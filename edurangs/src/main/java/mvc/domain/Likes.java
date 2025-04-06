package mvc.domain;

public class Likes {
	private long pNo;
	private String email;
	
	public Likes() {
		// TODO Auto-generated constructor stub
	}

	public Likes(long pNo, String email) {
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
