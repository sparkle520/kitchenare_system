package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.CouponUser;
import org.dromara.kitchenware.domain.bo.CouponUserBo;
import org.dromara.kitchenware.domain.query.CouponUserQuery;
import org.dromara.kitchenware.domain.vo.CouponUserVo;
import org.dromara.kitchenware.mapper.CouponUserMapper;
import org.dromara.kitchenware.service.ICouponUserService;

import java.util.Collection;
import java.util.List;

/**
 * 个人优惠券Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-18
 */
@Service
public class CouponUserServiceImpl extends ServiceImpl<CouponUserMapper, CouponUser> implements ICouponUserService {

    /**
     * 查询个人优惠券
     *
     * @param id 主键
     * @return CouponUserVo
     */
    @Override
    public CouponUserVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询个人优惠券列表
     *
     * @param query 查询对象
     * @return 个人优惠券分页列表
     */
    @Override
    public TableDataInfo<CouponUserVo> queryPageList(CouponUserQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询个人优惠券列表
     *
     * @param query 查询对象
     * @return 个人优惠券列表
     */
    @Override
    public List<CouponUserVo> queryList(CouponUserQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增个人优惠券
     *
     * @param bo 个人优惠券新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(CouponUserBo bo) {
        CouponUser add = MapstructUtils.convert(bo, CouponUser.class);
        return save(add);
    }

    /**
     * 修改个人优惠券
     *
     * @param bo 个人优惠券编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(CouponUserBo bo) {
        CouponUser update = MapstructUtils.convert(bo, CouponUser.class);
        return updateById(update);
    }

    /**
     * 批量删除个人优惠券信息
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
