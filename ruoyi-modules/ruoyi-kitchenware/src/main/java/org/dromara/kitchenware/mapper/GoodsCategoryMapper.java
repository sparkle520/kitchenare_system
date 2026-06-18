package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.GoodsCategory;
import org.dromara.kitchenware.domain.bo.GoodsCategoryBo;
import org.dromara.kitchenware.domain.query.GoodsCategoryQuery;
import org.dromara.kitchenware.domain.vo.GoodsCategoryVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 厨具商品分类Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-15
 */
public interface GoodsCategoryMapper extends BaseMapperPlus<GoodsCategory, GoodsCategoryVo> {

    /**
     * 查询厨具商品分类列表
     *
     * @param query 查询对象
     * @return {@link GoodsCategoryVo}
     */
    List<GoodsCategoryVo> queryList(GoodsCategoryQuery query);
}
