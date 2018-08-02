/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50637
 Source Host           : 127.0.0.1:3306
 Source Schema         : property

 Target Server Type    : MySQL
 Target Server Version : 50637
 File Encoding         : 65001

 Date: 06/06/2018 13:42:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `bid` int(8) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `bName` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '楼栋名称',
  `floorNum` int(3) DEFAULT NULL COMMENT '层数',
  `houseNum` int(2) DEFAULT NULL COMMENT '每层房间数',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, 'A', 17, 5);
INSERT INTO `building` VALUES (2, 'B', 17, 5);
INSERT INTO `building` VALUES (3, 'C', 17, 5);
INSERT INTO `building` VALUES (4, 'D', 17, 5);
INSERT INTO `building` VALUES (5, 'E', 17, 5);
INSERT INTO `building` VALUES (6, 'F', 17, 5);
INSERT INTO `building` VALUES (7, 'G', 17, 5);
INSERT INTO `building` VALUES (16, 'Z', 20, 5);
INSERT INTO `building` VALUES (17, 'S', 10, 2);
INSERT INTO `building` VALUES (18, 'AS', 10, 3);
INSERT INTO `building` VALUES (19, 'AA', 10, 3);

-- ----------------------------
-- Table structure for carport
-- ----------------------------
DROP TABLE IF EXISTS `carport`;
CREATE TABLE `carport`  (
  `carport_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '车位编号',
  `carport_position` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '车位位置',
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `owner_id` int(8) DEFAULT NULL COMMENT '业主编号',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `stopdate` date DEFAULT NULL COMMENT '截至日期',
  `area` double(10, 2) DEFAULT NULL COMMENT '车位面积',
  `carport_fee` double(10, 2) DEFAULT NULL COMMENT '费用',
  `cfee` int(10) DEFAULT NULL COMMENT '缴费信息',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '车位状态',
  PRIMARY KEY (`carport_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of carport
-- ----------------------------
INSERT INTO `carport` VALUES (1, 'A001', 'A1101', NULL, '2017-10-27', '2017-11-27', 10.00, 666.00, 23, '已使用');
INSERT INTO `carport` VALUES (2, 'A002', 'A1201', 1, '2017-10-01', '2017-11-26', 10.00, 1000.00, NULL, '已使用');
INSERT INTO `carport` VALUES (4, 'A004', 'A1302', NULL, '2017-11-01', '2017-11-30', 10.00, 1000.00, 31, '已使用');
INSERT INTO `carport` VALUES (6, 'A005', 'A1302', NULL, '2017-11-01', '2017-11-30', 10.00, 1000.00, 32, '已使用');
INSERT INTO `carport` VALUES (8, 'A008', 'A1301', NULL, '2017-11-08', '2017-11-30', 10.00, 1000.00, 34, '已使用');
INSERT INTO `carport` VALUES (9, 'A009', 'A1101', NULL, '2017-11-20', '2018-11-30', 10.00, 1000.00, 35, '已使用');
INSERT INTO `carport` VALUES (10, 'A010', 'A1403', NULL, '2017-11-23', '2017-12-31', 10.00, 1101.00, 36, '已使用');
INSERT INTO `carport` VALUES (11, 'A011', 'S1001', NULL, '2017-12-25', '2018-01-31', 10.00, 1000.00, 43, '已使用');
INSERT INTO `carport` VALUES (12, 'A012', 'AS1003', NULL, '2017-12-26', '2018-12-31', 10.00, 10000.00, 46, '已使用');
INSERT INTO `carport` VALUES (13, 'A013', 'AS1003', NULL, '2017-12-26', '2018-12-24', 10.00, 9000.00, 47, '已使用');
INSERT INTO `carport` VALUES (14, 'A014', 'A1305', NULL, '2017-05-01', '2018-05-24', 10.00, 34343.00, 50, '已使用');
INSERT INTO `carport` VALUES (15, 'A015', 'A1201', NULL, '2018-05-01', '2018-05-23', 10.00, 23232.00, 52, '已使用');
INSERT INTO `carport` VALUES (16, 'A016', 'A1101', 1, '2017-10-01', '2017-11-26', 10.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (17, 'A017', 'A1401', NULL, '2017-04-05', '2018-05-24', 10.00, 50000.00, 49, '已使用');
INSERT INTO `carport` VALUES (18, 'A018', 'A1101', 1, '2017-10-01', '2017-11-26', 10.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (19, 'A019', 'A1101', 1, '2017-10-01', '2017-11-26', 10.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (20, 'A020', 'A1101', 1, '2017-10-01', '2017-11-26', 10.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (21, 'A021', 'A1101', 1, '2017-10-01', '2017-11-26', 10.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (35, 'A023', 'A1101', 3, '2017-10-01', '2017-12-30', 13.00, 2000.00, 0, '未使用');
INSERT INTO `carport` VALUES (36, 'A025', 'A1101', 2, '2017-10-10', '2017-12-30', 14.00, 2000.00, 0, '未使用');
INSERT INTO `carport` VALUES (37, 'A029', 'A1101', 3, '2017-09-01', '2017-12-31', 14.00, 2000.00, 0, '未使用');
INSERT INTO `carport` VALUES (38, 'A026', 'A1101', 7, '2017-10-07', '2017-11-30', 12.00, 77.00, 0, '未使用');
INSERT INTO `carport` VALUES (39, 'A028', 'A1101', 7, '2017-10-04', '2017-10-20', 12.00, 800.00, 0, '未使用');
INSERT INTO `carport` VALUES (40, 'A030', 'A1101', 10, '2017-10-07', '2017-10-31', 14.00, 900.00, 0, '未使用');
INSERT INTO `carport` VALUES (41, 'A027', 'A1101', 1, '2017-10-01', '2017-10-31', 12.00, 800.00, 0, '未使用');
INSERT INTO `carport` VALUES (42, 'A022', NULL, NULL, NULL, NULL, 11.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (43, 'B003', NULL, NULL, NULL, NULL, 12.00, 1000.00, NULL, '未使用');
INSERT INTO `carport` VALUES (44, 'A031', 'A1101', NULL, '2017-11-01', '2017-11-30', 10.00, 2000.00, NULL, '已使用');
INSERT INTO `carport` VALUES (45, 'A048', NULL, NULL, NULL, NULL, 10.00, NULL, NULL, '未使用');
INSERT INTO `carport` VALUES (46, 'A050', NULL, NULL, NULL, NULL, 10.00, NULL, NULL, '未使用');
INSERT INTO `carport` VALUES (47, 'B004', NULL, NULL, NULL, NULL, 12.00, NULL, NULL, '未使用');
INSERT INTO `carport` VALUES (48, 'B001', NULL, NULL, NULL, NULL, 12.00, NULL, NULL, '未使用');

-- ----------------------------
-- Table structure for charge
-- ----------------------------
DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge`  (
  `charge_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '收费编号',
  `owner_id` int(8) DEFAULT NULL COMMENT '业主编号',
  `position` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `project` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收费项目',
  `way` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收费方式',
  `unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '计量单位',
  `used` double(10, 2) DEFAULT NULL COMMENT '用量',
  `price` double(10, 2) DEFAULT NULL COMMENT '单价',
  `total` double(10, 2) DEFAULT NULL COMMENT '应收总额',
  `inperson` int(8) DEFAULT NULL COMMENT '录入人',
  `indate` date DEFAULT NULL COMMENT '录入日期',
  `paydate` date DEFAULT NULL COMMENT '缴费日期',
  `transactor` int(8) DEFAULT NULL COMMENT '办理人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`charge_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of charge
-- ----------------------------
INSERT INTO `charge` VALUES (1, 1, 'A1201', '电费', '在线', '度', 100.00, 1.00, 100.00, 12, '2017-01-07', '2017-12-22', NULL, NULL);
INSERT INTO `charge` VALUES (2, 1, 'A1201', '水费', '在线', '吨', 100.00, 1.00, 100.00, 12, '2017-02-07', '2017-12-22', NULL, NULL);
INSERT INTO `charge` VALUES (3, 1, 'A1201', '天然气费', '在线', '升', 100.00, 1.00, 100.00, 12, '2017-10-03', '2017-12-22', NULL, NULL);
INSERT INTO `charge` VALUES (4, 1, 'A1201', '电费', '在线', '度', 100.00, 1.00, 100.00, 12, '2017-03-16', '2017-12-22', NULL, NULL);
INSERT INTO `charge` VALUES (6, 18, 'A1201', '电费', '在线', '度', 100.00, 1.00, 100.00, 12, '2017-04-07', '2017-10-20', NULL, NULL);
INSERT INTO `charge` VALUES (7, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-05-07', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (8, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-06-30', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (9, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-07-13', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (11, 1, 'A1201', '电费', '在线', '度', 100.00, 1.00, 100.00, 12, '2017-08-23', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (12, 1, 'A1201', '水费', '现金', '吨', 100.00, 1.00, 100.00, 12, '2017-09-13', '2017-10-16', 1, NULL);
INSERT INTO `charge` VALUES (13, 1, 'A1201', '天然气费', '现金', '升', 100.00, 1.00, 100.00, 12, '2017-07-13', '2017-10-16', 1, NULL);
INSERT INTO `charge` VALUES (14, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (15, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-08-16', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (16, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-09-20', '2017-11-21', 1, NULL);
INSERT INTO `charge` VALUES (17, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-06-07', '2017-11-12', 1, NULL);
INSERT INTO `charge` VALUES (18, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-05-17', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (19, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-04-12', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (20, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-03-30', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (21, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-02-28', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (22, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-01-03', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (23, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (24, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (25, 1, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (26, 3, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (27, 3, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (28, 3, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (29, 3, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (30, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (31, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (32, 2, 'A1101', '电费', '现金', '度', 100.00, 1.00, 100.00, 12, '2017-10-07', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (34, NULL, 'A1101', '电费', '现金', '元/度', 300.00, 1.00, 300.00, 1, '2017-10-27', '2017-10-27', 1, NULL);
INSERT INTO `charge` VALUES (36, NULL, 'A1402', '电费', '现金', '元/度', 10000.00, 1.00, 10000.00, 1, '2017-10-28', '2017-10-28', 1, NULL);
INSERT INTO `charge` VALUES (37, NULL, 'A1402', '水费', '现金', '元/吨', 10000.00, 1.00, 10000.00, 1, '2017-10-28', '2017-10-28', 1, NULL);
INSERT INTO `charge` VALUES (38, NULL, 'A1402', '天然气费', '现金', '元/升', 10000.00, 1.00, 10000.00, 1, '2017-10-28', '2017-10-28', 1, NULL);
INSERT INTO `charge` VALUES (39, 26, 'A1205', '电费', '在线', '元/度', 10000.00, 1.00, 10000.00, 1, '2017-11-01', '2017-11-01', NULL, NULL);
INSERT INTO `charge` VALUES (40, 26, 'A1205', '水费', '在线', '元/吨', 10000.00, 12.00, 120000.00, 1, '2017-11-01', '2017-11-01', NULL, NULL);
INSERT INTO `charge` VALUES (41, 1, 'A1201', '天然气费', '在线', '元/升', 300.00, 2.00, 600.00, 1, '2017-11-01', '2017-11-12', NULL, NULL);
INSERT INTO `charge` VALUES (42, NULL, 'A1205', '电费', '现金', '元/度', 300.00, 1.00, 300.00, 1, '2017-11-01', '2017-11-01', 1, NULL);
INSERT INTO `charge` VALUES (43, NULL, 'A1205', '水费', '现金', '元/吨', 133.00, 12.00, 1596.00, 1, '2017-11-01', '2017-11-01', 1, NULL);
INSERT INTO `charge` VALUES (44, NULL, 'A1205', '电费', '现金', '元/度', 366.00, 1.00, 366.00, 1, '2017-11-01', '2017-11-01', 1, NULL);
INSERT INTO `charge` VALUES (45, 1, 'A1201', '电费', '在线', '元/度', 1111.00, 1.00, 1111.00, 1, '2017-11-01', '2017-11-12', NULL, NULL);
INSERT INTO `charge` VALUES (46, 1, 'A1201', '电费', '在线', '元/度', 120.00, 1.00, 120.00, 1, '2017-11-02', '2017-11-12', NULL, NULL);
INSERT INTO `charge` VALUES (47, 1, 'A1201', '水费', '在线', '元/吨', 300.00, 12.00, 3600.00, 1, '2017-11-02', '2017-11-12', NULL, NULL);
INSERT INTO `charge` VALUES (48, 27, 'A1302', '电费', '在线', '元/度', 144.00, 1.00, 144.00, 1, '2017-11-08', '2017-11-08', NULL, NULL);
INSERT INTO `charge` VALUES (49, 27, 'A1302', '水费', '在线', '元/吨', 5555.00, 12.00, 66660.00, 1, '2017-11-08', '2017-11-08', NULL, NULL);
INSERT INTO `charge` VALUES (50, 27, 'A1302', '天然气费', '在线', '元/升', 666.00, 2.00, 1332.00, 1, '2017-11-08', '2017-11-08', NULL, NULL);
INSERT INTO `charge` VALUES (51, NULL, 'A1302', '电费', '现金', '元/度', 111.00, 1.00, 111.00, 1, '2017-11-08', '2017-11-08', 1, NULL);
INSERT INTO `charge` VALUES (52, NULL, 'A1101', '电费', '现金', '元/度', 122.00, 1.00, 122.00, 1, '2017-11-08', '2017-11-08', 1, NULL);
INSERT INTO `charge` VALUES (53, 28, 'A1301', '电费', '在线', '元/度', 144.00, 1.00, 144.00, 1, '2017-11-08', '2017-11-08', NULL, NULL);
INSERT INTO `charge` VALUES (54, 28, 'A1301', '水费', '在线', '元/吨', 100.00, 12.00, 1200.00, 1, '2017-11-08', '2017-11-08', NULL, NULL);
INSERT INTO `charge` VALUES (55, 28, 'A1301', '天然气费', '在线', '元/升', 100.00, 2.00, 200.00, 1, '2017-11-08', '2017-11-08', NULL, NULL);
INSERT INTO `charge` VALUES (56, NULL, 'A1101', '电费', '现金', '元/度', 111.00, 1.00, 111.00, 1, '2017-11-08', '2017-11-08', 1, NULL);
INSERT INTO `charge` VALUES (57, NULL, 'A1101', '水费', '现金', '元/吨', 122.00, 12.00, 1464.00, 1, '2017-11-08', '2017-11-08', 1, NULL);
INSERT INTO `charge` VALUES (58, 1, 'A1201', '电费', '在线', '元/度', 100.00, 2.00, 200.00, 1, '2017-11-12', '2017-11-12', NULL, NULL);
INSERT INTO `charge` VALUES (59, 46, 'A1403', '电费', '在线', '元/度', 555.00, 5.00, 2775.00, 1, '2017-11-23', '2017-11-23', NULL, NULL);
INSERT INTO `charge` VALUES (60, 46, 'A1403', '天然气费', '在线', '元/升', 634.00, 3.00, 1902.00, 1, '2017-11-23', '2017-11-23', NULL, NULL);
INSERT INTO `charge` VALUES (61, NULL, 'B0101', '电费', '现金', '元/度', 300.00, 2.00, 600.00, 1, '2017-11-23', '2017-11-23', 1, NULL);
INSERT INTO `charge` VALUES (62, NULL, 'B0101', '水费', '现金', '元/吨', 200.00, 2.00, 400.00, 1, '2017-11-23', '2017-11-23', 1, NULL);
INSERT INTO `charge` VALUES (63, NULL, 'B0101', '天然气费', '现金', '元/升', 100.00, 3.00, 300.00, 1, '2017-11-23', '2017-11-23', 1, NULL);
INSERT INTO `charge` VALUES (64, 47, 'B0101', '电费', '在线', '元/度', 111.00, 2.00, 222.00, 1, '2017-11-23', '2017-11-23', NULL, NULL);
INSERT INTO `charge` VALUES (65, NULL, 'B0101', '电费', '未交', '元/度', 100.00, 2.00, 200.00, 1, '2017-11-23', NULL, NULL, NULL);
INSERT INTO `charge` VALUES (66, NULL, 'B0101', '电费', '未交', '元/度', 300.00, 2.00, 600.00, 1, '2017-11-23', NULL, NULL, NULL);
INSERT INTO `charge` VALUES (67, NULL, 'A1304', '电费', '现金', '元/度', 200.00, 5.00, 1000.00, 1, '2017-11-28', '2018-05-09', 1, NULL);
INSERT INTO `charge` VALUES (68, NULL, 'S1001', '电费', '现金', '元/度', 303.00, 1.30, 393.90, 1, '2017-12-25', '2017-12-25', 1, NULL);
INSERT INTO `charge` VALUES (69, NULL, 'S1001', '水费', '现金', '元/吨', 144.00, 1.40, 201.60, 1, '2017-12-25', '2017-12-25', 1, NULL);
INSERT INTO `charge` VALUES (70, NULL, 'S1001', '天然气费', '现金', '元/升', 111.00, 3.30, 366.30, 1, '2017-12-25', '2017-12-25', 1, NULL);
INSERT INTO `charge` VALUES (71, 52, 'S1001', '电费', '在线', '元/度', 66666.00, 1.30, 86665.80, 1, '2017-12-25', '2017-12-25', NULL, NULL);
INSERT INTO `charge` VALUES (72, 53, 'AS1003', '电费', '在线', '元/度', 300.30, 4.00, 1201.20, 1, '2017-12-26', '2017-12-26', NULL, NULL);
INSERT INTO `charge` VALUES (73, 53, 'AS1003', '水费', '在线', '元/吨', 200.00, 1.30, 260.00, 1, '2017-12-26', '2017-12-26', NULL, NULL);
INSERT INTO `charge` VALUES (74, 53, 'AS1003', '天然气费', '在线', '元/升', 500.00, 3.30, 1650.00, 1, '2017-12-26', '2017-12-26', NULL, NULL);
INSERT INTO `charge` VALUES (75, 54, 'AA0101', '电费', '在线', '元/度', 300.00, 2.20, 660.00, 1, '2017-12-27', '2017-12-27', NULL, NULL);
INSERT INTO `charge` VALUES (76, 54, 'AA0101', '水费', '在线', '元/吨', 333.00, 1.10, 366.30, 1, '2017-12-27', '2017-12-27', NULL, NULL);
INSERT INTO `charge` VALUES (77, 54, 'AA0101', '天然气费', '在线', '元/升', 122.00, 3.30, 402.60, 1, '2017-12-27', '2017-12-27', NULL, NULL);
INSERT INTO `charge` VALUES (78, 55, 'A1401', '电费', '在线', '元/度', 123142.00, 2.20, 270912.40, 1, '2018-05-09', '2018-05-09', NULL, NULL);
INSERT INTO `charge` VALUES (79, 55, 'A1401', '水费', '在线', '元/吨', 123.00, 2.40, 295.20, 1, '2018-05-09', '2018-05-09', NULL, NULL);
INSERT INTO `charge` VALUES (80, 55, 'A1401', '天然气费', '在线', '元/升', 1231.00, 1.10, 1354.10, 1, '2018-05-09', '2018-05-09', NULL, NULL);
INSERT INTO `charge` VALUES (81, 56, 'A1305', '电费', '在线', '元/度', 12312.00, 2.20, 27086.40, 1, '2018-05-09', '2018-05-09', NULL, NULL);
INSERT INTO `charge` VALUES (82, 1, 'A1201', '水费', '在线', '元/吨', 1111.00, 2.40, 2666.40, 1, '2018-05-09', '2018-05-09', NULL, NULL);
INSERT INTO `charge` VALUES (83, NULL, 'A1201', '电费', '未交', '元/度', 1231.00, 2.20, 2708.20, 1, '2018-05-09', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for complaint
-- ----------------------------
DROP TABLE IF EXISTS `complaint`;
CREATE TABLE `complaint`  (
  `complaint_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '投诉编号',
  `complaint_date` date DEFAULT NULL COMMENT '投诉日期',
  `owner_id` int(8) DEFAULT NULL COMMENT '业主编号',
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `complaint_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '状态',
  `handledate` date DEFAULT NULL COMMENT '处理日期',
  `handler` int(8) DEFAULT NULL COMMENT '处理人编号',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '投诉内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`complaint_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of complaint
-- ----------------------------
INSERT INTO `complaint` VALUES (1, '2017-09-01', 1, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (2, '2017-08-31', 1, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (3, '2017-07-13', 1, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (4, '2017-06-22', 1, 'A1201', '15186469868', '已评价', '2017-10-27', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (5, '2017-08-16', 1, 'A1201', '15186469868', '已评价', '2017-10-19', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (6, '2017-10-03', 1, 'A1201', '15186469868', '已评价', '2017-10-19', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (7, '2017-05-11', 1, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (8, '2017-04-12', 1, 'A1101', '15186469868', '已处理', '2017-10-27', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (9, '2017-03-22', 1, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (10, '2017-02-16', 1, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (11, '2017-01-11', 2, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (12, '2016-12-15', 2, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (13, '2017-10-19', 2, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (14, '2017-01-14', 2, 'A1101', '15186469868', '未处理', NULL, NULL, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (16, '2017-01-18', 2, 'A1102', '15846523636', '已处理', '2017-10-12', 1, '草坪有狗屎', '已清理');
INSERT INTO `complaint` VALUES (23, '2017-02-15', NULL, 'A1504', '15846523636', '未处理', NULL, NULL, '小区路太滑了', '');
INSERT INTO `complaint` VALUES (24, '2017-03-10', NULL, 'A1201', '15986532323', '未处理', NULL, NULL, 'sjdfksdjalg', 'sdfsadf');
INSERT INTO `complaint` VALUES (25, '2017-04-11', 32, 'A1201', '15777770909', '未处理', NULL, NULL, '这是测试', '435345');
INSERT INTO `complaint` VALUES (26, '2017-05-12', 32, 'A1201', '15830305050', '未处理', NULL, NULL, '3498TDFUIT3498T', '34563456');
INSERT INTO `complaint` VALUES (27, '2017-07-21', 32, 'A1201', '13590907878', '已评价', NULL, NULL, '5467545463RTYRT', '345436');
INSERT INTO `complaint` VALUES (28, '2017-10-27', NULL, 'A1103', '18700023564', '已处理', '2017-10-27', 1, '斯蒂芬斯蒂芬斯', '123');
INSERT INTO `complaint` VALUES (30, '2017-11-02', 1, 'A1201', '18700023564', '未处理', NULL, NULL, '家里没有阳光', '');
INSERT INTO `complaint` VALUES (31, '2017-11-08', 40, 'A1302', '18700023564', '已评价', '2017-11-08', 1, '2134241', '2345');
INSERT INTO `complaint` VALUES (32, '2017-11-08', NULL, 'A1302', '18700023564', '已处理', '2017-11-08', 1, '352345', '4564');
INSERT INTO `complaint` VALUES (33, '2017-11-08', 41, 'A1301', '18700023564', '已评价', '2017-11-08', 1, '324234', '');
INSERT INTO `complaint` VALUES (34, '2017-11-08', NULL, 'A1101', '18700023564', '未处理', NULL, NULL, '452525', '');
INSERT INTO `complaint` VALUES (35, '2017-11-20', NULL, 'A1101', '18700023564', '未处理', NULL, NULL, 'ccccccccc', NULL);
INSERT INTO `complaint` VALUES (36, '2017-11-23', NULL, 'A1403', '18700023564', '未处理', NULL, NULL, '123123', NULL);
INSERT INTO `complaint` VALUES (37, '2017-11-23', 47, 'B0101', '18700023564', '已评价', '2017-11-23', 1, '11111111111', '');
INSERT INTO `complaint` VALUES (38, '2017-10-01', 1, 'A1201', '15186469868', '已处理', '2017-10-19', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (39, '2017-10-03', 1, 'A1201', '15186469868', '已评价', '2017-10-19', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (40, '2017-10-03', 1, 'A1201', '15186469868', '已评价', '2017-10-19', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (41, '2017-10-03', 1, 'A1201', '15186469868', '已评价', '2017-10-19', 1, '服务态度差', NULL);
INSERT INTO `complaint` VALUES (42, '2017-12-22', NULL, 'A1201', '15723463114', '未处理', NULL, NULL, '适当是的噶速度跟', NULL);
INSERT INTO `complaint` VALUES (43, '2017-12-25', NULL, 'S1001', '15986532323', '已评价', '2017-12-25', 1, '1213312312', NULL);
INSERT INTO `complaint` VALUES (44, '2017-12-26', NULL, 'AS1003', '15846523636', '已评价', '2017-12-26', 1, '服务态度太差了', NULL);
INSERT INTO `complaint` VALUES (45, '2017-12-27', NULL, 'AA0101', '18720148610', '已评价', '2017-12-27', 1, '小区环境太差', NULL);
INSERT INTO `complaint` VALUES (46, '2018-05-09', NULL, 'A1401', '18720148610', '未处理', NULL, NULL, '服务态度太差', NULL);
INSERT INTO `complaint` VALUES (47, '2018-05-09', NULL, 'A1305', '18720148610', '已处理', '2018-05-09', 1, '是的发生士大夫', NULL);
INSERT INTO `complaint` VALUES (48, '2018-05-09', NULL, 'A1305', '18720148610', '未处理', NULL, NULL, '手动阀实打实的', NULL);
INSERT INTO `complaint` VALUES (49, '2018-05-09', NULL, 'A1201', '18720148610', '已处理', '2018-05-09', 1, '墙壁GG了', NULL);
INSERT INTO `complaint` VALUES (50, '2018-05-09', NULL, 'A1201', '18720148610', '未处理', NULL, NULL, '这是一条投诉信息', '');
INSERT INTO `complaint` VALUES (51, '2018-05-09', NULL, 'A1201', '18720148610', '未处理', NULL, NULL, '投诉投诉投诉投诉', NULL);

-- ----------------------------
-- Table structure for electricity
-- ----------------------------
DROP TABLE IF EXISTS `electricity`;
CREATE TABLE `electricity`  (
  `electricity_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '电表编号',
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `startdate` date DEFAULT NULL COMMENT '启用日期',
  `price` double(10, 2) DEFAULT NULL COMMENT '单价',
  PRIMARY KEY (`electricity_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of electricity
-- ----------------------------
INSERT INTO `electricity` VALUES (1, 'A1101', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (2, 'A1102', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (3, 'A1103', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (4, 'A1201', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (5, 'A1202', '2017-10-08', 2.20);
INSERT INTO `electricity` VALUES (6, 'A1203', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (7, 'A1204', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (8, 'A1205', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (9, 'A1301', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (10, 'A1302', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (11, 'A1303', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (12, 'A1304', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (13, 'A1305', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (14, 'A1401', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (15, 'A1402', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (16, 'A1403', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (17, 'A1404', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (18, 'A1405', '2017-07-01', 2.20);
INSERT INTO `electricity` VALUES (19, 'B0101', '2017-11-23', 2.20);
INSERT INTO `electricity` VALUES (20, 'C0301', '2017-11-27', 2.20);
INSERT INTO `electricity` VALUES (21, 'S1001', '2017-12-25', 2.20);
INSERT INTO `electricity` VALUES (22, 'AS1003', '2017-12-26', 2.20);
INSERT INTO `electricity` VALUES (23, 'AA0101', '2017-12-27', 2.20);

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `equipment_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '设备编号',
  `equipment_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备名称',
  `brand` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品牌',
  `version` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '型号',
  `department` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属部门',
  `costdate` date DEFAULT NULL COMMENT '购买日期',
  `cost` double(10, 2) DEFAULT NULL COMMENT '购买价格',
  `startdate` date DEFAULT NULL COMMENT '启用日期',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`equipment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (1, '太阳能电池板', '兴圣', 'v123', '保安部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (2, '太阳能电池板', '兴圣', 'v123', '维修部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (3, '太阳能电池板', '兴圣', 'v123', '维修部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (4, '太阳能电池板', '兴圣', 'v123', '维修部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (5, '太阳能电池板', '兴圣', 'v123', '维修部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (6, '太阳能电池板', '兴圣', 'v123', '维修部', '2017-10-01', 3000.00, '2017-10-02', '维修');
INSERT INTO `equipment` VALUES (7, '太阳能电池板', '兴圣', 'v123', '维修部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (8, '太阳能电池板', '兴圣', 'v123', '清洁部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (9, '太阳能电池板', '兴圣', 'v123', '清洁部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (10, '太阳能电池板', '兴圣', 'v123', '清洁部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (11, '太阳能电池板', '兴圣', 'v123', '人事部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (12, '太阳能电池板', '兴圣', 'v123', '人事部', '2017-10-01', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (13, '太阳能电池板', '兴圣', 'v123', '人事部', '2017-09-05', 3000.00, '2017-10-02', '正常');
INSERT INTO `equipment` VALUES (15, '打印机', '品牌1', '型号1', '人事部', '2017-10-01', 3000.00, '2017-10-14', '正常');
INSERT INTO `equipment` VALUES (16, '投影仪', '品牌1', '型号1', '人事部', '2017-10-01', 2000.00, '2017-10-03', '正常');
INSERT INTO `equipment` VALUES (17, '打印机', '兴圣', 'v123', '人事部', '2017-11-08', 2000.00, '2017-11-08', '正常');
INSERT INTO `equipment` VALUES (18, '打印机A', '品牌1', '型号1', '人事部', '2017-11-23', 3000.00, '2017-11-23', '正常');

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate`  (
  `eId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价编号',
  `star` int(1) DEFAULT NULL COMMENT '评星',
  `econtent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '内容',
  `eType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '评价类型',
  `targetId` int(4) DEFAULT NULL COMMENT '目标编号',
  `eDate` datetime(0) DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`eId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of evaluate
-- ----------------------------
INSERT INTO `evaluate` VALUES (6, 0, '', 'complaint', 5, '2017-10-22 14:25:37');
INSERT INTO `evaluate` VALUES (7, 5, '', 'complaint', 6, '2017-10-22 14:41:42');
INSERT INTO `evaluate` VALUES (8, 5, '', 'repair', 3, '2017-10-22 14:54:00');
INSERT INTO `evaluate` VALUES (9, 5, '很好', 'repair', 28, '2017-11-08 13:42:59');
INSERT INTO `evaluate` VALUES (10, 5, '345345', 'complaint', 31, '2017-11-08 13:43:34');
INSERT INTO `evaluate` VALUES (11, 5, '5345', 'complaint', 33, '2017-11-08 16:04:01');
INSERT INTO `evaluate` VALUES (12, 5, '23423', 'repair', 30, '2017-11-08 16:05:11');
INSERT INTO `evaluate` VALUES (13, 4, '231423', 'repair', 6, '2017-11-21 16:48:17');
INSERT INTO `evaluate` VALUES (14, 5, '', 'complaint', 37, '2017-11-23 14:51:31');
INSERT INTO `evaluate` VALUES (15, 5, '', 'repair', 34, '2017-11-23 14:51:43');
INSERT INTO `evaluate` VALUES (16, 5, '非常好', 'complaint', 4, '2017-12-21 23:43:09');
INSERT INTO `evaluate` VALUES (17, 4, '处理的还行吧', 'complaint', 39, '2017-12-21 23:45:33');
INSERT INTO `evaluate` VALUES (18, 4, '666666', 'complaint', 27, '2017-12-22 10:17:19');
INSERT INTO `evaluate` VALUES (19, 5, 'hsosdfasdf', 'repair', 27, '2017-12-22 10:19:27');
INSERT INTO `evaluate` VALUES (20, 5, '非常好', 'repair', 40, '2017-12-25 16:13:00');
INSERT INTO `evaluate` VALUES (21, 5, '非常好', 'complaint', 43, '2017-12-25 16:13:13');
INSERT INTO `evaluate` VALUES (22, 5, '非常好', 'complaint', 44, '2017-12-26 11:29:43');
INSERT INTO `evaluate` VALUES (23, 5, '非常好', 'repair', 41, '2017-12-26 11:29:57');
INSERT INTO `evaluate` VALUES (24, 5, '满意', 'repair', 42, '2017-12-27 17:03:30');
INSERT INTO `evaluate` VALUES (25, 5, '非常好', 'complaint', 45, '2017-12-27 17:03:44');
INSERT INTO `evaluate` VALUES (26, 5, '666666666', 'repair', 44, '2018-05-09 14:10:12');

-- ----------------------------
-- Table structure for gas
-- ----------------------------
DROP TABLE IF EXISTS `gas`;
CREATE TABLE `gas`  (
  `gas_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '天然气表编号',
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `startdate` date DEFAULT NULL COMMENT '启用日期',
  `price` double(10, 2) DEFAULT NULL COMMENT '单价',
  PRIMARY KEY (`gas_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gas
-- ----------------------------
INSERT INTO `gas` VALUES (1, 'A1101', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (2, 'A1102', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (3, 'A1103', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (4, 'A1201', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (5, 'A1202', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (6, 'A1203', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (7, 'A1204', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (8, 'A1205', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (9, 'A1301', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (10, 'A1302', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (11, 'A1303', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (12, 'A1304', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (13, 'A1305', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (14, 'A1401', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (15, 'A1402', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (16, 'A1403', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (17, 'A1404', '2017-07-01', 1.10);
INSERT INTO `gas` VALUES (18, 'A1405', '2017-07-03', 1.10);
INSERT INTO `gas` VALUES (19, 'B0101', '2017-11-23', 1.10);
INSERT INTO `gas` VALUES (20, 'C0301', '2017-11-27', 1.10);
INSERT INTO `gas` VALUES (21, 'S1001', '2017-12-25', 1.10);
INSERT INTO `gas` VALUES (22, 'AS1003', '2017-12-26', 1.10);
INSERT INTO `gas` VALUES (23, 'AA0101', '2017-12-27', 3.30);

-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house`  (
  `house_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '房产编号',
  `position` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `area` double(10, 2) DEFAULT NULL COMMENT '建筑面积',
  `usedarea` double(10, 2) DEFAULT NULL COMMENT '使用面积',
  `house_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '房型',
  `workoff` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否售出',
  `owner_id` int(8) DEFAULT NULL COMMENT '业主编号',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`house_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of house
-- ----------------------------
INSERT INTO `house` VALUES (1, 'A1101', 120.00, 90.00, '三室一厅', '已入住', 1, NULL);
INSERT INTO `house` VALUES (2, 'A1102', 120.00, 90.00, '三室一厅', '已入住', 1, NULL);
INSERT INTO `house` VALUES (3, 'A1103', 120.00, 90.00, '三室一厅', '已入住', 1, NULL);
INSERT INTO `house` VALUES (4, 'A1201', 120.00, 90.00, '三室一厅', '已入住', 1, NULL);
INSERT INTO `house` VALUES (5, 'A1202', 100.00, 85.00, '二室一厅', '已入住', NULL, '');
INSERT INTO `house` VALUES (6, 'A1203', 110.00, 90.00, '三室一厅', '已入住', 1, '');
INSERT INTO `house` VALUES (7, 'A1204', 120.00, 90.00, '三室一厅', '已入住', 37, NULL);
INSERT INTO `house` VALUES (8, 'A1205', 120.00, 90.00, '三室一厅', '已入住', 39, NULL);
INSERT INTO `house` VALUES (9, 'A1301', 120.00, 90.00, '三室一厅', '已入住', 41, NULL);
INSERT INTO `house` VALUES (10, 'A1302', 120.00, 90.00, '三室一厅', '已入住', 40, NULL);
INSERT INTO `house` VALUES (11, 'A1303', 120.00, 90.00, '三室一厅', '已入住', 42, NULL);
INSERT INTO `house` VALUES (12, 'A1304', 120.00, 90.00, '三室一厅', '已入住', 51, NULL);
INSERT INTO `house` VALUES (13, 'A1305', 120.00, 90.00, '三室一厅', '已入住', 56, NULL);
INSERT INTO `house` VALUES (14, 'A1401', 120.00, 90.00, '三室一厅', '已入住', 55, NULL);
INSERT INTO `house` VALUES (15, 'A1402', 120.00, 90.00, '三室一厅', '已入住', 38, NULL);
INSERT INTO `house` VALUES (16, 'A1403', 120.00, 90.00, '三室一厅', '已入住', 46, NULL);
INSERT INTO `house` VALUES (17, 'A1404', 120.00, 90.00, '三室一厅', '已入住', 57, NULL);
INSERT INTO `house` VALUES (18, 'A1405', 120.00, 90.00, '三室一厅', '售出', 1, NULL);
INSERT INTO `house` VALUES (19, 'A1501', 120.00, 90.00, '三室一厅', '售出', 1, NULL);
INSERT INTO `house` VALUES (20, 'A1502', 120.00, 90.00, '三室一厅', '售出', 1, NULL);
INSERT INTO `house` VALUES (21, 'A1503', 120.00, 90.00, '三室一厅', '售出', 1, NULL);
INSERT INTO `house` VALUES (22, 'A1504', 120.00, 90.00, '三室一厅', '售出', 1, '2134');
INSERT INTO `house` VALUES (24, 'A1505', 150.00, 110.00, '三室两厅', '售出', 1, '备注');
INSERT INTO `house` VALUES (25, 'A1601', 150.00, 140.00, '四室二厅', '售出', NULL, '');
INSERT INTO `house` VALUES (26, 'A1133', 133.00, 120.00, '四室二厅', '售出', NULL, '');
INSERT INTO `house` VALUES (27, 'C0301', 110.00, 90.00, '四室二厅', '已入住', 48, '');
INSERT INTO `house` VALUES (28, 'A0402', 110.00, 98.00, '二室一厅', '售出', NULL, '');
INSERT INTO `house` VALUES (29, 'A0101', 100.00, 90.00, '二室一厅', '售出', NULL, '');
INSERT INTO `house` VALUES (30, 'B0101', 120.00, 100.00, '四室二厅', '已入住', 47, '');
INSERT INTO `house` VALUES (31, 'D0402', 150.00, 140.00, '四室二厅', '已入住', 49, '');
INSERT INTO `house` VALUES (32, 'S1001', 150.00, 120.00, '四室二厅', '已入住', 52, '');
INSERT INTO `house` VALUES (33, 'AS1003', 200.00, 180.00, '四室二厅', '已入住', 53, '');
INSERT INTO `house` VALUES (34, 'AA0101', 110.00, 90.00, '四室二厅', '已入住', 54, '');
INSERT INTO `house` VALUES (35, 'C0202', 12.00, 123.00, '四室三厅', '售出', NULL, '');

-- ----------------------------
-- Table structure for maintenance
-- ----------------------------
DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE `maintenance`  (
  `maintenance_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '维修编号',
  `equipment_id` int(8) DEFAULT NULL COMMENT '设备编号',
  `equipment_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备名称',
  `maintenance_date` date DEFAULT NULL COMMENT '维修日期',
  `finisheddate` date DEFAULT NULL COMMENT '完成日期',
  `maintenance_fee` double(10, 2) DEFAULT NULL COMMENT '维修费用',
  `maintenance_man` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '维修人员',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '维修内容',
  `maintenance_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '维修情况',
  PRIMARY KEY (`maintenance_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of maintenance
-- ----------------------------
INSERT INTO `maintenance` VALUES (1, 1, '太阳能电池板', '2017-01-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (2, 1, '太阳能电池板', '2017-02-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (3, 1, '太阳能电池板', '2017-03-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (4, 1, '太阳能电池板', '2017-04-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (5, 1, '太阳能电池板', '2017-05-01', '2017-10-01', 200.00, '123', '坏了', '已修');
INSERT INTO `maintenance` VALUES (6, 1, '太阳能电池板', '2017-06-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (7, 1, '太阳能电池板', '2017-07-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (8, 1, '太阳能电池板', '2017-08-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (9, 1, '太阳能电池板', '2017-09-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (10, 1, '太阳能电池板', '2017-10-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (11, 1, '太阳能电池板', '2017-10-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (12, 1, '太阳能电池板', '2017-10-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (13, 1, '太阳能电池板', '2017-10-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (14, 1, '太阳能电池板', '2017-10-01', '2017-10-01', 200.00, 'lwe', '坏了', '已修');
INSERT INTO `maintenance` VALUES (16, NULL, '投影仪', '2017-10-02', '2017-10-28', 2000.00, '张二蛋', '开不了机', '已修');
INSERT INTO `maintenance` VALUES (17, NULL, '打印机', '2017-10-28', NULL, NULL, NULL, '大不了字了', '未修');
INSERT INTO `maintenance` VALUES (18, 6, '太阳能电池板', '2017-10-28', '2017-10-28', 666.00, '张三', '坏了', '已修');
INSERT INTO `maintenance` VALUES (19, 7, '太阳能电池板', '2017-10-28', '2017-10-28', 1000.00, '李四', '用不了了', '已修');
INSERT INTO `maintenance` VALUES (20, 15, '打印机', '2017-11-08', '2017-11-08', 345.00, '3453', '打不了字', '已修');
INSERT INTO `maintenance` VALUES (21, 17, '打印机', '2017-11-08', '2017-11-08', 2000.00, '张二蛋', '打不了字', '已修');
INSERT INTO `maintenance` VALUES (22, 17, '打印机', '2017-11-08', '2018-05-09', 123.00, '里斯', '235', '已修');
INSERT INTO `maintenance` VALUES (23, 4, '太阳能电池板', '2017-11-23', '2017-11-23', 100.00, '张二蛋', '开不了机', '已修');
INSERT INTO `maintenance` VALUES (24, 3, '太阳能电池板', '2017-12-26', '2017-12-26', 5000.00, '张二蛋', '234234234234', '已修');
INSERT INTO `maintenance` VALUES (25, 6, '太阳能电池板', '2018-05-09', NULL, NULL, NULL, '3214234', '未修');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `nid` int(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `person` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`nid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '停水通知34', '停水345345263', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (3, '1111111111', '22222222', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (4, '停电通知', '停电通知', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (5, '又停水了', '又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (6, '又停电了', '又停电了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (7, '又停电又停水了', '又停电又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (8, '停水通知', '又停电又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (9, '停水通知34', '又停电又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (10, '停水通知3', '又停电又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (11, '停水通知34', '又停电又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (12, '停水通知342', '又停电又停水了', '2017-11-21', '小明');
INSERT INTO `notice` VALUES (13, '停水通知343', '又停电又停水了', '2017-11-22', '小明');
INSERT INTO `notice` VALUES (14, '停水通知347', '又停电又停水了', '2017-11-22', '小明');
INSERT INTO `notice` VALUES (15, '停水通知344', '又停电又停水了', '2017-11-22', '小明');
INSERT INTO `notice` VALUES (16, '停水通告', '11111111111111111111111', '2017-11-23', '小明');
INSERT INTO `notice` VALUES (17, '停电通知', '今天上午停电', '2017-12-27', '小明');
INSERT INTO `notice` VALUES (18, '地震了', '435345234523围绕区委', '2018-05-09', '小明');
INSERT INTO `notice` VALUES (19, '今天会发生火灾', '请小心火灾', '2018-05-09', '小明');
INSERT INTO `notice` VALUES (20, '爱惜环境活动通知', '请大家爱护环境', '2018-05-09', '小明');

-- ----------------------------
-- Table structure for owner
-- ----------------------------
DROP TABLE IF EXISTS `owner`;
CREATE TABLE `owner`  (
  `owner_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '业主编号',
  `owner_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业主姓名',
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别',
  `hometown` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '籍贯',
  `job` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工作',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `idcard` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '身份证号',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话号码',
  `indate` date DEFAULT NULL COMMENT '入住时间',
  `outdate` date DEFAULT NULL COMMENT '迁出时间',
  `account` double(10, 2) DEFAULT NULL COMMENT '账户',
  PRIMARY KEY (`owner_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of owner
-- ----------------------------
INSERT INTO `owner` VALUES (1, '刘备', '男', '益州', '蜀国', '1510197456@qq.com', '411524197905034596', '15846523636', '2017-09-01', NULL, 3894.60);
INSERT INTO `owner` VALUES (2, '关羽', '男', '益州', '蜀国大将', '456@163.com', '345678678965634689', '15846523636', '2017-10-06', NULL, 3.00);
INSERT INTO `owner` VALUES (3, '张飞', '男', '益州', '蜀国大将', '123@qq.com', '345678678965634689', '13456784587', '2017-10-13', NULL, 0.00);
INSERT INTO `owner` VALUES (4, '赵云', '男', '益州', '蜀国大将', '456@163.com', '345678678965634689', '13456784587', '2017-10-12', NULL, 0.00);
INSERT INTO `owner` VALUES (5, '黄忠', '男', '益州', '蜀国大将', '456@163.com', '345678678965634689', '15846523636', '2017-10-13', NULL, 1000.00);
INSERT INTO `owner` VALUES (6, '测试', '女', '湖南省', '背景板', '163@163.com', '620822198112193497', '15723463114', '2017-10-04', NULL, 0.00);
INSERT INTO `owner` VALUES (35, '黄忠', '男', '荆州', '荆州大将', '163@163.com', '411524197905034596', '13656569234', '2017-10-25', NULL, 0.00);
INSERT INTO `owner` VALUES (36, '马超', '男', '凉州', '蜀国', 'machao@163.com', '510903197802195517', '13500002323', '2017-10-25', NULL, 0.00);
INSERT INTO `owner` VALUES (37, '曹操', '男', '魏国', '魏国', '123@123.com', '620822198112193497', '18700023564', '2017-10-27', NULL, 0.00);
INSERT INTO `owner` VALUES (38, 'LWJ', '男', 'GX', 'jx', '321321@qq.com', '450981199609081173', '15179298226', '2017-09-26', NULL, 0.00);
INSERT INTO `owner` VALUES (39, '郭奉孝', '男', '颍川', '魏国', '111@123.com', '510903197802195517', '13000000031', '2017-11-01', NULL, 0.00);
INSERT INTO `owner` VALUES (40, '诸葛亮', '男', '蜀国', '蜀国丞相', '155@qq.com', '620822198112193497', '18700023564', '2017-11-08', NULL, 0.00);
INSERT INTO `owner` VALUES (41, '小乔', '女', '北京', '北京', '163@163.com', '510903197802195517', '18700023564', '2017-11-08', NULL, 0.00);
INSERT INTO `owner` VALUES (42, '贾诩', '男', '益州', '魏国', '1510197456@qq.com', '411524197905034596', '18700023564', '2017-11-20', NULL, 0.00);
INSERT INTO `owner` VALUES (46, '大乔', '女', '123', '江东', '1510197456@qq.com', '620822198112193497', '15986532323', '2017-11-23', NULL, 1890.00);
INSERT INTO `owner` VALUES (47, '李四', '男', '湖北', '111', '1510197456@qq.com', '411524197905034596', '18700023562', '2017-11-23', NULL, 667.00);
INSERT INTO `owner` VALUES (48, '周公瑾', '男', '江东', '', '163@163.com', '411524197905034596', '15846523636', '2017-11-27', NULL, 0.00);
INSERT INTO `owner` VALUES (49, '路人甲', '男', '益州', '魏国', '163@163.com', '411524197905034596', '15846523636', '2017-11-28', NULL, 0.00);
INSERT INTO `owner` VALUES (51, '孙权', '男', '江东', '江东', '456@qq.com', '411524197905034596', '15986532323', '2017-11-28', NULL, 1230.00);
INSERT INTO `owner` VALUES (52, '孙悟空', '男', '花果山', '花果山', '1510197456@qq.com', '620822198112193497', '18700023564', '2017-12-25', NULL, 23333.20);
INSERT INTO `owner` VALUES (53, '甄宓', '女', '河东', '河东甄家', '1510197456@qq.com', '620822198112193497', '18700023564', '2017-12-26', NULL, 888.80);
INSERT INTO `owner` VALUES (54, '周小灿', '男', '湖北', '江西', '18720148610@163.com', '42112719951230221X', '18720148610', '2017-12-27', NULL, 1571.10);
INSERT INTO `owner` VALUES (55, '王大', '男', '湖南', '南京', '1510197456@qq.com', '42112719951230221X', '18720148610', '2018-05-09', NULL, 33027441.30);
INSERT INTO `owner` VALUES (56, '大熊', '男', '湖北', '北京', '1510197456@qq.com', '42112719951230221X', '18720148610', '2018-05-09', NULL, 969910.60);
INSERT INTO `owner` VALUES (57, '李强', '男', '湖南', '', '1510197456@qq.com', '42112719951230221X', '18720148610', '2018-05-09', NULL, 0.00);

-- ----------------------------
-- Table structure for parking
-- ----------------------------
DROP TABLE IF EXISTS `parking`;
CREATE TABLE `parking`  (
  `pid` int(8) NOT NULL AUTO_INCREMENT COMMENT '车位编号',
  `pregion` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '车位区域',
  `pnum` int(3) DEFAULT NULL COMMENT '该区域车位数量',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of parking
-- ----------------------------
INSERT INTO `parking` VALUES (1, 'A', 50);
INSERT INTO `parking` VALUES (2, 'B', 60);
INSERT INTO `parking` VALUES (3, 'C', 35);
INSERT INTO `parking` VALUES (4, 'D', 30);
INSERT INTO `parking` VALUES (5, 'E', 29);

-- ----------------------------
-- Table structure for property_fee
-- ----------------------------
DROP TABLE IF EXISTS `property_fee`;
CREATE TABLE `property_fee`  (
  `fee_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '收费编号',
  `owner_id` int(8) DEFAULT NULL COMMENT '业主编号',
  `position` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `inputdate` date DEFAULT NULL COMMENT '录入日期',
  `project` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收费项目',
  `way` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收费方式',
  `total` double(10, 2) DEFAULT NULL COMMENT '应收总额',
  `deliverdate` date DEFAULT NULL COMMENT '交费日期',
  `transactor` int(8) DEFAULT NULL COMMENT '办理人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`fee_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of property_fee
-- ----------------------------
INSERT INTO `property_fee` VALUES (1, 1, 'A1201', '2017-01-20', '物业费', '在线', 100.00, '2017-12-22', 1, NULL);
INSERT INTO `property_fee` VALUES (2, 1, 'A1201', '2017-02-08', '垃圾清理费', '在线', 100.00, '2017-12-22', 1, NULL);
INSERT INTO `property_fee` VALUES (3, 1, 'A1201', '2017-03-24', '垃圾清理费', '在线', 100.00, '2017-12-22', 1, NULL);
INSERT INTO `property_fee` VALUES (4, 1, 'A1101', '2017-04-18', '垃圾清理费', '未交', 100.00, '2017-11-21', 1, NULL);
INSERT INTO `property_fee` VALUES (5, 1, 'A1101', '2017-05-10', '垃圾清理费', '现金', 100.00, '2017-11-21', 1, NULL);
INSERT INTO `property_fee` VALUES (6, 1, 'A1101', '2017-06-22', '垃圾清理费', '现金', 100.00, '2017-11-21', 1, NULL);
INSERT INTO `property_fee` VALUES (8, 1, 'A1101', '2017-08-24', '垃圾清理费', '现金', 100.00, '2017-11-21', 1, NULL);
INSERT INTO `property_fee` VALUES (9, 1, 'A1101', '2017-09-19', '垃圾清理费', '现金', 100.00, '2017-11-12', 1, NULL);
INSERT INTO `property_fee` VALUES (10, 1, 'A1101', '2017-10-08', '垃圾清理费', '现金', 100.00, '2017-11-12', 1, NULL);
INSERT INTO `property_fee` VALUES (12, 1, 'A1101', '2017-10-08', '垃圾清理费', '现金', 100.00, '2017-10-27', 1, NULL);
INSERT INTO `property_fee` VALUES (13, 1, 'A1101', '2017-10-08', '垃圾清理费', '现金', 100.00, '2017-10-27', 1, NULL);
INSERT INTO `property_fee` VALUES (14, 1, 'A1101', '2017-10-08', '垃圾清理费', '现金', 100.00, '2017-10-16', 1, NULL);
INSERT INTO `property_fee` VALUES (15, 1, 'A1101', '2017-10-08', '垃圾清理费', '现金', 100.00, '2017-10-16', 1, NULL);
INSERT INTO `property_fee` VALUES (19, NULL, 'A1102', '2017-10-27', '物业费', '现金', 1000.00, '2017-10-27', 1, NULL);
INSERT INTO `property_fee` VALUES (20, NULL, 'A1101', '2017-10-27', '物业费', '现金', 1233.00, '2017-10-27', 1, NULL);
INSERT INTO `property_fee` VALUES (23, NULL, 'A1101', '2017-10-27', '车位费', '现金', 666.00, '2017-10-27', NULL, NULL);
INSERT INTO `property_fee` VALUES (24, NULL, 'A1402', '2017-10-28', '垃圾处理费', '现金', 10000.00, '2017-10-28', 1, NULL);
INSERT INTO `property_fee` VALUES (25, NULL, 'A1205', '2017-11-01', '垃圾清理费', '现金', 100.00, '2017-11-01', 1, NULL);
INSERT INTO `property_fee` VALUES (26, 1, 'A1201', '2017-11-01', '物业管理费', '在线', 1000.00, '2017-11-12', 1, NULL);
INSERT INTO `property_fee` VALUES (27, 1, 'A1201', '2017-11-02', '物业费', '在线', 2000.00, '2017-11-12', NULL, NULL);
INSERT INTO `property_fee` VALUES (28, 27, 'A1302', '2017-11-08', '物业费', '在线', 2000.00, '2017-11-08', NULL, NULL);
INSERT INTO `property_fee` VALUES (29, 27, 'A1302', '2017-11-08', '垃圾清理费', '在线', 1000.00, '2017-11-08', NULL, NULL);
INSERT INTO `property_fee` VALUES (30, NULL, 'A1302', '2017-11-08', '垃圾清理费', '现金', 1000.00, '2017-11-08', 1, NULL);
INSERT INTO `property_fee` VALUES (31, NULL, 'A1302', '2017-11-08', '车位费', '现金', 1000.00, '2017-11-08', NULL, NULL);
INSERT INTO `property_fee` VALUES (32, NULL, 'A1302', '2017-11-08', '车位费', '现金', 1000.00, '2017-11-08', NULL, NULL);
INSERT INTO `property_fee` VALUES (33, 28, 'A1301', '2017-11-08', '垃圾清理费', '在线', 1000.00, '2017-11-08', NULL, NULL);
INSERT INTO `property_fee` VALUES (34, NULL, 'A1301', '2017-11-08', '车位费', '现金', 1000.00, '2017-11-08', NULL, NULL);
INSERT INTO `property_fee` VALUES (35, NULL, 'A1101', '2017-11-20', '车位费', '现金', 1000.00, '2017-11-20', NULL, NULL);
INSERT INTO `property_fee` VALUES (36, NULL, 'A1403', '2017-11-23', '车位费', '现金', 1101.00, '2017-11-23', NULL, NULL);
INSERT INTO `property_fee` VALUES (37, 46, 'A1403', '2017-11-23', '垃圾清理费', '在线', 333.00, '2017-11-23', NULL, NULL);
INSERT INTO `property_fee` VALUES (38, NULL, 'B0101', '2017-11-23', '垃圾清理费', '现金', 1000.00, '2017-11-23', 1, NULL);
INSERT INTO `property_fee` VALUES (39, 47, 'B0101', '2017-11-23', '物业费', '在线', 111.00, '2017-11-23', NULL, NULL);
INSERT INTO `property_fee` VALUES (40, NULL, 'A1304', '2017-11-28', '物业费', '现金', 200.00, '2018-05-09', 1, NULL);
INSERT INTO `property_fee` VALUES (41, NULL, 'A1304', '2017-11-28', '物业管理费', '现金', 500.00, '2018-05-09', 1, NULL);
INSERT INTO `property_fee` VALUES (42, NULL, 'S1001', '2017-12-25', '物业费', '现金', 2000.00, '2017-12-25', 1, NULL);
INSERT INTO `property_fee` VALUES (43, NULL, 'S1001', '2017-12-25', '车位费', '现金', 1000.00, '2017-12-25', 1, NULL);
INSERT INTO `property_fee` VALUES (44, 52, 'S1001', '2017-12-25', '垃圾清理费', '在线', 40000.00, '2017-12-25', NULL, NULL);
INSERT INTO `property_fee` VALUES (45, 53, 'AS1003', '2017-12-26', '垃圾清理费', '在线', 20000.00, '2017-12-26', NULL, NULL);
INSERT INTO `property_fee` VALUES (46, NULL, 'AS1003', '2017-12-26', '车位费', '现金', 10000.00, '2017-12-26', 1, NULL);
INSERT INTO `property_fee` VALUES (47, NULL, 'AS1003', '2017-12-26', '车位费', '现金', 9000.00, '2017-12-26', 1, NULL);
INSERT INTO `property_fee` VALUES (48, 54, 'AA0101', '2017-12-27', '垃圾清理费', '在线', 2000.00, '2017-12-27', NULL, NULL);
INSERT INTO `property_fee` VALUES (49, NULL, 'A1401', '2018-05-09', '车位费', '现金', 50000.00, '2018-05-09', 1, NULL);
INSERT INTO `property_fee` VALUES (50, NULL, 'A1305', '2018-05-09', '车位费', '现金', 34343.00, '2018-05-09', 1, NULL);
INSERT INTO `property_fee` VALUES (51, 56, 'A1305', '2018-05-09', '物业费', '在线', 234234.00, '2018-05-09', NULL, NULL);
INSERT INTO `property_fee` VALUES (52, NULL, 'A1201', '2018-05-09', '车位费', '现金', 23232.00, '2018-05-09', 1, NULL);
INSERT INTO `property_fee` VALUES (53, 1, 'A1201', '2018-05-09', '物业费', '在线', 5000.00, '2018-05-09', NULL, NULL);
INSERT INTO `property_fee` VALUES (54, NULL, 'A1201', '2018-05-09', '物业费', '未交', 12323.00, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for repair
-- ----------------------------
DROP TABLE IF EXISTS `repair`;
CREATE TABLE `repair`  (
  `repair_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '报修编号',
  `repair_date` date DEFAULT NULL COMMENT '报修日期',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '报修内容',
  `owner_id` int(8) DEFAULT NULL COMMENT '报修业主',
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `handledate` date DEFAULT NULL COMMENT '处理日期',
  `handler` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '维修人员',
  `servicecost` double(10, 2) DEFAULT NULL COMMENT '服务费用',
  `mattercost` double(10, 2) DEFAULT NULL COMMENT '物料费用',
  `situation` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '维修情况',
  PRIMARY KEY (`repair_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of repair
-- ----------------------------
INSERT INTO `repair` VALUES (1, '2017-01-07', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (2, '2017-02-07', '房顶漏水了', 1, 'A1201', '13456784587', '2017-10-19', '2', 1.00, 1.00, '已处理');
INSERT INTO `repair` VALUES (3, '2017-03-02', '房顶漏水了', 1, 'A1201', '13456784587', '2017-10-19', '2', 2.00, 2.00, '已评价');
INSERT INTO `repair` VALUES (4, '2017-04-03', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (5, '2017-05-03', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (6, '2017-06-16', '房顶漏水0.0', NULL, 'A1201', '13456784587', '2017-10-27', '李四', 100.00, 100.00, '已评价');
INSERT INTO `repair` VALUES (7, '2017-07-19', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (8, '2017-08-16', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (9, '2017-10-09', '房顶漏水了', 1, 'A1202', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (10, '2017-09-22', '房顶漏水了', 1, 'A1202', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (11, '2017-09-20', '房顶漏水了', 1, 'A1202', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (12, '2017-08-16', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (13, '2017-06-15', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (14, '2017-05-27', '房顶漏水了', 1, 'A1201', '13456784587', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (16, '2017-05-16', '地板裂了', 1, 'A1102', '13456784587', NULL, '', 0.00, 0.00, '未处理');
INSERT INTO `repair` VALUES (17, '2017-04-19', '墙破了', 1, 'A1102', '15846523636', NULL, '', NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (18, '2017-04-27', '天花板漏水', NULL, 'A1101', '15846523636', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (19, '2017-03-29', '水管漏了', NULL, 'A1501', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (20, '2017-02-24', 'sdifasndkf', NULL, 'A1201', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (21, '2017-02-21', '这是测试', NULL, 'A1201', '15900034567', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (23, '2017-01-09', '3562234634', 32, 'A1201', '13800000831', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (24, '2017-10-19', '测试测试测试', 32, 'A1201', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (25, '2017-10-19', '54645735475', 32, 'A1201', '18740584666', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (26, '2017-10-27', '开不了机', NULL, 'A1101', '18700037878', '2017-10-27', '战三', 50.00, 100.00, '已处理');
INSERT INTO `repair` VALUES (27, '2017-10-28', '漏水', 1, 'A1201', '15179298226', '2017-10-28', 'zxc', 10000.00, 12000.00, '已评价');
INSERT INTO `repair` VALUES (28, '2017-11-08', '3453', 40, 'A1302', '15986532323', '2017-11-08', '李四', 100.00, 100.00, '已评价');
INSERT INTO `repair` VALUES (29, '2017-11-08', '23423', NULL, 'A1302', '15900034567', '2017-11-08', '战三', 100.00, 233.00, '已处理');
INSERT INTO `repair` VALUES (30, '2017-11-08', 'EWWE', 41, 'A1301', '18700023564', '2017-11-08', '李四', 200.00, 300.00, '已评价');
INSERT INTO `repair` VALUES (31, '2017-11-08', '开不了机', NULL, 'A1101', '18700023564', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (32, '2017-11-20', 'aaaaaaa', NULL, 'A1101', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (33, '2017-11-23', '2342354', NULL, 'A1403', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (34, '2017-11-23', '2222222222222', 47, 'B0101', '18700023564', '2017-11-23', '李四', 100.00, 100.00, '已评价');
INSERT INTO `repair` VALUES (35, '2017-11-23', '11111', 47, 'B0101', '18700023564', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (36, '2017-12-22', '刹帝利干哈收到了开个会', NULL, 'A1201', '18144879080', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (37, '2017-12-22', '卡巴拉巴拉山东那边了广泛', NULL, 'A1201', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (38, '2017-12-22', '洒进来看到了开工建设gas', NULL, 'A1201', '15986532323', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (39, '2017-12-25', '223423423', NULL, 'A1201', '15900034567', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (40, '2017-12-25', 's324t342634', NULL, 'S1001', '15986532323', '2017-12-25', '李四', 100.00, 300.00, '已评价');
INSERT INTO `repair` VALUES (41, '2017-12-26', '我家天花板漏水了，快派人来修', NULL, 'AS1003', '15846523636', '2017-12-26', '李四', 100.00, 300.00, '已评价');
INSERT INTO `repair` VALUES (42, '2017-12-27', '我家水管漏了', NULL, 'AA0101', '18720148610', '2017-12-27', '曹操', 200.00, 300.00, '已评价');
INSERT INTO `repair` VALUES (43, '2018-05-09', '水管坏了', NULL, 'A1401', '18720148610', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (44, '2018-05-09', '上帝发誓', NULL, 'A1305', '18720148610', '2018-05-09', '超人', 123.00, 123.00, '已评价');
INSERT INTO `repair` VALUES (45, '2018-05-09', '213412341', NULL, 'A1305', '18720148610', NULL, NULL, NULL, NULL, '未处理');
INSERT INTO `repair` VALUES (46, '2018-05-09', '报修报修', NULL, 'A1201', '18720148610', NULL, NULL, NULL, NULL, '未处理');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型',
  `retime` date DEFAULT NULL COMMENT '注册时间',
  `lasttime` datetime(0) DEFAULT NULL COMMENT '上次登录时间',
  `repswTime` datetime(0) DEFAULT NULL COMMENT '上次修改时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '小明', '123456', '工作人员', '2017-09-01', '2018-05-09 16:57:11', NULL);
INSERT INTO `user` VALUES (18, 'A1201', '123456', '业主', '2017-10-13', '2018-05-09 16:58:44', '2017-12-27 14:37:46');
INSERT INTO `user` VALUES (19, 'A1202', '123456', '业主', '2017-10-13', NULL, NULL);
INSERT INTO `user` VALUES (20, 'A1502', '123456', '业主', '2017-10-13', NULL, NULL);
INSERT INTO `user` VALUES (21, 'A1405', '15723463114', '业主', '2017-10-21', NULL, NULL);
INSERT INTO `user` VALUES (22, 'A1202', '13656569234', '业主', '2017-10-25', NULL, NULL);
INSERT INTO `user` VALUES (23, 'A1203', '13500002323', '业主', '2017-10-25', NULL, NULL);
INSERT INTO `user` VALUES (24, 'A1204', '18700023564', '业主', '2017-10-27', NULL, NULL);
INSERT INTO `user` VALUES (25, 'A1402', '15179298226', '业主', '2017-10-28', NULL, NULL);
INSERT INTO `user` VALUES (26, 'A1205', '13000000031', '业主', '2017-11-01', NULL, NULL);
INSERT INTO `user` VALUES (27, 'A1302', '121212', '业主', '2017-11-08', '2017-11-08 14:34:05', NULL);
INSERT INTO `user` VALUES (28, 'A1301', '18700023564', '业主', '2017-11-08', '2017-11-08 15:55:45', NULL);
INSERT INTO `user` VALUES (29, 'A1303', '18700023564', '业主', '2017-11-20', NULL, NULL);
INSERT INTO `user` VALUES (31, 'A1403', '123456', '业主', '2017-11-23', '2017-11-23 14:11:14', NULL);
INSERT INTO `user` VALUES (32, 'B0101', 'aaaaaa', '业主', '2017-11-23', '2017-11-23 15:12:04', '2017-11-23 15:11:50');
INSERT INTO `user` VALUES (33, 'C0301', '15846523636', '业主', '2017-11-27', NULL, NULL);
INSERT INTO `user` VALUES (34, 'D0402', '15846523636', '业主', '2017-11-28', NULL, NULL);
INSERT INTO `user` VALUES (36, 'A1304', '123456', '业主', '2017-11-28', '2017-11-28 14:38:20', NULL);
INSERT INTO `user` VALUES (37, 'S1001', '111', '业主', '2017-12-25', '2017-12-25 16:09:59', NULL);
INSERT INTO `user` VALUES (38, 'AS1003', '18700023564', '业主', '2017-12-26', '2017-12-26 12:21:38', NULL);
INSERT INTO `user` VALUES (39, 'AA0101', '18720148610', '业主', '2017-12-27', '2017-12-27 16:59:12', NULL);
INSERT INTO `user` VALUES (40, 'A1401', '666666', '业主', '2018-05-09', '2018-05-09 16:20:28', '2018-05-09 16:20:18');
INSERT INTO `user` VALUES (41, 'A1305', '18720148610', '业主', '2018-05-09', '2018-05-09 14:04:29', NULL);
INSERT INTO `user` VALUES (42, 'A1404', '18720148610', '业主', '2018-05-09', NULL, NULL);

-- ----------------------------
-- Table structure for water
-- ----------------------------
DROP TABLE IF EXISTS `water`;
CREATE TABLE `water`  (
  `water_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '水表编号',
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物业地址',
  `startdate` date DEFAULT NULL COMMENT '启用日期',
  `price` double(10, 2) DEFAULT NULL COMMENT '单价',
  PRIMARY KEY (`water_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of water
-- ----------------------------
INSERT INTO `water` VALUES (1, 'A1101', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (2, 'A1102', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (3, 'A1103', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (4, 'A1201', '2018-05-09', 2.40);
INSERT INTO `water` VALUES (5, 'A1202', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (6, 'A1203', '2016-07-14', 2.40);
INSERT INTO `water` VALUES (8, 'A1205', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (9, 'A1301', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (10, 'A1302', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (11, 'A1303', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (12, 'A1304', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (13, 'A1305', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (14, 'A1401', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (15, 'A1402', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (16, 'A1403', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (17, 'A1404', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (18, 'A1405', '2017-07-01', 2.40);
INSERT INTO `water` VALUES (20, 'B0101', '2017-11-23', 2.40);
INSERT INTO `water` VALUES (21, 'C0301', '2017-11-27', 2.40);
INSERT INTO `water` VALUES (22, 'S1001', '2017-12-25', 2.40);
INSERT INTO `water` VALUES (23, 'AS1003', '2017-12-26', 2.40);
INSERT INTO `water` VALUES (24, 'AA0101', '2017-12-27', 2.40);

SET FOREIGN_KEY_CHECKS = 1;
