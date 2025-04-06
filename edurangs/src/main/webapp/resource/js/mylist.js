$(document).ready(function() {
    // 페이지 로드 시 초기 페이징 설정
    var pageNum = parseInt($('#pageNum').val(), 10) || 1;
    var totalArticles = parseInt($('#totalArticles').val(), 10) || 0;
    var rowCount = parseInt($('#rowCount').val(), 10) || 15;
    makePaging(pageNum, totalArticles, rowCount, 1, 5, 5, "pagingDiv");
	
});

// 페이징 생성 함수
function makePaging(pageNum, totalArticles, rowCount, startPageNum, endPageNum, pageBlockSize, pagingDivId) {
    console.log("makePaging 함수 호출됨. pageNum: ", pageNum, "totalArticles: ", totalArticles, "rowCount: ", rowCount);
    var totalPage = Math.ceil(totalArticles / rowCount);
    console.log("totalPage: ", totalPage); // 디버깅용 로그

    // endPageNum이 totalPage를 초과하지 않도록 조정
    if (endPageNum > totalPage) {
        endPageNum = totalPage;
    }

    var pagingHtml = '<div class="paging">';
    if (startPageNum > 1) {
        pagingHtml += '<a href="#" onclick="pageMove(' + (startPageNum - 1) + '); return false;" class="prev">이전</a>';
    }
    for (var i = startPageNum; i <= endPageNum; i++) {
        if (i == pageNum) {
            pagingHtml += '<strong>' + i + '</strong>';
        } else {
            pagingHtml += '<a href="#" onclick="pageMove(' + i + '); return false;">' + i + '</a>';
        }
    }
    if (endPageNum < totalPage) {
        pagingHtml += '<a href="#" onclick="pageMove(' + (endPageNum + 1) + '); return false;" class="next">다음</a>';
    }
    pagingHtml += '</div>';

    $('#' + pagingDivId).html(pagingHtml);
}


// 페이지 이동 함수

function pageMove(pageNum) {
    $('#pageNum').val(pageNum);
    var currentMode = window.location.href.includes('bookmark') ? 'bookmark' : 'list'; // 현재 모드 확인
    loadArticles('/edurang/mylist.do?m=' + currentMode);
}


// AJAX로 게시글 로드
function loadArticles(url) {
    console.log("loadArticles 함수 호출됨. url: ", url);
    var selectedRowCount = 15;
    var pageNum = $('#pageNum').val() || 1;
    var pageBlockSize = 5; // 페이지 블록 크기

    // startPageNum과 endPageNum을 동적으로 계산
    var startPageNum = Math.floor((pageNum - 1) / pageBlockSize) * pageBlockSize + 1;
    var endPageNum = startPageNum + (pageBlockSize - 1);

    $.ajax({
        url: url,
        method: "GET",
		cache: false,
        data: {
            pageNum: pageNum,
            rowCount: selectedRowCount
        },
        dataType: "html",
        success: function(result) {
            console.log("AJAX 요청 성공. result: ", result);
            $('#artclArea').html($(result).find('#artclArea').html());
            var totalArticles = parseInt($(result).find('#totalArticles').val(), 10) || 0;
            console.log("totalArticles: ", totalArticles);

            // endPageNum이 totalPage를 초과하지 않도록 조정
            var totalPage = Math.ceil(totalArticles / selectedRowCount);
            if (endPageNum > totalPage) {
                endPageNum = totalPage;
            }

            makePaging(pageNum, totalArticles, selectedRowCount, startPageNum, endPageNum, pageBlockSize, "pagingDiv");
        },
        error: function(e) {
            console.error("AJAX 요청 실패. error: ", e);
            alert('게시글을 불러오는 데 실패했습니다. 다시 시도해주세요.');
        }
    });
}

// 게시글 상세보기 함수
function fnView(pNo) {
    console.log("pNo: ", pNo); // 디버깅용 로그
    var f = document.getElementById("listForm"); // 폼 요소를 ID로 가져옴
    
    if (f) {
        f.pNo.value = pNo; // 폼에 pNo 값을 설정
        f.action = "/edurang/bbs/list.do?m=content&pNo=" + pNo; // 이동할 URL 설정
        f.submit(); // 폼 제출
    } else {
        console.error("폼을 찾을 수 없습니다."); // 폼이 없는 경우 에러 로그
    }
}