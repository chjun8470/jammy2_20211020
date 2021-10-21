<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.site.service.*" %>

<%@include file="include/func.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>모바일-전남연구장비정보망</title>

<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7"  />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />


<link href="/css/cms/front/mobile/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/media_480.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/base.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/common.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/board.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/sub.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/main.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/basic.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/basic_grid.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/cont.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/login.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/my_page.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/board_3.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/mobile/media_480.css" media="all" rel="stylesheet" type="text/css" />

<!--[if lte IE 8]>
<link href="/css/cms/front/media_960.cs" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css" />
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js" type="text/javascript"></script>
<![endif]-->

<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js'/>"></script>
<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/common.js'/>"></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="/css/cms/front/basic_grid.css" />
<script type="text/javascript" src="/js/board.js"></script>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js" type="text/javascript"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=775c36174af77a7878a91ef218173921&libraries=services" type="text/javascript"></script>
<!-- <script src="//apis.daum.net/maps/maps3.js?apikey=09cdede77b4c4027e119e58c73d4e495&libraries=services" type="text/javascript"></script> -->

<c:forEach var="js" items="${jsList}">
	<script type="text/javascript" src="<c:out value='${js}'/>"></script>
</c:forEach>

<!-- 그래프 -->
<script type="text/javascript" src="https://code.highcharts.com/highcharts.js"></script>
<script type="text/javascript" src="https://code.highcharts.com/modules/exporting.js"></script>
<!-- 그래프 end-->

<script type="text/javascript" src="/js/cms/front/func_web.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
</head>
<body>

<!--Wrap S-->
<div class="Wrap">


    <!--HeaderWrap S-->
    <div class="HeaderWrap">
		<%@include file="include/header_mobile.jsp"%>
	</div>
	<!--HeaderWrap E-->


	<!--SubWrap S-->
	<div class="SubWrap">
		<!--SubBox S-->
		<img src="/img/mobile/sub/txt_visual.png" alt="세상을 바꾸는 과학기술 전남과학기술정보시스템 Jeonnam Science&amp;Technology Information System">
		<!--SubBox E-->
	</div>

	<!--SubBox S-->
	<div class="scontent">

		<!--leftMenu S-->
		<div id="leftMenu">
		
			<%@include file="include/snb.jsp"%>
			
		</div>
		<!--leftMenu E-->



		<!--ContWrap S-->
		<div class="ContWrap">

			<div class="cont_top">
				<div class="navi">
					<%
					  for (int z = 0; z < parntsSiteMenuVOList.size(); z++)
					  {
						SiteMenuVO vo = (SiteMenuVO)parntsSiteMenuVOList.get(z);
						String active = siteMenuVO.getMenuId() == vo.getMenuId() ? "class=\"active\"" : "";
					  if (z == 0) {
							//active = "class=\"Blue\"";
					  }
					  if(z == parntsSiteMenuVOList.size()-1){
						  active = "class=\"Blue\"";
					  }
						if(z != 0){
							out.print("&nbsp;&nbsp;>&nbsp;&nbsp;");
						}
						out.print(String.format("<span %s>%s</span>", active, vo.getMenuNm()));
					  }
					  %>
				</div>
				<div class="cont_tit">
					<% if (siteMenuVO.getLvl() > 3) {%><%=parntsSiteMenuVOList.get(3).getMenuNm()%><%}else{%><%=siteMenuVO.getMenuNm()%><%}%>
				</div>
				
			</div>
			<!--Contents S-->
			<div class="Contents">

					<c:import url="${contentFile}" />

			</div>
		</div>
		<!--ContWrap E-->
	</div>
	<!--SubBox E-->
</div>
<!--SubWrap E-->

<!--FooterWrap S-->
<div class="FooterWrap">
    <%@include file="include/footer_mobile.jsp"%>

</div>
<!--FooterWrap E-->


</div>
<!--Wrap e-->

</body>
</html>