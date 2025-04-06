<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
    <form id="rForm" name="rForm" method="post" action="${pageContext.request.contextPath}/comment/save">
        <input type="hidden" id="artcl_id" name="artcl_id" value="${artcl_id}" />
        <input type="hidden" id="bbs_id" name="bbs_id" value="${bbs_id}" />

        <div class="reply_form">
            <fieldset>
                <legend>댓글 작성</legend>
                <textarea id="title" name="title" cols="30" rows="10" placeholder="댓글은 최대 1,000 byte 까지 입력이 가능합니다."></textarea>
                <button type="submit">등록</button>
            </fieldset>
        </div>
    </form>
</body>
</html>
