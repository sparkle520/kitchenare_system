package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.Supplier;
import org.dromara.kitchenware.domain.bo.SupplierBo;
import org.dromara.kitchenware.domain.query.SupplierQuery;
import org.dromara.kitchenware.domain.vo.SupplierVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 供货供应商Service接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface ISupplierService extends IService<Supplier> {

    /**
     * 查询供货供应商
     *
     * @param id 主键
     * @return SupplierVo
     */
    SupplierVo queryById(Long id);

    /**
     * 分页查询供货供应商列表
     *
     * @param query 查询对象
     * @return 供货供应商分页列表
     */
    TableDataInfo<SupplierVo> queryPageList(SupplierQuery query);

    /**
     * 查询供货供应商列表
     *
     * @param query 查询对象
     * @return 供货供应商列表
     */
    List<SupplierVo> queryList(SupplierQuery query);

    /**
     * 新增供货供应商
     *
     * @param bo 供货供应商新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(SupplierBo bo);

    /**
     * 修改供货供应商
     *
     * @param bo 供货供应商编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(SupplierBo bo);

    /**
     * 批量删除供货供应商信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
