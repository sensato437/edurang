package mvc.domain;

import java.sql.Date;

public class Member {
	private String email;
	private String pwd;
	private String name;
	private String nick;
	private int point;
	private Date birth;
	private int state;
	private Date cDate;
	private Date lDate;
	private int gNo;
	private int roldID;
	private Date deletedAt;
	
	public Member(){}
	public Member(String email, String pwd, String name, String nick, Date birth) {
		this.email = email;
		this.pwd = pwd;
		this.name = name;
		this.nick = nick;
		this.birth = birth;
	}
	public Member(String email, String pwd, String name, String nick, int point, Date birth, int state, Date cDate,
			Date lDate, int gNo, int roldID, Date deletedAt) {
		
		this(email,pwd,name,nick,birth);
		this.point = point;
		this.state = state;
		this.cDate = cDate;
		this.lDate = lDate;
		this.gNo = gNo;
		this.roldID = roldID;
		this.deletedAt = deletedAt;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getcDate() {
		return cDate;
	}
	public void setcDate(Date cDate) {
		this.cDate = cDate;
	}
	public Date getlDate() {
		return lDate;
	}
	public void setlDate(Date lDate) {
		this.lDate = lDate;
	}
	public int getgNo() {
		return gNo;
	}
	public void setgNo(int gNo) {
		this.gNo = gNo;
	}
	public int getRoldID() {
		return roldID;
	}
	public void setRoldID(int roldID) {
		this.roldID = roldID;
	}
	public Date getDeletedAt() {
		return deletedAt;
	}
	public void setDeletedAt(Date deletedAt) {
		this.deletedAt = deletedAt;
	}
	
}