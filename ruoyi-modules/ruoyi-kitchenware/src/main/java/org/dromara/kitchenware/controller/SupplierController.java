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
import org.dromara.kitchenware.domain.bo.SupplierBo;
import org.dromara.kitchenware.domain.query.SupplierQuery;
import org.dromara.kitchenware.domain.vo.SupplierVo;
import org.dromara.kitchenware.service.ISupplierService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 供货供应商
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Validated
@RestController
@RequestMapping("/kitchenware/supplier")
public class SupplierController extends BaseController {

    @Autowired
    private ISupplierService supplierService;

    /**
     * 查询供货供应商列表
     */
    @SaCheckPermission("kitchenware:supplier:list")
    @GetMapping("/list")
    public TableDataInfo<SupplierVo> list(SupplierQuery query) {
        return supplierService.queryPageList(query);
    }

    /**
     * 导出供货供应商列表
     */
    @SaCheckPermission("kitchenware:supplier:export")
    @Log(title = "供货供应商", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(SupplierQuery query, HttpServletResponse response) {
        List<SupplierVo> list = supplierService.queryList(query);
        ExcelUtil.exportExcel(list, "供货供应商", SupplierVo.class, response);
    }

    /**
     * 获取供货供应商详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:supplier:query", "kitchenware:supplier:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<SupplierVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(supplierService.queryById(id));
    }

    /**
     * 新增供货供应商
     */
    @SaCheckPermission("kitchenware:supplier:add")
    @Log(title = "供货供应商", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody SupplierBo bo) {
        return toAjax(supplierService.insertByBo(bo));
    }

    /**
     * 修改供货供应商
     */
    @SaCheckPermission("kitchenware:supplier:edit")
    @Log(title = "供货供应商", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody SupplierBo bo) {
        return toAjax(supplierService.updateByBo(bo));
    }

    /**
     * 删除供货供应商
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:supplier:remove")
    @Log(title = "供货供应商", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(supplierService.deleteWithValidByIds(List.of(ids)));
    }
}
