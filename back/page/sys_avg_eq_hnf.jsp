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
	
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String dateStart = util.getStr(paramMap.get("dateStart"));
	String dateEnd = util.getStr(paramMap.get("dateEnd"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String chart = util.getStr(paramMap.get("chart"));
	
	if(chart.equals("")){
		chart = "column";
	}
%>
<div class="content_center">

<%-- 		<jsp:include page="/sys/avg_eq_hnf.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		  	<jsp:param name="searchType" value="<%=searchType %>"/>
		  	<jsp:param name="searchWord" value="<%=searchWord %>"/>
		  	<jsp:param name="dateStart" value="<%=dateStart%>"/>
		  	<jsp:param name="dateEnd" value="<%=dateEnd%>"/>
		  	<jsp:param name="chart" value="<%=chart%>"/>
		</jsp:include> --%>

	<div class="content_center">
      <iframe src="/AIViewer55/temp/eqst.jsp" id="eqst" name="eqst" width="100%" height="100%" style="border:0px;scroller:no;" onload="autoReportResize('eqst')"></iframe>
   </div>

</div>
<script type="text/javascript">
var height=57;                  //px단위
var topMargin=26;
var didScroll;
var currentPage 	= 1;
pageTop = new Array();
	var didScroll;
	var endPage;
	var startPage;
	function pageH(pageT,end,start){
		alert("페이지2");
		endPage = end ;
		startPage = start;
		for(var i = 1 ; i<=pageT.length;i++){
			pageTop[i]=pageT[i]+200;
		}
	}
</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>
