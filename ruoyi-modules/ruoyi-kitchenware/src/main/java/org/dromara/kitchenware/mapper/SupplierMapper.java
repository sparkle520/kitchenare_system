package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.Supplier;
import org.dromara.kitchenware.domain.bo.SupplierBo;
import org.dromara.kitchenware.domain.query.SupplierQuery;
import org.dromara.kitchenware.domain.vo.SupplierVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 供货供应商Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface SupplierMapper extends BaseMapperPlus<Supplier, SupplierVo> {

    /**
     * 查询供货供应商列表
     *
     * @param query 查询对象
     * @return {@link SupplierVo}
     */
    List<SupplierVo> queryList(SupplierQuery query);
}
