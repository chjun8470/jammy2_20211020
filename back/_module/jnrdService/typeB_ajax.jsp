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
	
   	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
  	ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
  	ArrayList<HashMap<String, String>> agencyList  = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
  	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
  	
   	String xcount = util.getStr(paramMap.get("xcount"));
	
	String fileGrp = "Jnrdtypeb";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
     	
       
%>

<jsp:useBean id="currTime" class="java.util.Date" />


<div class="typeBformContent" id="typeBformContent<%=xcount%>">
<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">선정과제-<%=xcount%></h3>
<form name="typebform_<%=xcount%>" id="typebform_<%=xcount%>" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="xcount" value="<%=xcount%>" />
	
	<h3 class="tit">- 사업(과제)정보</h3>
	<table class="skin_basic_write" >
		<caption>사업(과제)정보</caption>
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
          			<select name="yxyear" id="yxyear" class="select_box" style="width:150px;">
         				<option value="">:::선택:::</option>
         				<c:forEach var="i" begin="2018" end="${currTime}">
            			<option value="${i}">${i}</option>
            			</c:forEach>
         			</select>
         			
         			<label><input type="checkbox" name="yxstatus" value="1"> 미선정</label>
           			
           		</td>
           	</tr>
           	
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)신청일</th>
           		<td colspan="3">
           			<label><input type="radio" name="yxtype1" value="국가 R&D" checked="checked"> 국가R&D</label>
	           		<label><input type="radio" name="yxtype1" value="국가 비R&D"> 국가 비R&D</label> 
	           		<label><input type="radio" name="yxtype1" value="도비 R&D"> 도비 R&D</label>
	           		<label><input type="radio" name="yxtype1" value="도비 비R&D"> 도비 비R&D</label>
	           		<label><input type="radio" name="yxtype1" value="xx"> 기타</label>
           		</td>
           	</tr>
           	
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업성격</th>
           		<td colspan="3">
           			<label><input type="radio" name="yxtype2" value="국비사업" checked="checked"> 국비사업</label>
	           		<label><input type="radio" name="yxtype2" value="국도비 매칭사업"> 국도비 매칭사업</label> 
	           		<label><input type="radio" name="yxtype2" value="도비사업"> 도비사업</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 지원부처(청)명</th>
           		<td colspan="3">
           			<select name="yx_name" class="select_box">
	           			<option value="">:::선택:::</option>
	          			<% for(HashMap sup:supportList){ %>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처(전남도)사업명</th>
           		<td>
           			<input type="text" name="yx_dname" id="yx_dname" value="" class="inp_txt"/>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 과제명</th>
           		<td>
           			<input type="text" name="yx_bname" id="yx_bname" value="" class="inp_txt">
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- 총사업기간</h3>
	<table class="skin_basic_write" >
		<caption>총사업기간</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 시작년월일</th>
           		<td colspan="3">
           			<input type="text" name="yx_sdate" id="yx_sdate<%=xcount%>" value="" class="inp_txt read_only" readonly />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 종료년월일</th>
           		<td colspan="3">
           			<input type="text" name="yx_edate" id="yx_edate<%=xcount%>" value="" class="inp_txt read_only" readonly />
           			<label><input type="checkbox" name="ming" id="MING" value="1"/>연차계속</label>
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)기간</th>
           		<td colspan="3">
           			<input type="hidden" name="yx_tmonth" id="yx_tmonth" value="" class="inp_txt" />
           			<span id="yx_tmonth_text<%=xcount%>" class="yx_tmonth_text"></span>
           		</td>
           	</tr>
           	
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- 선정사업비</h3>
	<table class="skin_basic_write" >
		<caption>선정사업비</caption>
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
          			<input type="text" name="yx_price1" id="yx_price1" value="" class="inp_txt" />
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 도비</th>
          		<td>
          			<input type="text" name="yx_price2" id="yx_price2" value="" class="inp_txt" />
          		</td>
          	</tr>
          	<tr>
       		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
          		<td>
          			<input type="text" name="yx_price3" id="yx_price3" value="" class="inp_txt" />
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타현금</th>
          		<td>
          			<input type="text" name="yx_price4" id="yx_price4" value="" class="inp_txt" />
          		</td>
          	</tr>
          	<tr>
       		<th scope="row" class="tit"><span style="color:red;" >*</span> 현물</th>
          		<td>
          			<input type="text" name="yx_price5" id="yx_price5" value="" class="inp_txt" />
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 총사업비</th>
          		<td>
          			<input type="text" name="yx_price6" id="yx_price6" value="" class="inp_txt read_only" readonly />
          		</td>
          	</tr>
   	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 선정과제 증빙자료 등록</h3>
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
        		<th scope="row" class="tit">사업(과제)계획서 표지등록</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="1">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" value="" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">사업(과제)협약서 등록</th>
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
   	
   	
   	
   	
   	<h3 class="tit">- 사업(과제)정보</h3>
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
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 기관유형</th>
           		<td colspan="3">
           			<select name="yx_ctype" class="select_box">
	           			<option value="">:::선택:::</option>
	          			<% for(HashMap sup:agencyList){ %>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 관리기관</th>
           		<td>
           			<input type="text" name="yx_cname" id="yx_cname" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관</th>
           		<td>
           			<input type="text" name="yx_yname" id="yx_yname" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관소재지</th>
           		<td colspan="3">
           			<label><input type="radio" name="yx_cont1" value="전라남도" checked> 전라남도</label>
           			<label><input type="radio" name="yx_cont1" value="전라남도외"> 전라남도외</label>
           			<label><input type="radio" name="yx_cont1" value="국외"> 국외</label>
           			
           			<select name="yx_cont1_text" class="hide_select select_box" style="display:none;" disabled>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<input type="text" name="yx_cont1_text" value="" class="inp_txt" style="display:none;" disabled>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 소속부서(학과)</th>
           		<td>
           			<input type="text" name="yx_cont2" id="yx_cont2" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 소속부서(학과)소재지</th>
           		<td>
           			<input type="text" name="yx_cont3" id="yx_cont3" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자이름</th>
           		<td>
           			<input type="text" name="yx_cont4" id="yx_cont4" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자직위</th>
           		<td>
           			<input type="text" name="yx_cont5" id="yx_cont5" value=""  class="inp_txt"/>
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자 최종학위</th>
           		<td colspan="3">
           			<label><input type="radio" name="yx_cont6" value="고졸"> 고졸</label>
           			<label><input type="radio" name="yx_cont6" value="전문학사"> 전문학사</label>
           			<label><input type="radio" name="yx_cont6" value="학사" checked> 학사</label>
           			<label><input type="radio" name="yx_cont6" value="석사"> 석사</label>
           			<label><input type="radio" name="yx_cont6" value="박사"> 박사</label>
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업시행지</th>
           		<td colspan="3">
           			<label><input type="radio" name="yx_cont7" value="전라남도" checked> 전라남도</label>
           			<label><input type="radio" name="yx_cont7" value="전라남도시군"> 전라남도시군</label>
           			<label><input type="radio" name="yx_cont7" value="타시도"> 타시도</label>
           			<label><input type="radio" name="yx_cont7" value="기타"> 기타</label>
           			
           			<select name="yx_cont8" class="select_box" style="display:none;">
           			<% for(HashMap rs:areaSigunguList) { %>
					<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
					<% } %>
           			</select>
           			
           			<input type="text" name="yx_cont8" class="inp_txt" style="display:none;">
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 전남도(사업소)관리 부서 및 담당자</h3>
	<table class="skin_basic_write" >
		<caption>전남도(사업소)관리 부서 및 담당자</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit">실국/사업소</th>
           		<td>
           			<input type="text" name="yx_hcont1" id="yx_hcont1" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit">부서(과)</th>
           		<td>
           			<input type="text" name="yx_hcont2" id="yx_hcont2" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">담당자이름</th>
           		<td>
           			<input type="text" name="yx_hcont3" id="yx_hcont3" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit">담당자직위</th>
           		<td>
           			<input type="text" name="yx_hcont4" id="yx_hcont4" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">담당자 전화번호</th>
           		<td>
           			<input type="text" name="yx_hcont5" id="yx_hcont5" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit">담당자 휴대전화</th>
           		<td>
           			<input type="text" name="yx_hcont6" id="yx_hcont6" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">담당자이메일</th>
           		<td colspan="3">
           			<input type="text" name="yxmail1" id="yxmail1" value="" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="yxmail2" id="yxmail2" value="" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise4" id="emailDomainChoise4" class="select_box" title="이메일주소도메인선택" >
						<option value="">직접입력</option>
						<option value="gmail.com">지메일</option>
						<option value="empal.com">엠파스</option>
						<option value="naver.com">네이버</option>
						<option value="hanmail.net">다음</option>
						<option value="hotmail.com">핫메일</option>
						<option value="yahoo.co.kr">야후</option>
						<option value="nate.com">네이트</option>
					</select>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- 비고</h3>
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
        		<td colspan="4">
           			<textarea name="yx_comment" rows="5" class="inp_txt" style="width:100%;"></textarea>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<input type="button" class="typebinsert" value="등록">
   	
</form>
</div>