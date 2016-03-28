/*
Navicat MySQL Data Transfer

Source Server         : 胖先生
Source Server Version : 50016
Source Host           : 127.0.0.1:3308
Source Database       : xy19_rbac

Target Server Type    : MYSQL
Target Server Version : 50016
File Encoding         : 65001

Date: 2016-03-23 15:29:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for role_link_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_link_menu`;
CREATE TABLE `role_link_menu` (
  `id` varchar(64) NOT NULL,
  `fk_role_id` int(10) default NULL,
  `fk_menu_id` int(10) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_menu_id` (`fk_menu_id`),
  CONSTRAINT `role_link_menu_ibfk_1` FOREIGN KEY (`fk_menu_id`) REFERENCES `sys_menu` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_link_menu
-- ----------------------------
INSERT INTO `role_link_menu` VALUES ('a', '100', '1');
INSERT INTO `role_link_menu` VALUES ('b', '100', '2');
INSERT INTO `role_link_menu` VALUES ('c', '100', '3');
INSERT INTO `role_link_menu` VALUES ('d', '200', '2');
INSERT INTO `role_link_menu` VALUES ('e', '200', '4');
INSERT INTO `role_link_menu` VALUES ('f', '200', '5');
INSERT INTO `role_link_menu` VALUES ('g', '200', '6');
INSERT INTO `role_link_menu` VALUES ('h', '300', '7');
INSERT INTO `role_link_menu` VALUES ('i', '300', '2');
INSERT INTO `role_link_menu` VALUES ('j', '100', '11');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` int(10) NOT NULL auto_increment COMMENT '注解',
  `menu_name` varchar(32) default NULL COMMENT '菜单名称',
  `url` varchar(128) default NULL COMMENT '访问路径',
  `target` varchar(16) default 'right' COMMENT '打开的位置',
  `open_type` varchar(1) default '1' COMMENT '1 target方式打开 2使用弹出方式打开 3外域打开_blank',
  `parent_id` int(11) default '-1',
  PRIMARY KEY  (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统用户管理', 'sys/user/find123', 'right', '2', '8');
INSERT INTO `sys_menu` VALUES ('2', '角色信息管理', 'sys/user/find123', 'right', '1', '9');
INSERT INTO `sys_menu` VALUES ('3', '车辆信息管理', 'sys/user/find', 'right', '1', '9');
INSERT INTO `sys_menu` VALUES ('4', '系统用户管理', '/sys/aaa', 'right', '2', '9');
INSERT INTO `sys_menu` VALUES ('5', '预定管理', null, 'right', '1', '9');
INSERT INTO `sys_menu` VALUES ('6', '车辆统计', null, 'right', '1', '10');
INSERT INTO `sys_menu` VALUES ('7', '财务统计', null, 'right', '1', '10');
INSERT INTO `sys_menu` VALUES ('8', '系统管理', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('9', '车辆管理', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('10', '统计管理', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('11', '菜单管理', 'sys/menu/parent/list', 'right', '1', '8');
INSERT INTO `sys_menu` VALUES ('12', '财务管理', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('13', '员工管理', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('14', '系统用户管理1231', 'sys/ddd', 'right', '1', '8');
INSERT INTO `sys_menu` VALUES ('15', '维护管理', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('17', '维护2', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('18', '维护3', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('19', '维护4', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('20', '维护5', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('21', '维护6', null, 'right', '1', '-1');
INSERT INTO `sys_menu` VALUES ('22', '测试', '1111132', 'right', '2', '9');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` int(10) NOT NULL auto_increment,
  `role_name` varchar(32) default NULL,
  `role_desc` varchar(256) default NULL,
  `role_status` varchar(1) default '1' COMMENT '1可用 2禁用',
  PRIMARY KEY  (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('100', '管理员', '管理所有', '1');
INSERT INTO `sys_role` VALUES ('200', '经理', null, '1');
INSERT INTO `sys_role` VALUES ('300', '业务员', null, '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int(10) NOT NULL auto_increment,
  `account` varchar(32) default NULL,
  `password` varchar(32) default NULL,
  `user_name` varchar(32) default NULL,
  `sex` varchar(32) default NULL,
  `tel` varchar(16) default NULL,
  `create_date` date default NULL,
  `status` varchar(1) default '1' COMMENT '1可用 2禁用',
  `fk_role_id` int(10) default NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('10', 'wukong', '123123', '悟空', '男', '123213', '2016-03-23', '1', null);
INSERT INTO `sys_user` VALUES ('11', 'super', 'super', '超级官六员', '男', '15568572301', '2016-03-23', '1', '100');
INSERT INTO `sys_user` VALUES ('12', 'admin', 'admin', '官六员', '女', '123123', '2016-03-23', '1', '200');
