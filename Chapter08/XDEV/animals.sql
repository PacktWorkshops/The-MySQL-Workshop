USE test;

DROP TABLE animals;

CREATE TABLE animals (
  id int(11) NOT NULL,
  name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE animals_collection (
  doc json DEFAULT NULL,
  _id varbinary(32) GENERATED ALWAYS AS (json_unquote(json_extract(`doc`,_utf8mb4'$._id'))) STORED NOT NULL,
  PRIMARY KEY (`_id`)
);
INSERT INTO animals VALUES (1,'dog'),(2,'Camel'),(3,NULL);

INSERT INTO animals_collection (`doc`) VALUES ('{\"_id\": 1, \"name\": \"monkey\"}'),('{\"_id\": 2, \"name\": \"zebra\"}'),('{\"_id\": 3, \"name\": \"lion\"}');
