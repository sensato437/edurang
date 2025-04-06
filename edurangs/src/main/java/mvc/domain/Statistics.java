package mvc.domain;

public class Statistics {
	private long count;
	private String cName;
	
	public Statistics() {}
	
	
	public Statistics(long count, String cName) {
		this.count = count;
		this.cName = cName;
	}


	public long getCount() {
		return count;
	}
	public void setCount(long count) {
		this.count = count;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
}
