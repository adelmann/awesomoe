INSERT INTO `awconfig` (`awid`, `awvarname`, `awvartype`, `awvarvalue`) VALUES
(11, 'iAgileType', 'int', '2');

UPDATE awconfig
SET awvarvalue = '1.0' WHERE awvarname= 'sVersion';