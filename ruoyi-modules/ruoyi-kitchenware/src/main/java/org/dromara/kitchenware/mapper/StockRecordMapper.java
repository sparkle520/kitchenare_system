package org.dromara.kitchenware.mapper;

import org.dromara.kitchenware.domain.StockRecord;
import org.dromara.kitchenware.domain.bo.StockRecordBo;
import org.dromara.kitchenware.domain.query.StockRecordQuery;
import org.dromara.kitchenware.domain.vo.StockRecordVo;
import org.dromara.common.mybatis.core.mapper.BaseMapperPlus;

import java.util.List;

/**
 * 库存变更流水Mapper接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface StockRecordMapper extends BaseMapperPlus<StockRecord, StockRecordVo> {

    /**
     * 查询库存变更流水列表
     *
     * @param query 查询对象
     * @return {@link StockRecordVo}
     */
    List<StockRecordVo> queryList(StockRecordQuery query);
}
