package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.Purchase;
import org.dromara.kitchenware.domain.bo.PurchaseBo;
import org.dromara.kitchenware.domain.query.PurchaseQuery;
import org.dromara.kitchenware.domain.vo.PurchaseVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 进货入库单Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface PurchaseMapper extends BaseMapperPlus<Purchase, PurchaseVo> {

    /**
     * 查询进货入库单列表
     *
     * @param query 查询对象
     * @return {@link PurchaseVo}
     */
    List<PurchaseVo> queryList(PurchaseQuery query);
}
