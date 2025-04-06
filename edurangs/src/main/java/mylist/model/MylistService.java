package mylist.model;

import java.util.ArrayList;

import mvc.domain.Article;
import mvc.domain.Report;

public class MylistService {
	private MylistDAO dao;
	
	private static final MylistService instance
	= new MylistService();
	private MylistService() {
		dao = new MylistDAO();
	}
	
	public static MylistService getInstance() {
		return instance;
	}
	
	//list 페이징
	public ArrayList<Article> listS(int pageNum, int rowCount){
		return dao.list(pageNum, rowCount);
	}
	
	public ArrayList<Article> catListS(int pageNum, int rowCount, int firstPart, int secondPart, String email){
		return dao.catList(pageNum, rowCount, firstPart, secondPart, email);
	}

	//list 총페이지 수 계산
	public int getTotalPageS(int rowCount, String email){
		int totalArticles = dao.getTotalArticlesCount(email);
		return (int) Math.ceil((double) totalArticles / rowCount);
	}

	public int getTotalArticlesCountS(String email){
		return dao.getTotalArticlesCount(email);
	}

	
	public ArrayList<Article> bookmarkListS(int pageNum, int rowCount, String email) {
		int totalBookmarks = getTotalBookmarkCountS(email);
		return dao.bookmarkList(pageNum, rowCount, email);
	}
	public int getTotalBookmarkCountS(String email) {
	    return dao.getTotalBookmarkCount(email);
	}

	//getLikeCount 공감수 조회
	public int getLikeCountS(long pNo){
		return dao.getLikeCount(pNo);
	}
}
