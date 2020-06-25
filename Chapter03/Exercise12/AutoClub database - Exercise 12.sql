CREATE DATABASE  IF NOT EXISTS `autoclub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `autoclub`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 192.168.0.3    Database: autoclub
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clubevents`
--

DROP TABLE IF EXISTS `clubevents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubevents` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EventType` int(11) DEFAULT NULL,
  `EventDate` date NOT NULL COMMENT 'Date of the event',
  `EventStartTime` time NOT NULL COMMENT 'Time the event will start',
  `EventEndTime` time NOT NULL COMMENT 'Expected time the event will finish',
  `RegistrationTime` time NOT NULL COMMENT 'Members must register on the day by this time',
  `VenueStart` int(11) NOT NULL COMMENT 'Venue or location where the event will start from',
  `VenuEnd` int(11) NOT NULL COMMENT 'Venue or location where the event will end',
  `EntriesClose` datetime DEFAULT NULL COMMENT 'Date and Time when entry registrations close',
  `EntryFee` double NOT NULL DEFAULT '0',
  `EventTitle` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `EventBlurb` mediumtext COLLATE utf8mb4_unicode_ci,
  `clubeventscol` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ClubEvents_EventVenue_idx` (`VenueStart`),
  KEY `FK_ClubEvents_EventVenue_End_idx` (`VenuEnd`),
  KEY `Idx_EventDate` (`EventDate` DESC),
  KEY `FK_Clubevents_EventType` (`EventType`),
  CONSTRAINT `FK_ClubEvents_EventVenue_End` FOREIGN KEY (`VenuEnd`) REFERENCES `eventvenues` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ClubEvents_EventVenue_Start` FOREIGN KEY (`VenueStart`) REFERENCES `eventvenues` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Clubevents_EventType` FOREIGN KEY (`EventType`) REFERENCES `eventtype` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubevents`
--

LOCK TABLES `clubevents` WRITE;
/*!40000 ALTER TABLE `clubevents` DISABLE KEYS */;
/*!40000 ALTER TABLE `clubevents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventmemberregistration`
--

DROP TABLE IF EXISTS `eventmemberregistration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventmemberregistration` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClubEventID` int(11) NOT NULL,
  `MemberID` int(11) NOT NULL,
  `ExpectedGuestCount` int(11) NOT NULL DEFAULT '0',
  `RegistrationDate` date NOT NULL,
  `FeesPaid` bit(1) NOT NULL DEFAULT b'0',
  `TotalFees` double NOT NULL DEFAULT '0',
  `MemberAttended` bit(1) NOT NULL DEFAULT b'0',
  `ActualGuestCount` int(11) NOT NULL DEFAULT '0',
  `Notes` mediumtext COLLATE utf8mb4_unicode_ci,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `Idx_EventID` (`ClubEventID` DESC),
  KEY `FK_EventReg_Members_idx` (`MemberID`),
  KEY `FK_EventReg_ClubEvents` (`ClubEventID`),
  CONSTRAINT `FK_EventReg_ClubEvents` FOREIGN KEY (`ClubEventID`) REFERENCES `clubevents` (`ID`),
  CONSTRAINT `FK_EventReg_Members` FOREIGN KEY (`MemberID`) REFERENCES `members` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventmemberregistration`
--

LOCK TABLES `eventmemberregistration` WRITE;
/*!40000 ALTER TABLE `eventmemberregistration` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventmemberregistration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventtype`
--

DROP TABLE IF EXISTS `eventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventtype` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EventType` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventtype`
--

LOCK TABLES `eventtype` WRITE;
/*!40000 ALTER TABLE `eventtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventvenues`
--

DROP TABLE IF EXISTS `eventvenues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventvenues` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VenueName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `VenueAddress1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueAddress2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueTown` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueState` int(11) DEFAULT NULL,
  `VenuePostcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueContactName` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenuePhone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueEmail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueWebsite` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Idx_VenueName` (`VenueName`),
  KEY `FK_EventVenue_States_idx` (`VenueState`),
  CONSTRAINT `FK_EventVenue_States` FOREIGN KEY (`VenueState`) REFERENCES `states` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventvenues`
--

LOCK TABLES `eventvenues` WRITE;
/*!40000 ALTER TABLE `eventvenues` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventvenues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identification`
--

DROP TABLE IF EXISTS `identification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `identification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `IDType` int(11) NOT NULL,
  `StateOfIssue` int(11) NOT NULL,
  `IDNumber` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ExpiryDate` date NOT NULL,
  `Class` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Conditions` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IdentificationNumber` (`IDType`,`IDNumber`),
  KEY `FK_Member_idx` (`MemberID`),
  KEY `FK_IdentificationMember_idx` (`MemberID`),
  CONSTRAINT `FK_Identification_IdentificationType` FOREIGN KEY (`IDType`) REFERENCES `identificationtype` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Identification_Members` FOREIGN KEY (`MemberID`) REFERENCES `members` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identification`
--

LOCK TABLES `identification` WRITE;
/*!40000 ALTER TABLE `identification` DISABLE KEYS */;
INSERT INTO `identification` VALUES (195,87,3,8,'2440','2020-06-20',NULL,NULL,'2020-01-24 11:56:11','2020-01-24 11:56:11'),(196,85,1,8,'6762','2019-10-23',NULL,NULL,'2020-01-24 11:56:11','2020-01-24 11:56:11'),(197,40,2,1,'1031','2020-10-21',NULL,NULL,'2020-01-24 11:56:11','2020-01-24 11:56:11'),(198,90,1,1,'2958','2020-04-10',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(199,54,1,8,'9798','2020-04-19',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(200,66,1,2,'1629','2020-08-11',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(201,102,2,4,'7127','2020-03-15',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(202,23,2,2,'1860','2020-07-13',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(203,83,1,4,'9057','2020-02-14',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(204,78,3,4,'2897','2020-12-16',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(205,1,2,6,'4285','2019-11-30',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(206,62,2,6,'9137','2020-11-07',NULL,NULL,'2020-01-24 11:56:12','2020-01-24 11:56:12'),(207,99,1,5,'9161','2020-05-03',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(208,100,3,5,'5137','2020-05-18',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(209,19,2,4,'2698','2019-11-10',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(210,86,1,8,'610','2020-04-14',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(211,26,2,4,'1557','2020-05-23',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(212,12,1,6,'5421','2019-12-27',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(213,47,3,6,'5061','2020-04-14',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(214,77,1,7,'4596','2020-09-30',NULL,NULL,'2020-01-24 11:56:13','2020-01-24 11:56:13'),(215,7,2,7,'188','2020-01-21',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(216,65,1,1,'3317','2019-12-14',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(217,101,1,5,'6570','2020-06-24',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(218,79,3,1,'1920','2020-08-26',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(219,50,2,3,'1500','2020-09-07',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(220,32,3,5,'897','2020-10-02',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(221,61,2,4,'4922','2020-01-20',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(222,56,1,1,'5898','2020-01-02',NULL,NULL,'2020-01-24 11:56:14','2020-01-24 11:56:14'),(223,81,3,1,'4439','2020-02-19',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(224,27,3,7,'2730','2020-08-24',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(225,51,1,1,'310','2020-03-14',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(226,10,3,3,'2353','2020-05-26',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(227,94,1,3,'450','2020-05-27',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(228,20,1,7,'5886','2020-10-01',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(229,48,3,3,'5429','2019-11-22',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(230,36,2,4,'9604','2019-12-08',NULL,NULL,'2020-01-24 11:56:15','2020-01-24 11:56:15'),(231,30,3,5,'3477','2019-12-24',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(232,67,2,2,'9937','2019-12-15',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(233,24,1,3,'5477','2020-12-18',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(234,46,2,4,'8472','2020-11-03',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(235,88,3,6,'9967','2020-03-22',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(236,68,2,4,'6953','2020-01-07',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(237,21,2,5,'8146','2020-06-23',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(238,97,2,5,'2278','2020-07-29',NULL,NULL,'2020-01-24 11:56:16','2020-01-24 11:56:16'),(239,18,2,6,'8866','2020-04-05',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(240,41,1,3,'1503','2020-06-18',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(241,37,1,5,'3635','2020-11-26',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(242,71,2,2,'6840','2020-09-27',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(243,93,2,7,'1618','2020-10-25',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(244,70,1,8,'659','2019-11-13',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(245,33,3,4,'4636','2019-12-10',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(246,58,1,2,'482','2020-09-12',NULL,NULL,'2020-01-24 11:56:17','2020-01-24 11:56:17'),(247,15,2,5,'2168','2020-05-20',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(248,43,3,7,'3989','2020-12-08',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(249,49,3,1,'6346','2020-09-11',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(250,84,1,4,'4020','2020-02-21',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(251,59,3,7,'6961','2020-04-27',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(252,25,3,3,'3566','2020-05-04',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(253,73,3,1,'6459','2020-03-25',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(254,45,1,2,'777','2020-05-04',NULL,NULL,'2020-01-24 11:56:18','2020-01-24 11:56:18'),(256,34,1,4,'3959','2020-02-23',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(257,103,2,2,'5173','2021-01-06',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(258,39,2,8,'6572','2020-05-08',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(259,31,3,1,'7561','2020-09-05',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(260,17,2,2,'2238','2020-03-15',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(261,63,3,1,'5180','2020-10-02',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(262,42,3,3,'9727','2020-10-23',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(263,2,3,8,'8757','2020-04-26',NULL,NULL,'2020-01-24 11:56:19','2020-01-24 11:56:19'),(264,29,1,8,'7973','2020-09-03',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(265,44,2,1,'1678','2019-12-31',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(266,91,2,4,'1062','2020-02-21',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(267,95,2,7,'4980','2020-01-11',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(268,64,3,3,'3236','2020-10-08',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(269,75,1,4,'2361','2020-11-27',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(270,14,2,3,'3895','2020-11-19',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(271,52,2,8,'5172','2020-03-17',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(272,38,3,3,'2596','2020-01-07',NULL,NULL,'2020-01-24 11:56:20','2020-01-24 11:56:20'),(273,60,2,1,'7423','2020-11-10',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(274,69,1,6,'4049','2020-10-27',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(275,72,3,4,'780','2020-04-23',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(276,8,2,6,'3123','2020-10-21',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(277,13,1,5,'9562','2020-02-06',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(278,98,3,1,'9842','2020-08-05',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(279,16,2,8,'5749','2020-02-07',NULL,NULL,'2020-01-24 11:56:21','2020-01-24 11:56:21'),(280,76,3,1,'4388','2020-10-03',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(281,80,1,4,'3973','2020-06-16',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(282,82,1,5,'2097','2019-11-21',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(283,35,3,1,'6524','2020-12-07',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(284,53,1,8,'8462','2020-05-08',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(285,6,2,7,'8349','2020-04-10',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(286,57,1,3,'4132','2019-12-25',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(287,96,2,1,'2051','2020-09-02',NULL,NULL,'2020-01-24 11:56:22','2020-01-24 11:56:22'),(288,92,2,2,'9914','2020-05-22',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(289,89,1,4,'2887','2020-09-29',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(290,11,3,7,'1769','2019-12-05',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(291,5,1,2,'3774','2020-01-11',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(292,104,3,7,'5815','2020-09-19',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(293,55,1,3,'283','2020-11-03',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(294,9,3,7,'3327','2020-05-12',NULL,NULL,'2020-01-24 11:56:23','2020-01-24 11:56:23'),(295,74,2,7,'5640','2020-01-18',NULL,NULL,'2020-01-24 11:56:24','2020-01-24 11:56:24'),(296,22,1,3,'5735','2020-03-24',NULL,NULL,'2020-01-24 11:56:24','2020-01-24 11:56:24');
/*!40000 ALTER TABLE `identification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identificationtype`
--

DROP TABLE IF EXISTS `identificationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `identificationtype` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identificationtype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identificationtype`
--

LOCK TABLES `identificationtype` WRITE;
/*!40000 ALTER TABLE `identificationtype` DISABLE KEYS */;
INSERT INTO `identificationtype` VALUES (1,'Drivers License'),(2,'ID Card (Government Issued)'),(3,'Passport');
/*!40000 ALTER TABLE `identificationtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookups`
--

DROP TABLE IF EXISTS `lookups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lookups` (
  `Key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Value` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descriptions` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookups`
--

LOCK TABLES `lookups` WRITE;
/*!40000 ALTER TABLE `lookups` DISABLE KEYS */;
INSERT INTO `lookups` VALUES ('ImageRepository','D:\\FileRepository\\','AutomobileClubimages');
/*!40000 ALTER TABLE `lookups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `make`
--

DROP TABLE IF EXISTS `make`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `make` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Make` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `make`
--

LOCK TABLES `make` WRITE;
/*!40000 ALTER TABLE `make` DISABLE KEYS */;
INSERT INTO `make` VALUES (1,'Alfa Romeo'),(2,'Aprilia'),(3,'Audi'),(4,'BMW'),(5,'Bombardier'),(6,'Chevrolet'),(7,'Chrysler'),(8,'Citroen'),(9,'Daewoo'),(10,'DAF'),(11,'Daihatsu'),(12,'Daimler'),(13,'Dodge'),(14,'Ducati'),(15,'Eunos'),(16,'Ferrari'),(17,'Fiat'),(18,'Ford'),(19,'Foton'),(20,'Great Wall'),(21,'Harley Davidson'),(22,'Hino'),(23,'Hitachi'),(24,'Holden'),(25,'Honda'),(26,'Hummer'),(27,'Hyundai'),(28,'Isuzu'),(29,'Iveco'),(30,'Jaguar'),(31,'Jeep'),(32,'Kawasaki'),(33,'Kenworth'),(34,'Kia'),(35,'Lamborghini'),(36,'Land Rover'),(37,'LDV'),(38,'Lexus'),(39,'M.G'),(40,'Mack'),(41,'Mahindra'),(42,'Maserati'),(43,'Mazda'),(44,'Mercedes'),(45,'Mercedes-Benz'),(46,'Mini'),(47,'Mini Cooper'),(48,'Mitsubishi'),(49,'MV Augusta'),(50,'Nissan'),(51,'Peugeot'),(52,'Pontiac'),(53,'Porsche'),(54,'Proton'),(55,'Quintrex'),(56,'Renault'),(57,'Rhino'),(58,'Riviera'),(59,'Rover'),(60,'Saab'),(61,'Seat'),(62,'Skoda'),(63,'Ssangyong'),(64,'Subaru'),(65,'Suzuki'),(66,'Toyota'),(67,'Volkswagen'),(68,'Volvo'),(69,'Western Star'),(70,'Yamaha');
/*!40000 ALTER TABLE `make` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberaddress`
--

DROP TABLE IF EXISTS `memberaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberaddress` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `StreetAddress1` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `StreetAddress2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `State` int(11) NOT NULL,
  `Postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `FK_Member_idx` (`MemberID`),
  KEY `FK_MemberAddress_States_idx` (`State`),
  CONSTRAINT `FK_MemberAddress_Members` FOREIGN KEY (`MemberID`) REFERENCES `members` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_MemberAddress_States` FOREIGN KEY (`State`) REFERENCES `states` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberaddress`
--

LOCK TABLES `memberaddress` WRITE;
/*!40000 ALTER TABLE `memberaddress` DISABLE KEYS */;
INSERT INTO `memberaddress` VALUES (1,1,'314 Hyatt Wells',NULL,'Bodehaven',2,'501','2020-01-24 06:52:40','2020-01-24 12:03:26'),(2,2,'010 Schaefer Brook',NULL,'West Calista',2,'5476','2020-01-24 06:52:40','2020-01-24 12:03:26'),(3,77,'590 Kuhn Ports',NULL,'Yasmeenchester',1,'5584','2020-01-24 06:52:40','2020-01-24 12:03:35'),(4,73,'320 Vivien Cliffs',NULL,'Jacksonbury',2,'2836','2020-01-24 06:52:40','2020-01-24 12:03:35'),(5,5,'61589 Crona Squares',NULL,'Port Otto',2,'2065','2020-01-24 06:52:40','2020-01-24 12:03:26'),(6,6,'5654 Margarette Drive',NULL,'Weimannmouth',2,'9626','2020-01-24 06:52:40','2020-01-24 12:03:26'),(7,7,'33624 Maudie Terrace',NULL,'New Conner',2,'9330','2020-01-24 06:52:40','2020-01-24 12:03:26'),(8,8,'426 Cassandre Vista',NULL,'Teaganmouth',2,'9925','2020-01-24 06:52:40','2020-01-24 12:03:27'),(9,9,'013 Jameson Curve',NULL,'South Miller',2,'8396','2020-01-24 06:52:40','2020-01-24 12:03:27'),(10,10,'6639 Heath Corner',NULL,'West Corneliushaven',2,'4093','2020-01-24 06:52:40','2020-01-24 12:03:27'),(11,11,'77272 Zelda Walks',NULL,'South Elenaton',1,'8052','2020-01-24 06:52:40','2020-01-24 12:03:27'),(12,12,'4453 Bernardo Prairie',NULL,'North Raphaellemouth',2,'9894','2020-01-24 06:52:40','2020-01-24 12:03:27'),(13,13,'506 Beatty Bridge',NULL,'Willismouth',2,'2585','2020-01-24 06:52:40','2020-01-24 12:03:27'),(14,14,'77473 Goldner Fords',NULL,'New Wilber',1,'1745','2020-01-24 06:52:40','2020-01-24 12:03:27'),(15,15,'1097 Abernathy View',NULL,'North Clara',1,'6946','2020-01-24 06:52:40','2020-01-24 12:03:27'),(16,16,'0619 Bechtelar Port',NULL,'Kingfort',2,'170','2020-01-24 06:52:40','2020-01-24 12:03:27'),(17,17,'636 Kohler Square',NULL,'Karleeside',4,'3391','2020-01-24 06:52:40','2020-01-24 12:03:27'),(18,18,'1922 Germaine Gateway',NULL,'Julesfort',2,'6925','2020-01-24 06:52:40','2020-01-24 12:03:28'),(19,19,'323 Kevin Center',NULL,'Lake Missouribury',2,'1104','2020-01-24 06:52:40','2020-01-24 12:03:28'),(20,20,'44277 Marlee Island',NULL,'Madelynnport',2,'1098','2020-01-24 06:52:40','2020-01-24 12:03:28'),(21,21,'26816 Huel Ridges',NULL,'Lake Norwoodton',2,'2906','2020-01-24 06:52:40','2020-01-24 12:03:28'),(22,22,'972 Tracey Plains',NULL,'West Myriam',2,'3989','2020-01-24 06:52:40','2020-01-24 12:03:28'),(23,23,'93107 Arielle Walk',NULL,'West Obieview',2,'5590','2020-01-24 06:52:40','2020-01-24 12:03:28'),(24,24,'106 Lakin Keys',NULL,'Leuschkeside',2,'3110','2020-01-24 06:52:40','2020-01-24 12:03:28'),(25,25,'452 Johnson Extensions',NULL,'Port Briellefurt',2,'2956','2020-01-24 06:52:40','2020-01-24 12:03:28'),(26,26,'3950 Avery Parks',NULL,'Nicoland',2,'8079','2020-01-24 06:52:40','2020-01-24 12:03:28'),(27,27,'2933 Kattie Inlet',NULL,'Grahamville',4,'3096','2020-01-24 06:52:40','2020-01-24 12:03:28'),(28,28,'2197 VonRueden Ford',NULL,'DuBuquehaven',1,'3758','2020-01-24 06:52:40','2020-01-24 22:32:41'),(29,29,'790 Bianka Avenue',NULL,'New Markburgh',4,'4010','2020-01-24 06:52:40','2020-01-24 12:03:29'),(30,30,'039 Colby Trafficway',NULL,'Pricestad',4,'8414','2020-01-24 06:52:40','2020-01-24 12:03:29'),(31,31,'280 Swaniawski Roads',NULL,'Roweberg',4,'4096','2020-01-24 06:52:40','2020-01-24 12:03:29'),(32,32,'606 Toy Plaza',NULL,'Athenashire',4,'7245','2020-01-24 06:52:40','2020-01-24 12:03:29'),(33,33,'7156 Darron Cape',NULL,'Alysamouth',4,'6587','2020-01-24 06:52:40','2020-01-24 12:03:29'),(34,34,'5750 Greyson Circle',NULL,'Port Veda',2,'4064','2020-01-24 06:52:40','2020-01-24 12:03:29'),(35,35,'796 Littel Crest',NULL,'New Jedidiahbury',2,'9503','2020-01-24 06:52:40','2020-01-24 12:03:29'),(36,36,'39514 Pfeffer Mountains',NULL,'Harveymouth',2,'6456','2020-01-24 06:52:40','2020-01-24 12:03:30'),(37,37,'0768 Chadrick Lights',NULL,'Lake Santafort',2,'5161','2020-01-24 06:52:40','2020-01-24 12:03:30'),(38,38,'99833 Reina Fork',NULL,'West Jamirmouth',5,'2234','2020-01-24 06:52:40','2020-01-24 12:03:30'),(39,39,'64980 Keaton Views',NULL,'South Adell',2,'5827','2020-01-24 06:52:40','2020-01-24 12:03:30'),(40,40,'802 Rodriguez Trail',NULL,'Kreigerhaven',2,'7485','2020-01-24 06:52:40','2020-01-24 12:03:30'),(41,41,'3197 Rogers Terrace',NULL,'Janaechester',2,'4565','2020-01-24 06:52:40','2020-01-24 12:03:30'),(42,42,'303 Ricky Mews',NULL,'Lorenzshire',2,'9043','2020-01-24 06:52:40','2020-01-24 12:03:30'),(43,43,'48367 Baumbach Centers',NULL,'Blandaborough',2,'2830','2020-01-24 06:52:40','2020-01-24 12:03:30'),(44,44,'3703 Madie Greens',NULL,'North Colt',2,'6675','2020-01-24 06:52:40','2020-01-24 12:03:31'),(45,45,'038 Daniel Point',NULL,'Kuhlmanbury',2,'8901','2020-01-24 06:52:40','2020-01-24 12:03:31'),(46,46,'7473 Herman Turnpike',NULL,'New Helena',5,'2814','2020-01-24 06:52:40','2020-01-24 12:03:31'),(47,47,'1531 Pinkie Lane',NULL,'Zariatown',5,'3681','2020-01-24 06:52:40','2020-01-24 12:03:31'),(48,48,'01604 Dino Viaduct',NULL,'Starkbury',5,'143','2020-01-24 06:52:40','2020-01-24 12:03:31'),(49,49,'381 Melvin Summit',NULL,'Rutherfordchester',5,'2947','2020-01-24 06:52:40','2020-01-24 12:03:31'),(50,50,'682 Antonio Knoll',NULL,'Rueckerfort',5,'9840','2020-01-24 06:52:40','2020-01-24 12:03:31'),(51,51,'41459 Cleo Path',NULL,'West Madelyn',5,'7613','2020-01-24 06:52:40','2020-01-24 12:03:32'),(52,52,'98423 Brakus Ports',NULL,'East Garretburgh',5,'5809','2020-01-24 06:52:40','2020-01-24 12:03:32'),(53,53,'8214 Kovacek Fall',NULL,'Lake Jarrett',2,'6057','2020-01-24 06:52:40','2020-01-24 12:03:32'),(54,54,'576 Cordelia Dale',NULL,'North Malachichester',2,'2681','2020-01-24 06:52:40','2020-01-24 12:03:32'),(55,55,'6357 Watsica Garden',NULL,'Monahanburgh',2,'5082','2020-01-24 06:52:40','2020-01-24 12:03:32'),(56,56,'383 Hellen Loop',NULL,'New Juvenalport',2,'7936','2020-01-24 06:52:40','2020-01-24 12:03:32'),(57,57,'40777 Baumbach Passage',NULL,'Hickleborough',2,'8574','2020-01-24 06:52:40','2020-01-24 12:03:32'),(58,58,'0269 Neil Well',NULL,'Lake Reneland',2,'932','2020-01-24 06:52:40','2020-01-24 12:03:33'),(59,59,'525 Ara Mews',NULL,'Prohaskaburgh',2,'5419','2020-01-24 06:52:40','2020-01-24 12:03:33'),(60,60,'6337 Mercedes Creek',NULL,'Ankundingfurt',6,'4154','2020-01-24 06:52:40','2020-01-24 12:03:33'),(61,61,'1896 Carolyne Ports',NULL,'Davisbury',2,'734','2020-01-24 06:52:40','2020-01-24 12:03:33'),(62,62,'04082 Hahn Hollow',NULL,'Coleport',6,'4514','2020-01-24 06:52:40','2020-01-24 12:03:33'),(63,63,'6331 Claire Isle',NULL,'South Korbin',6,'6989','2020-01-24 06:52:40','2020-01-24 12:03:33'),(64,64,'257 Geraldine Union',NULL,'New Armaniland',6,'4993','2020-01-24 06:52:40','2020-01-24 12:03:33'),(65,65,'14550 Amelie Underpass',NULL,'South Donavonmouth',6,'4069','2020-01-24 06:52:40','2020-01-24 12:03:34'),(66,66,'458 Bashirian Rest',NULL,'Port Earnestview',6,'9450','2020-01-24 06:52:40','2020-01-24 12:03:34'),(67,67,'21073 Gerry Streets',NULL,'Keelingmouth',2,'9846','2020-01-24 06:52:40','2020-01-24 12:03:34'),(68,68,'837 Stanton Mount',NULL,'North Ezekiel',2,'5914','2020-01-24 06:52:40','2020-01-24 12:03:34'),(69,69,'969 Leonora Villages',NULL,'West Arturo',2,'5320','2020-01-24 06:52:40','2020-01-24 12:03:34'),(70,70,'09861 Jeanette Shoals',NULL,'New Marlin',2,'6151','2020-01-24 06:52:40','2020-01-24 12:03:34'),(71,71,'858 Cassandre Cliff',NULL,'Lubowitzmouth',2,'892','2020-01-24 06:52:40','2020-01-24 12:03:34'),(72,72,'81852 August Flat',NULL,'East Nicola',2,'1845','2020-01-24 06:52:40','2020-01-24 12:03:34'),(73,73,'9360 Willie Plains',NULL,'Blickstad',2,'189','2020-01-24 06:52:40','2020-01-24 12:03:35'),(74,74,'9943 Watsica Park',NULL,'East Chanelle',2,'1526','2020-01-24 06:52:40','2020-01-24 12:03:35'),(75,75,'600 Filiberto Turnpike',NULL,'Rathtown',2,'4201','2020-01-24 06:52:40','2020-01-24 12:03:35'),(76,76,'239 Clement Squares',NULL,'Lake Lucius',2,'5484','2020-01-24 06:52:40','2020-01-24 12:03:35'),(77,77,'0951 Emmerich Ridge',NULL,'Prestonstad',2,'7810','2020-01-24 06:52:40','2020-01-24 12:03:35'),(78,78,'637 Winifred Mission',NULL,'Lake Edenbury',2,'430','2020-01-24 06:52:40','2020-01-24 12:03:35'),(79,79,'794 Fannie Hollow',NULL,'Cummingsburgh',7,'4058','2020-01-24 06:52:40','2020-01-24 12:03:36'),(80,80,'81020 Jevon Harbor',NULL,'Cliffordstad',7,'590','2020-01-24 06:52:40','2020-01-24 12:03:36'),(81,81,'89438 Tromp Walks',NULL,'Ashlynnfort',7,'3119','2020-01-24 06:52:40','2020-01-24 12:03:36'),(82,82,'4444 Murray Loop',NULL,'Kalebland',7,'6030','2020-01-24 06:52:40','2020-01-24 12:03:36'),(83,83,'74139 Hirthe Roads',NULL,'Eddieview',7,'5177','2020-01-24 06:52:40','2020-01-24 12:03:36'),(84,84,'60705 Mraz Roads',NULL,'Port Tatum',2,'5964','2020-01-24 06:52:40','2020-01-24 12:03:36'),(85,85,'8633 Vandervort Common',NULL,'Rileyfort',2,'3296','2020-01-24 06:52:40','2020-01-24 12:03:36'),(86,86,'1545 Richmond Mountains',NULL,'Port Gino',2,'9093','2020-01-24 06:52:40','2020-01-24 12:03:36'),(87,87,'851 Bins Spring',NULL,'Cheyenneshire',2,'7700','2020-01-24 06:52:40','2020-01-24 12:03:37'),(88,88,'031 Zulauf Park',NULL,'Fayville',2,'5759','2020-01-24 06:52:40','2020-01-24 12:03:37'),(89,89,'52570 Strosin Burgs',NULL,'South Julie',2,'4316','2020-01-24 06:52:40','2020-01-24 12:03:37'),(90,90,'497 Leffler Cliff',NULL,'Kunzeside',2,'7325','2020-01-24 06:52:41','2020-01-24 12:03:37'),(91,91,'1137 Amparo Points',NULL,'Kozeyhaven',2,'1630','2020-01-24 06:52:41','2020-01-24 12:03:37'),(92,92,'04680 Becker Prairie',NULL,'East Odellbury',2,'597','2020-01-24 06:52:41','2020-01-24 12:03:37'),(93,93,'613 Emard Green',NULL,'South Tremayneside',2,'2433','2020-01-24 06:52:41','2020-01-24 12:03:37'),(94,94,'646 Stehr Pike',NULL,'Ilaville',8,'7585','2020-01-24 06:52:41','2020-01-24 12:03:37'),(95,95,'498 Rick Terrace',NULL,'West Dariana',8,'9512','2020-01-24 06:52:41','2020-01-24 12:03:38'),(96,96,'0738 Lenora Freeway',NULL,'Bahringerfurt',8,'3454','2020-01-24 06:52:41','2020-01-24 12:03:38'),(97,97,'75327 Mattie Pine',NULL,'East Eribertoburgh',8,'6842','2020-01-24 06:52:41','2020-01-24 12:03:38'),(98,98,'854 McLaughlin Way',NULL,'East Sister',2,'7914','2020-01-24 06:52:41','2020-01-24 12:03:38'),(99,99,'6264 Holden Centers',NULL,'Daphneburgh',2,'355','2020-01-24 06:52:41','2020-01-24 12:03:38'),(100,100,'3087 Schumm Villages',NULL,'Marquisfort',2,'7941','2020-01-24 06:52:41','2020-01-24 12:03:39');
/*!40000 ALTER TABLE `memberaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Surname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FirstName` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MiddleNames` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DOB` date NOT NULL,
  `Signature` blob,
  `Photo` blob,
  `PhotoPath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SigPath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Active` bit(1) NOT NULL DEFAULT b'1',
  `JoinDate` date NOT NULL,
  `InactiveDate` date DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `Surname` (`Surname`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'Bloggs','Frederick',NULL,'1990-06-16','ˇ\ÿˇ\‡\0JFIF\0\0\0\0\0\0ˇ\·\0@Exif\0\0II*\0\0\0\0\01\0\0\0\0&\0\0\0;\0\0\0\0-\0\0\0\0\0\0\0Picasa\0Tom Pettit\0ˇ\·¨http://ns.adobe.com/xap/1.0/\0<?xpacket begin=\"Ôªø\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"XMP Core 5.5.0\"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\"> <dc:creator> <rdf:Seq> <rdf:li>Tom Pettit</rdf:li> </rdf:Seq> </dc:creator> </rdf:Description> </rdf:RDF> </x:xmpmeta>   <?xpacket end=\"w\"?>ˇ\€\0Ñ\0\Z#\"! !!  3\"!%\'.*4 -20*0\"\'(&			&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&ˇ¿\0\0E\0˝\0ˇ\ƒ\0\0\0\0\0\0\0\0\0\0\0\0ˇ\ƒ\07\0\0\0\0\0\0!1A\"2QaqÅBë°#Rí$3bÇˇ\ƒ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇ\ƒ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ˇ\⁄\0\0\0?\0\ﬂ\Ë\nÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†P(9eÉ$Ñ\0$û¿\Á\'\ÿPföø^4ç-ÕºM,¯8-)\\˝ã∫Ç>\„\"Ç7˛°lnqõmu$¨B∆å#@\ŒN±\'\œ˙Pk\Î˜†˝P(\nquf\√m\›ˇ\0∏I>Qxƒä~\'\nTeùFp¬Ç˚@†Áªªé¡\Z\Ê\Ì\’FYúÖP>\‰ˆ©:±c#4zDwW•O\ [ºÄ¶N˝é(8€≠vé-µòo,\…Ò˘õrΩæ∏R\«˚P_4\ÌNZ5Ω\”\‰Y#oïêÇ\Ó=˛\‘;ÉuY\Ìd\Z\‘\È9\‚\Ã\ÿÛ\≈FY±ë\‡{è≠.\œ\ﬁ÷ª\Ÿ$∫\“9Òç¯kƒìÄA\'±\ﬂ∑ä-Å@†P(\nÅ@†P(3}\⁄ˆøJ\—\√>Ωﬂ¶pÚJ±\∆∞\Ô…ªÂ†ã\‹\›8€õ>\Õı}N‘ï@=yπ; †	@\…?∞\Ó|\nøK6Êï™BªßM”ñ›π∞à¥\œ1¬û<á3Ö<≤;w\Ìú\–j¥\nÅ@†ÚÆ\”\„}\—˘ÛÒ\'\Ê$ú#”è&/\◊\ÂAA\Í™£\À˛tjsΩ˚ß\Ÿ\È\¬Öëò∞Fly\»F?aÅ\ÓrŒ¢uô\€\«e¶\≈ï¡Ù¢åhÉ∑\"˘s\ÿå˜\Ó0h#çÑ€≥nÕ®oYX^\Ê#¡TBãâ\0\0I\…W8†£˛o\Êw:rì\Ëò=F$äø`J≥~º~\‘-f_ÛOs.òO+h¶=Ω8≤dˇ\0õ3Ù+Ù†◊∫\Z\‹K©j∂\„\Àx\À1Ç∞¢FH«±eo\ÈAx†P(\nÅ@†P(\nW∏∫Wq®\Î∫Ù´≥ná≠\«>ß¬™∏_\Â!ï@!ª£g\Ô\ƒfæó&\◊Dµë[ÉHÚ¢∞%[\n±Ú\Â8-\ÿ˝h9zgæµ)b≤⁄õ~\‘˙I(\‹g\ƒm1yÄâÖr;\‰úv\ÓE\Áxı*\È5\·k%Ãñ÷ñ≥™≤ß É!e^\Ó[\0A#\«sAm\€{\Ín§\Î(öYí++Dyd©ôè¬º¬úq\…\»Sû\ s\Á∞Ko\Ì˜=µ\‹+k¸\‹\Ï\»@a˘\„\‡∑∑\0x9\nf\‚ø\‘6µe¶\ÿ_\\\›	\ƒFH\Á~`ñê´\0∏\¬FG\‘\–]∫≠\‘Ò±£[+\0\ÍQï\r\›cL\„ë˘ ÖPIÒÇõ˝V\“4©7~•©\\ã±ë°,=\0å@(c\∆9aºå`ˆﬁÇ›§˙ì\›\Î>H\“%?wnM˝=1˝h=A¸#=çA±:Iw≤\Ô\ﬂPÇ-±\'˝%R\Õ,}¯á\‰\0R3\‰d˘\∆2h2nµ\ÍT\÷\Áâ{àÑq ˝?\Ê\ÌA§ıv\Ó˜C∂∑“¶\¬Èå±\≈+¿∏ Ø\ y!O\ÿÛÇ	\Ôä	Ω\Z]3f\Ë3\Ó\r£Úòâıºç7 Å˛Ñ;\ƒ`w\Ì\Á$2>ëI\"\…qì\ﬁÚ\·[à£c\ i[\Ë*\„\Í\ƒ\ÔA\Ëk˚˚Nôi™\“dCnÅF9;{ª1\…\'ı4úæ\ÔW\”n∑\ÊΩ,©\níññ∂Ú<J[!Ai#+#G0˘_∑ÅA-\–M\«wØ\€\›.≠+\À\È∫i	b,96I<ìA¯\ﬁ=B∫\÷ıÿª-\¬9b≥\\cë\\∏_`ì\Á=Ü<êÜ\Í°®tî@t\›B{Ér≤DI≈óá\≈#\·8íG\Î\Ï\Z^\“\‘[J\—\·\÷7\Ã\«\—ı\ÊíBI\√\Â¿«∂\n>ÄbÇÉ∑uçG¨73\\Cq5çÑ$(\Ì\∆gc\‹\„\√cπÚ@\0\‰öI7N®ö∫t˙\…$ânïßvá\·f@ Æ{ås\ﬂ®7\›WSèGÜMF\Ï\·\"B\Ìè8\ÿ{ì\‡sAÁΩô\‘\Î\Ì~;]\À<±°ñTÙqErQX\0ês\ﬂ\ÔA\È*ÅA\Àó\ﬂ^∏H\–f>\0ö.\‡ã|\Ÿ=\Óå\Ô\Zø©\Zª(\‰\ Úü\‹gqA\ÊNßm´}QMø†sëÑqâ7\'y‹ì\ﬂ\€%Y{\0<\–zõi\È\·˚m%±ò¢Eb<r\„\«€ñh2çv\‰Ak{‘ª\ËPK:§Zz∫/$åû)!\»\Ì#dø\‘8†˚Ù\÷-Lπ\‹WÆ´\ÍJyª\0é5˜?´1˛î\∆\“\‹M®nO\‚ˆ\Õi\ÁòD\”T\’\÷<Å\ﬂ\Â!Bˆ\… dy†\ﬁm6ùÆﬁö]„∏¶\‹\„\‚ûP8îb4\…1\€\À7sﬂπ\»`®¶˛‹±\›LsójñpaCïGo´\Z\rWÒπñ\¬\ƒhú\…p\ \\\ÂâXüß\'\0Æ\ÈA¯\ËÑ\–m\›]f˝\ƒhfë\‰vÖP>˝\«`2Io⁄É^∂ú]¢\‹\«\·\‘0œúëü\ÎA∫˜ΩñÃå\\kq\Âû£.\‰y\‚?q\‹\‡w˚\–I\ÿj\—\ﬂ\€&∞2ë\…\ 9\‡FP\ﬂ\…\0Ä{˜†Ú\÷\—\”_®∫˘ΩP}3p\◊2\·b\…A˝{\'\Ôˆ†\’ˇ\07kô´|\œr∏eG$ˇ\0p?z¶¡•¥\⁄\◊%≤#ö˙5_æ3ˆ\ (˝A˙PiﬂáKR\¬{\‰\0\Ã”≤;c\‚\nÆ~ôbSˆ†´˛ ˜\\Z§ñ˙Ñ°˝#L\‰	>9\ÀÙ\ÂA5©\È-®l\»V¿g”ç% }Bd?∂Yè\Ëh:˙PWg\Ì\Ÿ˜\…d2 •ª|£Ñc˜e\Ìı\ÂAL¸=Jç™O%\ÀQ≠ﬂè#‹í\Ë[Úq\ﬂ\Îå˝\Ë8˙œ∏Ü\Ô\’c\”4\∆êÅ\nêr\ZVoè\‹dÖˇ\0\‰\–^:ıØE•\ÿCµ,\‹s-8¡\Ó!E<r=≤¡H\œ˚h$∫=≠Z\Ë:Ò+ßU\…+M\‹gñ~è˜\n\0˜\ÌAûÙyõs\Ó	5€ë\‹	\Ó\–<∑´\€Ù˚Pk\«Yã|^•¨nüì∑ó±,?\Ó\Óêr\nÄ¸\È\ŒHÚ¡}Üh3N∫m\ZçÆ°§ˇ\0\Êºn\‡ôT¢´¶C\0O\’s\ÔA\Ë®¡P\ŒNO\ﬂﬁÉ\È@†PD\Ó=\n-\Õk.ç}üNU¡«êA§}\√\0j\◊m\Ï=wc$ön›π≥ír¿\‹,°–ê (#8±$dx\Óh%∂gJCπm…ØK˘ª\«b\‹\ \·èí†˘o`{\0<A•PT∫á≥ˇ\0\∆ˆ/§F\·íºl\Ÿ\‚~∏\ÔÇ	¯\Œpqä\n.\…\Ë{i#Ü\Ê∏3G\»?\Âcg¸πq\·ú69¯∏èÚ;PsoﬁÑ∂πt˙æ‹ñ8åáì\« *ÅΩ ≤)#>qè9\Ô\ÌAﬂ∑z54•$\ﬁ˜≤]¨d∑ı$hAR\Á$}Ä_æA\≈fÚ\ËLöù˜Ò}µ4p´∞vV\‰¶7\ŒIèÇü~¯\ÌÉ\ÔÙ5ˇ\0H£∫\”f\—\⁄vñ\Íbé\◊Seù§OîíBc+åúr\'π†âÿΩmãni˝tG\Êñ\»\œ˘q\'˚ò69∏èÛ\‚ÉcÖy\’öˇ\0ò1\ƒ\–J\"ö\‹Qï±êq\‹wPA˜\Ìﬂ∞DùïØjˆi∂5{ªHm\’6{të¶í5\0qb\‹Tv\08œæFA	+æîEi•K∂v\‰Üóâíf\Ó“ï \·\»¡\n|`v=éNB∑®tìS\ﬁ/n7Ö\‹+h\¬*\€f`\0\‰Iê\0∞2\›\«a⁄Çˇ\0¨\Ï+]SL;J\ÿb\neFx0<Éy¯è.\Á\'\'\'ø|\–e[°\Zñù#E&°\ËBˇ\0?\ÂûPÚ(ˆ+ÖQ˚ñ\∆|\Zñ\„Ëµñ£ß¶â£Å\ƒ\≈\„î¸Eòå7®|ê¿0001A\rµ∫S´YA¸W\‘BY\‰ì\r∂K0\',¢FçY\‰\‰Éì€ΩÖß\Ï-?K\„¥\'Ç¨m,Ø∂1\»F\ÓP7sÒ\œ4∆°“Ω;Oøk[∏Ω!π~NQ\ÈÉ\‹	nqEˆ\Óc˙\–V∂æå˝B\◊K@?.à\∆Ba*D)C«â¡U\0\„¯ˆ†‹µ^ï\È≤\ÿÕßKî/˛§óR7)yÆHvwÚNGaÇ|g4\ﬂ]£is¨iq\À{Ñ1•\Ïä ∑åø¿\Z$b\Õ+Ç\ﬂ0¯GêGö	nãÙ\·wº∫∂•$\…ç\È˙qø2.raÒ\Â\€\0åï?Jvı\È5÷°sm©m\‚∑ ¢(õí§D≈óä∞%èúé¯\ÓOäF\Ÿÿèe8\‹û\‡\ﬁ^\‚ÆT,q)Ú#AÄ	\…\À`~É\'!y†P(\nÅ@†P(\nÅ@†P(\nÅ@†ƒ¨\ÔıM\∆]ßß\È\◊&˛Gõù\◊9vbeıI¡n-\ÿc\ÈäèL:|ª\n\ÿ\«)q.\Zg;|™π\Ô\≈r{˚íO\–\0\Ô\Í6ù>ßßº\ZzHxô\·X\’’ùˇ\0\ŸA\Ì\Ô\„ﬁÇÅ∫,\Ô˙Æ\–h∂Vì\ÿ\ŸF¡¶{î±`0†\' q\ÏI\∆π£iQhPG•\ÿ/\‚P™=>ß‹ì‹ürMÖÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†P(\nÅ@†Pˇ\Ÿ','ˇ\ÿˇ\‡\0JFIF\0\0\0\0\0\0ˇ\€\0Ñ\0\r\r\n\r\r\r\r\r\r\r\r\r\r\r\r\" + $%(((-1-&0\"\'(&			\r\r&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\'&&&&&&&&&&&&ˇ¿\0\0\À\0¯\0ˇ\ƒ\0\0\0\0\0\0\0\0\0\0\0\0\0ˇ\ƒ\0I\0	\0\0\0\0!\"12ABQRaqÅbrë°¡#3Çí±≤\—$CS¢\¬\·4\“c£TstÉìÒÚˇ\ƒ\0\Z\0\0\0\0\0\0\0\0\0\0\0\0ˇ\ƒ\0)\0\0\0\0\0\0\0!1A\"2QBÅ±Raqˇ\⁄\0\0\0?\0Ûe°\Î4\’3\Ëé\€Ú\‡\ÎôqaOuLº\ﬂ\À\‚ @@@@@@@@@Aòâ]û\Œ\»-uvò5Òè¸ï\—-¯≤˜v.ö\'¡             ¯d\Ã.\Ô∏[1y!,ZF\—\Á}Có1{.πóÒPì.g∂\Î\ÍøR¶^mæµ\"4µEôõ¿õ≠∫îƒ∫•¶í≤\“V\√v\‚\ÈR∂≤ﬂé˝\›+•¢ìÚ\ÂƒØÛy-\’\Ó\Ã\◊˜.%^xÒ=nz&nêêÅz¨\Œ\Ì¯2\‚g\∆[e\‹iu\√<˙Èñï\⁄\ÂΩ\∆G00\ \Ó\ﬂt\„4®>†\Ó\¬\Á\…8ı\√˘ˇ\0{)Ö∏ßR¥+ﬁàÄÄÄÄÄÄÄÄÄÄÄÄ§∑\÷&,\‚\Ï¸$9K¡q(ºn\“ﬂ´rßo+LY∞:7¨\√\Í©\€jXeÜ¶!\ŸÕï\ÀC6˛kOˆV›≠©\–bÄÄÄÄÄÄÄÄÄÉ\ÍÖ\Ï˜ne0òùJ\Â±≥nvøµ_R>2Dàë\rπßÆé=DZ˚<E\Ó\\Õï\ŒJCÇ∑`ΩÀ•lπ[πs6g…û≥Ò\0´doßßy	\ƒw∞˘e!{Å\–X9^\–b±pOöûNˆêl\Õ˜≤ \Ÿ\À\Ï#\Êÿ§Ü?US˚DOÕ¥Ôùºä˙πô\ŸQl.˚õΩ>† \»E»¨\⁄\›˜ \Í®\√\ÊäBåÄ\ƒ¿\‰>h\ŸŸüiπµ8\ﬁ˚Øg÷Éâá™\Ã\Z\'\ﬁ\€C‡¨§µ\‡…§≤≤e™≥\ÿDàôköpçÆOfr¸U\⁄tá´*I7>C\Ì0>_1fT\À&I¢\◊:Q®ñÖﬁõ\0hk(\‡:\Ï&c,\‹M,¥Û\‰ks~ÌΩ®)ëõâ3≥\ŸÿÆ\Œ\€\Ÿ€ùêY\Í±¡Æ§ölÑ\“\’—ì\€+9æjäkÛ3ªπx≥s≤\n≥\rı6∑A>Ù≠\”?\÷\‚d˝<%s∑å∫?˛4\‰4îíM \∆Fe∏[¸\‘\›\Í-xÑ÷ì+r´%Û√ü±òˇ\0oTO&ª_yòrr~YhÒ!lë\r@ìÄ¸\‡\∆(Ä˘à\œ~_k\Í\÷\Ïˆ}*&4∞Úˇ\0x\„\n˘∏I}-s@[G3\Î€∞≥;_^\’\ ˆ›ºày\Í\rë\ @LLˆvS¥\ƒ\È5ÖVgëÛë9æ\»vm\œkn]\÷Z∏˘=L´\Z\ƒds\·˙2“àçØ<.B\Ì\œk;;y;;s:™\’dÀÖç^î/YN\Ê\·Â©Ä\‹JJ|\÷\»Wf\⁄|ÕõW6≠Íøåª\ÍØ)C‹±NOÖTÙ\’1\Ã\—TP“Åén\Ì$:N®û\’ˇ\0\Ÿ\ŸO\Z\‰†2Òê\Ë°\ƒ¿˛lGo°©{D\Ô\Î≥Æi5]ü\œ\«!\∆Mî\„\'\ﬁ\Œ\≈ggÛA%Ä\≈ÙìKˇ\0Ü•öo∑óE7{I,o\‰Çs\Â42QQ∑\r-Cˆ\…\ﬂ9y\ÿPSêw\’a˙:jyùˇ\0\‹4§-\‘ z=˝w˜ \‡S°+Ñ`s’ùÅ≤É>‹Ø¿?´˜2™˘bã)énÙ|Üê,\ròﬂéW\‚—ªóüó7f\‹x¥íT\÷V\ŸQ\Â¶x⁄∞5YDÚı_Q¯≥˛=\Ào\'\·ì>5ç‹Æ˙\›˜≠\”\Î$x¡@ ªaò\r,T<ùûl\·úc!g\‘Õ™\◊}~\r\Âuñ˘ßı:\√N<~mâ¡åu0\Á\Â\Ã.Yû)ŸÉ?Uú]Ø≠h≠ßj¶u.\ÏèErw{Ω\∆˚Zµ+\Í\’\«¯ê]¥~DS¸ú\–LÙï8∂h%ä™&f⁄à∑\Í}O\Ã˛#ØS∫Æ\’aÕã\’r∂	HXÑ\√xn }lˆ}m´ôı∂\Á\\3.ú∞:ih*\€l>h4UP\ﬂh¥&˚Z˘Úúd\œ\◊v\ÎAa\ƒ1JGâ†w9∞Û\À51D_¥\“\€˜¥\œ\“{≥áz\⁄\Œ6AÀä*Z≠e<\·,•ivÄ^°Å¨Ú35æïõ.`≥=ùùõS†\·\‰\Z\’P\‚Z\‰QS\ÏˆÑjFBo˚lÉïˇ\0≠VÜ+{\„t\ÏÆ8k\"9G<:\¬a\Èh§åÚ˜\Â7vAp\Â&ES≤“ëúY\‚#ÜSÕ±©\⁄O.v}l\Ï\‚Ç#ìºìy\Ì4∑z#∏•˝øüõ≠fÀü¢¸xªΩB0`\·¢+œµ\Á#lc\Ë\Õ\◊]v¸>∞ñ&8\‹	≥			h_Q.©=eÕ£o\'\∆pô)\'x…ü.ΩÙLz¸z\Ÿz∏Ø\⁄~JjQj\≈bT\‰¥\ÿdlV1!\'m\râ\›ÚΩ¸]ùóõû\—é\›U¨#©Ñx°´âª,DPõx\\É\ÿ\ÀV,õ‘≤ÊÆ•«Ç;\Ëû\Â}{#õá\‚∂\’\‚Qv\—˘\“\"ªÕ∂\ZΩo.ØT’ó\'#\‚HH\ƒ\Œ\œﬁπòeòö∞∫è®‹≥v#~∑\Óo\—7Z˝OIîˇ\0%±Û\¬\ÍNW,êd+éª±	{Eõ\Õ\‘Dƒ¢khwÚ˚ß≠ûû™#b\œOíHãTëõΩâº\rõ´e\‘\Í˙ß;\Ídô”®¨\ ŸÇrFYHJfx\·yÚôw[¢\›oΩg…û#\„F</Dß¶9	Äà∫\"#\—¯2Û&\€nä\È\ﬁ4\Ìh\√È™ã±µ^¢\Ô\‹Àánj∫fáa\À4øºÀ¥!\Ëﬂú∫˙ª˘∫\Ïç9î\Ì\œQ&vGå%ÑlB&=í!ˆ:Ó≥ßıàÚrñx›¥aÙN!!.˚ouv,“Ø&-º∫¶ò°î£&±Å8óã/F≥∏aò\Î/F\√jÇó	≤\€,yÚìÒïΩ\ÔguÇi\€,∂R˝aÀç\‰û=+7\÷\·≤ª,\“C(èìª´0\«Iòˇ\0€åì\›ÇÖ†Ω∏âıı\€RÙh≥è∏Ñä\ÓWnv\"D:\"≥˘|0g\‘\Ï$>ñ\“\Êaä¥5;Ú±í)?N∞ıØì\…BL-\‚q\—LcîÑHrê±â[\≈\œ\ÓØ˝B/YÒ´:¶\Í˘9M \‰ıx~\„›ñJÚ,\Íp\’V™˘8áI™*c\÷]y≥jW\«.\ﬂ⁄ô\„’æãê∫>•á\“\⁄˜7\≈E˘s)Ø!\“\ÿ]0úŒ®ˇ\0ÉN?ãµ\Ì\Ìe_\ÍMñuäªJê\⁄/§p†ß\ÈFöcıœù˝æ\n\"IáV9\ﬁ\nX\»˜í~ºO¢\ﬁ>\Â\‘J&U1GL.\ŒC,\√\ƒ_πãµ\ÎπótÆ\’Z\⁄P\'\ÂÙBvL\∆¸NlÔµùz\„x\…nFõáó¥πuÖC?VP/~e\œ¯á˘)¨/\nò\ZN\›\Ÿ˚,\Ôø\«r¢¯f´\Èñ%ﬁ™\◊Yw∑ür\ÓÉ%HNÕ™Q±z\„f¸-\Ïu\Èq≠∏\”z\Í]tp\…Y\›\‡a=4m¡ÙF\Ã\ƒ¸\Ôq kt¥\≈/2cé\Î#Ü\‹gëùõˆß\·\‚\'}\\\ﬂW\ÏYÒ\‰\Ì?Úæ\‘\Í™¿\‡\0\¬œ©ôz\‘1‰àÜÊï∫\«\Ô.•\‘eç≤R≥bè\…e∑\‰˚\–\◊<$˚cìˇ\0tn\·Ìπ∑ã≤Ûˇ\0‘∞˜ØãqŒûÆæ{¯¯”±!\n©†}D\≈7˝0õ\⁄\rvo5”ñå\’N9\"Ñ)Cµ.\\\ﬁQçŸº\—\Zkl5\Õ9ú\ƒ#ò≥fm{õ_óπY:∆ëj˚¥/\ PùÅ¬ñúz[1ë~û\r≠˝\ \Ï¶ÛµYsDFûe\ >Wëù<7\»ZéWlπõ®[u\›zxpuˆ^~\\\€¯\·\√9S0±õå\0]∂ºüsõ\Õ\Ÿw~Lc¯\Áˇ\0SëÚõûIã\’x\«\‡\ÍØÚg˙Y˙ñ\√˘9KNY¿6«ÜC\"\"ofTd\‰L¯∫òa*®¸;˘(W\“i0Û{kâ\∆FÚ\‘ˇ\0\ \Óµqm©Uû7Æ@U}ı8\ >züj≥ô)\„JoîÿàADw\‚ó\ËÑ|xΩ\◊TÒ±Æ\Õwü™áQ*Ù\ÿ6\ﬂ\rX¶}}íDm\Ÿ\Œﬁ™Íí∑Ws:∑\Î–¨ˆ§@@@@@@@@@@Dæâ;;9		f!&\·&\Ô\\\ÃwÚM\È\Ì|ö\∆>{CØ\«¡(ˇ\0\’/}E\‡\Î\Ê9ÿ∫Y¢%,\Ï≥Oï[îm»§µ\Ìm˛/\Õ\\Æ«üƒå£∞\Á\…O\Îm\ŸÚvã}ªÏæè(\«Wâí\”kic\‰\Ô&òZyrº\‹[Ytq|ª˘π∫\ﬂ>Lˇ\0©\ÂV\„\√\”\€;Ò¢\ƒBêjB8©)§ÜY`©´qà™<ö†å˙D\“\\Y\⁄\Ê\Ã\Ó\ÕfVb\„\Ô\€9…õˇ\0IQUÖT\‚s\’\ŒA<T\‘Ù—∂\’dÁ¨°gff\ Nˆ\'≥æÆªgcÆπ-+åMÙm®GdvGÑvxYyπb\"[Ònaí\Ê>˙\◊<-$gò™\„d\≈mXºn>DauòH≥D\Ë±mì˝¶∑ì≠ºõ˘¶|prˇ\07\Œa◊±°\Ÿß\Œ˜˜d]Ò5ßÖ=jeNPœú5Ò èà÷íî≈≥n ∫ì∑°«∂\€\◊k\ƒ∏_-O	Çl±\ÈûwÇeñ0vb\Ãomov\»\÷\’√øØ3ãmÎåôg\«1¸∞\‚é¸4ç\‹\—ƒñy\‡\‚÷ôˇ\0\Õ\…)ú\Â©{çu1\ﬂYSF7ˇ\0\ÕÕïïy8X\"=óu\Âdüâë\Âf?\Âü\rßæb˘ª\Ê0w\‘eg±Sl?Ìï± ø˚óå+ÜÆö:àK<F\◊\È	tÑ€ô\Ÿ˘ñ\“ÿ≠\Îem*†\‚\\ò£§\ƒ$í0lÁ∑¥Y¥DWªgØ\Õnß\"÷ÆôgDæ\∆@\“\¬\ÁTB2âOM(3;∞^\Œ\ŒŸ¥wg\‘„ôπ\◊xm˙\„-v∏\„(ˇ\0:ßx_ß®b\⁄\…_(Ipñç£,\ﬁ\Ô≤9ü\„ â0I<Ò\À;\ƒZ •¶ßài®©Yıê¡sªÙü^\Ó¶TeÕ∏_ãù+,z\—>\n1É0Ÿ∏]k©¯è ß\À\Í[¡ΩÉpk\ÎÛz\◊ƒ∂ºf\‰\◊o>[ò\ƒxOO\Ï¸T\…?4≈µ\Î.™øè:óZµº@@@@@@@@@@@AÑ∞±éBk≤8s5ã˝z#i®Kê‚¢ßz\Íp{	\»Fn/¢&íGww\‘˙Ÿöœπ¨ºnWx∂∑®Y\\t¨|M\√Ús\'ÑÖCM~(mTU≤‘Ñz#å\È4agÄc#c;\Ë«òµm\≈\“>KÀøm˙ØrCëCÜº\Ì$ØYàÇ(∞⁄©cÇö\⁄Û\÷T3eª›æç\ƒ\ﬁ\⁄ÚΩ\ﬁ\‹f…ä?îª\≈¸-X~tSÑåLcS`Øäûœñ¨#m@\Ó˚Õø0ø3\ﬂ\»Àñπ<zt\«4Önπ\›\Áì7îÛ}\Á]WQ\n˝ôhRëG®ﬁÑ—±O\√ËÄÄ∫¸\"~∏ÒJ®¶í\È∂\…u;kgˆ≥.∞[Råµ\‹<ÜhJ3p&\ bˆ!~ge\Î«Ø2Zë	å(v\“<øá\Í¢SU4\Ï1\·Õ¥∫´¨S©mWΩ8[\Ÿ,∞Ú\'\–bê\›ÚÑ˘†?µ¡ˇ\0qÅc\Áb\Ô_„ó™U\‡îSûíJjié\÷\œ,1YπÆM{/{R5∑sé%\◊!l\0\"\0<\"\"#\‡Õ©ï[\‹\Ì\’b!íâu\ng)!\…Z\Ô\€?á¡j\ƒœí\n\’bòL¥K>Ia\‚πõü\‡\Ó]EvÆe\ >L\rW“ÜP®oª#71u?óÜå˙y*ra\ÌÒ\Á54\“E#ÅãÅèE\€¸‘∑\≈\‚Ò\„%©4K`√≤øıe.V	\€\Ë\œ\’/ Ç:	\Ì©\◊qf¨9J\»l\Ô)=F\‰@@@@@@@@@Dæ≥\€[>R\ËêÙ}&\\\œ\Óç\”\€97ç5mM≥•â«≥+qy>ˆ\ÓuÛº,\’[m.≥|áS\ÊS\nø+b⁄Ñ˝eúZ±K>Um^•™¶våG\‹\rr\À\ÃÕΩ˚\Ï\⁄\‘\ƒL˘k:Ä@@@Sî@ü\Œ\ﬂWGò3u\ŒCco≤:º]hà\’˙ØÚóY¶oHéQaUJmo•#à∫WnáÉ\Óˆu-rıñ|î\Ï¶`¡ı~_ãØMÅ6|%Í†ÑS≠:fªnN˙Y¶¬•πˆWQföÚb[ƒô˜+b\Õ5\…˙ÄÄÄÄÄÄÄÄÄÄÇO\«f†üIRŸí2\·1næßmv~ok,¸é,^<wé^∑Å\„W≈û7\ cıêó\÷wı∑Sˇ\0Ùæsë∆µ%¶-¨NØAM$Ø©¢\‰\\Vf\ﬁv\Ókøí´\Ì\‚mTw)°\œH\∆;B&\'òv∂]≥7v∂V·é≤¢ﬂπPZ6•\≈=!\Ã&y\"=ùL9≤>ˆ3{\ﬁ˝\Ã\ﬂu/\‚\’€±ôU∑o™6\na\"âçõqbN¿^iK,C\Ÿ\Îï˝m~\∆\ÁV÷ö˙\‚”∂\⁄*VÜ åxDxãàüy˜ª\›\‘^˚í!–∏v2DzâüF\“Ÿ∏G6_Wrˆc\„ ü©\"kã∑iJıdëŸøÕî\Z\–∂¡®vÙΩe\ﬂgq»órµ\È	∑\È3ß\»1Y)•i!2	G˜É˘l˙ùªüRœñ+fkÚ4ıÆGÚ\»1\—Uqéi~¨Ÿµ\«+∑5˘◊á\ \„˛î\Ó\ZpÚ?W\ƒ\‰xLqûí;√õåfﬂ¨\·\·ΩﬂàlO\Œ\Î4\ﬂ∆æör\„òdoLf\¬`9Ûà\Ó\‚∂˝WLy6\‚Ù“òµC>\ﬂôÜ\Ó\‚\"<D[\">.∫\Í\Ánjj∆ê∂D\ﬁ+lÀ®cR\Ôwnˆkw©öh€©q.Â¢∂∞ Ä\Â7\ÿø§]ën˜uv:ˆW2\Â\¬\‡ëÛTJ÷öV\·˛[\∆6¸_≠¸Y&>B+\ÍEg\÷\÷		ñäπ¥qü\√/`´k´¥®\ÿs}\'\Ÿ˛¶^¨|y≤ìRÑ,\«y˝$   (—®I-/X@@@@@M\'B#BÑM¢\ZN°õv\“\Êo•6\‰D9à\‹\’[eæ]∑GFyµ∂QEO∏n!%-LuÒ\ƒbc\ÈvÅ˚ùÆ\œ\‹Îåò˚\’fÙóª`X¸Ù\⁄Xühvdàæ∞≤\‹\Î\ÁÛ`úv{rwÜºC6å¿®k§\—|\“KãçµZk©\«Jˇ\0ˆõ\⁄^{)Uú§¿!Ojo•ü\√ ?õ≠î≠4\ÀkK/Ù®\›\Ÿ\Âs®q˛+\ÏÑMaÛµ˚\‘\ŒO\ÈWr¶ed@ì\ÏßÆ÷øŒ±H\Èˇ\0sJ\ﬂ8îz$z≤3˚G\Ô:\Ÿ_\€M≥G∂XñFÅ@)¸&®^STd¶\…“î\ƒ~\Àk/¡õ\Õh\„WrÕûU\‹9∏\ﬂ\’\È0∂\÷\œa≥q\ÂAÄÄÄÄÇIhz\¬ÜL\€\“l\Ê\÷”ò™üôW6e∂}5Æ˚\◊3uSñeÇ\„ÍôçäSZ•\ÈNÒ≥ø´\ÏB|Dªs\'mNë>§π%\ 2£≠\Ÿ\ﬂEüG8ÙJ\Î|º\Ó\‹M\ﬁ\÷\ÁuO\'^´Òfö?@≥Øõ∂\‚^ıu0®r∆öÚ¿lY3	\Èré\—\€.Kü3k=\⁄˜k‘µ\·ô\”6XÑ2±S\Íh\€EeXA\ o`πH∑{æ•\ﬁ:ˆù9¥¯è¿hå\ZJâ\Z\”Uê«∞=\0Úbˇ\0,Æ\œ:çCåQ\Í]fZ )©\no)*≥\‘\‰ná/\⁄}eo%\Ëqj√û\Õ4\Œ¡\ﬂ\÷ˇ\0ä\‘ŒèíGrª†\≈í\–ıÑÑ\√\·Ü\ÈiW{iRºÜ˝Å˛g\Ï¯2\Œ\√{\Ì\◊9\„{q	+èˆEZht¥MÙMˆø2∫ß±I\Ë\Ê¯†á√ß±\Â}\≈¯ß\—\Ï<á\Â–¥aGQügf	\ƒH∂Ü)-ØSn~≠˚Æ˛W?á\‹=6u∑*¢l≥\¬&CöQó\‚\Í\‹\ﬁ≈äë5ç5\ﬁ˚Sj™Ç2∂aòØo\Ÿiˆ\Ë\Ôó\Œ\À\\cf\Ô._ı	\Ï\”z“îQG\Ê˜w˜.¢ë˝ù\‰=\Ã\¬I\\M¿≥Aòa\ÌYıëzO\‰Ãì}yàw™fV@ÄÉìÆ\–@Út∏c—ø\ÎˆUò\Èª+\Õo&πñ∑\ÃD[D]¸D\Î÷à˝Ø>}ñ⁄ôÔ©∏á˛J\\¥      íZ∞ÄÄÄâá\'Qê\€˛/©ïvñ<ˆ\”D1\‰n\»ˇ\0˙U≤C¢ñ[Hﬁñ\…y¢ft\ÓÆ\—\›¯∫(Ñb	äf˙ ıPDœÆCÙàø2\n˝L:3∑≥¡\ﬂ\'1˘\‹Y∫&;]œ≤˜˚Àåµ\›}[Ü5/K8ô¯òK\÷%\‰ˆà∂ûÑ2eœÆº^ûîhMëM\Â~í|ç¡œ¨}\"¯y?ZÙ∏\ÿ˜9làgZc\Óô\·Ò@      íZ∞ÄÄÄ°1Òâó\“v•v•Uûf_\‰\Ë\\´Ü%\¬ﬁ± è@A/Z&~\»f˛T8Ò(\Ó\È\‡\Ë90°Ω\\\"\›9>Û\Â¯Æ/¸e\›~ΩÖy3ı\ÈV5\Â\"O\Ì!å\◊\Ë wn2Ÿè\÷~óìkˆ+ÒS∫¨ñQWß<˘†@@@@@@A$¥=aBc\‚\’g\Ïü˜¯*¨Û2ˇ\0\'Z\ÂXÇBm∫f~\Œ_–êG† íïˇ\0f˚A\ZÉó;D^ë¸~:9G§Ø}\–\ÀÁ©á\ﬁ\Ï˛JúÛ™≠\≈ó¶/*æ\À“üÇ @@@SX\Ô(ô“ççW\È\Áwg\ÿ\ròˇ\0®ºˇ\0/S:\√k£ï\ DKC\÷&X\–l;˙•Ô≤Æ\Ô?<z˚Ïè™+ÖêwQ\Îà\√¸\÷?™3ˇ\0∂oT>#êF\‚ß¿\ﬂk¸˜†±ræíwÙÛ?\Ë≤r\⁄x\Î\“¿\›\"Ñ!πEàh\‚—≥\ÌÀ≥\ÍáHæﬁ•Øãçü5î\Âæ+¶	ÙRëí\–ıÑB;˙Çˇ\0:ïvc\Œ\¬/´oUø*·ïí\Ã?\Î\’˛¶A\ |O\ÎPH\À˛\€\Ïá\Êd\»!qØ/≥˘Yß\‰ˇ\0\Î*=@¸Œ≤s\Z∏\Î\⁄¡¯mëB\"ãèH\ÔZz˜xemK\‘\„|`\À(ı\ÂD\nˇ\Ÿ','Members\\Photos\\MemberPhoto_1.jpg','Members\\Signatures\\MemberSignature_1.jpg','','2020-01-15',NULL,'2020-01-21 09:02:30','2020-01-23 06:23:55'),(2,'Pettit','Thomas','William','1960-10-15',NULL,NULL,'Members\\Photos\\MemberPhoto_2.jpg',NULL,'','2020-01-20',NULL,'2020-01-21 10:01:56','2020-01-23 09:34:37'),(5,'West','Anais','Avery','1984-08-06',NULL,NULL,NULL,NULL,'','2009-07-11',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(6,'Swaniawski','Waylon','Rita','2007-10-08',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(7,'Collins','Darby','Marielle','2019-01-11',NULL,NULL,NULL,NULL,'','2015-10-12',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(8,'Schamberger','Dexter','D\'angelo','1999-10-07',NULL,NULL,NULL,NULL,'','2020-09-01',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(9,'Wintheiser','Tania','Toy','2020-01-24',NULL,NULL,NULL,NULL,'','1993-10-01',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(10,'Gu√Ç¬™ann','Markus','Letha','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(11,'Welch','Kenya','Shanel','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(12,'Cole','Laurine','Lucio','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(13,'Schneider','Mohammed','Harley','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(14,'Reinger','Jessyca','Dillan','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(15,'Konopelski','Rosemarie','Marge','1986-06-04',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(16,'Schroeder','Vaughn','Dayton','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(17,'O\'Keefe','Friedrich','Jamie','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(18,'Jacobi','Jeanie','Rubye','2020-01-24',NULL,NULL,NULL,NULL,'','1997-08-08',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(19,'Brekke','Hertha','Vernon','2020-01-24',NULL,NULL,NULL,NULL,'','2007-04-06',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(20,'Haley','Kenton','Mason','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(21,'Hintz','Liliane','Pedro','1998-10-12',NULL,NULL,NULL,NULL,'','1991-11-05',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(22,'Yost','Maximillian','Nicholaus','2020-01-24',NULL,NULL,NULL,NULL,'','1995-12-05',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(23,'Bednar','Adelle','Anjali','2004-02-12',NULL,NULL,NULL,NULL,'','1983-12-02',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(24,'Hermiston','Karen','Talia','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(25,'Lubowitz','Scottie','Sabina','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(26,'Cassin','Harmon','Francisca','2020-01-24',NULL,NULL,NULL,NULL,'','1986-10-09',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(27,'Fritsch','Chaya','Ellen','1986-11-03',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(28,'Mosciski','Jennings','Johnny','2020-01-24',NULL,NULL,NULL,NULL,'','2014-01-12',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(29,'Predovic','Gabrielle','Breanne','1991-05-04',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(30,'Hand','Mozell','Hobart','1996-06-12',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(31,'O\'Hara','Paolo','Randall','1990-08-08',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(32,'Dicki','Makenna','Kendra','2010-03-11',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(33,'Koelpin','Ardith','Brenda','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(34,'Murray','Esmeralda','Kory','2020-01-24',NULL,NULL,NULL,NULL,'','1983-06-12',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(35,'Stokes','Mara','Kylie','1984-11-09',NULL,NULL,NULL,NULL,'','1999-09-01',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(36,'Hamill','Freddie','Sandy','2012-02-06',NULL,NULL,NULL,NULL,'','2014-01-11',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(37,'Keebler','Milton','Shaina','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(38,'Robel','Elda','Dennis','2001-08-08',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(39,'Nienow','Anastasia','Adriel','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(40,'Baumbach','Jeremie','Ayla','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(41,'Johnson','Ardith','Francis','2020-01-24',NULL,NULL,NULL,NULL,'','1986-10-01',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(42,'Pagac','Glenda','Emery','2000-12-07',NULL,NULL,NULL,NULL,'','2020-10-01',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(43,'Konopelski','Lorna','Candido','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(44,'Prohaska','Arnold','Tobin','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(45,'Moen','Berniece','Carmine','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(46,'Hermiston','Nils','Alf','2020-01-24',NULL,NULL,NULL,NULL,'','1996-10-11',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(47,'Cole','Zack','Benjamin','2020-01-24',NULL,NULL,NULL,NULL,'','1984-09-10',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(48,'Halvorson','Lorenz','Freddie','2020-01-24',NULL,NULL,NULL,NULL,'','2001-04-05',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(49,'Kub','Zoe','Isaac','2020-01-24',NULL,NULL,NULL,NULL,'','2003-10-08',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(50,'Dickens','Gerard','Orland','2020-01-24',NULL,NULL,NULL,NULL,'','1994-05-12',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(51,'Graham','Devin','Carrie','2020-01-24',NULL,NULL,NULL,NULL,'','1984-05-05',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(52,'Rempel','Cindy','Cassidy','2020-01-24',NULL,NULL,NULL,NULL,'','2019-06-07',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(53,'Stroman','Monica','Zane','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:10','2020-01-24 06:48:10'),(54,'Bechtelar','Dayana','Amely','2020-01-24',NULL,NULL,NULL,NULL,'','2014-12-12',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(55,'Windler','Yadira','Dimitri','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(56,'Fahey','Petra','Stefan','2020-01-24',NULL,NULL,NULL,NULL,'','1992-10-01',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(57,'Thiel','Archibald','Chaz','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(58,'Kohler','Jedediah','Hilton','2009-09-07',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(59,'Leffler','Marta','Toby','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(60,'Runolfsson','Kacey','Hanna','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(61,'Emmerich','Kenya','Carter','2015-03-05',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(62,'Bogan','Nikita','Westley','1995-05-01',NULL,NULL,NULL,NULL,'','1993-03-09',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(63,'Padberg','Freddie','June','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(64,'Rau','Rhiannon','Araceli','1995-04-02',NULL,NULL,NULL,NULL,'','1995-05-11',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(65,'Considine','Shayne','Oral','1989-11-01',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(66,'Bechtelar','Annette','Aditya','2015-05-05',NULL,NULL,NULL,NULL,'','1991-05-05',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(67,'Hauck','Bernie','Alyson','2020-01-24',NULL,NULL,NULL,NULL,'','1987-03-06',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(68,'Herzog','Beverly','Hope','2020-01-24',NULL,NULL,NULL,NULL,'','1981-11-06',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(69,'Rutherford','Sean','Eula','2017-09-10',NULL,NULL,NULL,NULL,'','2013-08-06',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(70,'Kihn','Kareem','Ted','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(71,'Kessler','Maudie','Jennie','2005-04-10',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(72,'Sawayn','Juanita','Laurie','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(73,'Mann','Harley','Kraig','2020-01-24',NULL,NULL,NULL,NULL,'','1994-02-06',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(74,'Wyman','Myra','Judge','2020-01-24',NULL,NULL,NULL,NULL,'','2016-10-04',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(75,'Reichert','Jakayla','Grayson','2020-01-24',NULL,NULL,NULL,NULL,'','1995-09-07',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(76,'Stehr','Victor','Linnie','2016-10-11',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(77,'Collier','Eli','Iva','1984-03-04',NULL,NULL,NULL,NULL,'','2003-08-04',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(78,'Blanda','Megane','Damian','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(79,'Daugherty','Geraldine','Selina','2010-12-07',NULL,NULL,NULL,NULL,'','2001-01-04',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(80,'Stehr','Lorna','Janelle','2020-01-24',NULL,NULL,NULL,NULL,'','2004-05-04',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(81,'Flatley','Barney','Davin','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(82,'Stiedemann','Tina','Emmalee','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(83,'Bergnaum','Felix','Jaida','2012-04-08',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(84,'Langworth','Dena','Charity','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(85,'Balistreri','Hugh','Thomas','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(86,'Carroll','Darrel','Pinkie','2020-01-24',NULL,NULL,NULL,NULL,'','2011-11-06',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(87,'Bailey','Summer','Wyman','2020-01-24',NULL,NULL,NULL,NULL,'','1996-11-04',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(88,'Hermiston','Tremayne','Kyla','1985-05-12',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(89,'Walsh','Jonatan','Dena','1989-07-05',NULL,NULL,NULL,NULL,'','1990-06-12',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(90,'Baumbach','Hunter','Margret','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(91,'Prosacco','Cassandra','Mariano','2020-01-24',NULL,NULL,NULL,NULL,'','1982-05-11',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(92,'VonRueden','Clarissa','Junius','2020-01-24',NULL,NULL,NULL,NULL,'','1996-12-06',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(93,'Kiehn','Jayde','Dylan','2016-11-11',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(94,'Gusikowski','Faustino','Floyd','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(95,'Purdy','Priscilla','Cali','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(96,'Thiel','Elfrieda','Summer','2011-02-12',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(97,'Hintz','Kellen','Walter','2001-03-03',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(98,'Schneider','Edwin','Ward','2011-02-07',NULL,NULL,NULL,NULL,'','1990-02-02',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(99,'Boyle','Daron','Xander','2012-09-01',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(100,'Brakus','Emmet','Dasia','2020-01-24',NULL,NULL,NULL,NULL,'','2012-07-08',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(101,'Corkery','Heber','Trystan','2005-01-01',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(102,'Bechtelar','Germaine','Lula','1990-01-04',NULL,NULL,NULL,NULL,'','2008-11-01',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(103,'Murray','Braxton','Felicity','2020-01-24',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11'),(104,'White','Graciela','Meagan','2006-06-08',NULL,NULL,NULL,NULL,'','2020-01-24',NULL,'2020-01-24 06:48:11','2020-01-24 06:48:11');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membershipfees`
--

DROP TABLE IF EXISTS `membershipfees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `membershipfees` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `FeeAmount` double NOT NULL,
  `DatePaid` date DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `FK_MembershipFees_Members_idx` (`MemberID`),
  CONSTRAINT `FK_MembershipFees_Members` FOREIGN KEY (`MemberID`) REFERENCES `members` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membershipfees`
--

LOCK TABLES `membershipfees` WRITE;
/*!40000 ALTER TABLE `membershipfees` DISABLE KEYS */;
INSERT INTO `membershipfees` VALUES (10,1,783,'2019-11-12','2020-01-24 06:57:27','2020-01-24 06:57:27'),(11,2,235,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(12,5,516,'1981-08-12','2020-01-24 06:57:27','2020-01-24 06:57:27'),(13,6,768,'1982-03-06','2020-01-24 06:57:27','2020-01-24 06:57:27'),(14,7,648,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(15,8,541,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(16,9,852,'1991-04-12','2020-01-24 06:57:27','2020-01-24 06:57:27'),(17,10,945,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(18,11,377,'1995-06-08','2020-01-24 06:57:27','2020-01-24 06:57:27'),(19,12,617,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(20,13,486,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(21,14,154,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(22,15,185,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(23,16,658,'1981-12-01','2020-01-24 06:57:27','2020-01-24 06:57:27'),(24,17,624,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(25,18,387,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(26,19,745,'1990-08-10','2020-01-24 06:57:27','2020-01-24 06:57:27'),(27,20,970,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(28,21,106,'2009-08-01','2020-01-24 06:57:27','2020-01-24 06:57:27'),(29,22,645,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(30,23,496,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(31,24,482,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(32,25,122,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(33,26,752,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(34,27,623,'2003-12-02','2020-01-24 06:57:27','2020-01-24 06:57:27'),(35,28,666,'1984-05-12','2020-01-24 06:57:27','2020-01-24 06:57:27'),(36,29,836,'2001-02-01','2020-01-24 06:57:27','2020-01-24 06:57:27'),(37,30,994,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(38,31,284,'1981-01-12','2020-01-24 06:57:27','2020-01-24 06:57:27'),(39,32,187,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(40,33,28,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(41,34,28,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(42,35,91,'2015-07-02','2020-01-24 06:57:27','2020-01-24 06:57:27'),(44,37,245,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(45,38,380,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(46,39,904,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(47,40,289,'1981-02-06','2020-01-24 06:57:27','2020-01-24 06:57:27'),(48,41,935,'2006-08-04','2020-01-24 06:57:27','2020-01-24 06:57:27'),(49,42,631,'1980-11-01','2020-01-24 06:57:27','2020-01-24 06:57:27'),(50,43,643,'1991-07-04','2020-01-24 06:57:27','2020-01-24 06:57:27'),(51,44,344,'2018-06-08','2020-01-24 06:57:27','2020-01-24 06:57:27'),(52,45,263,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(53,46,561,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(54,47,610,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(55,48,457,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(56,49,401,'2002-01-07','2020-01-24 06:57:27','2020-01-24 06:57:27'),(57,50,873,'1984-06-01','2020-01-24 06:57:27','2020-01-24 06:57:27'),(58,51,104,'2019-02-04','2020-01-24 06:57:27','2020-01-24 06:57:27'),(59,52,531,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(60,53,784,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(61,54,261,'2005-06-07','2020-01-24 06:57:27','2020-01-24 06:57:27'),(62,55,432,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(63,56,908,'2010-03-02','2020-01-24 06:57:27','2020-01-24 06:57:27'),(64,57,713,'1992-02-05','2020-01-24 06:57:27','2020-01-24 06:57:27'),(65,58,256,'2014-04-03','2020-01-24 06:57:27','2020-01-24 06:57:27'),(67,60,391,'2017-06-06','2020-01-24 06:57:27','2020-01-24 06:57:27'),(68,61,707,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(69,62,953,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(70,63,972,'2004-03-11','2020-01-24 06:57:27','2020-01-24 06:57:27'),(71,64,82,'2015-03-01','2020-01-24 06:57:27','2020-01-24 06:57:27'),(72,65,29,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(73,66,366,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(74,67,606,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(75,68,857,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(76,69,246,'2002-06-11','2020-01-24 06:57:27','2020-01-24 06:57:27'),(77,70,82,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(78,71,599,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(80,73,60,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(81,74,622,'2020-01-24','2020-01-24 06:57:27','2020-01-24 06:57:27'),(82,75,339,'2005-08-09','2020-01-24 06:57:27','2020-01-24 06:57:27'),(83,76,84,'2016-08-09','2020-01-24 06:57:28','2020-01-24 06:57:28'),(84,77,856,'1982-05-12','2020-01-24 06:57:28','2020-01-24 06:57:28'),(85,78,120,'1981-10-05','2020-01-24 06:57:28','2020-01-24 06:57:28'),(86,79,845,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(87,80,428,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(88,81,471,'1995-03-07','2020-01-24 06:57:28','2020-01-24 06:57:28'),(89,82,107,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(90,83,841,'1981-07-04','2020-01-24 06:57:28','2020-01-24 06:57:28'),(91,84,213,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(92,85,179,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(94,87,554,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(95,88,232,'2014-03-05','2020-01-24 06:57:28','2020-01-24 06:57:28'),(96,89,44,'1998-09-11','2020-01-24 06:57:28','2020-01-24 06:57:28'),(97,90,67,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(98,91,333,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(99,92,274,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(100,93,860,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(101,94,193,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(102,95,111,'1985-12-04','2020-01-24 06:57:28','2020-01-24 06:57:28'),(103,96,676,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(104,97,342,'1999-05-05','2020-01-24 06:57:28','2020-01-24 06:57:28'),(105,98,156,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(106,99,620,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28'),(107,100,762,'2020-01-24','2020-01-24 06:57:28','2020-01-24 06:57:28');
/*!40000 ALTER TABLE `membershipfees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `State` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (1,'ACT'),(2,'NSW'),(3,'VIC'),(4,'TAS'),(5,'QLD'),(6,'NT'),(7,'SA'),(8,'WA');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table1`
--

DROP TABLE IF EXISTS `table1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `table1` (
  `ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table1`
--

LOCK TABLES `table1` WRITE;
/*!40000 ALTER TABLE `table1` DISABLE KEYS */;
INSERT INTO `table1` VALUES (1),(2),(3),(NULL),(5),(6),(7),(8),(NULL),(10);
/*!40000 ALTER TABLE `table1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table2`
--

DROP TABLE IF EXISTS `table2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `table2` (
  `ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table2`
--

LOCK TABLES `table2` WRITE;
/*!40000 ALTER TABLE `table2` DISABLE KEYS */;
INSERT INTO `table2` VALUES (1),(3),(4),(6),(NULL),(8),(9),(10),(NULL),(12);
/*!40000 ALTER TABLE `table2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Active` bit(1) NOT NULL DEFAULT b'1',
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `RegoExpires` date NOT NULL,
  `RegNumb` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Use` int(11) NOT NULL,
  `Year` int(11) NOT NULL,
  `Make` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Variant` int(11) NOT NULL,
  `Shape` int(11) NOT NULL,
  `EngCap` double NOT NULL,
  `VIN` varchar(17) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Tare` int(11) DEFAULT NULL,
  `GVM` int(11) DEFAULT NULL,
  `GCM` int(11) DEFAULT NULL,
  `Passengers` int(11) NOT NULL,
  `EngNumb` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `AxleCode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Conditions` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `WhenAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `FK_Vehicle_VehicleUse_idx` (`Use`),
  KEY `FK_Vehicle_Years_idx` (`Year`),
  KEY `FK_Vehicle_Make_idx` (`Make`),
  KEY `FK_Vehicle_VehicleModel_idx` (`Model`),
  KEY `FK_Vehicle_VehicleVariant_idx` (`Variant`),
  KEY `FK_Vehicle_VehicleShape_idx` (`Shape`),
  KEY `FK_Vehicle_Members_idx` (`MemberID`),
  CONSTRAINT `FK_Vehicle_Make` FOREIGN KEY (`Make`) REFERENCES `make` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Vehicle_Members` FOREIGN KEY (`MemberID`) REFERENCES `members` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Vehicle_VehicleModel` FOREIGN KEY (`Model`) REFERENCES `vehiclemodel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Vehicle_VehicleShape` FOREIGN KEY (`Shape`) REFERENCES `vehicleshape` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Vehicle_VehicleUse` FOREIGN KEY (`Use`) REFERENCES `vehicleuse` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Vehicle_VehicleVariant` FOREIGN KEY (`Variant`) REFERENCES `vehiclevariant` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Vehicle_Years` FOREIGN KEY (`Year`) REFERENCES `years` (`Year`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,87,'2020-01-24','1',1,2020,34,418,88,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:01:54','2020-01-24 09:01:54'),(2,85,'2020-01-24','1',1,2020,24,417,86,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:01:56','2020-01-24 09:01:56'),(3,40,'2020-01-24','1',1,2020,45,390,41,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:01:59','2020-01-24 09:01:59'),(4,90,'2020-01-24','1',1,2020,64,419,91,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:01:59','2020-01-24 09:01:59'),(5,54,'2020-01-24','1',1,2020,18,402,55,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:01:59','2020-01-24 09:01:59'),(6,66,'2020-01-24','1',1,2020,50,406,67,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(7,102,'2020-01-24','1',1,2020,48,422,103,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(8,23,'2020-01-24','1',1,2020,50,376,24,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(9,83,'2020-01-24','1',1,2020,25,416,84,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(10,78,'2020-01-24','1',1,2020,62,415,79,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(11,1,'2020-01-24','1',1,2020,64,365,2,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(12,62,'2020-01-24','1',1,2020,50,406,63,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(13,99,'2020-01-24','1',1,2020,48,422,100,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:00','2020-01-24 09:02:00'),(14,100,'2020-01-24','1',1,2020,48,422,101,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(15,19,'2020-01-24','1',1,2020,48,373,20,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(16,86,'2020-01-24','1',1,2020,34,418,87,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(17,26,'2020-01-24','1',1,2020,25,377,27,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(18,12,'2020-01-24','1',1,2020,4,371,13,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(19,47,'2020-01-24','1',1,2020,18,396,48,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(20,77,'2020-01-24','1',1,2020,38,414,78,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(21,7,'2020-01-24','1',1,2020,38,368,8,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:01','2020-01-24 09:02:01'),(22,65,'2020-01-24','1',1,2020,50,406,66,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(23,101,'2020-01-24','1',1,2020,48,422,102,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(24,79,'2020-01-24','1',1,2020,25,416,80,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(25,50,'2020-01-24','1',1,2020,66,398,51,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(26,32,'2020-01-24','1',1,2020,50,382,33,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(27,61,'2020-01-24','1',1,2020,50,406,62,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(28,56,'2020-01-24','1',1,2020,18,402,57,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(29,81,'2020-01-24','1',1,2020,25,416,82,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:02','2020-01-24 09:02:02'),(30,27,'2020-01-24','1',1,2020,56,378,28,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(31,51,'2020-01-24','1',1,2020,50,400,52,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(32,10,'2020-01-24','1',1,2020,4,371,11,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(33,94,'2020-01-24','1',1,2020,48,421,95,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(34,20,'2020-01-24','1',1,2020,48,373,21,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(35,48,'2020-01-24','1',1,2020,14,397,49,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(36,36,'2020-01-24','1',1,2020,45,385,37,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:03','2020-01-24 09:02:03'),(37,30,'2020-01-24','1',1,2020,50,380,31,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(38,67,'2020-01-24','1',1,2020,50,406,68,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(39,24,'2020-01-24','1',1,2020,50,376,25,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(40,46,'2020-01-24','1',1,2020,18,396,47,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(41,88,'2020-01-24','1',1,2020,64,419,89,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(42,68,'2020-01-24','1',1,2020,50,406,69,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(43,21,'2020-01-24','1',1,2020,48,373,22,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:04','2020-01-24 09:02:04'),(44,97,'2020-01-24','1',1,2020,48,421,98,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:05','2020-01-24 09:02:05'),(45,18,'2020-01-24','1',1,2020,48,373,19,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:05','2020-01-24 09:02:05'),(46,41,'2020-01-24','1',1,2020,45,391,42,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:05','2020-01-24 09:02:05'),(47,37,'2020-01-24','1',1,2020,45,386,38,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:05','2020-01-24 09:02:05'),(48,71,'2020-01-24','1',1,2020,48,407,72,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:05','2020-01-24 09:02:05'),(49,93,'2020-01-24','1',1,2020,48,421,94,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:05','2020-01-24 09:02:05'),(50,70,'2020-01-24','1',1,2020,48,407,71,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(51,33,'2020-01-24','1',1,2020,45,383,34,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(52,58,'2020-01-24','1',1,2020,43,404,59,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(53,15,'2020-01-24','1',1,2020,48,373,16,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(54,43,'2020-01-24','1',1,2020,45,392,44,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(55,49,'2020-01-24','1',1,2020,14,397,50,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(56,84,'2020-01-24','1',1,2020,24,417,85,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(57,59,'2020-01-24','1',1,2020,43,404,60,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:06','2020-01-24 09:02:06'),(58,25,'2020-01-24','1',1,2020,25,377,26,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:07','2020-01-24 09:02:07'),(59,73,'2020-01-24','1',1,2020,24,410,74,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:07','2020-01-24 09:02:07'),(60,45,'2020-01-24','1',1,2020,24,395,46,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:07','2020-01-24 09:02:07'),(61,28,'2020-01-24','1',1,2020,56,378,29,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:07','2020-01-24 09:02:07'),(62,34,'2020-01-24','1',1,2020,45,384,35,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:07','2020-01-24 09:02:07'),(63,103,'2020-01-24','1',1,2020,48,422,104,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:08','2020-01-24 09:02:08'),(64,39,'2020-01-24','1',1,2020,45,388,40,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:08','2020-01-24 09:02:08'),(65,31,'2020-01-24','1',1,2020,48,381,32,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:08','2020-01-24 09:02:08'),(66,17,'2020-01-24','1',1,2020,48,373,18,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:08','2020-01-24 09:02:08'),(67,63,'2020-01-24','1',1,2020,50,406,64,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:09','2020-01-24 09:02:09'),(68,42,'2020-01-24','1',1,2020,45,392,43,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:09','2020-01-24 09:02:09'),(69,2,'2020-01-24','1',1,2020,64,365,3,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:09','2020-01-24 09:02:09'),(70,29,'2020-01-24','1',1,2020,39,379,30,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:09','2020-01-24 09:02:09'),(71,44,'2020-01-24','1',1,2020,45,393,45,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:09','2020-01-24 09:02:09'),(72,91,'2020-01-24','1',1,2020,64,419,92,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:09','2020-01-24 09:02:09'),(73,95,'2020-01-24','1',1,2020,48,421,96,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(74,64,'2020-01-24','1',1,2020,50,406,65,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(75,75,'2020-01-24','1',1,2020,9,412,76,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(76,14,'2020-01-24','1',1,2020,48,373,15,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(77,52,'2020-01-24','1',1,2020,9,401,53,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(78,38,'2020-01-24','1',1,2020,45,387,39,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(79,60,'2020-01-24','1',1,2020,43,405,61,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:10','2020-01-24 09:02:10'),(80,69,'2020-01-24','1',1,2020,50,406,70,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(81,72,'2020-01-24','1',1,2020,50,409,73,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(82,8,'2020-01-24','1',1,2020,30,369,9,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(83,13,'2020-01-24','1',1,2020,4,372,14,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(84,98,'2020-01-24','1',1,2020,48,422,99,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(85,16,'2020-01-24','1',1,2020,48,373,17,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(86,76,'2020-01-24','1',1,2020,50,413,77,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:11','2020-01-24 09:02:11'),(87,80,'2020-01-24','1',1,2020,25,416,81,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(88,82,'2020-01-24','1',1,2020,25,416,83,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(89,35,'2020-01-24','1',1,2020,45,385,36,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(90,53,'2020-01-24','1',1,2020,18,402,54,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(91,6,'2020-01-24','1',1,2020,67,367,7,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(92,57,'2020-01-24','1',1,2020,43,403,58,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(93,96,'2020-01-24','1',1,2020,48,421,97,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(94,92,'2020-01-24','1',1,2020,64,420,93,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:12','2020-01-24 09:02:12'),(95,89,'2020-01-24','1',1,2020,64,419,90,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(96,11,'2020-01-24','1',1,2020,4,371,12,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(97,5,'2020-01-24','1',1,2020,38,366,6,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(98,104,'2020-01-24','1',1,2020,48,422,105,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(99,55,'2020-01-24','1',1,2020,18,402,56,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(100,9,'2020-01-24','1',1,2020,54,370,10,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(101,74,'2020-01-24','1',1,2020,9,412,75,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13'),(102,22,'2020-01-24','1',1,2020,56,374,23,23,250,NULL,NULL,NULL,NULL,6,'1',NULL,NULL,'2020-01-24 09:02:13','2020-01-24 09:02:13');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiclemodel`
--

DROP TABLE IF EXISTS `vehiclemodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiclemodel` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MakeID` int(11) DEFAULT NULL,
  `Model` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiclemodel`
--

LOCK TABLES `vehiclemodel` WRITE;
/*!40000 ALTER TABLE `vehiclemodel` DISABLE KEYS */;
INSERT INTO `vehiclemodel` VALUES (1,43,'00-00'),(2,4,'116i'),(3,4,'118d'),(4,4,'118i'),(5,4,'120i'),(6,4,'120i LCI'),(7,43,'121'),(8,4,'125i'),(9,4,'130i'),(10,4,'135i'),(11,1,'147'),(12,67,'1500'),(13,1,'156'),(14,1,'164'),(15,50,'180SX'),(16,45,'190'),(17,43,'2'),(18,50,'200SX'),(19,51,'205'),(20,51,'206'),(21,51,'207'),(22,56,'21'),(23,45,'260'),(24,43,'3'),(25,51,'3008'),(26,7,'300C'),(27,45,'300Se'),(28,50,'300ZX'),(29,51,'306'),(30,51,'307'),(31,15,'30X'),(32,4,'316Ti'),(33,4,'318i'),(34,4,'318is'),(35,4,'320Ci'),(36,4,'320d'),(37,4,'320i'),(38,43,'323'),(39,4,'323Ci'),(40,4,'323i'),(41,4,'325Ci'),(42,4,'325i'),(43,4,'325Ti'),(44,4,'328Ci'),(45,4,'328i'),(46,1,'33'),(47,4,'330Ci'),(48,4,'330i'),(49,4,'335i'),(50,4,'335i Series I'),(51,50,'350Z'),(52,16,'360'),(53,50,'370Z'),(54,48,'380'),(55,45,'380SLC'),(56,58,'4000'),(57,45,'400SEL'),(58,51,'406'),(59,51,'407'),(60,45,'420SEL'),(61,4,'435i'),(62,55,'450 Escape'),(63,69,'4800'),(64,66,'4Runner'),(65,15,'500'),(66,17,'500'),(67,45,'500SL'),(68,4,'520i'),(69,4,'523i'),(70,4,'525i'),(71,4,'528i'),(72,4,'530d'),(73,4,'530i'),(74,4,'535i'),(75,4,'540i'),(76,43,'6'),(77,51,'607'),(78,43,'626'),(79,4,'645i'),(80,4,'730i'),(81,4,'735i'),(82,4,'735Li'),(83,4,'740i'),(84,59,'75'),(85,4,'750i'),(86,4,'760Li'),(87,3,'80'),(88,68,'850'),(89,66,'86'),(90,60,'900'),(91,60,'9000'),(92,53,'911'),(93,60,'9-3'),(94,60,'9-5'),(95,3,'A1 Series I'),(96,3,'A1 Series II'),(97,45,'A160'),(98,45,'A180'),(99,45,'A200'),(100,3,'A3'),(101,3,'A4'),(102,45,'A45 AMG'),(103,3,'A5'),(104,3,'A6'),(105,3,'A8'),(106,25,'Accord'),(107,63,'Actyon'),(108,24,'Adventra'),(109,67,'Amarok'),(110,45,'AMG C 43'),(111,45,'AMG C55'),(112,24,'Apollo'),(113,27,'Ascent'),(114,24,'Astra'),(115,48,'ASX'),(116,66,'Aurion'),(117,66,'Avalon'),(118,66,'Avensis'),(119,66,'Avensis Verso'),(120,45,'B 200'),(121,24,'Barina'),(122,67,'Beetle'),(123,24,'Berlina'),(124,8,'Berlingo'),(125,50,'Bluebird'),(126,53,'Boxster'),(127,43,'Bravo'),(128,1,'Brera'),(129,64,'BRZ'),(130,43,'BT-50'),(131,45,'C 200'),(132,45,'C 250'),(133,45,'C 63'),(134,45,'C180'),(135,45,'C180 CGI'),(136,45,'C180 Kompressor'),(137,45,'C200'),(138,45,'C200 Classic'),(139,44,'C200 Kompressor'),(140,45,'C220'),(141,45,'C230'),(142,45,'C240'),(143,45,'C250'),(144,45,'C250 CDI'),(145,45,'C280'),(146,8,'C3'),(147,45,'C320 CDI'),(148,45,'C320 Elegance'),(149,45,'C350'),(150,8,'C5'),(151,68,'C70'),(152,67,'Caddy'),(153,24,'Calais'),(154,13,'Caliber'),(155,24,'Calibra'),(156,6,'Camaro'),(157,24,'Camira'),(158,66,'Camry'),(159,66,'Camry & Vienta'),(160,48,'Canter'),(161,24,'Caprice'),(162,24,'Captiva'),(163,67,'Caravelle'),(164,34,'Carnival'),(165,53,'Cayenne'),(166,53,'Cayman'),(167,25,'CBR'),(168,25,'CBR1000RR'),(169,66,'Celica'),(170,34,'Cerato'),(171,10,'CF85'),(172,48,'Challenger'),(173,11,'Charade'),(174,31,'Cherokee'),(175,66,'C-HR'),(176,9,'Cielo'),(177,25,'Civic'),(178,25,'Civic - Type R'),(179,45,'CL500'),(180,45,'CLA 45 AMG'),(181,45,'CLC200'),(182,45,'CLK 63'),(183,45,'CLK200'),(184,45,'CLK280'),(185,45,'CLK320'),(186,45,'CLK350'),(187,45,'CLK430'),(188,45,'CLK500'),(189,66,'Coaster'),(190,24,'Colorado'),(191,24,'Colorado 7'),(192,48,'Colt'),(193,24,'Combo'),(194,24,'Commodore'),(195,31,'Compass'),(196,61,'Cordoba'),(197,66,'Corolla'),(198,6,'Corvette'),(199,46,'Countryman'),(200,27,'Coupe'),(201,42,'Coupe M138'),(202,18,'Courier'),(203,67,'Crafter'),(204,34,'Credos'),(205,66,'Cressida'),(206,24,'Crewman'),(207,24,'Crewman Cross8'),(208,24,'Crewman S'),(209,24,'Crewman SS'),(210,24,'Cruze'),(211,25,'CR-V'),(212,25,'CRX'),(213,21,'Custom Built'),(214,43,'CX-5'),(215,43,'CX-7'),(216,43,'CX-9'),(217,29,'Daily'),(218,36,'Defender'),(219,48,'Delica'),(220,11,'Delta Tipper'),(221,14,'Diavel'),(222,36,'Discovery Mk 1'),(223,36,'Discovery Mk 2'),(224,36,'Discovery Mk 3'),(225,36,'Discovery Mk 4 Series II'),(226,36,'Discovery Mk 4 Series III SDV6 HSE'),(227,28,'D-Max'),(228,12,'Double-Six'),(229,50,'Dualis'),(230,17,'Ducato'),(231,22,'DUTRO'),(232,45,'E 63'),(233,45,'E Class Coupe'),(234,45,'E200'),(235,43,'E2000'),(236,45,'E220'),(237,45,'E230'),(238,45,'E240'),(239,45,'E280'),(240,45,'E320'),(241,45,'E350'),(242,38,'E5330H'),(243,45,'E55'),(244,45,'E55 AMG'),(245,66,'Echo'),(246,18,'Econovan'),(247,27,'Elantra'),(248,50,'Elgrand'),(249,50,'Elgrande'),(250,67,'Eos'),(251,24,'Epica'),(252,38,'ES300'),(253,18,'Escape'),(254,9,'Espero'),(255,66,'Estima'),(256,50,'EXA'),(257,27,'Excel'),(258,51,'Expert'),(259,18,'Explorer'),(260,48,'Express'),(261,68,'F10 F12 F16'),(262,16,'F142'),(263,18,'F150'),(264,18,'F250'),(265,16,'F355'),(266,49,'F4'),(267,16,'F430'),(268,4,'F800GS'),(269,18,'Fairlane'),(270,18,'Fairmont'),(271,18,'Falcon'),(272,18,'Falcon Forte'),(273,18,'Falcon Utility'),(274,21,'Fat Boy'),(275,18,'Festiva'),(276,18,'Fiesta'),(277,21,'FLHR'),(278,21,'FLSTF'),(279,18,'Focus'),(280,64,'Forester'),(281,18,'Forte'),(282,30,'F-Pace'),(283,18,'FPV GS'),(284,18,'FPV GT'),(285,18,'FPV Pursuit'),(286,18,'FPV Super Pursuit'),(287,18,'FPV Territory F6X'),(288,18,'FPV Typhoon'),(289,36,'Freelander'),(290,36,'Freelander MK 1'),(291,24,'Frontera'),(292,28,'FRR500'),(293,48,'FTO'),(294,18,'Futura'),(295,21,'FX'),(296,21,'FXDCI Dyna Super Glide Custom'),(297,21,'FXRS'),(298,37,'G10'),(299,48,'Galant'),(300,35,'Gallardo'),(301,1,'Giulia'),(302,45,'GL320'),(303,45,'GL450'),(304,45,'GLE350D'),(305,67,'Golf'),(306,34,'Grand Carnival'),(307,31,'Grand Cherokee'),(308,31,'Grand Cherokee Laredo'),(309,31,'Grand Cherokee Sport'),(310,65,'Grand Vitara'),(311,7,'Grand Voyager'),(312,48,'Grandis'),(313,38,'GS300'),(314,38,'GS450H'),(315,65,'GSX-R'),(316,1,'GT'),(317,57,'GTS'),(318,26,'H2'),(319,26,'H3'),(320,46,'Hatch'),(321,66,'Hiace'),(322,66,'Hilux'),(323,66,'Hino'),(324,25,'HR-V'),(325,24,'HSV'),(326,24,'HSV GTS'),(327,27,'i30'),(328,65,'Ignis'),(329,27,'iLoad'),(330,27,'iMax'),(331,6,'Impala'),(332,64,'Impreza'),(333,25,'Insight'),(334,25,'Integra'),(335,38,'IS F'),(336,38,'IS200'),(337,38,'IS250'),(338,38,'IS300'),(339,27,'ix35'),(340,24,'Jackaroo'),(341,25,'Jazz'),(342,67,'Jetta'),(343,65,'Jimny Sierra'),(344,13,'Journey'),(345,50,'Juke'),(346,8,'Jumpy'),(347,18,'Ka'),(348,56,'Kangoo'),(349,24,'Kingswood'),(350,65,'Kizashi'),(351,66,'Kluger'),(352,9,'Korando'),(353,63,'Kyron'),(354,56,'Laguna'),(355,70,'Lanboer'),(356,48,'Lancer'),(357,66,'LandCruiser'),(358,66,'LandCruiser Prado'),(359,9,'Lanos'),(360,27,'Lantra'),(361,18,'Laser'),(362,9,'Leganza'),(363,66,'Lexcen'),(364,65,'Liana'),(365,64,'Liberty'),(366,38,'LS400'),(367,67,'LT'),(368,38,'LX470'),(369,30,'M'),(370,54,'M21'),(371,4,'M3'),(372,4,'M5'),(373,48,'Magna'),(374,56,'Master'),(375,18,'Maverick'),(376,50,'Maxima'),(377,25,'MDX'),(378,56,'Megane'),(379,39,'MGF'),(380,50,'Micra'),(381,48,'Mirage'),(382,50,'MK235'),(383,45,'ML 250'),(384,45,'ML 63'),(385,45,'ML 63 AMG'),(386,45,'ML270'),(387,45,'ML280CDI'),(388,45,'ML320'),(389,45,'ML320 CDI'),(390,45,'ML350 CDI 4MATIC'),(391,45,'ML430'),(392,45,'ML500'),(393,45,'ML55 AMG'),(394,45,'ML550'),(395,24,'Monaro'),(396,18,'Mondeo'),(397,14,'Monster'),(398,66,'MR2'),(399,50,'Murano'),(400,50,'Murano Z50'),(401,9,'Musso'),(402,18,'Mustang'),(403,43,'MX5'),(404,43,'MX-5'),(405,43,'MX6'),(406,50,'Navara'),(407,48,'Nimbus'),(408,28,'NNR'),(409,50,'Nomad'),(410,24,'Nova'),(411,28,'NQR498A'),(412,9,'Nubira'),(413,50,'NX'),(414,38,'NX300H'),(415,62,'Octavia'),(416,25,'Odyssey'),(417,24,'One Tonner'),(418,34,'Optima'),(419,64,'Outback'),(420,64,'Outback BS'),(421,48,'Outlander'),(422,48,'Pajero'),(423,18,'Panel Van'),(424,66,'Paseo'),(425,67,'Passat'),(426,50,'Pathfinder'),(427,31,'Patriot'),(428,50,'Patrol'),(429,54,'Persona'),(430,67,'Polo'),(431,34,'Pregio'),(432,25,'Prelude'),(433,43,'Premacy'),(434,18,'Probe'),(435,7,'PT Cruiser'),(436,50,'Pulsar'),(437,3,'Q5'),(438,3,'Q7'),(439,50,'Qashqai'),(440,40,'Quantum'),(441,42,'Quattroporte V'),(442,42,'Quattroporte VI'),(443,59,'Quintet'),(444,45,'R280 CDI'),(445,47,'R58'),(446,3,'R8'),(447,13,'RAM'),(448,36,'Range Rover'),(449,36,'Range Rover Classic'),(450,36,'Range Rover Evoque'),(451,36,'Range Rover Sport'),(452,36,'Range Rover Vogue'),(453,18,'Ranger'),(454,22,'Ranger'),(455,66,'RAV4'),(456,51,'RCZ'),(457,63,'Rexton'),(458,34,'Rio'),(459,24,'Rodeo'),(460,2,'RSV 1000R'),(461,38,'RX330'),(462,38,'RX350'),(463,38,'RX400H'),(464,38,'RX450H'),(465,43,'RX-7'),(466,43,'RX-8'),(467,27,'S Coupe'),(468,25,'S2000'),(469,45,'S240'),(470,3,'S3'),(471,45,'S320'),(472,45,'S320 CDI'),(473,45,'S350'),(474,45,'S350 CDI'),(475,68,'S40'),(476,45,'S420'),(477,45,'S430'),(478,45,'S500L'),(479,3,'S6'),(480,68,'S60'),(481,68,'S80'),(482,27,'Santa Fe'),(483,54,'Satria'),(484,54,'Savvy'),(485,38,'SC430'),(486,56,'Scenic'),(487,67,'Scirocco'),(488,56,'Scudo'),(489,5,'Sea-Doo 200 Speedster'),(490,34,'Shuma'),(491,65,'Sierra'),(492,50,'Silvia'),(493,11,'Sirion'),(494,50,'Skyline'),(495,50,'Skyline 350GT'),(496,45,'SL350'),(497,45,'SL500'),(498,45,'SL65 AMG'),(499,45,'SLK230'),(500,45,'SLK320'),(501,66,'Soarer'),(502,27,'Sonata'),(503,34,'Sorento'),(504,34,'Spectra'),(505,1,'Spider'),(506,34,'Sportage'),(507,45,'Sprinter'),(508,50,'Stagea'),(509,66,'Starlet'),(510,24,'Statesman'),(511,63,'Stavic'),(512,66,'Supra'),(513,24,'Surburban'),(514,65,'Swift'),(515,65,'SX4'),(516,33,'T401'),(517,66,'Tarago'),(518,18,'Taurus'),(519,18,'Telstar'),(520,11,'Terios'),(521,27,'Terracan'),(522,18,'Territory'),(523,24,'Thunder'),(524,27,'Tiburon'),(525,24,'Tigra'),(526,67,'Tiguan'),(527,50,'Tiida'),(528,67,'Touareg'),(529,66,'TownAce'),(530,18,'Trader'),(531,56,'Trafic'),(532,27,'Trajet'),(533,52,'Trans Am'),(534,18,'Transit'),(535,67,'Transporter'),(536,64,'Tribeca'),(537,43,'Tribute'),(538,48,'Triton'),(539,22,'Truck 0.0'),(540,3,'TT'),(541,27,'Tucson'),(542,19,'Tunland'),(543,67,'UP!'),(544,20,'V200'),(545,20,'V240'),(546,68,'V40'),(547,68,'V70'),(548,24,'Vectra'),(549,27,'Veloster'),(550,48,'Verada'),(551,45,'Viano'),(552,66,'Vienta'),(553,65,'Vitara'),(554,45,'Vito'),(555,24,'Viva'),(556,65,'VL800C'),(557,21,'V-Rod'),(558,21,'V-Rod Muscle'),(559,21,'VRSCDX'),(560,54,'Waja'),(561,54,'Wira'),(562,70,'WR450F'),(563,31,'Wrangler'),(564,4,'X1'),(565,20,'X240'),(566,45,'X250'),(567,4,'X3'),(568,4,'X4'),(569,4,'X5'),(570,4,'X5 LCI'),(571,4,'X6'),(572,68,'XC60'),(573,68,'XC70'),(574,68,'XC90'),(575,30,'XJ'),(576,30,'XJ6'),(577,21,'XL'),(578,21,'XL1200X'),(579,50,'X-Trail'),(580,30,'X-Type'),(581,41,'XUV500'),(582,64,'XV'),(583,66,'Yaris'),(584,4,'Z3'),(585,4,'Z4'),(586,24,'Zafira'),(587,39,'ZT'),(588,32,'ZX10R'),(589,23,'ZX200-3 Excavator'),(590,32,'ZX636-C');
/*!40000 ALTER TABLE `vehiclemodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicleshape`
--

DROP TABLE IF EXISTS `vehicleshape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicleshape` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Shape` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicleshape`
--

LOCK TABLES `vehicleshape` WRITE;
/*!40000 ALTER TABLE `vehicleshape` DISABLE KEYS */;
INSERT INTO `vehicleshape` VALUES (1,'2-Door     2'),(2,'2-Door Cab-chassis Van'),(3,'2-Door Hard-top Cabriolet'),(4,'2-Door Hard-top Coupe'),(5,'2-Door Soft-top Convertible'),(6,'2-Door Van'),(7,'2+1 Door Coupe'),(8,'3-Door Hatch'),(9,'3-Door Van'),(10,'4-Door Hatch'),(11,'4-Door Van'),(12,'4-Door Wagon'),(13,'4-Wheel Drive'),(14,'4-Wheel Drive    SUV'),(15,'4-Wheel Drive, SUV'),(16,'5-Door Hatch'),(17,'5-Door Van'),(18,'Boat - Runabout'),(19,'Light Truck'),(20,'Motorbike'),(21,'People Mover'),(22,'Prime-Mover'),(23,'Sedan'),(24,'Sport Utility Vehicle (SUV)'),(25,'Truck'),(26,'Utility'),(27,'Utility - Crew-cab');
/*!40000 ALTER TABLE `vehicleshape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicleuse`
--

DROP TABLE IF EXISTS `vehicleuse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicleuse` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Use` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicleuse`
--

LOCK TABLES `vehicleuse` WRITE;
/*!40000 ALTER TABLE `vehicleuse` DISABLE KEYS */;
INSERT INTO `vehicleuse` VALUES (1,'Private'),(2,'Commercial');
/*!40000 ALTER TABLE `vehicleuse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiclevariant`
--

DROP TABLE IF EXISTS `vehiclevariant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiclevariant` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ModelID` int(11) DEFAULT NULL,
  `Variant` varchar(75) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1252 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiclevariant`
--

LOCK TABLES `vehiclevariant` WRITE;
/*!40000 ALTER TABLE `vehiclevariant` DISABLE KEYS */;
INSERT INTO `vehiclevariant` VALUES (1,365,'4 GEN BL Series II'),(2,365,'4 GEN Series II'),(3,365,'5 GEN'),(4,365,'5 GEN Series II'),(5,365,'6 GEN'),(6,366,'--Missing Data--'),(7,367,'T4'),(8,368,'UZJ100R'),(9,369,'Custom'),(10,370,'--Missing Data--'),(11,371,'E36 I'),(12,371,'E46 II'),(13,371,'E92'),(14,372,'E60'),(15,373,'TE'),(16,373,'TF'),(17,373,'TH'),(18,373,'TJ'),(19,373,'TL'),(20,373,'TP'),(21,373,'TR'),(22,373,'TS'),(23,374,'X70'),(24,376,'J32 ST-L'),(25,376,'ST-L'),(26,377,'--Missing Data--'),(27,377,'YD1 Wagon'),(28,378,'II Phase I  X84'),(29,378,'II Phase II  X84'),(30,379,'--Missing Data--'),(31,380,'K12'),(32,381,'CE Series I & Series II'),(33,382,'B210L'),(34,383,'BLUETEC 4MATIC W166'),(35,384,'W164'),(36,385,'W164'),(37,385,'W166'),(38,386,'W163'),(39,387,'W164'),(40,388,'W163'),(41,390,'W164'),(42,391,'W163'),(43,392,'W163'),(44,392,'W164'),(45,393,'W163'),(46,395,'V2'),(47,396,'HB'),(48,396,'--Missing Data--'),(49,397,'999S'),(50,397,'M620'),(51,398,'SW20R'),(52,400,'Wagon ST or TI'),(53,401,'--Missing Data--'),(54,402,'1st Gen'),(55,402,'Cobra'),(56,402,'FM GT Fastback'),(57,402,'GT Coupe Gen 5'),(58,403,'Roadstar'),(59,404,'NB'),(60,404,'NC'),(61,405,'GE'),(62,406,'D22'),(63,406,'D22 DX'),(64,406,'D22 ST'),(65,406,'D22 STD'),(66,406,'D22 ST-R'),(67,406,'D40 RX'),(68,406,'D40 ST'),(69,406,'D40 ST-X'),(70,406,'D40 ST-X 550'),(71,407,'UF'),(72,407,'UG'),(73,409,'IMPORT'),(74,410,'--Missing Data--'),(75,412,'J100 Series I'),(76,412,'J100 Series II'),(77,413,'--Missing Data--'),(78,414,'200T200'),(79,415,'1Z Elegence Mk2 Facelift'),(80,416,'3rd Gen'),(81,416,'--Missing Data--'),(82,416,'MK1 Series II'),(83,416,'MK2'),(84,416,'MK4'),(85,417,'VY Series II'),(86,417,'VZ'),(87,418,'EX Platinum Gen III'),(88,418,'Si Gen III'),(89,419,'3GEN'),(90,419,'3GEN Luxury Wagon'),(91,419,'4GEN'),(92,419,'5GEN'),(93,420,'5 GEN'),(94,421,'ZE - Mk2'),(95,421,'ZF - Mk2'),(96,421,'ZG - Mk2'),(97,421,'ZH - Mk2'),(98,421,'ZJ - Mk3'),(99,422,'NA-NG Mk1 and NH- NL Mk2'),(100,422,'NM'),(101,422,'NM-NP'),(102,422,'NP'),(103,422,'NP [Mk3]'),(104,422,'NS'),(105,422,'NT'),(106,422,'NW'),(107,422,'NX Exceed'),(108,423,'XF'),(109,424,'EL44R'),(110,425,'3C'),(111,426,'R50 Mk2'),(112,426,'R50 Mk2 Series II'),(113,426,'R51 ST'),(114,426,'R51 Ti'),(115,426,'R52'),(116,427,'MK'),(117,428,'GQ, DX'),(118,428,'GQ2 - ST, 2.8L'),(119,428,'GU - DX, Mk2, 3.0DT'),(120,428,'GU - ST Mk2, 4.8L'),(121,428,'GU Mk2 Cab-Chassis, 3.0DT'),(122,428,'GU1 - 3.0DT'),(123,428,'GU1 - 4.5L'),(124,428,'GU1 - DX, 2.8L'),(125,428,'GU1 - DX, 4.2D'),(126,428,'GU1 - ST, 4.5L'),(127,428,'GU2 - DX, 3.0DT'),(128,428,'GU2 - ST, 3.0DT'),(129,428,'GU3 - ST, 3.0DT'),(130,428,'GU3 - ST, 4.2DT'),(131,428,'GU3 - ST, 4.8L'),(132,428,'GU4 - ST, 3.0DT'),(133,428,'GU6, 3.0DT'),(134,428,'GU7 - ST, 3.0DT'),(135,428,'GU8 - ST, 3.0DT'),(136,429,'--Missing Data--'),(137,430,'6R GTI'),(138,430,'9N'),(139,431,'--Missing Data--'),(140,432,'Mk4'),(141,432,'Mk5'),(142,433,'Series 1'),(143,434,'ST'),(144,435,'Series I'),(145,436,'B17'),(146,436,'N14'),(147,436,'N16'),(148,436,'SSS'),(149,436,'SSS C12'),(150,436,'ST'),(151,437,'8R Quattro Series II'),(152,437,'New Release Need More Data'),(153,438,'Quattro'),(154,439,'J11 TI'),(155,439,'J11 TL'),(156,440,'--Missing Data--'),(157,441,'M139'),(158,442,'M156'),(159,444,'W251 - R Class Wagon'),(160,445,'S Coupe'),(161,446,'Quattro 4.2'),(162,447,'Pickup'),(163,448,'L322'),(164,448,'P38A'),(165,450,'L538 Si4 Pure'),(166,451,'L320'),(167,451,'L320 - SuperCharged'),(168,451,'L320 TDV6'),(169,451,'L322 TDV6'),(170,453,'FD1J - 4th Gen'),(171,453,'PJ XL'),(172,453,'PJ XLT'),(173,453,'PK Wildtrak'),(174,453,'PK XL'),(175,453,'PX Wildtrak'),(176,453,'PX XL'),(177,453,'PX XL Series II'),(178,453,'PX XLT'),(179,454,'FD1J - 4th Gen'),(180,454,'PJ XL'),(181,454,'PJ XLT'),(182,454,'PK Wildtrak'),(183,454,'PK XL'),(184,454,'PX Wildtrak'),(185,454,'PX XL'),(186,454,'PX XL Series II'),(187,454,'PX XLT'),(188,455,'ACA22R or ACA23R'),(189,455,'ACA33R'),(190,455,'ASA44R'),(191,455,'GSA33R'),(192,455,'--Missing Data--'),(193,455,'SXA10R'),(194,456,'Phase I'),(195,457,'Y200 4x4 Sport wagon'),(196,458,'BC'),(197,458,'JB'),(198,459,'RA Crew-cab'),(199,459,'RA LX Cab Chassis'),(200,459,'TF Crew-cab'),(201,461,'--Missing Data--'),(202,462,'GGL15R'),(203,462,'GSU35R'),(204,463,'MHU38R'),(205,464,'F Sport GYL15R Mk3'),(206,465,'IMPORT'),(207,466,'--Missing Data--'),(208,467,'--Missing Data--'),(209,468,'Roadster'),(210,469,'W140'),(211,470,'8P'),(212,470,'8VA'),(213,471,'W140'),(214,471,'W220'),(215,472,'W221'),(216,473,'W220'),(217,474,'W221'),(218,475,'MS'),(219,475,'V40 Phase II'),(220,476,'W140'),(221,477,'V220'),(222,478,'W220 aka V220'),(223,479,'C7 Quattro'),(224,480,'--Missing Data--'),(225,481,'--Missing Data--'),(226,482,'CM'),(227,482,'GL'),(228,483,'GL'),(229,484,'BT'),(230,485,'--Missing Data--'),(231,486,'RX4'),(232,489,'--Missing Data--'),(233,490,'--Missing Data--'),(234,491,'--Missing Data--'),(235,492,'S15'),(236,493,'M100 Series I'),(237,494,'350GTV35'),(238,494,'R32'),(239,494,'R33'),(240,494,'R34'),(241,495,'V35'),(242,495,'V36'),(243,496,'R230'),(244,497,'R129'),(245,498,'R230'),(246,499,'R170'),(247,500,'R171'),(248,501,'IMPORT'),(249,502,'GLS'),(250,502,'Y3'),(251,503,'BL'),(252,504,'--Missing Data--'),(253,505,'--Missing Data--'),(254,506,'--Missing Data--'),(255,507,'W904 Gen 1'),(256,507,'W906 Gen 2'),(257,508,'Series I'),(258,1,'--Missing Data--'),(259,2,'E87'),(260,3,'E88'),(261,4,'E87'),(262,5,'E87'),(263,5,'E88'),(264,6,'F20'),(265,7,'Mk1'),(266,8,'E82'),(267,8,'F20 I'),(268,9,'E87'),(269,10,'E88'),(270,11,'Series I, Selespeed'),(271,11,'Series II'),(272,12,'Beetle'),(273,13,'Monza Twin Spark'),(274,13,'Selespeed Twin Spark'),(275,14,'--Missing Data--'),(276,15,'--Missing Data--'),(277,16,'E Class'),(278,17,'DE'),(279,17,'DY'),(280,17,'DY Series II'),(281,18,'S15'),(282,18,'Series I S14'),(283,19,'--Missing Data--'),(284,20,'T1 CC'),(285,20,'T1 GTI'),(286,21,'A7 CC'),(287,21,'A7 XE'),(288,22,'Marseille'),(289,23,'--Missing Data--'),(290,24,'BK Series 1 Maxx Sport'),(291,24,'BK Series II Hatch'),(292,24,'BK Series II Neo Sport'),(293,24,'BK Series II SP23'),(294,24,'BK Series II SP23 Hatch'),(295,24,'BL Hatch'),(296,24,'BL Series I'),(297,24,'BL Series II SP20 SkyActive'),(298,24,'BL SP25'),(299,24,'Maxx BM'),(300,24,'MPS Luxury, BL Series I'),(301,24,'SP25 GT BM'),(302,24,'Touring BM'),(303,25,'XTE'),(304,26,'HEMI Series I'),(305,26,'HEMI Touring Series II'),(306,26,'Limited'),(307,26,'Sports'),(308,26,'SRT HEMI Series II'),(309,26,'SRT-8'),(310,27,'W126'),(311,28,'IMPORT'),(312,29,'N3'),(313,30,'Series II'),(314,30,'T5 XSE'),(315,31,'--Missing Data--'),(316,32,'E46/5'),(317,33,'E30'),(318,33,'E36'),(319,33,'E46 I'),(320,33,'E46 II'),(321,34,'E36'),(322,35,'E46 I'),(323,35,'E46 II'),(324,36,'E90'),(325,36,'F30'),(326,37,'E36'),(327,37,'E46 II'),(328,37,'E90'),(329,37,'F30'),(330,38,'BA'),(331,38,'BG Series I'),(332,38,'BJ'),(333,38,'BJ Series III'),(334,39,'E46 I'),(335,39,'E46 II'),(336,40,'E36 I'),(337,40,'E46 I'),(338,40,'E90 II'),(339,41,'E46 I'),(340,41,'E46 II'),(341,42,'E46 I'),(342,42,'E46 II'),(343,42,'E90'),(344,42,'E90 Series II'),(345,42,'E92'),(346,43,'E46 II'),(347,44,'E36 I'),(348,44,'E46 I'),(349,45,'E36 I'),(350,45,'E46 I'),(351,46,'Series I'),(352,47,'E46 I'),(353,47,'E46 II'),(354,48,'E46 I'),(355,48,'E46 II'),(356,49,'E90'),(357,49,'E90 Series II'),(358,49,'E92'),(359,49,'E93'),(360,49,'E93 M Sport Convertible'),(361,49,'F30'),(362,50,'E90'),(363,51,'Z33'),(364,52,'Modena F1'),(365,52,'Spider F1'),(366,53,'Z34'),(367,54,'DB'),(368,54,'DB Series II'),(369,54,'DB Series III'),(370,55,'C107'),(371,56,'Boat'),(372,57,'W140'),(373,58,'D8 & D9'),(374,59,'2.2 V6 Hdi'),(375,59,'Series 1'),(376,60,'W126'),(377,61,'F32'),(378,62,'Runabout'),(379,63,'480068 SX Prime Mover'),(380,64,'1st & 2nd Generation'),(381,64,'VZN130R'),(382,65,'--Missing Data--'),(383,66,'--Missing Data--'),(384,67,'W129'),(385,68,'E28'),(386,69,'E39'),(387,70,'E39'),(388,70,'E60'),(389,71,'E39'),(390,72,'E60'),(391,73,'E60'),(392,74,'E34'),(393,74,'E39'),(394,74,'Series 5 F10'),(395,75,'E39'),(396,76,'GG Series I'),(397,76,'GG Series II'),(398,76,'GJ SKYACTIV-Drive'),(399,78,'GE Series I'),(400,78,'GE Series II'),(401,78,'GV'),(402,78,'--Missing Data--'),(403,79,'E63'),(404,80,'E38'),(405,81,'E32'),(406,81,'E38'),(407,82,'E66'),(408,83,'E38'),(409,83,'E65 I'),(410,83,'E65 II'),(411,85,'E65 I'),(412,85,'E65 II'),(413,86,'E65/6'),(414,87,'B4'),(415,88,'GLE'),(416,89,'ZN6 GTS'),(417,90,'MK2'),(418,90,'Series II'),(419,90,'Series IV'),(420,91,'Series II'),(421,92,'993'),(422,92,'996'),(423,92,'997'),(424,93,'442'),(425,93,'MK2'),(426,94,'SE'),(427,95,'8X'),(428,96,'8X'),(429,97,'W168'),(430,98,'W176'),(431,99,'W176'),(432,100,'8L Series I'),(433,100,'8L Series II'),(434,100,'8P Series I'),(435,100,'8V - Gen 3'),(436,101,'B5'),(437,101,'B6'),(438,101,'B6 Cabriolet'),(439,101,'B7'),(440,101,'B8'),(441,101,'B8 - 8K'),(442,101,'B9 TFSI'),(443,101,'RS4 B5 8E'),(444,101,'RS6 C6 4F'),(445,101,'S8 D2'),(446,102,'W176'),(447,103,'8T'),(448,103,'8T Petrol'),(449,103,'8T TFSI'),(450,103,'8T Turbo Diesel'),(451,103,'8TA TDI Series II'),(452,104,'C6 4F Series I'),(453,104,'C6 4F Series II'),(454,104,'C7'),(455,104,'S8 D2'),(456,105,'D2 A8'),(457,105,'D3 A8 Series II'),(458,106,'Euro'),(459,106,'Euro Luxury'),(460,106,'Luxury'),(461,106,'MK3'),(462,106,'MK5'),(463,106,'MK6'),(464,106,'Mk8 Luxury'),(465,106,'Series II'),(466,107,'100 Series Sports'),(467,107,'100 Series SPR'),(468,108,'VZ'),(469,109,'2H'),(470,109,'2H Highline'),(471,109,'2H TDi340'),(472,109,'2H TDi400 4Motion'),(473,109,'2H TDi550 4Motion'),(474,110,'4MATIC AWD'),(475,111,'W203'),(476,113,'LC'),(477,114,'AH'),(478,114,'AH SRI'),(479,114,'AH Twin Top Convertible'),(480,114,'TS'),(481,114,'TS CD'),(482,114,'TS Classic'),(483,116,'ACV40'),(484,116,'GSV40R'),(485,116,'GSV50R SPVS SPORTIVO SX6'),(486,117,'--Missing Data--'),(487,118,'Verso ACM21R GLX'),(488,119,'ACM20R GLX'),(489,120,'W245'),(490,121,'SB Series II'),(491,121,'TK Hatch'),(492,121,'TK Sedan'),(493,121,'XC'),(494,122,'--Missing Data--'),(495,123,'VE Series I'),(496,123,'VE Series II'),(497,123,'VP Series II'),(498,123,'VS Series I'),(499,123,'VS Series II'),(500,123,'VT Series I'),(501,123,'VT Series II'),(502,123,'VX Series I'),(503,123,'VX Series II'),(504,123,'VY Series II'),(505,123,'VZ Series I'),(506,124,'L2 B9 H1 Long'),(507,125,'P910'),(508,126,'986'),(509,126,'986 Series II'),(510,126,'987'),(511,127,'--Missing Data--'),(512,127,'Mk3'),(513,128,'Coupe'),(514,130,'UN DX Cab Chassis'),(515,130,'UN DX+ Cab Chassis'),(516,130,'UN DX+ Freestyle'),(517,130,'UN SDX'),(518,130,'UN SDX Freestyle'),(519,130,'UP XT'),(520,130,'UP XTR'),(521,130,'UR XT'),(522,133,'AMG'),(523,134,'BlueEFFICIENCY W204'),(524,134,'--Missing Data--'),(525,134,'W202'),(526,135,'W204'),(527,136,'Classic'),(528,137,'BlueEFFICIENCY W204'),(529,137,'Classic Kompressor'),(530,137,'Kompressor'),(531,137,'W204'),(532,138,'Kompressor'),(533,139,'Classic'),(534,140,'W202'),(535,141,'W203'),(536,142,'W203'),(537,143,'Avantgarde W204'),(538,144,'W204'),(539,145,'W202'),(540,146,'Series I'),(541,147,'W204'),(542,148,'Elegance'),(543,148,'Elegance W203'),(544,149,'W203'),(545,150,'Mk2'),(546,150,'Series I'),(547,150,'Series II'),(548,151,'--Missing Data--'),(549,152,'2K Trendline'),(550,152,'Life'),(551,153,'VE Series I'),(552,153,'VE Series II'),(553,153,'VF'),(554,153,'VS Series I'),(555,153,'VT Series I'),(556,153,'VT Series II'),(557,153,'VX Series I'),(558,153,'VX Series II'),(559,153,'VY Series I'),(560,153,'VY Series II'),(561,153,'VZ'),(562,154,'PM  2.0 CVT SXT'),(563,155,'YE'),(564,156,'--Missing Data--'),(565,157,'--Missing Data--'),(566,158,'ACV36R'),(567,158,'ACV40R Sportivo'),(568,158,'Atara R & S'),(569,158,'Atara S'),(570,158,'AVV50R Hybrid'),(571,158,'--Missing Data--'),(572,159,'--Missing Data--'),(573,160,'FE434'),(574,161,'VE Series II'),(575,161,'VF'),(576,161,'VS Series III'),(577,161,'WL'),(578,161,'WM Series I'),(579,161,'WM Series II'),(580,162,'CG Series I'),(581,162,'CG Series II'),(582,162,'CG Series II 5'),(583,162,'CG Series II 7'),(584,163,'T4'),(585,164,'KVII'),(586,165,'MKII'),(587,165,'Turbo'),(588,166,'987'),(589,167,'600RR'),(590,167,'--Missing Data--'),(591,169,'Mk5'),(592,169,'ST162'),(593,169,'ST204R'),(594,169,'ZZT231'),(595,169,'ZZT231R Series II'),(596,170,'LD'),(597,170,'YD1'),(598,171,'--Missing Data--'),(599,172,'PA'),(600,172,'PA Series I'),(601,172,'PA Series II'),(602,173,'G100'),(603,173,'G200'),(604,174,'KJ'),(605,174,'KK generation'),(606,174,'KL'),(607,174,'XJ'),(608,175,'Koba NGX-10R/50R'),(609,176,'1.5i'),(610,177,'7th Generation'),(611,177,'8th Generation'),(612,177,'MK5 Gli'),(613,177,'MK5 Vti'),(614,177,'Mk6'),(615,177,'Mk6 Series II'),(616,177,'Mk7'),(617,178,'8th Generation'),(618,179,'C216'),(619,180,'C117 4MATIC'),(620,181,'Kompressor CL203'),(621,182,'AMG'),(622,183,'A208'),(623,183,'Kompressor C209'),(624,184,'C209'),(625,185,'A208'),(626,185,'C208'),(627,185,'C209'),(628,186,'C209'),(629,187,'C208'),(630,188,'C209'),(631,189,'--Missing Data--'),(632,190,'RC LX'),(633,190,'RG LTZ'),(634,190,'RG LX'),(635,191,'RG'),(636,192,'RG Series II'),(637,193,'SB'),(638,194,'VE Group 3 HDT VH Retro'),(639,194,'VE Series I'),(640,194,'VE Series I Omega'),(641,194,'VE Series I Police Pack'),(642,194,'VE Series I SS'),(643,194,'VE Series I SS V'),(644,194,'VE Series I SV6'),(645,194,'VE Series II'),(646,194,'VE Series II SS'),(647,194,'VE Series II SS V'),(648,194,'VE Series II SS V Redline'),(649,194,'VE Series II SS Z'),(650,194,'VE Series II SV6 Z'),(651,194,'VF  SS V Series I'),(652,194,'VF  SS V Series II Redline'),(653,194,'VF Evoke'),(654,194,'VF SS'),(655,194,'VF SS Storm'),(656,194,'VF SV6'),(657,194,'VF SV6 Storm'),(658,194,'VL Covering Berlina and Calais'),(659,194,'VN'),(660,194,'VP Series I'),(661,194,'VP Series II'),(662,194,'VR Series I'),(663,194,'VR Series II'),(664,194,'VR Series II Executive'),(665,194,'VR Series II S'),(666,194,'VS Series I'),(667,194,'VS Series I Executive'),(668,194,'VS Series II'),(669,194,'VS Series II S'),(670,194,'VT Series I'),(671,194,'VT Series II'),(672,194,'VT Series II SS'),(673,194,'VT Series II V8 Executive'),(674,194,'VU Series II'),(675,194,'VU Series II S'),(676,194,'VU Series II SS'),(677,194,'VX Series I Executive'),(678,194,'VX Series I S'),(679,194,'VX Series I SS'),(680,194,'VX Series II'),(681,194,'VX Series II Executive'),(682,194,'VY Series I'),(683,194,'VY Series I SS'),(684,194,'VY Series II'),(685,194,'VY Series II Executive'),(686,194,'VY Series II S'),(687,194,'VY Series II SS'),(688,194,'VY Series II SV8'),(689,194,'VZ'),(690,194,'VZ Series I SS'),(691,194,'VZ SV6'),(692,194,'VZ SVZ'),(693,195,'MK'),(694,196,'--Missing Data--'),(695,197,'AE112'),(696,197,'AE80, AE95 & AE96'),(697,197,'Ascent Hatchback ZRE152R'),(698,197,'Ascent ZRE152R'),(699,197,'Ascent ZRE182R'),(700,197,'Conquest Hatchback ZRE152R'),(701,197,'--Missing Data--'),(702,197,'ZZE122R Ascent'),(703,197,'ZZE123R Ascent'),(704,197,'ZZE123R Sportivo'),(705,198,'--Missing Data--'),(706,199,'R60'),(707,200,'RD'),(708,200,'RD II'),(709,202,'PG'),(710,203,'35T 2EF1'),(711,204,'GLX'),(712,205,'--Missing Data--'),(713,206,'VY Series II'),(714,207,'VY Series II'),(715,207,'VZ Series I'),(716,208,'VZ Series I'),(717,209,'VY Series II'),(718,210,'JG'),(719,210,'JH Series II'),(720,210,'SRi-V JH Series II'),(721,210,'YG'),(722,211,'Mk1'),(723,211,'Mk2'),(724,211,'Mks Series II'),(725,211,'RE Luxury'),(726,211,'RM - 4th Generation'),(727,212,'Mk3'),(728,213,'--Missing Data--'),(729,214,'KE'),(730,215,'ER'),(731,216,'TB I Classic'),(732,216,'TB I Luxury'),(733,216,'TB II Classic'),(734,216,'TB II Luxury'),(735,216,'TB III Luxury'),(736,218,'L316'),(737,219,'4th Gen'),(738,220,'Truck'),(739,223,'L318'),(740,224,'L319'),(741,225,'L319'),(742,226,'L319'),(743,227,'LS-M'),(744,227,'LS-M or LS-U'),(745,227,'SX'),(746,229,'J10 Series II'),(747,230,'JTD'),(748,231,'Truck 0.0'),(749,232,'W212 AMG S'),(750,233,'E250 CGI C207 Avantgarde'),(751,234,'Kompressor W211'),(752,235,'--Missing Data--'),(753,236,'W124'),(754,236,'W212 Series I'),(755,237,'W210'),(756,238,'W211'),(757,239,'W211 Series II'),(758,240,'W210 Elegance'),(759,241,'W211'),(760,242,'AVV60R'),(761,243,'211'),(762,244,'W210'),(763,245,'--Missing Data--'),(764,246,'--Missing Data--'),(765,247,'GLS'),(766,247,'--Missing Data--'),(767,247,'SLX'),(768,248,'E51'),(769,248,'E52'),(770,249,'First Generation'),(771,250,'--Missing Data--'),(772,251,'CDX'),(773,252,'MCV20R'),(774,252,'VCV10R'),(775,253,'BA/ZA'),(776,253,'ZB'),(777,253,'ZC  XLT 3.0 Sport'),(778,254,'1.5i'),(779,256,'N13'),(780,257,'X2'),(781,257,'X3'),(782,259,'UP'),(783,259,'UT'),(784,259,'UX'),(785,259,'UZ'),(786,260,'SF/SG/SH/SJ'),(787,261,'Prime Mover'),(788,262,'Barbagallo'),(789,263,'IMS F Series'),(790,264,'RN'),(791,265,'Berlinetta'),(792,266,'--Missing Data--'),(793,267,'Spider'),(794,268,'Adventure'),(795,269,'AU'),(796,269,'BA'),(797,269,'BA II'),(798,269,'BF'),(799,269,'NA and DA LTD'),(800,269,'NC II'),(801,269,'NL'),(802,270,'AU'),(803,270,'AU Ghia'),(804,270,'BA'),(805,270,'BF'),(806,270,'BF MkII'),(807,270,'EA & EB'),(808,270,'ED'),(809,270,'EF'),(810,270,'EL'),(811,270,'XW'),(812,271,'AUI'),(813,271,'AUII'),(814,271,'AUII XR6'),(815,271,'AUII XR8'),(816,271,'AUIII XL'),(817,271,'AUIII XR6'),(818,271,'BA MkI'),(819,271,'BA MkII'),(820,271,'BA MkII Wagon'),(821,271,'BA XL'),(822,271,'BA XR6 MkII'),(823,271,'BA XR8 MkII'),(824,271,'BF MkI'),(825,271,'BF MkII'),(826,271,'BF MkII XR6'),(827,271,'BF MkII XR8'),(828,271,'BF MkIII'),(829,271,'EB Series I'),(830,271,'EB Series II'),(831,271,'ED'),(832,271,'EF Series I'),(833,271,'EF Series II'),(834,271,'EL'),(835,271,'FG G6 MkII'),(836,271,'FG G6E MkI'),(837,271,'FG XR MkI'),(838,271,'FG XR6 MkI'),(839,271,'FG XR6 MkII'),(840,271,'FG XR8 MkI'),(841,271,'FG XR8 MkII'),(842,271,'FG XT MkI'),(843,271,'FG XT MkII'),(844,271,'Futura EF'),(845,271,'XA'),(846,271,'XC'),(847,271,'XF'),(848,271,'XH'),(849,271,'XH II'),(850,271,'XW'),(851,271,'XY'),(852,272,'AU II'),(853,273,'BA MkII'),(854,273,'BF MkI Extended Cab'),(855,273,'BF MkI XL'),(856,275,'WF'),(857,276,'--Missing Data--'),(858,276,'WP'),(859,276,'WQ'),(860,276,'WT [also Festiva)'),(861,276,'WV'),(862,277,'110 Anniversary Edition'),(863,278,'--Missing Data--'),(864,279,'LR'),(865,279,'LT'),(866,279,'LV MKI'),(867,279,'LV MKII'),(868,279,'LW MKI'),(869,279,'LW MKII'),(870,279,'LZ'),(871,279,'--Missing Data--'),(872,280,'79V'),(873,280,'--Missing Data--'),(874,280,'MkII'),(875,280,'S4'),(876,280,'XT'),(877,281,'AUI'),(878,282,'X761 Prestige'),(879,283,'FG MkII'),(880,284,'BA Mk II'),(881,284,'FG MkII'),(882,285,'BF MkI Super Cab V6'),(883,286,'BF MkI Super Cab V8'),(884,287,'SY'),(885,288,'BF  F6'),(886,289,'L314'),(887,290,'Series 2 - L314'),(888,291,'MX MH'),(889,293,'--Missing Data--'),(890,294,'AUI'),(891,295,'--Missing Data--'),(892,297,'--Missing Data--'),(893,299,'HJ'),(894,300,'L140 LP550-2'),(895,301,'620 Veloce'),(896,302,'X164'),(897,303,'CDI'),(898,304,' 4Matic 9G-Tronic W166'),(899,305,'V GT'),(900,305,'V GTI'),(901,305,'V Pacific'),(902,305,'V R32'),(903,305,'VI GTI'),(904,305,'VI R'),(905,305,'VI Trendline'),(906,305,'VII'),(907,305,'VII R'),(908,306,'VQ'),(909,306,'VQ Si'),(910,307,'Laredo'),(911,307,'WH Limited'),(912,307,'WJ/WG'),(913,307,'WK II Limited'),(914,307,'WK Limited'),(915,307,'WKII Laredo'),(916,307,'WKII Limited'),(917,307,'WKII SRT'),(918,307,'ZG Laredo'),(919,308,'WJ/WG'),(920,309,'XJ'),(921,310,'JB Series II'),(922,310,'MK3'),(923,310,'Type 1'),(924,310,'XL'),(925,311,'LX'),(926,311,'RS SE'),(927,312,'BA'),(928,313,'JZS160R'),(929,314,'GWS191R'),(930,315,'R600'),(931,316,'V6 Coupe'),(932,317,'Alarm'),(933,319,'--Missing Data--'),(934,320,'Cooper S'),(935,320,'R56 LCI'),(936,321,'DT LWB'),(937,321,'Fourth Generation'),(938,321,'KDH201R DT LWB'),(939,321,'KDH221R High Roof'),(940,321,'KDH223R DT LWB'),(941,321,'--Missing Data--'),(942,322,'KZN165R'),(943,322,'RZN149R'),(944,322,'RZN165R'),(945,322,'SR GGN15R'),(946,322,'SR GGN25R'),(947,322,'SR KUN26R'),(948,322,'SR Xtra Cab 4x4 GUN126R'),(949,322,'SR Xtra Cab KUN26R'),(950,322,'SR5 GGN25R'),(951,322,'SR5 GUN126R'),(952,322,'SR5 KUN16R'),(953,322,'SR5 KUN26R'),(954,322,'SR5 LN167R'),(955,322,'TGN121R Workmate'),(956,322,'TGN16R'),(957,322,'Workmate TGN16R'),(958,323,'--Missing Data--'),(959,324,'RU - 2nd Generation'),(960,325,'Astra VXR'),(961,325,'Clubsport  R8 VE'),(962,325,'Clubsport E Series 3 R8'),(963,325,'Clubsport GEN-F2 R8'),(964,325,'Clubsport VS Series II'),(965,325,'Clubsport VT Series I'),(966,325,'Clubsport VX Series I'),(967,325,'Clubsport VY Series I'),(968,325,'Clubsport VY Series II'),(969,325,'Clubsport VZ Series I'),(970,325,'Grange VE'),(971,325,'Grange WH'),(972,325,'GTO VX Series I'),(973,325,'GTO VZ Series I'),(974,325,'GTS E Series 1'),(975,325,'GTS E Series 3'),(976,325,'GTS Gen-F'),(977,325,'GTS VE'),(978,325,'GTS VE Series II Sportswagon'),(979,325,'GTS VX Series I'),(980,325,'GTS-R'),(981,325,'Maloo VE'),(982,325,'Maloo VU Series II'),(983,325,'Maloo VY Series I'),(984,325,'Maloo VY Series II'),(985,325,'Maloo VZ Series I'),(986,325,'Monaro CV8 VZ Series I'),(987,325,'R8267 VE'),(988,325,'Senator VE'),(989,325,'Senator VS Series II'),(990,325,'Senator VT Series II'),(991,325,'Senator VX Series I'),(992,325,'Senator VY Series II'),(993,325,'Senator VZ Series I'),(994,325,'VF  Series II Maloo'),(995,326,'VP Series II'),(996,327,'FD SLX'),(997,327,'GD Active'),(998,328,'GL'),(999,329,'TQ3-V Series II'),(1000,329,'TQ-V'),(1001,330,'TQ-W'),(1002,332,'4 Gen'),(1003,332,'GD RX'),(1004,332,'GX'),(1005,332,'--Missing Data--'),(1006,332,'RS G3 Sedan'),(1007,332,'RX 55N'),(1008,332,'RX G3'),(1009,332,'WRX'),(1010,332,'WRX G3 Hatch'),(1011,332,'WRX G3 Sedan'),(1012,332,'WRX S'),(1013,332,'WRX S Sti'),(1014,332,'WRX STI'),(1015,332,'WRX STI G3'),(1016,332,'WRX STI G3 Spec R'),(1017,332,'WRX V1 STI'),(1018,334,'Mk2'),(1019,334,'Mk3'),(1020,334,'Mk4'),(1021,334,'Mk4 Series II'),(1022,334,'Type R'),(1023,335,'USE20R'),(1024,336,'GXE10R'),(1025,337,'GSE20R'),(1026,337,'GSE20R Mk2'),(1027,337,'GSE20R Series I'),(1028,338,'JCE10R'),(1029,339,'LM Active Wagon'),(1030,339,'LM Elite Wagon'),(1031,339,'LM Highlander Wagon'),(1032,339,'LM SE Wagon'),(1033,340,'U8'),(1034,341,'GD'),(1035,341,'GD Series II'),(1036,341,'Vti-S GE Mk2'),(1037,342,'--Missing Data--'),(1038,343,'JB43'),(1039,344,'JC'),(1040,345,'Ti-S F15 Series II'),(1041,347,'--Missing Data--'),(1042,348,'X76'),(1043,349,'HJ'),(1044,350,'FR'),(1045,351,'GSU40R'),(1046,351,'GSU45R KX-R'),(1047,351,'GSU50R GX'),(1048,351,'MCU28R CV'),(1049,351,'MCU28R CV Sport'),(1050,351,'MCU28R CVX'),(1051,351,'MCU28R Grande'),(1052,352,'--Missing Data--'),(1053,353,'2006 4x4 Xdi Wagon 5dr  2.7 Diesel'),(1054,353,'--Missing Data--'),(1055,354,'Mark II'),(1056,356,'CB & CC'),(1057,356,'CE & CE series II'),(1058,356,'CG'),(1059,356,'CH'),(1060,356,'CH Evolution'),(1061,356,'CJ'),(1062,356,'CJ ES Sportback'),(1063,356,'CJ Ralliart Evo 10 MR'),(1064,356,'CJ VR'),(1065,356,'CJ VR Sportback CVT'),(1066,356,'CJ XLS'),(1067,356,'CT9A EVOLUTION VII'),(1068,356,'CX4A'),(1069,356,'Evolution'),(1070,356,'Evolution VII'),(1071,356,'Evolution VIII'),(1072,357,'80 Series'),(1073,357,'FZJ105R'),(1074,357,'HDJ79R'),(1075,357,'HDJ80R GXL'),(1076,357,'HZJ105R GXL'),(1077,357,'HZJ105R Series II'),(1078,357,'HZJ75RP'),(1079,357,'UZJ100R'),(1080,357,'UZJ200R GXL'),(1081,357,'VDJ200R GXL'),(1082,357,'VDJ200R Sahara'),(1083,357,'VDJ200R VX'),(1084,357,'VDJ76R'),(1085,357,'VDJ78R'),(1086,357,'VDJ78R GXL Troopcarrier'),(1087,357,'VDJ79R'),(1088,357,'VDJ79R   GXL Wagon'),(1089,357,'VDJ79R GXL'),(1090,358,'90 Series'),(1091,358,'GDJ150R'),(1092,358,'GRJ120R'),(1093,358,'GRJ120R Grande or VX'),(1094,358,'GRJ150R'),(1095,358,'GX KDJ120R 1KD'),(1096,358,'GXL KDJ120R 1KD'),(1097,358,'KDJ150R'),(1098,358,'KZJ120R'),(1099,358,'VZJ95R Mk I'),(1100,359,'Series I'),(1101,359,'Series II'),(1102,360,'GL'),(1103,360,'J2'),(1104,360,'--Missing Data--'),(1105,361,'KC'),(1106,361,'KF'),(1107,361,'KJ Series III'),(1108,361,'KN'),(1109,362,'V100 Series I'),(1110,363,'Csi'),(1111,363,'--Missing Data--'),(1112,364,'GS'),(1113,365,'2 GEN'),(1114,365,'3 GEN'),(1115,365,'3 GEN RX'),(1116,365,'4 GEN BL'),(1117,509,'Life'),(1118,509,'--Missing Data--'),(1119,510,'VQ HX'),(1120,510,'VR Series I'),(1121,510,'VS Series III'),(1122,510,'WH'),(1123,510,'WL'),(1124,510,'WM'),(1125,511,'A100'),(1126,512,'IMPORT'),(1127,513,'K8'),(1128,514,'AZ'),(1129,514,'Cino'),(1130,514,'EZ'),(1131,514,'Gti'),(1132,517,'ACR30R'),(1133,517,'ACR50R'),(1134,517,'TCR10/11/20/21'),(1135,517,'TCR10/11/20/21 Series II'),(1136,518,'DN'),(1137,519,'AX'),(1138,520,'J100 Series I'),(1139,520,'J102 Series II'),(1140,521,'HP'),(1141,522,'SX'),(1142,522,'SY Series I'),(1143,522,'SY Series II'),(1144,522,'SZ Series I'),(1145,522,'SZ Series II'),(1146,523,'VE Series II SV6'),(1147,524,'GK'),(1148,525,'XC'),(1149,527,'C11'),(1150,529,'--Missing Data--'),(1151,530,'--Missing Data--'),(1152,531,'X83   VF1FL VF1JL'),(1153,532,'GL'),(1154,533,'--Missing Data--'),(1155,534,'VM LWB High Roof'),(1156,534,'VM SWB Low Roof'),(1157,535,'T4'),(1158,535,'T5'),(1159,535,'T5 Van'),(1160,535,'T6'),(1161,536,'B9'),(1162,538,'MJ'),(1163,538,'MK'),(1164,538,'MK K66T'),(1165,538,'MK KB8T'),(1166,538,'ML - Diesel'),(1167,538,'ML - Petrol'),(1168,538,'MN'),(1169,538,'MN Diesel'),(1170,538,'MQ Diesel'),(1171,539,'--Missing Data--'),(1172,540,'8J'),(1173,540,'8N'),(1174,542,'P201'),(1175,544,'K2 Utility Dual Cab'),(1176,545,'K2'),(1177,546,'Phase 2'),(1178,547,'Cross Country'),(1179,547,'--Missing Data--'),(1180,548,'JR CD'),(1181,548,'JS II'),(1182,548,'ZC CD'),(1183,549,'FS'),(1184,549,'FS2'),(1185,549,'FS2 SR Turbo'),(1186,550,'KE'),(1187,550,'KF'),(1188,550,'KH'),(1189,550,'KJ'),(1190,550,'KR'),(1191,551,'2.2 Cdi Ambiente'),(1192,551,'W639'),(1193,552,'MCV20R'),(1194,552,'XV10'),(1195,553,'1.5'),(1196,553,'RT-S'),(1197,553,'S Turbo LY'),(1198,554,'W639'),(1199,555,'JF'),(1200,557,'VRSCA'),(1201,557,'VRSCAW A'),(1202,558,'VRSCF'),(1203,559,'--Missing Data--'),(1204,560,'CF'),(1205,561,'--Missing Data--'),(1206,562,'--Missing Data--'),(1207,563,'JK'),(1208,563,'TJ'),(1209,563,'TJ Renegade'),(1210,564,'E84 SDRIVE 20D'),(1211,565,'Wagon'),(1212,566,'X-Class 470'),(1213,567,'E83'),(1214,567,'xDRIVE30D F25'),(1215,568,'xDrive20D F26'),(1216,569,'E53  Series I'),(1217,569,'E53 IS Series II'),(1218,569,'E53 Series II'),(1219,569,'E70'),(1220,569,'E70 xDrive35i'),(1221,569,'sDrive25d F15'),(1222,569,'xDrive50i E70'),(1223,570,'E70'),(1224,571,'E71 xDrive35D'),(1225,571,'E71 xDrive35i'),(1226,571,'E71 xDrive50i'),(1227,572,'Luxury AWD'),(1228,573,'--Missing Data--'),(1229,574,'Cross Country'),(1230,574,'Series I'),(1231,574,'Series II'),(1232,575,'--Missing Data--'),(1233,576,'X300 Series I'),(1234,577,'1200'),(1235,578,'Forty-Eight Sportster'),(1236,579,'STL T32 Series I'),(1237,579,'T30'),(1238,579,'T30 II'),(1239,580,'X400'),(1240,581,'W8'),(1241,582,'G4-X'),(1242,583,'NCP131R YRS'),(1243,583,'NCP90R YR'),(1244,583,'NCP93R YRS'),(1245,583,'NCP93R YRX'),(1246,584,'E36-7 Series I'),(1247,585,'E85'),(1248,586,'TT'),(1249,587,'--Missing Data--'),(1250,588,'Ninja'),(1251,590,'Ninja');
/*!40000 ALTER TABLE `vehiclevariant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `years`
--

DROP TABLE IF EXISTS `years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `years` (
  `Year` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Year`)
) ENGINE=InnoDB AUTO_INCREMENT=2026 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `years`
--

LOCK TABLES `years` WRITE;
/*!40000 ALTER TABLE `years` DISABLE KEYS */;
INSERT INTO `years` VALUES (1900),(1901),(1902),(1903),(1904),(1905),(1906),(1907),(1908),(1909),(1910),(1911),(1912),(1913),(1914),(1915),(1916),(1917),(1918),(1919),(1920),(1921),(1922),(1923),(1924),(1925),(1926),(1927),(1928),(1929),(1930),(1931),(1932),(1933),(1934),(1935),(1936),(1937),(1938),(1939),(1940),(1941),(1942),(1943),(1944),(1945),(1946),(1947),(1948),(1949),(1950),(1951),(1952),(1953),(1954),(1955),(1956),(1957),(1958),(1959),(1960),(1961),(1962),(1963),(1964),(1965),(1966),(1967),(1968),(1969),(1970),(1971),(1972),(1973),(1974),(1975),(1976),(1977),(1978),(1979),(1980),(1981),(1982),(1983),(1984),(1985),(1986),(1987),(1988),(1989),(1990),(1991),(1992),(1993),(1994),(1995),(1996),(1997),(1998),(1999),(2000),(2001),(2002),(2003),(2004),(2005),(2006),(2007),(2008),(2009),(2010),(2011),(2012),(2013),(2014),(2015),(2016),(2017),(2018),(2019),(2020),(2021),(2022),(2023),(2024),(2025);
/*!40000 ALTER TABLE `years` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'autoclub'
--

--
-- Dumping routines for database 'autoclub'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-25 15:51:39
