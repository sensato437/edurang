<%@ page contentType="text/html; charset=UTF-8"
import="java.sql.*, mvc.domain.Article, mvc.domain.Member"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/boardView.css" />
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_librarys.js"></script><!-- 2021-05-24 수정 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/slick.min.js"></script>
    <!-- 공통 -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.view.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.view.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.xdomainrequest.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/front.ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.bxslider.js"></script>
    <!-- //공통 -->

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/common.js?v=20241109"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/placeholders.min.js"></script>
    
    <title>에듀랑</title>
</head>

<body>
    <!-- wrap -->
    <div class="wrap">
        
        <!-- Header -->
        <%@ include file="/WEB-INF/common/header.jsp" %>
        <!-- Header //-->

        <!-- temp_modal_type1 -->
        <%@ include file="/WEB-INF/common/modalReport.jsp" %>
        <!-- //temp_modal_type1 -->

        <!-- container -->
        <section class="container">
            <!-- sub_container -->
            <div class="sub_container">
                
                <script type="text/javascript">
                function fnList() {                	
                    var f = document.vForm;                    
                    f.action = "list.do?cat=${param.cat}";
                    f.submit();
                }

                function fnDelete() {
                    if (confirm('이 게시글을 삭제하시겠습니까?')) {
                        var f = document.vForm;                        
                        f.action = "/edurang/bbs/list.do?m=delete&pNo=" + ${param.pNo};
                        f.submit();
                    }
                }

                function fnUpdate() {
                    var f = document.vForm;
                    var cat = "${param.cat}"
                    
                    f.action = "list.do?m=ucontent&pNo=${content.pNo}&cat=" + cat;
                    f.submit();
                }
                
            	//답글 달기 폼으로 이동            
                function fnForm() {
                	 var f = document.vForm;
                	 var cat = "${param.cat}";
                	 
                     f.action = "list.do?m=input&pNo=${content.pNo}&cat=" + cat;
                     f.submit();                
                }

                function fnRecommendSave() {
                    $.ajax({
                        cache: false,
                        url: 'list.do?m=like',
                        data: $('#vForm').serializeArray(),
                        dataType: 'json',
                        success: function(result) {
                            if (result.error) {
                                alert(result.error);
                            } else if (result.artclUserRecommendYn == 'Y') {
                                alert('이미 공감한 게시글 입니다.');
                            } else {
                                $('#emRecommendCnt').html(result.artclRecommendCnt.toLocaleString());
                                alert('공감하였습니다.');
                            }
                        },
                        error: function(){                            
                        	<c:if test="${empty member}">	        
	                	        goLoginNew();
	                	        return;
	                        </c:if>
                        }
                    });
                }

                function fnBookmarkSave(){
                    $.ajax({
                        cache: false,
                        url: 'list.do?m=bookmark',
                        data: $('#vForm').serializeArray(),
                        dataType: 'json',
                        success: function(result) {
                            if (result.error) {
                                alert(result.error);
                            } else if (result.success) {                                
                                alert('북마크가 추가되었습니다.');
                            } else if (result.deleted) {
                                alert('저장한 북마크를 취소했습니다.');
                            } else {
                                alert('북마크 추가에 실패했습니다.');
                            }
                        },
                        error: function(){
                        	<c:if test="${empty member}">	        
	                	        goLoginNew();
	                	        return;
	                        </c:if>                        
                        }
                    });
                }
                
              	//신고하기
                function fnReportLayer(pNo) {
                    <c:if test="${empty member}">	        
            	        goLoginNew();
            	        return;
                    </c:if>

                    $('#post_report button:last').attr('onclick', 'fnReport(' + pNo + ');');
                    $('#post_report').addClass('active');
                }

                // 댓글 목록 HTML 생성 및 댓글 개수 반환 함수
                function generateCommentHtml(data) {
                    let html = "";
                    let commentCount = 0; // 댓글 개수 초기화

                    for (const comment of data.data) {

                        var timestamp = new Date(comment.coDate);
                        var formattedDate = timestamp.toLocaleString('ko-KR', {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            hour: '2-digit',
                            minute: '2-digit',
                            hour12: false // 24시간 형식
                        });


                        commentCount++; // 댓글 개수 증가
                        if (comment.cgOrder == 0) {
                            html += "<li>";
                            html += "<div class='reply_info'>";
                            html += "<span class='reply_info_writer'>" + comment.nick + "</span>";
                            html += "<span>" + comment.email + "</span>";
                            html += "<span>" + formattedDate + "</span>";
                            html += "<span class='reply_info_system'>";
                            if (data.sessionEmail && data.sessionEmail === comment.email) {
                            html += "<a href='#' class='reply_info_com' onclick='fnRplyUpView(\"" + comment.pNo + "\", \"" + comment.coNo + "\", \"0\"); return false;'>수정</a>";
                            }
                            html += "<a href='#' class='reply_info_com' onclick='fnRplyThe(\"" + comment.pNo + "\", \"" + comment.coNo + "\", \"0\"); return false;'>댓글</a>";
                            if (data.sessionEmail && data.sessionEmail === comment.email) {
                            html += "<a href='#' class='reply_info_del' onclick='fnRplyDelete(\"" + comment.coNo + "\"); return false;'>삭제</a>";
                            }
                            //html += "<a href='#' class='reply_info_rep' onclick='fnReportLayer(\"5422497\", \"1\", \"0\", \"rply\", \"0\"); return false;'>신고</a>";
                            html += "</span>";
                            html += "</div>";
                            html += "<div class='reply_contents'>" + comment.comments + "</div>";
                            html += "</li>";
                            html += "<li id='rply_" + comment.pNo + "_" + comment.coNo + "_0' class='reply_by_reply reply_form' style='display: none;'>";
                            html += "<fieldset><legend>댓글 수정</legend>";
                            html += "<textarea id='title_" + comment.coNo + "' name='title_" + comment.coNo + "' cols='30' rows='10'>" + comment.comments + "</textarea>";
                            html += "<button type='submit' onclick='fnRplySave(\"" + comment.coNo + "\", \"update\", this); return false;'>수정</button>";
                            html += "</fieldset>";
                            html += "</li>";
                            html += "<li id='rplyThe_" + comment.pNo + "_" + comment.coNo + "_0' class='reply_by_reply reply_form' style='display: none;'>";
                            html += "<fieldset>";
                            html += "<legend>대댓글 작성</legend>";
                            html += "<textarea id='title_" + comment.coNo + "' name='title_" + comment.coNo + "' cols='30' rows='10' placeholder='댓글은 최대 1,000 byte 까지 입력이 가능합니다.'></textarea>";
                            html += "<button type='submit' onclick='fnRplySave(\"" + comment.coNo + "\", \"save\", this); return false;'>등록</button>";
                            html += "</fieldset>";
                            html += "</li>";
                        } else {
                            html += "<li class='reply_by_reply'>";
                            html += "<div class='reply_info'>";
                            html += "<span class='reply_info_writer'>" + comment.nick + "</span>";
                            html += "<span>" + comment.email + "</span>";
                            html += "<span>" + comment.coDate + "</span>";
                            html += "<span class='reply_info_system'>";
                            if (data.sessionEmail && data.sessionEmail === comment.email) {
                            html += "<a href='#' class='reply_info_com' onclick='fnRplyUpView(\"" + comment.pNo + "\", \"" + comment.coNo + "\", \"0\"); return false;'>수정</a>";
                            html += "<a href='#' class='reply_info_del' onclick='fnRplyDelete(\"" + comment.coNo + "\"); return false;'>삭제</a>";
                            }
                            //html += "<a href='#' class='reply_info_rep' onclick='fnReportLayer(\"5422497\", \"3\", \"1\", \"rply\", \"1\"); return false;'>신고</a>";
                            html += "</span>";
                            html += "</div>";
                            html += "<div class='reply_contents'>" + comment.comments + "</div>";
                            html += "</li>";
                            html += "<li id='rply_" + comment.pNo + "_" + comment.coNo + "_0' class='reply_by_reply reply_form' style='display: none;'>";
                            html += "<fieldset><legend>댓글 수정</legend>";
                            html += "<textarea id='title_" + comment.coNo + "' name='title_" + comment.coNo + "' cols='30' rows='10'>" + comment.comments + "</textarea>";
                            html += "<button type='submit' onclick='fnRplySave(\"" + comment.coNo + "\", \"update\", this); return false;'>수정</button>";
                            html += "</fieldset>";
                            html += "</li>";
                        }
                    }

                    return { html: html, commentCount: commentCount }; // HTML과 댓글 개수 반환
                }

                //처음에 댓글 수랑 목록 가져오기
                $(document).ready(function() {
                    const pNo = $("#pNo").val(); // 게시글 번호 가져오기
                    $.ajax({
                        url: '../comment.do?m=reload',
                        type: 'POST',
                        data: { pNo: pNo },
                        success: function(data) {
                            const result = generateCommentHtml(data); // 댓글 목록 및 개수 생성
                            $('.reply_list').html(result.html); // 댓글 목록 업데이트
                            $('#rCnt_' + pNo).text(result.commentCount); // 댓글 개수 업데이트
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log("댓글 목록 불러오기 실패:", textStatus, errorThrown);
                        }
                    });
                });

                //대댓글 저장 + 댓글/대댓글 수정
                function fnRplySave(coNo, type, obj) {

                    <c:if test="${empty member}">
                            //alert('로그인이 필요한 기능입니다.');
                            goLoginNew();
                            return;
                    </c:if>

                    let pNo = $("#pNo").val();  // pNo 값을 가져옵니다.
                    let title = $(obj).closest('fieldset').find('textarea').val(); // 입력된 댓글/대댓글 내용 가져오기

                    if (title.trim() === "") {
                        alert("내용을 입력해주세요.");
                        return false;
                    }

                    $.ajax({
                        url: '../comment.do?m=rsave', // 댓글/대댓글 저장 요청 URL
                        type: 'POST',
                        data: {
                            pNo: pNo, // 게시글 번호
                            coNo: coNo, // 대댓글인 경우 상위 댓글 번호
                            title: title, // 대댓글 내용
                            type: type // 작업 타입 (save: 저장, update: 수정)
                        },
                        dataType: 'json',
                        success: function(result) {
                                if (result.status === "success") {
                                    // 댓글 목록 새로고침
                                    $.ajax({
                                        url: '../comment.do?m=reload',
                                        type: 'POST',
                                        data: { pNo: pNo },
                                        success: function(data) {
                                            const result = generateCommentHtml(data); // 댓글 목록 및 개수 생성
                                            $('.reply_list').html(result.html); // 댓글 목록 업데이트
                                            $('#rCnt_' + pNo).text(result.commentCount); // 댓글 개수 업데이트
                                        },
                                        error: function(jqXHR, textStatus, errorThrown) {
                                            console.log("댓글 목록 불러오기 실패:", textStatus, errorThrown);
                                        }
                                    });
                                }
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                console.log("댓글 저장 실패:", textStatus, errorThrown);
                                console.log("서버 응답:", jqXHR.responseText); // 서버 응답 확인
                            }
                        });
                }
                    
                
				//댓글 저장
                $(function() {
                    let pNo = $("#pNo").val();  // pNo 값을 가져옵니다.

                    $("#cinput").on('click', function() {
                    	
                        <c:if test="${empty member}">
                            //alert('로그인이 필요한 기능입니다.');
                            goLoginNew();
                            return;
                        </c:if>

                        let comment = $("#title").val();  // 버튼 클릭 시 실제 입력된 댓글을 가져옵니다.
                        
                        $.ajax({
                            url: '../comment.do?m=save',  // 댓글 저장 요청
                            type: 'POST',
                            data: { title: comment, pNo: pNo }
                        })
                        .done(function(response) {
                            $.ajax({
                                url: '../comment.do?m=reload',  // 댓글 목록을 다시 불러옵니다.
                                type: 'POST',
                                data: { pNo: pNo },
                                success: function(data) {
                                    const result = generateCommentHtml(data); // 댓글 목록 및 개수 생성
                                    $('#title').val("");
                                    $('.reply_list').html(result.html); // 댓글 목록 업데이트
                                    $('#rCnt_' + pNo).text(result.commentCount); // 댓글 개수 업데이트
                                },
                                error: function(jqXHR, textStatus, errorThrown) {
                                    // 댓글 목록 불러오기 실패 시 처리
                                    console.log("댓글 목록 불러오기 에러:", textStatus, errorThrown);
                                }
                            });
                        })
                        .fail(function(jqXHR, textStatus, errorThrown) {
                            // 댓글 저장 실패 시 처리
                            console.log("저장 에러 발생(혹시 로그인 안한건 아닌지...):", textStatus, errorThrown);
                        });
                    });
                });


				//댓글, 대댓글 삭제
                function fnRplyDelete(coNo) {

                    let pNo = $("#pNo").val();

                    if (confirm('댓글을 삭제하시겠습니까?')) {
                        $.ajax({
                            url: '../comment.do?m=delete',
                            type: 'POST',
                            data: { coNo: coNo },
                            dataType: 'json', // JSON 응답 기대
                            success: function(result) {
                                if (result.status === "success") {
                                    // 댓글 목록 새로고침
                                    $.ajax({
                                        url: '../comment.do?m=reload',
                                        type: 'POST',
                                        data: { pNo: pNo },
                                        success: function(data) {
                                            const result = generateCommentHtml(data); // 댓글 목록 및 개수 생성
                                            $('.reply_list').html(result.html); // 댓글 목록 업데이트
                                            $('#rCnt_' + pNo).text(result.commentCount); // 댓글 개수 업데이트
                                        },
                                        error: function(jqXHR, textStatus, errorThrown) {
                                            console.log("댓글 목록 불러오기 실패:", textStatus, errorThrown);
                                        }
                                    });
                                }
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                console.log("댓글 삭제 실패:", textStatus, errorThrown);
                                console.log("서버 응답:", jqXHR.responseText); // 서버 응답 확인
                            }
                        });
                    }
                }

				function fnRplyUpView(pNo, coNo, level) {
					if (document.getElementById('rply_' + pNo + '_' + coNo + '_' + level).style.display == 'none') {
						$('#rply_' + pNo + '_' + coNo + '_' + level).show();
						$('#rplyThe_' + pNo + '_' + coNo + '_' + level).hide();
					} else {
						$('#rply_' + pNo + '_' + coNo + '_' + level).hide();
					}
				}

				function fnRplyThe(pNo, coNo, level) {
					if (document.getElementById('rplyThe_' + pNo + '_' + coNo + '_' + level).style.display == 'none') {
						$('#rplyThe_' + pNo + '_' + coNo + '_' + level).show();
						$('#rply_' + pNo + '_' + coNo + '_' + level).hide();
					} else {
						$('#rplyThe_' + pNo + '_' + coNo + '_' + level).hide();
					}
				}

                $(document).ready(function() {

                    // 모달 창 열기 이벤트 추가
                    $("a.modal_btn").click(function(e) {
                        e.preventDefault(); // 기본 동작 방지
                        var modalId = $(this).data("modal-id"); // data-modal-id 속성 값 가져오기
                        $("#" + modalId).addClass("active"); // 모달 창 열기
                    });

                    // 모달 창 닫기 이벤트 추가
                    $(".modal_close").click(function(e) {
                        e.preventDefault(); // 기본 동작 방지
                        $(this).closest(".modal").removeClass("active"); // 모달 창 닫기
                    });
                });
                </script>
                <!-- contents -->
                <div class="contents">
                <div style="margin: 1.5em !important;"></div>
                    <!-- article -->
                    <article class="article">
                        <div class="article_top">
                            <div class="article_top_sort"></div>
                            <h1 class="article_top_subject">${content.subject}</h1>
                            <div class="article_top_info">
                                <span>${content.nick}</span>
                                <span>${content.email}</span>
                                <span><fmt:formatDate value="${content.pDate}" pattern="yyyy. MM. dd. HH:mm" /></span>
                                <span>조회수 <em>${content.views}</em></span>
                                <span>공감수 <em id="emRecommendCnt">${likes}</em></span>
                                <span class="reply_info_system mt0 mr0">
                                    <a href="#" class="reply_info_bookmark" onclick="fnBookmarkSave()">북마크</a>
                                    <a href="#" class="reply_info_like" onclick="fnRecommendSave()">공감</a>
                                    <a href="#" class="reply_info_rep" onclick="fnReportLayer('${content.pNo}'); return false;">신고</a>
                                </span>
                            </div>
                        </div>
                        <div class="article_contents">
                        	${content.pContent}
                        </div>
                    </article>
                    <!-- //article -->
                    
                    <!-- reply -->
                    <div class="reply">
                        <div class="reply_top">
                            <div class="reply_top_count">댓글 <span id="rCnt_${content.pNo}">${commentCount}</span></div>
                            <div class="reply_top_info">
                                <p>게시판의 취지와는 상관없는 욕설이나 비방 글, 도배 글 등의 경우에는 관리자가 사전에 통보 없이 삭제할 수 있습니다.</p>
                                <a href="#" class="modal_btn" data-modal-id="board_rules">게시판 이용 수칙</a>
                            </div>
                        </div>
                        <span id="rplyArea"></span>
                    </div>
                    <!-- //reply -->
                    <html>
                    <head>
                        <title>댓글 작성</title>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $.ajaxSetup({
                                    headers: {"cache-control": "no-cache"}
                                });

                                $('#rForm textarea').keyup(function () {                                	
                                    var strValue = $(this).val().replace(/\r(?!\n)|\n(?!\r)/g, "\r\n");
                                    var strLen = strValue.length;
                                    var totalByte = 0;
                                    var len = 0;
                                    var oneChar = "";
                                    var str = "";
                                    var max = parseInt($(this).attr('maxlength'));

                                    if (!max) {
                                        max = '1000';
                                    }

                                    for (var i = 0; i < strLen; i++) {
                                        oneChar = strValue.charAt(i);
                                        if (escape(oneChar).length > 4) {
                                            totalByte += 2;
                                        } else {
                                            totalByte++;
                                        }

                                        if (totalByte <= max) {
                                            len = i + 1;
                                        }
                                    }

                                    if (totalByte > max) {
                                        str = strValue.substr(0, len);
                                        $(this).val(str);
                                        alert(max + "byte까지 입력 가능합니다.");
                                    }                                      
                                });
                            });
                        </script>
                    </head>
                    <body>
                        <form id="rForm" name="rForm" action="#">
                            <input type="hidden" id="pNo" name="pNo" value="${content.pNo}" />

                            <div class="reply_form">
                                <fieldset>
                                    <legend>댓글 작성</legend>
                                    <textarea id="title" name="title" cols="30" rows="10" placeholder="댓글은 최대 1,000 byte 까지 입력이 가능합니다."></textarea>
                                    <button type='button' id='cinput'>등록</button>
                                </fieldset>
                            </div>
                        </form>
                    </body>
                    </html>
                    <ul class="reply_list">
						
                    </ul>
                    <!-- contents bottom (게시물 삭제) -->
                    <div class="contents_bottom">
                        <div class="contents_bottom_left">
                        	<c:if test="${not empty sessionScope.member and sessionScope.member.email eq content.email}">
                            	<a href="#" class="btn_outline" onclick="fnDelete(); return false;">삭제</a>
                            </c:if>
                        </div>
                        <div class="contents_bottom_right">
                            <c:if test="${not empty sessionScope.member and sessionScope.member.email eq content.email}">
                                <a href="#" class="btn_gray" onclick="fnUpdate(); return false;">수정</a>                                
                            </c:if>
                            <a href="#" class="btn_red" onclick="fnList(); return false;">목록</a>
                        </div>
                        <div class="contents_bottom_right" style="margin: 0 1.5em !important;">
                        	<a href="#" onclick="fnForm(); return false;" class="btn_reply">답글작성</a>                            
                        </div>
                    </div>
                    <!-- //contents -->
                    <form id="vForm" name="vForm" method="post">
                        <input type="hidden" id="pNo" name="pNo" value="${content.pNo}" />
                        <input type="hidden" id="cat" name="cat" value="${param.cat}" />
                        
                        <input type="hidden" id="rowCount" name="rowCount" value="15" />
                        <input type="hidden" id="recommendCnt" name="recommendCnt" value="0" />
                        <input type="hidden" id="dataOrd" name="dataOrd" value="" />
                        <input type="hidden" id="sKeyword" name="sKeyword" value="" />
                        <input type='hidden' id='pageNum' name='pageNum' value="1">
                        <input type="hidden" id="sField" name="sField" value="all" />
                        <input type="hidden" id="sField2" name="sField2" value="" />
                    </form>
                    <form name="pageMoveForm" id="pageMoveForm" method="post"></form>
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
            <!-- modal_top -->
            <div class="modal_top">
                <h1 class="modal_top_title">게시판 이용수칙</h1>
                <a href="#" class="modal_top_close modal_close">닫기</a>
            </div>
            <!-- //modal_top -->
            <!-- modal_contents -->
            <%@ include file="/WEB-INF/common/modalRule.jsp" %>
            <!-- //modal_contents -->
        </section>
        <!-- //modal_box -->
    </div>
    <!-- //temp_modal_type1 -->
</body>

</html>