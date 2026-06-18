package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 入库商品明细对象 purchase_item
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@TableName("purchase_item")
public class PurchaseItem implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 明细主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

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
