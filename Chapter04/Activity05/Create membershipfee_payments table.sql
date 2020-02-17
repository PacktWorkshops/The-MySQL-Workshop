CREATE TABLE `logging_database`.`membershipfee_payments` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `MemberID` INT NOT NULL,
  `FeeAmount` DECIMAL(10,2) NOT NULL,
  `DatePaid` DATE NOT NULL,
  PRIMARY KEY (`ID`));
