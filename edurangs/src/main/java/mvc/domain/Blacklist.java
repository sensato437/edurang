package mvc.domain;

import java.sql.Date;

public class Blacklist {
	private long banNo;
	private String bContent;
	private Date bDate;
	private Date uBdate;
	private String email;
	
	public Blacklist() {}

	public Blacklist(long banNo,String bContent, Date bDate, Date uBdate, String email) {
		this.banNo = banNo;
		this.bContent = bContent;
		this.bDate = bDate;
		this.uBdate = uBdate;
		this.email = email;
	}

	public long getBanNo() {
		return banNo;
	}

	public void setBanNo(long banNo) {
		this.banNo = banNo;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public Date getbDate() {
		return bDate;
	}

	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}

	public Date getuBdate() {
		return uBdate;
	}

	public void setuBdate(Date uBdate) {
		this.uBdate = uBdate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
