<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
	<meta name="language" content="ko">
	<meta http-equiv="pragma" content="no-cache" />
	<meta id="viewport" name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1, minimum-scale=1">

	<link rel="icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" type="image/x-icon">
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/common.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/slick.css" />
	<!-- 공용 css -->

	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css" />		
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_librarys.js"></script><!-- 2021-05-24 수정 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/slick.min.js"></script>
	
	<!-- 공통 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.css"/>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.xdomainrequest.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/front.ui.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.bxslider.js"></script>
	<!-- //공통 -->	
	
	<!-- 메인 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/common.js?v=20241109"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/placeholders.min.js" ></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/devUtil.js?v=20241109"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_common.js?v=20241109"></script>
	
	<script type="text/javascript">
        var targetDate = new Date('2025-11-13T08:40:00');

        function updateCountdown() {
            var now = new Date();
            var timeDifference = targetDate - now;  // 밀리초 단위로 남은 시간 계산

            // 남은 시간 계산
            var days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
            var hours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

            // 초 단위까지 남은 시간을 업데이트
            document.getElementById('countdown').innerHTML = 'D- ' + days + '일 <br><span class="time">' + hours + '시간 '
                + minutes + '분 ' + seconds + '초</span>';
        }

        // 매초마다 업데이트
        setInterval(updateCountdown, 1000);
    </script>
	
	<style>
		#countdown {
			font-size: 3.3rem; font-weight: bold; color: #2c3e50; background: #f8f9fa; padding: 30px;
			border-radius: 15px; text-align: center; margin: 15px auto; max-width: 700px;
		}
		#countdown span {font-size: 2.5rem; color: #3ec58c; padding: 5px; border-radius: 5px; margin: 0 5px;}
		
		.durang img {						
		    display: block;	width: 100%; max-width: 150px; margin: 0 auto; overflow: hidden;	    
		    transition: opacity 0.3s ease;
		}
		.durang .default-img {opacity: 1;}
		.durang:hover .default-img {opacity: 0;}
		.durang .hover-img {opacity: 0;}
		.durang:hover .hover-img {opacity: 1;}
		.durang .hover-img {position: absolute; top: 0; left: 0; width: 100%; height: auto; display: block; opacity: 0; transition: opacity 0.3s ease;}	
	</style>
	<title>에듀랑</title>
</head>

<body>	
	<!-- wrap -->
	<div class="wrap">
	
	<!-- Header -->
	<%@ include file="/WEB-INF/common/header.jsp" %>
	<!-- //Header -->		
	<div id="evt5thBanner" style="display:block; width: 100%; max-width: 1280px; margin: 0 auto; overflow: hidden;">
	    <img src="${pageContext.request.contextPath}/resource/img/edurang_banner_c1.png" alt="Top Banner" style="width: 100%; height: auto; display: block;" />
	</div>
		
		<!-- container -->
		<section class="container">

			<!-- main_contents -->
			<div class="main_contents">
				<aside class="internal_link pc_only_b" id="wingAreaRight">
				    <div class="sticky_box">
				    <div class="durang">   						
   						<img class="default-img" src="${pageContext.request.contextPath}/resource/img/rang.png" style="width: 95%; height: auto; display: block;" />
   						<img class="hover-img" src="${pageContext.request.contextPath}/resource/img/rang_hover.png" alt="Hover Image" />					
					</div>
				        <a href="#none;" 
				           class="btn_quick_menu on" 
				           onclick="jQuery(this).toggleClass('on');"
				           style="padding-left: 1em;">
				           공부하자GO!<span></span>
				        </a>
				        <div class="qm_box">
				            <div class="quick_menu01">
				                <a href="https://www.ebsi.co.kr" target="_blank" class="">EBSi</a>
				                <a href="https://www.megastudy.net/" target="_blank" class="">메가스터디</a>
				                <a href="https://www.etoos.com/" target="_blank" class="">이투스</a>
				                <a href="https://www.mimacstudy.com" target="_blank" class="">대성마이맥</a>
				            </div>
				        </div>
				    </div>
				</aside>	
			
			<div style = "margin: 2em;"></div>
				
			<!-- main_video -->
			<div class="main_section_column">
				<div class="main_section main_standard">
					<h2 class="main_section_title">에듀랑 TV 📺</h2>					
					<ul class="main_standard_list">
						<li>
                        <a href="https://www.youtube.com/watch?v=4XV5OnuOr3A">
							<div class="main_standard_thumb">
								<iframe width="560" height="315" src="https://www.youtube.com/embed/4XV5OnuOr3A?si=1R3EMWXl6aHywaSv" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
							</div>
							<div class="main_standard_text">
								<div class="main_standard_subject cout_tf">🚨수포자 동기부여🚨 수학 38점 받던 중하위권이 수학 만점을 만든 피땀 눈물 최후의 공부법💯📖</div>
							</div>
						</a>
                        </li>
					</ul>
				</div>
			
				<div class="main_section main_standard">
				    <h2 class="main_section_title">입시 TV 📺</h2>				    
				    <ul class="main_standard_list">
				    	<li>
				            <a href="https://www.youtube.com/watch?v=fULb6zqey-Q">
				                <div class="main_standard_thumb">
									<iframe width="100%" height="auto" src="https://www.youtube.com/embed/fULb6zqey-Q" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
								</div>
				                <div class="main_standard_text">
				                    <div class="main_standard_subject cout_tf">[입시의 정석] 고3 첫 모의고사 한 달 앞, 선택과목 어떻게 고를까?</div>
				                </div>
				            </a>
				        </li>
			        </ul>
				</div>
			</div>
			<!-- //main_video -->
			
			<div style = "margin: 2em;"></div>
				
			<!-- main_section_column(main_board) -->
			<div class="main_section_column">
				<!-- main_board -->
				<div class="main_section main_board">
					<h2 class="main_section_title">문제질문 최신글</h2>
					<a href="bbs/list.do?cat=2-7" class="main_section_more">더보기</a>
					<ul class="main_board_list">
						<c:forEach items="${qnalist}" var="article">
							<li>
	                            <a href="bbs/list.do?m=content&cat=2-${article.cNo}&pNo=${article.pNo}">
									<c:choose>
										<c:when test="${article.cName == '고1'}">
											<span class="main_board_sort go1">${article.cName}</span>
										</c:when>
										<c:when test="${article.cName == '고2'}">
											<span class="main_board_sort go2">${article.cName}</span>
										</c:when>
										<c:when test="${article.cName == '고3'}">
											<span class="main_board_sort go3">${article.cName}</span>
										</c:when>
										<c:otherwise>
											<span class="main_board_sort">${article.cName}</span>
										</c:otherwise>
									</c:choose>
									<span class="main_board_subject">${article.subject}</span>                                
								</a>
	                        </li>
                        </c:forEach>
					</ul>
					</div>
					<!-- //main_board -->

					<!-- main_board -->
					<div class="main_section main_board">
						<h2 class="main_section_title">커뮤니티</h2>
						<a href="bbs/list.do?cat=1-4" class="main_section_more">더보기</a>
						<ul class="main_board_list">
							<c:forEach items="${comlist}" var="article">
							<li>
                                <a href="bbs/list.do?m=content&cat=1-${article.cNo}&pNo=${article.pNo}">
									<span class="main_board_sort">${article.cName}</span>
									<span class="main_board_subject">${article.subject}</span>                                
								</a>
	                        </li>
							</c:forEach>
						</ul>
					</div>
					<!-- //main_board -->
				</div>
				<!-- //main_section_column(main_board) -->
				
				<div style = "margin: 2em;"></div>

				<!-- main_section_column(main_survey) -->
				<div class="main_section_column">
					<!-- main_news -->
					<div class="main_section main_news">
						<h2 class="main_section_title">유용한 정보</h2>
						<a href="bbs/list.do?cat=3-10" class="main_section_more">더보기</a>
						<ul class="main_news_list">
							<c:forEach items="${infolist}" var="article">
								<li>
	                                <a href="bbs/list.do?m=content&cat=3-${article.cNo}&pNo=${article.pNo}">
										<span class="main_news_sort"><em>${article.cName}</em></span>
										<span class="main_news_subject">${article.subject}</span>
									</a>
		                        </li>
		                 	 </c:forEach>
						</ul>
					</div>
					<!-- //main_board -->

					<!-- main_board -->
					<div class="main_section main_survey">
					
					<h2 class="main_section_title">2025년 11월 13일 수능까지🚩</h2>
					    <div id="countdown">
					        <!-- 남은 시간 표시영역 -->					        
					    </div>
					</div>
					<!-- //main_board -->
				</div>
				<!-- //main_section_column(main_board) -->
				
				<div style = "margin: 2em;"></div>
		</section>
		<!-- //-container -->
		
		<!-- // footer -->
		<%@ include file="/WEB-INF/common/footer.jsp" %>
		<!-- footer //-->

	</div>
</body>
</html>