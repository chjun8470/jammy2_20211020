<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


		
			<div class="block-head">
				<h1>항목 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeSurveyQuestion" action="?act=qwrite" class="form-horizontal" role="form">
					<input type="hidden" name="returnQueryString" value="act=qlist&srvyId=<c:out value='${searchSurveyQuestionVO.srvyId}'/>"/>
					<input type="hidden" name="command" value="<c:out value='${command}' />" />				
					<input type="hidden" name="srvyId" value="<c:out value='${searchSurveyQuestionVO.srvyId}'/>"/>
					<c:if test="${command == 'update'}">
					<input type="hidden" name="srvyQstnId" value="<c:out value='${searchSurveyQuestionVO.srvyQstnId}'/>"/>
					</c:if>
					
					<fieldset>
						<legend class="sr-only">항목 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="position" class="control-label">* 순서</label></span>
							<div class="col-sm-10">
								<form:input path="position" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">질문유형</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="qstnTy" value="A" />다지선다형(단일선택)</label>
								<label class="radio-inline"><form:radiobutton path="qstnTy" value="B" />다지선다형(복수형)</label>
								<label class="radio-inline"><form:radiobutton path="qstnTy" value="C" />주관식</label>
								<label class="radio-inline"><form:radiobutton path="qstnTy" value="D" />기타형(단일선택,주관식)</label>
								<label class="radio-inline"><form:radiobutton path="qstnTy" value="E" />기타형(복수선택,주관식)</label>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="qstnTitle" class="control-label">* 질문내용</label></span>
							<div class="col-sm-10">
								<form:input path="qstnTitle" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">필수선택(작성)여부</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="requiredYn" value="Y" />필수선택</label>
								<label class="radio-inline"><form:radiobutton path="requiredYn" value="N" />필수선택아님</label>
							</div>
						</div>
						<div class="form-group" id="_layer_min_chked_num">
							<span class="col-sm-2 text-right"><label for="minChkedNum" class="control-label">※ 복수선택인 경우</label></span>
							<div class="col-sm-10">
								<form:input path="minChkedNum" class="form-control required" />
							</div>
						</div>
						<div class="form-group" id="_layer_example_list">
							<span class="col-sm-2 text-right"><label class="control-label">예문입력</label></span>
							<div class="col-sm-10">
								<ul id="_example_list" class="list-group">							
								<c:forEach var="result" items="${surveyExampleList}" varStatus="status">
								<li class="list-group-item">
									<div class="input-group">
										<input type="hidden" name="ex_ids" value="<c:out value='${result.srvyExId}'/>" />
										<input type="text" name="ex_titles" class="form-control" value="<c:out value='${result.exTitle}'/>" />
										<span class="input-group-btn">										
											<button type="button" class="btn btn-default btn-xs _del_example"><spring:message code="common.delete" /></button>
                                        </span>										
									</div>
								</li>
								</c:forEach>
								</ul>
								<div class="mg-t-xs">
									<button type="button" id="_add_example" class="btn btn-default btn-xs"/>예문 추가</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary"><i class="fa fa-pencil"></i> <spring:message code="common.save" /></button>
								<a href="?act=qlist&amp;srvyId=<c:out value='${searchSurveyQuestionVO.srvyId}'/>" class="btn btn-default"><i class="fa fa-list"></i> <spring:message code="common.reset" /></a>
							</div>
						</div>						
					</fieldset>
				</form:form>			
			</div>
		


<script type="text/javascript"> 
//<![CDATA[
$(function()
{
	$("#writeSurveyQuestion").validate();
		
	function set_qstn_ty(val)
	{
		$('#_layer_min_chked_num').hide();
		$('#_layer_example_list').hide();
		if (val == 'B' || val == 'E')
		{
			$('#_layer_min_chked_num').show();
		}
		if (val != 'C')
		{
			$('#_layer_example_list').show();
		}
	}
	
	$(document).on('change', 'input[name="qstnTy"]', function()
	{
		set_qstn_ty($(this).val());
	});
	
	set_qstn_ty('<c:out value='${writeSurveyQuestion.qstnTy}'/>')
	
	
	$(document).on('click', '#_add_example', function()
	{
		html = '<li class="list-group-item">';
		html+= '	<div class="input-group">';
		html+= '		<input type="hidden" name="ex_ids" value="" />';
		html+= '		<input type="text" name="ex_titles" class="form-control" value="" />';
		html+= '		<span class="input-group-btn">';
		html+= '			<button type="button" class="btn btn-default btn-xs _del_example">삭제</button>';
		html+= '		</span>';
		html+= '	</div>';
		html+= '</li>';
		$('#_example_list').append(html);
	});
	
	$(document).on('click', '._del_example', function()
	{
		$(this).parent().parent().parent().remove();
	});
});
//]]>
</script>