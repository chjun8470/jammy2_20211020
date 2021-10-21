<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String configFile = String.format("config_%s.jsp", boardVO.getBoardTy());
%>
<jsp:include page="<%=configFile%>" flush="true" />

<script type="text/javascript" charset="utf-8">
//<![CDATA[
		$(window).load(function(){
			
			//set and get some variables
			var thumbnail = {
				imgIncrease : 20, /* the image increase in pixels (for zoom) */
				effectDuration : 200, /* the duration of the effect (zoom and info) */
				/* 
				get the width and height of the images. Going to use those
				for 2 things:
					make the list items same size
					get the images back to normal after the zoom 
				*/
				imgWidth : $('.gallery-content ul li').find('img').width(), 
				imgHeight : $('.gallery-content ul li').find('img').height() 
				
			};
			
			//make the list items same size as the images
			$('.gallery-content ul li').css({ 
				
				'width' : thumbnail.imgWidth, 
				'height' : thumbnail.imgHeight 
				
			});
			
			//when mouse over the list item...
			$('.gallery-content ul li').hover(function(){
			//$('.gallery-content ul li .ui-slider-handle').focus(function(){
				
				$(this).find('img').stop().animate({
					
					/* increase the image width for the zoom effect*/
					width: parseInt(thumbnail.imgWidth) + thumbnail.imgIncrease,
					/* we need to change the left and top position in order to 
					have the zoom effect, so we are moving them to a negative
					position of the half of the imgIncrease */
					left: thumbnail.imgIncrease/2*(-1),
					top: thumbnail.imgIncrease/2*(-1)
					
				},{ 
					
					"duration": thumbnail.effectDuration,
					"queue": false
					
				});
				
				//show the info using slideDown event
				$(this).find('.info:not(:animated)').slideDown(thumbnail.effectDuration);
				
			//when mouse leave...
			}, function(){
				
				//find the image and animate it...
				$(this).find('img').animate({
					
					/* get it back to original size (zoom out) */
					width: thumbnail.imgWidth,
					/* get left and top positions back to normal */
					left: 0,
					top: 0
					
				}, thumbnail.effectDuration);
				
				//hide the info using slideUp event
				$(this).find('.info').slideUp(thumbnail.effectDuration);
				
			});

			$('.gallery-content ul li a').focus(function() {

			  $(this).mouseover();

			});


			
		});
//]]>			
</script>
<style type="text/css" media="screen">
		.gallery-content { width:100%; margin:0px auto; } /* not important */
		
		.gallery-content ul { 
			list-style-type: none; /* remove the default style for list items (the circles) */ 
			margin:0px; /* remove default margin */
			padding:0px; /* remove default padding */
		}
		.gallery-content ul li { 
			float:left; /* important: left float */
			position:relative; /* so we can use top and left positioning */
			overflow:hidden; /* hide the content outside the boundaries (ZOOM) */
		}
		.gallery-content ul li a img { 
		    width:100%;
			height:100%; /* not important, the pics we use here are too big */
			position:relative; /* so we can use top and left positioning */
			border:none; /* remove the default blue border */
		}
		.info{
			position:absolute; /* needed for positioning */
			bottom:0px; /* bottom of the list item (container) */
			left:0px; /* start from left of the list item (container) */
			width:100%; /* stretch to the whole width of container */
			display:none; /* hide by default */
			/* styling bellow */
			background:#000;
			color:white;
			opacity:0.8;
		}
		.info .infoInside{
			/* just styling */
			padding:5px;
			margin:0px;
		}
		.info .infoInside a{color:#fff; font-size:13px;}
		.clear { clear:both; } /* to clear the float after the last item */
		#body #content .content-body .board .gallery-content ul li {padding:10px 0; !important;}
	</style>







<c:if test="${boardVO.useCategoryAt == 'Y'}">
	<a href="?act=list">전체</a>
	<c:forEach var="result" items="${boardCategory}" varStatus="status">
	<a href="?categoryNm=<c:out value='${jmy:urlEncoder(result)}'/>"><c:out value="${result}"/></a>
	</c:forEach>
</c:if>




<div class="board">
	<div class="gallery-content">
		<form name="boardListForm" action="<c:url value='/cms/board/${boardVO.boardId}.do'/>" method="post">
		<input type="hidden" name="act" value="" />
			<ul class="clearfix">
			<c:forEach items="${resultList}" var="result" varStatus="status">
				<c:set var="iSecret" value="${result.secretAt == 'Y' ? true : false}"/>
				<c:set var="iReply" value="${result.depth > 0 ? true : false}"/>
				<c:set var="iAtchFile" value="${result.atchFileCnt > 0 ? true : false}"/>
				<c:set var="iNew" value="${boardVO.newIconPeriod > result.registDateDiff ? true : false}"/>
				<li class="item col-lg-3 col-md-4 col-xs-6">
					<div class="item-contain">
						<div class="photo">
							<a href="?act=read&amp;articleId=<c:out value="${result.articleId}"/>&amp;<c:out value="${boardSearchQueryString}"/>">
								<img src="<c:url value='/${result.thumbAtchFileFullPath}'/>" alt="" />
							</a>
						</div>
						<div class="info">
							<div class="infoInside">
								<c:if test="${isBoardAdmin}">
									<input type="checkbox" name="chks" value="<c:out value='${result.articleId}'/>" />
								</c:if>
								<c:choose>
									<c:when test="${!isBoardAdmin && result.deletedAt == 'Y'}">삭제된 글입니다.</c:when>
									<c:otherwise><a href="?act=read&amp;articleId=<c:out value="${result.articleId}"/>&amp;<c:out value="${boardSearchQueryString}"/>"><c:out value="${result.subject}"/></a></c:otherwise>
								</c:choose>
								<c:if test="${iNew}"><span class="inew"><span class="txt">새글</span></span></c:if>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
			</ul>
		</form>
	</div>
	<div class="gallery-footer">
		<div class="clearfix">
			<div class="pull-left">
				<c:if test="${isBoardAdmin}">
				<button type="button" class="btn btn-default btn-sm" onclick="board_manager(); return false;">게시글 관리</button>
				</c:if>
			</div>
			<div class="pull-right">
				<c:if test="${writeAuthor}">
				<a href="?act=write&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-primary btn-sm"><i class="fa fa-pencil"></i> <spring:message code="button.create"/></a>
				</c:if>			
			</div>
		</div>
		<div class="text-center">
			<ul class="pagination pagination-sm">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
			</ul>
		</div>
		<div class="text-center">			
			<form action="?act=list" method="post" class="form-inline" role="form">
				<input type="hidden" name="categoryNm" value="<c:out value='${param.categoryNm}'/>" />
				<fieldset>
					<legend class="sr-only">검색 폼</legend>
					<div class="form-group">
						<label for="searchCondition" class="sr-only">검색방법선택</label>
						<select name="searchCondition" id="searchCondition" class="form-control input-sm">
						<option value="subject" <c:if test="${param.searchCondition == 'subject'}">selected="selected"</c:if>><spring:message code="common.subject"/></option>
						<option value="content" <c:if test="${param.searchCondition == 'content'}">selected="selected"</c:if>><spring:message code="common.content"/></option>
						<option value="writerNm" <c:if test="${param.searchCondition == 'writerNm'}">selected="selected"</c:if>><spring:message code="common.name"/></option>
						<option value="writerId" <c:if test="${param.searchCondition == 'writerId'}">selected="selected"</c:if>><spring:message code="common.userId"/></option>
						</select>
					</div>
					<div class="input-group">
						<label for="searchKeyword" class="sr-only">검색어</label>
						<input type="text" name="searchKeyword" id="searchKeyword" class="form-control input-sm" value="<c:out value='${param.searchKeyword}'/>"/>
						<span class="input-group-btn">
							<button type="submit" class="btn btn-default btn-sm mgt0"><spring:message code="common.search"/></button>
						</span>
					</div>					
				</fieldset>
			</form>		
		</div>
	</div>
</div>