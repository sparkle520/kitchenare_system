package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 优惠券模板查询对象 coupon_template
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CouponTemplateQuery extends BasePageQuery {

    /**
     * 1无门槛 2满减券
     */
    private Integer couponType;

    /**
     * 抵扣金额
     */
    private BigDecimal denomination;

    /**
     * 满减门槛 0=无门槛
     */
    private BigDecimal fullMoney;

    /**
     * 总发放数量
     */
    private Integer totalCount;

    /**
     * 已领取数量
     */
    private Integer receiveCount;

    /**
     * 领取后有效天数
     */
    private Integer validDays;

    /**
     * 发放开始时间
     */
    private Date startTime;

    /**
     * 发放结束时间
     */
    private Date endTime;

    /**
     * 1全品类 2指定分类 3指定商品
     */
    private Integer scopeType;

    /**
     * 1启用 0关闭
     */
    private Integer status;

}
