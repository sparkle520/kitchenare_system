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
import org.dromara.kitchenware.domain.bo.StockRecordBo;
import org.dromara.kitchenware.domain.query.StockRecordQuery;
import org.dromara.kitchenware.domain.vo.StockRecordVo;
import org.dromara.kitchenware.service.IStockRecordService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 库存变更流水
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Validated
@RestController
@RequestMapping("/kitchenware/StockRecord")
public class StockRecordController extends BaseController {

    @Autowired
    private IStockRecordService stockRecordService;

    /**
     * 查询库存变更流水列表
     */
    @SaCheckPermission("kitchenware:StockRecord:list")
    @GetMapping("/list")
    public TableDataInfo<StockRecordVo> list(StockRecordQuery query) {
        return stockRecordService.queryPageList(query);
    }

    /**
     * 导出库存变更流水列表
     */
    @SaCheckPermission("kitchenware:StockRecord:export")
    @Log(title = "库存变更流水", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(StockRecordQuery query, HttpServletResponse response) {
        List<StockRecordVo> list = stockRecordService.queryList(query);
        ExcelUtil.exportExcel(list, "库存变更流水", StockRecordVo.class, response);
    }

    /**
     * 获取库存变更流水详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:StockRecord:query", "kitchenware:StockRecord:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<StockRecordVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(stockRecordService.queryById(id));
    }

    /**
     * 新增库存变更流水
     */
    @SaCheckPermission("kitchenware:StockRecord:add")
    @Log(title = "库存变更流水", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody StockRecordBo bo) {
        return toAjax(stockRecordService.insertByBo(bo));
    }

    /**
     * 修改库存变更流水
     */
    @SaCheckPermission("kitchenware:StockRecord:edit")
    @Log(title = "库存变更流水", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody StockRecordBo bo) {
        return toAjax(stockRecordService.updateByBo(bo));
    }

    /**
     * 删除库存变更流水
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:StockRecord:remove")
    @Log(title = "库存变更流水", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(stockRecordService.deleteWithValidByIds(List.of(ids)));
    }
}
