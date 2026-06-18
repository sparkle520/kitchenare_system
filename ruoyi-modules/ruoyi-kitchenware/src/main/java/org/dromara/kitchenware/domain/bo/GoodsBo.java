package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.Goods;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;

import java.io.Serial;
import java.io.Serializable;

/**
 * 商品业务对象 goods
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@AutoMapper(target = Goods.class, reverseConvertGenerate = false)
public class GoodsBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 商品SPU主键
     */
    @NotNull(message = "商品SPU主键不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 所属分类ID
     */
    @NotNull(message = "所属分类ID不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long categoryId;
    /**
     * 商品名称
     */
    @NotBlank(message = "商品名称不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 60, message = "商品名称不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String goodsName;
    /**
     * 品牌
     */
    @Length(max = 30, message = "品牌不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String brand;
    /**
     * 商品详情介绍
     */
    private String detail;
    /**
     * 商品主图地址
     */
    @NotBlank(message = "商品主图地址不能为空", groups = {AddGroup.class, EditGroup.class})
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
    @NotNull(message = "1上架 0下架不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer status;
}
