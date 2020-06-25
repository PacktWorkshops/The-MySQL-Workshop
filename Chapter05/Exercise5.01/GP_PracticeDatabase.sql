CREATE DATABASE  IF NOT EXISTS `backuppractice` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `backuppractice`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 192.168.0.3    Database: backuppractice
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
-- Table structure for table `continents`
--

DROP TABLE IF EXISTS `continents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continents` (
  `ContinentID` int(11) NOT NULL AUTO_INCREMENT,
  `Continent` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`ContinentID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continents`
--

LOCK TABLES `continents` WRITE;
/*!40000 ALTER TABLE `continents` DISABLE KEYS */;
INSERT INTO `continents` VALUES (1,'Africa'),(2,'Asia'),(3,'Europe'),(4,'North America'),(5,'Oceania'),(6,'South America');
/*!40000 ALTER TABLE `continents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `CountryID` int(11) NOT NULL AUTO_INCREMENT,
  `Country Code` varchar(5) DEFAULT NULL,
  `Country Name` varchar(50) DEFAULT NULL,
  `ContinentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`CountryID`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'ABW','Aruba',4),(2,'AFG','Afghanistan',2),(3,'AGO','Angola',1),(4,'ALB','Albania',3),(5,'AND','Andorra',3),(6,'ARB','Arab World',NULL),(7,'ARE','United Arab Emirates',2),(8,'ARG','Argentina',6),(9,'ARM','Armenia',2),(10,'ASM','American Samoa',5),(11,'ATG','Antigua and Barbuda',4),(12,'AUS','Australia',5),(13,'AUT','Austria',3),(14,'AZE','Azerbaijan',2),(15,'BDI','Burundi',1),(16,'BEL','Belgium',3),(17,'BEN','Benin',1),(18,'BFA','Burkina Faso',1),(19,'BGD','Bangladesh',2),(20,'BGR','Bulgaria',3),(21,'BHR','Bahrain',2),(22,'BHS','Bahamas, The',4),(23,'BIH','Bosnia and Herzegovina',3),(24,'BLR','Belarus',3),(25,'BLZ','Belize',4),(26,'BMU','Bermuda',4),(27,'BOL','Bolivia',6),(28,'BRA','Brazil',6),(29,'BRB','Barbados',4),(30,'BRN','Brunei Darussalam',2),(31,'BTN','Bhutan',2),(32,'BWA','Botswana',1),(33,'CAF','Central African Republic',1),(34,'CAN','Canada',4),(35,'CEB','Central Europe and the Baltics',NULL),(36,'CHE','Switzerland',3),(37,'CHI','Channel Islands',NULL),(38,'CHL','Chile',6),(39,'CHN','China',2),(40,'CIV','Cote d\'Ivoire',1),(41,'CMR','Cameroon',1),(42,'COD','Congo, Dem. Rep.',1),(43,'COG','Congo, Rep.',1),(44,'COL','Colombia',6),(45,'COM','Comoros',1),(46,'CPV','Cabo Verde',1),(47,'CRI','Costa Rica',4),(48,'CSS','Caribbean small states',NULL),(49,'CUB','Cuba',4),(50,'CUW','Curacao',NULL),(51,'CYM','Cayman Islands',4),(52,'CYP','Cyprus',2),(53,'CZE','Czech Republic',3),(54,'DEU','Germany',3),(55,'DJI','Djibouti',1),(56,'DMA','Dominica',4),(57,'DNK','Denmark',3),(58,'DOM','Dominican Republic',4),(59,'DZA','Algeria',1),(60,'EAP','East Asia & Pacific (excluding high income)',NULL),(61,'EAR','Early-demographic dividend',NULL),(62,'EAS','East Asia & Pacific',NULL),(63,'ECA','Europe & Central Asia (excluding high income)',NULL),(64,'ECS','Europe & Central Asia',NULL),(65,'ECU','Ecuador',6),(66,'EGY','Egypt, Arab Rep.',1),(67,'EMU','Euro area',NULL),(68,'ERI','Eritrea',1),(69,'ESP','Spain',3),(70,'EST','Estonia',3),(71,'ETH','Ethiopia',1),(72,'EUU','European Union',NULL),(73,'FCS','Fragile and conflict affected situations',NULL),(74,'FIN','Finland',3),(75,'FJI','Fiji',5),(76,'FRA','France',3),(77,'FRO','Faroe Islands',3),(78,'FSM','Micronesia, Fed. Sts.',5),(79,'GAB','Gabon',1),(80,'GBR','United Kingdom',3),(81,'GEO','Georgia',2),(82,'GHA','Ghana',1),(83,'GIB','Gibraltar',3),(84,'GIN','Guinea',1),(85,'GMB','Gambia, The',1),(86,'GNB','Guinea-Bissau',1),(87,'GNQ','Equatorial Guinea',1),(88,'GRC','Greece',3),(89,'GRD','Grenada',4),(90,'GRL','Greenland',4),(91,'GTM','Guatemala',4),(92,'GUM','Guam',5),(93,'GUY','Guyana',6),(94,'HIC','High income',NULL),(95,'HKG','Hong Kong SAR, China',2),(96,'HND','Honduras',4),(97,'HPC','Heavily indebted poor countries (HIPC)',NULL),(98,'HRV','Croatia',3),(99,'HTI','Haiti',4),(100,'HUN','Hungary',3),(101,'IBD','IBRD only',NULL),(102,'IBT','IDA & IBRD total',NULL),(103,'IDA','IDA total',NULL),(104,'IDB','IDA blend',NULL),(105,'IDN','Indonesia',2),(106,'IDX','IDA only',NULL),(107,'IMN','Isle of Man',NULL),(108,'IND','India',2),(109,'IRL','Ireland',3),(110,'IRN','Iran, Islamic Rep.',2),(111,'IRQ','Iraq',2),(112,'ISL','Iceland',3),(113,'ISR','Israel',2),(114,'ITA','Italy',3),(115,'JAM','Jamaica',4),(116,'JOR','Jordan',2),(117,'JPN','Japan',2),(118,'KAZ','Kazakhstan',2),(119,'KEN','Kenya',1),(120,'KGZ','Kyrgyz Republic',2),(121,'KHM','Cambodia',2),(122,'KIR','Kiribati',5),(123,'KNA','St. Kitts and Nevis',4),(124,'KOR','Korea, Rep.',2),(125,'KWT','Kuwait',2),(126,'LAC','Latin America & Caribbean (excluding high income)',NULL),(127,'LAO','Lao PDR',2),(128,'LBN','Lebanon',2),(129,'LBR','Liberia',1),(130,'LBY','Libya',1),(131,'LCA','St. Lucia',4),(132,'LCN','Latin America & Caribbean',NULL),(133,'LDC','Least developed countries: UN classification',NULL),(134,'LIC','Low income',NULL),(135,'LIE','Liechtenstein',3),(136,'LKA','Sri Lanka',2),(137,'LMC','Lower middle income',NULL),(138,'LMY','Low & middle income',NULL),(139,'LSO','Lesotho',1),(140,'LTE','Late-demographic dividend',NULL),(141,'LTU','Lithuania',3),(142,'LUX','Luxembourg',3),(143,'LVA','Latvia',3),(144,'MAC','Macao SAR, China',2),(145,'MAF','St. Martin (French part)',NULL),(146,'MAR','Morocco',1),(147,'MCO','Monaco',3),(148,'MDA','Moldova',3),(149,'MDG','Madagascar',1),(150,'MDV','Maldives',2),(151,'MEA','Middle East & North Africa',NULL),(152,'MEX','Mexico',4),(153,'MHL','Marshall Islands',5),(154,'MIC','Middle income',NULL),(155,'MKD','Macedonia, FYR',3),(156,'MLI','Mali',1),(157,'MLT','Malta',3),(158,'MMR','Myanmar',2),(159,'MNA','Middle East & North Africa (excluding high income)',NULL),(160,'MNE','Montenegro',NULL),(161,'MNG','Mongolia',2),(162,'MNP','Northern Mariana Islands',5),(163,'MOZ','Mozambique',1),(164,'MRT','Mauritania',1),(165,'MUS','Mauritius',1),(166,'MWI','Malawi',1),(167,'MYS','Malaysia',2),(168,'NAC','North America',NULL),(169,'NAM','Namibia',1),(170,'NCL','New Caledonia',5),(171,'NER','Niger',1),(172,'NGA','Nigeria',1),(173,'NIC','Nicaragua',4),(174,'NLD','Netherlands',3),(175,'NOR','Norway',3),(176,'NPL','Nepal',2),(177,'NRU','Nauru',5),(178,'NZL','New Zealand',5),(179,'OED','OECD members',NULL),(180,'OMN','Oman',2),(181,'OSS','Other small states',NULL),(182,'PAK','Pakistan',2),(183,'PAN','Panama',4),(184,'PER','Peru',6),(185,'PHL','Philippines',2),(186,'PLW','Palau',5),(187,'PNG','Papua New Guinea',5),(188,'POL','Poland',3),(189,'PRE','Pre-demographic dividend',NULL),(190,'PRI','Puerto Rico',4),(191,'PRK','Korea, Dem. People\'s Rep.',2),(192,'PRT','Portugal',3),(193,'PRY','Paraguay',6),(194,'PSE','West Bank and Gaza',2),(195,'PSS','Pacific island small states',NULL),(196,'PST','Post-demographic dividend',NULL),(197,'PYF','French Polynesia',5),(198,'QAT','Qatar',2),(199,'ROU','Romania',NULL),(200,'RUS','Russian Federation',3),(201,'RWA','Rwanda',1),(202,'SAS','South Asia',NULL),(203,'SAU','Saudi Arabia',2),(204,'SDN','Sudan',1),(205,'SEN','Senegal',1),(206,'SGP','Singapore',2),(207,'SLB','Solomon Islands',5),(208,'SLE','Sierra Leone',1),(209,'SLV','El Salvador',4),(210,'SMR','San Marino',3),(211,'SOM','Somalia',1),(212,'SRB','Serbia',NULL),(213,'SSA','Sub-Saharan Africa (excluding high income)',NULL),(214,'SSD','South Sudan',NULL),(215,'SSF','Sub-Saharan Africa',NULL),(216,'SST','Small states',NULL),(217,'STP','Sao Tome and Principe',1),(218,'SUR','Suriname',6),(219,'SVK','Slovak Republic',3),(220,'SVN','Slovenia',3),(221,'SWE','Sweden',3),(222,'SWZ','Eswatini',1),(223,'SXM','Sint Maarten (Dutch part)',NULL),(224,'SYC','Seychelles',1),(225,'SYR','Syrian Arab Republic',2),(226,'TCA','Turks and Caicos Islands',4),(227,'TCD','Chad',1),(228,'TEA','East Asia & Pacific (IDA & IBRD)',NULL),(229,'TEC','Europe & Central Asia (IDA & IBRD)',NULL),(230,'TGO','Togo',1),(231,'THA','Thailand',2),(232,'TJK','Tajikistan',2),(233,'TKM','Turkmenistan',2),(234,'TLA','Latin America & Caribbean (IDA & IBRD)',NULL),(235,'TLS','Timor-Leste',NULL),(236,'TMN','Middle East & North Africa (IDA & IBRD)',NULL),(237,'TON','Tonga',5),(238,'TSA','South Asia (IDA & IBRD)',NULL),(239,'TSS','Sub-Saharan Africa (IDA & IBRD)',NULL),(240,'TTO','Trinidad and Tobago',4),(241,'TUN','Tunisia',1),(242,'TUR','Turkey',2),(243,'TUV','Tuvalu',5),(244,'TZA','Tanzania',1),(245,'UGA','Uganda',1),(246,'UKR','Ukraine',3),(247,'UMC','Upper middle income',NULL),(248,'URY','Uruguay',6),(249,'USA','United States',4),(250,'UZB','Uzbekistan',2),(251,'VCT','St. Vincent and the Grenadines',4),(252,'VEN','Venezuela, RB',6),(253,'VGB','British Virgin Islands',4),(254,'VIR','Virgin Islands (U.S.)',4),(255,'VNM','Vietnam',2),(256,'VUT','Vanuatu',5),(257,'WLD','World',NULL),(258,'WSM','Samoa',5),(259,'XKX','Kosovo',NULL),(260,'YEM','Yemen, Rep.',2),(261,'ZAF','South Africa',1),(262,'ZMB','Zambia',1),(263,'ZWE','Zimbabwe',1);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-26 18:21:26
