USE `autoclub`;

DELIMITER $$

DROP TRIGGER IF EXISTS autoclub.LogMemberChanges$$
USE `autoclub`$$
CREATE TRIGGER `LogMemberChanges` AFTER UPDATE ON `members` FOR EACH ROW BEGIN


if NEW.Surname <> OLD.Surname THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.Surname,NEW.Surname);
end if;

if NEW.MiddleNames <> OLD.MiddleNames THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.MiddleNames,NEW.MiddleNames);
end if;

if NEW.FirstName <> OLD.FirstName THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.FirstName,NEW.FirstName);
end if;

if NEW.DOB <> OLD.DOB  THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.DOB ,NEW.DOB );
end if;

if NEW.PhotoPath <> OLD.PhotoPath THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.PhotoPath,NEW.PhotoPath);
end if;

if NEW.SigPath <> OLD.SigPath THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.SigPath,NEW.SigPath);
end if;

if NEW.Active <> OLD.Active THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.Active,NEW.Active);
end if;

if NEW.JoinDate <> OLD.JoinDate THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.JoinDate,NEW.JoinDate);
end if;

if NEW.InactiveDate <> OLD.InactiveDate THEN
	INSERT INTO `logging_database`.`changelog` (`Database`, `TableName`, `PKValue`, `OldValue`, `NewValue`)
	VALUES ('autoclub', 'Members',OLD.ID, OLD.InactiveDate,NEW.InactiveDate);
end if;


END $$
DELIMITER ;