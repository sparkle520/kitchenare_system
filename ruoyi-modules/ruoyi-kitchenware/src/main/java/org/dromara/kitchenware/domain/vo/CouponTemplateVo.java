package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.CouponTemplate;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 优惠券模板视图对象 coupon_template
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = CouponTemplate.class)
public class CouponTemplateVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 券模板ID
     */
    @ExcelProperty(value = "券模板ID")
    private Long id;

    /**
     * 1无门槛 2满减券
     */
    @ExcelProperty(value = "1无门槛 2满减券")
    private Integer couponType;

    /**
     * 抵扣金额
     */
    @ExcelProperty(value = "抵扣金额")
    private BigDecimal denomination;

    /**
     * 满减门槛 0=无门槛
     */
    @ExcelProperty(value = "满减门槛 0=无门槛")
    private BigDecimal fullMoney;

    /**
     * 总发放数量
     */
    @ExcelProperty(value = "总发放数量")
    private Integer totalCount;

    /**
     * 已领取数量
     */
    @ExcelProperty(value = "已领取数量")
    private Integer receiveCount;

    /**
     * 领取后有效天数
     */
    @ExcelProperty(value = "领取后有效天数")
    private Integer validDays;

    /**
     * 发放开始时间
     */
    @ExcelProperty(value = "发放开始时间")
    private Date startTime;

    /**
     * 发放结束时间
     */
    @ExcelProperty(value = "发放结束时间")
    private Date endTime;

    /**
     * 1全品类 2指定分类 3指定商品
     */
    @ExcelProperty(value = "1全品类 2指定分类 3指定商品")
    private Integer scopeType;

    /**
     * 1启用 0关闭
     */
    @ExcelProperty(value = "1启用 0关闭")
    private Integer status;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date createTime;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date updateTime;

}
