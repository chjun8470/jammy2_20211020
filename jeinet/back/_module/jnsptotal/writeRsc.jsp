<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> branchList1 = request.getAttribute("branchList1") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList1");
	ArrayList<HashMap<String, String>> branchList2 = request.getAttribute("branchList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList2");
	ArrayList<HashMap<String, String>> branchList3 = request.getAttribute("branchList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("branchList3");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	
	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	//USER 정보
	String userIdx = util.getStr(paramMap.get("userIdx"));
	String userTp = util.getStr(paramMap.get("userTp"));
	String psnNm = util.getStr(paramMap.get("psnNm"));
	String orgGrpCd = util.getStr(paramMap.get("orgGrpCd"));
	String orgGrpNm = util.getStr(paramMap.get("orgGrpNm"));
	String deptNm = util.getStr(paramMap.get("deptNm"));
	String telNo = util.getStr(paramMap.get("telNo"));
	String faxNo = util.getStr(paramMap.get("faxNo"));
	String positionNm = util.getStr(paramMap.get("positionNm"));
	String email = util.getStr(paramMap.get("email"));
	String authLv = util.getStr(paramMap.get("authLv"));

	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "rscWrite";
%>
<%if(Integer.parseInt(loginVO.getAuthLv()) < 70) {%>
<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
</script>
<%} %>

<style>
#bgLayer {
  position:fixed;
  left:0;
  top:0;
  z-index:1001;
  width:100%;d
  height:100%;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
  filter: alpha(opacity=50);
  -khtml-opacity: 0.5;
  -moz-opacity: 0.5;
  opacity:0.5;
  background-color:#000;
  display:none;

}

#factureFinder,#locationFinder{
 position:absolute;
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

	$("#takeSdt, #takeEdt , #takeDt,#disuseDt,#disuseVerdictDt").datepicker({
		//showOn : "both",
		//buttonImage: "button.png",

		showMonthAfterYear : true,
		showButtonPanel : true,
		changeMonth : true,
		changeYear : true,
		nextText : '다음 달',
		prevText : '이전 달',
		currentText : '오늘 날짜',
		closeText : '닫기',
		dateFormat : "yy-mm-dd",
		dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin : ['월','화','수','목','금','토','일'],
		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	});
	$('#buildPrc').keyup(function() {
		if(Number($(this).val())==0){
			$('#noneBuildReason').show();
		}else{
			$('#noneBuildReason').hide();
		}
	});
	$('#landPrc').keyup(function() {
		if(Number($(this).val())==0){
			$('#noneLandReason').show();
		}else{
			$('#noneLandReason').hide();
		}
	});

	function noneCheck(val,targetID){
		alert("test");
		if(Number(val)==0){
			$("#none"+targetID+"REASON").show();
		}else{
			$("#none"+targetID+"REASON").hide();
		}
	}

	var fileCount = $("input[type=file]").length;
	for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function() {
				var fileName = $('#jnsptotalFile'+i).val();
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
		for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function() {
				var fileName = $('#jnsptotalFile'+i).val();
				fileName = fileName.slice(fileName.lastIndexOf(".") + 1).toLowerCase();
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
	});

	$("#fixedAsetNone").click(AsetNone);
	$("#korLargeFacYn").click(LargeFacYn);

	$('input[name="rndYN"]').change(function(){
		if($(this).val()=='N'){
			$('#rndInfo').val("");
			$('#rndInfo').hide();
		}else{
			$('#rndInfo').show();
		}
	});

	$('input[name="registCd"]').change(function(){
		/* if($(this).val()=='1'){
			$('#equipMainDetail').hide();
		}else{
			$('#equipMainDetail').show();
		} */
	});
	$('input[name="useScopeCd"]').change(function(){
		if($(this).val()=='1'){
			$('#useScopeCd_1').show();
			$('#useScopeMeanDiv,#useScopeRangeDiv,#equipuseTypeCd').hide();
		}else{
			$('#useScopeMeanDiv,#useScopeRangeDiv,#equipuseTypeCd').show();
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
		if($(this).val()=="04"||$(this).val()=="05"){
			$('#disuseOrgan').show();
			$('#disuseOrganFinder').show();
		}else{
			$('#disuseOrgan').hide();
			$('#disuseOrganFinder').hide();
		}
		$('#pDisuseCd_'+$(this).val()).show();
		$('#thDisuseCd_'+$(this).val()).show();
		$('#trDisuseCd').show();

	});

	$('input[type="checkbox"][name="equipFacilitiesYN"]').click(function(){
		if ($(this).prop('checked')) {
			$('input[type="checkbox"][name="equipFacilitiesYN"]').prop('checked', false);
			$(this).prop('checked', true);
		}
	});
});
function radio_area(mode,no){
	if(no =="2"){

		$("#"+mode+"1").val("");

		$("#"+mode+"1").attr("name","0");
		$("#"+mode+"2").attr("name",mode);
		$("#"+mode+"1").hide();
		$("#"+mode+"2").show();
	}else{
		$("#"+mode+"2").val("");
		$("#"+mode+"2").attr("name","0");
		$("#"+mode+"1").attr("name",mode);
		$("#"+mode+"2").hide();
		$("#"+mode+"1").show();
	}
}
</script>

<div id="bgLayer" onclick="factureFindExit();dataCheckExit();locationFindExit();"></div>
<div id="dataCheck"></div>
<div id="factureFinder"></div>
<div id="locationFinder"></div>

	 <form name="fwrite" id="fwrite" action="/sys/jnsptotalProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
		<input type="hidden" name="tmenu" id="tmenu" value="2"/>
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
	  	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />

	<div id="div_h3_step1" class="h3_box mb30">
		<h3>
			연구 시설등록
			<span style="float:right; color:red; font-size:10pt;"> * 필수 입력사항입니다.</span>
		</h3>
	</div>

	<div class="clear_wrap">
			<div class="left_box w80">
				<div class="box_in" style="width:100%">
					<table id="step1" summary="연구시설의 상세정보입력" class="skin_basic_write">
						<caption>연구시설 상세정보</caption>
						<colgroup>
	               			<col style="width: 220px;" />
	       					<col style="width: *;">
	                	</colgroup>
						<tbody>
						<tr style="display:none">
							<th scope="row"><label for="equipCd"> * 시설장비 분류</label></th>
							<td>
								<input id="equipCd01" name="equipCd" title="연구장비" type="radio" value="1" readonly="readonly"/><label for="equipCd01">연구장비</label>
								<input id="equipCd03" name="equipCd" title="연구시설" type="radio" value="2" checked="checked"/><label for="equipCd03">연구시설</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="ntisEquipInfoYN"> * NTIS등록번호</label></th>
							<td>
								<input type="radio" name="ntisEquipInfoYN" id="ntisEquipInfoY" onclick="ntisEquipInfoYNCheck()" value="Y"/><label for="ntisEquipInfoY"> NTIS 등록장비</label>
								<input class="inp_txt" type="text" style="display: none; width: 240px;" name="ntisEquipInfo" id="ntisEquipInfo" maxlength="50"/>
								<input type="radio" name="ntisEquipInfoYN" id="ntisEquipInfoN" onclick="ntisEquipInfoYNCheck()" value="N"/><label for="ntisEquipInfoN"> NTIS 미등록장비</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="registCd"> * 시설구분</label></th>
							<td>
								<input id="registCd1" name="registCd" type="radio" value="1" checked="checked"/><label for="registCd1"> 주시설</label>
								<input id="registCd2" name="registCd" type="radio" value="3"/><label for="registCd2"> 부대시설</label>
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="equip_detail()" />
							</td>
						</tr>

				 		<!--<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션" style="display:none;"> -->
						<!--<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션">
							<th scope="row"><label for="eqcpidlayer"> * 주시설 입력</label></th>
							<td>
								<input id="eqcpId" name="eqcpId" type="hidden" value=""/>
								<input id="eqcpId" name="eqcpId" type="text" value="eqcpId" onfocus="this.value=''"/>
								<input id="eqcpNm" name="eqcpNm" title="연구시설명" style="width:350px;" type="text" value=""/>
								<input type="button" onclick="alert('미실장')";" value = "찾기" />
							</td>
						</tr>-->

						<tr>
							<th scope="row"><label for="fixedAsetNo"> * 고정자산관리번호</label></th>
							<td>
								<input class="inp_txt" id="fixedAsetNo" name="fixedAsetNo" title="고정자산번호" style="width:87%;" maxlength="30" type="text" onkeydown="$('#fixedAsetCheckVal').val('N')" onkeydown="$('#fixedAsetCheckVal').val('N')" onkeyup="if(event.keyCode==32){this.value=this.value.replace(/[\s]/gi,'');alert('스페이스바는 사용하실 수 없습니다.');}"/>
								<input id="fixedAsetCheck" name = "fixedAsetCheck" title="자산관리번호체크" type="button" value="이중등록확인" class="btn_inp_b_01" onclick="AsetCheck()"/>
								<input id="fixedAsetNone" name = "fixedAsetNone" title="자산관리번호사용안함체크" type="checkbox" value="Y"/><label for="fixedAsetNone"> 고정자산관리번호 사용안함</label>
								<input id="fixedAsetCheckVal" name="fixedAsetCheckVal" title="고정자산번호체크여부" type="hidden" value="N"/>
							</td>
						</tr>

						<tr>
							<th scope="row"><label for="korNm" id="kor"> * 한글시설명</label></th>
							<td class="brn srch_label">
								<input class="inp_txt" id="korNm" name="korNm" title="한글시설명" style="width:87%;" type="text" maxlength="30"/>
								<!--
								<div>
								<input id="korLargeFacYn" name = "korLargeFacYn" title="대형연구시설 검색" type="checkbox" value="Y"/><label for="korLargeFacYn">대형연구시설</label>
									<span id = "korLargeFacSearch" style="display:none"><input type="button" onclick="alert('미실장');" value="검색"/></span>
									<span style="color:red">* 대형연구시설일 경우 이곳을 선택해주세요</span>
								</div>
								-->
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="korKeyWord1" id="korKeyWordTR">한글키워드</label></th>
							<td class="brn srch_label">
								<input class="inp_txt" id="korKeyWord1" name="korKeyWord1" title="한글키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="korKeyWord2" name="korKeyWord2" title="한글키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="korKeyWord3" name="korKeyWord3" title="한글키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="korKeyWord4" name="korKeyWord4" title="한글키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="korKeyWord5" name="korKeyWord5" title="한글키워드" style="width:110px;" type="text" maxlength="15"/>
							</td>
						</tr>

						<tr>
							<th scope="row"><label for="engNm" id="eng"> * 영문시설명</label></th>
							<td>
								<input class="inp_txt" id="engNm" name="engNm" title="영문시설명" style="width:87%;" type="text" maxlength="100"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="engKeyWord1" id="engKeyWordTR">영문키워드</label></th>
							<td class="brn srch_label">
								<input class="inp_txt" id="engKeyWord1" name="engKeyWord1" title="영문키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="engKeyWord2" name="engKeyWord2" title="영문키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="engKeyWord3" name="engKeyWord3" title="영문키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="engKeyWord4" name="engKeyWord4" title="영문키워드" style="width:110px;" type="text" maxlength="15"/>
								<input class="inp_txt" id="engKeyWord5" name="engKeyWord5" title="영문키워드" style="width:110px;" type="text" maxlength="15"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="manufactureNm"> * 제조사</label></th>
							<td>
								<input class="inp_txt" id="manufactureNm" maxlength="50" name="manufactureNm" style="width:87%;" type="text" value="" />
							</td>
						</tr>
						<tr id="modelTr">
							<th scope="row"><label for="modelFind"> * 모델명</label></th>
							<td>
				 				<!--<input id="modelCd" name="modelCd" type="hidden" value="" /> -->
  								<!--<input id="modelNm" name="modelNm" style="width:40%;background-color:#dddddd;" type="text" value="" readonly="readonly"/> -->
								<input class="inp_txt" id="modelNm" name="modelNm" style="width:87%;" type="text" value="" maxlength="50"/>
 								<!--<input id="modelFind" name = "modelFind" title="제작사,모델찾기버튼" type="button" value="찾기" onclick="modelFind()"/> -->
								<input id="modelNone" name = "modelNone" title="모델명 없음" type="checkbox" onclick="modelNoneCheck()"/><label for="modelNone">모델명 없음</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="branchNm"> * 국가연구시설장비<br/>표준분류체계</label></th>
							<td>
							<select class="select_box" name="branchCd1" id="branchCd1" onchange="branchCall(this.value,'M')" style="width:172px">
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
							<select class="select_box" name="branchCd2" id="branchCd2" onchange="branchCall(this.value,'S')" style="width:210px">
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
											<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %>><%=util.getStr(rs.get("CODE_NM"))%></option>
									<%}
								}%>
							</select>
							<select class="select_box" name="branchCd3" id="branchCd3" onchange="branchCall(this.value,'')" style="width:210px">
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
											<option value="<%=util.getStr(rs.get("CODE_CD"))%>" <%=selectedYN %>><%=util.getStr(rs.get("CODE_NM"))%></option>
									<%}
								}%>
							</select>
							<br/>
								<input class="inp_txt" id="branchNm" name="branchNm" title="연구시설장비표준분류체계" style="width:599px;" type="text" value="<%=util.getStr(util.getStr(dataMap.get("BRANCH_NM"))) %>" readonly="readonly"/>
								<%-- <input id="branchCd" name="branchCd" title="연구시설장비표준분류체계" readonly="readonly" type="hidden" value="<%=util.getStr(util.getStr(dataMap.get("BRANCH_CD"))) %>"/> --%>
								<a href="/file/branchPdf.pdf" target="_blank" class="btn_inp_w_01">표준분류체계PDF파일보기</a>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="takeCd" id="take"> * 구축방법</label></th>
							<td>
								<input id="takeCd1" name="takeCd" title="구축방법" type="radio" value="1"/><label for="takeCd1"> 구매</label>
								<input id="takeCd2" name="takeCd" title="구축방법" type="radio" value="2"/><label for="takeCd2"> 개발</label>
							</td>
						</tr>
						<tr id="takeCdChange3" >
							<th scope="row">
								<div class="equipCdOption" id="equiCdpsubDetail">
									<label for="takeSdt"> * 구축기간</label>
								</div>
							</th>
							<td>
								<div class="equipCdOption" id="equiCdpsubDetail1">
									<input class="inp_txt" id="takeSdt" name="takeSdt" title="구축일자(개발, 시설 선택 시)" type="text" value="" style="width:140px;" readonly="readonly"/>
									~
									<input class="inp_txt" id="takeEdt" name="takeEdt" title="구축일자(개발, 시설 선택 시)" type="text" value="" style="width:140px;" readonly="readonly"/>
								</div>
							</td>
						</tr>
						<tr>
                			<th scope="row"><label for="fileList" id="fileImage"> * 시설사진</label></th>
                			<td>
				              	<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
				              		<div >
				              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" title="파일첨부" />
									</div>
				              	</div>

				              	<div style="display:inline-block;vertical-align:bottom;">
				              		<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
									<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
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
								<br/> * 300kb이상 217px * 217px 사이즈의 이미지만 등록해주세요.
	              			</td>
                		</tr>
						</tbody>
					</table>

					<%--/////////////////////////2단계/////////////////////style="display:none;"--%>
					<table id ="step2" summary="연구시설의 상세정보입력" class="skin_basic_write">
						<caption>연구시설 상세정보</caption>
						<colgroup>
	               			<col style="width: 220px;" />
	       					<col style="width: *;">
	                	</colgroup>
	                	<tbody>

						<!--연구과제정보&구축금액-->
						<tr>
							<th scope="row"><label for="rndY"> * 연구과제정보</label></th>
							<td>
								<label><input id="rndY" name="rndYN" type="radio" value="Y" /> R&D과제 (연구개발사업 조사분석대상)</label>
								<input class="inp_txt" id="rndInfo" name="rndInfo" value="" maxlength="30" style="width: 250px; display:none;"/>
								<label><input id="rndN" name="rndYN" type="radio" value="N" /> 비 R&D과제</label>
							</td>
						</tr>
						<tr>
							<th scope="row">구축금액</th>
							<td>
								<span style="color:orange">
									 * 대형연구시설이 아닌경우, 특수설비비에 구축금액을 입력해 주십시오.<br/>
									 * 토지비와 건물비, 연구장비비는 기본 '0'원으로 셋팅되어 있는데, 만약 해당 금액이 있을 경우 직접 Text로 입력해주시기 바랍니다.
								</span>
								<table style="width:100%" class="skin_basic_write" class="skin_basic_write">
									<colgroup>
										<col style="width: 14%;">
										<col style="width: 20%;">
										<col style="width: 13%;">
										<col style="width: 20%;">
										<col style="width: 13%;">
										<col style="width: 20%;">
									</colgroup>
									<tbody>
										<tr>
											<th rowspan="2">토지비</th>
											<td><input class="inp_txt" type="text" style="width:60%;" id="landPrc" name="landPrc" value="0" onkeyup="korNumTrans(this.value,'landPrcKor');"/> (원)</td>
											<th>면적</th>
											<td colspan="3"><input class="inp_txt"type="text" style="width:25%;" id="landArea" name="landArea" value="0" /> ㎡</td>
										</tr>
										<tr>
											<td colspan="5"><span id = "landPrcKor"></span></td>
										</tr>
										<tr id = "noneLandReason" style="display:none">
											<th>사유</th>
											<td colspan="5">
												<input class="inp_txt" type="text" id="landReason" name="landReason" style="width:60%"/>
												<input type="checkbox" id="groundPrcYn" name="groundPrcYn" value="Y"/>
												<label for="groundPrcYn">토지가 없음</label>
											</td>
										</tr>
										<tr>
											<th rowspan="2">건물비</th>
											<td><input class="inp_txt" type="text" style="width:60%;" id="buildPrc" name="buildPrc" value="0" onkeyup="korNumTrans(this.value,'buildPrcKor');"/> (원)</td>
											<th>면적</th>
											<td colspan="3"><input class="inp_txt" type="text" style="width:25%;" id="buildArea" name="buildArea" value = "0" /> ㎡</td>
										</tr>
										<tr >
											<td colspan="5"><span id="buildPrcKor"></span></td>
										</tr>
										<tr>
											<th>지상층수</th>
											<td><input class="inp_txt" type="text" style="width:60%;" id="floorUp" name="floorUp" value="0" /> (층)</td>
											<th>지하층수</th>
											<td colspan="3"><input class="inp_txt" type="text" style="width:25%;" id="floorDown" name="floorDown" value = "0" /> (층)</td>
										</tr>
										<tr id = "noneBuildReason" style="display:none;">
											<th>사유</th>
											<td colspan="5">
												<input class="inp_txt" type="text" style="width:60%" id="buildReason" name="buildReason"/>
												<input type="checkbox" id="buildPrcYN" name="buildPrcYN" value="Y"/>
												<label for="buildPrcYN">건물이 없음</label>
											</td>
										</tr>
										<tr>
											<th rowspan="2">특수설비비</th>
											<td colspan="5">
												<input class="inp_txt" type="text" style="width:18%;" id="equipFacilitiesTakePrc" name="equipFacilitiesTakePrc" value="0" onkeyup="korNumTrans(this.value,'equipFacilitiesTakePrcKor')"/> (원)
												<span style="float:right">
													<input type="checkbox" onclick = "equipFacilitiesYNCheck()" id="equipFacilitiesY" name = "equipFacilitiesYN" value = "Y" /><label for="equipFacilitiesY"> 특수설비비 없음</label>
													<input type="checkbox" onclick = "equipFacilitiesYNCheck()" id="equipFacilitiesN" name = "equipFacilitiesYN" value = "N" /><label for="equipFacilitiesN"> 건물비 포함</label>
												</span>
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<span id="equipFacilitiesTakePrcKor"></span>
											</td>
										</tr>
										<tr>
											<th rowspan="2">연구장비비</th>
											<td colspan="5">
												<input class="inp_txt" type="text" style="width:18%;" id="equipTakePrc" name="equipTakePrc" value = "0" onkeyup="korNumTrans(this.value,'equipTakePrcKor')"/> (원)
												<span style="float:right">
													<input id="equipTakePrcNoneYN" onclick="equipTakePrcNoneCheck()" name="equipTakePrcNoneYN" title="연구장비비없음" type="checkbox"/>
													<label for="equipTakePrcNoneYN">연구장비 없음</label>
	 												<!--<input type="button" value="연구장비선택" onclick="alert('미실장');"/> -->
 												</span>
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<span id= "equipTakePrcKor"></span>
											</td>
										</tr>
										<tr>
											<th rowspan="2">3천만원 미만<br/>연구장비</th>
											<td colspan="5">
												<input class="inp_txt" type="text" style="width:18%;" id="equipLittleTakePrc" name = "equipLittleTakePrc" value = "0" onkeyup="korNumTrans(this.value,'equipLittleTakePrcKor')"/> (원)
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<span id="equipLittleTakePrcKor"></span>
											</td>
										</tr>
										<tr>
											<th rowspan="2">총 구축금액</th>
											<td><input class="inp_txt" type="text" style="width:60%;background-color:#0F0F0F0F;" id="takePrc" name="takePrc" value="0" readonly="readonly"> (원)</td>
											<th>국산금액</th>
											<td><input class="inp_txt" type="text" style="width:60%;" id="takePrcForeign" name="takePrcForeign" value="0" onkeyup="korNumTrans(this.value)"> (원)</td>
											<th>외산금액</th>
											<td><input class="inp_txt" type="text" style="width:60%;" id="takePrcDomestic" name="takePrcDomestic" value="0" onkeyup="korNumTrans(this.value)"> (원)</td>
										</tr>
										<tr>
											<td colspan="6"><span id="takePrcKor"></span></td>
										</tr>
									</table>
							</td>
						</tr>
						<tr class="equipRegistOption" id="useScopeCdTR" title="주장비 추가등록 옵션" >
							<th scope="row"><label for="modelSearchLayer"> * 활용범위</label></th>
							<td>
								<input id="useScopeCd1" name="useScopeCd" type="radio" value="1"/><label for="useScopeCd1"> 단독활용만 가능</label>
								<input id="useScopeCd2" name="useScopeCd" type="radio" value="2"/><label for="useScopeCd2"> 공동활용허용가능</label>
								<input id="useScopeCd3" name="useScopeCd" type="radio" value="3"/><label for="useScopeCd3"> 공동활용서비스가능</label>
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="equip_main_detail()" />
							</td>
						</tr>
						<tr class="useScopeCd" id="useScopeCd_1" style="display:none;">
							<th scope="row"><label for="useScopeReason"> * 단독활용사유</label></th>
							<td>
								<select class="select_box" id="useScopeReason" name="useScopeReason" title="단독활용사유" style="width:95%">
									<option value="">선택</option>
									<option value="01">자체 수요가 많아 내부 활용도가 매우 높은 장비(장비가동률 100%, 년간 2000시간 이상 장비)</option>
									<option value="02">시작품 시제품 수준으로 아직 시험운영중이거나 요소 부품 및 기술 개발중인 장비</option>
									<option value="03">특수목적용 장비로서 반드시 자체 특화된 연구에만 전용되어야 하는 장비</option>
									<option value="04">상시 모니터링 및 계측용으로 연중 실시간 또는 지속적으로 활용되어지는 장비</option>
									<option value="05">국가안보, 기술유출 등으로 보안 및 기밀유지가 요구되는 장비</option>
									<option value="06">위험물질 취급 및 고위험성으로 인하여 이용이 제한되어 있는 장비</option>
									<option value="07">초고감도 정밀장비로 오염 및 손상시 복구가 불가능한 장비</option>
									<option value="08">라이센스 계약에 묶여있어 타이용자가 사용이 불가능한 장비</option>
									<option value="09">기타</option>
								</select>
							</td>
						</tr>
						<tr class="table01" id="useScopeRangeDiv" style="display:none;">
							<th scope="row"><label for="useScopeRange"> * 활용대상</label></th>
							<td>
									<input id="useScopeRange01" name="useScopeRange" type="radio" value="기관내부활용"/><label for="useScopeRange01"> 기관내부활용</label>
									<input id="useScopeRange02" name="useScopeRange" type="radio" value="기관외부활용"/><label for="useScopeRange02"> 기관외부활용</label>

							</td>
						</tr>
						<tr class="table01" id=useScopeMeanDiv style="display:none;">
							<th scope="row"><label for="useScopeMean"> * 이용방법</label></th>
							<td>
									<input id="useScopeMean01" name="useScopeMean" type="radio" value="이용자 직접사용"/><label for="useScopeMean01"> 이용자 직접사용</label>
									<input id="useScopeMean02" name="useScopeMean" type="radio" value="분석&middot;시험 의뢰"/><label for="useScopeMean02"> 분석&middot;시험 의뢰</label>
									<input id="useScopeMean04" name="useScopeMean" type="radio" value="대여"/><label for="useScopeMean04"> 대여</label>
									<input id="useScopeMean03" name="useScopeMean" type="radio" value="모두 가능"/><label for="useScopeMean03"> 모두 가능</label>
							</td>
						</tr>
						<tr class="equipRegistOption" id="equipuseTypeCd" title="시험용도" style="display:none;">
							<th scope="row"><label for="useTypeCd"> * 시설용도</label></th>
							<td>
								<input id="useTypeCd01" name="useTypeCd" type="radio" value="시험용"/><label for="useTypeCd01"> 시험용</label>
								<input id="useTypeCd02" name="useTypeCd" type="radio" value="분석용"/><label for="useTypeCd02"> 분석용</label>
								<input id="useTypeCd03" name="useTypeCd" type="radio" value="교육용"/><label for="useTypeCd03"> 교육용</label>
								<input id="useTypeCd04" name="useTypeCd" type="radio" value="계측용"/><label for="useTypeCd04"> 계측용</label>
								<input id="useTypeCd05" name="useTypeCd" type="radio" value="생산용"/><label for="useTypeCd05"> 생산용</label>
								<input id="useTypeCd06" name="useTypeCd" type="radio" value="기타"/><label  for="useTypeCd06"> 기타</label>
							</td>
						</tr>
						<tr class="useTypeCd" id="useTypeCd_06" style="display:none">
							<th scope="row"> 시설용도사유</th>
							<td><input class="inp_txt" id="useTypeReason" name="useTypeReason" style="width:87%;" type="text" value=""/></td>
						</tr>
						<tr class="equipRegistOption" id="equipIdleDisuseCd" title="시설상태">
							<th scope="row"><label for="idleDisuseCd"> * 시설상태</label></th>
							<td>
								<input id="idleDisuseCd1" name="idleDisuseCd" type="radio" value="01"/><label for="idleDisuseCd1"> 활용</label>
								<input id="idleDisuseCd2" name="idleDisuseCd" type="radio" value="02"/><label for="idleDisuseCd2"> 저활용</label>
								<input id="idleDisuseCd3" name="idleDisuseCd" type="radio" value="03"/><label for="idleDisuseCd3"> 유휴</label>
								<input id="idleDisuseCd4" name="idleDisuseCd" type="radio" value="04"/><label for="idleDisuseCd4"> 불용</label>
								<!-- <input id="idleDisuseCd5" name="idleDisuseCd" type="radio" value="05"/><label for="idleDisuseCd5">대여</label>-->
								&nbsp;&nbsp;<input type="button" value="자세히보기" class="btn_inp_y_01" onclick="idle_disuse_detail()">
							</td>
						</tr>
						<tr id="disuseVerdictDt_4" class="disuseVerdictDt" style="display:none;">
							<th scope="row"><label for="disuseVerdictDt"> * 불용판정일자</label></th>
							<td>
								<input class="inp_txt" id="disuseVerdictDt" name="disuseVerdictDt" style="width:135px;" type="text" value="" readonly="readonly"/>
							</td>
						</tr>
						<tr id="idleDisuseCd_4" class="idleDisuseCd" style="display:none;">
							<th scope="row"><label for="disuseCd"> * 불용처분</label></th>
							<td>
								<input id="disuseCd01" name="disuseType" type="radio" value="01"/><label for="disuseCd01"> 매각</label>
								<input id="disuseCd02" name="disuseType" type="radio" value="02"/><label for="disuseCd02"> 재활용</label>
								<input id="disuseCd03" name="disuseType" type="radio" value="03"/><label for="disuseCd03"> 폐기</label>
								<input id="disuseCd04" name="disuseType" type="radio" value="04"/><label for="disuseCd04"> 양여</label>
								<input id="disuseCd05" name="disuseType" type="radio" value="05"/><label for="disuseCd05"> 대여</label>
								<br/><span class="f_orange mb5"> ※ 장비처분 시, 해당 기관의 ‘장비심의위원회’의 승인사항입니다.</span>
							</td>
						</tr>

						<tr id="trDisuseCd" class="disuseCd" style="display:none;">
							<th scope="row">
								<span id="thDisuseCd_01" style="display:none"> * 매각일자</span>
								<span id="thDisuseCd_02" style="display:none"> * 재활용일자</span>
								<span id="thDisuseCd_03" style="display:none"> * 폐기일자</span>
								<span id="thDisuseCd_04" style="display:none"> * 양여기관</span>
								<span id="thDisuseCd_05" style="display:none"> * 대여기관</span>
							</th>
							<td>
 								<input id="disuseOrgan" name="disuseOrgan" type="text" value="" style="background-color:#0F0F0F;"/>
								<!--<input id="disuseOrganFinder" onclick="alert('미실장');" type = "button" value="찾기"/> -->

								<input class="inp_txt" id="disuseDt" name="disuseDt" style="width:135px;" type="text" value="" readonly="readonly"/>
								<p id="pDisuseCd_01" style="display:none"><span class="f_blue">(매각일자가 불용판정일자와 다를 경우, 매각된 일자로 수정해주세요)</span></p>
								<p id="pDisuseCd_02" style="display:none"><span class="f_blue">(재활용일자가 불용판정일자와 다를 경우, 재활용된 일자로 수정해주세요)</span></p>
								<p id="pDisuseCd_03" style="display:none"><span class="f_blue">(폐기일자가 불용판정일자와 다를 경우, 폐기된 일자로 수정해주세요)</span></p>
								<p id="pDisuseCd_04" style="display:none"><span class="f_blue">(양여일자가 불용판정일자와 다를 경우, 양여된 일자로 수정해주세요)</span></p>
								<p id="pDisuseCd_05" style="display:none"><span class="f_blue">(대여일자가 불용판정일자와 다를 경우, 대여된 일자로 수정해주세요)</span></p>
							</td>
						</tr>
						<tr>
							<th scope="row" ><span> * </span>지역명</th>
							<td>
								&nbsp;&nbsp;전라남도 <input type="radio" name="area" id="utilityArea1" value="1"  checked="checked" onclick="radio_area('utilitysearchArea','1')"/>
								&nbsp;&nbsp;전라남도 외 지역 <input type="radio" name="area" id="utilityArea2" value="2"  onclick="radio_area('utilitysearchArea','2')"/>&nbsp;&nbsp;
								<select class="p_select" name="areaSigungu" id="utilitysearchArea1">
									<option value="">선택하세요</option>
									<%
										int utilitynumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea++; } %>
								</select>
								<select class="p_select" name="areaSigungu" id="utilitysearchArea2" style="display:none;">
									<option value="">선택하세요</option>
									<%
										int utilitynumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea2++; } %>
								</select>
							</td>
						</tr>
						<tr>
                			<th scope="row"><label for="takeCd" id="take"> * 설치장소</label></th>
                			<td>
	                			<div>
									<input class="inp_txt" type="text" value="" name = "location" id = "location" style="width:255px;" maxlength="100" readonly/>
	                				<input class="inp_txt" type="text" value="" name = "locationDtl" id = "locationDtl" style="width:255px;" maxlength="100" readonly/>
	                				<input type="button" class="btn_inp_w_01" value="기관정보 불러오기" onclick="callOrgDeptInfo('org')"/>
	                				<input type="button" class="btn_inp_w_01" value="부서정보 불러오기" onclick="callOrgDeptInfo('dept')"/>
								</div>

                				<input type="checkbox" id="newLocation" name="newLocation" value="Y" onclick="if($('#newLocation:checked').val() == 'Y') {$('#nLocationDiv').show(); $('#location').val(''); $('#locationDtl').val(''); }else {$('#nLocationDiv').hide(); $('#nlocation').val(''); $('#nlocationDtl').val('');}"/>
								<label for="newLocation">새로운 설치장소 입력</label>

                				<div id="nLocationDiv" style="display: none;">
                					<!-- 주소등록 -->
									<input class="inp_txt" type="text" name="location" id="nLocation" value="" style="width:255px;" maxlength="100" />
									<input class="inp_txt" type="text" name="locationDtl" id="nlocationDtl" value="" style="width:255px;" maxlength="100" />
									<input type="button" id="nLocationFind" value="찾아보기" class="btn_inp_g_01" onclick="placeFind('nLocation')">
								</div>
                			</td>
                		</tr>
						<tr>
							<th scope="row">
								<label for="orgNm" id = "ownOrgNmLB"> * 보유기관</label>
							</th>
							<td>
								<input class="inp_txt" type="hidden" name="ownOrg" id="orgGrpCd" maxlength="20" />
								<input class="inp_txt" type="text" name="ownOrgNm" id="orgNm" style="width:30%;" maxlength="20" onkeydown='$("#orgGrpCd").val("")'/>
								<input type="button" name="orgData" id="orgData" class="btn_inp_g_01" value="보유기관 조회" onclick="popupWindow('orgManagePop')">
 								<!--<input type="text" name = "ownOrg" id = "ownOrg" maxlength="20"/> -->
							</td>
						</tr>
						
						
						<tr>
							<th scope="row">
								<label for="orgSubNm" id = "orgSubNmLB"> * 보유부서</label>
							</th>
							<td>
								<input class="inp_txt" type="hidden" name="ownOrgSub" id="orgSubGrpCd" maxlength="20" />
								<input class="inp_txt" type="text" name="ownOrgSubNm" id="orgSubNm" style="width:30%;" maxlength="20" onkeydown='$("#orgSubGrpCd").val("")'/>
								<input type="button" name="orgSubData" id="orgSubData" class="btn_inp_g_01" value="보유부서 조회" onclick="popupWindow('orgSubManagePop')">
 								<!--<input type="text" name = "ownOrg" id = "ownOrg" maxlength="20"/> -->
							</td>
						</tr>
						
						
						<tr>
							<th scope="row"><label for="capability"> * 구성 및 성능</label></th>
							<td>
								<textarea id="capability" name="equipDetailCapability" title="구성 및 기능" style="width:100%;" rows="10" cols="10" ></textarea>
 								<!--<br/> * 50자 이상 입력해주세요 -->
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="example"> * 사용예</label></th>
							<td>
								<textarea id="example" name="equipDetailExample" title="사용예" style="width:100%;" rows="10" cols="10" ></textarea>
 								<!--<br/> * 50자 이상 입력해주세요 -->
							</td>
						</tr>
						<tr>
							<th scope="row"> * 5대 중점투자분야</th>
							<td>
								<select class="select_box" id="importCd" name="importCd" title="5대 중점투자분야">
									<option value="">:: 중점투자분야선택 ::</option>
									<option value="1">국가주도기술 핵심역량 확보</option>
									<option value="2">글로벌 이슈대응 연구개발 추진</option>
									<option value="3">기초과학·융합기술 연구개발 활성화</option>
									<option value="4">신산업 창출 핵심기술개발 강화</option>
									<option value="5">주력기간산업 기술 고도화</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="equipCd"> * 담당자 정보</label></th>
                			<td>
	                			<input type="hidden" name="equUserIdx" id="equUserIdx" maxlength="10" value="<%=userIdx%>"/>
	                			<input type="button" name="operData" id="operData" value="담당자정보 조회" class="btn_inp_g_01" onclick="popupWindow('orgUserPop')">

	                			<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operOrgGrp" id="operOrgGrp" value="<%=orgGrpNm%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operOrgGrpSub" id="operOrgGrpSub" value="<%=deptNm%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operChargerTd" id="operChargerTd" value="<%=psnNm%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operPositionTd" id="operPositionTd" value="<%=positionNm%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="operTelTd" id="operTelTd" value="<%=telNo%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>이메일</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="operEmailTd" id="operEmailTd" value="<%=email%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>

	                			</table>

                			</td>
						</tr>
	                	</tbody>
	               </table>

				   <%--/////////////////////////3단계///////////////////// style="display:none;"--%>
	               <input id="rsvYnY" name="rsvYn" title="연구장비" type="hidden" value="Y" />
	               <table id ="step3" summary="연구장비의 상세정보입력" class="skin_basic_write">
						<caption>연구시설 상세정보</caption>
						<colgroup>
	               			<col style="width: 220px;" />
	       					<col style="width: *;">
	                	</colgroup>
	                	<tbody>
						<!-- <tr>
							<th scope="row"> * 예약가능여부</th>
							<td>
								<input id="rsvYnY" name="rsvYn" title="연구장비" type="radio" value="Y" checked="checked"/><label for="rsvYnY"> 예약가능</label>
								<input id="rsvYnN" name="rsvYn" title="연구장비" type="radio" value="N" /><label for="rsvYnN"> 예약불가</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="refRsvTel" id="refRsvTelLB"> * 예약문의연락처</label></th>
							<td>
								<input class="inp_txt" type="text" name="refRsvTel" id="refRsvTel" style="width:25%;" maxlength="20"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="refEquTel" id="refEquTelLB"> * 장비문의연락처</label></th>
							<td>
								<input class="inp_txt" type="text" name="refEquTel" id="refEquTel" style="width:25%;" maxlength="20"/>
							</td>
						</tr>

						주소등록
						<tr>
							<th scope="row"><label for="rscPlace"> * 시설주소</label></th>
							<td>
								<input class="inp_txt" type="text" name="rscPlace" id="rscPlace" value="" style="width: 70%;" maxlength="100" />
								<input type="button" id="rscPlaceFind" value="찾아보기" class="btn_inp_g_01" onclick="placeFind('rscPlace')">
								<br>
								<input class="inp_txt" type="text" name="rscPlaceDetail" id="rscPlaceDetail" value="" style="width: 70%;" maxlength="100" />
							</td>
						</tr>

						지도구현
						<tr id="mapTr" style="display:none;">
							<th scope="row"><label for="rscPlace"> * 지도</label>	</th>
							<td>
								X축
								<input type="hidden" maxlength="20" class="inputBox_1" id="mapX" name="mapX" value=""/>
								Y축
								<input type="hidden" maxlength="20" class="inputBox_1" id="mapY" name="mapY" value=""/>
								<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr> -->

						<tr>
							<th scope="row">
								<label for="howUse" id = "howUseLB"> * 이용방법</label>
							</th>
							<td>
								<textarea id="howUse" name="howUse" title="이용방법" style="width:100%;" rows="10" cols="10" ></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="equAttention" id = "equAttentionLB"> * 유의사항</label>
							</th>
							<td>
								<textarea id="equAttention" name="equAttention" title="유의사항" style="width:100%;" rows="10" cols="10" ></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="rentalInfo" id = "rentalInfoLB"> * 이용료 안내</label>
							</th>
							<td>
								<textarea id="rentalInfo" name="rentalInfo" title="이용료 안내" style="width:100%;" rows="10" cols="10" ></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label for="useMarkText" id = "useMarkTextLB"> * 이용신청서표기문구</label>
							</th>
							<td>
								<p>예시) (재)전남테크노파크 전남과학기술진흥센터장 귀하</p>
								<input class="inp_txt" type="text" name="useMarkText" id="useMarkText" style="width:100%;" maxlength="100"  />
							</td>
						</tr>
						</tbody>
	                </table>

	                <div class="btn_box">
                		<div class="btn_right_box" >
							<button class="btn_inp_b_01" type="button" onclick="submitGo()">등록</button>
                			<input class="btn_inp_w_01" type="button" onclick="window.location.href='/sys/sys_jnsptotal_eq.do'" value="목록"/>
                		</div>
	               </div>
				</div>
			</div>
	</div>
	</form>



<script type="text/javascript">

	function equipTakePrcNoneCheck(){
		if($("#equipTakePrcNoneYN").is(":checked")){
		   $("#equipTakePrc").attr("readonly", true);
		   $("#equipTakePrc").val("0");
		}else{
		   $("#equipTakePrc").removeAttr("readonly");
		}
		korNumTrans('0','equipTakePrcKor');
	}

	function equipFacilitiesYNCheck(){
		if($("input[name='equipFacilitiesYN']").is(":checked")){
			$("#equipFacilitiesTakePrc").attr("readonly", true);
			$("#equipFacilitiesTakePrc").val("0");
		}else{
			$("#equipFacilitiesTakePrc").removeAttr("readonly");
		}
		korNumTrans('0','equipFacilitiesTakePrcKor');
	}

	function callOrgDeptInfo(calltype){

		$("#newLocation").attr("checked", false);
		$("#nLocation").val(''); //초기화
		$("#nLocationDtl").val(''); //초기화
		$("#nLocationDiv").hide();

		$.ajax({
	         type: "POST",
	         url : '/sys/deptInfoCall.do',
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

	     			if(calltype == 'dept'){
	     				if(deptAddr == "" || deptAddr == null){
	     					alert("부서정보가 없습니다.");
	     					return;
	     				}
	     			}

	     			if(calltype == 'org'){
	     				if(orgAddr == "" || orgAddr == null){
		     				alert("기관정보가 없습니다.");
		     				return;
	     				}
	     			}

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

	function modelFind(){
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
	}

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

	function AsetNone(){
		  if (this.checked) {
			  	$("#fixedAsetNo").attr("readonly", true);
			  	$("#fixedAsetNo").val("");
			  	$("#fixedAsetNo").hide();
			  	$("#fixedAsetCheck").hide();
			  	$("#fixedAsetCheckVal").val("N");
		  } else {
				$("#fixedAsetNo").removeAttr("readonly");
				$("#fixedAsetNo").show();
				$("#fixedAsetCheck").show();
				$("#fixedAsetCheckVal").val("Y");
		  }
	}

	function LargeFacYn(){
		  if (this.checked) {
			  	$("#korLargeFacSearch").show();
		  } else {
				$("#korLargeFacSearch").hide();
		  }
	}

	function korNumTrans(thisVal,targetID){
			var num = thisVal;
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
					if(i > 15){alert("금액이 너무 많습니다.");return false;}

					result = str + result;
				}
			}
			result = result != "" ? "["+result+"]" : "";
			if(targetID!=undefined&&targetID!=null&&targetID!=""){
				$("#"+targetID).html(result);
			}
			korNumTotalTrans();
	}

	function korNumTotalTrans(){

		var num = "0";
		var TotalIdArray = new Array("equipFacilitiesTakePrc","landPrc","buildPrc","equipTakePrc","equipLittleTakePrc","takePrcForeign","takePrcDomestic");


		for(idx=0; idx<TotalIdArray.length; idx++) {
			var totalNum = Number($("#"+TotalIdArray[idx]).val());
			if(!isNaN(totalNum)&&totalNum!=null&&totalNum!=""){
				num = Number(num) + Number(totalNum);
			};
		}

		var NumArray = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
		var unitArray = new Array("","십","백","천");
		var result = "";

		//int형 string형변환
		num = num+"";

			for(var i=0; i<num.length; i++) {
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
		result = result != "" ? "["+result+"]" : "";
		$("#takePrc").val(num);
		$("#takePrcKor").html(result);
	}

	function submitGo(){

		var errMsg = "";


		//////////////////////////1단계//////////////////////////////

		/* if(!$("input[name='registCd']").is(":checked")){
			errMsg+="시설구분 : 필수입력사항입니다."+"<br/>";
		}

		if($('#rscPlace').val() == ""){
			alert("시설주소를 입력해주세요");
			$("#rscPlace").focus();
			return false;
		} */

		if($("input[type=radio][name='registCd']:checked").val()==2){
				/* if($("#eqcpId").val()==null || $("#eqcpId").val()==""||$("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
					errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
				}*/
				/* if($("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
					errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
				}*/
		}


		if(!$("input[type=radio][name='ntisEquipInfoYN']").is(":checked")){
				errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
		}
		if($("input[type=radio][name='ntisEquipInfoYN']:checked").val()=="Y"){
			if($("#ntisEquipInfo").val()==null || $("#ntisEquipInfo").val()==""){
				errMsg+="NTIS 등록번호 : 필수입력사항입니다."+"<br/>";
			}
		}


		if(!$("#fixedAsetNone").is(":checked")){
			if($("#fixedAsetNo").val()==null || $("#fixedAsetNo").val()==""){
				//alert("고정자산관리번호를 입력해주세요.");
				errMsg+="고정자산관리번호 : 필수입력사항입니다."+"<br/>";
				//$("#fixedAsetNo").focus();
				//return false;
			}

			if($("#fixedAsetCheckVal").val()!="Y"){
				//alert("이중등록여부를 확인하여주세요.");
				errMsg+="고정자산관리번호 : 이중등록여부를<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				errMsg+="확인하여주세요."+"<br/>";
				//$("#fixedAsetNo").focus();
				//return false;
			};
		}


		if($("#korNm").val()==null || $("#korNm").val()==""){
			//alert("한글시설명을 입력해주세요.");
			errMsg+="한글시설명 : 필수입력사항입니다."+"<br/>";
			//$("#korNm").focus();
			//return false;
		}


		if(!korPattern.test($("#korNm").val())){
			//alert("한글이 포함되어야합니다.");
			errMsg+="한글시설명 : 한글이 포함되어야합니다."+"<br/>";
			//$("#korNm").focus();
			//return false;
		}

		if($("#engNm").val()==null || $("#engNm").val()==""){
			//alert("영문시설명을 입력해주세요.");
			errMsg+="영문시설명 : 필수입력사항입니다."+"<br/>";
			//$("#engNm").focus();
			//return false;
		}

		if(!engPattern.test($("#engNm").val())){
			//alert("영문이 포함되어야합니다.");
			errMsg+="영문시설명 : 영문이 포함되어야합니다."+"<br/>";
			//$("#engNm").focus();
			//return false;
		}

		/*
		if(korPattern.test($("#engNm").val())){
			//alert("한글은 입력하실 수 없습니다.");
			errMsg+="영문시설명 : 한글은 입력하실 수 없습니다."+"<br/>";
			//$("#engNm").focus();
			//return false;
		}

		if(korPattern.test($("#modelNm").val())){
			//alert("모델명을 검색해주세요.");
			errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
			//modelFind();
			//return false;
		}
		*/

		if($("#manufactureNm").val()==null || $("#manufactureNm").val()==""){
			errMsg+="제조사 : 필수입력사항입니다."+"<br/>";
		}

		if(!$("#modelNone").is(":checked")){
			if($("#modelNm").val()==null || $("#modelNm").val()==""){
				//alert("모델명을 검색해주세요.");
				errMsg+="모델명 : 필수입력사항입니다."+"<br/>";
				//modelFind();
				//return false;
				}
		}

		/*
		if($("#branchCd").val()==null || $("#branchCd").val()==""){
			//alert("국가연구시설장비 표준분류체계를 입력해주세요.");
			errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
			//$("#branchNm").focus();
			//return false;
		}
		*/

		if($("#branchNm").val()==null || $("#branchNm").val()==""){
			//alert("국가연구시설장비 표준분류체계를 입력해주세요.");
			errMsg+="표준분류체계 : 필수입력사항입니다."+"<br/>";
			//$("#branchNm").focus();
			//return false;
		}

		if(!$("input[name='takeCd']").is(":checked")){
			//alert("구축방법을 선택해주세요.");
			errMsg+="구축방법 : 필수입력사항입니다."+"<br/>";
			//$("#takeCd1").focus();
			//return false;
		}

		if($("#takeSdt").val()==null || $("#takeSdt").val()==""){
			//alert("취득일자를 입력해주세요.");
			errMsg+="구축기간 : 필수입력사항입니다."+"<br/>";
			//$("#takeSdt").focus();
			//return false;
		}else if($("#takeEdt").val()==null || $("#takeEdt").val()==""){
			//alert("취득일자를 입력해주세요.");
			errMsg+="구축기간 : 필수입력사항입니다."+"<br/>";
			//$("#takeEdt").focus();
			//return false;
		}

		/*
		if(!$("input[name='takePrc']").is(":checked")){
			//alert("시설사진을 등록해주세요.");
			errMsg+="시설사진 : 필수입력사항입니다."+"<br/>";
			//$("#takeCd1").focus();
			//return false;
		}
		*/


		var fileCheck = 0;
		var fileCount = $("input[type=file]").length;

		for(i = 1; i <= fileCount; i++) {
			var fileName = $('#jnsptotalFile'+i).val();
			alert(fileName);
			if( fileName != "" && fileName != null){
				fileCheck++;
			}
		}
		if(fileCheck == 0)
		{
			//alert("1개이상의 첨부파일을 등록해주세요.");
			errMsg+="시설사진 : 필수입력사항입니다.<br/>";
			//return false;
		}

		//////////////////////////2단계//////////////////////////////
		if(!$("input[name='rndYN']").is(":checked")){
			errMsg+="과제정보 : 필수입력사항입니다."+"<br/>";
		}else if($("#rndInfo").val()=='' || $("#rndInfo").val()==null){
			if($("input[type=radio][name='rndYN']:checked").val()=='Y'){
				errMsg+="과제정보 : 필수입력사항입니다."+"<br/>";
			}
		}

		if($("#landPrc").val()=='' || $("#landPrc").val()==null){
			errMsg+="토지비 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#landPrc").val()) == true){
			errMsg+="토지비 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#landArea").val()=='' || $("#landArea").val()==null){
			errMsg+="토지면적 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#landArea").val()) == true){
			errMsg+="토지면적 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#buildPrc").val()=='' || $("#buildPrc").val()==null){
			errMsg+="건물비 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#buildPrc").val()) == true){
			errMsg+="건물비 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#buildArea").val()=='' || $("#buildArea").val()==null){
			errMsg+="건물면적 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#buildArea").val()) == true){
			errMsg+="건물면적 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#floorUp").val()=='' || $("#floorUp").val()==null){
			errMsg+="지상층수 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#floorUp").val()) == true){
			errMsg+="지상층수 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#floorDown").val()=='' || $("#floorDown").val()==null){
			errMsg+="지하층수 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#floorDown").val()) == true){
			errMsg+="지하층수 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#equipFacilitiesTakePrc").val()=='' || $("#equipFacilitiesTakePrc").val()==null){
			errMsg+="특수설비비 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#equipFacilitiesTakePrc").val()) == true){
			errMsg+="특수설비비 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#equipTakePrc").val()=='' || $("#equipTakePrc").val()==null){
			errMsg+="연구장비비 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#equipTakePrc").val()) == true){
			errMsg+="연구장비비 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#equipLittleTakePrc").val()=='' || $("#equipLittleTakePrc").val()==null){
			errMsg+="3천만원 미만 연구장비 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#equipLittleTakePrc").val()) == true){
			errMsg+="3천만원 미만 연구장비 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#takePrcForeign").val()=='' || $("#takePrcForeign").val()==null){
			errMsg+="국산금액 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#takePrcForeign").val()) == true){
			errMsg+="국산금액 : 숫자만 입력해주세요."+"<br/>";
		}

		if($("#takePrcDomestic").val()=='' || $("#takePrcDomestic").val()==null){
			errMsg+="외산금액 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#takePrcDomestic").val()) == true){
			errMsg+="외산금액 : 숫자만 입력해주세요."+"<br/>";
		}

		/* if($("#takePrc").val()=='' || $("#landPrc").val()==null){
			errMsg+="토지비 : 필수입력사항입니다."+"<br/>";
		}else if(isNaN($("#landPrc").val()) == true){
			errMsg+="토지비 : 숫자만 입력해주세요."+"<br/>";
		}*/
		/* if($("#eqcpNm").val()==null || $("#eqcpNm").val()==""){
			errMsg+="주장비 : 필수입력사항입니다."+"<br/>";
		}*/

		if(!$("input[name='idleDisuseCd']").is(":checked")){
			errMsg+="시설상태 : 필수입력사항입니다."+"<br/>";
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
			if($("#disuseOrgan").val()==null ||$("#disuseOrgan").val()==""){
				if($("input[type=radio][name='disuseType']:checked").val()=='04'){
					errMsg+="양여기관 : 필수입력사항입니다."+"<br/>";
				}else if($("input[type=radio][name='disuseType']:checked").val()=='04'){
					errMsg+="대여기관 : 필수입력사항입니다."+"<br/>";
				}
			}
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
			if(!$("input[name='useTypeCd']").is(":checked")){
				errMsg+="장비용도 : 필수입력사항입니다."+"<br/>";
			}
		}else{
			if($("#useScopeReason > option:selected").val()==null || $("#useScopeReason > option:selected").val()==""){
				errMsg+="단독활용사유 : 필수입력사항입니다."+"<br/>";
			}
		}

		if(!$("input[name='newLocation']").is(":checked")){
			if($("#location").val()==null || $("#location").val()==""){
				errMsg+="설치장소 : 필수입력사항입니다."+"<br/>";
			}
		}else{
			if($("#nLocation").val()==null || $("#nLocation").val()==""){
				errMsg+="설치장소 : 필수입력사항입니다."+"<br/>";
			}
		}
	/*
		if($("#feature").val()==null || $("#feature").val()==""){
			errMsg+="장비설명 : 필수입력사항입니다."+"<br/>";
		}else if($("#feature").val().length<50){
			//errMsg+="장비설명 : 50자이상 입력해주세요."+"<br/>";
		}
*/
		if($("#capability").val()==null || $("#capability").val()==""){
			errMsg+="구성 및 성능 : 필수입력사항입니다."+"<br/>";
		}else if($("#capability").val().length<50){
			//errMsg+="구성 및 성능 : 50자이상 입력해주세요."+"<br/>";
		}

		if($("#example").val()==null || $("#example").val()==""){
			errMsg+="사용예 : 필수입력사항입니다."+"<br/>";
		}
		/* else if($("#example").val().length<50){
			errMsg+="사용예 : 50자이상 입력해주세요."+"<br/>";
		} */

		if($("#importCd > option:selected").val()==null || $("#importCd > option:selected").val()==""){
			errMsg+="5대 중점투자분야 : 필수입력사항입니다."+"<br/>";
		}

		if($("#equUserIdx").val()==null || $("#equUserIdx").val()==""){
			errMsg+="담당자 : 필수입력사항입니다."+"<br/>";
		}

		/*
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
		*/

		///////////////////////////3단계////////////////////
		//if($("input[type=radio][name='rsvYn']:checked").val()=='Y'){
			/*
			if($("#refRsvTel").val()==null || $("#refRsvTel").val()==""){
				errMsg+="예약문의연락처 : 필수입력사항입니다."+"<br/>";
			}else if(!telPattern.test($('#refRsvTel').val())){
				errMsg+="예약문의연락처  : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
			}
			if($("#refEquTel").val()==null || $("#refEquTel").val()==""){
				errMsg+="장비문의연락처 : 필수입력사항입니다."+"<br/>";
			}else if(!telPattern.test($('#refEquTel').val())){
				errMsg+="장비문의연락처  : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
			}
			
			if($("#mapX").val()==null || $("#mapX").val()==""){
				errMsg+="장비위치 : 필수입력사항입니다."+"<br/>";
			}else if($("#mapY").val()==null || $("#mapY").val()==""){
				errMsg+="장비위치 : 필수입력사항입니다."+"<br/>";
			}
			
			if(isNaN($("#mapX").val())){
				errMsg+="장비위치 : 숫자만 입력하세요."+"<br/>";
			}else if(isNaN($("#mapY").val())){
				errMsg+="장비위치 : 숫자만 입력하세요."+"<br/>";
			}
			*/
			if($("#howUse").val()==null || $("#howUse").val()==""){
				errMsg+="이용방법 : 필수입력사항입니다."+"<br/>";
			}
			if($("#rentalInfo").val()==null || $("#rentalInfo").val()==""){
				errMsg+="이용료 안내 : 필수입력사항입니다."+"<br/>";
			}
			/*
			if($("#ownOrg").val()==null || $("#ownOrg").val()==""){
				errMsg+="보유 기관 : 필수입력사항입니다."+"<br/>";
			}
			*/
			if($("#orgNm").val()==null || $("#orgNm").val()==""){
				errMsg+="보유 기관 : 필수입력사항입니다."+"<br/>";
			}
			if($("#orgSubNm").val()==null || $("#orgSub").val()==""){
				errMsg+="보유 부서 : 필수입력사항입니다."+"<br/>";
			}
			if($("#equAttention").val()==null || $("#equAttention").val()==""){
				errMsg+="유의 사항 : 필수입력사항입니다."+"<br/>";
			}
			if($("#useMarkText").val()==null || $("#useMarkText").val()==""){
				errMsg+="이용신청서표기문구 : 필수입력사항입니다."+"<br/>";
			}
		//}

		if(errMsg==""){
			fwrite.submit();
		}else{
			errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
			errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;

			errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기' class='btn_inp_w_01'/></div>";
			errMsg+="</div>";
			$('#dataCheck').html(errMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
		 	//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();
			return false;
		}


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

	function modelNoneCheck(){
		if($("#modelNone").is(":checked")){
			$("#modelNm").attr("readonly", true);
			$("#modelNm").hide();
			$("#modelNm").val("");
		}else{
			$("#modelNm").removeAttr("readonly");
			$("#modelNm").show();
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
			detailMsg+="- 주시설이란?<br/> ‘추가적인 부대시설 없이도 본래의 구축 목적에 맞는 활용 및 성능을 발휘하는 핵심적인 시설’를 말함<br/><br/>";
			//detailMsg+="- 부대장비란?<br/>‘ 주장비의 일부분으로 규정하고, 주장비의 기본성능과 별도로 반드시 새로운 성능향상을 위하여 주장비에 부착하는 개념의 추가적인 장치’를 말함<br/><br/>";
			detailMsg+="- 보조시설이란?<br/> ‘주시설의 성능향상이 아니라, 본래 주시설의 구축 목적에 따라 시설이 정상적으로 가동되기 위한 보조시설·부속시설’을 말함<br/><br/>";
			//////////////내용삭제///////////////////
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기' class='btn_inp_w_01'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
			//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
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
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기' class='btn_inp_w_01'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
			//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
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
			detailMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기' class='btn_inp_w_01'/></div>";
			detailMsg+="</div>";
			$('#dataCheck').html(detailMsg);
			$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
			//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
			$("#dataCheck").css("top","200px");
			$('#dataCheck,#bgLayer').show();

	}


	// 주소검색 & 지도 스크립트
	/*---------지도 S-----------*/
	var korPattern = /[가-힣]/;
	var onlyKorPattern = /[^가-힣]/;
	var engPattern = /[a-zA-Z]/;
	var numPattern = /[\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
	var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

		//검색관련
		function placeFind(code){

			var code = code;

			new daum.Postcode({
				oncomplete: function(data) {

					if(code == 'rscPlace'){
						//$("#zipcode").val(data.zonecode);
						$("#rscPlace").val(data.address);
						$("#rscPlaceDetail").focus();
					}else{
						$("#nLocation").val(data.address);
						$("#nLocationDtl").focus();
					}

					/**/
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullAddr = data.address; // 최종 주소 변수
					var extraAddr = ''; // 조합형 주소 변수

					// 기본 주소가 도로명 타입일때 조합한다.
					if(data.addressType === 'R'){
						//법정동명이 있을 경우 추가한다.
						if(data.bname !== ''){
							extraAddr += data.bname;
						}
						// 건물명이 있을 경우 추가한다.
						if(data.buildingName !== ''){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
					}

					// 주소 정보를 해당 필드에 넣는다.
					//$("#location").val(fullAddr);

					if(code == 'rscPlace'){
						// 주소로 좌표를 검색
						geocoder.addr2coord(data.address, function(status, result) {

							// 정상적으로 검색이 완료됐으면
							if (status === daum.maps.services.Status.OK) {

								// 해당 주소에 대한 좌표를 받아서
								var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
								   $("#mapX").val(result.addr[0].lat);
								   $("#mapY").val(result.addr[0].lng);
								   //$("#mapTr").show();
								// 지도를 보여준다.
								mapContainer.style.display = "block";
								map.relayout();
								// 지도 중심을 변경한다.
								map.setCenter(coords);
								// 마커를 결과값으로 받은 위치로 옮긴다.
								marker.setPosition(coords)
							}
						});
					}

				}
			}).open();
		}

		//지도
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: new daum.maps.LatLng(35.2268795, 126.8429492),
				level: 5 // 지도의 확대 레벨
			};

		//지도를 미리 생성
		var map = new daum.maps.Map(mapContainer, mapOption);
		//주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new daum.maps.Marker({
			position: new daum.maps.LatLng(35.2268795, 126.8429492),
			map: map
		});

		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			   searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
					if (status === daum.maps.services.Status.OK) {

						  // 클릭한 위도, 경도 정보를 가져옵니다
						  var latlng = mouseEvent.latLng;
						  // 마커 위치를 클릭한 위치로 옮깁니다
						  marker.setPosition(latlng);

						  // 페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
					   	  // $("#location").val(result[0].jibunAddress.name);
						  $("#mapX").val(latlng.getLat());
					   	  $("#mapY").val(latlng.getLng());
						  marker.setMap(map);
					}
			   });
		 });

		 // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		 daum.maps.event.addListener(map, 'idle', function() {
			   searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		 });

		 function searchAddrFromCoords(coords, callback) {
			   // 좌표로 행정동 주소 정보를 요청합니다
			   geocoder.coord2addr(coords, callback);
		 }

		 function searchDetailAddrFromCoords(coords, callback) {
			   // 좌표로 법정동 상세 주소 정보를 요청합니다
			   geocoder.coord2detailaddr(coords, callback);
		 }

		 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		 function displayCenterInfo(status, result) {
			   if (status === daum.maps.services.Status.OK) {
					$("#centerAddr").html(result[0].fullName);
			   }
		 }
		 /*---------지도 E-----------*/


		 
			
			function popupWindow(listMode,userTp){
				var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

				if(listMode == 'orgManagePop'){
					var popUrl="/sys/popup/orgList.do?mode=total";
				}else if(listMode == 'orgSubManagePop'){
					var popUrl="/sys/popup/orgSubList.do?mode=total&orgGrpCd="+$('#orgGrpCd').val();
				}
				var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
				window.open(popUrl,"",popOption);
			}

</script>