CREATE TABLE `Users` (
`FirstName` varchar(24) NOT NULL default '',
`LastName` varchar(24) NOT NULL default '',
`Age` int(3) NOT NULL default 1,
`CreatedAtTimestamp` timestamp default CURRENT_TIMESTAMP
);
-- 
-- Dumping data for table `apps_countries`
-- 
INSERT INTO `Users` VALUES ('John', 'Doe', '44', '2018-01-03 04:30:43');
INSERT INTO `Users` VALUES ('Jane', 'Doe', '46', '2018-02-03 07:33:43');
INSERT INTO `Users` VALUES ('Rusty', 'Joe', '23', '2018-03-03 08:30:43');
INSERT INTO `Users` VALUES ('Barb', 'Be', '29', '2018-03-09 09:30:33');
INSERT INTO `Users` VALUES ('Al', 'mond', '63', '2018-11-03 04:30:43');