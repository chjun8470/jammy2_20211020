<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!--Headerinner S-->
<div class="Headerinner">

<div class="width1200">


    <!--탑 메뉴 S-->
	<!-- div class="top_menu">
		<ul>
            <li class="home"><a href="/jeinet/main.do">홈</a></li>
			<li class="jntis"><a href="http://jntis.jnsp.re.kr/jntis/main.do" target="_self" >JNTIS</a></li>

			<% if (!info.elsys.jnsp.util.ComUtil.loginCheck()) {%>
			<li><a href="javascript:ssoPopupShow('login','jeinet')">로그인</a></li>
			<li><a href="javascript:ssoPopupShow('join','jeinet')">회원가입</a></li>
			<% } else { %>
			<li><a href="<c:out value='${BASE_URL}/member/logout.do'/>">LOGOUT</a></li>
			<li><a href="javascript:ssoPopupShow('mypage','jeinet')">MYPAGE</a></li>
			<li><a href="<c:url value='/sys/main.do'/>" target="_blank">관리자</a></li>
			<%} %>
			<li><a href="<c:out value='/jeinet/sub.do?m=91'/>">SITEMAP</a></li>
		</ul>
	</div-->
	<!--탑 메뉴 E-->

	<button class="m_search"><img src="/img/mobile/main/sch_icon.png" alt="검색"></button>
	<div class="m_login">
		<% if (!info.elsys.jnsp.util.ComUtil.loginCheck()) {%>
		<a href="/sso/login.do?siteId=mjeinet">로그인</a>
		<% } %>
	</div>

	<div class="m_menu">
		<button class="m_menu_btn"><img src="/img/common/btn_m_menu.gif" alt="메뉴버튼" /></button>
	</div>

	<h1>
		<a href="/mjeinet/main.do">
			<img src="/img/common/logo.png" alt="JEINET 로고">
		</a>
	</h1>


	<div class="m_nav_wrap" >
		
		<div class="nav_login">
			<img src="/img/mobile/main/m_logo02.png">
            <button class="m_close_btn">X</button>
			<% if (!info.elsys.jnsp.util.ComUtil.loginCheck()) {%>
            <p class="white">로그인을 하시면 JEINET의 서비스를 이용할 수 있습니다.</p>
            <a  href="/sso/login.do?siteId=mjeinet" class="login_btn">JEINET 로그인</a>
			<% } else { %>
			<a  href="/sso/home.do?siteId=mjeinet" class="login_btn">마이페이지</a>
			<a  href="/sso/logout.do?siteId=mjeinet" class="login_btn">로그아웃</a>
			<%} %>
		</div>

	 <%
	List<SiteMenuJsonVO> topmenuList = siteManager.getMenuList(siteInfoVO.getSiteId(), 1);
	if (topmenuList.size() > 0)
	{
		out.print("<ul class=\"m_nav\" id=\"s_m_topmenu\">");
		SiteMenuJsonVO topmenuVO;
		String liClass = "";
		for (int i = 0; i < topmenuList.size(); i++)
		{
			
			
			
			liClass = "";
			topmenuVO = (SiteMenuJsonVO)topmenuList.get(i);
			
			System.out.println(topmenuVO.getMenuId());

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

			out.print(String.format("<li class=\"gnbli01\" %s>%s", liClass, getMenuLink(request, siteInfoVO, topmenuVO, "", "txt", "")));

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

	<div class="search_box">
	
	<form id = "unitySearch" name = "unitySearch" method="post" action="http://search.jnsp.re.kr/RSA/front/Search.jsp" target="_blank" class="boardSearch" onsubmit="return true;">
		<div class="search MAR0">
			<select name="select" class="select">
			<option value="allsearch">통합검색</option>
			</select>
			<input class="srch_txt" name="qt" type="text" title="검색단어입력" />
			<input type="image" src="/img/common/btn_srh.png" class="go_btn" alt="바로가기" />
		</div>
	</form>
	
	</div>



</div>

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
			out.print("<li>11<h2 style='display:inline-block;'>"+getMenuLink(request, siteInfoVO, topmenuVO, "", "txt", "")+"</h2>");
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
//<![CDATA[
/*$(function (){
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
});*/

$(function () {
                    $('#m_topmenu > li > h2').each(function (idx) {
                        $(this).mouseover(function () {
                            $('#m_topmenu > li > .gnb_sub').hide();
                            $('#m_submenu_' + idx).show();
                            $('.menu_back').show();
                        });
                        $(this).mouseout(function () {
                        });

                    });
                    $('#m_topmenu > li > h2 > a').each(function (idx) {
                        $(this).focus(function () {
                            $('#m_topmenu > li > .gnb_sub').hide();
                            $('#m_submenu_' + idx).show();
                        });
                    });
                    $('#m_topmenu > li > .gnb_sub').mouseover(function () {
                        $(this).slideDown();
                        $('.menu_back').slideDown();
                    });
                    $('#m_topmenu > li > .gnb_sub').mouseout(function () {
                        $(this).slideUp();
                        $('.menu_back').slideUp();
                    });
                    $('.m_search').click(function(){
                        if($(".search_box").is(":visible")){
                            $('.search_box').hide();
                        }else{
                            $('.search_box').fadeIn('fast');
                        }
                    });

                    $("#s_m_topmenu > li > a").attr("onclick", "return false");
					$("#s_m_topmenu > li").each(function(idx) {
						$(this).click(function() {
							$("#s_m_topmenu > li").removeClass("on");
							$(this).addClass("on");
							$('#s_m_topmenu > li').not($(this)).find(".gnbsub01").slideUp();
							$(this).find('.gnbsub01').slideToggle();
						});
					});
                    $(".m_menu_btn").click(function () {
                            $(".m_nav_wrap").fadeIn();
                    });
                    $(".m_close_btn").click(function () {
                            $(".m_nav_wrap").hide();
                    });
                    $("#top_menu_id_114").focusout(function () {
                        $('#m_topmenu > li > .gnb_sub').hide();
                    });

                });

//]]>
</script>
<!--gnbBox E-->
</div>
<!--Headerinner E-->

