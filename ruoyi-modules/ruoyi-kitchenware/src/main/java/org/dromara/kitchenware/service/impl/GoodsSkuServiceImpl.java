package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.GoodsSku;
import org.dromara.kitchenware.domain.bo.GoodsSkuBo;
import org.dromara.kitchenware.domain.query.GoodsSkuQuery;
import org.dromara.kitchenware.domain.vo.GoodsSkuVo;
import org.dromara.kitchenware.mapper.GoodsSkuMapper;
import org.dromara.kitchenware.service.IGoodsSkuService;

import java.util.Collection;
import java.util.List;

/**
 * 商品规格SKUService业务层处理
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Service
public class GoodsSkuServiceImpl extends ServiceImpl<GoodsSkuMapper, GoodsSku> implements IGoodsSkuService {

    /**
     * 查询商品规格SKU
     *
     * @param id 主键
     * @return GoodsSkuVo
     */
    @Override
    public GoodsSkuVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询商品规格SKU列表
     *
     * @param query 查询对象
     * @return 商品规格SKU分页列表
     */
    @Override
    public TableDataInfo<GoodsSkuVo> queryPageList(GoodsSkuQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询商品规格SKU列表
     *
     * @param query 查询对象
     * @return 商品规格SKU列表
     */
    @Override
    public List<GoodsSkuVo> queryList(GoodsSkuQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增商品规格SKU
     *
     * @param bo 商品规格SKU新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(GoodsSkuBo bo) {
        GoodsSku add = MapstructUtils.convert(bo, GoodsSku.class);
        return save(add);
    }

    /**
     * 修改商品规格SKU
     *
     * @param bo 商品规格SKU编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(GoodsSkuBo bo) {
        GoodsSku update = MapstructUtils.convert(bo, GoodsSku.class);
        return updateById(update);
    }

    /**
     * 批量删除商品规格SKU信息
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
