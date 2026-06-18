package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.Purchase;
import org.dromara.kitchenware.domain.bo.PurchaseBo;
import org.dromara.kitchenware.domain.query.PurchaseQuery;
import org.dromara.kitchenware.domain.vo.PurchaseVo;
import org.dromara.kitchenware.mapper.PurchaseMapper;
import org.dromara.kitchenware.service.IPurchaseService;

import java.util.Collection;
import java.util.List;

/**
 * 进货入库单Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Service
public class PurchaseServiceImpl extends ServiceImpl<PurchaseMapper, Purchase> implements IPurchaseService {

    /**
     * 查询进货入库单
     *
     * @param id 主键
     * @return PurchaseVo
     */
    @Override
    public PurchaseVo queryById(Long id) {
        return baseMapper.selectVoById(id);
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
     * 新增进货入库单
     *
     * @param bo 进货入库单新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(PurchaseBo bo) {
        Purchase add = MapstructUtils.convert(bo, Purchase.class);
        return save(add);
    }

    /**
     * 修改进货入库单
     *
     * @param bo 进货入库单编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(PurchaseBo bo) {
        Purchase update = MapstructUtils.convert(bo, Purchase.class);
        return updateById(update);
    }

    /**
     * 批量删除进货入库单信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        return removeByIds(ids);
    }
}
