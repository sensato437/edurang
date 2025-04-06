package admin.model;

class AdminSQL {
	final static String PBOARD_STATISTICS = "select Count(CNo),CName from PBoard natural join categorys group by CNo";
	
	final static String DATE_STATISTICS = "SELECT DATE_FORMAT(CDate, '%Y-%m-%d') AS formatted_date, COUNT(CDate) FROM members WHERE CDate >= NOW() - INTERVAL 5 DAY GROUP BY formatted_date";
	final static String REPORT_LIST = "SELECT R.RNo, R.PNo, P.subject, R.RContent, R.email FROM REPORT R INNER JOIN PBOARD P ON R.PNo = P.PNo ORDER BY R.RNo DESC LIMIT ?, 5";
	final static String REPORT_SIZE = "SELECT COUNT(RNO) from REPORT";
	
	final static String BLACK_LIST = "SELECT * FROM blacklist ORDER BY banNO DESC LIMIT ?,5";
	final static String BLACK_SIZE = "SELECT COUNT(BanNo) from blacklist";
}
