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

    try {

        out.clear();
        out=pageContext.pushBody();

        AIScriptManager manager = new AIScriptManager(request, response, pageContext, out, logger, null);

        String requestMethod = request.getMethod();
        if (requestMethod == null)
            requestMethod = "GET";

        String filename = request.getParameter("param");
        //시큐어 코딩 관련
        //특수문자열("../") 포함여부 체크
        //실제 의미없슴다.
        /*
        if(filename.contains("..") || filename.contains("/")){
            String error=String.format("#9091 parameter bad : %s",filename);
            logger.error(error);
            throw new Exception(error);
        }
        */

        String reportUrl = manager.getReportUrl2(filename);

        String domainName = AIScriptManager.aiProps.getProperties("domainName");
        String ipAddress = AIScriptManager.aiProps.getProperties("ipAddress");
        if (domainName != null && ipAddress != null)
            reportUrl = reportUrl.replace(domainName, ipAddress);

        //logger.error("#9040 " + "reportUrl " + reportUrl);

        String splitUrl[] = reportUrl.split("/");
        StringBuilder realUrl = new StringBuilder();
        for (int i = 3; i < splitUrl.length; i++) {
            realUrl.append("/");
            realUrl.append(splitUrl[i]);
        }

        if (AIScriptManager.aiProps.getProperties("domainNameToLocalIpAddress") != null &&
                AIScriptManager.aiProps.getProperties("domainNameToLocalIpAddress").equals("false")) {
            reportUrl = reportUrl.replace("https", "http");
        } else {
            String ipAddr = "http://" + "127.0.0.1:" + request.getLocalPort();
            reportUrl = ipAddr + realUrl;
        }

        //urlConnection구간 시작
        HttpURLConnection conn;
        conn = (HttpURLConnection) new URL(reportUrl).openConnection();
        if (!requestMethod.toUpperCase().equals("GET"))
            conn.setRequestMethod("POST");
        else
            conn.setRequestMethod("GET");

        String userAgent = request.getHeader("user-agent");

        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=" + "utf-8");
        conn.setRequestProperty("user-agent", userAgent);

        conn.setUseCaches(false);
        conn.setDoOutput(true);
        conn.setDoInput(true);

        if (request.getCookies() != null) {

            Iterator<Cookie> iHeader = java.util.Arrays.asList(
                    request.getCookies()).iterator();

            StringBuilder buf = new StringBuilder();
            while (iHeader.hasNext()) {

                Cookie cookie = iHeader.next();

                if (!cookie.getValue().equals("")) {
                    buf.append(cookie.getName());
                    buf.append("=");
                    buf.append(cookie.getValue());
                    buf.append("; ");
                }
            }

            conn.setRequestProperty("Cookie", buf.toString());

        }

        if (!requestMethod.toUpperCase().equals("GET")) {

            String parameter = manager.getReportParameters(filename, "UTF-8");
            PrintWriter pw = new PrintWriter(new OutputStreamWriter(conn.getOutputStream(), "utf-8"));

            pw.write(parameter);
            pw.flush();
            pw.close();

            //logger.error("#9050 " + "parameter " + parameter);

        }


        int resultCode = conn.getResponseCode();
        if (resultCode != 200) { // 보고서 호출 결과가 성공이 아닌 경우
            logger.error("#9060 " + "url request responded with code[" + resultCode + "]");
            logger.error("#9061 " + "url=[" + reportUrl + "]");

            response.setContentType("text/html; charset=UTF-8");
            BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
            outs.write("#9060 처리중 에라가 발생하였습니다...\n".getBytes("utf-8"));
            outs.write(String.format("error code : %d", resultCode).getBytes("utf-8"));
            outs.flush();
            outs.close();

            return;
        }

        /*
        String headerString=conn.getHeaderField("Content-Disposition");
        if(headerString==null || headerString.equals("")){
            logger.error("#9091 " + "headerString no value...");
            return;
        }

        //외부 입력값의 null 여부를 체크하고, 해더값이 두 개로 나누어 지는 것을 방지하기
        //위해 replaceAll()을 이용하여 개행문자를 제거합니다.
        headerString=headerString.replaceAll("\r","").replaceAll("\n","");

        response.setContentType(conn.getContentType());
        String result="success";
        if(conn.getContentType().indexOf("text/html")!=-1)
            result="fail";
        else
            response.setHeader("Content-Disposition",headerString);
            */

        response.setHeader("Content-Disposition",conn.getContentType());

        java.io.BufferedOutputStream outs = new java.io.BufferedOutputStream(response.getOutputStream());

        byte[] data=readStreamAll(conn.getInputStream());
        response.setContentLength(data.length);

        outs.write(data);
        outs.flush();
        outs.close();

        //urlConnection구간 end

    }
    catch(Exception e){
        logger.error("#9999 " + e);
    }
    finally{

    }

%>
