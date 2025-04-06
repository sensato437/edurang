package comment.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mvc.domain.Comments;
import mvc.domain.Member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import comment.model.CommentService;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/comment.do")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String m = request.getParameter("m");

		if (m != null) {
			m = m.trim();
			switch (m) {
				case "save":
					insert(request, response);
					break;
				case "rsave":
					rinsert(request, response);
					break;
				case "delete":
					delete(request, response);
					break;
				case "reload":
					reload(request, response);
					break;
			}
		} else {

		}
	}

	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		String email = member.getEmail(); // 세션에서 사용자 이메일 가져오기
		String comments = request.getParameter("title");
		String pNoStr = request.getParameter("pNo");
		long pNo = Long.parseLong(pNoStr);

		// 답글 작성 시 필요한 정보 설정(coNo, comments, coDate, cgNo, cgOrder, email, pNo)
		Comments comment = new Comments(-1, comments, null, -1, -1, email, pNo);

		CommentService service = CommentService.getInstance();
		boolean flag = service.insertS(comment);

	}

	private void rinsert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		String email = member.getEmail(); // 세션에서 사용자 이메일 가져오기
		String comments = request.getParameter("title");
		String pNoStr = request.getParameter("pNo");
		long pNo = Long.parseLong(pNoStr);
		String coNoStr = request.getParameter("coNo");
		long coNo = Long.parseLong(coNoStr);

		// 답글 작성 시 필요한 정보 설정(coNo, comments, coDate, cgNo, cgOrder, email, pNo)
		Comments comment = new Comments(coNo, comments, null, -1, -1, email, pNo);

		if(type.equals("save")) {	
			CommentService service = CommentService.getInstance();
			boolean result = service.rInsertS(comment);
		} else if(type.equals("update")) {
			CommentService service = CommentService.getInstance();
			boolean result = service.updateS(comment);
		}

		// JSON 응답 반환
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"status\": \"success\"}");

	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 유효성 검사 추가
		String coNostr = request.getParameter("coNo");
		long coNo = Long.parseLong(coNostr);

		CommentService service = CommentService.getInstance();
		boolean result = service.deleteS(coNo);

		// JSON 응답 반환
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"status\": \"success\"}");

	}

	private void reload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentService service = CommentService.getInstance();
		long pNo = Long.parseLong(request.getParameter("pNo"));
		ArrayList<Comments> list = service.list(pNo);
		Gson gson = new Gson();
		String json = gson.toJson(list);

		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		String email = null; // 기본값을 null로 설정

	    // member가 null이 아닐 때만 이메일 가져오기
	    if (member != null) {
	        email = member.getEmail();
	    }

		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("sessionEmail", email);
		jsonObject.add("data", JsonParser.parseString(json)); // 기존 JSON 데이터 포함

		// 최종 JSON 문자열로 변환
		String finalJson = gson.toJson(jsonObject);

		try {
			response.setContentType("application/json;charset=utf-8");
			PrintWriter pw = response.getWriter();
			pw.print(finalJson);
		} catch (IOException ie) {
			// TODO: handle exception
		}
	}

}
