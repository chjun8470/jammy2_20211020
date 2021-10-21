<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>

<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
   
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
   	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

  
   	String xcount = util.getStr(paramMap.get("xcount"));
	
	String fileGrp = "Jnrdtypea";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
     	
       
%>

<jsp:useBean id="currTime" class="java.util.Date" />


<div class="typeAformContent" id="typeAformContent<%=xcount%>">
<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">지원현황-<%=xcount%></h3>
<form name="typeaform_<%=xcount%>" id="typeaform_<%=xcount%>" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="cxidx" value="" />
	<table class="skin_basic_write" >
		<caption>정부사업지원현황</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 조사연도</th>
           		<td colspan="3">
           			
           			<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
          			<select name="txyear" id="txyear" class="select_box" style="width:150px;">
         				<option value="">:::선택:::</option>
         				<c:forEach var="i" begin="2018" end="${currTime}">
            			<option value="${i}">${i}</option>
            			</c:forEach>
         			</select>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 접수정보</th>
           		<td colspan="3">
           			<label><input type="radio" name="txtype" value="접수" checked="checked"> 접수</label>
	           		<label><input type="radio" name="txtype" value="미접수"> 미접수</label>
	           		<label><input type="radio" name="txtype" value="정책기획"> 정책기획</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)신청일</th>
           		<td>
           			<input type="text" name="txdate" id="txdate<%=xcount%>" value="" class="inp_txt read_only" readonly />
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 제안부처명</th>
           		<td>
           			<input type="text" name="txname" id="txname" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처사업명</th>
           		<td>
           			<input type="text" name="tx_bname" id="tx_bname" value="" class="inp_txt" />
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 관리기관명</th>
           		<td>
           			<input type="text" name="tx_cname" id="tx_cname" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업과제날짜</th>
           		<td>
           			시작일 : <input type="text" name="tx_sdate" id="tx_sdate<%=xcount%>" value="" class="inp_txt read_only" readonly><br/>
           			종료일 : <input type="text" name="tx_edate" id="tx_edate<%=xcount%>" value="" class="inp_txt read_only" readonly>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업기간</th>
           		<td>
           			<input type="hidden" name="tx_tmonth" id="tx_tmonth" value="" class="inp_txt read_only" readonly>
           			<span class="monthTit"></span>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- 신청사업비(백만원)</h3>
	<table class="skin_basic_write" >
		<caption>비고</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 국비</th>
           		<td>
           			<input type="text" name="tx_price1" id="tx_price1" value="" class="inp_txt" />
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 도비</th>
           		<td>
           			<input type="text" name="tx_price2" id="tx_price2" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
           		<td>
           			<input type="text" name="tx_price3" id="tx_price3" value="" class="inp_txt" />
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타현금</th>
           		<td>
           			<input type="text" name="tx_price4" id="tx_price4" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 현물</th>
           		<td>
           			<input type="text" name="tx_price5" id="tx_price5" value="" class="inp_txt" />
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 총사업비</th>
           		<td>
           			<input type="text" name="tx_price6" id="tx_price6" value="" class="inp_txt read_only" readonly />
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 사업신청 관련 증빙자료 등록</h3>
	<table class="skin_basic_write" >
		<caption>비고</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업공고문</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="1">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" value="" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업신청서표지</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="2">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" value="" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">기타자료</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="3">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File3" id="<%=fileFullGrp%>File3" value="" />
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- 사업비 확보 노력 현황자료</h3>
	<table class="skin_basic_write" >
		<caption>비고</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit">사업비 확보 노력 현황자료</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="4">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File4" id="<%=fileFullGrp%>File4" value="" />
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<input type="button" class="typeainsert" value="등록">
   	
</form>
</div>