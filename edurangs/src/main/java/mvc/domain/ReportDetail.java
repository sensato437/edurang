package mvc.domain;

public class ReportDetail {
	private long rNo;
	private long pNo;
	private String subject;
	private String email;
	private String rContent;
	
	public ReportDetail() {}


	public ReportDetail(long rNo, long pNo,String subject ,String email, String rContent) {
		super();
		this.rNo = rNo;
		this.pNo = pNo;
		this.subject = subject;
		this.rContent = rContent;
		this.email = email;
	}


	public long getrNo() {
		return rNo;
	}


	public void setrNo(long rNo) {
		this.rNo = rNo;
	}


	public long getpNo() {
		return pNo;
	}


	public void setpNo(long pNo) {
		this.pNo = pNo;
	}


	public String getrContent() {
		return rContent;
	}


	public void setrContent(String rContent) {
		this.rContent = rContent;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}
	
	
}
