<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.site.service.SiteManager" %>
<%@ page import="egovframework.jammy2.system.orgnzt.service.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
SiteManager siteManager = new SiteManager(request);

String rootOrgnztId = "ORGNZT_0000000000002";
String searchOrgnztId = EgovStringUtil.nullConvert(request.getParameter("orgnztId"));
if ("".equals(searchOrgnztId))
{
	searchOrgnztId = "ORGNZT_0000000000003";
}

List<OrgnztVO> orgnztList = (List)siteManager.getOrgnztList(rootOrgnztId);
OrgnztVO orgnztVO = (OrgnztVO)siteManager.getOrgnztInfo(searchOrgnztId);

request.setAttribute("orgnztList", orgnztList);
request.setAttribute("orgnztVO", orgnztVO);
%>

<ul>
<c:forEach var="result" items="${orgnztList}" varStatus="status">
	<c:if test="${result.level == orgnztVO.level}">
	<li><a href="?orgnztId=<c:out value='${result.orgnztId}'/>"><c:out value="${result.orgnztNm}"/></a></li>
	</c:if>
</c:forEach>
</ul>

<h4><c:out value="${orgnztVO.orgnztNm}"/></h4>

<c:out value="${orgnztVO.orgnztDc}" escapeXml="false"/>