var updateStatusId=null;

function startUploadStatus(id){
	updateStatusId=id;
	setTimeout("uploadStatus('"+updateStatusId+"')",100);
	return true;
}



function openDialog(id,widthPx,closeFunc){
	$("#"+id).css("margin","0px");
	$("#"+id).css("padding","0px");
	var $dialog=$("#"+id).dialog({
		close: closeFunc,
		width: widthPx
	});
	$(".ui-dialog-titlebar").hide();
	$dialog.find("h5 a").attr("href","javascript:;");
	$dialog.find("h5 a").on("click",function(){
		$dialog.dialog("close");
	});
	return $dialog;
}

function closeDialog(id){
	$("#"+id).dialog("close");
}

function isIE(){
	var myNav = navigator.userAgent.toLowerCase();
	return (myNav.indexOf('msie')!=-1)? parseInt(myNav.split('msie')[1]) : false;
}

/**
 * 숫자에 천단위 마다 (,) 추가
 * @param  : value
 */
function formatNumber(value) {
    value += '';
    
    var x 	= value.split('.');
    var x1 	= x[0];
    var x2 	= x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    
    return x1 + x2;
}

function checkSearch(){
	if($.trim($("#fsearch").val())==""){
		alert("검색어를 입력하세요.");
		return false;
	}
}

function mobileLoginForm(){
	$("#mobileLoginArea").toggle();
	$("#mobileNavArea").toggle();
}

//폭 구하기
function fncGetClientWidth() {
	var intClientWidth = 0;

	if (self.innerWidth) {
		intClientWidth = self.innerWidth;
	} else if (document.documentElement && document.documentElement.clientWidth) {
		intClientWidth = document.documentElement.clientWidth;
	} else if (document.body) {
		intClientWidth = document.body.clientWidth;
	}
	return intClientWidth;
}

//높이 구하기
function fncGetClientHeight() {
	var intClientHeight = 0;

	if (self.innerHeight) {
		intClientHeight = self.innerHeight;
	} else if (document.documentElement && document.documentElement.clientHeight) {
		intClientHeight = document.documentElement.clientHeight;
	} else if (document.body) {
		intClientHeight = document.body.clientHeight;
	}
	return intClientHeight;
}

/*
 * currentPage : 현재페이지번호
 * totalRowSize : 전체데이터 로우 사이즈
 * pageRowSize : 페이지 로우 갯수
 * startPageNum : 시작 페이지 번호
 * endPageNum : 종료 페이지 번호
 * pageBlockSize : 한 페이지에 보여줄 페이지 수
 * pagingDivId : 페이징 그려질 DIV태그 아이디
 * pagingFuncNm : 페이지 이동시 호출할 함수명
 */
function makePaging(currentPage, totalRowSize, pageRowSize, startPageNum, endPageNum, pageBlockSize, pagingDivId, pagingFuncNm) {
	var totalPageBlockSize 	= 0;  // 총 페이지 블럭갯수
	var currentBlockPage 	= 0; // 현재 페이지 블럭 번호
	var totalPage			= 0;	// 전체 페이지 수
	var startPage			= 0; // 시작페이지 번호
	var endPage				= 0; // 끝페이지 번호
	var pagingHtml			= "";
	
	if(currentPage == "")   currentPage = 1;
	if(pageRowSize == "") pageRowSize = 15;
	
	totalPage 				= Math.ceil(totalRowSize / pageRowSize);
	
	if(currentPage > totalPage) currentPage = 1;
	
	
	totalPageBlockSize = Math.ceil(totalPage / pageBlockSize);
	currentBlockPage 	= Math.ceil(currentPage / pageBlockSize);
	
	if(currentBlockPage > totalPageBlockSize) currentBlockPage = totalPageBlockSize;
	
	startPage 	= ((currentBlockPage - 1) * pageBlockSize) + 1;
	endPage 	= startPage + pageBlockSize - 1;
	
	if(startPage < 1) 			startPage = 1;
	if(endPage > totalPage) endPage = totalPage;
	if(endPage < 1) 			endPage = 1;
	
	
	if(currentBlockPage > 1){
		pagingHtml 	+= '<a href="javascript:pageMove(\'1\');" class="pagination_first">처음</a>';
		pagingHtml  += '<a href="javascript:pageMove(\'' + (startPage - parseInt(pageBlockSize)) + '\');" class="pagination_prev">이전</a>';
	}
		
	if(totalPage > 0) {
		for(var i=parseInt(startPageNum); i <= parseInt(endPageNum); i++){
			if(i == currentPage)
				pagingHtml += '<span class="current">'+ i +'</span>';
			else
				pagingHtml += '<span onclick="javascript:pageMove(\'' + i + '\');">'+ i +'</span>';
		}
	}
	
	if(currentBlockPage < totalPageBlockSize) {
		pagingHtml += '<a href="javascript:pageMove(\'' + (startPage + parseInt(pageBlockSize)) + '\');" class="pagination_next">다음</a>';
		pagingHtml += '<a href="javascript:pageMove(\'' + totalPage + '\');" class="pagination_last">끝</a>';
	}
	
	if(pagingFuncNm != undefined) pagingHtml = pagingHtml.replace(/pageMove/g, pagingFuncNm);
	
	$("#" + pagingDivId).append(pagingHtml);
}

$("#mobileNavArea ul li").click(function () {
	if($(this).hasClass("open")) {
		$(this).removeClass("open").addClass("close");
		$(this).children().eq(1).show();
	} else if($(this).hasClass("close")) {
		$(this).removeClass("close").addClass("open");
		$(this).children().eq(1).hide();
	}
});
