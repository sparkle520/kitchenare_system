package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.Member;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 商城会员视图对象 member
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Member.class)
public class MemberVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 会员主键ID
     */
    @ExcelProperty(value = "会员主键ID")
    private Long memberId;

    /**
     * 会员昵称
     */
    @ExcelProperty(value = "会员昵称")
    private String nickname;

    /**
     * 手机号(唯一登录账号)
     */
    @ExcelProperty(value = "手机号")
    private String mobile;

    /**
     * 头像地址
     */
    @ExcelProperty(value = "头像地址")
    private String avatar;

    /**
     * 登录加密密码
     */
    @ExcelProperty(value = "登录加密密码")
    private String password;

    /**
     * 账户余额
     */
    @ExcelProperty(value = "账户余额")
    private BigDecimal balance;

    /**
     * 会员积分
     */
    @ExcelProperty(value = "会员积分")
    private Integer point;

    /**
     * 最后登录时间
     */
    @ExcelProperty(value = "最后登录时间")
    private Date lastLoginTime;

    /**
     * 账号状态：1正常 0禁用
     */
    @ExcelProperty(value = "账号状态：1正常 0禁用")
    private String status;

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
