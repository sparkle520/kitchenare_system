package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.GoodsCategory;
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
 * 厨具商品分类业务对象 goods_category
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@AutoMapper(target = GoodsCategory.class, reverseConvertGenerate = false)
public class GoodsCategoryBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类主键ID
     */
    @NotNull(message = "分类主键ID不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 分类名称
     */
    @NotBlank(message = "分类名称不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 30, message = "分类名称不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String categoryName;
    /**
     * 排序权重
     */
    @NotNull(message = "排序权重不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer sort;
    /**
     * 备注说明
     */
    @Length(max = 200, message = "备注说明不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String remark;
}
