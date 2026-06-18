package org.dromara.kitchenware.service.impl;

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

import java.util.Collection;
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
}
