package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 库存变更流水对象 stock_record
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@TableName("stock_record")
public class StockRecord implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 流水ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 操作SKU
     */
    private Long skuId;

    /**
     * 1采购入库 2销售出库 3退货入库 4损耗扣库
     */
    private Integer changeType;

    /**
     * 变动数量(出库负数)
     */
    private Integer changeNum;

    /**
     * 变动后剩余库存
     */
    private Integer stockAfter;

    /**
     * 关联单据ID(采购/订单/售后)
     */
    private Long relationId;

    /**
     * 
     */
    private Date operateTime;

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
