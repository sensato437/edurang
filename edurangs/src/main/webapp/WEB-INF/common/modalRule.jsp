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
	</script>
</head>

<body>
<div class="modal_contents">
    <div class="board_rules">
        <div class="board_rules_box">
            Edurang은 아름다운 게시판 문화 형성을 통한 즐거운 참여 공간 창출을위해 노력하고 있습니다.            
            <br>여러분들의 글과 사진은 많은 사람들이 함께 보고 공유됩니다.
            <br>일부 사용자들의 부적절한 게시판 이용은 타인에게 상처를 줄 수 있으며, 올바른 게시판 문화를 만들어 가는데 악영향을 주기도 합니다.
            <br>이에 ‘게시판 이용수칙’을 통해서 아름다운 게시판 문화를 만들어 가고자 합니다.
        </div>
        <dl class="board_rules_list">
            <dt><불량 게시물 및 댓글 신고제도></dt>
            <dd>
                <ul>
                    <li>게시물 중에 학습과 무관한 정치적인 글, 선정적인 글, 개인이나 특정 단체에 대한 실명을 노출하거나 비방하는 글, 비속어, 욕설 등에 대해서 회원 누구나 신고할 수 있습니다.</li>
                    <li>불량 게시물 및 신고된 게시물을 지속적으로 모니터링하여 최종 삭제/복원 여부를 판단하고, 건전한 게시판 문화가 형성되도록 관리, 운영하고 있습니다.</li>
                    <strong>※ 성희롱, 성적 수치심을 유발하는 글을 올리거나 이름을 사용할 경우 즉시 회원정보 확인 후 사이버범죄 수사 의뢰합니다.</strong>
                </ul>
            </dd>
        </dl>
        <p class="board_rules_end">무심코 던진 한마디가 타인에게 큰 아픔을 줄 수 있습니다. 아름다운 게시판 문화를 만들기 위해 모두의 노력이 필요합니다. 여러분들의 많은 관심과 협조를 부탁드립니다.</p>
    </div>
</div>
</body>
</html>