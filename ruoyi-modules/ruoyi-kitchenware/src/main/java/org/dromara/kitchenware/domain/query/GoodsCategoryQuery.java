package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 厨具商品分类查询对象 goods_category
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class GoodsCategoryQuery extends BasePageQuery {

    /**
     * 分类名称
     */
    private String categoryName;

    /**
     * 排序权重
     */
    private Integer sort;

}
