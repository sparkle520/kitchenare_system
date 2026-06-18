package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.CouponTemplate;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;

import java.io.Serial;
import java.io.Serializable;

/**
 * 优惠券模板业务对象 coupon_template
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@AutoMapper(target = CouponTemplate.class, reverseConvertGenerate = false)
public class CouponTemplateBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 券模板ID
     */
    @NotNull(message = "券模板ID不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 1无门槛 2满减券
     */
    @NotNull(message = "1无门槛 2满减券不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer couponType;
    /**
     * 抵扣金额
     */
    @NotNull(message = "抵扣金额不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal denomination;
    /**
     * 满减门槛 0=无门槛
     */
    @NotNull(message = "满减门槛 0=无门槛不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal fullMoney;
    /**
     * 总发放数量
     */
    @NotNull(message = "总发放数量不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer totalCount;
    /**
     * 已领取数量
     */
    @NotNull(message = "已领取数量不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer receiveCount;
    /**
     * 领取后有效天数
     */
    @NotNull(message = "领取后有效天数不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer validDays;
    /**
     * 发放开始时间
     */
    @NotNull(message = "发放开始时间不能为空", groups = {AddGroup.class, EditGroup.class})
    private Date startTime;
    /**
     * 发放结束时间
     */
    @NotNull(message = "发放结束时间不能为空", groups = {AddGroup.class, EditGroup.class})
    private Date endTime;
    /**
     * 1全品类 2指定分类 3指定商品
     */
    @NotNull(message = "1全品类 2指定分类 3指定商品不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer scopeType;
    /**
     * 1启用 0关闭
     */
    @NotNull(message = "1启用 0关闭不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer status;
}
