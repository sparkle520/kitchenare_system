package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.dromara.kitchenware.domain.Purchase;
import org.dromara.kitchenware.domain.PurchaseItem;
import org.dromara.kitchenware.domain.GoodsSku;
import org.dromara.kitchenware.domain.StockRecord;
import org.dromara.kitchenware.domain.bo.PurchaseBo;
import org.dromara.kitchenware.domain.query.PurchaseQuery;
import org.dromara.kitchenware.domain.vo.PurchaseVo;
import org.dromara.kitchenware.mapper.PurchaseItemMapper;
import org.dromara.kitchenware.mapper.PurchaseMapper;
import org.dromara.kitchenware.mapper.GoodsSkuMapper;
import org.dromara.kitchenware.mapper.StockRecordMapper;
import org.dromara.kitchenware.service.IPurchaseService;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * 进货入库单Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Service
public class PurchaseServiceImpl extends ServiceImpl<PurchaseMapper, Purchase> implements IPurchaseService {

    @Autowired
    private PurchaseItemMapper purchaseItemMapper;
    
    @Autowired
    private GoodsSkuMapper goodsSkuMapper;
    
    @Autowired
    private StockRecordMapper stockRecordMapper;

    /**
     * 查询进货入库单（包含明细）
     *
     * @param id 主键
     * @return PurchaseVo
     */
    @Override
    public PurchaseVo queryById(Long id) {
        PurchaseVo vo = baseMapper.selectVoById(id);
        if (vo != null) {
            // 查询关联的明细
            List<PurchaseItem> items = purchaseItemMapper.selectList(new LambdaQueryWrapper<PurchaseItem>()
                    .eq(PurchaseItem::getPurchaseId, id));
            vo.setPurchaseItems(items);
        }
        return vo;
    }

    /**
     * 分页查询进货入库单列表
     *
     * @param query 查询对象
     * @return 进货入库单分页列表
     */
    @Override
    public TableDataInfo<PurchaseVo> queryPageList(PurchaseQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询进货入库单列表
     *
     * @param query 查询对象
     * @return 进货入库单列表
     */
    @Override
    public List<PurchaseVo> queryList(PurchaseQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增进货入库单（包含明细），保存后直接生效入库
     * 
     * 同步更新：
     * 1. SKU库存数量（叠加）
     * 2. SKU加权成本价
     * 3. 库存变更流水记录
     *
     * @param bo 进货入库单新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(PurchaseBo bo) {
        Purchase add = MapstructUtils.convert(bo, Purchase.class);
        boolean result = save(add);
        
        // 如果有明细，保存明细并关联入库单ID，同时更新库存
        if (result && !CollectionUtils.isEmpty(bo.getPurchaseItems())) {
            for (PurchaseItem item : bo.getPurchaseItems()) {
                item.setPurchaseId(add.getId());
                purchaseItemMapper.insert(item);
                
                // 更新SKU库存和加权成本
                updateSkuStockAndCost(item.getSkuId(), item.getBuyNum(), item.getBuyPrice());
                
                // 记录库存流水
                recordStockChange(item.getSkuId(), 1, item.getBuyNum(), add.getId());
            }
        }
        return result;
    }
    
    /**
     * 更新SKU库存和加权成本
     * 
     * 加权成本计算公式：
     * 新成本 = (原库存 * 原成本 + 本次采购数量 * 本次采购单价) / (原库存 + 本次采购数量)
     * 
     * @param skuId SKUID
     * @param buyNum 采购数量（正数入库，负数退货）
     * @param buyPrice 采购单价
     */
    private void updateSkuStockAndCost(Long skuId, Integer buyNum, BigDecimal buyPrice) {
        // 查询当前SKU信息
        GoodsSku sku = goodsSkuMapper.selectById(skuId);
        if (sku == null) {
            return;
        }
        
        int currentStock = sku.getStockNum() != null ? sku.getStockNum() : 0;
        BigDecimal currentCost = sku.getPurchasePrice() != null ? sku.getPurchasePrice() : BigDecimal.ZERO;
        
        // 计算新库存
        int newStock = currentStock + buyNum;
        
        // 计算加权成本
        BigDecimal newCost;
        if (newStock <= 0) {
            // 库存为0或负数，成本重置为0
            newCost = BigDecimal.ZERO;
        } else if (currentStock <= 0) {
            // 原库存为0，直接使用本次采购单价
            newCost = buyPrice;
        } else {
            // 加权平均计算
            BigDecimal totalCost = currentCost.multiply(BigDecimal.valueOf(currentStock))
                    .add(buyPrice.multiply(BigDecimal.valueOf(buyNum)));
            newCost = totalCost.divide(BigDecimal.valueOf(newStock), 4, BigDecimal.ROUND_HALF_UP);
        }
        
        // 更新SKU
        goodsSkuMapper.update(new LambdaUpdateWrapper<GoodsSku>()
                .eq(GoodsSku::getId, skuId)
                .set(GoodsSku::getStockNum, newStock)
                .set(GoodsSku::getPurchasePrice, newCost));
    }
    
    /**
     * 记录库存变更流水
     * 
     * @param skuId SKUID
     * @param changeType 变更类型：1采购入库 2销售出库 3退货入库 4损耗扣库
     * @param changeNum 变更数量
     * @param relationId 关联单据ID
     */
    private void recordStockChange(Long skuId, Integer changeType, Integer changeNum, Long relationId) {
        // 查询更新后的库存
        GoodsSku sku = goodsSkuMapper.selectById(skuId);
        int stockAfter = sku != null && sku.getStockNum() != null ? sku.getStockNum() : 0;
        
        StockRecord record = new StockRecord();
        record.setSkuId(skuId);
        record.setChangeType(changeType);
        record.setChangeNum(changeNum);
        record.setStockAfter(stockAfter);
        record.setRelationId(relationId);
        record.setOperateTime(new Date());
        
        stockRecordMapper.insert(record);
    }

    /**
     * 修改进货入库单（包含明细）
     * 
     * 注意：已入库单据禁止编辑，录错需新增负数采购退货单冲抵库存，或通过盘点单修正
     *
     * @param bo 进货入库单编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(PurchaseBo bo) {
        // 已入库单据禁止修改
        throw new UnsupportedOperationException("已入库单据禁止编辑，录错请新增负数采购退货单冲抵库存，或通过盘点单修正");
    }

    /**
     * 批量删除进货入库单信息（包含关联明细），同时回滚库存
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        // 查询要删除的入库单明细
        List<PurchaseItem> items = purchaseItemMapper.selectList(new LambdaQueryWrapper<PurchaseItem>()
                .in(PurchaseItem::getPurchaseId, ids));
        
        // 回滚库存（负数出库）
        for (PurchaseItem item : items) {
            // 负数表示出库回滚
            updateSkuStockAndCost(item.getSkuId(), -item.getBuyNum(), BigDecimal.ZERO);
            
            // 删除关联的库存流水记录
            stockRecordMapper.delete(new LambdaQueryWrapper<StockRecord>()
                    .eq(StockRecord::getRelationId, item.getPurchaseId())
                    .eq(StockRecord::getSkuId, item.getSkuId()));
        }
        
        // 先删除关联的明细
        purchaseItemMapper.delete(new LambdaQueryWrapper<PurchaseItem>()
                .in(PurchaseItem::getPurchaseId, ids));
        // 再删除入库单
        return removeByIds(ids);
    }
}
