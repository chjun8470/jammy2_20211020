<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<div class="container">
	<h1 class="logo">
		<a href="<c:out value='${BASE_URL}/main.do'/>"><img src="${LAYOUT_PATH}/images/common/logo.gif" alt="데모 홈페이지 - DEMO HOMEPAGE" /></a>	
	</h1>
	<div class="util">
		<div class="mn">
			<ul>
			<li><a href="<c:out value='${BASE_URL}/main.do'/>">홈</a></li>			
			<% if (!info.elsys.jnsp.util.ComUtil.loginCheck()) {%>
			<li><a href="<c:out value='${BASE_URL}/member/login.do'/>">로그인</a></li>
			<li><a href="<c:out value='${BASE_URL}/member/register/gnrl.do'/>">회원가입</a></li>
			<% } else { %>
			<li><a href="<c:out value='${BASE_URL}/member/logout.do'/>">로그아웃</a></li>
			<li><a href="<c:out value='${BASE_URL}/member/myinfo.do'/>">회원정보변경</a></li>
			<li><a href="<c:url value='/cms/admin/main.do'/>" target="_blank">관리자 바로가기</a></li>
			<% }  %>			
			<li><a href="<c:out value='${BASE_URL}/sitemap.do'/>">사이트맵</a></li>			
			</ul>
		</div>
	</div>

	<div class="top_search">
		<form action="<c:out value='${BASE_URL}/search.do'/>" method="get">
			<fieldset>
				<legend class="blind">통합검색</legend>
				<input type="text" name="query" class="search_keyword" placeholder="검색어를 입력하세요"  value="<c:out value='${queryString}'/>" />
				<button type="submit" class="btn_search"><span>검색</span></button>
			</fieldset>
		</form>		
	</div>

	<h2 class="blind"><a href="#gnb">주메뉴</a></h2>
	<div class="gnb" id="gnb">
	<%
	List<SiteMenuJsonVO> topmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), 1);
	if (topmenuList.size() > 0)
	{
		out.print("<ul id=\"topmenu\">");
		SiteMenuJsonVO topmenuVO;
		String liClass = "";
		for (int i = 0; i < topmenuList.size(); i++)
		{
			topmenuVO = (SiteMenuJsonVO)topmenuList.get(i);
			
			List<SiteMenuJsonVO> submenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), topmenuVO.getMenuId());
			boolean chldrns = submenuList.size() > 0 ? true : false;
			
			liClass = "m"+topmenuVO.getMenuId();
			if (parntsSiteMenuVOList.get(1) != null && topmenuVO.getMenuId() == parntsSiteMenuVOList.get(1).getMenuId()) {
				liClass += " active";
			}

			if (i == (topmenuList.size()-1)) {
				liClass += " last";
			}

			if (!"".equals(liClass)) {
				liClass = String.format("class=\"%s\"", liClass);
			}

			out.print(String.format("<li %s>%s", liClass, getMenuLink(request, siteInfoVO, topmenuVO, "", "txt", "")));
			
			if (chldrns)
			{
				out.print("<div class=\"sub\">");
				out.print("<ul>");
				for (int j = 0; j < submenuList.size(); j++)
				{
					SiteMenuJsonVO submenuVO = (SiteMenuJsonVO)submenuList.get(j);
					out.print(String.format("<li>%s</li>", getMenuLink(request, siteInfoVO, submenuVO, "", "txt", "")));					
				}
				out.print("</ul>");
				out.print("</div>");
			}
			out.print("</li>");
		}
		out.print("</ul>");		
	}
%>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
initNavigation(0);
//]]>
</script>