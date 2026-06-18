package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.Goods;
import org.dromara.kitchenware.domain.bo.GoodsBo;
import org.dromara.kitchenware.domain.query.GoodsQuery;
import org.dromara.kitchenware.domain.vo.GoodsVo;
import org.dromara.kitchenware.mapper.GoodsMapper;
import org.dromara.kitchenware.service.IGoodsService;

import java.util.Collection;
import java.util.List;

/**
 * 商品Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Service
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements IGoodsService {

    /**
     * 查询商品
     *
     * @param id 主键
     * @return GoodsVo
     */
    @Override
    public GoodsVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询商品列表
     *
     * @param query 查询对象
     * @return 商品分页列表
     */
    @Override
    public TableDataInfo<GoodsVo> queryPageList(GoodsQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询商品列表
     *
     * @param query 查询对象
     * @return 商品列表
     */
    @Override
    public List<GoodsVo> queryList(GoodsQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增商品
     *
     * @param bo 商品新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(GoodsBo bo) {
        Goods add = MapstructUtils.convert(bo, Goods.class);
        return save(add);
    }

    /**
     * 修改商品
     *
     * @param bo 商品编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(GoodsBo bo) {
        Goods update = MapstructUtils.convert(bo, Goods.class);
        return updateById(update);
    }

    /**
     * 批量删除商品信息
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
