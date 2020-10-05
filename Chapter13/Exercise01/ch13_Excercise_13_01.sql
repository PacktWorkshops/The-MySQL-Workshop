--disable_warnings
DROP SCHEMA IF EXISTS coffeeprefs;
--enable_warnings

CREATE SCHEMA coffeeprefs;
USE coffeeprefs;

CREATE TABLE coffeeprefs (
  name VARCHAR(255),
  preference VARCHAR(255),
  PRIMARY KEY(name)
);

INSERT INTO coffeeprefs VALUES
("John", "Capuchino"),
("Sue", "Cortado"),
("Peter", "Flat White");
