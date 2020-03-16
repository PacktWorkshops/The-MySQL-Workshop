create database cli_activity;


show databases;	



use cli_activity;




CREATE TABLE `cli_activity`.`courses` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`));



INSERT INTO `Courses` (`CourseName`) values ('The MySQ Workshop');




select * from courses;