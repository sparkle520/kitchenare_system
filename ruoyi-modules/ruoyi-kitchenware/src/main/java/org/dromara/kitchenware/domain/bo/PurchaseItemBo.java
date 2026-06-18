package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.PurchaseItem;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

import java.io.Serial;
import java.io.Serializable;

/**
 * 入库商品明细业务对象 purchase_item
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@AutoMapper(target = PurchaseItem.class, reverseConvertGenerate = false)
public class PurchaseItemBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 明细主键
     */
    @NotNull(message = "明细主键不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 入库单ID
     */
    @NotNull(message = "入库单ID不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long purchaseId;
    /**
     * 商品SKU
     */
    @NotNull(message = "商品SKU不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long skuId;
    /**
     * 采购数量
     */
    @NotNull(message = "采购数量不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer buyNum;
    /**
     * 单件进价
     */
    @NotNull(message = "单件进价不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal buyPrice;
    /**
     * 本行小计金额
     */
    @NotNull(message = "本行小计金额不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal subtotal;
}
