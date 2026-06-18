package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 商城会员对象 member
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@TableName("member")
public class Member implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 会员主键ID
     */
    @TableId(value = "member_id", type = IdType.AUTO)
    private Long memberId;

    /**
     * 会员昵称
     */
    private String nickname;

    /**
     * 手机号(唯一登录账号)
     */
    private String mobile;

    /**
     * 头像地址
     */
    private String avatar;

    /**
     * 登录加密密码
     */
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
    private String status;

    /**
     * 逻辑删除：0正常 1删除
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private String delFlag;

    /**
     * 创建人
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createBy;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新人
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateBy;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

}
