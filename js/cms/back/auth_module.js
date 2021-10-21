



	function orgAuthListShow(){
		var orgGrpNm = $('#orgGrpNm').val();

		var params = {
			"orgGrpNm" : orgGrpNm,
			"mode":"orglist"
		};

		jQuery.post("/sys/authOrg.do",$.param(params),
		function(data) {
			$('#orgAuthList').html(data);
		});
	}





	var nowOrgGrpCd = '';
	var nowOrgGrpNm = '';
	function authModuelShow(orgGrpCd,orgGrpNm){
		nowOrgGrpCd = orgGrpCd;
		nowOrgGrpNm = orgGrpNm;
		$('#orgAuthPopNm').text(orgGrpNm);

		var params = {
			"orgGrpCd":orgGrpCd,
			"mode":"modauthlist"
		};

		allModuleShow(orgGrpCd);

		jQuery.post("/sys/authOrg.do",$.param(params),
		function(data) {
			$('#authModule').html(data);
		});
	}






	function allModuleShow(orgGrpCd){

		var params = {
			"orgGrpCd":orgGrpCd,
			"mode":"modlist"
		};

		jQuery.post("/sys/authOrg.do",$.param(params),
		function(data) {
			$('#allModule').html(data);
		});
	}


	function orgModuleAdd(moduleInfoIdx){
		if(nowOrgGrpCd == ''){
			alert('기관을 선택해주세요');
			return;
		}
		var params = {
				"orgGrpCd":nowOrgGrpCd,
				"moduleInfoIdx":moduleInfoIdx,
				"mode":"modadd"
			};

			jQuery.post("/sys/authOrg.do",$.param(params),
			function(data) {
				authModuelShow(nowOrgGrpCd,nowOrgGrpNm);
			});



	}
	function orgModuleDel(moduleInfoIdx){
		if(nowOrgGrpCd == ''){
			alert('기관을 선택해주세요');
			return;
		}
		var params = {
			"orgGrpCd":nowOrgGrpCd,
			"moduleInfoIdx":moduleInfoIdx,
			"mode":"moddel"
		};

		jQuery.post("/sys/authOrg.do",$.param(params),
		function(data) {
			authModuelShow(nowOrgGrpCd,nowOrgGrpNm);
		});
	}



	function menuOver(code,myNode){
		$(myNode).css('background-color','#abeafe');
	}


	function menuOut(code,myNode){
		if(code==1){
			$(myNode).css('background-color','#ffffff');
		}else{
			$(myNode).css('background-color','#f9f9f9');
		}

	}


	$(function(){
		orgAuthListShow();

	});
