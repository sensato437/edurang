<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduRang - 교육 커뮤니티</title>
    <!-- <link rel="stylesheet" href="<c:url value='/resource/css/style.css' />">
    <script src="<c:url value='/resource/js/common.js' />"></script> -->
    
    <script type="text/javascript">
          	//이용수칙 모달창
	    $(document).ready(function(){		
	        // 모달 창 열기
	    	$(document).on('click', 'a.modal_btn', function(e) {
	            e.preventDefault(); // 기본 동작 방지
	            var modalId = $(this).data("modal-id"); // data-modal-id 속성 값
	            $("#" + modalId).addClass("active");
	            
	            $("html").addClass("modal_open").css("overflow", "hidden");
	        });

	        // 모달 창 닫기
	        $(document).on('click', '.modal_close', function(e) {
	            e.preventDefault(); // 기본 동작 방지
	            $(this).closest(".modal").removeClass("active");
	            
	            //modal_open 제거
	            $("html").removeClass("modal_open").attr("style", ""); // style 속성 제거
      			$("body").attr("style", ""); // body의 style 속성도 제거
	        });
	    });
          	
	    function closeModal() {
	        // 모달 창 닫기
	        $(".modal").removeClass("active");
	        
	        // modal_open 클래스 제거
	        $("html").removeClass("modal_open").attr("style", "");
	        $("body").attr("style", "");
	    }
	</script>
</head>

<body>
<!-- temp_modal_type1 -->
<div class="modal btn_form" id="post_report">
    <!-- modal_box -->
    <section class="modal_box">
        <!-- modal_top -->
        <div class="modal_top">
            <h1 class="modal_top_title">게시글 신고</h1>
            <a href="#" class="modal_top_close modal_close">닫기</a>
        </div>
        <!-- //modal_top -->
        <!-- modal_contents -->
        <div class="modal_contents">
            <!-- post_report -->
            <div class="post_report">
                <div class="post_report_box">
                    <b>신고전에 잠깐!</b>
                    <p>1. 불건전한 게시물에 대해서만 신고해 주세요.</p>
                    <p>2. 신고가 5회 이상 누적되는 경우, 해당 게시글은 비노출됩니다.</p>
                    <p>3. 허위 신고자는 불량회원으로 등록되어 일정기간 게시물 및 댓글작성이 안 됩니다.</p>
                </div>
                <form>
                    <div class="post_report_subject">신고 사유를 선택해 주세요.</div>
                    <div class="post_report_desc">(여러 사유에 해당되는 경우에는 대표적인 경우 하나를 선택해 주세요.)</div>
                    <ul class="post_report_list">
                        <li>
                            <input type="radio" id="rpt_type1" name="rpt_type" value="1" checked="checked">
                            <label for="rpt_type1">타인에 대한 욕설 또는 비방</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type2" name="rpt_type" value="3">
                            <label for="rpt_type2">인신공격 및 명예 훼손</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type3" name="rpt_type" value="5">
                            <label for="rpt_type3">음란성 내용 및 음란물 링크</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type4" name="rpt_type" value="7">
                            <label for="rpt_type4">상업적 광고, 사이트/홈피 홍보</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type5" name="rpt_type" value="2">
                            <label for="rpt_type5">불법 정보 유출</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type6" name="rpt_type" value="4">
                            <label for="rpt_type6">같은 내용의 반복(도배)</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type7" name="rpt_type" value="6">
                            <label for="rpt_type7">폭력 또는 사행심 조장</label>
                        </li>
                        <li>
                            <input type="radio" id="rpt_type8" name="rpt_type" value="8">
                            <label for="rpt_type8">게시판 성격에 맞지 않는 내용</label>
                        </li>
                    </ul>
                    <div class="survey_form_button">
                        <button type="button" class="gray" onclick="closeModal();">취소</button>
                        <button type="button" onclick="fnReport('${content.pNo}');">신고하기</button>
                    </div>
                </form>
            </div>
            <!-- //post_report -->   
        </div>
        <!-- //modal_contents -->
    </section>
    <!-- //modal_box -->
</div>
<!-- //temp_modal_type1 -->

<script>
//신고하기
function fnReport(pNo) {

    console.log("pNo:", pNo); 

    <c:if test="${empty member}">
        alert('로그인이 필요한 기능입니다.');
        goLoginNew();
        return;
    </c:if>


    //게시물ID $("#pNo").val();
    //신고 구분 코드
    //신고 내용 

    var pNo= pNo;
    var notfDsCd = jQuery("#post_report input:radio[name=rpt_type]:checked").val();
    var notfBd = jQuery("label[for='rpt_type" + notfDsCd + "']").text();

    
    console.log("notfDsCd:", notfDsCd); // 신고 구분 코드 확인
    console.log("notfBd:", notfBd); // 신고 내용 확인

    $.ajax({
        url: '/edurang/bbs/list.do?m=report',
        data: {
            pNo: pNo,
            notfDsCd: notfDsCd,
            notfBd: notfBd
        },
        dataType: "json",
        async: false,
        type: 'post',
        success: function(data) {
            console.log("Response data:", data); // 서버 응답 확인
            if (data && data.message) {
                alert(data.message);
            } else {
                alert('신고에 실패했습니다.');
            }
        },
        error: function(e) {
            console.error('Error:', e); // 오류 정보 출력
            alert('error : ' + e.responseText); // e.result 대신 e.responseText 사용
        }
    });

}
</script>
</body>
</html>