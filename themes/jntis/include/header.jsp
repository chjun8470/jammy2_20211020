<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!--Headerinner S-->
<div class="Headerinner">

	<!--탑 메뉴 S-->
	<div class="top_menu">
		<ul>
            <li class="home"><a href="http://jntis.jnsp.re.kr/jntis/main.do"  id="topHeaderStart" >홈</a></li>
			<li class="jeinet"><a href="http://jeinet.jnsp.re.kr/jeinet/main.do" target="_self" >JEINET</a></li>
			<li class="jipbank"><a href="http://jipbank.jnsp.re.kr/jipbank/main.do" target="_self" >JIPBANK</a></li>
			<% if (!info.elsys.jnsp.util.ComUtil.loginCheck()) {%>
			<li><a href="javascript:ssoPopupShow('login','jntis')" title="새창열림">로그인</a></li>
			<li><a href="javascript:ssoPopupShow('join','jntis')" title="새창열림">회원가입</a></li>
			<% } else { %>
			<li><a href="<c:out value='${BASE_URL}/member/logout.do'/>">LOGOUT</a></li>
			<li><a href="javascript:ssoPopupShow('mypage','jntis')" title="새창열림">MYPAGE</a></li>
			<li><a href="<c:url value='/sys/main.do'/>" target="_blank">관리자</a></li>
			<%} %>
			<li><a href="<c:out value='${BASE_URL}/sub.do?m=102'/>">SITEMAP</a></li>
		</ul>
	</div>
	<!--탑 메뉴 E-->

	<h1><a href="/jntis/main.do"><img src="/img/jntis/common/logo.png" alt="JNTIS 로고" /></a></h1>


	<div class="m_menu">
		<button class="m_menu_btn"><img src="/img/jntis/common/btn_m_menu.gif" alt="메뉴 버튼" /></button>
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

	<form id = "unitySearch" name = "unitySearch" method="post" action="http://search.jnsp.re.kr/RSA/front/Search.jsp" target="_blank" class="boardSearch" onsubmit="return true;">
	<div class="search">
        
        <label class="hide" for="select">검색조건</label>
		<select name="select" class="select" id="select" title="원하시는 검색어를 입력 후, 검색 아이콘 버튼이나 엔터키를 누르시면 해당 페이지로 이동됩니다.">
	      <option value="allsearch">통합검색</option>
		</select>
        
        <label class="hide" for="qt">검색어</label>
		<input class="srch_txt" name="qt" type="text" id="qt" />
        
		<input type="image" src="/img/common/btn_srh.png" class="go_btn" alt="검색" title="새창열림" />
	</div>
	</form>

	<script type="text/javascript">
	//<![CDATA[
		function searchAction(){
			if($('#allSearchSel').val() == 'jeinet'){
				$('#allSearchForm').attr('action','http://jeinet.jnsp.re.kr/jeinet/sub.do?m=53');
				$('#totallmode').val('');
				$('#totalllistMode').val('');
				$('#totallsearchCd').val('');
			}else{
				$('#allSearchForm').attr('action','http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57');
				$('#totallsearchSelectText').val($('#totalsearchWord').val());
				$('#totalsearchWord').val('');
			}

			return true;
		}
	//]]>	
	</script>
	<!--gnbBox S-->
	<div class="gnbBox" >
    
    <h2 class="hide">주메뉴</h2>

	 <%
	topmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), 1);
	if (topmenuList.size() > 0)
	{
		out.print("<ul class=\"m_nav\" style=\"display:block\" id=\"m_topmenu\">");
		SiteMenuJsonVO topmenuVO;
		String liClass = "";
		String subLiClass = "";
		for (int i = 0; i < topmenuList.size(); i++)
		{
			topmenuVO = (SiteMenuJsonVO)topmenuList.get(i);
			List<SiteMenuJsonVO> submenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), topmenuVO.getMenuId());
			out.print("<li><h2 style='display:inline-block;'>"+getMenuLink(request, siteInfoVO, topmenuVO, "", "txt", "")+"</h2>");
			out.print("<div id='m_submenu_"+i+"' class=\"gnb_sub\" style=\"display:none;\">");

			for (int j = 0; j < submenuList.size(); j++){
				out.print("<ul>");
				if(j == 0){
					subLiClass="class=\"first\"";
				}else{
					subLiClass="";
				}
				SiteMenuJsonVO submenuVO = (SiteMenuJsonVO)submenuList.get(j);
				out.print(String.format("<li %s>%s</li>", subLiClass, getMenuLink(request, siteInfoVO, submenuVO, "", "txt", "")));
				out.print("</ul>");
			}
			out.print("</div></li>");
		}
		out.print("</ul>");
	}
%>


</div>
<script type="text/javascript">
//<![CDATA[
$(function (){
	$('#m_topmenu > li > h2').each(function(idx){
		$(this).mouseover(function(){
			$('#m_topmenu > li > .gnb_sub').hide();
			$('#m_submenu_'+idx).show();
		});
		$(this).mouseout(function(){

		});
		
	});
	$('#m_topmenu > li > h2 > a').each(function(idx){
		$(this).focus(function(){
			$('#m_topmenu > li > .gnb_sub').hide();
			$('#m_submenu_'+idx).show();
		});
	});
	$('#m_topmenu > li > .gnb_sub').mouseover(function(){
		$(this).show();
	});
	$('#m_topmenu > li > .gnb_sub').mouseout(function(){
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

//]]>
</script>
<!--gnbBox E-->
</div>
<!--Headerinner E-->

