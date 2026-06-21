package org.dromara.kitchenware.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
import org.dromara.kitchenware.domain.Goods;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 商品视图对象 goods
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Goods.class)
public class GoodsVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 商品SPU主键
     */
    @ExcelProperty(value = "商品SPU主键")
    private Long id;

    /**
     * 所属分类ID
     */
    @ExcelProperty(value = "所属分类ID")
    private Long categoryId;

    /**
     * 商品名称
     */
    @ExcelProperty(value = "商品名称")
    private String goodsName;

    /**
     * 品牌
     */
    @ExcelProperty(value = "品牌")
    private String brand;

    /**
     * 商品详情介绍
     */
    @ExcelProperty(value = "商品详情介绍")
    private String detail;

    /**
     * 商品主图地址
     */
    @ExcelProperty(value = "商品主图地址")
    private String mainImg;

    /**
     * 轮播多图，逗号分隔
     */
    @ExcelProperty(value = "轮播多图")
    private String slideImages;

    /**
     * 详情长图
     */
    @ExcelProperty(value = "详情长图")
    private String detailImg;

    /**
     * 1上架 0下架
     */
    @ExcelProperty(value = "1上架 0下架")
    private Integer status;

    /**
     * SKU最低价格
     */
    private BigDecimal minPrice;

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
