DROP SCHEMA IF EXISTS `logging_database`;

CREATE DATABASE `logging_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `logging_database`.`changelog` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Database` VARCHAR(45) NOT NULL,
    `TableName` VARCHAR(45) NOT NULL,
    `OldValue` VARCHAR(255) NOT NULL,
    `NewValue` VARCHAR(255) NOT NULL,
    `WhenLogged` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ID`)
);