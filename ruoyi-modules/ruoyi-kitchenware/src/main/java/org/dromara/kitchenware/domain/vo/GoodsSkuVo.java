package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.GoodsSku;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 商品规格SKU视图对象 goods_sku
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = GoodsSku.class)
public class GoodsSkuVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * SKU主键
     */
    @ExcelProperty(value = "SKU主键")
    private Long id;

    /**
     * 商品id
     */
    @ExcelProperty(value = "商品id")
    private Long goodsId;

    /**
     * 规格JSON 如{"材质":"304不锈钢","尺寸":"32cm"}
     */
    @ExcelProperty(value = "规格JSON")
    private String skuAttr;

    /**
     * 货号条码
     */
    @ExcelProperty(value = "货号条码")
    private String skuCode;

    /**
     * 单位 个/套/把
     */
    @ExcelProperty(value = "单位 个/套/把")
    private String unit;

    /**
     * 当前库存
     */
    @ExcelProperty(value = "当前库存")
    private Integer stockNum;

    /**
     * 库存预警下限
     */
    @ExcelProperty(value = "库存预警下限")
    private Integer safeStock;

    /**
     * 进货成本价
     */
    @ExcelProperty(value = "进货成本价")
    private BigDecimal purchasePrice;

    /**
     * 零售售价
     */
    @ExcelProperty(value = "零售售价")
    private BigDecimal salePrice;

    /**
     * 规格图片地址
     */
    @ExcelProperty(value = "规格图片地址")
    private String picUrl;

    /**
     * 1启用 0停用
     */
    @ExcelProperty(value = "1启用 0停用")
    private Integer status;

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
