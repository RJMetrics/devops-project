CREATE TABLE testdb.Users 
( 
    FirstName VARCHAR(32) NOT NULL, 
    LastName  VARCHAR(40) NOT NULL, 
    Age       INT(3) NOT NULL, 
    CreatedAtTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (LastName, FirstName) 
);