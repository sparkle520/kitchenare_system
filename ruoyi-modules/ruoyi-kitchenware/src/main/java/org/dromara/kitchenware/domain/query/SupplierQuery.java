package org.dromara.kitchenware.domain.query;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.dromara.common.mybatis.core.domain.BasePageQuery;

/**
 * 供货供应商查询对象 supplier
 *
 * @author sparkle520
 * @date 2026-06-16
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SupplierQuery extends BasePageQuery {

    /**
     * 厂商名称
     */
    private String supplierName;

    /**
     * 对接联系人
     */
    private String contact;

    /**
     * 联系电话
     */
    private String phone;

    /**
     * 厂商地址
     */
    private String address;

}
