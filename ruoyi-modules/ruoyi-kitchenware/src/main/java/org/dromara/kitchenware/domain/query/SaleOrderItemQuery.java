package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 订单商品明细查询对象 sale_order_item
 *
 * @author sparkle520
 * @date 2026-06-19
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SaleOrderItemQuery extends BasePageQuery {

    /**
     * 归属订单ID
     */
    private Long orderId;

    /**
     * 商品SPU
     */
    private Long goodsId;

    /**
     * 规格SKU
     */
    private Long skuId;

    /**
     * 购买数量
     */
    private Integer buyNum;

    /**
     * 下单时原价快照
     */
    private BigDecimal originalPrice;

    /**
     * 实际成交单价
     */
    private BigDecimal sellPrice;

    /**
     * 本行小计金额
     */
    private BigDecimal subtotal;

}
