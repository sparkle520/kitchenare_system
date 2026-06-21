package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 个人优惠券对象 coupon_user
 *
 * @author sparkle520
 * @date 2026-06-18
 */
@Data
@TableName("coupon_user")
public class CouponUser implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户券主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 所属模板
     */
    private Long templateId;

    /**
     * 持有买家
     */
    private Long memberId;

    /**
     * 领取时间
     */
    private Date receiveTime;

    /**
     * 过期时间
     */
    private Date validEnd;

    /**
     * 核销订单ID
     */
    private Long useOrderId;

    /**
     * 使用时间
     */
    private Date useTime;

    /**
     * 1未使用 2已使用 3已过期
     */
    private Integer couponStatus;

    /**
     *
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private String delFlag;

}
