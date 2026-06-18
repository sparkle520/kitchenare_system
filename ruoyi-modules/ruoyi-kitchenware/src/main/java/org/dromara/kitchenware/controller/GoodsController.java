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
import org.dromara.kitchenware.domain.bo.GoodsBo;
import org.dromara.kitchenware.domain.query.GoodsQuery;
import org.dromara.kitchenware.domain.vo.GoodsVo;
import org.dromara.kitchenware.service.IGoodsService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 商品
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Validated
@RestController
@RequestMapping("/kitchenware/goods")
public class GoodsController extends BaseController {

    @Autowired
    private IGoodsService goodsService;

    /**
     * 查询商品列表
     */
    @SaCheckPermission("kitchenware:goods:list")
    @GetMapping("/list")
    public TableDataInfo<GoodsVo> list(GoodsQuery query) {
        return goodsService.queryPageList(query);
    }

    /**
     * 导出商品列表
     */
    @SaCheckPermission("kitchenware:goods:export")
    @Log(title = "商品", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(GoodsQuery query, HttpServletResponse response) {
        List<GoodsVo> list = goodsService.queryList(query);
        ExcelUtil.exportExcel(list, "商品", GoodsVo.class, response);
    }

    /**
     * 获取商品详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:goods:query", "kitchenware:goods:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<GoodsVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(goodsService.queryById(id));
    }

    /**
     * 新增商品
     */
    @SaCheckPermission("kitchenware:goods:add")
    @Log(title = "商品", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody GoodsBo bo) {
        return toAjax(goodsService.insertByBo(bo));
    }

    /**
     * 修改商品
     */
    @SaCheckPermission("kitchenware:goods:edit")
    @Log(title = "商品", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody GoodsBo bo) {
        return toAjax(goodsService.updateByBo(bo));
    }

    /**
     * 删除商品
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:goods:remove")
    @Log(title = "商品", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(goodsService.deleteWithValidByIds(List.of(ids)));
    }
}
