<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));
// 	String msg = util.getStr(paramMap.get("msg"));
	String reUrl = util.getStr(paramMap.get("reUrl"));

	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String rndEquIdx = util.getStr(paramMap.get("rndEquIdx"));
	String equGoodsIdx = util.getIntStr(paramMap.get("equGoodsIdx"));
	String equipCd = util.getIntStr(paramMap.get("equipCd"));
	String state = util.getStr(paramMap.get("state"));
	String reject = util.getStr(paramMap.get("reject"));
	String authLv = util.getStr(paramMap.get("authLv"));
	
	System.out.println(paramMap);


	String msg = util.getStr(paramMap.get("msg"),"정상적으로 처리되었습니다.");
	if("popCloseReload".equals(util.getStr(paramMap.get("reUrl")))){
%>
<script type="text/javascript">
	<%if(!"no".equals(msg)){%>
		alert(	'<%=msg%>');
	<%}%>
	try{
		opener.location.reload();
	}catch(e){
	}
	window.close();
</script>
<%
	}else if("jnspTotal".equals(util.getStr(paramMap.get("pageName")))){
%>
		<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
		<form name="searchForm" id="searchForm" action="<%=reUrl%>" method="post" >
			<input type="hidden" name="mode" id="mode" value="<%=mode%>"/>
			<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>"/>
			<input type="hidden" name="tmenu" id="tmenu" value="2"/>
			<input type="hidden" name="rndEquIdx" id="rndEquIdx" value="<%=rndEquIdx%>"/>
			<input type="hidden" name="equGoodsIdx" id="equGoodsIdx" value="<%=equGoodsIdx%>"/>
			<input type="hidden" name="equipCd" id="equipCd" value="<%=equipCd%>"/>
			<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>"/>
			<input type="hidden" name="state" id="state" value="<%=state%>"/>
			<input type="hidden" name="reject" id="reject" value="<%=reject%>"/>

			<input type="hidden" name="searchType" id="searchType" value="<%=util.getStr(paramMap.get("searchType"))%>"/>
			<input type="hidden" name="searchState" id="searchState" value="<%=util.getStr(paramMap.get("searchState"))%>"/>
			<input type="hidden" name="searchNameOrg" id="searchNameOrg" value="<%=util.getStr(paramMap.get("searchNameOrg"))%>"/>
			<input type="hidden" name="searchOrgGrp" id="searchOrgGrp" value="<%=util.getStr(paramMap.get("searchOrgGrp"))%>"/>
			<input type="hidden" name="searchOrgSub" id="searchOrgSub" value="<%=util.getStr(paramMap.get("searchOrgSub"))%>"/>
			<input type="hidden" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
		</form>

		<script type="text/javascript">
			<%if(!"no".equals(msg)){%>
				alert(	'<%=msg%>');
			<%}%>

			if($('#mode').val() == 'write'){
				pageListGo();
			}else{
				pageViewGo();
			}

			function pageListGo(){
				$('#mode').val('list');
				$('#searchForm').submit();
			}

			function pageViewGo(){
				$('#mode').val('view');
				$('#searchForm').submit();
			}
		</script>
<%
	}else{
%>
<script type="text/javascript">
	<%if(!"no".equals(msg)){%>
		alert(	'<%=msg%>');
	<%}%>
	<%if("6".equals(paramMap.get("searchState"))){%>
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>?searchState=<%=util.getStr(paramMap.get("searchState"))%>';
	<%}else if("jnrdm1".equals(paramMap.get("pageName"))){%>
		
	<%}else{%>
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>';
	<%}%>
</script>
<%}%>