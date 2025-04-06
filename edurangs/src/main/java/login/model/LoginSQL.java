package login.model;

class LoginSQL {
	final static String SIGNUP = "insert into Members(email,pwd,name,nick,birth) values(?,?,?,?,?)";
	final static String E_CHECK = "SELECT COUNT(*) FROM MEMBERS WHERE email = ?";
	final static String N_CHECK = "select COUNT(*) from MEMBERS where NICK=?";
	final static String SIGNIN = "select * from MEMBERS where EMAIL=? and PWD=? ";
	final static String USER_STATUS_LOGGED = "update members set state=? where email=?";
	final static String USER_UPDATE = "UPDATE members SET nick = ?, pwd = ? WHERE email = ?";
	final static String USER_UPDATE_NICK = "UPDATE MEMBERS SET nick = ? WHERE email = ?";
	final static String WITHDRAW = "UPDATE members SET deleted_at = NOW() where email = ?";
	final static String RESTORE = "UPDATE members SET deleted_at = NULL WHERE email = ?";
}
