package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 商品规格SKU对象 goods_sku
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@TableName("goods_sku")
public class GoodsSku implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * SKU主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 商品id
     */
    private Long goodsId;

    /**
     * 规格JSON 如{"材质":"304不锈钢","尺寸":"32cm"}
     */
    private String skuAttr;

    /**
     * 货号条码
     */
    private String skuCode;

    /**
     * 单位 个/套/把
     */
    private String unit;

    /**
     * 当前库存
     */
    private Integer stockNum;

    /**
     * 库存预警下限
     */
    private Integer safeStock;

    /**
     * 进货成本价
     */
    private BigDecimal purchasePrice;

    /**
     * 零售售价
     */
    private BigDecimal salePrice;

    /**
     * 规格图片地址
     */
    private String picUrl;

    /**
     * 1启用 0停用
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
