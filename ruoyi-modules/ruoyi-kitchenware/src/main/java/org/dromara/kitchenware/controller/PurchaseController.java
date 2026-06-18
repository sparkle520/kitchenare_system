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
import org.dromara.kitchenware.domain.bo.PurchaseBo;
import org.dromara.kitchenware.domain.query.PurchaseQuery;
import org.dromara.kitchenware.domain.vo.PurchaseVo;
import org.dromara.kitchenware.service.IPurchaseService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 进货入库单
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Validated
@RestController
@RequestMapping("/kitchenware/purchase")
public class PurchaseController extends BaseController {

    @Autowired
    private IPurchaseService purchaseService;

    /**
     * 查询进货入库单列表
     */
    @SaCheckPermission("kitchenware:purchase:list")
    @GetMapping("/list")
    public TableDataInfo<PurchaseVo> list(PurchaseQuery query) {
        return purchaseService.queryPageList(query);
    }

    /**
     * 导出进货入库单列表
     */
    @SaCheckPermission("kitchenware:purchase:export")
    @Log(title = "进货入库单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(PurchaseQuery query, HttpServletResponse response) {
        List<PurchaseVo> list = purchaseService.queryList(query);
        ExcelUtil.exportExcel(list, "进货入库单", PurchaseVo.class, response);
    }

    /**
     * 获取进货入库单详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:purchase:query", "kitchenware:purchase:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<PurchaseVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(purchaseService.queryById(id));
    }

    /**
     * 新增进货入库单
     */
    @SaCheckPermission("kitchenware:purchase:add")
    @Log(title = "进货入库单", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody PurchaseBo bo) {
        return toAjax(purchaseService.insertByBo(bo));
    }

    /**
     * 修改进货入库单
     */
    @SaCheckPermission("kitchenware:purchase:edit")
    @Log(title = "进货入库单", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody PurchaseBo bo) {
        return toAjax(purchaseService.updateByBo(bo));
    }

    /**
     * 删除进货入库单
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:purchase:remove")
    @Log(title = "进货入库单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(purchaseService.deleteWithValidByIds(List.of(ids)));
    }
}
