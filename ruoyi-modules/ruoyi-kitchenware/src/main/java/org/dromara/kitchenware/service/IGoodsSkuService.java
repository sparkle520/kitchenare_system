package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.GoodsSku;
import org.dromara.kitchenware.domain.bo.GoodsSkuBo;
import org.dromara.kitchenware.domain.query.GoodsSkuQuery;
import org.dromara.kitchenware.domain.vo.GoodsSkuVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 商品规格SKUService接口
 *
 * @author sparkle520
 * @date 2026-06-15
 */
public interface IGoodsSkuService extends IService<GoodsSku> {

    /**
     * 查询商品规格SKU
     *
     * @param id 主键
     * @return GoodsSkuVo
     */
    GoodsSkuVo queryById(Long id);

    /**
     * 分页查询商品规格SKU列表
     *
     * @param query 查询对象
     * @return 商品规格SKU分页列表
     */
    TableDataInfo<GoodsSkuVo> queryPageList(GoodsSkuQuery query);

    /**
     * 查询商品规格SKU列表
     *
     * @param query 查询对象
     * @return 商品规格SKU列表
     */
    List<GoodsSkuVo> queryList(GoodsSkuQuery query);

    /**
     * 新增商品规格SKU
     *
     * @param bo 商品规格SKU新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(GoodsSkuBo bo);

    /**
     * 修改商品规格SKU
     *
     * @param bo 商品规格SKU编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(GoodsSkuBo bo);

    /**
     * 批量删除商品规格SKU信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
