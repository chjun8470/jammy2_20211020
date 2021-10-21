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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
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
		<li class="on"><a href="#" onclick="setRefresh('excel')">파일등록</a></li>
		<%if("99".equals(loginVO.getAuthLv())){ %>
		<li><a href="#" onclick="setRefresh('excelEdit')">파일수정</a></li>
		<%} %>
		<li><a href="#" onclick="setRefresh('list')">리스트</a></li>
	</ul>
</div>

<form action="/sys/sys_use_status_write.do" id="submitForm">
	<input type="hidden" name="mode" id="submitMode" value=""/>
</form>
<%if("99".equals(loginVO.getAuthLv())){ %>
	<form id="useDateForm" name="useDateForm">
		<input type="hidden" id="useDateFormMode" name="mode" value="useDate"/>
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
				<label>신청기간</label>
					<select class="select" name="useYear" id="useYear">
						<option value="" >전체</option>
					<%String selected="";
						for(int i=stYear ; i<edYear ; i++){
					%>
						<option value="<%=i%>" <%if(util.getStr(paramMap.get("useYear")).equals(String.valueOf(i))) { %> selected="selected" <% } %>><%=i%></option>
					<%}%>
					</select>
					&nbsp;&nbsp;
					<input type="text" class="inp_txt" id="useStDt" name="useStDt"  value="<%=util.getStr(paramMap.get("useStDt"))%>" />
					&nbsp;~&nbsp;
					<input type="text" class="inp_txt" id="useEdDt" name="useEdDt" value="<%=util.getStr(paramMap.get("useEdDt"))%>" />
					<input type="button" class="btn_inp_g_01" value="저장" onclick="setUseDate();" style="float: right;">
				</div>
			</div>
		</div>
	</form>
<%} %>

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
			<div class="write_box">
				<h2 class="tit">등록 <%=useStDt%> ~ <%=useEdDt%></h2><br/>
				<div class="sub_tit">연구장비운영실태조사표 등록</div>
				<table class="write_table">
					<colgroup>
						<col width="30%"/>
						<col width="70%"/>
					</colgroup>
					<tr>
						<th>연구장비운영실태조사 제출 공문</th>
						<td>
							<jsp:include page="/getFileWriteForm.do">
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
							<jsp:include page="/getFileWriteForm.do">
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
							<jsp:include page="/getFileWriteForm.do">
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
							<jsp:include page="/getFileWriteForm.do">
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
							<jsp:include page="/getFileWriteForm.do">
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
							<jsp:include page="/getFileWriteForm.do">
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
							<jsp:include page="/getFileWriteForm.do">
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
		<%}else{%>
			<%if("99".equals(loginVO.getAuthLv())){ %>
				<span>신청 기간을 저장 하세요.</span>
			<%} else { %>
				<span>신청 기간이 아닙니다.</span>
			<%} %>
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
})

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

function setUseDate(){
	$("#useDateFormMode").val("useDate");
	var params = $("#useDateForm").serialize();
	if(confirm("신청기간을 저장 하시겠습니까?")){
		$.post("/sys/useStatusWrite.do?"+params,
		function(data){
			if(data.result == "success"){
				alert("신청기간을 저장하였습니다.");
				setRefresh('excel');
			}else{
				alert("신청기간 저장에 실패하였습니다.");
			}
		});
	}
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
 </script>