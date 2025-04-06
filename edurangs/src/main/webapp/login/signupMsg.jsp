<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
    if(${flag}){
		alert("회원가입 성공(환영합니다!^ㅁ^))");
	}else{
		alert("입력실패(ㅠㅠ)");
	}
	location.href="../main.do";
</script>