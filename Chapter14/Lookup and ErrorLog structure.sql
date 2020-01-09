-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 192.168.0.3    Database: bedrock
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `errorlog`
--

DROP TABLE IF EXISTS `errorlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errorlog` (
  `SQLID` int(11) NOT NULL AUTO_INCREMENT,
  `ErrNumber` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ErrDescription` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `CallingProc` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ErrDate` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `UserName` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ShowUser` int(11) DEFAULT NULL,
  `Parameters` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`SQLID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errorlog`
--

LOCK TABLES `errorlog` WRITE;
/*!40000 ALTER TABLE `errorlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `errorlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookups`
--

DROP TABLE IF EXISTS `lookups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookups` (
  `Key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Descriptions` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookups`
--

LOCK TABLES `lookups` WRITE;
/*!40000 ALTER TABLE `lookups` DISABLE KEYS */;
INSERT INTO `lookups` VALUES ('MySQL Database','bedrock','The name of the database to connect to'),('MySQL Driver','<Your Details>','MySQL Driver to use'),('MySQL Port','3306','The port number to connect to MySQL Server'),('MySQL Server','<Your Details>','The IP address of the MySQL Server'),('MySQL User Name','<Your Details>','The username to log into MySQL'),('MySQL User Password','<Your Details>','The password to log into MySQL with'),('ReleaseFolder','<Your Details>','Release folder to download new version'),('ReleaseName','Chapter14 Contacts - Conversion.accdb','Name of the released application'),('ReleaseVersion','1','Latest released version number');
/*!40000 ALTER TABLE `lookups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-28 10:04:38
