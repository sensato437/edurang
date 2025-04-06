package categorys.model;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.sql.DataSource;

import mvc.domain.Category;

class CategoryDAO {
	private DataSource ds;
	CategoryDAO(){
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch(NamingException ne) {
			System.out.println("DBCP객체(jdbc/TestDB)를 못찾음");
		}
	}
	
	ArrayList<Category> search(int cNo){
		ArrayList<Category> list = new ArrayList<>();
		String sql = CategorySQL.SEARCH_NUM;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cNo);
			pstmt.setInt(2, cNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int rsCNo = rs.getInt(1);
				int cPNo = rs.getInt(2);
				int cPLevel = rs.getInt(3);
				String cName = rs.getString(4);
				
				list.add(new Category(rsCNo,cPNo,cPLevel,cName));
			}
			return list;
		}catch (SQLException se) {
			return null;
		}finally{
			try {
				rs.close();
				pstmt.close();
				con.close();
			}catch (SQLException se) {}
		}
	}
}
