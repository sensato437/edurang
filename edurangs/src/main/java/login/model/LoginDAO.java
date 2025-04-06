package login.model;

import mvc.domain.Member;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

class LoginDAO {
	private DataSource ds;
	public LoginDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException ne) {
				System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}
	Member getMember(String email,String pwd) {
		String sql = LoginSQL.SIGNIN;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//Service파트에 m.getPwd가 없는데 비밀번호 가져오는걸 추가해야할까요? 해서 했씁니다. pwd랑 겹쳐서 변수명 pwdc...
				//대신 service단에서 m.setPwd""로 초기화시켰씁니다.
				String pwdc = rs.getString(2);
				String name = rs.getString(3);
				String nick = rs.getString(4);
				int point = rs.getInt(5);
				Date birth = rs.getDate(6);
				int state = rs.getInt(7);
				Date cDate = rs.getDate(8);
				Date lDate = rs.getDate(9);
				int gNo = rs.getInt(10);
				int role_id = rs.getInt(11);
				Date deletedAt = rs.getDate(12);
				return new Member(email, pwdc, name, nick, point, birth, state, cDate, lDate, gNo, role_id, deletedAt);
			}
			else
				return null;
		}catch (SQLException se) {
			return null;
		}finally {
			try {
				pstmt.close();
				con.close();
			}catch (SQLException se) {}
		}
	}
	boolean signUp(Member member) {
		String sql = LoginSQL.SIGNUP;
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getEmail());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getNick());
			pstmt.setDate(5, member.getBirth());
			int i = pstmt.executeUpdate();
			if(i>0)
				return true;
			else
				return false;
		}catch (SQLException e) {
			return false;
		}finally {
			try {
				pstmt.close();
				con.close();
			}catch (SQLException e) {
				// TODO: handle exception
			}
		}
	}
	boolean checkEmail(String email) {
		String sql = LoginSQL.E_CHECK;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isDuplicate = true;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
                int count = rs.getInt(1);  // COUNT(*) 결과는 첫 번째 열에 저장됨
                if (count > 0) {
                    isDuplicate = false;
                }
            }
		}catch(SQLException se) {
			System.err.println("SQL 오류 발생: " + se.getMessage());
	        se.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			}catch (SQLException e) {
				// TODO: handle exception
			}
		}
			return isDuplicate;
	}
	
	boolean checkNick(String nick) {
		String sql = LoginSQL.N_CHECK;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isDuplicate = true;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();

			if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    isDuplicate = false;
                }
            }
		}catch(SQLException se) {
			System.err.println("SQL 오류 발생: " + se.getMessage());
	        se.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			}catch (SQLException e) {
				// TODO: handle exception
			}
		}
		return isDuplicate;
	}
	boolean chagneState(int state,String email) {
		String sql = LoginSQL.USER_STATUS_LOGGED;
		Connection con =null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setString(2,email);
			int i = pstmt.executeUpdate();
			if(i>0)
				return true;
			else
				return false;
		}catch (SQLException se) {
			return false;
		}finally {
			try {
				pstmt.close();
				con.close();
			}catch (SQLException se) {
				// TODO: handle exception
			}
		}
	}
	 boolean updateProfile(Member member) {
	        String sql;
	        if (member.getPwd() == null) {
	            // 비밀번호가 null인 경우, 닉네임만 업데이트
	            sql = LoginSQL.USER_UPDATE_NICK;
	        } else {
	            // 비밀번호가 있는 경우, 닉네임과 비밀번호 모두 업데이트
	            sql = LoginSQL.USER_UPDATE;
	        }
	        Connection con = null;
	        PreparedStatement pstmt = null;

	        try {
	            con = ds.getConnection();
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, member.getNick());
	            if (member.getPwd() == null) {
	                pstmt.setString(2, member.getEmail());
	            } else {
	                pstmt.setString(2, member.getPwd());
	                pstmt.setString(3, member.getEmail());
	            }

	            int i = pstmt.executeUpdate();

	            // 업데이트 성공 여부 확인
	            if (i > 0) {
	                return true;
	            } else {
	                return false;
	            }
	        } catch (SQLException se) {
	            System.err.println("SQL 오류 발생: " + se.getMessage());
	            se.printStackTrace();
	            return false;
	        } finally {
	            try {
	                if (pstmt != null) pstmt.close();
	                if (con != null) con.close();
	            } catch (SQLException se) {
	                // 예외 처리
	            }
	        }
	    }
	 boolean withdraw(Member member) {
			String sql = LoginSQL.WITHDRAW;
			Connection con =null;
			PreparedStatement pstmt = null;
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,member.getEmail());
				int i = pstmt.executeUpdate();
				if(i>0)
					return true;
				else
					return false;
			}catch (SQLException se) {
				return false;
			}finally {
				try {
					pstmt.close();
					con.close();
				}catch (SQLException se) {
				}
			}
		}
	 public boolean restore(String email) {
		    String sql = LoginSQL.RESTORE;
		    Connection con = null;
		    PreparedStatement pstmt = null;

		    try {
		        con = ds.getConnection();
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, email);
		        int i = pstmt.executeUpdate();
		        return i > 0; // 업데이트 성공 여부 반환
		    } catch (SQLException se) {
		        System.err.println("SQL 오류 발생: " + se.getMessage());
		        se.printStackTrace();
		        return false;
		    } finally {
		        try {
		            if (pstmt != null) pstmt.close();
		            if (con != null) con.close();
		        } catch (SQLException se) {}
		    }
		}
	 public Map<String, Object> getPoint(String email) {
		    String sql = "SELECT point, GNo FROM members WHERE email = ?";
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    try {
		        con = ds.getConnection();
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, email);
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		        	int point = rs.getInt("point");
		            int gNo = rs.getInt("GNo");
		            Map<String, Object> result = new HashMap<>();
		            result.put("point", point);
		            result.put("grade", gNo == 2 ? "멘토" : "멘티");
		            return result;
		        } else {
		            return null; // 포인트 조회 실패 시 -1 반환
		        }
		    } catch (SQLException se) {
		        System.out.println("포인트 조회 실패: " + se);
		        return null;
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (pstmt != null) pstmt.close();
		            if (con != null) con.close();
		        } catch (SQLException se) {}
		    }
		}
}
