<%@ page contentType="text/html; charset=UTF-8"%>

<script>
	if(${flag}){
		alert("${msg}");
		
		/*if(){
			
		}else if(){
			
		}*/
	}else{
		alert("서버에서 문제가 발생했습니다.\n잠시 후 다시 시도해주세요.");
	}
	location.href="list.do?cat=${cat}";
</script>