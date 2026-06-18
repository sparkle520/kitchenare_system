package org.dromara.kitchenware.service.impl;

import org.dromara.common.core.utils.MapstructUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.dromara.common.mybatis.core.page.TableDataInfo;
import org.dromara.common.mybatis.core.page.PageQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.dromara.kitchenware.domain.StockRecord;
import org.dromara.kitchenware.domain.bo.StockRecordBo;
import org.dromara.kitchenware.domain.query.StockRecordQuery;
import org.dromara.kitchenware.domain.vo.StockRecordVo;
import org.dromara.kitchenware.mapper.StockRecordMapper;
import org.dromara.kitchenware.service.IStockRecordService;

import java.util.Collection;
import java.util.List;

/**
 * 库存变更流水Service业务层处理
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Service
public class StockRecordServiceImpl extends ServiceImpl<StockRecordMapper, StockRecord> implements IStockRecordService {

    /**
     * 查询库存变更流水
     *
     * @param id 主键
     * @return StockRecordVo
     */
    @Override
    public StockRecordVo queryById(Long id) {
        return baseMapper.selectVoById(id);
    }

    /**
     * 分页查询库存变更流水列表
     *
     * @param query 查询对象
     * @return 库存变更流水分页列表
     */
    @Override
    public TableDataInfo<StockRecordVo> queryPageList(StockRecordQuery query) {
        return PageQuery.of(() -> baseMapper.queryList(query));
    }

    /**
     * 查询库存变更流水列表
     *
     * @param query 查询对象
     * @return 库存变更流水列表
     */
    @Override
    public List<StockRecordVo> queryList(StockRecordQuery query) {
        return baseMapper.queryList(query);
    }

    /**
     * 新增库存变更流水
     *
     * @param bo 库存变更流水新增业务对象
     * @return 是否新增成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertByBo(StockRecordBo bo) {
        StockRecord add = MapstructUtils.convert(bo, StockRecord.class);
        return save(add);
    }

    /**
     * 修改库存变更流水
     *
     * @param bo 库存变更流水编辑业务对象
     * @return 是否修改成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateByBo(StockRecordBo bo) {
        StockRecord update = MapstructUtils.convert(bo, StockRecord.class);
        return updateById(update);
    }

    /**
     * 批量删除库存变更流水信息
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
