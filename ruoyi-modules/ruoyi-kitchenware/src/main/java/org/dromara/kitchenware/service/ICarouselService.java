package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.Carousel;
import org.dromara.kitchenware.domain.bo.CarouselBo;
import org.dromara.kitchenware.domain.query.CarouselQuery;
import org.dromara.kitchenware.domain.vo.CarouselVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 轮播图Service接口
 *
 * @author sparkle520
 * @date 2026-06-21
 */
public interface ICarouselService extends IService<Carousel> {

    /**
     * 查询轮播图
     *
     * @param id 主键
     * @return CarouselVo
     */
    CarouselVo queryById(Long id);

    /**
     * 分页查询轮播图列表
     *
     * @param query 查询对象
     * @return 轮播图分页列表
     */
    TableDataInfo<CarouselVo> queryPageList(CarouselQuery query);

    /**
     * 查询轮播图列表
     *
     * @param query 查询对象
     * @return 轮播图列表
     */
    List<CarouselVo> queryList(CarouselQuery query);

    /**
     * 新增轮播图
     *
     * @param bo 轮播图新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(CarouselBo bo);

    /**
     * 修改轮播图
     *
     * @param bo 轮播图编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(CarouselBo bo);

    /**
     * 批量删除轮播图信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
