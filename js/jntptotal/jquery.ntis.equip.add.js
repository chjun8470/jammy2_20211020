/* Copyright (c) 2012 kisystems, Inc.
 * All right reserved
 *
 * Revision History
 * Author           Date             Description
 * --------------   --------------   ------------------
 * yhs              2013. 08. 29.     신규생성
 */

/**
 * 장비이미지 멀티 
 */

$(function() {
	
	/* 제작사 모델 포커스  =============================================================*/
	
	/**
	 * 제작사 모델 포커스
	 */
	var _manufactureFocus = function(id) {
		$('#' + id).focus();
	};
	
	/* 달력  =============================================================*/
	
	/**
	 * 달력위젯
	 * 오늘 날짜 기준으로 미래 날짜는 선택되지 않도록 막음.
	 */
	$(".equipCalendar").datepicker({
		showOn: 'both',
		buttonImage: '/wcom/images/contents/icon_sche.gif',
		buttonImageOnly: true,
		changeYear: true,
		yearRange: 'c-99:c+99',
		maxDate: '+0d'
	});
	
	/**
	 * 과제정보 달력위젯
	 */
	$(".subjectCalendar").datepicker({
		showOn: 'both',
		buttonImage: '/wcom/images/contents/icon_sche.gif',
		buttonImageOnly: true,
		changeYear: true,
		yearRange: 'c-100:c+100',
		maxDate: null
	});
	
	/**
	 * 운영일지 및 유지보수 일지 현황 달력
	 */
	$(".operMainalendar").datepicker({
		showOn: 'both',
		buttonImage: '/wcom/images/contents/icon_sche.gif',
		buttonImageOnly: true,
		changeYear: true,
		yearRange: 'c-100:c+100',
		maxDate: null,
		//dateFormat : "yy-mm",
		monthNamesShort: ['01','02','03','04','05','06','07','08','09','10','11','12'],
		onChangeMonthYear : function(year, month, inst) {
			$("#startMonth").val(year + "-" + month);
		},
	});
	
	/**
	 * 토글이미지버튼
	 * 열기/닫기 이미지 버튼은 동일한 경로에 동일한 확장자야합니다.
	 */
	$.imgbtnToggle = function (params) {
		
		if(jQuery.isEmpty(params.btnId)) { alert('btnId is empty'); return; }
		if(jQuery.isEmpty(params.trgtId) && jQuery.isEmpty(params.trgtCls)) { alert('trgtId or trgtCls is empty'); return; }
		if(jQuery.isEmpty(params.openImg)) { alert('openImg is empty'); return; }
		if(jQuery.isEmpty(params.closeImg)) { alert('closeImg is empty'); return; }
		
		this.params = jQuery.extend({
			btnId:		null,	// 이미지버튼ID
			trgtId:		null,	// 토글엘리먼트ID
			trgtCls:	null,	// 토글엘리먼트CLASS
			openImg:	null,	// 열기버튼이미지
			closeImg: 	null,	// 닫기버튼이미지
			duration:	200		// 토글속도
		}, params);
		
		var oldParam = this.params;
		
		var trgtObj = null;
		if(jQuery.isEmpty(this.params.trgtId)) {
			trgtObj = jQuery('.' + this.params.trgtCls); 
		}
		else trgtObj = jQuery('#' + this.params.trgtId);
		
		trgtObj.slideToggle(this.params.duration, function() {
			
			var btnObj = jQuery('#' + oldParam.btnId);
			var imgSrc = btnObj.attr('src');
			
			var prefix = imgSrc.substring(0, imgSrc.lastIndexOf('/') + 1) ;
			var surfix = imgSrc.substring(imgSrc.lastIndexOf('.'));
			
			if($(this).is(":visible")) {
				btnObj.attr('src', prefix + oldParam.closeImg + surfix);	
			} 
			else btnObj.attr('src', prefix + oldParam.openImg + surfix); 
		});
		
		return;
	};
	
	/* multiToggle  =============================================================*/
	
	/**
	 * 전체엘리먼트를 숨기고 개별엘리먼트를 출력합니다.
	 * 개별엘리먼트가 없는경우 모두 숨깁니다.
	 */
	jQuery.multiToggle = function(params) {
		this.params = jQuery.extend({
			object:				null,	// 전체엘리먼트 ('#object', '.object', object)
			item:				null,	// 개별엘리먼트 ('#item', '.item', object)
			toggle:				true,	// 숨김옵션
			disabled:			true	// 비활성화옵션 
		}, params);
		
		if(jQuery.isEmpty(this.params.object)) {
			alert('전체엘리먼트가 지정되지 않았습니다.'); return;
		}
		else if(!this.params.toggle && !this.params.disabled) {
			alert('숨김, 비활성화 옵션중 한가지 이상 활성화되야 합니다.'); return;
		}
		else {
			if(this.params.toggle) {
				jQuery(this.params.object).hide();
				if(!jQuery.isEmpty(this.params.item)) {
					jQuery(this.params.item).show();
				}
			}
			if(this.params.disabled) {
				jQuery(this.params.object).attr('disabled', true);
				if(!jQuery.isEmpty(this.params.item)) {
					jQuery(this.params.item).removeAttr('disabled');
				}
			}
		}
	};
	
	/* step2  =============================================================*/
	
	/**
	 * 국가과제 추가.
	 * 
	 */
	$("#addItemBtn").on('click', function() {  
		
		var clone = $("#subjectTable table:eq(0)").clone(true);	
		var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
		var lastSubAcqNo = 0;
		if($("#subjectAcqYTable table").length > 0) lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
		var idx = null;
		if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
		else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
		clone.removeClass(); 
		
		$('#rndPrc_0').val('');
		$('#rndWeight_0').val('');
		
		$(clone).find("tr").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
			
			if(!$.isEmpty($(this).attr("class"))) {
				var classId = $(this).attr("class");
				var idPrefix = classId.substring(0, classId.indexOf('_')+1);
				$(this).attr('class', idPrefix + idx);
				
			}
		});
		
		$(clone).find("th").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("td").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				if($("#subjectOcd_0").is(':hidden')) {
					if(idPrefix == 'subjectTlt_') $(this).text("과제번호 :");
					else if(idPrefix == 'subjectNmSpan_') $(this).text("세부과제명 :");
				}
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("select").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				$(this).attr('name', prefix + idx + suffix).val("");
			}
				
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
			
		$(clone).find("input").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				
				if(suffix == '].rndYn') $(this).attr('name', prefix + idx + suffix).val("Y");
				else $(this).attr('name', prefix + idx + suffix).val("");
			}
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				if($("#subjectOcd_0").is(':hidden')) {
					if(idPrefix == "subjectOcd_") $(this).show();
					else if(idPrefix == "subjectTxt_") $(this).val("").hide();
					else if(idPrefix == "subjectNm_") $(this).show();
					else if(idPrefix == "busiNmTxt_") $(this).val("").hide();
				}
			}
		});
		
		$(clone).find("button").each(function() {
			if($(this).attr("type") == 'button') $(this).attr("style", "display:'';");
		});
			
		$(clone).find("a").each(function() {
			var id = $(this).attr("id");
			var idPrefix = id.substring(0, id.indexOf('_')+1);
			$(this).find("span").text("찾기");
			$(this).attr('id', idPrefix + idx);
			$(this).attr('href', "/com/pjt/search/layer?selector=ntisSubeqMod&flag="+idx);
		});
			
		$(clone).find("span").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
			
		$(clone).find("label").each(function() {
			var forid = $(this).attr("for");
			var foPrefix = forid.substring(0, forid.indexOf('_')+1);
			$(this).attr('for', foPrefix + idx);
		});
		
		$('#equipSubjectHelper').show();
		clone.addClass("tbl_00").attr('id', 'subjectItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
		$("#subjectTable").append(clone);
	});
	
	/**
	 * 연구시설 국가과제 추가.
	 * 
	 */
	$("#addItemFacBtn").on('click', function() {  
		var clone = $("#subjectTable table:eq(0)").clone(true);	
		var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
		var lastSubAcqNo = 0;
		if($("#subjectAcqYTable table").length > 0) lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
		var idx = null;
		if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
		else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
		clone.removeClass(); 
		
		$('#rndWeight_0').val('');
		
		$(clone).find("tr").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
			
			if(!$.isEmpty($(this).attr("class"))) {
				var classId = $(this).attr("class");
				var idPrefix = classId.substring(0, classId.indexOf('_')+1);
				$(this).attr('class', idPrefix + idx);
				
			}
		});
		
		$(clone).find("th").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("td").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				if(idPrefix == 'subjectWeight_') $(this).hide();
			}
		});
		
		$(clone).find("em").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx).text("");
			}
		});
		
		$(clone).find("input").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				
				if(suffix == '].rndYn') $(this).attr('name', prefix + idx + suffix).val("Y");
				else if(suffix == '].landPrc' || suffix == '].buildingPrc' || suffix == '].specFacPrc') $(this).attr('name', prefix + idx + suffix).val(0);
				else if(suffix == '].rndWeight') $(this).attr('name', prefix + idx + suffix).val('');
				else $(this).attr('name', prefix + idx + suffix).val("");
			}
			
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("button").each(function() {
			if($(this).attr("type") == 'button') $(this).attr("style", "display:'';");
		});
		
		$(clone).find("select").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				$(this).attr('name', prefix + idx + suffix).val("");
			}
				
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("a").each(function() {
			var id = $(this).attr("id");
			var idPrefix = id.substring(0, id.indexOf('_')+1);
			if($("#apiNtisProjectSearchPopup_0").is(':hidden')) {
				if(idPrefix == 'apiNtisProjectSearchPopup_') $(this).show();
			}
			$(this).attr('id', idPrefix + idx);
			$(this).attr('href', "/com/pjt/search/layer?selector=facEquip&flag="+idx);
		});
		
		$(clone).find("span").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				if(idPrefix == 'help_') $(this).hide();
				$(this).attr('id', idPrefix + idx);
			}
		});
		$('#equipSubjectHelper').show();
		clone.addClass("tbl07").attr('id', 'subjectItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
		$("#subjectTable").append(clone);
		removeLayer(idx);
	});
	
	/**
	 * 국가과제 삭제.
	 * 
	 */
	$("#delItemBtn").on('click', function() { 
		var clickedRow = $(this).parent().parent().parent().parent();
        var cls = clickedRow.attr("id");
        var tblNum = $("#subjectTable table").length;
        
        if(tblNum > 1) $("#" +cls).remove();
        else alert("과제정보는 한건이상 입력하셔야 합니다.");
        
        sumLandTake();
        sumbuildingTake();
        sumspecFacTake();
	});
	
	/**
	 * 취득재원 추가.
	 * 
	 */
	$("#addItemAcqBtn").on('click', function() { 
		if($('#acqShow').val() == '0') {
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var idx = (parseInt(lastSubNo)+1);
			$.multiToggle({object:'.equipRndYnOption', item:'#equipRndDetail, #equipRndButton, #subjectAcqYTable, #equipRndSubDetailButton2'});
			if($.isEmpty($('input[name="largeFacYn"]:checked').val())) {
				$("#subjectAcqYTable").append("<table class='tbl_00' summary='과제번호, 당해년도수행기간, 집행금액, 과제비중등을 나타낸 표' id='subjectAcqItem"+idx+"' style='border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;'>" 
						+"<caption>과제정보</caption>"
						+"<colgroup><col width='12%'><col width='35%'><col width='10%'><col width='35%'></colgroup>"
						+"<tbody>"
						+"<tr>"
						+"<td class='tl'>비R&amp;D재원명 :</td>"
						+"<td colspan='3' class='tl'><input type='text' name='equipRndList["+idx+"].rndAcq' id='rndAcq_"+idx+"' style='width:95%;'></td>"
						+"</tr>"
						+"<tr>"
						+"<td class='tl'>집행금액 :</td>"
						+"<td class='tl'><input type='text' name='equipRndList["+idx+"].rndWeight' id='rndWeight_"+idx+"' class='number' style='width:35%'> (%)"
						+"<button type='button' class='btn_v23' onclick='javascript:delRnd("+idx+");' style='margin-left:30px;'><span>삭제</span></button>" 
						+"<input type='hidden' name='equipRndList["+idx+"].rndYn' id='rndYn_"+idx+"' value='N'>"
						+"</tr>"
						+"<tr>"
						+"<td colspan='4' class='f_orange' id='bRndTxt_"+idx+"'>※ “신재생에너지테스트베드육성사업”, “교육기반조성사업”, ”실험실습기자재확충사업” 등과 같이 사업명칭을 입력해주세요.</td>"
						+"</tr>"
						+"</tbody>"
						+"</table>");
			}
			else {
				$("#subjectAcqYTable").append("<table class='tbl_00' summary='과제번호, 당해년도수행기간, 집행금액, 과제비중등을 나타낸 표' id='subjectAcqItem"+idx+"' style='border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;'>" 
						+"<caption>과제정보</caption>"
						+"<colgroup><col width='12%'><col width='35%'><col width='10%'><col width='35%'></colgroup>"
						+"<tbody>"
						+"<tr>"
						+"<td class='tl'>비R&amp;D재원명 :</td>"
						+"<td colspan='3' class='tl'><input type='text' name='equipRndList["+idx+"].rndAcq' id='rndAcq_"+idx+"' style='width:88%;'>"
						+"<button type='button' class='btn_v23' onclick='javascript:delRnd("+idx+");' style='margin-left:30px;'><span>삭제</span></button>" 
						+"<input type='hidden' name='equipRndList["+idx+"].rndYn' id='rndYn_"+idx+"' value='N'>"
						+"</td>"
						+"</tr>"
						+"<tr>"
						+"<td colspan='4' class='f_orange' id='bRndTxt_"+idx+"'>※ “신재생에너지테스트베드육성사업”, “교육기반조성사업”, ”실험실습기자재확충사업” 등과 같이 사업명칭을 입력해주세요.</td>"
						+"</tr>"
						+"</tbody>"
						+"</table>");
			}
			$('#acqShow').val('1');
		}
		else {
			var clone = $("#subjectAcqYTable table:eq(0)").clone(true);
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			
			var idx = null;
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
			clone.removeClass(); 
			$(clone).find("input").each(function() {
				if(!$.isEmpty($(this).attr("name"))) {
					var name = $(this).attr("name");
					var prefix = name.substring(0, name.indexOf('[')+1);
					var suffix = name.substring(name.indexOf(']'));
					if(suffix == '].rndYn') {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
					}
					else {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
					}
				}
			});
			
			$(clone).find("button").each(function() {
				if($(this).attr("type") == 'button') $(this).attr('onclick', 'javascript:delRnd('+idx+')');
			});
			
			$(clone).find("tr").each(function() {
				if(!$.isEmpty($(this).attr("id"))) {
					var id = $(this).attr("id");
					var idPrefix = id.substring(0, id.indexOf('_')+1);
					if(idPrefix == 'bRndTxt_') $(this).attr("style", "display:none");
					$(this).attr('id', idPrefix + idx);
				}
			});
			
			clone.addClass("tbl_00").attr('id', 'subjectAcqItem' + idx);
			$("#subjectAcqYTable").append(clone);
			var trNum = $("#subjectAcqYTable table").length;
			$('#acqShow').val(trNum);
		}
	});
	
	/**
	 * 취득재원 추가(등록).
	 * 
	 */
	$("#addItemAcqFacAddBtn").on('click', function() { 
		if($('#acqShow').val() == '0') {
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var idx = (parseInt(lastSubNo)+1);
			$.multiToggle({object:'.equipRndYnOption', item:'#equipRndDetail, #equipRndButton, #subjectAcqYTable, #equipRndSubDetailButton2'});
			$("#subjectAcqYTable").append("<table class='tbl07' summary='과제번호, 당해년도수행기간, 집행금액, 과제비중등을 나타낸 표' id='subjectAcqItem"+idx+"' style='border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;'>" 
					+"<caption>과제정보</caption>"
					+"<colgroup><col width='60px'><col width='100px;'><col width='160px'></colgroup>"
					+"<tbody>"
					+"<tr>"
					+"<td class='tl'>비R&amp;D재원명</td>"
					+"<td class='tl'><input type='text' name='equipRndList["+idx+"].rndAcq' id='rndAcq_"+idx+"' style='width:95%;'></td>"
					+"<td class='srch_label'>과제비중" 
					+"<span class='help' id='helpWeight_"+idx+"'>!"
					+"<span style='width:400px;'>"
					+"<em class='f_blue'>2개 이상 과제로 시설을 구축한 경우 각 과제별 집행한 금액의 비중</em><br>"
					+"<em class='f_green'>ex)  1억의 시설을 A과제에서 7천만원  B과제에서 3천만원 사용한 경우, A과제 비중은 70%, B과제비중은 30%임</em>"
					+"</span>"
					+"</span>"
					+": <input type='text' name='equipRndList["+idx+"].rndWeight' id='rndWeight_"+idx+"' class='number' style='width:35%'> (%) <input type='hidden' name='equipRndList["+idx+"].rndYn' id='rndYn_"+idx+"' value='N'/><input type='hidden' name='equipRndList["+idx+"].facSeq' id='facSeq_"+idx+"'/>" 
					+"<button type='button' class='btn_v23' onclick='javascript:delRnd("+idx+");'><span>삭제</span></button>"
					+"</td>"
					+"</tr>"
					+"<tr id='takePrcTr_"+idx+"' class='takePrcTr_"+idx+"'>"
					+"<td colspan='3' class='tl'>"
					+"<span id='landSpan_"+idx+"'>토지비 : <input name='equipRndList["+idx+"].landPrc' id='landTake_"+idx+"' class='number' style='width:15%;' onkeyup='javascript:sumLandTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;<span id='landSpan_"+idx+"'>건물비 : <input name='equipRndList["+idx+"].buildingPrc' id='buildingTake_"+idx+"' class='number' style='width:15%;' onkeyup='javascript:sumbuildingTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;<span id='landSpan_"+idx+"'>특수설비비 : <input name='equipRndList["+idx+"].specFacPrc' id='specFacTake_"+idx+"' class='number' style='width:15%;' onkeyup='javascript:sumspecFacTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"</td>"
					+"</tr>"
					+"<tr>"
					+"<td colspan='3' class='f_orange'>※ “신재생에너지테스트베드육성사업”, “교육기반조성사업”, ”실험실습기자재확충사업” 등과 같이 사업명칭을 입력해주세요.</td>"
					+"</tr>"
					+"</tbody>"
					+"</table>");
			$('#acqShow').val('1');
		}
		else {
			var clone = $("#subjectAcqYTable table:eq(0)").clone(true);
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			
			var idx = null;
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
			clone.removeClass(); 
			$(clone).find("input").each(function() {
				if(!$.isEmpty($(this).attr("name"))) {
					var name = $(this).attr("name");
					var prefix = name.substring(0, name.indexOf('[')+1);
					var suffix = name.substring(name.indexOf(']'));
					if(suffix == '].rndYn') {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
					}
					else {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
					}
				}
				
				if(!$.isEmpty($(this).attr("id"))) {
					if($(this).attr("type") != 'checkbox') {
						var id = $(this).attr("id");
						var idPrefix = id.substring(0, id.indexOf('_')+1);
						$(this).attr('id', idPrefix + idx);
					}
					else if($(this).attr("type") == 'checkbox') {
						if($(this).attr("id") == 'facSeq01_' + idx) {
							$(this).val("01");
							$(this).prop("checked", false);
						}
						else if($(this).attr("id") == 'facSeq02_' + idx) {
							$(this).val("02");
							$(this).prop("checked", false);
						}
						else if($(this).attr("id") == 'facSeq03_' + idx) {
							$(this).val("03");
							$(this).prop("checked", false);
						}
					}
				}
			});
			
			$(clone).find("button").each(function() {
				if($(this).attr("type") == 'button') $(this).attr('onclick', 'javascript:delRnd('+idx+')');
			});
			
			clone.addClass("tbl07").attr('id', 'subjectAcqItem' + idx);
			$("#subjectAcqYTable").append(clone);
			var trNum = $("#subjectAcqYTable table").length;
			$('#acqShow').val(trNum);
		}
	});
	
	/**
	 * 취득재원 추가.
	 * 
	 */
	$("#addItemAcqFacBtn").on('click', function() { 
		if($('#acqShow').val() == '0') {
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var idx = (parseInt(lastSubNo)+1);
			$.multiToggle({object:'.equipRndYnOption', item:'#equipRndDetail, #equipRndButton, #subjectAcqYTable, #equipRndSubDetailButton2'});
			$("#subjectAcqYTable").append("<table class='tbl07' summary='과제번호, 당해년도수행기간, 집행금액, 과제비중등을 나타낸 표' id='subjectAcqItem"+idx+"' style='border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;'>" 
					+"<caption>과제정보</caption>"
					+"<colgroup><col width='110px'><col width='510px;'><col width='160px'></colgroup>"
					+"<tbody>"
					+"<tr>"
					+"<th scope='col' class='tl'>비R&amp;D재원명</th>"
					+"<td class='tl'><input type='text' name='equipRndList["+idx+"].rndAcq' id='rndAcq_"+idx+"' style='width:95%;'></td>"
					+"<td><button type='button' class='btn_v23' onclick='javascript:delRnd("+idx+");'><span>삭제</span></button></td>"
					+"</tr>"
					+"<tr id='takePrcTr_"+idx+"' class='takePrcTr_"+idx+"'>"
					+"<td colspan='2' class='tl'>"
					+"<span id='landSpan_"+idx+"'>토지비 : <input name='equipRndList["+idx+"].landPrc' id='landTake_"+idx+"' class='number' style='width:19%;' onkeyup='javascript:sumLandTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;<span id='landSpan_"+idx+"'>건물비 : <input name='equipRndList["+idx+"].buildingPrc' id='buildingTake_"+idx+"' class='number' style='width:19%;' onkeyup='javascript:sumbuildingTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;<span id='landSpan_"+idx+"'>특수설비비 : <input name='equipRndList["+idx+"].specFacPrc' id='specFacTake_"+idx+"' class='number' style='width:19%;' onkeyup='javascript:sumspecFacTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"</td>"
					+"<td>과제비중 : <input type='text' name='equipRndList["+idx+"].rndWeight' id='rndWeight_"+idx+"' class='number' style='width:35%'> (%) <input type='hidden' name='equipRndList["+idx+"].rndYn' id='rndYn_"+idx+"' value='N'/><input type='hidden' name='equipRndList["+idx+"].facSeq' id='facSeq_"+idx+"'/><input type='hidden' name='equipRndList["+idx+"].rndPrc' id='rndPrc_"+idx+"'/></td>"
					+"</tr>"
					+"<tr>"
					+"<td colspan='3' class='f_orange'>※ “신재생에너지테스트베드육성사업”, “교육기반조성사업”, ”실험실습기자재확충사업” 등과 같이 사업명칭을 입력해주세요.</td>"
					+"</tr>"
					+"</tbody>"
					+"</table>");
			$('#acqShow').val('1');
		}
		else {
			var clone = $("#subjectAcqYTable table:eq(0)").clone(true);
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			
			var idx = null;
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
			clone.removeClass(); 
			$(clone).find("input").each(function() {
				if(!$.isEmpty($(this).attr("name"))) {
					var name = $(this).attr("name");
					var prefix = name.substring(0, name.indexOf('[')+1);
					var suffix = name.substring(name.indexOf(']'));
					if(suffix == '].rndYn') {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
					}
					else {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
					}
				}
			});
			
			$(clone).find("button").each(function() {
				if($(this).attr("type") == 'button') $(this).attr('onclick', 'javascript:delRnd('+idx+')');
			});
			
			clone.addClass("tbl07").attr('id', 'subjectAcqItem' + idx);
			$("#subjectAcqYTable").append(clone);
			var trNum = $("#subjectAcqYTable table").length;
			$('#acqShow').val(trNum);
		}
	});
	
	/**
	 * 취득재원 삭제.
	 * 
	 */
	$("#delItemAcqBtn").on('click', function() {
		var clickedRow = $(this).parent().parent().parent();
        var cls = clickedRow.attr("class");
        if($(this).attr('class') == 'btn2 delItemAcqNBtn') {
        	var trNum = $("#subjectAcqYTable ul").length;
        	if(trNum > 1) {
        		$("." +cls).remove();
        	}
        	else {
        		$('#subjectAcqYTable').hide();
        		$('#acqShow').val('0');
        	}
        }
        else {
	        var trNum = $("#subjectAcqTable table").length;
	        if(trNum > 1) {
	        	$("." +cls).remove();
	        }
	        else {
	        	$('#subjectAcqYTable').hide();
	        	$('#equipRndSubDetail').hide();
	        }
	        var newtrNum = $("#subjectAcqTable table").length;
        	$('#acqShow').val(newtrNum);
        }
	});
	
	
	/**
	 * 연구장비 수정시 국가과제 추가.
	 * 
	 */
	$(".addItemModBtn").on('click', function() {
		var clone = $("#subjectTable table:eq(0)").clone(true);
		var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
		var idx = null;
		if($('#acqShow').val() == '0') {
			idx =  (parseInt(lastSubNo)+1);
		}
		else {
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
		}
		
		clone.removeClass(); 
		$('#rndPrc_0').val('');
		$('#rndWeight_0').val('');
		
		$(clone).find("tr").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
			
			if(!$.isEmpty($(this).attr("class"))) {
				var classId = $(this).attr("class");
				var idPrefix = classId.substring(0, classId.indexOf('_')+1);
				$(this).attr('class', idPrefix + idx);
				
			}
		});
		
		$(clone).find("th").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				
				if($("#subjectOcd_0").is(':hidden')) {
					if(idPrefix == 'subjectTlt_') $(this).text("과제번호 :");
					else if(idPrefix == 'subjectNmSpan_') $(this).text("세부과제명 :"); 
				}
			}
		});
		
		$(clone).find("td").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
			
		$(clone).find("input").each(function() {
			
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
					
				if(suffix == '].rndYn') $(this).attr('name', prefix + idx + suffix).val("Y");
				else $(this).attr('name', prefix + idx + suffix).val("");
				
			}
				
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				if($("#subjectOcd_0").is(':hidden')) {
					if(idPrefix == 'subjectTxt_') $(this).val("").hide();
					else if(idPrefix == 'busiNmTxt_') $(this).val("").hide();
					else if(idPrefix == 'subjectOcd_') $(this).val("").show();
					else if(idPrefix == 'subjectNm_') $(this).val("").show();
				}
			}
		});
		
		$(clone).find("button").each(function() {
			if($(this).attr("type") == 'button') $(this).attr("style", "display:'';");
		});
			
		$(clone).find("a").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				if($("#apiNtisProjectSearchPopup_0").is(':hidden')) {
					if(idPrefix == 'apiNtisProjectSearchPopup_') $(this).show();
				}
				$(this).attr('id', idPrefix + idx);
				$(this).attr('href', "/com/pjt/search/layer?selector=ntisSubeqMod&flag="+idx);
				if($(this).find("span").text() == "과제수정") $(this).find("span").text("과제찾기");
			}
		});
			
		$(clone).find("span").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				
				if($("#subjectOcd_0").is(':hidden')) {
					if(idPrefix == 'subjectTlt_') $(this).text("과제번호 :");
					else if(idPrefix == 'subjectNmSpan_') $(this).text("세부과제명 :");
				}
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("select").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				$(this).attr('name', prefix + idx + suffix).val("");
			}
				
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
				
		$(clone).find("label").each(function() {
			var forid = $(this).attr("for");
			var foPrefix = forid.substring(0, forid.indexOf('_')+1);
			$(this).attr('for', foPrefix + idx);
		});
		
		clone.addClass("tbl_00").attr('id', 'subjectItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
		$("#subjectTable").append(clone);
	});
	
	/**
	 * 연구장비 수정시 국가과제 삭제(R&amp;D).
	 * 
	 */
	$(".delItemBtn").on('click', function() { 
		var clickedRow = $(this).parent().parent().parent().parent();
        var cls = clickedRow.attr("id");
        $("#" +cls).remove();
	});	
	
	/**
	 * 연구장비 수정시 취득재원 추가(R&amp;D).
	 * 
	 */
	$(".addItemAcqModBtn").on('click', function() { 
		if($('#acqShow').val() == '0') {
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var idx = (parseInt(lastSubNo)+1);
			
			$.multiToggle({object:'.equipRndYnOption', item:'#equipRndDetail, #equipRndButton, #subjectAcqYTable'});
			$("#subjectAcqYTable").append("<table class='tbl_00' summary='과제번호, 당해년도수행기간, 집행금액, 과제비중등을 나타낸 표' id='subjectAcqItem"+idx+"' style='border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;'>" 
					+"<caption>과제정보</caption>"
					+"<colgroup><col width='13%'><col width='25%'><col width='17%'><col width='45%'></colgroup>"
					+"<tbody>"
					+"<tr>"
					+"<td class='tl'>비R&amp;D재원명 :</td>"
					+"<td colspan='3' class='tl'><input type='text' name='equipRndList["+idx+"].rndAcq' id='rndAcq_"+idx+"' style='width:88%;'></td>"
					+"</tr>"
					+"<tr>"
					+"<td class='tl'>집행금액 :</td>"
					+"<td class='tl'><input type='text' name='equipRndList["+idx+"].rndPrc' id='rndPrc_"+idx+"' class='number' style='width:80%;' onkeyup='javascript:rndWeightDivison(this.id, this.value);'> (원)</td>"
					+"<td class='tl'>과제비중 :</td>"
					+"<td class='tl'><input type='text' name='equipRndList["+idx+"].rndWeight' id='rndWeight_"+idx+"' class='number' style='width:35%'> (%)"
					+"<button type='button' class='btn_v23' onclick='javascript:delRnd("+idx+");' style='margin-left:157px;'><span>삭제</span></button>" 
					+"<input type='hidden' name='equipRndList["+idx+"].rndYn' id='rndYn_"+idx+"' value='N'>"
					+"<input type='hidden' name='equipRndList["+idx+"].facSeq' id='facSeq_"+idx+"'></td>"
					+"</tr>"
					+"<tr>"
					+"<td colspan='4' class='f_orange' id='bRndTxt_"+idx+"'>※ “신재생에너지테스트베드육성사업”, “교육기반조성사업”, ”실험실습기자재확충사업” 등과 같이 사업명칭을 입력해주세요.</td>"
					+"</tr>"
					+"</tbody>"
					+"</table>");
			$('#acqShow').val('1');
		}
		else {
			var clone = $("#subjectAcqYTable table:eq(0)").clone(true);
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			var idx = null;
			
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
			clone.removeClass(); 
			$(clone).find("input").each(function() {
				if(!$.isEmpty($(this).attr("name"))) {
					var name = $(this).attr("name");
					var prefix = name.substring(0, name.indexOf('[')+1);
					var suffix = name.substring(name.indexOf(']'));
					if(suffix == '].rndYn') {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
					}
					else {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
					}
				}
				
				if(!$.isEmpty($(this).attr("id"))) {
					var id = $(this).attr("id");
					var idPrefix = id.substring(0, id.indexOf('_')+1);
					$(this).attr('id', idPrefix + idx);
				}
			});
			
			$(clone).find("button").each(function() {
				if($(this).attr("type") == 'button') {
					if($(this).children("span").text() == '삭제') $(this).attr('onclick', 'javascript:delRnd('+idx+')');
				}
			});
			clone.addClass("tbl_00").attr('id', 'subjectAcqItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
			$("#subjectAcqYTable").append(clone);
			var trNum = $("#subjectAcqYTable table").length;
			$('#acqShow').val(trNum);
		}
	});
	
	/**
	 * 연구시설장비 수정시 취득재원 추가(R&amp;D).
	 * 
	 */
	$(".addItemFacAcqModBtn").on('click', function() { 
		if($('#acqShow').val() == '0') {
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var idx = (parseInt(lastSubNo)+1);
			$.multiToggle({object:'.equipRndYnOption', item:'#equipRndDetail, #equipRndButton, #subjectAcqYTable, #equipRndSubDetailButton2'});
			$("#subjectAcqYTable").append("<table class='tbl07' summary='과제번호, 당해년도수행기간, 집행금액, 과제비중등을 나타낸 표' id='subjectAcqItem"+idx+"' style='border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;'>" 
					+"<caption>과제정보</caption>"
					+"<colgroup><col width='70px'><col width='160px;'><col width='100px'></colgroup>"
					+"<tbody>"
					+"<tr>"
					+"<th scope='col' class='tl'>비R&amp;D재원명</th>"
					+"<td class='tl'><input type='text' name='equipRndList["+idx+"].rndAcq' id='rndAcq_"+idx+"' style='width:95%;'></td>"
					+"<td>과제비중 : <input type='text' name='equipRndList["+idx+"].rndWeight' id='rndWeight_"+idx+"' class='number' style='width:35%'> (%) <input type='hidden' name='equipRndList["+idx+"].rndYn' id='rndYn_"+idx+"' value='N'/><input type='hidden' name='equipRndList["+idx+"].facSeq' id='facSeq_"+idx+"'/></td>"
					+"</tr>"
					+"<tr id='takePrcTr_"+idx+"' class='takePrcTr_"+idx+"'>"
					+"<td colspan='3' class='tl'>"
					+"<span id='landSpan_"+idx+"'>토지비 : <input name='equipRndList["+idx+"].landPrc' id='landTake_"+idx+"' class='number' style='width:15%;' onkeyup='javascript:sumLandTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;<span id='landSpan_"+idx+"'>건물비 : <input name='equipRndList["+idx+"].buildingPrc' id='buildingTake_"+idx+"' class='number' style='width:15%;' onkeyup='javascript:sumbuildingTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;<span id='landSpan_"+idx+"'>특수설비비 : <input name='equipRndList["+idx+"].specFacPrc' id='specFacTake_"+idx+"' class='number' style='width:15%;' onkeyup='javascript:sumspecFacTake(); sumRndPrc(this.id)' value='0'/> (원)</span>"
					+"&nbsp;&nbsp;&nbsp;&nbsp;<button type='button' class='btn_v23' onclick='javascript:delRnd("+idx+");'><span>삭제</span></button>"
					+"</td>"
					+"</tr>"
					+"<tr>"
					+"<td colspan='3' class='f_orange'>※ “신재생에너지테스트베드육성사업”, “교육기반조성사업”, ”실험실습기자재확충사업” 등과 같이 사업명칭을 입력해주세요. </td>"
					+"</tr>"
					+"</tbody>"
					+"</table>");
			$('#acqShow').val('1');
		}
		else {
			var clone = $("#subjectAcqYTable table:eq(0)").clone(true);
			var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			var idx = null;
			
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
			clone.removeClass(); 
			$(clone).find("input").each(function() {
				if(!$.isEmpty($(this).attr("name"))) {
					var name = $(this).attr("name");
					var prefix = name.substring(0, name.indexOf('[')+1);
					var suffix = name.substring(name.indexOf(']'));
					if(suffix == '].rndYn') {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
					}
					else {
						$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
					}
				}
				
				if(!$.isEmpty($(this).attr("id"))) {
					var id = $(this).attr("id");
					var idPrefix = id.substring(0, id.indexOf('_')+1);
					$(this).attr('id', idPrefix + idx);
				}
			});
			
			$(clone).find("button").each(function() {
				if($(this).attr("type") == 'button') {
					if($(this).children("span").text() == '삭제') $(this).attr('onclick', 'javascript:delRnd('+idx+')');
				}
			});
			clone.addClass("tbl07").attr('id', 'subjectAcqItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
			$("#subjectAcqYTable").append(clone);
			var trNum = $("#subjectAcqYTable table").length;
			$('#acqShow').val(trNum);
		}
	});
	
	/**
	 * 연구장비 수정시 취득재원 삭제(R&amp;D).
	 * 
	 */
	$(".delItemAcqNBtn").on('click', function() {
		var clickedRow = $(this).parent().parent().parent();
		var cls = clickedRow.attr("class");
		$("." +cls).remove();
		var trNum = $("#subjectAcqYTable ul").length;
		$('#acqShow').val(trNum);
	}); 
	
	
	/**
	 * 연구시설장비 수정시 국가과제 추가.
	 * 
	 */
	$(".addItemFacModBtn").on('click', function() {
		var clone = $("#subjectTable table:eq(0)").clone(true);
		var lastSubNo = $("#subjectTable table:last").attr("id").replace("subjectItem", "");
		var idx = null;
		if($('#acqShow').val() == '0') {
			idx =  (parseInt(lastSubNo)+1);
		}
		else {
			var lastSubAcqNo = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			if(parseInt(lastSubNo) >= parseInt(lastSubAcqNo)) idx = (parseInt(lastSubNo)+1);
			else if(parseInt(lastSubNo) < parseInt(lastSubAcqNo)) idx = (parseInt(lastSubAcqNo)+1);
		}
		
		clone.removeClass(); 
		$('#rndWeight_0').val('');
		
		$(clone).find("tr").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
			
			if(!$.isEmpty($(this).attr("class"))) {
				var classId = $(this).attr("class");
				var idPrefix = classId.substring(0, classId.indexOf('_')+1);
				$(this).attr('class', idPrefix + idx);
				
			}
		});
		
		$(clone).find("th").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("em").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx).text("");
			}
		});
		
		$(clone).find("td").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				if(idPrefix == 'subjectWeight_') $(this).hide();
			}
		});
			
		$(clone).find("input").each(function() {
			
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
					
				if(suffix == '].rndYn') $(this).attr('name', prefix + idx + suffix).val("Y");
				else if(suffix == '].landPrc' || suffix == '].buildingPrc' || suffix == '].specFacPrc') $(this).attr('name', prefix + idx + suffix).val(0);
				else if(suffix == '].rndWeight') $(this).attr('name', prefix + idx + suffix).val('');
				else $(this).attr('name', prefix + idx + suffix).val("");
				
			}
				
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				if($("#subjectOcd_0").is(':hidden')) {
					if(idPrefix == 'subjectTxt_') $(this).val("").hide();
					else if(idPrefix == 'busiNmTxt_') $(this).val("").hide();
					else if(idPrefix == 'subjectOcd_') $(this).val("").show();
					else if(idPrefix == 'subjectNm_') $(this).val("").show();
				}
			}
		});
		
		$(clone).find("select").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				$(this).attr('name', prefix + idx + suffix).val("");
				
			}
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("button").each(function() {
			if($(this).attr("type") == 'button') $(this).attr("style", "display:'';").attr('onclick', 'javascript:delRndYMod('+idx+')');
		});
			
		$(clone).find("a").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				if($("#apiNtisProjectSearchPopup_0").is(':hidden')) {
					if(idPrefix == 'apiNtisProjectSearchPopup_') $(this).show();
				}
				$(this).attr('id', idPrefix + idx);
				$(this).attr('href', "/com/pjt/search/layer?selector=facEquip&flag="+idx);
				if($(this).find("span").text() == "과제수정") $(this).find("span").text("과제찾기");
			}
		});
			
		$(clone).find("span").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				if(idPrefix == 'help_') $(this).hide();
				$(this).attr('id', idPrefix + idx);
			}
		});
				
		$(clone).find("label").each(function() {
			var forid = $(this).attr("for");
			var foPrefix = forid.substring(0, forid.indexOf('_')+1);
			$(this).attr('for', foPrefix + idx);
		});
		
		clone.addClass("tbl07").attr('id', 'subjectItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
		$("#subjectTable").append(clone);
		removeLayer(idx);
	});
	
	/**
	 * 취득재원추가(비R&amp;D일때 버튼).
	 * 
	 */
	$("#addItemAcqBtnN").on('click', function() {
		var lastSubAcqNo = $("#subjectAcqTable table:last").attr("id").replace("subjectAcqItem", "");
		var idx = (parseInt(lastSubAcqNo)+1);
		var clone = $("#subjectAcqTable table:eq(0)").clone(true);
		clone.removeClass(); 
		$(clone).find("input").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				if(suffix == '].rndYn') {
					$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
				}
				else {
					$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
				}
			}
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("button").each(function() {
			if($(this).attr("type") == 'button') {
				if($(this).children("span").text() == '추가') $(this).attr("style" , "display:none");
				else if($(this).children("span").text() == '삭제') {
					$(this).attr("style" , "").attr('onclick', 'javascript:delBrnd('+idx+')');
				}
			}
		});
		
		$(clone).find("tr").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				if(idPrefix == 'bRndTxt_') $(this).attr("style", "display:none");
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		clone.addClass("tbl07").attr('id', 'subjectAcqItem' + idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:10px; padding-bottom:10px;');
		$("#subjectAcqTable").append(clone);
	});
	
	/**
	 * 취득재원삭제(비R&amp;D일때 버튼).
	 * 
	 */
	$("#delItemAcqBtnN").on('click', function() {
		var clickedRow = $(this).parent().parent().parent().parent().parent();
		var cls = clickedRow.attr("id");
		
		var tblNum = $("#subjectAcqTable table").length;
		
		if(tblNum > 1) $("#" +cls).remove();
		else alert("취득재원은 한건 이상 입력하셔야 합니다.");
	});
	
	/**
	 * 연구장비 수정시 취득재원추가(비R&amp;D일때 버튼).
	 * 
	 */
	$('.addItemAcqModBtnN').on('click', function() {
		var lastSubAcqNo = $("#subjectAcqTable ul:last").attr("class").replace("subjectAcqItem", "");
		var idx = (parseInt(lastSubAcqNo)+1);
		var clone = $("#subjectAcqTable ul:eq(0)").clone(true);
		clone.removeClass(); 
		$(clone).find("input").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				if(suffix == '].rndYn') {
					$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("N");
				}
				else {
					$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
				}
			}
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
		});
		
		$(clone).find("button").each(function() {
			if($(this).attr("type") == 'button') {
				if($(this).children("span").text() == '추가') $(this).attr("style" , "display:none");
				else if($(this).children("span").text() == '삭제') {
					$(this).attr("style" , "");
				}
			}
		});
		clone.addClass("subjectAcqItem"+idx).attr('style', 'border-top:1px dotted #c7c7c7; padding-top:8px; padding-bottom:8px;');
		$("#subjectAcqTable").append(clone);
	});
	
	$(".addImageBtn").on('click', function() {
		var clone = $(".equipImage li:eq(0)").clone(true);
		var lastNum = $(".equipImage li:last").attr("class").replace("imgageItem", "");
		var idx = parseInt(lastNum)+1;
		clone.removeClass(); 
		$(clone).find("input").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var name = $(this).attr("id");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				if($(this).attr("type") != 'button') $(this).attr('id', prefix + idx + suffix);
			}
		});
		
		$(clone).find("a").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				if($(this).attr("id") == 'add') $(this).attr("style", "display:none;");
				else if($(this).attr("id") == 'del') $(this).attr("style", "display:''");
			}
		});
		
		clone.addClass("imgageItem"+idx);
		$(".equipImage").append(clone);
	});
	
	$(".delImageBtn").on('click', function() {
		var clickedRow = $(this).parent();
		var cls = clickedRow.attr("class");
		var trNum = $(".equipImage li").length;
		if(trNum > 1) $("." +cls).remove();
		else alert("장비구축사진은 한장 이상 등록하셔야 합니다.");
	});
	
	/**
	 * 연구장비 수정시 취득재원삭제(비R&amp;D일때 버튼).
	 * 
	 */
	$('.delItemAcqModBtnN').on('click', function() {
		var clickedRow = $(this).parent().parent().parent();
		var cls = clickedRow.attr("class");
		$("." +cls).remove();
	});
	
	/**
	 * 3천만원 미만 연구장비 추가 
	 * 
	 */
	$(".addLittle").on('click', function() {
		var lastSubAcqNo = $("#littleTbody table:last").attr("id").replace("littleItem", "");
		var idx = (parseInt(lastSubAcqNo)+1);
		var clone = $("#littleTd table:eq(0)").clone(true);
		clone.removeClass(); 
		
		$(clone).find("input").each(function() {
			if(!$.isEmpty($(this).attr("name"))) {
				var name = $(this).attr("name");
				var prefix = name.substring(0, name.indexOf('[')+1);
				var suffix = name.substring(name.indexOf(']'));
				$(this).attr('name', prefix + idx + suffix).attr("disabled",false).val("");
			
			}
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
				if(idPrefix == "typeCd_") $(this).val("3");
			}
		});
		
		$(clone).find("a").each(function() {
			if($(this).children("span").text() == '추가') $(this).attr("style" , "display:none");
			else if($(this).children("span").text() == '삭제') $(this).attr("style" , "");
		});
		
		$(clone).find("tr").each(function() {
			if(!$.isEmpty($(this).attr("id"))) {
				var id = $(this).attr("id");
				var idPrefix = id.substring(0, id.indexOf('_')+1);
				$(this).attr('id', idPrefix + idx);
			}
			
			if(!$.isEmpty($(this).attr("class"))) {
				var cla = $(this).attr("class");
				var claPrefix = cla.substring(0, cla.indexOf('_')+1);
				$(this).attr('class', claPrefix + idx);
				
			}
		});
		clone.addClass("tbl_00").attr('id', 'littleItem' + idx);
		$("#littleTd").append(clone);
		$("#equipLittleCnt").val($("#littleTd table").length);
	});
	
	/**
	 * 3천만원 미만 연구장비 삭제 
	 * 
	 */
	$(".delLittle").on('click', function() {
		var clickedRow = $(this).parent().parent();
		var cls = clickedRow.attr("class");
		$("." +cls).remove();
		$("#equipLittleCnt").val($("#littleTd table").length);
	});
	
	
	/**
	 * 심의 통과 여부에 따른 심의정보 컨트롤
	 */
	$(':radio[name="redYn"]').on('click', function() {
		if($(this).val() == 'N') {
			$('#redInfoSearchArea').hide();
			$('#rfdEquipNo').val(null);
		}
		else {
			$('#redInfoSearchArea').show();
		}
	});
	
	
	/**
	 * 연구장비 연구시설 장비에 따른 구분
	 * 
	 */
	$.equipCdChg = function(val) {
		//$("#fixRadio").remove();
		if(val == "03") {
			$("#equipRegistMain").show();
			if($("input[name='registCd']:checked").val() == '2' || $("input[name='registCd']:checked").val() == '3') $("#equipMain").show();
			else $("#equipMain").hide();
			$("#fixedAsetNo").attr("style", "width:30%;");
			$("#manufactureNm").attr("style", "width:42%");
			$("#largeP").show();
			if($('#fixRadio').is(':hidden')) $("#fixRadio").show();
			if($('#modelRadio').is(':hidden')) $("#modelRadio").show();
			$("#equipChange").val(val);
			$("#branchCdSearch").attr('href', "/com/code/branch/tree/layer?equipGubun=03").attr("style","display:none;");
			$("#modelSearchLayer").attr('href', "/com/model/search/layer?flag=addModel&equipGubun=03");
			$("#eqcpIdLayer").attr('href', "/com/equip/equipSelectFind/layer?equipGubun=03");
			$("#kor").text("한글시설명");
			$("#eng").text("영문시설명");
			$("#take").text("구축방법");
			$("#fileImage").text("시설사진");
			$("#imageTxt").text("시설 사진은 jpeg/gif/png 등의 이미지 파일만 업로드가 가능합니다.\n 300kb 이상의  이미지를 업로드 해주세요.");
		}
		else {
			$("#equipRegistMain").hide();
			$("#equipMain").hide();
			$("#fixedAsetNo").attr("style", "width:77%;");
			$("#manufactureNm").attr("style", "width:89%");
			$("#fixRadio").hide();
			$("#modelRadio").hide();
			$("#equipChange").val(val);
			$("#largeP").hide();
			$("input[name='largeFacYn']").prop("checked", false);
			$("#branchCdSearch").attr('href', "/com/code/branch/tree/layer?equipGubun=01");
			$("#modelSearchLayer").attr('href', "/com/model/search/layer?flag=addModel&equipGubun=01");
			$("#eqcpIdLayer").attr('href', "/com/equip/equipSelectFind/layer?equipGubun=01");
			$("#kor").text("한글장비명");
			$("#eng").text("영문장비명");
			$("#take").text("취득방법");
			$("#fileImage").text("장비사진");
			$("#imageTxt").text("장비 사진은 jpeg/gif/png 등의 이미지 파일만 업로드가 가능합니다.\n 300kb 이상의  이미지를 업로드 해주세요.");
			//$("#korNm").attr("class", "").attr("disabled", false);
			$("#modelTr").show();
		}
		
		if(!$.isEmpty($("input[name='takeCd']:checked").val())) $.takeChg($("input[name='takeCd']:checked").val());
		else $.takeChg("1");
	};
	
	$.largeTr = function(val) {
		if($("#equipChange").val() == '03' && val == '1') { 
			$.multiToggle({object:'.equipRegistOption', item:'#largeP'});
			$("#modelTr").show();
			$("#equipRegistMain").show();
		}
		//else $("#modelTr").hide();
	}; 
	
	/**
	 * 연구시설 구축 장비 선택
	 * 
	 */
	$.facEquipSelect = function() {
		var checkedVal = $.getCheckedValues({cls:'chkboxEquip', key:'facEquip'});
		if(checkedVal.length < 0) alert("연구장비가 선택되지 않았습니다.");
		else if($('#checkedRow tbody tr').length == 0) alert("연구장비가 선택되지 않았습니다.");
		else {
			$("#facEquipId_0").val(checkedVal);
			$("#facEquipTotal").text(checkedVal.length + "점");
			$("#equipTakePrc").val();
			$.equipBaseEquip();
			$(".ui-dialog-content").dialog("close");
			sumTakePrc();
			number_format($('#equipTakePrc').val(), equipTakeView);
		}
	};
	
	/**
	 * 연구시설 구축 시설 선택
	 * 
	 */
	$.facSelectEquip = function() {
		var checkedVal = $.getCheckedValues({cls:'chkboxFac', key:'facEquipSelect'});
		if(checkedVal.length < 0) alert("연구시설이 선택되지 않았습니다.");
		else if($('#checkedFacRow tbody tr').length == 0) alert("연구시설이 선택되지 않았습니다.");
		else {
			$("#facEquipId_1").val(checkedVal);
			$("#facEquipFacTotal").text(checkedVal.length + "점");
			$("#equipFacTakePrc").val();
			$.equipBaseFacEquip();
			$(".ui-dialog-content").dialog("close");
			sumTakePrc();
			number_format($('#equipFacTakePrc').val(), equipSpecTakeView);
		}
	};
	
	$.sumTakePrc = function() {
		var sumTake = 0;
		$('#checkedRow tbody tr').remove();
		$("input[name='id']:checked").each(function(idx, row) {
			if($(row).parents("tr").find("td:eq(8)").attr("class") == "takeVal") {
				sumTake += parseInt($(row).parents("tr").find("td:eq(8)").text());
			}
			
			var rowClone = $(row).parents("tr").html();
			$('#checkedRow tbody').append('<tr id='+idx+'>'+rowClone+'</tr>');
			$('#checkedRow tbody').find('tr').find("td:eq(0)").children().attr("disabled", true);
			$('#checkedRow tbody').find('tr').find("td:eq(9)").attr("style", "display:");
			$('#checkedRow').show();
		});
		var onSumTake = addThousandSeparatorCommas(sumTake);
		
		$("#equipTakePrc").val(onSumTake);
		$("#equipTakeTotal").text(onSumTake + " (원)");
		$("#equipCnt").text($("input[name='id']:checked").length + " (점)");
	};
	
	
	$.equipBaseCookie = function() {
		setTimeout('$.equipBaseEquip()', 200);
	};
	
	$.equipBaseFacCookie = function() {
		setTimeout('$.equipBaseFacEquip()', 200);
	};
	
	$.equipBaseEquip = function() {
		var equipIds =  $.getCheckedValues({cls:'chkboxEquip', key:'facEquip'});
		var sumTake = 0;
		$.ajax({
			url: '/equip/base/equip?equipId='+ equipIds + '&equipCd=01',
			success: function(data) {
				if(data.length > 0) {
					$('#checkedRow tbody tr').remove();	
					$.cookie('facEquip', null);
					var newArr = new Array();
					$(data).each(function(i, equipList) {
						var rndNm = null;
						if(equipList.rndYn == 'Y') rndNm = "R&amp;D";
						else if(equipList.rndYn == 'N') rndNm = "비R&amp;D";
						sumTake += parseInt(equipList.takePrc);
						$('#checkedRow tbody').append("<tr>"
								+"<td class='tl'>"+equipList.korNm+"<br/>("+equipList.fixedAsetNo+")</td>"
								+"<td class='tc'>"+equipList.equipNo+"</td>"
								+"<td class='tc'>"+rndNm+"</td>"
								+"<td class='tc'>"+equipList.eqRegistDt+"</td>"
								+"<td class='tc'>"+addThousandSeparatorCommas(equipList.takePrc)+" (원)</td>"
								+"<td class='tc'>"+equipList.idleDisuseCd+"</td>"
								+"<td class='tc'><button type='button' class='btn_v23' id='"+equipList.equipId+"' onclick='javascript:delEquip(this.id);'><span>삭제</span></button></td>"
								+"</tr>"
						);
						newArr.push($.trim(equipList.equipId));
					});
					$.cookie('facEquip', newArr.join(','));
					$('.chkboxEquip').checkbox({debug: '#chked2', cookie: 'facEquip'});
					$('#checkedRow').show();
					
					var onSumTake = addThousandSeparatorCommas(sumTake);
					
					$("#equipTakePrc").val(onSumTake);
					$("#equipTakeTotal").text(onSumTake + " (원)");
					$("#equipCnt").text($(data).length + " (점)");
				}
				else {
					$('#checkedRow tbody tr').remove();	
					$("#equipTakePrc").val("");
					$("#equipTakeTotal").text("");
					$("#equipCnt").text("");
				}
			}
		});
	};
	
	$.equipBaseFacEquip = function() {
		var equipIds =  $.getCheckedValues({cls:'chkboxFac', key:'facEquipSelect'});
		var sumTake = 0;
		$.ajax({
			url: '/equip/base/equip?equipId='+ equipIds + '&equipCd=03',
			success: function(data) {
				if(data.length > 0) {
					$('#checkedFacRow tbody tr').remove();	
					$.cookie('facEquipSelect', null);
					var newArr = new Array();
					$(data).each(function(i, equipList) {
						var rndNm = null;
						if(equipList.rndYn == 'Y') rndNm = "R&amp;D";
						else if(equipList.rndYn == 'N') rndNm = "비R&amp;D";
						sumTake += parseInt(equipList.takePrc);
						$('#checkedFacRow tbody').append("<tr>"
								+"<td class='tl'>"+equipList.korNm+"<br/>("+equipList.fixedAsetNo+")</td>"
								+"<td class='tc'>"+equipList.equipNo+"</td>"
								+"<td class='tc'>"+rndNm+"</td>"
								+"<td class='tc'>"+equipList.eqRegistDt+"</td>"
								+"<td class='tc'>"+addThousandSeparatorCommas(equipList.takePrc)+" (원)</td>"
								+"<td class='tc'>"+equipList.idleDisuseCd+"</td>"
								+"<td class='tc'><button type='button' class='btn_v23' id='"+equipList.equipId+"' onclick='javascript:delFacEquip(this.id);'><span>삭제</span></button></td>"
								+"</tr>"
						);
						newArr.push($.trim(equipList.equipId));
					});
					$.cookie('facEquipSelect', newArr.join(','));
					$('.chkboxFac').checkbox({debug: '#chkedFacEquip', cookie: 'facEquipSelect'});
					$('#checkedFacRow').show();
					
					var onSumTake = addThousandSeparatorCommas(sumTake);
					
					$("#equipFacTakePrc").val(onSumTake);
					$("#equipFacTakeTotal").text(onSumTake + " (원)");
					$("#equipFacCnt").text($(data).length + " (점)");
				}
				else {
					$('#checkedFacRow tbody tr').remove();	
					$("#equipFacTakePrc").val("");
					$("#equipFacTakeTotal").text("");
					$("#equipFacCnt").text("");
				}
			}
		});
	};
	
	/**
	 * 구매, 개발, 구축에 따른 multiToggle.
	 * 
	 */
	$.takeChg = function(val) {
		$("#takeCdChange").show();
		if($("#equipChange").val() != "03") {
			if(val == "1") {
				$("#equipChange").val("01");
				$.multiToggle({object:'.equipCdOption', item:'#equiCdpMainDetail,#equiCdpMainDetail1,#equiCdpMainDetail2'});
			}
			else if(val == "2") {
				$("#equipChange").val("02");
				$.multiToggle({object:'.equipCdOption', item:'#equiCdpsubDetail,#equiCdpsubDetail1,#equiCdpsubDetail2,#equiCdpsubDetail3,#equiCdpsubDetail4'});
			}
			$("#takeCdChange1").show();
			$("#takeCdChange2").show();
		}
		else {
			$.multiToggle({object:'.equipCdOption', item:'#equiCdpthDetail,#equiCdpsubDetail1,#equiCdpthDetail2,#equipTakePrcForeigndiv,#equipTakePrcForeignLable'});
			/*$("#takePrc").attr("readonly",true).attr("style","background: #f0f0f0").attr("cssClass","Ltext4 numberFormat");
			takePrcSumRatio();
			number_format($("#takePrc").val());*/
			$("#takeCdChange1").hide();
			$("#takeCdChange2").hide();
		}
	};
	
	/**
	 * 주장비, 보조장치, 부대장비 multiToggle.
	 * 
	 */
	$.registChg = function(val, equipId) {
		if(val == '2' || val == '3') {
			$.ajax({
				url:'/equip/organ/checkRegist?equipId='+equipId,
				success:function(data) {
					if(data == false) {
						alert("해당 장비에 연결된 부대장비나 보조장치가 존재하여\n변경하실수 없습니다.\n변경을 원하시면 부대장비나 보조장치를 해제해주세요.");
						$.multiToggle({object:'.equipRegistOption', item:'#equipMainDetail, #equipUseTypeCd, #equipIdleDisuseCd, #equipSetup'});
						$("input[name='equipEquip.registCd'][value='1']").prop("checked", true);
					}
				}
			});
		}
	};
	
	/**
	 * 활용범위 단독활용만 가능일때
	 * 
	 */
	$.useScopeChg = function(val) {
		if(val == '1') $.multiToggle({object:'.useScopeCd', item:'#useScopeCd_' + val});
	};
	
	/**
	 *  tr 숨김
	 */
	$.trHide = function(nm, val) {
		
		if(nm == 'useScopeCd') {																					// 활용범위
			if(val != '1') {																						// 단독활용만가능이 아닐때
				$('#useScope_09').hide();																			// 단독활용기타사유 input 숨김
			}
			else if(val == '1') {																					// 단독활용사유일때 안내 레이어 출력		
				$('#useScopeTip').dialog({width:'320',height:'100'});
			}
			else if(val == '1' && $('#useScope').val() == '09') {													// 단독활용만 가능이고 단독활용사유가 기타일때 
				$('#useScope_09').show();																			// 단독활용기타사유 input 보임
			}
		}
		else if(nm == 'registCd') {																					// 장비구분
			if(val != '1') {																						// 주장비가 아닐때 
				$('#useScopeCd_1').hide();																			// 단독활용사유 숨김
				$('#useScope_09').hide();																			// 단독활용가타사유 숨김
				$('#useTypeCd_06').hide();																			// 장비용도사유 숨김
				$('#idleDisuseCd_4').hide();																		// 불용사유 숨김
				$('#disuseCd_'+$("input[name='disuseCd']:checked").val()).hide();									// 불용사유 (매각..대여...) 숨김
			}
			else if(val == '1') {																					// 주장비일때 
				if($("input[name='useScopeCd']:checked").val() == '1') $('#useScopeCd_1').show();					// 활용범위가 단독활용만 가능이면 단독활용사유 보임
				if($('#useScope').val() == '09') $('#useScope_09').show();											// 단독활용사유가 기타일때 기타 input 보임
				if($("input[name='useTypeCd']:checked").val() == '06') $('#useTypeCd_06').show();					// 장비용도가 기타일때 기타 input 보임
				$('#disuseCd_'+$("input[name='disuseCd']:checked").val()).show();									// 장비상태에 따른 불용사유
				if($("input[name='idleDisuseCd']:checked").val() == '4') $('#idleDisuseCd_4').show();				// 장비상태가 불용일때 불용사유 보임
			}
		}
		else if(nm == 'idleDisuseCd') {																				// 장비상태일때 
			if(val != '4') {
				$('#disuseCd_'+$("input[name='disuseCd']:checked").val()).hide();									// 불용이 아니면 불용사유 숨김
			}
			else {
				if(!$.isEmpty($("input[name='disuseCd']:checked").val())) $('#disuseCd_'+$("input[name='disuseCd']:checked").val()).show();
			}
			
			if(val == '2' || val == '3') $('#idleStatusTip').show();					// 장비상태가 유휴나 저활용일때 레이어 출력
		}
	};
	
	/**
	 *  rnd변경
	 */
	$.rndChg = function() {
		var tempSeq = $('#tempSeq').val();
		var rndYn = $('input[name = rndYnCheck]:checked').val();
		$.ajax({
			url : '/equip/temp/rndChg?tempSeq='+tempSeq+'&rndYn='+rndYn,
			success: function(data) {
				location.reload();
			},
			error:function(xhr, status, error) {
				alert(xhr + "||" + status + "||" + error);
			}
		});
	};
	
	/**
	 *  제작사 신규등록 
	 */
	$.manufactureDirectSelector = function(params, selector, selectorNm) {
		var madeNm =null;
		if($.isEmpty(params.directlyManufactureNm)) {
			alert("제작사를 입력해주세요.");
			_manufactureFocus('directlyManufactureNmLayer');
		}
		else if($.isEmpty(params.directlyMadeCd)) {
			alert("제작국가를 선택해주세요.");
			_manufactureFocus('directlyMadeCd');	
		}
		else {
			$.ajax({
				type: 'POST',
				async:	false,
				url : '/equip/manufacture/duplicate',
				data : {manufactureNm : params.directlyManufactureNm, madeCd : params.directlyMadeCd},
				success: function(manufacture) {
					if($(manufacture).length > 0) {
						for(var i = 0; i < $(manufacture).length; i++) {
							params.directlyManufactureCd = $(manufacture).get(i)['manufactureCd'];
							madeNm = $(manufacture).get(i)['madeNm'];
						}
					}
					else {
						alert("제작사 : "+params.directlyManufactureNm+"는 존재합니다.");
					}
				}
			});
			$('#manufactureCd').val(params.directlyManufactureCd);
			$('#manufacture').val(params.directlyManufactureNm + " / " + madeNm);
			$('#madeCd').val(params.directlyMadeCd);
			
			$(".ui-dialog-content").dialog("close");
		};
	};
	
	/**
	 *  모델 신규등록 
	 */
	$.modelDirectSelector = function() {
		if($.isEmpty($("#manufactureCd").val())) {
			alert("제작사를 선택해주세요");
			return false;
		}
		else if($.isEmpty($("#branchCd").val())) {
			alert("표준분류체계를 선택해주세요");
			return false;
		}
		else if($.isEmpty($("input[name='takeCd']:checked").val())) {
			alert("구축방법을 선택해주세요.");
			return false;	
		}
		else {
			var manufacture = $("#manufactureCd").val();
			var branch = $("#branchCd").val();
			var made = $("#madeCd").val();
			var take = $("input[name='takeCd']:checked").val();
			var modelCode = null;
			var modelName = null;
			$.ajax({
				type: 'POST',
				async:	false,
				url : '/equip/model/duplicate',
				data : {manufactureCd : manufacture, madeCd : made, branchCd : branch, takeCd : take},
				success: function(model) {
					if($(manufacture).length > 0) {
						for(var i = 0; i < $(model).length; i++) {
							model = $(model).get(i)['modelCd'];
							modelNm = $(model).get(i)['modelNm'];
						}
					}
					else {
						modelCode = model.modelCd;
						modelName = model.modelNm;
					}
				}
			});
			$("#modelCd").val(modelCode);
			$("#modelNm").val(modelName);
			$("#manufactureNm").val(modelName);
		};
	};
	
	/**
	 *  제작사& 모델 신규등록 
	 */
	$.manufactureModelDirectSelector = function(params, selector, selectorNm) {
		var branchNm = null;
		if($.isEmpty(params.directlyManufactureNm)) {
			alert("제작사를 입력해주세요.");
			_manufactureFocus('directlyManufactureNmLayer');
		}
		else if($.isEmpty(params.directlyModelNm)) {
			alert("모델명을 확인해주세요.");
			$("#directlyModelNmLayer").val("모델명 없음");
			_manufactureFocus('directlyModelNmLayer');
		}
		else if($.isEmpty(params.directlyMadeCd)) {
			alert("제작국가를 선택해주세요.");
			_manufactureFocus('directlyMadeCd');	
		}
		else if($.isEmpty(params.directlyBranchCd)) {
			alert("표준분류를 선택해주세요.");
			_manufactureFocus('directlyBranchCdLayer');	
		}
		else if($.isEmpty(params.directlyTakeCd)) {
			alert("취득방법을 선택해주세요.");
		}
		else if($.isEmpty(params.directlyModelNameYn)) {
			alert("모델명 유무를 선택해주세요.");
		}
		else {
			$.ajax({
				type: 'POST',
				async:	false,
				url : '/equip/manufactureModel/duplicate',
				data : {manufactureNm : params.directlyManufactureNm, madeCd : params.directlyMadeCd, modelNm : params.directlyModelNm, branchCd : params.directlyBranchCd, takeCd : params.directlyTakeCd, modelNameYn : params.directlyModelNameYn},
				success: function(manufacture) {
					if($(manufacture).length > 0) {
						for(var i = 0; i < $(manufacture).length; i++) {
							params.directlyManufactureCd = $(manufacture).get(i)['manufactureCd'];
							params.directlyModelCd = $(manufacture).get(i)['modelCd'];
							params.directlyBranchCd = $(manufacture).get(i)['branchCd'];
							branchNm = $(manufacture).get(i)['branchNm'];
							params.directlyModelNm = $(manufacture).get(i)['modelNm'];
						}
					}
					else {
						alert("제작사 : "+params.directlyManufactureNm+","+"모델명 : "+params.directlyModelNm+"은 존재합니다.");
					}
				}
			});
			
			$('#manufactureCd').val(params.directlyManufactureCd);
			$('#manufactureNm').val(params.directlyManufactureNm +',' + params.directlyModelNm);
			$('#modelCd').val(params.directlyModelCd);
			$('#modelNm').val(params.directlyModelNm);
			$('#madeCd').val(params.directlyMadeCd);
			$('#branchCd').val(params.directlyBranchCd);
			$('#branchNm').val(branchNm);
			$("input[name='takeCd'][value='"+params.directlyTakeCd+"']").prop("checked", true);
			if(!$.isEmpty(params.directlyBranchCd)) {
				$('#branchNm').css('width', '100%');
				$('#branchCdSearch').attr('style', 'display:none');
				$('#branchCheck').val('Y');
				if($("#equipChange").val() != "03") branchChg();
			}
			if(!$.isEmpty(params.directlyTakeCd)) {
				$("input[name='takeCd']").each(function(i) {
					$(this).attr('disabled', 'disabled');
				});
				$('#takeCheck').val('Y');
				if($("#equipChange").val() != "03") $.takeChg(params.directlyTakeCd);
			} 
			$("#modelCheck").val("Y");
			$(".ui-dialog-content").dialog("close");
		}
	};
	
	/**
	 * 심의번호 바인드
	 */
	$.bindRfdEquipNo = function(rfdEquipNo) {
		$('#rfdEquipNo').val(rfdEquipNo);
		$('#redPassY').attr('checked', true);
		$(".ui-dialog-content").dialog("close");
	};
	
	/* step2 dialog  =============================================================*/
	
	/**
	 * 주장비검색 다이얼로그 설정.
	 * 
	 */
	$('#eqcpIdLayer').dialogAjaxLinkStart({
		id: 'modal1',
		bind: 'bindSelectEqCp',
		title: '주장비검색',
		width: 930,
		sync: true
	});
	
	/**
	 * 주장비검색 다이얼로그 설정.
	 * 
	 */
	$('#eqcpIdLayer1').dialogAjaxLinkStart({
		id: 'modal1',
		bind: 'bindSelectEqCp1',
		title: '주장비검색',
		width: 930,
		sync: true
	});
	
	/**
	 * 대형연구시설 다이얼로그 설정.
	 * 
	 */
	$('#largeFacSearch').dialogAjaxLinkStart({
		id: 'largeFacSearch1',
		bind: 'bindSelectLargeFac',
		title: '대형연구시설 검색',
		width: 930,
		sync: true
	});
	
	/**
	 * 설치장소 다이얼로그 설정.
	 * 
	 */
	$('#setupLayer').dialogAjaxLinkStart({
		id: 'modal2',
		bind: 'bindSelectSetup',
		title: '설치장소검색',
		width: 820,
		sync: true
	});
	
	/**
	 * 과제정보 다이얼로그 설정.
	 * 
	 */
	$('.apiNtisProjectSearch').dialogAjaxLinkStart({
		id: 'equipPjtSearch',
		bind: 'bindSelectSubject',
		title: '과제명을 검색할 시  한 개의 키워드만 입력하셔도 검색이 가능합니다.',
		width: 1100,
		sync: true
	});
	
	/**
	 * 기관검색 다이얼로그 설정.
	 * 
	 */
	$('.organSearchLayer').dialogAjaxLinkStart({
		id: 'modal4',
		bind: 'bindSelectOrgan',
		title: '기관검색',
		width: 900,
		sync: true
	});
	
	/**
	 * 유사장비 다이얼로그 설정.
	 * 
	 */
	$('#equipNmLayer').dialogAjaxLinkStart({
		id: 'modal6',
		bind: 'bindSelectEquipNm',
		title: '유사장비',
		width: 600,
		sync: true
	});
	
	/**
	 * 표준분류체계 다이얼로그 설정.
	 * 
	 */
	$('#equipBranchLayer').dialogAjaxLinkStart({
		id: 'modal7',
		bind: 'branchSelector',
		title: '유사장비',
		width: 600,
		sync: true,
		treeId : 'equipTree'
	});
	
	/**
	 * 과제수행부처청 다이얼로그 설정.
	 * 
	 */
	$('.officelayer').dialogAjaxLinkStart({
		id: 'modal8',
		bind: 'bindSelectOffice',
		title: '과제수행부처청',
		width: 830,
		sync: true
	});
	
	// 장비표준분류 다이얼로그 설정
	$('#branchCdSearch').dialogAjaxLinkStart({
		id: 'modal9',
		bind: 'bindSelectBranchCd',
		type: 'tree', 
		width: 500,
		sync: true
	});
	
	// 제작사
	$('#manufactureSearchLayer').dialogAjaxLinkStart({
		id: 'manufactureSearch',
		bind: 'bindSelectManufacture',
		title: '제작사 선택',
		width: 600,
		sync: true
	});
	
	// 모델선택
	$('#modelSearchLayer').dialogAjaxLinkStart({
		id: 'modal5',
		bind: 'bindSelectModel',
		title: '제작사-모델선택',
		width: 820,
		sync: true
	});
	
	// 비RnD 과제정보 입력
	$('.pjtNotRndLayer').dialogAjaxLinkStart({
		id: 'pjtNotRndLayer',
		bind: 'pjtNotRndLayer',
		title: '비R&amp;D과제정보입력',
		width: 930,
		sync: true
	});
	
	/**
	 * 구축 연구장비 선택 다이얼로그 설정.
	 * 
	 */
	$('.equipSearch').dialogAjaxLinkStart({
		id: 'facEquipLayer',
		bind: 'facEquip',
		title: '연구장비찾기',
		width: 930,
		sync: true
	});
	
	
	
	/**
	 * 구축 연구시설 선택 다이얼로그 설정.
	 * 
	 */
	$('.equipFacSearch').dialogAjaxLinkStart({
		id: 'facEquipSelectLayer',
		bind: 'facSelectEquip',
		title: '연구시설찾기',
		width: 930,
		sync: true
	});
	
	/**
	 * 심의정보 검색
	 */
	$('#redInfoSearchPopup').dialogAjaxLinkStart({
		id: 'refInfoSelectLayer',
		bind: 'bindRfdEquipNo',
		title: '심의정보 찾기',
		width: 1200,
		sync: true
	});
	
	/**
	 * 날짜 포맷
	 */
	jQuery.isDateFormat = (function(str,id) {
		//var pormTxt;
		var strDt;
		var regExp = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
		
		var now = new Date();
		var year= now.getFullYear();
		var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	    
		if(!regExp.test(str)) {
			if(str.length > 0) {
				if(str.length == 8) {
					var year = str.substring(0,4);
					var month = str.substring(4,6);
					var day = str.substring(6);
					if(month < 1 || month > 12) {
						//$('.errorMsg').show();
						//pormTxt = "월을 잘못입력하셨습니다.";
						//$('.errorMsg').append('<p class="hint_text" style="color:red;" id="error_'+id+'">'+pormTxt+'</p>');
						alert("월을 잘못입력하셨습니다.");
						document.getElementById(id).focus();
						$('#'+id).val(null);
						return false;
					}
					
					if(day < 1 || day > 31) {
						//$('.errorMsg').show();
						//pormTxt = "일을 잘못입력하셨습니다.";
						//$('.errorMsg').append('<p class="hint_text" style="color:red;" id="error_'+id+'">'+pormTxt+'</p>');
						alert("일을 잘못입력하셨습니다.");
						document.getElementById(id).focus();
						$('#'+id).val(null);
						return false;
					}
					
					if((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
						alert(month+"는 31일이 올수 없습니다.");
						document.getElementById(id).focus();
						$('#'+id).val(null);
						return false;
					}
					
					if (month == 2) { // check for february 29th
						var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
						
						if (day > 29 || (day == 29 && ! isleap)) {
							alert("날짜가 잘못되었습니다.");
							document.getElementById(id).focus();
							$('#'+id).val(null);
							return false;
						}
					}
					/*
					if($('.errorMsg').show()) {
						$('.errorMsg').hide();
						$('#error_'+id).remove();
					}
					*/
					strDt = year+"-"+month+"-"+day;
					document.getElementById(id).value = strDt;
					return;
				}
				else {
					alert("날짜를 형식에 맞게 입력하세요 \nex) 2013-01-01 \n* 입력시에는 '-' 빼고 숫자만 입력하세요.");
					document.getElementById(id).focus();
					$('#'+id).val(null);
					return;
				}
			}
		}
		
		if(!$.isEmpty(str)) {
	    	var takeDt = replaceAll(str,"-","");
		    var toDt = year + mon + day;
		    
		    if($.isEmpty($("input[name='largeFacYn']:checked").val())) {
			    if(takeDt > toDt) {
			    	alert("취득일자가 현재일자보다 미래일수 없습니다.");
					document.getElementById(id).focus();
					$('#'+id).val(null);
					return false;
			    }
		    }
	    }
	});	
	
	$("#notFix").on('click', function() {
		if($(this).is(':checked')) $("#fixedAsetNo").attr("class", "inp_none").attr("disabled", true).val(null);
		else $("#fixedAsetNo").attr("class", "").attr("disabled", false).val(null);
	});
	
	$("#notModel").on('click', function() {
		if($(this).is(':checked')) {
			$("#equipManufactureToggle").show();
			$("#modelSearchLayer").hide();
			$("#manufacture").val("");
			$(this).parent().parent().each(function() {
				$(this).find("input").each(function() {
					if($(this).attr("id") != "notModel") $(this).val("");
				});
			});
			$("#branchCdSearch").show();
			/*if(!$.isEmpty($("input[name='largeFacYn']:checked").val())) $("#branchCdSearch").show();
			else $("#branchCdSearch").hide();*/
		}
		else {
			$("#equipManufactureToggle").hide();
			$("#modelSearchLayer").show();
			$("#branchCdSearch").hide();
		}
	});
	
	/*$("#notManufacture").on('click', function() {
		if($(this).is(':checked')) {
			$("#manufactureSearchLayer").hide();
			$("#manufacture").val("");
		}
		else {
			$("#manufactureSearchLayer").show();
		}
	});*/
	
	$("#largeFacYn").on('click', function() {
		var subLen = $("#subjectTable table").length;
		if($(this).is(':checked')) {
			$("#largeFacSearch").show();
			$("#eqcpIdLayer1").show();
			$("#specTable").show();
			$("#specLittleTable").show();
			$("#equipManufactureToggle").hide();
			$("#facInfo").hide();
			$("input[name='notModel']").prop("checked", false);
			//$("#korNm").attr("class", "inp_none").attr("disabled", true);
			$("#takeSdtTd").attr("class", "top_sell brn").attr("colspan" , "3");
			$(".equipCalendar").datepicker("option", "maxDate", "" );
			
			if(subLen > 0) {
				for(var i=0; i < subLen; i++) {
					$("#subjectTable table").find("td").each(function() {
						var id = $(this).attr("id");
						if(!$.isEmpty(id)) {
							var idPrefix = id.substring(0, id.indexOf('_')+1);
							if(idPrefix == "rndWeightTdTxt_") $(this).hide();
							else if(idPrefix == "rndWeightTd_") $(this).hide();
							else if(idPrefix == "rndPrcTdTxt_") $(this).hide();
							else if(idPrefix == "rndPrcTd_") $(this).hide();
						}
					});
				}
			}
		}
		else {
			$("#largeFacSearch").hide();
			$("#eqcpIdLayer1").hide();
			$("#facInfo").show();
			$("#specTable").hide();
			$("#specLittleTable").hide();
			//$("#korNm").attr("class", "").attr("disabled", false).val(null);
			$("#takeSdtTd").attr("class", "top_sell brn").attr("colspan" , "");
			$("#largeFacEquipId").val(null);
			$(".equipCalendar").datepicker("option", "maxDate", "+0d" );
			
			if(subLen > 0) {
				for(var i=0; i < subLen; i++) {
					$("#subjectTable table").find("td").each(function() {
						var id = $(this).attr("id");
						if(!$.isEmpty(id)) {
							var idPrefix = id.substring(0, id.indexOf('_')+1);
							if(idPrefix == "rndWeightTdTxt_") $(this).show();
							else if(idPrefix == "rndWeightTd_") $(this).show();
							else if(idPrefix == "rndPrcTdTxt_") $(this).show();
							else if(idPrefix == "rndPrcTd_") $(this).show();
						}
					});
				}
			}
		}
		//$("#branchCdSearch").hide();
	});
	
	$("#groundPrcYn").on('click', function() {
		if($(this).is(':checked')) $("#reason_0").val("토지가 없음");
		else $("#reason_0").val(null);
	});
	
	$("#buildingPrcYn").on('click', function() {
		if($(this).is(':checked')) $("#reason_1").val("건물이 없음");
		else $("#reason_1").val(null);
	});
	
	$("#takePrcY").on('click', function() {
		if($(this).is(':checked'))  {
			$("#takePrc_2").attr("class", "inp_none").attr("disabled", true).val("0");
			//number_format($('#takePrc_2').val(), specTakeView); 
			$("#specTakeView").hide();
			sumTakePrc();
			if($("#takePrcN").is(':checked')) $("#takePrcN").prop('checked', false);
		}
		else { 
			$("#takePrc_2").attr("class", "").attr("disabled", false);
			$("#specTakeView").text("");
			$("#specTakeView").show();
			
		}
	});
	
	$("#takePrcN").on('click', function() {
		if($(this).is(':checked'))  {
			$("#takePrc_2").attr("class", "inp_none").attr("disabled", true).val("0");
			//number_format($('#takePrc_2').val(), specTakeView); 
			$("#specTakeView").hide();
			sumTakePrc();
			if($("#takePrcY").is(':checked')) $("#takePrcY").prop("checked", false);
		}
		else { 
			$("#takePrc_2").attr("class", "").attr("disabled", false);
			$("#specTakeView").text("");
			$("#specTakeView").show();
		}
	});
	
	$("#equipFacYn").on('click', function() {
		if($(this).is(':checked')) {
			$("#equipTakePrc").val(null); $("#facEquipId_0").val(null); $("#facEquipTotal").text("");
			$("#equipSearchShow").hide();
		}
		else $("#equipSearchShow").show();
	});
	
	$("#equipFacEquipYn").on('click', function() {
		if($(this).is(':checked')) {
			$("#equipFacTakePrc").val(null);
			$("#equipFacSearchShow").hide();
			$("#facEquipFacTotal").hide();
			$("#facEquipId_1").val(null);
		}
		else {
			$("#equipFacSearchShow").show();
			$("#facEquipFacTotal").show();
		}
	});
	
	/*$("#equipFacLittleYn").on('click', function() {
		if($(this).is(':checked')) {
			$("#equipLittleTakePrc").attr("class", "inp_none").attr("disabled", true).val("0");
			$("#equipLittleCnt").attr("class", "inp_none").attr("disabled", true).val("0");
			$("#littleBaseAddShow").hide();
		}
		else {
			$("#equipLittleTakePrc").attr("class", "").attr("disabled", false).val("");
			$("#equipLittleCnt").attr("class", "").attr("disabled", false).val("");
			$("#littleBaseAddShow").show();
		}
	});*/
	
	$(".littleBaseAdd").on('click', function() {
		if($.isEmpty($("#equipLittleCnt").val()) || $("#equipLittleCnt").val() == "0") {
			alert("장비 수를 입력해주세요");
			return false;
		}
		else {
			var trLen = $("#littleBase_name tr").length;
			for(var i = 1; i < trLen; i++) {
				var idx = parseInt(2) + parseInt(i);
				$('.littleBase_' + idx).remove();
			}
		}
		
		var samCnt = $("#equipLittleCnt").val();
		for(var i = 1; i < samCnt; i++) {
			var clone = $("#littleBase_name tr:eq(0)").clone(true);
			var idx = parseInt(2) + parseInt(i);
			clone.removeClass(); 
		
			$(clone).find("input").each(function() {
				if(!$.isEmpty($(this).attr("name"))) {
					var name = $(this).attr("name");
					var prefix = name.substring(0, name.indexOf('[')+1);
					var suffix = name.substring(name.indexOf(']'));
					
					$(this).attr('name', prefix + idx + suffix).val(null);
				}
				
				if(!$.isEmpty($(this).attr("id"))) {
					var id = $(this).attr("id");
					var idPrefix = id.substring(0, id.indexOf('_')+1);
					$(this).attr('id', idPrefix + idx);
					if(idPrefix == "typeCd_") $(this).val("3");
				}
			});
			$(clone).find("span").each(function(i) {
				if(!$.isEmpty($(this).attr("id"))) {
					var id = $(this).attr("id");
					var idPrefix = id.substring(0, id.indexOf('_')+1);
					$(this).attr('id', idPrefix + idx);
					$(this).text(parseInt(idx)-1);
				}
			});
			
			clone.addClass("littleBase_" + idx);
			$("#littleBase_name").append(clone); 
		}
		layerToggle("littleBaseDiv");
	});
	
	$.addLittleBase = function() {
		var lastSubNo = $("#littleBase_name tr").length;
		for(var i = 0; i < lastSubNo; i++) {
			var idx = parseInt(2) + parseInt(i);
			if($.isEmpty($("input[id='fixedAsetNo_"+idx+"']").val())) {
				alert("고정자산번호를 입력하세요");
				$("#littleBaseError").val("1");
				return false;
				
			}
			else if($.isEmpty($("input[id='korNm_"+idx+"']").val())) {
				alert("장비명을 입력하세요");
				$("#littleBaseError").val("1");
				return false;
			}
			else {
				if($.isEmpty($("input[id='takePrcList_"+idx+"']").val())) {
					alert("금액을 입력하세요");
					$("#littleBaseError").val("1");
					return false;
				}
				else {
					$("#littleBaseError").val("0");
				}
			}
			
			if($("#littleBaseError").val() == '0') {
				for(var i = 0; i < lastSubNo; i++) {
					var idx = parseInt(2) + parseInt(i);
					var fixVal = $("input[id='fixedAsetNo_"+idx+"']").val();
					var korVal = $("input[id='korNm_"+idx+"']").val();
					var takeVal = $("input[id='takePrcList_"+idx+"']").val();
					var typeVal = $("input[id='typeCd_"+idx+"']").val();
					$(".littleBaseDiv").append('<input type="hidden" name="equipFacilitesEquipList['+idx+'].fixedAsetNo" id="fixedAsetNo_'+idx+'" value="'+fixVal+'">');
					$(".littleBaseDiv").append('<input type="hidden" name="equipFacilitesEquipList['+idx+'].korNm" id="korNm_'+idx+'" value="'+korVal+'">');
					$(".littleBaseDiv").append('<input type="hidden" name="equipFacilitesEquipList['+idx+'].takePrc" id="takePrcList_'+idx+'" value="'+takeVal+'">');
					$(".littleBaseDiv").append('<input type="hidden" name="equipFacilitesEquipList['+idx+'].typeCd" id="typeCd_'+idx+'" value="'+typeVal+'">');
				}
				layerToggle("littleBaseDiv");
			}
		}
	};
	
	/**  1단계 저장 
	 * 
	 */
	$('.equipStep1Save').on('click', function() {
		
		if($("#equipChange").val() == "03" && $("#notModel").is(":checked")) $.modelDirectSelector();
		
		validStart();
		validFormStart("step1");
		$("input[name='takeCd']").attr("disabled", false);
		var errCnt = $('.errAllMsg').find('p').attr('class', 'hint_text').length;
		if(!$.isEmpty($("input[name='fileData']").val())) {
			var result = null;
			$(".equipImage li").each(function(i) {
				result = false;
				var IMG_FORMAT = "\\.(bmp|gif|jpg|jpeg|png)$";
				if((new RegExp(IMG_FORMAT, "i")).test($("input[id='equipFileList["+i+"].fileData']").val())) result = true;
				else return false;
			});
			if(result == false) {
				alert("장비구축사진은 이미지 파일만 첨부하실 수 있습니다.");
				return false;
			}	
		}
		
		if($("input[name='equipCd']:checked").val() == '03' && $("input[name='registCd']:checked").val() != '1') {
			if($.isEmpty($("#eqcpId").val())) {
				if($("input[name='equipCd']:checked").val() == '01') alert("주장비를 선택해주세요");
				else if($("input[name='equipCd']:checked").val() == '03') alert("주시설을 선택해주세요");
				return false;
			}
		}
		
		if(errCnt > 0) {
			$('#errorMsgLayer').draggable();
			layerToggle("errorMsgLayer");
		}
		else {
			$("input[name='equipCd']").val($("#equipChange").val());
			$("input[name='equipCd']").attr("disabled",false);

			if($("#fixResult").val() == "true") {
				if($("#equipChange").val() != "03") duplicateLayer();
				else {
					var frm = document.equipAddForm;
					$(this).attr('disabled', 'disabled');
					//if(!$.isEmpty($('input[name="largeFacYn"]:checked').val())) $("#korNm").attr("disabled",false);
					frm.submit();
				}
			}
			else {
				alert("이미 등록된 고정자산관리번호 입니다.\n고정자산관리번호를 수정해주세요.");
				return false;
			}
			
		}
	});
	
	/**  연구장비 임시저장
	 * 
	 */
	$('.equipTempSave').on('click', function() {
		if(confirm('임시 저장 하시겠습니까?')) {
			$("#littleBaseDiv input").attr("disabled",true);
			var frm = document.equipAddForm;
			if($("#eqRndYn").val() == 'Y') {
				if($("#acqShow").val() == '0') {
					$("#subjectAcqTable input").attr("disabled",true);
				}
			}
			else if($("#eqRndYn").val() == 'N') {
				$("#subjectTable input").attr("disabled",true);
			}
			$("#subjectTable select").attr("disabled",false);
			frm.action = "/equip/temp/save";
			$(this).attr('disabled', 'disabled');
			$.removeCookie('facEquip');
			$.removeCookie('facEquipSelect');
			if(!$.isEmpty($("#equipChange").val()) && $("#equipChange").val() == '03') saveSumTakePrc();
			frm.submit();
		}
	});
	
	/**  연구장비 임시저장
	 * 
	 */
	$('.equipTemp2Save').on('click', function() {
		var frm = document.equipAddForm;
		$("#littleBaseDiv input").attr("disabled",true);
		var eqRndYn = $("#eqRndYn").val();
		if($("#eqRndYn").val() == 'Y') {
			if($("#acqShow").val() == '0') {
				$("#subjectAcqTable input").attr("disabled",true);
			}
		}
		else if($("#eqRndYn").val() == 'N') {
			$("#subjectTable input").attr("disabled",true);
		}
		$("#subjectTable select").attr("disabled",false);
		frm.action = "/equip/add/step1?rndYn="+eqRndYn;
		$(this).attr('disabled', 'disabled');
		frm.submit();
	});
	
	/**  연구장비저장
	 * 
	 */
	$('.equipStep2Save').on('click', function() {
		
		$("#littleBaseDiv input").attr("disabled",true);
		if(!$.isEmpty($("input[name='registCd']:checked").val())) $("#registCd").val($("input[name='registCd']:checked").val());
		
		validStart();
		validFormStart("step2");
		
		var errCnt = $('.errAllMsg').find('p').attr('class', 'hint_text').length;
		if(errCnt > 0) {
			//$('.errAllMsg').dialog({width:'350',height:'200'});
			$('#errorMsgLayer').draggable();
			layerToggle("errorMsgLayer");
		}
		else {
			var subLen = $("#subjectTable table").length;
			var acqLen = $("#subjectAcqYTable table").length;
			var feature = $("#feature").val();
			var capability = $("#capability").val();
			var example = $("#example").val();
			
			if(confirm('등록 하시겠습니까? \n등록시 임시장비 데이터는 삭제됩니다.')) {
										
				if($("#eqRndYn").val() == 'Y') {
					if($("#acqShow").val() == '0') {
						$("#subjectAcqTable input").attr("disabled",true);
					}
				}
				else if($("#eqRndYn").val() == 'N') {
					$("#subjectTable input").attr("disabled",true);
				}
				
				var weight = 0;
				if(subLen > 0) {
					$("#subjectTable table").each(function(i) {
						$(this).find("input").each(function() {
							var id = $(this).attr("id");
							if(!$.isEmpty(id)) {
								var idPrefix = id.substring(0, id.indexOf('_')+1);
								if(idPrefix == "rndWeight_") {
									var idx = id.substring(id.indexOf('_')+1);
									weight = weight+parseInt($("#rndWeight_"+idx).val());
								}
							}
						});
					});
				}
				
				if(acqLen > 0) {
					$("#subjectAcqYTable table").each(function(i) {
						$(this).find("input").each(function() {
							var id = $(this).attr("id");
							if(!$.isEmpty(id)) {
								var idPrefix = id.substring(0, id.indexOf('_')+1);
								if(idPrefix == "rndWeight_") {
									var idx = id.substring(id.indexOf('_')+1);
									weight = weight+parseInt($("#rndWeight_"+idx).val());
								}
							}
						});
					});
				}
				
				if(weight > 100) {
					alert("현재 과제가중치 합계가 " +weight+"% 입니다.\n"+"과제가중치 의 합이 100%를 넘을수 없습니다.");
					return false;
				}
				
				if(feature == capability || feature == example || capability == example) {
					alert("장비설명, 구성 및 성능, 사용예가 같을수 없습니다. 다시 입력해주세요");
					return false;
				}
				
				//심의정보 입력(rnd == Y and 취득금액 7천만원이상일 경우)
				/*if($('#eqRndYn').val() == 'Y' && $('#takePrcVal').val() > 70000000) {
					if($(':radio[name="redYn"]:checked').val() == null) {
						alert('심의 통과 여부를 선택해주세요');
						return false;
					}
					else if($(':radio[name="redYn"]:checked').val() == 'Y' && $('#rfdEquipNo').val() == '') {
						alert('심의승인번호를 선택해주세요');
						return false;
					}
				}*/
				
				$("#subjectTable select").attr("disabled",false);
				var frm = document.equipAddForm;
				$(this).attr('disabled', 'disabled');
				$.removeCookie('facEquip');
				$.removeCookie('facEquipSelect');
				if(!$.isEmpty($("#equipChange").val()) && $("#equipChange").val() == '03') saveSumTakePrc();
				frm.submit();
			}
		}
	});
});

	/* function  =============================================================*/

/**
 * 주장비검색 선택.
 * 
 */
function bindSelectEqCp(eqCp) {
	
	if(eqCp.selector == 'mequip') {
		$('#mainEquipId').val(eqCp.equipId);
		$('#mainEquipNm').val(eqCp.eqcpNm);
		$('#eqcpId').val(eqCp.equipId);
		
	}
	else if(eqCp.selector == 'mequipMod') {
		$('#mainEquipNm').val(eqCp.eqcpNm);
		$('#newValue_5').val(eqCp.equipId);
	}
	else {
		if(eqCp.equipGubun == "03") {
			if(!$.isEmpty(eqCp.branchCd)) {
				$('#branchCd').val(eqCp.branchCd);
				$('#branchNm').val(eqCp.branchNm);
				$('#branchNm').css('width', '100%');
				$('#branchCdSearch').attr('style', 'display:none');
			}
		}
		$('#eqcpId').val(eqCp.equipId);
		$('#eqcpNm').val(eqCp.equipNo + " (" + eqCp.eqcpNm + ")" );
	}
	$(".ui-dialog-content").dialog("close");
}

function bindSelectEqCp1(eqCp) {
	$('#korNm').val(eqCp.eqcpNm);
	$(".ui-dialog-content").dialog("close");
}

/**
 * 표준분류 선택.
 * 
 */
$.branchSelector = function(params, selector) {	
	if(params.treeId == '#manuTree') {
		$("#directlyBranchNmLayer").val(params.branchNms);
		$("#directlyBranchCdLayer").val(params.branchCd);
		$("#brancSel").dialog("close");
	}
	else {
		$("#branchNm").val(params.branchNms);
		$("#branchCd").val(params.branchCd);
		$(".ui-dialog-content").dialog("close");
		if($("#equipChange").val() != "03") branchChg();
	}
};

/**
 * 기관 선택.
 * 
 */
function bindSelectOrgan(organ) {
	if(organ.selecter == 'Hisorgan') {
		$('#HisorganCd').val(organ.organCd);
		$('#HisorganNm').val(organ.organNm);
	}
	else if(organ.selecter == 'peOrgan') {
		$('#organCd').val(organ.organCd);
		$('#organNm').val(organ.organNm);
	}
	else {
		$('#moveOrganCd'+organ.flag).val(organ.organCd);
		$('#moveOrganNm'+organ.flag).val(organ.organNm);
	}
	$("#modal4").dialog("close");
}

/**
 * 제작사 선택.
 * 
 */
function bindSelectManufacture(manufacture) {
	$('#manufactureCd').val(manufacture.busiCd);
	$('#madeCd').val(manufacture.madeCd);
	$('#manufacture').val(manufacture.manuNm + " / " + manufacture.madeNm);
	$(".ui-dialog-content").dialog("close");
}

/**
 * 제작사/모델 선택.
 * 
 */
function bindSelectModel(model) {
	if(model.selector == 'equipMod') {
		if($.isEmpty($("#reason").val())) {
			alert("제작사/모델 변경 사유를 입력하세요.");
		}
		else {
			$('#newValue_3').val(model.branchCd);
			$('#newValue_9').val(model.modelCd);
			$('#reason_9').val($("#reason").val());
			$('#newValue_10').val(model.busiCd);
			$('#newValue_11').val(model.madeCd);
			$('#newValue_12').val(model.takeCd);
			//if(!$.isEmpty($('#modelChgFile').val())) $('#chgFile_9').push($('#modelChgFile').val()); 
			
			$(".ui-dialog-content").dialog("close");
		}
	}
	else {
		$('#manufactureCd').val(model.busiCd);
		$('#manufactureNm').val(model.busiNm);
		$('#modelCd').val(model.modelCd);
		$('#madeCd').val(model.madeCd);
		$('#manufacture').val(model.manuNm);
		$('#modelNm').val(model.modelNm);
		$('#branchNm').val(model.branchNm);
		$('#branchCd').val(model.branchCd);
		$("input[name='takeCd'][value='"+model.takeCd+"']").prop("checked", true);
		
		if(!$.isEmpty(model.branchCd) && !$.isEmpty(model.branchNm)) {
			$('#branchNm').css('width', '100%');
			$('#branchCdSearch').attr('style', 'display:none');
			$('#branchCheck').val('Y');
		}
		
		if(!$.isEmpty(model.takeCd)) {
			$("input[name='takeCd']").each(function(i) {
				$(this).attr('disabled', 'disabled');
			});
			$('#takeCheck').val('Y');
		}
		if($("#equipChange").val() != "03") branchChg();
		$("#modelCheck").val("N");
		$(".ui-dialog-content").dialog("close");
	}
}



/**
 * 유사장비 선택(모델 검색).
 * 
 */
function bindSelectEquipNm(equip) {
	$("#equipIdNm").val(equip.equipId);
	$.equipNmChg();
	$(".ui-dialog-content").dialog("close");
}

/**
 * 유사장비 선택(표준분류 검색).
 * 
 */
function bindSelectEquipBranch(equip) {
	$("#equipIdNm").val(equip.equipId);
	$.equipNmChg();
	$(".ui-dialog-content").dialog("close");
}


/**
 * 구축금액(국산, 외산, 합계).
 * 
 */
function takePrcSumRatio() {
	foreign = $("#takePrcForeign").val();
	foreign = foreign.split(',').join('');
	domestic = $("#takePrcDomestic").val();
	domestic = domestic.split(',').join('');
	takePrcVal = $("#takePrc").val();
	
	if(foreign == null || foreign == "") {
		$("#takePrcForeign").val("0");
	}
		
	if(domestic == null || domestic == "") {
		$("#takePrcDomestic").val("0");
	}	
	
	takePrcSum = parseInt(foreign)+parseInt(domestic);
	
	takePrcForeignRatioVal = foreign / takePrcSum * 100;
	takePrcForeignRatioVal = takePrcForeignRatioVal.toFixed(2);
	takePrcDomesticRatioVal = domestic / takePrcSum * 100;
	takePrcDomesticRatioVal = takePrcDomesticRatioVal.toFixed(2);
	
	takePrcForeignRatio.innerHTML = '['+takePrcForeignRatioVal+'] %';
	takePrcDomesticRatio.innerHTML = '['+takePrcDomesticRatioVal+'] %';
	
	if(foreign != "" && domestic != "") {
		$("#takePrc").val(takePrcSum);
	}
}

/**
 * 금액 한글로 표시 
 * 
 */
function number_format(chknum, spanId) {
	num = chknum;
	num = num.split(',').join('');
	var arr = num.split('.');
	var num = new Array();
	
	for (var i = 0; i <= arr[0].length-1; i++) {
		num[i] = arr[0].substr(arr[0].length-1-i,1);
		if(i%3 == 0 && i != 0) num[i]+= ',';
	}
	num = num.reverse().join('');
	
	if (!arr[1]) chknum = num; 
	else chknum.value = num+'.'+arr[1];
	if(spanId) num2won(chknum, spanId);
}

/**
 * 금액 한글로 표시 
 * 
 */
function num2won(chknum, spanId) {
	val = chknum;
	var won = new Array();
	re = /^[1-9][0-9]*$/;
	num = val.toString().split(',').join('');
	
	if (!re.test(num)) {
		//chknum.value = '';
		//spanId.innerHTML = '';
	} 
	else {
		var price_unit0 = new Array('','일','이','삼','사','오','육','칠','팔','구');
		var price_unit1 = new Array('','십','백','천');
		var price_unit2 = new Array('','만','억','조','경','해','시','양','구','간','정');
		
		for(var i = num.length-1; i >= 0; i--) {
			won[i] = price_unit0[num.substr(num.length-1-i,1)];
			if(i > 0 && won[i] != '') won[i] += price_unit1[i%4];
			if(i % 4 == 0) won[i] += price_unit2[(i/4)];
		}
		
		for(var i = num.length-1; i >= 0; i--) {
			if(won[i].length == 2) won[i-i%4] += '-';
			if(won[i].length == 1 && i > 0) won[i] = '';
			if(i%4 != 0) won[i] = won[i].replace('일','');
		}
		
		won = won.reverse().join('').replace(/-+/g,'');
		spanId.innerHTML = '['+won+'] 원';
	}
}

/**
 * 표준분류에 따른 설정
 * 
 */
function branchChg() {
	var takeVal = null;
	if(!$.isEmpty($('#branchCd').val())) {
		var branchVal = $('#branchCd').val().substring(0,1);
		if(branchVal == "H") {
			$("#equipChange").val("03");
			takeVal = '03';
		}
		else {
			if($.isEmpty($("input[name='takeCd']:checked").val())) {
				$("#equipChange").val("01");
				takeVal = '1';
			} 
			else { 
				if($("input[name='takeCd']:checked").val() == '1') {
					$("#equipChange").val("01");
					takeVal = '1';
				}
				else if($("input[name='takeCd']:checked").val() == '2') {
					$("#equipChange").val("02");
					takeVal = '2';
				}
			}
		}
	}
	$.takeChg(takeVal);
}


/**
 * 과제가중치 자동입력 (사용금액 - 취득금액)
 * 
 */
function rndWeightDivison(id, val) {
	var idx = id.replace("rndPrc_","");
	var divVal = null;
	var takePrcVal = $('#takePrcVal').val();
	
	if($('#equipModDev').val() == 'Y') {
		if(!$.isEmpty(val) && !$.isEmpty($('input[name=takePrc]').val())) {
			var value = val.replace(/,/g,"");
			var takePrc = $('input[name=takePrc]').val().replace(/,/g,"");
			divVal = parseInt((value / takePrc) * 100);
		}
	}
	else {
		if(!$.isEmpty(val) && !$.isEmpty(takePrcVal)) {
			var value = val.replace(/,/g,"");
			divVal = parseInt((value / takePrcVal) * 100);
		}
	}
	
	if(divVal > 100) {
		alert("가중치가 100%를 넘을수 없습니다.");
		$('#rndPrc_'+idx).val("");
		$('#rndWeight_'+idx).val("");
		$('#rndPrc_'+idx).focus();
		return false;
	}
	else {
		$('#rndWeight_'+idx).val(divVal);
	}
}

function delRnd(idx) {
	$("#subjectAcqItem"+idx).remove();
	var trNum = $("#subjectAcqYTable table").length;
	$('#acqShow').val(trNum);
}

function delRndYMod(idx) {
	$("#subjectItem"+idx).remove();
}

function delImage(fileSeq, idx) {
	$(".fileDnm"+ idx).remove();
	var delFileSeq = null;
	if(!$.isEmpty($("#delFileSeqs").val())) {
		delFileSeq = $("#delFileSeqs").val() + "," + fileSeq;
		$("#delFileSeqs").val(delFileSeq);
	}
	else {
		$("#delFileSeqs").val(fileSeq);
	}
}

function replaceAll(str,orgStr,repStr) {
    return str.split(orgStr).join(repStr);
}

function duplicateLayer() {
	$.ajax({
		url: '/equip/duplicateSuspected/jsonList?modelNm='+ encodeURIComponent($("#modelNm").val())+'&takeDt='+ $("#takeDt").val() + '&takePrc='+ $("#takePrc").val(),
		success: function(data) {
			if(data.length > 0) {
				$("#duplicateValue").html("");
				$(data).each(function(i, duplicateList) {
					var num = i + 1;
					$("#duplicateValue").append('<tr>'
										+'<td class="bln">'+num+'</td>'
										+'<td class="tl"><img src="'+duplicateList.filePath+'"></td>'
										+'<td class="tl">'+ duplicateList.fixedAsetNo + '</td>'
										+'<td class="tl">'+ duplicateList.modelNm + '</td>'
										+'<td class="tl"><a href="/search/equip/read/'+duplicateList.equipId+'" target="_blank">'+ duplicateList.korNm + '</a></td>'
										+'<td>'+ duplicateList.takeDtS +'</td>'
										+'<td class="tr brn">'+ addThousandSeparatorCommas(duplicateList.takePrc) + '</td>'
										+ '</tr>');
				});
				$("#secondText").text("· 중복장비로 의심되는 장비가 " + data.length + "점 검색되었습니다.");
				$('#duplicateLayer').draggable();
				layerToggle("duplicateLayer");
			}
			else {
				$(".ui-dialog-content").dialog("close");
				equipStep1Save();
			}
		},
		error:function(xhr, status, error) {
			alert(xhr + "||" + status + "||" + error);
		}
	});
}

/**
 * 과제정보 선택.
 * 
 */
function bindSelectSubject(pjt) {
	if(pjt.selector == "facEquip") {
		removeLayer(pjt.flag);
		if(!$.isEmpty(pjt.subjectOcd)) {
			var sixCdVal = null;
			var secretPjtYn = null;
			if(!$.isEmpty(pjt.sixTechnology)) {
				var sixTechnology = pjt.sixTechnology.substring(0,2);
				
				if (sixTechnology == "01") {
					sixCdVal = '0IT';
				}
				else if(sixTechnology == "02") {
					sixCdVal = '0BT';
				}
				else if(sixTechnology == "03") {
					sixCdVal = '0NT';
				}
				else if(sixTechnology == "04") {
					sixCdVal = '0ST';
				}
				else if(sixTechnology == "05") {
					sixCdVal = '0ET';
				}
				else if(sixTechnology == "06") {
					sixCdVal = '0CT';
				}
				else if(sixTechnology == "07") {
					sixCdVal = '0TC';
				}
			}
			else sixCdVal = '0TC';
				
			
			if(!$.isEmpty(pjt.secretPjtYn)) {
				if(pjt.secretPjtYn == "2") secretPjtYn = "Y";
				else if(pjt.secretPjtYn == "1") secretPjtYn = "N";
			}
			
			$('#subjectOcd_'+pjt.flag).val(pjt.subjectOcd);
			$('#officeCd_'+pjt.flag).val(pjt.officeCd);
			$('#directorNm_'+pjt.flag).val(pjt.directorNm);
			$('#officeNm_'+pjt.flag).val(pjt.officeNm);
			$('#organNm_'+pjt.flag).val(pjt.organNm);
			$('#subjectPcd_'+pjt.flag).val(pjt.subjectPcd);
			$('#busiCd_'+pjt.flag).val(pjt.busiCd);
			$('#busiNm_'+pjt.flag).val(pjt.busiNm);
			$('#subjectNm_'+pjt.flag).val(pjt.subjectNm);
			$('#sixCd_'+pjt.flag).val(sixCdVal);
			$('#sixCdSub_'+pjt.flag).val(pjt.sixTechnology);
			$('#startDt_'+pjt.flag).val(pjt.startDt);
			$('#endDt_'+pjt.flag).val(pjt.endDt);
			$('#porganNm_'+pjt.flag).val(pjt.porganNm);
			$('#subOrganNm_'+pjt.flag).val(pjt.subOrganNm);
			$('#selInpYn_'+pjt.flag).val(pjt.selInpYn);
			$('#rndYn_'+pjt.flag).val(pjt.rndYn);
			$('#scienceCdOld_'+pjt.flag).val(pjt.scienceCdOld);
			$('#scienceLtype1Cd_'+pjt.flag).val(pjt.scienceLtypeCdNew1);
			$('#scienceMtype1Cd_'+pjt.flag).val(pjt.scienceMtypeCdNew1);
			$('#scienceStype1Cd_'+pjt.flag).val(pjt.scienceStypeCdNew1);
			$('#scienceLtype2Cd_'+pjt.flag).val(pjt.scienceLtypeCdNew2);
			$('#scienceMtype2Cd_'+pjt.flag).val(pjt.scienceMtypeCdNew2);
			$('#scienceStype2Cd_'+pjt.flag).val(pjt.scienceStypeCdNew2);
			$('#scienceLtype3Cd_'+pjt.flag).val(pjt.scienceLtypeCdNew3);
			$('#scienceMtype3Cd_'+pjt.flag).val(pjt.scienceMtypeCdNew3);
			$('#scienceStype3Cd_'+pjt.flag).val(pjt.scienceStypeCdNew3);
			$('#pjtYear_'+pjt.flag).val(pjt.pjtYear);
			$('#secretPjtYn_'+pjt.flag).val(secretPjtYn);
			$('#subOrganCd_'+pjt.flag).val(pjt.subOrganCd);
			$('#totalStartDt_'+pjt.flag).val(pjt.totalStartDt);
			$('#totalEndDt_'+pjt.flag).val(pjt.totalEndDt);
			$('#porganCd_'+pjt.flag).val(pjt.porganCd);
			$('#goal_'+pjt.flag).val(pjt.goal);
			$('#goalSummary_'+pjt.flag).val(pjt.goalSummary);
			$('#abstractFull_'+pjt.flag).val(pjt.abstractFull);
			$('#abstractSummary_'+pjt.flag).val(pjt.abstractSummary);
			$('#effect_'+pjt.flag).val(pjt.effect);
			$('#effectSummary_'+pjt.flag).val(pjt.effectSummary);
			$('#performOrganCd_'+pjt.flag).val(pjt.performOrganCd);
			$('#devStepCd_'+pjt.flag).val(pjt.devStepCd);
			$('#pjtGovFund_'+pjt.flag).val(pjt.pjtGovFund);
			$('#pjtTotalFund_'+pjt.flag).val(pjt.pjtTotalFund);
			$('#subjectEngNm_'+pjt.flag).val(pjt.subjectEngNm);
			$('#directorRschNo_'+pjt.flag).val(pjt.directorRschNo);
			$('#researchers_'+pjt.flag).val(pjt.researchers);
			$('#researchersNo_'+pjt.flag).val(pjt.researchersNo);
			$('#keywordKor_'+pjt.flag).val(pjt.keywordKor);
			$('#keywordEng_'+pjt.flag).val(pjt.keywordEng);
			
			$("#selectSubjectTd_"+pjt.flag).append(pjt.subjectOcd);
			$("#subjectWeight_"+pjt.flag).show();
			var rndWeVal = null;
			if(pjt.flag == 0) rndWeVal = 100;
			$("#rndWeight_"+pjt.flag).val(rndWeVal);
		}
		else {
			if($.isEmpty(pjt.officeCd)) {
				alert("과제수행부처 청을 선택해주세요.");
				$('#officeCd').focus();
				return false;
			}
			else if($.isEmpty(pjt.subjectNm)) {
				alert("세부과제명을 입력해주세요.");
				$('#subjectNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.organNm)) {
				alert("주관기관을 입력해주세요.");
				$('#organNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.directorNm)) {
				alert("연구책임자를 입력해주세요.");
				$('#directorNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.startDt)) {
				alert("당해년도 과제수행 시작 일자를 입력해주세요.");
				$('#startDt').focus();
				return false;
			}
			else if($.isEmpty(pjt.endDt)) {
				alert("당해년도 과제수행 종료 일자를 입력해주세요.");
				$('#endDt').focus();
				return false;
			}
			else if($.isEmpty(pjt.sixCd)) {
				alert("6T분류를 선택해주세요");
				$('#sixCd').focus();
				return false;
			}
			else if($.isEmpty(pjt.busiNm)) {
				alert("세부사업명을 입력해주세요");
				$('#busiNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.porganNm)) {
				alert("전문기관을 입력해주세요");
				$('#porganNm').focus();
				return false;
			}
			else if(!$.isEmpty(pjt.startDt) && !$.isEmpty(pjt.endDt)) {
				var start = replaceAll(pjt.startDt,"-","");
				var end = replaceAll(pjt.endDt,"-","");
				if(start > end) {
					alert("당해년도 과제수행 종료일자가 당해년도 과제수행 시작일보다 과거일수 없습니다.");
					return false;
				}
			}
			
			$('#subjectOcd_'+pjt.flag).val(null);
			$('#officeCd_'+pjt.flag).val(pjt.officeCd);
			$('#subjectNm_'+pjt.flag).val(pjt.subjectNm);
			$('#busiNm_'+pjt.flag).val(pjt.busiNm);
			$('#organNm_'+pjt.flag).val(pjt.organNm);
			$('#directorNm_'+pjt.flag).val(pjt.directorNm);
			$('#startDt_'+pjt.flag).val(pjt.startDt);
			$('#endDt_'+pjt.flag).val(pjt.endDt);
			$('#porganNm_'+pjt.flag).val(pjt.porganNm);
			$('#subjectPcd_'+pjt.flag).val(pjt.subjectPcd);
			$('#sixCdSub_'+pjt.flag).val(pjt.sixCdSub);
			$('#sixCd_'+pjt.flag).val(pjt.sixCd);
			$('#selInpYn_'+pjt.flag).val(pjt.selInpYn);
			$('#rndYn_'+pjt.flag).val(pjt.rndYn);
			
			$("#selectSubjectTd_"+pjt.flag).append(pjt.subjectNm);
			$("#subjectWeight_"+pjt.flag).show();
			var rndWeVal = null;
			if(pjt.flag == 0) rndWeVal = 100;
			$("#rndWeight_"+pjt.flag).val(rndWeVal);
		}
		
		$("#subjectSubjectNm_"+pjt.flag).append("세부과제명 : "+ pjt.subjectNm);
		$("#subjectStart_"+pjt.flag).append("당해년도수행기간 : "+ pjt.startDt+" ~ "+pjt.endDt+"");
		if(!$.isEmpty(pjt.subjectOcd)) $("#subjectOffice_"+pjt.flag).append("과제수행부처·청 : "+ pjt.officeNm+"");
		$("#subjectBusi_"+pjt.flag).append("세부사업명 : "+ pjt.busiNm+"");
		$("#subjectOrgan_"+pjt.flag).append("주관기관 : "+ pjt.organNm+"");
		$("#subjectDirector_"+pjt.flag).append("연구책임자 : "+ pjt.directorNm+"");
		$("#subjectPorgan_"+pjt.flag).append("전문기관 : "+ pjt.porganNm+"");
		$("#help_"+pjt.flag).show();
	}
	else {
		if(!$.isEmpty(pjt.subjectOcd)) {
			var sixCdVal = null;
			var secretPjtYn = null;
			if(!$.isEmpty(pjt.sixTechnology)) {
				var sixTechnology = pjt.sixTechnology.substring(0,2);
				
				if (sixTechnology == "01") {
					sixCdVal = '0IT';
				}
				else if(sixTechnology == "02") {
					sixCdVal = '0BT';
				}
				else if(sixTechnology == "03") {
					sixCdVal = '0NT';
				}
				else if(sixTechnology == "04") {
					sixCdVal = '0ST';
				}
				else if(sixTechnology == "05") {
					sixCdVal = '0ET';
				}
				else if(sixTechnology == "06") {
					sixCdVal = '0CT';
				}
				else if(sixTechnology == "07") {
					sixCdVal = '0TC';
				}
			}
			else sixCdVal = '0TC';
			
			if(!$.isEmpty(pjt.secretPjtYn)) {
				if(pjt.secretPjtYn == "2") secretPjtYn = "Y";
				else if(pjt.secretPjtYn == "1") secretPjtYn = "N";
			}
			
			$('#subjectOcd_'+pjt.flag).val(pjt.subjectOcd);
			$('#officeCd_'+pjt.flag).val(pjt.officeCd);
			$('#directorNm_'+pjt.flag).val(pjt.directorNm);
			$('#officeNm_'+pjt.flag).val(pjt.officeNm);
			$('#organNm_'+pjt.flag).val(pjt.organNm);
			$('#subjectPcd_'+pjt.flag).val(pjt.subjectPcd);
			$('#busiCd_'+pjt.flag).val(pjt.busiCd);
			$('#busiNm_'+pjt.flag).val(pjt.busiNm);
			$('#subjectNm_'+pjt.flag).val(pjt.subjectNm);
			$('#sixCd_'+pjt.flag).val(sixCdVal);
			$('#sixCdSub_'+pjt.flag).val(pjt.sixTechnology);
			$('#startDt_'+pjt.flag).val(pjt.startDt);
			$('#endDt_'+pjt.flag).val(pjt.endDt);
			$('#porganNm_'+pjt.flag).val(pjt.porganNm);
			$('#subOrganNm_'+pjt.flag).val(pjt.subOrganNm);
			$('#selInpYn_'+pjt.flag).val(pjt.selInpYn);
			$('#rndYn_'+pjt.flag).val(pjt.rndYn);
			$('#scienceCdOld_'+pjt.flag).val(pjt.scienceCdOld);
			$('#scienceLtype1Cd_'+pjt.flag).val(pjt.scienceLtypeCdNew1);
			$('#scienceMtype1Cd_'+pjt.flag).val(pjt.scienceMtypeCdNew1);
			$('#scienceStype1Cd_'+pjt.flag).val(pjt.scienceStypeCdNew1);
			$('#scienceLtype2Cd_'+pjt.flag).val(pjt.scienceLtypeCdNew2);
			$('#scienceMtype2Cd_'+pjt.flag).val(pjt.scienceMtypeCdNew2);
			$('#scienceStype2Cd_'+pjt.flag).val(pjt.scienceStypeCdNew2);
			$('#scienceLtype3Cd_'+pjt.flag).val(pjt.scienceLtypeCdNew3);
			$('#scienceMtype3Cd_'+pjt.flag).val(pjt.scienceMtypeCdNew3);
			$('#scienceStype3Cd_'+pjt.flag).val(pjt.scienceStypeCdNew3);
			$('#pjtYear_'+pjt.flag).val(pjt.pjtYear);
			$('#secretPjtYn_'+pjt.flag).val(secretPjtYn);
			$('#subOrganCd_'+pjt.flag).val(pjt.subOrganCd);
			$('#totalStartDt_'+pjt.flag).val(pjt.totalStartDt);
			$('#totalEndDt_'+pjt.flag).val(pjt.totalEndDt);
			$('#porganCd_'+pjt.flag).val(pjt.porganCd);
			$('#goal_'+pjt.flag).val(pjt.goal);
			$('#goalSummary_'+pjt.flag).val(pjt.goalSummary);
			$('#abstractFull_'+pjt.flag).val(pjt.abstractFull);
			$('#abstractSummary_'+pjt.flag).val(pjt.abstractSummary);
			$('#effect_'+pjt.flag).val(pjt.effect);
			$('#effectSummary_'+pjt.flag).val(pjt.effectSummary);
			$('#performOrganCd_'+pjt.flag).val(pjt.performOrganCd);
			$('#devStepCd_'+pjt.flag).val(pjt.devStepCd);
			$('#pjtGovFund_'+pjt.flag).val(pjt.pjtGovFund);
			$('#pjtTotalFund_'+pjt.flag).val(pjt.pjtTotalFund);
			$('#subjectEngNm_'+pjt.flag).val(pjt.subjectEngNm);
			$('#directorRschNo_'+pjt.flag).val(pjt.directorRschNo);
			$('#researchers_'+pjt.flag).val(pjt.researchers);
			$('#researchersNo_'+pjt.flag).val(pjt.researchersNo);
			$('#keywordKor_'+pjt.flag).val(pjt.keywordKor);
			$('#keywordEng_'+pjt.flag).val(pjt.keywordEng);
			
			if($('#subjectOcd_'+pjt.flag).is(':hidden')) {
				
				$('#subjectTlt_'+pjt.flag).text("과제번호 :");
				$('#subjectOcd_'+pjt.flag).show();
				$('#subjectNmSpan_'+pjt.flag).text("세부과제명 :");
				$('#subjectNm_'+pjt.flag).show();
				
				$('#subjectTxt_'+pjt.flag).hide();
				$('#busiNmTxt_'+pjt.flag).hide();
			}
		}
		else {
			if($.isEmpty(pjt.officeCd)) {
				alert("과제수행부처 청을 선택해주세요.");
				$('#officeCd').focus();
				return false;
			}
			else if($.isEmpty(pjt.subjectNm)) {
				alert("세부과제명을 입력해주세요.");
				$('#subjectNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.organNm)) {
				alert("주관기관을 입력해주세요.");
				$('#organNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.directorNm)) {
				alert("연구책임자를 입력해주세요.");
				$('#directorNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.startDt)) {
				alert("당해년도 과제수행 시작 일자를 입력해주세요.");
				$('#startDt').focus();
				return false;
			}
			else if($.isEmpty(pjt.endDt)) {
				alert("당해년도 과제수행 종료 일자를 입력해주세요.");
				$('#endDt').focus();
				return false;
			}
			else if($.isEmpty(pjt.sixCd)) {
				alert("6T분류를 선택해주세요");
				$('#sixCd').focus();
				return false;
			}
			else if($.isEmpty(pjt.busiNm)) {
				alert("세부사업명을 입력해주세요");
				$('#busiNm').focus();
				return false;
			}
			else if($.isEmpty(pjt.porganNm)) {
				alert("전문기관을 입력해주세요");
				$('#porganNm').focus();
				return false;
			}
			else if(!$.isEmpty(pjt.startDt) && !$.isEmpty(pjt.endDt)) {
				var start = replaceAll(pjt.startDt,"-","");
				var end = replaceAll(pjt.endDt,"-","");
				if(start > end) {
					alert("당해년도 과제수행 종료일자가 당해년도 과제수행 시작일보다 과거일수 없습니다.");
					return false;
				}
			}
			
			$('#subjectOcd_'+pjt.flag).val(null);
			$('#officeCd_'+pjt.flag).val(pjt.officeCd);
			$('#subjectNm_'+pjt.flag).val(pjt.subjectNm);
			$('#busiNm_'+pjt.flag).val(pjt.busiNm);
			$('#organNm_'+pjt.flag).val(pjt.organNm);
			$('#directorNm_'+pjt.flag).val(pjt.directorNm);
			$('#startDt_'+pjt.flag).val(pjt.startDt);
			$('#endDt_'+pjt.flag).val(pjt.endDt);
			$('#porganNm_'+pjt.flag).val(pjt.porganNm);
			$('#subjectPcd_'+pjt.flag).val(pjt.subjectPcd);
			$('#sixCdSub_'+pjt.flag).val(pjt.sixCdSub);
			$('#sixCd_'+pjt.flag).val(pjt.sixCd);
			$('#selInpYn_'+pjt.flag).val(pjt.selInpYn);
			$('#rndYn_'+pjt.flag).val(pjt.rndYn);
			$('#subjectTlt_'+pjt.flag).text("세부과제명 :");
			$('#subjectTxt_'+pjt.flag).val(pjt.subjectNm).show();
			$('#apiNtisProjectSearchPopup_'+pjt.flag).attr("href", "/com/pjt/search/layer?selector=ntisSubeqMod&selYn=N&flag="+pjt.flag).find("span").text("수정");
			$('#subjectOcd_'+pjt.flag).hide();
			$('#subjectNmSpan_'+pjt.flag).text("세부사업명 :");
			$('#busiNmTxt_'+pjt.flag).val(pjt.busiNm).show();
			$('#subjectNm_'+pjt.flag).hide();
		}
	}
	$(".ui-dialog-content").dialog("close");
}

// 대형연구시설 선택 
function bindSelectLargeFac(largeFac, selector) {
	if(selector == 'modSelect') {
		$.ajax({
			url : '/equip/largeFac/read?equipId='+ largeFac.largeFacEquipId,
			success:function(data) {
				$(data).each(function(i, list) {
					if(list.equipFacilitesList.length > 0) {
						$(list.equipFacilitesList).each(function(j, facList) {
							$("#takePrc_" + j).val(facList.takePrc);
							$("#area_" + j).val(facList.area);
							if(j == '1') {
								$("#floorUp_" + j).val(facList.floorUp);
								$("#floorDown_" + j).val(facList.floorDown);
							}
							else if(j == '2') {
								if(!$.isEmpty(facList.takePrcYn)) $("input[name='equipFacilitesList[2].takePrcYn'][value='"+facList.takePrcYn+"']").prop("checked", true);
								else {
									$("input[name='equipFacilitesList[2].takePrcYn']").prop("checked", false);
									$("#takePrc_" + j).attr("class", "").attr("disabled", false);
								}
							}
						});
					}
					if(list.equipFacilitesEquipList.length > 0) {
						$(list.equipFacilitesEquipList).each(function(k, facEquipList) {
							if(k == '0') {
								$("#facEquipId_" + k).val(facEquipList.equipIdsList);
							}
						});
					}
					if(!$.isEmpty(list.equipTakePrc)) {
						$("input[name='equipFacYn']").prop("checked", false);
						$("#equipSearchShow").show();
					}
					$("#equipTakePrc").val(list.equipTakePrc);
				});
			}
		});
		
		if(!$.isEmpty($('#takePrc_0').val())) reasonChk('1'); number_format($('#takePrc_0').val(), gorundTakeView); 
		if(!$.isEmpty($('#takePrc_1').val())) reasonChk('2'); number_format($('#takePrc_1').val(), buildingTakeView);
		if(!$.isEmpty($('#takePrc_2').val())) number_format($('#takePrc_2').val(), specTakeView);
		sumTakePrc();
		if(!$.isEmpty($('#takePrc').val())) number_format($('#takePrc').val(), takePrcTotalView);
	}
	
	$("#largeFacEquipId").val(largeFac.largeFacEquipId);	
	
	$("#korNm").val(largeFac.korNm);
	if(!$.isEmpty(largeFac.fixedAsetNo) && largeFac.fixedAsetNo == '고정자산관리번호 없음') {
		 $("#fixedAsetNo").attr("class", "inp_none").attr("disabled", true).val(null);
		 $("input[name='notFix']").prop("checked", true);
	}
	else $("#fixedAsetNo").val(largeFac.fixedAsetNo);
	$(".ui-dialog-content").dialog("close");
}

function equipStep1Save() {
	if(confirm('2단계로 이동하시겠습니까?')) {
		var frm = document.equipAddForm;
		$(this).attr('disabled', 'disabled');
		frm.submit();
	}
}

function equipStep1Cancle() {
	if(confirm('등록을 취소하시겠습니까?')) {
		layerToggle('duplicateLayer');
		//location.href = "http://nfecdev.ntis.go.kr/organ/equip";
	}
}

function layerToggle(id) {
	/*$("#" + id).css("position","absolute");
	$("#" + id).css("top", "800px");
	$("#" + id).css("left", "300px");*/
	$("#" + id).toggle();
	
	/*$("#" + id).css("position","absolute");
	$("#" + id).css("top", Math.max(0, (($(window).height() - $("#" + id).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	$("#" + id).css("left", Math.max(0, (($(window).width() - $("#" + id).outerWidth()) / 2) + $(window).scrollLeft()) + "px");*/
	
	$("#" + id).css({
        'position': 'absolute',
        'left': Math.max(0, ((($(window).width() / 2) - ($(this).outerWidth() / 2))) + 
                $(window).scrollLeft()) + "px",
        'top': Math.max(0, ((($(window).height() / 2) - ($(this).outerHeight()) / 2)) + 
                $(window).scrollTop()) + "px"
    });
}

function layerToggleMod(id) {
	/*$("#" + id).css("position","absolute");
	$("#" + id).css("top", "800px");
	$("#" + id).css("left", "300px");*/
	$("#" + id).toggle();
	
	/*$("#" + id).css("position","absolute");
	$("#" + id).css("top", Math.max(0, (($(window).height() - $("#" + id).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	$("#" + id).css("left", Math.max(0, (($(window).width() - $("#" + id).outerWidth()) / 2) + $(window).scrollLeft()) + "px");*/
	
	$("#" + id).css({
        'position': 'absolute',
        'left': Math.max(0, ((($(window).width() / 2) - ($(this).outerWidth() / 2))) + 
                $(window).scrollLeft()) + "px",
        'top': Math.max(0, ((($(window).height() / 2) - ($(this).outerHeight()) / 2)) + 
                $(window).scrollTop()) + "px"
    });
	
	$("#" + id).draggable();
}

function addThousandSeparatorCommas(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function removeLayer(flag) {
	$("#selectSubjectTd_"+flag).text("");
	$("#subjectStart_"+flag).text("");
	$("#subjectOffice_"+flag).text("");
	$("#subjectBusi_"+flag).text("");
	$("#subjectOrgan_"+flag).text("");
	$("#subjectDirector_"+flag).text("");
	$("#subjectPorgan_"+flag).text("");
}

function sumLandTake() {
	var landSum = 0;
	var landTake = 0;
	
	if($("input[name='rndYnCheck']:checked").val() == 'Y' || $("#eqRndYn").val() == 'Y') {
		$("#subjectAcqTable input").attr("disabled",true);
		$("#subjectTable table").each(function (i) {
			if(!$.isEmpty($("input[name='equipRndList["+i+"].landPrc']").val())) landTake = $("input[name='equipRndList["+i+"].landPrc']").val().replace(/,/g, '');
			else landTake = 0;
			landSum += parseInt(landTake);
		});
		
		if($("#subjectAcqYTable table").length > 0) {
			var idx = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			$("#subjectAcqYTable table").each(function (i) {
				if(!$.isEmpty($("#landTake_" + idx).val())) landTake = $("#landTake_" + idx).val().replace(/,/g, '');
				else landTake = 0;
				landSum += parseInt(landTake);
			});
		}
		else $("#subjectAcqYTable input").attr("disabled",true);
	}
	else if($("input[name='rndYnCheck']:checked").val() == 'N' || $("#eqRndYn").val() == 'N') {
		$("#subjectTable input").attr("disabled",true);
		$("#subjectAcqYTable input").attr("disabled",true);
		$("#subjectAcqTable table").each(function (i) {
			if(!$.isEmpty($("#landTakeRndN_" + i).val())) landTake = $("#landTakeRndN_" + i).val().replace(/,/g, '');
			else landTake = 0;
			landSum += parseInt(landTake);
		});
	}
	
	if(!$.isEmpty(landSum) && landSum > 0) {
		$("#landReason").hide();
		$("#reason_0").val("");
	}
	else $("#landReason").show();
	$("input[name='equipFacilitesList[0].takePrc']").val(landSum);
}

function sumbuildingTake() {
	var buildingSum = 0;
	var buildingTake =  0;
	
	if($("input[name='rndYnCheck']:checked").val() == 'Y' || $("#eqRndYn").val() == 'Y') {
		$("#subjectAcqTable input").attr("disabled",true);
		$("#subjectTable table").each(function (i) {
			if(!$.isEmpty($("#buildingTake_" + i).val())) buildingTake = $("#buildingTake_" + i).val().replace(/,/g, '');
			else buildingTake = 0;
			buildingSum += parseInt(buildingTake);
		});
		if($("#subjectAcqYTable table").length > 0) {
			var idx = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			$("#subjectAcqYTable table").each(function (i) {
				if(!$.isEmpty($("#buildingTake_" + idx).val())) buildingTake = $("#buildingTake_" + idx).val().replace(/,/g, '');
				else buildingTake = 0;
				buildingSum += parseInt(buildingTake);
			});
		}
		else $("#subjectAcqYTable input").attr("disabled",true);
	}
	else if($("input[name='rndYnCheck']:checked").val() == 'N' || $("#eqRndYn").val() == 'N') {
		$("#subjectTable input").attr("disabled",true);
		$("#subjectAcqYTable input").attr("disabled",true);
		$("#subjectAcqTable table").each(function (i) {
			if(!$.isEmpty($("#buildingTakeRndN_" + i).val())) buildingTake = $("#buildingTakeRndN_" + i).val().replace(/,/g, '');
			else buildingTake = 0;
			buildingSum += parseInt(buildingTake);
		});
	}
	
	if(!$.isEmpty(buildingSum) && buildingSum > 0) {
		$("#buildingReason").hide();
		$("#reason_1").val("");
	}
	else $("#buildingReason").show();
	$("input[name='equipFacilitesList[1].takePrc']").val(buildingSum);
}

function sumspecFacTake() {
	var specFacSum = 0;
	var specFacTake = 0;
	
	if($("input[name='rndYnCheck']:checked").val() == 'Y' || $("#eqRndYn").val() == 'Y') {
		$("#subjectAcqTable input").attr("disabled",true);
		$("#subjectTable table").each(function (i) {
			if(!$.isEmpty($("#specFacTake_" + i).val())) specFacTake = $("#specFacTake_" + i).val().replace(/,/g, '');
			else specFacTake = 0;
			specFacSum += parseInt(specFacTake);
		});
		if($("#subjectAcqYTable table").length > 0) {
			var idx = $("#subjectAcqYTable table:last").attr("id").replace("subjectAcqItem", "");
			$("#subjectAcqYTable table").each(function (i) {
				if(!$.isEmpty($("#specFacTake_" + idx).val())) specFacTake = $("#specFacTake_" + idx).val().replace(/,/g, '');
				else specFacTake = 0;
				specFacSum += parseInt(specFacTake);
			});
		}
		else $("#subjectAcqYTable input").attr("disabled",true);
	}
	else if($("input[name='rndYnCheck']:checked").val() == 'N' || $("#eqRndYn").val() == 'N') {
		$("#subjectTable input").attr("disabled",true);
		$("#subjectAcqYTable input").attr("disabled",true);
		$("#subjectAcqTable table").each(function (i) {
			if(!$.isEmpty($("#specFacTakeRndN_" + i).val())) specFacTake = $("#specFacTakeRndN_" + i).val().replace(/,/g, '');
			else specFacTake = 0;
			specFacSum += parseInt(specFacTake);
		});
	}
	
	if(!$.isEmpty(specFacSum) && specFacSum > 0) {
		$("#speFacReason").hide();
		$("#reason_2").val("");
	}
	else $("#speFacReason").show();
	$("input[name='equipFacilitesList[2].takePrc']").val(specFacSum);
}

function sumRndPrc(id) {
	
	var idPrefix = id.substring(0, id.indexOf('_')+1);
	var idx = id.replace(idPrefix, "");
	var landTake = 0;
	var buildingTake = 0;
	var specFacTake = 0;
	
	if($("input[name='rndYnCheck']:checked").val() == 'Y') {
		if(!$.isEmpty($("#landTake_" + idx).val())) landTake = $("#landTake_" + idx).val().replace(/,/g, '');
		if(!$.isEmpty($("#buildingTake_" + idx).val())) buildingTake = $("#buildingTake_" + idx).val().replace(/,/g, '');
		if(!$.isEmpty($("#specFacTake_" + idx).val())) specFacTake = $("#specFacTake_" + idx).val().replace(/,/g, '');
	}
	else if($("input[name='rndYnCheck']:checked").val() == 'N') {
		if(!$.isEmpty($("#landTakeRndN_" + idx).val())) landTake = $("#landTakeRndN_" + idx).val().replace(/,/g, '');
		if(!$.isEmpty($("#buildingTakeRndN_" + idx).val())) buildingTake = $("#buildingTakeRndN_" + idx).val().replace(/,/g, '');
		if(!$.isEmpty($("#specFacTakeRndN_" + idx).val())) specFacTake = $("#specFacTakeRndN_" + idx).val().replace(/,/g, '');
	}
	
	var sum = parseInt(landTake) + parseInt(buildingTake) + parseInt(specFacTake);
	if($("input[name='rndYnCheck']:checked").val() == 'Y') $("#rndPrc_" + idx).val(sum);
	else if($("input[name='rndYnCheck']:checked").val() == 'N') $("#rndPrcRndN_" + idx).val(sum);

}

function sumTakePrc() {
	var takePrc1 = 0;
	var takePrc2 = 0;
	var takePrc3 = 0;
	var takePrc4 = 0;
	var takePrc5 = 0;
	var takePrc6 = 0;
	
	if(!$.isEmpty($("input[name='equipFacilitesList[0].takePrc']").val()) && $("input[name='equipFacilitesList[0].takePrc']").val().replace(/,/g, '') > 0) takePrc1 = $("input[name='equipFacilitesList[0].takePrc']").val().replace(/,/g, '');
	if(!$.isEmpty($("input[name='equipFacilitesList[1].takePrc']").val()) && $("input[name='equipFacilitesList[1].takePrc']").val().replace(/,/g, '') > 0) takePrc2 = $("input[name='equipFacilitesList[1].takePrc']").val().replace(/,/g, '');
	if(!$.isEmpty($("input[name='equipFacilitesList[2].takePrc']").val()) && $("input[name='equipFacilitesList[2].takePrc']").val().replace(/,/g, '') > 0) takePrc3 = $("input[name='equipFacilitesList[2].takePrc']").val().replace(/,/g, '');
	if(!$.isEmpty($("#equipTakePrc").val()) && $("#equipTakePrc").val().replace(/,/g, '') > 0) takePrc4 = $("#equipTakePrc").val().replace(/,/g, '');
	if(!$.isEmpty($("#equipFacTakePrc").val()) && $("#equipFacTakePrc").val().replace(/,/g, '') > 0) takePrc5 = $("#equipFacTakePrc").val().replace(/,/g, '');
	if(!$.isEmpty($("#equipLittleTakePrc").val()) && $("#equipLittleTakePrc").val().replace(/,/g, '') > 0) takePrc6 = $("#equipLittleTakePrc").val().replace(/,/g, '');
			
	var sum = parseInt(takePrc1) + parseInt(takePrc2) + parseInt(takePrc3) + parseInt(takePrc4) + parseInt(takePrc5) + parseInt(takePrc6);
	//$("#takePrc").val(sum);
	$("#takePrc").val(addThousandSeparatorCommas(sum));
	number_format($('#takePrc').val(), takePrcTotalView);
}

function saveSumTakePrc() {
	var takePrc1 = 0;
	var takePrc2 = 0;
	var takePrc3 = 0;
	var takePrc4 = 0;
	
	if(!$.isEmpty($("input[name='equipFacilitesList[0].takePrc']").val()) && $("input[name='equipFacilitesList[0].takePrc']").val().replace(/,/g, '') > 0) takePrc1 = $("input[name='equipFacilitesList[0].takePrc']").val().replace(/,/g, '');
	if(!$.isEmpty($("input[name='equipFacilitesList[1].takePrc']").val()) && $("input[name='equipFacilitesList[1].takePrc']").val().replace(/,/g, '') > 0) takePrc2 = $("input[name='equipFacilitesList[1].takePrc']").val().replace(/,/g, '');
	if(!$.isEmpty($("input[name='equipFacilitesList[2].takePrc']").val()) && $("input[name='equipFacilitesList[2].takePrc']").val().replace(/,/g, '') > 0) takePrc3 = $("input[name='equipFacilitesList[2].takePrc']").val().replace(/,/g, '');
	if(!$.isEmpty($("#equipLittleTakePrc").val()) && $("#equipLittleTakePrc").val().replace(/,/g, '') > 0) takePrc4 = $("#equipLittleTakePrc").val().replace(/,/g, '');
	
	var sum = parseInt(takePrc1) + parseInt(takePrc2) + parseInt(takePrc3) + parseInt(takePrc4);
	$("#takePrc").val(addThousandSeparatorCommas(sum));
}


function delBrnd(idx) {
	if($("input[name='rndYnCheck']:checked").val() == 'Y' || $("#eqRndYn").val() == 'Y') {
		$("#subjectAcqYTable table").each(function (i) {
			if(i == idx) $(this).attr("id", "subjectAcqItem" +idx).remove();
		});
	}
	else if($("input[name='rndYnCheck']:checked").val() == 'N' || $("#eqRndYn").val() == 'N') {
		$("#subjectAcqTable table").each(function (i) {
			if(i == idx) $(this).attr("id", "subjectAcqItem" +idx).remove();
		});
	}
}

function reasonChk(idVal) {
	if(idVal == '1') {
		if(($.isEmpty($("#takePrc_0").val()) || $("#takePrc_0").val().replace(/,/g, '') == 0)) {
			$("#takePrc_0").val(0);
			$("#landReason").show();
			return false;
		}
		else {
			$("#landReason").hide();
			$("#reason_0").val("");
			
		}
	}
	else if(idVal == '2') {
		if(($.isEmpty($("#takePrc_1").val()) || $("#takePrc_1").val().replace(/,/g, '') == 0)) {
			$("#takePrc_1").val(0);
			$("#buildingReason").show();
			return false;
		}
		else {
			$("#buildingReason").hide();
			$("#reason_1").val("");
		}
	}
	/*else if(($.isEmpty($("input[name='equipFacilitesList[2].takePrc']").val()) || $("input[name='equipFacilitesList[2].takePrc']").val().replace(/,/g, '') == 0) && $.isEmpty($("input[name='equipFacilitesList[2].reason']").val())) {
		alert(infoTxt);
		$("input[name='equipFacilitesList[2].takePrc']").val(0);
		$("#speFacReason").show();
		return false;
	}*/
}

function disuseverY(code) {
	/*if($("input[id='disuseverY"+code+"']").is(":checked") == true) {
		if($.isEmpty($("#disuseVerdictDt01").val())) {
			alert("불용판정일자를 먼저 입력해주세요");
			$("input[id='disuseverY"+code+"']").attr("checked", false);
		}
		else {
			if(code == "01" || code == "02" || code == "03") $("#disuseDt"+code).val($("#disuseVerdictDt01").val());
			else if(code == "04" || code == "05")  $("#moveDt"+code).val($("#disuseVerdictDt01").val());
		}
	}
	else {
		if(code == "01" || code == "02" || code == "03") $("#disuseDt"+code).val(null);
		else if(code == "04" || code == "05")  $("#moveDt"+code).val(null);
	}*/
	if(!$.isEmpty($("#disuseVerdictDt01").val())) {
		if(code == "01" || code == "02" || code == "03") $("#disuseDt"+code).val($("#disuseVerdictDt01").val());
		else if(code == "04" || code == "05")  $("#moveDt"+code).val($("#disuseVerdictDt01").val());
	}
	
}

function delEquip(val) {
	$("input[name='id'][value='"+val+"']").prop("checked", false);
	var cookie =  $.getCheckedValues({cls:'chkbox', key:'facEquip'});
	$(cookie).each(function(i) {
		if(this == val) {
			if(i == 0) cookie.splice(i, 1);
			else cookie.splice(i, i);
			
		}
	});
	$.cookie('facEquip', cookie);
	$.equipBaseCookie();
}

function delFacEquip(val) {
	$("input[name='id'][value='"+val+"']").prop("checked", false);
	var cookie =  $.getCheckedValues({cls:'chkbox', key:'facEquipSelect'});
	$(cookie).each(function(i) {
		if(this == val) {
			if(i == 0) cookie.splice(i, 1);
			else cookie.splice(i, i);
			
		}
	});
	$.cookie('facEquipSelect', cookie);
	$.equipBaseFacCookie();
}

function totalLittleTake() {
	var trLen = $("#littleBase_name tr").length;
	var sumTake = 0;
	for(var i = 0; i < trLen; i++) {
		var idx = parseInt(2) + parseInt(i);
		if(!$.isEmpty($("#takePrcList_" + idx).val())) sumTake += parseInt($("#takePrcList_" + idx).val().replace(/,/g, ''));
	}
	$("#totalLittleTake").text(addThousandSeparatorCommas(sumTake));
	//$("#equipLittleTakePrc").val(addThousandSeparatorCommas(sumTake));
}

function useScopeRechg(value) {
	if(!$.isEmpty(value) && value != '1') {
		$("#useScopeRangeDiv").show();
		$("#useScopeMeanDiv").show();
		if($.isEmpty($("input[name='useScopeRange']:checked").val())) $("input[name='useScopeRange'][value='02']").prop("checked", true);
		if($.isEmpty($("input[name='useScopeMean']:checked").val())) $("input[name='useScopeMean'][value='03']").prop("checked", true);
	}
	else {
		$("#useScopeRangeDiv").hide();
		$("#useScopeMeanDiv").hide();
	}
}

function selOperOpenYn(value) {
	if(value == 'Y') {
		$("#operDiv").show();
		$("#operData1").hide();
		$("#operData2").hide();
	}
	else {
		$("#operDiv").hide();
		$("#operData1").show();
		$("#operData2").show();
	}
}


function formReset() {
	$("#equipAddForm").each(function() {
		$(this).find("input").each(function() {
			if($(this).attr("type") =='text') $(this).val("");
			if($(this).attr("type") =='hidden') {
				if($(this).attr("id") == 'eqcpId' || $(this).attr("id") == 'manufactureCd' || $(this).attr("id") == 'madeCd' || $(this).attr("id") == 'modelCd' || $(this).attr("id") == 'modelNm' || $(this).attr("id") == 'branchCd') {
					$(this).val("");
				}
			}
		});
	});
}

/** 이미지 해상도 확인을 위한 미리 보기 설정 */
function readURL(input, id) {
	if(input.files && input.files[0]) {
		var size =  input.files[0].size / 1024;
		var type = input.files[0].type;
		var dot = type.lastIndexOf("/");
		var ext = type.substring(dot).toLowerCase();
		
		if(ext != "/jpg" && ext != "/jpeg" && ext != "/gif" && ext != "/png") {
			alert("jpeg/gif/jpg/png 이미지만 업로드 하실수 있습니다.");
			input.outerHTML = input.outerHTML;
			return false;
		}
		
		if(size < 300) {
			alert("이미지 용량이 300kb 미만인 경우 품질문제로 업로드 하실수 없습니다.");
			input.outerHTML = input.outerHTML;
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$("#UploadImage").attr("src", e.target.result);
			var value = e.target.result;
			var imgInfo = new Image();
			imgInfo.src = value;
			//alert("1111111 ===" + imgInfo.width);
			/*if(imgInfo.width < 600) {
				alert("이미지 가로사이즈가 600px 미만일 경우 품질문제로 업로드 하실수 없습니다.");
				input.outerHTML = input.outerHTML;
				$("#UploadImage").attr("src", "");
				return false;
			}*/
		};
		reader.readAsDataURL(input.files[0]);
	}	
}

function validChk(id, idx) {
	var resultMsg = "변경 값을 입력해주세요";
	var resulReasontMsg = "변경사유를 입력해주세요";
	if(id == "equipCdLayer") {
		if($.isEmpty($("input[name='tmpTbEquipList["+idx+"].newValue']:checked").val())) {
			alert(resultMsg);
			return false;
		}
		else if($.isEmpty($("input[name='tmpTbEquipList["+idx+"].reason']").val())) {
			alert(resulReasontMsg);
			return false;
		}
		else layerToggle(id);
	}
	else if(id == "registCdLayer") {
		if($.isEmpty($("input[name='tmpTbEquipList["+idx+"].newValue']:checked").val())) {
			alert(resultMsg);
			return false;
		}
		else if($.isEmpty($("input[name='tmpTbEquipList["+idx+"].reason']").val())) {
			alert(resulReasontMsg);
			return false;
		}
		else if(!$.isEmpty($("input[name='tmpTbEquipList["+idx+"].newValue']:checked").val()) && ($("input[name='tmpTbEquipList["+idx+"].newValue']:checked").val() == "2" || $("input[name='tmpTbEquipList["+idx+"].newValue']:checked").val() == "3" )) {
			if($.isEmpty($("input[name='tmpTbEquipList[5].newValue']").val())) {
				alert(resultMsg);
				return false;
			}
		}	
		else layerToggle(id);
	}
	else {
		if($.isEmpty($("input[name='tmpTbEquipList["+idx+"].newValue']").val())) {
			alert(resultMsg);
			return false;
		}
		else if($.isEmpty($("input[name='tmpTbEquipList["+idx+"].reason']").val())) {
			alert(resulReasontMsg);
			return false;
		}
		else layerToggle(id);
	}
} 

function chgReset(id, idx) {
	if(id == "equipCdLayer") {
		$("input[name='tmpTbEquipList["+idx+"].newValue']").removeAttr("checked");
		$("input[name='tmpTbEquipList["+idx+"].reason']").val("");
		layerToggle(id);
	}
	else if(id == "registCdLayer") {
		$("input[name='tmpTbEquipList["+idx+"].newValue']").removeAttr("checked");
		$("input[name='tmpTbEquipList["+idx+"].reason']").val("");
		$("input[name='tmpTbEquipList[5].newValue']").val("");
		layerToggle(id);
	}
	else {
		$("input[name='tmpTbEquipList["+idx+"].newValue']").val("");
		$("input[name='tmpTbEquipList["+idx+"].reason']").val("");
		layerToggle(id);
	}
}

function checkMade() {
	if(!$.isEmpty($("#madeCd").val())) {
		if($("#madeCd").val() == "KR") {
			$("#takePrcForeign").attr("disabled", false);
			$("#takePrcDomestic").attr("disabled", true);
		}
		else {
			$("#takePrcForeign").attr("disabled", true);
			$("#takePrcDomestic").attr("disabled", false);
		}
	}
}
