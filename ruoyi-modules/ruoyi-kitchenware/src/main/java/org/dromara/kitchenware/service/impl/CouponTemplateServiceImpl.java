package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.CouponTemplate;
import org.dromara.kitchenware.domain.bo.CouponTemplateBo;
import org.dromara.kitchenware.domain.query.CouponTemplateQuery;
import org.dromara.kitchenware.domain.vo.CouponTemplateVo;
import org.dromara.kitchenware.mapper.CouponTemplateMapper;
import org.dromara.kitchenware.service.ICouponTemplateService;

import java.util.Collection;
import java.util.List;

/**
 * 优惠券模板Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Service
public class CouponTemplateServiceImpl extends ServiceImpl<CouponTemplateMapper, CouponTemplate> implements ICouponTemplateService {

    /**
     * 查询优惠券模板
     *
     * @param id 主键
     * @return CouponTemplateVo
     */
    @Override
    public CouponTemplateVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询优惠券模板列表
     *
     * @param query 查询对象
     * @return 优惠券模板分页列表
     */
    @Override
    public TableDataInfo<CouponTemplateVo> queryPageList(CouponTemplateQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询优惠券模板列表
     *
     * @param query 查询对象
     * @return 优惠券模板列表
     */
    @Override
    public List<CouponTemplateVo> queryList(CouponTemplateQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增优惠券模板
     *
     * @param bo 优惠券模板新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(CouponTemplateBo bo) {
        CouponTemplate add = MapstructUtils.convert(bo, CouponTemplate.class);
        return save(add);
    }

    /**
     * 修改优惠券模板
     *
     * @param bo 优惠券模板编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(CouponTemplateBo bo) {
        CouponTemplate update = MapstructUtils.convert(bo, CouponTemplate.class);
        return updateById(update);
    }

    /**
     * 批量删除优惠券模板信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        return removeByIds(ids);
    }
}
