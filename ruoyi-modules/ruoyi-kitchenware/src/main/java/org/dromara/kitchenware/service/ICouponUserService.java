package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.CouponUser;
import org.dromara.kitchenware.domain.bo.CouponUserBo;
import org.dromara.kitchenware.domain.query.CouponUserQuery;
import org.dromara.kitchenware.domain.vo.CouponUserVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 个人优惠券Service接口
 *
 * @author sparkle520
 * @date 2026-06-18
 */
public interface ICouponUserService extends IService<CouponUser> {

    /**
     * 查询个人优惠券
     *
     * @param id 主键
     * @return CouponUserVo
     */
    CouponUserVo queryById(Long id);

    /**
     * 分页查询个人优惠券列表
     *
     * @param query 查询对象
     * @return 个人优惠券分页列表
     */
    TableDataInfo<CouponUserVo> queryPageList(CouponUserQuery query);

    /**
     * 查询个人优惠券列表
     *
     * @param query 查询对象
     * @return 个人优惠券列表
     */
    List<CouponUserVo> queryList(CouponUserQuery query);

    /**
     * 新增个人优惠券
     *
     * @param bo 个人优惠券新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(CouponUserBo bo);

    /**
     * 修改个人优惠券
     *
     * @param bo 个人优惠券编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(CouponUserBo bo);

    /**
     * 批量删除个人优惠券信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
