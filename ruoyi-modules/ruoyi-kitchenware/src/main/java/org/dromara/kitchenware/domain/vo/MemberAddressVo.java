package org.dromara.kitchenware.domain.vo;

import java.util.Date;
import org.dromara.kitchenware.domain.MemberAddress;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 会员收货地址视图对象 member_address
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = MemberAddress.class)
public class MemberAddressVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 地址主键ID
     */
    @ExcelProperty(value = "地址主键ID")
    private Long addressId;

    /**
     * 会员ID，关联member表
     */
    @ExcelProperty(value = "会员ID，关联member表")
    private Long memberId;

    /**
     * 收货人姓名
     */
    @ExcelProperty(value = "收货人姓名")
    private String receiverName;

    /**
     * 收货人手机号
     */
    @ExcelProperty(value = "收货人手机号")
    private String receiverMobile;

    /**
     * 省份
     */
    @ExcelProperty(value = "省份")
    private String province;

    /**
     * 城市
     */
    @ExcelProperty(value = "城市")
    private String city;

    /**
     * 区县
     */
    @ExcelProperty(value = "区县")
    private String district;

    /**
     * 详细地址
     */
    @ExcelProperty(value = "详细地址")
    private String detailAddress;

    /**
     * 是否默认地址 0否 1是
     */
    @ExcelProperty(value = "是否默认地址 0否 1是")
    private String isDefault;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private Date updateTime;

}
