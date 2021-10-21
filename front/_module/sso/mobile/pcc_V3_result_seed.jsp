<%
/**************************************************************************************************************************
* Program Name  : ����Ȯ�� ��� ���� Sample JSP
* File Name	 : pcc_V3_result_seed.jsp
* Comment	   :
* History	   :
*
**************************************************************************************************************************/
%>
<%@ page  contentType = "text/html;charset=ksc5601"%>
<%@ page import = "java.util.*" %>
<%
	// ���� --------------------------------------------------------------------------------
	String retInfo		= "";																// �������

	String name			= "";															   //����
	String sex			= "";																//����
	String birYMD		= "";																//�������
	String fgnGbn		= "";																//���ܱ��� ���а�

	String di			= "";																//DI
	String ci1			= "";																//CI
	String ci2			= "";																//CI
	String civersion	= "";															   //CI Version

	String reqNum		= "";															   // ����Ȯ�� ��û��ȣ
	String result		= "";															   // ����Ȯ�ΰ�� (Y/N)
	String certDate		= "";															   // �����ð�
	String certGb		= "";															   // ��������
	String cellNo		= "";																// �ڵ��� ��ȣ
	String cellCorp		= "";																// �̵���Ż�
	String addVar		= "";


	//��ȭȭ�� ����
	String encPara		= "";
	String encMsg		= "";
	String msgChk	   = "N";

	//-----------------------------------------------------------------------------------------------------------------

	//��Ű�� ���� ����
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

		// Parameter ���� --------------------------------------------------------------------
		retInfo  = request.getParameter("retInfo").trim();

		// 1. ��ȣȭ ��� (jar) Loading
		com.sci.v2.pcc.secu.SciSecuManager sciSecuMg = new com.sci.v2.pcc.secu.SciSecuManager();
		//��Ű���� ������ ���� Key�� ���� �Ѵ�.
		retInfo  = sciSecuMg.getDec(retInfo, cookiereqNum);

		// 2.1�� �Ľ�---------------------------------------------------------------
		String[] aRetInfo1 = retInfo.split("\\^");

		encPara  = aRetInfo1[0];		 //��ȣȭ�� ���� �Ķ����
		encMsg   = aRetInfo1[1];	//��ȣȭ�� ���� �Ķ������ Hash��

		String  encMsg2   = sciSecuMg.getMsg(encPara);
			// 3.��/���� ���� ---------------------------------------------------------------
		if(encMsg2.equals(encMsg)){
			msgChk="Y";
		}

		if(msgChk.equals("N")){
%>
			<script language=javascript>
			//<![CDATA[
			alert("���������� �����Դϴ�.!!<%=msgChk%>");
			//]]>
			</script>
<%
			return;
		}


		// ��ȣȭ �� ��/���� ���� ---------------------------------------------------------------
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
		//session.setMaxInactiveInterval(10*60);//����10��

		//HashMap<String, String> TestMap = new HashMap<String, String>();
		//TestMap = (HashMap<String,String>)session.getAttribute("certiMap");


%>
<html>
	<head>
		<title>SCI������ ����Ȯ�ΰ��</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	</head>
	<body onload="">

	<script type="text/javascript">
	//<![CDATA[
		alert('�Ǹ������� �Ϸ�Ǿ����ϴ�.');
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