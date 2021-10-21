<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt_rt" %>
<%  
  String file_name ="content_satisfaction_excel";
  String ExcelName  = new String(file_name.getBytes(),"UTF-8")+".xls";
  response.setContentType("application/vnd.ms-excel");
  response.setHeader("Content-Disposition", "attachment; filename="+ExcelName);
  response.setHeader("Content-Description", "JSP Generated Data");
  response.setHeader("Pragma", "no-cache");    
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="keywords" content="">
	<meta name="description" content="">	
</head>
<body>
<table border="1">					
	<thead>
		<tr>
			<th scope="col" class="text-center">메뉴명</th>
			<th scope="col" class="text-center">매우만족</th>
			<th scope="col" class="text-center">만족</th>
			<th scope="col" class="text-center">보통</th>
			<th scope="col" class="text-center">불만</th>
			<th scope="col" class="text-center">매우불만</th>
			<th scope="col" class="text-center">전체참여자</th>
			<th scope="col" class="text-center">평균</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<fmt_rt:formatNumber var="stsfdg10percent" value="${result.stsfdg10Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg10Count * 100)}" maxFractionDigits="1" />
		<fmt_rt:formatNumber var="stsfdg8percent" value="${result.stsfdg8Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg8Count * 100)}" maxFractionDigits="1" />
		<fmt_rt:formatNumber var="stsfdg6percent" value="${result.stsfdg6Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg6Count * 100)}" maxFractionDigits="1" />
		<fmt_rt:formatNumber var="stsfdg4percent" value="${result.stsfdg4Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg4Count * 100)}" maxFractionDigits="1" />
		<fmt_rt:formatNumber var="stsfdg2percent" value="${result.stsfdg2Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg2Count * 100)}" maxFractionDigits="1" />
		<fmt_rt:formatNumber var="average" value="${(result.stsfdg10Count * 100 + result.stsfdg8Count * 80 + result.stsfdg6Count * 60 + result.stsfdg4Count * 40 + result.stsfdg2Count * 20) / result.stsfdgTotal}" maxFractionDigits="1" />
		<tr>
			<td><c:out value="${result.menuPath}"/></td>
			<td class="text-center">
				<c:out value="${result.stsfdg10Count}"/>명<br />
				[<c:out value="${stsfdg10percent}"/>%]
			</td>
			<td class="text-center">
				<c:out value="${result.stsfdg8Count}"/>명<br />
				[<c:out value="${stsfdg8percent}"/>%]
			</td>
			<td class="text-center">
				<c:out value="${result.stsfdg6Count}"/>명<br />
				[<c:out value="${stsfdg6percent}"/>%]
			</td>
			<td class="text-center">
				<c:out value="${result.stsfdg4Count}"/>명<br />
				[<c:out value="${stsfdg4percent}"/>%]
			</td>
			<td class="text-center">
				<c:out value="${result.stsfdg2Count}"/>명<br />
				[<c:out value="${stsfdg2percent}"/>%]
			</td>
			<td class="text-center"><c:out value="${result.stsfdgTotal}"/>명</td>
			<td class="text-center"><c:out value="${average}"/>점</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>