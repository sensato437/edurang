package main.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import main.model.MainService;
import mvc.domain.Article;
import mvc.domain.Member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/main.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10MB
		maxFileSize = 1024 * 1024 * 20, // 20MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)

public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String m = request.getParameter("m");
		if (m != null) {
			m = m.trim();
			switch (m) {
				case "content":
					break;
			}
		} else {
			main(request, response);
		}

	}

	private void main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 포워딩
		// String view = "../main.jsp";

		MainService service = MainService.getInstance();
		ArrayList<Article> qnalist = service.list("QNA");
		ArrayList<Article> comlist = service.list("COM");
		ArrayList<Article> infolist = service.list("INFO");
		
		request.setAttribute("qnalist", qnalist);
		request.setAttribute("comlist", comlist);
		request.setAttribute("infolist", infolist);

		RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
		rd.forward(request, response);

	}

}
