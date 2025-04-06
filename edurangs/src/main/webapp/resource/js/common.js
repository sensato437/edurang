$(document).ready(function() {
    //모바일일때 언어선택이 드롭다운리스트로 변환
    var mdlang = $('.nav_lang li.on').text();
    var mdlst = $('.selct');

    $(mdlst).children('a').text(mdlang);
    $(mdlst).click(function() {
        if ($(this).hasClass('on')) {
            $(this).removeClass('on');
        } else {
            $(this).addClass('on');
        }
    });

    //약관 팝업에서 "영상처리..." 있을시에 드롭다운 리스트로 변경
    var mdlang1 = $('.tab_myinfo_02 li.on').text();
    var mdlst1 = $('.mod_yamenu');
    $(mdlst1).children('a').text(mdlang1);

    $(mdlst1).click(function() {
        if ($(this).hasClass('on')) {
            $(this).removeClass('on');
        } else {
            $(this).addClass('on');
        }
    });

    //생년월일 드롭다운리스트
    $('.d_box').click(function() {
        var onscroll = $(this).siblings('.child_drop');
        var index = $(this).siblings('.child_drop').children('li.on').index();
        var hH = $(this).siblings('.child_drop').children('li').height();

        if ($(this).children('a').hasClass('on')) {
            $(this).children('a').removeClass('on');
            $(this).siblings('.child_drop').slideUp(200);
        } else {
            $('.para_drop .d_tag').removeClass('on');
            $('.para_drop .child_drop').slideUp(200);
            $(this).children('a').addClass('on');
            $(this).siblings('.child_drop').slideDown(200);
            $(onscroll).scrollTop(index * 35);
        }
    });

    // 드롭다운 항목 선택 시 이벤트
    $('.child_drop label').click(function() {
        var t1 = $(this).text();
        var s1 = $(this).parents('li');
        var t2 = $(this).parents().parents('.child_drop').siblings('.d_box').children('a').children('p');
        $(this).parents('li').addClass('on').siblings().removeClass('on');
        $(t2).text(t1);
        $(this).parents().parents('.child_drop').siblings('.d_box').children('a').removeClass('on');
        $(this).parents().parents('.child_drop').slideUp(200);
    });

    // 랜딩시 드롭다운에 on 이 있을시 (백단에서 선택시) 항목 텍스트 변경
    $('.para_drop').each(function(index) {
        var d1 = $(this).find('a').children('p');
        var d2 = $(this).find('.child_drop .on').children('label').text();
        if ($(this).find('.child_drop').children('li').hasClass("on") === true) {
            $(d1).text(d2);
        }
    });

    // 드롭다운 리스트가 펼쳐져 있을때 Body를 클릭시 닫기
    $("body").click(function(e) {
        if ($(".child_drop").is(":visible")) {
            var t = $(".child_drop").is(":visible");
            if (!$('.d_box').has(e.target).length) {
                $('body').find('.d_tag.on').removeClass('on');
                $(".child_drop").hide();
            }
        }
    });

    //생년월일 필드 체크
    $.chkBrithDay = function(txtMsg) {
        var msg = '';
        if ($(':input:radio[name=birthdayYear]:checked').val() == '' ||
            $(':input:radio[name=birthdayMonth]:checked').val() == '' ||
            $(':input:radio[name=birthdayDay]:checked').val() == '') {

            msg = '<label id="birthdayYear-error" class="error" for="birthdayYear">';
            msg += (txtMsg != null || txtMsg != '') ? txtMsg : '';
            msg += '</label>';
            $("#birthDay_desc").html(msg);
            return false;
        }
        return true;
    }
});