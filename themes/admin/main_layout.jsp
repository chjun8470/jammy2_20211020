<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="java.util.*" %>

<%@include file="include/func.jsp"%>
<%@include file="include/head.jsp"%>

<body>

<div class="page-container">
	<div class="page-head">
   <!-- <ul class="page-head-elements pull-right">
			<li>
				<a href="<c:url value='/cms/admin/logout.do'/>" class="but dropdown-toggle" title="LOGOUT"><i class="fa fa-times"></i></a>
			</li>
		</ul> -->
		<div class="top_menu">
				<div class="menu_lft">
					<a href="/cms/admin/main.do">CMS</a>
				</div>
				<div class="menu_cent">
					<a href="/sys/main.do?tmenu=1">통합 PMS</a>
				</div>
				<div class="menu_rgt">
					<a href="/sys/main.do?tmenu=2">기관 PMS</a>
				</div>
			</div>
	</div>
	<div class="page-navigation">

		<div class="page-navigation-info">
			<a href="/sys/main.do">
				<img src="/img/common/logo_main.png">
			</a>

		</div>

		<div class="profile">
			<img src="<c:out value='${LAYOUT_PATH}' />/img/ico_0.png"/>
			<a href="<c:url value='/cms/admin/logout.do'/>" class="but dropdown-toggle logout_btn" title="LOGOUT">
				<img src="<c:out value='${LAYOUT_PATH}' />/img/logout.png">
			</a>
			<div class="profile-info">
				<a href="#" class="profile-title"><c:out value="${LOGIN_INFO.name}"/> (<c:out value="${LOGIN_INFO.id}"/>)</a>
				<!-- <span class="profile-subtitle">Administrator</span> -->
                <div class="profile-buttons">
                    <div class="btn-group">

                    </div>
                </div>
			</div>
		</div>
		<ul class="navigation">
<%
	List<AdminMenuVO> topmenuList = adminManager.getMenuList(1);
	if (topmenuList.size() > 0)
	{
		for (int i = 0; i < topmenuList.size(); i++)
		{
			AdminMenuVO topmenuVO = (AdminMenuVO)topmenuList.get(i);

			List<AdminMenuVO> submenuList = adminManager.getMenuList(topmenuVO.getMenuId());
			boolean chldrns = submenuList.size() > 0 ? true : false;

			String liClass = "";
			if (PARNTS_ADMIN_MENU_LIST.get(1) != null)
			{
				if (PARNTS_ADMIN_MENU_LIST.get(1).getMenuId() == topmenuVO.getMenuId())
				{
					liClass = " class=\"active open\"";
				}
			}

			out.print(String.format("<li %s>%s", liClass, getMenuLink(request, topmenuVO)));

			if (chldrns)
			{
				out.print("<ul>");
				for (int j = 0; j < submenuList.size(); j++)
				{
					AdminMenuVO submenuVO = (AdminMenuVO)submenuList.get(j);

					String liClass2 = "";
					if (PARNTS_ADMIN_MENU_LIST.get(2) != null)
					{
						if (PARNTS_ADMIN_MENU_LIST.get(2).getMenuId() == submenuVO.getMenuId())
						{
							liClass2 = " class=\"active\"";
						}
					}

					out.print(String.format("<li%s>%s</li>", liClass2, getMenuLink(request, submenuVO)));
				}
				out.print("</ul>");
			}
			out.print("</li>");
		}
	}
%>
		</ul>
	</div>
	<div class="page-content">
		<div class="container">
			<c:choose>
				<c:when test="${ADMIN_MENU_INFO != null}">
					<div class="page-toolbar">
						<div class="page-toolbar-block">
							<div class="page-toolbar-title">
							<%=ADMIN_MENU_INFO.getMenuNm()%>
							</div>
						</div>
						<ul class="breadcrumb">
<%
	if (PARNTS_ADMIN_MENU_LIST != null)
	{
		for (int z = 0; z < PARNTS_ADMIN_MENU_LIST.size(); z++)
		{
			AdminMenuVO vo = (AdminMenuVO)PARNTS_ADMIN_MENU_LIST.get(z);
			String active = ADMIN_MENU_INFO.getMenuId() == vo.getMenuId() ? "class=\"active\"" : "";
			out.print(String.format("<li %s>%s</li>", active, vo.getMenuNm()));
		}
	}
%>
						</ul>
					</div>
				</c:when>
			</c:choose>
			<c:import url="${contentFile}" />
		</div>
	</div>
	<div class="page-sidebar">
	</div>
</div>
</body>
</html>