<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<ul class="nav nav-tabs">
			    <li <c:if test="${searchGnrlMemberVO.mberSttus == 'P'}">class="active"</c:if>><a href="?mberSttus=P">회원목록(승인)</a></li>
			    <li <c:if test="${searchGnrlMemberVO.mberSttus == 'A'}">class="active"</c:if>><a href="?mberSttus=A">회원목록(가입대기)</a></li>
			    <li <c:if test="${searchGnrlMemberVO.mberSttus == 'D'}">class="active"</c:if>><a href="?mberSttus=D">회원목록(탈퇴)</a></li>
			    <li><a href="<c:url value='/cms/admin/member/config/gnr.do' />">환경설정</a></li>
			</ul>
			<div class="block-head">
				<h2>회원 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/member/gnrl.do'/>" method="post" class="form-inline" role="form">
					<input type="hidden" name="mberSttus" value="<c:out value='${searchGnrlMemberVO.mberSttus}'/>" />
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="groupId" id="groupId" class="form-control">
							<option value="">+ 그룹선택</option>
							<c:forEach items="${groupList}" var="result" varStatus="status">
							<option value="<c:out value='${result.groupId}'/>" <c:if test="${searchGnrlMemberVO.groupId == result.groupId}">selected="selected"</c:if>><c:out value="${result.groupNm}"/></option>
							</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<select name="levelId" id="levelId" class="form-control">
							<option value="0">+ 등급선택</option>
							<c:forEach items="${levelList}" var="result" varStatus="status">
							<option value="<c:out value='${result.levelId}'/>" <c:if test="${searchGnrlMemberVO.levelId == result.levelId}">selected="selected"</c:if>><c:out value="${result.levelNm}"/></option>
							</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<select name="sexdstnCode" id="sexdstnCode" class="form-control">
							<option value="">+ 성별</option>
							<c:forEach items="${sexdstnCodeList}" var="result" varStatus="status">
							<option value="<c:out value='${result.code}'/>" <c:if test="${searchGnrlMemberVO.sexdstnCode == result.code}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
							</c:forEach>
							</select>
						</div>						
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="mberId" <c:if test="${searchGnrlMemberVO.searchCondition == 'mberId'}">selected="selected"</c:if>>아이디</option>
							<option value="mberNm" <c:if test="${searchGnrlMemberVO.searchCondition == 'mberNm'}">selected="selected"</c:if>>이름</option>
							<option value="telNo" <c:if test="${searchGnrlMemberVO.searchCondition == 'telNo'}">selected="selected"</c:if>>전화번호</option>
							<option value="hpNo" <c:if test="${searchGnrlMemberVO.searchCondition == 'hpNo'}">selected="selected"</c:if>>핸드폰번호</option>
							<option value="email" <c:if test="${searchGnrlMemberVO.searchCondition == 'email'}">selected="selected"</c:if>>이메일</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchGnrlMemberVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/member/gnrl.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
							</span> 
						</div>						
					</fieldset>
				</form>
			</div>
			
			<form name="memberListForm" action="<c:url value='/cms/admin/member/gnrl.do'/>" method="post" class="form-inline">
				<input type="hidden" name="act" value="" />
				<input type="hidden" name="change" value="" />				
				<input type="hidden" name="returnQueryString" value="<c:out value='${searchGnrlMemberVO.queryString}' escapeXml='false' />" />
				<div class="block-content np">
					<table class="table">
						<thead>
							<tr>
								<th scope="col" class="text-center"><input type="checkbox" onclick="set_checkbox(this.form, 'chks', this.checked)" /></th>
								<th scope="col" class="text-center">이름</th>
								<th scope="col" class="text-center">아이디</th>
								<th scope="col" class="text-center">이메일</th>
								<th scope="col" class="text-center">가입일</th>
								<th scope="col" class="text-center">그룹</th>								
								<th scope="col" class="text-center">등급</th>
								<th scope="col" class="text-center">관리</th>
							</tr>
						</thead>
						<tbody>	
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="text-center"><input type="checkbox" name="chks" value="<c:out value='${result.mberId}'/>" /></td>
								<td class="text-center"><c:out value="${result.mberNm}" /></td>
								<td class="text-center"><c:out value="${result.mberId}" /></td>
								<td class="text-center"><c:out value="${result.email}" /></td>
								<td class="text-center"><c:out value="${result.sbscrbDe}" /></td>
								<td class="text-center"><c:out value="${result.groupNm}" /></td>
								<td class="text-center"><c:out value="${result.levelNm}" /></td>
								<td class="text-center">
									<a href="?act=write&amp;mberId=<c:out value='${result.mberId}'/>&amp;<c:out value='${searchGnrlMemberVO.queryString}'/>" class="btn btn-default btn-xs">수정</a>
									<a href="javascript:post_delete('', 'act=delete&mberId=<c:out value="${result.mberId}"/>');" class="btn btn-default btn-xs">삭제</a>							
								</td>		
							</tr>
						</c:forEach>
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="8" class="text-center"><spring:message code="info.nodata.msg"/></td>  
							</tr>		 
						</c:if>	
						</tbody>					
					</table>		
				</div>
				<div class="block-footer">
					<div class="clearfix">
						<div class="pull-left">
							<ul class="pagination pagination-sm">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
							</ul>
						</div>
						<div class="pull-right">
							<c:if test="${empty adminSiteId}">
							<a href="?act=write&amp;<c:out value='${searchGnrlMemberVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-lg pd-r-lg"><spring:message code="common.create"/></a>
							</c:if>
						</div>
					</div>
					<div class="bd-t mg-t-md pd-t-md">
						<div class="mg-b-xs">
							ㆍ선택된 회원의 상태를
							<div class="input-group">
								<select name="changeStatus" id="changeStatus" class="form-control" style="display:inline-block; width:150px;">
								<c:forEach items="${mberSttusList}" var="result" varStatus="status">
								<option value="<c:out value='${result.code}'/>"><c:out value="${result.codeNm}"/></option>
								</c:forEach>
								</select> 
								<span class="input-group-btn">
									<button type="button" class="btn btn-default" onclick="member_manager('status');">일괄수정</button>
								</span>
							</div>
						</div>
						<div class="mg-b-xs">
							ㆍ선택된 회원의 등급을
							<div class="input-group">
								<select name="changeGroupId" id="changeGroupId" class="form-control" style="display:inline-block; width:120px;">
								<c:forEach items="${groupList}" var="result" varStatus="status">
								<option value="<c:out value='${result.groupId}'/>"><c:out value="${result.groupNm}"/></option>
								</c:forEach>
								</select> 
								<span class="input-group-btn">
									<button type="button" class="btn btn-default" onclick="member_manager('group');">일괄수정</button>
								</span>
							</div>
						</div>							
						<div class="mg-b-xs">
							ㆍ선택된 회원의 그룹을
							<div class="input-group">
								<select name="changeLevelId" id="changeLevelId" class="form-control" style="display:inline-block; width:120px;">
								<c:forEach items="${levelList}" var="result" varStatus="status">
								<option value="<c:out value='${result.levelId}'/>"><c:out value="${result.levelNm}"/></option>
								</c:forEach>
								</select> 
								<span class="input-group-btn">
									<button type="button" class="btn btn-default" onclick="member_manager('level');">일괄수정</button>
								</span>
							</div>
						</div>
					</div>								
				</div>
			</form>
		</div>	
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
function member_manager(gubun)
{
	if (!chk_checkbox(memberListForm, 'chks', true))
	{
		alert('회원을 선택해 주세요');
		return;
	}

	if (!confirm('정말로 일괄수정하시겠습니까?'))
	{
		return;
	}

	document.memberListForm.act.value='manager';
	document.memberListForm.change.value=gubun;
	document.memberListForm.submit();
}
//]]>
</script>
