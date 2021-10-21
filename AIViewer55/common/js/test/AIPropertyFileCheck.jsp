<%@ page language="java" contentType="image/png; charset=UTF-8"
    pageEncoding="euc-kr" import="java.util.*, java.io.*, java.net.*" %>
    
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="com.activeintra.manager.*"%>

<%!

	final Logger logger = Logger.getLogger("com.activeintra");

    private InputStream findResourceStream(String startDir, String fileName,
                                           ServletContext context) {
        Set<String> dir = context.getResourcePaths(startDir);
        if (dir == null) return null; // empty

        List<String> list = new ArrayList<String>(dir.size());
        for (String path : dir) {
            if (path.endsWith(fileName)) {
                return (context.getResourceAsStream(path));
            }
            if (path.charAt(path.length()-1) == '/') { // 디렉토리 by API spec.
                list.add(path);
            }
        }

        for (String subDir : list) {
            InputStream in = findResourceStream(subDir, fileName, context);
            if (in != null) return in;
        }

        return null;
    }

%>

<%

	ServletContext context = pageContext.getServletContext();
	Properties props = new Properties();

	InputStream in=null;
	
	try{
		
		in = findResourceStream("/WEB-INF/", "AIReport.properties", context);
		if(in==null)
			out.print("read error...");
		else
			props.load(in);
	}
	catch(Exception e){
		logger.error("AIProperties #1101 " + e);
	}
	finally{
		if(in!=null)
			in.close();
	}
	
	out.print("installPath:" + props.getProperty("installPath") + "\r\n");
	out.print("printCallTag:" + props.getProperty("printCallTag") + "\r\n");
	out.print("flashCallTag:" + props.getProperty("flashCallTag") + "\r\n");
	

%>