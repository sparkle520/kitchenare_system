package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 商品规格SKU查询对象 goods_sku
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class GoodsSkuQuery extends BasePageQuery {

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

}
