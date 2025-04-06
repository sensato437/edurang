package main.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import mvc.domain.Category;

class CategoryDAO {
	private DataSource ds;
	public CategoryDAO() {
		try {
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException ne) {
			System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}
	ArrayList<Category> categorys(long cpNo){
		ArrayList<Category> categorys = new ArrayList<>();
		String sql = "";
		if(cpNo > -1)
			sql = CategorySQL.SELETE;
		else
			sql = CategorySQL.ASELETE;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			if(cpNo > -1) pstmt.setLong(1, cpNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				long cNo = rs.getLong(1);
				long cpcNo = rs.getLong(2);
				int cpLevel = rs.getInt(3);
				String cName = rs.getString(4);
				categorys.add(new Category(cNo,cpcNo,cpLevel,cName));
			}
			return categorys;
		}catch (SQLException se) {
			return null;
		}finally{
			try {
				if(rs!=null) rs.close();
				pstmt.close();
				con.close();
			}catch (SQLException se) {
				// TODO: handle exception
			}
		}
		
	}
}
