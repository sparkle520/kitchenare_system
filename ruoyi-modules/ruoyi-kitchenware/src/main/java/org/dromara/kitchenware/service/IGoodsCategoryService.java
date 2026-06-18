package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.GoodsCategory;
import org.dromara.kitchenware.domain.bo.GoodsCategoryBo;
import org.dromara.kitchenware.domain.query.GoodsCategoryQuery;
import org.dromara.kitchenware.domain.vo.GoodsCategoryVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 厨具商品分类Service接口
 *
 * @author sparkle520
 * @date 2026-06-15
 */
public interface IGoodsCategoryService extends IService<GoodsCategory> {

    /**
     * 查询厨具商品分类
     *
     * @param id 主键
     * @return GoodsCategoryVo
     */
    GoodsCategoryVo queryById(Long id);

    /**
     * 分页查询厨具商品分类列表
     *
     * @param query 查询对象
     * @return 厨具商品分类分页列表
     */
    TableDataInfo<GoodsCategoryVo> queryPageList(GoodsCategoryQuery query);

    /**
     * 查询厨具商品分类列表
     *
     * @param query 查询对象
     * @return 厨具商品分类列表
     */
    List<GoodsCategoryVo> queryList(GoodsCategoryQuery query);

    /**
     * 新增厨具商品分类
     *
     * @param bo 厨具商品分类新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(GoodsCategoryBo bo);

    /**
     * 修改厨具商品分类
     *
     * @param bo 厨具商品分类编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(GoodsCategoryBo bo);

    /**
     * 批量删除厨具商品分类信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
