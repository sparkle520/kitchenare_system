package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 供货供应商对象 supplier
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@TableName("supplier")
public class Supplier implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 供应商ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 厂商名称
     */
    private String supplierName;

    /**
     * 对接联系人
     */
    private String contact;

    /**
     * 联系电话
     */
    private String phone;

    /**
     * 厂商地址
     */
    private String address;

    /**
     * 备注
     */
    private String remark;

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
