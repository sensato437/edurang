package mvc.domain;

import java.sql.Date;

public class AdminArticle {
	private long pNo;
	private String subject;
	private String email;
	private Date pDate;
	
	public AdminArticle() {}

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getpDate() {
		return pDate;
	}

	public void setpDate(Date pDate) {
		this.pDate = pDate;
	}
	
}
