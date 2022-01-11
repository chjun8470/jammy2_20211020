<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>



<style>

.xbtn{border:none; clear:both; background:#3974cd; text-align:center; display:block; padding:10px 0; color:#fff; margin-top:30px;}

</style>


<div class="MPContImg">
<h3 class="MPHome">마이페이지</h3>
	<p class="TxtMPHome01">저희 홈페이지를 방문해 주셔서 <br />감사합니다.</p>
	<p class="TxtMPHome02">*개인회원은 전남과학기술정보시스템의<br /> &nbsp;&nbsp;일부 서비스를 제공 받으실 수 없습니다.</p>
</div>
<div class="MPQuickLink">
<ul>
	<li class="MPQL01">
		<a href="/sso/mypagecon.do" class="mpql01">
			<div class="icon_bg01"></div>
			<p class="txt_MPQL0101">회원정보관리</p>
			<p class="txt_MPQL0102">고객님의 회원정보를<br />관리하실 수 있습니다.</p>
		</a>
	</li>
	<li class="MPQL02">
		<a href="/sso/equorder.do" class="mpql02">
			<div class="icon_bg02"></div>
			<p class="txt_MPQL0201">예약정보</p>
			<p class="txt_MPQL0202">고객님의 장비 예약정보를<br /> 관리하실 수 있습니다.</p>
		</a>
	</li>
	<li class="MPQL03">
		<a href="/sso/changeboard.do" class="mpql03">
			<div class="icon_bg03"></div>
			<p class="txt_MPQL0301">담당자게시판</p>
			<p class="txt_MPQL0302">고객님의 담당자 <br />게시판입니다.</p>
		</a>
	</li>
	<li class="MPQL04">
		<a href="/sso/myfav.do" class="mpql04">
			<div class="icon_bg04"></div>
			<p class="txt_MPQL0401">장바구니</p>
			<p class="txt_MPQL0402">고객님의 장바구니를<br /> 관리하실 수 있습니다.</p>
		</a>
	</li>
</ul>
</div>
<%
if(util.getStr(loginVO.getUserTp()).equals("4")){ 
%>
	<a href="/sso/expertInfo.do?mode=view&userIdx=<%=util.getStr(loginVO.getUserIdx())%>"><span class="xbtn">전문가 상세정보 입력</span></a>
<%
}
%>

