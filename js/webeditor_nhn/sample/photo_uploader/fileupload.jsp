<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%

String filePath = "/home/jnspcms/www";

%>
<!DOCTYPE>
<html>
<head>
	<title>Insert title here</title>
</head>
<body>
<%

	String dir = filePath+"/file/webeditor_temp/";
	File desti = new File(dir);
	  //해당 디렉토리의 존재여부를 확인
		if(!desti.exists()){
	  //없다면 생성
		desti.mkdirs();
		}// 업로드되는 실제 경로
	int max =10*1024*1024; // 업로드 파일의 최대 크기 지정
	String originalName ="";
	String saveName ="";
	String callback = "";
	String callback_func = "";
	// 첫번째 매개변수로 요청 request를 입력
	try{
		MultipartRequest mr = new MultipartRequest( request, dir, max, "UTF-8", new DefaultFileRenamePolicy() );
	    String now = new SimpleDateFormat("yyyyMMddHmss").format(new Date());  //현재시간
	    originalName =  mr.getOriginalFileName("Filedata"); //원본파일 이름이다.
	    int i = -1;
        i = originalName.lastIndexOf("."); // 파일 확장자 위치
		//saveName = originalName.substring(0, i)+"_"+now+originalName.substring(i, originalName.length()); //저장될 이름이다.
		saveName = now+originalName.substring(i, originalName.length()); //저장될 이름이다.
		callback = mr.getParameter("callback");
		callback_func = mr.getParameter("callback_func");
		File oldFile = new File(dir + originalName);
		File newFile = new File(dir + saveName);
		oldFile.renameTo(newFile);

	}
	catch(Exception e) {
		e.printStackTrace();
		System.out.print("예외 상황 발생..! ");
	}
	String url = callback + "?callback_func="+callback_func+"&bNewLine=true&sFileName="+saveName+"&sFileURL=/file/webeditor_temp/"+saveName;
	response.sendRedirect(url);

%>
</body>
</html>