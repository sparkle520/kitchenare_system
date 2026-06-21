package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 个人优惠券查询对象 coupon_user
 *
 * @author sparkle520
 * @date 2026-06-18
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CouponUserQuery extends BasePageQuery {

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

}
