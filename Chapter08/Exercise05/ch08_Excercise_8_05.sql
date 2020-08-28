USE test;

CREATE TABLE furniture (
  id INT PRIMARY KEY,
  description VARCHAR(255),
  room VARCHAR(255)
);

INSERT INTO furniture VALUES
(1, 'couch', 'living room'),
(2, 'bed', 'bedroom'),
(3, 'small table', 'kitchen');

--error 1062
INSERT INTO furniture VALUES
(4, 'bed', 'second bedroom'),
(1, 'table', 'second bedroom');

SELECT * FROM furniture;
