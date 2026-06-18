package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.MemberAddress;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

import java.io.Serial;
import java.io.Serializable;

/**
 * 会员收货地址业务对象 member_address
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@AutoMapper(target = MemberAddress.class, reverseConvertGenerate = false)
public class MemberAddressBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 地址主键ID
     */
    @NotNull(message = "地址主键ID不能为空", groups = {EditGroup.class})
    private Long addressId;
    /**
     * 会员ID，关联member表
     */
    @NotNull(message = "会员ID，关联member表不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long memberId;
    /**
     * 收货人姓名
     */
    @NotBlank(message = "收货人姓名不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 50, message = "收货人姓名不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String receiverName;
    /**
     * 收货人手机号
     */
    @NotBlank(message = "收货人手机号不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 11, message = "收货人手机号不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String receiverMobile;
    /**
     * 省份
     */
    @NotBlank(message = "省份不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 20, message = "省份不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String province;
    /**
     * 城市
     */
    @NotBlank(message = "城市不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 20, message = "城市不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String city;
    /**
     * 区县
     */
    @NotBlank(message = "区县不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 20, message = "区县不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String district;
    /**
     * 详细地址
     */
    @NotBlank(message = "详细地址不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 255, message = "详细地址不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String detailAddress;
    /**
     * 是否默认地址 0否 1是
     */
    @NotBlank(message = "是否默认地址 0否 1是不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 1, message = "是否默认地址 0否 1是不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String isDefault;
}
