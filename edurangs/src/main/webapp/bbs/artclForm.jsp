<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    
    <!-- 에디터 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/boardList.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ui_librarys.js"></script><!-- 2021-05-24 수정 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/slick.min.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
    
    <!-- 공통 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/js/jquery/jquery-ui.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.xdomainrequest.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/front.ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.bxslider.js"></script>
    <!-- //공통 -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common/common.js?v=20241109"></script>

    <title>에듀랑</title>
</head>

<body>    
    <!-- wrap -->
    <div class="wrap">
            
        <!-- Header -->
        <%@ include file="/WEB-INF/common/header.jsp" %>
        <!-- Header //-->
        
        <!-- container -->
        <section class="container">
            <!-- sub_container -->
            <div class="sub_container">                
              <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/board.css" />
              <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/write.css" />
                                
              <script type="text/javascript">
             
              $(document).ready(function() {
                  // Summernote 초기화
                  $('#bd').summernote({
                      height: 500,
                      minHeight: null,
                      maxHeight: null,
                      focus: true,
                      lang: "ko-KR",
                      placeholder: '내용을 입력해 주세요',
                      codeviewFilter: false,
                      codeviewIframeFilter: true,
                      toolbar: [
                      	['fontsize', ['fontname', 'fontsize']],
                          ['color', ['forecolor', 'backcolor']],                        	
                          ['style', ['bold', 'italic', 'underline', 'clear']],                          
                          ['para', ['paragraph', 'ul', 'ol', 'height']],
                          ['font', ['strikethrough', 'superscript', 'subscript']],
                          ['insert', ['picture', 'link', 'video']],                            
                          ['view', ['undo', 'redo', 'codeview', 'help']]
                      ],
                      
                      fontSizes: ['8', '10', '12', '14', '16', '18', '20', '26', '30', '36', '50', '72'],
                      
                      //파일 업로드 (多)
                      callbacks: {
                          onImageUpload: function(files) {
                              for (var i = 0; i < files.length; i++) {
                                  uploadImage(files[i]); // 파일 업로드 함수임
                              }
                          }
                      }
                  });
                  
                  //서버 → 에디터로 url 삽입 (多)
                  function uploadImage(file) {
                      var formData = new FormData();
                      formData.append("file", file); // 서버로 전송할 파일 추가

                      $.ajax({
                          url: "${pageContext.request.contextPath}/file/file.do?m=uploadImage",  // 서버에 이미지 업로드 요청
                          type: "POST",
                          data: formData,
                          contentType: false,
                          processData: false,
                          success: function(response) {
                              var urls = response.urls; //서버에서 반환한 이미지
                              for (var i = 0; i < urls.length; i++) { //url 삽입
                              	$('#bd').summernote('insertImage', urls[i]); // 업로드된 이미지 URL 삽입
                              }
                          },
                          error: function() {
                              alert("이미지 업로드 실패");
                          }
                      });
                  }

                  // 폼 제출 시 Summernote 내용을 hidden input에 저장
                  $('form#aForm').on('submit', function() {
                      var content = $('#bd').summernote('code'); // Summernote 내용 가져오기
                      $('#content').val(content); // hidden input에 저장
                  });
              });			    

              function fnList() {
                  (confirm('작성 중인 글이 있습니다.\n취소하면 글이 저장되지 않습니다.\n취소하시겠습니까?'))
                  location.href = "/edurang/bbs/list.do?cat=${param.cat}";                    
              }               

              function fnSave() {
                 var f = document.aForm;

                 //Summernote 내용 → hidden input id = "content" 에 저장
                 $('#content').val(content);                   

                 if ($.trim(f.title.value) == '') {
                     alert("제목을 한 글자 이상 입력해주세요.");
                     f.title.focus();
                     return;
                 }     
                 
                 f.submit();
              }

              function textChk() {
                  var objEv = event.srcElement;
                  var num = "§"; //입력을 막을 특수문자 일단 아무거나 씀
                  //{}[]()<>?_|~`!@#$%^&*-+\"'\\/"; //입력을 막을 특수문자 기재.
                  event.returnValue = true;

                  for (var i = 0; i < objEv.value.length; i++) {
                      if (-1 != num.indexOf(objEv.value.charAt(i))) {
                          event.returnValue = false;
                      }
                  }

                  if (!event.returnValue) {
                      alert("특수문자는 입력하실 수 없습니다.");
                      objEv.value = "";
                  }
              }
              
              function LockF5() {
                  if (event.keyCode == 116) {
                      event.keyCode = 0;
                      return false;
                  }
              }
              </script>
              
                <!-- contents -->
                <div class="contents">
                <div style="margin: 2em 0;"></div>
                  <div class="board_top">
                      <a href="#" class="modal_btn mar_l0 board_top_guide" data-modal-id="board_rules">게시판 이용 수칙</a>
                  </div>
                  <c:if test="${empty sessionScope.member}">
                      <script>                            
                          goLoginNew();
                      </script>
                  </c:if>
                    
                <c:if test="${not empty sessionScope.member}">
                  <form id="aForm" name="aForm" method="post" action="/edurang/bbs/list.do?m=${empty param.pNo ? 'insert' : 'insertReply'}">
                      <input type="hidden" id="pNo" name="pNo" value="${param.pNo}" />
                      <input type="hidden" id="cNo" name="cNo" value="${cNo}" />
                      <input type="hidden" id="cat" name="cat" value=${param.cat} />
                      <input type="hidden" id="content" name="content" />
                      <input type="hidden" id="rowCount" name="rowCount" value="" />                        
                      
                      <!-- write -->
                      <div class="write">                           
                          <div class="write_row">
                              <label for="subject">제목</label>
                              <input type="text" id="title" name="title" placeholder="제목을 입력해 주세요" onKeyDown="textChk();" maxlength="40">
                          </div>
                          <div class="write_row">
                              <!-- wysiwyg editor 영역 -->
                              <textarea id="bd" name="bd" placeholder="내용을 입력해 주세요" style="width:100%; height:500px;"></textarea>
                              <!-- wysiwyg editor 영역 -->
                          </div>
                      </div>
                      <!-- //write -->
                      
                      
                      <article class="write_guide">                            
                          <ul>
                              <li>게시판에 개인정보(휴대폰 번호, 메일 등)를 입력하시면 외부 노출의 위험이 있으므로 작성하지 말아주세요.</li>
                              <li>개인정보 작성 시 안내 없이 삭제 또는 수정될 수 있습니다.</li>
                          </ul>
                      </article>
                      
                      <!-- write bottom -->
                      <div class="write_bottom">
                          <a href="#" class="btn_gray" onclick="fnList(); return false;">취소</a>
                          <button type="button" class="btn_red" onclick="fnSave(); return false;">등록</button>
                      </div>
                      <!-- //write bottom -->
                  </form>
                </c:if>
                </div>
                <!-- //contents -->              
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