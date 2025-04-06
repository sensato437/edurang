<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta id="viewport" name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1, minimum-scale=1">
    <title>Edurang - 로그인</title>
    <link rel="shortcut icon" type="image/icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/common.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/slick.css" />
	<!-- 위에 css는 공용입니다 -->

	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css" />		
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_librarys.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/slick.min.js"></script>
	
	<!-- 공통 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.css"/>
	<!--
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.xdomainrequest.min.js"></script>
	-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/front.ui.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.bxslider.js"></script>
	<!-- //공통 -->	
	
	<script id="sliderScript" type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jssor.slider.min.js"></script><!-- 메인 -->
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-containerE {
        background-color: white;
        padding: 3rem; /* 패딩 증가 */
        border-radius: 10px; /* 둥근 모서리 */
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 그림자 강조 */
        width: 600px; /* 컨테이너 너비 증가 */
    }
	    @media (max-width: 768px) {
	    .login-container {
	        width: 90%; /* 작은 화면에서 너비 조정 */
	        margin: 80px auto 0; /* 상단 여백 조정 */
	        padding: 2rem; /* 패딩 조정 */
	    }
	}
         h2 {
        text-align: center;
        color: #333;
        font-size: 2rem; /* 제목 폰트 크기 증가 */
        margin-bottom: 1.5rem; /* 여백 추가 */
    }
        form {
            display: flex;
            flex-direction: column;
        }
        input {
        margin: 15px 0; /* 여백 증가 */
        padding: 12px; /* 패딩 증가 */
        border: 1px solid #ddd;
        border-radius: 6px; /* 둥근 모서리 */
        font-size: 1rem; /* 입력 필드 폰트 크기 증가 */
    }
    .button-container {
        display: flex;
        gap: 15px; /* 버튼 간격 증가 */
        margin-top: 20px; /* 상단 여백 증가 */
    }
    button, .restore-button {
        background-color: #41bd81;
        color: white;
        border: none;
        padding: 15px; /* 패딩 증가 */
        border-radius: 6px; /* 둥근 모서리 */
        cursor: pointer;
        flex: 1;
        font-size: 16px; /* 버튼 폰트 크기 증가 */
    }
    button:hover {
        background-color: #41bd81;
    }
    button[type="button"] {
        background-color: #6c757d;
    }
    button[type="button"]:hover {
        background-color: #5a6268;
    }
    .error {
        color: red;
        text-align: center;
        font-size: 15px;
    }
   
    </style>
</head>
<body style="margin: 0; padding: 0;">
    <!-- Header -->
    <!-- <header style="position: fixed; top: 0; left: 0; width: 100%; background-color: white; z-index: 1000;"> -->
    <div style="position: fixed; top: 0; left: 0; width: 100%; background-color: white; z-index: 1000;">
        <%@ include file="/WEB-INF/common/header.jsp" %>
    </div>
    <!-- </header> -->

    <!-- Login Container -->
    <div class="login-containerE" style="width: 100%; max-width: 600px; margin: 130px auto 0; padding: 20px;">
        <div id="login-containerE" style="width: 100%;">
            <h2>로그인</h2>
				<% 
				String error = (String) request.getAttribute("error");
				if (error != null) {
				    if (error.equals("1")) {
				%>
				        <p class="error">아이디 또는 비밀번호가 잘못되었습니다.</p>
				    <% } else if (error.equals("2")) { %>
				        <p class="error">다른 오류가 발생했습니다. 다시 시도해주세요.</p>
				    <% } else if (error.equals("4")) { %>
				        <p class="error">탈퇴한 회원입니다. 계정을 복원하시려면 비밀번호를 입력해주세요</p>
				        <form action="login.do?m=restore" method="post">
				            <input type="hidden" name="email" value="<%= request.getParameter("email") %>" />
				            <input type="password" name="password" placeholder="비밀번호" required>
				            <button type="submit" class="restore-button" >계정 복원</button>
				        </form>
				    <% } else { %>
				        <p class="error"><%= error %></p>
				    <% }
				} %>
				
				<!-- 로그인 폼 -->
				<% if (error == null || !error.equals("4")) { %>
				<% 
				    String redirectParam = request.getParameter("redirect");
				%>
				    <form action="login.do?m=login<% if (redirectParam != null && !redirectParam.isEmpty()) { %>&redirect=<%= java.net.URLEncoder.encode(redirectParam, "UTF-8") %><% } %>" method="post">
				        <input type="text" name="email" placeholder="아이디 (아이디는 이메일 형식입니다)" required>
				        <input type="password" name="password" placeholder="비밀번호" required>
				        <div style="display: flex; gap: 10px; width: 100%;">
				            <a href="/edurang/login/form.jsp" style="text-decoration: none; flex: 1;">
				                <button type="button" style="background-color: #dbdbdb; width: 100%; padding: 10px; border-radius: 5px; font-size: 16px;">회원가입</button>
				            </a>
				            <button type="submit" style="flex: 1; padding: 10px; border-radius: 5px; font-size: 16px;">로그인</button>
				        </div>
				    </form>
				<% } %>
        </div>
    </div>
</body>
</html>