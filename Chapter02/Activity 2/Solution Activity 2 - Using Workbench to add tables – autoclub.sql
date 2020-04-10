CREATE DATABASE  IF NOT EXISTS `autoclub` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `autoclub`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 192.168.0.3    Database: autoclub
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
-- Table structure for table `identification`
--

DROP TABLE IF EXISTS `identification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `IDType` int(11) NOT NULL,
  `StateOfIssue` int(11) NOT NULL,
  `IDNumber` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `ExpiryDate` date NOT NULL,
  `Class` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Conditions` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IdentificationNumber` (`IDType`,`IDNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `memberaddress`
--

DROP TABLE IF EXISTS `memberaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `memberaddress` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `StreetAddress1` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `StreetAddress2` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Town` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `State` int(11) NOT NULL,
  `Postcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Surname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `FirstName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MiddleNames` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DOB` date NOT NULL,
  `Signature` blob,
  `Photo` blob,
  `Active` bit(1) NOT NULL DEFAULT b'1',
  `JoinDate` date NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `Surname` (`Surname`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `RegoExpires` date NOT NULL,
  `RegNumb` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Use` int(11) NOT NULL,
  `Year` int(11) NOT NULL,
  `Make` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Variant` int(11) NOT NULL,
  `Shape` int(11) NOT NULL,
  `EngCap` double NOT NULL,
  `VIN` varchar(17) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tare` int(11) DEFAULT NULL,
  `GVM` int(11) DEFAULT NULL,
  `GCM` int(11) DEFAULT NULL,
  `Passengers` int(11) NOT NULL,
  `EngNumb` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `AxleCode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Conditions` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-18 20:02:15
