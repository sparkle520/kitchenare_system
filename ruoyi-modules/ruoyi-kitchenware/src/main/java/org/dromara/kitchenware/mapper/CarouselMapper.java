package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.Carousel;
import org.dromara.kitchenware.domain.bo.CarouselBo;
import org.dromara.kitchenware.domain.query.CarouselQuery;
import org.dromara.kitchenware.domain.vo.CarouselVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 轮播图Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-21
 */
public interface CarouselMapper extends BaseMapperPlus<Carousel, CarouselVo> {

    /**
     * 查询轮播图列表
     *
     * @param query 查询对象
     * @return {@link CarouselVo}
     */
    List<CarouselVo> queryList(CarouselQuery query);
}
