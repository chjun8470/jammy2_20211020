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
	
      
       ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	   ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	   
	   ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	
	   ArrayList<HashMap<String, String>> rndStageList = request.getAttribute("rndStageList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
	   ArrayList<HashMap<String, String>> rndPurposeList = request.getAttribute("rndPurposeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndPurposeList");
	   ArrayList<HashMap<String, String>> scienceBList = request.getAttribute("scienceBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scienceBList");
	   ArrayList<HashMap<String, String>> emphasisBList = request.getAttribute("emphasisBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("emphasisBList");
	   ArrayList<HashMap<String, String>> rndTbList = request.getAttribute("rndTbList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndTbList");
	   ArrayList<HashMap<String, String>> IndustryList = request.getAttribute("IndustryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("IndustryList");
	   ArrayList<HashMap<String, String>> blueList = request.getAttribute("blueList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("blueList");
	   ArrayList<HashMap<String, String>> agencyList = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
		
	   String xNum = util.getStr(paramMap.get("xnum"));
	   String year = util.getStr(paramMap.get("year"));
	   String mIDX = util.getStr(paramMap.get("midx"));
	   
	   String fileGrp = "Jnrdm1";
	   String fileSubGrp = "";
	   String fileFullGrp =fileGrp+fileSubGrp;
     	
       
%>

<div id="ncontent<%=year %>" class="ncontent">
	<form method="post" name="ncontForm_<%=year%>" id="ncontForm_<%=year%>" action="<%=myPage%>">
	<input type="hidden" name="mode" value="writeProc">
	<input type="hidden" name="midx" value="<%=mIDX%>">
	
	<table class="skin_basic_write" >
		<caption>대상연도예산액</caption>
	       <colgroup>
	             <col style="width:20%" />
	             <col style="width:30%" />
	             <col style="width:20%" />
	             <col style="width:30%" />
	       </colgroup>
	       <tbody>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 조사대상연도</th>
	          		<td colspan="3">
	          			<!-- select name="npyear" id="npyear1" class="select_box" style="min-width:150px;">
	          				<option value="">::년도선택::</option>
	          			</select-->
	          			<input type="text" name="npyear" id="npyear1" value="<%=year %>" class="inp_txt read_only" readonly />
	          			<label><input type="checkbox" name="npset" id="npset1" value="1"/> 비대상</label>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 재원구분</th>
	          		<td>
	          			<label><input type="radio" name="nptype1" value="일반회계" checked="checked"> 일반회계</label>
	           			<label><input type="radio" name="nptype1" value="특별회계"> 특별회계</label>
	           			<label><input type="radio" name="nptype1" value="기금"> 기금</label>
	           			<label><input type="radio" name="nptype1" value="지자체회계"> 지자체회계</label>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 예산액확정</th>
	          		<td>
	          			<label><input type="radio" name="nptype2" value="확정"> 확정</label>
	           			<label><input type="radio" name="nptype2" value="미확정" checked="checked"> 미확정</label>
	           			<label><input type="radio" name="nptype2" value="검토중"> 검토중</label>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 신규/계속</th>
	          		<td>
	          			<label><input type="radio" name="nptype3" value="신규" checked="checked"> 신규</label>
	           			<label><input type="radio" name="nptype3" value="계속"> 계속</label>
	           			<label><input type="radio" name="nptype3" value="예정"> 예정</label>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 총연구비</th>
	          		<td>
	          			<input type="number" name="nptotprice" id="nptotprice" class="inp_txt" value="" disabled/> (단위 : 백만원)
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 국비</th>
	          		<td>
	          			<input type="number" name="npprice1" id="npprice1" class="inp_txt" value="" disabled/> (단위 : 백만원)
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 도비</th>
	          		<td>
	          			<input type="number" name="npprice2" id="npprice2" class="inp_txt" value="" disabled/> (단위 : 백만원)
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
	          		<td>
	          			<input type="number" name="npprice3" id="npprice3" class="inp_txt" value="" disabled/> (단위 : 백만원)
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타</th>
	          		<td>
	          			<input type="number" name="npprice4" id="npprice4" class="inp_txt" value="" disabled/> (단위 : 백만원)
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 계</th>
	          		<td colspan="3">
	          			<input type="number" name="npprice5" id="npprice5" class="inp_txt read_only" readonly  disabled value=""/> (단위 : 백만원)
	          		</td>
	          	</tr>
	          	
	   	</tbody>
	</table>
	
	<h3 class="tit"> - 사업정보출처</h3>
	<div class="zoom"></div>
	<table class="skin_basic_write" >
		<caption>사업정보출처</caption>
	       <colgroup>
	             <col style="width:20%" />
	             <col style="width:30%" />
	             <col style="width:20%" />
	             <col style="width:30%" />
	       </colgroup>
	       <tbody>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 과학기술진흥시행계획</th>
	          		<td>
	          			<label><input type="radio" name="npftype1" value="yes" checked="checked"> 해당</label>
	           			<label><input type="radio" name="npftype1" value="no"> 미해당</label>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> NTIS</th>
	          		<td>
	          			<label><input type="radio" name="npftype2" value="yes" checked="checked"> 해당</label>
	           			<label><input type="radio" name="npftype2" value="no"> 미해당</label>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 연지단</th>
	          		<td>
	          			<label><input type="radio" name="npftype3" value="yes" checked="checked"> 해당</label>
	           			<label><input type="radio" name="npftype3" value="no"> 미해당</label>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 전남도</th>
	          		<td>
	          			<label><input type="radio" name="npftype4" value="yes" checked="checked"> 해당</label>
	           			<label><input type="radio" name="npftype4" value="no"> 미해당</label>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구계획서 표지등록</th>
	          		<td colspan="3">
	          			<input type="hidden" name="fileSn" value="1">
           				<input type="hidden" name="fileFlog" value="">
	          			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" value="">
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 과학기술진흥종합계획<br>사업조서등록</th>
	          		<td colspan="3">
	          			<input type="hidden" name="fileSn" value="2">
           				<input type="hidden" name="fileFlog" value="">
	          			<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" value="">
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"> 기타자료등록</th>
	          		<td colspan="3">
	          			<input type="hidden" name="fileSn" value="3">
           				<input type="hidden" name="fileFlog" value="">
	          			<input type="file" name="<%=fileFullGrp%>File3" id="<%=fileFullGrp%>File3" value="">
	          		</td>
	          	</tr>
	          	
	   	</tbody>
	</table>
	
	<h3 class="tit"> - 전문(관리)기관</h3>
	<div class="zoom"></div>
	<table class="skin_basic_write" >
		<caption>전문(관리)기관</caption>
	       <colgroup>
	             <col style="width:20%" />
	             <col style="width:30%" />
	             <col style="width:20%" />
	             <col style="width:30%" />
	       </colgroup>
	       <tbody>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 전문기관</th>
	          		<td>
	          			<input type="text" name="npotext1" id="npotext1" class="inp_txt" value=""/>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 관리기관</th>
	          		<td>
	          			<input type="text" name="npotext2" id="npotext2" class="inp_txt" value=""/>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 기관유형</th>
	          		<td>
	          			<select name="npotext3" id="npotext3" class="select_box" style="min-width:150px;">
	          				<option value="">::유형선택::</option>
	          				<% for(HashMap va:agencyList){ %>
							<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관</th>
	          		<td>
	          			<input type="text" name="npotext4" id="npotext4" class="inp_txt" value=""/>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관소재지</th>
	          		<td>
	          			<label><input type="radio" name="npotext5" value="1" checked="checked" onclick="areaClick('npocode','1')"> 광역지자체</label>
	           			<label><input type="radio" name="npotext5" value="2" onclick="areaClick('npocode','2')"> 전라남도</label>
	           			<select name="npocode" id="npocode1" class="select_box">
	           				<option value="">:::선택:::</option>
	           				<%
								for(HashMap rs:areaList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	           			</select>
	           			<select name="0" id="npocode2" class="select_box" style="display:none;">
	           				<option value="">:::선택:::</option>
	           				<%
								for(HashMap rs:areaSigunguList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	           			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 소속부서(학과)</th>
	          		<td>
	          			<input type="text" name="npotext6" id="npotext6" class="inp_txt" value=""/>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자명</th>
	          		<td>
	          			<input type="text" name="npotext7" id="npotext7" class="inp_txt" value=""/>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자직위</th>
	          		<td>
	          			<input type="text" name="npotext8" id="npotext8" class="inp_txt" value=""/>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit">연구책임자 최종학위</th>
	          		<td>
	          			<select name="npotext9" id="npotext9" class="select_box" style="min-width:150px;">
	          				<option value="">::학위선택::</option>
	          				<option>고졸</option>
	          				<option>전문학사</option>
	          				<option>학사</option>
	          				<option>석사</option>
	          				<option>박사</option>
	          			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업시행지</th>
	          		<td>
	          			<select name="npotext10" id="npotext10" class="select_box" style="min-width:150px;">
	          				<option value="">::선택::</option>
	          				<%
							for(HashMap rs:areaList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          	</tr>      	
	   	</tbody>
	</table>
	
	<h3 class="tit"> - 과제분류</h3>
	<div class="zoom"></div>
	<table class="skin_basic_write" >
		<caption>과제분류</caption>
	       <colgroup>
	             <col style="width:20%" />
	             <col style="width:30%" />
	             <col style="width:20%" />
	             <col style="width:30%" />
	       </colgroup>
	       <tbody>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구개발단계분류</th>
	          		<td>
	          			<select name="npwtext1" id="npwtext1" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<% for(HashMap va:rndStageList){ %>
							<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구개발목적</th>
	          		<td>
	          			<select name="npwtext2" id="npwtext2" class="select_box" style="min-width:150px;">
	          				<option value="">::목적선택::</option>
	          				<%
							for(HashMap rs:rndPurposeList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 과학기술표준분류(분야)</th>
	          		<td>
	          			<select name="npwtext3" id="npwtext3" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<option>과학기술</option>
	          				<option>인문사회과학</option>
	          				<option>기타</option>
	          			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 과학기술표준분류(대분류)</th>
	          		<td>
	          			<select name="npwtext4" id="npwtext4" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<%
							for(HashMap rs:scienceBList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 중점과학기술분류</th>
	          		<td>
	          			<select name="npwtext5" id="npwtext5" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<%
							for(HashMap rs:emphasisBList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 6T분류</th>
	          		<td>
	          			<select name="npwtext6" id="npwtext6" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<%
							for(HashMap rs:rndTbList) {
							%>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 블루이코노미분류</th>
	          		<td>
	          			<select name="npwtext7" id="npwtext7" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<% for(HashMap va:blueList){ %>
							<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
							<% } %>	          				
	          			</select>
	          		</td>
	          		<th scope="row" class="tit"><span style="color:red;" >*</span> 산업분류</th>
	          		<td>
	          			<select name="npwtext8" id="npwtext8" class="select_box" style="min-width:150px;">
	          				<option value="">::분류선택::</option>
	          				<% for(HashMap va:IndustryList){ %>
							<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
							<% } %>
	          			</select>
	          		</td>
	          	</tr>      	
	   	</tbody>
	</table>
	
	<h3 class="tit"> - 전남도(사업소)관리부서 및 담당자</h3>
	<div class="zoom"></div>
	<table class="skin_basic_write" >
		<caption>과제분류</caption>
	       <colgroup>
	             <col style="width:20%" />
	             <col style="width:30%" />
	             <col style="width:20%" />
	             <col style="width:30%" />
	       </colgroup>
	       <tbody>
	          	<tr>
	          		<th scope="row" class="tit">실국/사업소</th>
	          		<td>
	          			<input type="text" name="npxtext1" id="npxtext1" class="inp_txt" value=""/>
	          		</td>
	          		<th scope="row" class="tit">부서(과)</th>
	          		<td>
	          			<input type="text" name="npxtext2" id="npxtext2" class="inp_txt" value=""/>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit">담당자이름</th>
	          		<td colspan="3">
	          			<input type="text" name="npxtext3" id="npxtext3" class="inp_txt" value=""/>
	          		</td>
	          		
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit">담당자직위</th>
	          		<td>
	          			<input type="text" name="npxtext5" id="npxtext5" class="inp_txt" value=""/>
	          		</td>
	          		<th scope="row" class="tit">담당자전화번호</th>
	          		<td>
	          			<input type="text" name="npxtext6" id="npxtext6" class="inp_txt" value=""/>
	          		</td>
	          	</tr> 	
	   	</tbody>
	</table>
	
	<h3 class="tit"> - 비고</h3>
	<div class="zoom"></div>
	<table class="skin_basic_write" >
		<caption>비고</caption>
	       <colgroup>
	             <col style="width:20%" />
	             <col style="width:30%" />
	             <col style="width:20%" />
	             <col style="width:30%" />
	       </colgroup>
	       <tbody>
	          	<tr>
	          		<td colspan="4">
	          			<textarea name="xcomment" id="xcomment" class="inp_txt" rows="5" style="width:100%;"></textarea>
	          			<span class="htmlBtn cGreen addPriceInfo" data-year="<%=year%>">등록</span>
	          		</td>
	          	</tr>      	
	   	</tbody>
	</table>
	
	</form>
	
</div>

<div style="padding-top:15px"></div>


