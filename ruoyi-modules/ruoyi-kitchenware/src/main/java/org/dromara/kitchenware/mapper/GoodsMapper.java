package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.Goods;
import org.dromara.kitchenware.domain.bo.GoodsBo;
import org.dromara.kitchenware.domain.query.GoodsQuery;
import org.dromara.kitchenware.domain.vo.GoodsVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 商品Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-15
 */
public interface GoodsMapper extends BaseMapperPlus<Goods, GoodsVo> {

    /**
     * 查询商品列表
     *
     * @param query 查询对象
     * @return {@link GoodsVo}
     */
    List<GoodsVo> queryList(GoodsQuery query);
}
