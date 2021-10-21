<%
/************************************************************************************
Generated by AIDesigner 5.5.0.9
************************************************************************************
보고서 제목 : 보고서 (2013/4/18 9:40:37)
작성일 : 2013년4월18일 9시40분37초
작성자 :
************************************************************************************/
%>

<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL" %>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.activeintra.manager.*" %>
<%@ page import="com.activeintra.url.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.apache.log4j.PropertyConfigurator" %>
<%@ page import="com.activeintra.util.uds.*" %>

<%@ page import="com.activeintra.util.*" %>

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
private Logger logger = Logger.getLogger("test203.jsp");
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
	int[] nAutoHeight_r1=new int[1];
	String sheet10_B4;
	String sheet10_C4;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_mysqltestdb;		//DSN mysqltestdb Connection 객체
	private java.sql.Statement stat_SQL_htmltest;		//ResultSet SQL_htmltest 객체를 생성하기 위한 Statement 객체
	private ResultSet SQL_htmltest;		//ResultSet SQL_htmltest 객체

	//-----SQL 변수 선언-----
	private String sql_SQL_htmltest;		//ResultSet SQL_htmltest 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet SQL_htmltest 객체에서 필드 값을 받는 쿼리 필드 변수
	private long SQL_htmltest_id;
	private String SQL_htmltest_htmldata;

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
			cleanup(SQL_htmltest, stat_SQL_htmltest, null, null);
			cleanup(null, null, null, conn_mysqltestdb);
		}    //end try
	}

	//-----쉬트 함수-----
	//-----SHEET=Sheet1   FRAME=Frame0 Start
	//-----폼 형식 : 상대 양식
	private void executeSheet10( ) throws Exception{
		//쉬트 초기화 함수 호출
		getSheetPaperInfo("A4", "2100x2970", "9", "VERTICAL", "56 70 56 70");
		initSheetVariant(74, 83, 523, 762, true);

		//시작 페이지 번호 출력
		pageWrite(nPageNum);

		//밴드 함수 호출
		getScriptFromVoidBand100(true, true);    //Void 밴드 호출
		getScriptFromr1(true);    //반복 밴드 호출

		//페이지 및 좌표 설정
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //생성된 최대 페이지 번호 구하기
	}

	//-----밴드 함수-----
	//----VoidBand100 VoidBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : VoidBand100
	//----밴드 종류 : Void 밴드
	//----bIsFrist : 부모 밴드 함수나 쉬트 함수에서 최초로 호출될 때 true, 그 이후 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. true면 출력, false면 AI 스크립트를 생성하지 않음.
	//----nRepeatCnt : 부모 반복 밴드 수행 횟수와 연동 옵션 설정시 void 밴드가 수행할 반복 횟수 전달
	private void getScriptFromVoidBand100(boolean bIsFirst, boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=60;    //밴드 출력 높이

		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
		}    //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			//Empty Row만으로 구성되어 출력 위치를 조정하기 위한 VoidBand 함수 호출
			voidBandNoneData(nBandHeight, 10);
		}   //end if(bIsPrint)
	}

	//-----r1 RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : r1
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromr1(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;
		//폰트명 : 굴림
		//폰트 사이즈 : 11
		//각 문자별 폭을 할당할 배열 선언
		int[] charWidth = {366,366,413,825,657,963,756,312,413,413,550,688,367,688,367,459,632,632,632,632,632,632,632,632,632,632,367,367,688,688,688,596,1100,710,744,790,794,688,655,846,804,296,550,698,597,894,769,846,700,851,733,696,640,782,660,984,688,688,688,550,1009,550,596,550,366,619,666,630,666,624,376,666,628,265,265,550,255,947,638,666,666,666,366,578,345,627,550,825,550,550,550,550,550,550,871,1100};

		//데이터 변수 초기화
		sheet10_B4="";
		sheet10_C4="";

		//DataSet 객체 생성
		//ResultSet SQL_htmltest 객체의 생성
		if(SQL_htmltest==null){
			SQL_htmltest = stat_SQL_htmltest.executeQuery(sql_SQL_htmltest.toString());
		}else{
			SQL_htmltest.beforeFirst();
		}

		while(SQL_htmltest.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromSQL_htmltest();	//RecordSet SQL_htmltest에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_B4=String.valueOf(SQL_htmltest_id);
			sheet10_C4=manager.scriptObject.HtmlDataParsing(321, 20, "cell_style_1", SQL_htmltest_htmldata, "sheet10_C4");

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				//페이지 연결 출력 루프문 시작
				boolean bSplitLoopPrint=true;
				boolean bSplitLoop=true;
				String []sheet10_C4_Split=new String[2];
				do{
					if(isPageSkip(nYCurPos+15)){   //스크립트 출력 영역 검사
						//페이지 스킵 함수 호출
						pageSkip(10);
					}   //end if(page skip test)

					//페이지 연결 출력 Auto Size Code
					nAutoHeight_r1[0]=0;
					nAutoHeight_r1[0]=manager.scriptObject.HtmlDataPrintHeightEx(nYEndPos-nYCurPos, nAutoHeight_r1[0], sheet10_C4_Split, "sheet10_C4");
					nBandHeight=nAutoHeight_r1[0];
					if(!sheet10_C4_Split[0].equals(isEmpty)){
						sheet10_C4=sheet10_C4_Split[0];
					}

					//스크립트 출력 함수 호출
					writeScriptr1(bSplitLoopPrint);

					//페이지 연결 출력 및 가상병합 플래그 Reset
					if(sheet10_C4_Split[0].equals(isEmpty)){
						bSplitLoop=false;
					}else{
						sheet10_B4="";		//XL 속성이 없는 셀
						sheet10_C4=sheet10_C4_Split[1];
						bSplitLoopPrint=false;
					}

					//다음 출력 좌표 설정
					nYCurPos=nYCurPos+nBandHeight;
				}while(bSplitLoop);    //페이지 연결 출력 루프문 종료
			}   //end if(bIsPrint)

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end

		if(bIsFirst){   //while 루프가 실행되지 않은 경우
		} else {   //while 루프가 실행된 경우
		}   //루프 외부 end if(bIsFirst)
	}

	//-----스크립트 출력 함수-----
	//----r1 스크립트 문 출력 함수----
	private void writeScriptr1(boolean bSplitLoopPrint) throws Exception{
		//스크립트문 생성
		objectWrite(CELL_OBJECT, nXCurPos+14, nYCurPos, 80, nAutoHeight_r1[0], sheet10_B4, "sheet10_B4", "cell_style_0");
		manager.scriptObject.HtmlDataWrite(nXCurPos+94, nYCurPos, nAutoHeight_r1[0], "cell_style_1", "sheet10_C4", manager);
	}

	private void getBgImageScriptEx(int nIndex) throws Exception{
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//mysqltestdb Connection 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn_mysqltestdb = DriverManager.getConnection("jdbc:mysql://192.168.0.27:3306/test","sysk","1234");
		stat_SQL_htmltest=conn_mysqltestdb.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	}

	//-----ResultSet, Statement, Connection, CallableStatement Close 함수-----
	private void cleanup(Object rs, Statement st, CallableStatement cs, Connection conn){
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
	private void initSQLConst(){
		sql_SQL_htmltest = "SELECT * FROM htmltest";
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet SQL_htmltest 객체에서 필드 값 설정 함수
	private void setFieldVariableFromSQL_htmltest() throws Exception{
		int size;
		Blob blob;
		byte[] buf;

		SQL_htmltest_id=SQL_htmltest.getLong(1);
		blob=SQL_htmltest.getBlob(2);
		if(blob==null){
			size=0;
		}
		else{
			size=(int)blob.length();
		}

		if(size!=0){
			buf=blob.getBytes(1, size);
			SQL_htmltest_htmldata=new String(buf);
		}
		else{
			SQL_htmltest_htmldata="";
		}
	}

	//ResultSet SQL_htmltest 객체의 필드 값 초기화 함수
	private void setFieldInitFromSQL_htmltest(){
		SQL_htmltest_id=0L;
		SQL_htmltest_htmldata="";
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
		manager.scriptWrite("AIReport", "scriptVersion|docVersion|style|title", "32|7|test203.style|보고서 (2013/4/18 9:40:37)", false);
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
