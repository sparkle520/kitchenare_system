package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.GoodsCategory;
import org.dromara.kitchenware.domain.bo.GoodsCategoryBo;
import org.dromara.kitchenware.domain.query.GoodsCategoryQuery;
import org.dromara.kitchenware.domain.vo.GoodsCategoryVo;
import org.dromara.kitchenware.mapper.GoodsCategoryMapper;
import org.dromara.kitchenware.service.IGoodsCategoryService;

import java.util.Collection;
import java.util.List;

/**
 * 厨具商品分类Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Service
public class GoodsCategoryServiceImpl extends ServiceImpl<GoodsCategoryMapper, GoodsCategory> implements IGoodsCategoryService {

    /**
     * 查询厨具商品分类
     *
     * @param id 主键
     * @return GoodsCategoryVo
     */
    @Override
    public GoodsCategoryVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询厨具商品分类列表
     *
     * @param query 查询对象
     * @return 厨具商品分类分页列表
     */
    @Override
    public TableDataInfo<GoodsCategoryVo> queryPageList(GoodsCategoryQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询厨具商品分类列表
     *
     * @param query 查询对象
     * @return 厨具商品分类列表
     */
    @Override
    public List<GoodsCategoryVo> queryList(GoodsCategoryQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增厨具商品分类
     *
     * @param bo 厨具商品分类新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(GoodsCategoryBo bo) {
        GoodsCategory add = MapstructUtils.convert(bo, GoodsCategory.class);
        return save(add);
    }

    /**
     * 修改厨具商品分类
     *
     * @param bo 厨具商品分类编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(GoodsCategoryBo bo) {
        GoodsCategory update = MapstructUtils.convert(bo, GoodsCategory.class);
        return updateById(update);
    }

    /**
     * 批量删除厨具商品分类信息
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
