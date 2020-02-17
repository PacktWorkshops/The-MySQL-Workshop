DELIMITER $$

DROP TRIGGER IF EXISTS autoclub.CheckMemberAge$$
USE `autoclub`$$
CREATE  TRIGGER `CheckMemberAge` BEFORE UPDATE ON `members` FOR EACH ROW BEGIN

	declare msg varchar(128);
    
	SET @MinAge = (SELECT `Value` FROM LOOKUPS WHERE `KEY`='MinMemberAge');
    
	if NEW.dob > (SELECT DATE_SUB(curdate(), interval @MinAge year)) THEN
        set msg = concat('MyTriggerError: Minimum member age is: ', @MinAge);
        signal sqlstate '45000' set message_text = msg;		
    end if;

END$$
DELIMITER ;
