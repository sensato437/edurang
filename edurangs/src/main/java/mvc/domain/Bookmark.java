package mvc.domain;

public class Bookmark {
	private long pNo;
	private String email;
	
	public Bookmark() {
		// TODO Auto-generated constructor stub
	}

	public Bookmark(long pNo, String email) {
		pNo = pNo;
		this.email = email;
	}

	public long getPNo() {
		return pNo;
	}

	public String getEmail() {
		return email;
	}

}
