<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mvc.domain.Member"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Edurang - 회원정보 수정</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" />
    <link rel="shortcut icon" type="image/icon" href="${pageContext.request.contextPath}/resource/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/common_renew_v2.css" />
    <link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style type="text/css">
        #passwordMessage img {
            vertical-align: middle;
    h1 {
	    display: flex;
	    align-items: center;
		}
		
		.intro_a {
		    margin-left: 10px;
		}        
        }
        input[readonly], input[disabled] {
		    background-color: #f0f0f0; /* 배경색 변경 */
		    color: #666; /* 텍스트 색상 변경 */
		    cursor: not-allowed; /* 마우스 포인터 변경 */
		    height : 37px;
		}
		.cssbtn.withdrawl {
		    padding: 5px 10px;
		    font-size: 14px;
		    background-color: #ff4d4d; /* 빨간색 배경 */
		    color: #fff; /* 흰색 텍스트 */
		    border: none;
		    cursor: pointer;
		    margin: 0 0 5px 0;
		}
		
		.cssbtn.withdrawl:hover {
		    background-color: #cc0000; /* 호버 시 더 어두운 빨간색 */
		}
		
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/pwdStrengthCheck.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.7/dayjs.min.js"></script>
    <script type="text/javascript">
	 let validator;
	 $(document).ready(function(e) {
	 	console.log("DOM이 준비되었습니다!");

		$('#userId').on('input', function() {
		    _isValidUserIdValue = false; // 닉네임 변경 시 중복 체크 여부 초기화
		});
	   
	     validator = $("#joinForm").validate({
	         rules: {
	             confirmPassword: {
	                 required: true,
	                 equalTo: "#password"
	             },
	         },
	         
	         messages: {
	             confirmPassword: {
	                 required: '',
	                 equalTo: '비밀번호가 일치하지 않습니다.'
	             },
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
	
	function _checkId() {
    const userIdInput = $('#userId');

    // 입력값 확인
    const userId = jQuery.trim(userIdInput.val());
    console.log("입력된 닉네임:", userId);
		 
		    if (!_isValidUserId(userId)) {
		        return; // 유효성 검사 실패 시 중복체크 수행하지 않음
		    }
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
	
	 /* ID->닉네임 유효성 체크 한글, 특수문자 일부 추가함 */
	 function _isValidUserId(userId) { // userId를 매개변수로 받음
	 
	    const regex = /^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\s!@#$%^&*]{2,12}$/;
	    if (!regex.test(userId)) {
	        alert("닉네임은 2자 이상 12자 이하로, 한글, 영문, 숫자, 특수문자(!@#$%^&*), 띄어쓰기를 사용 가능합니다.");
	        $('#userId').val('');
	        $('#userId').focus();
	        return false;
	    }
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
</script> 
</head>

<body>
    <a href="#contents_body" class="link_jump">본문 바로가기</a>
    <div class="header">
        <div class="wrap">
        <h1>
            <a class="logos" href="/edurang/main.jsp">
                <img src="${pageContext.request.contextPath}/resource/img/logo.png" alt="로고" width="120" height="40" />
            </a>
            <a href="#" class="intro_a">내 정보 수정</a>
        </h1>
    </div>
    </div>
    <!-- 본문 -->
    <div id="contents_body" class="contents detail_form lang_ko">
        <div class="page_top">
            <h2>나의 정보 수정</h2>
        </div>

        <form id="joinForm" name="joinForm" class="frmbox"  method="post"><input type="hidden" name="joinSiteCode" value="edurang" />
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
					        <input type="text" id="emailId" name="emailId" title="메일 아이디" class="txtinput half" value="${emailId}" disabled />
					        <input type="text" id="emailDomain" name="emailDomain" title="메일 업체" class="txtinput half" value="${emailDomain}" disabled />
					    </td>
					</tr>
                    <!-- //이메일 -->
              
                    <tr>
                        <th scope="row" style="vertical-align:top;"><label for="userId"><span class="txt_necessary" title="필수입력">닉네임</span></label></th>
                        <td class="txt_left">
                            <input type="text" id="userId" name="userId" class="txtinput"  maxlength="12" placeholder="닉네임" autocomplete="off"/>
                            <a href="#" class="cssbtn small" onclick="_checkId(); return false;"><span>중복확인</span></a>
                            <p class="status_desc" id="userId_desc_guide">
                                <label id="userId-guide" class="status_ok_desc" for="userId">
								16자 이하의 닉네임을 지어주세요.</label>
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
					        <input type="text" id="userName" name="userName" class="txtinput" value="${name}" disabled />
					    </td>
					</tr>
                    <!-- //이름 -->


                    <!-- 생년월일 -->
                    <tr>
					    <th scope="row"><label for="birthdayYear"><span class="txt_necessary" title="필수입력">생년월일</span></label></th>
					    <td class="txt_left">
					    	<input type="text" id="birthday" name="birthday" class="txtinput" disabled value="${birth}"/>
					    </td>
					</tr>
                    <!-- //생년월일 -->
                    <tr>
                    <form id="withdrawForm" action="/edurang/login/login.do?m=withdraw" method="POST" style="display: none;">
					    <input type="hidden" name="userId" value="${emailId}" />
					</form>
					    <th scope="row"><label>회원탈퇴</label></th>
					    <td class="txt_left">
					        <button type="button" class="cssbtn withdrawl" onclick="confirmWithdrawal()">회원탈퇴</button>
					        <p class="status_desc">회원탈퇴 시 1주일 뒤 영구삭제됩니다.</p>
					    </td>
					</tr>

                </tbody>
            </table>
            <!-- 버튼 타입을 "button"으로 하고 onclick()메소드를 줘서 유효성 검사 후 폼이 넘어갈 수 있도록... -->
            <div class="btn_area">
                <button type="button" class="cssbtn big on" onclick="finalCheck()"><span>수정 완료</span></button>
            </div>
        </form>
        
        <form id="withdrawForm" action="/edurang/login/login.do?m=withdraw" method="POST" style="display: none;">
		    <!-- 세션을 통해 userId와 emailDomain을 처리하므로, hidden input이 필요 없음 -->
		</form>
        
    </div>

    <script type="text/javascript">
    function finalCheck() {
	    // DOM 요소 선택 확인
	    const userIdInput = document.getElementById('userId');
	    const passwordInput = document.getElementById('password');
	    const confirmPasswordInput = document.getElementById('confirmPassword');

	    console.log("userIdInput:", userIdInput);
	    console.log("passwordInput:", passwordInput);
	    console.log("confirmPasswordInput:", confirmPasswordInput);

	    // 입력값 확인
	    if (!userIdInput || !passwordInput || !confirmPasswordInput) {
	        console.error("DOM 요소를 찾을 수 없습니다.");
	        return;
	    }
	    const userId = userIdInput.value;
	    const password = passwordInput.value;
	    const confirmPassword = confirmPasswordInput.value;

	    // 닉네임 중복체크 (닉네임이 입력된 경우만 검사)
	    if (userId !== "" && !_isValidUserIdValue) {
	        alert("닉네임 중복체크를 해주세요");
	        return;
	    }

	    // 비밀번호 유효성 검사 (비밀번호가 입력된 경우만 검사)
	    if (password !== "") {
	        let reg = /^(?=.*[A-Za-z])(?=.*\d).{6,14}$/;
	        if (!reg.test(password)) {
	            alert("비밀번호는 6자리 이상이어야 하며, 영문 대문자/소문자/숫자를 두 종류 이상 조합해야합니다");
	            passwordInput.focus();
	            return;
	        }
	        if (password.search(/\s/) != -1) {
	            alert("비밀번호를 공백 없이 입력해주세요.");
	            passwordInput.focus();
	            return;
	        }
	        if (password !== confirmPassword) {
	            alert("비밀번호가 일치하지 않습니다.");
	            return;
	        }
	    }

	    // 전송할 데이터
	    const data = {
	        userId: userId,
	        password: password
	    };

	 // fetch()를 사용한 AJAX 요청
	    fetch("/edurang/login/login.do?m=updateProfile", {
	        method: "POST", // POST로 설정
	        headers: {
	            "Content-Type": "application/json" // JSON 형식으로 전송
	        },
	        body: JSON.stringify(data) // 데이터를 JSON 문자열로 변환
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error("서버 응답이 실패했습니다.");
	        }
	        return response.json();
	    })
	    .then(response => {
	        if (response.success) {
	            alert("회원정보가 수정되었습니다.");
	            window.location.href = "/edurang/main.do"; // 메인 페이지로 리다이렉트
	        } else {
	            alert("회원정보 수정에 실패했습니다.");
	        }
	    })
	    .catch(error => {
	        console.error("AJAX 요청 실패:", error);
	        alert("서버 오류가 발생했습니다.");
	    });
	    return false;
	}
    
    function confirmWithdrawal() {
        if (confirm("정말로 회원탈퇴를 하시겠습니까? 탈퇴 1주일 이후 정보가 영구삭제됩니다.")) {
        	document.getElementById('withdrawForm').submit();
        }
    } 
    </script>
</body>
</html>