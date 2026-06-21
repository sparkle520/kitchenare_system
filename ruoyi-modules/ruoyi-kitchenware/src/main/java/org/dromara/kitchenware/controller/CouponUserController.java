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
import org.dromara.kitchenware.domain.bo.CouponUserBo;
import org.dromara.kitchenware.domain.query.CouponUserQuery;
import org.dromara.kitchenware.domain.vo.CouponUserVo;
import org.dromara.kitchenware.service.ICouponUserService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 个人优惠券
 *
 * @author sparkle520
 * @date 2026-06-18
 */
@Validated
@RestController
@RequestMapping("/kitchenware/CouponUser")
public class CouponUserController extends BaseController {

    @Autowired
    private ICouponUserService couponUserService;

    /**
     * 查询个人优惠券列表
     */
    @SaCheckPermission("kitchenware:CouponUser:list")
    @GetMapping("/list")
    public TableDataInfo<CouponUserVo> list(CouponUserQuery query) {
        return couponUserService.queryPageList(query);
    }

    /**
     * 导出个人优惠券列表
     */
    @SaCheckPermission("kitchenware:CouponUser:export")
    @Log(title = "个人优惠券", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(CouponUserQuery query, HttpServletResponse response) {
        List<CouponUserVo> list = couponUserService.queryList(query);
        ExcelUtil.exportExcel(list, "个人优惠券", CouponUserVo.class, response);
    }

    /**
     * 获取个人优惠券详细信息
     *
     * @param id 主键
     */
    @SaCheckPermission(value = {"kitchenware:CouponUser:query", "kitchenware:CouponUser:edit"}, mode = SaMode.OR)
    @GetMapping("/{id}")
    public R<CouponUserVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(couponUserService.queryById(id));
    }

    /**
     * 新增个人优惠券
     */
    @SaCheckPermission("kitchenware:CouponUser:add")
    @Log(title = "个人优惠券", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody CouponUserBo bo) {
        return toAjax(couponUserService.insertByBo(bo));
    }

    /**
     * 修改个人优惠券
     */
    @SaCheckPermission("kitchenware:CouponUser:edit")
    @Log(title = "个人优惠券", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody CouponUserBo bo) {
        return toAjax(couponUserService.updateByBo(bo));
    }

    /**
     * 删除个人优惠券
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:CouponUser:remove")
    @Log(title = "个人优惠券", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(couponUserService.deleteWithValidByIds(List.of(ids)));
    }
}
