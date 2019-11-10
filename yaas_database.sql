/*
SQLyog Community v12.4.2 (64 bit)
MySQL - 5.7.27-0ubuntu0.16.04.1 : Database - yaas_database
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`yaas_database` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `yaas_database`;

/*Table structure for table `Auction` */

DROP TABLE IF EXISTS `Auction`;

CREATE TABLE `Auction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(3000) NOT NULL,
  `min_price` decimal(11,2) NOT NULL,
  `deadline` datetime(6) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `version` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Auction_seller_id_72d9a6de_fk_User_id` (`seller_id`),
  KEY `Auction_status_id_87e0bd54_fk_Auction_Status_id` (`status_id`),
  CONSTRAINT `Auction_seller_id_72d9a6de_fk_User_id` FOREIGN KEY (`seller_id`) REFERENCES `User` (`id`),
  CONSTRAINT `Auction_status_id_87e0bd54_fk_Auction_Status_id` FOREIGN KEY (`status_id`) REFERENCES `Auction_Status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Auction` */

/*Table structure for table `Auction_Status` */

DROP TABLE IF EXISTS `Auction_Status`;

CREATE TABLE `Auction_Status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `Auction_Status` */

insert  into `Auction_Status`(`id`,`status`) values 
(1,'Active'),
(2,'Banned'),
(3,'Due'),
(4,'Adjudicated');

/*Table structure for table `Auction_Temp` */

DROP TABLE IF EXISTS `Auction_Temp`;

CREATE TABLE `Auction_Temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(3000) NOT NULL,
  `min_price` decimal(11,2) NOT NULL,
  `seller_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Auction_Temp_seller_id_13b14602_fk_User_id` (`seller_id`),
  CONSTRAINT `Auction_Temp_seller_id_13b14602_fk_User_id` FOREIGN KEY (`seller_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Auction_Temp` */

/*Table structure for table `Bid` */

DROP TABLE IF EXISTS `Bid`;

CREATE TABLE `Bid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bid_price` decimal(11,2) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `version` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `bidder_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Bid_auction_id_d48ebe09_fk_Auction_id` (`auction_id`),
  KEY `Bid_bidder_id_15d325d1_fk_User_id` (`bidder_id`),
  CONSTRAINT `Bid_auction_id_d48ebe09_fk_Auction_id` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`id`),
  CONSTRAINT `Bid_bidder_id_15d325d1_fk_User_id` FOREIGN KEY (`bidder_id`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Bid` */

/*Table structure for table `Role` */

DROP TABLE IF EXISTS `Role`;

CREATE TABLE `Role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `Role` */

insert  into `Role`(`id`,`role`) values 
(1,'Admin'),
(2,'Registered'),
(3,'Anonimous');

/*Table structure for table `User` */

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(250) NOT NULL,
  `language` varchar(10) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `User_role_id_0ae7280f_fk_Role_id` (`role_id`),
  CONSTRAINT `User_role_id_0ae7280f_fk_Role_id` FOREIGN KEY (`role_id`) REFERENCES `Role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `User` */

insert  into `User`(`id`,`username`,`password`,`email`,`language`,`role_id`) values 
(1,'admin','admin','admin@yaas.com','Eng',1);

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add task',7,'add_task'),
(26,'Can change task',7,'change_task'),
(27,'Can delete task',7,'delete_task'),
(28,'Can view task',7,'view_task'),
(29,'Can add completed task',8,'add_completedtask'),
(30,'Can change completed task',8,'change_completedtask'),
(31,'Can delete completed task',8,'delete_completedtask'),
(32,'Can view completed task',8,'view_completedtask'),
(33,'Can add user',9,'add_user'),
(34,'Can change user',9,'change_user'),
(35,'Can delete user',9,'delete_user'),
(36,'Can view user',9,'view_user'),
(37,'Can add role',10,'add_role'),
(38,'Can change role',10,'change_role'),
(39,'Can delete role',10,'delete_role'),
(40,'Can view role',10,'view_role'),
(41,'Can add auction_ status',11,'add_auction_status'),
(42,'Can change auction_ status',11,'change_auction_status'),
(43,'Can delete auction_ status',11,'delete_auction_status'),
(44,'Can view auction_ status',11,'view_auction_status'),
(45,'Can add auction',14,'add_auction'),
(46,'Can change auction',14,'change_auction'),
(47,'Can delete auction',14,'delete_auction'),
(48,'Can view auction',14,'view_auction'),
(49,'Can add bid',12,'add_bid'),
(50,'Can change bid',12,'change_bid'),
(51,'Can delete bid',12,'delete_bid'),
(52,'Can view bid',12,'view_bid'),
(53,'Can add auction_ temp',13,'add_auction_temp'),
(54,'Can change auction_ temp',13,'change_auction_temp'),
(55,'Can delete auction_ temp',13,'delete_auction_temp'),
(56,'Can view auction_ temp',13,'view_auction_temp');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `background_task` */

DROP TABLE IF EXISTS `background_task`;

CREATE TABLE `background_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(190) NOT NULL,
  `task_params` longtext NOT NULL,
  `task_hash` varchar(40) NOT NULL,
  `verbose_name` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `run_at` datetime(6) NOT NULL,
  `repeat` bigint(20) NOT NULL,
  `repeat_until` datetime(6) DEFAULT NULL,
  `queue` varchar(190) DEFAULT NULL,
  `attempts` int(11) NOT NULL,
  `failed_at` datetime(6) DEFAULT NULL,
  `last_error` longtext NOT NULL,
  `locked_by` varchar(64) DEFAULT NULL,
  `locked_at` datetime(6) DEFAULT NULL,
  `creator_object_id` int(10) unsigned DEFAULT NULL,
  `creator_content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `background_task_creator_content_type_61cc9af3_fk_django_co` (`creator_content_type_id`),
  KEY `background_task_task_name_4562d56a` (`task_name`),
  KEY `background_task_task_hash_d8f233bd` (`task_hash`),
  KEY `background_task_priority_88bdbce9` (`priority`),
  KEY `background_task_run_at_7baca3aa` (`run_at`),
  KEY `background_task_queue_1d5f3a40` (`queue`),
  KEY `background_task_attempts_a9ade23d` (`attempts`),
  KEY `background_task_failed_at_b81bba14` (`failed_at`),
  KEY `background_task_locked_by_db7779e3` (`locked_by`),
  KEY `background_task_locked_at_0fb0f225` (`locked_at`),
  CONSTRAINT `background_task_creator_content_type_61cc9af3_fk_django_co` FOREIGN KEY (`creator_content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `background_task` */

/*Table structure for table `background_task_completedtask` */

DROP TABLE IF EXISTS `background_task_completedtask`;

CREATE TABLE `background_task_completedtask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(190) NOT NULL,
  `task_params` longtext NOT NULL,
  `task_hash` varchar(40) NOT NULL,
  `verbose_name` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `run_at` datetime(6) NOT NULL,
  `repeat` bigint(20) NOT NULL,
  `repeat_until` datetime(6) DEFAULT NULL,
  `queue` varchar(190) DEFAULT NULL,
  `attempts` int(11) NOT NULL,
  `failed_at` datetime(6) DEFAULT NULL,
  `last_error` longtext NOT NULL,
  `locked_by` varchar(64) DEFAULT NULL,
  `locked_at` datetime(6) DEFAULT NULL,
  `creator_object_id` int(10) unsigned DEFAULT NULL,
  `creator_content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `background_task_comp_creator_content_type_21d6a741_fk_django_co` (`creator_content_type_id`),
  KEY `background_task_completedtask_task_name_388dabc2` (`task_name`),
  KEY `background_task_completedtask_task_hash_91187576` (`task_hash`),
  KEY `background_task_completedtask_priority_9080692e` (`priority`),
  KEY `background_task_completedtask_run_at_77c80f34` (`run_at`),
  KEY `background_task_completedtask_queue_61fb0415` (`queue`),
  KEY `background_task_completedtask_attempts_772a6783` (`attempts`),
  KEY `background_task_completedtask_failed_at_3de56618` (`failed_at`),
  KEY `background_task_completedtask_locked_by_edc8a213` (`locked_by`),
  KEY `background_task_completedtask_locked_at_29c62708` (`locked_at`),
  CONSTRAINT `background_task_comp_creator_content_type_21d6a741_fk_django_co` FOREIGN KEY (`creator_content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `background_task_completedtask` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(10,'account','role'),
(9,'account','user'),
(1,'admin','logentry'),
(14,'auction','auction'),
(11,'auction','auction_status'),
(13,'auction','auction_temp'),
(12,'auction','bid'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(8,'background_task','completedtask'),
(7,'background_task','task'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'account','0001_initial','2019-11-04 17:24:50.917629'),
(2,'contenttypes','0001_initial','2019-11-04 17:24:52.943037'),
(3,'auth','0001_initial','2019-11-04 17:24:56.139935'),
(4,'admin','0001_initial','2019-11-04 17:25:04.742378'),
(5,'admin','0002_logentry_remove_auto_add','2019-11-04 17:25:06.770616'),
(6,'admin','0003_logentry_add_action_flag_choices','2019-11-04 17:25:06.831641'),
(7,'auction','0001_initial','2019-11-04 17:25:08.981850'),
(8,'contenttypes','0002_remove_content_type_name','2019-11-04 17:25:14.878332'),
(9,'auth','0002_alter_permission_name_max_length','2019-11-04 17:25:15.023765'),
(10,'auth','0003_alter_user_email_max_length','2019-11-04 17:25:15.146796'),
(11,'auth','0004_alter_user_username_opts','2019-11-04 17:25:15.215240'),
(12,'auth','0005_alter_user_last_login_null','2019-11-04 17:25:15.959621'),
(13,'auth','0006_require_contenttypes_0002','2019-11-04 17:25:16.005069'),
(14,'auth','0007_alter_validators_add_error_messages','2019-11-04 17:25:16.076146'),
(15,'auth','0008_alter_user_username_max_length','2019-11-04 17:25:16.250559'),
(16,'auth','0009_alter_user_last_name_max_length','2019-11-04 17:25:16.418970'),
(17,'auth','0010_alter_group_name_max_length','2019-11-04 17:25:16.597333'),
(18,'auth','0011_update_proxy_permissions','2019-11-04 17:25:16.642181'),
(19,'background_task','0001_initial','2019-11-04 17:25:17.482918'),
(20,'background_task','0002_auto_20170927_1109','2019-11-04 17:25:32.489151'),
(21,'sessions','0001_initial','2019-11-04 17:25:32.930553');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('gm04plnh0hd3gb8bmxxie2wdvpn4npfm','N2JmMGUxYzkyMDg0ODI0ZmFhODliYTkyZTQ0NTA4Yjc1YjE0ZTNhYjp7Imxhbmd1YWdlIjoiRW5nIn0=','2019-11-18 19:46:53.095626');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
