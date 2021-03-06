START TRANSACTION
;

CREATE TABLE IF NOT EXISTS test (
	this int NOT NULL,
	`is` varchar(1) NULL,
	a varchar(1) NULL,
 	CONSTRAINT PK_test PRIMARY KEY CLUSTERED (this)
)
;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/test.csv'
INTO TABLE test
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

COMMIT;