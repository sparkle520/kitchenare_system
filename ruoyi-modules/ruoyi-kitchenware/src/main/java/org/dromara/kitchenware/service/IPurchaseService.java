package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.Purchase;
import org.dromara.kitchenware.domain.bo.PurchaseBo;
import org.dromara.kitchenware.domain.query.PurchaseQuery;
import org.dromara.kitchenware.domain.vo.PurchaseVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 进货入库单Service接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface IPurchaseService extends IService<Purchase> {

    /**
     * 查询进货入库单
     *
     * @param id 主键
     * @return PurchaseVo
     */
    PurchaseVo queryById(Long id);

    /**
     * 分页查询进货入库单列表
     *
     * @param query 查询对象
     * @return 进货入库单分页列表
     */
    TableDataInfo<PurchaseVo> queryPageList(PurchaseQuery query);

    /**
     * 查询进货入库单列表
     *
     * @param query 查询对象
     * @return 进货入库单列表
     */
    List<PurchaseVo> queryList(PurchaseQuery query);

    /**
     * 新增进货入库单
     *
     * @param bo 进货入库单新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(PurchaseBo bo);

    /**
     * 修改进货入库单
     *
     * @param bo 进货入库单编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(PurchaseBo bo);

    /**
     * 批量删除进货入库单信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
