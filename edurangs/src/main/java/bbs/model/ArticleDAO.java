package bbs.model;

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

import static bbs.model.ArticleSQL.*;

class ArticleDAO {
	private DataSource ds;
	public ArticleDAO() {
		try {
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		ds = (DataSource)envContext.lookup("edu/EduDB");
		}catch (NamingException ne) {
			System.out.println("DBCP객체(edu/EduDB)를 못찾음");
		}
	}
	
	//list: 글 목록(페이지네이션 ㄴㄴ)
	/*ArrayList<Article> list(){
		ArrayList<Article> list = new ArrayList<>();
		String sql = LIST;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			//pstmt.setLong(1, pNo);
			//pstmt.setLong(2, cNo);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				long articlePNo = rs.getLong("pNo");
				String subject = rs.getString("subject");
				String pContnet = rs.getString("pContent");
				Date pDate = rs.getDate("pDate");
				int views = rs.getInt("views");
				int pGNo = rs.getInt("pGNo");
				int pGOrder = rs.getInt("pGOrder");
				long articleCNo = rs.getLong("cNo");
				String email = rs.getString("email");
				
				list.add(new Article(articlePNo, subject, pContnet, pDate, views, pGNo, pGOrder, articleCNo, email));
			}
		}catch(SQLException se) {
			//return null;
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(SQLException se) {}
		}
		return list;
	}*/
	

	//list: Pagination
	ArrayList<Article> list(int pageNum, int rowCount){
		ArrayList<Article> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = ArticleSQL.LISTP;
		
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

	ArrayList<Article> catList(int pageNum, int rowCount, int firstPart, int secondPart){
		ArrayList<Article> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = ArticleSQL.CLISTP;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, secondPart);
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
				String email = rs.getString("email");
				String cName = rs.getString("cName");
				String nick = rs.getString("nick");

				list.add(new Article(articlePNo, subject, pContnet, pDate, views, pGNo, pGOrder, articleCNo, email, cName, nick));
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
	int getTotalArticlesCount(int secondPart){
		String sql = ArticleSQL.COUNT;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, secondPart);
			//카테고리별로 정렬해야 함
			//pstmt.setLong(1, cNo);
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
	int getTotalArticlesCount(){
		String sql = ArticleSQL.ALL_COUNT;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
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
	ArrayList<Article> listDeatil(int intList[]){
		ArrayList<Article> list = new ArrayList<>();
		String sql = new String(ArticleSQL.LIST_DETAIL);
		sql+=detail(intList)+" ORDER BY pNo DESC";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			for(int i=0;i<intList.length;i++)
				pstmt.setInt(i+1,intList[i]);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				long articlePNo = rs.getLong("pNo");
				String subject = rs.getString("subject");
				String pContnet = rs.getString("pContent");
				Date pDate = rs.getDate("pDate");
				int views = rs.getInt("views");
				int pGNo = rs.getInt("pGNo");
				int pGOrder = rs.getInt("pGOrder");
				long articleCNo = rs.getLong("cNo");
				String email = rs.getString("email");
				String cName = rs.getString("CNAME");
				
				list.add(new Article(articlePNo, subject, pContnet, pDate, views, pGNo, pGOrder, articleCNo, email,cName));
			}
		}catch(SQLException se) {
			//return null;
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(SQLException se) {}
		}
		return list;
	}
	
	//insert: 글 작성
	boolean insert(Article article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int[] intList = {1, 2, 3, 4};
		String sql = ArticleSQL.INSERT;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getpContent());			
			pstmt.setLong(3, article.getcNo()); //작성 cno
			pstmt.setString(4, article.getEmail()); //로그인한 멤버 이메일
			
			int i = pstmt.executeUpdate();
				if(i>0) return true;
				else return false;
		}catch(SQLException se) {
			System.out.println("SQL문 체크(원글): " + se);
			return false;
		}finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se) {}			
		}
	}

	boolean insertReply(Article article){
		Connection con = null;
		PreparedStatement pstmt = null;

		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		String sql = ArticleSQL.INSERT_REPLY;
		String sql2 = ArticleSQL.UPDATE_POINT;
		String sql3 = "UPDATE members SET GNo = ? WHERE email = ?";
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getpContent());
			pstmt.setInt(3, article.getpGNo()); //원글의 pgNo 사용
			pstmt.setInt(4, article.getpGOrder()); //원글의 pgOrder → +1 로직은 Controller에서
			pstmt.setLong(5, article.getcNo()); //원글의 cNo
			pstmt.setString(6, article.getEmail());

			int i = pstmt.executeUpdate();
			
			if (i>0) {
			long cNo = article.getcNo();
			String email = article.getEmail();
			if(cNo>=7 && cNo<=9) {
				pstmt2 = con.prepareStatement(sql2);
				//답글로 답해주는 회원에게는 100포인트
				pstmt2.setInt(1, 100);
	            pstmt2.setString(2, email);
				pstmt2.executeUpdate();
				
				// 포인트 조회
                String sql4 = "SELECT point FROM members WHERE email = ?";
                pstmt3 = con.prepareStatement(sql4);
                pstmt3.setString(1, email);
                ResultSet rs = pstmt3.executeQuery();

                if (rs.next()) {
                    int point = rs.getInt("point");
                    // 포인트가 1000점 이상이면 GNo를 2(멘토)로 업데이트
                    if (point >= 1000) {
                        pstmt3 = con.prepareStatement(sql3);
                        pstmt3.setInt(1, 2); // GNo = 2 (멘토)
                        pstmt3.setString(2, email);
                        int k = pstmt3.executeUpdate();
                        System.out.println("멘토 업데이트 성공 여부: " + k);
                    }
                }
			}
				con.commit();
				return true;
			}else {
				con.rollback();
				return false;
			}
		}catch(SQLException se){
			System.out.println("SQL문 체크(답글): " + se);
			return false;
		}finally{
			try{
				if (pstmt3 != null) pstmt3.close();
				if (pstmt2 != null) pstmt2.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}
	}

	//원글의 답글 중 가장 큰 pGOrder
	int getMaxpGOrder(int pGNo){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = ArticleSQL.MAXPGNO;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pGNo);
			rs = pstmt.executeQuery();

			if(rs.next()){
				return rs.getInt(1); //max pGNo
			}
			return 0; //글이 없으면 pGNo 반환
		}catch(SQLException se){
			System.out.println("SQL문 체크(답글 maxpGNo): " + se);
			return 0;
		}finally{
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}	
	}
	
	//content: 글 내용 조회
	Article content(Article article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = CONTENT;
		
		try {
			con = ds.getConnection();
			long pNo = article.getpNo();
			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {				
				String subject = rs.getString("subject");
				String pContent = rs.getString("pContent");
				Date pDate = rs.getDate("pDate");
				int views = rs.getInt("views");
				int pGNo = rs.getInt("pGNo");
				int pGOrder = rs.getInt("pGOrder");
				int cNo = rs.getInt("cNo");
				String email = rs.getString("email");
				String nick = rs.getString("nick");
				
				return new Article(pNo, subject, pContent, pDate, views, pGNo, pGOrder, cNo, email, null, nick);
			}
			return null;
		}catch(SQLException se) {
			System.out.println("SQL 실행 오류(체크해!): " + se);
			return null;
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se) {}
		}		
	}
	
	//views: 조회수
	void increaseView(long pNo) {
		String sql = VIEW;
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setLong(1, pNo);
			pstmt.executeUpdate();
		}catch(SQLException se) {
			System.out.println("조회수 증가 오류: " + se);
		}
	}
	
	boolean delete(long pNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = DEL;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pNo);
			int i = pstmt.executeUpdate();
				if(i>0) return true;
				else return false;				
		}catch(SQLException se) {
			return false;
		}finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se) {}
		}		
	}
	
	//update
	boolean update(Article article) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = UPDATE;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getpContent());
			pstmt.setLong(3, article.getpNo());
			
			int i = pstmt.executeUpdate();
			return i>0;
		}catch(SQLException se) {
			return false;
		}finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se) {}
		}		
	}

	private String detail(int intList[]) {
		StringBuilder sb = new StringBuilder();
		int size = intList.length;
        for (int i = 0; i < size; i++) {
            sb.append("?");
            if (i < size - 1) {
                sb.append(", ");
            }
        }
        sb.append(")"); // 마지막에 ')' 추가

        String result = sb.toString();
        return result;
	}


	public boolean report(Report report) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = ArticleSQL.REPORT;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setLong(1, report.getPNo());
			pstmt.setString(2, report.getEmail());
			pstmt.setString(3, report.getrContent());
			
			int i = pstmt.executeUpdate();
			if(i>0) return true;
			else return false;
		}catch(SQLException se) {
			System.out.println("SQL문 체크(원글): " + se);
			return false;
		}finally {
			try {
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se) {}			
		}
	}
	
	boolean isReportExist(Report report) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = ArticleSQL.REPORTCOUNT;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setLong(1, report.getPNo());
			pstmt.setString(2, report.getEmail());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {				
				int count = rs.getInt(1);
				
				if(count>0) return true;
			}
			return false;
		}catch(SQLException se) {
			System.out.println("SQL문 체크(원글): " + se);
			return false;
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se) {}			
		}
	}

	//공감 추가
	boolean addLike(long pNo, String email){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = ArticleSQL.INSERT_LIKE;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pNo);
			pstmt.setString(2, email);

			int i = pstmt.executeUpdate();
			return i > 0;
		}catch(SQLException se){
			System.out.println("SQL문 체크(공감insert): " + se);
			return false;
		}finally{
			try{
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}		
	}

	//공감수 조회
	int getLikeCount(long pNo){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = ArticleSQL.LIKECOUNT;

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

	//중복 공감 (특정 사용자의 특정 글)
	boolean isLiked(long pNo, String email){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = ArticleSQL.ISLIKE;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pNo);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();

			return rs.next(); //공감했으면 true
		}catch(SQLException se){
			System.out.println("SQL문 체크(isLiked): " + se);
			return false;
		}finally{
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}		
	}

	//북마크 추가
	boolean addBookmark(long pNo, String email){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = ArticleSQL.ADD_BOOKMARK;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setLong(1, pNo);
			pstmt.setString(2, email);

			int i = pstmt.executeUpdate();
			return i > 0; //추가성공 true
		}catch(SQLException se){
			System.out.println("SQL문 체크(addBookmark): " + se);
			return false;
		}finally{
			try{
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}
	}

	//북마크 삭제
	boolean deleteBookmark(long pNo, String email){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = ArticleSQL.DELBOOKMARK;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pNo);
			pstmt.setString(2, email);

			int i = pstmt.executeUpdate();
			return i > 0; //삭제 성공 시 true			
		}catch(SQLException se){
			System.out.println("SQL문 체크(deleteBookmark): " + se);
			return false;
		}finally{
			try{
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}
	}

	//북마크 중복체크
	boolean isBookmarked(long pNo, String email){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = ArticleSQL.ISBOOKMARK;

		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setLong(1, pNo);
			pstmt.setString(2, email);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				int i = rs.getInt(1); //count(*) 값
				return i > 0; //0보다 크면 true
			}
			return false;
		}catch(SQLException se){
			System.out.println("SQL문 오류(isBookmark): " + se);
			return false;
		}finally{
			try{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (con != null) con.close();
			}catch(SQLException se){}
		}
	}

	public ArrayList<Article> search(long cNo, String word, int pageNum, int rowCount) {
			ArrayList<Article> list = new ArrayList<>();
			String sql = ArticleSQL.SEARCH;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try{
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setLong(1, cNo);
				pstmt.setString(2, "%"+word+"%");
				pstmt.setString(3, "%"+word+"%");
				pstmt.setInt(4, rowCount);
				pstmt.setInt(5, (pageNum-1)*rowCount);
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
					String cName = rs.getString("CName");
					String nick = rs.getString("nick");

					list.add(new Article(articlePNo, subject, pContnet, pDate, views, pGNo, pGOrder, articleCNo, email, cName, nick));
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

		int getSearchCount(long cNo, String word) {
			String sql = ArticleSQL.SEARCH_COUNT;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setLong(1, cNo);
				pstmt.setString(2, "%" + word + "%");
				pstmt.setString(3, "%" + word + "%");
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
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (con != null)
						con.close();
				} catch (SQLException se) {
				}
			}
		}
	
	    public ArrayList<Article> aside(int firstPart) {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        ArrayList<Article> list = new ArrayList<>();
	        String sql = null;
	        if(firstPart == 2) {
	        	sql = ArticleSQL.QNALIST;
	        }else if(firstPart == 1){
	        	sql = ArticleSQL.COMLIST;
	        }else {
	        	sql = ArticleSQL.INFOLIST;
	        }
	
	
	        try {
	            con = ds.getConnection();
	            pstmt = con.prepareStatement(sql);
	            rs = pstmt.executeQuery();
	
				while(rs.next()){
					long articlePNo = rs.getLong("pNo");
					String subject = rs.getString("subject");
					String cName = rs.getString("CName");
					list.add(new Article(articlePNo, subject, null, null, -1, -1, -1, -1, null, cName));
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
