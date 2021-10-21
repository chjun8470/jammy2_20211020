<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.site.service.*" %>

<%@include file="include/func.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>전남지식재산정보은행</title>

<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7"  />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/board.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/board_3.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/common.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/sub.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/media_480.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/cont.css" media="all" rel="stylesheet" type="text/css" />

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

<c:forEach var="js" items="${jsList}">
       <script type="text/javascript" src="<c:out value='${js}'/>"></script>
</c:forEach>

<!-- 그래프 -->
<script type="text/javascript" src="https://code.highcharts.com/highcharts.js"></script>
<script type="text/javascript" src="https://code.highcharts.com/modules/exporting.js"></script>
<!-- 그래프 end-->

<script type="text/javascript" src="/js/cms/front/func_web.js"></script>
</head>
<body>

<!--Wrap S-->
<div class="Wrap">


    <!--HeaderWrap S-->
    <div class="HeaderWrap">
              <%@include file="include/header.jsp"%>
       </div>
       <!--HeaderWrap E-->


<!--SubWrap S-->
<div class="SubWrap">
       <!--SubBox S-->
       <div class="SubBox">
              <div class="TxtSubBox">
		      	<img src="/img/jipbank/sub/txt_sub_visual.png" alt="지식재산보호는 국가 경쟁력의 핵심입니다. 지식재산권 보호기반을 조성하고유관기관 협력 네트워크를 통해 국내 산업발전과 지식재산분야의 국제경쟁력 강화를 위해 창립되었습니다." />
		      </div>
              <!--leftMenu S-->
              <div id="leftMenu">
                     <%@include file="include/snb.jsp"%>
              </div>
              <!--leftMenu E-->



              <!--ContWrap S-->
              <div class="ContWrap">

                     <div class="cont_top">
                           <div class="cont_tit"><% if (siteMenuVO.getLvl() > 3) {%><%=parntsSiteMenuVOList.get(3).getMenuNm()%><%}else{%><%=siteMenuVO.getMenuNm()%><%}%></div>
                           <div class="navi">
                           <%
                             for (int z = 0; z < parntsSiteMenuVOList.size(); z++)
                             {
                                  SiteMenuVO vo = (SiteMenuVO)parntsSiteMenuVOList.get(z);
                                  String active = siteMenuVO.getMenuId() == vo.getMenuId() ? "class=\"active\"" : "" ;
                             if (z == 0) {
                                  active = "class=\"Blue\"";
                             }
                                  if(z != 0){
                                         out.print("&nbsp;&nbsp;>&nbsp;&nbsp;");
                                  }
                               out.print(String.format("<span %s>%s</span>", active, vo.getMenuNm()));
                             }
                             %>

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
    <%@include file="include/footer.jsp"%>

</div>
<!--FooterWrap E-->


</div>
<!--Wrap e-->

</body>
</html>