package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 入库商品明细查询对象 purchase_item
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class PurchaseItemQuery extends BasePageQuery {

    /**
     * 入库单ID
     */
    private Long purchaseId;

    /**
     * 商品SKU
     */
    private Long skuId;

    /**
     * 采购数量
     */
    private Integer buyNum;

    /**
     * 单件进价
     */
    private BigDecimal buyPrice;

    /**
     * 本行小计金额
     */
    private BigDecimal subtotal;

}
