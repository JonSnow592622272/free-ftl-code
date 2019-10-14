/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : nimei

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 14/10/2019 09:48:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for test_scores
-- ----------------------------
DROP TABLE IF EXISTS `test_scores`;
CREATE TABLE `test_scores`  (
  `id` int(11) NOT NULL,
  `student_id` int(11) NULL DEFAULT NULL COMMENT '学生id#SELLER,0,店长;CITYMANAGER,1,城市经理;SUPPLIER,2,供应商',
  `type` int(11) NULL DEFAULT NULL COMMENT '科目',
  `score` int(11) NULL DEFAULT NULL COMMENT '成绩分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '成绩表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for test_student
-- ----------------------------
DROP TABLE IF EXISTS `test_student`;
CREATE TABLE `test_student`  (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名#SELLER,0,店长;CITYMANAGER,1,城市经理;SUPPLIER,2,供应商',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '学生表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
