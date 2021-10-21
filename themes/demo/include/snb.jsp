<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.site.service.*" %>
<%
	if (parntsSiteMenuVOList.get(1) != null)
	{
		SiteMenuVO leftmenuTitleVO = (SiteMenuVO)parntsSiteMenuVOList.get(1);
%>
	<h2 class="snb_title"><%=leftmenuTitleVO.getMenuNm()%></h2>	
		
<%
		List<SiteMenuJsonVO> leftmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), leftmenuTitleVO.getMenuId());
		if (leftmenuList.size() > 0)
		{			
			out.print("<ul>");
			SiteMenuJsonVO leftmenuVO;
			String addClass;
			String activeClass2;
			for (int i = 0; i < leftmenuList.size(); i++)
			{
				leftmenuVO = (SiteMenuJsonVO)leftmenuList.get(i);
				
				List<SiteMenuJsonVO> submenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), leftmenuVO.getMenuId());
				boolean chldrns = submenuList.size() > 0 ? true : false;
				
				addClass = "";
				if (parntsSiteMenuVOList.get(2) != null && leftmenuVO.getMenuId() == parntsSiteMenuVOList.get(2).getMenuId())
				{
					addClass = " active";
				}

				if (chldrns)
				{
					addClass += " child";
				}
				
				out.print(String.format("<li class=\"s%d %s\">%s", leftmenuVO.getMenuId(), addClass, getMenuLink(request, siteInfoVO, leftmenuVO, "", "txt", "")));

				//if (chldrns && (parntsSiteMenuVOList.get(2) != null)) 3���޴� ��ĥ��
				if (chldrns && (parntsSiteMenuVOList.get(2) != null && leftmenuVO.getMenuId() == parntsSiteMenuVOList.get(2).getMenuId()))
				{
					out.print(String.format("<ul class=\"%s\">", "s"+leftmenuVO.getMenuId()));
					for (int j = 0; j < submenuList.size(); j++)
					{						
						SiteMenuJsonVO submenuVO = (SiteMenuJsonVO)submenuList.get(j);
						
						activeClass2 = "";
						if (parntsSiteMenuVOList.get(3) != null && submenuVO.getMenuId() == parntsSiteMenuVOList.get(3).getMenuId())
						{
							activeClass2 = "class=\"active\"";
						}						
						
						out.print(String.format("<li %s>%s</li>", activeClass2, getMenuLink(request, siteInfoVO, submenuVO, "", "txt", "")));					
					}
					out.print("</ul>");
				}

				out.print("</li>");
			}
			out.print("</ul>");	
		}				
	}
%>