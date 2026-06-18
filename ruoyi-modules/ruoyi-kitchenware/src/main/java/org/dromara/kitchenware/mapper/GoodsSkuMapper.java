package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.GoodsSku;
import org.dromara.kitchenware.domain.bo.GoodsSkuBo;
import org.dromara.kitchenware.domain.query.GoodsSkuQuery;
import org.dromara.kitchenware.domain.vo.GoodsSkuVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 商品规格SKUMapper接口
 *
 * @author sparkle520
 * @date 2026-06-15
 */
public interface GoodsSkuMapper extends BaseMapperPlus<GoodsSku, GoodsSkuVo> {

    /**
     * 查询商品规格SKU列表
     *
     * @param query 查询对象
     * @return {@link GoodsSkuVo}
     */
    List<GoodsSkuVo> queryList(GoodsSkuQuery query);
}
