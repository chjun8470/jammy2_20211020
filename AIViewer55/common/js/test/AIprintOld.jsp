<%@page import="com.activeintra.manager.*"%>
<%@ page language="java" contentType="application/pdf; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.io.*, java.net.*" %>
    
<%@ page import="org.apache.log4j.Logger" %>
    
<%!


	final Logger logger = Logger.getLogger("AIprint.jsp");
	String charSet=null;

	private BufferedInputStream getPdfFile(String filename) throws Exception {
		BufferedReader  reader = null;
		BufferedInputStream bis = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(filename));
			
		} catch (Exception e) {
			logger.error("#9010 pdffile open error");
			logger.error("#9020 " + e);
			throw new Exception(e);
		}
		
		return bis;
	}

	private String toKor(String s){
		if(s==null){
			return ""; 
		}
		
		/*
		String charSet="utf-8";
		if(System.getProperty("file.encoding").toLowerCase().equals("ms949"))
			charSet="8859_1";
		else if(System.getProperty("file.encoding").toLowerCase().equals("euc-kr"))
			charSet="8859_1";
		else if(System.getProperty("file.encoding").toLowerCase().equals("utf-8"))
			charSet="utf-8";
		*/
		
		try{ 
			return new String(s.getBytes(charSet),"UTF-8");
		}catch(Exception e){
			return s;
		} 
	}
	
	public byte[] readStreamAll(InputStream in){
	       
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
			logger.error("#9030 " + e);
		}

        return out.toByteArray();
    }
%>

<%
	try { 
		
		AIScriptManager manager = new AIScriptManager(request, response, pageContext, out, logger, null);
		
		charSet=AIScriptManager.aiProps.getProperties("charSetEncoding");
		
		if(charSet==null)
			charSet="8859_1";

		String reportParams="";
		String reportMode=toKor(request.getParameter("reportMode"));
		String reportFlag=toKor(request.getParameter("reportFlag"));
		
		if(!reportFlag.equals("pdfserversave")){
			out.clear();
			out=pageContext.pushBody();
		}

		Properties props = new Properties();
		String filename = request.getParameter("nameTag");
		String requestMethod;

		if(filename==null){
			
			StringBuffer parameter=new StringBuffer();
			StringBuffer getParameter=new StringBuffer();
			filename = request.getParameter("key");
			
			filename=new String(com.activeintra.util.AIEncryptor.decryptBytes(com.activeintra.util.Base64.decode(filename.getBytes())));
			FileInputStream fis=null;
			
			try{
				
				fis = new FileInputStream(filename);
	            props.load(new java.io.BufferedInputStream(fis));
	           
	            Enumeration enumeration = props.keys();  
	            while (enumeration.hasMoreElements()) {  
	             	String key = (String) enumeration.nextElement();
	             	if(!key.startsWith("param_"))
	            	 	continue;
	             	if(key.indexOf("reportMode") != -1)
	             		continue;
	             	if(key.indexOf("reportParams") != -1){
	             		reportParams=(String) props.get(key);
	             		continue;
	             	}
	             
	             	parameter.append(String.format("%s=%s&", key.substring(6),(String) props.get(key)));
	             	
	             	//logger.error("#8888 " +  key + " " + toKor((String) props.get(key)));
	             	//logger.error("#8888 " +  key + " " + (String) props.get(key));
	             	
	             	getParameter.append(String.format("%s=%s&", key.substring(6),URLEncoder.encode(toKor((String) props.get(key)),"utf-8")));
	             	
	            } 
	            
			}
			catch(Exception e){
				logger.error("#9040 " + e);
				return;
			}
			finally{
				if(fis!=null) fis.close();
			}

			if(parameter.length() == 0)
				parameter.append("parameterDummey=nothing&");
			if(getParameter.length() == 0)
				getParameter.append("parameterDummey=nothing&");
			
			//filename=(String) props.getProperty("url") + "?reportMode=PDF&reportParams=pdfserversave:true";
			filename= request.getParameter("url");
			
			//charSet=(String) props.getProperty("charSet");
			requestMethod=(String) props.getProperty("parameterTranferMethod");
			
			if(requestMethod.toUpperCase().equals("GET")){
				reportParams=toKor(reportParams);
				
				if(reportFlag.equals("pdfserversave")){
					//인쇄
					if(reportParams.equals(""))
						filename=filename + "?reportMode=" + reportMode + "&reportFlag=pdfserversave&" +  getParameter.toString() + "reportParams=pdfserversave:true";
					else
						filename=filename + "?reportMode=" + reportMode + "&reportFlag=pdfserversave&" +  getParameter.toString() + "reportParams=" + URLEncoder.encode(reportParams,"utf-8") + ",pdfserversave:true";
				}
				else{
					//변환저장
					if(reportParams.equals(""))
						filename=filename + "?reportMode=" + reportMode + "&" +  getParameter.toString().substring(0, getParameter.length()-1);
					else
						filename=filename + "?reportMode=" + reportMode + "&" +  getParameter.toString() + "reportParams=" +  URLEncoder.encode(reportParams,"utf-8");
				}
			}
			
			//logger.error("#9040 " + "parameter=" + parameter);
			//logger.error("#9050 " + "url" + filename);
			
			HttpURLConnection conn = null;
			conn = (HttpURLConnection) new URL(filename).openConnection();
			
			if(!requestMethod.toUpperCase().equals("GET"))
				conn.setRequestMethod("POST");
			else
				conn.setRequestMethod("GET");
			
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=" + "utf-8");
			conn.setRequestProperty("user-agent", request.getHeader("user-agent"));
		
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			
			//logger.error(request.getHeader("user-agent"));
			
			if(request.getCookies()!=null){
				
				Iterator<Cookie> iHeader = java.util.Arrays.asList(
						request.getCookies()).iterator();
 
				StringBuffer buf = new StringBuffer();
				while (iHeader.hasNext()) {
	
					Cookie cookie = (Cookie) iHeader.next();
	     
					if (!cookie.getValue().equals("")) {
						buf.append(cookie.getName());
						buf.append("=");
						buf.append(cookie.getValue());
						buf.append("; ");
					}
				}
			
				//errorLogging("set Cookies : " + buf.toString());
				conn.setRequestProperty("Cookie", buf.toString());
					
			}
			
			if(!requestMethod.toUpperCase().equals("GET")){
				PrintWriter pw=new PrintWriter(new OutputStreamWriter(conn.getOutputStream(),"utf-8"));
				if(reportFlag.equals("pdfserversave")){
					//인쇄
					if(reportParams.equals(""))
						pw.write("reportMode=" + reportMode + "&reportFlag=pdfserversave&" + parameter.toString().substring(0, parameter.length()) + "reportParams=pdfserversave:true");
					else
						pw.write("reportMode=" + reportMode + "&reportFlag=pdfserversave&" + parameter.toString().substring(0, parameter.length()) + "reportParams=" + reportParams + ",pdfserversave:true");
				}
				else{
					//변환저장 
					if(reportParams.equals(""))
						pw.write("reportMode=" + reportMode + "&" + parameter.toString().substring(0, parameter.length()-1));
					else
						pw.write("reportMode=" + reportMode + "&" + parameter.toString().substring(0, parameter.length()) + "reportParams=" + reportParams );
				}
				
				//pw.write("reportMode=PDF" + "&" + parameter.toString().substring(0, parameter.length()-1));
				pw.flush();
				pw.close();
				
				logger.error("#9050 " + "parameter=" + parameter);
				
			}
			
			int resultCode = conn.getResponseCode();
			if (resultCode != 200) { // 보고서 호출 결과가 성공이 아닌 경우
				logger.error("#9050 " + "url request responded with code[" + resultCode + "]");
				return;
			}
			
			if(!reportFlag.equals("pdfserversave")){
				
				//logger.error("#999999 " +conn.getHeaderField("Content-Disposition"));
				
				response.setHeader("Content-Disposition", conn.getHeaderField("Content-Disposition")); 
				response.setHeader("Content-Description", "JSP Generated Data"); 
				response.setContentType(conn.getContentType());
				
				java.io.BufferedOutputStream outs = new java.io.BufferedOutputStream(response.getOutputStream());
				
				byte[] data=readStreamAll(conn.getInputStream());

				outs.write(data);
				outs.flush();
				outs.close();
				
			}
			else{
				String data=new String(readStreamAll(conn.getInputStream()),"utf-8");
				out.print(data);
			}
			
			return;
			
		}
		
		filename=new String(com.activeintra.util.AIEncryptor.decryptBytes(com.activeintra.util.Base64.decode(filename.getBytes())));
		//filename=toKor(filename);
		logger.error("#999999 " +filename);
		
		response.setContentType("application/pdf");
		java.io.BufferedOutputStream outs = new java.io.BufferedOutputStream(response.getOutputStream());
		BufferedInputStream reader = getPdfFile(filename);
		
		byte[] b = new byte[1024];
		
		int read = 0;
		while( (read = reader.read(b)) != -1){
		
			outs.write(b,0,read);	
		}
		
		outs.close();
		reader.close();
	
	}
	catch(Exception e){
		logger.error("#9060 " + e);
	}
	

%>
