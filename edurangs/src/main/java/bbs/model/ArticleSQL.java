package bbs.model;

class ArticleSQL {
	final static String LIST = "select PB.PNO,PB.SUBJECT,PB.PCONTENT,PB.PDATE,PB.VIEWS,PB.PGNO,PB.PGOrder,C.CNO,M.EMAIL,C.CNAME from PBoard AS PB LEFT JOIN MEMBERS AS M  ON PB.EMAIL = M.EMAIL LEFT JOIN CATEGORYS AS C ON PB.CNO = C.CNO order by pNo desc;";
	//final static String LISTP = "select * from pBoard order by pGNo desc, pGOrder asc, pNo desc LIMIT ? OFFSET ?";
	final static String LISTP = "select p.pNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName " +
								"from pBoard p " + 
								"join Categorys c on p.cNo = c.cNo " +
								"order by p.pGNo desc, p.pGOrder asc, p.pNo desc " +
								"LIMIT ? OFFSET ?";
	final static String CLISTP = "SELECT p.pNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName, m.nick " +
					            "FROM pBoard p " +
					            "JOIN Categorys c ON p.cNo = c.cNo " +
					            "JOIN Members m ON p.email = m.email " +
					            "WHERE p.cNo = ? " +
					            "ORDER BY p.pGNo DESC, p.pGOrder ASC, p.pNo DESC " +
					            "LIMIT ? OFFSET ?";
	//final static String LIST = "select * from PBoard order by pNo, cNo";
	//final static String PAGING = "select * from PBoard order by pNo desc LIMIT ?, ?";
	final static String COUNT = "select count(*) from PBoard where cNo = ?";
	final static String ALL_COUNT = "select count(*) from PBoard order by pNo";
	//final static String COUNTCAT = "select count(*) from PBoard where cNo";
	final static String MAXPGNO = "select max(pGOrder) from pBoard where pGNo = ?";
	
	//final static String INSERT = "INSERT INTO PBoard (WRITER, EMAIL, SUBJECT, CONTENT, FNAME, ONAME, FSIZE, RDATE) VALUES (?, ?, ?, ?, ?, ?, ?, current_timestamp())";
	
	//아직 기능구현 전이라 PGOrder(0), CNo(1)은 일단 정해둠 → 나중에 제거
	final static String INSERT = "INSERT INTO PBoard (subject, PContent, PDate, views, PGNo, PGOrder, CNo, email) VALUES (?, ?, NOW(), 0, NEXT VALUE FOR SeqPGNo, 0, ?, ?)";
	final static String INSERT_REPLY = "INSERT INTO PBoard (subject, PContent, PDate, views, PGNo, PGOrder, CNo, email) VALUES (?, ?, NOW(), 0, ?, ?, ?, ?)";
	
	final static String CONTENT = "SELECT p.pNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName, m.nick " +
					            "FROM pBoard p " +
					            "JOIN Categorys c ON p.cNo = c.cNo " +
					            "JOIN Members m ON p.email = m.email " +
					            "WHERE p.pNo = ?";
			
	final static String VIEW = "update PBoard set views = views + 1 where pNo = ?";
	
	
	final static String DEL = "delete from PBoard where pNo= ?";
	final static String UPDATE = "update PBoard set subject=?, pContent=? where pNo=?";
	final static String LIST_DETAIL = "select * from PBorad where CNo = any(";
	
	//신고
	final static String REPORT = "INSERT INTO Report (PNo, email, RContent) VALUES (?, ?, ?)";
	final static String REPORTCOUNT = "SELECT COUNT(*) FROM report WHERE pNo = ? AND email = ?";

	//공감
	final static String INSERT_LIKE = "insert into Likes (pNo, email) values (?, ?)";	
	final static String LIKECOUNT = "select count(*) from Likes where pNo = ?";
	final static String ISLIKE = "select * from Likes where pNo = ? and email =?"; //중복공감 조회

	//북마크
	final static String ADD_BOOKMARK = "insert into BOOKMARK (pNo, email) values (?, ?)"; //북마크 추가
	final static String ISBOOKMARK = "select count(*) from Bookmark where pNo = ? and email = ?"; //pNo, email 묶어서 조회
	final static String DELBOOKMARK = "delete from Bookmark where pNo = ? and email = ?";
	
  final static String PBOARD_SIZE = "select count(pNo) from pboard";

	//포인트
	final static String UPDATE_POINT = "update members set point=point+? where email = ?";
	
	//aside
	final static String QNALIST = "SELECT PBoard.pNo, PBoard.subject, Categorys.CNAME "
	            + "FROM PBoard "
	            + "JOIN Categorys ON PBoard.CNo = Categorys.CNo "
	            + "WHERE PBoard.PGOrder = 0 "
	            + "AND PBoard.CNo IN (7, 8, 9) "
	            + "ORDER BY PBoard.views DESC "
	            + "LIMIT 6;";

	final static String COMLIST = "SELECT PBoard.pNo, PBoard.subject, Categorys.CNAME "
	            + "FROM PBoard "
	            + "JOIN Categorys ON PBoard.CNo = Categorys.CNo "
	            + "WHERE PBoard.PGOrder = 0 "
	            + "AND PBoard.CNo IN (4, 5, 6) "
	            + "ORDER BY PBoard.views DESC "
	            + "LIMIT 6;";
	
	final static String INFOLIST = "SELECT PBoard.pNo, PBoard.subject, Categorys.CNAME "
	            + "FROM PBoard "
	            + "JOIN Categorys ON PBoard.CNo = Categorys.CNo "
	            + "WHERE PBoard.PGOrder = 0 "
	            + "AND PBoard.CNo IN (10, 11) "
	            + "ORDER BY PBoard.views DESC "
	            + "LIMIT 6;";
	
	//검색
    final static String SEARCH = 
            "SELECT p.PNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName, m.nick " +
            "FROM PBoard p " +
            "JOIN Categorys c ON p.cNo = c.CNo " +
            "JOIN Members m ON p.email = m.email " +
            "WHERE p.cNo = ? " +
            "AND (p.subject LIKE ? OR p.PContent LIKE ?) " +
            "ORDER BY p.pGNo DESC, p.pGOrder ASC, p.pNo DESC " +
            "LIMIT ? OFFSET ?";

	final static String SEARCH_COUNT = "select count(*) from PBoard where cNo = ? AND (subject LIKE ? OR PContent LIKE ?)";
		

}