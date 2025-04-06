package mylist.model;

class MylistSQL {
	final static String LIST = "select PB.PNO,PB.SUBJECT,PB.PCONTENT,PB.PDATE,PB.VIEWS,PB.PGNO,PB.PGOrder,C.CNO,M.EMAIL,C.CNAME from PBoard AS PB LEFT JOIN MEMBERS AS M  ON PB.EMAIL = M.EMAIL LEFT JOIN CATEGORYS AS C ON PB.CNO = C.CNO order by pNo desc;";
	//final static String LISTP = "select * from pBoard order by pGNo desc, pGOrder asc, pNo desc LIMIT ? OFFSET ?";
	final static String LISTP = "select p.pNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName " +
								"from pBoard p " + 
								"join Categorys c on p.cNo = c.cNo " +
								"order by p.pGNo desc, p.pGOrder asc, p.pNo desc " +
								"LIMIT ? OFFSET ?";
	final static String CLISTP = "select p.pNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName " +
								"from pBoard p " + 
								"join Categorys c on p.cNo = c.cNo " +
								"WHERE p.email = ? " +
								"order by p.pGNo desc, p.pGOrder asc, p.pNo desc " +
								"LIMIT ? OFFSET ?";
	//final static String LIST = "select * from PBoard order by pNo, cNo";
	//final static String PAGING = "select * from PBoard order by pNo desc LIMIT ?, ?";
	final static String COUNT =  "SELECT COUNT(*) FROM pboard WHERE email = ?";
	final static String MAXPGNO = "select max(pGOrder) from pBoard where pGNo=?";
	
	final static String BOOKMARK_LIST = "SELECT p.pNo, p.subject, p.PContent, p.PDate, p.views, p.pGNo, p.pGOrder, p.cNo, p.email, c.cName " +
            "FROM pBoard p " +
            "JOIN Categorys c ON p.cNo = c.cNo " +
            "JOIN Bookmark b ON p.pNo = b.pNo " +
            "WHERE b.email = ? " +
            "ORDER BY p.pGNo DESC, p.pGOrder ASC, p.pNo DESC " +
            "LIMIT ? OFFSET ?";
	
	//final static String INSERT = "INSERT INTO PBoard (WRITER, EMAIL, SUBJECT, CONTENT, FNAME, ONAME, FSIZE, RDATE) VALUES (?, ?, ?, ?, ?, ?, ?, current_timestamp())";
	
	//아직 기능구현 전이라 PGOrder(0), CNo(1)은 일단 정해둠 → 나중에 제거
	//final static String INSERT = "INSERT INTO PBoard (subject, PContent, PDate, views, PGNo, PGOrder, CNo, email) VALUES (?, ?, NOW(), 0, NEXT VALUE FOR SeqPGNo, 0, ?, ?)";
	//final static String INSERT_REPLY = "INSERT INTO PBoard (subject, PContent, PDate, views, PGNo, PGOrder, CNo, email) VALUES (?, ?, NOW(), 0, ?, ?, ?, ?)";
	
	final static String CONTENT = "select * from PBoard where pNo= ?";
	final static String VIEW = "update PBoard set views = views + 1 where pNo = ?";
	
	
	//final static String DEL = "delete from PBoard where pNo= ?";
	//final static String UPDATE = "update PBoard set subject=?, pContent=? where pNo=?";
	final static String LIST_DETAIL = "select * from PBorad where CNo = any(";
	
	//신고
	//final static String REPORT = "INSERT INTO Report (PNo, email, RContent) VALUES (?, ?, ?)";
	//final static String REPORTCOUNT = "SELECT COUNT(*) FROM report WHERE pNo = ? AND email = ?";

	//공감
	//final static String INSERT_LIKE = "insert into Likes (pNo, email) values (?, ?)";	
	final static String LIKECOUNT = "select count(*) from Likes where pNo = ?";
	//final static String ISLIKE = "select * from Likes where pNo = ? and email =?"; //중복공감 조회

	//북마크
	//final static String ADD_BOOKMARK = "insert into BOOKMARK (pNo, email) values (?, ?)"; //북마크 추가
	//final static String ISBOOKMARK = "select count(*) from Bookmark where pNo = ? and email = ?"; //pNo, email 묶어서 조회
	//final static String DELBOOKMARK = "delete from Bookmark where pNo = ? and email = ?";
}