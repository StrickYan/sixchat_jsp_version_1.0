-- --------------------------------------------------------
-- 主机:                           119.29.24.253
-- 服务器版本:                        5.1.73 - Source distribution
-- 服务器操作系统:                      redhat-linux-gnu
-- HeidiSQL 版本:                  8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 S2013150028 的数据库结构
CREATE DATABASE IF NOT EXISTS `S2013150028` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `S2013150028`;


-- 导出  表 S2013150028.music 结构
CREATE TABLE IF NOT EXISTS `music` (
  `musicTime` int(11) NOT NULL AUTO_INCREMENT,
  `musicId` int(11) DEFAULT NULL,
  PRIMARY KEY (`musicTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  过程 S2013150028.music_of_today 结构
DELIMITER //
CREATE DEFINER=`S2013150028`@`%` PROCEDURE `music_of_today`()
BEGIN
	select musicId from music where musicTime=curdate()+0;
END//
DELIMITER ;


-- 导出  表 S2013150028.WaddFriend 结构
CREATE TABLE IF NOT EXISTS `WaddFriend` (
  `uId` char(50) DEFAULT NULL,
  `addId` char(50) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `remarks` char(50) DEFAULT NULL,
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.WBlock 结构
CREATE TABLE IF NOT EXISTS `WBlock` (
  `momentId` int(11) DEFAULT NULL,
  `blockedId` char(50) DEFAULT NULL,
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.WComment 结构
CREATE TABLE IF NOT EXISTS `WComment` (
  `momentId` int(11) DEFAULT NULL,
  `comment` varchar(280) DEFAULT NULL,
  `replyId` char(50) DEFAULT NULL,
  `replyedId` char(50) DEFAULT NULL,
  `time` char(50) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `news` int(11) DEFAULT '1',
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.WFriends 结构
CREATE TABLE IF NOT EXISTS `WFriends` (
  `uId` char(50) DEFAULT NULL,
  `fId` char(50) DEFAULT NULL,
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.Wlike 结构
CREATE TABLE IF NOT EXISTS `Wlike` (
  `momentId` int(11) DEFAULT NULL,
  `likeId` char(50) DEFAULT NULL,
  `likedId` char(50) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `news` int(11) DEFAULT '1',
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.WMentions 结构
CREATE TABLE IF NOT EXISTS `WMentions` (
  `mentionId` char(50) DEFAULT NULL,
  `mentionedId` char(50) DEFAULT NULL,
  `momentId` int(11) DEFAULT NULL,
  `news` int(11) DEFAULT '1',
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.WMoments 结构
CREATE TABLE IF NOT EXISTS `WMoments` (
  `uId` char(50) DEFAULT NULL,
  `Info` varchar(300) DEFAULT NULL,
  `Imageurl` varchar(100) DEFAULT NULL,
  `Time` char(50) DEFAULT NULL,
  `state` int(11) unsigned DEFAULT '1',
  `No` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 S2013150028.WUsers 结构
CREATE TABLE IF NOT EXISTS `WUsers` (
  `uId` char(50) NOT NULL,
  `Password` char(50) DEFAULT NULL,
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `uImageurl` varchar(100) DEFAULT 'img/default/04.jpg',
  `sex` char(50) DEFAULT '未知',
  `region` char(50) DEFAULT '广东深圳',
  `whatsup` char(50) DEFAULT '啦啦啦',
  PRIMARY KEY (`uId`),
  KEY `No` (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
