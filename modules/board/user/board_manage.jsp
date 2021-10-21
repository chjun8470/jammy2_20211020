<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<style>
legend {display:inline-block; margin:0 0 10px 0; padding:7px 10px 7px 10px; background:#dc0000; color:#fff;}
.pass_box {width:90%; margin:35px auto 0 auto; padding:10px 10px 10px 160px; border:1px dotted #424242; background: url('/modules/bbs/skins/default/img/notice_bg.png') no-repeat 20px 20px; background-color:#fff;}
.pass_form {margin:15px 0; padding:10px 0; border-top: 1px solid #dedede; border-bottom: 1px solid #dedede;}
.btn {font-size:12px; margin-top:0px; vertical-align:middle;}
.pass_input {height:32px; }
.pass_box dl dd {padding:10px; background:#f7f7f7;}
.form-control {display:inline-block;}
#targetBoardId {width:250px;}
#deleteMemo {width:250px;}
</style>
<div class="pass_box">
<form action="" method="post">
	<input type="hidden" name="act" value="manage" />
	<input type="hidden" name="manage" value="ok" />
	<input type="hidden" name="mode" value="" />
	<input type="hidden" name="chk" value="<c:out value='${chk}'/>" />
	<fieldset>
		<legend>게시글 관리</legend>
		<div class="form-group">
			<span><strong>게시글 이동</strong></span>
			<select name="targetBoardId" id="targetBoardId" class="form-control input-sm">
			<c:forEach var="result" items="${boardList}" varStatus="status">
			<c:if test="${boardVO.boardId != result.boardId}">
			<option value="${result.boardId}"><c:out value="${result.boardNm}"/></option>
			</c:if>
			</c:forEach>
			</select>
			<button class="btn btn-warning btn-sm" type="button" onclick="this.form.mode.value='move'; this.form.submit();">이동</button>
		</div>
		<div class="form-group">
			<span><strong>게시글 삭제</strong></span>
			<input type="text" name="deleteMemo" id="deleteMemo" class="form-control input-sm" value="" />
			<button class="btn btn-warning btn-sm" type="button" onclick="if(confirm('<spring:message code="common.delete.msg"/>')){this.form.mode.value='delete'; this.form.submit();}"><spring:message code="common.delete"/></button>
		</div>
		
		
		<button class="btn btn-danger btn-sm" type="button" onclick="if(confirm('<spring:message code="common.deleteDatabase.msg"/>')){this.form.mode.value='deleteDatabase'; this.form.submit();}"><spring:message code="common.deleteDatabase"/></button>
	</fieldset>
</form>
</div>