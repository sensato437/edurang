function reportSet(page) {
	var paging = page.value;
	$.ajax({
		url:'admin.do?m=report',
		type: 'POST',
		data: {page: paging},
		success: function(data){
			let tablehtml="";
			tablehtml+="<thead>";
			tablehtml+="<tr>";
			tablehtml+="<th scope='col'>신고번호</th>";
			tablehtml+="<th scope='col'>제목</th>";
			tablehtml+="<th scope='col'>신고자</th>";
			tablehtml+="<th scope='col'>신고내용</th>";
			tablehtml+="</tr>";
			tablehtml+="</thead>";
			
			tablehtml+="<tbody>";
			for(const list of data.data){
				tablehtml+="<tr>";
				tablehtml+="<th scope='row'>"+list.rNo+"</th>";
				tablehtml+="<td><a href='../bbs/list.do?m=content&pNo="+list.pNo+"'>"+list.subject+"</a></td>";
				tablehtml+="<td>"+list.email+"</td>";
				tablehtml+="<td>"+list.rContent+"</td>";
				tablehtml+="</tr>";
			}
			tablehtml+="</tbody>"
			
			$("#list").html(tablehtml);
			
			let pagehtml="";
			if(data.page < 6){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>Previous</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'><a class='page-link' data-value='"+(data.page-4)+"' onclick='report(this.getAttribute(\"data-value\"))' href='#'>Previous</a></li>";
			}
			if((data.page)<4){
				for(let i=0;i<5;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}
			}else if(data.page > data.size-3){
				for(let i=data.size-5;i<data.size;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}						
			}
			else{
				for(let i=0;i<5;i++){
					let pagement = (data.page+i+1)-3;
					if(data.page==pagement)
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link'>"+pagement+"</a></li>";
					else
						pagehtml+="<li class='page-item'><a class='page-link' data-value= '"+pagement+"'onclick='report(this.getAttribute(\"data-value\")) href='#'>"+pagement+"</a></li>";
				}
			}if(data.page > data.size-5){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>next</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'>"
				pagehtml+="<a class='page-link' href='#'>"+"Next</a>"
				pagehtml+="</li>"
			}
			$("#paging").html(pagehtml);
			localStorage.setItem("table","report");
			localStorage.setItem("paging",paging);
		}
	})
}

function report(page) {
	var paging = page;
	$.ajax({
		url:'admin.do?m=report',
		type: 'POST',
		data: {page: paging},
		success: function(data){
			let tablehtml="";
			tablehtml+="<thead>";
			tablehtml+="<tr>";
			tablehtml+="<th scope='col'>신고번호</th>";
			tablehtml+="<th scope='col'>제목</th>";
			tablehtml+="<th scope='col'>신고자</th>";
			tablehtml+="<th scope='col'>신고내용</th>";
			tablehtml+="</tr>";
			tablehtml+="</thead>";
			
			tablehtml+="<tbody>";
			for(const list of data.data){
				tablehtml+="<tr>";
				tablehtml+="<th scope='row'>"+list.rNo+"</th>";
				tablehtml+="<td><a href='../bbs/list.do?m=content&pNo="+list.pNo+"'>"+list.subject+"</a></td>";
				tablehtml+="<td>"+list.email+"</td>";
				tablehtml+="<td>"+list.rContent+"</td>";
				tablehtml+="</tr>";
			}
			tablehtml+="</tbody>"
			
			$("#list").html(tablehtml);
			
			let pagehtml="";
			if(data.page < 6){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>Previous</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'><a class='page-link' data-value='"+(data.page-5)+"' onclick='report(this.getAttribute(\"data-value\"))' href='#'>Previous</a></li>";
			}
			if((data.page)<4){
				for(let i=0;i<5;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}
			}else if(data.page > data.size-3){
				for(let i=data.size-5;i<data.size;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='report(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}						
			}
			else{
				for(let i=0;i<5;i++){
					let pagement = (data.page+i+1)-3;
					
					if(data.page==(pagement)-1)
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link'>"+pagement+"</a></li>"
					else
						pagehtml+="<li class='page-item'><a class='page-link' data-value='"+pagement+"' onclick='report(this.getAttribute(\"data-value\")) href='#'>"+pagement+"</a></li>";
				}
			}if(data.page > data.size-5){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>next</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'>"
				pagehtml+="<a class='page-link' data-value='"+(data.page+5)+"' onclick='report(this.getAttribute(\"data-value\"))'>"+"Next</a>"
				pagehtml+="</li>"
			}
			$("#paging").html(pagehtml);
			localStorage.setItem("table","report");
			localStorage.setItem("paging",paging);
		}
	})
}
function board(page) {
	var paging = page;
	$.ajax({
		url:'admin.do?m=board',
		type: 'POST',
		data: {page: paging},
		success: function(data){
			let tablehtml="";
			tablehtml+="<thead>";
			tablehtml+="<tr>";
			tablehtml+="<th scope='col'>번호</th>";
			tablehtml+="<th scope='col'>게시글</th>";
			tablehtml+="<th scope='col'>작성자</th>";
			tablehtml+="<th scope='col'>작성날짜</th>";
			tablehtml+="</tr>";
			tablehtml+="</thead>";
			
			tablehtml+="<tbody>";
			for(const list of data.data){
				tablehtml+="<tr>";
				tablehtml+="<th scope='row'>"+list.pNo+"</th>";
				tablehtml+="<td><a href='../bbs/list.do?m=content&pNo="+list.pNo+"'>"+list.subject+"</a></td>";
				tablehtml+="<td>"+list.email+"</td>";
				tablehtml+="<td>"+list.pDate+"</td>";
				tablehtml+="</tr>";
			}
			tablehtml+="</tbody>"
			
			$("#list").html(tablehtml);
			
			let pagehtml="";
			if(data.page < 6){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>Previous</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'><a class='page-link' data-value='"+(data.page-5)+"' onclick='board("+(data.page-5)+")' href='#'>Previous</a></li>";
			}
			if(data.page<4){
				for(let i=0;i<5;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='board("+(i+1)+")'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"'onclick='board("+(i+1)+")'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}
			}else if(data.page > data.size-3){
				for(let i=data.size-5;i<data.size;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='board("+(i+1)+")'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='board("+(i+1)+")'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}						
			}
			else{
				for(let i=0;i<5;i++){
					let pagement = (data.page+i+1)-3;
					if(data.page==pagement)
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' value="+pagement+" onclick='board(this.getAttribute(\"data-value\"))'"+ "href='#'>"+pagement+"</a></li>";
					else
						pagehtml+="<li class='page-item'><a class='page-link' data-value='"+pagement+"' onclick='board(this.getAttribute(\"data-value\"))'href='#'>"+pagement+"</a></li>";
			
				}
			}if(data.page > data.size-5){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>next</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'>"
				pagehtml+="<a class='page-link' href='#' data-value="+(data.page+5)+" onclick='board(this.getAttribute(\"data-value\"))'>"+"Next</a>"
				pagehtml+="</li>"
			}
			$("#paging").html(pagehtml);
			localStorage.setItem("table","board");
			localStorage.setItem("paging",paging);
		}
	})
}
function boardSet(page) {
	var paging = page.value;
	localStorage.setItem("table","board");
	localStorage.setItem("paging",paging);
	$.ajax({
		url:'admin.do?m=board',
		type: 'POST',
		data: {page: paging},
		success: function(data){
			let tablehtml="";
			tablehtml+="<thead>";
			tablehtml+="<tr>";
			tablehtml+="<th scope='col'>번호</th>";
			tablehtml+="<th scope='col'>게시글</th>";
			tablehtml+="<th scope='col'>작성자</th>";
			tablehtml+="<th scope='col'>작성날짜</th>";
			tablehtml+="</tr>";
			tablehtml+="</thead>";
			
			tablehtml+="<tbody>";
			for(const list of data.data){
				tablehtml+="<tr>";
				tablehtml+="<th scope='row'>"+list.pNo+"</th>";
				tablehtml+="<td><a href='../bbs/list.do?m=content&pNo="+list.pNo+"'>"+list.subject+"</a></td>";
				tablehtml+="<td>"+list.email+"</td>";
				tablehtml+="<td>"+list.pDate+"</td>";
				tablehtml+="</tr>";
			}
			tablehtml+="</tbody>"
			
			$("#list").html(tablehtml);
			
			let pagehtml="";
			if(data.page < 6){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>Previous</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'><a class='page-link' data-value='"+(data.page-5)+"' onclick='board("+(data.page-5)+")' href='#'>Previous</a></li>";
			}
			if(data.page<4){
				for(let i=0;i<5;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='board(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"'onclick='board(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}
			}else if(data.page > data.size-3){
				for(let i=data.size-5;i<data.size;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='board(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='board(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}						
			}
			else{
				for(let i=0;i<5;i++){
					let pagement = (data.page+i+1)-3;
					if(data.page==pagement)
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' value="+pagement+" onclick='board(this.getAttribute(\"data-value\"))'"+ "href='#'>"+pagement+"</a></li>";
					else
						pagehtml+="<li class='page-item'><a class='page-link' data-value='"+pagement+"' onclick='board(this.getAttribute(\"data-value\"))'href='#'>"+pagement+"</a></li>";
				}
			}if(data.page >= data.size-5){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>next</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'>"
				pagehtml+="<a class='page-link' href='#' data-value="+(data.page+5)+" onclick='board(this.getAttribute(\"data-value\"))'>"+"Next</a>"
				pagehtml+="</li>"
			}
			$("#paging").html(pagehtml);
		}
	})
}
		
function blacklistSet(page) {
	var paging = page.value;
	
	$.ajax({
		url:'admin.do?m=blacklist',
		type: 'POST',
		data: {page: paging},
		success: function(data){
			let tablehtml="";
			tablehtml+="<thead>";
			tablehtml+="<tr>";
			tablehtml+="<th scope='col'>번호</th>";
			tablehtml+="<th scope='col'>이메일</th>";
			tablehtml+="<th scope='col'>차단내역</th>";
			tablehtml+="<th scope='col'>차단날짜</th>";
			tablehtml+="<th scope='col'>차단해제날짜</th>";
			tablehtml+="</tr>";
			tablehtml+="</thead>";
			
			tablehtml+="<tbody>";
			for(const list of data.data){
				tablehtml+="<tr>";
				tablehtml+="<th scope='row'>"+list.banNo+"</th>";
				tablehtml+="<td>"+list.email+"</td>";
				tablehtml+="<td>"+list.bContent+"</td>";
				tablehtml+="<td>"+list.bDate+"</td>";
				tablehtml+="<td>"+list.uBdate+"</td>";
				tablehtml+="</tr>";
			}
			tablehtml+="</tbody>"
			
			$("#list").html(tablehtml);
			
			let pagehtml="";
			if(data.page < 6){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>Previous</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'><a class='page-link' data-value='"+(data.page-5)+"' onclick='blacklist("+(data.page-5)+")' href='#'>Previous</a></li>";
			}
			if(data.page<4){
				for(let i=0;i<5;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"'onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}
			}else if(data.page > data.size-3){
				for(let i=data.size-5;i<data.size;i++){
					if(data.page==(i+1))
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					else
						pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
					if(data.size==(i+1))
						break;
				}						
			}
			else{
				for(let i=0;i<5;i++){
					let pagement = (data.page+i+1)-3;
					if(data.page==pagement)
						pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' value="+pagement+" onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+pagement+"</a></li>";
					else
						pagehtml+="<li class='page-item'><a class='page-link' data-value='"+pagement+"' onclick='blacklist(this.getAttribute(\"data-value\"))'href='#'>"+pagement+"</a></li>";
				}
			}if(data.page >= data.size-5){
				pagehtml+="<li class='page-item disabled'>";
				pagehtml+="<a class='page-link'>next</a>";
				pagehtml+="</li>";
			}else{
				pagehtml+="<li class='page-item'>"
				pagehtml+="<a class='page-link' href='#' data-value="+(data.page+5)+" onclick='blacklist(this.getAttribute(\"data-value\"))'>"+"Next</a>"
				pagehtml+="</li>"
			}
			$("#paging").html(pagehtml);
			localStorage.setItem("table","blacklist");
			localStorage.setItem("paging",paging);
		}
	})
}
		
		

function blacklist(page) {
			var paging = page;
			
			$.ajax({
				url:'admin.do?m=blacklist',
				type: 'POST',
				data: {page: paging},
				success: function(data){
					let tablehtml="";
					tablehtml+="<thead>";
					tablehtml+="<tr>";
					tablehtml+="<th scope='col'>번호</th>";
					tablehtml+="<th scope='col'>이메일</th>";
					tablehtml+="<th scope='col'>차단내역</th>";
					tablehtml+="<th scope='col'>차단날짜</th>";
					tablehtml+="<th scope='col'>차단해제날짜</th>";
					tablehtml+="</tr>";
					tablehtml+="</thead>";
					
					tablehtml+="<tbody>";
					for(const list of data.data){
						tablehtml+="<tr>";
						tablehtml+="<th scope='row'>"+list.banNo+"</th>";
						tablehtml+="<td>"+list.email+"</td>";
						tablehtml+="<td>"+list.bContent+"</td>";
						tablehtml+="<td>"+list.bDate+"</td>";
						tablehtml+="<td>"+list.uBdate+"</td>";
						tablehtml+="</tr>";
					}
					tablehtml+="</tbody>"
					
					$("#list").html(tablehtml);
					
					let pagehtml="";
					if(data.page < 6){
						pagehtml+="<li class='page-item disabled'>";
						pagehtml+="<a class='page-link'>Previous</a>";
						pagehtml+="</li>";
					}else{
						pagehtml+="<li class='page-item'><a class='page-link' data-value='"+(data.page-5)+"' onclick='blacklist("+(data.page-5)+")' href='#'>Previous</a></li>";
					}
					if(data.page<4){
						for(let i=0;i<5;i++){
							if(data.page==(i+1))
								pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
							else
								pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"'onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
							if(data.size==(i+1))
								break;
						}
					}else if(data.page > data.size-3){
						for(let i=data.size-5;i<data.size;i++){
							if(data.page==(i+1))
								pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
							else
								pagehtml+="<li class='page-item' aria-current='page'><a class='page-link' data-value='"+(i+1)+"' onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+(i+1)+"</a></li>";
							if(data.size==(i+1))
								break;
						}						
					}
					else{
						for(let i=0;i<5;i++){
							let pagement = (data.page+i+1)-3;
							if(data.page==pagement)
								pagehtml+="<li class='page-item active' aria-current='page'><a class='page-link' value="+pagement+" onclick='blacklist(this.getAttribute(\"data-value\"))'"+ "href='#'>"+pagement+"</a></li>";
							else
								pagehtml+="<li class='page-item'><a class='page-link' data-value='"+pagement+"' onclick='blacklist(this.getAttribute(\"data-value\"))'href='#'>"+pagement+"</a></li>";
						}
					}if(data.page >= data.size-5){
						pagehtml+="<li class='page-item disabled'>";
						pagehtml+="<a class='page-link'>next</a>";
						pagehtml+="</li>";
					}else{
						pagehtml+="<li class='page-item'>"
						pagehtml+="<a class='page-link' href='#' data-value="+(data.page+5)+" onclick='blacklist(this.getAttribute(\"data-value\"))'>"+"Next</a>"
						pagehtml+="</li>"
					}
					$("#paging").html(pagehtml);
					localStorage.setItem("table","blacklist");
					localStorage.setItem("paging",paging);
				}
			})
		}
				
