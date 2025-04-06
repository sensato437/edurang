package mvc.domain;

import java.sql.Date;

public class SignUpMember {
	private String cdate;
	private int cCount;
	public SignUpMember(){}
	public SignUpMember(String cdate, int cCount) {
		this.cdate = cdate;
		this.cCount = cCount;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public int getcCount() {
		return cCount;
	}
	public void setcCount(int cCount) {
		this.cCount = cCount;
	}
	
}
