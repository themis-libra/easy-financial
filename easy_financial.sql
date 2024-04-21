/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : easy_financial

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 21/04/2024 19:08:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bankcard_number
-- ----------------------------
DROP TABLE IF EXISTS `bankcard_number`;
CREATE TABLE `bankcard_number`  (
  `cid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户证件号',
  `bankcard_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '银行卡号',
  `btime` datetime NOT NULL COMMENT '添加银行卡时间',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '删除标志',
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '柜台人员账号',
  PRIMARY KEY (`cid`, `bankcard_number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bankcard_number
-- ----------------------------
INSERT INTO `bankcard_number` VALUES ('123456789987654321', '1987654320123456712', '2024-01-08 11:21:59', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('147258369012345678', '8163975420123456789', '2024-01-01 16:53:39', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('230718569456789123', '1987654320123456789', '2024-01-01 23:52:34', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('374658921071234567', '1298374560123456789', '2024-01-03 20:01:52', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('374658921071234567', '7836249150123456789', '2024-01-02 16:16:11', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('374658921071234567', '9027418635432101234', '2024-01-03 20:02:29', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('513026199874120254', '4587654320123456712', '2024-01-08 19:33:17', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('522726199874120254', '1234654320123456712', '2024-01-08 19:36:32', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('586397412034567890', '4510237986789012345', '2024-01-02 22:20:28', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('765432198765432109', '6309741825432101234', '2024-01-01 23:52:34', 0, NULL);
INSERT INTO `bankcard_number` VALUES ('918273645012345678', '3471258906543210123', '2024-01-02 21:31:59', 0, NULL);

-- ----------------------------
-- Table structure for customer_information
-- ----------------------------
DROP TABLE IF EXISTS `customer_information`;
CREATE TABLE `customer_information`  (
  `cname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户姓名',
  `cid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户证件号',
  `ctype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户类型',
  `idtype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '证件类型',
  `clevel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户风险等级',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '删除标志',
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '柜台人员账号',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_information
-- ----------------------------
INSERT INTO `customer_information` VALUES ('周梓桐', '123456789012345679', '个人', '护照', '低风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('张三', '123456789987654321', '个人', '中国大陆身份证', '未知风险等级', 0, NULL);
INSERT INTO `customer_information` VALUES ('王爔瑜', '147258369012345678', '个人', '港澳台通行证', '未知风险等级', 0, NULL);
INSERT INTO `customer_information` VALUES ('刘梓轩', '230718569456789123', '机构', '中国大陆身份证', '中低风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('李明', '374658921071234567', '个人', '中国大陆身份证', '低风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('郭子涵', '456789012345678910', '个人', '中国大陆身份证', '高风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('李四', '513026199874120254', '个人', '中国大陆身份证', '低风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('王五', '522726199874120254', '个人', '中国大陆身份证', '低风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('赵瑾萱', '586397412034567890', '个人', '护照', '中风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('吴语嫣', '632890157468901234', '个人', '中国大陆身份证', '中风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('陈嘉怡', '765432198765432109', '个人', '港澳台通行证', '中高风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('孙浩宇', '890123456789123450', '个人', '护照', '低风险', 0, NULL);
INSERT INTO `customer_information` VALUES ('张悦然', '918273645012345678', '机构', '中国大陆身份证', '高风险', 0, NULL);

-- ----------------------------
-- Table structure for market_information
-- ----------------------------
DROP TABLE IF EXISTS `market_information`;
CREATE TABLE `market_information`  (
  `mpid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品代码',
  `mtime` datetime NOT NULL COMMENT '日期',
  `net_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '当日净值',
  `daily_growth_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日增长率',
  PRIMARY KEY (`mpid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of market_information
-- ----------------------------

-- ----------------------------
-- Table structure for production_information
-- ----------------------------
DROP TABLE IF EXISTS `production_information`;
CREATE TABLE `production_information`  (
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品代码',
  `pname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `ptype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品类型',
  `plevel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品风险等级',
  `pstate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品状态',
  `ptime` datetime NOT NULL COMMENT '产品创建或修改时间',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of production_information
-- ----------------------------
INSERT INTO `production_information` VALUES (' 1', ' 2', '基金', '中高风险', '上市', '2023-12-27 16:39:01', 0);
INSERT INTO `production_information` VALUES (' 11', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:39:43', 0);
INSERT INTO `production_information` VALUES (' 111', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:39:38', 0);
INSERT INTO `production_information` VALUES (' 2', ' 3', '基金', '中高风险', '上市', '2023-12-27 16:39:17', 0);
INSERT INTO `production_information` VALUES (' 4', ' 5', '基金', '中高风险', '上市', '2023-12-27 16:39:23', 0);
INSERT INTO `production_information` VALUES (' 40', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:39:55', 1);
INSERT INTO `production_information` VALUES (' 7', ' 8', '基金', '中高风险', '上市', '2023-12-27 16:39:28', 1);
INSERT INTO `production_information` VALUES (' 8', ' 9', '基金', '中高风险', '上市', '2023-12-27 16:39:33', 0);
INSERT INTO `production_information` VALUES (' 88', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:39:47', 0);
INSERT INTO `production_information` VALUES (' 99', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:39:50', 1);
INSERT INTO `production_information` VALUES ('1', '2', '基金', '中高风险', '上市', '2023-12-27 16:37:10', 1);
INSERT INTO `production_information` VALUES ('555', '777', '基金', '中高风险', '上市', '2023-12-27 16:44:18', 0);
INSERT INTO `production_information` VALUES ('808', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:40:01', 1);
INSERT INTO `production_information` VALUES ('8087', ' 222', '基金', '中高风险', '上市', '2023-12-27 16:40:06', 1);

-- ----------------------------
-- Table structure for receptionist_information
-- ----------------------------
DROP TABLE IF EXISTS `receptionist_information`;
CREATE TABLE `receptionist_information`  (
  `rname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '柜台人员姓名',
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '柜台人员账号',
  `rcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '柜台人员密码',
  PRIMARY KEY (`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of receptionist_information
-- ----------------------------

-- ----------------------------
-- Table structure for redemption_information
-- ----------------------------
DROP TABLE IF EXISTS `redemption_information`;
CREATE TABLE `redemption_information`  (
  `rcname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户名称',
  `rcid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户证件号',
  `rbankcard_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户银行卡号',
  `rpid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品代码',
  `ramount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '赎回金额',
  `rtime` datetime NOT NULL COMMENT '赎回日期',
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '柜台人员账号',
  `rshare` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '赎回份额',
  PRIMARY KEY (`rcid`, `rbankcard_number`, `rpid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of redemption_information
-- ----------------------------

-- ----------------------------
-- Table structure for subscribe_information
-- ----------------------------
DROP TABLE IF EXISTS `subscribe_information`;
CREATE TABLE `subscribe_information`  (
  `scname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户姓名',
  `scid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户证件号',
  `sbankcard_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户银行卡号',
  `spid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品代码',
  `samount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '购买金额',
  `stime` datetime NOT NULL COMMENT '申购日期',
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '柜台人员账号',
  `state` int NOT NULL DEFAULT 0 COMMENT '申购表状态',
  `share` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '购买份额',
  PRIMARY KEY (`scid`, `sbankcard_number`, `spid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subscribe_information
-- ----------------------------

-- ----------------------------
-- Table structure for system_state
-- ----------------------------
DROP TABLE IF EXISTS `system_state`;
CREATE TABLE `system_state`  (
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态 ',
  `state_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态名字',
  PRIMARY KEY (`state_name`, `state`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_state
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
