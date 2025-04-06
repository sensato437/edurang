package login.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import login.model.LoginConst;
import login.model.LoginService;
import mvc.domain.Member;
import mvc.listener.LoginInfo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

@WebServlet("/login/login.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String m = request.getParameter("m");
		if (m != null) {
			m = m.trim();
			switch (m) {
				case "loginform": loginform(request,response); break;
				case "login": login(request,response); break;
				case "form": form(request,response); break;
				case "signup": signup(request,response); break;
				case "editProfile": editProfile(request,response); break;
				case "updateProfile": updateProfile(request,response); break;
				case "withdraw": withdraw(request,response); break;
				case "emailCheck": emailCheck(request,response); break;
				case "logout": logout(request,response); break;
				case "nickCheck": nickCheck(request,response); break;
				case "restore": restore(request,response); break;
				case "getPoint": getPoint(request,response); break;
			}
		} else {
			loginform(request, response);
		}
	}
	protected void loginform(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String redirectUrl = request.getParameter("redirect");
	    if (redirectUrl != null && !redirectUrl.isEmpty()) {
	        request.setAttribute("redirect", redirectUrl);
	    }
		 RequestDispatcher rd = request.getRequestDispatcher("/login/login.jsp");
	        rd.forward(request, response);
	}

	protected void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    //파라미터 확인하기
		java.util.Enumeration<String> params = request.getParameterNames();
	    while (params.hasMoreElements()) {
	        String paramName = params.nextElement();
	    }
		//입력값 받아옴
		String email = request.getParameter("email");
		String pwd = request.getParameter("password");

		//Validate check
		LoginService service = LoginService.getInstance();
		int result = service.check(email, pwd);
		
		//로그인 성공 → 세션에 사용자 정보를 저장
		if(result == LoginConst.YES_ID_PWD){
			//기존 세션 무효화 → NEW세션 생성
			HttpSession oldSession = request.getSession(false);
			if(oldSession != null){
				oldSession.invalidate();
			}
			HttpSession newSession = request.getSession(true);
			Member member = service.LoginS(email, pwd);
			//비밀번호 무효화
			member.setPwd("");
			newSession.setAttribute("member", member);
			//리스너
			LoginInfo info = new LoginInfo(email);
			// 리다이렉트 URL 처리
	        String redirectUrl = request.getParameter("redirect");
	        if (redirectUrl != null && !redirectUrl.isEmpty()) {
	        	redirectUrl = java.net.URLDecoder.decode(redirectUrl, "UTF-8");
	            response.sendRedirect(redirectUrl);
	        } else {
	            response.sendRedirect("/edurang/main.do");
	        }
		} else if (result == LoginConst.DELETED_USER) {
		    // 탈퇴된 회원
		    request.setAttribute("error", "4");
		    RequestDispatcher rd = request.getRequestDispatcher("/login/login.jsp");
		    rd.forward(request, response);
		}else{
			//로그인 실패함ㅠ
			request.setAttribute("error", "1");
			RequestDispatcher rd = request.getRequestDispatcher("/login/login.jsp");
	        rd.forward(request, response); //다시 로그인 페이지로
		}
	}
	protected void form(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 RequestDispatcher rd = request.getRequestDispatcher("/login/form.jsp");
	        rd.forward(request, response);
	}
	protected void signup(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String emailId = request.getParameter("emailId");
		String emaildomain = request.getParameter("emailDomain");
		String email = emailId + "@" + emaildomain;
		String pwd = request.getParameter("password");
		String name = request.getParameter("userName");
		String nick = request.getParameter("userId");
		String birthdayYear = request.getParameter("birthdayYear");
		String birthdayMonth = request.getParameter("birthdayMonth");
		String birthdayDay = request.getParameter("birthdayDay");
		String birthStr = birthdayYear+"-"+birthdayMonth+"-"+birthdayDay;
		
        Date birth = Date.valueOf(birthStr);
		LoginService service = LoginService.getInstance();
		Member member = new Member(email,pwd,name,nick,birth);
		
		boolean flag = service.signupS(member);
        request.setAttribute("flag", flag);

		//회원가입 성공하면 메시지 띄워주고 메시지에서는 메인으로 보내주기!
        String view = "signupMsg.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
	}
	protected void editProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 HttpSession session = request.getSession();
		 if (session == null || session.getAttribute("member") == null) {
			    // 세션이 없거나 member 객체가 없는 경우, 로그인 페이지로 리다이렉트
			    response.sendRedirect("/login/login.jsp");
			    return;
			}
		 Member member = (Member) session.getAttribute("member");
		 
		 request.setAttribute("emailId", member.getEmail().split("@")[0]); // 이메일 아이디
	     request.setAttribute("emailDomain", member.getEmail().split("@")[1]); // 이메일 도메인
	     request.setAttribute("nick", member.getNick()); // 닉네임
	     request.setAttribute("name", member.getName()); // 이름
	     request.setAttribute("birth", member.getBirth()); // 생년월일
		 
		 RequestDispatcher rd = request.getRequestDispatcher("/login/editProfile.jsp");
	     rd.forward(request, response);
	}
	protected void updateProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청 데이터 확인
		BufferedReader reader = request.getReader();
	    StringBuilder jsonBuilder = new StringBuilder();
	    String line;
	    
	    while ((line = reader.readLine()) != null) {
	        jsonBuilder.append(line);
	    }

	    // JSON 데이터
	    String jsonData = jsonBuilder.toString();

	    // JSON 데이터 파싱
	    Gson gson = new Gson();
	    Map<String, String> data = gson.fromJson(jsonData, Map.class);  // 수정: request.getReader() 대신 jsonData 사용

	    // 세션에서 회원 정보 가져오기
	    HttpSession session = request.getSession();
	    Member member = (Member) session.getAttribute("member");
	    if (member == null) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        return;
	    }
	    
	 // 수정된 필드 업데이트
	    if (data.containsKey("userId") && data.get("userId") != null && !data.get("userId").isEmpty()) {
	        member.setNick(data.get("userId"));
	    }
	    if (data.containsKey("password") && data.get("password") != null && !data.get("password").isEmpty()) {
	        member.setPwd(data.get("password"));
	    }else {
	        // 비밀번호가 빈 값인 경우, 기존 비밀번호 유지
	        member.setPwd(null); // null로 설정하여 DAO에서 처리
	    }

	    // 회원정보 업데이트
	    LoginService service = LoginService.getInstance();
	    boolean success = service.updateProfileS(member);

	    // 응답 전송
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();
	    out.print("{\"success\": " + success + "}");
	    out.flush();
	}
	protected void withdraw(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    // 세션에서 회원 정보 가져오기
	    HttpSession session = request.getSession();
	    //세션 받아와지는지 확인
	    request.getSession().getId();
	    Member member = (Member) session.getAttribute("member");
	    if (member == null) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        return;
	    }
	    
	    // 회원정보 업데이트
	    LoginService service = LoginService.getInstance();
	    boolean success = service.withdrawS(member);

	    if (success) {
	        session.invalidate(); // 세션 무효화
	        response.sendRedirect("../main.do"); // 홈페이지로 리다이렉트
	    } else {
	        response.sendRedirect("/edurang/login/editProfile.jsp"); // 실패 시 프로필 페이지로 리다이렉트
	    }
	}
	protected void restore(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    LoginService service = LoginService.getInstance();
	    boolean success = service.restoreS(email, password);

	    if (success) {
	        // 복원 성공 시, 로그인 페이지로 리다이렉트
	        response.sendRedirect("/edurang/login/login.jsp");
	    } else {
	        // 복원 실패 시, 에러 메시지 표시
	        request.setAttribute("error", "비밀번호가 일치하지 않거나 복원에 실패했습니다.");
	        RequestDispatcher rd = request.getRequestDispatcher("/login/login.jsp");
	        rd.forward(request, response);
	    }
	}
	private void logout(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		LoginService service = LoginService.getInstance();
		Member member = (Member) session.getAttribute("member");
		String email = member.getEmail();
		service.LogOutState(email);
		session.invalidate();
		
		response.setContentType("application/json; charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    out.print("{\"sessionExpired\": true, \"redirect\": false}"); // redirect를 false로 설정
	    out.flush();
	}
	private void nickCheck(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String nick = request.getParameter("nick");
		LoginService service = LoginService.getInstance();
		boolean check = service.checkNickS(nick);
		response.setContentType("application/json"); // JSON 형식 설정
	    response.setCharacterEncoding("UTF-8");
	    
	    PrintWriter out = response.getWriter();
	    out.print("{\"result\": " + check + "}"); // JSON 객체로 응답
	    out.flush();
	}
	private void emailCheck(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String email = request.getParameter("email");
		LoginService service = LoginService.getInstance();
		boolean check = service.checkEmailS(email);
		response.setContentType("application/json"); // JSON 형식 설정
	    response.setCharacterEncoding("UTF-8");
	    
	    PrintWriter out = response.getWriter();
	    out.print("{\"result\": " + check + "}"); // JSON 객체로 응답
	    out.flush();
	}
	private void getPoint(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
	    Member member = (Member) session.getAttribute("member");
	    if (member == null) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
	        return;
	    }
        String email = member.getEmail();
        
        LoginService service = LoginService.getInstance();
        Map<String, Object> result = service.getPointS(email); // 포인트 조회 로직
        if (result == null) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            return;
        }
        
        // JSON으로 변환
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(result);
        
        // 응답 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
	}
}
