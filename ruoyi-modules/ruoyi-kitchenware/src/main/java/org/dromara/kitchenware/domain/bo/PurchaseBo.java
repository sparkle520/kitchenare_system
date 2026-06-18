package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.Purchase;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.Date;

import java.io.Serial;
import java.io.Serializable;

/**
 * 进货入库单业务对象 purchase
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@AutoMapper(target = Purchase.class, reverseConvertGenerate = false)
public class PurchaseBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 入库单主键
     */
    @NotNull(message = "入库单主键不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 供应商ID
     */
    @NotNull(message = "供应商ID不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long supplierId;
    /**
     * 操作员工sys_user.id
     */
    @NotNull(message = "操作员工sys_user.id不能为空", groups = {AddGroup.class, EditGroup.class})
    private Long operatorId;
    /**
     * 单据总金额
     */
    @NotNull(message = "单据总金额不能为空", groups = {AddGroup.class, EditGroup.class})
    private BigDecimal totalAmount;
    /**
     * 0未付款 1已结清
     */
    @NotNull(message = "0未付款 1已结清不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer payStatus;
    /**
     * 入库时间
     */
    @NotNull(message = "入库时间不能为空", groups = {AddGroup.class, EditGroup.class})
    private Date purchaseTime;
    /**
     * 单据备注
     */
    @Length(max = 300, message = "单据备注不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String note;
}
