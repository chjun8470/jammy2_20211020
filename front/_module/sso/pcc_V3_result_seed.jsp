<%
/**************************************************************************************************************************
* Program Name  : 본인확인 결과 수신 Sample JSP
* File Name	 : pcc_V3_result_seed.jsp
* Comment	   :
* History	   :
*
**************************************************************************************************************************/
%>
<%@ page  contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*" %>
<%
	// 변수 --------------------------------------------------------------------------------
	String retInfo		= "";																// 결과정보

	String name			= "";															   //성명
	String sex			= "";																//성별
	String birYMD		= "";																//생년월일
	String fgnGbn		= "";																//내외국인 구분값

	String di			= "";																//DI
	String ci1			= "";																//CI
	String ci2			= "";																//CI
	String civersion	= "";															   //CI Version

	String reqNum		= "";															   // 본인확인 요청번호
	String result		= "";															   // 본인확인결과 (Y/N)
	String certDate		= "";															   // 검증시간
	String certGb		= "";															   // 인증수단
	String cellNo		= "";																// 핸드폰 번호
	String cellCorp		= "";																// 이동통신사
	String addVar		= "";


	//복화화용 변수
	String encPara		= "";
	String encMsg		= "";
	String msgChk	   = "N";

	//-----------------------------------------------------------------------------------------------------------------

	//쿠키값 가져 오기
	Cookie[] cookies = request.getCookies();
	String cookiename = "";
	String cookiereqNum = "";
	if(cookies!=null){
		for (int i = 0; i < cookies.length; i++){
			Cookie c = cookies[i];
			cookiename = c.getName();
			cookiereqNum = c.getValue();
			if(cookiename.compareTo("reqNum")==0) break;

			cookiereqNum = null;
		}
	}

	try{

		// Parameter 수신 --------------------------------------------------------------------
		retInfo  = request.getParameter("retInfo").trim();

		// 1. 암호화 모듈 (jar) Loading
		com.sci.v2.pcc.secu.SciSecuManager sciSecuMg = new com.sci.v2.pcc.secu.SciSecuManager();
		//쿠키에서 생성한 값을 Key로 생성 한다.
		retInfo  = sciSecuMg.getDec(retInfo, cookiereqNum);

		// 2.1차 파싱---------------------------------------------------------------
		String[] aRetInfo1 = retInfo.split("\\^");

		encPara  = aRetInfo1[0];		 //암호화된 통합 파라미터
		encMsg   = aRetInfo1[1];	//암호화된 통합 파라미터의 Hash값

		String  encMsg2   = sciSecuMg.getMsg(encPara);
			// 3.위/변조 검증 ---------------------------------------------------------------
		if(encMsg2.equals(encMsg)){
			msgChk="Y";
		}

		if(msgChk.equals("N")){
%>
			<script language=javascript>
			//<![CDATA[
			alert("비정상적인 접근입니다.!!<%=msgChk%>");
			//]]>
			</script>
<%
			return;
		}


		// 복호화 및 위/변조 검증 ---------------------------------------------------------------
		retInfo  = sciSecuMg.getDec(encPara, cookiereqNum);

		String[] aRetInfo = retInfo.split("\\^");

		name		= aRetInfo[0];
		birYMD		= aRetInfo[1];
		sex			= aRetInfo[2];
		fgnGbn		= aRetInfo[3];
		di			= aRetInfo[4];
		ci1			= aRetInfo[5];
		ci2			= aRetInfo[6];
		civersion	= aRetInfo[7];
		reqNum		= aRetInfo[8];
		result		= aRetInfo[9];
		certGb		= aRetInfo[10];
		cellNo		= aRetInfo[11];
		cellCorp	= aRetInfo[12];
		certDate	= aRetInfo[13];
		addVar		= aRetInfo[14];


		HashMap<String, String> certiMap = new HashMap<String, String>();
		certiMap.put("psnNm",name);
		certiMap.put("genderTypeCd",sex);
		certiMap.put("globalTp",fgnGbn);

		String cpNoT = cellNo.substring(0, 3);
		certiMap.put("cpNo1",cellNo.substring(0, 3));
		certiMap.put("cpNo2",cellNo.substring(3, 7));
		certiMap.put("cpNo3",cellNo.substring(7, 11));
		certiMap.put("cpNo",cellNo);


		certiMap.put("certiMode",addVar);
		certiMap.put("birth",birYMD);
		certiMap.put("diKey",di);
		certiMap.put("certiState",result);
		session.setAttribute("certiMap", certiMap);
		//session.setMaxInactiveInterval(10*60);//세션10분

		//HashMap<String, String> TestMap = new HashMap<String, String>();
		//TestMap = (HashMap<String,String>)session.getAttribute("certiMap");


%>
<html>
	<head>
		<title>SCI평가정보 본인확인결과</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	</head>
	<body onload="">

	<script type="text/javascript">
	//<![CDATA[
		alert('실명인증이 완료되었습니다.');
		document.location.href = "/sso/join.do";
	//]]>	
	</script>


	<!-- <form name="certiForm" method="post" action="/sso/join.do">
		<input type="hidden" name="mode" value=""/>
	</form> -->

	</body>
</html>
<%
		// ----------------------------------------------------------------------------------

	}catch(Exception ex){
		  System.out.println("[pcc] Receive Error -"+ex.getMessage());
	}
%>