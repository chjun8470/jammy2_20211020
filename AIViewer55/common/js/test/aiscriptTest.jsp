
<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL" %>
<%@ page contentType="application/pdf; charset=utf-8" pageEncoding="euc-kr" %>
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
private Logger logger = Logger.getLogger("aiscriptTest.jsp");
class ReportHandler{
	//���� ���� ����
	private Object[] userObj = null;
	private int nStartPage;		//�� ��Ʈ�� ���� ������ ����
	private int nMaxPage;		//�� ��Ʈ�� ����� �� ������ �ִ� ������ ��ȣ ����
	private int nPageNum;		//���� ������ ��ȣ
	private int nYStartPos;		//��Ʈ���� Y ���� ��ǥ
	private int nYEndPos;		//��Ʈ���� Y �� ��ǥ
	private int nYCurPos;		//���� Y ��ǥ
	private int nYSavePos;		//����� ��Ƽ ������ ��Ʈ���� ���� Y ��ǥ ����
	private int nYLastPos;		//����� ��Ƽ ������ ��Ʈ���� �� �������� ������ Y ��ǥ ����
	private int nXStartPos;		//��Ʈ���� X ���� ��ǥ
	private int nXEndPos;		//��Ʈ���� X �� ��ǥ
	private int nXCurPos;		//���� X ��ǥ
	private int nXSavePos;		//����� ��Ƽ ������ ��Ʈ���� ���� X ��ǥ ����
	private int  nXLastPos;		//����� ��Ƽ ������ ��Ʈ���� �� �������� ������ X ��ǥ ����
	private boolean bIsBeforePageSkip;		//���� ��忡�� ������ �ѱ�� ���� �Ǵ�
	private int nLoopRef;		//���� ��Ŀ��� ���� ���� ����
	private int CELL_OBJECT = 0;
	private int DRAW_OBJECT = 1;
	private String isEmpty="";		//�� ���ڿ� �񱳿� ���
	private Map<String, String> mapParam;

	private HttpServletRequest request;
	private HttpServletResponse response;
	private PageContext pageContext;
	private JspWriter out;
	private ServletContext context;

	private AIScriptManager manager;
	private String reportMode="AIScript";
	private String pdfFilename="";
	private String excelFilename="";

	//-----������ ���� ����-----
	long sheet10_B4;
	String sheet10_A5;
	String sheet10_B6;
	String sheet10_B7;

	//ReportHandler ������ �Լ�
	ReportHandler(PageContext pageContext,HttpServletRequest request,HttpServletResponse response,Object[] userObj){
		this.pageContext=pageContext;
		this.request=request;
		this.response=response;
		this.userObj=userObj;
	}

	//ReportHandler ���� �Լ�
	void service(JspWriter out) throws Exception{
		try{    //try ����
			//���� �ʱ�ȭ
			this.out = out;
			nMaxPage = 0;   //nMaxPage �ʱ�ȭ

			manager = new AIScriptManager(request, response, pageContext, out, logger, null);

			context = pageContext.getServletContext();
			//String temp = null;
			//if(!context.getContextPath().equals("/"))
			//temp = request.getRequestURI().replace(context.getContextPath(), "");
			//else
			//temp = request.getRequestURI();
				
			//temp=temp.replace("aiscriptTest", "report");
			//System.out.println(temp);
				
			//temp = "test.jsp";

			String path = "/temp/report.style";

			//�Ķ���� ���� �Լ� ȣ��
			setParam();
			if(manager.open(reportMode, context.getRealPath(path)))
			{
				//��ũ��Ʈ ��� �Լ� ȣ��
				getScriptHeader("A4", "2100x2970", "9", "VERTICAL", "56 70 56 70");

				//���� ������ �ʱ�ȭ �Լ� ȣ��
				initConstVarient();

				//Connection �� Statement ��ü ���� �Լ� ȣ��
				createConnAndStateObject();

				//������ �ʱ�ȭ �Լ� ȣ��
				initSQLConst();

				//��Ʈ �Լ� ȣ��
				//SHEET=Sheet1   FRAME=0 �Լ� ȣ��
				executeSheet10();

				//---------------��ũ��Ʈ ����---------------
				manager.scriptWrite("/AIReport", "", "", false);
				manager.close();
			}
		}catch(Exception e){    //catch ����
			logger.error("---service function exception raised---");
			logger.error(e);
			throw e;
		}finally{    //finally ����
		}    //end try
	}

	//-----��Ʈ �Լ�-----
	//-----SHEET=Sheet1   FRAME=Frame0 Start
	//-----�� ���� : ��� ���
	private void executeSheet10( ) throws Exception{
		//��Ʈ �ʱ�ȭ �Լ� ȣ��
		getSheetPaperInfo("A4", "2100x2970", "9", "VERTICAL", "56 70 56 70");
		initSheetVariant(68, 82, 528, 761, true);

		//���� ������ ��ȣ ���
		pageWrite(nPageNum);

		//��� �Լ� ȣ��
		getScriptFromv1(true, true);    //Void ��� ȣ��

		//������ �� ��ǥ ����
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //������ �ִ� ������ ��ȣ ���ϱ�
	}

	//-----��� �Լ�-----
	//----v1 VoidBand Start----
	//----�Ҽ� ��Ʈ : SHEET=Sheet1    FRAME=Frame0
	//----��� �̸� : v1
	//----��� ���� : Void ���
	//----bIsFrist : �θ� ��� �Լ��� ��Ʈ �Լ����� ���ʷ� ȣ��� �� true, �� ���� ȣ��� �� false
	//----bIsPrint : ���߱� �Ӽ� ���� ����. true�� ���, false�� AI ��ũ��Ʈ�� �������� ����.
	//----nRepeatCnt : �θ� �ݺ� ��� ���� Ƚ���� ���� �ɼ� ������ void ��尡 ������ �ݺ� Ƚ�� ����
	private void getScriptFromv1(boolean bIsFirst, boolean bIsPrint) throws Exception{
		//���� ���� ���� �� �ʱ�ȭ
		int nBandHeight=480;    //��� ��� ����

		if(bIsFirst){   //��� ���� ȣ�� �ÿ��� ����Ǵ� �ڵ�
		}    //end if(bIsFirst)

		//AI ��ũ��Ʈ ���
		if(bIsPrint){   //���߱� �Ӽ��� �������� ������ bIsPrint�� true
			//��ũ��Ʈ ��� ���� �˻�
			if(isPageSkip(nYCurPos+nBandHeight)){
				pageSkip(10);
			}

			//��ũ��Ʈ ��� �Լ� ȣ��
			writeScriptv1();

			//���� ��� ��ǥ ����
			nYCurPos=nYCurPos+nBandHeight;
		}   //end if(bIsPrint)
	}

	//-----��ũ��Ʈ ��� �Լ�-----
	//----v1 ��ũ��Ʈ �� ��� �Լ�----
	private void writeScriptv1( ) throws Exception{
		//��ũ��Ʈ�� ����
		//objectWrite(CELL_OBJECT, nXCurPos+80, nYCurPos+60, 80, 20, String.valueOf(sheet10_B4), "sheet10_B4", "cell_style_0");
		//objectWrite(CELL_OBJECT, nXCurPos, nYCurPos+80, 80, 20, sheet10_A5, "sheet10_A5", "cell_style_1");
		//objectWrite(CELL_OBJECT, nXCurPos+80, nYCurPos+100, 240, 20, sheet10_B6, "sheet10_B6", "cell_style_2");
		//objectWrite(CELL_OBJECT, nXCurPos+80, nYCurPos+120, 80, 20, sheet10_B7, "sheet10_B7", "cell_style_3");
		
		InputStream in = findResourceStream("/temp/", "report.txt", context);
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(in,"utf-8"));
		
		
		while (true){
			String line=reader.readLine();
			if(line==null)
				break;
			System.out.println(line);
			
			String left="";
			String top="";
			String width="";
			String height="";
			String style="";
			String name="";
			String property="";
			String value="";
			
			
			if(line.startsWith("<<AIReport")){
				
			}
			else if(line.startsWith("<PaperInfo")){
				
			}
			else if(line.startsWith("<Page")){
				
			}
			else if(line.startsWith("<CellObject")){
				String[] object = line.split(" ");
				
				for(int i=1; i<object.length; i++){
					if(object[i].startsWith("left")){
						left=object[i].substring(6, object[i].length()-1);
					}
					else if(object[i].startsWith("top")){
						top=object[i].substring(5, object[i].length()-1);
					}
					else if(object[i].startsWith("width")){
						width=object[i].substring(7, object[i].length()-1);
					}
					else if(object[i].startsWith("height")){
						height=object[i].substring(8, object[i].length()-1);
					}
					else if(object[i].startsWith("height")){
						height=object[i].substring(8, object[i].length()-1);
					}
					else if(object[i].startsWith("style")){
						style=object[i].substring(7, object[i].length()-1);
					}
					else if(object[i].startsWith("name")){
						if(object[i].endsWith("</CellObject>")){
							System.out.println(object[i]);
							int startIndex=object[i].indexOf(">");
							name=object[i].substring(6, object[i].length()-startIndex-2);
							value=object[i].substring(startIndex+1, object[i].length()-13);
						}
						else if(object[i].endsWith("/>")){
							name=object[i].substring(6, object[i].length()-2);
						}
						
					}
						
				}
				System.out.println("left="+left + " top=" + top +" width=" + width +" height=" + height + " style=" + style
						+ " name=" + name + " value=" + value);
				
				objectWrite(CELL_OBJECT, Integer.parseInt(left), Integer.parseInt(top), 
						Integer.parseInt(width), Integer.parseInt(height), value, name, style);
				
			}
			else if(line.startsWith("<CellProperty")){
				
			}
			else if(line.startsWith("<DrawObject")){
				
			}
			else if(line.startsWith("<DrawProperty")){
				
			}
			else if(line.startsWith("</AIReport")){
				
			}
			
	  	}
		reader.close();
		

		//String scripts=readStreamAll(in);
		
	}

	private void getBgImageScriptEx(int nIndex) throws Exception{
	}

	//-----Connection �� Statement ��ü ���� �Լ�-----
	private void createConnAndStateObject() throws Exception{
	}

	//-----ResultSet, Statement, Connection, CallableStatement Close �Լ�-----
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

	//-----SQL�� ���� �ʱ�ȭ �Լ�-----
	private void initSQLConst(){
	}

	//-----���� ������ �ʱ�ȭ �Լ�-----
	private void initConstVarientEx(){
		sheet10_B4=12345678;
		sheet10_A5="" + toDate() + "";
		sheet10_B6="" + toDate() + "";
		sheet10_B7="" + toDate() + "";
	}

	//-----���� �Լ� ����-----
	//�Ķ���� ���� �Լ�
	private void setParam() {
		//SetParam_AutoCode
		reportMode=toKor(GetB(request.getParameter("reportMode")));
		if(reportMode.equals("")) {
			reportMode="HTML";
		}
		manager.setParam("pdfFilename:" + pdfFilename + "," + "excelFilename:" + excelFilename + "," + toKor(GetB(request.getParameter("reportParams"))));
	}

	//��� ������ �ʱ�ȭ ���� �Լ�
	private void initConstVarient() {
		//InitConstVarient_AutoCode
		initConstVarientEx();
	}

	//��� �̹��� ��� ���� �Լ�
	private void getBgImageScript(int nIndex) throws Exception{
		//GetBgImageScript_AutoCode
		getBgImageScriptEx(nIndex);
	}

	//������ ��ŵ �Լ�
	//������ ��ŵ�� ȣ��Ǵ� �Լ��μ� ������ ��ȣ�� ������Ű�� ������ ���ù� ��� �׸��� Y��ǥ �ʱ�ȭ
	//�Ű������� ���� �ش� ��Ʈ�� ��� �̹���, �Ӹ��� ���, �ٴڱ� ��� �Լ� ȣ��
	private void pageSkip(int nIndex) throws Exception{
		//PageSkip_AutoCode
		nXCurPos=nXStartPos;
		nYCurPos=nYStartPos;
		nPageNum=nPageNum+1;
		pageWrite(nPageNum);

		switch(nIndex){
			case 10:		//SHEET=Sheet=1   FRAME=0���� ������ ��ŵ��
			break;
		}
	}

	//������ ��ŵ�� �ʿ����� �˻��ϴ� �Լ�
	private boolean isPageSkip(int nTestPos){
		//IsPageSkip_AutoCode
		if(nTestPos>nYEndPos){
			return true;
		}else{
			return false;
		}
	}

	//������ ���� �����Ͽ� �������� ��� ���̸� �ڵ������� �����ϴ� �Լ�
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

	//���� �ܾ��� ���� ���ں��� �����Ͽ� �������� ��� ���̸� �����ϴ� �Լ�
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

	//������ ���� �����Ͽ� �������� ��� ���̸� �ڵ������� �����ϰ� ������ �ʰ��� �ʰ��ϴ� ������ �����ϴ� �Լ�
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

	//��ũ��Ʈ ��� ��� �Լ�
	private void getScriptHeader(String paper, String size, String value, String orient, String margin) throws Exception{
		//GetScriptHeader_AutoCode
		manager.scriptWrite("AIReport", "scriptVersion|docVersion|style|title", "32|4|test004.style|���� (2013/10/30 19:20:11)", false);
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

	//Empty Row������ �����Ǿ� ��� ��ġ�� �����ϱ� ���� VoidBand �Լ�
	//nRangePos - VoidBand�� ��� ����
	//nIndex - PageSkip �Լ� ȣ��� ������ ��Ʈ �ε���
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
	
	private InputStream findResourceStream(String startDir, String fileName,
            ServletContext context) {
		Set<String> dir = context.getResourcePaths(startDir);
		if (dir == null) return null; // empty
		
		List<String> list = new ArrayList<String>(dir.size());
		for (String path : dir) {
			if (path.endsWith(fileName)) {
				return (context.getResourceAsStream(path));
			}
			if (path.charAt(path.length()-1) == '/') { // ���丮 by API spec.
				list.add(path);
			}
		}
		
		for (String subDir : list) {
			InputStream in = findResourceStream(subDir, fileName, context);
			if (in != null) return in;
		}
		
		return null;
	}
	
	public String readStreamAll(InputStream in){
	       
		ByteArrayOutputStream out = new ByteArrayOutputStream(1024);
        final int capa = 512;
        byte[] data = new byte[capa];
        BufferedInputStream bin = new BufferedInputStream(in, capa);
        int reads;
        try {
			while ((reads = bin.read(data, 0, capa)) != -1) {
				out.write(data, 0, reads);
			}
		} catch (IOException e) {
			logger.error("AILicenseCheck #1120 " + e);
		}

        return out.toString(); 
    }
	
}
%>
