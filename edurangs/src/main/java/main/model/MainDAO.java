package main.model;

import mvc.domain.Article;
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

class MainDAO {
    private DataSource ds;

    public MainDAO() {
		try {
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException ne) {
			System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}

    public ArrayList<Article> list(String cat) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Article> list = new ArrayList<>();
        String sql = null;
        if(cat.equals("QNA")) {
        	sql = MainSQL.QNALIST;
        }else if(cat.equals("COM")){
        	sql = MainSQL.COMLIST;
        }else {
        	sql = MainSQL.INFOLIST;
        }


        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);
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
