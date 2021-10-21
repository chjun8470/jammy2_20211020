<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="vStartP" value="7000000" />

<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, Object> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("dataMap");
	String mode = util.getStr(paramMap.get("mode"));


	/***신청기간 확인 S***/
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	int stYear = 2010;
	int nowYear = Calendar.getInstance().get(Calendar.YEAR);
	int edYear = nowYear + 3;
	String useStDt = util.getStr(dataMap.get("useStDt"));
	String useEdDt = util.getStr(dataMap.get("useEdDt"));
	boolean result = false;
	Date beginDate = new Date();
	Date endDate = new Date();
	Date toDate = new Date();
	//시작날짜 설정
	if(!"".equals(useStDt)){
		beginDate = format.parse(useStDt);
	} else {
		beginDate = toDate;
	}
	//종료날짜 설정
	if(!"".equals(useEdDt)){
		endDate = format.parse(useEdDt);
	} else {
		endDate = toDate;
	}
	//기간 확인
	if("".equals(useStDt) || "".equals(useEdDt)){
    	result = false;
	}else if(toDate.before(beginDate) || toDate.after(endDate)){
    	result = false;
    }else{
    	result = true;
    }
	/***신청기간 확인 E***/

%>

<style type="text/css">
.conts .cont01{margin-bottom: 15px;margin-top: 5px;}
.conts .cont01 .search_box{display: inline-block;width: 100%;}
.conts .cont01 .write_box span{font-size: 14px;font-weight:bold;}
.conts .cont01 .write_box .write_table{border-collapse: collapse;width: 100%;margin-top: 8px;margin-bottom: 15px;}
.conts .cont01 .write_box .write_table th,td{border: 1px solid #bbb;padding: 12px 8px;}
.conts .cont01 .write_box .write_table th{background-color: #f5f5f5;}
.conts span.title-left{border-left: 5px solid #0198ce;padding-left: 5px;}
.red_desc{color: red;padding-top: 3px;}
 </style>

<div class="tabBox_pub">
	<ul>
		<li><a href="#" onclick="setRefresh('excel')">파일등록</a></li>
		<li class="on"><a href="#" onclick="setRefresh('excelEdit')">파일수정</a></li>
		<li><a href="#" onclick="setRefresh('list')">리스트</a></li>
	</ul>
</div>

<form action="/sys/sys_use_status_write.do" name="submitForm" id="submitForm">
	<input type="hidden" id="submitMode" name="mode" value="excelEdit"/>
	<div class="basic_grid">
		<div class="search_box" style="padding:10px">
			<div class="board-search">
			<label for="search_year">기간</label>
				<select class="select" id="useYear" name="useYear">
					<option value="" >전체</option>
					<%String selected2="";
						for(int i=stYear ; i<edYear ; i++){
					%>
						<option value="<%=i%>" <%if(util.getStr(paramMap.get("useYear")).equals(String.valueOf(i))) { %> selected="selected" <% } %>><%=i%></option>
					<%}%>
				</select>
				<label for="orgGrpNm">기관</label>
				<input type="text" class="inp_txt" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(paramMap.get("orgGrpNm"))%>" />
				<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>" />
				<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm1" class="btn_inp_b_01" style="display: inline-block;" onclick="popupWindow('orgList','2')">
				<input type="button" class="btn_inp_g_01" value="조회" style="float: right;" onclick="setRefresh('excelEdit')">
			</div>
		</div>
	</div>
</form>

<div class="conts">
	<div class="cont01">
		<%if(result){%>
		<script type="text/javascript" src="/back/_module/useStatusWrite/fileWrite.js" ></script>
		<form id="writeForm" name="writeForm" action="/sys/sys_use_status_write.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="fileId" id="fileId" value=""/>
			<input type="hidden" name="mode" id="writeFormMode" value="fileUpload"/>
			<input type="hidden" name="excelType" id="excelType" value=""/>
			<input type="hidden" name="useDateIdx" id="useDateIdx" value="<%=util.getStr(dataMap.get("useDateIdx"))%>"/>
			<input type="hidden" name="useYear" id="useYearWrite" value="<%=util.getStr(dataMap.get("useYear"))%>"/>
			<input type="hidden" name="useStDt" id="useStDtWrite" value="<%=useStDt%>"/>
			<input type="hidden" name="useEdDt" id="useEdDtWrite" value="<%=useEdDt%>"/>
			<input type="hidden" name="fileGrp" id="fileGrp" value="useStatus"/>
			<input type="hidden" name="orgGrpCd" id="submitOrgCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>"/>
			<div class="write_box">
				<div class="sub_tit">연구장비운영실태조사표 등록</div>
				<table class="write_table">
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr>
						<th>연구장비운영실태조사 제출 공문</th>
						<td>
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file1" name="fileSubGrp"/>
								<jsp:param value="1" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="pdf&hwp" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* PDF, 한글파일을 등록하세요.</div>
						</td>
					</tr>
					<tr>
						<th>연구장비운영실태조사표</th>
						<td>
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file2" name="fileSubGrp"/>
								<jsp:param value="1" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="hwp" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* 한글파일을 등록하세요.</div>
						</td>
					</tr>
					<tr>
						<th>연구장비실태조사 증빙문서</th>
						<td>
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file3" name="fileSubGrp"/>
								<jsp:param value="10" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="pdf&hwp" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* PDF, 한글파일을 등록하세요. <br> * 파일은 10개까지 등록 가능합니다.</div>
						</td>
					</tr>
				</table>

				<div class="sub_tit">연구장비운영계획 등록</div>
				<table class="write_table">
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr>
						<th>연구장비운영계획</th>
						<td>
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file4" name="fileSubGrp"/>
								<jsp:param value="1" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="hwp" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* 한글파일을 등록하세요.</div>
						</td>
					</tr>
					<tr>
						<th>연구장비운영계획 관련문서등록</th>
						<td>
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file5" name="fileSubGrp"/>
								<jsp:param value="10" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="pdf&hwp" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* PDF, 한글파일을 등록하세요. <br> * 파일은 10개까지 등록 가능합니다.</div>
						</td>
					</tr>
				</table>
				<input type="button" class="btn_inp_g_01" value="등록" onclick="setFileSave();" style="float: right;">

				<div class="sub_tit">연구장비활용실태조사표 등록</div>
				<table class="write_table">
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr>
						<th>연구장비활용실태조사표</th>
						<td>
							<input type="button" value="파일 등록" onclick="setFileExcelSave('total')" class="btn_inp_g_01" style="float: right;" />
							<input type="button" class="btn_inp_g_01" value="양식다운로드" onclick="location.href='/sys/getTotalTempFileWrite.do'" style="float: right;" />
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file6" name="fileSubGrp"/>
								<jsp:param value="1" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="xls&xlsx" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* EXCEL파일을 등록하세요.</div>
						</td>
					</tr>
				</table>

				<div class="sub_tit">연구장비이용자현황조사표 등록</div>
				<table class="write_table">
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr>
						<th>연구장비이용자현황조사표</th>
						<td>
							<input type="button" value="파일 등록" onclick="setFileExcelSave('user')" class="btn_inp_g_01" style="float: right;" />
							<input type="button" class="btn_inp_g_01" value="양식다운로드" onclick="location.href='/sys/getUserTempFileWrite.do'" style="float: right;" />
							<jsp:include page="/getFileEditForm.do">
								<jsp:param value="useStatus" name="fileGrp"/>
								<jsp:param value="<%=util.getStr(dataMap.get(\"useDateIdx\"))%>" name="useDateIdx"/>
								<jsp:param value="file7" name="fileSubGrp"/>
								<jsp:param value="1" name="fileCnt"/>
								<jsp:param value="50" name="fileSize"/>
								<jsp:param value="gtext" name="fileExt"/>
								<jsp:param value="xls&xlsx" name="fileExt2"/>
							</jsp:include>
							<div class="red_desc">* EXCEL파일을 등록하세요.</div>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<form  id="typeForm" name="typeForm" action="/sys/setTypeChangeForm.do">
			<input type="hidden" name="useDateIdx" id="setDateIdx" value="<%=util.getStr(dataMap.get("useDateIdx"))%>"/>
			<input type="hidden" name="orgGrpCd" id="setOrgCd" value=""/>
			<input type="hidden" name="typeChange" id="typeChange" value=""/>
			<input type="hidden" name="jointType" id="jointType" value=""/>
			<input type="button" class="btn_inp_g_01" value="확정" onclick="setType('1');" style="float: right;">
			<input type="button" class="btn_inp_g_01" value="미확정" onclick="setType('2');" style="float: right;">
		</form>
		<%}else{%>
			<span>해당년도에는 신청정보가 없습니다.</span>
		<%}%>
	</div>
</div><br/>


 <script type="text/javascript">
$(document).ready(function(){
	$("#useStDt, #useEdDt").datepicker({
		showMonthAfterYear : true,
		showButtonPanel : true,
		changeMonth : true,
		changeYear : true,
		nextText : '다음 달',
		prevText : '이전 달',
		currentText : '오늘 날짜',
		closeText : '닫기',
		dateFormat : "yy-mm-dd",
		dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
		dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
	});
	// 시작일 값에 따른 종료일 선택 값 제한
    $('#useStDt').datepicker("option", "maxDate", $("#useEdDt").val());
    $('#useStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#useEdDt").datepicker( "option", "minDate", selectedDate );
    });
	// 종료일 값에 따른 시작일 선택 값 제한
    $('#useEdDt').datepicker("option", "minDate", $("#useStDt").val());
    $('#useEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#useStDt").datepicker( "option", "maxDate", selectedDate );
	});
});

//기관검색 팝업
function popupWindow(listMode,userTp){
	if(listMode == 'orgList'){
		var popUrl="/sys/popup/"+listMode+".do?userTp="+userTp;
	}
	var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}

//기관정보
function orgInfo(orgGrpCd, cnt){
	$("#orgGrpCd").val(orgGrpCd);
	var orgGrpNm;
	var params = {
			"orgGrpCd": orgGrpCd
	};
	$.post("/sys/getOrgInfo.do",$.param(params),
	function(data){
		if(cnt != 'cnt'){$("#deptNm").val("");$("#positionNm").val("");}
		orgGrpNm = data.dataMap.ORG_GRP_NM;
		$("#orgGrpNm").val(orgGrpNm);
	});
}

function goUploadExcel(){
    var uploadForm = document.uploadForm;

    if( uploadForm.file1.value == "" ) {
        alert( "파일을 업로드해주세요." );
        return false;
    } else if( !checkFileType(uploadForm.file1.value) ) {
        alert( "엑셀파일만 업로드 해주세요." );
        return false;
    }

    if( confirm("업로드 하시겠습니까?") ) {
        $("#mode").val("excelView");
        uploadForm.submit();
    }
}

function checkFileType( filePath ) {
    var fileFormat = filePath.toLowerCase();
    if( fileFormat.indexOf(".xls") > -1 ) {
    	document.getElementById("format").value = "xls";
    	return true;
    } else if(fileFormat.indexOf(".xlsx") > -1) {
    	document.getElementById("format").value = "xlsx";
    	return true;
    } else return false;
}

function setFileSave(){
	if(confirm("파일을 등록 하시겠습니까?")){
		$("#writeForm").submit();
	}
}

function setFileExcelSave(type){
	if(confirm("파일을 업로드 하시겠습니까?")){
		$("#writeFormMode").val('excel'+type);
		$("#excelType").val(type);
		$("#writeForm").submit();
	}
}

function setRefresh(mode){
	$("#submitMode").val(mode);
	$("#submitForm").submit();
}

// 확정 미확정
function setType(val){
	var orgcd = $("#orgGrpCd").val();
	$("#setOrgCd").val(orgcd);
	$("#typeChange").val('Y');
	if(val=='1'){
		$("#jointType").val('1');
		$("#typeForm").submit();
	}else{
		$("#jointType").val('2');
		$("#typeForm").submit();
	}
}

</script>