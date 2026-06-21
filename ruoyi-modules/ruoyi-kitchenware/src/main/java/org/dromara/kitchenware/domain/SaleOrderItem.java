package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 订单商品明细对象 sale_order_item
 *
 * @author sparkle520
 * @date 2026-06-19
 */
@Data
@TableName("sale_order_item")
public class SaleOrderItem implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 明细主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

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

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createBy;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateBy;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private String delFlag;

}
