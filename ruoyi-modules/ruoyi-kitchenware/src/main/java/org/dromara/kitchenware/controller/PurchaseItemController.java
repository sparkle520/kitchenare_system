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
import org.dromara.kitchenware.domain.bo.PurchaseItemBo;
import org.dromara.kitchenware.domain.query.PurchaseItemQuery;
import org.dromara.kitchenware.domain.vo.PurchaseItemVo;
import org.dromara.kitchenware.service.IPurchaseItemService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 入库商品明细
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Validated
@RestController
@RequestMapping("/kitchenware/item")
public class PurchaseItemController extends BaseController {

    @Autowired
    private IPurchaseItemService purchaseItemService;

    /**
     * 查询入库商品明细列表
     */
    @SaCheckPermission("kitchenware:item:list")
    @GetMapping("/list")
    public TableDataInfo<PurchaseItemVo> list(PurchaseItemQuery query) {
        return purchaseItemService.queryPageList(query);
    }

    /**
     * 导出入库商品明细列表
     */
    @SaCheckPermission("kitchenware:item:export")
    @Log(title = "入库商品明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(PurchaseItemQuery query, HttpServletResponse response) {
        List<PurchaseItemVo> list = purchaseItemService.queryList(query);
        ExcelUtil.exportExcel(list, "入库商品明细", PurchaseItemVo.class, response);
    }

    /**
     * 获取入库商品明细详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:item:query", "kitchenware:item:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<PurchaseItemVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(purchaseItemService.queryById(id));
    }

    /**
     * 新增入库商品明细
     */
    @SaCheckPermission("kitchenware:item:add")
    @Log(title = "入库商品明细", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody PurchaseItemBo bo) {
        return toAjax(purchaseItemService.insertByBo(bo));
    }

    /**
     * 修改入库商品明细
     */
    @SaCheckPermission("kitchenware:item:edit")
    @Log(title = "入库商品明细", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody PurchaseItemBo bo) {
        return toAjax(purchaseItemService.updateByBo(bo));
    }

    /**
     * 删除入库商品明细
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:item:remove")
    @Log(title = "入库商品明细", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(purchaseItemService.deleteWithValidByIds(List.of(ids)));
    }
}
