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
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"),"list");
    String listMode = util.getStr(request.getParameter("listMode"),"image");
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");
	String searchType = util.getStr(request.getParameter("searchType"));
	String searchWord = util.getStr(request.getParameter("searchWord"));
	String boardIdx = util.getStr(request.getParameter("boardIdx"));
	String m = util.getStr(request.getParameter("m"));
    String siteId = util.getStr(request.getParameter("siteId"));//사이트구분
	String boardComIdx = "00028";//코드를 입력하세요
    String sclas = "";//게시판 구분1
    String allYN = "all_jipbank"; //게시판 구분2
%>
<jsp:include page="/web/comBoard.do" flush="true">
	<jsp:param name="mode" value="<%=mode%>"/>
	<jsp:param name="listMode" value="<%=listMode%>"/>
	<jsp:param name="nowPage" value="<%=nowPage%>"/>
	<jsp:param name="searchType" value="<%=searchType%>"/>
	<jsp:param name="searchWord" value="<%=searchWord%>"/>
	<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
	<jsp:param name="m" value="82"/>
	<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
    <jsp:param name="siteId" value="<%=siteId%>"/>
    <jsp:param name="sclas" value="<%=sclas%>"/>
    <jsp:param name="allYN" value="<%=allYN%>"/>
</jsp:include>