<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <title>Edurang - 회원가입</title>
    
    <link rel="icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/common_renew_v2.css" />
    <link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style type="text/css">
    #passwordMessage img {
            vertical-align: middle;
        }
    h1 {
	    display: flex;
	    align-items: center;
	}
	.intro_a {
	    margin-left: 10px;
	}
	.error_message {
    color: red;
	}
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/pwdStrengthCheck.js"></script>
    <!-- 폼 유효성 검사를 위한 jquery입니다. -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>
    <!-- 소스 잘 받아와지는지 확인할것 -->
    <script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/daumRoadName.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.7/dayjs.min.js"></script>
 
	 <script type="text/javascript">
	 let validator;
	 $(document).ready(function(e) {
	 	console.log("DOM이 준비되었습니다!");
	 	
	 	$('#emailId, #emailDomain').on('input', function() {
		    _isValidEmailValue = false; // 이메일 변경 시 중복 체크 여부 초기화
		});

		$('#userId').on('input', function() {
		    _isValidUserIdValue = false; // 닉네임 변경 시 중복 체크 여부 초기화
		});
	   
	     validator = $("#joinForm").validate({
	         //쓸거같은 부분만 남김
	         rules: {
	             //여기를 지우면 안될듯
	             confirmPassword: {
	                 required: true,
	                 equalTo: "#password"
	             }
	         },
	         errorPlacement: function(error, element) {
	             // Append error within linked label
	             if (element.attr("name") === "birthdayYear" || element.attr("name") === "birthdayMonth" || element.attr("name") === "birthdayDay") {
	                 $(element).closest("form").find("#birthDay_desc").html(error);
	             } else {
	                 $(element).closest("form").find("#" + element.attr("name") + "_desc").removeClass("status_ok_desc");
	                 $(element).closest("form").find("#" + element.attr("name") + "_desc").html(error);
	             }
	         },
	         messages: {
	             confirmPassword: {
	                 required: '',
	                 equalTo: '비밀번호가 일치하지 않습니다.'
	             }
	         }
	     });
	
	     $("#userId").change(function() {
	         _isValidUserIdValue = false;
	     });
	
	     $('#confirmPassword').keyup(function() {
	         const pwd = jQuery.trim($('#password').val());
	         const confirm = jQuery.trim($('#confirmPassword').val());
	
	         if ((pwd !== "" && confirm !== "") && (pwd === confirm)) {
	             $('#confirm_desc_guide').hide();
	         } else {
	             $('#confirm_desc_guide').show();
	         }
	     });   
	 });
	
	
	 let _isValidUserIdValue = false; /* 아이디 중복 체크 여부 flag */
	 let _isValidEmailValue = false; /* 이메일 중복 체크 여부 flag */
	
	 function _checkId() {
		    if (_isValidUserId()) {
		        let userId = jQuery.trim($('#userId').val());
		        $.ajax({
		            url: 'login.do?m=nickCheck',
		            method: 'POST',
		            dataType: "json",
		            data: { nick: userId },
		            success: function(data) {
		            	 console.log("서버 응답:", data.result);
		                if (data.result === false) {
		                    _isValidUserIdValue = false;
		                    $("#userId_desc").removeClass("status_ok_desc").html("<label id='userId-error' class='error' for='userId'>'" + $('#userId').val() + "' 은(는) 이미 사용중인 아이디 입니다.</label>");
		                } else if (data.result === true) {
		                    _isValidUserIdValue = true;
		                    $("#userId_desc").addClass("status_ok_desc").html('사용 가능한 닉네임입니다.');
		                }
		            },
		            error: function(xhr, status, error) {
		                console.error("AJAX 요청 실패:", status, error);
		                console.error("상태 코드:", xhr.status); // HTTP 상태 코드 확인
		                console.error("응답 데이터:", xhr.responseText); // 서버 응답 데이터 확인
		            }
		        });
		    }
		}
	 function _checkEmail() {
		 if (_isValidEmail()) {
	         let email = jQuery.trim($('#emailId').val()+'@'+$('#emailDomain').val());
	         $.ajax({
	             url: 'login.do?m=emailCheck',
	             method: 'POST',
	             dataType: "json",
	             data: { email : email },
	             success: function(data) {
	             	 console.log("서버 응답:", data);
	                 if (data.result === false) {
	                	 _isValidEmailValue = false;
	                     $("#emailAddress_desc").removeClass("status_ok_desc").html("<label id='emailId-error' class='error' for='emailAddress_desc'>  중복된 이메일입니다.</label>");
	                 } else if (data.result === true) {
	                	 _isValidEmailValue = true;
	                     $("#emailAddress_desc").addClass("status_ok_desc").html('사용 가능한 이메일 입니다.');
	                 }
	             },
	             error: function(xhr, status, error) {
	                 console.error("AJAX 요청 실패:", status, error);
	                 console.error("상태 코드:", xhr.status); // HTTP 상태 코드 확인
	                 console.error("응답 데이터:", xhr.responseText); // 서버 응답 데이터 확인
	             }
	         });
		 }
	 }
	 	
	 /* ID->닉네임 유효성 체크 한글, 특수문자 일부 추가함 */
	 function _isValidUserId() {
	     let userId = jQuery.trim($('#userId').val());
	     if (!/^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\s!@#$%^&*]{2,12}$/.test(userId)) {
	         $('#userId').val('');
	         $('#userId').focus();
	         return false;
	     }
	
	     return true;
	 }
	 /*이메일 유효성체크부터 하도록*/
	 function _isValidEmail() {
		    const emailId = jQuery.trim($('#emailId').val());
		    const emailDomain = jQuery.trim($('#emailDomain').val());

		    // 이메일 아이디 검사
		    const emailIdRegex = /^[A-Za-z0-9._-]+$/;
		    if (!emailIdRegex.test(emailId)) {
		        $('#emailAddress_desc').text("이메일 아이디는 영문 대소문자, 숫자, '.', '_', '-'만 사용 가능합니다.")
		                               .addClass("error_message");
		        $('#emailId').focus();
		        return false;
		    }

		    // 도메인 검사
		    const emailDomainRegex = /^[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
		    if (!emailDomainRegex.test(emailDomain)) {
		        $('#emailAddress_desc').text("도메인은 영문 대소문자, 숫자, '.', '-'만 사용 가능하며, 최소 하나의 '.'이 포함되어야 합니다.")
		                               .addClass("error_message");
		        $('#emailDomain').focus();
		        return false;
		    }

		    // 전체 이메일 주소 검사
		    const fullEmail = emailId + "@" + emailDomain;
		    const emailRegex = /^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
		    if (!emailRegex.test(fullEmail)) {
		        $('#emailAddress_desc').text("유효한 이메일 주소를 입력해주세요.")
		                               .addClass("error_message");
		        $('#emailId').focus();
		        return false;
		    }

		    // 유효성 검사 통과 시 에러 메시지 초기화
		    $('#emailAddress_desc').text("").removeClass("error_message");
		    return true;
		}
	
	 function _resetValue(event) {
	     event.target.parentNode.children[0].value = '';
	 }
	
	 function _showPassword(event) {
	     let target = event.target.parentNode.children;
	     if ($(target[0]).attr('type') === 'password') {
	         $(target[0]).prop('type', 'text');
	         $(target[2]).css("display", "none");
	         $(target[3]).css("display", "inline-block");
	     } else {
	         $(target[0]).prop('type', 'password');
	         $(target[2]).css("display", "inline-block");
	         $(target[3]).css("display", "none");
	     }
	 }
	
	 //생년월일 필드 클릭
	 $('.d_tag').click(function() {
	     $.chkBrithDay('정확한 정보로 입력하시기 바랍니다.');
	 });
	
	 /* 생년월일 체크 */
	 function checkBirthday() {
	     if (!$.chkBrithDay('정확한 정보로 입력하시기 바랍니다.')) {
	         return false;
	     } else {
	         $("#birthDay_desc").html('');
	     }
	 }
	function finalCheck(){
		 	if(document.joinForm.emailId.value == "")
			{
			  alert("이메일을 입력해주세요");
			  return false;
			}
		 	if(document.joinForm.emailDomain.value == "")
			{
			  alert("이메일을 입력해주세요");
			  return false;
			}
	
			if(document.joinForm.userId.value == "")
			{
			  alert("닉네임을 입력해주세요");
			  return false;
			}
			
			if(document.joinForm.password.value == "")
			{
			  alert("비밀번호를 입력해주세요");
			  return false;
			}
			if(document.joinForm.userName.value == "")
			{
			  alert("이름을 입력해주세요");
			  return false;
			}
			let birthYear = $(':input:radio[name=birthdayYear]:checked').val();
		    let birthMonth = $(':input:radio[name=birthdayMonth]:checked').val();
		    let birthDay = $(':input:radio[name=birthdayDay]:checked').val();

		    if (!birthYear || !birthMonth || !birthDay) {
		        alert("생년월일을 선택해주세요.");
		        return false;
		    }
			//false면 안되는 것 1.이메일 중복체크 2. 닉네임 중복체크 3.비밀번호 일치여부 체크
			if (_isValidEmailValue == false){
				console.log(_isValidEmailValue);
				alert("이메일 중복체크를 해주세요");
				return false;
			}
			if (_isValidUserIdValue == false){
				alert("닉네임 중복체크를 해주세요");
				return false;
			}
			let password = $("#password").val();
	        let confirmPassword = $("#confirmPassword").val();
	        if (password !== confirmPassword) {
	            alert("비밀번호 일치여부를 확인해주세요.");
	            return false;
	        }
			if(document.joinForm.confirmPassword.value == "")
			{
			  alert("비밀번호를 확인해주세요");
			  return false;
			}
			//6자리 이상 14자 이하, 영문 대소문자와 숫자를 포함하는지 검사
			let reg = /^(?=.*[A-Za-z])(?=.*\d).{6,14}$/
			
			if(!reg.test(document.joinForm.password.value)){
				alert("비밀번호는 6자리 이상이어야 하며, 영문 대문자/소문자/숫자를 두 종류 이상 조합해야합니다");
				document.joinForm.password.focus();
				return;
			}
			//비밀번호에 공백을 포함할 수 없다.
			if(document.joinForm.password.value.search(/\s/) != -1){
				alert("비밀번호를 공백 없이 입력해주세요.");
				document.joinForm.password.focus();
				return;
			}
						
			const nameRegex = /^[가-힣A-Za-z]{2,20}$/;
		    if (!nameRegex.test(document.joinForm.userName.value)) {
		        alert("이름은 한글 또는 영문 대소문자만 사용 가능하며, 2자 이상 20자 이하로 입력해주세요.");
		        document.joinForm.userName.focus();
		        return false;
		    }
		    
			document.joinForm.submit();
	}
	
	$("#joinForm").submit(function(event) {
	    if (!finalCheck()) {
	        event.preventDefault(); // 폼 제출 막기
	    }
	});
</script> 
</head>

<body>
    <a href="#contents_body" class="link_jump">본문 바로가기</a>
    <div class="header">
        <div class="wrap">
            <h1>
            <a class="logos" href = "/edurang/main.do">
                <img src="${pageContext.request.contextPath}/resource/img/logo.png" alt="로고" width="120" height="40" />
            </a>
                <a href=# class="intro_a">회원가입</a>
            </h1>

        </div>
    </div>
    <!-- 본문 -->
    <div id="contents_body" class="contents detail_form lang_ko">
        <div class="page_top">
            <h2>정보입력 및 본인확인</h2>
        </div>

        <form id="joinForm" name="joinForm" class="frmbox" action="login.do?m=signup" method="post" onsubmit="return finalCheck();"><input type="hidden" name="joinSiteCode" value="edurang" />
            <table id="frm" class="data_table mobtable01" summary="이 테이블은 회원가입 아이디, 비밀번호, 이름, 성별, 생년월일, 이메일, 휴대폰 정보를 작성하는 테이블 입니다.">
                <caption>상세정보입력</caption>
                <colgroup>
                    <col width="250" />
                    <col width="*" />
                </colgroup>
                <tbody>
                 <!--  회원가입때 받아야 할 것 1.이메일=아이디 2.비밀번호 3.생년월일 4.닉네임 -->
                    <!-- user id = 이메일임! -->
                    <!-- 이메일 -->
                    <tr>
                        <th scope="row"><label for="emailId"><span class="txt_necessary" title="필수입력">이메일</span></label></th>
                        <td class="txt_left">
                            <input type="text" id="emailId" name="emailId" title="메일 아이디" class="txtinput half" style="ime-mode:disabled;" maxlength="24" placeholder="이메일" /> @
                            <input type="text" id="emailDomain" name="emailDomain" title="메일 업체" class="txtinput half" style="ime-mode:disabled;" maxlength="20" />
                            <a href="#" class="cssbtn small" onclick="_checkEmail(); return false;"><span>중복확인</span></a>
                            <p class="status_desc" id="emailAddress_desc"></p>
                        </td>
                    </tr>
                    <!-- //이메일 -->
                    
                    <!-- user id = 닉네임임!!-->
                    <tr>
                        <th scope="row" style="vertical-align:top;"><label for="userId"><span class="txt_necessary" title="필수입력">닉네임</span></label></th>
                        <td class="txt_left">
                            <input type="text" id="userId" name="userId" class="txtinput" style="ime-mode:disabled;" maxlength="12" placeholder="아이디" />
                            <a href="#" class="cssbtn small" onclick="_checkId(); return false;"><span>중복확인</span></a>
                            <p class="status_desc" id="userId_desc_guide">
                                <label id="userId-guide" class="status_ok_desc" for="userId">
								닉네임은 16자까지 사용.</label>
                            </p>
                            <p class="status_desc" id="userId_desc"></p>
                        </td>
                    </tr>
                    <!-- //user id -->

                    <!-- 비밀번호 -->
                    <tr>
                        <th scope="row"><label for="password"><span class="txt_necessary" title="필수입력">비밀번호</span></label></th>
                        <td class="txt_left">
                            <div class="input-box">
                                <input type="password" id="password" name="password" class="txtinput" style="ime-mode:disabled;" maxlength="13" placeholder="비밀번호" autocomplete="off"/>
                                <i class='fa fa-close icon-close' onclick="_resetValue(event)"></i>
                                <i class='fa fa-eye icon-eye' onclick="_showPassword(event)"></i>
                                <i class='fa fa-eye-slash icon-eye' style="display: none" onclick="_showPassword(event)"></i>
                            </div>
                            <span id="passwordMessage"></span>
                            <p class="status_desc" id="password_desc_guide">
                                <label id="password-guide" class="status_ok_desc" for="password">
								비밀번호는 6자리 이상이어야 하며, 영문 대문자/소문자/숫자를 두 종류 이상 조합해야합니다</label>
                            </p>
                            <p class="status_desc" id="password_desc"></p>
                        </td>
                    </tr>
                    <!-- //비밀번호 -->

                    <!-- 비밀번호 확인 -->
                    <tr>
                        <th scope="row"><label for="confirmPassword"><span class="txt_necessary" title="필수입력">비밀번호 확인</span></label></th>
                        <td class="txt_left">
                            <div class="input-box">
                                <input type="password" id="confirmPassword" name="confirmPassword" class="txtinput" style="ime-mode:disabled;" maxlength="13" placeholder="비밀번호 확인" />
                                <i class='fa fa-close icon-close' onclick="_resetValue(event)"></i>
                                <i class='fa fa-eye icon-eye' onclick="_showPassword(event)"></i>
                                <i class='fa fa-eye-slash icon-eye' style="display: none" onclick="_showPassword(event)"></i>
                            </div>
                            <p class="status_desc" id="confirm_desc_guide">
                                <label id="confirm-guide" class="status_ok_desc" for="confirmPassword">
								비밀번호를 확인 해주세요.</label>
                            </p>
                            <p class="status_desc" id="confirmPassword_desc"></p>
                        </td>
                    </tr>
                    <!-- //비밀번호 확인 -->

                    <!-- 이름 -->
                    <tr>
                        <th scope="row"><label for="userName"><span class="txt_necessary" title="필수입력">이름</span></label></th>
                        <td class="txt_left">
                            <input type="text" id="userName" name="userName" class="txtinput" maxlength="20" placeholder="이름" autocomplete="off"/>
                            <p class="status_desc" id="userName_desc"></p>
                        </td>
                    </tr>
                    <!-- //이름 -->
                    <!-- 생년월일 -->
                    <tr>
                        <th scope="row"><label for="birthdayYear"><span class="txt_necessary" title="필수입력">생년월일</span></label></th>
                        <td class="txt_left">
                            <p class="birth_title">생년월일</p>
                            <div class="para_drop">
                                <div class="d_box">
                                    <a href="#" class="d_tag">
                                        <p>선택</p> <i></i></a>
                                </div>
                                <span>년</span>
                                <ul class="child_drop birthdayYear" id="birthdayYear">
                                <c:forEach var="year" begin="1930" end="2025">
				                    <li onclick="checkBirthday();">
				                        <input type="radio" name="birthdayYear" id="by_${year}" value="${year}" />
				                        <label for="by_${year}">${year}</label>
				                    </li>
				                </c:forEach>
                                </ul>
                                <div class="clr"></div>
                            </div>

                            <div class="para_drop">
                                <div class="d_box">
                                    <a href="#this" class="d_tag">
                                        <p>선택</p><i></i></a>
                                </div>
                                <span>월</span>
                                <ul class="child_drop birthdayMonth" id="birthdayMonth">
                                    <c:forEach var="month" begin="1" end="12">
					                    <li onclick="checkBirthday();">
					                        <input type="radio" name="birthdayMonth" id="bm_${month < 10 ? '0' : ''}${month}" value="${month < 10 ? '0' : ''}${month}"  />
					                        <label for="bm_${month < 10 ? '0' : ''}${month}">${month < 10 ? '0' : ''}${month}</label>
					                    </li>
					                </c:forEach>
                                </ul>
                                <div class="clr"></div>
                            </div>

                            <div class="para_drop">
                                <div class="d_box">
                                    <a href="#this" class="d_tag">
                                        <p>선택</p> <i></i></a>
                                </div>
                                <span>일</span>
                                <ul class="child_drop birthdayDay" id="birthdayDay">
                                    <c:forEach var="day" begin="1" end="31">
					                    <li onclick="checkBirthday();">
					                        <input type="radio" name="birthdayDay" id="bd_${day < 10 ? '0' : ''}${day}" value="${day < 10 ? '0' : ''}${day}" />
					                        <label for="bd_${day < 10 ? '0' : ''}${day}">${day < 10 ? '0' : ''}${day}</label>
					                    </li>
					                </c:forEach>
                                </ul>
                                <div class="clr"></div>
                            </div>
                            <div class="clr"></div>
                            <p class="status_desc" id="birthDay_desc"></p>
                        </td>
                    </tr>
                    <!-- //생년월일 -->
                </tbody>
            </table>
       <!-- 버튼 타입을 "button"으로 하고 onclick()메소드를 줘서 유효성 검사 후 폼이 넘어갈 수 있도록... -->
            <div class="btn_area">
                <button type="button" class="cssbtn big on" onclick="finalCheck()"><span>확인</span></button>
            </div>
    </div>

</body>


</html>