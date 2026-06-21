package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.SaleOrderItem;
import org.dromara.kitchenware.domain.bo.SaleOrderItemBo;
import org.dromara.kitchenware.domain.query.SaleOrderItemQuery;
import org.dromara.kitchenware.domain.vo.SaleOrderItemVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 订单商品明细Service接口
 *
 * @author sparkle520
 * @date 2026-06-19
 */
public interface ISaleOrderItemService extends IService<SaleOrderItem> {

    /**
     * 查询订单商品明细
     *
     * @param id 主键
     * @return SaleOrderItemVo
     */
    SaleOrderItemVo queryById(Long id);

    /**
     * 分页查询订单商品明细列表
     *
     * @param query 查询对象
     * @return 订单商品明细分页列表
     */
    TableDataInfo<SaleOrderItemVo> queryPageList(SaleOrderItemQuery query);

    /**
     * 查询订单商品明细列表
     *
     * @param query 查询对象
     * @return 订单商品明细列表
     */
    List<SaleOrderItemVo> queryList(SaleOrderItemQuery query);

    /**
     * 新增订单商品明细
     *
     * @param bo 订单商品明细新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(SaleOrderItemBo bo);

    /**
     * 修改订单商品明细
     *
     * @param bo 订单商品明细编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(SaleOrderItemBo bo);

    /**
     * 批量删除订单商品明细信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);

    /**
     * 插入订单商品
     *
     * @param orderItem 订单商品
     * @return 是否插入成功
     */
    Boolean insertOrderItem(SaleOrderItem orderItem);

    /**
     * 根据订单ID查询订单商品列表
     *
     * @param orderId 订单ID
     * @return 订单商品列表
     */
    List<SaleOrderItemVo> queryListByOrderId(Long orderId);
}
