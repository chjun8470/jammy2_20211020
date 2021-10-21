<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.util.EgovUserDetailsHelper" %>
<%@ page import="egovframework.jammy2.cmm.LoginVO" %>
<%@ page import="egovframework.jammy2.cmm.service.*" %>
<%@ page import="egovframework.jammy2.system.admin.service.*" %>
<%@ page import="egovframework.jammy2.system.menu.service.*" %>

<%
	AdminManager adminManager = new AdminManager(request);

	AdminMenuVO ADMIN_MENU_INFO = (AdminMenuVO)request.getAttribute("ADMIN_MENU_INFO");
	
	HashMap<Integer, AdminMenuVO> PARNTS_ADMIN_MENU_LIST = new HashMap<Integer, AdminMenuVO>(); 

	if (ADMIN_MENU_INFO != null)
	{
		List<AdminMenuVO> list = adminManager.getParntsMenuList(ADMIN_MENU_INFO.getMenuId());
		for (int i = 0; i < list.size(); i++)
		{
			AdminMenuVO vo = (AdminMenuVO) list.get(i);
			PARNTS_ADMIN_MENU_LIST.put(i, vo);
		}		
		PARNTS_ADMIN_MENU_LIST.put(list.size(), ADMIN_MENU_INFO);
	}	
%>

<%!
	public String getMenuLink(HttpServletRequest request,
			AdminMenuVO adminMenuVO) {
			
		String href = "";
		if ("LINK_IN".equals(adminMenuVO.getMenuTy()))
		{
			href = request.getContextPath() + adminMenuVO.getLinkUrl(); 
		}
		else if ("LINK_OUT".equals(adminMenuVO.getMenuTy()))
		{
			href = adminMenuVO.getLinkUrl();
		}
		else
		{
			href = request.getContextPath() + adminMenuVO.getLinkUrl();
		}
		
		String target = (adminMenuVO.getLinkTarget().equals("_BLANK")) ? "target=\"_blank\" title=\"새창\"" : "";
		String onclick = (adminMenuVO.getLinkTarget().equals("_POPUP")) ? "onclick=\"window.open(this.href, 'menu" + adminMenuVO.getMenuId() + "', '" + adminMenuVO.getPopupParam() + "'); return false;\"" : "";
				
		String title = adminMenuVO.getMenuNm();	
		
		String icon = EgovStringUtil.nullConvert(adminMenuVO.getMenuIcon());
		if (!"".equals(icon))
		{
			icon = String.format("<i class=\"%s\"></i>", icon);
		}

		return String.format("<a href=\"%s\" %s %s>%s%s</a>", href, target, onclick, icon, title);
	}%>