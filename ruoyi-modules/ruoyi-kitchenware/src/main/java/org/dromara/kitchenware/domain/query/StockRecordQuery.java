package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 库存变更流水查询对象 stock_record
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class StockRecordQuery extends BasePageQuery {

    /**
     * 操作SKU
     */
    private Long skuId;

    /**
     * 1采购入库 2销售出库 3退货入库 4损耗扣库
     */
    private Integer changeType;

    /**
     * 变动数量(出库负数)
     */
    private Integer changeNum;

    /**
     * 变动后剩余库存
     */
    private Integer stockAfter;

    /**
     * 关联单据ID(采购/订单/售后)
     */
    private Long relationId;

    /**
     * 
     */
    private Date operateTime;

}
