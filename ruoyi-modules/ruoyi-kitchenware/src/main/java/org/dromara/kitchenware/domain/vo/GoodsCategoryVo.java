package org.dromara.kitchenware.domain.vo;

import java.util.Date;
import org.dromara.kitchenware.domain.GoodsCategory;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 厨具商品分类视图对象 goods_category
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = GoodsCategory.class)
public class GoodsCategoryVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类主键ID
     */
    @ExcelProperty(value = "分类主键ID")
    private Long id;

    /**
     * 分类名称
     */
    @ExcelProperty(value = "分类名称")
    private String categoryName;

    /**
     * 排序权重
     */
    @ExcelProperty(value = "排序权重")
    private Integer sort;

    /**
     * 备注说明
     */
    @ExcelProperty(value = "备注说明")
    private String remark;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private Date updateTime;

}
