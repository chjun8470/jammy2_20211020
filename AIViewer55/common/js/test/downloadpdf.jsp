<%@ page language="java" contentType="application/pdf; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*, java.io.*" %>
    
<%!

//트정 문자가 포함된 Stream 만 추출
	private BufferedInputStream extractionWord(){
		BufferedReader  reader = null;
		BufferedInputStream bis = null;
		try {
			bis = new BufferedInputStream(new FileInputStream("C:\\log\\aaa.pdf"));
			reader =  new BufferedReader ( new InputStreamReader ( new FileInputStream("C:\\TEMP\\pdftest\\test.pdf"), "euc-kr" ));
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return bis;
	}

%>

<%

java.io.BufferedOutputStream outs = new java.io.BufferedOutputStream(response.getOutputStream());
BufferedInputStream reader = extractionWord();
String tmp;
byte[] b = new byte[1024];

int read = 0;
while( (read = reader.read(b)) != -1){

	outs.write(b,0,read);	
}

outs.close();
reader.close();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="application/pdf; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
</body>
</html>