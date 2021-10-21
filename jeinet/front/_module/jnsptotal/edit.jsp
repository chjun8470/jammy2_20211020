<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	
	ArrayList<HashMap<String, String>> branchList1 = request.getAttribute("branchList1") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList1");
	ArrayList<HashMap<String, String>> branchList2 = request.getAttribute("branchList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList2");
	ArrayList<HashMap<String, String>> branchList3 = request.getAttribute("branchList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList3");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));
%>

<style>
#bgLayer {  
  position:fixed;  
  left:0;
  top:0;
  z-index:1001; 
  width:100%;
  height:100%;
  opacity:0.5;  
  background-color:#000;   
  display:none;
  
}

#factureFinder,#locationFinder{
 position:fixed;  
  z-index:1002; 
  width:800px;
  min-height:300px;
  background-color:#FFFFFF;   
  display:none;
  text-align: left;
}
#dataCheck{
 position:fixed;
  z-index:1002; 
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;   
  display:none;
  text-align: left;
}

</style>
<script type="text/javascript">
var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png"); 
var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

$(document).ready(function(){
	
	$('input[name="takeSource"]').change(function(){
		if($(this).val()=='4'){
// 			$("#kor").html("연구과제정보");
			$("#rndDtLB").html("과제수행기간");
			/* $("#rndDirectorLB").html("연구책임자명"); */
			$("#rndDivisionLB").html("6T분류");
			$("#rndMainOrgLB").html("주관기관명");
			$("#rndBizLB").html("세부사업명");
			$("#rndTaskLB").html("세부과제명");
			$("#rndCommitLB").html("과제수행부처ㆍ청");
		}
		else{
// 			$("#kor").html(" * 연구과제정보");
			$("#rndDtLB").html(" * 과제수행기간");
			/* $("#rndDirectorLB").html(" * 연구책임자명"); */
			$("#rndDivisionLB").html(" * 6T분류");
			$("#rndMainOrgLB").html(" * 주관기관명");
			$("#rndBizLB").html(" * 세부사업명");
			$("#rndTaskLB").html(" * 세부과제명");
			$("#rndCommitLB").html(" * 과제수행부처ㆍ청");
		}
	    if($(this).val()=='3'){
	    	$('#takeSourceDtDiv').show();
	    }else{
	    	$('#takeSourceDtDiv').hide();
	    }
	});
	
	
	$("#takeSdt, #takeEdt , #takeDt,#disuseDt,#disuseVerdictDt,#rndStDt,#rndEdDt").datepicker({
//		showOn : "both",
//    	buttonImage: "button.png", 
         
    	showMonthAfterYear : true,
    	showButtonPanel : true,
    	changeMonth : true,
    	changeYear : true,
    	nextText : '다음 달',
    	prevText : '이전 달',
    	currentText : '오늘 날짜',
    	closeText : '닫기',
    	dateFormat : "yy-mm-dd",
    	showOn: 'both',
    	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
    	dayNamesMin : ['월','화','수','목','금','토','일'],
    	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
    });
	
	// 과제수행기간  시작일 값에 따른 종료일 선택 값 제한
    $('#rndStDt').datepicker("option", "maxDate", $("#rndEdDt").val());
    $('#rndStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#rndEdDt").datepicker( "option", "minDate", selectedDate );
    });
    
	// 과제수행기간 종료일 값에 따른 시작일 선택 값 제한
    $('#rndEdDt').datepicker("option", "minDate", $("#rndStDt").val());
    $('#rndEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#rndStDt").datepicker( "option", "maxDate", selectedDate );
	});
    
 	$("input[name='takePrc']").keyup(function() {
		var num = $(this).val();
		var NumArray = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
	    var unitArray = new Array("","십","백","천");
	    var result = "";
	    if(!isNaN(num)&&num!=""&&num!=null) {
	        for(i=0; i<num.length; i++) {
	            var str = "";
	            var korNum = NumArray[num.charAt(num.length-(i+1))];
	            if(korNum != ""){
	            	if(i>3){
	            		str = i%4 == 0 ? korNum+unitArray[0] : korNum+unitArray[i%4]; 
	            	}else{
	            		str = korNum+unitArray[i];
	            	}
	            }
	            if(i == 4) str += "만";
	            if(i == 8) str += "억";
	            if(i == 12) str += "조";
	            result = str + result;
	        }
	    }
	    result = result != "" ? "["+result+"]" : ""; 
	    $(".prcKorean").html(result);
	}); 
	
    var fileCount = $("input[type=file]").length;
     for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function() {
				var fileName = $('#jnsptotalFile'+fileCount).val();
				if(fileName != "" || fileName != null){
					fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(imgPattern.indexOf(fileName)==-1){
						alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}else if(this.files[0].size<300000){
						alert("300kb 이상의 이미지를 등록해주세요.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}
				}
			});
	}
								
	$(".addImageBtn,.delImageBtn").bind('click', function(){
	var fileCount = $("input[type=file]").length;
			$('#jnsptotalFile'+fileCount).bind('change', function() {
				var fileName = $('#jnsptotalFile'+fileCount).val();
				
				if(fileName != "" || fileName != null){
					fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(imgPattern.indexOf(fileName)==-1){
						alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}else if(this.files[0].size<300000){
						alert("300kb 이상의 이미지를 등록해주세요.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}
				}
			});
	});
	
	$('input[name="takeCd"]').change(function(){
	    if($(this).val()=='1'){
// 	    	$('#thTakeDt1, #tdTakeDt1').show();
	    	$('#thTakeDt1').show();
	    	$('#thTakeDt2, #tdTakeDt2').hide();
	    	$('#thTakePrc1').show();
	    	$('#thTakePrc2,#thDevSpec,#thOpenYn').hide();
	    	$('#takePrc,#takeSdt,#takeEdt').val("");
	    	$('#prcKorean').html("");
 			$("#warrantyTR").show();
	    }else if($(this).val()=='2'){
// 	    	$('#thTakeDt1, #tdTakeDt1').hide();
			$('#thTakeDt1').hide();
	    	$('#thTakeDt2, #tdTakeDt2').show();
	    	$('#thTakePrc1').hide();
	    	$('#thTakePrc2,#thDevSpec,#thOpenYn').show();
	    	$('#takePrc,#takeDt').val("");
	    	$('#prcKorean').html("");
	    	$("#warrantyTR").hide();
	    }
	});
	
	////////2단
	

	$('input[name="registCd"]').change(function(){
	    if($(this).val()=='1'){
	    	//$('#equipuseTypeCd').show();
// 	    	$('#equipMainDetail,#equipuseTypeCd').show();
// 	    	$('#equipuseTypeCd').show();
	    }else{
// 	    	$('#equipMainDetail,#equipuseTypeCd').hide();
			//$('#equipuseTypeCd').hide();
// 			$('#equipuseTypeCd').hide();
	    }
	});
	$('input[name="useScopeCd"]').change(function(){
		
	    if($(this).val()=='1'){
	    	$('#useScopeCd_1').show();
	    	$('#useScopeMeanDiv,#useScopeRangeDiv').hide();
	    }else{
	    	if($(this).val()=='3'){
	    		$('#useScopeRangeDiv').hide();
	    	}else{
	    		$('#useScopeRangeDiv').show();
	    	}
	    	$('#useScopeMeanDiv').show();
	    	$('#useScopeCd_1').hide();
	    }
	    
	});
	$('input[name="useTypeCd"]').change(function(){
	    if($(this).val()=='기타'){
	    	$('#useTypeCd_06').show();
	    }else{
	    	$('#useTypeCd_06').hide();
	    }
	});

	$('input[name="idleDisuseCd"]').change(function(){
	    if($(this).val()=='04'){
	    	$('#disuseVerdictDt_4,#idleDisuseCd_4').show();
	    }else{
	    	$('#disuseVerdictDt_4,#idleDisuseCd_4,#trDisuseCd').hide();
	    }

	    
	});

	$('input[name="disuseType"]').change(function(){
		var cdLength = $("input[name='disuseType']").length;
		for(var i =1;i<=cdLength;i++){
			$('#pDisuseCd_0'+i).hide();
			$('#thDisuseCd_0'+i).hide();
		}
		$('#pDisuseCd_'+$(this).val()).show();
		$('#thDisuseCd_'+$(this).val()).show();
		$('#trDisuseCd').show();
	    
	});
	
});


</script>
<div id = "bgLayer" onclick="factureFindExit();dataCheckExit();locationFindExit();"></div>
<div id="dataCheck"></div>
<div id="factureFinder"></div>
<div id="locationFinder"></div>
<div class="clear_wrap">
<form name="fwrite" id="fwrite" action="/sys/jnsptotalProc.do" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
			<div class="left_box w80">
				<div class="box_in">
					<p class="tr mb5"></p>
					<table id="step1" summary="연구장비의 상세정보입력" class="tbl04">
	                	<caption>연구장비 상세정보수정</caption>
	                	<colgroup>
	               			<col width="200px">
	               			<col width="">
	               			
	                	</colgroup>
	                	<tbody>
						<tr>
                			<th scope="col" class="top_sell bln"><label for="equipCd"> * 시설장비 분류</label></th>
                			<td class="top_sell brn">
	                			<input id="equipCd01" name="equipCd" title="연구장비" type="radio" value="1" checked='checked'/><label for="equipCd01">연구장비</label>
                				<input id="equipCd02" name="equipCd" title="연구시설" type="radio" value="2" onclick="if(confirm('연구시설로 변경하시겠습니까?')){window.location.href='./<%=myPage %>?mode=editRsc&rndEquIdx=<%=util.getStr(paramMap.get("rndEquIdx")) %>'}else{return false;}"/><label for="equipCd02">연구시설</label>
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="ntisEquipInfoYN"> * NTIS등록번호</label></th>
                			<td class="brn">
                			<label><input type="radio" name="ntisEquipInfoYN" id="ntisEquipInfoY" onclick="ntisEquipInfoYNCheck()" value="Y"/>NTIS 등록장비</label>
                			<input type="text" <%=util.getStr(dataMap.get("ntisEquipInfo")).equals("")?"style='display: none'" :"" %> name="ntisEquipInfo" id="ntisEquipInfo" maxlength="50"/>
                			<label><input type="radio" name="ntisEquipInfoYN" id="ntisEquipInfoN" onclick="ntisEquipInfoYNCheck()" value="N" <%=util.getStr(dataMap.get("ntisEquipInfo")).equals("")?"checked='checekd'" :"" %>/>NTIS 미등록장비</label>
                			
                			
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="fixedAsetNo"> * 고정자산관리번호</label></th>
                			<td class="top_sell brn">
	                			<input type="text" name="fixedAsetNo" id="fixedAsetNo"  maxlength="30" value="<%=util.getStr(dataMap.get("FIXED_ASET_NO"))%>"  onkeydown="$('#fixedAsetCheckVal').val('N')" onkeyup="if(event.keyCode==32){this.value=this.value.replace(/[\s]/gi,'');alert('스페이스바는 사용하실 수 없습니다.');}"/>
	                			<input id="fixedAsetCheck" class="btn_inp_b_01" name = "fixedAsetCheck" title="자산관리번호체크" type="button" value="이중등록확인" onclick="AsetCheck()"/>
                				<input id="fixedAsetCheckVal" name="fixedAsetCheckVal" title="고정자산번호체크여부" type="hidden" value="Y"/>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="korNm"> * 한글장비명</label></th>
                			<td class="top_sell brn">
                			<input type="text" name="korNm" id="korNm" maxlength="30" value="<%=util.getStr(dataMap.get("KOR_NM"))%>">
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="korKeyWord1" id="korKeyWordTR">한글키워드</label></th>
                			
                			<td class="brn srch_label">
                			<%String[] korKeyWordList = dataMap.get("KOR_KEY_WORD").split("[\\,]");%>
                				<input id="korKeyWord1" maxlength="15" name="korKeyWord1" title="한글키워드" style="width:80px;" type="text" value = "<%=korKeyWordList[0]%>" />
                				<input id="korKeyWord2" maxlength="15" name="korKeyWord2" title="한글키워드" style="width:80px;" type="text" value = "<%=korKeyWordList[1]%>"/>
                				<input id="korKeyWord3" maxlength="15" name="korKeyWord3" title="한글키워드" style="width:80px;" type="text" value = "<%=korKeyWordList[2]%>"/>
                				<input id="korKeyWord4" maxlength="15" name="korKeyWord4" title="한글키워드" style="width:80px;" type="text" value = "<%=korKeyWordList[3]%>"/>
                				<input id="korKeyWord5" maxlength="15" name="korKeyWord5" title="한글키워드" style="width:80px;" type="text" value = "<%=korKeyWordList[4]%>"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="engNm"> * 영문장비명</label></th>
                			<td class="top_sell brn">
                			<input type="text"  maxlength="100" name="engNm" id="engNm" value="<%=util.getStr(dataMap.get("ENG_NM"))%>">
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="engKeyWord1" id="engKeyWordTR">영문키워드</label></th>
                			<td class="brn srch_label">
                				<%String[] engKeyWordList = dataMap.get("ENG_KEY_WORD").split("[\\,]");%>
                				<input id="engKeyWord1" maxlength="15" name="engKeyWord1" title="한글키워드" style="width:80px;" type="text" value = "<%=engKeyWordList[0]%>" />
                				<input id="engKeyWord2" maxlength="15" name="engKeyWord2" title="한글키워드" style="width:80px;" type="text" value = "<%=engKeyWordList[1]%>"/>
                				<input id="engKeyWord3" maxlength="15" name="engKeyWord3" title="한글키워드" style="width:80px;" type="text" value = "<%=engKeyWordList[2]%>"/>
                				<input id="engKeyWord4" maxlength="15" name="engKeyWord4" title="한글키워드" style="width:80px;" type="text" value = "<%=engKeyWordList[3]%>"/>
                				<input id="engKeyWord5" maxlength="15" name="engKeyWord5" title="한글키워드" style="width:80px;" type="text" value = "<%=engKeyWordList[4]%>"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="equProduce"> * 제조사</label></th>
                			<td class="top_sell brn">
								<input id="equProduce" maxlength="50" name="equProduce" style="width:89%;" type="text" value="<%=util.getStr(util.getStr(dataMap.get("EQU_PRODUCE"))) %>" />
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="manufactureFind"> * 모델명</label></th>
                			<td class="top_sell brn">
<!-- 								<input id="manufactureCd" name="manufactureCd" type="hidden" value="" /> -->
								<input id="manufactureNm" maxlength="50" name="manufactureNm" style="width:89%;" type="text" value="<%=util.getStr(util.getStr(dataMap.get("MANUFACTURE_NM"))) %>" />
<!-- 								<input id="manufactureFind" name = "manufactureFind" title="제작사,모델찾기버튼" type="button" value="찾기" onclick="manuFactureFind()"/> -->
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="branchNm"> * 국가연구시설장비<br/>표준분류체계</label></th>
                			                			<td class="brn">
                			
                	<select name="branchCd1" id="branchCd1" onchange="branchCall(this.value,'M')" style="width:100px">		                			
	                	<option value="">선택</option>
						<%
						String selectedYN = "";
						if(branchList1.size()>0){
							for(HashMap rs:branchList1) {
							if(rs.get("CODE_CD").equals(dataMap.get("BRANCH_CD1"))){
								selectedYN = "selected='selected'";
							}else{
								selectedYN = "";
							}
							%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %>><%=util.getStr(rs.get("CODE_NM"))%></option>
							<%}
						}%>
					</select>
					<select name="branchCd2" id="branchCd2" onchange="branchCall(this.value,'S')" style="width:100px">		                			
	                	<option value="">선택</option>
						<%
						if(branchList2.size()>0){
							for(HashMap rs:branchList2) {
							if(rs.get("CODE_CD").equals(dataMap.get("BRANCH_CD2"))){
								selectedYN = "selected='selected'";
							}else{
								selectedYN = "";
							}
							%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %> ><%=util.getStr(rs.get("CODE_NM"))%></option>
							<%}
						}%>
					</select>
					<select name="branchCd3" id="branchCd3" onchange="branchCall(this.value,'')" style="width:100px">		                			
	                	<option value="">선택</option>
						<%
						if(branchList3.size()>0){
							for(HashMap rs:branchList3) {
							if(rs.get("CODE_CD").equals(dataMap.get("BRANCH_CD3"))){
								selectedYN = "selected='selected'";
							}else{
								selectedYN = "";
							}
							%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %> ><%=util.getStr(rs.get("CODE_NM"))%></option>
							<%}
						}%>
					</select>
                			<br/>
                				<input id="branchNm" name="branchNm" title="연구시설장비표준분류체계" style="width:63%" type="text" value="<%=util.getStr(util.getStr(dataMap.get("BRANCH_NM"))) %>" readonly="readonly"/>
                				<%-- <input id="branchCd" name="branchCd" title="연구시설장비표준분류체계" readonly="readonly" type="hidden" value="<%=util.getStr(util.getStr(dataMap.get("BRANCH_CD"))) %>"/> --%>
                				<a href="/file/branchPdf.pdf" target="_blank" class="btn_inp_w_01"/>표준분류체계PDF파일보기</a>
                				
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="bln"><label for="takeCd" id="take"> * 취득방법</label></th>
                			<td class="brn">
								<input id="takeCd1" name="takeCd" title="구매" type="radio" value="1" <%=util.getStr(dataMap.get("TAKE_CD")).equals("1") ? "checked='checked'":""%>/><label for="takeCd1">구매</label>
                				<input id="takeCd2" name="takeCd" title="개발" type="radio" value="2" <%=util.getStr(dataMap.get("TAKE_CD")).equals("2") ? "checked='checked'":""%>/><label for="takeCd2">개발</label>
                			</td>
                		</tr>
                		<tr <%=!util.getStr(dataMap.get("TAKE_CD")).equals("1") ? "style='display:none'":""%> id="warrantyTR">
                			<th scope="row" class="bln"> 내구연한 </th>
                			<td>
                				<input type="text" id="equipWarranty" name="equipWarranty"  value="<%=util.getStr(dataMap.get("EQUIP_WARRANTY"))%>" maxlength="3"/>년
                			</td>
                		</tr>
						<tr id="trTakeDt">
							<th scope="col" class="bln">
								<div class="equipCdOption" id="thTakeDt1" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("1") ? "style='display:none'":""%>>
									<label for="takeDt"> * 취득일자</label>
								</div>
								<div class="equipCdOption" id="thTakeDt2" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("2") ? "style='display:none'":""%>>
									<label for="takeSdt"> * 개발기간</label>
								</div>
							</th>
							
							<td class="brn">
								
									
									<input id="takeSdt" name="takeSdt" value = "<%=util.getStr(dataMap.get("TAKE_SDT"))%>" class="equipCalendar" title="취득일자(개발, 시설 선택 시)" type="text" value="" readonly="readonly"/>
									<span class="equipCdOption" id="tdTakeDt2" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("2") ? "style='display:none'":""%>>
									 ~ <input id="takeEdt" name="takeEdt" value = "<%=util.getStr(dataMap.get("TAKE_EDT"))%>" class="equipCalendar" title="취득일자(개발, 시설 선택 시)" type="text" value="" readonly="readonly"/>
									</span>
							 <br/>* 고정자산 등재일 기재
							</td>
						</tr>
						<tr id="takePrcSource">
							<th scope="row" class="bln">
								<div class="equipCdOption" id="takeSource">
									<label for="takeSource"> * 사업비출처</label>
								</div>
							</th>
							<td class="brn">
								<div class="equipCdOption" id="takeSourceDiv">
									<label><input id="takeSource1" <%=util.getStr(dataMap.get("TAKE_SOURCE")).equals("1") ? "checked='checked'" : "" %>name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="1" />국비</label>
									<label><input id="takeSource2" <%=util.getStr(dataMap.get("TAKE_SOURCE")).equals("2") ? "checked='checked'" : "" %> name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="2" />국비+지방비</label>
									
									<label><input id="takeSource3" <%=util.getStr(dataMap.get("TAKE_SOURCE")).equals("3") ? "checked='checked'" : "" %> name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="3" />지방비</label>
									<span id = "takeSourceDtDiv" <%=util.getStr(dataMap.get("TAKE_SOURCE")).equals("2") ? "" : "style='display:none'" %> >
										(<label><input id="takeSourceDt1" <%=util.getStr(dataMap.get("TAKE_SOURCE_DT")).equals("1") ? "checked='checked'" : "" %> name="takeSourceDt" class="equipCalendar" title="사업비출처" type="radio" value="1" />도비</label>
										<label><input id="takeSourceDt2" <%=util.getStr(dataMap.get("TAKE_SOURCE_DT")).equals("2") ? "checked='checked'" : "" %>name="takeSourceDt" class="equipCalendar" title="사업비출처" type="radio" value="2" />시군비</label>)
									</span>
									
									<label><input id="takeSource4" <%=util.getStr(dataMap.get("TAKE_SOURCE")).equals("4") ? "checked='checked'" : "" %> name="takeSource" class="equipCalendar" title="사업비출처" type="radio" value="4" />자체</label>
								</div>
							</td>
						</tr>
						<tr id="trTakePrc">
							<th scope="col" class="bln">
								<div class="equipCdOption" id="thTakePrc1" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("1") ? "style='display:none'":""%>>
									<label for="takeDt"> * 취득금액</label>
								</div>
								<div class="equipCdOption" id="thTakePrc2" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("2") ? "style='display:none'":""%>>
									<label for="takeSdt"> * 개발금액</label>
								</div>
							</th>
							
							<td class="brn">
								<div class="equipCdOption" id="tdTakePrc" >

<input id="takePrc" name="takePrc" class="number" title="취득(개발)금액" type="text" maxlength="20" value="<%=util.getStr(dataMap.get("TAKE_PRC"))%>"
									  onkeyup="if(event.keyCode==32||event.keyCode==188){this.value=this.value.replace(/[,\s]/gi,'');alert(' , 및 스페이스바는 사용하실 수 없습니다.');}"/>
									  <span id="prcKorean" class="prcKorean"></span> 원
									 <br/>* ',' 및 스페이스바는 입력하실 수 없습니다.
								</div>
							</td>
						</tr>
						<tr id = "thOpenYn" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("2") ? "style='display:none'":""%>>
                			<th scope="col" class="top_sell bln"><label for="devOpenYn"> * 개발장비공개여부</label></th>
                			<td class="top_sell brn">
                				<input id="devOpenYn1" name="devOpenYn" type="radio" value="Y" <%=util.getStr(dataMap.get("DEV_OPEN_YN")).equals("Y") ? "checked='checked'" : "" %>/><label for="devOpenYn1">공개</label>
								<input id="devOpenYn2" name="devOpenYn" type="radio" value="N" <%=util.getStr(dataMap.get("DEV_OPEN_YN")).equals("N") ? "checked='checked'" : "" %>/><label for="devOpenYn2">미공개</label>	
                			</td>
                		</tr>
                		<tr id = "thDevSpec" <%=!util.getStr(dataMap.get("TAKE_CD")).equals("2") ? "style='display:none'":""%>>
                			<th scope="col" class="top_sell bln"><label for="devOpenYn"> * 개발장비비중</label></th>
                			<td class="top_sell brn">
                				<input id="devSpec" name="devSpec" class="number" title="개발장비 비중" type="text" value="<%=util.getStr(dataMap.get("DEV_SPEC"))%>"/>%
                			</td>
                		</tr>
                		<!-- 22222222222222222222222222 -->
                		<!-- <tr>
                			<th scope="col" class="top_sell bln"><label for="">R&D과제정보</label></th>
                			<td class="top_sell brn">
                				협의중
                			</td>
                		</tr> -->
	                	<tr id="rndCommitTR">
                			<th scope="row" class="bln"><label for = "rndCommit" id="rndCommitLB"><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>과제수행부처ㆍ청</label></th>
                			<td class="brn srch_label">
                				<input id="rndCommit" name="rndCommit" value="<%=util.getStr(dataMap.get("RND_COMMIT"))%>" type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		<tr id="rndBizTR">
                			<th scope="row" class="bln"><label for = "rndBiz" id="rndBizLB" ><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>세부사업명</label></th>
                			<td class="brn srch_label">
                				<input id="rndBiz" name="rndBiz" value="<%=util.getStr(dataMap.get("RND_BIZ"))%>"  type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		<tr id="rndTaskTR">
                			<th scope="row" class="bln"><label for = "rndTask" id="rndTaskLB" ><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>세부과제명</label></th>
                			<td class="brn srch_label">
                				<input id="rndTask" name="rndTask" value="<%=util.getStr(dataMap.get("RND_TASK"))%>"  type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		
                		<tr id="rndMainOrgTR">
                			<th scope="row" class="bln"><label for = "rndMainOrg" id="rndMainOrgLB" ><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>주관기관명</label></th>
                			<td class="brn srch_label">
                				<input id="rndMainOrg" name="rndMainOrg" value="<%=util.getStr(dataMap.get("RND_MAIN_ORG"))%>"  type="text" style="width:250px" maxlength="30"/>
                			</td>
                		</tr>
                		<tr id="rndDivisionTR">
                			<th scope="row" class="bln"><label for = "rndDivision" id="rndDivisionLB" ><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>6T분류</label></th>
                			<td class="brn srch_label">
<%--                 				<input id="rndDivision" name="rndDivision" value="<%=util.getStr(dataMap.get("RND_DIVISION"))%>"  type="text" style="width:250px" maxlength="30"/> --%>
									<select id="rndDivision" name="rndDivision">
										<option value="" >선택</option>
										<option value="BT" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("BT") ? "selected='selected'" : "" %>>BT(Biology Technology)</option>
										<option value="ET" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("ET") ? "selected='selected'" : "" %>>ET(Environment Technology)</option>
										<option value="IT" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("IT") ? "selected='selected'" : "" %>>IT(Information Technology)</option>
										<option value="NT" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("NT") ? "selected='selected'" : "" %>>NT(Nano Technology)</option>
										<option value="ST" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("ST") ? "selected='selected'" : "" %>>ST(Space Technology)</option>
										<option value="CT" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("CT") ? "selected='selected'" : "" %>>CT(Culture Technology)</option>
										<option value="ETC" <%=util.getStr(dataMap.get("RND_DIVISION")).equals("ETC") ? "selected='selected'" : "" %>>기타</option>
									</select>
									&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="division_detail()" />
                			</td>
                		</tr>
                		<tr id="rndDtTR">
                			<th scope="row" class="bln"><label for="rndStDt" id="rndDtLB"><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>과제수행기간</label></th>
                			<td class="brn srch_label">
                				<input id="rndStDt" name="rndStDt" value="<%=util.getStr(dataMap.get("RND_ST_DT"))%>"  type="text" readonly="readonly"/> ~ 
                				<input id="rndEdDt" name="rndEdDt" value="<%=util.getStr(dataMap.get("RND_ED_DT"))%>"  type="text" readonly="readonly"/>
                			</td>
                		</tr>
                		<%-- <tr id="rndDirectorTR">
                			<th scope="row" class="bln"><label for="rndDirector" id="rndDirectorLB"><%=!util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")?" * " : "" %>연구책임자명</label></th>
                			<td class="brn srch_label">
                				<input id="rndDirector" name="rndDirector" value="<%=util.getStr(dataMap.get("RND_DIRECTOR"))%>"  type="text" style="width:250px"/>
                			</td>
                		</tr> --%>
                		<tr>
                			<th scope="row" class="bln"><label for="registCd"> * 장비구분</label></th>
                			<td class="brn">
                				<input id="registCd1" name="registCd" type="radio" value="1" <%=util.getStr(dataMap.get("REGIST_CD")).equals("1") ? "checked='checked'" : "" %>/><label for="registCd1">주장비(주시설)</label>
								<input id="registCd2" name="registCd" type="radio" value="2" <%=util.getStr(dataMap.get("REGIST_CD")).equals("2") ? "checked='checked'" : "" %>/><label for="registCd2">보조장비</label>
								<input id="registCd3" name="registCd" type="radio" value="3" <%=util.getStr(dataMap.get("REGIST_CD")).equals("3") ? "checked='checked'" : "" %>/><label for="registCd3">부대장비(부대시설)</label>
								
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="equip_detail()" />
								
                			</td>
                		</tr>
						<%-- <tr class="equipRegistOption" id="equipMain" >
							<th scope="row" class="bln"><label for="eqcpidlayer"> * 주장비(주시설) 입력</label></th>
							<td class="brn">
<!-- 								<input id="eqcpId" name="eqcpId" type="hidden" value=""/> -->
								<input id="eqcpId" name="eqcpId" type="text" value="<%=util.getStr(dataMap.get("EQCP_ID"))%>" onfocus="this.value=''"/>
								<input id="eqcpNm" name="eqcpNm" title="연구시설명" style="width:350px;" type="text" value="<%=util.getStr(dataMap.get("EQCP_NM"))%>"/>
<!-- 								<input type="button" value="찾기" onclick="alert('미실장');"/> -->
							</td>
						</tr> --%>
						<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션" >
                			<th scope="row" class="bln"><label for="modelSearchLayer"> * 활용범위</label></th>
                			<td class="brn">
								<input id="useScopeCd1" name="useScopeCd" type="radio" value="1" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "checked='checked'" : "" %>/><label for="useScopeCd1">단독활용만 가능</label>
								<input id="useScopeCd2" name="useScopeCd" type="radio" value="2" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("2") ? "checked='checked'" : "" %>/><label for="useScopeCd2">공동활용허용가능</label>
								<input id="useScopeCd3" name="useScopeCd" type="radio" value="3" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("3") ? "checked='checked'" : "" %>/><label for="useScopeCd3">공동활용서비스가능</label>
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="equip_main_detail()" />
                			</td>
                		</tr>
                		<tr class="useScopeCd" id="useScopeCd_1" <%=!util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="useScopeReason"> * 단독활용사유</label></th>
							<td class="brn">
								<select id="useScopeReason" name="useScopeReason" title="단독활용사유" style="width:95%">
									<option value="">선택</option>
									<option value="01" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("01") ? "selected='selected'" : "" %>>자체 수요가 많아 내부 활용도가 매우 높은 장비(장비가동률 100%, 년간 2000시간 이상 장비)</option>
									<option value="02" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("02") ? "selected='selected'" : "" %>>시작품 시제품 수준으로 아직 시험운영중이거나 요소 부품 및 기술 개발중인 장비</option>
									<option value="03" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("03") ? "selected='selected'" : "" %>>특수목적용 장비로서 반드시 자체 특화된 연구에만 전용되어야 하는 장비</option>
									<option value="04" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("04") ? "selected='selected'" : "" %>>상시 모니터링 및 계측용으로 연중 실시간 또는 지속적으로 활용되어지는 장비</option>
									<option value="05" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("05") ? "selected='selected'" : "" %>>국가안보, 기술유출 등으로 보안 및 기밀유지가 요구되는 장비</option>
									<option value="06" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("06") ? "selected='selected'" : "" %>>위험물질 취급 및 고위험성으로 인하여 이용이 제한되어 있는 장비</option>
									<option value="07" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("07") ? "selected='selected'" : "" %>>초고감도 정밀장비로 오염 및 손상시 복구가 불가능한 장비</option>
									<option value="08" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("08") ? "selected='selected'" : "" %>>라이센스 계약에 묶여있어 타이용자가 사용이 불가능한 장비</option>
									<option value="09" <%=util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("09") ? "selected='selected'" : "" %>>기타</option>
								</select>
							</td>
						</tr>
						<tr class="table01" id="useScopeRangeDiv" <%=!util.getStr(dataMap.get("USE_SCOPE_CD")).equals("2") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="useScopeRange"> * 활용대상</label></th>
							<td class="brn">
									<input id="useScopeRange01" name="useScopeRange" type="radio" value="기관내부활용" <%=util.getStr(dataMap.get("USE_SCOPE_RANGE")).equals("기관내부활용") ? "checked='checked'" : "" %>/><label for="useScopeRange01">기관내부활용</label>
									<input id="useScopeRange02" name="useScopeRange" type="radio" value="기관외부활용" <%=util.getStr(dataMap.get("USE_SCOPE_RANGE")).equals("기관외부활용") ? "checked='checked'" : "" %>/><label for="useScopeRange02">기관외부활용</label>
							</td>
						</tr>
						<tr class="table01" id="useScopeMeanDiv" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="useScopeMean"> * 이용방법</label></th>
							<td class="brn">
									<input id="useScopeMean01" name="useScopeMean" type="radio" value="이용자 직접사용" <%=util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("이용자 직접사용") ? "checked='checked'" : "" %>/><label for="useScopeMean01">이용자 직접사용</label>
									<input id="useScopeMean02" name="useScopeMean" type="radio" value="분석&middot;시험 의뢰" <%=util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("분석·시험 의뢰") ? "checked='checked'" : "" %>/><label for="useScopeMean02">분석&middot;시험 의뢰</label>
									<input id="useScopeMean04" name="useScopeMean" type="radio" value="대여" <%=util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("대여") ? "checked='checked'" : "" %>/><label for="useScopeMean04">대여</label>
									<input id="useScopeMean03" name="useScopeMean" type="radio" value="모두 가능" <%=util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("모두 가능") ? "checked='checked'" : "" %>/><label for="useScopeMean03">모두 가능</label>
							</td>
						</tr>
						<tr class="equipRegistOption" id="equipuseTypeCd" title="장비용도" >
                			<th scope="row" class="bln"><label for="useTypeCd"> * 장비용도</label></th>
                			<td class="brn">
								<input id="useTypeCd01" name="useTypeCd" type="radio" value="시험용" <%=util.getStr(dataMap.get("USE_TYPE_CD")).equals("시험용") ? "checked='checked'" : "" %>/><label for="useTypeCd01">시험용</label>
								<input id="useTypeCd02" name="useTypeCd" type="radio" value="분석용" <%=util.getStr(dataMap.get("USE_TYPE_CD")).equals("분석용") ? "checked='checked'" : "" %>/><label for="useTypeCd02">분석용</label>
								<input id="useTypeCd03" name="useTypeCd" type="radio" value="교육용" <%=util.getStr(dataMap.get("USE_TYPE_CD")).equals("교육용") ? "checked='checked'" : "" %>/><label for="useTypeCd03">교육용</label>
								<input id="useTypeCd04" name="useTypeCd" type="radio" value="계측용" <%=util.getStr(dataMap.get("USE_TYPE_CD")).equals("계측용") ? "checked='checked'" : "" %>/><label for="useTypeCd04">계측용</label>
								<input id="useTypeCd05" name="useTypeCd" type="radio" value="생산용" <%=util.getStr(dataMap.get("USE_TYPE_CD")).equals("생산용") ? "checked='checked'" : "" %>/><label for="useTypeCd05">생산용</label>
								<input id="useTypeCd06" name="useTypeCd" type="radio" value="기타"  <%=util.getStr(dataMap.get("USE_TYPE_CD")).equals("기타") ? "checked='checked'" : "" %>/><label  for="useTypeCd06">기타</label>
                			</td>
                		</tr>
						<tr class="useTypeCd" id="useTypeCd_06" <%=!util.getStr(dataMap.get("USE_TYPE_CD")).equals("기타") ? "style='display:none'" : "" %>/>
							<th scope="row" class="bln">
									장비용도사유
							</th>
							<td class="brn"><input id="useTypeReason" name="useTypeReason" style="width:450px;" type="text" maxlength="50" value="<%=util.getStr(dataMap.get("USE_TYPE_REASON"))%>"/></td>
						</tr>
						
                		
                		<tr class="equipRegistOption" id="equipIdleDisuseCd" title="장비상태" >
							<th scope="row" class="bln">
								<label for="idleDisuseCd">
										 * 장비상태
								</label>
							</th>
							<td class="brn">
									<input id="idleDisuseCd1" name="idleDisuseCd" type="radio" value="01" <%=util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("01") ? "checked='checked'" : "" %>/><label for="idleDisuseCd1">활용</label>
									<input id="idleDisuseCd2" name="idleDisuseCd" type="radio" value="02" <%=util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("02") ? "checked='checked'" : "" %>/><label for="idleDisuseCd2">재활용</label>
									<input id="idleDisuseCd3" name="idleDisuseCd" type="radio" value="03" <%=util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("03") ? "checked='checked'" : "" %>/><label for="idleDisuseCd3">유휴</label>
									<input id="idleDisuseCd4" name="idleDisuseCd" type="radio" value="04" <%=util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "checked='checked'" : "" %>/><label for="idleDisuseCd4">불용</label>
<!-- 									<input id="idleDisuseCd5" name="idleDisuseCd" type="radio" value="05" <%=util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("05") ? "checked='checked'" : "" %>/><label for="idleDisuseCd5">대여</label> -->
									&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="idle_disuse_detail()">
							</td>
						</tr>

						<tr id="disuseVerdictDt_4" class="disuseVerdictDt" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="disuseVerdictDt"> * 불용판정일자</label></th>
							<td class="brn">
								<input id="disuseVerdictDt" name="disuseVerdictDt" class="equipCalendar" style="width:150px;" type="text" value="<%=util.getStr(dataMap.get("DISUSE_VERDICT_DT"))%>"  readonly="readonly"/>
							</td>
						</tr>
						<tr id="idleDisuseCd_4" class="idleDisuseCd" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>">
							<th scope="row" class="bln"><label for="disuseCd"> * 불용처분</label></th>
							<td class="brn">
									<input id="disuseCd01" name="disuseType" type="radio" value="01" <%=util.getStr(dataMap.get("DISUSE_TYPE")).equals("01") ? "checked='checked'" : "" %>/><label for="disuseCd01">매각</label>
									<input id="disuseCd02" name="disuseType" type="radio" value="02" <%=util.getStr(dataMap.get("DISUSE_TYPE")).equals("02") ? "checked='checked'" : "" %>/><label for="disuseCd02">재활용</label>
									<input id="disuseCd03" name="disuseType" type="radio" value="03" <%=util.getStr(dataMap.get("DISUSE_TYPE")).equals("03") ? "checked='checked'" : "" %>/><label for="disuseCd03">폐기</label>
									<input id="disuseCd04" name="disuseType" type="radio" value="04" <%=util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "checked='checked'" : "" %>/><label for="disuseCd04">양여</label>
									<input id="disuseCd05" name="disuseType" type="radio" value="05" <%=util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "checked='checked'" : "" %>/><label for="disuseCd05">대여</label>
								<br/><span class="f_orange mb5"> ※ 장비처분 시, 해당 기관의 ‘장비심의위원회’의 승인사항입니다.</span>
							</td>
						</tr>
						
						<tr id="trDisuseCd" class="disuseCd" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>>
									<th scope="row" class="bln">
										<span id="thDisuseCd_01" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("01") ? "style='display:none'" : "" %>> * 매각일자</span>
										<span id="thDisuseCd_02" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("02") ? "style='display:none'" : "" %>> * 재활용일자</span>
										<span id="thDisuseCd_03" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("03") ? "style='display:none'" : "" %>> * 폐기일자</span>
										<span id="thDisuseCd_04" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "style='display:none'" : "" %>> * 양여일자</span>
										<span id="thDisuseCd_05" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "style='display:none'" : "" %>> * 대여일자</span>
									</th>
									<td class="brn">
										<input id="disuseDt" name="disuseDt" class="equipCalendar" style="width:150px;" type="text" value="<%=util.getStr(dataMap.get("DISUSE_DT"))%>" readonly="readonly"/>
										<p id="pDisuseCd_01" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("01") ? "style='display:none'" : "" %>><span class="f_blue">매각일자가 불용판정일자와 다를 경우, 매각된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_02" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("02") ? "style='display:none'" : "" %>><span class="f_blue">재활용일자가 불용판정일자와 다를 경우, 재활용된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_03" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("03") ? "style='display:none'" : "" %>><span class="f_blue">폐기일자가 불용판정일자와 다를 경우, 폐기된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_04" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "style='display:none'" : "" %>><span class="f_blue">양여일자가 불용판정일자와 다를 경우, 양여된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_05" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "style='display:none'" : "" %>><span class="f_blue">대여일자가 불용판정일자와 다를 경우, 대여된 일자로 수정해주세요 </span>
									</td>
						</tr>

	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="location"> * 설치장소</label></th>
                			<td class="top_sell brn">
                				<input type="text" value="<%=util.getStr(dataMap.get("LOCATION")) %>" name = "location" id = "location"  maxlength="50"/>
                				<input type="text" value="<%=util.getStr(dataMap.get("LOCATION_DTL")) %>" name = "locationDtl" id = "locationDtl" maxlength="50"/>
                				<!--<input type="button" value="부서정보 불러오기" onclick="callDeptInfo('dept')"/>-->
                				<input type="button" value="기관정보 불러오기" onclick="callDeptInfo('org')"/>
<!--                 				<input id="btLocationFind" name = "btLocationFind" title="설치장소버튼" type="button" value="찾기" onclick="locationFind()"/>	 -->
                			</td>
                		</tr>
	                	
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="feature"> * 장비설명</label></th>
                			<td class="top_sell brn">
                				<textarea style = "width:100%" id="feature" name="equipDetailFeature"  maxlength="300"><%=util.getStr(dataMap.get("EQUIP_DETAIL_FEATURE")) %></textarea>
<!--                 				<br/> * 50자 이상 입력해주세요 -->
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="capability"> * 구성 및 성능</label></th>
                			<td class="top_sell brn">
	                			<textarea style="width:100%" id="capability" name="equipDetailCapability"  maxlength="300"><%=util.getStr(dataMap.get("EQUIP_DETAIL_CAPABILITY")) %></textarea>
<!-- 	                			<br/> * 50자 이상 입력해주세요 -->
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="example"> * 사용예</label></th>
                			<td class="top_sell brn">
                				<textarea style="width:100%" id="example" name="equipDetailExample"  maxlength="300"><%=util.getStr(dataMap.get("EQUIP_DETAIL_EXAMPLE")) %></textarea>
<!--                 				<br/> * 50자 이상 입력해주세요 -->
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="importCd"> * 5대 중점투자분야</label></th>
                			<td class="top_sell brn">
                				<select id="importCd" name="importCd" title="5대 중점투자분야">
                				
									<option value="">:: 중점투자분야선택 ::</option>
									<option <%=util.getInt(dataMap.get("IMPORT_CD")) == 1 ? "selected='selected'":""%> value="1">국가주도기술 핵심역량 확보</option>
									<option <%=util.getInt(dataMap.get("IMPORT_CD")) == 2 ? "selected='selected'":""%> value="2">글로벌 이슈대응 연구개발 추진</option>
									<option <%=util.getInt(dataMap.get("IMPORT_CD")) == 3 ? "selected='selected'":""%> value="3">기초과학·융합기술 연구개발 활성화</option>
									<option <%=util.getInt(dataMap.get("IMPORT_CD")) == 4 ? "selected='selected'":""%> value="4">신산업 창출 핵심기술개발 강화</option>
									<option <%=util.getInt(dataMap.get("IMPORT_CD")) == 5 ? "selected='selected'":""%> value="5">주력기간산업 기술 고도화</option>
								</select>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="equipCd"> * 담당자 정보</label></th>
                			<td class="top_sell brn">
                			<table class="tbl4">
                				<tr>
                					<th style="width:100px">담당자</th>
                					<td style="width:200px">
                						<input type="text" value="<%=util.getStr(dataMap.get("OPER_CHARGER")) %>" name="operCharger" id="operCharger" maxlength="10"/>
                					</td>
                					<th style="width:100px">직위</th>
                					<td style="width:200px">
                						<input type="text" value="<%=util.getStr(dataMap.get("OPER_POSITION")) %>" name="operPosition"  id="operPosition" maxlength="10"/>
                					</td>
                				</tr>
                				<tr>
                					<th>전화번호</th>
                					<td >
                						<input type="text" value="<%=util.getStr(dataMap.get("OPER_TEL")) %>" name = "operTel" id = "operTel" maxlength="20"/>
                					</td>
                					<th>이메일</th>
                					<td>
                						<input type="text" value="<%=util.getStr(dataMap.get("OPER_EMAIL")) %>" name="operEmail" id="operEmail" maxlength="40"/>
                					</td>
                				</tr>
                				<tr>
                					<th >팩스</th>
                					<td >
                						<input type="text" value="<%=util.getStr(dataMap.get("OPER_FAX")) %>" name="operFax" id="operFax" maxlength="20"/>
                					</td>
                					<th >비고</th>
                					<td >
                						<input type="text" value="<%=util.getStr(dataMap.get("OPER_ETC")) %>" name="operEtc" id="operEtc" maxlength="40"/>
                					</td>
                				</tr>
                				
                			</table>
                				
                			</td>
                		</tr>
				<tr>
					<th scope="col" class="tit">
						<label for="extfile"> * 첨부파일</label>
					</th>
					<td>
				<%
					if(fileList.size() > 0){
				%>
						<ul class="file" style="line-height: 22px;">
						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
								String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;rndEquIdx="+util.getStr(rs.get("RND_EQU_IDX"));
						%>
							<li class="text">
								<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
										value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" /> &nbsp;
								<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>
<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
								
							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" /> 
							<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div> 
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
				            		fileHtml += "</div>";
			
			            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}
			
					            function delRowFile(fileGrpnm){
					            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }
			
								function fileSet(fileCnt){
									if($('#fileFlog_'+fileCnt).is(':checked')){
										$('#fileBox_'+fileCnt).show();
									}else{
										$('#fileBox_'+fileCnt).hide();
									}
								}
				            </script> 
				            
	            <% }else{ %>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" /> 
							<input type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div> 
						<script type="text/javascript">
							var arrfileCnt = new Array();
							arrfileCnt['<%=fileFullGrp%>'] = 2;
				            function addRowFile(fileGrpnm){
			            		var fileHtml = "<div>";
			            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
			            		fileHtml += "</div>";
		
		            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
		            			arrfileCnt[fileGrpnm]++;
			            	}
		
				            function delRowFile(fileGrpnm){
				            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
				            		return;
				            	}
				            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
				            	arrfileCnt[fileGrpnm]--;
				            }
			            </script> 
			      <% } %>
						      <br/> * 300kb이상의 실사이미지만 등록이 가능합니다.
							  <br/> * 가로형 이미지만 등록해주세요.
					      </td>
				      </tr>
                	</tbody>
                </table>
              </div>
              <div class="btn_box" >
			            <div class="btn_left_box" >
			              	<button class="btn_inp_g_01" type="button" onclick="pageDelGo()">삭제</button>
			            </div>
	                	<div class="btn_right_box" >
	                		<button class="btn_inp_b_01" type="button" onclick="submitGo();">수정</button>
	                		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">이전</button>
	                	</div>
             </div>
            </div>

	<input type="hidden" id = "rnd_equ_idx" name = "rndEquIdx" value = "<%=util.getStr(paramMap.get("rndEquIdx"))%>"/>
</form>
<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('view');
		$('#fwrite').attr("action","/sys/sys_jnsptotal.do");
		$('#fwrite').submit();
	}
	function pageDelGo(){
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fwrite').attr("action","/sys/jnsptotalProc.do");
			$('#fwrite').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('view');
		$('#fwrite').attr("action","/sys/jnsptotalProc.do");
		$('#fwrite').submit();
	}
	
	function branchCall(branchCd,branchGrpCd){
		if(branchGrpCd!=""){
			 $.ajax({
		         type: "POST",
		         url : './branchList.do',
		         data : {
						codeCd : branchCd,
						codeGrpCd : branchGrpCd
	          	},
		         dataType : 'json',
		         success : function(data){
	                 
	                 var branchInfoList = data.branchList;
	                 var txt="<option value=''>선택</option>";
	                 for(var i=0; i<branchInfoList.length;i++){
	                	 txt+="<option value='"+branchInfoList[i].CODE_CD+"'>"+branchInfoList[i].CODE_NM+"</option>";    
	                 }
		                 
		            if(branchGrpCd=="M"){
		                	 $("#branchCd2").html(txt);
		                	 $("#branchCd3").html("<option value=''>선택</option>");
		                	 
		            }
		            else if(branchGrpCd=="S"){
		            		$("#branchCd3").html(txt);
		            }
	                 
	        	}
			})
		}
		 
         //branchNm(분류코드명) 변경
         txt="";
         txt = $("#branchCd1 option:selected").text();
         if(branchGrpCd=="S"){
         	txt +=" > "+$("#branchCd2 option:selected").text();
         }else if(branchGrpCd==""){
         	txt +=" > "+$("#branchCd2 option:selected").text();
            txt +=" > "+$("#branchCd3 option:selected").text();
         }
         $("#branchNm").val(txt);
	}
	
	function callDeptInfo(calltype){
			$.ajax({
	             type: "POST",
	             url : '/web/deptInfoCall.do',
	             dataType : 'json',
	             success : function(data){
	            	 var ERR = "";
	            	 var deptAddr = "";
	            	 var deptAddrDtl = "";
	            	 var orgAddr = "";
	            	 var orgAddrDtl = "";
	         		for (var i in data) {
	         			ERR = data.ERR;
	         			deptAddr = data.deptAddr;
	         			deptAddrDtl = data.deptAddrDtl;
	         			orgAddr = data.blngOrgAddr;
	         			orgAddrDtl = data.blngOrgAddrDtl;
	         		}
	         		
	            	 if(ERR=="Y"){
	            		 alert("정보 조회에 실패하였습니다.");
	            	 }else{
	            		 if(calltype=='dept'){
		            		 $("#location").val(deptAddr);
		            		 $("#locationDtl").val(deptAddrDtl);
	            		 }else{
	            			 $("#location").val(orgAddr);
		            		 $("#locationDtl").val(orgAddrDtl);
	            		 }
	            	 }
	             }
	    	})
	}
	
	
	function AsetCheck(){
		var fixedAsetNUM = $("#fixedAsetNo").val();
		if(fixedAsetNUM !=null && fixedAsetNUM != ""){
			if(!numPattern.test(fixedAsetNUM)){
				alert("숫자를 포함하여 입력해주세요.");
				return false;
			}
			$.ajax({
	             type: "POST",
	             data : {
						fixedAsetNo : fixedAsetNUM
	             },
	             url : './jnspAsetCheck.do',
	             dataType : 'json',
	             success : function(data){
	            	 if(data.AsetCheck=="0"){
	            		 $("#fixedAsetCheckVal").val("Y");
	            		 alert("신규로 사용하실수 있는 고정자산관리번호 입니다.");
	            	 }else{
	            		 $("#fixedAsetCheckVal").val("N");
	            		 alert("신규로 사용하실수 없는 고정자산관리번호 입니다.");
	            	 }
	             }
	    	})
		}else{
			alert("고정자산관리번호를 입력해주세요.");
			$("#fixedAsetNo").focus();
			return false;
		}
	}

	/* function manuFactureFind(){
			$.ajax({
	             type: "POST",
	             url : './jnspModelFinder.do',
	             success : function(data){
	            	 $("#factureFinder").html(data);
	            	 $("#bgLayer,#factureFinder").show();
	         		 $("#factureFinder").css("left",($(document).width()/2)-($("#factureFinder").width()/2)+"px");
	         		 $("#factureFinder").css("top",($(document).height()/2)-($("#factureFinder").height()/2)+"px");
	             }
	    	})
	} */
	function locationFind(){
		$.ajax({
	         type: "POST",
	         url : './jnspLocationFinder.do',
	         success : function(data){
	        	 $("#locationFinder").html(data);
	        	 $("#bgLayer,#locationFinder").show();
	     		 $("#locationFinder").css("left",($(document).width()/2)-($("#locationFinder").width()/2)+"px");
	     		 $("#locationFinder").css("top",($(document).height()/2)-($("#locationFinder").height()/2)+"px");
	         }
		})
	}

	function locationFindExit(){
		$("#bgLayer,#locationFinder").hide();
		$("#locationFinder").html("");
	}
	function factureFindExit(){
		$("#bgLayer,#factureFinder").hide();
		$("#factureFinder").html("");
	}
	function dataCheckExit(){
		$("#bgLayer,#dataCheck").hide();
		$("#dataCheck").css("width","400px");
		$("#dataCheck").html("");
	}
	function submitGo(){

		var errMsg = "";
		if($("input[type=radio][name='ntisEquipInfoYN']:checked").val()=="Y"){
			if($("#ntisEquipInfo").val()==null || $("#ntisEquipInfo").val()==""){
				errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
			}
		}
		if($("#fixedAsetNo").val()==null || $("#fixedAsetNo").val()==""){
			errMsg+="고정자산관리번호 : 필수입력사항입니다."+"<br/>";
		}
		
		if($("#fixedAsetCheckVal").val()!="Y"){
			errMsg+="고정자산관리번호 : 이중등록여부를<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			errMsg+="확인하여주세요."+"<br/>";
		}
		if($("#korNm").val()==null || $("#korNm").val()==""){
			errMsg+="한글장비명 : 필수입력사항입니다."+"<br/>";
		}
		
		
		if(!korPattern.test($("#korNm").val())){
			errMsg+="한글장비명 : 한글이 포함되어야합니다."+"<br/>";
		}

		if($("#engNm").val()==null || $("#engNm").val()==""){
			errMsg+="영문장비명 : 필수입력사항입니다."+"<br/>";
		}
		
		if(!engPattern.test($("#engNm").val())){
			errMsg+="영문장비명 : 영문이 포함되어야합니다."+"<br/>";
		}
	/*
	 	if(korPattern.test($("#engNm").val())){
		errMsg+="영문장비명 : 한글은 입력하실 수 없습니다."+"<br/>";
	}
	 
		if(korPattern.test($("#manufactureNm").val())){
		errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
		}*/
		if($("#equProduce").val()==null || $("#equProduce").val()==""){
			errMsg+="제조사 : 필수입력사항입니다."+"<br/>";
		}
		
		if($("#manufactureNm").val()==null || $("#manufactureNm").val()==""){
			//alert("모델명을 검색해주세요.");
			errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
			//manuFactureFind();
			//return false;
			}
		
		if($("#branchNm").val()==null || $("#branchNm").val()==""){
			errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
		}
		/* if($("#branchCd").val()==null || $("#branchCd").val()==""){
		errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
		} */
			
		if(!$("input[name='takeCd']").is(":checked")){
			errMsg+="취득방법 : 필수입력사항입니다."+"<br/>";
		}
		
		if(!$("input[type=radio][name='takeSource']").is(":checked")){
			errMsg+="사업비출처 : 필수입력사항입니다."+"<br/>";
		}
		
		if($("input[type=radio][name='takeCd']:checked").val()==1){
			if($("#takeSdt").val()==null || $("#takeSdt").val()==""){
				errMsg+="취득일자 : 필수입력사항입니다."+"<br/>";
			}
			
			if($("#takePrc").val()==null || $("#takePrc").val()==""){
				errMsg+="취득금액 : 필수입력사항입니다."+"<br/>";
			}
			
			if(isNaN($("#takePrc").val()) == true){
				errMsg+="취득금액 : 숫자만 입력해주세요."+"<br/>";
			}
			if($("#takePrc").val()<1000000){
				errMsg+="취득금액 : 100만원 이상 입력하세요."+"<br/>";
			}
		}else{
			if($("#takeSdt").val()==null || $("#takeSdt").val()==""){
				errMsg+="개발기간일자 : 필수입력사항입니다."+"<br/>";
			}else if($("#takeEdt").val()==null || $("#takeEdt").val()==""){
				errMsg+="개발기간일자 : 필수입력사항입니다."+"<br/>";
			}
			
			if($("#takePrc").val()==null || $("#takePrc").val()==""){
				errMsg+="개발금액 : 필수입력사항입니다."+"<br/>";
			}
			if($("#takePrc").isNaN){
				errMsg+="개발금액 : 숫자만 입력해주세요."+"<br/>";
			}
			if($("#takePrc").val()<1000000){
				errMsg+="개발금액 : 100만원 이상 입력하세요."+"<br/>";
			}
			if(!$("input[name='devOpenYn']").is(":checked")){
				errMsg+="개발장비공개여부 : 필수입력사항입니다."+"<br/>";
			}
			if($("#devSpec").val()==null || $("#devSpec").val()==""){
				errMsg+="개발장비비중 : 필수입력사항입니다."+"<br/>";
			}
			
		}

		var fileCK=0
	    var fileCheck = document.getElementsByName("fileFlog");
	    var fileTot = fileCheck.length;
	    for (var fi = 0; fi < fileTot; fi++) {
	        if (fileCheck[fi].checked == true) {
	            fileCK++;
	        }
	    }
	   
		var fileCheck = 0;
		var fileCheck2 = $("input[name=fileFlog]").length;
			fileCheck = Number(fileCheck) + Number(fileCheck2) + Number(fileCK);
		var fileCount = $("input[type=file]").length;
			for(i = 1; i <= fileCount; i++) {
					var fileName = $('#jnsptotalFile'+fileCount).val();
					if(fileName != "" && fileName != null){fileCheck++;}
			}
		if(fileCheck == 0)
		{
 			errMsg+="장비사진 : 필수입력사항입니다.<br/>";
		}
		
	//////////////////2단계////////////////////
		
		
		if($("input[type=radio][name='takeSource']:checked").val()!='4'){
//				if($("#rndInfo").val()==null || $("#rndInfo").val()==""){
//					errMsg+="연구과제정보 : 필수입력사항입니다."+"<br/>";
//				}
			if($("#rndCommit").val()==null || $("#rndCommit").val()==""){
				errMsg+="과제수행부처ㆍ청 : 필수입력사항입니다."+"<br/>";
			}
			if($("#rndTask").val()==null || $("#rndTask").val()==""){
				errMsg+="세부과제명 : 필수입력사항입니다."+"<br/>";
			}
			if($("#rndBiz").val()==null || $("#rndBiz").val()==""){
				errMsg+="세부사업명 : 필수입력사항입니다."+"<br/>";
			}
			if($("#rndMainOrg").val()==null || $("#rndMainOrg").val()==""){
				errMsg+="주관기관명 : 필수입력사항입니다."+"<br/>";
			}
			if($("#rndDivision > option:selected").val()==null || $("#rndDivision > option:selected").val()==""){
				errMsg+="6T분류 : 필수입력사항입니다."+"<br/>";
			}
			if($("#rndStDt").val()==null || $("#rndStDt").val()==""){
				errMsg+="과제기간 : 필수입력사항입니다."+"<br/>";
			}else if($("#rndEdDt").val()==null || $("#rndEdDt").val()==""){
				errMsg+="과제기간 : 필수입력사항입니다."+"<br/>";
			}
			/* if($("#rndDirector").val()==null || $("#rndDirector").val()==""){
				errMsg+="책임자 : 필수입력사항입니다."+"<br/>";
			} */
		}
		
		if(!$("input[name='registCd']").is(":checked")){
			errMsg+="장비구분 : 필수입력사항입니다."+"<br/>";
		}
				if(!$("input[name='useScopeCd']").is(":checked")){
					errMsg+="활용범위 : 필수입력사항입니다."+"<br/>";
				}
				if($("input[type=radio][name='useScopeCd']:checked").val()!=1){
					if($("input[type=radio][name='useScopeCd']:checked").val()!=3){
						if(!$("input[name='useScopeRange']").is(":checked")){
							errMsg+="활용대상 : 필수입력사항입니다."+"<br/>";
						}
					}
					if(!$("input[name='useScopeMean']").is(":checked")){
						errMsg+="이용방법 : 필수입력사항입니다."+"<br/>";
					}
				}else{
					if($("#useScopeReason > option:selected").val()==null || $("#useScopeReason > option:selected").val()==""){
						errMsg+="단독활용사유 : 필수입력사항입니다."+"<br/>";
					}
					
				}
// 			if($("input[type=radio][name='registCd']:checked").val()==1)
// 				{
					if(!$("input[name='useTypeCd']").is(":checked")){
						errMsg+="장비용도 : 필수입력사항입니다."+"<br/>";
					}
// 				}
				/* if($("#eqcpId").val()==null || $("#eqcpId").val()==""||$("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
					errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
				} */
			/* if($("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
				errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
			} */
		if(!$("input[name='idleDisuseCd']").is(":checked")){
			errMsg+="장비상태 : 필수입력사항입니다."+"<br/>";
		}
		
		if($("input[type=radio][name='idleDisuseCd']:checked").val()=='04'){

			
			if($("#disuseVerdictDt").val()==null || $("#disuseVerdictDt").val()==""){
				errMsg+="불용판정일자 : 필수입력사항입니다."+"<br/>";
			}
			if(!$("input[name='disuseType']").is(":checked")){
				errMsg+="불용처분 : 필수입력사항입니다."+"<br/>";
			}
			if($("#disuseDt").val()==null || $("#disusedt").val()==""){
				if($("input[type=radio][name='disuseType']:checked").val()=='01'){
						errMsg+="매각일자 : 필수입력사항입니다."+"<br/>";
				}else if($("input[type=radio][name='disuseType']:checked").val()=='02'){
						errMsg+="재활용일자 : 필수입력사항입니다."+"<br/>";
				}else if($("input[type=radio][name='disuseType']:checked").val()=='03'){
						errMsg+="폐기일자 : 필수입력사항입니다."+"<br/>";
				}else if($("input[type=radio][name='disuseType']:checked").val()=='04'){
						errMsg+="양여일자 : 필수입력사항입니다."+"<br/>";
				}else if($("input[type=radio][name='disuseType']:checked").val()=='05'){
						errMsg+="대여일자 : 필수입력사항입니다."+"<br/>";
				}
			}
		}
		if($("#location").val()==null || $("#location").val()==""){
			errMsg+="설치장소 : 필수입력사항입니다."+"<br/>";
		}
		
		if($("#feature").val()==null || $("#feature").val()==""){
			errMsg+="장비설명 : 필수입력사항입니다."+"<br/>";
		}else if($("#feature").val().length<50){
// 			errMsg+="장비설명 : 50자이상 입력해주세요."+"<br/>";
		}
		
		if($("#capability").val()==null || $("#capability").val()==""){
			errMsg+="구성 및 성능 : 필수입력사항입니다."+"<br/>";
		}else if($("#capability").val().length<50){
// 			errMsg+="구성 및 성능 : 50자이상 입력해주세요."+"<br/>";
		}
		if($("#example").val()==null || $("#example").val()==""){
			errMsg+="사용예 : 필수입력사항입니다."+"<br/>";
		}else if($("#example").val().length<50){
// 			errMsg+="사용예 : 50자이상 입력해주세요."+"<br/>";
		}
		 
		if($("#importCd > option:selected").val()==null || $("#importCd > option:selected").val()==""){
			errMsg+="5대 중점투자분야 : 필수입력사항입니다."+"<br/>";
		}
		
		if($("#operCharger").val()==null || $("#operCharger").val()==""){
			errMsg+="담당자 : 필수입력사항입니다."+"<br/>";
		}else if(onlyKorPattern.test($("#operCharger").val())){
			errMsg+="담당자 : 한글만 입력해주세요."+"<br/>";
		}
		if($("#operPosition").val()==null || $("#operPosition").val()==""){
			errMsg+="직위 : 필수입력사항입니다."+"<br/>";
		}else if(onlyKorPattern.test($("#operPosition").val())){
			errMsg+="직위 : 한글만 입력해주세요."+"<br/>";
		}
		if($("#operTel").val()==null || $("#operTel").val()==""){
			errMsg+="전화번호 : 필수입력사항입니다."+"<br/>";
		}else if(!telPattern.test($('#operTel').val())){
			errMsg+="전화번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
		}
		if($("#operEmail").val()==null || $("#operEmail").val()==""){
			errMsg+="이메일 : 필수입력사항입니다."+"<br/>";
		}else if(!emailPattern.test($('#operEmail').val())){
			errMsg+="이메일 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:Example@email.com)"+"<br/>";
		}
		if($("#operFax").val()==null || $("#operFax").val()==""){
			errMsg+="팩스 : 필수입력사항입니다."+"<br/>";
		}else if(!telPattern.test($('#operFax').val())){
			errMsg+="팩스 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
		}
		
		if(errMsg==""){
			if(confirm("수정하시겠습니까?")){
			fwrite.submit();
			}
		}else{
			errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
			errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;
			
			errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
			errMsg+="</div>";
			$('#dataCheck').html(errMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
// 			$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();
			return false;
		}
		
}
	
	function ntisEquipInfoYNCheck(){
		if($("input[type=radio][name='ntisEquipInfoYN']:checked").val()=="Y"){
			$("#ntisEquipInfo").show();
		}else{
			$("#ntisEquipInfo").hide();
			$("#ntisEquipInfo").val("");
		}
	}  
	
	
	function equip_detail(){
		var detailMsg="<div style='margin:20px'><h2>장비구분</h2>";
			detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
			//////////////내용삽입///////////////////
			detailMsg+="- 주장비란?<br/> ‘추가적인 부대장비 없이도 본래의 구축 목적에 맞는 활용 및 성능을 발휘하는 핵심적인 장치’를 말함<br/><br/>";
			detailMsg+="- 부대장비란?<br/>‘ 주장비의 일부분으로 규정하고, 주장비의 기본성능과 별도로 반드시 새로운 성능향상을 위하여 주장비에 부착하는 개념의 추가적인 장치’를 말함<br/><br/>";
			detailMsg+="- 보조장치란?<br/> ‘주장비의 성능향상이 아니라, 본래 주장비의 구축 목적에 따라 장비가 정상적으로 가동되기 위한 보조물·부속물’을 말함<br/><br/>";
			//////////////내용삭제///////////////////
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//				$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();
			
		}
	function equip_main_detail(){
		var detailMsg="<div style='margin:20px'><h2>활용범위</h2>";
		detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
		//////////////내용삽입///////////////////
		detailMsg+="- 단독활용(Private Use) 연구시설·장비<br/>";
		detailMsg+="· 단독활용을 목적으로 구축하는 연구시설 및 연구장비<br/>";
		detailMsg+="· 주로 개별연구자가 직접 관리<br/>";
		detailMsg+="· 구입부서만 활용이 가능<br/><br/>";
		detailMsg+="- 공동활용허용(Permissive Use) 연구시설·장비<br/>";
		detailMsg+="· 연구자가 공동연구 등의 목적으로 외부기관 및 소속기관 타부서 연구자에게 활용을 허용한 연구시설 및 연구장비<br/>";
		detailMsg+="· 주로 연구시설·장비 보유 책임자가 판단하여 외부기관 및 보유기관 소속 타부서 연구자에게 활용을 허용<br/>";
		detailMsg+="· 공동활용을 위한 세부적인 운영규정이 마련되지 않은 상태<br/><br/>";
		detailMsg+="- 공동활용서비스(Public Use) 연구시설·장비<br/>";
		detailMsg+="· 대외 개방을 위해 연구시설·장비 이용료, 이용절차, 이용시간, 전담운영인력 등 세부적인 운영규정에 의해 활용되는 연구시설 및 연구장비<br/>";
		detailMsg+="· 연구기관 차원에서 체계적으로 관리";
		detailMsg+="";
		//////////////내용삭제///////////////////
		detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
		detailMsg+="</div>";
		$('#dataCheck').html(detailMsg);
		$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//			$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
		$("#dataCheck").css("top","200px");
		$('#dataCheck,#bgLayer').show();
		
	}
	function idle_disuse_detail(){
		var detailMsg="<div style='margin:20px'><h2>설치장소</h2>";
		detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
		//////////////내용삽입///////////////////
		
		detailMsg+="- 활용 연구시설·장비<br/>"
		+"· 당초 활용을 목적으로 구축 후 목적과 용도에 맞게 활용되고 있으며 가동상태 및 운영상황이 양호한 연구시설 및 연구장비<br/><br/>"
		+"- 저활용 연구시설·장비<br/>"
		+"· 당초 활용을 목적으로 구축 후 사용 및 사양 저조, 경제적 보유수준이 적합하지 않은 이유 등으로 정상가동은 가능하나 활용도가 낮은 연구시설 및 연구장비<br/><br/>"
		+"- 유휴 연구시설·장비<br/>"
		+"· 당초 활용을 목적으로 구축 후 활용성 상실 등의 사유로 가동이 중지되어 놀리는 연구시설 및 연구장비<br/><br/>"
		+"- 불용 연구시설·장비<br/>"
		+"· 계속 가동이 정지되어 향후 활용가능성이 희박하고 비경제적이어서 더 이상 <br/>";
		
		//////////////내용삭제///////////////////
		detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
		detailMsg+="</div>";
		$('#dataCheck').html(detailMsg);
		$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//			$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
		$("#dataCheck").css("top","200px");
		$('#dataCheck,#bgLayer').show();
		
	}
	function division_detail(){
		var detailMsg="<div style='margin:20px'><h2>6T분류</h2>";
			detailMsg+="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>";
			//////////////내용삽입///////////////////
			detailMsg	+="<table class='tbl04'>"
						+ "<tr><th>BT<br/>(Biology Technology)</th>"
						+ "<td>생명공학기술에 활용되는 <br/>연구시설ㆍ장비</td></tr>"
						+ "<tr><th>ET<br/>(Environment Technology)</th>"
						+ "<td>환경공학기술에 활용되는 <br/>연구시설ㆍ장비</td></tr>"
						+ "<tr><th>IT<br/>(Information Technology)</th>"
						+ "<td>정보기술에 활용되는 <br/>연구시설ㆍ장비</td></tr>"
						+ "<tr><th>NT<br/>(Nano Technology)</th>"
						+ "<td>나노기술(초정밀기술)에 활용되는 <br/>연구시설ㆍ장비</td></tr>"
						+ "<tr><th>ST<br/>(Space Technology)</th>"
						+ "<td>우주항공기술에 활용되는 <br/>연구시설ㆍ장비</td></tr>"
						+ "<tr><th>CT<br/>(Culture Technology)</th>"
						+ "<td>문화콘텐츠기술에 활용되는 <br/>연구시설ㆍ장비</td></tr>"
						+ "</table>";
			//////////////내용삭제///////////////////
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("width","500px");
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
//				$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();
			
		}
</script>
