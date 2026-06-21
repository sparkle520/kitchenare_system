package org.dromara.kitchenware.domain.vo;

import java.util.Date;
import org.dromara.kitchenware.domain.CouponUser;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 个人优惠券视图对象 coupon_user
 *
 * @author sparkle520
 * @date 2026-06-18
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = CouponUser.class)
public class CouponUserVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户券主键
     */
    @ExcelProperty(value = "用户券主键")
    private Long id;

    /**
     * 所属模板
     */
    @ExcelProperty(value = "所属模板")
    private Long templateId;

    /**
     * 持有买家
     */
    @ExcelProperty(value = "持有买家")
    private Long memberId;

    /**
     * 领取时间
     */
    @ExcelProperty(value = "领取时间")
    private Date receiveTime;

    /**
     * 过期时间
     */
    @ExcelProperty(value = "过期时间")
    private Date validEnd;

    /**
     * 核销订单ID
     */
    @ExcelProperty(value = "核销订单ID")
    private Long useOrderId;

    /**
     * 使用时间
     */
    @ExcelProperty(value = "使用时间")
    private Date useTime;

    /**
     * 1未使用 2已使用 3已过期
     */
    @ExcelProperty(value = "1未使用 2已使用 3已过期", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "coupon_status")
    private Integer couponStatus;

}
