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
String tapIdx = request.getParameter("Idx");
if(tap == null || tap.equals("null")){
	tap = "1" ;
}
if(tapIdx == null || tapIdx.equals("null")){
	tapIdx = "1" ;
}
%>

 	<div class="content_center">
   		<div class="tabBox" style="margin-top:30px;">
			<ul id =tabul style="width: 1000px;">
				<li class="<%if(tap.equals("1")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_jip_avg_constc.do?tap=1">기관별</a></li>
				<li class="<%if(tap.equals("2")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_jip_avg_constc.do?tap=2">지역별</a></li>
				<li class="<%if(tap.equals("3")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_jip_avg_constc.do?tap=3">연도별</a></li>
			</ul>
		</div>
   		<div class="btn_right_box">
			<input type="radio" name ="avg" id ="brand" value = "상표" onclick="stateChan('1','<%=tap%>')" Checked = "Checked"/>
			<label for="brand"> 상표 </label>
			<input type="radio" name ="avg"  id ="design"  value = "디자인" onclick="stateChan('2','<%=tap%>')"/>
			<label for="design"> 디자인 </label>
			<input type="radio" name ="avg"  id ="know"  value = "노하우" onclick="stateChan('3','<%=tap%>')" />
			<label for="know"> 노하우 </label>
			<input type="radio" name ="avg"  id ="model"  value = "특허실용" onclick="stateChan('4','<%=tap%>')" />
			<label for="model"> 특허실용 </label>
			<input type="radio" name ="avg"  id ="program"  value = "프로그램" onclick="stateChan('5','<%=tap%>')" />
			<label for="program"> 프로그램 </label>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn_inp_w_01" style="float: right;" value="인쇄" onclick="print()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="PDF저장" onclick="pdf()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="EXCEL저장" onclick="excel()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="한글저장" onclick="hwp()"/>
		</div>
		<%if(tap.equals("1")){ %>
	   <div><!-- 기관별 -->
	      <iframe src="/AIViewer55/temp/jipbank/JnspJipPatent.jsp?reportParams=showMenuBar:false&Idx=1" id="tem" name="tem" width="100%" height="100%" style="border:0px;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%}else if(tap.equals("2")){ %>
	   <div><!-- 지역별 -->
	      <iframe src="/AIViewer55/temp/jipbank/JnspJipPatentAre.jsp?reportParams=showMenuBar:false&Idx=1" id="tem" name="tem"  style="border:0px;width:100%; height:100%" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%}else if(tap.equals("3")){ %>
	   <div><!-- 연도별 -->
	      <iframe src="/AIViewer55/temp/jipbank/JnspJipPatentDate.jsp?reportParams=showMenuBar:false&Idx=1" id="tem" name="tem"  style="border:0px;width:100%; height:100%" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%} %>
   </div>

<script type="text/javascript">
function stateChan(tabIdx,tab){
	var url ;
	if(tab == '1'){
		url = "/AIViewer55/temp/jipbank/JnspJipPatent.jsp?reportParams=showMenuBar:false&dvsn=true&Idx="+tabIdx ;
	}
	if(tab == '2'){
		url = "/AIViewer55/temp/jipbank/JnspJipPatentAre.jsp?reportParams=showMenuBar:false&dvsn=true&Idx="+tabIdx ;
	}
	if(tab == '3'){
		url = "/AIViewer55/temp/jipbank/JnspJipPatentDate.jsp?reportParams=showMenuBar:false&dvsn=true&Idx="+tabIdx ;
	}
	$('#tem').attr('src', url);
}
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

	
	
	
	
</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>