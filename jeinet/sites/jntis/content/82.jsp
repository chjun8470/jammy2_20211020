<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO"%>
<%
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
    SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
    siteInfoVO.setSiteId("jipbank");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"));
	String listMode = util.getStr(request.getParameter("listMode"));
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");
	String searchType = util.getStr(request.getParameter("searchType"));
	String searchWord = util.getStr(request.getParameter("searchWord"));
	String boardIdx = util.getStr(request.getParameter("boardIdx"));
	String boardComIdx = "00028";//코드를 입력하세요

    String siteId = util.getStr(request.getParameter("siteId")); //게시판 구분
%>
<div class="skin_line" style="display:block;height:10px;"></div>

<jsp:include page="/web/comBoard.do" flush="true">
	<jsp:param name="mode" value="<%=mode%>"/>
	<jsp:param name="listMode" value="<%=listMode%>"/>
	<jsp:param name="nowPage" value="<%=nowPage%>"/>
	<jsp:param name="searchType" value="<%=searchType%>"/>
	<jsp:param name="searchWord" value="<%=searchWord%>"/>
	<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
	<jsp:param name="m" value="82"/>
	<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
    <jsp:param name="lclas" value="<%=siteId%>"/>
    <jsp:param name="allYN" value="all"/>
</jsp:include>