<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.util.EgovUserDetailsHelper" %>
<%@ page import="egovframework.jammy2.cmm.LoginVO" %>
<%@ page import="egovframework.jammy2.site.service.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	SiteManager siteManager = new SiteManager(request);

	LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");

	SiteMenuVO siteMenuVO = (SiteMenuVO)request.getAttribute("SITE_MENU");

	request.setAttribute("CONTENT_PATH", "/sites/"+siteInfoVO.getSiteId());
	request.setAttribute("SITE_ID", siteInfoVO.getSiteId());

	HashMap<Integer, SiteMenuVO> parntsSiteMenuVOList = new HashMap<Integer, SiteMenuVO>();

	if (siteMenuVO != null)
	{
		List<SiteMenuVO> list = siteManager.getParntsMenuList(siteInfoVO.getSiteId(), siteMenuVO.getMenuId());
		for (int i = 0; i < list.size(); i++)
		{
			SiteMenuVO vo = (SiteMenuVO) list.get(i);
			parntsSiteMenuVOList.put(i, vo);
		}
		parntsSiteMenuVOList.put(list.size(), siteMenuVO);
	}
%>
<%!public String getMenuLink(HttpServletRequest request,
			SiteInfoVO siteInfoVO,
			SiteMenuJsonVO siteMenuJsonVO,
			String addAttr,
			String menuType,
			String fileExt) {

		String layoutPath = String.format("/themes/%s/%s", siteMenuJsonVO.getThemeId(), siteMenuJsonVO.getLayout());

		String href = request.getContextPath().concat("/"+siteInfoVO.getSiteId());
		if ("MENU_LINK".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = href.concat("/sub.do?m=" + siteMenuJsonVO.getLinkMenuId());
		}
		else if ("BOARD".equals(siteMenuJsonVO.getMenuTy()) || "PROGRAM".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = request.getContextPath() + siteMenuJsonVO.getLinkUrl().replace("cms", siteMenuJsonVO.getSiteId()) + "?m="+siteMenuJsonVO.getMenuId();
		}
		else if ("LINK_IN".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = request.getContextPath() + siteMenuJsonVO.getLinkUrl();
		}
		else if ("LINK_OUT".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = siteMenuJsonVO.getLinkUrl();
		}
		else
		{
			href = href.concat("/sub.do?m=" + siteMenuJsonVO.getMenuId());
		}

		String target = (siteMenuJsonVO.getLinkTarget().equals("_BLANK")) ? "target=\"_blank\" title=\"새창\"" : "";
		String onclick = (siteMenuJsonVO.getLinkTarget().equals("_POPUP")) ? "onclick=\"window.open(this.href, 'menu" + siteMenuJsonVO.getMenuId() + "', '" + siteMenuJsonVO.getPopupParam() + "'); return false;\"" : "";

		String title = siteMenuJsonVO.getMenuNm();
		if (menuType.equals("image"))
		{
			fileExt = (fileExt == null || "".equals(fileExt)) ? "gif" : fileExt;
			title = "<img src=\""+layoutPath+"/images/common/topmenu_"+siteMenuJsonVO.getMenuId()+"."+fileExt+"\" alt=\""+siteMenuJsonVO.getMenuNm()+"\" />";
		}
		String menuTitle = "";
		if( target.equals("") ){
			menuTitle ="title=\""+title+"\"";
		}
		
		String iblank = "";
		/* if (siteMenuJsonVO.getLinkTarget().equals("_BLANK")) {
			iblank = " <span class=\"iblank\">새창</span>";
		} */
		return String.format("<a class='top_menu_id_%s' href=\"%s\" %s %s %s %s>%s%s</a>",siteMenuJsonVO.getMenuId(), href, menuTitle, addAttr, target.replaceAll("&amp;","&").replaceAll("&","&amp;"), onclick.replaceAll("&amp;","&").replaceAll("&","&amp;"), title.replaceAll("&amp;","&").replaceAll("&","&amp;"), iblank);
		//return String.format("<a href=\"%s\" %s %s %s>%s%s</a>", href, addAttr, target.replaceAll("&amp;","&").replaceAll("&","&amp;"), onclick.replaceAll("&amp;","&").replaceAll("&","&amp;"), title.replaceAll("&amp;","&").replaceAll("&","&amp;"), iblank);
	}%>
<%!public String getSubMenuLink(HttpServletRequest request,
			SiteInfoVO siteInfoVO,
			SiteMenuJsonVO siteMenuJsonVO,
			String addAttr,
			String menuType,
			String fileExt) {

		String layoutPath = String.format("/themes/%s/%s", siteMenuJsonVO.getThemeId(), siteMenuJsonVO.getLayout());

		String href = request.getContextPath().concat("/"+siteInfoVO.getSiteId());
		if ("MENU_LINK".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = href.concat("/sub.do?m=" + siteMenuJsonVO.getLinkMenuId());
		}
		else if ("BOARD".equals(siteMenuJsonVO.getMenuTy()) || "PROGRAM".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = request.getContextPath() + siteMenuJsonVO.getLinkUrl().replace("cms", siteMenuJsonVO.getSiteId()) + "?m="+siteMenuJsonVO.getMenuId();
		}
		else if ("LINK_IN".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = request.getContextPath() + siteMenuJsonVO.getLinkUrl();
		}
		else if ("LINK_OUT".equals(siteMenuJsonVO.getMenuTy()))
		{
			href = siteMenuJsonVO.getLinkUrl();
		}
		else
		{
			href = href.concat("/sub.do?m=" + siteMenuJsonVO.getMenuId());
		}

		String target = (siteMenuJsonVO.getLinkTarget().equals("_BLANK")) ? "target=\"_blank\" title=\"새창\"" : "";
		String onclick = (siteMenuJsonVO.getLinkTarget().equals("_POPUP")) ? "onclick=\"window.open(this.href, 'menu" + siteMenuJsonVO.getMenuId() + "', '" + siteMenuJsonVO.getPopupParam() + "'); return false;\"" : "";

		String title = siteMenuJsonVO.getMenuNm();
		if (menuType.equals("image"))
		{
			fileExt = (fileExt == null || "".equals(fileExt)) ? "gif" : fileExt;
			title = "<img src=\""+layoutPath+"/images/common/topmenu_"+siteMenuJsonVO.getMenuId()+"."+fileExt+"\" alt=\""+siteMenuJsonVO.getMenuNm()+"\" />";
		}
		String menuTitle = "";
		if( target.equals("") ){
			menuTitle ="title=\""+title+"\"";
		}
		
		String iblank = "";
		/* if (siteMenuJsonVO.getLinkTarget().equals("_BLANK")) {
			iblank = " <span class=\"iblank\">새창</span>";
		} */
		//return String.format("<a id='top_menu_id_%s' href=\"%s\" %s %s %s %s>%s%s</a>",siteMenuJsonVO.getMenuId(), href, menuTitle, addAttr, target.replaceAll("&amp;","&").replaceAll("&","&amp;"), onclick.replaceAll("&amp;","&").replaceAll("&","&amp;"), title.replaceAll("&amp;","&").replaceAll("&","&amp;"), iblank);
		return String.format("<a href=\"%s\" %s %s %s>%s%s</a>", href, addAttr, target.replaceAll("&amp;","&").replaceAll("&","&amp;"), onclick.replaceAll("&amp;","&").replaceAll("&","&amp;"), title.replaceAll("&amp;","&").replaceAll("&","&amp;"), iblank);
	}%>

