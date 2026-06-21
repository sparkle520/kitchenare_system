package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.MemberAddress;
import org.dromara.kitchenware.domain.bo.MemberAddressBo;
import org.dromara.kitchenware.domain.query.MemberAddressQuery;
import org.dromara.kitchenware.domain.vo.MemberAddressVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 会员收货地址Service接口
 *
 * @author sparkle520
 * @date 2026-06-17
 */
public interface IMemberAddressService extends IService<MemberAddress> {

    /**
     * 查询会员收货地址
     *
     * @param addressId 主键
     * @return MemberAddressVo
     */
    MemberAddressVo queryById(Long addressId);

    /**
     * 分页查询会员收货地址列表
     *
     * @param query 查询对象
     * @return 会员收货地址分页列表
     */
    TableDataInfo<MemberAddressVo> queryPageList(MemberAddressQuery query);

    /**
     * 查询会员收货地址列表
     *
     * @param query 查询对象
     * @return 会员收货地址列表
     */
    List<MemberAddressVo> queryList(MemberAddressQuery query);

    /**
     * 新增会员收货地址
     *
     * @param bo 会员收货地址新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(MemberAddressBo bo);

    /**
     * 修改会员收货地址
     *
     * @param bo 会员收货地址编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(MemberAddressBo bo);

    /**
     * 批量删除会员收货地址信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);

    /**
     * 根据会员ID查询收货地址列表
     *
     * @param memberId 会员ID
     * @return 收货地址列表
     */
    List<MemberAddressVo> queryByMemberId(Long memberId);

    /**
     * 获取会员默认收货地址
     *
     * @param memberId 会员ID
     * @return 默认收货地址
     */
    MemberAddressVo getDefaultAddress(Long memberId);

    /**
     * 设置默认收货地址
     *
     * @param addressId 地址ID
     * @param memberId 会员ID
     * @return 是否成功
     */
    Boolean setDefaultAddress(Long addressId, Long memberId);
}
