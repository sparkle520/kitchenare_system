package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 轮播图查询对象 carousel
 *
 * @author sparkle520
 * @date 2026-06-21
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class CarouselQuery extends BasePageQuery {

    /**
     * 轮播图标题
     */
    private String title;

    /**
     * 图片地址
     */
    private String imageUrl;

    /**
     * 描述/副标题
     */
    private String description;

    /**
     * 跳转类型：0-无跳转 1-内部链接 2-外部链接 3-商品详情 4-分类页
     */
    private Integer linkType;

    /**
     * 跳转地址/商品ID/分类ID
     */
    private String linkUrl;

    /**
     * 打开方式：1-当前窗口 2-新窗口
     */
    private Integer openType;

    /**
     * 位置：home-首页轮播 activity-活动页 member-会员中心
     */
    private String position;

    /**
     * 排序号，越小越靠前
     */
    private Integer sort;

    /**
     * 状态：0-禁用 1-启用
     */
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
    private Integer clickCount;

    /**
     * 图片背景色/占位色
     */
    private String bgColor;

}
