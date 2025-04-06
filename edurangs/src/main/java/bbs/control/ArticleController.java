package bbs.control;

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

import mvc.domain.*;
import bbs.model.ArticleService;
import comment.model.CommentService;

@WebServlet("/bbs/list.do")
public class ArticleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String m = request.getParameter("m");
		if (m != null) {
			m = m.trim();
			switch (m) {
				// case "mylist": mylist(request, response); break;
				case "list":
					catList(request, response);
					break;
				case "input":
					input(request, response);
					break; // 글작성페이지
				case "insert":
					insert(request, response);
					break; // 글작성후
				case "insertReply":
					insertReply(request, response); // 답글작성
				case "content":
					content(request, response);
					break; // 글내용
				case "delete":
					delete(request, response);
					break; // 글삭제
				case "ucontent":
					ucontent(request, response);
					break; // 글수정에서 기존글 조회
				case "update":
					update(request, response);
					break; // 글수정
				case "report":
					report(request, response);
					break; // 글신고
				case "like":
					like(request, response);
					break; // 글공감
				case "bookmark":
					bookmark(request, response);
					break; // 글북마크
				// default: catlist(request,response); break;
			}
		} else {

			catList(request, response);
		}
	}

	private Member checkSession(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");

		// 세션 만료됨
		if (member == null) {
			request.setAttribute("errorMsg", "세션이 만료되었습니다. 다시 로그인해주세요.");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return null;
		}

		return member;
	}

	public void catList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageNum = request.getParameter("pageNum") != null ? Integer.parseInt(request.getParameter("pageNum")) : 1;
		int rowCount = request.getParameter("rowCount") != null ? Integer.parseInt(request.getParameter("rowCount"))
				: 15;

		int firstPart = 0;
		int secondPart = 0;

		// 카테고리 (1(메인카테고리)-1(중간카테고리) 형식)
		String catValue = request.getParameter("cat");
		if (catValue != null) {
			String[] catParts = catValue.split("-");
			// 분리된 값을 처리
			firstPart = Integer.parseInt(catParts[0]);
			secondPart = Integer.parseInt(catParts[1]);
		}

		// 검색어가 있는지 확인
		String searchWord = request.getParameter("word");
		boolean isSearch = searchWord != null && !searchWord.trim().isEmpty();

		ArticleService service = ArticleService.getInstance();
		ArrayList<Article> articles;
		int totalArticles;
		int totalPages;

		if (isSearch) {
			// 검색 결과 처리
			articles = service.searchS(secondPart, searchWord, pageNum, rowCount);
			totalArticles = service.getSearchCountS(secondPart, searchWord);
			totalPages = (totalArticles + rowCount - 1) / rowCount;
		} else {
			// 전체 리스트 처리
			articles = service.catListS(pageNum, rowCount, firstPart, secondPart);
			totalArticles = service.getTotalArticlesCountS(secondPart);
			totalPages = service.getTotalPageS(rowCount, secondPart);
		}

		// 각 글들의 공감수 조회
		Map<Long, Integer> likesMap = new HashMap<>();
		for (Article article : articles) {
			int likes = service.getLikeCountS(article.getpNo()); // pNo의 공감수
			likesMap.put(article.getpNo(), likes);
		}

		// AJAX 요청인지 확인
		String requestType = request.getHeader("X-Requested-With");
		if ("XMLHttpRequest".equals(requestType)) { // AJAX 요청이면 HTML 목록만 반환
			System.out.println(totalArticles);
			StringBuilder sb = new StringBuilder();
			sb.append("<div id='totalArticles' style='display:none;'>").append(totalArticles).append("</div>"); // totalArticles를
																												// 숨겨진
																												// div에
																												// 포함
			sb.append("<div class='board_top'>");
			sb.append("<div class='board_top_total'>게시글 <span>").append(totalArticles).append("</span></div>");
			sb.append("<a href='#' class='modal_btn board_top_guide' data-modal-id='board_rules'>게시판 이용 수칙</a>");
			sb.append("<div class='board_top_left'>");
			sb.append(
					"<select id='bbsRowCount' name='bbsRowCount' onchange='fnOrdPage();' class='select_gray board_top_limit'>");
			sb.append("<option value='15'>15개씩 보기</option>");
			sb.append("<option value='30'>30개씩 보기</option>");
			sb.append("<option value='50'>50개씩 보기</option>");
			sb.append("</select>");
			sb.append("</div>");
			sb.append("</div>");

			sb.append("<ul class='board'>");
			sb.append("<li class='board_head'>");
			sb.append("<div class='w70 board_num'>번호</div>");
			sb.append("<div class='w110 board_sort'>분류</div>");
			sb.append("<div class='board_subject'>제목</div>");
			sb.append("<div class='w120 board_writer'>작성자</div>");
			sb.append("<div class='w70 board_count'>조회수</div>");
			sb.append("<div class='w70 board_count'>공감수</div>");
			sb.append("<div class='w100 board_date'>등록일</div>");
			sb.append("</li>");

			// 공지사항 항목 추가
			sb.append("<li class='board_notice'>");
			sb.append("<a href='/edurang/bbs/list.do?m=content&pNo=0'>");
			sb.append("<div class='w70 board_num'><span class='board_notice_tag'>공지</span></div>");
			sb.append("<div class='w110 board_sort'>-</div>");
			sb.append("<div class='board_subject'>");
			sb.append("<span class='board_subject_text'>[수능] 2026년까지 화이팅!</span>");
			sb.append("<span class='board_subject_reply'></span>");
			sb.append("<span></span>");
			sb.append("</div>");
			sb.append("<div class='w120 board_writer'><span>운영자</span></div>");
			sb.append("<div class='w70 board_count'>9,999</div>");
			sb.append("<div class='w70 board_likes'>100</div>");
			sb.append("<div class='w100 board_date'>2025-01-01</div>");
			sb.append("</a>");
			sb.append("</li>");
			// 공지사항 끝

			for (Article article : articles) {

				sb.append("<li class='");
				if (article.getpGOrder() > 0) {
					sb.append("reply");
				}
				sb.append("'>");
				sb.append("<a href='#' onclick='fnView(" + article.getpNo() + ", " + article.getcNo()
						+ "); return false;'>");
				sb.append("<div class='w70 board_num' style='");
				if (article.getpGOrder() > 0) {
					sb.append("width: 7rem;");
				}
				sb.append("'>").append(article.getpNo()).append("</div>");
				sb.append("<div class='w110 board_sort'>" + article.getcName() + "</div>");
				sb.append("<div class='board_subject'>");
				if (article.getpGOrder() > 0) {
					sb.append(
							"<img src='/edurang/resource/img/ico_arrow_reply_large.png' style='width: 20px !important; height: 20px !important; vertical-align: middle !important; display: inline-block; margin-right: 0.7em;'/>");
				}
				sb.append("<span class='board_subject_text'>" + article.getSubject() + "</span>");
				sb.append("<span class='board_subject_reply'></span>");
				sb.append("<span class='board_subject_new'></span>");
				sb.append("</div>");
				sb.append("<div class='w120 board_writer'>" + article.getNick() + "</div>");
				sb.append("<div class='w70 board_count'>" + article.getViews() + "</div>");
				sb.append("<div class='w70 board_likes'>" + likesMap.get(article.getpNo()) + "</div>");
				sb.append("<div class='w100 board_date'>" + article.getpDate() + "</div>");
				sb.append("</a>");
				sb.append("</li>");
			}
			sb.append("</ul>");

			sb.append("<div class='contents_bottom'>");
			sb.append("<div class='pagination' id='pagingDiv'></div>");

			sb.append("<div class='contents_bottom_right'>");
			sb.append("<br>");
			sb.append("<a href='#' onclick='fnForm(); return false;' class='btn_write btn_red'>글쓰기</a>");
			sb.append("</div>");
			sb.append("</div>");

			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write(sb.toString());
		} else { // AJAX가 아닌 일반 요청일 경우, JSP로 포워딩
			request.setAttribute("list", articles);
			request.setAttribute("totalArticles", totalArticles); // 총 게시글 수
			request.setAttribute("totalPages", totalPages); // 총 페이지 수
			request.setAttribute("pageNum", pageNum); // 현재 페이지 번호
			request.setAttribute("rowCount", rowCount); // 표시할 게시글 단위
			request.setAttribute("likesMap", likesMap); // 공감수
			request.setAttribute("isSearch", isSearch); // 검색 여부 플래그 추가

			// aside
			ArrayList<Article> asideList = service.asideS(firstPart);
			request.setAttribute("asideList", asideList);

			// artclList.jsp로 포워딩
			String view = "/bbs/artclList.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(view);
			rd.forward(request, response);
		}

	}

	protected void input(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pNo = request.getParameter("pNo");
		String catValue = request.getParameter("cat");

		// String[] catParts = catValue.split("-");

		if (pNo != null) {
			request.setAttribute("pNo", pNo);
			request.setAttribute("cat", catValue);
		}

		// cNo 넘기려고 forwarding 함
		String view = "artclForm.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
	}

	protected void insert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Member member = checkSession(request, response);
		if (member == null)
			return;

		String email = member.getEmail();

		// title(subject), bd(content) 가져오기
		String subject = request.getParameter("title");
		String pContent = request.getParameter("bd");

		String catStr = request.getParameter("cat");

		String catParts[] = catStr.split("-");

		request.setAttribute("cat", catStr); // okMsg.jsp 로

		long cNo = Long.parseLong(catParts[1]); // insert의 cNo

		Article article = new Article(-1L, subject, pContent, null, 0, 0, 0, cNo, email, null);

		ArticleService service = ArticleService.getInstance();
		boolean flag = service.insertS(article);

		request.setAttribute("flag", flag); // okMsg.jsp 로
		request.setAttribute("msg", "글 등록이 완료되었습니다. 글을 등록한 카테고리 게시판으로 이동합니다."); // okMsg.jsp 로

		RequestDispatcher rd = request.getRequestDispatcher("okMsg.jsp");
		rd.forward(request, response);
	}

	protected void insertReply(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Member member = checkSession(request, response);
		if (member == null)
			return;

		String email = member.getEmail();

		// 원글 pNo, subject, content get!
		long pNo = Long.parseLong(request.getParameter("pNo")); // 원글의 pNo
		// long cNo = Long.parseLong(request.getParameter("cNo"));
		String subject = request.getParameter("title");
		String pContent = request.getParameter("bd");

		//
		String catStr = request.getParameter("cat");
		String catParts[] = catStr.split("-");

		request.setAttribute("cat", catStr); // okMsg.jsp로 넘기는 ${cat} ex:1-4

		// long cNo = Long.parseLong(catParts[1]); // insert의 cNo

		ArticleService service = ArticleService.getInstance();
		Article article = new Article(pNo, null, null, null, 0, 0, 0, 0, email, null);
		Article parentArticle = service.contentS(article);
		int pGNo = parentArticle.getpGNo(); // 원글 pgno
		// int pGOrder = parentArticle.getpGOrder(); //원글pgorder
		long cNo = parentArticle.getcNo(); // 원글 cno

		int maxpGOrder = service.getMaxpGOrderS(pGNo);

		// 답글 객체
		Article reply = new Article();
		reply.setSubject(subject);
		reply.setpContent(pContent);
		reply.setpGNo(pGNo); //
		reply.setpGOrder(maxpGOrder + 1); // pGOrder +1 증가
		reply.setcNo(cNo); //
		reply.setEmail(email);

		// 답글 작성
		boolean flag = service.insertReplyS(reply);
		request.setAttribute("flag", flag); // okMsg.jsp 로
		request.setAttribute("msg", "답글 등록이 완료되었습니다. 글을 등록한 카테고리 게시판으로 이동합니다."); // okMsg.jsp 로

		RequestDispatcher rd = request.getRequestDispatcher("okMsg.jsp");
		rd.forward(request, response);
	}

	protected void content(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int firstPart = 0;

		// 카테고리 (1(메인카테고리)-1(중간카테고리) 형식)
		String catValue = request.getParameter("cat");
		if (catValue != null) {
			String[] catParts = catValue.split("-");
			// 분리된 값을 처리
			firstPart = Integer.parseInt(catParts[0]);
		}

		// 요청 GET으로 (pNo값) 받아옴
		try {
			long pNo = Long.parseLong(request.getParameter("pNo"));
			// long cNo = Long.parseLong(request.getParameter("cNo"));

			ArticleService service = ArticleService.getInstance();
			service.increaseViewS(pNo); // 조회수 증가 호출

			// 댓글도 가져옴
			CommentService cservice = CommentService.getInstance();
			List<Comments> comment = cservice.list(pNo);

			// Article 객체 생성 수 pNo 전달
			Article article = new Article();
			article.setpNo(pNo);

			/*
			 * 후에 카테고리 생기면 확인 Category category = new Category(); category.setcNo(cNo);
			 */

			Article content = service.contentS(article); // article객체 content (글 상세정보 조회)
			int likes = service.getLikeCountS(pNo);

			// content에 scope명 설정
			request.setAttribute("content", content);
			request.setAttribute("comments", comment); // 댓글
			request.setAttribute("likes", likes);

			// aside
			ArrayList<Article> asideList = service.asideS(firstPart);
			request.setAttribute("asideList", asideList);

			if (!response.isCommitted()) {
				// String view = "artclView.jsp";
				RequestDispatcher rd = request.getRequestDispatcher("/bbs/artclView.jsp");
				rd.forward(request, response);
			}
			// return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 세션 검증
		Member member = checkSession(request, response);
		if (member == null)
			return; // checkSession이 포워딩이라 다시 return 필요

		long pNo = Long.parseLong(request.getParameter("pNo")); // 삭제할 글 pNo

		ArticleService service = ArticleService.getInstance();

		// Article(글)의 pNo를 가져와서 email 조회
		Article article = new Article();
		article.setpNo(pNo);
		Article content = service.contentS(article);

		// 삭제할 글 없어
		if (content == null) {
			request.setAttribute("errorMsg", "해당 글은 이미 삭제된 상태입니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return;
		}

		// member.email == content.email
		String writerEmail = content.getEmail();
		String memberEmail = member.getEmail();
		if (!writerEmail.equals(memberEmail)) {
			request.setAttribute("errorMsg", "본인 글만 삭제할 수 있습니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return;
		}

		String cat = request.getParameter("cat");
		// request.setAttribute("cat", cat);

		boolean flag = service.deleteS(pNo);

		request.setAttribute("flag", flag); // okMsg.jsp 로
		request.setAttribute("cat", cat); // okMsg.jsp 로
		request.setAttribute("msg", "글을 성공적으로 삭제했습니다."); // okMsg.jsp 로

		RequestDispatcher rd = request.getRequestDispatcher("okMsg.jsp");
		rd.forward(request, response);

		// 내 글 삭제할래!
		// service.deleteS(pNo);
		// response.sendRedirect("list.do?cat=" + cat);
	}

	protected void ucontent(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 세션 검증
		Member member = checkSession(request, response);
		if (member == null)
			return;

		String memberEmail = member.getEmail(); // 로그인된 멤버 email

		// 수정할 글 pNo 파라미터 받기
		long pNo = Long.parseLong(request.getParameter("pNo"));

		ArticleService service = ArticleService.getInstance();

		// Article 객체 생성 → pNo 설정
		Article article = new Article();
		article.setpNo(pNo);

		// 기존 글 내용 조회(content 재활용)
		// content(request, response);
		Article content = service.contentS(article);

		// 글 조회 실패 (삭제된 글이라면)
		if (content == null) {
			request.setAttribute("errorMsg", "해당 글 찾을 수 없음");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return;
		}

		// 네 글이니?
		String writerEmail = content.getEmail(); // 글의 멤버 email
		if (!writerEmail.equals(memberEmail)) { // 아니야
			request.setAttribute("errorMsg", "본인 글만 수정할 수 있음");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return;
		}

		// 내 글 맞아
		request.setAttribute("content", content);

		// String view = "/bbs/artclUpForm.jsp";
		String view = "/bbs/artclUpForm.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
	}

	protected void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Member member = checkSession(request, response);
		if (member == null)
			return;

		// 유저 입력값(request가 보낸 데이터) pNo, subject, pContent
		long pNo = Long.parseLong(request.getParameter("pNo")); // 링크에서 넘겨받음음
		String subject = request.getParameter("title");
		String pContent = request.getParameter("bd");
		String cat = request.getParameter("cat");

		request.setAttribute("cat", cat); // mokMsg로 전달
		request.setAttribute("pNo", pNo); // mokMsg로 전달

		// DB에서 가져올 데이터 (글 작성자 email)
		ArticleService service = ArticleService.getInstance();
		Article article = new Article();
		article.setpNo(pNo); // DTO에서 조회함
		Article content = service.contentS(article);
		if (content == null) {
			request.setAttribute("errorMsg", "해당 글을 찾을 수 없습니다. 글 번호(" + pNo + ")가 유효하지 않거나 글이 삭제되었을 수 있습니다.");
			RequestDispatcher rd = request.getRequestDispatcher("/bbs/error.jsp");
			rd.forward(request, response);
			return;
		}

		// 네 글이니? (member.email == content.email)
		String writerEmail = content.getEmail();
		String memberEmail = member.getEmail();
		if (!writerEmail.equals(memberEmail)) { // 아님
			request.setAttribute("errorMsg", "본인 글만 수정할 수 있습니다.");
			RequestDispatcher rd = request.getRequestDispatcher("bbs/error.jsp");
			rd.forward(request, response);
			return;
		}

		// 내 글 맞다니까?
		Article updateArticle = new Article(pNo, subject, pContent, null, 0, 0, 0, pNo, memberEmail, null);

		// ArticleService service = ArticleService.getInstance();
		boolean flag = service.updateS(updateArticle);

		request.setAttribute("flag", flag); // mokMsg로 전달

		String view = "mokMsg.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(view);
		rd.forward(request, response);
	}

	protected void report(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		String email = member.getEmail();
		long pNo = Long.parseLong(request.getParameter("pNo"));
		String rContent = request.getParameter("notfBd");

		Report report = new Report(pNo, email, rContent);

		ArticleService service = ArticleService.getInstance();

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		if (service.isReportExistS(report)) {
			response.getWriter().write("{\"message\": \"이미 신고한 게시글입니다.\"}");
		} else {
			boolean flag = service.reportS(report);
			if (flag) {
				response.getWriter().write("{\"message\": \"신고가 성공적으로 처리되었습니다.\"}");
			} else {
				response.getWriter().write("{\"error\": \"신고 처리에 실패했습니다.\"}");
			}
		}
	}

	protected void like(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = checkSession(request, response);
		if (member == null) {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"로그인이 필요합니다.\"}");
			return;
		}
		String memberEmail = member.getEmail();

		long pNo = Long.parseLong(request.getParameter("pNo")); // 공감할 글 번호

		ArticleService service = ArticleService.getInstance();

		// 중복공감 확인
		if (service.isLikedS(pNo, memberEmail)) {
			// response.getWriter().write("already_liked");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"artclUserRecommendYn\": \"Y\"}");
			return;
		}

		boolean flag = service.addLikeS(pNo, memberEmail); // 공감 추가

		if (flag) {
			int artclRecommendCnt = service.getLikeCountS(pNo); // 공감수 조회

			// JSON응답 생성 (매번 해야하나...?)
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter()
					.write("{\"artclUserRecommendYn\": \"N\", \"artclRecommendCnt\": " + artclRecommendCnt + "}");
		} else {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"공감에 실패했습니다.\"}");
		}
	}

	protected void bookmark(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Member member = checkSession(request, response);
		if (member == null) {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("{\"error\": \"로그인이 필요합니다.\"}");
			return;
		}

		String memberEmail = member.getEmail();
		long pNo = Long.parseLong(request.getParameter("pNo")); // pNo 받아옴

		ArticleService service = ArticleService.getInstance();
		if (service.isBookmarkedS(pNo, memberEmail)) { // pNo, memberEmail의 북마크가 있으면
			boolean result = service.deleteBookmarkS(pNo, memberEmail);
			if (result) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"deleted\": true}");
			} else {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"error\": \"북마크 취소에 실패했습니다.\"}");
			}
		} else {
			boolean result = service.addBookmarkS(pNo, memberEmail);
			if (result) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"success\": true}");
			} else {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"error\": \"북마크 추가에 실패했습니다.\"}");
			}
		}
	}
}