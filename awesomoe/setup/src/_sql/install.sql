CREATE TABLE IF NOT EXISTS `awcomments` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awprojectid` int(11) NOT NULL,
  `awtaskid` int(11) NOT NULL,
  `awdesc` text NOT NULL,
  `awdate` datetime NOT NULL,
  `awuser` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
CREATE TABLE IF NOT EXISTS `awconfig` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awvarname` varchar(255) NOT NULL,
  `awvartype` varchar(4) NOT NULL,
  `awvarvalue` varchar(255) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awgroups` (
  `awid` int(10) NOT NULL AUTO_INCREMENT,
  `awname` char(10) NOT NULL,
  `awproject` char(10) NOT NULL COMMENT 'add,edit,delete,finnish',
  `awtask` char(10) NOT NULL,
  `awtrack` char(10) NOT NULL,
  `awfiles` char(10) NOT NULL,
  `awadmin` int(1) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awhistory` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awtype` varchar(20) NOT NULL,
  `awfield` char(20) NOT NULL,
  `awpreval` text NOT NULL,
  `awafterval` text NOT NULL,
  `awdate` datetime NOT NULL,
  `awuser` int(11) NOT NULL,
  `awprojectid` int(11) NOT NULL,
  `awtaskid` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awmedia` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awproject` int(11) NOT NULL,
  `awtask` int(11) NOT NULL,
  `awfilename` varchar(255) NOT NULL,
  `awnewfilename` varchar(255) NOT NULL,
  `awuserid` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awnotifications` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awuserid` int(11) NOT NULL,
  `awchanginguser` int(11) NOT NULL,
  `awprojectid` int(11) NOT NULL,
  `awtaskid` int(11) NOT NULL,
  `awtype` int(11) NOT NULL,
  `awdatetime` datetime NOT NULL,
  `awisread` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awprio` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awname` varchar(255) NOT NULL,
  `awsort` int(11) NOT NULL,
  `awcolor` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awprojects` (
  `awid` int(255) NOT NULL AUTO_INCREMENT,
  `awname` varchar(255) NOT NULL,
  `awdescription` text NOT NULL,
  `awprefix` char(25) NOT NULL,
  `awpicture` varchar(255),
  `awleader` int(11) NOT NULL DEFAULT '1',
  `awurl` varchar(255),
  `awworkflow` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awreports` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awproject` int(11) NOT NULL,
  `awbegins` date NOT NULL,
  `awends` date NOT NULL,
  `awstates` varchar(255) NOT NULL,
  `awusers` varchar(255) NOT NULL,
  `awname` varchar(255) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awtasks` (
  `awid` int(255) NOT NULL AUTO_INCREMENT,
  `awnumber` int(255) NOT NULL,
  `awproject` int(11) NOT NULL,
  `awtitle` varchar(500) NOT NULL,
  `awdescription` text NOT NULL,
  `awestimate` varchar(5) NOT NULL,
  `awstart` date,
  `awdeadline` date,
  `awcreator` int(5) NOT NULL,
  `awworkflowpos` int(11) NOT NULL DEFAULT '1',
  `awowner` int(11),
  `awprio` int(11) NOT NULL,
  `awcreate` datetime NOT NULL,
  `awupdate` datetime NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awusers` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awmail` varchar(50) NOT NULL,
  `awpassword` varchar(255) NOT NULL,
  `awname` varchar(50),
  `awlastname` varchar(50),
  `awcompany` int(2),
  `awphone` varchar(20),
  `awmobile` varchar(20),
  `awzip` int(10),
  `awcity` varchar(20),
  `awstreet` varchar(50) NOT NULL,
  `awcountry` int(2) NOT NULL,
  `awgender` int(1) NOT NULL,
  `awavatar` varchar(255),
  `awlastlogin` date,
  `awurl` varchar(255),
  `awposition` varchar(255),
  `awadded` date NOT NULL,
  `awstate` int(1),
  `awgroup` int(11) NOT NULL,
  `awnotification2comment` int(11) NOT NULL DEFAULT '3',
  `awnotification2worklog` int(11) NOT NULL DEFAULT '3',
  `awnotification2state` int(11) NOT NULL DEFAULT '3',
  `awnotification2description` int(11) NOT NULL DEFAULT '3',
  `awnotification2assignee` int(11) NOT NULL DEFAULT '3',
  `awnotification2newtask` int(11) NOT NULL DEFAULT '3',
  `awupdate` date NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awusers2projects` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awprojectid` int(11) NOT NULL,
  `awuserid` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awwatchlist` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awuserid` int(11) NOT NULL,
  `awprojectid` int(11) NOT NULL,
  `awtaskid` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awworkflow` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awname` varchar(255) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awworkflowsteps` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awworkflow` int(5) NOT NULL,
  `awname` varchar(255) NOT NULL,
  `awsort` int(5) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `awworklog` (
  `awid` int(11) NOT NULL AUTO_INCREMENT,
  `awprojectid` int(11) NOT NULL,
  `awtaskid` int(11) NOT NULL,
  `awtime` varchar(5) NOT NULL,
  `awdesc` text NOT NULL,
  `awdate` datetime NOT NULL,
  `awuser` int(11) NOT NULL,
  PRIMARY KEY (`awid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT INTO `awconfig` (`awid`, `awvarname`, `awvartype`, `awvarvalue`) VALUES
(1, 'sTitle', 'str', 'awesomeo'),
(2, 'sSkin', 'str', 'skin-blue'),
(3, 'sCopyright', 'str', 'adelmann-solutions'),
(4, 'sCopyrightLink', 'str', 'adelmann-solutions.com'),
(5, 'sFooterInfo', 'str', ''),
(6, 'iDays4NewTasks', 'int', '2'),
(7, 'iDays4EndTime', 'int', '2'),
(8, 'sMailName', 'str', 'awesomoe.de'),
(9, 'sMailAdress', 'str', ''),
(10, 'sVersion', 'str', '1.0') ;
(11, 'iAgileType', 'int', '2') ;

INSERT INTO `awgroups` (`awid`, `awname`, `awproject`, `awtask`, `awtrack`, `awfiles`, `awadmin`) VALUES
(1, 'Admin', '1,1,1,1', '1,1,1,1', '1,1,1,1', '1,1,1,1', 1),
(2, 'User', '0,1,0,1', '1,1,1,1', '1,1,1,1', '1,1,1,1', 0),
(3, 'Client', '0,0,0,0', '1,1,1,1', '0,0,0,0', '1,0,0,0', 0) ;

INSERT INTO `awprio` (`awid`, `awname`, `awsort`, `awcolor`) VALUES
(1, 'Niedrig', 1, 0),
(2, 'Mittel', 2, 4),
(3, 'Hoch', 3, 2),
(4, 'Blocker', 4, 3) ;

INSERT INTO `awworkflow` (`awid`, `awname`) VALUES
(1, 'Standard') ;

INSERT INTO `awworkflowsteps` (`awid`, `awworkflow`, `awname`, `awsort`) VALUES
(1, 1, 'Review', 1),
(2, 1, 'Ready for Development', 2),
(3, 1, 'In Progress', 3),
(4, 1, 'Ready for Testing', 4),
(5, 1, 'Testing', 5),
(6, 1, 'Solved', 6) ;

