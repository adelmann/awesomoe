CREATE TABLE IF NOT EXISTS `awcompanys` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awname` varchar(50),
  `awmail` varchar(50) NOT NULL,
  `awphone` varchar(20),
  `awmobile` varchar(20),
  `awzip` int(10),
  `awcity` varchar(20),
  `awstreet` varchar(50) NOT NULL,
  `awcountry` int(2) NOT NULL,
  `awavatar` varchar(255),
  `awurl` varchar(255),
  `awadded` date NOT NULL,
  `awupdate` date NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;