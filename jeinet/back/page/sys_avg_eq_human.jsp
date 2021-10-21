<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@include file="/back/_temple/basic/t_top.jsp" %>
<%
String tap = request.getParameter("tap");
if(tap == null || tap.equals("null")){
	tap = "1" ;
}
%>
<%-- <%
	
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String avg = util.getStr(paramMap.get("avg"));
	
	if(avg.equals("")){
		avg = "기관별";
	}
%>
<div class="content_center">
		<jsp:include page="/sys/avg_eq_cnstc.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		  	<jsp:param name="avg" value="<%=avg%>"/>
		</jsp:include>
</div> --%>

   <div class="content_center">
   		<div class="tabBox" style="margin-top:30px;">
			<ul id =tabul>
				<li class="<%if(tap.equals("1")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_human.do?tap=1">기관별</a></li>
				<li class="<%if(tap.equals("2")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_human.do?tap=2">지역별</a></li>
			</ul>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_w_01" style="float: right;" value="인쇄" onclick="print()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="PDF저장" onclick="pdf()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="EXCEL저장" onclick="excel()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="한글저장" onclick="hwp()"/>
		</div>
		<%if(tap.equals("1")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/jeinet/JnspRePerAge.jsp?reportParams=showMenuBar:false" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%} else if(tap.equals("2")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/jeinet/JnspRePerAre.jsp?reportParams=showMenuBar:false" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%}%>
	</div>
<script type="text/javascript">
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

</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>