<%
/**************************************************************************************************************************
* Program Name  : ����Ȯ�� ��û Sample JSP (Real)
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

	String id	   = "SZYG001";							   // ���νǸ�Ȯ�� ȸ���� ���̵�
	//String srvNo	= "001002";							// ���νǸ�Ȯ�� ���񽺹�ȣ
	String siteId = util.getStr(paramMap.get("siteId"));
	String srvNo = "";

	if(siteId.equals("jeinet")){
		srvNo = "002001";
	}else if(siteId.equals("jipbank")){
		srvNo = "003001";
	}else if(siteId.equals("jntis")){
		srvNo = "006001";
	}else{
		srvNo = "004001";
	}

	String reqNum   = nowTime+util.getIntStr(randomNum);						   // ���νǸ�Ȯ�� ��û��ȣ
	String exVar	= "0000000000000000";									   // ��ȣȭ�� �ӽ��ʵ�


	//String retUrl   = request.getParameter("retUrl");						   // ���νǸ�Ȯ�� ������� URL
	String retUrl   = "32http://"+request.getServerName()+(request.getServerName().equals("localhost")?":8080":"")+"/sso/phoneCheck.do";// ���νǸ�Ȯ�� ������� URL

	String certDate	= nowTime;						 // ���νǸ�Ȯ�� ��û�ð�
	String certGb	= "H";						   // ���νǸ�Ȯ�� ����Ȯ�� ��������
	String addVar	= "PHONE||"+request.getParameter("userTp");						   // ���νǸ�Ȯ�� �߰� �Ķ����

	/**
	*
	* reqNum ���� ���� ����� ��ȣȭ�� ���� SecuKey�� Ȱ�� �ǹǷ� �߿��մϴ�.
	* reqNum �� ���� Ȯ�� ��û�� �׻� ���ο� ������ �ߺ� ���� �ʰ� ���� �ؾ� �մϴ�.
	* ��Ű �Ǵ� Session�� ��Ÿ ����� ����ؼ� reqNum ����
	* pcc_V3_result_seed.jsp���� ���� �� �� �ֵ��� �ؾ� ��.
	* ������ ���ؼ� ��Ű�� ����� ���̹Ƿ� ���� �Ͻñ� �ٶ��ϴ�.
	*
	*/
	Cookie c = new Cookie("reqNum", reqNum);
	//c.setMaxAge(1800);  // <== �ʿ�� ����(�ʴ����� �����˴ϴ�)
	response.addCookie(c);

	//01. ��ȣȭ ��� ����
	com.sci.v2.pcc.secu.SciSecuManager seed  = new com.sci.v2.pcc.secu.SciSecuManager();

	//02. 1�� ��ȣȭ
	String encStr = "";
	String reqInfo	  = id+"^"+srvNo+"^"+reqNum+"^"+certDate+"^"+certGb+"^"+addVar+"^"+exVar;  // ������ ��ȣȭ
	encStr			  = seed.getEncPublic(reqInfo);

	//03. ������ ���� �� ����
	com.sci.v2.pcc.secu.hmac.SciHmac hmac = new com.sci.v2.pcc.secu.hmac.SciHmac();
	String hmacMsg = hmac.HMacEncriptPublic(encStr);

	//03. 2�� ��ȣȭ
	reqInfo  = seed.getEncPublic(encStr + "^" + hmacMsg + "^" + "0000000000000000");  //2����ȣȭ
%>

<html>
<head>
<title>���νǸ�Ȯ�� ���� Sample ȭ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style>
<!--
   body,p,ol,ul,td
   {
	 font-family: ����;
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
			 alert(" �� ������ XP SP2 �Ǵ� ���ͳ� �ͽ��÷η� 7 ������� ��쿡�� \n	ȭ�� ��ܿ� �ִ� �˾� ���� �˸����� Ŭ���Ͽ� �˾��� ����� �ֽñ� �ٶ��ϴ�. \n\n�� MSN,����,���� �˾� ���� ���ٰ� ��ġ�� ��� �˾������ ���ֽñ� �ٶ��ϴ�.");
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

<!-- ���νǸ�Ȯ�μ��� ��û form --------------------------->
<!-- <form name="reqPCCForm" method="post" action = "" onsubmit="return openPCCWindow()"> -->
<form name="reqPCCForm" method="post" action = "">
	<input type="hidden" name="reqInfo"	 value = "<%=reqInfo%>">
	<input type="hidden" name="retUrl"	  value = "<%=retUrl%>">
</form>

</body>
</html>