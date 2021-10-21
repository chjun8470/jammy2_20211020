<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<form:form commandName="writeBoard" action="?act=write" class="form-horizontal" role="form">		
		<input type="hidden" name="command" value="<c:out value='${command}' />" />
		<input type="hidden" name="returnQueryString" value="<c:out value='${searchBoardVO.queryString}' escapeXml='false' />" />
		
		<c:if test="${command == 'update'}">
		<input type="hidden" name="boardId" value="<c:out value='${searchBoardVO.boardId}' />" />
		</c:if>
		
			<div class="col-lg-12">	
				<div class="block">
					<div class="block-head">
						<h2>게시판 기본정보</h2>
					</div>			
					<div class="block-content">
					<fieldset>
						<legend class="sr-only">기본설정 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="boardId" class="control-label">* 게시판 아이디</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<p class="form-control-static">게시판 아이디는 자동으로 생성됩니다.</p>
									</c:when>
									<c:otherwise>
										<form:input path="boardId" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>		
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="siteId" class="control-label">* 사이트</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:select path="siteId" class="form-control required">
										<form:option value="">+ 사이트 선택</form:option>
										<c:forEach var="result" items="${siteList}" varStatus="status">
										<form:option value="${result.siteId}"><c:out value="${result.siteNm}" /></form:option>
										</c:forEach>
										</form:select>
									</c:when>
									<c:otherwise>
										<form:select path="siteId" class="form-control required" disabled="true">
										<form:option value="">+ 사이트 선택</form:option>
										<c:forEach var="result" items="${siteList}" varStatus="status">
										<form:option value="${result.siteId}"><c:out value="${result.siteNm}" /></form:option>
										</c:forEach>
										</form:select>									
									</c:otherwise>
								</c:choose>								
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="boardNm" class="control-label">* 게시판 명</label></span>
							<div class="col-sm-10">
								<form:input path="boardNm" maxlength="60" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="boardSummary" class="control-label">게시판 썸머리</label></span>
							<div class="col-sm-10">
								<form:input path="boardSummary" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="boardTy" class="control-label">* 게시판 유형</label></span>
							<div class="col-sm-10">
								<form:select path="boardTy" class="form-control required">
								<c:forEach var="result" items="${boardTyList}" varStatus="status">
								<form:option value="${result.code}">[<c:out value="${result.code}"/>] <c:out value="${result.codeNm}" /></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="skinNm" class="control-label">* 스킨</label></span>
							<div class="col-sm-10">
								<form:select path="skinNm" class="form-control">
								<c:forEach var="result" items="${skinList}" varStatus="status">
								<form:option value="${result.dir}"><c:out value="${result.name}"/></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="mobileSkinNm" class="control-label">* 모바일스킨</label></span>
							<div class="col-sm-10">
								<form:select path="mobileSkinNm" class="form-control">
								<c:forEach var="result" items="${skinList}" varStatus="status">
								<form:option value="${result.dir}"><c:out value="${result.name}"/></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="category" class="control-label">카테고리</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><form:checkbox path="useCategoryAt" value="Y" /> 사용</span>									
									<form:input path="category" class="form-control" />
								</div>
								<div class="help-block">
								분류를 콤마(,)로 구분해 주세요. 보기)유머,공포,엽기,무협,기타 
								</div>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="uploadCount" class="control-label">업로드</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<span class="input-group-addon">갯수</span>
									<form:input path="uploadCount" class="form-control digits" />
								</div>
								<div class="input-group mg-t-xs">
									<span class="input-group-addon">사이즈</span>
									<form:input path="uploadSize" class="form-control digits" />
								</div>
								<div class="input-group mg-t-xs">
									<span class="input-group-addon">허용확장자</span>
									<form:input path="uploadExt" class="form-control" />
								</div>								
							</div>
						</div>				
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchBoardVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>
					</fieldset>		
				</div>			
			</div>	
		</div>
		<div class="col-lg-12">	
			<div class="block">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab1" data-toggle="tab">권한설정</a></li>
				    <li><a href="#tab2" data-toggle="tab">고급설정</a></li>
				</ul>			
				<div class="block-content">
					<div class="tab-content mg-t-sm">
						<div class="tab-pane active" id="tab1">					
							<fieldset>
								<legend class="sr-only">권한설정 폼</legend>								
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlList" class="control-label">목록보기 (허용등급)</label></span>
									<div class="col-sm-10">
										<form:select path="permLvlList" class="form-control">
										<form:option value="0">+ 전체허용</form:option>
										<c:forEach items="${levelList}" var="result" varStatus="status">
										<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/></form:option>
										</c:forEach>
										</form:select>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlList" class="control-label"><span class="sr-only">목록보기</span> (차단그룹)</label></span>
									<div class="col-sm-10">
										<c:forEach items="${groupList}" var="result" varStatus="status">
										<label class="checkbox-inline"><form:checkbox path="permGrpListArr" value="${result.groupId}" /><c:out value="${result.groupNm}"/></label>
										</c:forEach>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlRead" class="control-label">상세보기 (허용등급)</label></span>
									<div class="col-sm-10">
										<form:select path="permLvlRead" class="form-control">
										<form:option value="0">+ 전체허용</form:option>
										<c:forEach items="${levelList}" var="result" varStatus="status">
										<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/></form:option>
										</c:forEach>
										</form:select>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlRead" class="control-label"><span class="sr-only">상세보기</span> (차단그룹)</label></span>
									<div class="col-sm-10">
										<c:forEach items="${groupList}" var="result" varStatus="status">
										<label class="checkbox-inline"><form:checkbox path="permGrpReadArr" value="${result.groupId}" /> <c:out value="${result.groupNm}"/></label>
										</c:forEach>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlWrite" class="control-label">글쓰기 (허용등급)</label></span>
									<div class="col-sm-10">
										<form:select path="permLvlWrite" class="form-control">
										<form:option value="0">+ 전체허용</form:option>
										<c:forEach items="${levelList}" var="result" varStatus="status">
										<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/></form:option>
										</c:forEach>
										</form:select>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlWrite" class="control-label"><span class="sr-only">글쓰기</span> (차단그룹)</label></span>
									<div class="col-sm-10">
										<c:forEach items="${groupList}" var="result" varStatus="status">
										<label class="checkbox-inline"><form:checkbox path="permGrpWriteArr" value="${result.groupId}" /> <c:out value="${result.groupNm}"/></label>
										</c:forEach>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlReply" class="control-label">답변 (허용등급)</label></span>
									<div class="col-sm-10">
											<form:select path="permLvlReply" class="form-control">
											<form:option value="0">+ 전체허용</form:option>
											<form:option value="-1">사용안함</form:option>
											<c:forEach items="${levelList}" var="result" varStatus="status">
											<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/></form:option>
											</c:forEach>
											</form:select>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlReply" class="control-label"><span class="sr-only">답변</span> (차단그룹)</label></span>
									<div class="col-sm-10">
										<c:forEach items="${groupList}" var="result" varStatus="status">
										<label class="checkbox-inline"><form:checkbox path="permGrpReplyArr" value="${result.groupId}" /> <c:out value="${result.groupNm}"/></label>
										</c:forEach>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlEditor" class="control-label">에디터사용 (허용등급)</label></span>
									<div class="col-sm-10">
										<form:select path="permLvlEditor" class="form-control">
										<form:option value="0">+ 전체허용</form:option>
										<form:option value="-1">사용안함</form:option>
										<c:forEach items="${levelList}" var="result" varStatus="status">
										<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/></form:option>
										</c:forEach>
										</form:select>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="permLvlEditor" class="control-label"><span class="sr-only">에디터사용</span> (차단그룹)</label></span>
									<div class="col-sm-10">
										<c:forEach items="${groupList}" var="result" varStatus="status">
										<label class="checkbox-inline"><form:checkbox path="permGrpEditorArr" value="${result.groupId}" /> <c:out value="${result.groupNm}"/></label>
										</c:forEach>
									</div>
								</div>
							</fieldset>
						</div>
						<div class="tab-pane" id="tab2">
							<fieldset>
								<legend class="sr-only">고급설정 폼</legend>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="boardAdmin" class="control-label">추가관리자</label></span>
									<div class="col-sm-10">
										<form:input path="boardAdmin" class="form-control" />
										<div class="help-block">
											이 게시판에 대해서 관리자권한을 별도로 부여할 회원이 있을경우 회원아이디를 콤마(,)로 구분해서 등록해 주세요.<br />관리자로 지정될 경우 열람/수정/삭제등의 모든권한을 얻게 됩니다.
										</div>
									</div>
								</div>		
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="showDeletedAt" class="control-label">삭제된 게시글 출력여부</label></span>
									<div class="col-sm-10">
										<form:select path="showDeletedAt" class="form-control">
										<form:option value="Y">출력함</form:option>										
										<form:option value="N">출력안함</form:option>
										</form:select>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="useSecretAt" class="control-label">비밀글</label></span>
									<div class="col-sm-10">
										<form:select path="useSecretAt" class="form-control">
										<form:option value="N">사용안함</form:option>
										<form:option value="C">체크박스</form:option>
										<form:option value="A">무조건</form:option>
										</form:select>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="perPage" class="control-label">* 게시글출력</label></span>
									<div class="col-sm-10">
										<form:input path="perPage" maxlength="6" class="form-control required digits" />
										<div class="help-block">
											한페이지에 출력할 게시물의 수
										</div>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="subjectLen" class="control-label">* 제목끊기</label></span>
									<div class="col-sm-10">
										<form:input path="subjectLen" maxlength="5" class="form-control required digits" />
										<div class="help-block">
											제목이 길 경우 자르기
										</div>										
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="newIconPeriod" class="control-label">* 새글유지기간</label></span>
									<div class="col-sm-10">
										<form:input path="newIconPeriod" maxlength="3" class="form-control required digits" />
										<div class="help-block">
											새글로 인식되는 기간
										</div>											
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="headHtml" class="control-label">상단HTML</label></span>
									<div class="col-sm-10">
										<form:textarea path="headHtml" rows="6" class="form-control" />
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="tailHtml" class="control-label">하단HTML</label></span>
									<div class="col-sm-10">
										<form:textarea path="tailHtml" rows="6" class="form-control" />
									</div>
								</div>
							</fieldset>
						</div>
					</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchBoardVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>
				</div>
			</div>	
		</div>
	</form:form>	
</div>

<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#writeBoard").validate({
		rules: 
		{
			boardNm:{maxlength: 60}
			, boardSummary:{maxlength: 255}
			, category:{maxlength: 255}
			, perPage:{min: 1}
			, subjectLen:{min: 1}
		}
	});
});
//]]>
</script>