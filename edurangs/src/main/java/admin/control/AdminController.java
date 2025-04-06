package admin.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvc.domain.Article;
import mvc.domain.Blacklist;
import mvc.domain.ReportDetail;
import mvc.domain.SignUpMember;
import mvc.domain.Statistics;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import com.google.gson.Gson;

import admin.model.AdminService;
import bbs.model.ArticleService;

@WebServlet("/admin/admin.do")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String m = request.getParameter("m");
		if (m != null) {
			m = m.trim();
			switch (m) {
				case "report" : report(request, response); break;
				case "board" : board(request, response); break;
				case "blacklist" : blacklist(request,response); break;
				default : main(request,response); break;
			}
		}else
			main(request, response);
	}
	private void main(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String view = "admin.jsp";
		
		AdminService service = AdminService.getInstance();
		ArrayList<Statistics> statis = service.pBoardStatisticsS();
		ArrayList<SignUpMember> mstatis = service.signUpStatisticsS();
		Gson gson = new Gson();
		String jsonSta = gson.toJson(statis);
		request.setAttribute("jsonSta", jsonSta);
		String jsonSUM = gson.toJson(mstatis);
		request.setAttribute("jsonSUM", jsonSUM);
		
		ArticleService aService = ArticleService.getInstance();
		ArrayList<Article> list = aService.listS(1, 5);
		request.setAttribute("list", list);
		
		long size = aService.getTotalArticlesCountS();
		
		
		size = (int)Math.ceil(size/5.0);
		request.setAttribute("size", size);
		
		request.setAttribute("page", 1);
		
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
	}
	
	private void report(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		AdminService service = AdminService.getInstance();
		String pageStr = request.getParameter("page");
		int page = Integer.parseInt(pageStr);
		if(page<0)
			page = 1;
		ArrayList<ReportDetail> data = service.reportListS(page);
		Gson gson = new Gson();
		
		HashMap<String, Object> responseMap = new HashMap<>();
		
		long size = service.reportSizeS();
		
		size= (long)Math.ceil(size/5.0);
		
	    responseMap.put("page", page);  // 페이지 번호
	    responseMap.put("data", data);
	    responseMap.put("size", size);
		
	    String json = gson.toJson(responseMap);
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        
	}
	
	private void board(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ArticleService service = ArticleService.getInstance();
		String pageStr = request.getParameter("page");
		int page = Integer.parseInt(pageStr);
		if(page<0)
			page = 1;
		ArrayList<Article> data = service.listS(page,5);
		Gson gson = new Gson();
		
		HashMap<String, Object> responseMap = new HashMap<>();
		
		long size = service.getTotalArticlesCountS();
		size= (long)Math.ceil(size/5.0);
	    responseMap.put("page", page);  // 페이지 번호
	    responseMap.put("data", data);
	    responseMap.put("size", size);
		
	    String json = gson.toJson(responseMap);
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        
	}
	
	private void blacklist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		AdminService service = AdminService.getInstance();
		String pageStr = request.getParameter("page");
		int page = Integer.parseInt(pageStr);
		if(page<0)
			page = 1;
		ArrayList<Blacklist> data = service.blacklistS(page);
		Gson gson = new Gson();
		
		HashMap<String, Object> responseMap = new HashMap<>();
		
		long size = service.blackSizeS();
		
		size= (long)Math.ceil(size/5.0);
		
	    responseMap.put("page", page);  // 페이지 번호
	    responseMap.put("data", data);
	    responseMap.put("size", size);
		
	    String json = gson.toJson(responseMap);
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        
	}
}
