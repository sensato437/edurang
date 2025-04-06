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
    
    <link rel="icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" type="image/x-icon">
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/common.css" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/slick.css" />
    <!-- 위에 css는 공용입니다 -->
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/boardList.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/nethru/wlo.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_librarys.js"></script><!-- 2021-05-24 수정 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/slick.min.js"></script>
    <!-- 공통 -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.xdomainrequest.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/front.ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.bxslider.js"></script>
    <!-- //공통 -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/common.js?v=20241109"></script>

    <script>
    window.onload = function(){
        var catValue = "${param.cat}";
        if (catValue){
            var catParts = catValue.split("-");
            if (catParts.length > 1){
                var cNo = catParts[1];
                if (cNo) {
                    document.getElementById("cNo").value = cNo; // hidden input에 설정
                } else {
                    console.error("cNo is null or undefined");
                }
            } else {
                console.error("Invalid cat format");
            }
        } else {
            console.error("cat parameter is null");
        }
    }
    </script>
    <title>글 목록</title>
</head>

<body>
    <!-- skip nav -->
    <div class="skip">
        <p><a href="#container" tabindex="1">본문 바로가기</a></p>
        <p><a href="#gnb" tabindex="1">주메뉴 바로가기</a></p>
    </div>
    <!-- skip nav -->
    
    <!-- wrap -->
    <div class="wrap">

        <!-- Header -->
        <%@ include file="/WEB-INF/common/header.jsp" %>
        <!-- Header //-->
        
        <!-- container -->
        <section class="container">
            <!-- sub_container -->
            <div class="sub_container">
                <script type="text/javascript">                
                //페이지네이션을 통해 게시글 목록으로 이동 기능
                function movePage(type) {
                    $("#listForm").attr("action", "/edurang/bbs/list.do").submit();
                }
                
                //검색어 → 검색 결과 보여주는 기능
                function fnSearch(flag) {
                    if (flag == 'Y' && $("#sKeyword").val().trim().length < 2) {
                        alert("두 글자 이상 입력해주세요.");
                        $("#sKeyword").focus();
                        return;
                    }

                // 검색어가 있으면 fnOrdPage 호출
                fnOrdPage();
                }

                var ordPageOn = true;
                
                //사용자 정렬 기준 설정 → 페이지 번호 초기화
                function fnOrdPage(popStateYn) {
                    if (ordPageOn) {
                        ordPageOn = false;

                        // bbsRowCount 변경 시에만 페이지 번호 초기화
                        if (event && event.target && event.target.id === 'bbsRowCount') {
                            $("#pageNum").val(1);
                        }

                        if (!$("#pageNum").val()) {
                            $("#pageNum").val(1); // 기본값 설정
                        }

                        //$('#rowCount').val($('#bbsRowCount').val()); //선택된 행 수 설정
                        var selectedRowCount = $('#bbsRowCount').val();
                        if  (!selectedRowCount || selectedRowCount.trim() === "") {
                            selectedRowCount = 15; // 기본값 설정
                        }
                        $('#rowCount').val(selectedRowCount);
                        //$('#pageNum').val(1); //페이지 번호 초기화(OPTION)

                        // cat 파라미터 가져오기
                        var catValue = "${param.cat}";

                        var searchWord = $("#sKeyword").val();

                        var formData = $('#listForm').serializeArray();
                        formData.push({ name: "cat", value: catValue });
                        if (searchWord) {
                            formData.push({ name: "word", value: searchWord });
                        }

                        $.ajax({
                            cache: false,
                            url: '/edurang/bbs/list.do', //서버 URL
                            type: 'GET',
                            headers: {
                                'X-Requested-With': 'XMLHttpRequest' // AJAX 요청 헤더 추가
                            },
                            data: $.param(formData), //폼 데이터 전송
                            //dataType: 'json', //응답 데이터 형식
                            dataType: 'html', //응답 데이터 형식
                            success: function(result) {
                                //console.table(result);
                                 
                                // artclArea 초기화
                                $('#artclArea').html(""); 
                                //$('#artclArea').empty();
                                $('#artclArea').html(result); //결과를 HTML로 업데이트
                                
                                if (popStateYn != 'N') {
                                	var newUrl = '/edurang/bbs/list.do?pageNum=' + $('#pageNum').val() + '&rowCount=' + selectedRowCount + '&cat=' + catValue ;
                                	//var newUrl = '/edurang/bbs/list.do';
                                    history.pushState({ 'formData': $('#listForm').serialize() }, null, newUrl);
                                    if (searchWord) {
                                        newUrl += '&word=' + searchWord;
                                    }
                                    history.pushState({ 'formData': $('#listForm').serialize() }, null, newUrl);
                                }
                                
                                var parser = new DOMParser();
                                var doc = parser.parseFromString(result, "text/html");
                                var totalArticlesElement = doc.getElementById('totalArticles');
                                var totalArticles = totalArticlesElement ? parseInt(totalArticlesElement.innerText, 10) : 0;

                             	// 페이징 처리
                                //var totalArticles = parseInt($('#totalArticles', result).text(), 10);
                                //var rowCount = parseInt("${rowCount}", 10);
                                var rowCount = parseInt(selectedRowCount, 10);                                
                                var pageNum = parseInt($("#pageNum").val(), 10);
                                var pageBlockSize = 5; //페이지 블럭 크기
                                
                                var totalPage = Math.ceil(totalArticles / rowCount);
                                
                                if (pageNum > totalPage) {
                                	pageNum = totalPage;
                                }
                                
                                var startPageNum = Math.floor((pageNum - 1) / pageBlockSize) * pageBlockSize + 1;
                                var endPageNum = startPageNum + (pageBlockSize - 1);                              
                                if (endPageNum > totalPage) endPageNum = totalPage;

                                // makePaging 호출: 페이징 div에 동적으로 페이징 표시
                                makePaging(pageNum, totalArticles, rowCount, startPageNum, endPageNum, pageBlockSize, "pagingDiv");
                                                                
                                // 드롭박스에서 선택한 값 다시 설정
                                $('#bbsRowCount').val(selectedRowCount); // 여기에 추가! 선택된 값으로 드롭다운 설정
                                //$('#pagingDiv').html(result.pagingHtml);
                                ordPageOn = true;
                            },
                            error: function(e) {
                                ordPageOn = true;
                                console.log("Ajax 요청 실패: " + e.responseText); //오류 콘솔출력
                            }
                        });
                    }
                }

                //글 작성 폼으로 이동
                function fnForm(cert) {
                    var f = document.listForm;
                    var cat = "${param.cat}";
                    var catParts = cat.split("-");
                    var secondPart = catParts[1];                    

                    f.action = "/edurang/bbs/list.do?m=input&cat=" + cat;                    
                    f.submit();                    
                }

                function pageMove(pageNum) {
                    $("#pageNum").val(pageNum);
                    fnOrdPage(); //페이지 번호 설정 → 게시글 목록 갱신
                }

                //특정 게시글 내용 보여줌
                function fnView(pNo, cNo) {
                	console.log("pNo: ", pNo);
                    //var f = document.listForm;
                    var f = document.getElementById("listForm"); //ID로 접근해보자
                    
                    var upCat;
                    if (cNo >= 4 && cNo <= 6){
                        upCat = "1-";
                    }else if (cNo >= 7 && cNo <= 9){
                        upCat = "2-";
                    }else if (cNo >= 10 && cNo <= 11){
                        upCat = "3-";
                    }else{
                        alert("존재하지 않는 카테고리입니다!");
                    }

                    f.pNo.value = pNo;
                    f.action = "/edurang/bbs/list.do?m=content&pNo="+pNo+"&cat="+upCat+cNo;
                    
                    f.submit();
                }

                </script>
                <!-- contents -->
                <div class="contents">
                <form id="listForm" name="listForm" method="post">
                    <input type="hidden" id="pNo" name="pNo" value="">
                    <input type="hidden" id="cNo" name="cNo" value="">					
                    <input type="hidden" id="pageNum" name="pageNum" value="">
                    
                    <input type="hidden" id="cert" name="cert" value="N" />                    
                    <input type="hidden" id="sField2" name="sField2" value="" />
                    <input type="hidden" id="dataOrd" name="dataOrd" value="" />
                    <input type="hidden" id="rowCount" name="rowCount" value="" />
                    
                    <!-- search form -->
                    <div style="margin: 1.5em !important;"></div>
                    <div class="search_form">
                        <fieldset>
                            <legend>게시글 검색</legend>
                            <div class="search_form_select adClass">
                                <div class="select_form_input">
                                    <select id="sField" name="sField" disabled>
                                        <option value="all" selected>전체</option>
                                        <option value="title">제목</option>
                                        <option value="bd">내용</option>
                                    </select>
                                </div>
                                <div class="search_form_input">
                                    <input type="text" title="검색어 입력" id="sKeyword" name="sKeyword" placeholder="두 글자 이상 입력해 주세요" value="">
                                    <button type="submit" onclick="fnSearch('Y'); return false;">검색</button>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <!-- //search form -->
                </form>
                <!-- 리스트목록 시작 -->
                <div id="artclArea">
                	<div>                	
					<%-- 총 게시글 수: ${totalArticles} <br>
					현재 페이지당 표시할 게시글 수: ${rowCount} <br>
					계산된 totalPages: <%= (int) Math.ceil((double) (Integer.parseInt(request.getAttribute("totalArticles").toString()) / Integer.parseInt(request.getAttribute("rowCount").toString()))) %>
                	 --%></div>
                	<%-- //totalArticles, rowCount 확인 --%>
                	
                    <script type="text/javascript">
                    //var pageNum = ${pageNum};  
                    var pageNum = "${pageNum}" || "1";  // JSP에서 받아온 pageNum 없으면 1로 설정
					pageNum = parseInt(pageNum, 10);    // convert to 숫자                    
                    
                    $(document).ready(function() {

                        <c:if test="${isSearch}">
                            $('#sKeyword').val("${param.word}");
                        </c:if>


                        $('#pageNum').val(pageNum);
						
                   		// 페이징을 동적으로 계산하여 호출
                        var totalArticles = parseInt("${totalArticles}", 10) || 0; // 전체 게시글 수
                        var rowCount = parseInt("${rowCount}", 10) || 15; // 한 페이지당 표시할 게시글 수
                        var pageBlockSize = 5; // 한 번에 표시할 최대 페이지 수
                        
                        var startPageNum = Math.floor((pageNum - 1) / pageBlockSize) * pageBlockSize + 1;
                        var endPageNum = startPageNum + (pageBlockSize - 1);
                        var totalPage = Math.ceil(totalArticles / rowCount);

                        if (endPageNum > totalPage) endPageNum = totalPage; // 마지막 페이지 번호 조정
                                              
                        //페이지네이션 관련: 페이징 그리는 기능
                        makePaging(pageNum, totalArticles, rowCount, startPageNum, endPageNum, pageBlockSize, "pagingDiv");
                        
                        $('#sKeyword').keypress(function(e) {
                            if ($('#sKeyword').val() == '') {
                                if (e.keyCode == 13) {
                                    e.preventDefault(); //검색어가 Empty → Enter키 막음
                                }
                            } else {
                                if (e.keyCode == 13) {
                                    fnSearch();
                                }
                            }
                        });

                        $('.modal_btn').on('click', function(e) {
                            e.preventDefault();

                            var $modalId = $('#' + $(this).data('modalId'));
                            // 현재 열린 팝업 창이 있으면, 해당 팝업을 닫은 후 열림

                            if ($('html').hasClass('modal_open')) {
                                $('.modal').removeClass('active');
                            }

                            $('html').addClass('modal_open');
                            $modalId.addClass('active');
                        });

                        $('[name=dataOrd]').on('click', function(e) {
                            $('[name=dataOrd]').not($('#' + $(this).attr('id'))).prop('checked', false);
                            $('#dataOrd').val($(this).val());
                            $("#pageNum").val(1);

                            fnOrdPage();
                        });

                    });
                    </script>
                    <!-- board top -->
                    <div class="board_top">
                        <div class="board_top_total">
                            게시글
                            <span>${totalArticles}</span>
                        </div>
                        <a href="#" class="modal_btn board_top_guide" data-modal-id="board_rules">게시판 이용 수칙</a>
                        <div class="board_top_left">
                            <select id="bbsRowCount" name="bbsRowCount" onchange="fnOrdPage();" class="select_gray board_top_limit">
                                <option value="15">15개씩 보기</option>
                                <option value="30">30개씩 보기</option>
                                <option value="50">50개씩 보기</option>
                            </select>
                        </div>
                    </div>
                    <!-- //board top -->
                    <!-- board -->
                    <ul class="board">
                        <li class="board_head">
                            <div class="w70 board_num">번호</div>
                            <div class="w110 board_sort">분류</div>
                            <div class="board_subject">제목</div>
                            <div class="w120 board_writer">작성자</div>
                            <div class="w70 board_count">조회수</div>
                            <div class="w70 board_count">공감수</div>
                            <div class="w100 board_date">등록일</div>
                        </li>
                        <!--공지-->
                        <li class="board_notice">
                            <a href="/edurang/bbs/list.do?m=content&pNo=0">
                                <div class="w70 board_num"><span class="board_notice_tag">공지</span></div>
                                <div class="w110 board_sort">-</div>
                                <div class="board_subject">
                                    <span class="board_subject_text">[수능] 2026년까지 화이팅!</span>
                                    <span class="board_subject_reply"></span>
                                    <span></span>
                                </div>
                                <div class="w120 board_writer"><span>운영자</span></div>
                                <div class="w70 board_count">9,999</div>
                                <div class="w70 board_likes">100</div>
                                <div class="w100 board_date">2025-01-01</div>
                            </a>
                        </li>
                        <!--공지-->
                        <!--추천-->
                        <!--추천-->
                        <!--empty 게시물-->
                        <c:if test="${empty requestScope.list}">
                        <li>
                            <a>
                                <div class="w70 board_num">
                                    0</div>
                                <div class="w110 board_sort">Special</div>
                                <div class="board_subject">
                                    <span class="board_subject_text">첫번째 글을 작성해주세요😊</span>
                                    <span class="board_subject_reply">
                                    </span>
                                    <span class="board_subject_new"></span>
                                </div>
                                <div class="w120 board_writer">
                                    <span>에듀랑</span>
                                </div>
                                <div class="w70 board_count">0</div>
                                <div class="w70 board_likes">0</div>
                                <div class="w100 board_date">00:00</div>
                            </a>
                        </li>
                        </c:if>
                        <!--empty 게시물-->
                        <!--게시물-->
                        <c:forEach items="${requestScope.list}" var="article">
                        <li class="${article.pGOrder > 0 ? 'reply' : ''}">
                            <a href="#" onclick="fnView(${article.pNo}, ${article.cNo}); return false;">
                                <div class="w70 board_num" style="${article.pGOrder > 0 ? 'width: 7rem;' : ''}">
                                    ${article.pNo}</div>
                                <div class="w110 board_sort">${article.cName}</div>
                                <div class="board_subject">
                                    <c:if test="${article.pGOrder > 0}">
                                        <img src="${pageContext.request.contextPath}/resource/img/ico_arrow_reply_large.png" 
         style="width: 20px !important; height: 20px !important; vertical-align: middle !important; display: inline-block; margin-right: 0.7em;" />
                                    </c:if>
                                    <span class="board_subject_text">${article.subject}</span>
                                    <span class="board_subject_reply">
                                    </span>
                                    <span class="board_subject_new"></span>
                                </div>
                                <div class="w120 board_writer">
                                    <span>${article.nick}</span>
                                </div>
                                <div class="w70 board_count">${article.views}</div>
                                <div class="w70 board_likes">${likesMap[article.pNo]}</div>
                                <div class="w100 board_date">${article.pDate}</div>
                            </a>
                        </li>
                        </c:forEach>
                        <!--게시물-->
                    </ul>
                    <!-- //board -->
                    <!-- contents bottom (pagination) -->
                    <div class="contents_bottom">
                        <div class="pagination" id="pagingDiv">                        
                        <!-- 페이징 만드는 곳 -->
                        </div>
                        
                        <div class="contents_bottom_right">
                            <br>
                            <a href="#" onclick="fnForm(); return false;" class="btn_write btn_red">글쓰기</a>
                        </div>
                    </div>
                    <!-- //contents bottom -->
                </div>
                <!-- 리스트목록 끝 -->
            </div>
            <!-- //contents -->
            <!-- lnb -->
			
			
            <aside class="lnb">
            <div style="margin-top: 1.5em !important;"></div>
		    <span>
		        <div class="lnb_box">
		            <h2 style='text-align: center;'>❤️‍🔥HOT❤️‍🔥</h2>
		            <div id="pc_dunasubmain_lec">
		                <ul class="lnb_list lnb_class">
		                	<c:forEach items="${asideList}" var="article">
		                    <li>
		                        <a href="list.do?m=content&cat=${param.cat}&pNo=${article.pNo}" target="_self">
		                            <span class="lnb_class_sort">[${article.cName}]</span>
		                            <span class="lnb_class_subject">${article.subject}</span>
		                        </a>
		                    </li>
		                    </c:forEach>
		                </ul>
		            </div>
		        </div>
		    </span>
			</aside>
            <!-- //lnb -->            
    </div>
    <!-- //sub_container -->
    </section>
    <!-- //-container -->
    
    <!-- footer -->
    <%@ include file="/WEB-INF/common/footer.jsp" %>
    <!-- footer //-->
    </div>
    <!-- wrap -->
    
    <!-- temp_modal_type1 -->
    <div class="modal" id="board_rules">
        <!-- modal_box -->
        <section class="modal_box">
            
            <div class="modal_top">
                <h1 class="modal_top_title">게시판 이용수칙</h1>
                <a href="#" class="modal_top_close modal_close">닫기</a>
            </div>

            <!-- modal_contents -->
            <%@ include file="/WEB-INF/common/modalRule.jsp" %>
            <!-- //modal_contents -->
        </section>
        <!-- //modal_box -->
    </div>
    <!-- //temp_modal_type1 -->
    
    <%@ include file="/WEB-INF/common/modalReport.jsp" %>
    <!-- //temp_modal_type1 -->
</body>

</html>