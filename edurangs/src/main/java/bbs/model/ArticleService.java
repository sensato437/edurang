package bbs.model;

import java.util.ArrayList;

import mvc.domain.Address;
import mvc.domain.Article;
import mvc.domain.Report;

public class ArticleService {
	private ArticleDAO dao;
	
	private static final ArticleService instance
	= new ArticleService();
	private ArticleService() {
		dao = new ArticleDAO();
	}
	
	public static ArticleService getInstance() {
		return instance;
	}
	
	/*public ArrayList<Article> listS(){
		return dao.list();
	}*/
	
	//list 페이징
	public ArrayList<Article> listS(int pageNum, int rowCount){
		return dao.list(pageNum, rowCount);
	}
	
	public ArrayList<Article> catListS(int pageNum, int rowCount, int firstPart, int secondPart){
		return dao.catList(pageNum, rowCount, firstPart, secondPart);
	}

	//list 총페이지 수 계산
	public int getTotalPageS(int rowCount, int secondPart){
		int totalArticles = dao.getTotalArticlesCount(secondPart);
		return (int) Math.ceil((double) totalArticles / rowCount);
	}

	public int getTotalArticlesCountS(int secondPart){
		return dao.getTotalArticlesCount(secondPart);
	}
	public int getTotalArticlesCountS(){
		return dao.getTotalArticlesCount();
	}
	public ArrayList<Article> listDetailS(int[] intList){
		return dao.listDeatil(intList);
	}
	
	//insert 작성
	public boolean insertS(Article article) {
		return dao.insert(article);
	}

	//insertReply 답글작성
	public boolean insertReplyS(Article article){
		return dao.insertReply(article);
	}
	
	//답글 max pGNo
	public int getMaxpGOrderS(int pGNo){
		return dao.getMaxpGOrder(pGNo);
	}

	//content 내용
	public Article contentS(Article article) {
		return dao.content(article);
	}
	
	//Views 조회수
	public void increaseViewS(long pNo) {
		dao.increaseView(pNo);
	}
	
	//delete 삭제
	public boolean deleteS(long pNo) {
		return dao.delete(pNo);
	}
	
	//update 수정
	public boolean updateS(Article article) {
		return dao.update(article);
	}


	public boolean reportS(Report report) {
		return dao.report(report);
	}
	
	public boolean isReportExistS(Report report) {
		return dao.isReportExist(report);
	}

	//addlike 공감
	public boolean addLikeS(long pNo, String email){
		return dao.addLike(pNo, email);
	}

	//getLikeCount 공감수 조회
	public int getLikeCountS(long pNo){
		return dao.getLikeCount(pNo);
	}

	//isLiked 중복공감 조회
	public boolean isLikedS(long pNo, String email){
		return dao.isLiked(pNo, email);
	}

	//addBookmark 북마크 추가
	public boolean addBookmarkS(long pNo, String email){
		return dao.addBookmark(pNo, email);
	}

	//deleteBookmark 북마크 삭제
	public boolean deleteBookmarkS(long pNo, String email){
		return dao.deleteBookmark(pNo, email);
	}

	//isBookmark 북마크 중복
	public boolean isBookmarkedS(long pNo, String email){
		return dao.isBookmarked(pNo, email);
	}

	public ArrayList<Article> searchS(long cNo, String word, int pageNum, int rowCount) {
		return dao.search(cNo, word, pageNum, rowCount);
	}

	public int getSearchCountS(long cNo, String word) {
		return dao.getSearchCount(cNo, word);
	}
	
	public ArrayList<Article> asideS(int firstPart) {
		return dao.aside(firstPart);
	}
}
