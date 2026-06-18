package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.Member;
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
 * 商城会员业务对象 member
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@AutoMapper(target = Member.class, reverseConvertGenerate = false)
public class MemberBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 会员主键ID
     */
    @NotNull(message = "会员主键ID不能为空", groups = {EditGroup.class})
    private Long memberId;
    /**
     * 会员昵称
     */
    @NotBlank(message = "会员昵称不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 50, message = "会员昵称不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String nickname;
    /**
     * 手机号(唯一登录账号)
     */
    @NotBlank(message = "手机号不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 11, message = "手机号不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String mobile;
    /**
     * 头像地址
     */
    @Length(max = 255, message = "头像地址不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String avatar;
    /**
     * 登录加密密码
     */
    @Length(max = 100, message = "登录加密密码不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String password;
    /**
     * 账户余额
     */
    private BigDecimal balance;
    /**
     * 会员积分
     */
    private Integer point;
    /**
     * 最后登录时间
     */
    private Date lastLoginTime;
    /**
     * 账号状态：1正常 0禁用
     */
    @NotBlank(message = "账号状态：1正常 0禁用不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 1, message = "账号状态：1正常 0禁用不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String status;
}
