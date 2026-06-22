package org.dromara.kitchenware.controller;

import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import org.dromara.common.idempotent.annotation.RepeatSubmit;
import org.dromara.common.log.annotation.Log;
import org.dromara.common.web.core.BaseController;
import org.dromara.common.core.domain.R;
import org.dromara.common.core.validate.AddGroup;
import org.dromara.common.core.validate.EditGroup;
import org.dromara.common.log.enums.BusinessType;
import org.dromara.common.excel.utils.ExcelUtil;
import org.dromara.kitchenware.domain.bo.CarouselBo;
import org.dromara.kitchenware.domain.query.CarouselQuery;
import org.dromara.kitchenware.domain.vo.CarouselVo;
import org.dromara.kitchenware.service.ICarouselService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 轮播图
 *
 * @author sparkle520
 * @date 2026-06-21
 */
@Validated
@RestController
@RequestMapping("/kitchenware/carousel")
public class CarouselController extends BaseController {

    @Autowired
    private ICarouselService carouselService;

    /**
     * 查询轮播图列表
     */
    @SaCheckPermission("kitchenware:carousel:list")
    @GetMapping("/list")
    public TableDataInfo<CarouselVo> list(CarouselQuery query) {
        return carouselService.queryPageList(query);
    }

    /**
     * 查询轮播图列表（匿名访问）
     */

    @GetMapping("/front/list")
    public TableDataInfo<CarouselVo> frontList(CarouselQuery query) {
        return carouselService.queryPageList(query);
    }

    /**
     * 导出轮播图列表
     */
    @SaCheckPermission("kitchenware:carousel:export")
    @Log(title = "轮播图", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CarouselQuery query, HttpServletResponse response) {
        List<CarouselVo> list = carouselService.queryList(query);
        ExcelUtil.exportExcel(list, "轮播图", CarouselVo.class, response);
    }

    /**
     * 获取轮播图详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:carousel:query", "kitchenware:carousel:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<CarouselVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(carouselService.queryById(id));
    }

    /**
     * 新增轮播图
     */
    @SaCheckPermission("kitchenware:carousel:add")
    @Log(title = "轮播图", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody CarouselBo bo) {
        return toAjax(carouselService.insertByBo(bo));
    }

    /**
     * 修改轮播图
     */
    @SaCheckPermission("kitchenware:carousel:edit")
    @Log(title = "轮播图", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody CarouselBo bo) {
        return toAjax(carouselService.updateByBo(bo));
    }

    /**
     * 删除轮播图
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:carousel:remove")
    @Log(title = "轮播图", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(carouselService.deleteWithValidByIds(List.of(ids)));
    }
}
