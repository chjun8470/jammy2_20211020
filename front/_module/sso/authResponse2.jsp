<%@ page language = "java" contentType = "text/html; charset=UTF-8"%>
<%@ page import = "java.util.*" %> 
<%!

    String getSession(HttpSession session, String attrName)
    {
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
    <title>GPIN SP - SAMPLE - 사용자 본인인증 결과</title>
</head>
<body>
<%
    /**
     * Sample-AuthRequest 를 통한 사용자인증 완료후 session에 저장된 사용자정보를 가져오는 페이지입니다.
     * Sample-AuthRequest에서 리턴페이지로 지정을 해주어야 연결되며 보여지는 항목의 상세한 내용은 가이드를참조하시기바랍니다.
     */
    // 인증 수신시 요청처와 동일한 위치인지를 session에 저장한 요청자 IP와 비교합니다.
	if (request.getRemoteAddr().equals(session.getAttribute("gpinUserIP")))
	{
		  
		HashMap<String, String> certiMap = new HashMap<String, String>();
		certiMap.put("psnNm",getSession(session, "realName"));
		certiMap.put("genderTypeCd",getSession(session, "sex").equals("1")?"M":"F");
		certiMap.put("globalTp",getSession(session, "nationalInfo").equals("0")?"1":"2");

		certiMap.put("certiMode","GPIN||"+getSession(session,"userTp"));
		certiMap.put("birth",getSession(session, "birthDate"));
		certiMap.put("diKey",getSession(session, "dupInfo"));
		certiMap.put("certiState","Y");
		session.setAttribute("certiMap", certiMap);
		
		System.out.println("::::::::certiMap확인 : "+certiMap);
%>
<html>
	<head>
		<title>GPIN 실명인증결과</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	</head>
	<body onload="">
	<script type="text/javascript">
	//<![CDATA[
		alert('실명인증이 완료되었습니다.');
		document.location.href = "/sso/findPassword.do";
	//]]>	
	</script>
	</body>
</html>

<%// getSession(session, "virtualNo")//개인식별번호(virtualNo) %>
<% //getSession(session, "authInfo")//본인인증방법(authInfo) %>
<%
	}
	else
	{
%>
<html>
	<head>
		<title>GPIN 실명인증결과</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	</head>
	<body onload="">
	<script type="text/javascript">
	//<![CDATA[
		alert('실명인증에 실패했습니다.');
		document.location.href = "/sso/login.do";
	//]]>	
	</script>
	</body>
</html>
<%
	}
	%>
