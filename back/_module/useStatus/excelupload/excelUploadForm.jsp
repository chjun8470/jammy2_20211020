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

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataMap = request.getAttribute("dataMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "useStatus";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>

<script type="text/javascript">
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
</script>

<style type="text/css">
.bu_tit {padding-left:22px !important; margin:21px 0 14px 0 !important; background:url("<c:url value='/images/bl_circle.gif' />") no-repeat left 50% !important; font-size:15px !important; color:#393939 !important;}
 </style>
 <script>
 </script>

<h2 class="menu-title">활용실적 등록</h2>
<hr/>
	<div class="search-box" style="margin-top: 10px;">
		<fieldset class="dhx_fs" style="padding-right:10px">
		<div style ="float:left">
		<form name="uploadForm" action="<%=myPage %>" method="post" onSubmit="return false;" encType="multipart/form-data">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="format" id="format"/>
	     	<input type="file" name="file1" accept="application/vnd.ms-excel" />
      	</form>
      	</div>

		<div style="float: right">
			<input type="button" class="btn_inp_b_01" id="save" name="save" value="선택파일 업로드"  onclick="goUploadExcel();"  />
			<input type="button" class="btn_inp_b_01" onclick ="location.href='./getTemPlateFile.do'" value="입력양식다운로드" title="입력양식다운로드">
		</div>
		</fieldset>
	</div>
<br />

	<table class="skin_basic_write" style="width:100%; height:auto" summary="한글이름,한자이름,영문이름,생년월일,성별,출생지역,소속직장,소속전화번호,소속주소,집주소,개인휴대폰번호,이메일">
	<caption>활용실적 일괄처리</caption>
	<colgroup>
	<col style="width: 20%" />
	<col style="width: 80%" />
	</colgroup>
		<tbody>
			<tr>
				<th align="left">업로드시 유의사항</th>
				<td colspan="4" style="text-align:left;">
				<br/><br/>
				1. 반드시 상단의 입력양식 다운로드를 통해 받은 엑셀 파일로 작성해주시고, 항목을 늘리거나 줄여서 작성하지 마십시오.<br/><br/><br/>
				</td>
			</tr>
			</tbody>
	</table>
<div align="right">
	<input type="button" class="btn_inp_w_01" onclick ="location.href='./sys_use_status.do'" value="목록" title="목록">
</div>

