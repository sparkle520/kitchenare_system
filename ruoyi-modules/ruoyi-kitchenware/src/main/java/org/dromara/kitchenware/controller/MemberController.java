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
import org.dromara.kitchenware.domain.bo.MemberBo;
import org.dromara.kitchenware.domain.query.MemberQuery;
import org.dromara.kitchenware.domain.vo.MemberVo;
import org.dromara.kitchenware.service.IMemberService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 商城会员
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Validated
@RestController
@RequestMapping("/kitchenware/member")
public class MemberController extends BaseController {

    @Autowired
    private IMemberService memberService;

    /**
     * 查询商城会员列表
     */
    @SaCheckPermission("kitchenware:member:list")
    @GetMapping("/list")
    public TableDataInfo<MemberVo> list(MemberQuery query) {
        return memberService.queryPageList(query);
    }

    /**
     * 导出商城会员列表
     */
    @SaCheckPermission("kitchenware:member:export")
    @Log(title = "商城会员", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(MemberQuery query, HttpServletResponse response) {
        List<MemberVo> list = memberService.queryList(query);
        ExcelUtil.exportExcel(list, "商城会员", MemberVo.class, response);
    }

    /**
     * 获取商城会员详细信息
     *
     * @param memberId 主键
     */
    @SaCheckPermission(value = {"kitchenware:member:query", "kitchenware:member:edit"}, mode = SaMode.OR)
    @GetMapping("/{memberId}")
    public R<MemberVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long memberId) {
        return R.ok(memberService.queryById(memberId));
    }

    /**
     * 新增商城会员
     */
    @SaCheckPermission("kitchenware:member:add")
    @Log(title = "商城会员", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody MemberBo bo) {
        return toAjax(memberService.insertByBo(bo));
    }

    /**
     * 修改商城会员
     */
    @SaCheckPermission("kitchenware:member:edit")
    @Log(title = "商城会员", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody MemberBo bo) {
        return toAjax(memberService.updateByBo(bo));
    }

    /**
     * 删除商城会员
     *
     * @param memberIds 主键串
     */
    @SaCheckPermission("kitchenware:member:remove")
    @Log(title = "商城会员", businessType = BusinessType.DELETE)
    @DeleteMapping("/{memberIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] memberIds) {
        return toAjax(memberService.deleteWithValidByIds(List.of(memberIds)));
    }
}
