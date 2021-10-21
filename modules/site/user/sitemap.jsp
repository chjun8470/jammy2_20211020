<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.site.service.*" %>
<%!
public String getMenuLink(HttpServletRequest request,
		SiteInfoVO siteInfoVO, 
		SiteMenuJsonVO siteMenuJsonVO) {
	
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
	String title = "";
	if( target.equals("") ){
		title = siteMenuJsonVO.getMenuNm();
	}
	

	return String.format("<a href=\"%s\" %s %s>%s</a>", href, target, onclick, title);
}
%>
<%
	SiteManager siteManager = new SiteManager(request);
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
	
	String reqRow = EgovStringUtil.nullConvert(request.getParameter("row"), "3");
	
	int row;
	try
	{
		row = Integer.parseInt(reqRow);
	}
	catch (NumberFormatException e)
	{
		row = 0;
	}
%>

<div class="sitemap">
<%
	List<SiteMenuJsonVO> depth1list = siteManager.getMenuList(siteInfoVO.getSiteId(), 1, "Y");
	if (depth1list.size() > 0)
	{
		out.print("<div class=\"group\">");
		
		for (int i = 0; i < depth1list.size(); i++)
		{
			SiteMenuJsonVO depth1vo = (SiteMenuJsonVO)depth1list.get(i);
			
			out.print("<div class=\"item\">");
			out.print(String.format("<h4>%s", getMenuLink(request, siteInfoVO, depth1vo)));
			out.print("</h4>");
			
			List<SiteMenuJsonVO> depth2list = siteManager.getMenuList(siteInfoVO.getSiteId(), depth1vo.getMenuId(), "Y");
			if (depth2list.size() > 0)
			{
				out.print("<ul>");
				for (int j = 0; j < depth2list.size(); j++)
				{
					SiteMenuJsonVO depth2vo = (SiteMenuJsonVO)depth2list.get(j);
					out.print(String.format("<li>%s", getMenuLink(request, siteInfoVO, depth2vo)));
					
					List<SiteMenuJsonVO> depth3list = siteManager.getMenuList(siteInfoVO.getSiteId(), depth2vo.getMenuId(), "Y");
					if (depth3list.size() > 0)
					{
						out.print("<ul>");
						for (int k = 0; k < depth3list.size(); k++)
						{
							SiteMenuJsonVO depth3vo = (SiteMenuJsonVO)depth3list.get(k);
							out.print(String.format("<li>%s</li>", getMenuLink(request, siteInfoVO, depth3vo)));
						}
						out.print("</ul>");
					}
					out.print("</li>");
				}				
				out.print("</ul>");
			}
			out.print("</div>");
			
			if (row > 0)
			{
				if (i % row == (row-1))
				{
					out.print("</div>");
					out.print("<div class=\"group\">");
				}
			}			
		}
				

		out.print("</div>");
	}
%>		
</div>