package mvc.domain;

public class Category {
	private long cNo;
	private long cpNo;
	private int cpLevel;
	private String cName;
	
	public Category(){}

	public Category(long cNo, long cpNo, int cpLevel, String cName) {
		this.cNo = cNo;
		this.cpNo = cpNo;
		this.cpLevel = cpLevel;
		this.cName = cName;
	}

	public long getcNo() {
		return cNo;
	}

	public void setcNo(long cNo) {
		this.cNo = cNo;
	}

	public long getCpNo() {
		return cpNo;
	}

	public void setCpNo(long cpNo) {
		this.cpNo = cpNo;
	}

	public int getCpLevel() {
		return cpLevel;
	}

	public void setCpLevel(int cpLevel) {
		this.cpLevel = cpLevel;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}
	
}
