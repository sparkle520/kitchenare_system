package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.PurchaseItem;
import org.dromara.kitchenware.domain.bo.PurchaseItemBo;
import org.dromara.kitchenware.domain.query.PurchaseItemQuery;
import org.dromara.kitchenware.domain.vo.PurchaseItemVo;
import org.dromara.kitchenware.mapper.PurchaseItemMapper;
import org.dromara.kitchenware.service.IPurchaseItemService;

import java.util.Collection;
import java.util.List;

/**
 * 入库商品明细Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Service
public class PurchaseItemServiceImpl extends ServiceImpl<PurchaseItemMapper, PurchaseItem> implements IPurchaseItemService {

    /**
     * 查询入库商品明细
     *
     * @param id 主键
     * @return PurchaseItemVo
     */
    @Override
    public PurchaseItemVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询入库商品明细列表
     *
     * @param query 查询对象
     * @return 入库商品明细分页列表
     */
    @Override
    public TableDataInfo<PurchaseItemVo> queryPageList(PurchaseItemQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询入库商品明细列表
     *
     * @param query 查询对象
     * @return 入库商品明细列表
     */
    @Override
    public List<PurchaseItemVo> queryList(PurchaseItemQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增入库商品明细
     *
     * @param bo 入库商品明细新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(PurchaseItemBo bo) {
        PurchaseItem add = MapstructUtils.convert(bo, PurchaseItem.class);
        return save(add);
    }

    /**
     * 修改入库商品明细
     *
     * @param bo 入库商品明细编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(PurchaseItemBo bo) {
        PurchaseItem update = MapstructUtils.convert(bo, PurchaseItem.class);
        return updateById(update);
    }

    /**
     * 批量删除入库商品明细信息
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
