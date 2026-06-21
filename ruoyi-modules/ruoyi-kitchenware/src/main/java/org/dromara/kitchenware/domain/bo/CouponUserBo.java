package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.CouponUser;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;

import java.io.Serial;
import java.io.Serializable;

/**
 * 个人优惠券业务对象 coupon_user
 *
 * @author sparkle520
 * @date 2026-06-18
 */
@Data
@AutoMapper(target = CouponUser.class, reverseConvertGenerate = false)
public class CouponUserBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户券主键
     */
    @NotNull(message = "用户券主键不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 所属模板
     */
    @NotNull(message = "所属模板不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long templateId;
    /**
     * 持有买家
     */
    @NotNull(message = "持有买家不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long memberId;
    /**
     * 领取时间
     */
    @NotNull(message = "领取时间不能为空", groups = {AddGroup.class, EditGroup.class})
    private Date receiveTime;
    /**
     * 过期时间
     */
    @NotNull(message = "过期时间不能为空", groups = {AddGroup.class, EditGroup.class})
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
    @NotNull(message = "1未使用 2已使用 3已过期不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer couponStatus;
}
