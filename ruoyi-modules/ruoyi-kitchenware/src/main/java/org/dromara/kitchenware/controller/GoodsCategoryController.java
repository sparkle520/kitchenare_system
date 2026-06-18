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
import org.dromara.kitchenware.domain.bo.GoodsCategoryBo;
import org.dromara.kitchenware.domain.query.GoodsCategoryQuery;
import org.dromara.kitchenware.domain.vo.GoodsCategoryVo;
import org.dromara.kitchenware.service.IGoodsCategoryService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 厨具商品分类
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Validated
@RestController
@RequestMapping("/kitchenware/category")
public class GoodsCategoryController extends BaseController {

    @Autowired
    private IGoodsCategoryService goodsCategoryService;

    /**
     * 查询厨具商品分类列表
     */
    @SaCheckPermission("kitchenware:category:list")
    @GetMapping("/list")
    public TableDataInfo<GoodsCategoryVo> list(GoodsCategoryQuery query) {
        return goodsCategoryService.queryPageList(query);
    }

    /**
     * 导出厨具商品分类列表
     */
    @SaCheckPermission("kitchenware:category:export")
    @Log(title = "厨具商品分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(GoodsCategoryQuery query, HttpServletResponse response) {
        List<GoodsCategoryVo> list = goodsCategoryService.queryList(query);
        ExcelUtil.exportExcel(list, "厨具商品分类", GoodsCategoryVo.class, response);
    }

    /**
     * 获取厨具商品分类详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:category:query", "kitchenware:category:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<GoodsCategoryVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(goodsCategoryService.queryById(id));
    }

    /**
     * 新增厨具商品分类
     */
    @SaCheckPermission("kitchenware:category:add")
    @Log(title = "厨具商品分类", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody GoodsCategoryBo bo) {
        return toAjax(goodsCategoryService.insertByBo(bo));
    }

    /**
     * 修改厨具商品分类
     */
    @SaCheckPermission("kitchenware:category:edit")
    @Log(title = "厨具商品分类", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody GoodsCategoryBo bo) {
        return toAjax(goodsCategoryService.updateByBo(bo));
    }

    /**
     * 删除厨具商品分类
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:category:remove")
    @Log(title = "厨具商品分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(goodsCategoryService.deleteWithValidByIds(List.of(ids)));
    }
}
