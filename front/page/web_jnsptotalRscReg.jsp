<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@include file="/front/_temple/basic/t_top.jsp" %>
<%
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	if(mode.equals("")){mode = "rscWrite";}
%>
<div class="content_center">

		<jsp:include page="/web/jnsptotal.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		</jsp:include>

</div>
<%@include file="/front/_temple/basic/t_footer.jsp" %>
