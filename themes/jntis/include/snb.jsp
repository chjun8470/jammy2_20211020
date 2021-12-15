<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.site.service.*" %>



<%
	if (parntsSiteMenuVOList.get(1) != null)
	{
		SiteMenuVO leftmenuTitleVO = (SiteMenuVO)parntsSiteMenuVOList.get(1);
%>
<div class="lnb_tit">
	<p class="tit01"><%=leftmenuTitleVO.getMenuNm()%></p>
	<h2>
		<%=leftmenuTitleVO.getMenuNm().equals("JNTIS 소개") ? "ABOUT<br/>JNTIS" :
			leftmenuTitleVO.getMenuNm().equals("사업정보") ? "BUSINESS<br/>INFORMATION" :
			leftmenuTitleVO.getMenuNm().equals("행사·교육정보") ? "EDU·EVENT<br/>INFORMATION" :
			leftmenuTitleVO.getMenuNm().equals("과학기술정보") ? "SCIENCE<br/>INFORMATION" :
			leftmenuTitleVO.getMenuNm().equals("기업정보") ? "ENTERPRISE<br/>INFORMATION" :
			leftmenuTitleVO.getMenuNm().equals("커뮤니티") ? "COMMUNITY" :
			leftmenuTitleVO.getMenuNm().equals("전문가정보") ? "EXPERT<br/>INFORMATION" :
			leftmenuTitleVO.getMenuNm().equals("기타") ? "OTHER" :""
		%>
	</h2>
</div>

<%
		List<SiteMenuJsonVO> leftmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), leftmenuTitleVO.getMenuId());
		if (leftmenuList.size() > 0)
		{
			out.print("<ul class=\"leftMenuList\">");
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
					addClass = "on";
				}

				if (chldrns)
				{
					addClass += "";
				}

				out.print(String.format("<li  id=\"left0%s\" class=\"s%d %s\">%s", (i+1),leftmenuVO.getMenuId(), addClass, getMenuLink(request, siteInfoVO, leftmenuVO, "", "txt", "")));

				//if (chldrns && (parntsSiteMenuVOList.get(2) != null)) 3���޴� ��ĥ��
				if (chldrns && (parntsSiteMenuVOList.get(2) != null && leftmenuVO.getMenuId() == parntsSiteMenuVOList.get(2).getMenuId()))
				{
					out.print("<div id=\"leftSub0"+(i+1)+"\" style=\"display: block;\">");
					out.print(String.format("<ul class=\"%s\">", "s"+leftmenuVO.getMenuId()));
					for (int j = 0; j < submenuList.size(); j++)
					{
						SiteMenuJsonVO submenuVO = (SiteMenuJsonVO)submenuList.get(j);

						activeClass2 = "";
						if (parntsSiteMenuVOList.get(3) != null && submenuVO.getMenuId() == parntsSiteMenuVOList.get(3).getMenuId())
						{
							activeClass2 = "class=\"on\"";
						}

						out.print(String.format("<li id=\"leftSubImg0"+(i+1)+"0"+(j+1)+"\" %s>%s</li>", activeClass2, getMenuLink(request, siteInfoVO, submenuVO, "", "txt", "")));
					}
					out.print("</ul>");
					out.print("</div>");
				}

				out.print("</li>");
			}
			out.print("</ul>");
		}
	}

%>
