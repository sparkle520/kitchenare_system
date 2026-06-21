package org.dromara.kitchenware.domain.bo;

import org.dromara.kitchenware.domain.Carousel;
import org.dromara.common.mybatis.core.domain.BaseEntity;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.hibernate.validator.constraints.Length;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import jakarta.validation.constraints.*;
import java.util.Date;

import java.io.Serial;
import java.io.Serializable;

/**
 * 轮播图业务对象 carousel
 *
 * @author sparkle520
 * @date 2026-06-21
 */
@Data
@AutoMapper(target = Carousel.class, reverseConvertGenerate = false)
public class CarouselBo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @NotNull(message = "主键ID不能为空", groups = {EditGroup.class})
    private Long id;
    /**
     * 轮播图标题
     */
    @NotBlank(message = "轮播图标题不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 100, message = "轮播图标题不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String title;
    /**
     * 图片地址
     */
    @NotBlank(message = "图片地址不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 1000, message = "图片地址不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String imageUrl;
    /**
     * 描述/副标题
     */
    @NotBlank(message = "描述/副标题不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 255, message = "描述/副标题不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String description;
    /**
     * 跳转类型：0-无跳转 1-内部链接 2-外部链接 3-商品详情 4-分类页
     */
    @NotNull(message = "跳转类型：0-无跳转 1-内部链接 2-外部链接 3-商品详情 4-分类页不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer linkType;
    /**
     * 跳转地址/商品ID/分类ID
     */
    @NotBlank(message = "跳转地址/商品ID/分类ID不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 1000, message = "跳转地址/商品ID/分类ID不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String linkUrl;
    /**
     * 打开方式：1-当前窗口 2-新窗口
     */
    @NotNull(message = "打开方式：1-当前窗口 2-新窗口不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer openType;
    /**
     * 位置：home-首页轮播 activity-活动页 member-会员中心
     */
    @NotBlank(message = "位置：home-首页轮播 activity-活动页 member-会员中心不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 50, message = "位置：home-首页轮播 activity-活动页 member-会员中心不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String position;
    /**
     * 排序号，越小越靠前
     */
    @NotNull(message = "排序号，越小越靠前不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer sort;
    /**
     * 状态：0-禁用 1-启用
     */
    @NotNull(message = "状态：0-禁用 1-启用不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer status;
    /**
     * 生效开始时间
     */
    private Date startTime;
    /**
     * 生效结束时间
     */
    private Date endTime;
    /**
     * 点击次数
     */
    @NotNull(message = "点击次数不能为空", groups = {AddGroup.class, EditGroup.class})
    private Integer clickCount;
    /**
     * 图片背景色/占位色
     */
    @NotBlank(message = "图片背景色/占位色不能为空", groups = {AddGroup.class, EditGroup.class})
    @Length(max = 20, message = "图片背景色/占位色不能大于{max}个字符", groups = {AddGroup.class, EditGroup.class})
    private String bgColor;
}
