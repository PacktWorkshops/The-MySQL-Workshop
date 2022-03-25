USE `autoclub`;

DELIMITER $$

DROP TRIGGER IF EXISTS autoclub.LogMemberShipFeePayments$$
USE `autoclub`$$
CREATE  TRIGGER `LogMemberShipFeePayments` AFTER INSERT ON `MemberShipFees` FOR EACH ROW 
BEGIN

	INSERT INTO `logging_database`.`membershipfee_payments` (MemberID, FeeAmount, DatePaid)
	VALUES (new.MemberID, new.FeeAmount, new.DatePaid);

END $$
DELIMITER ;
