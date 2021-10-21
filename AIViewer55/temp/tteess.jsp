﻿<%
/************************************************************************************
Generated by AIDesigner 5.6.0.3
************************************************************************************
보고서 제목 : 보고서 (2016/6/15 13:37:6)
작성일 : 2016년6월15일 13시37분6초
수정일 : 2016년6월15일 19시17분38초
작성자 :
************************************************************************************/
%>

<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=utf-8" %>

<%@ page import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL" %>
<%@ page import="com.activeintra.manager.*" %>
<%@ page import="com.activeintra.url.*" %>
<%@ page import="com.activeintra.util.uds.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.apache.log4j.PropertyConfigurator" %>

<%@ page import="com.activeintra.util.*" %>

<%
Object[] userObj = null;
HttpParameterDecoder decoder = HttpParameterDecoder.newInstance(request, application);
request.setAttribute("paramsDecoder", decoder);

String reportMode = decoder.getParameter("reportMode");
String reportParams = decoder.getParameter("reportParams");
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

ReportHandler handler = new ReportHandler(pageContext, request, response, userObj, decoder);
handler.service(out);
handler = null;
%>

<%!
private ReportInitializer initializer;
//보고서 초기화 - 한번만 실행되고 사용자 Request에서 반복사용가능한 코드를 기술
public void jspInit() {
	initializer = new ReportInitializer(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	//수정되지 않는 정적 Query변수들을 초기화
	//sql_a
	StringBuilder sql_a = new StringBuilder();
	sql_a.setLength(0);
	sql_a.append(" SELECT C.PSN_NM ");
	sql_a.append("       , C.DEPT_NM ");
	sql_a.append("       , C.POSITION_NM ");
	sql_a.append("       , B.EDU_NM ");
	sql_a.append("       , B.EDU_TOTAL_TIME ");
	sql_a.append("       , CONCAT(B.EDU_ST_DT,' ~ ',B.EDU_ED_DT) AS EDU_DT ");
	sql_a.append("       , DATE_FORMAT(now(),'%Y-%m-%d') AS NOW_DATE ");
	sql_a.append("       , CONCAT (E.FILE_PATH,E.TITLE) AS CI_FILE_SRC ");
	sql_a.append("       , CONCAT (F.FILE_PATH,F.TITLE) AS STAMP_FILE_SRC ");
	sql_a.append("       , G.ORG_GRP_NM ");
	sql_a.append("       , D.CERTI_ORG ");
	sql_a.append("       , D.CERTI_DIRECTOR ");
	sql_a.append("       , CONCAT(DATE_FORMAT(now(),'%Y'),'-',B.EDU_ID,A.EDU_RESV_ID) AS SN ");
	sql_a.append("       , CONCAT(DATE_FORMAT(NOW(),'%Y'),'년  ',DATE_FORMAT(NOW(),'%m'),'월  ',DATE_FORMAT(NOW(),'%d'),'일  ') AS nnn ");
	sql_a.append("       , CONCAT(B.EDU_ID,A.EDU_RESV_ID) AS SNasdasd ");
	sql_a.append(" ");
	sql_a.append("       from TB_EDU_RESV AS A ");
	sql_a.append("LEFT JOIN TB_EDU AS B ON (A.EDU_ID = B.EDU_ID) ");
	sql_a.append("LEFT JOIN TB_USER_COPY AS C ON (A.USER_IDX = C.USER_IDX) ");
	sql_a.append("LEFT JOIN TB_ORG_GRP AS D ON (B.ORG_GRP_CD = D.ORG_GRP_CD) ");
	sql_a.append("LEFT JOIN TB_JNSP_FILE AS E ON (E.FILE_ID = D.CI_FILE_SRC) ");
	sql_a.append("LEFT JOIN TB_JNSP_FILE AS F ON (F.FILE_ID = D.ORG_STAMP_FILE) ");
	sql_a.append("LEFT JOIN TB_ORG_GRP AS G ON (G.ORG_GRP_CD = C.ORG_GRP_CD) ");
	sql_a.append("WHERE A.EDU_RESV_ID = 34 ");
	sql_a.append("AND A.RESV_STATE = '50' ");
	sql_a.append("AND (A.DELETE_YN != 'Y' or A.DELETE_YN IS NULL) ");
	initializer.prepareQuery("sql_a", sql_a.toString());
}

private Logger logger = Logger.getLogger("com.activeintra");
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
	private Map<String, String> mapParam;

	private int nBandRepeatType;	//1이면 반복밴드 가로 반복
	private int nBandWidth;		//반복밴드의 가로 폭
	private int nBandOffset;		//반복밴드 가로 반복 offset값
	private int nYBandStart;		//반복밴드 가로 반복 Y 시작 좌표
	private int nYBandEnd;		//반복밴드 가로 반복 Y 끝 좌표
	private int nHorRepeatNum;		//반복밴드 가로 반복 횟수
	private int nHorRepeatCnt;		//반복밴드 가로 반복 횟수 카운팅
	private Map<String, Integer> mapLeft;		//셀 Left
	private Map<String, Integer> mapTop;		//셀 Top
	private Map<String, Integer> mapWidth;		//셀 Width
	private Map<String, Integer> mapHeight;		//셀 Height
	private Map<String, String> mapStyle;		//셀 Style
	private HttpServletRequest request;
	private HttpServletResponse response;
	private PageContext pageContext;
	private JspWriter out;
	private HttpParameterDecoder decoder;

	private AIScriptManager manager;
	private String reportMode="AIScript";
	private String pdfFilename="";
	private String excelFilename="";

	//-----데이터 변수 선언-----
	String sheet10_A2 = "";
	String sheet10_A3 = "";
	String sheet10_A10 = "";
	String sheet10_F10 = "";
	String sheet10_A11 = "";
	String sheet10_F11 = "";
	String sheet10_A12 = "";
	String sheet10_F12 = "";
	String sheet10_A13 = "";
	String sheet10_F13 = "";
	String sheet10_A16 = "";
	String sheet10_A22 = "";

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_jnspcms; 	 //jnspcms Connection 객체
	private java.sql.PreparedStatement stat_a;		//ResultSet a 객체를 생성하기 위한 PreparedStatement 객체
	private ResultSet a;		//ResultSet a 객체

	//-----SQL 변수 선언-----
	private StringBuilder sql_a = new StringBuilder();		//ResultSet a 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet a 객체에서 필드 값을 받는 쿼리 필드 변수
	private String a_PSN_NM;
	private String a_DEPT_NM;
	private String a_POSITION_NM;
	private String a_EDU_NM;
	private long a_EDU_TOTAL_TIME;
	private String a_EDU_DT;
	private String a_NOW_DATE;
	private String a_CI_FILE_SRC;
	private String a_STAMP_FILE_SRC;
	private String a_ORG_GRP_NM;
	private String a_CERTI_ORG;
	private String a_CERTI_DIRECTOR;
	private String a_SN;
	private String a_nnn;
	private String a_SNasdasd;

	//ReportHandler 생성자 함수
	ReportHandler(PageContext pageContext, HttpServletRequest request, HttpServletResponse response, Object[] userObj, HttpParameterDecoder decoder){
		this.pageContext = pageContext;
		this.request = request;
		this.response = response;
		this.userObj = userObj;
		this.decoder = decoder;
	}

	//ReportHandler 서비스 함수
	void service(JspWriter out) throws Exception{
		try{    //try 구문
			//변수 초기화
			this.out = out;
			nMaxPage = 0;   //nMaxPage 초기화

			nBandRepeatType=0;
			nBandWidth=0;
			nBandOffset=0;
			nYBandStart=0;
			nYBandEnd=0;
			nHorRepeatNum=0;
			nHorRepeatCnt=0;

			manager = new AIScriptManager(request, response, pageContext, out, logger, null);

			ServletContext context = pageContext.getServletContext();
			String temp = null;
			if(!context.getContextPath().equals("/"))
			temp = request.getRequestURI().replace(context.getContextPath(), "");
			else
			temp = request.getRequestURI();

			String path = temp.replace(".jsp", ".style");

			//셀 Rect, Style 값 저장
			setCellInfoMap();

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
			logger.error("---service function exception raised---");
			logger.error(e);
			throw e;
		}finally{    //finally 구문
			//DataSet Close
			cleanup(a, stat_a, null, null);
			cleanup(null, null, null, conn_jnspcms);
		}    //end try
	}

	//-----쉬트 함수-----
	//-----SHEET=Sheet1   FRAME=Frame0 Start
	//-----폼 형식 : 상대 양식
	private void executeSheet10( ) throws Exception{
		//쉬트 초기화 함수 호출
		getSheetPaperInfo("A4", "2100x2970", "9", "VERTICAL", "56 70 56 70");
		initSheetVariant(68, 82, 528, 758, true);

		//시작 페이지 번호 출력
		pageWrite(nPageNum);

		//밴드 함수 호출
		getScriptFromveiw(true, true);    //Void 밴드 호출

		//페이지 및 좌표 설정
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //생성된 최대 페이지 번호 구하기
	}

	//-----밴드 함수-----
	//----veiw VoidBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : veiw
	//----밴드 종류 : Void 밴드
	//----bIsFrist : 부모 밴드 함수나 쉬트 함수에서 최초로 호출될 때 true, 그 이후 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. true면 출력, false면 AI 스크립트를 생성하지 않음.
	//----nRepeatCnt : 부모 반복 밴드 수행 횟수와 연동 옵션 설정시 void 밴드가 수행할 반복 횟수 전달
	private void getScriptFromveiw(boolean bIsFirst, boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=651;    //밴드 출력 높이

		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
			//DataSet 객체 생성
			//ResultSet a 객체의 생성
			if(a==null){
				a = stat_a.executeQuery();
			}else{
				a.beforeFirst();
			}

			//데이터 fetch
			if(a.next()){
				setFieldVariableFroma();	//ResultSet a에서 필드 값 설정
			}else{
				setFieldInitFroma();	//ResultSet a의 필드 값 초기화
			}

			//데이터 변수 초기화
			sheet10_A2="";
			sheet10_F10="";
			sheet10_F11="";
			sheet10_F12="";
			sheet10_F13="";
			sheet10_A22="";

			//데이터 변수 할당
			sheet10_A2 = String.valueOf(a_SN);
			sheet10_A3="수    료    증";
			sheet10_A10="소         속 :";
			sheet10_F10 = a_ORG_GRP_NM;
			sheet10_A11="성         명 :";
			sheet10_F11 = a_PSN_NM;
			sheet10_A12="교   육   명 :";
			sheet10_F12 = a_EDU_NM;
			sheet10_A13="교 육 기 간 :";
			sheet10_F13 = a_EDU_DT;
			sheet10_A16="        위 사람은 상기과정을 성실히 수료\n  하였으므로 이 증서를 수여합니다.";
			sheet10_A22 = a_nnn;
		}    //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 영역 검사
			if(isPageSkip(nYCurPos+nBandHeight)){
				pageSkip(10);
			}

			//스크립트 출력 함수 호출
			writeScriptveiw();

			//다음 출력 좌표 설정
			nYCurPos=nYCurPos+nBandHeight;
		}   //end if(bIsPrint)
	}

	//-----스크립트 출력 함수-----
	//----veiw 스크립트 문 출력 함수----
	private void writeScriptveiw( ) throws Exception{
		//스크립트문 생성
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A2"), nYCurPos+mapTop.get("sheet10_A2"), mapWidth.get("sheet10_A2"), mapHeight.get("sheet10_A2"), sheet10_A2, "sheet10_A2", mapStyle.get("sheet10_A2"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A3"), nYCurPos+mapTop.get("sheet10_A3"), mapWidth.get("sheet10_A3"), mapHeight.get("sheet10_A3"), sheet10_A3, "sheet10_A3", mapStyle.get("sheet10_A3"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A10"), nYCurPos+mapTop.get("sheet10_A10"), mapWidth.get("sheet10_A10"), mapHeight.get("sheet10_A10"), sheet10_A10, "sheet10_A10", mapStyle.get("sheet10_A10"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_F10"), nYCurPos+mapTop.get("sheet10_F10"), mapWidth.get("sheet10_F10"), mapHeight.get("sheet10_F10"), sheet10_F10, "sheet10_F10", mapStyle.get("sheet10_F10"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A11"), nYCurPos+mapTop.get("sheet10_A11"), mapWidth.get("sheet10_A11"), mapHeight.get("sheet10_A11"), sheet10_A11, "sheet10_A11", mapStyle.get("sheet10_A11"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_F11"), nYCurPos+mapTop.get("sheet10_F11"), mapWidth.get("sheet10_F11"), mapHeight.get("sheet10_F11"), sheet10_F11, "sheet10_F11", mapStyle.get("sheet10_F11"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A12"), nYCurPos+mapTop.get("sheet10_A12"), mapWidth.get("sheet10_A12"), mapHeight.get("sheet10_A12"), sheet10_A12, "sheet10_A12", mapStyle.get("sheet10_A12"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_F12"), nYCurPos+mapTop.get("sheet10_F12"), mapWidth.get("sheet10_F12"), mapHeight.get("sheet10_F12"), sheet10_F12, "sheet10_F12", mapStyle.get("sheet10_F12"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A13"), nYCurPos+mapTop.get("sheet10_A13"), mapWidth.get("sheet10_A13"), mapHeight.get("sheet10_A13"), sheet10_A13, "sheet10_A13", mapStyle.get("sheet10_A13"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_F13"), nYCurPos+mapTop.get("sheet10_F13"), mapWidth.get("sheet10_F13"), mapHeight.get("sheet10_F13"), sheet10_F13, "sheet10_F13", mapStyle.get("sheet10_F13"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A16"), nYCurPos+mapTop.get("sheet10_A16"), mapWidth.get("sheet10_A16"), mapHeight.get("sheet10_A16"), sheet10_A16, "sheet10_A16", mapStyle.get("sheet10_A16"));
		objectWrite(CELL_OBJECT, nXCurPos+mapLeft.get("sheet10_A22"), nYCurPos+mapTop.get("sheet10_A22"), mapWidth.get("sheet10_A22"), mapHeight.get("sheet10_A22"), sheet10_A22, "sheet10_A22", mapStyle.get("sheet10_A22"));
	}

	private void getBgImageScriptEx(int nIndex) throws Exception{
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//jnspcms Connection 객체 생성
		Class.forName("com.mysql.jdbc.Driver");
		conn_jnspcms = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jnspcms?useUnicode=true&characterEncoding=utf-8", "jnspcms", "jnspcms!@12");
	}

	//-----ResultSet, PreparedStatement, Connection, CallableStatement Close 함수-----
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
				}else if(rs instanceof com.activeintra.util.uds.JSONSetHandler){
					((com.activeintra.util.uds.JSONSetHandler)rs).close();
				}
			}
			catch(SQLException e){
				logger.error(e);
			}
		}

		if(st != null){
			try{
				st.close();
			}
			catch(SQLException e){
				logger.error(e);
			}
		}

		if(cs != null){
			try{
				cs.close();
			}
			catch(SQLException e){
				logger.error(e);
			}
		}

		if(conn != null){
			try{
				conn.close();
			}
			catch(SQLException e){
				logger.error(e);
			}
		}
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst() throws Exception {
		stat_a = initializer.configPreparedStatement("sql_a", mapParam, conn_jnspcms, null);
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet a 객체에서 필드 값 설정 함수
	private void setFieldVariableFroma() throws Exception{
		int size;
		Blob blob;
		byte[] buf;

		a_PSN_NM = GetB(a.getString(1));
		a_DEPT_NM = GetB(a.getString(2));
		a_POSITION_NM = GetB(a.getString(3));
		a_EDU_NM = GetB(a.getString(4));
		a_EDU_TOTAL_TIME = a.getLong(5);
		a_EDU_DT = GetB(a.getString(6));
		a_NOW_DATE = GetB(a.getString(7));
		a_CI_FILE_SRC = GetB(a.getString(8));
		a_STAMP_FILE_SRC = GetB(a.getString(9));
		a_ORG_GRP_NM = GetB(a.getString(10));
		a_CERTI_ORG = GetB(a.getString(11));
		a_CERTI_DIRECTOR = GetB(a.getString(12));
		blob=a.getBlob(13);
		if(blob==null){
			size=0;
		}
		else{
			size=(int)blob.length();
		}

		if(size!=0){
			buf=blob.getBytes(1, size);
			a_SN=new String(com.activeintra.util.Base64.encode(buf));
		}
		else{
			a_SN="";
		}
		a_nnn = GetB(a.getString(14));
		blob=a.getBlob(15);
		if(blob==null){
			size=0;
		}
		else{
			size=(int)blob.length();
		}

		if(size!=0){
			buf=blob.getBytes(1, size);
			a_SNasdasd=new String(com.activeintra.util.Base64.encode(buf));
		}
		else{
			a_SNasdasd="";
		}
	}

	//ResultSet a 객체의 필드 값 초기화 함수
	private void setFieldInitFroma(){
		a_PSN_NM = "";
		a_DEPT_NM = "";
		a_POSITION_NM = "";
		a_EDU_NM = "";
		a_EDU_TOTAL_TIME = 0L;
		a_EDU_DT = "";
		a_NOW_DATE = "";
		a_CI_FILE_SRC = "";
		a_STAMP_FILE_SRC = "";
		a_ORG_GRP_NM = "";
		a_CERTI_ORG = "";
		a_CERTI_DIRECTOR = "";
		a_SN="";
		a_nnn = "";
		a_SNasdasd="";
	}

	//ResultSet a 객체에서 RowData 획득함수
	private List<Object> getAIRowDataFroma() throws Exception{
		List<Object> row = new ArrayList<Object>();

		row.add(a.getObject(1));
		row.add(a.getObject(2));
		row.add(a.getObject(3));
		row.add(a.getObject(4));
		row.add(a.getLong(5));
		row.add(a.getObject(6));
		row.add(a.getObject(7));
		row.add(a.getObject(8));
		row.add(a.getObject(9));
		row.add(a.getObject(10));
		row.add(a.getObject(11));
		row.add(a.getObject(12));
		row.add(a.getBlob(13));
		row.add(a.getObject(14));
		row.add(a.getBlob(15));

		return row;
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarientEx(){
	}

	//-----공통 함수 선언-----
	//파라미터 설정 함수
	private void setParam() {
		//SetParam_AutoCode
		reportMode=decoder.getParameterB("reportMode");
		if(reportMode.equals("")) {
			reportMode="HTML";
		}
		manager.setParam("pdfFilename:" + pdfFilename + "," + "excelFilename:" + excelFilename + "," + decoder.getParameterB("reportParams"));
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
		if(nBandRepeatType==1) {
			int tmpX;
			tmpX=nXCurPos+nBandWidth+nBandOffset;
			nHorRepeatCnt=nHorRepeatCnt+1;
			if(tmpX+nBandWidth>nXEndPos || nHorRepeatCnt==nHorRepeatNum) {
				nYBandStart=nYStartPos;
				nYBandEnd=0;
				nHorRepeatCnt=0;
			}else{
				if(nYBandEnd<nYCurPos) {
					nYBandEnd=nYCurPos;
				}
				nYCurPos=nYBandStart;
				nXCurPos=tmpX;
				return;
			}
		}

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
	private int getPrintHeight(String data, int[] charWidth, int fontSize, int printWidth, int printHeight, int nMaxHeight, int horMargin, int vertMargin, String styleName) throws Exception {
		//GetPrintHeight_AutoCode
		if(data.equals(isEmpty)){
			return nMaxHeight;
		}
		if(!reportMode.equals("AIScript")) {
			printWidth+=horMargin;
			printHeight+=vertMargin;
			int needHeight=(int)TextHandler.wordWrapTextEx(printWidth, data, styleName, manager.getAIStyleInfo());

			if(needHeight>printHeight) {
				needHeight=needHeight-printHeight;
			}else{
				needHeight=0;
			}

			needHeight=(int)MAX((long)needHeight,(long)nMaxHeight);
			return needHeight;
		}
		else {
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
	private int getPrintHeightEx(String data, String[] strSplitData, int[] charWidth, int fontSize, int printWidth, int nExtHeight, int nMaxHeight, int horMargin, int vertMargin, String styleName) throws Exception {
		//GetPrintHeightEx_AutoCode
		if(!reportMode.equals("AIScript")) {
			strSplitData[0]="";
			strSplitData[1]="";
			printWidth+=horMargin;
			nExtHeight+=vertMargin;
			int needHeight=(int)TextHandler.wordWrapTextEx(printWidth, nExtHeight, data, strSplitData, styleName, manager.getAIStyleInfo());

			if(needHeight>nExtHeight) {
				needHeight=nExtHeight;
			}

			needHeight = (int)MAX((long)needHeight,(long)nMaxHeight);
			return needHeight;
		}
		else {
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
	}

	//스크립트 헤더 출력 함수
	private void getScriptHeader(String paper, String size, String value, String orient, String margin) throws Exception{
		//GetScriptHeader_AutoCode
		manager.scriptWrite("AIReport", "scriptVersion|docVersion|style|title", "32|0|Temporary.style|보고서 (2016/6/15 13:37:6)", false);
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
			return new String(en.getBytes("ISO-8859-1"), "utf-8");
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

	private void objectCellWrite(String name, String data, int nMoveX, int nMoveY) throws Exception {
		objectWrite(CELL_OBJECT, nMoveX+(nXCurPos+mapLeft.get(name)), nMoveY+(nYCurPos+mapTop.get(name)), mapWidth.get(name), mapHeight.get(name), data, name, mapStyle.get(name));
	}

	public String checkParam(String param) {
		param = param.replace("'", "");
		param = param.replace(";", "");
		param = param.replace("|", "");
		param = param.replace(":", "");
		param = param.replace("+", "");
		param = param.replace("\"", "");
		param = param.replace("\\", "");
		param = param.replace("--", "");
		param = param.replace("/", "");
		param = param.replaceAll("(?i)select", "");
		param = param.replaceAll("(?i)union", "");
		param = param.replaceAll("(?i)delete", "");
		param = param.replaceAll("(?i)update", "");
		param = param.replaceAll("(?i)insert", "");
		param = param.replaceAll("(?i)create", "");
		param = param.replaceAll("(?i)alter", "");
		param = param.replaceAll("(?i)drop", "");
		param = param.replaceAll("(?i)grant", "");
		param = param.replaceAll("(?i)revoke", "");
		param = param.replaceAll("(?i)merge", "");
		return param;
	}

	public String checkAITag(String strText) {
		strText = strText.replace("AI{P}", "^");
		strText = strText.replace("AI{F}", "@");
		strText = strText.replace("AI{S}", "#");
		strText = strText.replace("AI{E}", "=");
		return strText;
	}

	//셀 Rect, Style값 Map 저장
	public void setCellInfoMap_Internal(String name, int left, int top, int width, int height, String style) throws Exception {
		if( left != -1 ) {
			mapLeft.put(name, left);
		}
		if( top != -1 ) {
			mapTop.put(name, top);
		}
		if( width != -1 ) {
			mapWidth.put(name, width);
		}
		if( height != -1 ) {
			mapHeight.put(name, height);
		}
		if( style != null && !style.equals("") ) {
			mapStyle.put(name, style);
		}
	}

	//셀 Rect, Style값 저장
	public void setCellInfoMap() throws Exception {
		mapLeft = new HashMap<String, Integer>();
		mapTop = new HashMap<String, Integer>();
		mapWidth = new HashMap<String, Integer>();
		mapHeight = new HashMap<String, Integer>();
		mapStyle = new HashMap<String, String>();
		setCellInfoMap_Internal("sheet10_A10", 0, 175, 90, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_F10", 90, 175, 368, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_A11", 0, 199, 90, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_F11", 90, 199, 368, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_A12", 0, 223, 90, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_F12", 90, 223, 368, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_A13", 0, 247, 90, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_F13", 90, 247, 18, 24, "cell_style_2");
		setCellInfoMap_Internal("sheet10_A16", 0, 311, 458, 100, "cell_style_3");
		setCellInfoMap_Internal("sheet10_A2", 0, 6, 458, 29, "cell_style_0");
		setCellInfoMap_Internal("sheet10_A22", 0, 431, 458, 40, "cell_style_4");
		setCellInfoMap_Internal("sheet10_A3", 0, 35, 458, 120, "cell_style_1");
	}

	private ResultSet acquireResultSet(CallableStatement cstmt, int cursorIdx) throws SQLException {
		if (cstmt.execute()) {
			if (cursorIdx == -1) {
				return (cstmt.getResultSet());
			} else {
				return ((ResultSet) cstmt.getObject(cursorIdx));
			}
		} else {
			int count;
			if ((count = cstmt.getUpdateCount()) == -1) {
				if (cursorIdx == -1) {
					throw (new UnsupportedOperationException("None result"));
				} else {
					return ((ResultSet) cstmt.getObject(cursorIdx));
				}
			}
			while (true) {
				if (cstmt.getMoreResults()) {
					if (cursorIdx == -1) {
						return (cstmt.getResultSet());
					} else {
						return ((ResultSet) cstmt.getObject(cursorIdx));
					}
				} else if ((count = cstmt.getUpdateCount()) == -1) {
					if (cursorIdx == -1) {
						throw (new UnsupportedOperationException("None result-2"));
					} else {
						return ((ResultSet) cstmt.getObject(cursorIdx));
					}
				}
			}
		}
	}
}
%>
