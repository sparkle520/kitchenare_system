package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 商品查询对象 goods
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class GoodsQuery extends BasePageQuery {

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
     * 1上架 0下架
     */
    private Integer status;

}
