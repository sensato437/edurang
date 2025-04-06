package mylist.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import mvc.domain.*;
import mylist.model.MylistService;
import bbs.model.ArticleService;
import comment.model.CommentService;

@WebServlet("/mylist.do")
public class MylistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String m = request.getParameter("m");
		if (m != null) {
			m = m.trim();
			switch (m) {			
				case "list": catList(request, response); break;
				case "bookmark": bookmarkList(request, response); break;
			}
		} else {
			//list(request, response);
			catList(request, response);
		}
	}

	private Member checkSession(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");

		//세션 만료됨
		if(member == null){
			request.setAttribute("errorMsg", "세션이 만료되었습니다. 다시 로그인해주세요.");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return null;
		}

		return member;
	}

	public void catList(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    int pageNum = request.getParameter("pageNum") != null ? Integer.parseInt(request.getParameter("pageNum")) : 1;
	    int rowCount = request.getParameter("rowCount") != null ? Integer.parseInt(request.getParameter("rowCount")) : 15;
	    
	    int firstPart = 0;
	    int secondPart = 0;
	    
	    HttpSession session = request.getSession();
	    Member member = (Member) session.getAttribute("member");
	    String email = member.getEmail(); // 세션에서 사용자 이메일 가져오기
	    
	    String catValue = request.getParameter("cat");
	    if (catValue != null) {
	        String[] catParts = catValue.split("-");
	        firstPart = Integer.parseInt(catParts[0]);
	        secondPart = Integer.parseInt(catParts[1]);
	    }
	    
	    MylistService service = MylistService.getInstance();
	    ArrayList<Article> articles = service.catListS(pageNum, rowCount, firstPart, secondPart, email); // 게시글 목록
	    
	    int totalArticles = service.getTotalArticlesCountS(email); //총 게시글 수
	    int totalPages = service.getTotalPageS(rowCount, email); //총 페이지 수

	    Map<Long, Integer> likesMap = new HashMap<>();
	    for (Article article : articles){
	        int likes = service.getLikeCountS(article.getpNo()); //pNo의 공감수
	        likesMap.put(article.getpNo(), likes);
	    }
	    request.setAttribute("list", articles);
        request.setAttribute("totalArticles", totalArticles); // 총 게시글 수
        request.setAttribute("totalPages", totalPages); // 총 페이지 수        
        request.setAttribute("pageNum", pageNum); // 현재 페이지 번호
        request.setAttribute("rowCount", rowCount); // 표시할 게시글 단위
        request.setAttribute("likesMap", likesMap); //공감수

        //jsp로 포워딩
        String view = "/bbs/mylist.jsp";
        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
	}
	
	private void bookmarkList(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    Member member = checkSession(request, response);
	    if (member == null) return;

	    int pageNum = 1;
	    int rowCount = 15;

	    try {
	        pageNum = Integer.parseInt(request.getParameter("pageNum"));
	    } catch (NumberFormatException e) {
	        pageNum = 1;
	    }

	    try {
	        rowCount = Integer.parseInt(request.getParameter("rowCount"));
	    } catch (NumberFormatException e) {
	        rowCount = 15;
	    }

	    MylistService service = MylistService.getInstance();
	    ArrayList<Article> articles = service.bookmarkListS(pageNum, rowCount, member.getEmail());
	    
	    Map<Long, Integer> likesMap = new HashMap<>();
	    for (Article article : articles) {
	        int likes = service.getLikeCountS(article.getpNo());
	        likesMap.put(article.getpNo(), likes);
	    }

	    int totalArticles = service.getTotalBookmarkCountS(member.getEmail()); // 북마크된 게시글 수 계산
	    int totalPages = (int) Math.ceil((double) totalArticles / rowCount);

	    request.setAttribute("list", articles);
	    request.setAttribute("totalArticles", totalArticles);
	    request.setAttribute("totalPages", totalPages);
	    request.setAttribute("pageNum", pageNum);
	    request.setAttribute("rowCount", rowCount);
	    request.setAttribute("likesMap", likesMap);

	    String view = "/bbs/mylist.jsp";
	    RequestDispatcher rd = request.getRequestDispatcher(view);
	    rd.forward(request, response);
	}

}