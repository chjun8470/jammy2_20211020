﻿<%
/************************************************************************************
Generated by AIDesigner 5.5.0.9
************************************************************************************
보고서 제목 : 보고서 (2013/4/30 10:3:31)
작성일 : 2013년4월30일 10시3분31초
작성자 :
************************************************************************************/
%>

<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.activeintra.manager.*" %>
<%@ page import="com.activeintra.url.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.apache.log4j.PropertyConfigurator" %>
<%@ page import="com.activeintra.util.uds.*" %>


<%
Object[] userObj = null;

String reportMode=request.getParameter("reportMode");
String reportParams=request.getParameter("reportParams");
if(reportMode!=null){
	if(reportMode.equals("PDF")){
		if(reportParams == null || reportParams.toLowerCase().indexOf("pdfserversave:true") == -1){
			out.clear();
			out=pageContext.pushBody();
		}
	}
	else if(reportMode.equals("EXCEL")){
		if(reportParams == null || reportParams.toLowerCase().indexOf("excelserversave:true") == -1){
			out.clear();
			out=pageContext.pushBody();
		}
	}
	else if(reportMode.equals("AR5")){
		out.clear();
		out=pageContext.pushBody();
	}
}

ReportHandler handler = new ReportHandler(pageContext,request,response,userObj);
handler.service(out);
handler = null;
%>

<%!
private Logger logger = Logger.getLogger("test.jsp");
class ReportHandler{
	//공통 변수 선언
	private Object[] userObj = null;
	private int nStartPage;		//각 쉬트별 시작 페이지 저장
	private int nMaxPage;		//한 쉬트가 실행된 후 생성된 최대 페이지 번호 저장
	private int nPageNum;		//현재 페이지 번호
	private int nYStartPos;		//쉬트에서 Y 시작 좌표
	private int nYEndPos;		//쉬트에서 Y 끝 좌표
	private int nYCurPos;		//현재 Y 좌표
	private int nYSavePos;		//연결된 멀티 프레임 쉬트에서 시작 Y 좌표 저장
	private int nYLastPos;		//연결된 멀티 프레임 쉬트에서 각 프레임의 마지막 Y 좌표 저장
	private int nXStartPos;		//쉬트에서 X 시작 좌표
	private int nXEndPos;		//쉬트에서 X 끝 좌표
	private int nXCurPos;		//현재 X 좌표
	private int nXSavePos;		//연결된 멀티 프레임 쉬트에서 시작 X 좌표 저장
	private int  nXLastPos;		//연결된 멀티 프레임 쉬트에서 각 프레임의 마지막 X 좌표 저장
	private boolean bIsBeforePageSkip;		//조건 밴드에서 페이지 넘기기 여부 판단
	private int nLoopRef;		//절대 양식에서 루프 참조 변수
	private int CELL_OBJECT = 0;
	private int DRAW_OBJECT = 1;
	private String isEmpty="";		//빈 문자열 비교에 사용

	private HttpServletRequest request;
	private HttpServletResponse response;
	private PageContext pageContext;
	private JspWriter out;

	private AIScriptManager manager;
	private String reportMode="AIScript";
	private String pdfFilename="";
	private String excelFilename="";

	//-----데이터 변수 선언-----
	long sheet10_A1;
	String sheet10_B1;
	String sheet10_C1;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_Northwind;		//DSN Northwind Connection 객체
	private java.sql.PreparedStatement stat_qry_Shippers;		//ResultSet qry_Shippers 객체를 생성하기 위한 Statement 객체
	private ResultSet qry_Shippers;		//ResultSet qry_Shippers 객체

	//-----SQL 변수 선언-----
	private String sql_qry_Shippers;		//ResultSet qry_Shippers 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet qry_Shippers 객체에서 필드 값을 받는 쿼리 필드 변수
	private long qry_Shippers_ShipperID;
	private String qry_Shippers_CompanyName;
	private String qry_Shippers_Phone;

	//파라미터 변수 선언
	String id_Param;

	//ReportHandler 생성자 함수
	ReportHandler(PageContext pageContext,HttpServletRequest request,HttpServletResponse response,Object[] userObj){
		this.pageContext=pageContext;
		this.request=request;
		this.response=response;
		this.userObj=userObj;
	}

	//ReportHandler 서비스 함수
	void service(JspWriter out) throws Exception{
		try{    //try 구문
			//변수 초기화
			this.out = out;
			nMaxPage = 0;   //nMaxPage 초기화

			manager = new AIScriptManager(request, response, pageContext, out, logger, null);

			ServletContext context = pageContext.getServletContext();
			String temp = null;
			if(!context.getContextPath().equals("/"))
			temp = request.getRequestURI().replace(context.getContextPath(), "");
			else
			temp = request.getRequestURI();

			String path = temp.replace(".jsp", ".style");

			//파라미터 설정 함수 호출
			setParam();
			if(manager.open(reportMode, context.getRealPath(path)))
			{
				//스크립트 헤더 함수 호출
				getScriptHeader("A4", "2100x2970", "9", "VERTICAL", "56 70 56 70");

				//고정 데이터 초기화 함수 호출
				initConstVarient();

				//Connection 및 Statement 객체 생성 함수 호출
				createConnAndStateObject();

				//쿼리문 초기화 함수 호출
				initSQLConst();

				//쉬트 함수 호출
				//SHEET=Sheet1   FRAME=0 함수 호출
				executeSheet10();

				//---------------스크립트 종료---------------
				manager.scriptWrite("/AIReport", "", "", false);
				manager.close();
			}
		}catch(Exception e){    //catch 구문
			out.print(e);
			out.print("\r");
			StackTraceElement[] trace = e.getStackTrace();
			for(int i = 0; i < trace.length; i++) {
				out.println(trace[i]);
			}
			out.print("\r");
			out.print("AI!REPORT JSP ERROR!!!!\r");
		}finally{    //finally 구문
			//DataSet Close
			cleanup(qry_Shippers, stat_qry_Shippers, null, null);
			cleanup(null, null, null, conn_Northwind);
		}    //end try
	}

	//-----쉬트 함수-----
	//-----SHEET=Sheet1   FRAME=Frame0 Start
	//-----폼 형식 : 상대 양식
	private void executeSheet10( ) throws Exception{
		//쉬트 초기화 함수 호출
		getSheetPaperInfo("A4", "2100x2970", "9", "VERTICAL", "56 70 56 70");
		initSheetVariant(68, 82, 528, 761, true);

		//시작 페이지 번호 출력
		pageWrite(nPageNum);

		//밴드 함수 호출
		getScriptFromaaa(true);    //반복 밴드 호출

		//페이지 및 좌표 설정
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //생성된 최대 페이지 번호 구하기
	}

	//-----밴드 함수-----
	//-----aaa RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : aaa
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromaaa(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;

		//데이터 변수 초기화
		sheet10_A1=0L;
		sheet10_B1="";
		sheet10_C1="";

		//DataSet 객체 생성
		//ResultSet qry_Shippers 객체의 생성
		if(qry_Shippers==null){
			qry_Shippers = stat_qry_Shippers.executeQuery();
		}else{
			qry_Shippers.beforeFirst();
		}

		while(qry_Shippers.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromqry_Shippers();	//RecordSet qry_Shippers에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A1=qry_Shippers_ShipperID;
			sheet10_B1=qry_Shippers_CompanyName;
			sheet10_C1=qry_Shippers_Phone;

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptaaa();

				//다음 출력 좌표 설정
				nYCurPos=nYCurPos+nBandHeight;
			}   //end if(bIsPrint)

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end

		if(bIsFirst){   //while 루프가 실행되지 않은 경우
		} else {   //while 루프가 실행된 경우
		}   //루프 외부 end if(bIsFirst)
	}

	//-----스크립트 출력 함수-----
	//----aaa 스크립트 문 출력 함수----
	private void writeScriptaaa(  ) throws Exception{
		//스크립트문 생성
		objectWrite(CELL_OBJECT, nXCurPos, nYCurPos, 80, 20, String.valueOf(sheet10_A1), "sheet10_A1", "cell_style_0");
		objectWrite(CELL_OBJECT, nXCurPos+80, nYCurPos, 80, 20, sheet10_B1, "sheet10_B1", "cell_style_1");
		objectWrite(CELL_OBJECT, nXCurPos+160, nYCurPos, 80, 20, sheet10_C1, "sheet10_C1", "cell_style_1");
	}

	private void getBgImageScriptEx(int nIndex) throws Exception{
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//Northwind Connection 객체 생성
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		conn_Northwind=DriverManager.getConnection("jdbc:odbc:Northwind","","");
	}

	//-----ResultSet, Statement, Connection, CallableStatement Close 함수-----
	private void cleanup(Object rs, PreparedStatement st, CallableStatement cs, Connection conn){
		if(rs != null){
			try{
				if(rs instanceof ResultSet){
					((ResultSet)rs).close();
				}else if(rs instanceof com.activeintra.util.uds.AIDataSource){
					((com.activeintra.util.uds.AIDataSource)rs).close();
				}else if(rs instanceof com.activeintra.util.uds.XMLSetHandler){
					((com.activeintra.util.uds.XMLSetHandler)rs).close();
				}else if(rs instanceof com.activeintra.util.uds.CSVSetHandler){
					((com.activeintra.util.uds.CSVSetHandler)rs).close();
				}
			}
			catch(Exception e){
				//e.printStackTrace();
			}
		}

		if(st != null){
			try{
				st.close();
			}
			catch(Exception e){
				//e.printStackTrace();
			}
		}

		if(cs != null){
			try{
				cs.close();
			}
			catch(Exception e){
				//e.printStackTrace();
			}
		}

		if(conn != null){
			try{
				conn.close();
			}
			catch(Exception e){
				//e.printStackTrace();
			}
		}
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst() throws Exception {
		stat_qry_Shippers = conn_Northwind.prepareStatement("SELECT * FROM Shippers");
		stat_qry_Shippers.setInt(1, 1);
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet qry_Shippers 객체에서 필드 값 설정 함수
	private void setFieldVariableFromqry_Shippers() throws Exception{
		qry_Shippers_ShipperID=qry_Shippers.getLong(1);
		qry_Shippers_CompanyName=GetB(qry_Shippers.getString(2));
		qry_Shippers_Phone=GetB(qry_Shippers.getString(3));
	}

	//ResultSet qry_Shippers 객체의 필드 값 초기화 함수
	private void setFieldInitFromqry_Shippers(){
		qry_Shippers_ShipperID=0L;
		qry_Shippers_CompanyName="";
		qry_Shippers_Phone="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarientEx(){
	}

	//-----공통 함수 선언-----
	//파라미터 설정 함수
	private void setParam() {
		//SetParam_AutoCode
		reportMode=toKor(GetB(request.getParameter("reportMode")));
		if(reportMode.equals("")) {
			reportMode="HTML";
		}
		manager.setParam("pdfFilename:" + pdfFilename + "," + "excelFilename:" + excelFilename + "," + toKor(GetB(request.getParameter("reportParams"))));

		char data[] = {0x14};
		String str = new String(data);
		id_Param=toKor(GetB(request.getParameter("id")));
		id_Param=aiReplace(id_Param, str, "\n");
	}

	//상수 데이터 초기화 래퍼 함수
	private void initConstVarient() {
		//InitConstVarient_AutoCode
		initConstVarientEx();
	}

	//배경 이미지 출력 래퍼 함수
	private void getBgImageScript(int nIndex) throws Exception{
		//GetBgImageScript_AutoCode
		getBgImageScriptEx(nIndex);
	}

	//페이지 스킵 함수
	//페이지 스킵시 호출되는 함수로서 페이지 번호를 증가시키고 페이지 지시문 출력 그리고 Y좌표 초기화
	//매개변수에 따라 해당 쉬트의 배경 이미지, 머리글 밴드, 바닥글 밴드 함수 호출
	private void pageSkip(int nIndex) throws Exception{
		//PageSkip_AutoCode
		nXCurPos=nXStartPos;
		nYCurPos=nYStartPos;
		nPageNum=nPageNum+1;
		pageWrite(nPageNum);

		switch(nIndex){
			case 10:		//SHEET=Sheet=1   FRAME=0에서 페이지 스킵시
			break;
		}
	}

	//페이지 스킵이 필요한지 검사하는 함수
	private boolean isPageSkip(int nTestPos){
		//IsPageSkip_AutoCode
		if(nTestPos>nYEndPos){
			return true;
		}else{
			return false;
		}
	}

	//문자의 폭을 조사하여 데이터의 출력 높이를 자동적으로 조정하는 함수
	private int getPrintHeight(String data, int[] charWidth, int fontSize, int printWidth, int printHeight, int nMaxHeight){
		//GetPrintHeight_AutoCode
		int ch;
		int len = 95;
		int []width = new int[1];
		width[0] = 0;
		int asciiWidth = 0;
		int linePitch = (int)(fontSize*1.4);
		int height = linePitch;
		int size = data.length();
		int ascIndex=0;
		printWidth = printWidth*100;

		for (int i = 0; i < size; i++) {
			ch = data.charAt(i);

			if(ch<32 && !(ch==10 || ch==20 || ch==13)){
				continue;
			}

			if((ch>64 && ch<91) || (ch>96 && ch<123)) {
				if(asciiWidth==0){
					ascIndex=i;
				}

				asciiWidth += charWidth[ch-32];
				if (i==size-1){
					height+=getWordWrapHeight(data, charWidth, ascIndex, i+1, linePitch, printWidth, width, asciiWidth);
				}
			} else if (ch==10 || ch==20 || ch==13) {
				if(asciiWidth>0){
					height+=getWordWrapHeight(data, charWidth, ascIndex, i, linePitch, printWidth, width, asciiWidth);
					asciiWidth = 0;
				}

				width[0] = 0;
				height += linePitch;

				if (ch==13) {
					if ((i != size-1) && (10 == (int)data.charAt(i+1))) {
						i++;
					}
				}
			} else {
				if(asciiWidth>0){
					height+=getWordWrapHeight(data, charWidth, ascIndex, i, linePitch, printWidth, width, asciiWidth);
					asciiWidth=0;
				}

				if(ch>=32 && ch<=127){
					width[0] += charWidth[ch-32];
					if (width[0] > printWidth) {
						if (ch==32)
						{
							width[0] = 0;
						}
						else
						{
							width[0] = charWidth[ch-32];
						}
						height += linePitch;
					}
				}else{
					width[0] += charWidth[len];
					if (width[0] > printWidth) {
						width[0] = charWidth[len];
						height += linePitch;
					}
				}
			}
		}

		if (height>printHeight) {
			height=height-printHeight;
		}else{
			height=0;
		}

		height = (int)MAX((long)height,(long)nMaxHeight);
		return height;
	}

	//영문 단어의 폭을 문자별로 조사하여 데이터의 출력 높이를 조정하는 함수
	private int getWordWrapHeight(String data, int[] charWidth, int nStartIndex, int nEndIndex, int linePitch, int printWidth, int []width, int asciiWidth){
		//GetWordWrapHeight_AutoCode
		int ch;
		int height=0;

		if(asciiWidth>printWidth){
			for(int i=nStartIndex; i<nEndIndex; i++){
				ch=data.charAt(i);
				width[0]+=charWidth[ch-32];
				if(width[0]>printWidth){
					width[0]=charWidth[ch-32];
					height+=linePitch;
				}
			}
		}else{
			width[0]+=asciiWidth;
			if(width[0]>printWidth){
				width[0]=asciiWidth;
				height+=linePitch;
			}
		}

		return height;
	}

	//문자의 폭을 조사하여 데이터의 출력 높이를 자동적으로 조정하고 페이지 초과시 초과하는 데이터 절삭하는 함수
	private int getPrintHeightEx(String data, String[] strSplitData, int[] charWidth, int fontSize, int printWidth, int nExtHeight, int nMaxHeight){
		//GetPrintHeightEx_AutoCode
		int ch;
		int i;
		int len = 95;
		int []width = new int[1];
		width[0] = 0;
		int asciiWidth = 0;
		int linePitch = (int)(fontSize*1.4);
		int height = linePitch;
		int size = data.length();
		int ascIndex=0;
		boolean bSplit=false;
		strSplitData[0]="";
		strSplitData[1]="";
		printWidth = printWidth*100;

		for (i = 0; i < size; i++) {
			ch = data.charAt(i);

			if(ch<32 && !(ch==10 || ch==20 || ch==13)){
				continue;
			}

			if ((ch>64 && ch<91) || (ch>96 && ch<123)) {
				if(asciiWidth==0){
					ascIndex=i;
				}

				asciiWidth += charWidth[ch-32];
				if (i==size-1){
					height+=getWordWrapHeight(data, charWidth, ascIndex, i+1, linePitch, printWidth, width, asciiWidth);
					if(height>nExtHeight){
						height=nExtHeight;
						bSplit=true;
						i=ascIndex;
						break;
					}
				}
			}else if (ch==10 || ch==20 || ch==13) {
				if(asciiWidth>0){
					height+=getWordWrapHeight(data, charWidth, ascIndex, i, linePitch, printWidth, width, asciiWidth);
					if(height>nExtHeight){
						height=nExtHeight;
						bSplit=true;
						i=ascIndex;
						break;
					}
					asciiWidth = 0;
				}

				width[0] = 0;
				height += linePitch;
				if (ch==13){
					if ((i != size-1) && (10 == (int)data.charAt(i+1))) {
						i++;
					}
				}

				if(height>nExtHeight){
					height=nExtHeight;
					if(i!=size-1){
						bSplit=true;
						i++;
					}
					break;
				}
			}else{
				if(asciiWidth>0){
					height+=getWordWrapHeight(data, charWidth, ascIndex, i, linePitch, printWidth, width, asciiWidth);
					if(height>nExtHeight){
						height=nExtHeight;
						bSplit=true;
						i=ascIndex;
						break;
					}
					asciiWidth=0;
				}

				if(ch>=32 && ch<=127){
					width[0] += charWidth[ch-32];
					if (width[0] > printWidth) {
						if (ch==32)
						{
							width[0] = 0;
						}
						else
						{
							width[0] = charWidth[ch-32];
						}
						height += linePitch;
					}
				}else{
					width[0] += charWidth[len];
					if (width[0] > printWidth) {
						width[0] = charWidth[len];
						height += linePitch;
					}
				}

				if(height>nExtHeight){
					height=nExtHeight;
					bSplit=true;
					break;
				}
			}
		}

		if(bSplit){
			strSplitData[0]=data.substring(0, i);
			strSplitData[1]=data.substring(i);
		}

		height = (int)MAX((long)height,(long)nMaxHeight);
		return height;
	}

	//스크립트 헤더 출력 함수
	private void getScriptHeader(String paper, String size, String value, String orient, String margin) throws Exception{
		//GetScriptHeader_AutoCode
		manager.scriptWrite("AIReport", "scriptVersion|docVersion|style|title", "32|4|test.style|보고서 (2013/4/30 10:3:31)", false);
		manager.scriptWrite("PaperInfo", "name|size|value|orientation|margin", paper+"|"+size+"|"+value+"|"+orient+"|"+margin, true);
	}

	private void getSheetPaperInfo(String paper, String size, String value, String orient, String margin) throws Exception{
		//GetSheetPaperInfo_AutoCode
		manager.scriptWrite("PaperInfo", "name|size|value|orientation|margin", paper+"|"+size+"|"+value+"|"+orient+"|"+margin, true);
	}

	private void initSheetVariant(int constStartX, int constStartY, int constEndX, int constEndY, boolean bFirstFrame){
		//InitSheetVariant_AutoCode
		if(bFirstFrame){
			nStartPage=nMaxPage+1;
			nYLastPos=0;
		}
		nPageNum=nStartPage;
		nYStartPos=constStartY;
		nYEndPos=constEndY;
		nYCurPos=nYStartPos;
		nXStartPos=constStartX;
		nXEndPos=constEndX;
		CELL_OBJECT=0;
		DRAW_OBJECT=1;
		nXCurPos=nXStartPos;
	}

	private void initChildSheetVariant(int constStartX, int constStartY, int constEndX, int constEndY, boolean bIsMultiFrame, boolean bIsFirstFrame){
		//InitChildSheetVariant_AutoCode
		nXStartPos=constStartX;
		nXEndPos=constEndX;
		nXCurPos=nXStartPos;
		nYStartPos=constStartY;
		nYEndPos=constEndY;

		if(bIsMultiFrame){
			if(bIsFirstFrame){
				nStartPage=nPageNum;
				nYSavePos=nYCurPos;
				nYLastPos=0;
			}else{
				nPageNum=nStartPage;
				nYCurPos=nYSavePos;
			}
		}else{
			nStartPage=nPageNum;
		}
	}

	//Empty Row만으로 구성되어 출력 위치를 조정하기 위한 VoidBand 함수
	//nRangePos - VoidBand의 출력 영역
	//nIndex - PageSkip 함수 호출시 전달할 쉬트 인덱스
	private boolean voidBandNoneData(int nRangePos, int nIndex) throws Exception{
		//VoidBandNoneData_AutoCode
		int nTestPos;
		nTestPos=nYCurPos+nRangePos;
		if(isPageSkip(nTestPos)){
			pageSkip(nIndex);
			return true;
		}else{
			nYCurPos=nYCurPos+nRangePos;
			return false;
		}
	}

	private String Get0(String str){
		//Get0_AutoCode
		if(str==null){
			return "0";
		}else{
			if(str.equals("")){
				return "0";
			}else{
				return str;
			}
		}
	}

	private String GetB(String str){
		//GetB_AutoCode
		if(str==null){
			return "";
		}else{
			return str;
		}
	}

	private double SUM(double accVal, double tmpVal){
		//SUM(double, double)_AutoCode
		return(accVal+tmpVal);
	}

	private double SUM(double accVal, long tmpVal){
		//SUM(double, long)_AutoCode
		return(accVal+(double)tmpVal);
	}

	private long SUM(long accVal, long tmpVal){
		//SUM(long, long)_AutoCode
		return(accVal+tmpVal);
	}

	private double SUM(long accVal, double tmpVal){
		//SUM(long, double)_AutoCode
		return((double)accVal+tmpVal);
	}

	private long COUNT(long accuCNT){
		//COUNT_AutoCode
		return ++accuCNT;
	}

	private long MIN(long maxV, long maxTempV){
		//MIN(long, long)_AutoCode
		if(maxV<=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MIN(long maxV, double maxTempV){
		//MIN(long, double)_AutoCode
		if((double)maxV<=maxTempV){return (double)maxV;}
		else{return maxTempV;}
	}

	private double MIN(double maxV, double maxTempV){
		//MIN(double, double)_AutoCode
		if(maxV<=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MIN(double maxV, long maxTempV){
		//MIN(double, long)_AutoCode
		if(maxV<=maxTempV){return maxV;}
		else{return (double)maxTempV;}
	}

	private long MAX(long maxV, long maxTempV){
		//MAX(long, long)_AutoCode
		if(maxV>=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MAX(long maxV, double maxTempV){
		//MAX(long, double)_AutoCode
		if((double)maxV>=maxTempV){return (double)maxV;}
		else{return maxTempV;}
	}

	private double MAX(double maxV, double maxTempV){
		//MAX(double, double)_AutoCode
		if(maxV>=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MAX(double maxV, long maxTempV){
		//MAX(double, long)_AutoCode
		if(maxV>=maxTempV){return maxV;}
		else{return (double)maxTempV;}
	}

	private double AVG(double sumVal, long cntVal){
		//AVG(double, long)_AutoCode
		return(sumVal/cntVal);
	}

	private double AVG(long sumVal, long cntVal){
		//AVG(long, long)_AutoCode
		return((double)sumVal/(double)cntVal);
	}

	private String aiReplace(String strAll, String strSrc, String strDest) {
		//AIReplace_AutoCode
		int st = 0, ed = 0;
		final int size = strAll.length();
		ed = strAll.indexOf(strSrc);
		if (ed == -1) return strAll;

		StringBuffer buf = new StringBuffer(size);
		final int len =  strSrc.length();
		do {
			buf.append(strAll.substring(st, ed));
			buf.append(strDest);
			ed += len;
			st = ed;
		} while ((ed = strAll.indexOf(strSrc, ed)) != -1);
		if (st < size) {
			buf.append(strAll.substring(st));
		}
		return buf.toString();
	}

	private String toDate() {
		//ToDate_AutoCode
		SimpleDateFormat dateFormat=new SimpleDateFormat("'#SERVERDATE#'yyyy/MM/dd/HH/mm/ss");
		java.util.Date currentDate = new java.util.Date();
		return dateFormat.format(currentDate);
	}

	final String toKor (String en){
		//ToKor_AutoCode
		if(en==null){
			return "";
		}
		try{
			return new String(en.getBytes("8859_1"), "utf-8");
		}catch(Exception e){return en;}
	}

	private void objectWrite(int type, int left, int top, int width, int height, String data, String name, String style) throws Exception {
		//ObjectWrite_AutoCode
		manager.scriptWrite(type, left, top, width, height, data, name, style);
	}

	private void propertyWrite(int type, String name, String property, String style) throws Exception {
		//PropertyWrite_AutoCode
		manager.scriptWrite(type, name, property, style);
	}

	private void pageWrite(int pageNum) throws Exception {
		//PageWrite_AutoCode
		manager.scriptWrite("Page", "number", Integer.toString(pageNum), true);
	}
}
%>
