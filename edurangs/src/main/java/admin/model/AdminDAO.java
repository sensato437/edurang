package admin.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import admin.model.AdminSQL;
import mvc.domain.Blacklist;
import mvc.domain.ReportDetail;
import mvc.domain.SignUpMember;
import mvc.domain.Statistics;

class AdminDAO {
	private DataSource ds;
	public AdminDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException se) {
			System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}
	
	ArrayList<Statistics> pBoardStatistics(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<Statistics> list = new ArrayList<>();
		String sql = AdminSQL.PBOARD_STATISTICS;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				long count = rs.getLong(1);
				String cname = rs.getString(2);
				list.add(new Statistics(count,cname));
			}
			return list;
		}catch (SQLException se) {
			return null;
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
	ArrayList<ReportDetail> reportList(int page){
		ArrayList<ReportDetail> list = new ArrayList<ReportDetail>();
		String sql = AdminSQL.REPORT_LIST;
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if(page<1)
			page = 1;
		int paging = 5*(page-1);
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, paging);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				long rNo = rs.getLong(1);
				long pNo = rs.getLong(2);
				String subject = rs.getString(3);
				String email = rs.getString(4);
				String rContent = rs.getString(5);
				list.add(new ReportDetail(rNo, pNo, subject,rContent, email));
			}
			return list;
		}catch (SQLException se) {
			return null;
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
	long reportSize() {
		String sql = AdminSQL.REPORT_SIZE;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getLong(1);
			else
				return -1L;
		}catch (SQLException se) {
			return -1L;
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
	
	ArrayList<SignUpMember> signUpStatistics(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<SignUpMember> list = new ArrayList<>();
		String sql = AdminSQL.DATE_STATISTICS;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String cDate = rs.getString(1);
				int cCount = rs.getInt(2);
				list.add(new SignUpMember(cDate,cCount));
			}
			return list;
		}catch (SQLException se) {
			return null;
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
	
	long blacklistSize() {
		String sql = AdminSQL.BLACK_SIZE;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getLong(1);
			else
				return -1L;
		}catch (SQLException se) {
			return -1L;
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
	
	ArrayList<Blacklist> blacklist(int page){
		ArrayList<Blacklist> list = new ArrayList<Blacklist>();
		String sql = AdminSQL.BLACK_LIST;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int paging = (page-1)*5;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, paging);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				long banNo = rs.getLong(1);
				String bContent = rs.getString(2);
				Date bDate = rs.getDate(3);
				Date uBDate = rs.getDate(4);
				String email = rs.getString(5);
				list.add(new Blacklist(banNo, bContent, bDate, uBDate, email));
			}
			return list;
		}catch (SQLException se) {
			return null;
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
}
