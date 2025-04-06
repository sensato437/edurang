package comment.model;

import mvc.domain.Comments;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

class CommentDAO {
    private DataSource ds;

    public CommentDAO() {
		try {
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException ne) {
			System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}

   public boolean insert(Comments comment) {
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   PreparedStatement pstmt2 = null;
	   PreparedStatement pstmt3 = null;
	   String sql = CommentSQL.INSERT;
	   String sql2 = CommentSQL.UPDATE_POINT;
	   String sql3 = "UPDATE members SET GNo = ? WHERE email = ?";
	   try {
		   con = ds.getConnection();
		   con.setAutoCommit(false); // 트랜잭션 시작
		   
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, comment.getComments());
		   pstmt.setString(2, comment.getEmail());
		   pstmt.setLong(3, comment.getpNo());
		   int i = pstmt.executeUpdate();
		   
		   if (i > 0) {
	            // pNo를 사용하여 cNo 조회!
	            String sql4 = "SELECT CNo FROM pboard WHERE PNo = ?";
	            pstmt2 = con.prepareStatement(sql4);
	            pstmt2.setLong(1, comment.getpNo());
	            ResultSet rs = pstmt2.executeQuery();

	            if (rs.next()) {
	                int cNo = rs.getInt("CNo");
	                if (cNo == 7 || cNo == 8 || cNo == 9) {
	                    pstmt2 = con.prepareStatement(sql2);
	                    pstmt2.setInt(1, 50);
	                    pstmt2.setString(2, comment.getEmail());
	                    pstmt2.executeUpdate();
	                    
	                    // 포인트 조회
	                    String sql5 = "SELECT point FROM members WHERE email = ?";
	                    pstmt3 = con.prepareStatement(sql5);
	                    pstmt3.setString(1, comment.getEmail());
	                    ResultSet rs2 = pstmt3.executeQuery();

	                    if (rs2.next()) {
	                        int point = rs2.getInt("point");
	                        // 포인트가 1000점 이상이면 GNo를 2(멘토)로 업데이트
	                        if (point >= 1000) {
	                            pstmt3 = con.prepareStatement(sql3);
	                            pstmt3.setInt(1, 2); // GNo = 2 (멘토)
	                            pstmt3.setString(2, comment.getEmail());
	                            pstmt3.executeUpdate();
	                        }
	                    }
	                }
	            }
	            con.commit();
	            return true;
	        } else {
	        	con.rollback();
	            return false;
	        }
	   }catch(SQLException se) {
		   return false;
	   }finally {
		   try {
	            if (pstmt != null) pstmt.close();
	            if (pstmt2 != null) pstmt2.close();
	            if (pstmt3 != null) pstmt3.close();
	            if (con != null) con.close();
		   }catch (SQLException se) {
		}
	   }
   }
   
   public boolean rInsert(Comments comment) {
	   Connection con = null;
	  
	   PreparedStatement pstmt = null;
	   PreparedStatement pstmt2 = null;
	   PreparedStatement pstmt3 = null;
	   String sql = CommentSQL.REPLY_INSERT;
	   String sql2 = CommentSQL.UPDATE_POINT;
	   String sql3 = "UPDATE members SET GNo = ? WHERE email = ?";
	   

	   try {
		   long cgNo = searchCGNo(comment.getCoNo());;
		   int cgOrder = maxOrder(cgNo);
		   con = ds.getConnection();
		   con.setAutoCommit(false); // 트랜잭션 시작
		   
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, comment.getComments());
		   pstmt.setLong(2, cgNo);
		   pstmt.setInt(3, cgOrder+1);
		   pstmt.setString(4, comment.getEmail());
		   pstmt.setLong(5, comment.getpNo());
		   int i = pstmt.executeUpdate();
		   if (i > 0) {
	            // pNo를 사용하여 cNo 조회!
	            String sql4 = "SELECT CNo FROM pboard WHERE PNo = ?";
	            pstmt2 = con.prepareStatement(sql4);
	            pstmt2.setLong(1, comment.getpNo());
	            ResultSet rs = pstmt2.executeQuery();

	            if (rs.next()) {
	                int cNo = rs.getInt("CNo");
	                if (cNo == 7 || cNo == 8 || cNo == 9) {
	                    pstmt2 = con.prepareStatement(sql2);
	                    pstmt2.setInt(1, 50);
	                    pstmt2.setString(2, comment.getEmail());
	                    pstmt2.executeUpdate();
	                    
	                    // 포인트 조회
	                    String sql5 = "SELECT point FROM members WHERE email = ?";
	                    pstmt3 = con.prepareStatement(sql5);
	                    pstmt3.setString(1, comment.getEmail());
	                    ResultSet rs2 = pstmt3.executeQuery();

	                    if (rs2.next()) {
	                        int point = rs2.getInt("point");
	                        // 포인트가 1000점 이상이면 GNo를 2(멘토)로 업데이트
	                        if (point >= 1000) {
	                            pstmt3 = con.prepareStatement(sql3);
	                            pstmt3.setInt(1, 2); // GNo = 2 (멘토)
	                            pstmt3.setString(2, comment.getEmail());
	                            pstmt3.executeUpdate();
	                        }
	                    }
	                }
	            }
	            con.commit();
	            return true;
	        } else {
	        	con.rollback();
	            return false;
	        }
	   }catch(SQLException se) {
		   return false;
	   }finally {
		   try {
	            if (pstmt != null) pstmt.close();
	            if (pstmt2 != null) pstmt2.close();
	            if (pstmt3 != null) pstmt3.close();
	            if (con != null) con.close();
		   }catch (SQLException se) {}
		   
	   }
   }
   //CGORDER 최고치 찾는거
   int maxOrder(long cgNo) {
	   String sql = CommentSQL.SEARCH_ORDER_MAX;
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   try {
		   con = ds.getConnection();
		   pstmt = con.prepareStatement(sql);
		   pstmt.setLong(1, cgNo);
		   rs = pstmt.executeQuery();
		   if(rs.next())
			   return rs.getInt(1);
		   else
			   return -1;
	   }catch (SQLException se) {
		return -1;
	   }finally {
		   try {
			   if(rs!=null) rs.close();
			   pstmt.close();
			   con.close();
		   }catch (SQLException se) {
			// TODO: handle exception
		}
	   }
   }
   int searchCGNo(long coNo) {
	   String sql = CommentSQL.SEARCH_GROUP_NO;
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   try {
		   con = ds.getConnection();
		   pstmt = con.prepareStatement(sql);
		   pstmt.setLong(1, coNo);
		   rs = pstmt.executeQuery();
		   if(rs.next())
			   return rs.getInt(1);
		   else
			   return -1;
	   }catch (SQLException se) {
		   return -1;
	   }finally {
		   try {
			   if (rs!=null) rs.close();
			   pstmt.close();
			   con.close();
		   }catch (SQLException se) {
			// TODO: handle exception
		}
	   }
   }
   public boolean delete(long coNo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = CommentSQL.DELETE;

        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, coNo);
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (SQLException e) {
            }
        }
    }
   
   public boolean update(Comments comment) {
	   String sql = CommentSQL.UPDATE;
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   try {
		   con = ds.getConnection();
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1, comment.getComments());
		   pstmt.setLong(2, comment.getCoNo());
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

   
    public ArrayList<Comments> list(long pNo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Comments> list = new ArrayList<>();
        String sql = CommentSQL.LIST;

        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, pNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	long coNo = rs.getLong(1);
            	String commetns = rs.getString(2);
            	Timestamp coDate = rs.getTimestamp(3);
            	int cgNo = rs.getInt(4);
            	int cgOrder = rs.getInt(5);
            	String email = rs.getString(6);
            	String nick = rs.getString(7);
        

                list.add(new Comments(coNo, commetns, coDate, cgNo, cgOrder, email, pNo, nick));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (SQLException e) {}
        }
    }
    
}
