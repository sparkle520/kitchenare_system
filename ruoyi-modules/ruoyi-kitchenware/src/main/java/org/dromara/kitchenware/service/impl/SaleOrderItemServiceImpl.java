package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.SaleOrderItem;
import org.dromara.kitchenware.domain.bo.SaleOrderItemBo;
import org.dromara.kitchenware.domain.query.SaleOrderItemQuery;
import org.dromara.kitchenware.domain.vo.SaleOrderItemVo;
import org.dromara.kitchenware.mapper.SaleOrderItemMapper;
import org.dromara.kitchenware.service.ISaleOrderItemService;

import java.util.Collection;
import java.util.List;

/**
 * 订单商品明细Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-19
 */
@Service
public class SaleOrderItemServiceImpl extends ServiceImpl<SaleOrderItemMapper, SaleOrderItem> implements ISaleOrderItemService {

    /**
     * 查询订单商品明细
     *
     * @param id 主键
     * @return SaleOrderItemVo
     */
    @Override
    public SaleOrderItemVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询订单商品明细列表
     *
     * @param query 查询对象
     * @return 订单商品明细分页列表
     */
    @Override
    public TableDataInfo<SaleOrderItemVo> queryPageList(SaleOrderItemQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询订单商品明细列表
     *
     * @param query 查询对象
     * @return 订单商品明细列表
     */
    @Override
    public List<SaleOrderItemVo> queryList(SaleOrderItemQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增订单商品明细
     *
     * @param bo 订单商品明细新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(SaleOrderItemBo bo) {
        SaleOrderItem add = MapstructUtils.convert(bo, SaleOrderItem.class);
        return save(add);
    }

    /**
     * 修改订单商品明细
     *
     * @param bo 订单商品明细编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(SaleOrderItemBo bo) {
        SaleOrderItem update = MapstructUtils.convert(bo, SaleOrderItem.class);
        return updateById(update);
    }

    /**
     * 批量删除订单商品明细信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        return removeByIds(ids);
    }

    /**
     * 插入订单商品
     *
     * @param orderItem 订单商品
     * @return 是否插入成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertOrderItem(SaleOrderItem orderItem) {
        return save(orderItem);
    }

    /**
     * 根据订单ID查询订单商品列表
     *
     * @param orderId 订单ID
     * @return 订单商品列表
     */
    @Override
    public List<SaleOrderItemVo> queryListByOrderId(Long orderId) {
        return baseMapper.selectListByOrderId(orderId);
    }
}
