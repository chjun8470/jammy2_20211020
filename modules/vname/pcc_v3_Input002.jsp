<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.util.*"%>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%
    response.setHeader("Pragma", "no-cache" );
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-store");
    response.setHeader("Cache-Control", "no-cache" );
%>
<%	
	Calendar today = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	String day = sdf.format(today.getTime());

	java.util.Random ran = new Random();
	//랜덤 문자 길이
	int numLength = 16;
	String randomStr = "";
	
	for (int i = 0; i < numLength; i++) {
		//0 ~ 9 랜덤 숫자 생성
		randomStr += ran.nextInt(10);
	}
	
	String requestURL = request.getRequestURL().toString();
	String serverName = requestURL.substring(requestURL.indexOf("://") + 3);
	serverName = serverName.substring(0, serverName.indexOf("/"));	
	
	// 본인확인
	String id       = "SKDN001";                  												// 회원사 ID
	String reqNum 	= randomStr;				       											// 요청번호
	String retUrl   = "32http://"+serverName+"/modules/vname/pcc_v3_seed002.jsp";				// 결과 수신 URL
	String srvNo    = "001003";																	// 서비스번호	 		
	String exVar    = "0000000000000000";                  										// 복호화용 임시필드	
	String certDate	= day;   		        	           										// 본인실명확인 요청시간
	String certGb	= "H";          		               										// 본인실명확인 본인확인 인증수단
	String addVar	= request.getParameter("addVar");      										// 본인실명확인 추가 파라메터
	
	session.setAttribute("reqNum", reqNum);
	
	com.sci.v2.pcc.secu.SciSecuManager seed  = new com.sci.v2.pcc.secu.SciSecuManager();		// 암호화 모듈 선언
	String encStr  = "";
	String reqInfo = id+"^"+srvNo+"^"+reqNum+"^"+certDate+"^"+certGb+"^"+addVar+"^"+exVar; 	 	// 데이터 암호화
	encStr     = seed.getEncPublic(reqInfo);
	com.sci.v2.pcc.secu.hmac.SciHmac hmac = new com.sci.v2.pcc.secu.hmac.SciHmac();				// 위변조 검증 값 생성
	String hmacMsg     = hmac.HMacEncriptPublic(encStr);
	reqInfo = seed.getEncPublic(encStr + "^" + hmacMsg + "^" + "0000000000000000");  			// 2차암호화

	// IPIN
	String idPin    = "KDN002";                  												// 아이핀 회원사 아이디
	String srvNoIpin= "001005";																	// 아이핀 서비스번호	 	
	String encStrIpin  = "";
	String retUrlIpin = "23http://"+serverName+"/modules/vname/ipin_popup_seed002.jsp";				// 아이핀 결과수신 URL
	com.sci.v2.ipin.secu.SciSecuManager seedIpin  = new com.sci.v2.ipin.secu.SciSecuManager();	// 암호화 모듈 선언
	String reqInfoIpin = reqNum+"/"+idPin+"/"+srvNoIpin+"/"+exVar;  							// 데이터 암호화
	encStrIpin = seedIpin.getEncPublic(reqInfoIpin);
	com.sci.v2.ipin.secu.hmac.SciHmac hmacIpin = new com.sci.v2.ipin.secu.hmac.SciHmac();
	String hmacMsgIpin = hmacIpin.HMacEncriptPublic(encStrIpin);
	reqInfoIpin = seedIpin.getEncPublic(encStrIpin + "/" + hmacMsgIpin + "/" + "00000000");  	// 2차암호화
%>