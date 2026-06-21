package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.SaleOrderItem;
import org.dromara.kitchenware.domain.bo.SaleOrderItemBo;
import org.dromara.kitchenware.domain.query.SaleOrderItemQuery;
import org.dromara.kitchenware.domain.vo.SaleOrderItemVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 订单商品明细Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-19
 */
public interface SaleOrderItemMapper extends BaseMapperPlus<SaleOrderItem, SaleOrderItemVo> {

    /**
     * 查询订单商品明细列表
     *
     * @param query 查询对象
     * @return {@link SaleOrderItemVo}
     */
    List<SaleOrderItemVo> queryList(SaleOrderItemQuery query);

    /**
     * 根据订单ID查询订单商品列表
     *
     * @param orderId 订单ID
     * @return 订单商品列表
     */
    List<SaleOrderItemVo> selectListByOrderId(Long orderId);
}
