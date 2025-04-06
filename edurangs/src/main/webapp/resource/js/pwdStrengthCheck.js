function addLoadEvent(func) {
    var oldonload = window.onload;
    if (typeof window.onload != "function") {
        window.onload = func;
    } else {
        window.onload = function() {
            if (oldonload) {
                oldonload();
            }
            func();
        };
    }
}

function $() {
    var arrElms = [];
    for (var i = 0; i < arguments.length; i++) {
        var elm = arguments[i];
        if (typeof(elm == "string")) {
            elm = document.getElementById(elm);
        }
        if (arguments.length == 1) {
            return elm;
        }
        arrElms.push(elm);
    }
    return arrElms;
}

String.prototype.strReverse = function() {
    var newstring = "";
    for (var s = 0; s < this.length; s++) {
        newstring = this.charAt(s) + newstring;
    }
    return newstring;
    //strOrig = ' texttotrim ';
    //strReversed = strOrig.revstring();
};

function validate1() {
    var chk = 0;
    var upw = $('#password').val();
    if (upw.search(/[0-9]/g) != -1) chk++;
    if (upw.search(/[a-z]/ig) != -1) chk++;
    if (upw.search(/[\^\$\(\)\*\+\.\/\?\[\]\\\{\}\|\-,!"#%&':;<=>@_`~]/g) != -1) chk++;

    if (!((chk >= 3 && upw.length >= 8) || (chk >= 2 && upw.length >= 10))) {
        return false;
    }
    return true;
};

function validate2() {
    var upw = $('#password').val();
    if (upw.search($('#userId').val()) > -1 && $('#userId').val() != "") {
        return false;
    }
    return true;
};

function validate3() {
    var upw = $('#password').val();
    if (/(\w)\1\1\1/.test(upw)) {
        return false;
    }
    return true;
};

// 비밀번호 강도 체크

//pwdStrengthCheck
function pwdStrengthCheck(pwd, contextPath) {
    var passwordMessage = $("#passwordMessage");
    var nScore = 0,
        nLength = 0,
        nAlphaUC = 0,
        nAlphaLC = 0,
        nNumber = 0,
        nSymbol = 0,
        nMidChar = 0,
        nRequirements = 0,
        nAlphasOnly = 0,
        nNumbersOnly = 0,
        nUnqChar = 0,
        nRepChar = 0,
        nRepInc = 0,
        nConsecAlphaUC = 0,
        nConsecAlphaLC = 0,
        nConsecNumber = 0,
        nConsecSymbol = 0,
        nConsecCharType = 0,
        nSeqAlpha = 0,
        nSeqNumber = 0,
        nSeqSymbol = 0,
        nSeqChar = 0,
        nReqChar = 0,
        nMultConsecCharType = 0;
    var nMultRepChar = 1,
        nMultConsecSymbol = 1;
    var nMultMidChar = 2,
        nMultRequirements = 2,
        nMultConsecAlphaUC = 2,
        nMultConsecAlphaLC = 2,
        nMultConsecNumber = 2;
    var nReqCharType = 3,
        nMultAlphaUC = 3,
        nMultAlphaLC = 3,
        nMultSeqAlpha = 3,
        nMultSeqNumber = 3,
        nMultSeqSymbol = 3;
    var nMultLength = 4,
        nMultNumber = 4;
    var nMultSymbol = 6;
    var nTmpAlphaUC = "",
        nTmpAlphaLC = "",
        nTmpNumber = "",
        nTmpSymbol = "";
    var sAlphas = "abcdefghijklmnopqrstuvwxyz";
    var sNumerics = "01234567890";
    var sSymbols = ")!@#$%^&*()"; //추가를 해야할지 고민이 필요함.
    var textHeader = "";
    var secureGradeIcon = "";
    var minPwdLen = 8;
    var icons = ['/images/com/pwdSecureGrade1.gif', '/images/com/pwdSecureGrade2.gif', '/images/com/pwdSecureGrade3.gif', '/images/com/pwdSecureGrade4.gif'];
    if (document.all) {
        var nd = 0;
    } else {
        var nd = 1;
    }


    if (pwd) //password가 있는지 먼저 검사
    {
        if (pwd.length >= minPwdLen && validate1() && validate2() && validate3()) {
            if ($('#userId').val() == $('#password').val()) {
                textHeader = "<font color='gray'><b>불가</b></font>&nbsp;";
                secureGradeIcon = contextPath + icons[0];
            } else {
                nScore = parseInt(pwd.length * nMultLength);
                nLength = pwd.length;
                var arrPwd = pwd.replace(/\s+/g, "").split(/\s*/);
                var arrPwdLen = arrPwd.length;

                /* Loop through password to check for Symbol, Numeric, Lowercase and Uppercase pattern matches */
                for (var a = 0; a < arrPwdLen; a++) {
                    if (arrPwd[a].match(/[A-Z]/g)) {
                        if (nTmpAlphaUC !== "") {
                            if ((nTmpAlphaUC + 1) == a) {
                                nConsecAlphaUC++;
                                nConsecCharType++;
                            }
                        }
                        nTmpAlphaUC = a;
                        nAlphaUC++;
                    } else if (arrPwd[a].match(/[a-z]/g)) {
                        if (nTmpAlphaLC !== "") {
                            if ((nTmpAlphaLC + 1) == a) {
                                nConsecAlphaLC++;
                                nConsecCharType++;
                            }
                        }
                        nTmpAlphaLC = a;
                        nAlphaLC++;
                    } else if (arrPwd[a].match(/[0-9]/g)) {
                        if (a > 0 && a < (arrPwdLen - 1)) {
                            nMidChar++;
                        }
                        if (nTmpNumber !== "") {
                            if ((nTmpNumber + 1) == a) {
                                nConsecNumber++;
                                nConsecCharType++;
                            }
                        }
                        nTmpNumber = a;
                        nNumber++;
                    } else if (arrPwd[a].match(/[^a-zA-Z0-9_]/g)) {
                        if (a > 0 && a < (arrPwdLen - 1)) {
                            nMidChar++;
                        }
                        if (nTmpSymbol !== "") {
                            if ((nTmpSymbol + 1) == a) {
                                nConsecSymbol++;
                                nConsecCharType++;
                            }
                        }
                        nTmpSymbol = a;
                        nSymbol++;
                    }
                    /* Internal loop through password to check for repeat characters */
                    var bCharExists = false;
                    for (var b = 0; b < arrPwdLen; b++) {
                        if (arrPwd[a] == arrPwd[b] && a != b) { /* repeat character exists */
                            bCharExists = true;
                            nRepInc += Math.abs(arrPwdLen / (b - a));
                        }
                    }
                    if (bCharExists) {
                        nRepChar++;
                        nUnqChar = arrPwdLen - nRepChar;
                        nRepInc = (nUnqChar) ? Math.ceil(nRepInc / nUnqChar) : Math.ceil(nRepInc);
                    }
                }

                /* Check for sequential alpha string patterns (forward and reverse) */
                for (var s = 0; s < 23; s++) {
                    var sFwd = sAlphas.substring(s, parseInt(s + 3));
                    var sRev = sFwd.strReverse();
                    if (pwd.toLowerCase().indexOf(sFwd) != -1 || pwd.toLowerCase().indexOf(sRev) != -1) {
                        nSeqAlpha++;
                        nSeqChar++;
                    }
                }

                /* Check for sequential numeric string patterns (forward and reverse) */
                for (var s = 0; s < 8; s++) {
                    var sFwd = sNumerics.substring(s, parseInt(s + 3));
                    var sRev = sFwd.strReverse();
                    if (pwd.toLowerCase().indexOf(sFwd) != -1 || pwd.toLowerCase().indexOf(sRev) != -1) {
                        nSeqNumber++;
                        nSeqChar++;
                    }
                }

                /* Check for sequential symbol string patterns (forward and reverse) */
                for (var s = 0; s < 8; s++) {
                    var sFwd = sSymbols.substring(s, parseInt(s + 3));
                    var sRev = sFwd.strReverse();
                    if (pwd.toLowerCase().indexOf(sFwd) != -1 || pwd.toLowerCase().indexOf(sRev) != -1) {
                        nSeqSymbol++;
                        nSeqChar++;
                    }
                }


                /* General point assignment */
                if (nAlphaUC > 0 && nAlphaUC < nLength) {
                    nScore = parseInt(nScore + ((nLength - nAlphaUC) * 2));
                }
                if (nAlphaLC > 0 && nAlphaLC < nLength) {
                    nScore = parseInt(nScore + ((nLength - nAlphaLC) * 2));
                }
                if (nNumber > 0 && nNumber < nLength) {
                    nScore = parseInt(nScore + (nNumber * nMultNumber));
                }
                if (nSymbol > 0) {
                    nScore = parseInt(nScore + (nSymbol * nMultSymbol));
                }
                if (nMidChar > 0) {
                    nScore = parseInt(nScore + (nMidChar * nMultMidChar));
                }

                /* 점수 감산 */
                if ((nAlphaLC > 0 || nAlphaUC > 0) && nSymbol === 0 && nNumber === 0) { // Only Letters
                    nScore = parseInt(nScore - nLength);
                    nAlphasOnly = nLength;
                }
                if (nAlphaLC === 0 && nAlphaUC === 0 && nSymbol === 0 && nNumber > 0) { // Only Numbers
                    nScore = parseInt(nScore - nLength);
                    nNumbersOnly = nLength;
                }
                if (nRepChar > 0) { // Same character exists more than once
                    nScore = parseInt(nScore - nRepInc);
                }
                if (nConsecAlphaUC > 0) { // Consecutive Uppercase Letters exist
                    nScore = parseInt(nScore - (nConsecAlphaUC * nMultConsecAlphaUC));
                }
                if (nConsecAlphaLC > 0) { // Consecutive Lowercase Letters exist
                    nScore = parseInt(nScore - (nConsecAlphaLC * nMultConsecAlphaLC));
                }
                if (nConsecNumber > 0) { // Consecutive Numbers exist
                    nScore = parseInt(nScore - (nConsecNumber * nMultConsecNumber));
                }
                if (nSeqAlpha > 0) { // Sequential alpha strings exist (3 characters or more)
                    nScore = parseInt(nScore - (nSeqAlpha * nMultSeqAlpha));
                }
                if (nSeqNumber > 0) { // Sequential numeric strings exist (3 characters or more)
                    nScore = parseInt(nScore - (nSeqNumber * nMultSeqNumber));
                }
                if (nSeqSymbol > 0) { // Sequential symbol strings exist (3 characters or more)
                    nScore = parseInt(nScore - (nSeqSymbol * nMultSeqSymbol));
                }

                /* Determine if mandatory requirements have been met and set image indicators accordingly */
                var arrChars = [nLength, nAlphaUC, nAlphaLC, nNumber, nSymbol];
                var arrCharsIds = ["nLength", "nAlphaUC", "nAlphaLC", "nNumber", "nSymbol"];
                var arrCharsLen = arrChars.length;
                for (var c = 0; c < arrCharsLen; c++) {
                    if (arrCharsIds[c] == "nLength") {
                        var minVal = parseInt(minPwdLen - 1);
                    } else {
                        var minVal = 0;
                    }

                    if (arrChars[c] == parseInt(minVal + 1)) {
                        nReqChar++;
                    } else if (arrChars[c] > parseInt(minVal + 1)) {
                        nReqChar++;
                    }
                }

                nRequirements = nReqChar;
                if (pwd.length >= minPwdLen) {
                    var nMinReqChars = 3;
                } else {
                    var nMinReqChars = 4;
                }

                if (nRequirements > nMinReqChars) { // One or more required characters exist
                    nScore = parseInt(nScore + (nRequirements * 2));
                }

                /* 점수로 등급 산정
                 * nScore가 점수!!
                 *  */
                if (nScore > 100) {
                    nScore = 100;
                } else if (nScore < 0) {
                    nScore = 0;
                }
                if (nScore >= 0 && nScore <= 40) {
                    textHeader += "<font color='#D2312D'><b>낮음</b></font>&nbsp;";
                    secureGradeIcon = contextPath + icons[1];
                } else if (nScore > 40 && nScore <= 70) {
                    textHeader += "<font color='#E8BF3A'><b>적정</b></font>&nbsp;";
                    secureGradeIcon = contextPath + icons[2];
                } else if (nScore > 70 && nScore <= 100) {
                    textHeader += "<font color='#43BAF0'><b>높음</b></font>&nbsp;";
                    secureGradeIcon = contextPath + icons[3];
                }
            }
        } else // 8자리 미만이면서 사용 불가능한 특수 문자가 포함됐을 경우, 아이디랑 같을 경우
        {
            textHeader = "<font color='gray'><b>불가</b></font>&nbsp;";
            secureGradeIcon = contextPath + icons[0];
        }

        //이곳에서 화면에 출력
        passwordMessage.html("보안등급:&nbsp;&nbsp;" + textHeader + "<img width='12' height='12' src='" + secureGradeIcon + "' />");

    } else {
        initPwdChk();
    }
}

/*
 * view 초기화.
 * **/
function initPwdChk() {
    $("#passwordMessage").html("");
}

addLoadEvent(function() {
    initPwdChk(1);
});