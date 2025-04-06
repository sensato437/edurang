<%@ page contentType="text/html; charset=UTF-8"%>

<script>
	if(${flag}){
			alert("글이 성공적으로 수정되었습니다.\n수정된 글로 이동합니다.");
		}else{
			alert("서버에서 문제가 발생했습니다.\n잠시 후 다시 시도해주세요.");
		}
	//location.href="list.do?cat=${cat}";
	
		location.href = "list.do?m=content&pNo=${pNo}&cat=${cat}";
</script>