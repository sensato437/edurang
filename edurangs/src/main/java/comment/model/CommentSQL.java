package comment.model;

class CommentSQL {
	final static String INSERT = "insert into COMMENTS(COMMENTS,CGNO,EMAIL,PNO) VALUES(?,NEXTVAL(SeqCGNo),?,?)";
	final static String REPLY_INSERT = "insert into COMMENTS(COMMENTS,CGNO,CGORDER,EMAIL,PNO) VALUES(?,?,?,?,?)";
	final static String SEARCH_ORDER_MAX = "SELECT MAX(CGORDER) FROM COMMENTS WHERE CGNO =?";
	final static String SEARCH_GROUP_NO = "SELECT CGNO FROM COMMENTS WHERE CONO = ?";
	//ORDER BY CONO,CGNO,CGORDER"에서 cono 뺌
	final static String LIST="Select CONO,COMMENTS,CODATE,CGNO,CGORDER,EMAIL,NICK from COMMENTS natural join MEMBERS WHERE PNO=? ORDER BY CGNO,CGORDER";
	final static String UPDATE = "update COMMENTS set COMMENTS=? where CONO=?";
	final static String DELETE = "delete from COMMENTS where CONO=?";
	//포인트
	final static String UPDATE_POINT = "update members set point=point+? where email = ?";
}
