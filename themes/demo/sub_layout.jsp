<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.site.service.*" %>

<%@include file="include/func.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title><c:out value='${title}'/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/bootstrap.min.css'/>" media="screen">
	<link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/font-awesome.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/sub.css'/>" />
	<c:forEach var="css" items="${cssList}">
	<link rel="stylesheet" type="text/css" href="<c:out value='${css}'/>">
	</c:forEach>
    <link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />
	<!--[if lt IE 9]>
	<script src="<c:out value='${LAYOUT_PATH}/js/html5shiv.js'/>"></script>
	<script src="<c:out value='${LAYOUT_PATH}/js/respond.min.js'/>"></script>
	<![endif]-->	
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery.min.js'/>"></script>
		<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js'/>"></script>	
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/common.js'/>"></script>
	<c:forEach var="js" items="${jsList}">
	<script type="text/javascript" src="<c:out value='${js}'/>"></script>
	</c:forEach>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@include file="include/header.jsp"%>
	</div>
	<div id="body" class="extension">
		<div id="snb">
			<%@include file="include/snb.jsp"%>
		</div>		
		<div id="content">
			<div class="content-head clearfix">
				<h3 class="title"><% if (siteMenuVO.getLvl() > 3) {%><%=parntsSiteMenuVOList.get(3).getMenuNm()%><%}else{%><%=siteMenuVO.getMenuNm()%><%}%></h3>
				<div class="location">
					<ul>
					<%
						for (int z = 0; z < parntsSiteMenuVOList.size(); z++)
						{
							SiteMenuVO vo = (SiteMenuVO)parntsSiteMenuVOList.get(z);
							String active = siteMenuVO.getMenuId() == vo.getMenuId() ? "class=\"active\"" : "";
							if (z == 0) {
								active = "class=\"home\"";
							}
							out.print(String.format("<li %s>%s</li>", active, vo.getMenuNm()));
						}
					%>
					</ul>
				</div>
			</div>
			<%
			if (parntsSiteMenuVOList.get(4) != null)
			{
				List<SiteMenuJsonVO> tabmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), parntsSiteMenuVOList.get(3).getMenuId());
				if (tabmenuList.size() > 0)
				{		
					SiteMenuJsonVO tabmenuVO;
					String addClass;
					out.print("<div class=\"content-tabmenu extension\">");
					out.print("<ul>");
					for (int i = 0; i < tabmenuList.size(); i++)
					{
						tabmenuVO = (SiteMenuJsonVO)tabmenuList.get(i);
						addClass = "";
						if (parntsSiteMenuVOList.get(4) != null && tabmenuVO.getMenuId() == parntsSiteMenuVOList.get(4).getMenuId())
						{
							addClass = " active";
						}
						out.print(String.format("<li class=\"t%d %s\">%s</li>", tabmenuVO.getMenuId(), addClass, getMenuLink(request, siteInfoVO, tabmenuVO, "", "txt", "")));
					}
					out.print("</ul>");
					out.print("</div>");
				}
			}
			%>
			<div class="content-body">
				<c:import url="${contentFile}" />
			</div>
			<div class="content-tail">
				<%@include file="include/content_etc.jsp"%>
			</div>
		</div>	
	</div>		
	<div id="footer">
		<%@include file="include/footer.jsp"%>
	</div>
</div>

</body>
</html>