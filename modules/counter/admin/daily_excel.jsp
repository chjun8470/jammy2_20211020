<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt_rt" %>
<%  
  String file_name ="daily_excel";
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
사이트 명 : <c:out value="${siteInfoVO.siteNm}"/> / 기간 : <c:out value="${searchCounterDayVO.startDate}"/> ~ <c:out value="${searchCounterDayVO.endDate}"/>
<table class="table">
	<colgroup>
		<col style="width:150px;" />
		<col />
		<col />
	</colgroup>				
	<thead>
		<tr>
			<th scope="col">일별</th>
			<th scope="col">페이지뷰</th>
			<th scope="col">방문자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<fmt_rt:formatNumber var="percentHits" value="${result.hits == 0 ? 0 : (result.hits / sumHits * 100)}" maxFractionDigits="1" />
		<fmt_rt:formatNumber var="percentUniqHits" value="${result.uniqHits == 0 ? 0 : (result.uniqHits / sumUniqHits * 100)}" maxFractionDigits="1" />	
		<tr>
			<td>${result.countDe}</td>
			<td>						
				페이지뷰 : <fmt_rt:formatNumber value="${result.hits}" groupingUsed="true" /> / ${percentHits}%
			</td>
			<td>
				방문자 : <fmt_rt:formatNumber value="${result.uniqHits}" groupingUsed="true" /> / ${percentUniqHits}%
			</td>
		</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>	
			<td>전체</td>
			<td><fmt_rt:formatNumber value="${sumHits}" groupingUsed="true" /></td>
			<td><fmt_rt:formatNumber value="${sumUniqHits}" groupingUsed="true" /></td>
		</tr>
	</tfoot>
</table>
</body>
</html>