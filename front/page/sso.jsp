<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>

<%
	request.setCharacterEncoding("UTF-8");

	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
	LoginVO loginVO = util.getLoginInfo(request); //세션정보 가져오기

	String menuPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String nowPage = util.getStr(paramMap.get("nowPage"),"0");
	String userAppState = util.getStr(loginVO.getUserAppState());
	String pageMode = util.getStr(paramMap.get("pageMode"));
	String mode = util.getStr(paramMap.get("mode"));

	HashMap menuMap = new HashMap();

	menuMap.put("mypagecon", "deth=|1||1|");
	menuMap.put("mypage", "deth=|1||1|");
	menuMap.put("passChange", "deth=|1||2|");
	menuMap.put("leave", "deth=|1||3|");
	menuMap.put("agecon", "deth=|1||4|");
	menuMap.put("agechange", "deth=|1||4|");
	menuMap.put("equorder", "deth=|2||1|");
	menuMap.put("myfav", "deth=|2||2|");
	menuMap.put("education", "deth=|3||1|");
	menuMap.put("event", "deth=|4||1|");
	menuMap.put("changeboard", "deth=|5||1|");
	menuMap.put("advice_01", "deth=|6||1|");
	menuMap.put("advice_02", "deth=|6||2|");
	menuMap.put("advice_03", "deth=|6||3|");
	menuMap.put("advice_04", "deth=|6||4|");
	menuMap.put("advice_05", "deth=|6||5|");

	HashMap dethMap = util.getDeth(menuMap,pageMode);
	String menu1 = util.getStr(dethMap.get("deth1"));
	String menu2 = util.getStr(dethMap.get("deth2"));
	
	
	

%>




	
	<%@include file="/front/_temple/sso/t_top.jsp" %>

	
	<%

		if("login".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><%@include file="/front/_module/sso/login.jsp" %><%
			 }else{
				%><script type="text/javascript" >location.href="/sso/home.do";</script><%
			}
		}else if("join".equals(pageMode)) {

			if(!"".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/home.do";</script><%
			}else{
				%>
				<%@include file="/front/_module/sso/join.jsp" %>
				<%
			}

		}else if("idpwd".equals(pageMode)) {

			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><%@include file="/front/_module/sso/idpwd.jsp" %><%
			}else{
				%><%@include file="/front/_module/sso/home.jsp" %><%
			}

		}else if("mypagecon".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
			%><%@include file="/front/_module/sso/mypagecon.jsp" %><%
			}

		}else if("agecon".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
			%><%@include file="/front/_module/sso/agecon.jsp" %><%
			}

		}else if("agechange".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
			%><%@include file="/front/_module/sso/agechange.jsp" %><%
			}

		}else if("mypage".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
			%><%@include file="/front/_module/sso/mypage.jsp" %><%
			}

		}else if("deluser".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
				%><%@include file="/front/_module/sso/deluser.jsp" %><%
			}
		}else if("equorder".equals(pageMode)) {

			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
				%>
			<jsp:include page="/sso/eqReservationOrder.do" flush="true">
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage %>"/>
			</jsp:include>
			<%}

		}else if("myfav".equals(pageMode)) {

			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
				%>
			<jsp:include page="/sso/myFav.do" flush="true">
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage %>"/>
			</jsp:include>
				<%
			}

		}else if("education".equals(pageMode)) {

			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
				%>
			<jsp:include page="/education/edu.do" flush="true">
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage %>"/>
			</jsp:include>
				<%
			}
		}else if("event".equals(pageMode)) {

			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
				%>
			<jsp:include page="/web/event.do" flush="true">
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage %>"/>
			</jsp:include>
				<%
			}

		}else if("changeboard".equals(pageMode)) {

			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{

				 String listMode = util.getStr(request.getParameter("listMode"));
				 String searchType = util.getStr(request.getParameter("searchType"));
				 String searchWord = util.getStr(request.getParameter("searchWord"));
				 String boardIdx = util.getStr(request.getParameter("boardIdx"));
				 String boardComIdx = "00008";//코드를 입력하세요
			%>
			<jsp:include page="/web/comBoard.do" flush="true">
				 <jsp:param name="mode" value="<%=mode%>"/>
				 <jsp:param name="listMode" value="<%=listMode%>"/>
				 <jsp:param name="nowPage" value="<%=nowPage%>"/>
				 <jsp:param name="searchType" value="<%=searchType%>"/>
				 <jsp:param name="searchWord" value="<%=searchWord%>"/>
				 <jsp:param name="boardIdx" value="<%=boardIdx%>"/>
				 <jsp:param name="m" value="mypage"/>
				 <jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
			</jsp:include>
			<%
				}

		}else if("leave".equals(pageMode)) {
				if("".equals(util.getStr(loginVO.getUserIdx()))) {
					%><script type="text/javascript">location.href="/sso/login.do";</script><%
				}else{
					%><%@include file="/front/_module/sso/leave.jsp" %><%
				}
		}else if("passChange".equals(pageMode)) {
			if("".equals(util.getStr(loginVO.getUserIdx()))) {
				%><script type="text/javascript">location.href="/sso/login.do";</script><%
			}else{
				%><%@include file="/front/_module/sso/passChange.jsp" %><%
			}

		}	else if("advice_01".equals(pageMode)){
			String listMode = util.getStr(request.getParameter("listMode"));
			String searchType = util.getStr(request.getParameter("searchType"));
			String searchWord = util.getStr(request.getParameter("searchWord"));
			String boardIdx = util.getStr(request.getParameter("boardIdx"));
			String m = util.getStr(request.getParameter("m"));
			String boardComIdx = "00024";//코드를 입력하세요
			%>
			<jsp:include page="/web/comBoard.do" flush="true">
				<jsp:param name="searchUser" value="Y"/>
				<jsp:param name="pageMode" value="<%=pageMode%>"/>
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="listMode" value="<%=listMode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage%>"/>
				<jsp:param name="searchType" value="<%=searchType%>"/>
				<jsp:param name="searchWord" value="<%=searchWord%>"/>
				<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
				<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
			</jsp:include>
			<%
		}	else if("advice_02".equals(pageMode)){
			String listMode = util.getStr(request.getParameter("listMode"));
			String searchType = util.getStr(request.getParameter("searchType"));
			String searchWord = util.getStr(request.getParameter("searchWord"));
			String boardIdx = util.getStr(request.getParameter("boardIdx"));
			String m = util.getStr(request.getParameter("m"));
			String boardComIdx = "00025";//코드를 입력하세요
			%>
			<jsp:include page="/web/comBoard.do" flush="true">
				<jsp:param name="searchUser" value="Y"/>
				<jsp:param name="pageMode" value="<%=pageMode%>"/>
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="listMode" value="<%=listMode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage%>"/>
				<jsp:param name="searchType" value="<%=searchType%>"/>
				<jsp:param name="searchWord" value="<%=searchWord%>"/>
				<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
				<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
			</jsp:include>
			<%
		}	else if("advice_03".equals(pageMode)){
			String listMode = util.getStr(request.getParameter("listMode"));
			String searchType = util.getStr(request.getParameter("searchType"));
			String searchWord = util.getStr(request.getParameter("searchWord"));
			String boardIdx = util.getStr(request.getParameter("boardIdx"));
			String m = util.getStr(request.getParameter("m"));
			String boardComIdx = "00027";//코드를 입력하세요
			%>
			<jsp:include page="/web/comBoard.do" flush="true">
				<jsp:param name="searchUser" value="Y"/>
				<jsp:param name="pageMode" value="<%=pageMode%>"/>
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="listMode" value="<%=listMode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage%>"/>
				<jsp:param name="searchType" value="<%=searchType%>"/>
				<jsp:param name="searchWord" value="<%=searchWord%>"/>
				<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
				<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
			</jsp:include>
			<%
		}	else if("advice_04".equals(pageMode)){
			String listMode = util.getStr(request.getParameter("listMode"));
			String searchType = util.getStr(request.getParameter("searchType"));
			String searchWord = util.getStr(request.getParameter("searchWord"));
			String boardIdx = util.getStr(request.getParameter("boardIdx"));
			String m = util.getStr(request.getParameter("m"));
			String boardComIdx = "00010";//코드를 입력하세요
			%>
			<jsp:include page="/web/comBoard.do" flush="true">
				<jsp:param name="searchUser" value="Y"/>
				<jsp:param name="pageMode" value="<%=pageMode%>"/>
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="listMode" value="<%=listMode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage%>"/>
				<jsp:param name="searchType" value="<%=searchType%>"/>
				<jsp:param name="searchWord" value="<%=searchWord%>"/>
				<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
				<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
			</jsp:include>
			<%
		}	else if("advice_05".equals(pageMode)){
			String listMode = util.getStr(request.getParameter("listMode"));
			String searchType = util.getStr(request.getParameter("searchType"));
			String searchWord = util.getStr(request.getParameter("searchWord"));
			String boardIdx = util.getStr(request.getParameter("boardIdx"));
			String m = util.getStr(request.getParameter("m"));
			String boardComIdx = "00011";//코드를 입력하세요
			%>
			<jsp:include page="/web/comBoard.do" flush="true">
				<jsp:param name="searchUser" value="Y"/>
				<jsp:param name="pageMode" value="<%=pageMode%>"/>
				<jsp:param name="mode" value="<%=mode%>"/>
				<jsp:param name="listMode" value="<%=listMode%>"/>
				<jsp:param name="nowPage" value="<%=nowPage%>"/>
				<jsp:param name="searchType" value="<%=searchType%>"/>
				<jsp:param name="searchWord" value="<%=searchWord%>"/>
				<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
				<jsp:param name="boardComIdx" value="<%=boardComIdx%>"/>
			</jsp:include>
			<%
		}else{
				if("".equals(util.getStr(loginVO.getUserIdx()))) {
					%><script type="text/javascript">location.href="/sso/login.do";</script><%
				}else{
					%><%@include file="/front/_module/sso/home.jsp" %><%
				}
		}
	%>
	

	<%@include file="/front/_temple/sso/t_footer.jsp" %>






