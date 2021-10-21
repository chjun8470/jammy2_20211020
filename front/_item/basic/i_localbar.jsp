<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

	<div class="localbar">
             <ul>
                 <li>HOME</li>
                 <li>&gt;</li>

<%--           <%if("1".equals(menu1)) {%> --%>
<!--                  <li>연구장비정보망</li> -->
<!--                  <li>&gt;</li> -->
<%--              <%if("1".equals(menu2)) {%><li>연구장비/시설 리스트</li><%} %> --%>
<%--              <%if("2".equals(menu2)) {%><li>연구장비등록</li><%} %> --%>
<%--              <%if("3".equals(menu2)) {%><li>연구시설등록</li><%} %> --%>
<%--           <%} %> --%>
<%--           <%if("2".equals(menu1)) {%> --%>
<!--                  <li>직원관리</li> -->
<!--                  <li>&gt;</li> -->
<%--              <%if("1".equals(menu2)) {%><li>회원정보수정</li><%} %> --%>
<%--           <%} %> --%>
		<%if("1".equals(menu1)) {%>
                 <li>My Page</li>
                 <li>&gt;</li>
             <%if("1".equals(menu2)) {%><li>내정보수정</li><%} %>
             <%if("2".equals(menu2)) {%><li>기간회원변경신청</li><%} %>
             
          <%} %>
          </ul>
     </div>
