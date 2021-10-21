<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="java.util.*, java.io.*, java.net.*" %>

<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="com.activeintra.manager.*"%>

<%!

    final Logger logger = Logger.getLogger("com.activeintra");

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
        finally{

        }
        return out.toByteArray();
    }

%>

<%
    //request.setCharacterEncoding("utf-8");
    try {

        AIScriptManager manager = new AIScriptManager(request, response, pageContext, out, logger, null);

        boolean isGet;
        String method=request.getMethod();
        if(method==null)
            method="GET";
        if(method.toUpperCase().equals("POST"))
            isGet=false;
        else
            isGet=true;
        String filename = request.getParameter("param");
        String viewerParams = manager.getViewerParams56(filename, isGet);

        out.println(viewerParams);

    }
    catch(Exception e){
        logger.error("#9999 " + e);
    }
    finally{

    }

%>
