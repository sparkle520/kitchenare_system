package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 商品对象 goods
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@TableName("goods")
public class Goods implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 商品SPU主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 所属分类ID
     */
    private Long categoryId;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 品牌
     */
    private String brand;

    /**
     * 商品详情介绍
     */
    private String detail;

    /**
     * 商品主图地址
     */
    private String mainImg;

    /**
     * 轮播多图，逗号分隔
     */
    private String slideImages;

    /**
     * 详情长图
     */
    private String detailImg;

    /**
     * 1上架 0下架
     */
    private Integer status;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createBy;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateBy;

    /**
     * 
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private String delFlag;

}
