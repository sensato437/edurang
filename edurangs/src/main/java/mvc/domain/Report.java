package mvc.domain;

public class Report {
	private long pNo;
	private String email;
	private String rContent;
	public Report() {
		// TODO Auto-generated constructor stub
	}

	public Report(long pNo, String email , String rContent) {
		this.pNo = pNo;
		this.email = email;
		this.rContent = rContent;
	}

	public long getPNo() {
		return pNo;
	}

	public String getEmail() {
		return email;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
}
