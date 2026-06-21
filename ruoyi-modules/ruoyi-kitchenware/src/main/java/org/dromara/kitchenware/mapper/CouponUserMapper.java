package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.CouponUser;
import org.dromara.kitchenware.domain.bo.CouponUserBo;
import org.dromara.kitchenware.domain.query.CouponUserQuery;
import org.dromara.kitchenware.domain.vo.CouponUserVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 个人优惠券Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-18
 */
public interface CouponUserMapper extends BaseMapperPlus<CouponUser, CouponUserVo> {

    /**
     * 查询个人优惠券列表
     *
     * @param query 查询对象
     * @return {@link CouponUserVo}
     */
    List<CouponUserVo> queryList(CouponUserQuery query);
}
