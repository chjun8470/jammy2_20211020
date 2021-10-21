<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@include file="/back/_temple/basic/t_top.jsp" %>
<%
String tap = request.getParameter("tap");
if(tap == null || tap.equals("null")){
	tap = "1" ;
}
%>
<style type="text/css">
.leftMenuBox {
	position: relative;
	top: 0px;
	width: 1002px;
	display: inline-block;
	vertical-align: top;
}

.leftMenuBox .leftMenuTite {
	height: 30px;
	line-height: 30px;
	background-color: #f3f3f3;
	text-align: center;
	border: 1px solid #cccccc;
}

.leftMenuBox .leftMenuList {
	line-height: 30px;
	height: 150px;
	overflow-y:scroll;
	width: 1000px;
	border-right: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
}

.leftMenuBox .leftMenuList .menuRows {
	border-bottom: 1px solid #cccccc;
	cursor: pointer;
}

.leftMenuBox .leftMenuList .menuRows .menuRows_1 {
	border-bottom: 1px solid #cccccc;
	cursor: pointer;
	padding: 0px 5px;
}

.leftMenuBox .leftMenuList .menuRows .menuRows_2 {
	cursor: pointer;
	padding: 0px 5px;
	background-color: #f9f9f9;
}

.centerMenuBox {
	position: relative;
	top: 0px;
	width: 250px;
	display: inline-block;
	vertical-align: top;
}

.centerMenuBox .menuTite {
	height: 30px;
	width: 100%;
	line-height: 30px;
	background-color: #f3f3f3;
	text-align: center;
	border: 1px solid #cccccc;
}

.centerMenuBox .menuList {
	line-height: 30px;
	height: 700px;
	overflow-y:scroll;
	width: 250px;
	border-right: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
}

.centerMenuBox .menuList .menuRows_1 {
	border-bottom: 1px solid #cccccc;
	cursor: pointer;
	padding: 0px 25px 0px 5px;
}

.rightMenuBox {
	position: relative;
	top: 0px;
	width: 200px;
	display: inline-block;
	vertical-align: top;
}

.rightMenuBox .menuTite {
	height: 30px;
	width: 300px;
	line-height: 30px;
	background-color: #f3f3f3;
	text-align: center;
	border: 1px solid #cccccc;
}

.rightMenuBox .menuList {
	line-height: 30px;
	height: 100%;
}

.rightMenuBox .menuList .menuRows_1 {
	border-bottom: 1px solid #cccccc;
	cursor: pointer;
	padding: 0px 5px;
}

.title_box {
	border-bottom: 1px solid #cccccc;
	height: 30px;
	line-height: 30px;
}

.menu_view {
	width: 302px;
	height: 100%;
	line-height: 30px;
	border-collapse: collapse;
}

.menu_view th {
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
	border-collapse: collapse;
	background-color: #f3f3f3;
}

.menu_view td {
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
	border-collapse: collapse;
	padding: 0px 5px;
}

.tabbox {
	position: relative;
	border-bottom: 1px solid #cccccc;
	margin-top: 10px;
	padding-left: 20px;
}

.tabbox .tabBtn {
	position: relative;
	display: inline-block;
	height: 30px;
	line-height: 30px;
	width: 100px;
	background-color: #d0d0d0;
	color: #ffffff;
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
	margin-right: 10px;
	top: 1px;
	cursor: pointer;
}

.tabbox .tabBtn_on {
	position: relative;
	display: inline-block;
	height: 30px;
	line-height: 30px;
	width: 100px;
	color: #fffff;
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	border-bottom: 1px solid #ffffff;
	text-align: center;
	margin-right: 10px;
	background-color: #ffffff;
	top: 1px;
	color: #fffff;
	cursor: pointer;
}

#authPopBox {
	display:none;
	z-index: 9;
	border: 3px solid #60bbff;
	position: absolute;
	top: 500px;
	left: 0px;
	width: 294px;
	height: 300px;
	background: #ffffff;
}
</style>



   <div class="content_center">
	<%if (loginVO.getAuthLv().equals("99")){ %>
	<div class="bbs-top">
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<input type="hidden" name="orgCd" id="orgCd" value="" />
					기관명 : <input type="text" name="orgNm" id="orgNm" class="board-input" value="">
					<input type="button" class="btn_inp_g_01" value="검색" onclick="orgGo()">
					<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgList')" >
				</div>
				<!-- board-search e -->
			</div>
		</div>
	</div>
   <br/>
   <div class="leftMenuBox"  >

		<div class="leftMenuTite">
			기관권한관리
		</div>

		<div class="leftMenuList" id="MenuList">
			
		</div>
	</div>
   <br/>
   <br/>
   <br/>
   		<div class="btn_right_box" style="display:none;" id="sho">
			<input type="button" class="btn_inp_w_01" style="float: right;" value="인쇄" onclick="print()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="PDF저장" onclick="pdf()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="EXCEL저장" onclick="excel()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="한글저장" onclick="hwp()"/>
		<div>
	      <iframe id="tem" name="tem" width="100%" height="100%" style="border:0px;" onload="autoReportResize('tem')"></iframe>
	   </div>
		</div>
	<%}else{ %>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_w_01" style="float: right;" value="인쇄" onclick="print()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="PDF저장" onclick="pdf()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="EXCEL저장" onclick="excel()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="한글저장" onclick="hwp()"/>
		</div>
	   <div>
	      <iframe src="/AIViewer55/temp/previous.jsp?reportParams=showMenuBar:false&orgcd=<%=loginVO.getOrgGrpCd() %>" id="tem" name="tem"  style="border:0px;width:100%; height:100%" onload="autoReportResize('tem')"></iframe>
	   </div>
	   
	<%} %>      
   </div>
<script type="text/javascript">
//<![CDATA[
	//페이지 움직이기
	function parentTest(value){
   	  $( 'html, body' ).animate( { scrollTop : value+200 } );
   	}
	//파일 다운로드 스크립트
	var print = function() {
		index = tem.PDFPrint();
	}
	var pdf = function() {
		index = tem.PDFConvert();
	}
	var excel = function() {
		index = tem.ExcelConvert();
	}
	var hwp = function() {
		index = tem.hwpConvert();
	}
	$(document).ready(function() { 
		jQuery.post("/sys/avgOpe.do",
		function(data) {
		$('#MenuList').html(data);
		});
	});

	function avgShow(code){
		var url = "/AIViewer55/temp/previous.jsp?reportParams=showMenuBar:false&orgcd="+code+"&dvsn=true" ;
		$("#codeValue").val(code);
		if(code!=null){
			$('#tem').attr('src', url);
			$("#sho").css("display","block");	
		}
		
	}
	/*---------기관검색 S----------*/
	//기관검색 팝업
	function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	//기관정보
	function orgInfo(orgGrpCd){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),

		function(data){
			orgGrpNm = data.dataMap.ORG_GRP_NM; //기관명
			orgGrpCd = data.dataMap.ORG_GRP_CD; //기관코드
			$("#orgNm").val(orgGrpNm);
			$("#orgCd").val(orgGrpCd);

		});
	}
	/*---------기관검색 E----------*/
	function orgGo(){
		var params = {
				"orgCd": $('#orgCd').val(),
				"orgNm": $('#orgNm').val()
		};
		$.post("/sys/avgOpe.do",$.param(params),

		function(data){
			$('#MenuList').html(data);
		});
	}
//]]>	
</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>