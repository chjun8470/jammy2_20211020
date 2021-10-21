<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>

<%
String display = "sub";
request.setCharacterEncoding("utf-8");
ComUtil util = new ComUtil();

String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");

String mode = util.getStr(paramMap.get("mode"));
String nowPage = util.getStr(paramMap.get("nowPage"));
String userIdx = util.getStr(paramMap.get("userIdx"));
if("".equals(mode)) mode = "write";
%>




<div id="excelForm">
	<form name="fwrite" id="fwrite" method="post" enctype="multipart/form-data">
		
		<div class="skin_bbs_write" style="margin-top: 30px">
			<input type="file" name="exfile" value="">
		</div>
		
		<span class="excelBtn">등록11</span>
		
	</form>
</div>
<div id="excelList"></div>



<script>
$(".excelBtn").on("click",function(){
	$('#mode').val("writeproc");
	
	var form = $("#fwrite")[0];
	var formData = new FormData(form); 
    
    
    //var fileName = formData.get('file').name;
    
    $.ajax({
    	type:"POST",
    	enctype:"multipart/form-data",
    	url:"/sys/smbRndTeamExcelUpload.do",
    	data:formData,
    	dataType:"HTML",
    	cache:false,
    	contentType:false,
    	processData:false,
    	success:function(data){
    		
    		$("#excelForm").hide();
    		$("#excelList").html(data);
    		
    	}
    });
	
	//$('#fwrite').submit();
});
</script>