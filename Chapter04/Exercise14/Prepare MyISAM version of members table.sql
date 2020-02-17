USE `autoclub`;

-- Copy the members table to members_MyISAM
DROP TABLE IF EXISTS autoclub.members_MyISAM;
CREATE TABLE IF NOT EXISTS members_MyISAM SELECT * FROM
    members;

-- Set the Primary Key field and the Auto Increment properies on ID
ALTER TABLE `autoclub`.`members_MyISAM` 
CHANGE COLUMN `ID` `ID` INT(11) NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`ID`);

-- Change the tables engine to MyISAM so we can test it    
ALTER TABLE `autoclub`.`members_MyISAM` 
ENGINE = MyISAM ;    

-- Create the trigger for members_MyISAM
DELIMITER $$
DROP TRIGGER IF EXISTS autoclub.CheckMemberAge_MyISAM$$
USE `autoclub`$$
CREATE  TRIGGER `CheckMemberAge_MyISAM` BEFORE UPDATE ON `members_MyISAM` FOR EACH ROW BEGIN

	declare msg varchar(128);
    
	SET @MinAge = (SELECT `Value` FROM LOOKUPS WHERE `KEY`='MinMemberAge');
    
	if NEW.dob > (SELECT DATE_SUB(curdate(), interval @MinAge year)) THEN
        	set msg = concat('MyTriggerError: Minimum member age is: ', @MinAge);
        	signal sqlstate '45000' set message_text = msg;		
    	end if;

END$$



DROP TRIGGER IF EXISTS autoclub.LogMemberChanges_MyISAM$$
CREATE TRIGGER `LogMemberChanges_MyISAM` AFTER UPDATE ON `members_MyISAM` FOR EACH ROW BEGIN


if NEW.Surname <> OLD.Surname THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.Surname,NEW.Surname);
end if;

if NEW.MiddleNames <> OLD.MiddleNames THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.MiddleNames,NEW.MiddleNames);
end if;

if NEW.FirstName <> OLD.FirstName THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.FirstName,NEW.FirstName);
end if;

if NEW.DOB <> OLD.DOB  THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.DOB ,NEW.DOB );
end if;

if NEW.PhotoPath <> OLD.PhotoPath THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.PhotoPath,NEW.PhotoPath);
end if;

if NEW.SigPath <> OLD.SigPath THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.SigPath,NEW.SigPath);
end if;

if NEW.Active <> OLD.Active THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.Active,NEW.Active);
end if;

if NEW.JoinDate <> OLD.JoinDate THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.JoinDate,NEW.JoinDate);
end if;

if NEW.InactiveDate <> OLD.InactiveDate THEN
INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
VALUES ('autoclub', 'Members_MyISAM',OLD.ID, OLD.InactiveDate,NEW.InactiveDate);
end if;

END $$
DELIMITER ;

