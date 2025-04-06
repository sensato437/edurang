<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="mvc.domain.Member"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
//로그아웃 후 뒤로가기 시에 세션이 만료되었음에도 캐시가 남아 로그아웃 버튼 등이 보이는 경우가 있어 캐시를 비활성화하는 코드를 추가하였습니다. 
if (request.getMethod().equalsIgnoreCase("GET")) { // GET 요청인 경우에만 캐시 비활성화
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduRang - 교육 커뮤니티</title>
   	<script type="text/javascript">
   	//이부분도 로그아웃 뒤로가기 캐시관련해서 추가된부분!
   	window.onpageshow = function(event) {
   	    if (event.persisted) { // 캐시에서 로드된 경우
   	        window.location.reload(); // 페이지 새로고침
   	    }
   	};
	// 공통 기능
	function goLoginNew() {
		if (confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
			const currentUrl = window.location.href;
			location.href = "/edurang/login/login.do?redirect=" + encodeURIComponent(currentUrl);
		}
	}

	//로그아웃 후 현재 페이지에 머물려면 비동기처리!
	function logoutNew(){
		if(confirm("로그아웃 하시겠습니까?")){
	        $.ajax({
	            url: "/edurang/login/login.do?m=logout", // 로그아웃 처리 URL
	            method: "POST", // HTTP 메서드 (GET, POST 등)
	            dataType: "json",
	            success: function(response) {
	               var currentPage = window.location.search;
	                // 로그아웃 성공 시 화면 업데이트
	               if (currentPage.includes("m=input") || currentPage.includes("m=ucontent")) {
	                    // 특정 페이지일 경우 메인으로 리다이렉트
	                    console.log("현재 페이지는 로그아웃 시 리다이렉트 대상입니다. 메인 페이지로 이동합니다.");
	                    window.location.href = "/edurang/main.do";
	                } else {
	                    // 그 외 페이지는 현재 페이지에 머무르며 새로고침
	                    console.log("현재 페이지는 로그아웃 시 리다이렉트 대상이 아닙니다. 페이지를 새로고침합니다.");
	                    alert('로그아웃되었습니다.');
	                    location.reload();
	                }
	            },
	            error: function(xhr, status, error) {
	                // 로그아웃 실패 시 처리
	                alert('로그아웃에 실패했습니다.');
	            }
	        });
		}
	}
	
	//로그아웃 후에 로그인버튼 표시돼야함.
	function updateUIForLoggedOut() {
	    // 로그인 버튼 표시
	    $('.user_login').html('<a href="#none" onclick="goLoginNew();" class="btn_login">로그인</a>');
	    
	    // 사용자 정보 숨기기
	    $('.user_name').remove();
	}
	
       function updateUserPoint() {
       	console.log("포인트 업데이트 요청 시작");
           fetch('/edurang/login/login.do?m=getPoint', {
               method: 'GET',
               headers: {
                   'Content-Type': 'application/json'
               }
           })
           .then(response => {
	        console.log("서버 응답 상태:", response.status);
	        if (!response.ok) {
	            throw new Error(`서버 응답 실패: ${response.status} ${response.statusText}`);
	        }
	        return response.json();
	    })
           .then(data => {
	        console.log("서버 응답 데이터:", data);
	        if (data && data.point !== undefined && data.grade !== undefined) {
	            // 포인트 업데이트
	            document.querySelector('.user_point').textContent = data.point + ' 포인트';
	            
	            // 멘티/멘토 상태 업데이트
	            const gradeElement = document.querySelector('.user_grade');
	            if (data.grade === "멘토") {
	                gradeElement.innerHTML = `
	                    <img src="${pageContext.request.contextPath}/resource/img/grade2.png" alt="멘토" style="width: 20px; height: 20px;">
	                    멘토
	                `;
	            } else {
	                gradeElement.innerHTML = `
	                    <img src="${pageContext.request.contextPath}/resource/img/grade1.png" alt="멘티" style="width: 20px; height: 20px;">
	                    멘티
	                `;
	            }
	        } else {
	            console.error("포인트 또는 등급 데이터가 없습니다.");
	        }
	    })
           .catch(error => {
               console.error('포인트 업데이트 실패:', error);
           });
       }

        // 페이지 로드 시 포인트 업데이트
        document.addEventListener('DOMContentLoaded', function() {
        	console.log("페이지 로드 완료, 포인트 업데이트 시작");
            updateUserPoint();
            
        });
        
        window.onload = function() {
            // 현재 URL을 가져옵니다.
            var currentUrl = window.location.href;
    
            // 메뉴 항목을 찾아 각각의 href를 확인합니다.
            var menuItems = document.querySelectorAll('nav ul li a');
    
            // 각 항목에 대해 확인하고 'on' 클래스를 추가합니다.
            menuItems.forEach(function(item) {
            	
            	var href = item.getAttribute('href').replace('/edurang/bbs/list.do?', '');

                // href 속성 값이 현재 URL과 일치하면
                if (currentUrl.includes(href)) {

                    if(currentUrl.includes("cat=1")){
                        document.getElementById('c1').classList.add('on');
                    }else if(currentUrl.includes("cat=2")){
                        document.getElementById('c2').classList.add('on');
                    }else if(currentUrl.includes("cat=3")){
                        document.getElementById('c3').classList.add('on');
                    }else if(currentUrl.includes("/edurang/main.do")){
                        document.getElementById('main').classList.add('on');
                    }

                    // 해당 항목의 부모 <li>에 'on' 클래스를 추가합니다.
                    item.parentElement.classList.add('on');
                    // item에 'active' 및 'on' 클래스 추가
                    item.classList.add('active', 'on');
                } else {
                    // 일치하지 않으면 'on' 클래스를 제거합니다.
                    item.parentElement.classList.remove('on');
                    // item에서 'active' 및 'on' 클래스 제거
                    item.classList.remove('active', 'on');
                }
            });
        };
		</script>
		
		<style>
		/* 로고 가운데 정렬 */
		.center-logo {
		    display: flex;
		    justify-content: center; /* 가로 중앙 정렬 */
		    align-items: center; /* 세로 중앙 정렬 */
		    width: 100%; /* 전체 너비 사용 */
		    margin: 40px 0 40px 0;
		}
		.logo-image {
		    width: 300px;
		    height: 112px;
		    background-image: url('${pageContext.request.contextPath}/resource/img/edurang_logo_smile.png');
		    background-size: cover;
		    transition: background-image 0.3s ease; /* 부드러운 전환 효과 */
		}
		
		/* hover 시 이미지 변경 */
		.logo-image:hover {
		    background-image: url('${pageContext.request.contextPath}/resource/img/edurang_logo_wink.png');
		}
		nav .user_login {
		    text-align: left;
		    font-weight: 600;
		    font-size: 1.6rem;
		    color: #000;
		    margin-right: 1rem; /* 링크 간 간격 조정 */
		}
		.btn_login, .user_name, .btn_member {
		    margin-right: 1rem; /* 오른쪽 여백 추가 */
		}
		.user_point {
		    font-size: 16px;
		    font-weight: bold;
		    color: #333;
		    margin-right: 10px; /* user_grade와의 간격 조정 */
		}
		
		.user_grade {
		    display: inline-flex;
		    align-items: center;
		    font-size: 14px;
		    color: #555;
		}
		
		.user_grade img {
		    margin-right: 5px; /* 이미지와 텍스트 간격 조정 */
		}
		@media (max-width: 1125px) {
		    .user_point {
		        display: none !important;
		    }
		}
		</style>
</head>

<body>
    <header style="margin-bottom: 46px;">
        <!-- top_util_wrap -->        
        <div>
            <div class="logo">
            	<div class="logo center-logo">
            	<h1>
	            	<a href="/edurang/main.do">	            	
        			<div class = "logo-image" ></div>
        			</a>
        		</h1>
        		</div>
       		</div>     		
        </div>
        <!-- //top_util_wrap -->
        
        <!-- pc gnb Nav -->
        <nav>
            <!-- 카테고리 선택 -->
            <ul class="grade_menu_new grade_menu_slider_under1024" style="padding-bottom:1rem !important;">
            	<li id="cmain" class="on">
                    <a href="/edurang/main.do" id="moMainLink">
                    <span class="mo_only_ib">메인</span>
                        <span class="pc_only_ib" onclick="location.href='/edurang/bbs/list.do'">메인</span>
                        <span class="arrow_bottom mo_only_ib"></span>
                    </a>
                    <!-- 메인 Gnb(2차 카테고리) -->
                    <div class="gnb_wrap_new">
                        <ul class="le_nav slider">                        
                            <li>
                                <a href="/edurang/main.do" class="active on">에듀랑</a>                               
                            </li>                                                        
                        </ul>
                        <!-- <a href="#" class="fullMenu">전체메뉴</a> -->
                    </div>
                    <!-- //메인Gnb(2차 카테고리) -->
                </li>
                <li id="c3" class="">
                    <a href="/edurang/bbs/list.do?cat=3-10" id="moMainLink">
                    <span class="mo_only_ib">정보공유</span>
                        <span class="pc_only_ib" onclick="location.href='/edurang/bbs/list.do?cat=3-10'">정보공유</span>
                        <span class="arrow_bottom mo_only_ib"></span>
                    </a>
                    <!-- 2차 카테고리 -->
                    <div class="gnb_wrap_new">
                        <ul class="le_nav slider">
                            <li>
                                <a href="/edurang/bbs/list.do?cat=3-10" class="active on">입시</a>                                
                            </li>
                            <li>
                                <a href="/edurang/bbs/list.do?cat=3-11">기타</a>                                
                            </li>                       
                        </ul>
                        <!-- <a href="#" class="fullMenu">전체메뉴</a> -->
                    </div>
                    <!-- //2차 카테고리 -->
                </li>
                <li id="c1" class="">
                    <a href="/edurang/bbs/list.do?cat=1-4" id="moMainLink">
                        <span class="mo_only_ib">커뮤니티</span>
                        <span class="pc_only_ib" onclick="location.href='/edurang/bbs/list.do'">커뮤니티</span>
                        <span class="arrow_bottom mo_only_ib"></span>
                    </a>
                    <!-- 2차 카테고리 -->
                    <div class="gnb_wrap_new">
                        <ul class="le_nav slider">
                            <li>
                                <a href="/edurang/bbs/list.do?cat=1-4" class="active on">교재</a>                                
                            </li>
                            <li>                                
                                <a href="/edurang/bbs/list.do?cat=1-5" >강의</a>                                
                            </li>
                            <li>
                                <a href="/edurang/bbs/list.do?cat=1-6" >공부팁</a>                                
                            </li>                            
                        </ul>
                        <!-- <a href="#" class="fullMenu">전체메뉴</a> -->
                    </div>
                    <!-- //2차 카테고리 -->
                </li>
                <li id="c2" class="">
                    <a href="/edurang/bbs/list.do?cat=2-7" id="moMainLink">
                        <span class="mo_only_ib">문제 질문하기</span>
                        <span class="pc_only_ib" onclick="location.href='/edurang/bbs/list.do'">문제 질문하기</span>
                        <span class="arrow_bottom mo_only_ib"></span>
                    </a>
                    <!-- 2차 카테고리 -->
                    <div class="gnb_wrap_new">
                        <ul class="le_nav slider">
                            <li>
                                <a href="/edurang/bbs/list.do?cat=2-7" class="active on">고1</a>                                
                            </li>
                            <li>
                                <a href="/edurang/bbs/list.do?cat=2-8" >고2</a>                                
                            </li>
                            <li>
                                <a href="/edurang/bbs/list.do?cat=2-9" >고3</a>                                
                            </li>                            
                        </ul>
                        <!-- <a href="#" class="fullMenu">전체메뉴</a> -->
                    </div>
                    <!-- //2차 카테고리 -->
                </li>
            </ul>
            <!-- //카테고리 선택 -->
            <ul class="ri_nav pc_only_f">   	             	
                <!-- 로그인전 -->
                <c:if test="${empty sessionScope.member}">
	                <li class="user_login">
	                    <a href="#none" onclick="goLoginNew();" class="btn_login">로그인</a>
	                </li>
                </c:if>				
                <!-- //로그인전 -->
                
                <!-- 로그인후 (바꿔야 함) --> 
                <c:if test="${not empty sessionScope.member}">
	                <li class="user_login">
	                	<c:if test="${member.roldID == 20}">
				            <a href="/edurang/admin/admin.do" class="btn_member">관리자 페이지</a>
				        </c:if>
		                <span class="user_point"> ${member.point} 포인트</span>
		                <span class="user_grade">
						    <img src="${pageContext.request.contextPath}/resource/img/grade1.png" alt="멘티" style="width: 20px; height: 20px;">
						    멘티
						</span>
		                <a href="/edurang/mylist.do" class="btn_member">나의 활동</a>
		                <a href="/edurang/login/login.do?m=editProfile" class="btn_member">정보수정</a>
	                    <span class="user_name"> ${member.nick} 님</span>
	                    <a href="#none" onclick="logoutNew(); return false;" class="btn_login">로그아웃</a>
	                </li>
                </c:if>
                <!-- 로그인 후 -->
            </ul>
            <!-- 전체메뉴 박스 -->
            <div class="bg_depth" style="display:none;">
            </div>
            <!-- //전체메뉴 박스 -->
        </nav>
        <!-- //pc gnb Nav -->
        
        <!-- 모바일 전체 메뉴 layer -->
        <div class="mobile_menu">
            <!-- login_area -->
            <div class="login_area">
            
                <!-- 로그인전 -->
                <c:if test="${empty member}">
                	<div class="login">
                        <a href="#none" onclick="goLoginNew();">로그인</a>
                        <a href="#none" onclick="goJoin();">회원가입</a>
                    </div>
                </c:if>	
                <!-- //로그인전 -->
                <!-- 로그인후 -->
                <c:if test="${not empty member}">
	                <div class="logout">
						<span class="user">${member.nick}</span>
						<button type="button" onclick="logoutNew();"><span>로그아웃</span></button>
	                </div>
                </c:if>	
                <!-- 로그인 후 -->
                
                <a href="#none" class="mobile_menu_close"><span class="blind">닫기</span></a>
            </div>
            <!-- //login_area -->
        </div>
        <!-- //모바일 전체 메뉴 layer -->
    </header>
</body>
</html>