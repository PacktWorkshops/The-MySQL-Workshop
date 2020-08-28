USE test;

CREATE TABLE airports (
  iata_code CHAR(3) PRIMARY KEY,
  location VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  passengers INT NOT NULL
);

INSERT INTO airports VALUES
('ATL', 'Atlanta, Georgia', 'United States', 54388000),
('PEK', 'Chaoyang-Shunyi, Beijing', 'China', 49242000),
('LAX', 'Los Angeles, California', 'United States', 43049000),
('HND', 'Ōta, Tokyo', 'Japan', 41435000),
('DBX', 'Garhoud, Dubai', 'United Arab Emirates', 41278000);

SELECT * FROM airports;

SELECT * FROM airports ORDER BY passengers DESC;

