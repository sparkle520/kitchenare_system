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
import org.dromara.kitchenware.domain.bo.SaleOrderItemBo;
import org.dromara.kitchenware.domain.query.SaleOrderItemQuery;
import org.dromara.kitchenware.domain.vo.SaleOrderItemVo;
import org.dromara.kitchenware.service.ISaleOrderItemService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 订单商品明细
 *
 * @author sparkle520
 * @date 2026-06-19
 */
@Validated
@RestController
@RequestMapping("/kitchenware/SaleOrderItem")
public class SaleOrderItemController extends BaseController {

    @Autowired
    private ISaleOrderItemService saleOrderItemService;

    /**
     * 查询订单商品明细列表
     */
    @SaCheckPermission("kitchenware:SaleOrderItem:list")
    @GetMapping("/list")
    public TableDataInfo<SaleOrderItemVo> list(SaleOrderItemQuery query) {
        return saleOrderItemService.queryPageList(query);
    }

    /**
     * 导出订单商品明细列表
     */
    @SaCheckPermission("kitchenware:SaleOrderItem:export")
    @Log(title = "订单商品明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(SaleOrderItemQuery query, HttpServletResponse response) {
        List<SaleOrderItemVo> list = saleOrderItemService.queryList(query);
        ExcelUtil.exportExcel(list, "订单商品明细", SaleOrderItemVo.class, response);
    }

    /**
     * 获取订单商品明细详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:SaleOrderItem:query", "kitchenware:SaleOrderItem:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<SaleOrderItemVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(saleOrderItemService.queryById(id));
    }

    /**
     * 新增订单商品明细
     */
    @SaCheckPermission("kitchenware:SaleOrderItem:add")
    @Log(title = "订单商品明细", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody SaleOrderItemBo bo) {
        return toAjax(saleOrderItemService.insertByBo(bo));
    }

    /**
     * 修改订单商品明细
     */
    @SaCheckPermission("kitchenware:SaleOrderItem:edit")
    @Log(title = "订单商品明细", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody SaleOrderItemBo bo) {
        return toAjax(saleOrderItemService.updateByBo(bo));
    }

    /**
     * 删除订单商品明细
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:SaleOrderItem:remove")
    @Log(title = "订单商品明细", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(saleOrderItemService.deleteWithValidByIds(List.of(ids)));
    }
}
