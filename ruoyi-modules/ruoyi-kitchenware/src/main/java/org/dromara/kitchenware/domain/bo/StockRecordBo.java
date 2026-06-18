package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.StockRecord;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;

import java.io.Serial;
import java.io.Serializable;

/**
 * 库存变更流水业务对象 stock_record
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@AutoMapper(target = StockRecord.class, reverseConvertGenerate = false)
public class StockRecordBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 流水ID
     */
    @NotNull(message = "流水ID不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 操作SKU
     */
    @NotNull(message = "操作SKU不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long skuId;
    /**
     * 1采购入库 2销售出库 3退货入库 4损耗扣库
     */
    @NotNull(message = "1采购入库 2销售出库 3退货入库 4损耗扣库不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer changeType;
    /**
     * 变动数量(出库负数)
     */
    @NotNull(message = "变动数量不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer changeNum;
    /**
     * 变动后剩余库存
     */
    @NotNull(message = "变动后剩余库存不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer stockAfter;
    /**
     * 关联单据ID(采购/订单/售后)
     */
    private Long relationId;
    /**
     * 
     */
    @NotNull(message = "不能为空", groups = {AddGroup.class, EditGroup.class})
    private Date operateTime;
}
