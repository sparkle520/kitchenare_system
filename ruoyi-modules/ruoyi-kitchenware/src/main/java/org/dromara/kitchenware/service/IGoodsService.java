package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.Goods;
import org.dromara.kitchenware.domain.bo.GoodsBo;
import org.dromara.kitchenware.domain.query.GoodsQuery;
import org.dromara.kitchenware.domain.vo.GoodsVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 商品Service接口
 *
 * @author sparkle520
 * @date 2026-06-15
 */
public interface IGoodsService extends IService<Goods> {

    /**
     * 查询商品
     *
     * @param id 主键
     * @return GoodsVo
     */
    GoodsVo queryById(Long id);

    /**
     * 分页查询商品列表
     *
     * @param query 查询对象
     * @return 商品分页列表
     */
    TableDataInfo<GoodsVo> queryPageList(GoodsQuery query);

    /**
     * 查询商品列表
     *
     * @param query 查询对象
     * @return 商品列表
     */
    List<GoodsVo> queryList(GoodsQuery query);

    /**
     * 新增商品
     *
     * @param bo 商品新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(GoodsBo bo);

    /**
     * 修改商品
     *
     * @param bo 商品编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(GoodsBo bo);

    /**
     * 批量删除商品信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
