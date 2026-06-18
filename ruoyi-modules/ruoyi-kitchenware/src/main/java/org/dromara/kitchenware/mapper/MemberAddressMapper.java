package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.MemberAddress;
import org.dromara.kitchenware.domain.bo.MemberAddressBo;
import org.dromara.kitchenware.domain.query.MemberAddressQuery;
import org.dromara.kitchenware.domain.vo.MemberAddressVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 会员收货地址Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-17
 */
public interface MemberAddressMapper extends BaseMapperPlus<MemberAddress, MemberAddressVo> {

    /**
     * 查询会员收货地址列表
     *
     * @param query 查询对象
     * @return {@link MemberAddressVo}
     */
    List<MemberAddressVo> queryList(MemberAddressQuery query);
}
