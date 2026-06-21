package org.dromara.kitchenware.controller;

import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.*;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaIgnore;
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
import org.dromara.kitchenware.domain.bo.GoodsSkuBo;
import org.dromara.kitchenware.domain.query.GoodsSkuQuery;
import org.dromara.kitchenware.domain.vo.GoodsSkuVo;
import org.dromara.kitchenware.service.IGoodsSkuService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

/**
 * 商品规格SKU
 *
 * @author sparkle520
 * @date 2026-06-15
 */
@Validated
@RestController
@RequestMapping("/kitchenware/goods_sku")
public class GoodsSkuController extends BaseController {

    @Autowired
    private IGoodsSkuService goodsSkuService;

    /**
     * 查询商品规格SKU列表
     */
    @SaIgnore
    @GetMapping("/list")
    public TableDataInfo<GoodsSkuVo> list(GoodsSkuQuery query) {
        return goodsSkuService.queryPageList(query);
    }

    /**
     * 导出商品规格SKU列表
     */
    @SaCheckPermission("kitchenware:goods_sku:export")
    @Log(title = "商品规格SKU", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(GoodsSkuQuery query, HttpServletResponse response) {
        List<GoodsSkuVo> list = goodsSkuService.queryList(query);
        ExcelUtil.exportExcel(list, "商品规格SKU", GoodsSkuVo.class, response);
    }

    /**
     * 获取商品规格SKU详细信息
     *
     * @param id 主键
     */
    @SaIgnore
    @GetMapping("/{id}")
    public R<GoodsSkuVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long id) {
        return R.ok(goodsSkuService.queryById(id));
    }

    /**
     * 新增商品规格SKU
     */
    @SaCheckPermission("kitchenware:goods_sku:add")
    @Log(title = "商品规格SKU", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody GoodsSkuBo bo) {
        return toAjax(goodsSkuService.insertByBo(bo));
    }

    /**
     * 修改商品规格SKU
     */
    @SaCheckPermission("kitchenware:goods_sku:edit")
    @Log(title = "商品规格SKU", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody GoodsSkuBo bo) {
        return toAjax(goodsSkuService.updateByBo(bo));
    }

    /**
     * 删除商品规格SKU
     *
     * @param ids 主键串
     */
    @SaCheckPermission("kitchenware:goods_sku:remove")
    @Log(title = "商品规格SKU", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] ids) {
        return toAjax(goodsSkuService.deleteWithValidByIds(List.of(ids)));
    }
}
