<%
/**************************************************************************************************************************
* Program Name  : 본인확인 요청 Sample JSP (Real)
* File Name	 : pcc_V3_sample_seed.jsp
* Comment	   :
* History	   :
*
**************************************************************************************************************************/
%>
<%
	response.setHeader("Pragma", "no-cache" );
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-store");
	response.setHeader("Cache-Control", "no-cache" );
%>
<%@ page  contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%
	request.setCharacterEncoding("UTF-8");

	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String nowTime = util.getDate("yyyyMMddHHmmss");
	int randomNum = util.getRandomNumeric(1000000, 9999999);

	String id	   = "SZYG001";							   // 본인실명확인 회원사 아이디
	//String srvNo	= "001002";							// 본인실명확인 서비스번호
	String siteId = util.getStr(paramMap.get("siteId"));
	String srvNo = "";

	if(siteId.equals("jeinet")){
		srvNo = "002003";
	}else if(siteId.equals("jipbank")){
		srvNo = "003002";
	}else if(siteId.equals("jntis")){
		srvNo = "006002";
	}else{
		srvNo = "004002";
	}

	String reqNum   = nowTime+util.getIntStr(randomNum);						   // 본인실명확인 요청번호
	String exVar	= "0000000000000000";									   // 복호화용 임시필드


	//String retUrl   = request.getParameter("retUrl");						   // 본인실명확인 결과수신 URL
	String retUrl   = "32http://"+request.getServerName()+(request.getServerName().equals("localhost")?":8080":"")+"/sso/phonePassCheck.do";// 본인실명확인 결과수신 URL

	String certDate	= nowTime;						 // 본인실명확인 요청시간
	String certGb	= "H";						   // 본인실명확인 본인확인 인증수단
	String addVar	= "PHONE||"+request.getParameter("userTp");						   // 본인실명확인 추가 파라메터

	/**
	*
	* reqNum 값은 최종 결과값 복호화를 위한 SecuKey로 활용 되므로 중요합니다.
	* reqNum 은 본인 확인 요청시 항상 새로운 값으로 중복 되지 않게 생성 해야 합니다.
	* 쿠키 또는 Session및 기타 방법을 사용해서 reqNum 값을
	* pcc_V3_result_seed.jsp에서 가져 올 수 있도록 해야 함.
	* 샘플을 위해서 쿠키를 사용한 것이므로 참고 하시길 바랍니다.
	*
	*/
	Cookie c = new Cookie("reqNum", reqNum);
	//c.setMaxAge(1800);  // <== 필요시 설정(초단위로 설정됩니다)
	response.addCookie(c);

	//01. 암호화 모듈 선언
	com.sci.v2.pcc.secu.SciSecuManager seed  = new com.sci.v2.pcc.secu.SciSecuManager();

	//02. 1차 암호화
	String encStr = "";
	String reqInfo	  = id+"^"+srvNo+"^"+reqNum+"^"+certDate+"^"+certGb+"^"+addVar+"^"+exVar;  // 데이터 암호화
	encStr			  = seed.getEncPublic(reqInfo);

	//03. 위변조 검증 값 생성
	com.sci.v2.pcc.secu.hmac.SciHmac hmac = new com.sci.v2.pcc.secu.hmac.SciHmac();
	String hmacMsg = hmac.HMacEncriptPublic(encStr);

	//03. 2차 암호화
	reqInfo  = seed.getEncPublic(encStr + "^" + hmacMsg + "^" + "0000000000000000");  //2차암호화
%>

<html>
<head>
<title>본인실명확인 서비스 Sample 화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style>
<!--
   body,p,ol,ul,td
   {
	 font-family: 굴림;
	 font-size: 12px;
   }

   a:link { size:9px;color:#000000;text-decoration: none; line-height: 12px}
   a:visited { size:9px;color:#555555;text-decoration: none; line-height: 12px}
   a:hover { color:#ff9900;text-decoration: none; line-height: 12px}

   .style1 {
		color: #6b902a;
		font-weight: bold;
	}
	.style2 {
		color: #666666
	}
	.style3 {
		color: #3b5d00;
		font-weight: bold;
	}
-->
</style>

<script language=javascript>
//<![CDATA[
	//var PCC_window;

	function openPCCWindow(){
		//var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
		/*
		if(PCC_window == null){
			 alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n	화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
		}
		*/
		document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
		//document.reqPCCForm.target = 'PCCV3Window';
		document.reqPCCForm.submit();
//		return true;
	}
//]]>
</script>

</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 onload="openPCCWindow()">

<!-- 본인실명확인서비스 요청 form --------------------------->
<!-- <form name="reqPCCForm" method="post" action = "" onsubmit="return openPCCWindow()"> -->
<form name="reqPCCForm" method="post" action = "">
	<input type="hidden" name="reqInfo"	 value = "<%=reqInfo%>">
	<input type="hidden" name="retUrl"	  value = "<%=retUrl%>">
</form>

</body>
</html>