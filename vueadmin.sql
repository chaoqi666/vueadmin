/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.34 : Database - vueadmin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`vueadmin` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `vueadmin`;

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(64) NOT NULL,
  `path` varchar(255) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(255) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `component` varchar(255) DEFAULT NULL,
  `type` int(5) NOT NULL COMMENT '类型     0：目录   1：菜单   2：按钮',
  `icon` varchar(32) DEFAULT NULL COMMENT '菜单图标',
  `orderNum` int(11) DEFAULT NULL COMMENT '排序',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `statu` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`parent_id`,`name`,`path`,`perms`,`component`,`type`,`icon`,`orderNum`,`created`,`updated`,`statu`) values 
(1,0,'系统管理','','sys:manage','',0,'el-icon-s-operation',1,'2021-01-15 18:58:18','2021-01-15 18:58:20',1),
(2,1,'用户管理','/sys/users','sys:user:list','sys/User',1,'el-icon-s-custom',1,'2021-01-15 19:03:45','2021-01-15 19:03:48',1),
(3,1,'角色管理','/sys/roles','sys:role:list','sys/Role',1,'el-icon-rank',2,'2021-01-15 19:03:45','2021-01-15 19:03:48',1),
(4,1,'菜单管理','/sys/menus','sys:menu:list','sys/Menu',1,'el-icon-menu',3,'2021-01-15 19:03:45','2021-01-15 19:03:48',1),
(5,0,'系统工具','','sys:tools',NULL,0,'el-icon-s-tools',2,'2021-01-15 19:06:11',NULL,1),
(6,5,'数字字典','/sys/dicts','sys:dict:list','sys/Dict',1,'el-icon-s-order',1,'2021-01-15 19:07:18','2021-09-07 14:17:16',0),
(7,3,'添加角色','','sys:role:save','',2,'',1,'2021-01-15 23:02:25','2021-09-07 14:16:53',1),
(9,2,'添加用户',NULL,'sys:user:save',NULL,2,NULL,1,'2021-01-17 21:48:32',NULL,1),
(10,2,'修改用户',NULL,'sys:user:update',NULL,2,NULL,2,'2021-01-17 21:49:03','2021-01-17 21:53:04',1),
(11,2,'删除用户',NULL,'sys:user:delete',NULL,2,NULL,3,'2021-01-17 21:49:21',NULL,1),
(12,2,'分配角色',NULL,'sys:user:role',NULL,2,NULL,4,'2021-01-17 21:49:58',NULL,1),
(13,2,'重置密码',NULL,'sys:user:repass',NULL,2,NULL,5,'2021-01-17 21:50:36',NULL,1),
(14,3,'修改角色',NULL,'sys:role:update',NULL,2,NULL,2,'2021-01-17 21:51:14',NULL,1),
(15,3,'删除角色',NULL,'sys:role:delete',NULL,2,NULL,3,'2021-01-17 21:51:39','2021-09-07 14:17:05',0),
(16,3,'分配权限',NULL,'sys:role:perm',NULL,2,NULL,5,'2021-01-17 21:52:02',NULL,1),
(17,4,'添加菜单',NULL,'sys:menu:save',NULL,2,NULL,1,'2021-01-17 21:53:53','2021-01-17 21:55:28',1),
(18,4,'修改菜单',NULL,'sys:menu:update',NULL,2,NULL,2,'2021-01-17 21:56:12',NULL,1),
(19,4,'删除菜单',NULL,'sys:menu:delete',NULL,2,NULL,3,'2021-01-17 21:56:36',NULL,1);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `code` varchar(64) NOT NULL,
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `statu` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`code`,`remark`,`created`,`updated`,`statu`) values 
(3,'普通用户','normal','只有基本查看功能','2021-01-04 10:09:14','2021-01-30 08:19:52',1),
(6,'超级管理员','admin','系统默认最高权限，不可以编辑和任意修改','2021-01-16 13:29:03','2021-01-17 15:50:45',1);

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values 
(60,6,1),
(61,6,2),
(62,6,9),
(63,6,10),
(64,6,11),
(65,6,12),
(66,6,13),
(67,6,3),
(68,6,7),
(69,6,14),
(70,6,15),
(71,6,16),
(72,6,4),
(73,6,17),
(74,6,18),
(75,6,19),
(76,6,5),
(77,6,6),
(102,3,1),
(103,3,2),
(104,3,3),
(105,3,4),
(106,3,5);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `statu` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_USERNAME` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`avatar`,`email`,`city`,`created`,`updated`,`last_login`,`statu`) values 
(1,'admin','$2a$10$bWqdRwaVYh.56c47GUSD6uNlZ5M6syjHYN4vAgsLi5Pn4DU9jFdRK','https://blog.nianbroken.top/favicon.png','123@qq.com','广州','2021-08-30 22:13:53','2021-09-02 16:57:32','2021-09-06 08:38:37',1),
(2,'test','$2a$10$R7zegeWzOXPw871CmNuJ6upC0v8D373GuLuTw8jn6NET4BkPRZfgK','https://avatars.githubusercontent.com/u/32240879?s=400&u=43d5451914030ff6ff01719eb3506afebb327bfd&v=4','test@qq.com',NULL,'2021-08-30 08:20:22','2021-09-02 08:55:57',NULL,1),
(3,'visitor','$2a$10$ntuBMp6BD7zgGWLrgPmJXemmEdV9vKUtbty8.KvPtuGcc1UEAQZPy','https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png','123456@qq.com',NULL,'2021-09-06 23:34:27','2021-09-06 23:35:11',NULL,1);

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values 
(4,1,6),
(7,1,3),
(13,2,3),
(14,3,3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
