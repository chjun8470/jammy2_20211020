<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.activeintra.manager.*" %>
<%@ page import="com.activeintra.url.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.apache.log4j.PropertyConfigurator" %>

<%
Object[] userObj = null;

ReportHandler handler = new ReportHandler(pageContext,request,response,userObj);
handler.service(out);
handler = null;
%>

<%!
private Logger logger = Logger.getLogger("fileDelete.jsp");
class ReportHandler{

	private Object[] userObj = null;
	

	private HttpServletRequest request;
	private HttpServletResponse response;
	private PageContext pageContext;
	private JspWriter out;

	private AIScriptManager manager;
	
	//ReportHandler 생성자 함수
	ReportHandler(PageContext pageContext,HttpServletRequest request,HttpServletResponse response,Object[] userObj){
		this.pageContext=pageContext;
		this.request=request;
		this.response=response;
		this.userObj=userObj;
	}

	//ReportHandler 서비스 함수
	void service(JspWriter out) throws Exception{
		
		Calendar cal = Calendar.getInstance();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd hh:mm:ss");
    	TimeZone timezone = sdf.getTimeZone();
    	timezone = TimeZone.getTimeZone("GMT+9");
    	sdf.setTimeZone(timezone);
		
		int totalDeleteCount=0;
		try{ 
			manager = new AIScriptManager(request, response, pageContext, out, logger, null);

			//pdf 삭제
			totalDeleteCount=manager.temporaryFileDelete(manager.aiURL.getPdfPath());
			
			//image 삭제
			totalDeleteCount+=manager.temporaryFileDelete(manager.aiURL.getImagePath());
			
			logger.debug(totalDeleteCount + " file deleted ");
			
		}catch(Exception e){
			out.print("file delete error");
			out.print("\r\n");
		}finally{
			out.print(sdf.format(cal.getTime()));
			out.print("\r\n");
			out.print(totalDeleteCount + " file deleted ");
			out.print("\r\n");
		}    
	}
}
%>