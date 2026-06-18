package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 优惠券模板对象 coupon_template
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@TableName("coupon_template")
public class CouponTemplate implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 券模板ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

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
