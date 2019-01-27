CREATE TABLE testdb.Users 
( 
    Firstname VARCHAR(32) NOT NULL, 
    Lastname  VARCHAR(40) NOT NULL, 
    Age       INT(3) NOT NULL, 
    CreatedAtTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (Lastname, Firstname) 
);