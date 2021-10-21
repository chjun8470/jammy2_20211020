<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO" %>
<%@ page import="egovframework.jammy2.member.service.MemberConfigVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<%@ include file="/modules/vname/pcc_v3_Input001.jsp" %>
<%
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
	String siteId = "";
	if (siteInfoVO != null)
	{
		siteId = siteInfoVO.getSiteId();
	}
	
	session.setAttribute("siteId", siteId);
%>

<script type="text/javascript">
//<![CDATA[
// 공공아이핀
function Auth() 
{
	wWidth = 360;
	wHight = 120;
	wX = (window.screen.width - wWidth) / 2;
	wY = (window.screen.height - wHight) / 2;
	var w = window.open("/G-PIN/Sample-AuthRequest.jsp", "gPinLoginWin", "directories=no,toolbar=no,left="+wX+",top="+wY+",width="+wWidth+",height="+wHight);
}

//아이핀
var CBA_window; 
function openCBAWindow()
{ 
	CBA_window = window.open('', 'IPINWindow', 'width=450, height=500, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
	if(CBA_window == null)
	{ 
		alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	}
	document.reqCBAForm.action = 'https://ipin.siren24.com/i-PIN/jsp/ipin_j10.jsp';
	document.reqCBAForm.target = 'IPINWindow';
	document.reqCBAForm.submit();
	
	return true;
}

//본인확인
var PCC_window; 
function openPCCWindow()
{ 
	var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
    if(PCC_window == null)
    { 
		alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	}
    document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
    document.reqPCCForm.target = 'PCCV3Window';
    document.reqPCCForm.submit();
    
	return true;
}
//]]>
</script>

<!-- 본인실명확인서비스 요청 form --------------------------->
<form name="reqPCCForm" method="post" action = "">
<input type="hidden" name="reqInfo"     value = "<%=reqInfo%>" />
<input type="hidden" name="retUrl"      value = "<%=retUrl%>" />
</form>
<!--End 본인실명확인서비스 요청 form ----------------------->
<!-- IPIN서비스 요청 form --------------------------->
<form name="reqCBAForm" method="post" action="">
<input type="hidden" name="retUrl" value="<%=retUrlIpin%>" />
<input type="hidden" name="reqInfo" value="<%=reqInfoIpin%>" />
</form>
<!--End IPIN서비스 요청 form ----------------------->

<button onclick="openCBAWindow(); return false;">IPIN</button>
<button onclick="openPCCWindow(); return false;">실명인증</button>
