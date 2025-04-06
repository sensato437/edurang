<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>에러 페이지</title>
    <style>
        .error-message {
        color: red;
        padding: 10px;
        background-color: #ffe6e6;
        border: 1px solid #ff6666;
        margin-bottom: 20px;
        border-radius: 5px;
        }

        .error-message button {
            margin-left: 10px;
            padding: 5px 10px;
            background-color: #ff6666;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 3px;
        }

        .error-message button:hover {
            background-color: #ff4d4d;
        }
    </style>
</head>
<body>
    <h1>에러 발생</h1>
    <p>${errorMsg}</p>
    <button onclick="location.href='list.do'">목록으로 돌아가기</button>
</body>
</html>