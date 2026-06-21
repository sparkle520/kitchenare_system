package org.dromara.kitchenware.domain.vo;

import java.util.Date;
import org.dromara.kitchenware.domain.Carousel;
import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import org.dromara.common.excel.annotation.ExcelDictFormat;
import org.dromara.common.excel.convert.ExcelDictConvert;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;

/**
 * 轮播图视图对象 carousel
 *
 * @author sparkle520
 * @date 2026-06-21
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Carousel.class)
public class CarouselVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @ExcelProperty(value = "主键ID")
    private Long id;

    /**
     * 轮播图标题
     */
    @ExcelProperty(value = "轮播图标题")
    private String title;

    /**
     * 图片地址
     */
    @ExcelProperty(value = "图片地址")
    private String imageUrl;

    /**
     * 描述/副标题
     */
    @ExcelProperty(value = "描述/副标题")
    private String description;

    /**
     * 跳转类型：0-无跳转 1-内部链接 2-外部链接 3-商品详情 4-分类页
     */
    @ExcelProperty(value = "跳转类型：0-无跳转 1-内部链接 2-外部链接 3-商品详情 4-分类页", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "link_type")
    private Integer linkType;

    /**
     * 跳转地址/商品ID/分类ID
     */
    @ExcelProperty(value = "跳转地址/商品ID/分类ID")
    private String linkUrl;

    /**
     * 打开方式：1-当前窗口 2-新窗口
     */
    @ExcelProperty(value = "打开方式：1-当前窗口 2-新窗口", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "open_type")
    private Integer openType;

    /**
     * 位置：home-首页轮播 activity-活动页 member-会员中心
     */
    @ExcelProperty(value = "位置：home-首页轮播 activity-活动页 member-会员中心")
    private String position;

    /**
     * 排序号，越小越靠前
     */
    @ExcelProperty(value = "排序号，越小越靠前")
    private Integer sort;

    /**
     * 状态：0-禁用 1-启用
     */
    @ExcelProperty(value = "状态：0-禁用 1-启用", converter = ExcelDictConvert.class)
    @ExcelDictFormat(dictType = "sys_normal_disable")
    private Integer status;

    /**
     * 生效开始时间
     */
    @ExcelProperty(value = "生效开始时间")
    private Date startTime;

    /**
     * 生效结束时间
     */
    @ExcelProperty(value = "生效结束时间")
    private Date endTime;

    /**
     * 点击次数
     */
    @ExcelProperty(value = "点击次数")
    private Integer clickCount;

    /**
     * 图片背景色/占位色
     */
    @ExcelProperty(value = "图片背景色/占位色")
    private String bgColor;

    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @ExcelProperty(value = "更新时间")
    private Date updateTime;

}
