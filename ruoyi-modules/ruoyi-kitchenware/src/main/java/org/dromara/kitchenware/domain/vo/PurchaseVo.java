package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.Purchase;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 进货入库单视图对象 purchase
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Purchase.class)
public class PurchaseVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 入库单主键
     */
    @ExcelProperty(value = "入库单主键")
    private Long id;

    /**
     * 供应商ID
     */
    @ExcelProperty(value = "供应商ID")
    private Long supplierId;

    /**
     * 操作员工sys_user.id
     */
    @ExcelProperty(value = "操作员工sys_user.id")
    private Long operatorId;

    /**
     * 单据总金额
     */
    @ExcelProperty(value = "单据总金额")
    private BigDecimal totalAmount;

    /**
     * 0未付款 1已结清
     */
    @ExcelProperty(value = "0未付款 1已结清")
    private Integer payStatus;

    /**
     * 入库时间
     */
    @ExcelProperty(value = "入库时间")
    private Date purchaseTime;

    /**
     * 单据备注
     */
    @ExcelProperty(value = "单据备注")
    private String note;

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
