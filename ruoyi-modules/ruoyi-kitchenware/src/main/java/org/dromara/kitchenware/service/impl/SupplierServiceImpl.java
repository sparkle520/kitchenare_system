package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.Supplier;
import org.dromara.kitchenware.domain.bo.SupplierBo;
import org.dromara.kitchenware.domain.query.SupplierQuery;
import org.dromara.kitchenware.domain.vo.SupplierVo;
import org.dromara.kitchenware.mapper.SupplierMapper;
import org.dromara.kitchenware.service.ISupplierService;

import java.util.Collection;
import java.util.List;

/**
 * 供货供应商Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Service
public class SupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier> implements ISupplierService {

    /**
     * 查询供货供应商
     *
     * @param id 主键
     * @return SupplierVo
     */
    @Override
    public SupplierVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询供货供应商列表
     *
     * @param query 查询对象
     * @return 供货供应商分页列表
     */
    @Override
    public TableDataInfo<SupplierVo> queryPageList(SupplierQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询供货供应商列表
     *
     * @param query 查询对象
     * @return 供货供应商列表
     */
    @Override
    public List<SupplierVo> queryList(SupplierQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增供货供应商
     *
     * @param bo 供货供应商新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(SupplierBo bo) {
        Supplier add = MapstructUtils.convert(bo, Supplier.class);
        return save(add);
    }

    /**
     * 修改供货供应商
     *
     * @param bo 供货供应商编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(SupplierBo bo) {
        Supplier update = MapstructUtils.convert(bo, Supplier.class);
        return updateById(update);
    }

    /**
     * 批量删除供货供应商信息
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
