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
import org.dromara.kitchenware.domain.bo.CouponTemplateBo;
import org.dromara.kitchenware.domain.query.CouponTemplateQuery;
import org.dromara.kitchenware.domain.vo.CouponTemplateVo;
import org.dromara.kitchenware.service.ICouponTemplateService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 优惠券模板
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Validated
@RestController
@RequestMapping("/kitchenware/CouponTemplate")
public class CouponTemplateController extends BaseController {

    @Autowired
    private ICouponTemplateService couponTemplateService;

    /**
     * 查询优惠券模板列表
     */
    @SaCheckPermission("kitchenware:CouponTemplate:list")
    @GetMapping("/list")
    public TableDataInfo<CouponTemplateVo> list(CouponTemplateQuery query) {
        return couponTemplateService.queryPageList(query);
    }

    /**
     * 导出优惠券模板列表
     */
    @SaCheckPermission("kitchenware:CouponTemplate:export")
    @Log(title = "优惠券模板", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CouponTemplateQuery query, HttpServletResponse response) {
        List<CouponTemplateVo> list = couponTemplateService.queryList(query);
        ExcelUtil.exportExcel(list, "优惠券模板", CouponTemplateVo.class, response);
    }

    /**
     * 获取优惠券模板详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:CouponTemplate:query", "kitchenware:CouponTemplate:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<CouponTemplateVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(couponTemplateService.queryById(id));
    }

    /**
     * 新增优惠券模板
     */
    @SaCheckPermission("kitchenware:CouponTemplate:add")
    @Log(title = "优惠券模板", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody CouponTemplateBo bo) {
        return toAjax(couponTemplateService.insertByBo(bo));
    }

    /**
     * 修改优惠券模板
     */
    @SaCheckPermission("kitchenware:CouponTemplate:edit")
    @Log(title = "优惠券模板", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody CouponTemplateBo bo) {
        return toAjax(couponTemplateService.updateByBo(bo));
    }

    /**
     * 删除优惠券模板
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:CouponTemplate:remove")
    @Log(title = "优惠券模板", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(couponTemplateService.deleteWithValidByIds(List.of(ids)));
    }
}
