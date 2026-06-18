package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.GoodsSku;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

import java.io.Serial;
import java.io.Serializable;

/**
 * 商品规格SKU业务对象 goods_sku
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@AutoMapper(target = GoodsSku.class, reverseConvertGenerate = false)
public class GoodsSkuBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * SKU主键
     */
    @NotNull(message = "SKU主键不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 商品id
     */
    @NotNull(message = "商品id不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long goodsId;
    /**
     * 规格JSON 如{"材质":"304不锈钢","尺寸":"32cm"}
     */
    @NotBlank(message = "规格JSON 如{"材质":"304不锈钢","尺寸":"32cm"}不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 500, message = "规格JSON 如{"材质":"304不锈钢","尺寸":"32cm"}不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String skuAttr;
    /**
     * 货号条码
     */
    @Length(max = 50, message = "货号条码不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String skuCode;
    /**
     * 单位 个/套/把
     */
    @NotBlank(message = "单位 个/套/把不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 10, message = "单位 个/套/把不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String unit;
    /**
     * 当前库存
     */
    @NotNull(message = "当前库存不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer stockNum;
    /**
     * 库存预警下限
     */
    @NotNull(message = "库存预警下限不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer safeStock;
    /**
     * 进货成本价
     */
    @NotNull(message = "进货成本价不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal purchasePrice;
    /**
     * 零售售价
     */
    @NotNull(message = "零售售价不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal salePrice;
    /**
     * 规格图片地址
     */
    @Length(max = 255, message = "规格图片地址不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String picUrl;
    /**
     * 1启用 0停用
     */
    @NotNull(message = "1启用 0停用不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer status;
}
