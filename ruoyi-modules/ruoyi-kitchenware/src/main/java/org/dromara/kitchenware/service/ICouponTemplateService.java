package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.CouponTemplate;
import org.dromara.kitchenware.domain.bo.CouponTemplateBo;
import org.dromara.kitchenware.domain.query.CouponTemplateQuery;
import org.dromara.kitchenware.domain.vo.CouponTemplateVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 优惠券模板Service接口
 *
 * @author sparkle520
 * @date 2026-06-17
 */
public interface ICouponTemplateService extends IService<CouponTemplate> {

    /**
     * 查询优惠券模板
     *
     * @param id 主键
     * @return CouponTemplateVo
     */
    CouponTemplateVo queryById(Long id);

    /**
     * 分页查询优惠券模板列表
     *
     * @param query 查询对象
     * @return 优惠券模板分页列表
     */
    TableDataInfo<CouponTemplateVo> queryPageList(CouponTemplateQuery query);

    /**
     * 查询优惠券模板列表
     *
     * @param query 查询对象
     * @return 优惠券模板列表
     */
    List<CouponTemplateVo> queryList(CouponTemplateQuery query);

    /**
     * 新增优惠券模板
     *
     * @param bo 优惠券模板新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(CouponTemplateBo bo);

    /**
     * 修改优惠券模板
     *
     * @param bo 优惠券模板编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(CouponTemplateBo bo);

    /**
     * 批量删除优惠券模板信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
