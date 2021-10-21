	//주소
	function orgPost(){
		new daum.Postcode({
			oncomplete: function(data) {
				document.getElementById('zipCode').value = data.zonecode;

				if (data.userSelectedType === 'R') {
					// 도로명 주소 선택시
					var adrs = data.roadAddress;
					if (data.buildingName != undefined && data.buildingName.length > 0) {
						adrs += ' (' + data.buildingName + ')';
					}
					document.getElementById('addr1').value = adrs;
				} else {
					// 지번 주소 선택시
					document.getElementById('addr1').value = data.jibunAddress;
				}
				document.getElementById('addr2').focus();
			}
		}).open();
	}
	function loadOrgAddr(){
		var addr1 = $('#orgAddr1').val();
		var addr2 = $('#orgAddr2').val();
		var zipcode =  $('#zip').val();
		$('#addr1').val(addr1);
		$('#addr2').val(addr2);
		$('#zipCode').val(zipcode);
	}

	function orgGrpShow(code,grpIdx,grpAuthIdx,grnum,grsubnum){
		//alert("code= "+code+" grpidx= "+grpIdx+" grpAuthIdx= "+grpAuthIdx+" grnum= "+grnum+" grsubnum= "+grsubnum);
		$("#selGrnum").val(grnum);
		$("#selGrsubnum").val(grsubnum);
		if(grpIdx == ''){
			alert("항목 선택이 잘못되었습니다.");
			return;
		}

		$('#selOrgNm').text($('#orgNm_'+grnum).val());

		if(grsubnum == 'N'){
			$('#selOrgSubNm').text($('#orgNm_'+grnum).val());
			$('#selOrgCd').val(grpIdx);
			$('#selOrgSubCd').val(grpIdx);
			$('#inpSubOrgDel').hide();
		}else{
			$('#selOrgSubNm').text($('#orgNm_'+grnum+'_'+grsubnum).val());
			$('#selOrgCd').val(grpIdx);
			$('#selOrgSubCd').val(grpAuthIdx);
			$('#inpSubOrgDel').show();
		}

		orgNoGrpShow(code,grpIdx);

		var params = {
        				"code":code,
        				"orgGrpCd":grpIdx,
        				"orgGrpAuthCd":grpAuthIdx,
                        "mode":"usershow"
				};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			$('#authUser').html(data);
		});


	}


	function orgNoGrpShow(code,grpIdx){
		//alert("code= "+code+" grpidx= "+grpIdx);
		if(grpIdx == ''){
			alert("항목을 선택이 잘못되었습니다.");
			return;
		}

		var params = {
        				"code":code,
        				"orgGrpCd":grpIdx,
                        "mode":"nousershow"
				};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			$('#noAuthUser').html(data);
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

	function subOrgShow(event,nm,cd,addr1,addr2,zipcode){
		$('#authPopBox').css('top',(event.clientY-220)+'px');
		$('#orgAuthPopNm').html(nm);
		$('#orgAuthPopCd').val(cd);
		$('#orgAuthPopSubCd').val('');
		$('#orgSubAuthPopNm').val('');

		$('#zipCode').val('');
		$('#addr1').val('');
		$('#addr2').val('');
		$('#orgPhone').val('');
		$('#orgFax').val('');


		$('#btnAuthWirtePop').show(); //찾아보기 & 기관주소불러오기 버튼
		$('#btnAuthWirtePop2').show(); //저장버튼
		$('#btnAuthEditPop').hide(); //수정버튼
		$('#orgAddr1').val(addr1);
		$('#orgAddr2').val(addr1);
		$('#zip').val(zipcode);
		$('#authPopBox').show();

		subOrgAuthHide();
	}

	function subOrgHide(){
		$('#orgAuthPopNm').text('');
		$('#orgAuthPopCd').val('');
		$('#orgSubAuthPopNm').val('');
		$('#addr1').val('');
		$('#addr2').val('');
		$('#zipCode').val('');
		$('#orgPhone').val('');
		$('#orgFax').val('');
		$('#authPopBox').hide();
	}
	
	//체크박스 전체 체크
	function subOrgAuthCheck(){
		if(document.getElementById("sub_org_auth_check").checked ){
			//alert("!" + $("#sub_org_auth_check").attr("checked"));
			$(".all_check_box").prop("checked",true);
		}else{
			//alert("?" + $("#sub_org_auth_check").attr("checked"));
			$(".all_check_box").prop("checked",false);
		}
		
	}
	//권한저장
	function subOrgAuthSave(){


		var selOrgCd = $('#selOrgCd').val();
		var selOrgSubCd = $('#selOrgSubCd').val();
		var reqUserIdx = $('#reqUserIdx').val();

		var grpTp = $('#grpTp').val();

		if(grpTp == 'org'){
			if(selOrgCd == '' || selOrgSubCd == ''){
				alert("선택기관 정보가 없습니다.");
				return;
			}
		}else if(grpTp == 'user'){
			if(reqUserIdx == ''){
				alert('선택된 개인 정보가 없습니다.');
				return;
			}
		}

		var authList = "";
		var listcnt = 0;
		$('input[name=auth_md_list]').each(function(){
			var dot = "";
			if(listcnt != 0) dot = ",";
			if($(this).is(':checked')){
				authList += dot+"Y";
			}else{
				authList += dot+"N";
			}
			listcnt++;
		});

		var authWrite = "";
		var writecnt = 0;
		$('input[name=auth_md_write]').each(function(){
			var dot = "";
			if(writecnt != 0) dot = ",";
			if($(this).is(':checked')){
				authWrite += dot+"Y";
			}else{
				authWrite += dot+"N";
			}
			writecnt++;
		});



		var authEdit = "";
		var editcnt = 0;
		$('input[name=auth_md_edit]').each(function(){
			var dot = "";
			if(editcnt != 0) dot = ",";
			if($(this).is(':checked')){
				authEdit += dot+"Y";
			}else{
				authEdit += dot+"N";
			}
			editcnt++;
		});
		var authDel = "";
		var delcnt = 0;

		$('input[name=auth_md_del]').each(function(){
			var dot = "";
			if(delcnt != 0) dot = ",";
			if($(this).is(':checked')){
				authDel += dot+"Y";
			}else{
				authDel += dot+"N";
			}
			delcnt++;
		});

		var authMdIdx = "";
		var mdIdxCnt = 0;
		$('input[name=auth_md_info_idx]').each(function(){

			var dot = "";
			if(mdIdxCnt != 0) dot = ",";
			authMdIdx += dot+$(this).val();
			mdIdxCnt++;
		});


		var params = {
				"code":grpTp,
				"reqUserIdx":reqUserIdx,
				"orgGrpCd":selOrgCd,
				"orgGrpSubCd":selOrgSubCd,
				"authMdIdx":authMdIdx,
				"authList":authList,
				"authWrite":authWrite,
				"authEdit":authEdit,
				"authDel":authDel,
				"mode":"moduleauthsave"
				};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			if(data.state == 'OK'){

				var params = {
						"code":grpTp,
						"reqUserIdx":reqUserIdx,
						"orgGrpCd":selOrgCd,
						"orgGrpSubCd":selOrgSubCd,
		                "mode":"moduleauthlist"
				};

				jQuery.post("/sys/orgModuleManager.do",$.param(params),
				function(data) {
					$('#moduleList').html(data);
				});

				alert('저장되었습니다.');
			}
		});

	}

	//그룹 저장
	function subOrgWrite(){

		var orgAuthPopCd = $('#orgAuthPopCd').val();
		var orgSubAuthPopNm = $('#orgSubAuthPopNm').val();
		var zipCode = $('#zipCode').val();
		var addr1 = $('#addr1').val();
		var addr2 = $('#addr2').val();
		var orgPhone = $('#orgPhone').val();
		var orgFax = $('#orgFax').val();


		if(orgAuthPopCd == '' || orgSubAuthPopNm == ''){
			alert("항목을 입력해주세요.");
			return;
		}

		var params = {
        				"orgAuthPopCd":orgAuthPopCd,
        				"orgSubAuthPopNm":orgSubAuthPopNm,
        				"zipCode":zipCode,
        				"addr1":addr1,
        				"addr2":addr2,
        				"orgPhone":orgPhone,
        				"orgFax":orgFax,
                        "mode":"write"
				};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			orgAuthListShow();
			subOrgHide();
		});
	}

	//기관 권한 팝업
	function subOrgAuthOrgShow(gb){

		var data1 = $('#selOrgNm').text();
		var data2 = $('#selOrgSubNm').text();
		if(data1 == '기관이름'){
			alert('기관을 선택해주세요');
			return;
		}
		var useridx = "";
		subOrgAuthShow(gb,useridx,data1,data2);
	}

	//개인 권한 이관
	function authUserGo(){

		var orgGrpCd = $('#authUserGoOrgCd').val();
		var orgGrpSubCd =  $('#authUserGoOrgSubCd').val();
		var userIdx = $('#authUserGoIdx').val();
		var changeUserIdx = $("select[name=searchAuthUserGo]").val();

		if(userIdx == changeUserIdx){
			alert("이관대상자와 선택대상자가 동일하여 이관할 수 없습니다.");
			return false;
		}

		var params = {
        				"userIdx":userIdx,
        				"changeUserIdx":changeUserIdx,
        				"orgGrpCd":orgGrpCd,
        				"orgGrpSubCd":orgGrpSubCd,
                        "mode":"authgo"
				};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			orgGrpShow('SUBGRP',orgGrpCd,orgGrpSubCd,$("#selGrnum").val(),$("#selGrsubnum").val())
			subOrgAuthHide();
			//orgAuthListShow();
			//subOrgHide();
		});

	}

	function subOrgAuthShow(gb,useridx,data1,data2,data3,data4,data5,data6){

		//alert("gb= "+gb+" useridx= "+useridx+" data1= "+data1+" data2= "+data2+" data3= "+data3+" data3= "+data4+" data5= "+data5+" data6= "+data6);

		$('#grpTp').val(gb);

		if('user' == gb){
			$('#grpTp1').show();
			$('#grpTp2').hide();
			$('#grpInfo1').show();
			$('#grpInfo2').hide();
			$('#reqUserIdx').val(useridx);

			$('#grpInfo1_nm').text(data1);
			$('#grpInfo1_id').text(data2);
			$('#grpInfo1_org').text($("#selOrgNm").text());
			$('#grpInfo1_dept').text(data4);
			$('#grpInfo1_position').text(data3);
			$('#grpInfo1_phone').text(data5);
			$('#grpInfo1_email').text(data6);

			$('#grpInfo2_org').text('');
			$('#grpInfo2_auth').text('');

			$('#grpGoTr1').show();
			$('#grpGoTr2').show();

		}else if('org' == gb){

			$('#grpTp1').hide();
			$('#grpTp2').show();
			$('#grpInfo1').hide();
			$('#grpInfo2').show();

			$('#reqUserIdx').val('');

			$('#grpInfo1_nm').text('');
			$('#grpInfo1_id').text('');
			$('#grpInfo1_org').text('');
			$('#grpInfo1_dept').text('');
			$('#grpInfo1_position').text('');
			$('#grpInfo1_phone').text('');
			$('#grpInfo1_email').text('');

			$('#grpInfo2_org').text(data1);
			$('#grpInfo2_auth').text(data2);

			$('#grpGoTr1').hide();
			$('#grpGoTr2').hide();

		}

		subOrgHide();

		$('#authGrpPopBox').show();

		var params = {
				"code":gb,
				"reqUserIdx":useridx,
				"orgGrpCd":$('#selOrgCd').val(),
				"orgGrpSubCd":$('#selOrgSubCd').val(),
                "mode":"moduleauthlist"
		};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			$('#moduleList').html(data);
		});

		var params2 = {
				"code":gb,
				"reqUserIdx":useridx,
				"orgGrpCd":$('#selOrgCd').val(),
				"orgGrpSubCd":$('#selOrgSubCd').val(),
                "mode":"moduleauthgo"
		};
		jQuery.post("/sys/orgModuleManager.do",$.param(params2),
		function(data) {
			$('#grpGoSel').html(data);
		});
	}

	function subOrgAuthHide(){
		$('#grpTp1').hide();
			$('#grpTp2').hide();
		$('#authGrpPopBox').hide();
	}


	function orgAuthListShow(){
		var orgGrpNm = $('#orgGrpNm').val();
		var params = {
			"orgGrpNm" : orgGrpNm,
			"mode":"orgauthlist"
		};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			$('#orgAuthList').html(data);
		});
	}


	function subOrgEditShow(event,nm,cd,subnm,subcd,orgaddr1,orgaddr2,orgzipcode,orgphone,orgfax,addr1,addr2,zip){

		$('#authPopBox').css('top',(event.clientY-220)+'px');
		$('#orgAuthPopNm').html(nm);
		$('#orgAuthPopCd').val(cd);
		$('#orgAuthPopSubCd').val(subcd);
		$('#orgSubAuthPopNm').val(subnm);
		$('#orgAddr1').val(addr1);
		$('#orgAddr2').val(addr2);
		$('#zip').val(zip);
		$('#addr1').val(orgaddr1);
		$('#addr2').val(orgaddr2);
		$('#zipCode').val(orgzipcode);
		$('#orgPhone').val(orgphone);
		$('#orgFax').val(orgfax);

		$('#btnAuthWirtePop').show(); //찾아보기 & 기관주소불러오기 버튼
		$('#btnAuthWirtePop2').hide(); //저장버튼
		$('#btnAuthEditPop').show(); //수정버튼
		$('#authPopBox').show();

	}


	function subOrgEdit(){

		var orgAuthPopCd = $('#orgAuthPopCd').val();
		var orgAuthPopSubCd = $('#orgAuthPopSubCd').val();
		var orgSubAuthPopNm = $('#orgSubAuthPopNm').val();

		var addr1 = $('#addr1').val();
		var addr2 = $('#addr2').val();
		var zipCode = $('#zipCode').val();
		var orgPhone = $('#orgPhone').val();
		var orgFax = $('#orgFax').val();


		if(orgAuthPopCd == '' || orgAuthPopSubCd== '' || orgSubAuthPopNm== ''){
			alert("항목을 입력해주세요.");
			return;
		}

		var params = {
        				"orgGrpCd":orgAuthPopCd,
        				"orgGrpSubCd":orgAuthPopSubCd,
        				"orgGrpSubNm":orgSubAuthPopNm,
        				"addr1":addr1,
        				"addr2":addr2,
        				"zipCode":zipCode,
        				"orgPhone":orgPhone,
        				"orgFax":orgFax,
                        "mode":"edit"
				};

		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			orgAuthListShow();
			subOrgHide();
		});

	}

	function subSubOrgDelete(){

		if(confirm('정말 권한분류를 삭제하시겠습니다. \r\n지정된 권한이 모두 삭제 됩니다.')){
			if($('#selOrgCd').val() == '' || $('#selOrgSubCd').val() == ''){
				alert('삭제 할 내용이 없습니다.');
				return;
			}

			var params = {
	        				"orgGrpCd":$('#selOrgCd').val(),
	        				"orgGrpSubCd":$('#selOrgSubCd').val(),
	                        "mode":"delete"
					};


			jQuery.post("/sys/orgModuleManager.do",$.param(params),
			function(data) {
				if(data.state == 'OK'){
					orgAuthListShow();
					subOrgHide();
					$('#selOrgCd').val("");
					$('#selOrgSubCd').val("");

					$('#selOrgNm').text('기관이름');
					$('#selOrgSubNm').text('권한구분');
				}
			});
		}
	}



	function authOrgAdd(userIdx){

		if($('#selOrgCd').val() == '' || $('#selOrgSubCd').val() == '' ){
			alert("선택된 부서가 없습니다.");
			return;
		}


		var params = {
	        				"orgGrpCd":$('#selOrgCd').val(),
	        				"orgGrpAuthCd":$('#selOrgSubCd').val(),
	        				"addUserIdx":userIdx,
	                        "mode":"authadd"
					};


		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			if(data.state == 'OK'){
				orgAuthListShow();
				subOrgHide();


				var params = {
        				"code":'GRP',
        				"orgGrpCd":$('#selOrgCd').val(),
        				"orgGrpAuthCd":$('#selOrgSubCd').val(),
                        "mode":"usershow"
				};

				jQuery.post("/sys/orgModuleManager.do",$.param(params),
				function(data) {
					$('#authUser').html(data);
				});


				orgNoGrpShow('SUBGRP',$('#selOrgCd').val());
			}
		});

	}





	function authOrgDel(userIdx){

		if($('#selOrgCd').val() == '' || $('#selOrgSubCd').val() == '' ){
			alert("선택된 부서가 없습니다.");
			return;
		}


		var params = {
	        				"orgGrpCd":$('#selOrgCd').val(),
	        				"orgGrpAuthCd":$('#selOrgSubCd').val(),
	        				"addUserIdx":userIdx,
	                        "mode":"authdel"
					};


		jQuery.post("/sys/orgModuleManager.do",$.param(params),
		function(data) {
			if(data.state == 'OK'){
				orgAuthListShow();
				subOrgHide();


				var params = {
        				"code":'GRP',
        				"orgGrpCd":$('#selOrgCd').val(),
        				"orgGrpAuthCd":$('#selOrgSubCd').val(),
                        "mode":"usershow"
				};

				jQuery.post("/sys/orgModuleManager.do",$.param(params),
				function(data) {
					$('#authUser').html(data);
				});

				orgNoGrpShow('SUBGRP',$('#selOrgCd').val());
			}
		});
	}


	$(function(){
		orgAuthListShow();
	});
