
//내폰담기 목록담기
function actlogin(reUrl){
//	reUrl = "/sys/main.do";
	reUrl = reUrl;
	if(reUrl == ""){
		reUrl = "/sys/main.do";
	}
	var id = $('#login_id').val();
	var pwd = $('#login_pwd').val();


	if(id == "" || pwd == ""){
		alert("로그인 정보가 없습니다.");
		return;
	}

	var params = {
			"userId":id
			,"userPwd":pwd
			};
	jQuery.post("/sys/loginActionJson.do",jQuery.param(params),
	function(data) {
		var dataVal = "";
		for (var i in data) {
			dataVal = data.succCode;
		}
		if(dataVal == "OK"){
			location.href = reUrl;
			//opener.parent.location='/sys/main.do'
			return;
		}else if(dataVal == "PROOF"){
			alert("이메일 인증이 필요합니다.");
			return;
		}else if(dataVal == "MISS"){
			alert("아이디 패스워드가 일치 하지 않습니다.");
			return;
		}else{
			alert("로그인 정보가 없습니다.");
			return;
		}
	});
}

//AI리포트 iframe 사이즈
function autoReportResize(id){
	var h = $('#'+id).contents().find('#subreport').height();
	$('#'+id).css('height',(h+100)+"px");
	//$('#'+id).contents().find('#subreport').css('margin-left', '-45px')
	//$('#'+id).contents().find('#subreport').css('margin-top', '-90px')
}
//AI리포트 페이지 설정
function hasScrolled(pageTop,endPage,startPage,id) {
  // 동작을 구현
	var currentPage = 1;
    var start = 0;
	var end = 0;
	start = pageTop[currentPage];
	currentPage++;
	if(currentPage > endPage)
		end = start + 999;
	else
		end   = pageTop[currentPage];
	currentPage--;
	var position = $(window).scrollTop();
	if(position < 10 ){
		$('#'+id).contents().find('#page option').eq(startPage-1).prop("selected", "selected");
		currentPage = startPage;
		return true;
	}
	if(position >= pageTop[endPage]){
		$('#'+id).contents().find('#page option').eq(endPage-1).prop("selected", "selected");
		currentPage = endPage;
		return true;
	}
	for(var i=startPage;i < endPage+1;i++){
		if(position >= pageTop[i] && position < pageTop[i+1]){
			$('#'+id).contents().find('#page option').eq(i-1).prop("selected", "selected");
			currentPage=i;;
			break;
		}
	}
	return true;
}
//라이트 박스1111
var nodeId = ''; // ID 값 지정
function lightBoxShow(nodeId){
	try{
		$('#'+nodeId).css('z-index','1001');
		$('#'+nodeId).show();
	}catch(e){ }
	$('#ligth_box').show(); //보이기
	$(window).scroll(function(){ lightBoxResize(); }); //스크롤 제어
	$(window).resize(function(){ lightBoxResize(); }); //리사이즈 제어
}

//금액콤마222
function commaCheck(value){
	alert(value);
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return value; 
}


//라이트박스 숨기기
function lightBoxClose(nodeId){
	$('#ligth_box').hide(); //숨기기
	try{  $('#'+nodeId).hide();  }catch(e){ }
	$(window).scroll(function(){ }); //스크롤 제어 끄기
	$(window).resize(function(){ }); //리사이즈 제어 끄기
}
