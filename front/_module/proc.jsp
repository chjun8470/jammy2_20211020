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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));
	String msg = util.getStr(paramMap.get("msg"),"정상적으로 처리되었습니다.");
	String siteId = util.getStr(paramMap.get("siteId"));

	
	if("popCloseReload".equals(util.getStr(paramMap.get("reUrl")))){
%>


	<script type="text/javascript" src="/js/cms/front/func_web.js"></script>

	<script type="text/javascript">
	//<![CDATA[
		<%if(!"no".equals(msg)){%>
			alert(	'<%=msg%>');
		<%}%>
		try{
			<%if("mjeinet".equals(siteId)){%>
				window.location.href="/mjeinet/main.do";
			<%}else{%>
				opener.location.reload();
				window.close();
			<%}%>
		}catch(e){
			window.location.href="/sso/login.do?siteId=mjeinet";
			//window.location.reload();
		}
	//]]>	
	</script>


<%  }
	/* request popup Proc에서 사용 */
	if("popClose".equals(util.getStr(paramMap.get("reUrl")))) {%>

	<script type="text/javascript" src="/js/cms/front/func_web.js"></script>

	<script type="text/javascript">
	//<![CDATA[
		<%if(!"no".equals(msg)){%>
			alert('<%=msg%>');
		<%}%>
		try{
			window.close();
		}catch(e){
			//window.location.href="/sso/login.do";
			//window.location.reload();
		}
	//]]>	
	</script>

<%  }



	if("reservationCompletion".equals(util.getStr(paramMap.get("addPopup")))) { %>

	<script type="text/javascript">
	//<![CDATA[
		<%if(!"no".equals(msg)){%>
			alert(	'<%=msg%>');
		<%}%>
		
		
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>';
		ssoPopupShow('equorder');
		
	//]]>		
	</script>

<%  } else{ %>

	<script type="text/javascript">
	//<![CDATA[
		<%if(!"no".equals(msg)){%>
			alert(	'<%=msg%>');
		<%}%>
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>';
	//]]>	
	</script>
<%}%>