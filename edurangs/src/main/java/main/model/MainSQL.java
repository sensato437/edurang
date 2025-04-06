package main.model;

class MainSQL {
	final static String QNALIST = "SELECT PBoard.pNo, PBoard.subject, PBoard.PContent, PBoard.PDate, PBoard.views, PBoard.pGNo, PBoard.pGOrder, PBoard.cNo, PBoard.email, Categorys.cName "
						            + "FROM PBoard "
						            + "JOIN Categorys ON PBoard.CNo = Categorys.CNo "
						            + "WHERE PBoard.PGOrder = 0 "
						            + "AND PBoard.CNo IN (7, 8, 9) "
						            + "ORDER BY PBoard.PNo DESC "
						            + "LIMIT 6;";
	
	final static String COMLIST = "SELECT PBoard.pNo, PBoard.subject, PBoard.PContent, PBoard.PDate, PBoard.views, PBoard.pGNo, PBoard.pGOrder, PBoard.cNo, PBoard.email, Categorys.cName "
						            + "FROM PBoard "
						            + "JOIN Categorys ON PBoard.CNo = Categorys.CNo "
						            + "WHERE PBoard.PGOrder = 0 "
						            + "AND PBoard.CNo IN (4, 5, 6) "
						            + "ORDER BY PBoard.views DESC "
						            + "LIMIT 6;";
	
	final static String INFOLIST = "SELECT PBoard.pNo, PBoard.subject, PBoard.PContent, PBoard.PDate, PBoard.views, PBoard.pGNo, PBoard.pGOrder, PBoard.cNo, PBoard.email, Categorys.cName "
						            + "FROM PBoard "
						            + "JOIN Categorys ON PBoard.CNo = Categorys.CNo "
						            + "WHERE PBoard.PGOrder = 0 "
						            + "AND PBoard.CNo IN (10, 11) "
						            + "ORDER BY PBoard.PNo DESC "
						            + "LIMIT 6;";
}
