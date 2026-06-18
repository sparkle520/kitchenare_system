package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 会员收货地址对象 member_address
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@TableName("member_address")
public class MemberAddress implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 地址主键ID
     */
    @TableId(value = "address_id", type = IdType.AUTO)
    private Long addressId;

    /**
     * 租户编号
     */
    private String tenantId;

    /**
     * 会员ID，关联member表
     */
    private Long memberId;

    /**
     * 收货人姓名
     */
    private String receiverName;

    /**
     * 收货人手机号
     */
    private String receiverMobile;

    /**
     * 省份
     */
    private String province;

    /**
     * 城市
     */
    private String city;

    /**
     * 区县
     */
    private String district;

    /**
     * 详细地址
     */
    private String detailAddress;

    /**
     * 是否默认地址 0否 1是
     */
    private String isDefault;

    /**
     * 创建人
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createBy;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新人
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateBy;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 逻辑删除 0未删 1已删
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private String delFlag;

}
