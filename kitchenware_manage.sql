/*
 Navicat Premium Dump SQL

 Source Server         : sparkle520
 Source Server Type    : MySQL
 Source Server Version : 80038 (8.0.38)
 Source Host           : localhost:3306
 Source Schema         : kitchenware_manage

 Target Server Type    : MySQL
 Target Server Version : 80038 (8.0.38)
 File Encoding         : 65001

 Date: 18/06/2026 15:00:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for after_sale
-- ----------------------------
DROP TABLE IF EXISTS `after_sale`;
CREATE TABLE `after_sale`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '售后单主键',
  `order_id` bigint NOT NULL COMMENT '关联订单ID',
  `member_id` bigint NOT NULL COMMENT '申请买家',
  `item_id` bigint NULL DEFAULT NULL COMMENT '单个商品明细ID，整单售后为null',
  `sale_type` tinyint NOT NULL COMMENT '1仅退款 2退货退款',
  `refund_money` decimal(12, 2) NOT NULL COMMENT '申请退款金额',
  `reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '售后原因',
  `img_urls` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '凭证图片多逗号分隔',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '1待审核 2同意退货 3退款完成 4驳回',
  `return_express` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户寄回快递单号',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '退款到账时间',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '售后退款' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of after_sale
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_template
-- ----------------------------
DROP TABLE IF EXISTS `coupon_template`;
CREATE TABLE `coupon_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '券模板ID',
  `coupon_type` tinyint NOT NULL COMMENT '1无门槛 2满减券',
  `denomination` decimal(10, 2) NOT NULL COMMENT '抵扣金额',
  `full_money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '满减门槛 0=无门槛',
  `total_count` int NOT NULL DEFAULT 0 COMMENT '总发放数量',
  `receive_count` int NOT NULL DEFAULT 0 COMMENT '已领取数量',
  `valid_days` int NOT NULL DEFAULT 7 COMMENT '领取后有效天数',
  `start_time` datetime NOT NULL COMMENT '发放开始时间',
  `end_time` datetime NOT NULL COMMENT '发放结束时间',
  `scope_type` tinyint NOT NULL DEFAULT 1 COMMENT '1全品类 2指定分类 3指定商品',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '1启用 0关闭',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_template
-- ----------------------------
INSERT INTO `coupon_template` VALUES (1, 1, 10.00, 0.00, 10, 0, 4, '2026-06-18 00:00:00', '2026-06-20 00:00:00', 1, 1, 1, '2026-06-17 19:53:25', 1, '2026-06-17 19:53:25', '0');

-- ----------------------------
-- Table structure for coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `coupon_user`;
CREATE TABLE `coupon_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户券主键',
  `template_id` bigint NOT NULL COMMENT '所属模板',
  `member_id` bigint NOT NULL COMMENT '持有买家',
  `receive_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
  `valid_end` datetime NOT NULL COMMENT '过期时间',
  `use_order_id` bigint NULL DEFAULT NULL COMMENT '核销订单ID',
  `use_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `coupon_status` tinyint NOT NULL DEFAULT 1 COMMENT '1未使用 2已使用 3已过期',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_mem_status`(`member_id` ASC, `coupon_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '个人优惠券' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_user
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL COMMENT '编号',
  `data_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '数据源名称',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (2066472078095331329, 'master', 'after_sale', '售后退款', 'AfterSale', 'crud', 'org.dromara.system', 'system', 'sale', '售后退款', 'yixiacoco', '0', '/', NULL, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11', NULL);
INSERT INTO `gen_table` VALUES (2066472078552510465, 'master', 'coupon_template', '优惠券模板', 'CouponTemplate', 'crud', 'org.dromara.kitchenware', 'kitchenware', 'CouponTemplate', '优惠券模板', 'sparkle520', '0', '/', '{\"treeCode\":null,\"treeParentCode\":null,\"treeName\":null,\"parentMenuId\":\"2066474865592020993\",\"isUseQuery\":true,\"isUseBO\":true,\"isUseVO\":true,\"isUseController\":true,\"isUseVue\":true,\"isUseSql\":true,\"menuIcon\":\"#\",\"isUseAddMethod\":true,\"isUseEditMethod\":true,\"isUseRemoveMethod\":true,\"isUseImportMethod\":false,\"isUseExportMethod\":true,\"isUseDetailMethod\":true,\"isUseQueryMethod\":true}', NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58', NULL);
INSERT INTO `gen_table` VALUES (2066472078804168706, 'master', 'coupon_user', '个人优惠券', 'CouponUser', 'crud', 'org.dromara.system', 'system', 'user', '个人优惠券', 'yixiacoco', '0', '/', NULL, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11', NULL);
INSERT INTO `gen_table` VALUES (2066472079827578882, 'master', 'sale_order', 'C端购物订单', 'SaleOrder', 'crud', 'org.dromara.system', 'system', 'order', 'C端购物订单', 'yixiacoco', '0', '/', NULL, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12', NULL);
INSERT INTO `gen_table` VALUES (2066472080016322562, 'master', 'sale_order_item', '订单商品明细', 'SaleOrderItem', 'crud', 'org.dromara.system', 'system', 'orderItem', '订单商品明细', 'yixiacoco', '0', '/', NULL, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12', NULL);
INSERT INTO `gen_table` VALUES (2067228174556794882, 'master', 'member_address', '会员收货地址表', 'MemberAddress', 'crud', 'org.dromara.kitchenware', 'kitchenware', 'MemberAddress', '会员收货地址', 'sparkle520', '0', '/', '{\"treeCode\":null,\"treeParentCode\":null,\"treeName\":null,\"parentMenuId\":\"2066474865592020993\",\"isUseQuery\":true,\"isUseBO\":true,\"isUseVO\":true,\"isUseController\":true,\"isUseVue\":true,\"isUseSql\":true,\"menuIcon\":\"#\",\"isUseAddMethod\":true,\"isUseEditMethod\":true,\"isUseRemoveMethod\":true,\"isUseImportMethod\":false,\"isUseExportMethod\":true,\"isUseDetailMethod\":true,\"isUseQueryMethod\":true}', NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `is_detail` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否详情字段（1是）',
  `is_sort` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否排序字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (2066472078422487042, 2066472078095331329, 'id', '售后单主键', 'bigint', 'Long', 'id', '1', '1', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 1, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078422487043, 2066472078095331329, 'order_id', '关联订单ID', 'bigint', 'Long', 'orderId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 2, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078422487044, 2066472078095331329, 'member_id', '申请买家', 'bigint', 'Long', 'memberId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 3, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595905, 2066472078095331329, 'item_id', '单个商品明细ID，整单售后为null', 'bigint', 'Long', 'itemId', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 4, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595906, 2066472078095331329, 'sale_type', '1仅退款 2退货退款', 'tinyint', 'Integer', 'saleType', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'select', '', 5, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595907, 2066472078095331329, 'refund_money', '申请退款金额', 'decimal(12,2)', 'BigDecimal', 'refundMoney', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 6, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595908, 2066472078095331329, 'reason', '售后原因', 'varchar(300)', 'String', 'reason', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 7, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595909, 2066472078095331329, 'img_urls', '凭证图片多逗号分隔', 'varchar(1000)', 'String', 'imgUrls', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 8, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595910, 2066472078095331329, 'status', '1待审核 2同意退货 3退款完成 4驳回', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'radio', '', 9, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595911, 2066472078095331329, 'return_express', '用户寄回快递单号', 'varchar(50)', 'String', 'returnExpress', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 10, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595912, 2066472078095331329, 'audit_time', '审核时间', 'datetime', 'Date', 'auditTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 11, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595913, 2066472078095331329, 'refund_time', '退款到账时间', 'datetime', 'Date', 'refundTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 12, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595914, 2066472078095331329, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 13, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595915, 2066472078095331329, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 14, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595916, 2066472078095331329, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 15, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595917, 2066472078095331329, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 16, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078489595918, 2066472078095331329, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 17, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078741254145, 2066472078552510465, 'id', '券模板ID', 'bigint', 'Long', 'id', '1', '1', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 1, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254146, 2066472078552510465, 'coupon_type', '1无门槛 2满减券', 'tinyint', 'Integer', 'couponType', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'select', '', 2, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254147, 2066472078552510465, 'denomination', '抵扣金额', 'decimal(10,2)', 'BigDecimal', 'denomination', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 3, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254148, 2066472078552510465, 'full_money', '满减门槛 0=无门槛', 'decimal(10,2)', 'BigDecimal', 'fullMoney', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 4, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254149, 2066472078552510465, 'total_count', '总发放数量', 'int', 'Integer', 'totalCount', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 5, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254150, 2066472078552510465, 'receive_count', '已领取数量', 'int', 'Integer', 'receiveCount', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 6, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254151, 2066472078552510465, 'valid_days', '领取后有效天数', 'int', 'Integer', 'validDays', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 7, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254152, 2066472078552510465, 'start_time', '发放开始时间', 'datetime', 'Date', 'startTime', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 8, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254153, 2066472078552510465, 'end_time', '发放结束时间', 'datetime', 'Date', 'endTime', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 9, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254154, 2066472078552510465, 'scope_type', '1全品类 2指定分类 3指定商品', 'tinyint', 'Integer', 'scopeType', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'select', '', 10, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254155, 2066472078552510465, 'status', '1启用 0关闭', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'radio', '', 11, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254156, 2066472078552510465, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 12, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254157, 2066472078552510465, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 13, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254158, 2066472078552510465, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 14, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254159, 2066472078552510465, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 15, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078741254160, 2066472078552510465, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 16, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-17 16:26:58');
INSERT INTO `gen_table_column` VALUES (2066472078934192129, 2066472078804168706, 'id', '用户券主键', 'bigint', 'Long', 'id', '1', '1', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 1, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192130, 2066472078804168706, 'template_id', '所属模板', 'bigint', 'Long', 'templateId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 2, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192131, 2066472078804168706, 'member_id', '持有买家', 'bigint', 'Long', 'memberId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 3, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192132, 2066472078804168706, 'receive_time', '领取时间', 'datetime', 'Date', 'receiveTime', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 4, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192133, 2066472078804168706, 'valid_end', '过期时间', 'datetime', 'Date', 'validEnd', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 5, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192134, 2066472078804168706, 'use_order_id', '核销订单ID', 'bigint', 'Long', 'useOrderId', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 6, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192135, 2066472078804168706, 'use_time', '使用时间', 'datetime', 'Date', 'useTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 7, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192136, 2066472078804168706, 'coupon_status', '1未使用 2已使用 3已过期', 'tinyint', 'Integer', 'couponStatus', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'radio', '', 8, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472078934192137, 2066472078804168706, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 9, NULL, 1, '2026-06-15 18:45:11', 1, '2026-06-15 18:45:11');
INSERT INTO `gen_table_column` VALUES (2066472079953408001, 2066472079827578882, 'id', '订单主键', 'bigint', 'Long', 'id', '1', '1', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 1, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408002, 2066472079827578882, 'order_no', '唯一订单流水号', 'varchar(36)', 'String', 'orderNo', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 2, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408003, 2066472079827578882, 'member_id', '下单买家ID', 'bigint', 'Long', 'memberId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 3, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408004, 2066472079827578882, 'address_id', '收货地址ID', 'bigint', 'Long', 'addressId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 4, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408005, 2066472079827578882, 'total_goods_money', '商品原价合计', 'decimal(12,2)', 'BigDecimal', 'totalGoodsMoney', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 5, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408006, 2066472079827578882, 'coupon_money', '优惠券抵扣金额', 'decimal(12,2)', 'BigDecimal', 'couponMoney', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 6, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408007, 2066472079827578882, 'freight', '运费', 'decimal(10,2)', 'BigDecimal', 'freight', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 7, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408008, 2066472079827578882, 'real_pay', '用户实际支付金额', 'decimal(12,2)', 'BigDecimal', 'realPay', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 8, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408009, 2066472079827578882, 'pay_type', '1微信 2支付宝 3余额支付', 'tinyint', 'Integer', 'payType', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'select', '', 9, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408010, 2066472079827578882, 'order_status', '1待支付 2待发货 3待收货 4已完成 5已取消 6售后中', 'tinyint', 'Integer', 'orderStatus', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'radio', '', 10, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408011, 2066472079827578882, 'pay_time', '付款时间', 'datetime', 'Date', 'payTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 11, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408012, 2066472079827578882, 'delivery_time', '发货时间', 'datetime', 'Date', 'deliveryTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 12, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408013, 2066472079827578882, 'receive_time', '确认收货时间', 'datetime', 'Date', 'receiveTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 13, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408014, 2066472079827578882, 'finish_time', '订单完成时间', 'datetime', 'Date', 'finishTime', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 14, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408015, 2066472079827578882, 'express_company', '快递公司', 'varchar(30)', 'String', 'expressCompany', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 15, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408016, 2066472079827578882, 'express_no', '物流单号', 'varchar(50)', 'String', 'expressNo', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 16, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408017, 2066472079827578882, 'coupon_user_id', '使用的个人优惠券ID', 'bigint', 'Long', 'couponUserId', '0', '0', '0', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 17, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408018, 2066472079827578882, 'remark', '买家备注', 'varchar(300)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, '1', '0', 'EQ', 'input', '', 18, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408019, 2066472079827578882, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 19, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408020, 2066472079827578882, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 20, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408021, 2066472079827578882, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 21, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472079953408022, 2066472079827578882, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 22, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080016322561, 2066472079827578882, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 23, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151682, 2066472080016322562, 'id', '明细主键', 'bigint', 'Long', 'id', '1', '1', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 1, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151683, 2066472080016322562, 'order_id', '归属订单ID', 'bigint', 'Long', 'orderId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 2, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151684, 2066472080016322562, 'goods_id', '商品SPU', 'bigint', 'Long', 'goodsId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 3, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151685, 2066472080016322562, 'sku_id', '规格SKU', 'bigint', 'Long', 'skuId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 4, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151686, 2066472080016322562, 'buy_num', '购买数量', 'int', 'Integer', 'buyNum', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 5, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151687, 2066472080016322562, 'original_price', '下单时原价快照', 'decimal(10,2)', 'BigDecimal', 'originalPrice', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 6, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151688, 2066472080016322562, 'sell_price', '实际成交单价', 'decimal(10,2)', 'BigDecimal', 'sellPrice', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 7, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151689, 2066472080016322562, 'subtotal', '本行小计金额', 'decimal(12,2)', 'BigDecimal', 'subtotal', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 8, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151690, 2066472080016322562, 'create_by', '', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 9, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151691, 2066472080016322562, 'create_time', '', 'datetime', 'Date', 'createTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 10, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151692, 2066472080016322562, 'update_by', '', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 11, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151693, 2066472080016322562, 'update_time', '', 'datetime', 'Date', 'updateTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 12, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2066472080142151694, 2066472080016322562, 'del_flag', '', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 13, NULL, 1, '2026-06-15 18:45:12', 1, '2026-06-15 18:45:12');
INSERT INTO `gen_table_column` VALUES (2067228174909116417, 2067228174556794882, 'address_id', '地址主键ID', 'bigint', 'Long', 'addressId', '1', '1', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'input-number', '', 1, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116418, 2067228174556794882, 'tenant_id', '租户编号', 'varchar(20)', 'String', 'tenantId', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 2, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116419, 2067228174556794882, 'member_id', '会员ID，关联member表', 'bigint', 'Long', 'memberId', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input-number', '', 3, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116420, 2067228174556794882, 'receiver_name', '收货人姓名', 'varchar(50)', 'String', 'receiverName', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'LIKE', 'input', '', 4, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116421, 2067228174556794882, 'receiver_mobile', '收货人手机号', 'varchar(11)', 'String', 'receiverMobile', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 5, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116422, 2067228174556794882, 'province', '省份', 'varchar(20)', 'String', 'province', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 6, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116423, 2067228174556794882, 'city', '城市', 'varchar(20)', 'String', 'city', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 7, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174909116424, 2067228174556794882, 'district', '区县', 'varchar(20)', 'String', 'district', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 8, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225281, 2067228174556794882, 'detail_address', '详细地址', 'varchar(255)', 'String', 'detailAddress', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 9, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225282, 2067228174556794882, 'is_default', '是否默认地址 0否 1是', 'char(1)', 'String', 'isDefault', '0', '0', '1', '1', '1', '1', '1', '1', '0', 'EQ', 'input', '', 10, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225283, 2067228174556794882, 'create_by', '创建人', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 11, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225284, 2067228174556794882, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 12, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225285, 2067228174556794882, 'update_by', '更新人', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', '0', NULL, '0', '0', 'EQ', 'input-number', '', 13, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225286, 2067228174556794882, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', '0', '0', '1', NULL, '1', '0', 'EQ', 'datetime', '', 14, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');
INSERT INTO `gen_table_column` VALUES (2067228174976225287, 2067228174556794882, 'del_flag', '逻辑删除 0未删 1已删', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', NULL, '0', '0', 'EQ', 'input', '', 15, NULL, 1, '2026-06-17 20:49:39', 1, '2026-06-17 20:50:28');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品SPU主键',
  `category_id` bigint NOT NULL COMMENT '所属分类ID',
  `goods_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `brand` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '品牌',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品详情介绍',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '1上架 0下架',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `main_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品主图地址',
  `slide_images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '轮播多图，逗号分隔',
  `detail_img` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详情长图',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品SPU主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 2, '5Cr15 家用不锈钢切片刀', '锐厨', NULL, 1, 1, '2026-06-15 20:47:06', 1, '2026-06-15 20:47:06', '0', '2066500633063763970', NULL, NULL);

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类主键ID',
  `category_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序权重',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注说明',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID(sys_user.id)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除 0正常 1删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_category_name`(`category_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '厨具商品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES (1, '锅具类', 1, '炒锅、汤锅、煎锅、蒸锅、压力锅、砂锅等烹饪锅具', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (2, '刀板类', 2, '各类刀具、实木/PE/竹制砧板', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (3, '铲勺夹工具', 3, '锅铲、汤勺、漏勺、食品夹等操作工具', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (4, '预处理小工具', 4, '削皮器、压蒜器、研磨器、打蛋器、开瓶器等小件工具', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (5, '餐具盛具', 5, '碗、盘、碟、筷子、保鲜盒、炖盅等盛装餐具', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (6, '烘焙专用厨具', 6, '烤盘、刮刀、量杯、隔热手套、裱花工具等烘焙配件', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (7, '收纳辅助配件', 7, '刀架、锅盖架、沥水篮、调料置物架等收纳用品', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');
INSERT INTO `goods_category` VALUES (8, '厨房电动小家电', 8, '电饭煲、破壁机、空气炸锅、电磁炉、绞肉机等电动厨具', 1, '2026-06-14 20:20:22', 1, '2026-06-14 20:20:22', '0');

-- ----------------------------
-- Table structure for goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `goods_sku`;
CREATE TABLE `goods_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'SKU主键',
  `goods_id` bigint NOT NULL COMMENT '归属商品SPU',
  `sku_attr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格JSON 如{\"材质\":\"304不锈钢\",\"尺寸\":\"32cm\"}',
  `sku_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货号条码',
  `unit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单位 个/套/把',
  `stock_num` int NOT NULL DEFAULT 0 COMMENT '当前库存',
  `safe_stock` int NOT NULL DEFAULT 5 COMMENT '库存预警下限',
  `purchase_price` decimal(10, 2) NOT NULL COMMENT '进货成本价',
  `sale_price` decimal(10, 2) NOT NULL COMMENT '零售售价',
  `pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格图片地址',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '1启用 0停用',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_goods_id`(`goods_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品规格SKU' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_sku
-- ----------------------------
INSERT INTO `goods_sku` VALUES (1, 1, '{\"刀身材质\":\"5Cr15MoV 不锈钢\",\"刃长\":\"19cm\",\"手柄\":\"实木原木手柄\",\"重量\":\"280g\"}', '692000010001', '把', 135, 5, 758.49, 46.00, NULL, 1, 1, '2026-06-15 21:16:25', 1, '2026-06-17 16:09:41', '0');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `member_id` bigint NOT NULL AUTO_INCREMENT COMMENT '会员主键ID',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会员昵称',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号(唯一登录账号)',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录加密密码',
  `balance` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '账户余额',
  `point` int NULL DEFAULT 0 COMMENT '会员积分',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '账号状态：1正常 0禁用',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '逻辑删除：0正常 1删除',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`member_id`) USING BTREE,
  UNIQUE INDEX `idx_mobile`(`mobile` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, 'sparkle520', '18346554486', '', 'tt123456', 1000.00, 0, NULL, '1', '0', 1, '2026-06-17 20:19:36', 1, '2026-06-17 20:19:36');

-- ----------------------------
-- Table structure for member_address
-- ----------------------------
DROP TABLE IF EXISTS `member_address`;
CREATE TABLE `member_address`  (
  `address_id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址主键ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '租户编号',
  `member_id` bigint NOT NULL COMMENT '会员ID，关联member表',
  `receiver_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `receiver_mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人手机号',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '省份',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市',
  `district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '区县',
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否默认地址 0否 1是',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '逻辑删除 0未删 1已删',
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `idx_member_id`(`member_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_address
-- ----------------------------

-- ----------------------------
-- Table structure for purchase
-- ----------------------------
DROP TABLE IF EXISTS `purchase`;
CREATE TABLE `purchase`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '入库单主键',
  `supplier_id` bigint NOT NULL COMMENT '供应商ID',
  `operator_id` bigint NOT NULL COMMENT '操作员工sys_user.id',
  `total_amount` decimal(12, 2) NOT NULL COMMENT '单据总金额',
  `pay_status` tinyint NOT NULL DEFAULT 0 COMMENT '0未付款 1已结清',
  `purchase_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `note` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单据备注',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_supplier_id`(`supplier_id` ASC) USING BTREE,
  INDEX `idx_operator_id`(`operator_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '进货入库单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase
-- ----------------------------
INSERT INTO `purchase` VALUES (1, 1, 1, 10.00, 0, '2026-06-17 00:00:00', NULL, 1, '2026-06-16 14:50:32', 1, '2026-06-16 14:50:32', '0');
INSERT INTO `purchase` VALUES (2, 1, 1, 10.00, 0, '2026-06-17 00:00:00', NULL, 1, '2026-06-16 15:15:55', 1, '2026-06-16 15:15:55', '0');
INSERT INTO `purchase` VALUES (3, 1, 1, 1110.00, 1, '2026-06-18 00:00:00', NULL, 1, '2026-06-16 15:25:16', 1, '2026-06-16 15:25:16', '0');
INSERT INTO `purchase` VALUES (4, 1, 1, 10.00, 0, '2026-06-18 00:00:00', 'test', 1, '2026-06-16 16:31:20', 1, '2026-06-16 16:31:20', '0');
INSERT INTO `purchase` VALUES (5, 1, 1, 10.00, 1, '2026-06-18 00:00:00', NULL, 1, '2026-06-17 16:08:48', 1, '2026-06-17 16:08:48', '0');
INSERT INTO `purchase` VALUES (6, 1, 1, 100000.00, 0, '2026-06-19 00:00:00', NULL, 1, '2026-06-17 16:09:42', 1, '2026-06-17 16:09:42', '0');

-- ----------------------------
-- Table structure for purchase_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_item`;
CREATE TABLE `purchase_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细主键',
  `purchase_id` bigint NOT NULL COMMENT '入库单ID',
  `sku_id` bigint NOT NULL COMMENT '商品SKU',
  `buy_num` int NOT NULL COMMENT '采购数量',
  `buy_price` decimal(10, 2) NOT NULL COMMENT '单件进价',
  `subtotal` decimal(12, 2) NOT NULL COMMENT '本行小计金额',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_purchase_id`(`purchase_id` ASC) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '入库商品明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_item
-- ----------------------------
INSERT INTO `purchase_item` VALUES (1, 3, 1, 1, 1110.00, 1110.00, 1, '2026-06-16 15:25:16', 1, '2026-06-16 15:25:16', '0');
INSERT INTO `purchase_item` VALUES (2, 4, 1, 1, 10.00, 10.00, 1, '2026-06-16 16:31:20', 1, '2026-06-16 16:31:20', '0');
INSERT INTO `purchase_item` VALUES (3, 5, 1, 1, 10.00, 10.00, 1, '2026-06-17 16:08:48', 1, '2026-06-17 16:08:48', '0');
INSERT INTO `purchase_item` VALUES (4, 6, 1, 1, 100000.00, 100000.00, 1, '2026-06-17 16:09:42', 1, '2026-06-17 16:09:42', '0');

-- ----------------------------
-- Table structure for sale_order
-- ----------------------------
DROP TABLE IF EXISTS `sale_order`;
CREATE TABLE `sale_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单主键',
  `order_no` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '唯一订单流水号',
  `member_id` bigint NOT NULL COMMENT '下单买家ID',
  `address_id` bigint NOT NULL COMMENT '收货地址ID',
  `receiver_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `receiver_mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人手机号',
  `receiver_province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货省份',
  `receiver_city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货城市',
  `receiver_district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货区/县',
  `receiver_detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细收货地址',
  `total_goods_money` decimal(12, 2) NOT NULL COMMENT '商品原价合计',
  `coupon_money` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠券抵扣金额',
  `freight` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '运费',
  `real_pay` decimal(12, 2) NOT NULL COMMENT '用户实际支付金额',
  `pay_type` tinyint NOT NULL COMMENT '1微信 2支付宝 3余额支付',
  `order_status` tinyint NOT NULL DEFAULT 1 COMMENT '1待支付 2待发货 3待收货 4已完成 5已取消 6售后中',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '付款时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '确认收货时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '订单完成时间',
  `express_company` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '快递公司',
  `express_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `coupon_user_id` bigint NULL DEFAULT NULL COMMENT '使用的个人优惠券ID',
  `remark` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家备注',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_member_id`(`member_id` ASC) USING BTREE,
  INDEX `idx_order_status`(`order_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'C端购物订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sale_order
-- ----------------------------

-- ----------------------------
-- Table structure for sale_order_item
-- ----------------------------
DROP TABLE IF EXISTS `sale_order_item`;
CREATE TABLE `sale_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细主键',
  `order_id` bigint NOT NULL COMMENT '归属订单ID',
  `goods_id` bigint NOT NULL COMMENT '商品SPU',
  `sku_id` bigint NOT NULL COMMENT '规格SKU',
  `buy_num` int NOT NULL COMMENT '购买数量',
  `original_price` decimal(10, 2) NOT NULL COMMENT '下单时原价快照',
  `sell_price` decimal(10, 2) NOT NULL COMMENT '实际成交单价',
  `subtotal` decimal(12, 2) NOT NULL COMMENT '本行小计金额',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单商品明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sale_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for stock_record
-- ----------------------------
DROP TABLE IF EXISTS `stock_record`;
CREATE TABLE `stock_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  `sku_id` bigint NOT NULL COMMENT '操作SKU',
  `change_type` tinyint NOT NULL COMMENT '1采购入库 2销售出库 3退货入库 4损耗扣库',
  `change_num` int NOT NULL COMMENT '变动数量(出库负数)',
  `stock_after` int NOT NULL COMMENT '变动后剩余库存',
  `relation_id` bigint NULL DEFAULT NULL COMMENT '关联单据ID(采购/订单/售后)',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sku_id`(`sku_id` ASC) USING BTREE,
  INDEX `idx_change_type`(`change_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存变更流水' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_record
-- ----------------------------
INSERT INTO `stock_record` VALUES (1, 1, 1, 1, 133, 4, '2026-06-16 16:31:20', 1, '2026-06-16 16:31:20', 1, '2026-06-16 16:31:20', '0');
INSERT INTO `stock_record` VALUES (2, 1, 1, 1, 134, 5, '2026-06-17 16:08:48', 1, '2026-06-17 16:08:48', 1, '2026-06-17 16:08:48', '0');
INSERT INTO `stock_record` VALUES (3, 1, 1, 1, 135, 6, '2026-06-17 16:09:42', 1, '2026-06-17 16:09:42', 1, '2026-06-17 16:09:42', '0');

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `supplier_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '厂商名称',
  `contact` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对接联系人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '厂商地址',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '供货供应商' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (1, '阳江砺锋五金刀具有限公司', '黄经理', '13866229051', '广东省阳江市江城区五金刀剪产业园 A12 栋', '主营 5Cr15MoV 不锈钢家用刀具、锻打切片刀、砍骨刀，支持批量定制 logo，交货周期 3-7 天', 1, '2026-06-16 13:56:55', 1, '2026-06-16 13:56:55', '0');

-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_client`;
CREATE TABLE `sys_client`  (
  `id` bigint NOT NULL COMMENT 'id',
  `client_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端id',
  `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端key',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
  `grant_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '授权类型',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备类型',
  `active_timeout` int NULL DEFAULT 1800 COMMENT 'token活跃超时时间',
  `timeout` int NULL DEFAULT 604800 COMMENT 'token固定超时',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '状态（1正常 0停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统授权表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_client
-- ----------------------------
INSERT INTO `sys_client` VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '1', '0', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24');
INSERT INTO `sys_client` VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '1', '0', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `is_global` tinyint(1) NOT NULL COMMENT '是否是全局配置 1是 0否',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 0, 103, 1, '2026-06-14 12:19:24', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 0, 103, 1, '2026-06-14 12:19:24', NULL, NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 0, 103, 1, '2026-06-14 12:19:24', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 1, 103, 1, '2026-06-14 12:19:24', NULL, NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 1, 103, 1, '2026-06-14 12:19:24', NULL, NULL, 'true:开启, false:关闭');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `dept_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门类别编码',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` bigint NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '部门状态（1正常 0停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, '000000', 0, '0', 'XXX科技', NULL, 0, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (101, '000000', 100, '0,100', '深圳总公司', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (102, '000000', 100, '0,100', '长沙分公司', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (103, '000000', 101, '0,100,101', '研发部门', NULL, 1, 1, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (104, '000000', 101, '0,100,101', '市场部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (105, '000000', 101, '0,100,101', '测试部门', NULL, 3, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (106, '000000', 101, '0,100,101', '财务部门', NULL, 4, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (107, '000000', 101, '0,100,101', '运维部门', NULL, 5, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (108, '000000', 102, '0,100,102', '市场部门', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);
INSERT INTO `sys_dept` VALUES (109, '000000', 102, '0,100,102', '财务部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `tag_style` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回显风格',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', '', 'Y', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '000000', 1, '显示', '1', 'sys_show_hide', '', 'primary', '', 'Y', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '显示状态');
INSERT INTO `sys_dict_data` VALUES (5, '000000', 2, '隐藏', '0', 'sys_show_hide', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '隐藏状态');
INSERT INTO `sys_dict_data` VALUES (6, '000000', 1, '正常', '1', 'sys_normal_disable', '', 'primary', '', 'Y', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '000000', 2, '停用', '0', 'sys_normal_disable', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', '', 'Y', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', '', 'Y', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '000000', 1, '正常', '1', 'sys_notice_status', '', 'primary', '', 'Y', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '000000', 2, '关闭', '0', 'sys_notice_status', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, '000000', 1, '成功', '1', 'sys_common_status', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '成功状态');
INSERT INTO `sys_dict_data` VALUES (28, '000000', 2, '失败', '0', 'sys_common_status', '', 'danger', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '失败状态');
INSERT INTO `sys_dict_data` VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (30, '000000', 0, '域名', 'DOMAIN', 'sys_app_type', NULL, 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (31, '000000', 1, '微信小程序', 'WX_XCX', 'sys_app_type', NULL, 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (32, '000000', 2, '微信公众号', 'WX_GZH', 'sys_app_type', NULL, 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (33, '000000', 3, 'APP', 'APP', 'sys_app_type', NULL, 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (47, '000000', 0, '模板ID', 'TEMPLATE_ID', 'sys_message_template_mode', NULL, 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (48, '000000', 1, '模板内容', 'TEMPLATE_CONTENT', 'sys_message_template_mode', NULL, 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (49, '000000', 0, '密码认证', 'password', 'sys_grant_type', '', 'primary', 'light-outline', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '密码认证');
INSERT INTO `sys_dict_data` VALUES (50, '000000', 0, '短信认证', 'sms', 'sys_grant_type', '', 'primary', 'light-outline', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '短信认证');
INSERT INTO `sys_dict_data` VALUES (51, '000000', 0, '邮件认证', 'email', 'sys_grant_type', '', 'primary', 'light-outline', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '邮件认证');
INSERT INTO `sys_dict_data` VALUES (52, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', '', 'primary', 'light-outline', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '小程序认证');
INSERT INTO `sys_dict_data` VALUES (53, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', '', 'primary', 'light-outline', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '三方登录认证');
INSERT INTO `sys_dict_data` VALUES (54, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, 'PC');
INSERT INTO `sys_dict_data` VALUES (55, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '安卓');
INSERT INTO `sys_dict_data` VALUES (56, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, 'iOS');
INSERT INTO `sys_dict_data` VALUES (57, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'primary', '', 'N', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '小程序');
INSERT INTO `sys_dict_data` VALUES (70, '000000', 99, '其他', 'other', 'sensitive_words_category', NULL, 'primary', NULL, 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (100, '000000', 0, '代理转发请求', 'proxy', 'sys_storage_request_mode', NULL, 'primary', NULL, 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (101, '000000', 1, '源地址重定向请求', 'direct', 'sys_storage_request_mode', NULL, 'primary', NULL, 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (102, '000000', 2, '预签名重定向请求', 'direct_signature', 'sys_storage_request_mode', NULL, 'primary', NULL, 'N', 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_dict_data` VALUES (2066478507527155714, '000000', 0, '上架', '1', 'kitchenware_goods_status', NULL, 'success', NULL, 'N', 103, 1, '2026-06-15 19:10:44', 1, '2026-06-15 19:10:55', NULL);
INSERT INTO `sys_dict_data` VALUES (2066478662607351809, '000000', 1, '下架', '0', 'kitchenware_goods_status', NULL, 'default', NULL, 'N', 103, 1, '2026-06-15 19:11:21', 1, '2026-06-15 19:11:21', NULL);
INSERT INTO `sys_dict_data` VALUES (2066767623829508098, '000000', 0, '未付款', '0', 'kitchenware_purchase_status', NULL, 'default', NULL, 'N', 103, 1, '2026-06-16 14:19:35', 1, '2026-06-16 14:19:35', NULL);
INSERT INTO `sys_dict_data` VALUES (2066767676711292929, '000000', 0, '已结清', '1', 'kitchenware_purchase_status', NULL, 'success', NULL, 'N', 103, 1, '2026-06-16 14:19:47', 1, '2026-06-16 14:19:47', NULL);
INSERT INTO `sys_dict_data` VALUES (2066781497639227394, '000000', 0, '停用', '0', 'kitchenware_sku_status', NULL, 'danger', NULL, 'N', 103, 1, '2026-06-16 15:14:43', 1, '2026-06-16 15:14:43', NULL);
INSERT INTO `sys_dict_data` VALUES (2066781550139330562, '000000', 0, '启用', '1', 'kitchenware_sku_status', NULL, 'success', NULL, 'N', 103, 1, '2026-06-16 15:14:55', 1, '2026-06-16 15:14:55', NULL);
INSERT INTO `sys_dict_data` VALUES (2066804318474010626, '000000', 0, '采购入库', '1', 'kitchenware_stock_change_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-16 16:45:24', 1, '2026-06-16 16:45:24', NULL);
INSERT INTO `sys_dict_data` VALUES (2066804355123838978, '000000', 0, '销售出库', '2', 'kitchenware_stock_change_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-16 16:45:32', 1, '2026-06-16 16:45:32', NULL);
INSERT INTO `sys_dict_data` VALUES (2066804393388474369, '000000', 0, '退货入库', '3', 'kitchenware_stock_change_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-16 16:45:41', 1, '2026-06-16 16:45:41', NULL);
INSERT INTO `sys_dict_data` VALUES (2066804449281769474, '000000', 0, '损耗扣库', '4', 'kitchenware_stock_change_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-16 16:45:55', 1, '2026-06-16 16:45:55', NULL);
INSERT INTO `sys_dict_data` VALUES (2067159938549141505, '000000', 0, '微信', '1', 'pay_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:18:30', 1, '2026-06-17 16:18:30', NULL);
INSERT INTO `sys_dict_data` VALUES (2067159979498131458, '000000', 0, '支付宝', '2', 'pay_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:18:40', 1, '2026-06-17 16:18:40', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160029674590209, '000000', 0, '余额支付', '3', 'pay_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:18:52', 1, '2026-06-17 16:18:52', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160178605936642, '000000', 0, '待支付', '1', 'order_status', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:19:27', 1, '2026-06-17 16:19:27', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160230493671426, '000000', 0, '待发货', '2', 'order_status', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:19:40', 1, '2026-06-17 16:19:40', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160331177938945, '000000', 0, '待收货', '3', 'order_status', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:20:04', 1, '2026-06-17 16:20:04', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160396437114881, '000000', 0, '已完成', '4', 'order_status', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:20:19', 1, '2026-06-17 16:20:19', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160466406494210, '000000', 0, '已取消', '5', 'order_status', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:20:36', 1, '2026-06-17 16:20:36', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160497360457730, '000000', 0, '售后中', '6', 'order_status', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:20:43', 1, '2026-06-17 16:20:43', NULL);
INSERT INTO `sys_dict_data` VALUES (2067160977851535361, '000000', 0, '无门槛', '1', 'coupon_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:22:38', 1, '2026-06-17 16:22:38', NULL);
INSERT INTO `sys_dict_data` VALUES (2067161017789698050, '000000', 0, '满减券', '2', 'coupon_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:22:47', 1, '2026-06-17 16:22:47', NULL);
INSERT INTO `sys_dict_data` VALUES (2067161572666757121, '000000', 0, '全品类', '1', 'scope_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:25:00', 1, '2026-06-17 16:25:00', NULL);
INSERT INTO `sys_dict_data` VALUES (2067161612600725505, '000000', 0, '指定分类', '2', 'scope_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:25:09', 1, '2026-06-17 16:25:09', NULL);
INSERT INTO `sys_dict_data` VALUES (2067161668280111105, '000000', 0, '指定商品', '3', 'scope_type', NULL, 'text', NULL, 'N', 103, 1, '2026-06-17 16:25:22', 1, '2026-06-17 16:25:22', NULL);
INSERT INTO `sys_dict_data` VALUES (2067214994602381313, '000000', 0, '未使用', '1', 'coupon_status', NULL, 'default', NULL, 'N', 103, 1, '2026-06-17 19:57:16', 1, '2026-06-17 19:57:16', NULL);
INSERT INTO `sys_dict_data` VALUES (2067215068443103233, '000000', 0, '已使用', '2', 'coupon_status', NULL, 'primary', NULL, 'N', 103, 1, '2026-06-17 19:57:34', 1, '2026-06-17 19:57:34', NULL);
INSERT INTO `sys_dict_data` VALUES (2067215126098006017, '000000', 0, '已过期', '3', 'coupon_status', NULL, 'danger', NULL, 'N', 103, 1, '2026-06-17 19:57:48', 1, '2026-06-17 19:57:48', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `tenant_id`(`tenant_id` ASC, `dict_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '000000', '显隐状态', 'sys_show_hide', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '000000', '正常状态', 'sys_normal_disable', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '000000', '成功状态', 'sys_common_status', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '000000', '应用类型', 'sys_app_type', 103, 1, '2026-06-14 12:19:23', 1, '2026-06-14 12:19:23', '应用管理列表');
INSERT INTO `sys_dict_type` VALUES (14, '000000', '消息模板类型', 'sys_message_template_mode', 103, 1, '2026-06-14 12:19:23', 1, '2026-06-14 12:19:23', NULL);
INSERT INTO `sys_dict_type` VALUES (15, '000000', '授权类型', 'sys_grant_type', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '认证授权类型');
INSERT INTO `sys_dict_type` VALUES (16, '000000', '设备类型', 'sys_device_type', 103, 1, '2026-06-14 12:19:23', NULL, NULL, '客户端设备类型');
INSERT INTO `sys_dict_type` VALUES (17, '000000', '敏感词类别', 'sensitive_words_category', 103, 1, '2026-06-14 12:19:23', 1, '2026-06-14 12:19:23', NULL);
INSERT INTO `sys_dict_type` VALUES (21, '000000', '存储配置请求模式', 'sys_storage_request_mode', 103, 1, '2026-06-14 12:19:23', 1, '2026-06-14 12:19:23', '存储配置');
INSERT INTO `sys_dict_type` VALUES (2066478314282987522, '000000', '商品上架状态', 'kitchenware_goods_status', 103, 1, '2026-06-15 19:09:58', 1, '2026-06-15 19:09:58', NULL);
INSERT INTO `sys_dict_type` VALUES (2066759885485453314, '000000', '进货状态', 'kitchenware_purchase_status', 103, 1, '2026-06-16 13:48:50', 1, '2026-06-16 13:49:05', NULL);
INSERT INTO `sys_dict_type` VALUES (2066781432015147009, '000000', 'sku状态', 'kitchenware_sku_status', 103, 1, '2026-06-16 15:14:27', 1, '2026-06-16 15:14:27', NULL);
INSERT INTO `sys_dict_type` VALUES (2066804270247903234, '000000', '库存流水变更类型', 'kitchenware_stock_change_type', 103, 1, '2026-06-16 16:45:12', 1, '2026-06-16 16:45:12', NULL);
INSERT INTO `sys_dict_type` VALUES (2067159408456224770, '000000', '支付类型', 'pay_type', 103, 1, '2026-06-17 16:16:24', 1, '2026-06-17 16:16:38', NULL);
INSERT INTO `sys_dict_type` VALUES (2067160117633339394, '000000', '订单状态', 'order_status', 103, 1, '2026-06-17 16:19:13', 1, '2026-06-17 16:19:13', NULL);
INSERT INTO `sys_dict_type` VALUES (2067160870133420033, '000000', '优惠券类型', 'coupon_type', 103, 1, '2026-06-17 16:22:12', 1, '2026-06-17 16:22:12', NULL);
INSERT INTO `sys_dict_type` VALUES (2067161529570283522, '000000', '优惠券作用域类型', 'scope_type', 103, 1, '2026-06-17 16:24:49', 1, '2026-06-17 16:24:49', NULL);
INSERT INTO `sys_dict_type` VALUES (2067214823718047745, '000000', '优惠券状态', 'coupon_status', 103, 1, '2026-06-17 19:56:36', 1, '2026-06-17 19:56:36', NULL);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `file_id` bigint NOT NULL COMMENT '文件id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件访问地址',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小，单位字节',
  `filename` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件名称',
  `original_filename` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `base_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基础存储路径',
  `path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储路径',
  `ext` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `content_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'MIME类型',
  `storage_config_id` bigint NULL DEFAULT NULL COMMENT '存储配置id',
  `th_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '缩略图访问路径',
  `th_filename` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '缩略图名称',
  `th_size` bigint NULL DEFAULT NULL COMMENT '缩略图大小，单位字节',
  `th_content_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '缩略图MIME类型',
  `object_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件所属对象id',
  `object_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件所属对象类型，例如用户头像，评价图片',
  `metadata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文件元数据',
  `user_metadata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文件用户元数据',
  `th_metadata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '缩略图元数据',
  `th_user_metadata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '缩略图用户元数据',
  `attr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '附加属性',
  `file_acl` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件ACL',
  `th_file_acl` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '缩略图文件ACL',
  `hash_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '哈希信息',
  `upload_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传ID，仅在手动分片上传时使用',
  `upload_status` int NULL DEFAULT NULL COMMENT '上传状态，仅在手动分片上传时使用，1：初始化完成，2：上传完成',
  `file_category_id` bigint NOT NULL DEFAULT 0 COMMENT '分类id',
  `user_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户类型',
  `is_lock` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否锁定状态',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`file_id`) USING BTREE,
  INDEX `idx_filename`(`filename` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (2066497732564135938, '000000', '2026/06/15/6a2fef9b61ade0e7f66f4e21.jpg', 223713, '6a2fef9b61ade0e7f66f4e21.jpg', '微信图片_20251201145714_14_188.jpg', '', '2026/06/15/', 'jpg', 'image/jpeg', 2066497664289255425, NULL, NULL, NULL, NULL, NULL, NULL, '{}', '{}', '{}', '{}', '{}', NULL, NULL, '{}', NULL, NULL, 0, 'login', 0, 103, 1, 1, '2026-06-15 20:27:08', '2026-06-15 20:27:08');
INSERT INTO `sys_file` VALUES (2066500633063763970, '000000', '2026/06/15/6a2ff24f61ade0e7f66f4e22.png', 1406395, '6a2ff24f61ade0e7f66f4e22.png', 'image.png', '', '2026/06/15/', 'png', 'image/png', 2066497664289255425, NULL, NULL, NULL, NULL, NULL, NULL, '{}', '{}', '{}', '{}', '{}', NULL, NULL, '{}', NULL, NULL, 0, 'login', 0, 103, 1, 1, '2026-06-15 20:38:39', '2026-06-15 20:38:39');

-- ----------------------------
-- Table structure for sys_file_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_category`;
CREATE TABLE `sys_file_category`  (
  `file_category_id` bigint NOT NULL COMMENT '文件分类id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint NOT NULL COMMENT '父级分类id',
  `category_path` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类路径',
  `level` int NOT NULL COMMENT '层级',
  `order_num` int NOT NULL COMMENT '显示顺序',
  `login_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户类型',
  `create_by` bigint NOT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`file_category_id`) USING BTREE,
  INDEX `idx_user`(`create_by` ASC, `login_type` ASC, `order_num` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file_category
-- ----------------------------

-- ----------------------------
-- Table structure for sys_file_part
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_part`;
CREATE TABLE `sys_file_part`  (
  `file_part_id` bigint NOT NULL COMMENT '分片id',
  `storage_config_id` bigint NULL DEFAULT NULL COMMENT '存储配置id',
  `upload_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传ID，仅在手动分片上传时使用',
  `e_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分片 ETag',
  `part_number` int NULL DEFAULT NULL COMMENT '分片号。每一个上传的分片都有一个分片号，一般情况下取值范围是1~10000',
  `part_size` bigint NULL DEFAULT NULL COMMENT '文件大小，单位字节',
  `hash_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '哈希信息',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`file_part_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件分片信息表，仅在手动分片上传时使用' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file_part
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `client_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '客户端',
  `device_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '设备类型',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '登录状态（1成功 0失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (2066020719818616833, '000000', NULL, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '验证码错误', '2026-06-14 12:51:39');
INSERT INTO `sys_logininfor` VALUES (2066020734079250434, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 12:51:42');
INSERT INTO `sys_logininfor` VALUES (2066040487992791042, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 14:10:12');
INSERT INTO `sys_logininfor` VALUES (2066068318890168322, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 16:00:48');
INSERT INTO `sys_logininfor` VALUES (2066101897145778177, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 18:14:13');
INSERT INTO `sys_logininfor` VALUES (2066105791485739010, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '退出成功', '2026-06-14 18:29:42');
INSERT INTO `sys_logininfor` VALUES (2066105820401270785, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 18:29:49');
INSERT INTO `sys_logininfor` VALUES (2066121561980731394, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 19:32:22');
INSERT INTO `sys_logininfor` VALUES (2066124573704896513, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '退出成功', '2026-06-14 19:44:20');
INSERT INTO `sys_logininfor` VALUES (2066124631519182849, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 19:44:34');
INSERT INTO `sys_logininfor` VALUES (2066128174007369729, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '退出成功', '2026-06-14 19:58:38');
INSERT INTO `sys_logininfor` VALUES (2066128270203731970, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-14 19:59:01');
INSERT INTO `sys_logininfor` VALUES (2066471582185992193, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-15 18:43:13');
INSERT INTO `sys_logininfor` VALUES (2066487524030853121, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-15 19:46:34');
INSERT INTO `sys_logininfor` VALUES (2066494054792867842, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-15 20:12:31');
INSERT INTO `sys_logininfor` VALUES (2066507866568867841, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-15 21:07:24');
INSERT INTO `sys_logininfor` VALUES (2066751401700311042, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-16 13:15:07');
INSERT INTO `sys_logininfor` VALUES (2067156348799537154, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-17 16:04:14');
INSERT INTO `sys_logininfor` VALUES (2067204873763606530, '000000', NULL, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '验证码错误', '2026-06-17 19:17:03');
INSERT INTO `sys_logininfor` VALUES (2067204887160213505, '000000', NULL, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '验证码错误', '2026-06-17 19:17:07');
INSERT INTO `sys_logininfor` VALUES (2067204900779118594, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-17 19:17:10');
INSERT INTO `sys_logininfor` VALUES (2067493203222863874, '000000', 1, 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '登录成功', '2026-06-18 14:22:46');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件名称',
  `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 0 COMMENT '是否为外链（1是 0否）',
  `is_cache` int NULL DEFAULT 1 COMMENT '是否缓存（1缓存 0不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '显示状态（1显示 0隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '菜单状态（1正常 0停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `hidden_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '隐藏表达式',
  `shop_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '停用表达式',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 11, 'system', NULL, NULL, '', 0, 1, 'M', '1', '1', '', 'setting', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 13, 'monitor', NULL, NULL, '', 0, 1, 'M', '1', '1', '', 'chart', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 14, 'tool', NULL, NULL, '', 0, 1, 'M', '1', '1', '', 'tools', NULL, 'getProperty(\'spring.profiles.active\') != \'dev\'', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, 'PLUS官网', 0, 15, 'https://gitee.com/yixiacoco/ruoyi-tdesign', NULL, NULL, '', 1, 1, 'M', '1', '1', '', 'link', NULL, 'getProperty(\'spring.profiles.active\') != \'dev\'', 103, 1, '2026-06-14 12:19:21', NULL, NULL, 'ruoyi-tdesign官网地址');
INSERT INTO `sys_menu` VALUES (6, '租户管理', 0, 12, 'tenant', NULL, NULL, '', 0, 1, 'M', '1', '1', '', 'chart-bar', NULL, '!getProperty(\'tenant.enable\')', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '租户管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', 'User', '', 0, 1, 'C', '1', '1', 'system:user:list', 'user', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', 'Role', '', 0, 1, 'C', '1', '1', 'system:role:list', 'user-safety', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menus', 'system/menu/index', 'Menu', '', 0, 1, 'C', '1', '1', 'system:menu:list', 'bulletpoint', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', 'Dept', '', 0, 1, 'C', '1', '1', 'system:dept:list', 'tree-square-dot', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', 'Post', '', 0, 1, 'C', '1', '1', 'system:post:list', 'user-avatar', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', 'Dict', '', 0, 1, 'C', '1', '1', 'system:dict:list', 'book', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'sysConfig', 'system/config/index', 'Config', '', 0, 1, 'C', '1', '1', 'system:config:list', 'edit', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', 'Notice', '', 0, 1, 'C', '1', '1', 'system:notice:list', 'mail', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', NULL, '', 0, 1, 'M', '1', '1', '', 'root-list', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', 'Online', '', 0, 1, 'C', '1', '1', 'monitor:online:list', 'user-talk', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', 'Cache', '', 0, 1, 'C', '1', '1', 'monitor:cache:list', 'layers', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', 'Gen', '', 0, 1, 'C', '1', '1', 'tool:gen:list', 'code', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', 'Admin', '', 0, 1, 'C', '1', '1', 'monitor:admin:list', 'dashboard', NULL, '!getProperty(\'spring.boot.admin.client.enabled\')', 103, 1, '2026-06-14 12:19:21', NULL, NULL, 'Admin监控菜单');
INSERT INTO `sys_menu` VALUES (118, '文件管理', 1510, 2, 'oss', 'system/oss/index', 'Oss', '', 0, 1, 'C', '1', '1', 'system:oss:list', 'backup', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '文件管理菜单');
INSERT INTO `sys_menu` VALUES (120, '任务调度中心', 2, 6, 'snailjob', 'monitor/snailjob/index', NULL, '', 0, 1, 'C', '1', '1', 'monitor:snailjob:list', 'video', NULL, '!getProperty(\'snail-job.enabled\')', 103, 1, '2026-06-14 12:19:21', NULL, NULL, 'SnailJob控制台菜单');
INSERT INTO `sys_menu` VALUES (121, '租户管理', 6, 1, 'tenant', 'system/tenant/index', 'Tenant', '', 0, 1, 'C', '1', '1', 'system:tenant:list', 'bulletpoint', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '租户管理菜单');
INSERT INTO `sys_menu` VALUES (122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', 'TenantPackage', '', 0, 1, 'C', '1', '1', 'system:tenantPackage:list', 'edit-1', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '租户套餐管理菜单');
INSERT INTO `sys_menu` VALUES (123, '客户端管理', 1, 12, 'client', 'system/client/index', 'Client', '', 0, 1, 'C', '1', '1', 'system:client:list', 'internet', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '客户端管理菜单');
INSERT INTO `sys_menu` VALUES (124, '敏感词', 1, 13, 'sensitiveWord', 'system/sensitiveWord/index', 'SensitiveWord', '', 0, 1, 'C', '1', '1', 'system:sensitiveWord:list', 'book-open', NULL, NULL, 103, 1, '2026-06-14 12:19:21', 1, '2026-06-14 12:19:21', '敏感词菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 'Operlog', '', 0, 1, 'C', '1', '1', 'monitor:operlog:list', 'edit-1', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 'Logininfor', '', 0, 1, 'C', '1', '1', 'monitor:logininfor:list', 'swap', NULL, NULL, 103, 1, '2026-06-14 12:19:21', NULL, NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:import', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', '', 0, 1, 'F', '1', '1', 'system:user:resetPwd', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', '', 0, 1, 'F', '1', '1', 'system:role:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', '', 0, 1, 'F', '1', '1', 'system:role:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', '', 0, 1, 'F', '1', '1', 'system:role:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', '', 0, 1, 'F', '1', '1', 'system:role:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', '', 0, 1, 'F', '1', '1', 'system:role:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', '', 0, 1, 'F', '1', '1', 'system:menu:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', '', 0, 1, 'F', '1', '1', 'system:menu:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', '', 0, 1, 'F', '1', '1', 'system:menu:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', '', 0, 1, 'F', '1', '1', 'system:menu:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', '', 0, 1, 'F', '1', '1', 'system:dept:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', '', 0, 1, 'F', '1', '1', 'system:dept:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', '', 0, 1, 'F', '1', '1', 'system:dept:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', '', 0, 1, 'F', '1', '1', 'system:dept:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', '', 0, 1, 'F', '1', '1', 'system:post:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', '', 0, 1, 'F', '1', '1', 'system:post:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', '', 0, 1, 'F', '1', '1', 'system:post:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', '', 0, 1, 'F', '1', '1', 'system:post:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', '', 0, 1, 'F', '1', '1', 'system:post:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:dict:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:dict:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:dict:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:dict:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:dict:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:config:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:config:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:config:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:config:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:config:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:notice:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:notice:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:notice:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:notice:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:operlog:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:operlog:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:operlog:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:logininfor:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:logininfor:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:logininfor:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:online:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:online:batchLogout', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:online:forceLogout', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '账户解锁', 501, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'monitor:logininfor:unlock', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'tool:gen:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'tool:gen:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'tool:gen:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'tool:gen:import', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'tool:gen:preview', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'tool:gen:code', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1061, '客户端管理查询', 123, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:client:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1062, '客户端管理新增', 123, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:client:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1063, '客户端管理修改', 123, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:client:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1064, '客户端管理删除', 123, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:client:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1065, '客户端管理导出', 123, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:client:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1117, '菜单导出', 102, 5, '', '', '', '', 0, 1, 'F', '1', '1', 'system:menu:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1121, '部门导出', 103, 5, '', '', '', '', 0, 1, 'F', '1', '1', 'system:dept:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1140, '公告导出', 107, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:notice:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1500, 'OSS配置管理', 1510, 1, 'ossConfig', 'system/ossConfig/index', 'OssConfig', '', 0, 1, 'C', '1', '1', 'system:ossConfig:list', 'server', NULL, NULL, 103, 1, '2026-06-14 12:19:21', 1, NULL, '');
INSERT INTO `sys_menu` VALUES (1501, '配置添加', 1500, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:ossConfig:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1502, '配置编辑', 1500, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:ossConfig:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1503, '配置删除', 1500, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:ossConfig:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1510, '文件管理（旧）', 1, 10, 'store', NULL, NULL, NULL, 0, 1, 'M', '1', '1', NULL, 'cloud', NULL, NULL, 103, 1, '2026-06-14 12:19:21', 1, NULL, '');
INSERT INTO `sys_menu` VALUES (1521, 'OSS处理规则', 1510, 3, 'ossRule', 'system/ossRule/index', 'OssRule', NULL, 0, 1, 'C', '1', '1', 'system:ossRule:list', 'chevron-right-double', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, NULL, 'OSS处理规则菜单');
INSERT INTO `sys_menu` VALUES (1522, 'OSS处理规则查询', 1521, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossRule:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1523, 'OSS处理规则新增', 1521, 2, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossRule:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1524, 'OSS处理规则修改', 1521, 3, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossRule:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1525, 'OSS处理规则删除', 1521, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossRule:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1526, 'OSS处理规则导出', 1521, 5, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossRule:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1531, '我的文件', 1510, 4, 'ossCategory', 'system/ossCategory/index', 'OssCategory', NULL, 0, 1, 'C', '1', '1', 'system:ossCategory:list', 'folder-open', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '我的文件菜单');
INSERT INTO `sys_menu` VALUES (1532, 'OSS分类查询', 1531, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossCategory:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1533, 'OSS分类新增', 1531, 2, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossCategory:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1534, 'OSS分类修改', 1531, 3, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossCategory:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1535, 'OSS分类删除', 1531, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:ossCategory:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1600, '文件查询', 118, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:oss:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1601, '文件上传', 118, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:oss:upload', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1602, '文件下载', 118, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:oss:download', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1603, '文件删除', 118, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:oss:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1604, '文件修改', 118, 5, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:oss:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1606, '租户查询', 121, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenant:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1607, '租户新增', 121, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenant:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1608, '租户修改', 121, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenant:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1609, '租户删除', 121, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenant:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1610, '租户导出', 121, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenant:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1611, '租户套餐查询', 122, 1, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenantPackage:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1612, '租户套餐新增', 122, 2, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenantPackage:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1613, '租户套餐修改', 122, 3, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenantPackage:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1614, '租户套餐删除', 122, 4, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenantPackage:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1615, '租户套餐导出', 122, 5, '#', '', '', '', 0, 1, 'F', '1', '1', 'system:tenantPackage:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1701, '租户应用管理', 6, 3, 'tenantApp', 'system/tenantApp/index', 'TenantApp', NULL, 0, 1, 'C', '1', '1', 'system:tenantApp:list', 'app', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '租户应用管理菜单');
INSERT INTO `sys_menu` VALUES (1702, '租户应用管理查询', 1701, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:tenantApp:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1703, '租户应用管理新增', 1701, 2, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:tenantApp:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1704, '租户应用管理修改', 1701, 3, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:tenantApp:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1705, '租户应用管理删除', 1701, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:tenantApp:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1706, '租户应用管理导出', 1701, 5, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:tenantApp:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1710, '敏感词查询', 124, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:sensitiveWord:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1711, '敏感词新增', 124, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:sensitiveWord:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1712, '敏感词修改', 124, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:sensitiveWord:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1713, '敏感词删除', 124, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:sensitiveWord:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1714, '敏感词导出', 124, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:sensitiveWord:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1715, '敏感词导入', 124, 6, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:sensitiveWord:import', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1801, '消息管理', 1, 11, 'messageManage', NULL, NULL, NULL, 0, 1, 'M', '1', '1', NULL, 'chat', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1802, '消息配置', 1801, 1, 'messageConfig', 'system/messageConfig/index', 'MessageConfig', NULL, 0, 1, 'C', '1', '1', 'system:messageConfig:list', 'tools', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '消息配置菜单');
INSERT INTO `sys_menu` VALUES (1803, '消息配置查询', 1802, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageConfig:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1804, '消息配置新增', 1802, 2, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageConfig:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1805, '消息配置修改', 1802, 3, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageConfig:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1806, '消息配置删除', 1802, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageConfig:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1807, '消息配置导出', 1802, 5, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageConfig:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1810, '消息常量', 1801, 2, 'messageKey', 'system/messageKey/index', 'MessageKey', NULL, 0, 1, 'C', '1', '1', 'system:messageKey:list', 'root-list', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '消息常量菜单');
INSERT INTO `sys_menu` VALUES (1811, '消息常量查询', 1810, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageKey:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1812, '消息常量新增', 1810, 2, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageKey:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1813, '消息常量修改', 1810, 3, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageKey:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1814, '消息常量删除', 1810, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageKey:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1815, '消息常量导出', 1810, 5, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageKey:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1820, '消息模板', 1801, 3, 'messageTemplate', 'system/messageTemplate/index', 'MessageTemplate', NULL, 0, 1, 'C', '1', '1', 'system:messageTemplate:list', 'relativity', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '消息模板菜单');
INSERT INTO `sys_menu` VALUES (1821, '消息模板查询', 1820, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageTemplate:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1822, '消息模板新增', 1820, 2, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageTemplate:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1823, '消息模板修改', 1820, 3, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageTemplate:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1824, '消息模板删除', 1820, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageTemplate:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1825, '消息模板导出', 1820, 5, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageTemplate:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1826, '发送测试消息', 1820, 6, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:messageTemplate:test', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1830, '消息发送记录', 1801, 4, 'messageLog', 'system/messageLog/index', 'MessageLog', NULL, 0, 1, 'C', '1', '1', 'system:messageLog:list', 'history', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '消息发送记录菜单');
INSERT INTO `sys_menu` VALUES (1831, '消息发送记录查询', 1830, 1, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageLog:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1832, '消息发送记录删除', 1830, 4, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageLog:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1833, '消息发送记录导出', 1830, 5, '#', '', '', NULL, 0, 1, 'F', '1', '1', 'system:messageLog:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1899, '文件管理', 1, 10, 'storage', NULL, NULL, NULL, 0, 1, 'M', '1', '1', NULL, 'cloud', NULL, NULL, 103, 1, '2026-06-14 12:19:21', 1, '2026-06-14 12:19:21', '');
INSERT INTO `sys_menu` VALUES (1900, '存储配置', 1899, 1, 'storageConfig', 'system/storageConfig/index', 'StorageConfig', '', 0, 1, 'C', '1', '1', 'system:storageConfig:list', 'server', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '存储配置菜单');
INSERT INTO `sys_menu` VALUES (1901, '存储配置查询', 1900, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:storageConfig:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1902, '存储配置新增', 1900, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:storageConfig:add', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1903, '存储配置修改', 1900, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:storageConfig:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1904, '存储配置删除', 1900, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:storageConfig:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1905, '存储配置导出', 1900, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'system:storageConfig:export', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1910, '我的文件', 1899, 2, 'myFile', 'system/myFile/index', 'MyFile', NULL, 0, 1, 'C', '1', '1', '', 'folder-open', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1920, '文件管理', 1899, 3, 'file', 'system/file/index', 'File', NULL, 0, 1, 'C', '1', '1', 'system:file:list', 'sd-card-1', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1921, '文件查询', 1920, 1, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:file:query', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1922, '文件修改', 1920, 2, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:file:edit', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1923, '文件删除', 1920, 3, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:file:remove', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1924, '文件加锁解锁', 1920, 4, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:file:lock', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1925, '文件下载', 1920, 5, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:file:download', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (1926, '文件上传', 1920, 6, '', NULL, NULL, NULL, 0, 1, 'F', '1', '1', 'system:file:upload', '#', NULL, NULL, 103, 1, '2026-06-14 12:19:22', 1, '2026-06-14 12:19:22', '');
INSERT INTO `sys_menu` VALUES (2066474865592020993, '厨具管理', 0, 0, 'kitchenware', NULL, NULL, NULL, 0, 1, 'M', '1', '1', NULL, 'mind-map', NULL, NULL, 103, 1, '2026-06-15 18:56:16', 1, '2026-06-15 18:56:16', '');
INSERT INTO `sys_menu` VALUES (2066475994103066625, '商品', 2066474865592020993, 1, 'goods', 'kitchenware/goods/index', 'Goods', '', 0, 1, 'C', '1', '1', 'kitchenware:goods:list', '#', NULL, NULL, 103, 1, '2026-06-15 19:01:11', NULL, NULL, '商品菜单');
INSERT INTO `sys_menu` VALUES (2066475994103066626, '商品查询', 2066475994103066625, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:goods:query', '#', NULL, NULL, 103, 1, '2026-06-15 19:01:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066475994103066627, '商品新增', 2066475994103066625, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:goods:add', '#', NULL, NULL, 103, 1, '2026-06-15 19:01:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066475994103066628, '商品修改', 2066475994103066625, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:goods:edit', '#', NULL, NULL, 103, 1, '2026-06-15 19:01:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066475994103066629, '商品删除', 2066475994103066625, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:goods:remove', '#', NULL, NULL, 103, 1, '2026-06-15 19:01:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066475994103066630, '商品导出', 2066475994103066625, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:goods:export', '#', NULL, NULL, 103, 1, '2026-06-15 19:01:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066479603393933314, '厨具商品分类', 2066474865592020993, 1, 'category', 'kitchenware/category/index', 'Category', '', 0, 1, 'C', '1', '1', 'kitchenware:category:list', '#', NULL, NULL, 103, 1, '2026-06-15 19:16:13', NULL, NULL, '厨具商品分类菜单');
INSERT INTO `sys_menu` VALUES (2066479603393933315, '厨具商品分类查询', 2066479603393933314, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:category:query', '#', NULL, NULL, 103, 1, '2026-06-15 19:16:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066479603393933316, '厨具商品分类新增', 2066479603393933314, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:category:add', '#', NULL, NULL, 103, 1, '2026-06-15 19:16:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066479603393933317, '厨具商品分类修改', 2066479603393933314, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:category:edit', '#', NULL, NULL, 103, 1, '2026-06-15 19:16:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066479603393933318, '厨具商品分类删除', 2066479603393933314, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:category:remove', '#', NULL, NULL, 103, 1, '2026-06-15 19:16:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066479603393933319, '厨具商品分类导出', 2066479603393933314, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:category:export', '#', NULL, NULL, 103, 1, '2026-06-15 19:16:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066757413186519042, '进货入库单', 2066474865592020993, 1, 'purchase', 'kitchenware/purchase/index', 'Purchase', '', 0, 1, 'C', '1', '1', 'kitchenware:purchase:list', '#', NULL, NULL, 103, 1, '2026-06-16 13:39:40', NULL, NULL, '进货入库单菜单');
INSERT INTO `sys_menu` VALUES (2066757413186519043, '进货入库单查询', 2066757413186519042, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:purchase:query', '#', NULL, NULL, 103, 1, '2026-06-16 13:39:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066757413186519044, '进货入库单新增', 2066757413186519042, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:purchase:add', '#', NULL, NULL, 103, 1, '2026-06-16 13:39:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066757413186519045, '进货入库单修改', 2066757413186519042, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:purchase:edit', '#', NULL, NULL, 103, 1, '2026-06-16 13:39:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066757413186519046, '进货入库单删除', 2066757413186519042, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:purchase:remove', '#', NULL, NULL, 103, 1, '2026-06-16 13:39:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066757413186519047, '进货入库单导出', 2066757413186519042, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:purchase:export', '#', NULL, NULL, 103, 1, '2026-06-16 13:39:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066760742809579521, '供应商管理', 2066474865592020993, 1, 'supplier', 'kitchenware/supplier/index', 'Supplier', '', 0, 1, 'C', '1', '1', 'kitchenware:supplier:list', '#', NULL, NULL, 103, 1, '2026-06-16 13:52:36', 1, '2026-06-16 13:57:37', '供货供应商菜单');
INSERT INTO `sys_menu` VALUES (2066760742809579522, '供货供应商查询', 2066760742809579521, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:supplier:query', '#', NULL, NULL, 103, 1, '2026-06-16 13:52:36', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066760742809579523, '供货供应商新增', 2066760742809579521, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:supplier:add', '#', NULL, NULL, 103, 1, '2026-06-16 13:52:36', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066760742809579524, '供货供应商修改', 2066760742809579521, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:supplier:edit', '#', NULL, NULL, 103, 1, '2026-06-16 13:52:36', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066760742809579525, '供货供应商删除', 2066760742809579521, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:supplier:remove', '#', NULL, NULL, 103, 1, '2026-06-16 13:52:36', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066760742809579526, '供货供应商导出', 2066760742809579521, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:supplier:export', '#', NULL, NULL, 103, 1, '2026-06-16 13:52:36', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066796945181163522, '库存变更流水', 2066474865592020993, 1, 'StockRecord', 'kitchenware/StockRecord/index', 'StockRecord', '', 0, 1, 'C', '1', '1', 'kitchenware:StockRecord:list', '#', NULL, NULL, 103, 1, '2026-06-16 16:17:09', NULL, NULL, '库存变更流水菜单');
INSERT INTO `sys_menu` VALUES (2066796945181163523, '库存变更流水查询', 2066796945181163522, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:StockRecord:query', '#', NULL, NULL, 103, 1, '2026-06-16 16:17:09', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066796945181163524, '库存变更流水新增', 2066796945181163522, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:StockRecord:add', '#', NULL, NULL, 103, 1, '2026-06-16 16:17:09', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066796945181163525, '库存变更流水修改', 2066796945181163522, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:StockRecord:edit', '#', NULL, NULL, 103, 1, '2026-06-16 16:17:09', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066796945181163526, '库存变更流水删除', 2066796945181163522, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:StockRecord:remove', '#', NULL, NULL, 103, 1, '2026-06-16 16:17:09', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2066796945181163527, '库存变更流水导出', 2066796945181163522, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:StockRecord:export', '#', NULL, NULL, 103, 1, '2026-06-16 16:17:09', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067162153632387074, '优惠券模板', 2066474865592020993, 1, 'CouponTemplate', 'kitchenware/CouponTemplate/index', 'CouponTemplate', '', 0, 1, 'C', '1', '1', 'kitchenware:CouponTemplate:list', '#', NULL, NULL, 103, 1, '2026-06-17 16:28:11', NULL, NULL, '优惠券模板菜单');
INSERT INTO `sys_menu` VALUES (2067162153632387075, '优惠券模板查询', 2067162153632387074, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:CouponTemplate:query', '#', NULL, NULL, 103, 1, '2026-06-17 16:28:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067162153632387076, '优惠券模板新增', 2067162153632387074, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:CouponTemplate:add', '#', NULL, NULL, 103, 1, '2026-06-17 16:28:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067162153632387077, '优惠券模板修改', 2067162153632387074, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:CouponTemplate:edit', '#', NULL, NULL, 103, 1, '2026-06-17 16:28:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067162153632387078, '优惠券模板删除', 2067162153632387074, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:CouponTemplate:remove', '#', NULL, NULL, 103, 1, '2026-06-17 16:28:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067162153632387079, '优惠券模板导出', 2067162153632387074, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:CouponTemplate:export', '#', NULL, NULL, 103, 1, '2026-06-17 16:28:11', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067217155377778689, '会员管理', 2066474865592020993, 1, 'member', 'kitchenware/member/index', 'Member', '', 0, 1, 'C', '1', '1', 'kitchenware:member:list', '#', NULL, NULL, 103, 1, '2026-06-17 20:06:15', 1, '2026-06-17 20:11:37', '商城会员菜单');
INSERT INTO `sys_menu` VALUES (2067217155377778690, '商城会员查询', 2067217155377778689, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:member:query', '#', NULL, NULL, 103, 1, '2026-06-17 20:06:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067217155377778691, '商城会员新增', 2067217155377778689, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:member:add', '#', NULL, NULL, 103, 1, '2026-06-17 20:06:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067217155377778692, '商城会员修改', 2067217155377778689, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:member:edit', '#', NULL, NULL, 103, 1, '2026-06-17 20:06:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067217155377778693, '商城会员删除', 2067217155377778689, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:member:remove', '#', NULL, NULL, 103, 1, '2026-06-17 20:06:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067217155377778694, '商城会员导出', 2067217155377778689, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:member:export', '#', NULL, NULL, 103, 1, '2026-06-17 20:06:15', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067228432305164289, '会员收货地址', 2066474865592020993, 1, 'MemberAddress', 'kitchenware/MemberAddress/index', 'MemberAddress', '', 0, 1, 'C', '1', '1', 'kitchenware:MemberAddress:list', '#', NULL, NULL, 103, 1, '2026-06-17 20:51:13', NULL, NULL, '会员收货地址菜单');
INSERT INTO `sys_menu` VALUES (2067228432305164290, '会员收货地址查询', 2067228432305164289, 1, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:MemberAddress:query', '#', NULL, NULL, 103, 1, '2026-06-17 20:51:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067228432305164291, '会员收货地址新增', 2067228432305164289, 2, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:MemberAddress:add', '#', NULL, NULL, 103, 1, '2026-06-17 20:51:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067228432305164292, '会员收货地址修改', 2067228432305164289, 3, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:MemberAddress:edit', '#', NULL, NULL, 103, 1, '2026-06-17 20:51:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067228432305164293, '会员收货地址删除', 2067228432305164289, 4, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:MemberAddress:remove', '#', NULL, NULL, 103, 1, '2026-06-17 20:51:13', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (2067228432305164294, '会员收货地址导出', 2067228432305164289, 5, '#', '', NULL, '', 0, 1, 'F', '1', '1', 'kitchenware:MemberAddress:export', '#', NULL, NULL, 103, 1, '2026-06-17 20:51:13', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_message_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_config`;
CREATE TABLE `sys_message_config`  (
  `message_config_id` bigint NOT NULL COMMENT '消息设置id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `message_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息类型 SMS、MAIL',
  `supplier_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支持平台标识',
  `config_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '配置json',
  `status` tinyint(1) NOT NULL COMMENT '状态（1正常 0停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`message_config_id`) USING BTREE,
  INDEX `idx_message_type`(`message_type` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_message_config
-- ----------------------------

-- ----------------------------
-- Table structure for sys_message_key
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_key`;
CREATE TABLE `sys_message_key`  (
  `message_key_id` bigint NOT NULL COMMENT '消息key主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息名称',
  `message_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息key',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`message_key_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息常量表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_message_key
-- ----------------------------

-- ----------------------------
-- Table structure for sys_message_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_log`;
CREATE TABLE `sys_message_log`  (
  `message_log_id` bigint NOT NULL COMMENT '消息发送记录id',
  `message_template_id` bigint NULL DEFAULT NULL COMMENT '消息模板id',
  `message_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息key',
  `message_template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模板名称',
  `message_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息类型 SMS、MAIL',
  `template_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模板类型 模板id模式、内容模式',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发送账号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `template_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模板ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '发送内容',
  `message_config_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息配置标题',
  `supplier_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台标识',
  `is_success` tinyint(1) NULL DEFAULT NULL COMMENT '是否成功',
  `response_body` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '返回主体消息',
  `log_time` datetime NOT NULL COMMENT '记录时间',
  `cost_time` bigint NULL DEFAULT NULL COMMENT '消耗时间',
  PRIMARY KEY (`message_log_id`) USING BTREE,
  INDEX `idx_message_template_id`(`message_template_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息发送记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_message_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_message_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_template`;
CREATE TABLE `sys_message_template`  (
  `message_template_id` bigint NOT NULL COMMENT '消息模板id',
  `template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板名称',
  `message_config_id` bigint NOT NULL COMMENT '消息配置id',
  `message_key_id` bigint NOT NULL COMMENT '消息key主键',
  `message_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息key',
  `message_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息类型 SMS、MAIL',
  `template_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板类型 模板id模式、内容模式',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `signature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '签名',
  `template_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模板id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `vars_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '输入变量',
  `status` tinyint(1) NOT NULL COMMENT '状态（1正常 0停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`message_template_id`) USING BTREE,
  INDEX `idx_message_key_id`(`message_key_id` ASC) USING BTREE,
  INDEX `idx_message_key`(`message_key` ASC, `message_type` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_message_template
-- ----------------------------

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '公告状态（1正常 0关闭）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '1', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '000000', '维护通知：2018-07-01 系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '1', 103, 1, '2026-06-14 12:19:24', NULL, NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（1正常 0异常）',
  `error_msg` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (2066102364907143169, '000000', 1, '菜单管理', 1, 'org.dromara.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":null,\"menuName\":\"厨具系统\",\"parentId\":0,\"orderNum\":0,\"path\":\"kitchenware\",\"component\":null,\"componentName\":null,\"queryParam\":null,\"isFrame\":0,\"isCache\":1,\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"1\",\"icon\":\"ability-open\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-14 18:16:05', 39);
INSERT INTO `sys_oper_log` VALUES (2066102678154543106, '000000', 1, '菜单管理', 1, 'org.dromara.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":null,\"menuName\":\"商品\",\"parentId\":\"2066102364819062786\",\"orderNum\":0,\"path\":\"goods\",\"component\":null,\"componentName\":null,\"queryParam\":null,\"isFrame\":0,\"isCache\":1,\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"1\",\"icon\":\"apple-filled\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-14 18:17:19', 21);
INSERT INTO `sys_oper_log` VALUES (2066103767591452673, '000000', 1, '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":\"2066102678066462722\",\"menuName\":\"商品\",\"parentId\":\"2066102364819062786\",\"orderNum\":0,\"path\":\"goods\",\"component\":\"kitchenware/goods\",\"componentName\":\"goods\",\"queryParam\":null,\"isFrame\":0,\"isCache\":1,\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"1\",\"icon\":\"apple-filled\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-14 18:21:39', 25);
INSERT INTO `sys_oper_log` VALUES (2066105200709632001, '000000', 1, '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":\"2066102678066462722\",\"menuName\":\"商品\",\"parentId\":\"2066102364819062786\",\"orderNum\":0,\"path\":\"goods\",\"component\":\"kitchenware/goods/index\",\"componentName\":\"goods\",\"queryParam\":null,\"isFrame\":0,\"isCache\":1,\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"1\",\"icon\":\"apple-filled\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-14 18:27:21', 16);
INSERT INTO `sys_oper_log` VALUES (2066472080582553601, '000000', 1, '代码生成', 6, 'org.dromara.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '{\"tables\":\"after_sale,coupon_template,coupon_user,goods,goods_category,goods_sku,purchase,purchase_item,sale_order,sale_order_item,stock_record,supplier\",\"dataName\":\"master\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:45:12', 625);
INSERT INTO `sys_oper_log` VALUES (2066472574101139458, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079013883905\",\"dataName\":\"master\",\"tableName\":\"goods\",\"tableComment\":\"商品SPU主表\",\"className\":\"Goods\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods\",\"functionName\":\"商品SPU主\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":0,\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079122935810\",\"tableId\":\"2066472079013883905\",\"columnName\":\"id\",\"columnComment\":\"商品SPU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:47:09\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079122935811\",\"tableId\":\"2066472079013883905\",\"columnName\":\"category_id\",\"columnComment\":\"所属分类ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"categoryId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:47:09\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryId\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935812\",\"tableId\":\"2066472079013883905\",\"columnName\":\"goods_name\",\"columnComment\":\"商品名称\",\"columnType\":\"varchar(60)\",\"javaType\":\"String\",\"javaField\":\"goodsName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:47:09\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"goodsName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935813\",\"tableId\":\"2066472079013883905\",\"columnName\":\"brand\",\"columnComment\":\"品牌\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"brand\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:47:09\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"brand\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935814\",\"tableId\":\"2066472079013883905\",\"columnName\":\"detail\",\"columnComment\":\"商品详情介绍\",\"columnType\":\"text\",\"javaType\":\"String\",\"javaField\":\"detail\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:47:09\",\"queryType\":\"EQ\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:47:10', 87);
INSERT INTO `sys_oper_log` VALUES (2066472812316635137, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079013883905\"}', '', 1, '', '2026-06-15 18:48:06', 389);
INSERT INTO `sys_oper_log` VALUES (2066473095172108289, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2066102678066462722', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520553720\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:49:14', 23);
INSERT INTO `sys_oper_log` VALUES (2066473306363703298, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2000', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520603788\"}', '', 0, '存在子菜单,不允许删除', '2026-06-15 18:50:04', 6);
INSERT INTO `sys_oper_log` VALUES (2066473328035672065, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2001', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520608972\"}', '', 0, '菜单已分配,不允许删除', '2026-06-15 18:50:09', 3);
INSERT INTO `sys_oper_log` VALUES (2066473373426429954, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2005', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520619788\"}', '', 0, '菜单已分配,不允许删除', '2026-06-15 18:50:20', 4);
INSERT INTO `sys_oper_log` VALUES (2066473685683974145, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2066102364819062786', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520694191\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:51:35', 39);
INSERT INTO `sys_oper_log` VALUES (2066473699802001410, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2000', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520697600\"}', '', 0, '存在子菜单,不允许删除', '2026-06-15 18:51:38', 2);
INSERT INTO `sys_oper_log` VALUES (2066473964336754690, '000000', 1, '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2100', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781520760668\"}', '', 0, '存在子菜单,不允许删除', '2026-06-15 18:52:41', 2);
INSERT INTO `sys_oper_log` VALUES (2066474865654935553, '000000', 1, '菜单管理', 1, 'org.dromara.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":null,\"menuName\":\"厨具管理\",\"parentId\":0,\"orderNum\":0,\"path\":\"kitchenware\",\"component\":null,\"componentName\":null,\"queryParam\":null,\"isFrame\":0,\"isCache\":1,\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"1\",\"icon\":\"mind-map\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:56:16', 26);
INSERT INTO `sys_oper_log` VALUES (2066474944193277953, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079013883905\",\"dataName\":\"master\",\"tableName\":\"goods\",\"tableComment\":\"商品SPU主表\",\"className\":\"Goods\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods\",\"functionName\":\"商品SPU主\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079122935810\",\"tableId\":\"2066472079013883905\",\"columnName\":\"id\",\"columnComment\":\"商品SPU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:34\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079122935811\",\"tableId\":\"2066472079013883905\",\"columnName\":\"category_id\",\"columnComment\":\"所属分类ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"categoryId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:34\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryId\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935812\",\"tableId\":\"2066472079013883905\",\"columnName\":\"goods_name\",\"columnComment\":\"商品名称\",\"columnType\":\"varchar(60)\",\"javaType\":\"String\",\"javaField\":\"goodsName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:34\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"goodsName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935813\",\"tableId\":\"2066472079013883905\",\"columnName\":\"brand\",\"columnComment\":\"品牌\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"brand\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:34\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"brand\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935814\",\"tableId\":\"2066472079013883905\",\"columnName\":\"detail\",\"columnComment\":\"商品详情介绍\",\"columnType\":\"text\",\"javaType\":\"String\",\"javaField\":\"detail\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:5', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:56:35', 26);
INSERT INTO `sys_oper_log` VALUES (2066475008928165890, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079013883905\",\"dataName\":\"master\",\"tableName\":\"goods\",\"tableComment\":\"商品SPU主表\",\"className\":\"Goods\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods\",\"functionName\":\"商品\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079122935810\",\"tableId\":\"2066472079013883905\",\"columnName\":\"id\",\"columnComment\":\"商品SPU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:50\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079122935811\",\"tableId\":\"2066472079013883905\",\"columnName\":\"category_id\",\"columnComment\":\"所属分类ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"categoryId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:50\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryId\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935812\",\"tableId\":\"2066472079013883905\",\"columnName\":\"goods_name\",\"columnComment\":\"商品名称\",\"columnType\":\"varchar(60)\",\"javaType\":\"String\",\"javaField\":\"goodsName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:50\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"goodsName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935813\",\"tableId\":\"2066472079013883905\",\"columnName\":\"brand\",\"columnComment\":\"品牌\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"brand\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:50\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"brand\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935814\",\"tableId\":\"2066472079013883905\",\"columnName\":\"detail\",\"columnComment\":\"商品详情介绍\",\"columnType\":\"text\",\"javaType\":\"String\",\"javaField\":\"detail\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:56:50', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:56:50', 20);
INSERT INTO `sys_oper_log` VALUES (2066475101928468482, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079013883905\",\"dataName\":\"master\",\"tableName\":\"goods\",\"tableComment\":\"商品表\",\"className\":\"Goods\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods\",\"functionName\":\"商品\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079122935810\",\"tableId\":\"2066472079013883905\",\"columnName\":\"id\",\"columnComment\":\"商品SPU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:57:12\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079122935811\",\"tableId\":\"2066472079013883905\",\"columnName\":\"category_id\",\"columnComment\":\"所属分类ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"categoryId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:57:12\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryId\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935812\",\"tableId\":\"2066472079013883905\",\"columnName\":\"goods_name\",\"columnComment\":\"商品名称\",\"columnType\":\"varchar(60)\",\"javaType\":\"String\",\"javaField\":\"goodsName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:57:12\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"goodsName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935813\",\"tableId\":\"2066472079013883905\",\"columnName\":\"brand\",\"columnComment\":\"品牌\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"brand\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:57:12\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"brand\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935814\",\"tableId\":\"2066472079013883905\",\"columnName\":\"detail\",\"columnComment\":\"商品详情介绍\",\"columnType\":\"text\",\"javaType\":\"String\",\"javaField\":\"detail\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 18:57:12\",\"q', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 18:57:12', 16);
INSERT INTO `sys_oper_log` VALUES (2066475242869665794, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079307485193\"}', '', 1, '', '2026-06-15 18:57:46', 121);
INSERT INTO `sys_oper_log` VALUES (2066475994556051457, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079013883905\"}', '', 1, '', '2026-06-15 19:00:45', 111);
INSERT INTO `sys_oper_log` VALUES (2066478314454953986, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"商品上架状态\",\"dictType\":\"kitchenware_goods_status\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:09:58', 46);
INSERT INTO `sys_oper_log` VALUES (2066478507594264578, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"上架\",\"dictValue\":\"1\",\"dictType\":\"kitchenware_goods_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:10:44', 18);
INSERT INTO `sys_oper_log` VALUES (2066478554490777601, '000000', 1, '字典数据', 2, 'org.dromara.system.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":\"2066478507527155714\",\"dictSort\":0,\"dictLabel\":\"上架\",\"dictValue\":\"1\",\"dictType\":\"kitchenware_goods_status\",\"cssClass\":null,\"listClass\":\"success\",\"tagStyle\":null,\"isDefault\":\"N\",\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:10:55', 43);
INSERT INTO `sys_oper_log` VALUES (2066478662812872705, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":1,\"dictLabel\":\"下架\",\"dictValue\":\"0\",\"dictType\":\"kitchenware_goods_status\",\"cssClass\":null,\"listClass\":\"default\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:11:21', 41);
INSERT INTO `sys_oper_log` VALUES (2066479032544964609, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079013883905\",\"dataName\":\"master\",\"tableName\":\"goods\",\"tableComment\":\"商品表\",\"className\":\"Goods\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods\",\"functionName\":\"商品\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079122935810\",\"tableId\":\"2066472079013883905\",\"columnName\":\"id\",\"columnComment\":\"商品SPU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:12:49\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079122935811\",\"tableId\":\"2066472079013883905\",\"columnName\":\"category_id\",\"columnComment\":\"所属分类ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"categoryId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:12:49\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryId\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935812\",\"tableId\":\"2066472079013883905\",\"columnName\":\"goods_name\",\"columnComment\":\"商品名称\",\"columnType\":\"varchar(60)\",\"javaType\":\"String\",\"javaField\":\"goodsName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:12:49\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"goodsName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935813\",\"tableId\":\"2066472079013883905\",\"columnName\":\"brand\",\"columnComment\":\"品牌\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"brand\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:12:49\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"brand\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935814\",\"tableId\":\"2066472079013883905\",\"columnName\":\"detail\",\"columnComment\":\"商品详情介绍\",\"columnType\":\"text\",\"javaType\":\"String\",\"javaField\":\"detail\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:12:49\",\"q', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:12:49', 29);
INSERT INTO `sys_oper_log` VALUES (2066479546137489410, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079185850369\",\"dataName\":\"master\",\"tableName\":\"goods_category\",\"tableComment\":\"厨具商品分类\",\"className\":\"GoodsCategory\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"category\",\"functionName\":\"厨具商品分类\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079248764929\",\"tableId\":\"2066472079185850369\",\"columnName\":\"id\",\"columnComment\":\"分类主键ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:14:51\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079248764930\",\"tableId\":\"2066472079185850369\",\"columnName\":\"category_name\",\"columnComment\":\"分类名称\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"categoryName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:14:51\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079307485186\",\"tableId\":\"2066472079185850369\",\"columnName\":\"sort\",\"columnComment\":\"排序权重\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"sort\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:14:51\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"sort\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079307485187\",\"tableId\":\"2066472079185850369\",\"columnName\":\"remark\",\"columnComment\":\"备注说明\",\"columnType\":\"varchar(200)\",\"javaType\":\"String\",\"javaField\":\"remark\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:14:51\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"remark\",\"increment\":false,\"usableColumn\":true,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":false,\"insert\":true},{\"columnId\":\"2066472079307485188\",\"tableId\":\"2066472079185850369\",\"columnName\":\"create_by\",\"columnComment\":\"创建人ID(sys_user.id)\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"createBy\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:14:52', 44);
INSERT INTO `sys_oper_log` VALUES (2066479603930804226, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079185850369\"}', '', 1, '', '2026-06-15 19:15:06', 124);
INSERT INTO `sys_oper_log` VALUES (2066484869464240130, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079013883905\",\"dataName\":\"master\",\"tableName\":\"goods\",\"tableComment\":\"商品表\",\"className\":\"Goods\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods\",\"functionName\":\"商品\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079122935810\",\"tableId\":\"2066472079013883905\",\"columnName\":\"id\",\"columnComment\":\"商品SPU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:36:00\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"capJavaField\":\"id\",\"increment\":true,\"usableColumn\":false,\"edit\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"insert\":false},{\"columnId\":\"2066472079122935811\",\"tableId\":\"2066472079013883905\",\"columnName\":\"category_id\",\"columnComment\":\"所属分类ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"categoryId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:36:00\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"categoryId\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935812\",\"tableId\":\"2066472079013883905\",\"columnName\":\"goods_name\",\"columnComment\":\"商品名称\",\"columnType\":\"varchar(60)\",\"javaType\":\"String\",\"javaField\":\"goodsName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:36:00\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"goodsName\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935813\",\"tableId\":\"2066472079013883905\",\"columnName\":\"brand\",\"columnComment\":\"品牌\",\"columnType\":\"varchar(30)\",\"javaType\":\"String\",\"javaField\":\"brand\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:36:00\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"capJavaField\":\"brand\",\"increment\":false,\"usableColumn\":false,\"edit\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"insert\":true},{\"columnId\":\"2066472079122935814\",\"tableId\":\"2066472079013883905\",\"columnName\":\"detail\",\"columnComment\":\"商品详情介绍\",\"columnType\":\"text\",\"javaType\":\"String\",\"javaField\":\"detail\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 19:36:00\",\"queryTy', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 19:36:01', 17);
INSERT INTO `sys_oper_log` VALUES (2066495651837030402, '000000', 1, '文件存储', 1, 'org.dromara.system.controller.system.SysFileController.upload()', 'POST', 1, 'admin', '研发部门', '/system/file/upload', '0:0:0:0:0:0:0:1', '内网IP', '{\"fileCategoryId\":\"\",\"length\":\"1\"}', '', 0, 'Cannot invoke \"org.dromara.common.storage.balancer.FileServer.getPlatform()\" because \"server\" is null', '2026-06-15 20:18:52', 14);
INSERT INTO `sys_oper_log` VALUES (2066495686700085250, '000000', 1, '文件存储', 1, 'org.dromara.system.controller.system.SysFileController.upload()', 'POST', 1, 'admin', '研发部门', '/system/file/upload', '0:0:0:0:0:0:0:1', '内网IP', '{\"fileCategoryId\":\"\",\"length\":\"1\"}', '', 0, 'Cannot invoke \"org.dromara.common.storage.balancer.FileServer.getPlatform()\" because \"server\" is null', '2026-06-15 20:19:00', 2);
INSERT INTO `sys_oper_log` VALUES (2066497664352169986, '000000', 1, '存储配置', 1, 'org.dromara.system.controller.system.SysStorageConfigController.add()', 'POST', 1, 'admin', '研发部门', '/system/storageConfig', '0:0:0:0:0:0:0:1', '内网IP', '{\"storageConfigId\":null,\"name\":\"本地\",\"platform\":\"local_plus\",\"weight\":1,\"status\":1,\"configJson\":\"{\\\"storagePath\\\":\\\"D:/local_file\\\"}\",\"requestMode\":\"proxy\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 20:26:52', 31);
INSERT INTO `sys_oper_log` VALUES (2066497733801455618, '000000', 1, '文件存储', 1, 'org.dromara.system.controller.system.SysFileController.upload()', 'POST', 1, 'admin', '研发部门', '/system/file/upload', '0:0:0:0:0:0:0:1', '内网IP', '{\"fileCategoryId\":\"\",\"length\":\"1\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"filename\":\"6a2fef9b61ade0e7f66f4e21.jpg\",\"fileId\":\"2066497732564135938\",\"previewUrl\":\"/resource/file/preview/f986a409bdb4ae30e3707a4778b1da1f/6a2fef9b61ade0e7f66f4e21.jpg\",\"downloadUrl\":\"/resource/file/download/f986a409bdb4ae30e3707a4778b1da1f/6a2fef9b61ade0e7f66f4e21.jpg\"}}', 1, '', '2026-06-15 20:27:08', 442);
INSERT INTO `sys_oper_log` VALUES (2066500633101512706, '000000', 1, '文件存储', 1, 'org.dromara.system.controller.system.SysFileController.upload()', 'POST', 1, 'admin', '研发部门', '/system/file/upload', '0:0:0:0:0:0:0:1', '内网IP', '{\"fileCategoryId\":\"\",\"length\":\"1\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"filename\":\"6a2ff24f61ade0e7f66f4e22.png\",\"fileId\":\"2066500633063763970\",\"previewUrl\":\"/resource/file/preview/f986a409bdb4ae30e3707a4778b1da1f/6a2ff24f61ade0e7f66f4e22.png\",\"downloadUrl\":\"/resource/file/download/f986a409bdb4ae30e3707a4778b1da1f/6a2ff24f61ade0e7f66f4e22.png\"}}', 1, '', '2026-06-15 20:38:39', 18);
INSERT INTO `sys_oper_log` VALUES (2066502757940097025, '000000', 1, '商品', 1, 'org.dromara.kitchenware.controller.GoodsController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/goods', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"categoryId\":2,\"goodsName\":\"5Cr15 家用不锈钢切片刀\",\"brand\":\"锐厨\",\"detail\":null,\"mainImg\":\"2066500633063763970\",\"slideImages\":null,\"detailImg\":null,\"status\":1}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 20:47:06', 38);
INSERT INTO `sys_oper_log` VALUES (2066504869499531265, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079307485193\",\"dataName\":\"master\",\"tableName\":\"goods_sku\",\"tableComment\":\"商品规格SKU\",\"className\":\"GoodsSku\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"goods_sku\",\"functionName\":\"商品规格SKU\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":0,\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079441702914\",\"tableId\":\"2066472079307485193\",\"columnName\":\"id\",\"columnComment\":\"SKU主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 20:55:29\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"edit\":false,\"sorting\":false,\"query\":false,\"detail\":false,\"insert\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"id\"},{\"columnId\":\"2066472079441702915\",\"tableId\":\"2066472079307485193\",\"columnName\":\"goods_id\",\"columnComment\":\"商品id\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"goodsId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 20:55:29\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"edit\":true,\"sorting\":false,\"query\":true,\"detail\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"goodsId\"},{\"columnId\":\"2066472079441702916\",\"tableId\":\"2066472079307485193\",\"columnName\":\"sku_attr\",\"columnComment\":\"规格JSON 如{\\\"材质\\\":\\\"304不锈钢\\\",\\\"尺寸\\\":\\\"32cm\\\"}\",\"columnType\":\"varchar(500)\",\"javaType\":\"String\",\"javaField\":\"skuAttr\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 20:55:29\",\"queryType\":\"EQ\",\"htmlType\":\"textarea\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"edit\":true,\"sorting\":false,\"query\":true,\"detail\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"skuAttr\"},{\"columnId\":\"2066472079441702917\",\"tableId\":\"2066472079307485193\",\"columnName\":\"sku_code\",\"columnComment\":\"货号条码\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"skuCode\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-15 20:55:29\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"edit\":true,\"sorting\":false,\"query\":true,\"detail\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"skuCode\"},{\"columnId\":\"2066472079441702918\",\"tableId\":\"2066472079307485193\",\"columnName\":\"unit\",\"columnComment\":\"单位 个/套/把\",\"columnType\":\"varchar(10)\",\"javaType\":\"String\",\"javaField\":\"unit\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"up', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 20:55:29', 57);
INSERT INTO `sys_oper_log` VALUES (2066505005256568833, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079307485193\"}', '', 1, '', '2026-06-15 20:56:02', 145);
INSERT INTO `sys_oper_log` VALUES (2066510137289555969, '000000', 1, '商品规格SKU', 1, 'org.dromara.kitchenware.controller.GoodsSkuController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/goods_sku', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"goodsId\":1,\"skuAttr\":\"{\\\"刀身材质\\\":\\\"5Cr15MoV 不锈钢\\\",\\\"刃长\\\":\\\"19cm\\\",\\\"手柄\\\":\\\"实木原木手柄\\\",\\\"重量\\\":\\\"280g\\\"}\",\"skuCode\":\"692000010001\",\"unit\":\"把\",\"stockNum\":132,\"safeStock\":5,\"purchasePrice\":\"18\",\"salePrice\":\"46\",\"picUrl\":null,\"status\":1}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-15 21:16:25', 32);
INSERT INTO `sys_oper_log` VALUES (2066756786335203329, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079500423173\",\"dataName\":\"master\",\"tableName\":\"purchase\",\"tableComment\":\"进货入库单\",\"className\":\"Purchase\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"purchase\",\"functionName\":\"进货入库单\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079634640897\",\"tableId\":\"2066472079500423173\",\"columnName\":\"id\",\"columnComment\":\"入库单主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:36:30\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"superColumn\":false,\"usableColumn\":false,\"increment\":true,\"capJavaField\":\"id\",\"query\":false,\"insert\":false,\"sorting\":false,\"detail\":false,\"edit\":false,\"required\":true,\"list\":false,\"pk\":true},{\"columnId\":\"2066472079634640898\",\"tableId\":\"2066472079500423173\",\"columnName\":\"supplier_id\",\"columnComment\":\"供应商ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"supplierId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:36:30\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"supplierId\",\"query\":true,\"insert\":true,\"sorting\":false,\"detail\":true,\"edit\":true,\"required\":true,\"list\":true,\"pk\":false},{\"columnId\":\"2066472079634640899\",\"tableId\":\"2066472079500423173\",\"columnName\":\"operator_id\",\"columnComment\":\"操作员工sys_user.id\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"operatorId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:36:30\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"operatorId\",\"query\":true,\"insert\":true,\"sorting\":false,\"detail\":true,\"edit\":true,\"required\":true,\"list\":true,\"pk\":false},{\"columnId\":\"2066472079634640900\",\"tableId\":\"2066472079500423173\",\"columnName\":\"total_amount\",\"columnComment\":\"单据总金额\",\"columnType\":\"decimal(12,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"totalAmount\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:36:30\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"totalAmount\",\"query\":true,\"insert\":true,\"sorting\":false,\"detail\":true,\"edit\":true,\"required\":true,\"list\":true,\"pk\":false},{\"columnId\":\"2066472079634640901\",\"tableId\":\"2066472079500423173\",\"columnName\":\"pay_status\",\"columnComment\":\"0未付款 1已结清\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"payStatus\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:36:31', 81);
INSERT INTO `sys_oper_log` VALUES (2066756999846248450, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079500423173\",\"dataName\":\"master\",\"tableName\":\"purchase\",\"tableComment\":\"进货入库单\",\"className\":\"Purchase\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"purchase\",\"functionName\":\"进货入库单\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079634640897\",\"tableId\":\"2066472079500423173\",\"columnName\":\"id\",\"columnComment\":\"入库单主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:37:21\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"superColumn\":false,\"usableColumn\":false,\"increment\":true,\"capJavaField\":\"id\",\"query\":false,\"insert\":false,\"sorting\":false,\"detail\":false,\"edit\":false,\"required\":true,\"list\":false,\"pk\":true},{\"columnId\":\"2066472079634640898\",\"tableId\":\"2066472079500423173\",\"columnName\":\"supplier_id\",\"columnComment\":\"供应商ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"supplierId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:37:21\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"supplierId\",\"query\":true,\"insert\":true,\"sorting\":false,\"detail\":true,\"edit\":true,\"required\":true,\"list\":true,\"pk\":false},{\"columnId\":\"2066472079634640899\",\"tableId\":\"2066472079500423173\",\"columnName\":\"operator_id\",\"columnComment\":\"操作员工sys_user.id\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"operatorId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:37:21\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"operatorId\",\"query\":true,\"insert\":true,\"sorting\":false,\"detail\":true,\"edit\":true,\"required\":true,\"list\":true,\"pk\":false},{\"columnId\":\"2066472079634640900\",\"tableId\":\"2066472079500423173\",\"columnName\":\"total_amount\",\"columnComment\":\"单据总金额\",\"columnType\":\"decimal(12,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"totalAmount\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:37:21\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"totalAmount\",\"query\":true,\"insert\":true,\"sorting\":false,\"detail\":true,\"edit\":true,\"required\":true,\"list\":true,\"pk\":false},{\"columnId\":\"2066472079634640901\",\"tableId\":\"2066472079500423173\",\"columnName\":\"pay_status\",\"columnComment\":\"0未付款 1已结清\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"payStatus\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:37:22', 33);
INSERT INTO `sys_oper_log` VALUES (2066757413551423489, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079500423173\"}', '', 1, '', '2026-06-16 13:39:01', 89);
INSERT INTO `sys_oper_log` VALUES (2066759072507686914, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079500423173\",\"dataName\":\"master\",\"tableName\":\"purchase\",\"tableComment\":\"进货入库单\",\"className\":\"Purchase\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"purchase\",\"functionName\":\"进货入库单\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079634640897\",\"tableId\":\"2066472079500423173\",\"columnName\":\"id\",\"columnComment\":\"入库单主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:45:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"superColumn\":false,\"required\":true,\"list\":false,\"pk\":true,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"id\",\"edit\":false,\"insert\":false,\"query\":false,\"sorting\":false,\"detail\":false},{\"columnId\":\"2066472079634640898\",\"tableId\":\"2066472079500423173\",\"columnName\":\"supplier_id\",\"columnComment\":\"供应商ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"supplierId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:45:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"superColumn\":false,\"required\":true,\"list\":true,\"pk\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"supplierId\",\"edit\":true,\"insert\":true,\"query\":true,\"sorting\":false,\"detail\":true},{\"columnId\":\"2066472079634640899\",\"tableId\":\"2066472079500423173\",\"columnName\":\"operator_id\",\"columnComment\":\"操作员工sys_user.id\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"operatorId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:45:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"superColumn\":false,\"required\":true,\"list\":true,\"pk\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"operatorId\",\"edit\":true,\"insert\":true,\"query\":true,\"sorting\":false,\"detail\":true},{\"columnId\":\"2066472079634640900\",\"tableId\":\"2066472079500423173\",\"columnName\":\"total_amount\",\"columnComment\":\"单据总金额\",\"columnType\":\"decimal(12,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"totalAmount\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:45:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"superColumn\":false,\"required\":true,\"list\":true,\"pk\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"totalAmount\",\"edit\":true,\"insert\":true,\"query\":true,\"sorting\":false,\"detail\":true},{\"columnId\":\"2066472079634640901\",\"tableId\":\"2066472079500423173\",\"columnName\":\"pay_status\",\"columnComment\":\"0未付款 1已结清\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"payStatus\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:45:36', 67);
INSERT INTO `sys_oper_log` VALUES (2066759885670002689, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"进货状态\",\"dictType\":\"purchase_status\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:48:50', 42);
INSERT INTO `sys_oper_log` VALUES (2066759947154305026, '000000', 1, '字典类型', 2, 'org.dromara.system.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":\"2066759885485453314\",\"dictName\":\"进货状态\",\"dictType\":\"kitchenware_purchase_status\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:49:05', 38);
INSERT INTO `sys_oper_log` VALUES (2066760672064253953, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472080330895364\",\"dataName\":\"master\",\"tableName\":\"supplier\",\"tableComment\":\"供货供应商\",\"className\":\"Supplier\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"supplier\",\"functionName\":\"供货供应商\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472080393809922\",\"tableId\":\"2066472080330895364\",\"columnName\":\"id\",\"columnComment\":\"供应商ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:51:57\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"usableColumn\":false,\"increment\":true,\"capJavaField\":\"id\",\"query\":false,\"edit\":false,\"insert\":false,\"detail\":false,\"sorting\":false},{\"columnId\":\"2066472080456724482\",\"tableId\":\"2066472080330895364\",\"columnName\":\"supplier_name\",\"columnComment\":\"厂商名称\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"supplierName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:51:57\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"supplierName\",\"query\":true,\"edit\":true,\"insert\":true,\"detail\":true,\"sorting\":false},{\"columnId\":\"2066472080456724483\",\"tableId\":\"2066472080330895364\",\"columnName\":\"contact\",\"columnComment\":\"对接联系人\",\"columnType\":\"varchar(20)\",\"javaType\":\"String\",\"javaField\":\"contact\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:51:57\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"contact\",\"query\":true,\"edit\":true,\"insert\":true,\"detail\":true,\"sorting\":false},{\"columnId\":\"2066472080456724484\",\"tableId\":\"2066472080330895364\",\"columnName\":\"phone\",\"columnComment\":\"联系电话\",\"columnType\":\"varchar(11)\",\"javaType\":\"String\",\"javaField\":\"phone\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:51:57\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"increment\":false,\"capJavaField\":\"phone\",\"query\":true,\"edit\":true,\"insert\":true,\"detail\":true,\"sorting\":false},{\"columnId\":\"2066472080456724485\",\"tableId\":\"2066472080330895364\",\"columnName\":\"address\",\"columnComment\":\"厂商地址\",\"columnType\":\"varchar(200)\",\"javaType\":\"String\",\"javaField\":\"address\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"20', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:51:57', 61);
INSERT INTO `sys_oper_log` VALUES (2066760743715549186, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472080330895364\"}', '', 1, '', '2026-06-16 13:52:15', 220);
INSERT INTO `sys_oper_log` VALUES (2066761919055978497, '000000', 1, '供货供应商', 1, 'org.dromara.kitchenware.controller.SupplierController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/supplier', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierName\":\"阳江砺锋五金刀具有限公司\",\"contact\":\"黄经理\",\"phone\":\"13866229051\",\"address\":\"广东省阳江市江城区五金刀剪产业园 A12 栋\",\"remark\":\"主营 5Cr15MoV 不锈钢家用刀具、锻打切片刀、砍骨刀，支持批量定制 logo，交货周期 3-7 天\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:56:55', 53);
INSERT INTO `sys_oper_log` VALUES (2066762098043707393, '000000', 1, '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":\"2066760742809579521\",\"menuName\":\"供应商管理\",\"parentId\":\"2066474865592020993\",\"orderNum\":1,\"path\":\"supplier\",\"component\":\"kitchenware/supplier/index\",\"componentName\":\"Supplier\",\"queryParam\":\"\",\"isFrame\":0,\"isCache\":1,\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"1\",\"perms\":\"kitchenware:supplier:list\",\"icon\":\"#\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":\"供货供应商菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:57:37', 24);
INSERT INTO `sys_oper_log` VALUES (2066762675624534018, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079634640909\",\"dataName\":\"master\",\"tableName\":\"purchase_item\",\"tableComment\":\"入库商品明细\",\"className\":\"PurchaseItem\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"item\",\"functionName\":\"入库商品明细\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":0,\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079764664321\",\"tableId\":\"2066472079634640909\",\"columnName\":\"id\",\"columnComment\":\"明细主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:59:55\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"list\":false,\"pk\":true,\"superColumn\":false,\"detail\":false,\"insert\":false,\"edit\":false,\"query\":false,\"sorting\":false,\"increment\":true,\"capJavaField\":\"id\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664322\",\"tableId\":\"2066472079634640909\",\"columnName\":\"purchase_id\",\"columnComment\":\"入库单ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"purchaseId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:59:55\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"insert\":true,\"edit\":true,\"query\":true,\"sorting\":false,\"increment\":false,\"capJavaField\":\"purchaseId\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664323\",\"tableId\":\"2066472079634640909\",\"columnName\":\"sku_id\",\"columnComment\":\"商品SKU\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"skuId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:59:55\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"insert\":true,\"edit\":true,\"query\":true,\"sorting\":false,\"increment\":false,\"capJavaField\":\"skuId\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664324\",\"tableId\":\"2066472079634640909\",\"columnName\":\"buy_num\",\"columnComment\":\"采购数量\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"buyNum\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:59:55\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"insert\":true,\"edit\":true,\"query\":true,\"sorting\":false,\"increment\":false,\"capJavaField\":\"buyNum\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664325\",\"tableId\":\"2066472079634640909\",\"columnName\":\"buy_price\",\"columnComment\":\"单件进价\",\"columnType\":\"decimal(10,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"buyPrice\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 13:59:55\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 13:59:55', 65);
INSERT INTO `sys_oper_log` VALUES (2066762738086109186, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472079634640909\"}', '', 1, '', '2026-06-16 14:00:10', 91);
INSERT INTO `sys_oper_log` VALUES (2066763737169321986, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472079634640909\",\"dataName\":\"master\",\"tableName\":\"purchase_item\",\"tableComment\":\"入库商品明细\",\"className\":\"PurchaseItem\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"purchaseItem\",\"functionName\":\"入库商品明细\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":0,\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472079764664321\",\"tableId\":\"2066472079634640909\",\"columnName\":\"id\",\"columnComment\":\"明细主键\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 14:04:08\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"list\":false,\"pk\":true,\"superColumn\":false,\"detail\":false,\"insert\":false,\"edit\":false,\"query\":false,\"sorting\":false,\"increment\":true,\"capJavaField\":\"id\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664322\",\"tableId\":\"2066472079634640909\",\"columnName\":\"purchase_id\",\"columnComment\":\"入库单ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"purchaseId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 14:04:08\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"insert\":true,\"edit\":true,\"query\":true,\"sorting\":false,\"increment\":false,\"capJavaField\":\"purchaseId\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664323\",\"tableId\":\"2066472079634640909\",\"columnName\":\"sku_id\",\"columnComment\":\"商品SKU\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"skuId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 14:04:08\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"insert\":true,\"edit\":true,\"query\":true,\"sorting\":false,\"increment\":false,\"capJavaField\":\"skuId\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664324\",\"tableId\":\"2066472079634640909\",\"columnName\":\"buy_num\",\"columnComment\":\"采购数量\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"buyNum\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 14:04:08\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"insert\":true,\"edit\":true,\"query\":true,\"sorting\":false,\"increment\":false,\"capJavaField\":\"buyNum\",\"usableColumn\":false,\"required\":true},{\"columnId\":\"2066472079764664325\",\"tableId\":\"2066472079634640909\",\"columnName\":\"buy_price\",\"columnComment\":\"单件进价\",\"columnType\":\"decimal(10,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"buyPrice\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 1', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 14:04:08', 34);
INSERT INTO `sys_oper_log` VALUES (2066767624001474561, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"未付款\",\"dictValue\":\"0\",\"dictType\":\"kitchenware_purchase_status\",\"cssClass\":null,\"listClass\":\"default\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 14:19:35', 41);
INSERT INTO `sys_oper_log` VALUES (2066767676761624577, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"已结清\",\"dictValue\":\"1\",\"dictType\":\"kitchenware_purchase_status\",\"cssClass\":null,\"listClass\":\"success\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 14:19:47', 21);
INSERT INTO `sys_oper_log` VALUES (2066775414153596930, '000000', 1, '进货入库单', 1, 'org.dromara.kitchenware.controller.PurchaseController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"10\",\"payStatus\":0,\"purchaseTime\":\"2026-06-17 00:00:00\",\"note\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 14:50:32', 32);
INSERT INTO `sys_oper_log` VALUES (2066781432086450177, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"sku状态\",\"dictType\":\"kitchenware_sku_status\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 15:14:27', 33);
INSERT INTO `sys_oper_log` VALUES (2066781497672781825, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"停用\",\"dictValue\":\"0\",\"dictType\":\"kitchenware_sku_status\",\"cssClass\":null,\"listClass\":\"danger\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 15:14:43', 12);
INSERT INTO `sys_oper_log` VALUES (2066781550206439426, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"启用\",\"dictValue\":\"1\",\"dictType\":\"kitchenware_sku_status\",\"cssClass\":null,\"listClass\":\"success\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 15:14:55', 18);
INSERT INTO `sys_oper_log` VALUES (2066781801906622466, '000000', 1, '进货入库单', 1, 'org.dromara.kitchenware.controller.PurchaseController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"10\",\"payStatus\":0,\"purchaseTime\":\"2026-06-17 00:00:00\",\"note\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 15:15:55', 17);
INSERT INTO `sys_oper_log` VALUES (2066784155053772802, '000000', 1, '进货入库单', 1, 'org.dromara.kitchenware.controller.PurchaseController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"1110\",\"payStatus\":1,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":1,\"purchaseId\":3,\"skuId\":1,\"buyNum\":1,\"buyPrice\":\"1110\",\"subtotal\":\"1110\",\"createBy\":1,\"createTime\":\"2026-06-16 15:25:16\",\"updateBy\":1,\"updateTime\":\"2026-06-16 15:25:16\",\"delFlag\":\"0\"}]}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 15:25:16', 45);
INSERT INTO `sys_oper_log` VALUES (2066786856634339329, '000000', 1, '进货入库单', 2, 'org.dromara.kitchenware.controller.PurchaseController.edit()', 'PUT', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":3,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"6660\",\"payStatus\":1,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":1,\"purchaseId\":3,\"skuId\":1,\"buyNum\":6,\"buyPrice\":\"1110.00\",\"subtotal\":\"6660\",\"createBy\":1,\"createTime\":\"2026-06-16 15:35:59\",\"updateBy\":1,\"updateTime\":\"2026-06-16 15:35:59\",\"delFlag\":\"0\"}]}', '', 0, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\r\n### The error may exist in org/dromara/kitchenware/mapper/PurchaseItemMapper.java (best guess)\r\n### The error may involve org.dromara.kitchenware.mapper.PurchaseItemMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO purchase_item ( id, purchase_id, sku_id, buy_num, buy_price, subtotal, create_by, create_time, update_by, update_time, del_flag ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\n; Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'', '2026-06-16 15:36:00', 459);
INSERT INTO `sys_oper_log` VALUES (2066786877064794113, '000000', 1, '进货入库单', 2, 'org.dromara.kitchenware.controller.PurchaseController.edit()', 'PUT', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":3,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"6660\",\"payStatus\":1,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":1,\"purchaseId\":3,\"skuId\":1,\"buyNum\":6,\"buyPrice\":\"1110.00\",\"subtotal\":\"6660\",\"createBy\":1,\"createTime\":\"2026-06-16 15:36:04\",\"updateBy\":1,\"updateTime\":\"2026-06-16 15:36:04\",\"delFlag\":\"0\"}]}', '', 0, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\r\n### The error may exist in org/dromara/kitchenware/mapper/PurchaseItemMapper.java (best guess)\r\n### The error may involve org.dromara.kitchenware.mapper.PurchaseItemMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO purchase_item ( id, purchase_id, sku_id, buy_num, buy_price, subtotal, create_by, create_time, update_by, update_time, del_flag ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\n; Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'', '2026-06-16 15:36:05', 270);
INSERT INTO `sys_oper_log` VALUES (2066786896429895682, '000000', 1, '进货入库单', 2, 'org.dromara.kitchenware.controller.PurchaseController.edit()', 'PUT', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":3,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"6660\",\"payStatus\":1,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":1,\"purchaseId\":3,\"skuId\":1,\"buyNum\":6,\"buyPrice\":\"1110.00\",\"subtotal\":\"6660\",\"createBy\":1,\"createTime\":\"2026-06-16 15:36:09\",\"updateBy\":1,\"updateTime\":\"2026-06-16 15:36:09\",\"delFlag\":\"0\"}]}', '', 0, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\r\n### The error may exist in org/dromara/kitchenware/mapper/PurchaseItemMapper.java (best guess)\r\n### The error may involve org.dromara.kitchenware.mapper.PurchaseItemMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO purchase_item ( id, purchase_id, sku_id, buy_num, buy_price, subtotal, create_by, create_time, update_by, update_time, del_flag ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\n; Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'', '2026-06-16 15:36:10', 19);
INSERT INTO `sys_oper_log` VALUES (2066787261565030402, '000000', 1, '进货入库单', 2, 'org.dromara.kitchenware.controller.PurchaseController.edit()', 'PUT', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":3,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"1110.02\",\"payStatus\":1,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":1,\"purchaseId\":3,\"skuId\":1,\"buyNum\":1,\"buyPrice\":\"1110.02\",\"subtotal\":\"1110.02\",\"createBy\":1,\"createTime\":\"2026-06-16 15:37:36\",\"updateBy\":1,\"updateTime\":\"2026-06-16 15:37:36\",\"delFlag\":\"0\"}]}', '', 0, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\r\n### The error may exist in org/dromara/kitchenware/mapper/PurchaseItemMapper.java (best guess)\r\n### The error may involve org.dromara.kitchenware.mapper.PurchaseItemMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO purchase_item ( id, purchase_id, sku_id, buy_num, buy_price, subtotal, create_by, create_time, update_by, update_time, del_flag ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'\n; Duplicate entry \'1\' for key \'purchase_item.PRIMARY\'', '2026-06-16 15:37:37', 13);
INSERT INTO `sys_oper_log` VALUES (2066796283210940418, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472079013883905', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781597607368\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:13:28', 60);
INSERT INTO `sys_oper_log` VALUES (2066796313426706433, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472079185850369', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781597614636\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:13:35', 40);
INSERT INTO `sys_oper_log` VALUES (2066796326865256450, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472079307485193', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781597617856\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:13:38', 29);
INSERT INTO `sys_oper_log` VALUES (2066796376043470850, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472079634640909', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781597629565\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:13:50', 38);
INSERT INTO `sys_oper_log` VALUES (2066796399548350465, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472079500423173', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781597635178\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:13:56', 38);
INSERT INTO `sys_oper_log` VALUES (2066796483941941249, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472080330895364', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781597655326\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:14:16', 12);
INSERT INTO `sys_oper_log` VALUES (2066796822581657602, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472080205066242\",\"dataName\":\"master\",\"tableName\":\"stock_record\",\"tableComment\":\"库存变更流水\",\"className\":\"StockRecord\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"record\",\"functionName\":\"库存变更流水\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472080267980802\",\"tableId\":\"2066472080205066242\",\"columnName\":\"id\",\"columnComment\":\"流水ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"insert\":false,\"detail\":false,\"query\":false,\"edit\":false,\"sorting\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"id\"},{\"columnId\":\"2066472080267980803\",\"tableId\":\"2066472080205066242\",\"columnName\":\"sku_id\",\"columnComment\":\"操作SKU\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"skuId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"detail\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"skuId\"},{\"columnId\":\"2066472080267980804\",\"tableId\":\"2066472080205066242\",\"columnName\":\"change_type\",\"columnComment\":\"1采购入库 2销售出库 3退货入库 4损耗扣库\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"changeType\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:36\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"detail\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"changeType\"},{\"columnId\":\"2066472080267980805\",\"tableId\":\"2066472080205066242\",\"columnName\":\"change_num\",\"columnComment\":\"变动数量(出库负数)\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"changeNum\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:36\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"detail\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"changeNum\"},{\"columnId\":\"2066472080267980806\",\"tableId\":\"2066472080205066242\",\"columnName\":\"stock_after\",\"columnComment\":\"变动后剩余库存\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"stockAfter\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:15:36', 103);
INSERT INTO `sys_oper_log` VALUES (2066796867896918017, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472080205066242\",\"dataName\":\"master\",\"tableName\":\"stock_record\",\"tableComment\":\"库存变更流水\",\"className\":\"StockRecord\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"StockRecord\",\"functionName\":\"库存变更流水\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472080267980802\",\"tableId\":\"2066472080205066242\",\"columnName\":\"id\",\"columnComment\":\"流水ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:47\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":false,\"pk\":true,\"superColumn\":false,\"insert\":false,\"detail\":false,\"query\":false,\"edit\":false,\"sorting\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"id\"},{\"columnId\":\"2066472080267980803\",\"tableId\":\"2066472080205066242\",\"columnName\":\"sku_id\",\"columnComment\":\"操作SKU\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"skuId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:47\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"detail\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"skuId\"},{\"columnId\":\"2066472080267980804\",\"tableId\":\"2066472080205066242\",\"columnName\":\"change_type\",\"columnComment\":\"1采购入库 2销售出库 3退货入库 4损耗扣库\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"changeType\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:47\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"detail\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"changeType\"},{\"columnId\":\"2066472080267980805\",\"tableId\":\"2066472080205066242\",\"columnName\":\"change_num\",\"columnComment\":\"变动数量(出库负数)\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"changeNum\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:12\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:15:47\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"detail\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"changeNum\"},{\"columnId\":\"2066472080267980806\",\"tableId\":\"2066472080205066242\",\"columnName\":\"stock_after\",\"columnComment\":\"变动后剩余库存\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"stockAfter\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:15:47', 59);
INSERT INTO `sys_oper_log` VALUES (2066796945688674305, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472080205066242\"}', '', 1, '', '2026-06-16 16:16:06', 131);
INSERT INTO `sys_oper_log` VALUES (2066800781761343489, '000000', 1, '进货入库单', 1, 'org.dromara.kitchenware.controller.PurchaseController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"10\",\"payStatus\":0,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":\"test\",\"purchaseItems\":[{\"id\":2,\"purchaseId\":4,\"skuId\":1,\"buyNum\":1,\"buyPrice\":\"10\",\"subtotal\":\"10\",\"createBy\":1,\"createTime\":\"2026-06-16 16:31:20\",\"updateBy\":1,\"updateTime\":\"2026-06-16 16:31:20\",\"delFlag\":\"0\"}]}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:31:20', 64);
INSERT INTO `sys_oper_log` VALUES (2066804270524727298, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"库存流水变更类型\",\"dictType\":\"kitchenware_stock_change_type\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:45:12', 66);
INSERT INTO `sys_oper_log` VALUES (2066804318662754305, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"采购入库\",\"dictValue\":\"1\",\"dictType\":\"kitchenware_stock_change_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:45:24', 54);
INSERT INTO `sys_oper_log` VALUES (2066804355253862402, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"销售出库\",\"dictValue\":\"2\",\"dictType\":\"kitchenware_stock_change_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:45:32', 47);
INSERT INTO `sys_oper_log` VALUES (2066804393585606657, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"退货入库\",\"dictValue\":\"3\",\"dictType\":\"kitchenware_stock_change_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:45:41', 45);
INSERT INTO `sys_oper_log` VALUES (2066804449470513153, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"损耗扣库\",\"dictValue\":\"4\",\"dictType\":\"kitchenware_stock_change_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-16 16:45:55', 43);
INSERT INTO `sys_oper_log` VALUES (2067157499662028801, '000000', 1, '进货入库单', 1, 'org.dromara.kitchenware.controller.PurchaseController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"10\",\"payStatus\":1,\"purchaseTime\":\"2026-06-18 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":3,\"purchaseId\":5,\"skuId\":1,\"buyNum\":1,\"buyPrice\":\"10\",\"subtotal\":\"10\",\"createBy\":1,\"createTime\":\"2026-06-17 16:08:48\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:08:48\",\"delFlag\":\"0\"}]}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:08:49', 58);
INSERT INTO `sys_oper_log` VALUES (2067157723990183938, '000000', 1, '进货入库单', 1, 'org.dromara.kitchenware.controller.PurchaseController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/purchase', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"supplierId\":1,\"operatorId\":1,\"totalAmount\":\"100000\",\"payStatus\":0,\"purchaseTime\":\"2026-06-19 00:00:00\",\"note\":null,\"purchaseItems\":[{\"id\":4,\"purchaseId\":6,\"skuId\":1,\"buyNum\":1,\"buyPrice\":\"100000\",\"subtotal\":\"100000\",\"createBy\":1,\"createTime\":\"2026-06-17 16:09:41\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:09:41\",\"delFlag\":\"0\"}]}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:09:42', 39);
INSERT INTO `sys_oper_log` VALUES (2067159023729496065, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2066472080205066242', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781684091513\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:14:52', 45);
INSERT INTO `sys_oper_log` VALUES (2067159408611414018, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"支付状态\",\"dictType\":\"pay_type\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:16:24', 49);
INSERT INTO `sys_oper_log` VALUES (2067159469743394818, '000000', 1, '字典类型', 2, 'org.dromara.system.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":\"2067159408456224770\",\"dictName\":\"支付类型\",\"dictType\":\"pay_type\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:16:38', 28);
INSERT INTO `sys_oper_log` VALUES (2067159938708525058, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"微信\",\"dictValue\":\"1\",\"dictType\":\"pay_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:18:30', 69);
INSERT INTO `sys_oper_log` VALUES (2067159979712040962, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"支付宝\",\"dictValue\":\"2\",\"dictType\":\"pay_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:18:40', 44);
INSERT INTO `sys_oper_log` VALUES (2067160029741699074, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"余额支付\",\"dictValue\":\"3\",\"dictType\":\"pay_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:18:52', 22);
INSERT INTO `sys_oper_log` VALUES (2067160117809500161, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"订单状态\",\"dictType\":\"order_status\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:19:13', 38);
INSERT INTO `sys_oper_log` VALUES (2067160178639491074, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"待支付\",\"dictValue\":\"1\",\"dictType\":\"order_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:19:27', 18);
INSERT INTO `sys_oper_log` VALUES (2067160230653054978, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"待发货\",\"dictValue\":\"2\",\"dictType\":\"order_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:19:40', 43);
INSERT INTO `sys_oper_log` VALUES (2067160331316350978, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"待收货\",\"dictValue\":\"3\",\"dictType\":\"order_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:20:04', 40);
INSERT INTO `sys_oper_log` VALUES (2067160397481496577, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"已完成\",\"dictValue\":\"4\",\"dictType\":\"order_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:20:19', 246);
INSERT INTO `sys_oper_log` VALUES (2067160466582654977, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"已取消\",\"dictValue\":\"5\",\"dictType\":\"order_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:20:36', 43);
INSERT INTO `sys_oper_log` VALUES (2067160497431760898, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"售后中\",\"dictValue\":\"6\",\"dictType\":\"order_status\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:20:43', 17);
INSERT INTO `sys_oper_log` VALUES (2067160870200528897, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"优惠券类型\",\"dictType\":\"coupon_type\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:22:12', 20);
INSERT INTO `sys_oper_log` VALUES (2067160978514235393, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"无门槛\",\"dictValue\":\"1\",\"dictType\":\"coupon_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:22:38', 155);
INSERT INTO `sys_oper_log` VALUES (2067161018104270849, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"满减券\",\"dictValue\":\"2\",\"dictType\":\"coupon_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:22:47', 80);
INSERT INTO `sys_oper_log` VALUES (2067161529742249986, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"优惠券作用域类型\",\"dictType\":\"scope_type\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:24:49', 54);
INSERT INTO `sys_oper_log` VALUES (2067161572842917890, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"全品类\",\"dictValue\":\"1\",\"dictType\":\"scope_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:25:00', 39);
INSERT INTO `sys_oper_log` VALUES (2067161612743331842, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"指定分类\",\"dictValue\":\"2\",\"dictType\":\"scope_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:25:09', 41);
INSERT INTO `sys_oper_log` VALUES (2067161668456271874, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"指定商品\",\"dictValue\":\"3\",\"dictType\":\"scope_type\",\"cssClass\":null,\"listClass\":\"text\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:25:22', 46);
INSERT INTO `sys_oper_log` VALUES (2067162032039514113, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472078552510465\",\"dataName\":\"master\",\"tableName\":\"coupon_template\",\"tableComment\":\"优惠券模板\",\"className\":\"CouponTemplate\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"CouponTemplate\",\"functionName\":\"优惠券模板\",\"functionAuthor\":\"sparkle\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472078741254145\",\"tableId\":\"2066472078552510465\",\"columnName\":\"id\",\"columnComment\":\"券模板ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:49\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"superColumn\":false,\"pk\":true,\"detail\":false,\"insert\":false,\"query\":false,\"edit\":false,\"sorting\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"id\",\"list\":false,\"required\":true},{\"columnId\":\"2066472078741254146\",\"tableId\":\"2066472078552510465\",\"columnName\":\"coupon_type\",\"columnComment\":\"1无门槛 2满减券\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"couponType\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:49\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"\",\"sort\":2,\"superColumn\":false,\"pk\":false,\"detail\":true,\"insert\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"couponType\",\"list\":true,\"required\":true},{\"columnId\":\"2066472078741254147\",\"tableId\":\"2066472078552510465\",\"columnName\":\"denomination\",\"columnComment\":\"抵扣金额\",\"columnType\":\"decimal(10,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"denomination\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:49\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"superColumn\":false,\"pk\":false,\"detail\":true,\"insert\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"denomination\",\"list\":true,\"required\":true},{\"columnId\":\"2066472078741254148\",\"tableId\":\"2066472078552510465\",\"columnName\":\"full_money\",\"columnComment\":\"满减门槛 0=无门槛\",\"columnType\":\"decimal(10,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"fullMoney\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:49\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"superColumn\":false,\"pk\":false,\"detail\":true,\"insert\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"fullMoney\",\"list\":true,\"required\":true},{\"columnId\":\"2066472078741254149\",\"tableId\":\"2066472078552510465\",\"columnName\":\"total_count\",\"columnComment\":\"总发放数量\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"totalCount\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:26:49', 92);
INSERT INTO `sys_oper_log` VALUES (2067162071218507777, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2066472078552510465\",\"dataName\":\"master\",\"tableName\":\"coupon_template\",\"tableComment\":\"优惠券模板\",\"className\":\"CouponTemplate\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"CouponTemplate\",\"functionName\":\"优惠券模板\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2066472078741254145\",\"tableId\":\"2066472078552510465\",\"columnName\":\"id\",\"columnComment\":\"券模板ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:58\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"superColumn\":false,\"pk\":true,\"detail\":false,\"insert\":false,\"query\":false,\"edit\":false,\"sorting\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"id\",\"list\":false,\"required\":true},{\"columnId\":\"2066472078741254146\",\"tableId\":\"2066472078552510465\",\"columnName\":\"coupon_type\",\"columnComment\":\"1无门槛 2满减券\",\"columnType\":\"tinyint\",\"javaType\":\"Integer\",\"javaField\":\"couponType\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:58\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"\",\"sort\":2,\"superColumn\":false,\"pk\":false,\"detail\":true,\"insert\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"couponType\",\"list\":true,\"required\":true},{\"columnId\":\"2066472078741254147\",\"tableId\":\"2066472078552510465\",\"columnName\":\"denomination\",\"columnComment\":\"抵扣金额\",\"columnType\":\"decimal(10,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"denomination\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:58\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"superColumn\":false,\"pk\":false,\"detail\":true,\"insert\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"denomination\",\"list\":true,\"required\":true},{\"columnId\":\"2066472078741254148\",\"tableId\":\"2066472078552510465\",\"columnName\":\"full_money\",\"columnComment\":\"满减门槛 0=无门槛\",\"columnType\":\"decimal(10,2)\",\"javaType\":\"BigDecimal\",\"javaField\":\"fullMoney\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-15 18:45:11\",\"updateBy\":1,\"updateTime\":\"2026-06-17 16:26:58\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":4,\"superColumn\":false,\"pk\":false,\"detail\":true,\"insert\":true,\"query\":true,\"edit\":true,\"sorting\":false,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"fullMoney\",\"list\":true,\"required\":true},{\"columnId\":\"2066472078741254149\",\"tableId\":\"2066472078552510465\",\"columnName\":\"total_count\",\"columnComment\":\"总发放数量\",\"columnType\":\"int\",\"javaType\":\"Integer\",\"javaField\":\"totalCount\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"creat', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 16:26:58', 29);
INSERT INTO `sys_oper_log` VALUES (2067162153846296578, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2066472078552510465\"}', '', 1, '', '2026-06-17 16:27:18', 60);
INSERT INTO `sys_oper_log` VALUES (2067214024099155970, '000000', 1, '优惠券模板', 1, 'org.dromara.kitchenware.controller.CouponTemplateController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/CouponTemplate', '0:0:0:0:0:0:0:1', '内网IP', '{\"id\":null,\"couponType\":1,\"denomination\":\"10\",\"fullMoney\":\"0\",\"totalCount\":10,\"receiveCount\":0,\"validDays\":4,\"startTime\":\"2026-06-18 00:00:00\",\"endTime\":\"2026-06-20 00:00:00\",\"scopeType\":1,\"status\":1}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 19:53:25', 51);
INSERT INTO `sys_oper_log` VALUES (2067214824280084482, '000000', 1, '字典类型', 1, 'org.dromara.system.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictId\":null,\"dictName\":\"优惠券状态\",\"dictType\":\"coupon_status\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 19:56:36', 138);
INSERT INTO `sys_oper_log` VALUES (2067214994778542082, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"未使用\",\"dictValue\":\"1\",\"dictType\":\"coupon_status\",\"cssClass\":null,\"listClass\":\"default\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 19:57:16', 52);
INSERT INTO `sys_oper_log` VALUES (2067215068598292481, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"已使用\",\"dictValue\":\"2\",\"dictType\":\"coupon_status\",\"cssClass\":null,\"listClass\":\"primary\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 19:57:34', 43);
INSERT INTO `sys_oper_log` VALUES (2067215126689402882, '000000', 1, '字典数据', 1, 'org.dromara.system.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '0:0:0:0:0:0:0:1', '内网IP', '{\"dictCode\":null,\"dictSort\":0,\"dictLabel\":\"已过期\",\"dictValue\":\"3\",\"dictType\":\"coupon_status\",\"cssClass\":null,\"listClass\":\"danger\",\"tagStyle\":null,\"isDefault\":null,\"createDept\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 19:57:48', 147);
INSERT INTO `sys_oper_log` VALUES (2067216556057874434, '000000', 1, '代码生成', 6, 'org.dromara.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '{\"tables\":\"member\",\"dataName\":\"master\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:03:29', 187);
INSERT INTO `sys_oper_log` VALUES (2067217065040859137, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2067216555462283265\",\"dataName\":\"master\",\"tableName\":\"member\",\"tableComment\":\"商城会员表\",\"className\":\"Member\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"member\",\"functionName\":\"商城会员\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2067216555881713666\",\"tableId\":\"2067216555462283265\",\"columnName\":\"member_id\",\"columnComment\":\"会员主键ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"memberId\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"1\",\"isQuery\":null,\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:29\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"list\":true,\"pk\":true,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":false,\"edit\":false,\"insert\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"memberId\",\"required\":true},{\"columnId\":\"2067216555915268097\",\"tableId\":\"2067216555462283265\",\"columnName\":\"nickname\",\"columnComment\":\"会员昵称\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"nickname\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:29\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":true,\"edit\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"nickname\",\"required\":true},{\"columnId\":\"2067216555915268098\",\"tableId\":\"2067216555462283265\",\"columnName\":\"mobile\",\"columnComment\":\"手机号(唯一登录账号)\",\"columnType\":\"varchar(11)\",\"javaType\":\"String\",\"javaField\":\"mobile\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:29\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":true,\"edit\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"mobile\",\"required\":true},{\"columnId\":\"2067216555915268099\",\"tableId\":\"2067216555462283265\",\"columnName\":\"avatar\",\"columnComment\":\"头像地址\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"avatar\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:29\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":true,\"edit\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"avatar\",\"required\":false},{\"columnId\":\"2067216555915268100\",\"tableId\":\"2067216555462283265\",\"columnName\":\"password\",\"columnComment\":\"登录加密密码\",\"columnType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"password\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateT', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:05:30', 82);
INSERT INTO `sys_oper_log` VALUES (2067217122033061890, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2067216555462283265\",\"dataName\":\"master\",\"tableName\":\"member\",\"tableComment\":\"商城会员表\",\"className\":\"Member\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"member\",\"functionName\":\"商城会员\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2067216555881713666\",\"tableId\":\"2067216555462283265\",\"columnName\":\"member_id\",\"columnComment\":\"会员主键ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"memberId\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"1\",\"isQuery\":null,\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:43\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"list\":true,\"pk\":true,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":false,\"edit\":false,\"insert\":false,\"increment\":true,\"usableColumn\":false,\"capJavaField\":\"memberId\",\"required\":true},{\"columnId\":\"2067216555915268097\",\"tableId\":\"2067216555462283265\",\"columnName\":\"nickname\",\"columnComment\":\"会员昵称\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"nickname\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:43\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":true,\"edit\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"nickname\",\"required\":true},{\"columnId\":\"2067216555915268098\",\"tableId\":\"2067216555462283265\",\"columnName\":\"mobile\",\"columnComment\":\"手机号(唯一登录账号)\",\"columnType\":\"varchar(11)\",\"javaType\":\"String\",\"javaField\":\"mobile\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:43\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":true,\"edit\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"mobile\",\"required\":true},{\"columnId\":\"2067216555915268099\",\"tableId\":\"2067216555462283265\",\"columnName\":\"avatar\",\"columnComment\":\"头像地址\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"avatar\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:05:43\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"list\":true,\"pk\":false,\"superColumn\":false,\"detail\":true,\"sorting\":false,\"query\":true,\"edit\":true,\"insert\":true,\"increment\":false,\"usableColumn\":false,\"capJavaField\":\"avatar\",\"required\":false},{\"columnId\":\"2067216555915268100\",\"tableId\":\"2067216555462283265\",\"columnName\":\"password\",\"columnComment\":\"登录加密密码\",\"columnType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"password\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:03:29\",\"updateBy\":1,\"updateT', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:05:44', 55);
INSERT INTO `sys_oper_log` VALUES (2067217156547989506, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2067216555462283265\"}', '', 1, '', '2026-06-17 20:05:52', 288);
INSERT INTO `sys_oper_log` VALUES (2067218603960373249, '000000', 1, '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"menuId\":\"2067217155377778689\",\"menuName\":\"会员管理\",\"parentId\":\"2066474865592020993\",\"orderNum\":1,\"path\":\"member\",\"component\":\"kitchenware/member/index\",\"componentName\":\"Member\",\"queryParam\":\"\",\"isFrame\":0,\"isCache\":1,\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"1\",\"perms\":\"kitchenware:member:list\",\"icon\":\"#\",\"hiddenExpression\":null,\"shopExpression\":null,\"remark\":\"商城会员菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:11:37', 82);
INSERT INTO `sys_oper_log` VALUES (2067220611819835394, '000000', 1, '商城会员', 1, 'org.dromara.kitchenware.controller.MemberController.add()', 'POST', 1, 'admin', '研发部门', '/kitchenware/member', '0:0:0:0:0:0:0:1', '内网IP', '{\"memberId\":null,\"nickname\":\"sparkle520\",\"mobile\":\"18346554486\",\"avatar\":null,\"balance\":\"1000\",\"point\":null,\"lastLoginTime\":null,\"status\":\"1\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:19:36', 61);
INSERT INTO `sys_oper_log` VALUES (2067226574018777090, '000000', 1, '代码生成', 3, 'org.dromara.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2067216555462283265', '0:0:0:0:0:0:0:1', '内网IP', '{\"_t\":\"1781700197043\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:43:17', 58);
INSERT INTO `sys_oper_log` VALUES (2067228175068499970, '000000', 1, '代码生成', 6, 'org.dromara.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '{\"tables\":\"member_address\",\"dataName\":\"master\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:49:39', 165);
INSERT INTO `sys_oper_log` VALUES (2067228381168209922, '000000', 1, '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableId\":\"2067228174556794882\",\"dataName\":\"master\",\"tableName\":\"member_address\",\"tableComment\":\"会员收货地址表\",\"className\":\"MemberAddress\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.kitchenware\",\"moduleName\":\"kitchenware\",\"businessName\":\"MemberAddress\",\"functionName\":\"会员收货地址\",\"functionAuthor\":\"sparkle520\",\"genType\":\"0\",\"genPath\":\"/\",\"options\":\"{\\\"treeCode\\\":null,\\\"treeParentCode\\\":null,\\\"treeName\\\":null,\\\"parentMenuId\\\":\\\"2066474865592020993\\\",\\\"isUseQuery\\\":true,\\\"isUseBO\\\":true,\\\"isUseVO\\\":true,\\\"isUseController\\\":true,\\\"isUseVue\\\":true,\\\"isUseSql\\\":true,\\\"menuIcon\\\":\\\"#\\\",\\\"isUseAddMethod\\\":true,\\\"isUseEditMethod\\\":true,\\\"isUseRemoveMethod\\\":true,\\\"isUseImportMethod\\\":false,\\\"isUseExportMethod\\\":true,\\\"isUseDetailMethod\\\":true,\\\"isUseQueryMethod\\\":true}\",\"remark\":null,\"columns\":[{\"columnId\":\"2067228174909116417\",\"tableId\":\"2067228174556794882\",\"columnName\":\"address_id\",\"columnComment\":\"地址主键ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"addressId\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"1\",\"isQuery\":null,\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:49:39\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:50:27\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":true,\"pk\":true,\"superColumn\":false,\"insert\":false,\"sorting\":false,\"detail\":true,\"query\":false,\"edit\":false,\"increment\":true,\"capJavaField\":\"addressId\",\"usableColumn\":false},{\"columnId\":\"2067228174909116418\",\"tableId\":\"2067228174556794882\",\"columnName\":\"tenant_id\",\"columnComment\":\"租户编号\",\"columnType\":\"varchar(20)\",\"javaType\":\"String\",\"javaField\":\"tenantId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"0\",\"isEdit\":\"0\",\"isList\":\"0\",\"isQuery\":null,\"isDetail\":\"0\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:49:39\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:50:27\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":false,\"list\":false,\"pk\":false,\"superColumn\":false,\"insert\":false,\"sorting\":false,\"detail\":false,\"query\":false,\"edit\":false,\"increment\":false,\"capJavaField\":\"tenantId\",\"usableColumn\":false},{\"columnId\":\"2067228174909116419\",\"tableId\":\"2067228174556794882\",\"columnName\":\"member_id\",\"columnComment\":\"会员ID，关联member表\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"memberId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:49:39\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:50:27\",\"queryType\":\"EQ\",\"htmlType\":\"input-number\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"edit\":true,\"increment\":false,\"capJavaField\":\"memberId\",\"usableColumn\":false},{\"columnId\":\"2067228174909116420\",\"tableId\":\"2067228174556794882\",\"columnName\":\"receiver_name\",\"columnComment\":\"收货人姓名\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"receiverName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSort\":\"0\",\"createBy\":1,\"createTime\":\"2026-06-17 20:49:39\",\"updateBy\":1,\"updateTime\":\"2026-06-17 20:50:27\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"insert\":true,\"sorting\":false,\"detail\":true,\"query\":true,\"edit\":true,\"increment\":false,\"capJavaField\":\"receiverName\",\"usableColumn\":false},{\"columnId\":\"2067228174909116421\",\"tableId\":\"2067228174556794882\",\"columnName\":\"receiver_mobile\",\"columnComment\":\"收货人手机号\",\"columnType\":\"varchar(11)\",\"javaType\":\"String\",\"javaField\":\"receiverMobile\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"isDetail\":\"1\",\"isSo', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 1, '', '2026-06-17 20:50:28', 78);
INSERT INTO `sys_oper_log` VALUES (2067228432972058626, '000000', 1, '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"2067228174556794882\"}', '', 1, '', '2026-06-17 20:50:40', 174);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'URL地址',
  `ext1` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `size` bigint NULL DEFAULT NULL COMMENT '字节长度',
  `content_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容类型',
  `oss_category_id` bigint NOT NULL DEFAULT 0 COMMENT '分类id',
  `user_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户类型',
  `is_lock` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否锁定状态',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`) USING BTREE,
  INDEX `idx_oss_category_id`(`oss_category_id` ASC) USING BTREE COMMENT '分类索引',
  INDEX `idx_user`(`create_by` ASC, `user_type` ASC, `create_time` ASC) USING BTREE COMMENT '用户索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_category`;
CREATE TABLE `sys_oss_category`  (
  `oss_category_id` bigint NOT NULL COMMENT 'oss分类id',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint NOT NULL COMMENT '父级分类id',
  `category_path` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类路径',
  `level` int NOT NULL COMMENT '层级',
  `order_num` int NOT NULL COMMENT '显示顺序',
  `user_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户类型',
  `create_by` bigint NOT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`oss_category_id`) USING BTREE,
  INDEX `idx_user`(`create_by` ASC, `user_type` ASC, `order_num` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'oss分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss_category
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `oss_config_id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '域',
  `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否默认（1=是,0=否）',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对象存储配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1, '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '1', NULL, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_oss_config` VALUES (2, '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '0', NULL, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_oss_config` VALUES (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '0', NULL, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_oss_config` VALUES (4, '000000', 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1250000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', '0', NULL, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_oss_config` VALUES (5, '000000', 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', '0', NULL, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);

-- ----------------------------
-- Table structure for sys_oss_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_rule`;
CREATE TABLE `sys_oss_rule`  (
  `oss_rule_id` bigint NOT NULL COMMENT 'oss规则id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `rule_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则名称（例如：80x80，则字段名称将输出字段名_80x80）',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '匹配域名',
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '媒体类型（规则对匹配的媒体类型生效）',
  `rule` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则',
  `is_overwrite` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否覆盖默认字段值',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否默认（不指定规则时，默认输出的规则）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '启用状态',
  `rule_sort` int NOT NULL DEFAULT 0 COMMENT '规则顺序',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_rule_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OSS处理规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss_rule
-- ----------------------------
INSERT INTO `sys_oss_rule` VALUES (1, '000000', '180x180', 'oss-cn-beijing.aliyuncs.com', 'image', '#{#url}?x-oss-process=image/auto-orient,1/resize,m_lfit,w_180/quality,q_90', 'N', 'N', '1', 0, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);
INSERT INTO `sys_oss_rule` VALUES (2, '000000', '800x800', 'oss-cn-beijing.aliyuncs.com', 'image', '#{#url}?x-oss-process=image/auto-orient,1/resize,m_lfit,w_800/quality,q_90', 'N', 'N', '1', 1, 103, 1, '2026-06-14 12:19:24', 1, '2026-06-14 12:19:24', NULL);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '岗位类别编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（1正常 0停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, '000000', 103, 'ceo', NULL, '董事长', 1, '1', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2, '000000', 100, 'se', NULL, '项目经理', 2, '1', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (3, '000000', 100, 'hr', NULL, '人力资源', 3, '1', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (4, '000000', 100, 'user', NULL, '普通员工', 4, '1', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（1正常 0停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 1, 1, '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '000000', '普通角色', 'common', 2, '2', 1, 1, '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2002);
INSERT INTO `sys_role_menu` VALUES (1, 2003);
INSERT INTO `sys_role_menu` VALUES (1, 2004);
INSERT INTO `sys_role_menu` VALUES (1, 2005);
INSERT INTO `sys_role_menu` VALUES (1, 2100);
INSERT INTO `sys_role_menu` VALUES (1, 2101);
INSERT INTO `sys_role_menu` VALUES (1, 2102);
INSERT INTO `sys_role_menu` VALUES (1, 2103);
INSERT INTO `sys_role_menu` VALUES (1, 2104);
INSERT INTO `sys_role_menu` VALUES (1, 2105);
INSERT INTO `sys_role_menu` VALUES (1, 2200);
INSERT INTO `sys_role_menu` VALUES (1, 2201);
INSERT INTO `sys_role_menu` VALUES (1, 2202);
INSERT INTO `sys_role_menu` VALUES (1, 2203);
INSERT INTO `sys_role_menu` VALUES (1, 2204);
INSERT INTO `sys_role_menu` VALUES (1, 2205);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 1061);
INSERT INTO `sys_role_menu` VALUES (2, 1062);
INSERT INTO `sys_role_menu` VALUES (2, 1063);
INSERT INTO `sys_role_menu` VALUES (2, 1064);
INSERT INTO `sys_role_menu` VALUES (2, 1065);

-- ----------------------------
-- Table structure for sys_sensitive_word
-- ----------------------------
DROP TABLE IF EXISTS `sys_sensitive_word`;
CREATE TABLE `sys_sensitive_word`  (
  `word_id` bigint NOT NULL COMMENT '敏感词id',
  `word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '敏感词',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '敏感词类别',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint NOT NULL COMMENT '启用状态 1启用 0禁用',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`word_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '敏感词表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sensitive_word
-- ----------------------------

-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS `sys_social`;
CREATE TABLE `sys_social`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户id',
  `auth_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '平台+平台唯一id',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户来源',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台编号唯一id',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int NULL DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
  `access_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
  `union_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户的 unionid',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
  `token_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
  `id_token` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'id token，部分平台可能没有',
  `mac_algorithm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `mac_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
  `oauth_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `oauth_token_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '社会化关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_social
-- ----------------------------

-- ----------------------------
-- Table structure for sys_storage_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_storage_config`;
CREATE TABLE `sys_storage_config`  (
  `storage_config_id` bigint NOT NULL COMMENT '主建',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置名称',
  `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '平台',
  `weight` int NOT NULL COMMENT '负载均衡权重',
  `status` tinyint(1) NOT NULL COMMENT '启用状态',
  `config_json` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置json',
  `request_mode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求模式 proxy：代理转发请求 direct：源地址重定向请求 direct_signature：预签名重定向请求',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`storage_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_storage_config
-- ----------------------------
INSERT INTO `sys_storage_config` VALUES (2066497664289255425, '000000', '本地', 'local_plus', 1, 1, '{\"storagePath\":\"D:/local_file\"}', 'proxy', '0', 103, 1, '2026-06-15 20:26:52', 1, '2026-06-15 20:26:52', NULL);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `package_id` bigint NULL DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `account_count` int NULL DEFAULT -1 COMMENT '用户数量（-1不限制）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '租户状态（1正常 0停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (1, '000000', '管理组', '15888888888', 'XXX有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '1', '0', 103, 1, '2026-06-14 12:19:21', NULL, NULL);

-- ----------------------------
-- Table structure for sys_tenant_app
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_app`;
CREATE TABLE `sys_tenant_app`  (
  `appid` bigint NOT NULL COMMENT '应用id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `app_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '应用类型',
  `app_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '应用key',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '应用名称',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`appid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户应用管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant_app
-- ----------------------------

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '状态（1正常 0停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户套餐表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------

-- ----------------------------
-- Table structure for sys_tenant_package_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package_menu`;
CREATE TABLE `sys_tenant_package_menu`  (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `menu_id` bigint NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`package_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户套餐和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant_package_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` bigint NULL DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '帐号状态（1正常 0停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '000000', 103, 'admin', '管理员', 'sys_user', 'xxx@163.com', '15888888888', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '1', '0', '0:0:0:0:0:0:0:1', '2026-06-18 14:22:46', 103, 1, '2026-06-14 12:19:21', 1, '2026-06-18 14:22:46', '管理员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址主键',
  `member_id` bigint NOT NULL COMMENT '归属买家ID',
  `receiver` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货电话',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `detail_addr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `is_default` tinyint NOT NULL DEFAULT 0 COMMENT '1默认地址 0普通',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_member_id`(`member_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '买家多收货地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_address
-- ----------------------------

-- ----------------------------
-- Table structure for user_cart
-- ----------------------------
DROP TABLE IF EXISTS `user_cart`;
CREATE TABLE `user_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车主键',
  `member_id` bigint NOT NULL COMMENT '买家ID',
  `sku_id` bigint NOT NULL COMMENT '商品规格SKU',
  `buy_num` int NOT NULL DEFAULT 1 COMMENT '选购数量',
  `selected` tinyint NOT NULL DEFAULT 1 COMMENT '1结算勾选 0未勾选',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_mem_sku`(`member_id` ASC, `sku_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '买家购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_cart
-- ----------------------------

-- ----------------------------
-- Table structure for user_member
-- ----------------------------
DROP TABLE IF EXISTS `user_member`;
CREATE TABLE `user_member`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '买家主键ID',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加密密码',
  `balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '可用余额（可抵扣下单）',
  `level` tinyint NOT NULL DEFAULT 1 COMMENT '1普通 2会员',
  `points` int NOT NULL DEFAULT 0 COMMENT '积分',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '1正常 0禁用',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商城购物买家' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_member
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
