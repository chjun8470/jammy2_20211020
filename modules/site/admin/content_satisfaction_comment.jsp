<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1><c:out value="${siteMenuVO.menuNm}" /> 페이지 만족도 의견</h1>
			</div>
			<div class="block-content">
				<table class="table">
					<colgroup>
						<col style="width:150px;" />
						<col />
						<col style="width:150px;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="text-center">날짜</th>
							<th scope="col" class="text-center">의견</th>
							<th scope="col" class="text-center">작성자</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${result.registPnttm}"/></td>
							<td><c:out value="${result.stsfdgCn}"/></td>
							<td class="text-center">
								<c:out value="${result.wrterNm}"/>(<c:out value="${result.wrterId}"/>)
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="3" class="text-center"><spring:message code="info.nodata.msg"/></td>  
						</tr>		 
					</c:if>	
					</tbody>					
				</table>
			</div>
		</div>
	</div>
</div>