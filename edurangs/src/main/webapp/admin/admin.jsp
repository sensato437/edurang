<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<c:if test="${empty sessionScope.member}">
    <script>
    	location.href = "/edurang/main.do";   
    </script>
</c:if>

<c:if test="${member.roldID != 20}">
    <script>
    	location.href = "/edurang/main.do";   
    </script>
</c:if>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edurang-관리자</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/pagination.css">
        <script type="text/javascript">
			let statics = ${jsonSta};
			let names=[];
			let counts=[];
			statics.forEach(element => {
				  names.push(element['cName']);
				  counts.push(element['count']);
			})
			let mStatics = ${jsonSUM};
			
			let cDate=[];
			let cCounts=[];
			
			mStatics.forEach(element => {
				  cDate.push(element['cdate']);
				  cCounts.push(element['cCount']);
			})
			
        </script>
        <script src="/edurang/resource/js/admin.js"></script>
        <script type="text/javascript">
   
        </script>
        
    </head>
<body>
    <div>
        <nav class="navbar bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand">관리자 페이지</a>
                <form class="d-flex">
                    <button type="button" class="btn btn-outline-success" onclick="location.href='/edurang/main.do'">돌아가기</button>
                </form>
            </div>
	
        </nav>

        <div class="h-100 p-5 bg-body-tertiary border rounded-3">
            <div class="row">
                <div class="col-sm h-100 p-1 bg-body-tertiary border rounded-3" style="text-align: center; margin-right: 15px;">
                    <h3 class="bg-body-tertiary border rounded-2">게시글 요약</h3>
                    <canvas id="board" style="height:30vh; width:40vw;" ></canvas>
                </div>
                <div class="col-sm h-100 p-1 bg-body-tertiary border rounded-3" style="text-align: center; margin-right: 15px;">
                    <h3 class="bg-body-tertiary border rounded-2">유저 가입 통계</h3>
                    <canvas id="article" style="height:30vh; width:40vw;" ></canvas>
                </div>
            </div>
        </div>
    </div>
    <div class="h-100 p-5 bg-body-tertiary border rounded-3" style="margin-top: 15px;">
        <div class="btn-group" role="group" aria-label="Basic example">
            <button type="button" value='1' class="btn btn-outline-success" onclick="boardSet(this)">최근 게시글</button>
            <button type="button" value='1' class="btn btn-outline-success" onclick="reportSet(this)">신고된 글</button>
            <button type="button" value='1' class="btn btn-outline-success" onclick="blacklistSet(this)">정지된 유저</button>
        </div>
        <table class="table table-hover" id="list">
            <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">게시글</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성날짜</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="pboard">
                <tr>
                    <th scope="row">${pboard.pNo}</th>
                    <td><a href="/	edurang/bbs/list.do?m=content&pNo=${pboard.pNo}">${pboard.subject}</a></td>
                    <td>${pboard.email}</td>
                    <td>${pboard.pDate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav aria-label="...">
        	<ul class="pagination" id="paging">
        	<c:choose>
		    <c:when test="${page < 5}">
		        <li class="page-item disabled">
		            <a class="page-link">Previous</a>
		        </li>
		    </c:when>
		    <c:otherwise>
		        <li class="page-item">
		            <a class="page-link" data-value="${page-5}" onclick="board(this.getAttribute('data-value'))" href="#">Previous</a>
		        </li>
		    </c:otherwise>
		</c:choose>
		
		
		<c:choose>
		    <c:when test="${page < 5}">
		    	<c:set var="chk" value="true" />
		        <c:forEach var="i" begin="1" end="5">
		        	<c:choose>
		        		<c:when test="${i<=size}">
				            <li class="page-item ${page == i ? 'active' : ''}">
				                <a class="page-link" href="#" data-value='${i}' onclick="board(this.getAttribute('data-value'))">${i}</a>
				            </li>
			            </c:when>
			            <c:otherwise></c:otherwise>
		            </c:choose>
		        </c:forEach>
		    </c:when>
		    
		    <c:when test="${page > size - 5}">
			    <c:set var="startPage" value="${size - 4}" />
			    <c:forEach var="i" begin="${startPage}" end="${size}">
			        <li class="page-item ${page == i ? 'active' : ''}">
			            <a class="page-link" href="#" data-value="${i}" onclick="board(this.getAttribute('data-value'))">${i}</a>
			        </li>
			    </c:forEach>
			</c:when>
			
		    <c:otherwise>
		        <c:forEach var="i" begin="${page-2}" end="${page+2}">
		            <li class="page-item ${page == i ? 'active' : ''}">
		                <a class="page-link" href="#" data-value='${i}' onclick="board(this.getAttribute('data-value'))">${i}</a>
		            </li>
		        </c:forEach>
		    </c:otherwise>
		</c:choose>
		
		<!-- 다음 페이지 -->
		<c:choose>
		    <c:when test="${page >= size-5}">
		        <li class="page-item disabled">
		            <a class="page-link">Next</a>
		        </li>
		    </c:when>
		    
		    <c:otherwise>
		        <li class="page-item">
		            <a class="page-link" data-value='${page+5}' onclick="board(this.getAttribute('data-value'))" href="#">Next</a>
		        </li>
		    </c:otherwise>
		</c:choose>
        </ul>
        </nav>

    </div>

    <script>
        const ctx = document.getElementById('board');
        new Chart(ctx, {
          type: 'pie',  // 파이 차트 유형
          data: {
            labels: names,  // 레이블
            datasets: [{
              label: '# of Votes',  // 데이터 레이블
              data: counts  // 데이터 값
            }]
          },
          options: {
            responsive: false,
            plugins: {
              tooltip: {
                callbacks: {
                  // 백분율 표시
                  label: function(tooltipItem) {
                    var total = tooltipItem.dataset.data.reduce((sum, value) => sum + value, 0);  // 데이터 합계 계산
                    var percentage = (tooltipItem.raw / total) * 100;  // 각 데이터 항목에 대한 백분율 계산
                    return tooltipItem.label + ': ' + percentage.toFixed(2) + '%';  // 백분율을 툴팁에 표시
                  }
                }
              }
            }
          }
        });
        const ctxs = document.getElementById('article');
        new Chart(ctxs, {
        type: 'bar',
        data: {
            labels: cDate,
            datasets: [{
            label: '# of Votes',
            data: cCounts,
            borderWidth: 1
            }]
        },
        options: {
            responsive: false,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
        });
    </script>
    <script type="text/javascript">
	    window.onload = function(){
	    	let currentPage = localStorage.getItem('paging');
	    	let searchTable = localStorage.getItem('table');
	    	
	    	if(currentPage!=null){
		    	if(searchTable=="report"){
		    		report(currentPage);
		    	}else if(searchTable=="board"){
		    		board(currentPage);
		    	}else if(searchTable=="blacklist"){
		    		blacklist(currentPage);
		    	}
	    	}
	    }

    </script>
</body>
</html>