package org.dromara.kitchenware.domain.vo;

import java.util.Date;
import org.dromara.kitchenware.domain.Supplier;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 供货供应商视图对象 supplier
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Supplier.class)
public class SupplierVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 供应商ID
     */
    @ExcelProperty(value = "供应商ID")
    private Long id;

    /**
     * 厂商名称
     */
    @ExcelProperty(value = "厂商名称")
    private String supplierName;

    /**
     * 对接联系人
     */
    @ExcelProperty(value = "对接联系人")
    private String contact;

    /**
     * 联系电话
     */
    @ExcelProperty(value = "联系电话")
    private String phone;

    /**
     * 厂商地址
     */
    @ExcelProperty(value = "厂商地址")
    private String address;

    /**
     * 备注
     */
    @ExcelProperty(value = "备注")
    private String remark;

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
