package org.dromara.kitchenware.service;

import org.dromara.kitchenware.domain.StockRecord;
import org.dromara.kitchenware.domain.bo.StockRecordBo;
import org.dromara.kitchenware.domain.query.StockRecordQuery;
import org.dromara.kitchenware.domain.vo.StockRecordVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.dromara.common.mybatis.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 库存变更流水Service接口
 *
 * @author sparkle520
 * @date 2026-06-16
 */
public interface IStockRecordService extends IService<StockRecord> {

    /**
     * 查询库存变更流水
     *
     * @param id 主键
     * @return StockRecordVo
     */
    StockRecordVo queryById(Long id);

    /**
     * 分页查询库存变更流水列表
     *
     * @param query 查询对象
     * @return 库存变更流水分页列表
     */
    TableDataInfo<StockRecordVo> queryPageList(StockRecordQuery query);

    /**
     * 查询库存变更流水列表
     *
     * @param query 查询对象
     * @return 库存变更流水列表
     */
    List<StockRecordVo> queryList(StockRecordQuery query);

    /**
     * 新增库存变更流水
     *
     * @param bo 库存变更流水新增业务对象
     * @return 是否新增成功
     */
    Boolean insertByBo(StockRecordBo bo);

    /**
     * 修改库存变更流水
     *
     * @param bo 库存变更流水编辑业务对象
     * @return 是否修改成功
     */
    Boolean updateByBo(StockRecordBo bo);

    /**
     * 批量删除库存变更流水信息
     *
     * @param ids 待删除的主键集合
     * @return 是否删除成功
     */
    Boolean deleteWithValidByIds(Collection<Long> ids);
}
