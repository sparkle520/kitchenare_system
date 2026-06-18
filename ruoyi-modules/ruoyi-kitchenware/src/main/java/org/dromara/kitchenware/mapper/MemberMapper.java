package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.Member;
import org.dromara.kitchenware.domain.bo.MemberBo;
import org.dromara.kitchenware.domain.query.MemberQuery;
import org.dromara.kitchenware.domain.vo.MemberVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 商城会员Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-17
 */
public interface MemberMapper extends BaseMapperPlus<Member, MemberVo> {

    /**
     * 查询商城会员列表
     *
     * @param query 查询对象
     * @return {@link MemberVo}
     */
    List<MemberVo> queryList(MemberQuery query);

    /**
     * 根据手机号查询会员
     *
     * @param mobile 手机号
     * @return {@link MemberVo}
     */
    MemberVo selectByMobile(String mobile);
}
