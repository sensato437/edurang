package mvc.domain;

import java.sql.Timestamp;

public class Comments {
	
    private long coNo;        // 댓글 번호
    private String comments; // 댓글 내용
    private Timestamp coDate;     // 댓글 작성 일시
    private int cgNo;        // 댓글 그룹 번호
    private int cgOrder;     // 댓글 순서
    private String email;    // 댓글 작성자 이메일
    private long pNo;         // 게시물 번호
    private String nick;
	
	public Comments(){}

	public Comments(long coNo, String comments, Timestamp coDate, int cgNo, int cgOrder, String email, long pNo) {
		
		this.coNo = coNo;
		this.comments = comments;
		this.coDate = coDate;
		this.cgNo = cgNo;
		this.cgOrder = cgOrder;
		this.email = email;
		this.pNo = pNo;
	}
	
	public Comments(long coNo, String comments, Timestamp coDate, int cgNo, int cgOrder, String email, long pNo,
			String nick) {
		this(coNo, comments, coDate, cgNo, cgOrder, email, pNo);
		this.nick = nick;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public long getCoNo() {
		return coNo;
	}

	public void setCoNo(long coNo) {
		this.coNo = coNo;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Timestamp getCoDate() {
		return coDate;
	}

	public void setCoDate(Timestamp coDate) {
		this.coDate = coDate;
	}

	public int getCgNo() {
		return cgNo;
	}

	public void setCgNo(int cgNo) {
		this.cgNo = cgNo;
	}

	public int getCgOrder() {
		return cgOrder;
	}

	public void setCgOrder(int cgOrder) {
		this.cgOrder = cgOrder;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public long getpNo() {
		return pNo;
	}

	public void setpNo(long pNo) {
		this.pNo = pNo;
	}

	
	
	

}
