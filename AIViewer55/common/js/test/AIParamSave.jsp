<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.net.*,java.util.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.activeintra.manager.*" %>
<%@ page import="org.apache.log4j.Logger" %>

<%!

    final Logger logger = Logger.getLogger("com.activeintra");

    private String getPropertyName(){

        Random rand = new Random();
        int randNum = rand.nextInt();

        StringBuilder prop=new StringBuilder();

        prop.append("param").append(String.format("%d",randNum)).append("-")
                .append(SystemDate("yyMMddhhmmssSSS")).append(".prop");

        //debugLogging("@7010 " + chart);

        return prop.toString();
    }

    private String SystemDate(String dateFormat) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        return sdf.format(cal.getTime());

    }

%>

<%

    try{

        AIScriptManager manager = new AIScriptManager(request, response, pageContext, out, logger, null);
        if(manager.init()){
            //AIReport.properties에서 각종 option을 읽어 AIreqres객체의 각종member에 해당 값을 setting.
            Enumeration keys=AIScriptManager.aiProps.propertyNames();
            while(keys.hasMoreElements()){

                String key=(String)keys.nextElement();
                String value=AIScriptManager.aiProps.getProperties(key);
                manager.reqres.setParam(key,value);

            }

            String propertyName=getPropertyName();
            String fullPropertyName=AIScriptManager.aiURL.getPdfPath() + propertyName;
            File profile = new File(fullPropertyName);
            FileOutputStream fos=null;

            Properties prop = new Properties();
            try{
                if(!profile.exists()) profile.createNewFile();
                fos=new FileOutputStream(profile);

            }
            catch(IOException e){
                logger.error("2010 " + e);
                throw new Exception(e);
            }
            finally{

            }

            if(manager.reqres.getParameterDecoder()==null) {

                Map map = manager.reqres.getRequest().getParameterMap();
                Iterator iterator = map.keySet().iterator();

                while (iterator.hasNext()) {
                    String key = (String) iterator.next();
                    String[] values = (String[]) map.get(key);

                    if (values[0] == null) {
                        logger.error("#2011 " + key + " value is null");
                        continue;
                    }
                    prop.setProperty("param_" + key, values[0]);
                }
                prop.setProperty("HttpParameterDecoder","false");

            }
            else{
                Enumeration enu=manager.reqres.getParameterNames();

                while (enu.hasMoreElements()){
                    String key=(String) enu.nextElement();
                    String value=manager.reqres.getParameterB(key);

                    prop.setProperty("param_" + key, value);
                }
                prop.setProperty("HttpParameterDecoder","true");

            }

            // post관련
            prop.setProperty("url",manager.reqres.getURL2() + manager.reqres.getRequest().getRequestURI());
            String parameterTranferMethod="";
            parameterTranferMethod=manager.reqres.getRequest().getMethod();
            if(parameterTranferMethod==null)
                parameterTranferMethod="GET";
            parameterTranferMethod=parameterTranferMethod.toUpperCase();
            prop.setProperty("parameterTranferMethod", parameterTranferMethod);

            if(AIScriptManager.aiProps.getProperties("charSetEncoding") == null)
                prop.setProperty("charSetEncoding","utf-8");
            else
                prop.setProperty("charSetEncoding",AIScriptManager.aiProps.getProperties("charSetEncoding"));

            prop.store(fos, "AIParamSave make");
            fos.close();

            propertyName = AICipherAES128.encrypt(propertyName);
            out.print("{\"target\": \"" + propertyName + "\"}");

        }
        else{
            logger.error("#8888 " + "manager init error");
            throw new Exception("manager init error");
        }

    }
    catch(Exception e){
        logger.error("#9999 " + e);
    }
    finally{

    }

%>
