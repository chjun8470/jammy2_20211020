<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<c:if test="${defaultVO.menu == '1' || defaultVO.menu == null}">
	<c:set var="menu1_nm" value="사용자관리"/>
	<c:if test="${defaultVO.smenu == 1 || defaultVO.smenu == null}">
		<c:set var="menu2_nm" value="회원관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 2}">
		<c:set var="menu2_nm" value="관리자관리"/>
	</c:if>
</c:if>

<c:if test="${defaultVO.menu == '2'}">
	<c:set var="menu1_nm" value="시스템관리"/>
	<c:if test="${defaultVO.smenu == 1 || defaultVO.smenu == null}">
		<c:set var="menu2_nm" value="코드관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 2}">
		<c:set var="menu2_nm" value="관리자관리"/>
	</c:if>
</c:if>
<c:if test="${defaultVO.menu == '3'}">
	<c:set var="menu1_nm" value="데이터관리"/>

	<c:if test="${defaultVO.smenu == 1 || defaultVO.smenu == null}">
		<c:set var="menu2_nm" value="여행지관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 2}">
		<c:set var="menu2_nm" value="여행지상세관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 3}">
		<c:set var="menu2_nm" value="코스관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 4}">
		<c:set var="menu2_nm" value="음식점관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 5}">
		<c:set var="menu2_nm" value="쿠폰관리"/>
	</c:if>

</c:if>
<c:if test="${defaultVO.menu == '4'}">
	<c:set var="menu2_nm" value="통계관리"/>
	<c:if test="${defaultVO.smenu == 1 || defaultVO.smenu == null}">
		<c:set var="menu2_nm" value="이동경로"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 2}">
		<c:set var="menu2_nm" value="회원가입통계"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 3}">
		<c:set var="menu2_nm" value="접속자통계"/>
	</c:if>
</c:if>
<c:if test="${defaultVO.menu == '5'}">
	<c:set var="menu2_nm" value="운영관리"/>

	<c:if test="${defaultVO.smenu == 1 || defaultVO.smenu == null}">
		<c:set var="menu2_nm" value="쿠폰사용관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 2}">
		<c:set var="menu2_nm" value="MD추천관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 3}">
		<c:set var="menu2_nm" value="티켓관리"/>
	</c:if>
	<c:if test="${defaultVO.smenu == 4}">
		<c:set var="menu2_nm" value="사용자푸쉬"/>
	</c:if>

</c:if>


	<div id="cur_loc">
         <div id="cur_loc_align">
             <ul>
                 <li>HOME</li>
                 <li>&gt;</li>
                 <li>${menu1_nm}</li>
                 <li>&gt;</li>
                 <li>${menu2_nm}</li>
             </ul>
         </div>
     </div>
