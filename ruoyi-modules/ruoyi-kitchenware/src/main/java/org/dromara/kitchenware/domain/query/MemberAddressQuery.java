package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 会员收货地址查询对象 member_address
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MemberAddressQuery extends BasePageQuery {

    /**
     * 会员ID，关联member表
     */
    private Long memberId;

    /**
     * 收货人姓名
     */
    private String receiverName;

    /**
     * 收货人手机号
     */
    private String receiverMobile;

    /**
     * 省份
     */
    private String province;

    /**
     * 城市
     */
    private String city;

    /**
     * 区县
     */
    private String district;

    /**
     * 详细地址
     */
    private String detailAddress;

    /**
     * 是否默认地址 0否 1是
     */
    private String isDefault;

}
