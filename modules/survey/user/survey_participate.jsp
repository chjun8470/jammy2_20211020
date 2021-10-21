<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<table class="table table-bordered">
<tbody>
	<tr>
		<th scope="row">제목</th>
		<td><c:out value='${surveyVO.title}'/></td>
	</tr>
	<tr>
		<th scope="row">설문기간</th>
		<td><c:out value='${surveyVO.bgnde}'/> ~ <c:out value='${surveyVO.endde}'/></td>
	</tr>
	<tr>
		<th scope="row">참여인원</th>
		<td><c:out value='${surveyVO.voteCnt}'/>명</td>
	</tr>
	<tr>
		<th scope="row">내용</th>
		<td><c:out value='${jmy:nl2br(surveyVO.content)}' escapeXml='false'/></td>
	</tr>	
	<tr>
		<th scope="row">진행상태</th>
		<td>
			<c:choose>
				<c:when test="${surveyVO.progress == 'ING'}">진행</c:when>
				<c:when test="${surveyVO.progress == 'PRE'}">중비중</c:when>
				<c:otherwise>종료</c:otherwise>
			</c:choose>		
		</td>
	</tr>	
</tbody>
</table>


<form action="?act=participate" method="post" onsubmit="return validate(this);">
<input type="hidden" name="srvyId" value="${surveyVO.srvyId}" />
<input type="hidden" name="returnQueryString" value="<c:out value='${searchSurveyVO.queryString}' escapeXml='false' />"/>

				<c:forEach items="${surveyQuestionList}" var="question" varStatus="i">
					<div class="item">
						<h5><c:out value='${(i.index + 1)}'/>. <c:out value='${question.qstnTitle}' /></h5>
						<c:if test="${question.qstnTy == 'B' || question.qstnTy == 'E'}">
						<c:out value='${question.minChkedNum}'/>개 이상 선택해 주세요.
						</c:if>
						<div class="exampleList">
							<c:if test="${question.qstnTy == 'C'}">
								<textarea name="sa_<c:out value='${question.srvyQstnId}' />" class="answer_remarks_<c:out value='${question.srvyQstnId}' />" cols="100" rows="5"></textarea>
							</c:if>
							<c:if test="${question.qstnTy != 'C'}">
								<ul>
									<c:forEach items="${question.exampleList}" var="example" varStatus="k">
									<li>
										<c:if test="${question.qstnTy == 'A' || question.qstnTy == 'D'}"><input type="radio" name="ma_<c:out value='${question.srvyQstnId}' />" class="answers_<c:out value='${question.srvyQstnId}' />" value="<c:out value='${example.srvyExId}' />" /></c:if>
										<c:if test="${question.qstnTy == 'B' || question.qstnTy == 'E'}"><input type="checkbox" name="ma_<c:out value='${question.srvyQstnId}' />" class="answers_many_<c:out value='${question.srvyQstnId}' />" value="<c:out value='${example.srvyExId}' />" /></c:if>
										<c:out value='${example.exTitle}' />
														
										<c:if test="${question.qstnTy == 'D' || question.qstnTy == 'E'}">
											<c:if test="${(k.index + 1) == fn:length(question.exampleList)}">
											<div><textarea name="ma_<c:out value='${question.srvyQstnId}' />n<c:out value='${example.srvyExId}' />" class="answer_remarks_<c:out value='${question.srvyQstnId}' />" cols="100" rows="5"></textarea></div>
											</c:if>
										</c:if>
									</li>
									</c:forEach>
								</ul>			
							</c:if>
						</div>
					</div>
				</c:forEach>
	<button type="submit" class="btn btn-default">투표하기</button>
</form>

<script type="text/javascript">
//<![CDATA[
function validate(f)
{
	var question = new Array();
	
	<c:forEach items="${surveyQuestionList}" var="question" varStatus="i">
		<c:if test="${(question.qstnTy == 'A' || question.qstnTy == 'D') && question.requiredYn == 'Y'}">
		checked = $('input[class="answers_<c:out value='${question.srvyQstnId}'/>"]').is(":checked");
		if (checked == false)
		{
			alert("[<c:out value='${question.qstnTitle}'/>] 질문에 대한 사항을 선택해 주세요");
			return false;	
		}  	
		</c:if>
		<c:if test="${question.qstnTy == 'C' && question.requiredYn == 'Y'}">
		value = $('textarea[class="answer_remarks_<c:out value='${question.srvyQstnId}'/>"]').val();
		if (value == '')
		{
			alert("[<c:out value='${question.qstnTitle}'/>] 질문에 대한 사항을 입력해 주세요");
			return false;	
		}  	
		</c:if>
		<c:if test="${(question.qstnTy == 'B' || question.qstnTy == 'E') && question.requiredYn == 'Y' && question.minChkedNum > 1}">
		checked_num = eval($('input[class="answers_many_<c:out value='${question.srvyQstnId}'/>"]:checked').length);
		if (checked_num < <c:out value='${question.minChkedNum}'/>)
		{
			alert("[<c:out value='${question.qstnTitle}'/>] 질문에 대한 사항을 <c:out value='${question.minChkedNum}'/>개 이상 선택해 주세요");
			return false;	
		}  	
		</c:if>
	</c:forEach>
	
	return true;
}
//]]>
</script>