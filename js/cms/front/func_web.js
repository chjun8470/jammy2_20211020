
//내폰담기 목록담기
function actlogin(reUrl){
//	reUrl = "/sys/main.do";
	reUrl = reUrl;
//	if(reUrl == ""){
//		reUrl = "/sys/main.do";
//	}
	var id = $('#login_id').val();
	var pwd = $('#login_pwd').val();
	var siteId = $('#siteId').val();
	
	
	if(id == "" || pwd == ""){
		alert("로그인 정보가 없습니다.");
		return;
	}
	
	
	var params = {
			"userId":id
			,"userPwd":pwd
			};
	jQuery.post("/web/loginActionJson.do",jQuery.param(params),
	function(data) {
		var dataVal = "";
		var diffDays = "";
		for (var i in data) {
			dataVal = data.succCode;
			diffDays = data.diffDays;
		}
		
		if(dataVal == "OK"){
			try{
				if(siteId == "mjeinet"){
					window.location.href=reUrl;
				}else{
					window.close();
					opener.location.reload();
				}
			}catch(e){
				window.open('/');
				//window.close();
			}

			//window.location.href="/sso/mypage.do";
//			window.location.href="/sso/home.do";
			return;
		}else if(dataVal == "PROOF"){
			alert("이메일 인증이 필요합니다.");
			return;
		}else if(dataVal == "MISS"){
			alert("아이디 패스워드가 일치 하지 않습니다.");
			return;
		}else if(dataVal == "D30"){
			if(siteId == "smbrnd"){
				alert("전문가 회원님의 정보 공개 동의 만료 잔여 기한이 1개월 미만\n입니다. 회원님의 정보 공개 동의 만료 날짜는 ["+diffDays+"]\n이며, 지속적인 정보 공개를 원하시는 경우, 마이페이지에서\n해당 내용을 확인하시고 재 동의를 해주시기 바랍니다");				
			}
			window.close();
			opener.location.reload();
			return;
		}else if(dataVal == "D07"){
			if(siteId == "smbrnd"){
				alert("전문가 회원님의 정보 공개 동의 만료 잔여 기한이 1주일 미만\n입니다. 회원님의 정보 공개 동의 만료 날짜는 ["+diffDays+"]\n이며, 지속적인 정보 공개를 원하시는 경우, 마이페이지에서\n해당 내용을 확인하시고 재 동의를 해주시기 바랍니다");
			}
			window.close();
			opener.location.reload();
		}else{
			alert("로그인 정보가 없습니다.");
			return;
		}
	});
}


function ssoPopupShow(ssocode, siteId){
	if(ssocode == ""){ ssocode = "login";}
	//toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0
	if(ssocode == "join") {
		window.open("/sso/"+ssocode+".do?siteId="+siteId+"","SSO","width=800,height=620,scrollbars=yes,resizable=yes,toolbar=0,directories=0,status=no");
	}else if(ssocode == "mypage") {
		window.open("/sso/home.do?siteId="+siteId+"","SSO","width=800,height=620,scrollbars=yes,resizable=yes,toolbar=0,directories=0,status=no");
	}else{
	window.open("/sso/"+ssocode+".do?siteId="+siteId+"","SSO","width=800,height=620,scrollbars=yes,resizable=yes,toolbar=0,directories=0,status=no");
	}
}

//콤마찍기
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}


function chkPwd(str){
	 var pw = str;
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	 if(pw.length < 8 || pw.length > 20){
	  alert("8자리 ~ 20자리 이내로 입력해주세요.");
	  return false;
	 }
	 if(pw.search(/₩s/) != -1){
	  alert("비밀번호는 공백없이 입력해주세요.");
	  return false;
	 }
	 if(num < 0 || eng < 0){
	  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
	  return false;
	 }
	 return true;
	}