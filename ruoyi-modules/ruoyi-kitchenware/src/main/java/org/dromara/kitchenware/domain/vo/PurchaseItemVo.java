package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.PurchaseItem;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 入库商品明细视图对象 purchase_item
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = PurchaseItem.class)
public class PurchaseItemVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 明细主键
     */
    @ExcelProperty(value = "明细主键")
    private Long id;

    /**
     * 入库单ID
     */
    @ExcelProperty(value = "入库单ID")
    private Long purchaseId;

    /**
     * 商品SKU
     */
    @ExcelProperty(value = "商品SKU")
    private Long skuId;

    /**
     * 采购数量
     */
    @ExcelProperty(value = "采购数量")
    private Integer buyNum;

    /**
     * 单件进价
     */
    @ExcelProperty(value = "单件进价")
    private BigDecimal buyPrice;

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
