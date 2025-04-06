package login.model;
import java.util.Map;

import mvc.domain.Member;

public class LoginService {
	private LoginDAO dao;
	private static final LoginService instance = new LoginService();
	private LoginService() {
		dao = new LoginDAO();
	}
	
	public static LoginService getInstance() {
		return instance;
	}
	public boolean signupS(Member member) {
		return dao.signUp(member);
	}
	public boolean checkEmailS(String email) {
		return dao.checkEmail(email);
	}
	public boolean checkNickS(String nick) {
		return dao.checkNick(nick);
	}
	public Member LoginS(String email,String pwd) {
		if(dao.chagneState(LoginConst.LOGIN, email))
			return dao.getMember(email, pwd);
		else
			return null;
	}
	public boolean LogOutState(String email) {
		return dao.chagneState(LoginConst.LOGOUT, email);
	}	
	public int check(String email,String pwd) {
		Member m = dao.getMember(email,pwd);
		if(m == null) {
			return LoginConst.NO_ID; // Email이 없음
		}else {
			 // 탈퇴된 회원인지 확인
	        if (m.getDeletedAt() != null) {
	            return LoginConst.DELETED_USER; // 탈퇴된 회원
	        }
			
			String dbPwd = m.getPwd();
			if(dbPwd != null) dbPwd = dbPwd.trim();
			
			if(!dbPwd.equals(pwd)) {
				return LoginConst.NO_PWD; //email은 존재하지만 비번은 틀림
			}else { 
				dao.chagneState(LoginConst.LOGIN, email);
				return LoginConst.YES_ID_PWD; //로그인 성공
			}
		}
	}
	public boolean updateProfileS(Member member) {
		return dao.updateProfile(member);
	}
	public boolean withdrawS(Member member) {
		return dao.withdraw(member);
	}
	public boolean restoreS(String email, String password) {
	    Member member = dao.getMember(email, password);
	    if (member == null) {
	        return false; // 비밀번호가 일치하지 않음
	    }
	    return dao.restore(email);
	}
	public Map<String, Object> getPointS(String email) {
		return dao.getPoint(email);
	}
}
