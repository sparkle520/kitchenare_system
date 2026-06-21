package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.SaleOrderItem;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 订单商品明细视图对象 sale_order_item
 *
 * @author sparkle520
 * @date 2026-06-19
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = SaleOrderItem.class)
public class SaleOrderItemVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 明细主键
     */
    @ExcelProperty(value = "明细主键")
    private Long id;

    /**
     * 归属订单ID
     */
    @ExcelProperty(value = "归属订单ID")
    private Long orderId;

    /**
     * 商品SPU
     */
    @ExcelProperty(value = "商品SPU")
    private Long goodsId;

    /**
     * 规格SKU
     */
    @ExcelProperty(value = "规格SKU")
    private Long skuId;

    /**
     * 购买数量
     */
    @ExcelProperty(value = "购买数量")
    private Integer buyNum;

    /**
     * 下单时原价快照
     */
    @ExcelProperty(value = "下单时原价快照")
    private BigDecimal originalPrice;

    /**
     * 实际成交单价
     */
    @ExcelProperty(value = "实际成交单价")
    private BigDecimal sellPrice;

    /**
     * 本行小计金额
     */
    @ExcelProperty(value = "本行小计金额")
    private BigDecimal subtotal;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date createTime;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date updateTime;

}
