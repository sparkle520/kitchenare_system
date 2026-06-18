package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.Supplier;
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
 * 供货供应商业务对象 supplier
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@AutoMapper(target = Supplier.class, reverseConvertGenerate = false)
public class SupplierBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 供应商ID
     */
    @NotNull(message = "供应商ID不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 厂商名称
     */
    @NotBlank(message = "厂商名称不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 50, message = "厂商名称不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String supplierName;
    /**
     * 对接联系人
     */
    @Length(max = 20, message = "对接联系人不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String contact;
    /**
     * 联系电话
     */
    @Length(max = 11, message = "联系电话不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String phone;
    /**
     * 厂商地址
     */
    @Length(max = 200, message = "厂商地址不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String address;
    /**
     * 备注
     */
    @Length(max = 200, message = "备注不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String remark;
}
