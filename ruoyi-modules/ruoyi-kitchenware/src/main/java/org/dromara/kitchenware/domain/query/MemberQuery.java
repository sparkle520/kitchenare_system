package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 商城会员查询对象 member
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MemberQuery extends BasePageQuery {

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

}
