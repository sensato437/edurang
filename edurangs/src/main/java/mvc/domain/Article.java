package mvc.domain;

import java.sql.Date;

public class Article {
	private long pNo;
	private String subject;
	private String pContent;
	private Date pDate;
	private int views;
	private int pGNo;
	private int pGOrder;
	private long cNo;
	private String email;
	private String cName;
	private String nick;
	
	public Article() {}
	
	public Article(long pNo, String subject, String pContent, Date pDate, int views, int pGNo, int pGOrder, long cNo,
			String email,String cName) {		
		this.pNo = pNo;
		this.subject = subject;
		this.pContent = pContent;
		this.pDate = pDate;
		this.views = views;
		this.pGNo = pGNo;
		this.pGOrder = pGOrder;
		this.cNo = cNo;
		this.email = email;
		this.cName = cName;
	}
	
	public Article(long pNo, String subject, String pContent, Date pDate, int views, int pGNo, int pGOrder, long cNo,
			String email,String cName, String nick) {		
		this.pNo = pNo;
		this.subject = subject;
		this.pContent = pContent;
		this.pDate = pDate;
		this.views = views;
		this.pGNo = pGNo;
		this.pGOrder = pGOrder;
		this.cNo = cNo;
		this.email = email;
		this.cName = cName;
		this.nick = nick;
	}

	public long getpNo() {
		return pNo;
	}

	public void setpNo(long pNo) {
		this.pNo = pNo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getpContent() {
		return pContent;
	}

	public void setpContent(String pContent) {
		this.pContent = pContent;
	}

	public Date getpDate() {
		return pDate;
	}

	public void setpDate(Date pDate) {
		this.pDate = pDate;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getpGNo() {
		return pGNo;
	}

	public void setpGNo(int pGNo) {
		this.pGNo = pGNo;
	}

	public int getpGOrder() {
		return pGOrder;
	}

	public void setpGOrder(int pGOrder) {
		this.pGOrder = pGOrder;
	}

	public long getcNo() {
		return cNo;
	}

	public void setcNo(long cNo) {
		this.cNo = cNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}
	
}
