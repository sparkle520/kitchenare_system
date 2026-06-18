package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.PurchaseItem;
import org.dromara.kitchenware.domain.bo.PurchaseItemBo;
import org.dromara.kitchenware.domain.query.PurchaseItemQuery;
import org.dromara.kitchenware.domain.vo.PurchaseItemVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 入库商品明细Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface PurchaseItemMapper extends BaseMapperPlus<PurchaseItem, PurchaseItemVo> {

    /**
     * 查询入库商品明细列表
     *
     * @param query 查询对象
     * @return {@link PurchaseItemVo}
     */
    List<PurchaseItemVo> queryList(PurchaseItemQuery query);
}
