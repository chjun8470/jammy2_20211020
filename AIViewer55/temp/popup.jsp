<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
var print = function() {
	index = aireport.PDFPrint();
}
var pdf = function() {
	index = aireport.PDFConvert();
}
var excel = function() {
	index = aireport.ExcelConvert();
}
var hwp = function() {
	index = aireport.hwpConvert();
}
</script>
</head>
<body>
<input type="button" value="print" onclick="print();"/>
<input type="button" value="pdf" onclick="pdf();"/>
<input type="button" value="excel" onclick="excel();"/>
<input type="button" value="hwp" onclick="hwp();"/>

<iframe name="aireport" class="aireport" src="http://localhost:8080/AIViewer55/temp/eqst.jsp?test=2&reportParams=showMenuBar:false" width="100%" height="100%"></iframe>


</body>
</html>