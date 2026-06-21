package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.SaleOrderItem;
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
 * 订单商品明细业务对象 sale_order_item
 *
 * @author sparkle520
 * @date 2026-06-19
 */
@Data
@AutoMapper(target = SaleOrderItem.class, reverseConvertGenerate = false)
public class SaleOrderItemBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 明细主键
     */
    @NotNull(message = "明细主键不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 归属订单ID
     */
    @NotNull(message = "归属订单ID不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long orderId;
    /**
     * 商品SPU
     */
    @NotNull(message = "商品SPU不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long goodsId;
    /**
     * 规格SKU
     */
    @NotNull(message = "规格SKU不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long skuId;
    /**
     * 购买数量
     */
    @NotNull(message = "购买数量不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer buyNum;
    /**
     * 下单时原价快照
     */
    @NotNull(message = "下单时原价快照不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal originalPrice;
    /**
     * 实际成交单价
     */
    @NotNull(message = "实际成交单价不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal sellPrice;
    /**
     * 本行小计金额
     */
    @NotNull(message = "本行小计金额不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal subtotal;
}
