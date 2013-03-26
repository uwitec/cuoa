-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-03-26 17:09:02
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for oa
DROP DATABASE IF EXISTS `oa`;
CREATE DATABASE IF NOT EXISTS `oa` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `oa`;


-- Dumping structure for table oa.tb_employee
DROP TABLE IF EXISTS `tb_employee`;
CREATE TABLE IF NOT EXISTS `tb_employee` (
  `emp_id` varchar(32) NOT NULL COMMENT 'ID',
  `emp_login_name` varchar(100) NOT NULL COMMENT '员工登录名',
  `emp_name` varchar(100) NOT NULL COMMENT '员工姓名',
  `emp_login_password` varchar(32) NOT NULL COMMENT '员工登录密码',
  `emp_serial` varchar(50) NOT NULL COMMENT '员工编号',
  `emp_creater_id` varchar(32) NOT NULL COMMENT '创建人ID',
  `emp_modifier_id` varchar(32) DEFAULT NULL COMMENT '最后修改人ID',
  `emp_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `emp_modify_date` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  `emp_is_deleted` int(11) DEFAULT NULL COMMENT '是否删除',
  `emp_role_id` varchar(32) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工基本信息表';

-- Dumping data for table oa.tb_employee: ~4 rows (approximately)
/*!40000 ALTER TABLE `tb_employee` DISABLE KEYS */;
INSERT INTO `tb_employee` (`emp_id`, `emp_login_name`, `emp_name`, `emp_login_password`, `emp_serial`, `emp_creater_id`, `emp_modifier_id`, `emp_create_date`, `emp_modify_date`, `emp_is_deleted`, `emp_role_id`) VALUES
	('0', 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '00001', '0', '0', '2011-08-23 08:40:10', '2011-08-23 08:40:12', 0, '0'),
	('23425324', 'yjn', 'yjn测试', 'e10adc3949ba59abbe56e057f20f883e', '00002', '0', '0', '2011-08-27 23:59:50', '2011-08-29 23:59:52', 0, '402888b5320505970132050e31530001'),
	('35324abaaa', 'sale1', '销售屌', 'e10adc3949ba59abbe56e057f20f883e', '00003', '0', '0', '2012-10-27 17:59:49', '2012-10-27 17:59:52', 0, '402888b5320505970132050f963b0002'),
	('423532445', 'zcj', '赵成君', 'e10adc3949ba59abbe56e057f20f883e', '00004', '0', '0', '2012-10-27 18:01:52', '2012-10-27 18:01:50', 0, '402888b5320505970132050e31530001');
/*!40000 ALTER TABLE `tb_employee` ENABLE KEYS */;


-- Dumping structure for table oa.tb_resource
DROP TABLE IF EXISTS `tb_resource`;
CREATE TABLE IF NOT EXISTS `tb_resource` (
  `re_id` varchar(32) NOT NULL,
  `re_name` varchar(32) NOT NULL COMMENT '权限资源名称',
  `re_parent_id` varchar(32) NOT NULL COMMENT '父权限资源(顶层父权限资源为0)',
  `re_url` varchar(512) DEFAULT NULL COMMENT '权限资源url',
  `re_is_menu` int(11) NOT NULL COMMENT '是否显示为菜单',
  `re_is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`re_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限资源表(包含需要拦截的操作和树状菜单节点)';

-- Dumping data for table oa.tb_resource: ~15 rows (approximately)
/*!40000 ALTER TABLE `tb_resource` DISABLE KEYS */;
INSERT INTO `tb_resource` (`re_id`, `re_name`, `re_parent_id`, `re_url`, `re_is_menu`, `re_is_deleted`) VALUES
	('001', '功能列表', '-1', NULL, 1, 0),
	('001001', '权限管理', '001', NULL, 1, 0),
	('001001001', '员工管理', '001001', 'permissions/employeeManage!toIndex.action', 1, 0),
	('001001001001', '查询员工', '001001001', 'permissions/employeeManage!queryEmployeePage.action', 0, 0),
	('001001001002', '新增员工', '001001001', 'permissions/employeeManage!toAddEmployeeIndex.action', 0, 0),
	('001001001003', '删除员工', '001001001', 'permissions/employeeManage!deleteEmployees.action', 0, 0),
	('001001001004', '修改员工', '001001001', 'permissions/employeeManage!toModifyEmployeeIndex.action', 0, 0),
	('001001002', '角色管理', '001001', 'permissions/permissionManage!toRoleIndex.action', 1, 0),
	('001001002001', '查询角色', '001001002', 'permissions/permissionManage!toRoleIndex.action', 0, 0),
	('001001002002', '新增角色', '001001002', 'permissions/permissionManage!toAddRoleIndex.action', 0, 0),
	('001001002003', '删除角色', '001001002', 'permissions/permissionManage!deleteRoles.action', 0, 0),
	('001001002004', '修改角色', '001001002', 'permissions/permissionManage!toModifyRoleIndex.action', 0, 0),
	('001002', '工作日志', '001', NULL, 1, 0),
	('001002001', '日志列表', '001002', 'worklog/worklogManage!toIndex.action', 1, 0),
	('001002001001', '日志查询', '001002001', 'worklog/worklogManage!queryWorklogPage.action', 0, 0);
/*!40000 ALTER TABLE `tb_resource` ENABLE KEYS */;


-- Dumping structure for table oa.tb_role
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE IF NOT EXISTS `tb_role` (
  `rl_id` varchar(32) NOT NULL,
  `rl_name` varchar(100) NOT NULL COMMENT '角色名',
  `rl_deleted` int(10) NOT NULL COMMENT '是否删除',
  `rl_creater_id` varchar(32) NOT NULL COMMENT '创建人',
  `rl_create_date` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `rl_modifier_id` varchar(32) DEFAULT NULL COMMENT '最后修改人ID',
  `rl_modify_date` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`rl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- Dumping data for table oa.tb_role: ~6 rows (approximately)
/*!40000 ALTER TABLE `tb_role` DISABLE KEYS */;
INSERT INTO `tb_role` (`rl_id`, `rl_name`, `rl_deleted`, `rl_creater_id`, `rl_create_date`, `rl_modifier_id`, `rl_modify_date`) VALUES
	('0', '超级管理员', 0, '0', '2011-08-31 12:17:34', NULL, NULL),
	('402888b5320505970132050e31530001', '管理员', 0, '0', '2011-08-26 15:46:48', '0', '2011-08-26 15:46:48'),
	('402888b5320505970132050f963b0002', '销售人员', 0, '0', '2011-08-26 15:48:20', '0', '2011-08-26 15:48:20'),
	('402888b53205059701320511bc020003', '销售部主管', 0, '0', '2011-08-26 15:50:40', '0', '2011-08-26 15:50:40'),
	('402888b5320505970132051205690004', '市场部经理', 0, '0', '2011-08-26 15:50:59', '0', '2011-08-26 15:50:59'),
	('402888b53205059701320513937e0005', '财务总监123456', 0, '0', '2013-03-26 17:02:38', '0', '2013-03-26 17:07:57');
/*!40000 ALTER TABLE `tb_role` ENABLE KEYS */;


-- Dumping structure for table oa.tb_role_resource
DROP TABLE IF EXISTS `tb_role_resource`;
CREATE TABLE IF NOT EXISTS `tb_role_resource` (
  `rr_id` varchar(32) NOT NULL,
  `rr_role_id` varchar(32) NOT NULL COMMENT '角色id',
  `rr_resource_id` varchar(32) NOT NULL COMMENT '权限资源id',
  PRIMARY KEY (`rr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色－权限资源 关系表';

-- Dumping data for table oa.tb_role_resource: ~23 rows (approximately)
/*!40000 ALTER TABLE `tb_role_resource` DISABLE KEYS */;
INSERT INTO `tb_role_resource` (`rr_id`, `rr_role_id`, `rr_resource_id`) VALUES
	('0524de6af13c441a8f51719776cb8f5e', '402888b53205059701320513937e0005', '001001001002'),
	('064da47587cc454696f7630f73ab660c', '402888b5320505970132050e31530001', '001001001001'),
	('0da6596c41f54aa580f17d16765e7f2c', '402888b5320505970132050e31530001', '001001001003'),
	('25b49749831d4cf49a865a950693d3d5', '402888b53205059701320513937e0005', '001001'),
	('2d800fa5c44b4bb7b8cd2d73f21e5333', '402888b5320505970132050e31530001', '001001001'),
	('338d174275ed410dab01bd9868b73361', '402888b53205059701320513937e0005', '001001001004'),
	('4654fdb1e69a43a8abed15c849a3ef68', '402888b5320505970132050f963b0002', '001'),
	('4b85315e1a4f4fc0adc28cef0b2e98eb', '402888b5320505970132050e31530001', '001001001004'),
	('55a5b084838d4cc69f1a9664d6017a7b', '402888b5320505970132050e31530001', '001001'),
	('5f975838cf774ec58f603eb084186894', '402888b53205059701320513937e0005', '001001001'),
	('654d60bfe6584922a9680e0e8656aec5', '402888b5320505970132050e31530001', '001'),
	('73a1213c26ad40ec95ece5488192afde', '402888b53205059701320513937e0005', '001'),
	('7823fc2f3d834daea6af8cd8fb74f3ec', '402888b53205059701320513937e0005', '001001002'),
	('7f7c658b6a754f308db3e9c711d104c9', '402888b5320505970132050e31530001', '001001001002'),
	('94dbe403706b4532b9b5900f26c92c62', '402888b5320505970132050f963b0002', '001002001'),
	('9b9e84e605104a5eb596e426ada82d11', '402888b5320505970132050f963b0002', '-1'),
	('a431c395a6f8403bb9b18f416483d73c', '402888b5320505970132050e31530001', '-1'),
	('b095a447a2ac4beeb5d852661a2578bf', '402888b53205059701320513937e0005', '001001001001'),
	('b3bd46a2787d4fbaaad70e119272c263', '402888b53205059701320513937e0005', '001001001003'),
	('cfc8d5e933624926a57c57d261eb27ab', '402888b5320505970132050f963b0002', '001002'),
	('da045124fff8419b9067176e1cde0e94', '402888b53205059701320513937e0005', '-1'),
	('edb9a37f91e8462abe2f4a1c0d853bee', '402888b5320505970132050f963b0002', '001002001001'),
	('ee1f4e2e044145c98a2c92e0937ac46c', '402888b53205059701320513937e0005', '001001002002');
/*!40000 ALTER TABLE `tb_role_resource` ENABLE KEYS */;


-- Dumping structure for table oa.tb_worklog
DROP TABLE IF EXISTS `tb_worklog`;
CREATE TABLE IF NOT EXISTS `tb_worklog` (
  `wl_id` varchar(32) NOT NULL,
  `wl_employee_id` varchar(32) NOT NULL COMMENT '员工ID',
  `wl_caption` varchar(500) NOT NULL COMMENT '标题',
  `wl_log_date` date NOT NULL COMMENT '日志日期',
  `wl_log_content` varchar(5000) NOT NULL COMMENT '内容',
  `wl_is_deleted` int(11) NOT NULL,
  `wl_creater_id` varchar(32) NOT NULL,
  `wl_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wl_modifier_id` varchar(32) NOT NULL,
  `wl_modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`wl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工工作日志';

-- Dumping data for table oa.tb_worklog: ~1 rows (approximately)
/*!40000 ALTER TABLE `tb_worklog` DISABLE KEYS */;
INSERT INTO `tb_worklog` (`wl_id`, `wl_employee_id`, `wl_caption`, `wl_log_date`, `wl_log_content`, `wl_is_deleted`, `wl_creater_id`, `wl_create_date`, `wl_modifier_id`, `wl_modify_date`) VALUES
	('123123', '0', '系统管理员工作日志12312', '2011-08-25', '犬瘟热庆武确认qwerTY谔谔人儿王企鹅完全人我去', 0, '0', '2011-08-26 15:14:50', '0', '2011-08-27 15:14:50');
/*!40000 ALTER TABLE `tb_worklog` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
