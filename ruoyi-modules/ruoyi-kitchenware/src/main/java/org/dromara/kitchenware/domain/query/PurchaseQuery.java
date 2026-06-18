package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 进货入库单查询对象 purchase
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class PurchaseQuery extends BasePageQuery {

    /**
     * 供应商ID
     */
    private Long supplierId;

    /**
     * 操作员工sys_user.id
     */
    private Long operatorId;

    /**
     * 单据总金额
     */
    private BigDecimal totalAmount;

    /**
     * 0未付款 1已结清
     */
    private Integer payStatus;

    /**
     * 入库时间
     */
    private Date purchaseTime;

    /**
     * 单据备注
     */
    private String note;

}
