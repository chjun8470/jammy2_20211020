<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt_rt" %>
<%  
  String file_name ="hourly_excel";
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
			<th scope="col">시간별</th>
			<th scope="col">페이지뷰</th>
			<th scope="col">방문자</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>00:00 ~ 01:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh0 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh0}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh0 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh0}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>01:00 ~ 02:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh1 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh1}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh1 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh1}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>02:00 ~ 03:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh2 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh2}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh2 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh2}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>03:00 ~ 04:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh3 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh3}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh3 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh3}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>04:00 ~ 05:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh4 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh4}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh4 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh4}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>05:00 ~ 06:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh5 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh5}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh5 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh5}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>06:00 ~ 07:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh6 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh6}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh6 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh6}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>07:00 ~ 08:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh7 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh7}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh7 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh7}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>08:00 ~ 09:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh8 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh8}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh8 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh8}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>09:00 ~ 10:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh9 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh9}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh9 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh9}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>10:00 ~ 11:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh10 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh10}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh10 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh10}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>11:00 ~ 12:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh11 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh11}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh11 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh11}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>12:00 ~ 13:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh12 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh12}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh12 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh12}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>13:00 ~ 14:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh13 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh13}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh13 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh13}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>14:00 ~ 15:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh14 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh14}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh14 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh14}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>15:00 ~ 16:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh15 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh15}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh15 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh15}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>16:00 ~ 17:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh16 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh16}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh16 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh16}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>17:00 ~ 18:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh17 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh17}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh17 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh17}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>18:00 ~ 19:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh18 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh18}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh18 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh18}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>19:00 ~ 20:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh19 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh19}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh19 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh19}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>20:00 ~ 21:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh20 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh20}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh20 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh20}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>21:00 ~ 22:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh21 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh21}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh22 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh21}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>22:00 ~ 23:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh22 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh22}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh22 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh22}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
		<tr>
			<td>23:00 ~ 24:00</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh23 / result.hits * 100)}" maxFractionDigits="1" />								
				페이지뷰 : <fmt_rt:formatNumber value="${result.hh23}" groupingUsed="true" /> / ${countPer}% 
			</td>
			<td>
				<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh23 / result.uniqHits * 100)}" maxFractionDigits="1" />								
				방문자 : <fmt_rt:formatNumber value="${result.uhh23}" groupingUsed="true" /> / ${countPer}%
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>	
			<td>전체</td>
			<td><fmt_rt:formatNumber value="${result.hits}" groupingUsed="true" /></td>
			<td><fmt_rt:formatNumber value="${result.uniqHits}" groupingUsed="true" /></td>
		</tr>
	</tfoot>
</table>
</body>
</html>