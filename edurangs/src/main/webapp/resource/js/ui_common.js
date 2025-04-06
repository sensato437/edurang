/*-------------------------------------------------------------------
	분류순서
	- @Variables	: 전역변수
	- @Init			: 초기실행
	- @Settings		: 기본설정
	- @Utility		: 유틸기능
	- @Layout		: 레이아웃
	- @Components	: 컴포넌트
	- @Content		: 컨텐츠
-------------------------------------------------------------------*/
/*-------------------------------------------------------------------
	@Variables
-------------------------------------------------------------------*/
//Elements
var	$window			= null,
	$document		= null,
	$html			= null,
	$body			= null,
	$html_body		= null,
	$wrap			= null,
	$header			= null,
	$activeFocus	= null,
_;

//24-04-12 중복제거
//function getCookie(){
    //return '';
//}

//Devices
var isIOS			= browser.os == 'ios',
	isANDROID		= browser.os == 'android',
	isMOBILE		= browser.mobile == true,
	isPC			= browser.mobile == false,	
	breakPC			= 1024,
	breakTA			= 720,
	isBreakPC		= function(){ 
		if (breakPC <= $(window).width()){
			return true;
		} else {
			return false;
		}		
	}
	isBreakTA		= function(){ 
		if (breakPC > $(window).width() && breakTA <= $(window).width()){
			return true;
		} else {
			return false;
		}
	}
	isBreakMO		= function(){ 
		if (breakTA > $(window).width()){
			return true;
		} else {
			return false;
		}
	}
_;

/* 초기실행 (설정, 재실행) */
function set_UI(){
	/* Settings */
	setElements();
	setDevices();
	setEvents();
    navStickyInit();
    mnbInit();
	tabInit();
}

/* 엘리먼트 설정 */
function setElements(){
	$window		= $(window);
	$document	= $(document);
	$html		= $('html');
	$body		= $('body');
	$html_body	= $('html, body');
	$wrapper	= $('.wrap');
	$header		= $('header');
	$document.off('focusin.eleEvent click.eleEvent').on('focusin.eleEvent click.eleEvent', function(e){
		$activeFocus = $(e.target);
	})
}

/* 디바이스설정 - OS, Version, Browser */
function setDevices(){
	var cls = 'dv_';
	var browserDevice = function(){ return browser.mobile == true ? 'mobile' : 'pc' }
	var clsBrowser = ''
		+ cls + browser.name
		+ ' ' + cls + browser.name + browser.version
		+ ' ' + cls + browser.os
		+ ' ' + cls + browser.os + Math.floor(browser.osVersion)
		+ ' ' + cls + browserDevice();
	$body.addClass(clsBrowser);
}

/* 윈도우 커스텀이벤트설정 - scrollEnd, resizeEnd */
function setEvents(){
	var resizeEndTime, scrollEndTime;
	//Scroll
	$window.off('scroll.customEvent').on('scroll.customEvent', function(){
		clearTimeout(scrollEndTime); scrollEndTime = setTimeout(function(){ $window.trigger('scrollEnd') }, 100);
	});
	//Resize
	$window.off('resize.customEvent').on('resize.customEvent', function(){
		clearTimeout(resizeEndTime); resizeEndTime = setTimeout(function(){ $window.trigger('resizeEnd') }, 100);
	});
}

$(function () {
	/* slick slide type1 - footer family site */
	$('.slider_family').slick({
		infinite: false,
		arrows: true,
		slidesToShow: 5, // 2024-07-04 수정
		slidesToScroll: 1,
		speed: 600,
		focusOnChange: true,
		accessibility: true,
		responsive: [
			{
				breakpoint: 1024,
				settings: {
					slidesToShow: 3
				}
			},
			{
				breakpoint: 720,
				settings: {
					slidesToShow: 2
				}
			}
		]
	});

	// modal open button
	/*
		팝업 버튼 내
		'data-modal-id'의 속성 값을
		팝업 영역의 id로 하여 찾은 후 열림
	 */
	$('.modal_btn').click(function (e) {
		e.preventDefault();
		var $modalId = $('#' + $(this).data('modalId'));
		// 현재 열린 팝업 창이 있으면, 해당 팝업을 닫은 후 열림
		if ($('html').hasClass('modal_open')) {
			$('.modal').removeClass('active');
		}

		$('html').addClass('modal_open');
		$modalId.addClass('active');
	});
	// modal clise event
	$('.modal_close').on('click', function(e) {
		e.preventDefault();
		$(this).closest('.modal').removeClass('active');
		$('html').removeClass('modal_open');
	})

	$('.btn_noti_close').on('click.notiLayer', function(e){
		$(this).closest('.noti_layer').removeClass('active');
		if ($('.noti_layer.active').length == 0){
			$('.noti_layer_wrap').removeClass('active');
		}
	});
})

/* MNB Navigation */
function mnbOpen(){
	$('html').addClass('mm-opened');
	$('body').addClass('no_scroll');
	$('.dim').fadeIn(200);
	$('.dim').css({'height':$(window).height(),'width':$(window).width()});
	$('.mobile_menu').animate({'left':'0px'},300,function(){
		$(this).addClass('act');
		$('.m_menu_grade_slide').slick('slickGoTo', 2); // 2024-04-12 추가
	});
};

function mnbClose(){
	$('body').removeClass('no_scroll');
	$('.dim').fadeOut(200);
	$('.dim').hide().removeAttr('style');
	$('.mobile_menu').stop().animate({'left':'-100%'},300,function(){   
		$(this).removeClass('act');
		$('html').removeClass('mm-opened');
	});
};

function mnbInit(){
	$('header .all_menu').click(mnbOpen);
	$('.mobile_menu_close').click(mnbClose);
	$('.dim').bind('touchstart click', function() {
		mnbClose();
		return false;
	});
	
	$('.menu_area li.dep01 > div').addClass('submenu_div');
	$('.menu_area').off('click', '.dep_menu li.dep01 a.dep01').on('click', '.dep_menu li.dep01 a.dep01' , function(){
		$(this).parent().addClass('on').siblings().removeClass('on');
		gnbScrollFunc(true);
	});
	
	var gnbScrollFunc = function(flag) {		// ios bounce scroll prevent!!
		var __div = $('.menu_area').find('li.dep01.on > div');
		var _div = $('.menu_area').find('li.dep01 > div');
		__div.find('a:first').focus().blur();
		$(document).off('mousedown.ft touchstart.ft mousemove.ft touchmove.ft');
		__div.off('mousedown.ft touchstart.ft mousemove.ft touchmove.ft');
		if ( !window.navigator.userAgent.toLowerCase().match(/ipad|iphone/) ) {
			_div.stop().scrollTop(0);
			return false; // iphone, ipad인 경우만 touch event 실행
		} else {
			_div.stop().scrollTop(0);
			__div.addClass('has_scroll');
		}
		_div.off('scroll').on('scroll', function(e) {
			if ( $(this).scrollTop() <= 10 ) {
				$(this).scrollTop(10);
			} else if ( $(this).scrollTop() >= this.scrollHeight-$(this).outerHeight()-10 ) {
				$(this).scrollTop( this.scrollHeight-$(this).outerHeight()-10 );
			}
		});
	};
}

/* Tab */
function tabInit(){
	$document.off('click.tabEvent').on('click.tabEvent', '.tab > ul li', function(e){ 
		e.preventDefault();
		var id = $(this).data('id');
		var callback = null;

		//속성으로 콜백함수 처리
		if ($(this).data('callback') != '' && $(this).data('callback') != undefined){
			var str = $(this).data('callback');
			callback = getNewFunction(str);
		}
		tabAction(id, function(){ callback });
	});
}
function tabAction(id, callback){
	var $btn = $('[data-id="'+id+'"]');
	var $cont = $("#"+ id);
	var $tab = $("#"+ id).closest('.tab');
	
	$btn.addClass('on').siblings().removeClass('on');
	$cont.addClass('on').siblings('.con_box').removeClass('on');

	//콜백처리
	if (typeof(callback) == 'function'){ callback }
}

/* Toggle */
function toggleInit(){
	$(document).off('click.toggleEvent').on('click.toggleEvent', '.js_toggle', function(){
		var id = $(this).data('id');
		toggleAction(id);
	})
}

/* Nav Sticky */
function navStickyInit(){
	/* sticky bar */
	if( $("nav").offset() ){
		
		$(window).on('resize, scroll', function() {
			var navTop = $("header").offset().top + $("header").outerHeight();
			var scrTop = $(this).scrollTop();
			if(navTop < scrTop) {
				$("nav").addClass("sticky");
			} else {
				$("nav").removeClass("sticky");
			}
		})
	}	

	/* layer modal */
	$document.off('click.layerOpen').on('click.layerOpen', '.layer_full_open', function(e){
		e.preventDefault();
		$(".layer_full").stop().fadeIn(300);
	});
	$document.off('click.layerClose').on('click.layerClose', '.layer_full .close', function(e){
		e.preventDefault();
		$(".layer_full").stop().fadeOut(300);
	});
}

// 모바일 메뉴 스크롤 업 & 다운
var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('.mobile_gnb').outerHeight();

$(window).scroll(function(event){
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);

function hasScrolled() {
    var st = $(this).scrollTop();
    if(Math.abs(lastScrollTop - st) <= delta)
        return;
    if (st > lastScrollTop && st > navbarHeight){
        // Scroll Down
        $('.mobile_gnb').removeClass('nav-down').addClass('nav-up');
         
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('.mobile_gnb').removeClass('nav-up').addClass('nav-down');
        }
    }
    lastScrollTop = st;
}

function slickAdlider(){
	var slickObjArr = $(".adSlider");
	for(var i=0;i<slickObjArr.length;i++){
		
	    if($(slickObjArr[i]).find('.slick-track').length == 0){		
		    $(slickObjArr[i]).slick({
		        infinite: true,
		        autoplay: false,
		        autoplaySpeed: 4000,
		        speed: 400,
		        slidesToShow: 1,
		        slidesToScroll: 1,
		        adaptiveHeight: true,
		        arrows: false,
		        dots: true
		    });
	    }
	}
}

$(function(){
	navbarHeight = $('.mobile_gnb').outerHeight();

    // pc 전체메뉴
	$('.fullMenu').off("click");
    $('.fullMenu').on('click', function(){
        $(this).toggleClass('active');
        $('nav').toggleClass('on');
        $('.bg_depth').toggleClass('bg_depth_hover');
    });

    // pc 서브메뉴 hover
    $('.depth').mouseenter(function(){
        $(this).siblings('a').addClass('on');
    });
    $('.depth').mouseleave(function(){
        $(this).siblings('a').removeClass('on');
    });

    // mobile 학년 탭
    $('.grade_menu_new > li.on > a, .acc_sub').on('click', function(){
        $(this).toggleClass('on');
    });
 
    // .grade_menu_new 데스크탑 미만 사이즈 슬라이더
    $('.grade_menu_slider_under1024 .slider').each(function () {
        var notDesktop = false;
        var isTeachSlide = false;
        var $this = $(this);
        $(window).on('resizeEnd', function () {		
			var slideOn = false;
			try{
				if (matchMedia("screen and (min-width: 1023.1px)").matches == false) { slideOn = true; }
			}catch(e){
	            var $winWidth = $(this).width();
				try{ $winWidth = window.innerWidth; }catch(e){console.log(e);}
	            if ($winWidth < 1023.1) { slideOn = true; }
			}
            if (slideOn == true) {
                if (isTeachSlide == false) {
		    	if($(this).find('.slick-track').length == 0){
                    $this.slick({
                        infinite: false,
                        speed: 300,
                        slidesToShow: 4,
                        slidesToScroll: 1,
                        arrows: false,
                        responsive: [{
                            breakpoint: 460,
                            settings: {
                                slidesToShow: 3.1,
                                slidesToScroll: 1
                            }
                        }]
                    });
                    isTeachSlide = true;
				}
                }
            } else {
                if (isTeachSlide == true) {
                    $this.slick('unslick');
                    isTeachSlide = false;
                }
            }
        });
        $(window).trigger('resizeEnd');
    });

    // 모바일 학년 텝 슬라이드
    $('.m_menu_grade_slide').slick({
        infinite: false,
        autoplay: false,
        speed: 400,
        slidesToShow: 5,
        slidesToScroll: 1,
        rows: 1,
        draggable : true,
        initialSlide: 0,
        focusOnSelect: true,
        //centerMode:true,
        centerPadding:'0px',
        dots:false,
        arrows:false,
        responsive: [
            {
              breakpoint: 719,
              settings: {
                slidesToShow: 3.5,
                slidesToScroll: 1
              }
            },
        ],
        observer:true, 
        observeParents:true,
    });
});

$(function(){
    set_UI();
})
