package mylist.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.*;
import javax.sql.DataSource;

import mvc.domain.Article;
import mvc.domain.Report;

import static mylist.model.MylistSQL.*;

class MylistDAO {
	private DataSource ds;
	public MylistDAO() {
		try {
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException ne) {
			System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}
	
	ArrayList<Article> list(int pageNum, int rowCount){
		ArrayList<Article> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = MylistSQL.LISTP;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rowCount);
			pstmt.setInt(2, (pageNum-1)*rowCount);

			rs = pstmt.executeQuery();
			while(rs.next()){
				long articlePNo = rs.getLong("pNo");
				String subject = rs.getString("subject");
				String pContnet = rs.getString("pContent");
				Date pDate = rs.getDate("pDate");
				int views = rs.getInt("views");
				int pGNo = rs.getInt("pGNo");
				int pGOrder = rs.getInt("pGOrder");
				long articleCNo = rs.getLong("cNo");
				String email = rs.getString("email");
				String cName = rs.getString("cName");

				list.add(new Article(articlePNo, subject, pContnet, pDate, views, pGNo, pGOrder, articleCNo, email,cName));
			}
		}catch(SQLException se){
			System.out.println("SQL문 오류(list): " + se);
		}finally{
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){
				System.out.println("SQL list 오류: " + se);
			}
		}
		return list;
	}

	ArrayList<Article> catList(int pageNum, int rowCount, int firstPart, int secondPart, String email){
		ArrayList<Article> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = MylistSQL.CLISTP;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, rowCount);
			pstmt.setInt(3, (pageNum-1)*rowCount);

			rs = pstmt.executeQuery();
			while(rs.next()){
				long articlePNo = rs.getLong("pNo");
				String subject = rs.getString("subject");
				String pContnet = rs.getString("pContent");
				Date pDate = rs.getDate("pDate");
				int views = rs.getInt("views");
				int pGNo = rs.getInt("pGNo");
				int pGOrder = rs.getInt("pGOrder");
				long articleCNo = rs.getLong("cNo");
				String cName = rs.getString("cName");

				list.add(new Article(articlePNo, subject, pContnet, pDate, views, pGNo, pGOrder, articleCNo, email,cName));
			}
		}catch(SQLException se){
			System.out.println("SQL문 오류(list): " + se);
		}finally{
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){
				System.out.println("SQL list 오류: " + se);
			}
		}
		return list;
	}
	
	//list article count
	int getTotalArticlesCount(String email){
		String sql = COUNT;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 0;
		} catch (SQLException se) {
			System.out.println("Total articles count error: " + se);
			return 0;
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			} catch (SQLException se) {}
		}
	}
	public int getTotalBookmarkCount(String email) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "SELECT COUNT(*) FROM Bookmark WHERE email = ?";

	    try {
	        con = ds.getConnection();
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, email);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	        return 0;
	    } catch (SQLException se) {
	        System.out.println("Total bookmark count error: " + se);
	        return 0;
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException se) {}
	    }
	}
	public ArrayList<Article> bookmarkList(int pageNum, int rowCount, String email) {
	    ArrayList<Article> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        con = ds.getConnection();
	        pstmt = con.prepareStatement(MylistSQL.BOOKMARK_LIST);
	        pstmt.setString(1, email);
	        pstmt.setInt(2, rowCount);
	        pstmt.setInt(3, (pageNum - 1) * rowCount);

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            long articlePNo = rs.getLong("pNo");
	            String subject = rs.getString("subject");
	            String pContent = rs.getString("pContent");
	            Date pDate = rs.getDate("pDate");
	            int views = rs.getInt("views");
	            int pGNo = rs.getInt("pGNo");
	            int pGOrder = rs.getInt("pGOrder");
	            long articleCNo = rs.getLong("cNo");
	            String cName = rs.getString("cName");

	            list.add(new Article(articlePNo, subject, pContent, pDate, views, pGNo, pGOrder, articleCNo, email, cName));
	        }
	    } catch (SQLException se) {
	        System.out.println("SQL문 오류(bookmarkList): " + se);
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException se) {
	            System.out.println("SQL bookmarkList 오류: " + se);
	        }
	    }
	    return list;
	}
	
	//공감수 조회
	int getLikeCount(long pNo){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = MylistSQL.LIKECOUNT;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pNo);
			rs = pstmt.executeQuery();

			if(rs.next()) return rs.getInt(1);
			return 0;
		}catch(SQLException se){
			return 0;
		}finally{
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}
	}
}
