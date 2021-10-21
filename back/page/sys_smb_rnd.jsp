<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ include file="/back/_temple/basic/t_top.jsp" %>
<%
	//HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	String searchType1 = util.getStr(paramMap.get("searchType1"));
	String searchType2 = util.getStr(paramMap.get("searchType2"));
	String selCodeGrp = util.getStr(paramMap.get("selCodeGrp"));
	String searchCodeGrpWord = util.getStr(paramMap.get("searchCodeGrpWord")); //그룹코드관리
	String searchCodeWord = util.getStr(paramMap.get("searchCodeWord")); //코드관리

%>
<div class="content_center">
	<div class="conts">

		<jsp:include page="/sys/smbRndExcel.do" flush="true">
		  	<jsp:param name="searchType1" value="<%=searchType1 %>"/>
		  	<jsp:param name="searchType2" value="<%=searchType2 %>"/>
		  	<jsp:param name="selCodeGrp" value="<%=selCodeGrp %>"/>
		  	<jsp:param name="searchCodeGrpWord" value="<%=searchCodeGrpWord %>"/>
		  	<jsp:param name="searchCodeWord" value="<%=searchCodeWord %>"/>
		</jsp:include>

	</div>
</div>
<%@include file="/back/_temple/basic/t_footer.jsp" %>