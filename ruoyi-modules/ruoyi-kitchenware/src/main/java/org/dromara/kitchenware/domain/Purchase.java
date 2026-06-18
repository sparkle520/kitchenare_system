package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 进货入库单对象 purchase
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@TableName("purchase")
public class Purchase implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 入库单主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

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
