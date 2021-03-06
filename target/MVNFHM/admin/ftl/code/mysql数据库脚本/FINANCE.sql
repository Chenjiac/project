
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `FINANCE`
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE`;
CREATE TABLE `FINANCE` (
 		`FINANCE_ID` varchar(100) NOT NULL,
		`FINANCE_ID` int(11) NOT NULL COMMENT '财务id',
		`GENERAL_ARCHIVE` varchar(12) DEFAULT NULL COMMENT '全宗号',
		`CATALOG_NUMBER` varchar(12) DEFAULT NULL COMMENT '目录号',
		`VOLUME_NUM` varchar(12) DEFAULT NULL COMMENT '案卷号',
		`FINANCE_NAME` varchar(32) DEFAULT NULL COMMENT '会计核算材料名称',
		`FINANCE_YEAR` varchar(4) DEFAULT NULL COMMENT '会计年度',
		`COMPANY_NAME` varchar(24) DEFAULT NULL COMMENT '单位名称',
		`STORAGE_TIME` varchar(4) DEFAULT NULL COMMENT '保管期限',
		`ARCHIVE_NUM` varchar(6) DEFAULT NULL COMMENT '归档号',
		`SUPERVISOR` varchar(24) DEFAULT NULL COMMENT '主管',
		`BOOKKEEPER` varchar(24) DEFAULT NULL COMMENT '记账',
		`BINDING_PERSON` varchar(24) DEFAULT NULL COMMENT '装订人',
		`PAGES` int(11) NOT NULL COMMENT '页数',
  		PRIMARY KEY (`FINANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
