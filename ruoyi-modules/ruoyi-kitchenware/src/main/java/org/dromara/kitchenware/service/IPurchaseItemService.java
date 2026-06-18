package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.PurchaseItem;
import org.dromara.kitchenware.domain.bo.PurchaseItemBo;
import org.dromara.kitchenware.domain.query.PurchaseItemQuery;
import org.dromara.kitchenware.domain.vo.PurchaseItemVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 入库商品明细Service接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface IPurchaseItemService extends IService<PurchaseItem> {

    /**
     * 查询入库商品明细
     *
     * @param id 主键
     * @return PurchaseItemVo
     */
    PurchaseItemVo queryById(Long id);

    /**
     * 分页查询入库商品明细列表
     *
     * @param query 查询对象
     * @return 入库商品明细分页列表
     */
    TableDataInfo<PurchaseItemVo> queryPageList(PurchaseItemQuery query);

    /**
     * 查询入库商品明细列表
     *
     * @param query 查询对象
     * @return 入库商品明细列表
     */
    List<PurchaseItemVo> queryList(PurchaseItemQuery query);

    /**
     * 新增入库商品明细
     *
     * @param bo 入库商品明细新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(PurchaseItemBo bo);

    /**
     * 修改入库商品明细
     *
     * @param bo 入库商品明细编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(PurchaseItemBo bo);

    /**
     * 批量删除入库商品明细信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
