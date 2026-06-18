package org.dromara.kitchenware.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;
import java.io.Serial;
import java.io.Serializable;

/**
 * 厨具商品分类对象 goods_category
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Data
@TableName("goods_category")
public class GoodsCategory implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 分类主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 分类名称
     */
    private String categoryName;

    /**
     * 排序权重
     */
    private Integer sort;

    /**
     * 备注说明
     */
    private String remark;

    /**
     * 创建人ID(sys_user.id)
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createBy;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新人ID
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateBy;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 逻辑删除 0正常 1删除
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private String delFlag;

}
