package org.dromara.kitchenware.service.impl;

import cn.hutool.crypto.digest.BCrypt;
import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.Member;
import org.dromara.kitchenware.domain.bo.MemberBo;
import org.dromara.kitchenware.domain.query.MemberQuery;
import org.dromara.kitchenware.domain.vo.MemberVo;
import org.dromara.kitchenware.mapper.MemberMapper;
import org.dromara.kitchenware.service.IMemberService;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * 商城会员Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-17
 */
@Service
public class MemberServiceImpl extends ServiceImpl<MemberMapper, Member> implements IMemberService {

    /**
     * 查询商城会员
     *
     * @param memberId 主键
     * @return MemberVo
     */
    @Override
    public MemberVo queryById(Long memberId) {
        return baseMapper.selectVoById(memberId);
    }

    /**
     * 分页查询商城会员列表
     *
     * @param query 查询对象
     * @return 商城会员分页列表
     */
    @Override
    public TableDataInfo<MemberVo> queryPageList(MemberQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询商城会员列表
     *
     * @param query 查询对象
     * @return 商城会员列表
     */
    @Override
    public List<MemberVo> queryList(MemberQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增商城会员
     *
     * @param bo 商城会员新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(MemberBo bo) {
        Member add = MapstructUtils.convert(bo, Member.class);
        // 密码加密
        if (add.getPassword() != null && !add.getPassword().isEmpty()) {
            add.setPassword(BCrypt.hashpw(add.getPassword()));
        }
        return save(add);
    }

    /**
     * 修改商城会员
     *
     * @param bo 商城会员编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(MemberBo bo) {
        Member update = MapstructUtils.convert(bo, Member.class);
        // 如果密码有更新，进行加密
        if (update.getPassword() != null && !update.getPassword().isEmpty()) {
            update.setPassword(BCrypt.hashpw(update.getPassword()));
        }
        return updateById(update);
    }

    /**
     * 批量删除商城会员信息
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
     * 根据手机号查询会员
     *
     * @param mobile 手机号
     * @return MemberVo
     */
    @Override
    public MemberVo queryByMobile(String mobile) {
        return baseMapper.selectByMobile(mobile);
    }

    /**
     * 更新会员最后登录时间
     *
     * @param memberId 会员ID
     * @return 是否更新成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateLastLoginTime(Long memberId) {
        Member member = new Member();
        member.setMemberId(memberId);
        member.setLastLoginTime(new Date());
        return updateById(member);
    }

    /**
     * 会员注册
     *
     * @param mobile   手机号
     * @param password 密码
     * @param nickname 昵称
     * @return 是否注册成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean registerMember(String mobile, String password, String nickname) {
        // 检查手机号是否已注册
        MemberVo existingMember = baseMapper.selectByMobile(mobile);
        if (existingMember != null) {
            throw new RuntimeException("该手机号已被注册");
        }

        // 创建会员对象
        Member member = new Member();
        member.setMobile(mobile);
        member.setPassword(BCrypt.hashpw(password)); // 使用BCrypt加密密码
        member.setNickname(nickname != null && !nickname.isEmpty() ? nickname : mobile.substring(0, 3) + "****" + mobile.substring(7));
        member.setBalance(BigDecimal.valueOf(0.0));
        member.setPoint(0);
        member.setStatus("0"); // 0-正常

        return save(member);
    }

    /**
     * 校验密码
     *
     * @param rawPassword     明文密码
     * @param encodedPassword 加密后的密码
     * @return 是否匹配
     */
    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return BCrypt.checkpw(rawPassword, encodedPassword);
    }
}
