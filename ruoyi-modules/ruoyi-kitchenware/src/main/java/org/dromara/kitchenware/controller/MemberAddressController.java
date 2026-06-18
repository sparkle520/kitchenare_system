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
import org.dromara.kitchenware.domain.bo.MemberAddressBo;
import org.dromara.kitchenware.domain.query.MemberAddressQuery;
import org.dromara.kitchenware.domain.vo.MemberAddressVo;
import org.dromara.kitchenware.service.IMemberAddressService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 会员收货地址
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Validated
@RestController
@RequestMapping("/kitchenware/MemberAddress")
public class MemberAddressController extends BaseController {

    @Autowired
    private IMemberAddressService memberAddressService;

    /**
     * 查询会员收货地址列表
     */
    @SaCheckPermission("kitchenware:MemberAddress:list")
    @GetMapping("/list")
    public TableDataInfo<MemberAddressVo> list(MemberAddressQuery query) {
        return memberAddressService.queryPageList(query);
    }

    /**
     * 导出会员收货地址列表
     */
    @SaCheckPermission("kitchenware:MemberAddress:export")
    @Log(title = "会员收货地址", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(MemberAddressQuery query, HttpServletResponse response) {
        List<MemberAddressVo> list = memberAddressService.queryList(query);
        ExcelUtil.exportExcel(list, "会员收货地址", MemberAddressVo.class, response);
    }

    /**
     * 获取会员收货地址详细信息
     *
     * @param addressId 主键
     */
    @SaCheckPermission(value = {"kitchenware:MemberAddress:query", "kitchenware:MemberAddress:edit"}, mode = SaMode.OR)
    @GetMapping("/{addressId}")
    public R<MemberAddressVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long addressId) {
        return R.ok(memberAddressService.queryById(addressId));
    }

    /**
     * 新增会员收货地址
     */
    @SaCheckPermission("kitchenware:MemberAddress:add")
    @Log(title = "会员收货地址", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody MemberAddressBo bo) {
        return toAjax(memberAddressService.insertByBo(bo));
    }

    /**
     * 修改会员收货地址
     */
    @SaCheckPermission("kitchenware:MemberAddress:edit")
    @Log(title = "会员收货地址", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody MemberAddressBo bo) {
        return toAjax(memberAddressService.updateByBo(bo));
    }

    /**
     * 删除会员收货地址
     *
     * @param addressIds 主键串
     */
    @SaCheckPermission("kitchenware:MemberAddress:remove")
    @Log(title = "会员收货地址", businessType = BusinessType.DELETE)
    @DeleteMapping("/{addressIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] addressIds) {
        return toAjax(memberAddressService.deleteWithValidByIds(List.of(addressIds)));
    }
}
