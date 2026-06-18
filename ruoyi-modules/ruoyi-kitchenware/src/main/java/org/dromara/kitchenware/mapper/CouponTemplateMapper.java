package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.CouponTemplate;
import org.dromara.kitchenware.domain.bo.CouponTemplateBo;
import org.dromara.kitchenware.domain.query.CouponTemplateQuery;
import org.dromara.kitchenware.domain.vo.CouponTemplateVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 优惠券模板Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-17
 */
public interface CouponTemplateMapper extends BaseMapperPlus<CouponTemplate, CouponTemplateVo> {

    /**
     * 查询优惠券模板列表
     *
     * @param query 查询对象
     * @return {@link CouponTemplateVo}
     */
    List<CouponTemplateVo> queryList(CouponTemplateQuery query);
}
