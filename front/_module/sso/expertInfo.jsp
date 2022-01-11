<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@include file="/back/_item/basic/i_header.jsp" %>

<div style="margin:20px;">
<jsp:include page="/sys/expertManage.do" flush="true">
  	<jsp:param name="mode" value="${paramMap.get('mode')}"/>
  	<jsp:param name="xt" value="1"/>
  	<jsp:param name="nowPage" value="${paramMap.get('nowPage')}"/>
</jsp:include>
</div>