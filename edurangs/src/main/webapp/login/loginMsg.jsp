<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
    if(${flag}){
		alert("로그인 성공(환영합니다!^ㅁ^))");
		location.href="edurang/main.do";
	}else{
		alert("로그인 실패 ");
		location.href="login.do";
	}
	
</script>