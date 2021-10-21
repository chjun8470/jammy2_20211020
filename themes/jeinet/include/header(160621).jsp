<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!--Headerinner S-->
<div class="Headerinner">

    
    <!--탑 메뉴 S-->
	<div class="top_menu">
		<ul>
			<li class="first"><a href="/jeinet/main.do">JEINET</a></li>
			<li><a href="/jipbank/main.do">JIPBANK</a></li>
            <li><a href="/jntis/main.do">JNTIS</a></li>
			<% if (!EgovUserDetailsHelper.isAuthenticated()) {%>
			<li><a href="javascript:ssoPopupShow('login')">로그인</a></li>
			<li><a href="javascript:ssoPopupShow('join')">회원가입</a></li>
			<% } else { %>
			<li><a href="<c:out value='${BASE_URL}/member/logout.do'/>">LOGOUT</a></li>
			<li><a href="javascript:ssoPopupShow('mypage')">MYPAGE</a></li>
			<li><a href="<c:url value='/sys/main.do'/>" target="_blank">관리자</a></li>
			<%} %>
			<li><a href="<c:out value='${BASE_URL}/sub.do?m=91'/>">SITEMAP</a></li>
		</ul>
	</div>
	<!--탑 메뉴 E-->

	
	<!--탑 메뉴 S-->
	<!--
	<div class="top_menu">
		<ul>
			<li class="first"><a href="#">JNTIS</a></li>
			<li><a href="/jeinet/main.do">HOME</a></li>
			<% if (!EgovUserDetailsHelper.isAuthenticated()) {%>
			<li><a href="javascript:ssoPopupShow('login')">로그인</a></li>
			<li><a href="javascript:ssoPopupShow('join')">회원가입</a></li>
			<% } else { %>
			<li><a href="<c:out value='${BASE_URL}/member/logout.do'/>">LOGOUT</a></li>
			<li><a href="javascript:ssoPopupShow('mypage')">MYPAGE</a></li>
			<li><a href="<c:url value='/sys/main.do'/>" target="_blank">관리자</a></li>
			<%} %>
			<li><a href="<c:out value='${BASE_URL}/sitemap.do'/>">SITEMAP</a></li>
		</ul>
	</div>
	-->
	<!--탑 메뉴 E-->
	

	<div class="logo"><a href="/jeinet/main.do"><img src="/img/common/logo.png" alt="JEINET 로고" /></a></div>


	<div class="m_menu">
		<button class="m_menu_btn"><img src="/img/common/btn_m_menu.gif" alt="메뉴버튼" /></button>
	</div>


	<div class="m_nav_wrap" >


	 <%
	List<SiteMenuJsonVO> topmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), 1);
	if (topmenuList.size() > 0)
	{
		out.print("<ul class=\"m_nav\" style=\"display:none\" id=\"s_m_topmenu\">");
		SiteMenuJsonVO topmenuVO;
		String liClass = "";
		for (int i = 0; i < topmenuList.size(); i++)
		{
			liClass = "";
			topmenuVO = (SiteMenuJsonVO)topmenuList.get(i);

			List<SiteMenuJsonVO> submenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), topmenuVO.getMenuId());
			boolean chldrns = submenuList.size() > 0 ? true : false;

			//liClass = "m"+topmenuVO.getMenuId();
			if (parntsSiteMenuVOList.get(1) != null && topmenuVO.getMenuId() == parntsSiteMenuVOList.get(1).getMenuId()) {
				liClass += " on";
			}

			if (i == (topmenuList.size()-1)) {
				liClass += " last";
			}

			if (!"".equals(liClass)) {
				liClass = String.format("class=\"gnb0%s %s\"", (i+1),liClass);
			}

			out.print(String.format("<li %s>%s", liClass, getMenuLink(request, siteInfoVO, topmenuVO, "", "txt", "")));

			if (chldrns)
			{
				if(liClass.contains("on")) {
					out.print("<div class=\"gnbsub01\">");
				} else {
					out.print("<div class=\"gnbsub01\" style=\"display:none\">");
				}
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

	<form id = "allSearchForm" name = "allSearchForm" method="post" action="/jeinet/sub.do?m=53" class="boardSearch">
	<div class="search">
		<select name="select" class="select">
		<option value="allsearch">통합검색</option>
		</select>
		<input class="srch_txt" name="searchWord" type="text" title="검색단어입력" />
		<input type="image" src="/img/common/btn_srh.png" class="go_btn" alt="바로가기" />
	</div>
	</form>
	<!--gnbBox S-->
	<div class="gnbBox" >

	 <%
	topmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), 1);
	if (topmenuList.size() > 0)
	{
		out.print("<ul class=\"m_nav\" style=\"display:block\" id=\"m_topmenu\">");
		SiteMenuJsonVO topmenuVO;
		String liClass = "";
		for (int i = 0; i < topmenuList.size(); i++)
		{
			topmenuVO = (SiteMenuJsonVO)topmenuList.get(i);
			List<SiteMenuJsonVO> submenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), topmenuVO.getMenuId());
			out.print("<li><h2 style='display:inline-block;'>"+getMenuLink(request, siteInfoVO, topmenuVO, "", "txt", "")+"</h2>");
			out.print("<div id='m_submenu_"+i+"' class=\"gnb_sub\" style=\"display:none;\">");
			for (int j = 0; j < submenuList.size(); j++){
				out.print("<ul>");
				SiteMenuJsonVO submenuVO = (SiteMenuJsonVO)submenuList.get(j);
				out.print(String.format("<li>%s</li>", getMenuLink(request, siteInfoVO, submenuVO, "", "txt", "")));
				out.print("</ul>");
			}
			out.print("</div></li>");
		}
		out.print("</ul>");
	}
%>


</div>
<script type="text/javascript">

$(function (){
	$('#m_topmenu > li > h2').each(function(idx){

		$(this).mouseover(function(){
			$('#m_topmenu > li > .gnb_sub').hide();
			$('#m_submenu_'+idx).show();
		});
		$(this).mouseout(function(){

		});
	});
	$('#m_topmenu > li  > .gnb_sub').mouseover(function(){
		$(this).show();
	});
	$('#m_topmenu > li  > .gnb_sub').mouseout(function(){
		$(this).hide();
	});

	$("#s_m_topmenu > li > a").attr("onclick", "return false");
	$("#s_m_topmenu > li").each(function(idx) {
		$(this).click(function() {
			$("#s_m_topmenu > li").removeClass("on");
			$(this).addClass("on");
			$("#s_m_topmenu > li > div").hide();
			$(this).find('> div').show();
		});
	});

	$(".m_menu_btn").click(function() {
		if($("#s_m_topmenu").is(":visible")) {
			$("#s_m_topmenu").slideUp();
		} else {
			$("#s_m_topmenu").slideDown();
		}
	});
});


</script>
<!--gnbBox E-->
</div>
<!--Headerinner E-->

