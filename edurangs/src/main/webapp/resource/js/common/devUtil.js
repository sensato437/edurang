/************************************************
개발자들이 공통적으로 쓸 util js라 생각되시면 devUtil 안에 넣어주세요.
*************************************************/

var devUtil= {
		
	/*************************************************************************************************
	설명   : 해당 영역에 URL로드(일반적인 Tab메뉴 일때 이용)
	입력값 : objId - 로드할 영역 ID (필수값 string)
	         url - 호출될 url (필수값)
	         param - 호출시 전송될 입력 파라메터
	         callback - 로드 시점에서 바로 실행될 callback
	예)    : fn_pageLoad('testDetail', '/mba/memmn/ajaxListPage1.do');
	         fn_pageLoad('testDetail', '/mba/memmn/ajaxListPage1.do', 'test=111', 'fn_callback');
	**************************************************************************************************/
	fn_pageLoad : function(objId, url, param, callback){
		$("#"+objId).load(url, param, function(response, status, xhr){
			if (status == "error"){
				var msg = "Sorry but there was an error: ";
				$(this).html(msg + xhr.status + " " + xhr.statusText);
			} else {
				if (callback) {
					alert("Callback function 호출 에러!!");	
				}
			}
		});
	},
	

    isEmpty : function(str){
    	var obj = String($.trim(str));

    	if(obj == null || obj == undefined || obj == 'null' || obj == 'undefined' || obj == '' ) return true;
    	else return false;
    },
    
    isUndefined : function(str){
    	var obj = String($.trim(str));

    	if(obj == null || obj == undefined || obj == 'null' || obj == 'undefined' || obj == '' ) return true;
    	else return false;
    },
    isNull: function(obj) {
		if (typeof obj != 'object')
			return false;
		if (obj == null)
			return true;
		return false;
	},

    isString: function(object) {
        return "string" === typeof object;
    },
    
    isNumber: function(value) {
		var regex = /[^0-9]/i;
		if (regex.test(value))
			return false;
		return true;
	},
	
	isNumberComma: function(value) {
		var temp = value.replace('.', '');
		var regex = /([^0-9]|\.)/gi;
		if (regex.test(temp))
			return false;
		return true;
	},

    isFunction : function(object){
    	
    	return $.isFunction(object);
    },
    

    isObject: function(object) {
        return object !== null && "object" === typeof object;
    },
    

    isArray: function(object) {
        return Array.isArray(object);
    },
    
    setUndefined: function(obj, value) {
		if (devUtil.isUndefined(obj))
			return value;
		return obj;
	},
	limitLength: function(value, compareValue) {
		if (value.length > parseInt(compareValue))
			return false;
		return true;
	},
	limitValue: function(value, compareValue) {
		if (value.length > compareValue.length || parseInt(value) > parseInt(compareValue))
			return false;
		return true;
	},
	limitByte: function(value, limitByte, target) {
		var str = value;
		var strByte = 0;
		var retStr = '';
		var dispByte = 0;
		for(i = 0, n = str.length; i < n; i++) {
			var ch = str.charAt(i);
			if(escape(ch).length > 4)
				strByte += 2;
	      	else
	      		strByte++;
			if (target != undefined && strByte <= limitByte)
				dispByte = strByte;
		}
		
		if (target != undefined)
			$("#"+target).text(dispByte);
		
		if (strByte > limitByte)
			return false;
		return true;
	},
	eqaulsToTrue: function(value, compareValue) {
		if (value == compareValue)
			return true;
		return false;
	},
	alert: function(message) {
		if (devUtil.isUndefined(message))
			return;
		if (message.isNullOrEmpty())
			return
		alert(message);
	},
	backValue: function(obj, isBack, length) {
		if (devUtil.isUndefined(isBack))
			isBack = true;
		if (isBack) {
			if (devUtil.isUndefined(obj))
				return;
			if (devUtil.isUndefined(obj.value))
				return;
			if (devUtil.isUndefined(length))
				length = obj.value.length - 1;
			obj.value = obj.value.substring(0, length);
		}
	},
	backByte: function(obj, isBack, byte) {
		if (devUtil.isUndefined(isBack))
			isBack = true;
		if (isBack) {
			if (devUtil.isUndefined(obj))
				return;
			if (devUtil.isUndefined(obj.value))
				return;
			
			var str = obj.value;
			var strByte = 0;
			var retStr = '';
			for(i = 0, n = str.length; i < n; i++) {
				var ch = str.charAt(i);
				if(escape(ch).length > 4)
					strByte += 2;
		      	else
		      		strByte++;
				if(strByte > byte)
					//retStr = byte - (strByte - byte);
					break;
				else
					retStr += ch;
			}
			obj.value = retStr;
		}
	},
	resetValue: function(obj, isReset) {
		if (devUtil.isUndefined(isReset))
			isReset = true;
		if (isReset) {
			if (devUtil.isUndefined(obj))
				return;
			if (devUtil.isUndefined(obj.value))
				return;
			obj.value = '';
		}
	},
	compareRegExp: function(value, reg) {
		return reg.test(value);
	},
	compareRegExpRev: function(value, reg) {
		return !this.compareRegExp(value, reg);
	},
	escapeHtml: function(arg) {
	
		let returnData;
	 
		let regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi;
	 
		// 찾는 문자열이 들어있는지 확인
		if(regExp.test(arg)){
			returnData = arg.replace(regExp, ""); // 찾은 특수 문자를 제거
		}else{
			returnData = arg;
		}
		
		return returnData;
	},
	stripScripts: function(value) {
 
    	//var pattern = /<script[^>]*>((\n|\r|.)*?)<\/script>/img;
    
    	//return value.replace(pattern, '');
    	
		var pattern = new RegExp("(<script[^>]*>(.|[\\s\\r\\n])*<"+"/script>)", "gim"); 
		
		return value.replace(pattern, "");
	},
	strLengToBytes: function (str){
		var VLength=0;
		var temp = str;
		var EscTemp;
		if(temp!="" & temp !=null){
			for(var i=0;i<temp.length;i++){
				if (temp.charAt(i)!=escape(temp.charAt(i))){
					EscTemp=escape(temp.charAt(i));
					if (EscTemp.length>=6)
						VLength+=2;
					else
						VLength+=1;
				}else
					VLength+=1;
			}
		}
		return VLength;
	},
	textCheck:function(str) {
		str = str.toLowerCase().replace(/\s/g, "");
		
		if (str.indexOf("alert(") > -1 || str.indexOf("&lt;form") > -1 || str.indexOf("<form") > -1 || str.indexOf("<script") > -1 ||
				str.indexOf("&lt;script") > -1 || str.indexOf("<iframe") > -1 || str.indexOf("&lt;iframe") > -1 || str.indexOf("function(") > -1 ||
				str.indexOf("onload=") > -1){
			alert("사용할 수 없는 텍스트가 포함되어 있습니다.");
			return false;
		}
		return true;
	}
	
	
};

	//쿠키등록
	function setCookie(name, value, expiredays) {
	    var todayDate = new Date();
	    todayDate.setDate(todayDate.getDate() + expiredays);
	    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	//쿠키읽기
	function getCookie(cookieName) {
	    var search = cookieName + "=";
	    var cookie = document.cookie; /* 현재 쿠키가 존재할 경우 */
	    if (cookie.length > 0) {
	        /* 해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴. */
	        startIndex = cookie.indexOf(cookieName); /* 만약 존재한다면 */
	        if (startIndex != -1) {
	            /* 값을 얻어내기 위해 시작 인덱스 조절 */
	            startIndex += cookieName.length; /* 값을 얻어내기 위해 종료 인덱스 추출 */
	            endIndex = cookie.indexOf(";", startIndex); /* 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정 */
	            if (endIndex == -1) endIndex = cookie.length; /* 쿠키값을 추출하여 리턴 */
	            return unescape(cookie.substring(startIndex + 1, endIndex));
	        } else {
	            /* 쿠키 내에 해당 쿠키가 존재하지 않을 경우 */
	            return '';
	        }
	    } else {
	        /* 쿠키 자체가 없을 경우 */
	        return '';
	    }
	}

	/* 로그만 쌓기 */
	function logSetGo(logUrl,descr){
		
		$.ajax({
			url : "/ebs/pot/poty/potLogSetAjax.ajax",
			data : {url:logUrl,descr:descr},
			dataType : "json",
			async : false,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type : 'POST',
			success : function(data) {
			},
			error : function(e) {
			}
		});
	}
	
	/*로그쌓고 행동
	행동이 없을경우 > nextStr : 'javascript:qwer=1'
	*/
	function logSetNext(logUrl,descr,nextStr){
		$.ajax({
			url : "/ebs/pot/poty/potLogSetAjax.ajax",
			data : {url:logUrl,descr:descr},
			dataType : "json",
			async : false,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type : 'POST',
			success : function(data) {
				if(nextStr.indexOf("javascript:") > -1){
					alert("지원하지 않습니다.");
				}else{
					location.href = nextStr;
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	//퍼블에서 사용하는 디바이스 
	function pubDeviceGbn(){
		var resultGbn = 'pc';
		try{
			if( matchMedia("screen and (min-width: 719.1px)").matches == false ){
				resultGbn = 'mob';
			}else if( matchMedia("screen and (min-width: 1023.1px)").matches == false ){
				//미만
				resultGbn = 'tab';
			}	
		}catch(e){
			var nowWidth = $(window).width();
			try{
				nowWidth = window.innerWidth;
			}catch(e){console.log(e);}
			if(nowWidth <= 719){
				resultGbn = 'mob';
			}else if(nowWidth <= 1023){
				resultGbn = 'tab';
			}
		}
		
		return resultGbn;
	}

	//객체 위치로 스크롤 이동	
	function focusScrollMove(objId){
		try{
			var divEl = $("#" +objId);
			var divY = divEl.offset().top;
			window.scrollTo({top:divY, left:0, behavior:'auto'});
		}catch(e){console.log(e);}
	}

	function replaceAll(str, searchStr, replaceStr) {
		  return str.split(searchStr).join(replaceStr);
	}

	function replaceBr(str) {
		
	    var str = replaceAll(str,'&lt;br/&gt;','<br/>');
	    str = replaceAll(str,'&lt;br&gt;','<br/>');
	    str = replaceAll(str,'&lt;br /&gt;','<br/>');
	    str = replaceAll(str,'&lt;br/ &gt;','<br/>');
		str = replaceAll(str,'&lt;BR/&gt;','<br/>');
	    str = replaceAll(str,'&lt;BR&gt;','<br/>');
	    str = replaceAll(str,'&lt;BR /&gt;','<br/>');
	    str = replaceAll(str,'&lt;BR/ &gt;','<br/>');

		return str;
	}
	
	function hybridWindowOpen(_url,_name,_option){
		var nowDevice = 'web';
		try{
			nowDevice = deviceAddInfo1; //전역변수 선언: top2023.jsp
		}catch(e){ console.log('no variable : deviceAddInfo1'); }
		
		if(nowDevice == 'web'){
			if(undefined == _name){
				_name = "_blank" ;
			}
			if(undefined == _option){
				window.open(_url,_name);				
			}else{
				window.open(_url,_name,_option);	
			}
		}else{
			var formName = 'f' + String(Math.round(Math.random()*1000000));
			var formBody = '<form id="' + formName +'" method="get" ';
			formBody += ' action="' + _url.split('?')[0] + '"';
			
			if(undefined == _name){
				formBody += ' target="_blank"';
			}else{
				formBody += ' target="' + _name + '"';
			}
			formBody += '>';
			
			var urlParams = new URLSearchParams(_url.includes('?') ? _url.split('?')[1] : '');
			urlParams.forEach(function(value, key){
				formBody += '<input type="hidden" name="'+key+'" value="'+value+'"/>';
			});
			
			formBody += '</form>';
			
			$('body').append(formBody);
			$('#' + formName).submit();
		}
		
	}
	