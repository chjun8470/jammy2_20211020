<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@include file="/back/_temple/basic/t_top.jsp" %>
<div class="content_center">
      <iframe src="/AIViewer55/temp/eqhnf.jsp" id="eqhnf" name="eqhnf" width="100%" height="100%" style="border:0px;scroller:no;" onload="autoReportResize('eqhnf')"></iframe>
</div>


<script type="text/javascript">
	var didScroll;
	var endPage;
	var startPage;
	pageTop = new Array();
	//iframe 페이지 값 받기
	function pageH(pageT,end,start){
		endPage = end ;
		startPage = start;
		for(var i = 1 ; i<=pageT.length;i++){
			
			pageTop[i]=pageT[i]+200;
		}
	}
	// 스크롤시에 사용자가 스크롤했다는 것을 알림 
	$(window).scroll(function(event){
	    didScroll = true;
	});

	// hasScrolled()를 실행하고 didScroll 상태를 재설정
	setInterval(function() {
		var id = 'eqhnf';// iframe 아이디 설정 값
	    if (didScroll) {
    		hasScrolled(pageTop,endPage,startPage,id); //js파일 안에 있는 hasScrolled 함수 실행
	        didScroll = false;
	    }
	}, 250);
	//페이지 움직이기
	function parentTest(value){
   	  $( 'html, body' ).animate( { scrollTop : value+200 } );
   	}
</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>
