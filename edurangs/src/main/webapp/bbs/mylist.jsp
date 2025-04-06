<%@ page contentType="text/html; charset=UTF-8" 
	import="java.util.ArrayList, mvc.domain.*"%>	
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="language" content="ko">
    <meta http-equiv="pragma" content="no-cache" />
    <meta id="viewport" name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1, minimum-scale=1">
    
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" type="image/x-ico">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/common.css" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/slick.css" />
    <!-- 위에 css는 공용입니다 -->
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/boardList.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/nethru/wlo.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_librarys.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/slick.min.js"></script>
    <!-- 공통 -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.xdomainrequest.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/front.ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.bxslider.js"></script>
    <!-- //공통 -->
    
    <script id="sliderScript" type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jssor.slider.min.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/common.js?v=20241109"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/placeholders.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mylist.js"></script>

	
    <title>나의 활동</title>
    <style>
#artclArea ul.board li {
    display: flex;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
}

#artclArea ul.board li div {
    text-align: center;
    box-sizing: border-box; 
}

#artclArea ul.board li div.w70 {
    flex: 0 0 70px; 
    width: 70px; 
}

#artclArea ul.board li div.w100 {
    flex: 0 0 100px; 
    width: 100px; 
}

#artclArea ul.board li div.board_subject {
    flex-grow: 1;
    text-align: left;
    padding: 0 10px; 
    white-space: nowrap; 
    overflow: hidden; 
    text-overflow: ellipsis; 
}


#artclArea ul.board li div.board_writer {
    flex: 0 0 120px; 
    width: 120px; 
}
#artclArea ul.board li div.board_num {
    flex: 0 0 70px;
    width: 70px; 
}

#artclArea ul.board li div.board_count {
    flex: 0 0 70px; 
    width: 70px; 
}

#artclArea ul.board li div.board_likes {
    flex: 0 0 70px; 
    width: 70px;
}

#artclArea ul.board li div.board_date {
    flex: 0 0 100px; 
    width: 100px;
}


	    .button-container {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    gap: 10px;
	    margin: 15px
		}
		.btn_common {
		    background-color: #41bd81; /* 기본 색상 (예: 녹색) */
		    color: white;
		    padding: 10px 20px;
		    border: none;
		    cursor: pointer;
		    margin-right: 10px;
		    border-radius: 10px;
		}
		
		/* 활성화된 버튼 스타일 */
		.btn_common.active {
		    background-color: #808080; /* 회색 */
		    cursor: default;
		}
		
		.pagination a {
		    display: inline-block;
		    width: 26px;
		    height: 26px;
		    line-height: 26px;
		    text-align: center;
		    vertical-align: middle;
		    text-decoration: none;
		    color: #333;
		    border: 1px solid #ccc;
		    border-radius: 3px;
		    margin: 0 2px;
		}
		
		.pagination a:hover {
		    background-color: #f0f0f0;
		}
		
		.pagination strong {
		    display: inline-block;
		    width: 26px;
		    height: 26px;
		    line-height: 26px;
		    text-align: center;
		    vertical-align: middle;
		    background-color: #41bd81;
		    color: #fff;
		    border: 1px solid #41bd81;
		    border-radius: 3px;
		    margin: 0 2px;
		}
		.sub_container {
		    border-bottom: none; /* 바닥 선 제거 */
		    box-shadow: none; /* 그림자 제거 (필요한 경우) */
		}

    </style>   
</head>

<body>

    <!-- wrap -->
    <div class="wrap">
        <header>
        <!-- top_util_wrap -->
	        <div class="top_util_wrap">
	            <div class="logo"> <a href="/edurang/main.do">
	            <img src="${pageContext.request.contextPath}/resource/img/logo.png" alt="로고" width="120" height="40" padding="0, 0, 0, 50">
	        </a></h1></div><!-- //로고 -->
		</header>
               
        <section class="container">
            <div class="sub_container">
                <!-- 폼 요소 -->
                <form id="listForm" name="listForm" method="post">
                    <input type="hidden" id="pNo" name="pNo" value="" />
                    <input type="hidden" id="pageNum" name="pageNum" value="${pageNum}" />
                    <input type="hidden" id="totalArticles" name="totalArticles" value="${totalArticles}" />
                    <input type="hidden" id="rowCount" name="rowCount" value="15" />
                </form>

                <!-- 버튼 컨테이너 -->
                <div class="button-container">
                <a href="/edurang/mylist.do?m=list" class="btn_common ${empty param.m || param.m == 'list' ? 'active' : ''}">내가 쓴 글</a>
				<a href="/edurang/mylist.do?m=bookmark" class="btn_common ${param.m == 'bookmark' ? 'active' : ''}">내가 북마크한 글</a>
                </div>

                <!-- 게시글 목록 영역 -->
                <div id="artclArea">
                    <ul class="board">
                        <li class="board_head">
                            <div class="w70 board_num">번호</div>
                            <div class="board_subject">제목</div>
                            <div class="w70 board_count">조회수</div>
                            <div class="w70 board_count">공감수</div>
                            <div class="w100 board_date">등록일</div>
                        </li>
                        
                        <!-- 게시글이 없는 경우 -->
                        <c:if test="${empty requestScope.list}">
                           <li>
							    <div class="w70 board_number">00</div>
							    <div class="board_subject">게시글이 없습니다.</div>
							    <div class="w70 board_count">0</div>
							    <div class="w70 board_likes">0</div>
							    <div class="w100 board_date">00:00</div>
							</li>
                        </c:if>
                        
                        <!-- 게시글 목록 -->
                        <c:forEach items="${requestScope.list}" var="article">
                            <li>
                                <a href="#" onclick="fnView(${article.pNo}); return false;">
                                    <div class="w70 board_num">${article.pNo}</div>
                                    <div class="board_subject">${article.subject}</div>
                                    <div class="w70 board_count">${article.views}</div>
                                    <div class="w70 board_likes">${likesMap[article.pNo]}</div>
                                    <div class="w100 board_date">${article.pDate}</div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <!-- 페이징 영역 -->
                <div class="contents_bottom">
                    
                    <div class="pagination" id="pagingDiv"></div>
                    
                </div>
            </div>
        </section>
    </div>

    <%@ include file="/WEB-INF/common/modalReport.jsp" %>
</body>

</html>