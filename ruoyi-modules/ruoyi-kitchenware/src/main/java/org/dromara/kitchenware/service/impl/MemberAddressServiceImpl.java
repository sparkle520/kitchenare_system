package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.MemberAddress;
import org.dromara.kitchenware.domain.bo.MemberAddressBo;
import org.dromara.kitchenware.domain.query.MemberAddressQuery;
import org.dromara.kitchenware.domain.vo.MemberAddressVo;
import org.dromara.kitchenware.mapper.MemberAddressMapper;
import org.dromara.kitchenware.service.IMemberAddressService;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.Collection;
import java.util.List;

/**
 * 会员收货地址Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Service
public class MemberAddressServiceImpl extends ServiceImpl<MemberAddressMapper, MemberAddress> implements IMemberAddressService {

    /**
     * 查询会员收货地址
     *
     * @param addressId 主键
     * @return MemberAddressVo
     */
    @Override
    public MemberAddressVo queryById(Long addressId) {
        return baseMapper.selectVoById(addressId);
    }

    /**
     * 分页查询会员收货地址列表
     *
     * @param query 查询对象
     * @return 会员收货地址分页列表
     */
    @Override
    public TableDataInfo<MemberAddressVo> queryPageList(MemberAddressQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询会员收货地址列表
     *
     * @param query 查询对象
     * @return 会员收货地址列表
     */
    @Override
    public List<MemberAddressVo> queryList(MemberAddressQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增会员收货地址
     *
     * @param bo 会员收货地址新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(MemberAddressBo bo) {
        MemberAddress add = MapstructUtils.convert(bo, MemberAddress.class);
        return save(add);
    }

    /**
     * 修改会员收货地址
     *
     * @param bo 会员收货地址编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(MemberAddressBo bo) {
        MemberAddress update = MapstructUtils.convert(bo, MemberAddress.class);
        return updateById(update);
    }

    /**
     * 批量删除会员收货地址信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        return removeByIds(ids);
    }

    /**
     * 根据会员ID查询收货地址列表
     */
    @Override
    public List<MemberAddressVo> queryByMemberId(Long memberId) {
        MemberAddressQuery query = new MemberAddressQuery();
        query.setMemberId(memberId);
        return baseMapper.queryList(query);
    }

    /**
     * 获取会员默认收货地址
     */
    @Override
    public MemberAddressVo getDefaultAddress(Long memberId) {
        List<MemberAddressVo> list = queryByMemberId(memberId);
        return list.stream()
            .filter(addr -> "1".equals(addr.getIsDefault()))
            .findFirst()
            .orElse(list.isEmpty() ? null : list.get(0));
    }

    /**
     * 设置默认收货地址
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean setDefaultAddress(Long addressId, Long memberId) {
        // 先将所有地址设为非默认
        MemberAddress reset = new MemberAddress();
        reset.setMemberId(memberId);
        reset.setIsDefault("0");
        this.update(reset, new LambdaQueryWrapper<MemberAddress>().eq(MemberAddress::getMemberId, memberId));
        // 设置指定地址为默认
        MemberAddress address = new MemberAddress();
        address.setAddressId(addressId);
        address.setIsDefault("1");
        return updateById(address);
    }
}
