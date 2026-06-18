package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.Member;
import org.dromara.kitchenware.domain.bo.MemberBo;
import org.dromara.kitchenware.domain.query.MemberQuery;
import org.dromara.kitchenware.domain.vo.MemberVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 商城会员Service接口
 *
 * @author sparkle520
 * @date 2026-06-17
 */
public interface IMemberService extends IService<Member> {

    /**
     * 查询商城会员
     *
     * @param memberId 主键
     * @return MemberVo
     */
    MemberVo queryById(Long memberId);

    /**
     * 分页查询商城会员列表
     *
     * @param query 查询对象
     * @return 商城会员分页列表
     */
    TableDataInfo<MemberVo> queryPageList(MemberQuery query);

    /**
     * 查询商城会员列表
     *
     * @param query 查询对象
     * @return 商城会员列表
     */
    List<MemberVo> queryList(MemberQuery query);

    /**
     * 新增商城会员
     *
     * @param bo 商城会员新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(MemberBo bo);

    /**
     * 修改商城会员
     *
     * @param bo 商城会员编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(MemberBo bo);

    /**
     * 批量删除商城会员信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);

    /**
     * 根据手机号查询会员
     *
     * @param mobile 手机号
     * @return MemberVo
     */
    MemberVo queryByMobile(String mobile);

    /**
     * 更新会员最后登录时间
     *
     * @param memberId 会员ID
     * @return 是否更新成功
     */
    Boolean updateLastLoginTime(Long memberId);

    /**
     * 会员注册
     *
     * @param mobile   手机号
     * @param password 密码
     * @param nickname 昵称
     * @return 是否注册成功
     */
    Boolean registerMember(String mobile, String password, String nickname);
}
