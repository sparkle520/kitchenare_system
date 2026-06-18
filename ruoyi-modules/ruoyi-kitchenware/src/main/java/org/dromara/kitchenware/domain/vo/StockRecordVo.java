package org.dromara.kitchenware.domain.vo;

import java.util.Date;
import org.dromara.kitchenware.domain.StockRecord;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 库存变更流水视图对象 stock_record
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = StockRecord.class)
public class StockRecordVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 流水ID
     */
    @ExcelProperty(value = "流水ID")
    private Long id;

    /**
     * 操作SKU
     */
    @ExcelProperty(value = "操作SKU")
    private Long skuId;

    /**
     * 1采购入库 2销售出库 3退货入库 4损耗扣库
     */
    @ExcelProperty(value = "1采购入库 2销售出库 3退货入库 4损耗扣库")
    private Integer changeType;

    /**
     * 变动数量(出库负数)
     */
    @ExcelProperty(value = "变动数量")
    private Integer changeNum;

    /**
     * 变动后剩余库存
     */
    @ExcelProperty(value = "变动后剩余库存")
    private Integer stockAfter;

    /**
     * 关联单据ID(采购/订单/售后)
     */
    @ExcelProperty(value = "关联单据ID")
    private Long relationId;

    /**
     * 
     */
    @ExcelProperty(value = "")
    private Date operateTime;

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
