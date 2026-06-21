package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.Carousel;
import org.dromara.kitchenware.domain.bo.CarouselBo;
import org.dromara.kitchenware.domain.query.CarouselQuery;
import org.dromara.kitchenware.domain.vo.CarouselVo;
import org.dromara.kitchenware.mapper.CarouselMapper;
import org.dromara.kitchenware.service.ICarouselService;

import java.util.Collection;
import java.util.List;

/**
 * 轮播图Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-21
 */
@Service
public class CarouselServiceImpl extends ServiceImpl<CarouselMapper, Carousel> implements ICarouselService {

    /**
     * 查询轮播图
     *
     * @param id 主键
     * @return CarouselVo
     */
    @Override
    public CarouselVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询轮播图列表
     *
     * @param query 查询对象
     * @return 轮播图分页列表
     */
    @Override
    public TableDataInfo<CarouselVo> queryPageList(CarouselQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询轮播图列表
     *
     * @param query 查询对象
     * @return 轮播图列表
     */
    @Override
    public List<CarouselVo> queryList(CarouselQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增轮播图
     *
     * @param bo 轮播图新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(CarouselBo bo) {
        Carousel add = MapstructUtils.convert(bo, Carousel.class);
        return save(add);
    }

    /**
     * 修改轮播图
     *
     * @param bo 轮播图编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(CarouselBo bo) {
        Carousel update = MapstructUtils.convert(bo, Carousel.class);
        return updateById(update);
    }

    /**
     * 批量删除轮播图信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        return removeByIds(ids);
    }
}
