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
int authLv = Integer.parseInt(loginVO.getAuthLv());
String tap = request.getParameter("tap");
if(tap == null || tap.equals("null")){
	if(authLv >= 90) {
		tap = "1" ;
	} else {
		tap = "5";
	}
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
   	<%if(authLv >= 90) { %>
   		<div class="tabBox" style="margin-top:30px;">
			<ul id =tabul>
				<li class="<%if(tap.equals("1")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_uses.do?tap=1">수익금</a></li>
				<li class="<%if(tap.equals("2")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_uses.do?tap=2">활용기업수</a></li>
				<li class="<%if(tap.equals("3")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_uses.do?tap=3">장비수</a></li>
				<li class="<%if(tap.equals("4")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_uses.do?tap=4">구축금액</a></li>

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
	      <iframe src="/AIViewer55/temp/usesAdmin1.jsp?reportParams=showMenuBar:false" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%} else if(tap.equals("2")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/usesAdmin2.jsp?reportParams=showMenuBar:false" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%} else if(tap.equals("3")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/usesAdmin3.jsp?reportParams=showMenuBar:false" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%}else if(tap.equals("4")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/usesAdmin4.jsp?reportParams=showMenuBar:false" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%}
	   	} else {%>
		<div class="tabBox" style="margin-top:30px;">
			<ul id =tabul>
				<li class="<%if(tap.equals("5")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_uses.do?tap=5">수익금</a></li>
				<li class="<%if(tap.equals("6")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="/sys/sys_avg_eq_uses.do?tap=6">활용기업수</a></li>
			</ul>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_w_01" style="float: right;" value="인쇄" onclick="print()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="PDF저장" onclick="pdf()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="EXCEL저장" onclick="excel()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="한글저장" onclick="hwp()"/>
		</div>
		<%if(tap.equals("5")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/usesAgency1.jsp?reportParams=showMenuBar:false&orgcd=<%=loginVO.getOrgGrpCd() %>" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   <%} else if(tap.equals("6")){ %>
	   <div>
	      <iframe src="/AIViewer55/temp/usesAgency2.jsp?reportParams=showMenuBar:false&orgcd=<%=loginVO.getOrgGrpCd() %>" id="tem" name="tem" style="border:0px;width:100%;height:100%;" onload="autoReportResize('tem')"></iframe>
	   </div>
	   	<% }
		} %>
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
//]]>
</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>