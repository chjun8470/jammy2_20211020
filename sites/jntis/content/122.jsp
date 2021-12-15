<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO;"%>
<% 
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
    SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"));
	String listMode = util.getStr(request.getParameter("listMode"));
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");
	String searchType = util.getStr(request.getParameter("searchType"));
	String searchWord = util.getStr(request.getParameter("searchWord"));
	String boardIdx = util.getStr(request.getParameter("boardIdx"));
	String boardComIdx = "00028";//코드를 입력하세요
    
    String siteId = util.getStr(request.getParameter("siteId")); //게시판 구분
    String sclas = "LAWORD"; //관련법령 게시판 분류
%>
<div class="skin_line" style="display:block;height:10px;"></div>
	<div class="tabBox_pub">
		<ul>
			<li><a href="/jntis/sub.do?m=121">정책이슈</a></li>
			<li class="on"><a href="/jntis/sub.do?m=122">관련법령</a></li>
            <li><a href="/jntis/sub.do?m=123">발간물</a></li>
			<li><a href="/jntis/sub.do?m=124">통계자료</a></li>			
		</ul>
	</div>

        
<jsp:include page="/web/comBoard.do" flush="true">
	<jsp:param name="mode" value="<%=mode%>"/>
	<jsp:param name="listMode" value="<%=listMode%>"/>
	<jsp:param name="nowPage" value="<%=nowPage%>"/>
	<jsp:param name="searchType" value="<%=searchType%>"/>
	<jsp:param name="searchWord" value="<%=searchWord%>"/>
	<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
	<jsp:param name="m" value="122"/>
	<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
    <jsp:param name="lclas" value="<%=siteId%>"/>
    <jsp:param name="sclas" value="<%=sclas%>"/>
</jsp:include>