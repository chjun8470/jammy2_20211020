/* Copyright (c) 2012 kisystems, Inc.
 * All right reserved
 *
 * Revision History
 * Author           Date             Description
 * --------------   --------------   ------------------
 * yhs              2013. 08. 29.     신규생성
 */

var arrId =[['fixedAsetNo', '01', '고정자산번호', '01', '01'],
            ['korNm', '24', '한글장비명', '02', '02'],
            ['engNm', '02', '영문장비명', '03', '03'],
            ['manufactureNm', '03', '모델명', '23', '04'],
            ['takeDt', '06', '취득일자', '04', '08'],
            ['takeSdt', '07','개발(구축)일자', '05', '08'],
            ['eqcpNm', '','주장비(주시설)선택', '06'],
            ['equipFileList[0].fileData', '10','장비사진', '07', '05'],
            ['takePrc', '11','취득금액', '08', '09'],
            ['useScopeCd', '12','활용범위', '09', '13'],
            ['useTypeCd', '27','장비용도', '10'],
            ['useType', '13','장비용도 사유', '10'],
            ['idleDisuseCd', '22','장비상태', '26'],
            ['branchNm', '05','연구시설 표준분류', '24', '06'],
            ['location', '15', '설치장소', '11', '15'],
            ['equipRndList[0].rndYn', '','구입재원 구분', '12'],
            ['equipRndList[0].selInpYn', '','과제정보','13', '10'],
            ['subjectOcd_0', '16','국가과제고유번호', '14'],
            ['rndWeight_0', '','과제비중', '15'],
            ['officeCd_0', '17','과제수행부처청', '16'],
            ['example', '18', '사용예', '17', '16'],
            ['capability', '18', '구성 및 성능', '17', '16'],
            ['feature', '18', '장비설명', '17', '16'],
            ['sixCd0', '19', '6T분류'],
            ['takeCd', '20', '취득방법', '18', '07'],
            ['devOpenYn', '25', '개발장비 공개여부', '19'],
            ['devSpec', '26', '개발장비 비중', '20'],
            ['registCd', '21', '장비구분', '21', '11'],
            ['operTel', '23', '문의처', '22', '18'],
            ['importCd', '28', '5대 중점투자분야', '27', '17'],
            ['landTake_0', '11', '토지비', '08'],
            ['buildingTake_0', '11', '토지비', '08'],
            ['specFacTake_0', '11', '토지비', '08'],
            ['takePrc_0', '11', '토지비', '08'],
            ['takePrc_1', '11', '토지비', '08'],
            ['takePrc_2', '11', '토지비', '08']
		];
var eqPre = new Array();

$(function() {
	
	var hrValn = $(location).attr('href');
	var hrVal = hrValn.lastIndexOf("/");
	var hrefVal = hrVal + 6;
	var finHref = hrValn.substring(hrVal, hrefVal);
	var tagId = null;
	var validId = null;
	/* lodaing Script ==================================================== */
	
	/**
	 * step1, 2 에 따른 위치및 validation 설정
	 * 
	 */
	if(finHref == '/step1') {
		$.takeChg("1");
		tagId = 'fixedAsetNo';
		validId = 'step1';
	}
	else if(finHref == '/step2' || finHref == '/pacSt') {
		var eqRndYn = $("#eqRndYn").val();
		if(eqRndYn == 'Y') tagId = 'addItemBtn';
		else if(eqRndYn == 'N') tagId = 'rndAcq_0';
		validId = 'step2';
	}
	
	equipBaseInfo(tagId);														// 입력안내
	equipBasePrecautions(tagId);												// 주의사항
	//equipBaseCompanion(tagId);												// 반려사유 
	arrowMove(tagId);															// 등록안내 화샆표
	/*searchEquipNm($("#modelCd").val(), $("#branchCd").val());					// 유사장비 출력*/	
	$('.errorMsg').hide();														// 에러메시지 
	
	//errEndEquip();
		
	
	
	/* validation Script ==================================================== */
	
	/**
	 * 장비등록 input keyup, click function
	 * 
	 */
	$("#equipAddForm").find(":input").bind("keyup click", function() {
		equipBaseInfo(this.id);							// 장비등록 입력안내
		equipBasePrecautions(this.id);					// 장비등록 입력 주의사항
		//equipBaseCompanion(this.id);					// 장비등록 반려사유
		arrowMove(this.id);								// 등록안내 화샆표
		/*validStart();
		validFormStart(validId);*/
		
		/*if(this.id == 'korNm') {
			searchEquipNm($("#modelCd").val(), $("#branchCd").val());
		}*/
		
		if(this.id == 'fixedAsetNo') {																				// 고정자산번호 중복체크
			if($.isEmpty($('input[name="notFix"]:checked').val())) {
				if(!$.isEmpty($('#fixedAsetNo').val())) fixedAsetNoDuplicateCheck($('#fixedAsetNo').val(), '0');
			}
		}
		
		if(this.id == 'fixedAsetNoChk') {																			// 고정자산번호 이중등록확인 버튼 중복체크
			if($.isEmpty($('input[name="notFix"]:checked').val())) {												// 연구시설 일 경우 자산번호 없음에 체크 되어 있지 않을 경우 
				if($.isEmpty($('#fixedAsetNo').val())) {
					alert("고정자산번호를 입력하세요.");
				}
				else {
					fixedAsetNoDuplicateCheck($('#fixedAsetNo').val(), '1');
				}
			}
		}
		
		/*if(this.id == 'branchNm') {																					// 표준분류 설정
			if($(".infoTlt").hide()) $(".infoTlt").show();
			if($("input[name='equipCd']:checked").val() != '03') {
				$("#infoTitle").html('<strong>'+"연구시설 표준분류"+'&nbsp;입력안내'+'</strong>');
				$("#infoMsg").html($('<a href="/down/branchCd" target="_blank" class="btn_v23">'+'<span>표준분류체계설명</span>'+'</a>'));
				$("#careTitle").html('<strong>'+"연구시설 표준분류"+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
				$("#careMsg").text('필수 항목이므로 반드시 선택하셔야 합니다. 표준분류체계를 모를경우 도움말을 다운하여 참조하세요');
				$(".compTlt").hide();
				$("#copmMsg").text("");
			}
			else if($("input[name='equipCd']:checked").val() == '03') {
				$("#careTitle").html('<strong>'+"연구시설 표준분류"+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
				$("#careMsg").html($('<a href="/down/branchCd" target="_blank" class="btn_v23">'+'<span>표준분류체계설명</span>'+'</a>'));
				$("#compTitle").html('<strong>'+"연구시설 표준분류"+'&nbsp;반려사유&nbsp;확인'+'</strong>');
				$("#copmMsg").text('국가연구시설 표준분류를 잘못 입력한 경우');
			}
		}*/
		
		errEndEquip();																								// 프로그레스 바 설정
	});
	
	/**
	 * 장비등록 radio keyup, click function
	 * 
	 */
	$("#equipAddForm").find(":radio").bind("keyup click", function() {
		equipBaseInfo(this.name);
		equipBasePrecautions(this.name);
		//equipBaseCompanion(this.name);
		arrowMove(this.id);
		
		/*if(this.name == 'takeCd') searchEquipTake($("#modelCd").val(), $("#branchCd").val());
		if(this.name == 'registCd') searchEquipRegist($("#modelCd").val(), $("#branchCd").val());*/
		errEndEquip();																								// 프로그레스 바 설정
	});
	
	/**
	 * 장비등록 a keyup, click function
	 * 
	 */
	$("#equipAddForm").find("a").bind("click", function() {
		if(this.id == 'branchCdSearch') {																			// 표준분류 레이어 클릭시
			
			if($(".infoTlt").hide()) $(".infoTlt").show();
			if($("input[name='equipCd']:checked").val() != '03') {
				$("#infoTitle").html('<strong>'+this.title+'&nbsp;입력안내'+'</strong>');
				$("#infoMsg").html($('<a href="/down/branchCd" target="_blank" class="btn">'+'<span>표준분류체계설명</span>'+'</a>'));
				$("#careTitle").html('<strong>'+this.title+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
				//$("#careMsg").text('필수 항목이므로 반드시 선택하셔야 합니다. 표준분류체계를 모를경우 도움말을 다운하여 참조하세요');
				/*$(".compTlt").hide();
				$("#copmMsg").text("");*/
			}
			else if($("input[name='equipCd']:checked").val() == '03') {
				$("#careTitle").html('<strong>'+"연구시설 표준분류"+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
				//$("#careMsg").text('필수 항목이므로 반드시 선택하셔야 합니다. 표준분류체계를 모를경우 도움말을 다운하여 참조하세요');
				/*$("#compTitle").html('<strong>'+"연구시설 표준분류"+'&nbsp;반려사유&nbsp;확인'+'</strong>');
				$("#copmMsg").text('국가연구시설 표준분류를 잘못 입력한 경우');*/
			}
		} 
	});
	
	/**
	 * 장비등록 select keyup, click function
	 * 
	 */
	$("#equipAddForm").find("select").bind("keyup click", function() {
		equipBaseInfo(this.name);																// 장비등록 입력안내
		equipBasePrecautions(this.name);														// 장비등록 입력 주의사항
		//equipBaseCompanion(this.name);															// 장비등록 반려사유										
		arrowMove(this.id);																		// 등록안내 화살표
		
		// 실시간 에러 체크 하지 말고 한번에 체크로 변경 (2013.11.09)
		/*validStart();
		validFormStart(validId);*/
		
		/*if(this.name == 'importCd') searchEquipImport($("#modelCd").val(), $("#branchCd").val());*/
		
		if(this.name == 'importCd') {															// 5대 중정투자분야 클릭시
			
			if($(".infoTlt").hide()) $(".infoTlt").show();
			
			$("#infoTitle").html('<strong>'+this.title+'&nbsp;입력안내'+'</strong>');
			$("#infoMsg").html($('<span class="btn_down">'+'<a href="/down/importInvest" target="_blank" class="btn_v23">'+'<span>5대중점투자분야설명</span>'+'</a></span>'));
			$("#careTitle").html('<strong>'+this.title+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
			$("#careMsg").text('필수 항목이므로 반드시 선택하셔야 합니다. 투자분야를 모를경우 도움말을 다운하여 참조하세요');
		}
		else if(this.name == 'managerId') {														// 장비담당자 클릭시
			
			if($(".infoTlt").hide()) $(".infoTlt").show();

			$("#infoTitle").html('<strong>'+this.title+'&nbsp;입력안내'+'</strong>');
			$("#infoMsg").text('현 장비를 실제로 담당하는 담당자를 선택');
			$("#careTitle").html('<strong>'+this.title+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
			$("#careMsg").text('장비담당자는 현 장비를 실제로 담당하는 사람을 선택하여야 하며 추후 현 장비의 승인,삭제 등 변경이 있을 경우 담당자에게 이메일, SMS 가 발송됩니다.');
		}
		else if(this.id == 'useScope') {														// 활용범위 클릭시
			if($(".infoTlt").hide()) $(".infoTlt").show();
		
			$("#infoTitle").html('<strong>'+this.title+'&nbsp;입력안내'+'</strong>');
			$("#infoMsg").text('단독활용일경우 아래 에서 단독활용사유를 선택');
			$("#careTitle").html('<strong>'+this.title+'&nbsp;입력시&nbsp;주의사항'+'</strong>');
			$("#careMsg").text('단독활용사유에 포함되지 않는 기타 일경우 기타사유입력란에 사유를 정확하게 입력하세요.');
		}
		
		errEndEquip();
	});
	
	/**
	 * 장비등록 keydown function
	 * 
	 */
	$("#equipAddForm").keydown(function() {														
		/*validStart();
		validFormStart(validId);*/
		errEndEquip();																			// 프로그레스 바 설정
	});
	
	/**
	 * 장비등록 textarea blur function
	 * 
	 */
	$("#equipAddForm").find("textarea").on("blur", function() {
		if(!$.isEmpty($('#'+this.id).val())) {
			var orVal = $('#'+this.id).val();
			var trimVal = jQuery.trim(orVal);
			$('#'+this.id).val(trimVal.replace(/\s{3,10}/g, " "));
		}
	});
	
	/**
	 * 작성완료 확인
	 * 
	 */
	function errEndEquip() {
		
		validStart();
		validFormStart(validId);
		
		var errCnt = $('.errAllMsg').find('p').attr('class', 'hint_text').length;
		
		progressTime(errCnt);
		if(errCnt == '0') $('.errorMsg').hide();
		
		if(errCnt == '0') {
			$('#tagSearchLayer').attr('style', '');
			$('#disBtn').attr('style', 'display:none;');
				
			if(validId == 'step2') {
				barStart(100);
				$('.retTimer').empty();
				$('.retTimer').append('<span class="blue_text_b">'+'작성 완료'+'</span>');
			}
		}
		else {
			$('#tagSearchLayer').attr('style', 'display:none;');
			//$('#disBtn').attr('style', '');
		}
		$('#errCnt').val(errCnt);
	}
	
	/* EquipBase Script ==================================================== */
	
	/**
	 * 장비등록 상태바, 남은 시간
	 * 
	 */
	function progressTime(val) {
		var arrValStep1 = [	['1','40','약2분 50초 정도'],['2','35','약3분 정도'],['3','30','약3분 10초 정도'],['4','25','약3분 20초 정도'],['5','20','약3분 30초정도'],
		              	['6','15','약3분 45초 정도'],['7','10','약4분 정도'],['8','5','약4분 15초 정도'],['9','0','약4분 30초정도']
					];
		
		var arrValStep2 = [	['1','95','약10초 정도'],['2','90','약20초 정도'],['3','80','약30초 정도'],['4','75','약40초 정도'],['5','70','약1분 정도'],
			              	['6','65','약1분 15초 정도'],['7','60','약1분 30초 정도'],['8','55','약1분 45초 정도'],['9','50','약2분 정도'],
			              	['10','45','약2분 15초 정도'],['11','40','약2분 50초 정도']
					];
		
		var arrVal = null;
		var afterErrCnt = null;	
		if(validId == 'step1') {
			arrVal = arrValStep1; 
			afterErrCnt = 10;
		}
		else if(validId == 'step2') {
			arrVal = arrValStep2;
			afterErrCnt = 11;
		}
		
		if(afterErrCnt > val) {
			for(var i = 0; i < arrVal.length; i++) {
				if(val == arrVal[i][0]) {
					var barVal = arrVal[i][1];
					barStart(parseInt(barVal));
					$('.retTimer').empty();
					$('.retTimer').append('등록완료까지 '+'<span class="f_blue">'+arrVal[i][2]+'</span>'+' 소요됩니다.');
				}
			}
		}
		
	}
	
	/**
	 * 장비등록 유사장비명 조회(모델 코드)
	 * 
	 */
	function searchEquipNm(modelCd, branchCd) {
		if(!$.isEmpty(modelCd) && !$.isEmpty(branchCd)) {
			$.ajax ({
				url : '/organ/equip/add/equipNm/list?modelCd=' + modelCd,
				success : function(data) {
					if($(data).get(0)['total'] > 0) {
						$($(data).get(0)['source']).each(function(i, equip) {
							var equipTxt = '동일한&nbsp;모델명을&nbsp;가진&nbsp;유사장비&nbsp;<strong>'+$(data).get(0)['total']+'</strong>'+'점&nbsp;중&nbsp;'+'<strong>'+equip.equipCnt+'</strong>'+'점이&nbsp;'+'<strong>'+equip.korNm+'</strong>'+'을(를)&nbsp;장비명으로 사용중 입니다.' + '<a href="javascript:$.equipNmChg(1);">'+'<font color="red">'+'(장비명&nbsp;사용하기)'+'</font></a>'; 
							$("#equipTxt").html(equipTxt);
							$("#equipIdNmOne").val(equip.equipId);
						});
						
						if($(data).get(0)['total'] > 1) {
							$("#equipMore").show();
						}
					}
					else {
						searchEquipBranch(branchCd);
					}
				}
			});
		}
	}
	
	/**
	 * 장비등록 유사장비명 조회(표준분류코드)
	 * 
	 */
	function searchEquipBranch(branchCd) {
		if(!$.isEmpty(branchCd)) {
			$.ajax ({
				url : '/organ/equip/add/equipNmBranch/list?branchCd=' + branchCd,
				success : function(data) {
					if($(data).get(0)['total'] > 0) {
						$($(data).get(0)['source']).each(function(i, equip) {
							var equipTxt = '동일한&nbsp;모델명을&nbsp;가진&nbsp;유사장비&nbsp;<strong>'+$(data).get(0)['total']+'</strong>'+'점&nbsp;중&nbsp;'+'<strong>'+equip.equipCnt+'</strong>'+'점이&nbsp;'+'<strong>'+equip.korNm+'</strong>'+'을(를)&nbsp;장비명으로 사용중 입니다.'+'<a href="javascript:$.equipNmChg(1);">'+'<font color="red">'+'(장비명&nbsp;사용하기)'+'</font></a>'; 
							$("#equipTxt").html(equipTxt);
							$("#equipIdNmOne").val(equip.equipId);
						});
						
						if($(data).get(0)['total'] > 1) {
							$("#equipMore1").show();
						}
					}
					else if($(data).get(0)['total'] == 0) {
						$("#equipTxt").html("유사장비 없음");
					}
				}
			});
		}
	}
	
	/**
	 * 장비등록 유사장비명 조회(취득방법)
	 * 
	 */
	function searchEquipTake(modelCd, branchCd) {
		$.ajax ({
			url : '/organ/equip/add/equipNmTake/list?modelCd=' + modelCd + '&branchCd=' + branchCd,
			success : function(data) {
				if(data.length > 0) {
					var take = $(data).get(0)['equipCdNm'].replace("장비","");
					var equipTxt = '유사장비&nbsp;중&nbsp;<strong><font color="red">'+$(data).get(0)['equipCnt']+'</font></strong>'+'점&nbsp;이&nbsp;'+'<strong><font color="red">'+take+'</font></strong>'+'를&nbsp;취득방법으로&nbsp;등록하였습니다.'; 
					$("#equipTxt").html(equipTxt);
				}
				else {
					$("#equipTxt").html("유사장비에 대한 취득방법이 없습니다.");
				}
				$("#equipMore").hide();
				$("#equipMore1").hide();
			}
		});
	}
	
	/**
	 * 장비등록 유사장비명 조회(장비구분)
	 * 
	 */
	function searchEquipRegist(modelCd, branchCd) {
		$.ajax ({
			url : '/organ/equip/add/equipNmRegist/list?modelCd=' + modelCd + '&branchCd=' + branchCd,
			success : function(data) {
				if(data.length > 0) {
					var regist = $(data).get(0)['registNm'];
					var equipTxt = '유사장비&nbsp;중&nbsp;<strong><font color="red">'+$(data).get(0)['equipCnt']+'</font></strong>'+'점&nbsp;이&nbsp;'+'<strong><font color="red">'+regist+'</font></strong>'+'를&nbsp;장비구분으로&nbsp;등록하였습니다.'; 
					$("#equipTxt").html(equipTxt);
				}
				else {
					$("#equipTxt").html("유사장비에 대한 장비구분이 없습니다.");
				}
				$("#equipMore").hide();
				$("#equipMore1").hide();
			}
		});
	}
	
	/**
	 * 장비등록 유사장비명 조회(5대중점투자분야)
	 * 
	 */
	function searchEquipImport(modelCd, branchCd) {
		$.ajax ({
			url : '/organ/equip/add/equipNmImport/list?modelCd=' + modelCd + '&branchCd=' + branchCd,
			success : function(data) {
				if(data.length > 0) {
					var impo = $(data).get(0)['importNm'];
					var equipTxt = '유사장비&nbsp;중&nbsp;<strong><font color="red">'+$(data).get(0)['equipCnt']+'</font></strong>'+'점&nbsp;이&nbsp;'+'<strong><font color="red">'+impo+'</font></strong>'+'를&nbsp;5대중점투자분야로&nbsp;등록하였습니다.'; 
					$("#equipTxt").html(equipTxt);
				}
				else {
					$("#equipTxt").html("유사장비에 대한 5대중점투자분야가 없습니다.");
				}
				$("#equipMore").hide();
				$("#equipMore1").hide();
			}
		});
	}
	
	/**
	 * 장비등록 상태바
	 * 
	 */
	function barStart(cpt) {
		$("#prgCurrent").css({width : cpt + '%'}).text(cpt + '% 진행중');
		if(cpt != 100 ) $("#prgPer").css({left : cpt + '%'}).text(cpt + '% 진행중');
	}
	
	/**
	 * 장비등록도움말 세로크기 변경
	 * 
	 */
	var beforeHeight = null;
	$(function() { beforeHeight = $('#equipAddForm').height(); });
	
	$.heightMove = function() {
		if($('.left_box').height() != beforeHeight && beforeHeight != 0) {
			var afterHeight = $('.left_box').height();
			if($('.left_box').height() < beforeHeight) $('.aside_content2').css({height : $('.aside_content2').height() - (afterHeight - beforeHeight) + 'px'});
			else $('.aside_content2').css({height : $('.aside_content2').height() + (afterHeight - beforeHeight)  + 'px'});
		}
		beforeHeight = $('.left_box').height();
	};
	
	/**
	 * 장비등록 유사장비명 클릭시 장비명 등록
	 * 
	 */
	$.equipNmChg = function(numChk) {
		var equip = $("#equipIdNm").val();
		var equipOne = $("#equipIdNmOne").val();
	
		if(!$.isEmpty(numChk)) equip = equipOne;
		
		if(!$.isEmpty(equip)) {
			$.ajax ({
				url : '/organ/equip/add/equipIdSearch/list?equipId=' + equip,
				success : function(data) {
					
					$('#korNm').val($(data).get(0)['korNm']);
					$('#engNm').val($(data).get(0)['engNm']);
					
					barStart(45);
					$('.retTimer').empty();
					$('.retTimer').append('등록완료까지 '+'<span class="blue_text_b">'+'약2분 30초 정도'+'</span>'+' 소요됩니다.');
				}
			});
		}
		else {
			$('#korNm').val($('#equipNm').val());
		}
	};
	
	/**
	 * 장비등록 숫자 포맷
	 * 
	 */
	function numBerFor(val, id) {
		$('#'+id).val(val);
		$('#'+id).formatNumber({format:"#,###", locale:"kr"});
	}
	
	/**
	 * 장비등록 날짜 포맷
	 * 
	 */
	function getTimeStamp(val) {
		
		var forDate = new Date(val);
		var year = forDate.getFullYear();
		var month = forDate.getMonth();
		month +=1;
		var day = forDate.getDay();
		
		if(month.toString().length == 1) month = "0"+month;
		if(day.toString().length == 1) day = "0"+day;
		
		var stampDate = year+"-"+month+"-"+day;
		return stampDate;
	}
	
	/**
	 * 장비등록도움말 화살표 변경
	 * 
	 */
	function arrowMove(val) {
		setTimeout( function() {
			var idxY = $('#'+val);
			var offset = idxY.offset();
			if(!$.isEmpty(offset)) {
				if(offset.top == 0) offset.top = 398;
				var divTop = null; 
				if(finHref == '/step1') divTop = offset.top - 330;
				else if(finHref == '/step2') divTop = offset.top - 330;
				var divMaxHeight = $('#right_mun').height();
				
				if(divTop > divMaxHeight) divTop = divMaxHeight - 10;
				
				$('#modelPoint').css({
					"top" :divTop,
					//"left" : divLeft,
					"position" : "absolute"
				});
			}
		},50);
	}
	
	/**
	 * 장비등록 입력안내
	 * 
	 */
	function equipBaseInfo(idNm) {
		var equipGubun = null;
		if($("#equipChange").val() == '03') equipGubun = "03";
		else equipGubun = "01";
		for(var i = 0; i < arrId.length; i++ ) {
			if(idNm == arrId[i][0]) {
				$.ajax({
					url : '/organ/equip/help?code='+arrId[i][1]+'&equipGubun='+equipGubun,
					method : 'post',
					dataType : 'text',
					success : function(data) {
						if(data.length > 0) {
							if(idNm == 'branchNm') {
								$("#infoMsg").html(data + '<p class="f_blue mb5"> * 장비의 표준분류선택이 어려우실 경우, 표준분류체계 설명을 참고하시기 바랍니다 </p><a href="/down/branchCd" target="_blank" class="btn" style="margin-left:26px;">'+'<span>표준분류체계설명</span>'+'</a>');
								$("#useScopeMsg").hide();
								$("#useTypeMsg").hide();
								$("#idleDisuseMsg").hide();
								$("#takePrcMsg").hide();
								$("#importMsg").hide();
							}
							else if(idNm == 'takeCd') {
								if($("input[name='equipCd']:checked").val() == "01") {
									if($("input[name='takeCd']:checked").val() == '1') {
										$("#infoMsg").html(data + '<br/> - 구매 : 시중에 판매되는 장비를 구입하여 설치한 경우 <br/> - 개발 : 연구 목적이나 수요에 따라 고안 또는 발명해서 만든 장비');
										$("#useScopeMsg").hide();
										$("#useTypeMsg").hide();
										$("#idleDisuseMsg").hide();
										$("#takePrcMsg").hide();
										$("#importMsg").hide();
									}
									else if($("input[name='takeCd']:checked").val() == '2') {
										$("#infoMsg").html(data + '<br/> - 개발기간 : 연구장비의 개발 시작일부터 개발 종료일까지의 기간 <br/> - 개발금액 : 연구장비 개발에 투입된 금액 <br/> - 개발장비공개여부 : 정책상 공개 가능한 연구장비 또는 비공개 연구장비 여부 선택 <br/> - 개발비중 : 개발장비를 제작하는데 실제 투입한 비율 입력');
										$("#useScopeMsg").hide();
										$("#useTypeMsg").hide();
										$("#idleDisuseMsg").hide();
										$("#takePrcMsg").hide();
										$("#importMsg").hide();
									}
								}
								else {
									$("#infoMsg").html(data);
									$("#useScopeMsg").hide();
									$("#useTypeMsg").hide();
									$("#idleDisuseMsg").hide();
									$("#takePrcMsg").hide();
									$("#importMsg").hide();
								}
							}
							else if(idNm == 'useScopeCd') {
								$("#infoMsg").text(""); 
								$("#useScopeMsg").show();
								$("#useTypeMsg").hide();
								$("#idleDisuseMsg").hide();
								$("#importMsg").hide();
							}
							else if(idNm == 'useTypeCd') {
								$("#infoMsg").text(""); 
								$("#useTypeMsg").show();
								$("#useScopeMsg").hide();
								$("#importMsg").hide();
							}
							else if(idNm == 'idleDisuseCd') {
								$("#infoMsg").text(""); 
								$("#idleDisuseMsg").show();
								$("#useScopeMsg").hide();
								$("#useTypeMsg").hide();
								$("#importMsg").hide();
							}
							else if(idNm == 'takePrc_0' || idNm == 'takePrc_1' || idNm == 'takePrc_2') {
								$("#infoMsg").html("- 토지비 : 사람에 의한 이용이나 소유의 대상으로서 받아들여지는 경우의 땅의 비용<br/> - 건물비 : 토지에 붙어서 지붕, 기둥, 벽, 창 및 바닥으로 구성하여 일정한 형상을 갖추고 주거, 업무 등의 용도에 쓸 수 있도록 만든 건조물의 비용<br/> - 특수설비비 : 특수한 기능이나 환경을 조성하기 위한 구조물이나, 건물에 부착되어 있는 특수한 구조물, 기계 또는 장치 등의 비용<br/> ※ 이동형 연구시설의 경우, 건조비, 제작비를 건물비에 입력해주시기 바랍니다");
								$("#takePrcMsg").show();
								$("#idleDisuseMsg").hide();
								$("#useScopeMsg").hide();
								$("#useTypeMsg").hide();
								$("#importMsg").hide();
							}
							else if(idNm == 'registCd') {
								if($("input[name='equipCd']:checked").val() == "01" || $("#equipChange").val("01")) {
									if($("input[name='registCd']:checked").val() == '1') {
										$("#infoMsg").text("-주장비 : 추가적인 부대장비 없이도 본래의 구축 목적에 맞는 활용 및 성능을 발휘하는 핵심적인 장치");
										$("#useScopeMsg").hide();
										$("#useTypeMsg").hide();
										$("#idleDisuseMsg").hide();
										$("#takePrcMsg").hide();
										$("#importMsg").hide();
									}
									else if($("input[name='registCd']:checked").val() == '2') {
										$("#infoMsg").html("-부대장비 : 주장비의 일부분으로 규정하고, 주장비의 기본성능과 별도로 반드시 새로운 성능향상을 위하여 주장비에 부착하는 개념의 추가적인 장치");
										$("#useScopeMsg").hide();
										$("#useTypeMsg").hide();
										$("#idleDisuseMsg").hide();
										$("#takePrcMsg").hide();
										$("#importMsg").hide();
									}
									else if($("input[name='registCd']:checked").val() == '3') {
										$("#infoMsg").html("-보조장치 : 주장비의 성능향상이 아니라, 본래 주장비의 구축 목적에 따라 장비가 정상적으로 가동되기 위한 보조물․부속물");
										$("#useScopeMsg").hide();
										$("#useTypeMsg").hide();
										$("#idleDisuseMsg").hide();
										$("#takePrcMsg").hide();
										$("#importMsg").hide();
									}
								}
								else {
									$("#infoMsg").html("- 주시설 : 일반 연구건물 또는 이동수단과는 구별되는 특수한 기능 및 환경을 구현하는 장비를 갖추고 있거나 특수지역으로 이동할 수 있는 설비를 갖춘 편의적이고 독립적 연구공간 <br/> - 부대시설 : 연구시설의 운영 및 활용을 위해 추가적으로 설치한 유틸리티, 숙소, 응급실, 회의공간 등을 말함");
									$("#useScopeMsg").hide();
									$("#useTypeMsg").hide();
									$("#idleDisuseMsg").hide();
									$("#takePrcMsg").hide();
									$("#importMsg").hide();
								}
							}
							else if(idNm == 'importCd') {
								$("#infoMsg").text(""); 
								$("#importMsg").show();
								$("#useScopeMsg").hide();
								$("#useTypeMsg").hide();
								$("#idleDisuseMsg").hide();
								$("#takePrcMsg").hide();
							}
							else {
								$("#infoMsg").text(data);
								$("#useScopeMsg").hide();
								$("#useTypeMsg").hide();
								$("#idleDisuseMsg").hide();
								$("#takePrcMsg").hide();
								$("#importMsg").hide();
							}
						}
						else {
							$("#infoMsg").text("");
							$("#useScopeMsg").hide();
							$("#useTypeMsg").hide();
							$("#idleDisuseMsg").hide();
							$("#importMsg").hide();
						}
					},
					error:function(request,status,error){
				        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    }
				});
			}
		};
	}
	
	/**
	 * 장비등록 주의사항
	 * 
	 */
	function equipBasePrecautions(idNm) {
		var equipGubun = null;
		if($("#equipChange").val() == '03') equipGubun = "03";
		else equipGubun = "01";
		for(var i = 0; i < arrId.length; i++ ) {
			if(idNm == arrId[i][0]) {
				if(idNm == 'subjectOcd_0') $("#careMsg").text("연구시설 구축일자와 선택하신 과제의 ‘당해연도과제기간’이 다를 경우 반려");
				$.ajax({
					url : '/organ/equip/precautions?code=' + arrId[i][3]+'&equipGubun='+equipGubun,
					method : 'post',
					dataType : 'text',
					success : function(data) {
						if(data.length > 0) {
							if(idNm == 'manufactureNm') {
								$("#careMsg").html("모델명이 존재하는데 모델명 없음으로 입력하실 경우 승인되지 않습니다 <br/> 장비사진과 모델명이 다른 경우 승인되지 않습니다 <br/> 제조사의 세부모델명까지 입력해주시기 바랍니다<br/> ex. LX series(x) / LX550(O)<br/> * 다른 양식에서 따온 모델명을 복사/붙여넣기 하는 것을 주의해주세요");
							}
							else if(idNm == 'takePrc') {
								$("#careMsg").html("취득금액을 금액단위 착오 등으로 잘못 기재하였다고 판단되는 경우에는 승인되지 않습니다<br/> * 3천만원 미만 단독활용하는 연구장비는 등록대상이 아닙니다");
							}
							else if(idNm == 'useScopeCd') {
								$("#careMsg").html("단독활용을 선택하였으나, 단독활용사유가 불분명한 경우에는 승인되지 않습니다<br/> ※ 연구장비의 취득금액이 3천만원 미만(장비의 보조장치, 부대장비의 취득금액을 포함)인 경우, 공동활용허용 또는 공동활용서비스 장비로 등록해주시기 바랍니다");
							}
							else {
								$("#careMsg").html(data);
							}
						}
						else {
							if($("#equipChange").val() != '03') {
								$("#careMsg").html("");
							}
						}
					},
					error:function(request,status,error){
				        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    }
				});
			}
		}
	}
	
	/**
	 * 장비등록 반려사유
	 * 
	 */
	function equipBaseCompanion(idNm) {
		var equipGubun = null;
		if($("#equipChange").val() == '03') equipGubun = "03";
		for(var i = 0; i < arrId.length; i++ ) {
			if(idNm == arrId[i][0]) {
				var title = arrId[i][2];
				if(idNm == 'takePrc') {
					if($("input[name='takeCd']:checked").val() == '2') title= "개발금액";
				}
				
				if(idNm == 'korNm' && equipGubun == '03') title = "한글시설명";
				if(idNm == 'engNm' && equipGubun == '03') title = "영문시설명";
				if(idNm == 'takeCd' && equipGubun == '03') title = "구축방법";
				if(idNm == 'takeSdt' && equipGubun == '03') title = "구축일자";
				if(idNm == 'takeEdt' && equipGubun == '03') title = "구축일자";
				if(idNm == 'feature' && equipGubun == '03') title = "시설설명";
				
				$.ajax({
					url : '/organ/equip/companion?code=' + arrId[i][4],
					method : 'post',
					dataType : 'text',
					success : function(data) {
						if(data.length > 0) {
							$(".compTlt").show();
							$("#compTitle").html('<strong>'+title+'&nbsp;반려사유&nbsp;확인'+'</strong>');
							
							if((idNm == 'takeSdt' || idNm == 'takeEdt') && equipGubun == '03') $("#copmMsg").text('선택한 과제의 당해연도 과제수행기간과 시설의 취득시기가 다를 경우');
							else if(idNm == 'feature' && equipGubun == '03') $("#copmMsg").text('1) 시설소개를 단순히 장비명과 동일하게 입력하거나, “-”처럼 의미 없는값을 기재하였다고 판단되는 경우 2)  ‘시설설명’, 구성 및 성능’, ‘사용예’등의 내용이 중복 된 경우');
							else $("#copmMsg").text(data);
						}
						else {
							if($("input[name='equipCd']:checked").val() != '03') {
								$(".compTlt").hide();
								$("#copmMsg").text("");
							}
						}
					},
					error:function(request,status,error){
				        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    }
				});
			}
		}
	};
});


/**
 * 장비등록 고정관리자산번호 중복검사
 * 
 */
function fixedAsetNoDuplicateCheck(val, checkNum) {
	var organCd =  $("#organCd").val();
	var element = "dupFixedAsetNo";
	var pormTxt = "이미 등록된 고정자산관리번호입니다.";
	$.ajax ({
		url : '/equip/temp/duplicateCheck?fixedAsetNo='+val+'&organCd='+organCd,
		success : function(data) {
			if(data == true) {
				$("#fixResult").val(data);
				$('#error_'+element).remove();
				if(checkNum == '1') alert("신규로 사용하실수 있는 고정자산관리번호 입니다.");
			}
			else {
				$("#fixResult").val(data);
				alert(pormTxt);
				//$('.errAllMsg').append('<p class="hint_text" id="error1_'+element+'" style="color:red;">'+pormTxt+'</p>');
			}
		}
	});
}

/*
 * 유효성 검사 레이어 제거
 */
function divRemove(cls) {
	$("."+cls).remove();
}

/*
 * validation check
 */
function validStart() {
	var chk_rule = "korNm:isKor:한글장비명"
					+"@engNm:isEng:영문장비명"
					+"@fixedAsetNo:isNumber:고정자산관리번호"
					+"@takeEdt:isDateComparison:개발(구축)종료일자"
					+"@takePrc:isTakePrcLength:취득금액"
					+"@devSpec:isPrcLength:개발장비비중"
					/*+"@rndWeight:isRndWeightLength:가중치"*/
					+"@feature:isLength:장비설명"
					+"@capability:isLength:구성 및 성능"
					+"@example:isLength:사용예"
					+"@operTel:isTel:문의처";
	
	if(validateForm(chk_rule)) $('#errYn').val('N');		
	else $('#errYn').val('Y');
}

/*
 * validation check isEmpty
 */
function validFormStart(step) {
	
	var chk_ruleStep1 = "fixedAsetNo_fo:isEmpty:고정자산관리번호"
					+"@engNm_fo:isEmpty:영문장비명"
					+"@korNm_fo:isEmpty:한글장비명"
					+"@branchCd_fo:isEmpty:표준분류체계"
					+"@takeCd_fo:isEmpty:취득방법"
					+"@takeDt_fo:isTakeOneEmpty:취득일자"
					+"@takePrc1_fo:isTakeOneEmpty:취득금액"
					+"@takeSdt_fo:isTakeTwoEmpty:개발시작일자"
					+"@takeEdt_fo:isTakeTwoEmpty:개발종료일자"
					+"@devSpec_fo:isTakeTwoEmpty:개발장비비중"
					+"@takePrc2_fo:isTakeTwoEmpty:개발금액"
					+"@takeSdt1_fo:isTakeThreeEmpty:구축시작일자"
					+"@takeEdt1_fo:isTakeThreeEmpty:구축종료일자"
					+"@cpCd_fo:isTakeThreeEmpty:구성요소"
					+"@modelCd_fo:isEmpty:모델명"
					+"@fileData_fo:isEmpty:장비구축사진";
	
	var chk_ruleStep2 = "registCd_fo:isRegistOneEmpty:장비구분"
					+"@useScopeCd_fo:isRegistOneEmpty:활용범위"
					+"@useScopeEtc_fo:isRegistOneEmpty:기타사유입력"
					+"@useType_fo:isRegistOneEmpty:장비용도사유입력"
					+"@useTypeCd_fo:isRegistOneEmpty:장비용도"
					+"@idleDisuseCd_fo:isRegistOneEmpty:장비상태"
					+"@disuseCd_fo:isRegistOneEmpty:불용사유"
					+"@disuseDt1_fo:isRegistOneEmpty:매각일자"
					+"@disuseDt2_fo:isRegistOneEmpty:재활용일자"
					+"@disuseDt3_fo:isRegistOneEmpty:폐기일자"
					+"@moveOrganCd1_fo:isRegistOneEmpty:양여기관"
					+"@moveDt1_fo:isRegistOneEmpty:양여일자"
					+"@moveOrganCd2_fo:isRegistOneEmpty:대여기관"
					+"@moveDt2_fo:isRegistOneEmpty:대여일자"
					+"@location_fo:isRegistOneEmpty:설치장소"
					+"@rndYn_fo:isPjtEmpty:구입재원구분"
					+"@rndPrc_fo:isPjtEmpty:사용금액"
					+"@startDt_fo:isPjtEmpty:당해년도과제수행기간(시작일자)"
					+"@endDt_fo:isPjtEmpty:당해년도과제수행기간(종료일자)"
					+"@subjectOcd_fo:isPjtEmpty:국가과제고유번호"
					+"@rndWeight_fo:isPjtEmpty:과제비중"
					+"@rndAcq_fo:isPjtEmpty:취득재원"
					+"@area0_fo:isEquipCdEmpty:토지비 면적"
					+"@area1_fo:isEquipCdEmpty:건물비 면적"
					+"@floorUp1_fo:isEquipCdEmpty:건물비 지상층수"
					+"@floorDown1_fo:isEquipCdEmpty:건물비 지하층수"
					+"@equipFacTakePrc_fo:isEquipCdEmpty:기등록 특수설비비"
					+"@facEquipId1_fo:isEquipCdEmpty:기등록 특수설비"
					+"@equipLittleTakePrc_fo:isEquipCdEmpty:3천만원 미만 연구장비비"
					+"@equipTakePrc_fo:isEquipCdEmpty:연구장비비"
					+"@facEquipId0_fo:isEquipCdEmpty:연구장비"
					+"@feature_fo:isEmpty:장비설명"
					+"@capability_fo:isEmpty:구성 및 성능"
					+"@example_fo:isEmpty:사용예"
					+"@importCd_fo:isEmpty:5대 중점투자분야"
					+"@operTel_fo:isEmpty:문의처";				
	
	if(step == 'step1') {
		if(validateForm1(chk_ruleStep1)) {
			$('#errYn').val('N');
		}
		else {
			$('#errYn').val('Y');
		}
	}
	else if(step == 'step2') {
		if(validateForm1(chk_ruleStep2)) {
			$('#errYn').val('N');
		}
		else {
			$('#errYn').val('Y');
		}
	}
}

/** 값 체크 */
function isEmpty(obj) {
	return !$.isEmpty(obj.val());
}

/** 숫자가 포함되었는지 여부 */
function isNumber(obj) {
	var reg = /[0-9]/;
	return reg.test(obj.val());
}

/** 시작일자보다 종료일자가 과거인지 확인 */
function isDateComparison(obj1, obj2) {
	var startDt = obj1.val().replace(/-/g,"");
	var endDt = obj2.val().replace(/-/g,"");
	return startDt < endDt;
}

/** 숫자만 */
function isOnlyNumber(obj) {
    var reg =  /[0-9]/;
	return obj.val().match(reg);
}

/** 한글검사 */
function isKor(obj) {
    var reg = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	return obj.val().match(reg);
}

/** 영문검사 */
function isEng(obj) {
   /* var reg = /[A-Za-z]/;*/
    var reg = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	return !obj.val().match(reg);
}

/** 크기 검사 */
function isPrcLength(obj) {
	return obj.val() < 100;
}

/** 크기 검사 */
function isTakePrcLength(obj) {
	var takePrc = replaceAll(obj.val(),",","");
	return takePrc.length >= 7;
}

/** 가중치 합 검사 */
function isRndWeightLength() {
	var lastSubNo = $("#subjectTable ul:last").attr("class").replace("subjectItem", "");
	var lastSubAcqNo = $("#subjectAcqTable ul:last").attr("class").replace("subjectAcqItem", "");
	var idx = null;
	var n = 0;
	if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
	else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
	
	for(var i =0; i<=idx; i++) {
		n= n+parseInt($('#rndWeight_'+idx).val());
	}
	return n > 100;
}

/** 길이 검사 */
function isLength(obj) {
	var objVal =  jQuery.trim(obj.val());
	//obj.val(objVal);
	return objVal.length >= 100;
}

/** 이미지 여부 */
function isOnlyImage(obj) {
	var reg = /\S*\.gif|.jpg|.jpeg|.bmp|.png/i;
	return reg.test(obj);
}

/** 메일 검사 */
function isEmail(obj){
	var reg = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	return reg.test(obj.val());
}

/** 핸드폰 검사 */
function isHphone(obj) {
	var reg = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;
	return reg.test(obj.val());
}

/** 전화번호 검사 */
function isTel(obj) {
	var reg = /^\d{2,3}-\d{3,4}-\d{4}$/;
	return reg.test(obj.val());
}

/** 날짜 포맷 */
function isDateFormat(obj) {
	var str = obj.val();
	var reg = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
	return reg.test(str);
}

function isNotMonth() {
	alert("dfdfdfdfdfdf");
	return false;
}

function replaceAll(str,orgStr,repStr) {
    return str.split(orgStr).join(repStr);
}
	
function validateForm(chk_rule) {
	var chk_line = chk_rule.split("@"); 
	var validate = true;
	$.each(chk_line , function(index , line) {
		//if(!validate) return false;
		var element = line.split(":");
		var obj = $('#'+element[0]); 
		var fn_list = element[1].split(","); 
		$('#error_'+element[0]).remove();
		$('.formErrorContent_'+element[0]).remove();
		
		$.each(fn_list , function(index , fns) {
			var args = fns.split("#");
			var fn = args[0];
			
			if(fn == "isNumber") {
				if(!$.isEmpty(obj.val())) validate = isNumber(obj);
				else validate = true;				
			}
			else if(fn == "isLength") {
				if(!$.isEmpty(obj.val()) && $("#registCd").val() == '1') {
					validate = isLength(obj);
				}
				else {
					validate = true;
				}
			}
			else if(fn == "isDateComparison") {
				if(!$.isEmpty($('#takeSdt').val()) && $('#takeEdt').val()) {
					validate = isDateComparison($('#takeSdt') , $('#takeEdt'));
				}
				else {
					validate = true;
				}
				
			}
			else if(fn == "isOnlyNumber") {
				if(!$.isEmpty(obj.val())) {
					validate = isNumber(obj);
				}
				else {
					validate = true;
				}
				
			}
			else if(fn == "isTakePrcLength") {
				if(!$.isEmpty($('#equipChange').val()) && $('#equipChange').val() != '03') {
					if(!$.isEmpty(obj.val())) {
						validate = isTakePrcLength(obj);
					}
					else {
						validate = true;
					}
				}
				else {
					validate = true;
				}
				
			}
			/*else if(fn == "isRndWeightLength") {
				
				if($("input[name='equipRndList[0].rndYn']").val() == 'Y') {
					validate = isRndWeightLength();
				}
				else {
					validate = true;
				}
				
			}*/
			else if(fn == "isPrcLength") {
				if(!$.isEmpty(obj.val())) {
					validate = isPrcLength(obj);
				}
				else {
					validate = true;
				}
			}
			else if(fn =="isEmail") {
				if(!$.isEmpty(obj.val())) {
					validate = isEmail(obj);
				}
				else {
					validate = true;
				}
			}
			else if(fn =="isHphone") {
				if(!$.isEmpty(obj.val())) {
					validate = isHphone(obj);
				}
				else {
					validate = true;
				}
			}
			else if(fn =="isTel") {
				if(!$.isEmpty(obj.val())) {
					validate = isTel(obj);
				}
				else {
					validate = true;
				}
				
			}
			else if(fn == "isEmpty") {
				validate = isEmpty(obj);
			}
			else if(fn == "isKor") {
				if(!$.isEmpty(obj.val())) {
					validate = isKor(obj);
				}
				else {
					validate = true;
				}
			}
			else if(fn == "isEng") {
				if(!$.isEmpty(obj.val())) {
					validate = isEng(obj);
				}
				else {
					validate = true;
				}
			}
			else if(fn =="isDateFormat") {
				if(!$.isEmpty(obj.val())) {
					validate = isDateFormat(obj);
				}
				else {
					validate = true;
				}
			}
			
			var pormTxt;
			if(!validate) {
				//$('.errorMsg').show();
				pormTxt = element[2]+" : "+message[fn];
				//$('.errorMsg').html(pormTxt);
				//$('.errorMsg').append('<p class="hint_'+element[0]+'" id="error_'+element[0]+'" style="color:red;">'+pormTxt+'</p>');
				$('.errAllMsg').append('<p class="hint_'+element[0]+'" id="error_'+element[0]+'">'+pormTxt+'</p>');
				
				/*var prompt = $('<div>');
		        prompt.addClass(element[0] + "formError");
		        var promptContent = $('<div>').addClass(function (index){return 'formErrorContent_'+element[0]}).addClass('formErrorContent').html('<a onclick="javascript:divRemove(this.id);" id="formErrorContent_'+element[0]+'"><strong>'+pormTxt+'</strong></a>').appendTo(prompt);
		        var elePosition = $('#'+element[0]).position();
		        promptContent.css({'position': 'absolute', 'left': elePosition.left + 300, 'top' : elePosition.top - 55 , 'cursor':'pointer'});
		        $('#'+element[0]).before(prompt);*/
				//alert(pormTxt);
				//obj.focus();
			}
			else {
				$('#error_'+element[0]).remove();
				//$('.'+ element[0] + 'formError').remove();
				$('.formErrorContent_'+element[0]).remove();
			}
		});
	});
}

function validateForm1(chk_rule1) {
	var chk_line = chk_rule1.split("@"); 
	var validate = true;
	$.each(chk_line , function(index , line) {
		var element = line.split(":");
		var elen = element[0].split("_");
		var obj = $('#'+elen[0]); 
		var fn_list = element[1].split(","); 
		$('#error1_'+element[0]).remove();
		$.each(fn_list , function(index , fns) {
			var args = fns.split("#");
			var fn = args[0];
			if(fn == "isEmpty") {
				if(elen[0] == "takeCd") {
					obj = $("input[name='takeCd']:checked");
					validate = isEmpty(obj);	
				}
				else if(elen[0] == "fileData") {
					var lastNum = $(".equipImage li:last").attr("class").replace("imgageItem", "");
					var fileLen = $(".fileDnms span").length;
					var idx = parseInt(lastNum);
					if(fileLen <= 0 && $.isEmpty($("input[name='fileData']").val())) {
						for(var i=0; i <= idx; i++) {
							obj = $("input[id='equipFileList["+idx+"].fileData']");
							validate = isEmpty(obj);	
						}
					}
					else {
						validate = true;
					}
				}
				else if(elen[0] == "fixedAsetNo" && !$.isEmpty($('input[name="notFix"]:checked').val())) {
					validate = true;
				}
				else if(elen[0] == "modelCd" && (!$.isEmpty($('input[name="largeFacYn"]:checked').val()) || !$.isEmpty($('input[name="notModel"]:checked').val()))) {
					validate = true;
				}
				else {
					validate = isEmpty(obj);
				}
			}
			else if(fn == "isTakeOneEmpty") {
				if(!$.isEmpty($('#equipChange').val()) && $('#equipChange').val() == '01') {
					if(elen[0] == 'takePrc1') {
						validate = isEmpty($('#takePrc'));
					}
					else if(elen[0] == 'takeDt') {
						validate = isEmpty($('#takeDt'));
					}
					else {
						validate = true;
					}
					
				}
				else {
					validate = true;
				}
			}
			else if(fn == "isTakeTwoEmpty") {
				if(!$.isEmpty($('#equipChange').val()) && $('#equipChange').val() == '02') {
					if(elen[0] == 'takePrc2') {
						validate = isEmpty($('#takePrc'));
					}
					else if(elen[0] == 'takeSdt') {
						validate = isEmpty($('#takeSdt'));
					}
					else if(elen[0] == 'takeEdt') {
						validate = isEmpty($('#takeEdt'));
					}
					else if(elen[0] == 'devSpec') {
						validate = isEmpty($('#devSpec'));
					}
					else {
						validate = true;
					}
					
				}
				else {
					validate = true;
				}
			}
			else if(fn == "isTakeThreeEmpty") {
				if(!$.isEmpty($('#equipChange').val()) && $('#equipChange').val() == '03') {
					
					if(elen[0] == 'takeSdt1') {
						validate = isEmpty($('#takeSdt'));
					}
					else if(elen[0] == 'takeEdt1') {
						validate = isEmpty($('#takeEdt'));
					}
					else {
						validate = true;
					}
				}
				else {
					validate = true;
				}
			}
			else if(fn == "isRegistOneEmpty") {
				if(elen[0] == "registCd") {
					obj = $("#registCd");
					validate = isEmpty(obj);
				}
				else {
					validate = true;
				}
				
				if($("#registCd").val() == '1') {
					
					if(elen[0] == "useScopeCd") {
						validate = isEmpty($("input[name='useScopeCd']:checked"));
					}
					
					if(elen[0] == "useScope") {
						if($("input[name='useScopeCd']:checked").val() == '1') {
							validate = isEmpty(obj);
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "useScopeEtc") {
						/*if($("input[name='useScope']:selected").val() == '09') {*/
						if($("input[name='useScopeCd']:checked").val() == '1' && $("#useScope option:selected").val() == '09') {
							validate = isEmpty(obj);
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "useTypeCd") {
						obj = $("input[name='useTypeCd']:checked");
						validate = isEmpty(obj);
					}
					else if(elen[0] == "useType") {
						if($("input[name='useTypeCd']:checked").val() == '06') {
							validate = isEmpty(obj);
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "idleDisuseCd") {
						validate = isEmpty($("input[name='idleDisuseCd']:checked"));
					}
					else if(elen[0] == "disuseCd") {
						if($("input[name='idleDisuseCd']:checked").val() == '4') {
							validate = isEmpty($("input[name='disuseCd']:checked"));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "disuseDt1") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '01') {
							validate = isEmpty($('#disuseDt01'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "disuseDt2") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '02') {
							validate = isEmpty($('#disuseDt02'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "disuseDt3") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '03') {
							validate = isEmpty($('#disuseDt03'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveOrganCd1") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '04') {
							validate = isEmpty($('#moveOrganCd04'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveDt1") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '04') {
							validate = isEmpty($('#moveDt04'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveOrganCd2") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '05') {
							validate = isEmpty($('#moveOrganCd05'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveDt2") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '05') {
							validate = isEmpty($('#moveDt05'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "location") {
						validate = isEmpty(obj);
					}
				}
				else if($("#registCd").val() == '2' || $("#registCd").val() == '3') {
					if(elen[0] == "idleDisuseCd") {
						validate = isEmpty($("input[name='idleDisuseCd']:checked"));
					}
					else if(elen[0] == "disuseCd") {
						if($("input[name='idleDisuseCd']:checked").val() == '4') {
							validate = isEmpty($("input[name='disuseCd']:checked"));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "disuseDt1") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '01') {
							validate = isEmpty($('#disuseDt01'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "disuseDt2") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '02') {
							validate = isEmpty($('#disuseDt02'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "disuseDt3") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '03') {
							validate = isEmpty($('#disuseDt03'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveOrganCd1") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '04') {
							validate = isEmpty($('#moveOrganCd04'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveDt1") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '04') {
							validate = isEmpty($('#moveDt04'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveOrganCd2") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '05') {
							validate = isEmpty($('#moveOrganCd05'));
						}
						else {
							validate = true;
						}
					}
					else if(elen[0] == "moveDt2") {
						if($("input[name='idleDisuseCd']:checked").val() == '4' && $("input[name='disuseCd']:checked").val() == '05') {
							validate = isEmpty($('#moveDt05'));
						}
						else {
							validate = true;
						}
					}
					else {
						validate = true;
					}
				}
			}
			else if(fn == "isPjtEmpty") {
				
				var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
				var lastSubAcqNo = 0;
				if($("#subjectAcqYTable table").length > 0) lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
				var idx = null;
				if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo));
				else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo));
				if($('#allRndYn').val() == 'Y') {
					for(var i =0; i<=idx; i++) {
						if(elen[0] == "subjectOcd") {
							if(($.isEmpty($("input[name='equipRndList["+idx+"].selInpYn']").val()) || $("input[name='equipRndList["+idx+"].selInpYn']").val() == 'Y') && $("input[name='equipRndList["+idx+"].rndYn']").val() == 'Y') {
								obj = $("input[name='equipRndList["+idx+"].subjectOcd']");
								validate = isEmpty(obj);
							}
							else {
								validate = true;
							}
						}
						else if(elen[0] == "rndWeight" && $.isEmpty($("#largeFacYn").val())) {
							obj = $("input[name='equipRndList["+idx+"].rndWeight']");
							validate = isEmpty(obj);
						}
						else if(elen[0] == "rndPrc") {
							if($("#equipChange").val() != "03") {
								obj = $("input[name='equipRndList["+idx+"].rndPrc']");
								validate = isEmpty(obj);
							}
							else {
								validate = true;
							}
						}
						else if(elen[0] == "startDt") {
							if($("input[name='equipRndList["+idx+"].rndYn']").val() == 'Y') {
								obj = $("input[name='equipRndList["+idx+"].startDt']");
								validate = isEmpty(obj);
							}
							else {
								validate = true;
							}
						}
						else if(elen[0] == "endDt") {
							if($("input[name='equipRndList["+idx+"].rndYn']").val() == 'Y') {
								obj = $("input[name='equipRndList["+idx+"].endDt']");
								validate = isEmpty(obj);
							}
							else {
								validate = true;
							}
						}
						else if(elen[0] == "rndAcq") {
							if($("input[name='equipRndList["+idx+"].rndYn']").val() == 'N') {
								obj = $("input[name='equipRndList["+idx+"].rndAcq']");
								validate = isEmpty(obj);
							}
							else {
								validate = true;
							}
						}
					}
				}
				else if($('#allRndYn').val() == 'N') {
					if(elen[0] == "rndAcq") {
						obj = $("input[name='equipRndList["+idx+"].rndAcq']");
						validate = isEmpty(obj);
					}
					else {
						validate = true;
					}
				}
			}
			else if(fn == "isEquipCdEmpty") {
				if(!$.isEmpty($('#equipChange').val()) && $('#equipChange').val() == '03') {
					if(!$.isEmpty($('input[name="largeFacYn"]:checked').val())) {
						if(elen[0] == 'area0') {
							validate = isEmpty($('#area_0'));
						}
						else if(elen[0] == 'area1') {
							validate = isEmpty($('#area_1'));
						}
						else if(elen[0] == 'floorUp1') {
							validate = isEmpty($('#floorUp_1'));
						}
						else if(elen[0] == 'floorDown1') {
							validate = isEmpty($('#floorDown_1'));
						}
						else if(elen[0] == 'equipFacTakePrc') {
							validate = isEmpty($('#equipFacTakePrc'));
						}
						else if(elen[0] == 'facEquipId1') {
							validate = isEmpty($('#facEquipId_1'));
						}
						else if($.isEmpty($('input[name="equipFacYn"]:checked').val())) {
							if(elen[0] == 'equipTakePrc') {
								validate = isEmpty($('#equipTakePrc'));
							}
							else if(elen[0] == 'facEquipId0') {
								validate = isEmpty($('#facEquipId_0'));
							}
						}
						else if(elen[0] == 'equipLittleTakePrc') {
							validate = isEmpty($('#equipLittleTakePrc'));
						}
						else {
							validate = true;
						}
					}
					else {
						if(elen[0] == 'area0') {
							validate = isEmpty($('#area_0'));
						}
						else if(elen[0] == 'area1') {
							validate = isEmpty($('#area_1'));
						}
						else if(elen[0] == 'floorUp1') {
							validate = isEmpty($('#floorUp_1'));
						}
						else if(elen[0] == 'floorDown1') {
							validate = isEmpty($('#floorDown_1'));
						}
						else if($.isEmpty($('input[name="equipFacYn"]:checked').val())) {
							if(elen[0] == 'equipTakePrc') {
								validate = isEmpty($('#equipTakePrc'));
							}
							else if(elen[0] == 'facEquipId0') {
								validate = isEmpty($('#facEquipId_0'));
							}
						}
						else {
							validate = true;
						}
					}
				}
				else {
					validate = true;
				}
			}
			
			var pormTxt;
			if(!validate) {
				pormTxt = element[2]+" : "+message[fn];
				$('.errAllMsg').append('<p class="hint_text" id="error1_'+element[0]+'">'+pormTxt+'</p>');
				//$('.errorMsg1').append('<p class="hint_text" style="display:none;" id="error1_'+element[0]+'">'+pormTxt+'</p>');
				/*$('.errorMsg1').append('<p class="hint_text" id="error1_'+element[0]+'">'+pormTxt+'</p>');*/
				
			}
			else if(validate) {
				$('#error1_'+element[0]).remove();
			}
		});
	});
}

var message = 	{
		 "isEmpty":"필수항목입니다."
		,"isNumber":"숫자가 포함되어야 합니다."	
		,"eqVal":"두 값이 동일"	
		,"isEmail":"유효하지 않은 이메일"	
		,"isSSN":"유효하지 않은 주민번호"
		,"isDateComparison":"종료일자가 시작일자보다 과거일수 없습니다."
		,"isOnlyNumber" : "숫자만 입력하셔야 합니다."
		,"isPrcLength" : "100% 를 넘을수 없습니다."
		,"isOnlyImage" : "이미지만 첨부가능합니다.(확장자 : bmp,gif,jpg,jpeg,png)"
		,"isLength"    : "한글 100자 이상 영문은 200자 이상 입력해주세요."
		,"isEmail" : "이메일주소가 올바르지 않습니다."	
		,"isHphone" : "핸드폰 번호가 올바르지 않습니다."
		,"isTel" : "전화번호가 올바르지 않습니다."
		,"isTakeOneEmpty":"필수항목입니다."
		,"isTakeTwoEmpty":"필수항목입니다."
		,"isTakeThreeEmpty":"필수항목입니다." 
		,"isRegistOneEmpty":"필수항목입니다." 
		,"isPjtEmpty":"필수항목입니다."
		,"isEquipCdEmpty":"필수항목입니다."
		,"isTakePrcLength":"100만원 이상 입력하세요."
		,"isRndWeightLength":"가중치의 합이 100을 넘을수 없습니다."
		,"isKor":"한글이 포함되어야 합니다."
		,"isEng":"영문만 입력이 가능합니다."
		,"isDateFormat" :"날짜를 형식에 맞게 입력하세요  ex) 2013-01-01"
		,"isNotMonth" : "월을 잘못입력하셨습니다."
	};
