<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ include file="/back/_temple/basic/t_top.jsp" %>
<%

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"),"0");
	String m = "Y";

%>
<!-- front단을 include하여 css필요  -->
<link href="/css/cms/front/basic_grid.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/board.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/sub.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/content.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/cont.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/css/cms/back/default.css" />

<div class="content_center">

		<jsp:include page="/web/nationRndList.do" flush="true">
			<jsp:param name="mode" value="<%=mode%>"/>
			<jsp:param name="nowPage" value="<%=nowPage%>"/>
			<jsp:param name="m" value="<%=m%>"/>

		</jsp:include>

		<%--
		 <jsp:include page="/sys/nationRnd.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		</jsp:include>
		--%>

</div>
<%@include file="/back/_temple/basic/t_footer.jsp" %>
