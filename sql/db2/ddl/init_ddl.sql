START TRANSACTION
;

CREATE SCHEMA IF NOT EXISTS test_schema;

CREATE TABLE IF NOT EXISTS test_schema.test (
	this int NOT NULL,
	`is` varchar(1) NULL,
	a varchar(1) NULL,
 	CONSTRAINT PK_test PRIMARY KEY CLUSTERED (this)
)
;

COPY test_schema.test
FROM '/docker-entrypoint-initdb.d/test.csv'
DELIMITER ','
CSV HEADER;

COMMIT;