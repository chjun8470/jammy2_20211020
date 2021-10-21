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
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
   
   

	//ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	//ArrayList<HashMap<String, String>> applicationList = request.getAttribute("applicationList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("applicationList");
	//ArrayList<HashMap<String, String>> technologyList = request.getAttribute("technologyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("technologyList");
	ArrayList<HashMap<String, String>> agencyList = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
	
/*
ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
ArrayList<HashMap<String, String>> rndStageList = request.getAttribute("rndStageList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
ArrayList<HashMap<String, String>> rndPurposeList = request.getAttribute("rndPurposeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndPurposeList");
ArrayList<HashMap<String, String>> scienceBList = request.getAttribute("scienceBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
ArrayList<HashMap<String, String>> emphasisBList = request.getAttribute("emphasisBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("emphasisBList");
ArrayList<HashMap<String, String>> rndTbList = request.getAttribute("rndTbList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndTbList");
ArrayList<HashMap<String, String>> IndustryList = request.getAttribute("IndustryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("IndustryList");
ArrayList<HashMap<String, String>> blueList = request.getAttribute("blueList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("blueList");
ArrayList<HashMap<String, String>> agencyList = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
*/

   String mode = util.getStr(paramMap.get("mode"));
   String nowPage = util.getStr(paramMap.get("nowPage"));
   String userIdx = util.getStr(paramMap.get("userIdx"));
   if("".equals(mode)) mode = "write";

   String fileGrp = "Jnrdcx";
   String fileSubGrp = "";
   String fileFullGrp =fileGrp+fileSubGrp;

   int scCnt = 0;
       
       
%>

<style>
.hideBox{clear:both; border:1px solid #ddd; color:#999; font-size:14px; margin-bottom:15px; padding:30px 20px; text-align:center;}
</style>


<jsp:useBean id="currTime" class="java.util.Date" />


<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	<div class="skin_bbs_write" style="margin-top: 30px">
	
	<p style="color:red;"><span style="color:red;" >*</span>) 필수 입력사항입니다.</p>
	<p style="color:red;"><span style="color:red;" >*</span>작업중인 페이지 입니다. 실제 동작하지 않습니다.</p>

	<!-- 기본정보 S -->
	<h2 class="tit">기획과제 기본정보</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>기획과제 기본정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획과제 지원년도</th>
           		<td colspan="3">
           			
          			<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
         			<select name="cxyear" id="cxyear" class="select_box" style="width:150px;">
         				<option value="">:::선택:::</option>
         				<c:forEach var="i" begin="2018" end="${currTime}">
            			<option value="${i}">${i}</option>
            			</c:forEach>
         			</select>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)관리번호</th>
           		<td colspan="3">
           			<input type="text" name="cxcode" id="cxcode" value="R-" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- 기본정보 E -->
	
	
	<h3 class="tit">- 기획구분</h3>
	<table class="skin_basic_write" >
		<caption>기획구분</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획유형</th>
           		<td colspan="3">
           			
          			<label><input type="radio" name="cxtype1" value="정책연구" checked="checked"> 정책연구</label>
	           		<label><input type="radio" name="cxtype1" value="R&D"> R&D</label>
	           		<label><input type="radio" name="cxtype1" value="비R&D"> 비R&D</label>
	           		<label><input type="radio" name="cxtype1" value="xx"> 기타</label>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획주제</th>
           		<td colspan="3">
           			<label><input type="radio" name="cxtype2" value="자체기획" checked="checked"> 자체기획</label>
	           		<label><input type="radio" name="cxtype2" value="기획과제"> 기획과제</label>
	           		<label><input type="radio" name="cxtype2" value="기획연구회"> 기획연구회</label>
	           		<label><input type="radio" name="cxtype2" value="학술연구용역"> 학술연구용역</label>
	           		<label><input type="radio" name="cxtype2" value="xx"> 기타</label>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 기획지원 기관 및 담당자정보</h3>
	<table class="skin_basic_write" >
		<caption>기획지원 기관 및 담당자정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획명</th>
           		<td>
           			<input type="text" name="cx_cname" id="cx_cname" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서명</th>
           		<td>
           			<input type="text" name="cx_pname" id="cx_pname" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당자</th>
           		<td>
           			<input type="text" name="cx_uname" id="cx_uname" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td>
           			<input type="text" name="cx_spot" id="cx_spot" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전화번호</th>
           		<td>
           			<input type="text" name="cx_tel" id="cx_tel" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 휴대전화</th>
           		<td>
           			<input type="text" name="cx_hp" id="cx_hp" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이메일</th>
           		<td colspan="3">
           			<input type="text" name="mail1_1" id="mail1_1" value="" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="mail1_2" id="mail1_2" value="" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise1" id="emailDomainChoise1" class="select_box" title="이메일주소도메인선택" >
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
   	
   	
   	<h3 class="tit">- 전라남도 담당자정보</h3>
	<table class="skin_basic_write" >
		<caption>전라남도 담당자정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당자유/무</th>
           		<td colspan="3">
           			<label><input type="checkbox" name="cx_xuser" id="cx_xuser" value="1"> 담당자없음</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기관명</th>
           		<td>
           			<input type="text" name="cx_xtext1" id="cx_xtext1" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서(실국)명</th>
           		<td>
           			<input type="text" name="cx_xtext2" id="cx_xtext2" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당과명</th>
           		<td>
           			<input type="text" name="cx_xtext3" id="cx_xtext3" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당자명</th>
           		<td>
           			<input type="text" name="cx_xtext4" id="cx_xtext4" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td>
           			<input type="text" name="cx_xtext5" id="cx_xtext5" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연락처</th>
           		<td>
           			<input type="text" name="cx_xtext6" id="cx_xtext6" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이메일</th>
           		<td colspan="3">
           			<input type="text" name="mail2_1" id="mail2_1" value="" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="mail2_2" id="mail2_2" value="" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise2" id="emailDomainChoise2" class="select_box" title="이메일주소도메인선택" >
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
   	
   	
   	<h3 class="tit">- 기획지원 사업정보</h3>
	<table class="skin_basic_write" >
		<caption>기획지원 사업정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획과제지원 사업명</th>
           		<td colspan="3">
           			<input type="text" name="cx_a1" id="cx_a1" value="" class="inp_txt" style="width:300px;">
           			<label><input type="checkbox" name="cx_a2" value="on" /> 해당없음</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획과제 공고명</th>
           		<td colspan="3">
           			<input type="text" name="cx_a3" id="cx_a3" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 공고기간</th>
           		<td colspan="3">
           			공고시작일 : <input type="text" name="cx_a4" id="cx_a4" value="" class="inp_txt"> ~  
           			공고마감일 : <input type="text" name="cx_a5" id="cx_a5" value="" class="inp_txt">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 선정 및 협약</th>
           		<td colspan="3">
           			기획과제선정일 : <input type="text" name="cx_a6" id="cx_a6" value="" class="inp_txt"> ~  
           			기획과제협약일 : <input type="text" name="cx_a7" id="cx_a7" value="" class="inp_txt">
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 기획기관(기업)정보</h3>
	<table class="skin_basic_write" >
		<caption>기획지원 사업정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획과제명</th>
           		<td>
           			<input type="text" name="cx_b1" id="cx_b1" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기관유형</th>
           		<td>
           			<select name="cx_b2" class="select_box">
           			<%
						for(HashMap sup:agencyList){
					%>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
					<% 
					}
					%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관(기업)명</th>
           		<td>
           			<input type="text" name="cx_b3" id="cx_b3" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서(학과)명</th>
           		<td>
           			<input type="text" name="cx_b4" id="cx_b4" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획총괄책임자</th>
           		<td>
           			<input type="text" name="cx_b5" id="cx_b5" value="" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td>
           			<input type="text" name="cx_b6" id="cx_b6" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전화번호</th>
           		<td colspan="3">
           			<input type="text" name="cx_b7" id="cx_b7" value="" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이메일</th>
           		<td colspan="3">
           			<input type="text" name="mail3_1" id="mail3_1" value="" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="mail3_2" id="mail3_2" value="" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise3" id="emailDomainChoise3" class="select_box" title="이메일주소도메인선택" >
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
   	
   	
   	<h3 class="tit">- 기획기간</h3>
	<table class="skin_basic_write" >
		<caption>기획기간</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획기간</th>
           		<td colspan="3">
           			시작일 : <input type="text" name="cx_c1" id="cx_c1" value="" class="inp_txt">
           			종료일 : <input type="text" name="cx_c2" id="cx_c2" value="" class="inp_txt">
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 기획비</h3>
	<table class="skin_basic_write" >
		<caption>기획기간</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 도비</th>
           		<td>
           			<input type="text" name="cx_d1" id="cx_d1" value="" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군명</th>
           		<td>
           			<input type="text" name="cx_d2" id="cx_d2" value="" class="inp_txt">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
           		<td>
           			<input type="text" name="cx_d3" id="cx_d3" value="" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타기관명</th>
           		<td>
           			<input type="text" name="cx_d4" id="cx_d4" value="" class="inp_txt">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타</th>
           		<td>
           			<input type="text" name="cx_d5" id="cx_d5" value="" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 합계</th>
           		<td>
           			<input type="text" name="cx_d6" id="cx_d6" value="" class="inp_txt read_only" readonly>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획비집행액</th>
           		<td>
           			<input type="text" name="cx_d7" id="cx_d7" value="" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획비정산잔액</th>
           		<td>
           			<input type="text" name="cx_d8" id="cx_d8" value="" class="inp_txt read_only" readonly>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- 기획과제 증빙자료 등록</h3>
	<table class="skin_basic_write" >
		<caption>기획기간</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획과제 협약서</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="1">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" value="">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획보고서 요약서</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="2">
           			<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" value="">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> 기타자료</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="3">
           			<input type="file" name="<%=fileFullGrp%>File3" id="<%=fileFullGrp%>File3" value="">
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
           			<textarea name="cx_comment" rows="5" class="inp_txt" style="width:100%"></textarea>
           		</td>
           	</tr>
    	</tbody>
   	</table>

    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="신청하기"/>
           <input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
    </div>
    <!--// bo_btn -->
</form>


<div style="padding-top:15px"></div>


<input type="hidden" name="cxidx" id="cxidx" value="">


<h2 class="tit">정부사업지원현황</h2>
<div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('addTypeA')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('delTypeA')" />
</div>
<div class="typeAContent">
	<div class="hideBox">
		+버튼으로 지원현황을 추가하세요
	</div>
</div>

<div style="padding-top:15px; clear:both;"></div>

<h2 class="tit">선정과제기본정보</h2>
<div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('addTypeB')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('delTypeB')" />
</div>
<div class="typeBContent">
	<div class="hideBox">
		+버튼으로 선정과제을 추가하세요
	</div>
</div>











<script>

var typeACount = 1;
var typeBCount = 1;



function delRow(mode){
	
	var html = "";
	
	if(mode == "delTypeA"){
		$(".typeAformContent:last").remove();
		typeACount--;
		if(typeACount == 1){
			html += '<div class="hideBox" style="user-select: auto;">+버튼으로 지원현황을 추가하세요</div>';
			$(".typeAContent").append(html);
		}
		
	}else{
		$(".typeBformContent:last").remove();
		typeBCount--;
		if(typeBCount == 1){
			html += '<div class="hideBox" style="user-select: auto;">+버튼으로 선정과제을 추가하세요</div>';
			$(".typeBContent").append(html);
		}
	}
}



//정부사업지원현황
function addRow(mode){
	
	var nCont = typeACount - 1;
	var xCont = typeBCount - 1;
	
	if($("#cxidx").val() == ""){
		alert("기획과제 기본정보를 먼저등록하세요");
		return false;
	}
	
	if(mode == "addTypeA"){ //typeA
		
		
		
		if(typeACount < 6){
			
			var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
			
			if($("select[name='txyear']:last").val() == ""){
				alert("조사연도를 선택하세요");
				$("select[name='txyear']:last").focus();
				return false;
			}
			
			//if($("input[name=txtype]:checked").val() == "접수" ){
			
			
				if($("input[name='txdate']:last").val() == ""){
					alert("사업(과제)신청일을 선택하세요");
					$("input[name='txdate']:last").focus();
					return false;
				}
				if($("input[name='txname']:last").val() == ""){
					alert("제안부처명을 입력하세요");
					$("input[name='txname']:last").focus();
					return false;
				}
				if($("input[name='tx_bname']:last").val() == ""){
					alert("부처사업명을 입력하세요");
					$("input[name='tx_bname']:last").focus();
					return false;
				}
				if($("input[name='tx_cname']:last").val() == ""){
					alert("관리기관명을 입력하세요");
					$("input[name='tx_cname']:last").focus();
					return false;
				}
				if($("input[name='tx_sdate']:last").val() == ""){
					alert("시작일을 입력하세요");
					$("input[name='tx_sdate']:last").focus();
					return false;
				}
				if($("input[name='tx_edate']:last").val() == ""){
					alert("종료일을 입력하세요");
					$("input[name='tx_edate']:last").focus();
					return false;
				}
				
				if($("input[name='tx_price1']:last").val() == ""){
					alert("국비를 입력하세요");
					$("input[name='tx_price1']:last").focus();
					return false;
				}
				if($("input[name='tx_price2']:last").val() == ""){
					alert("도비를 입력하세요");
					$("input[name='tx_price2']:last").focus();
					return false;
				}
				if($("input[name='tx_price3']:last").val() == ""){
					alert("시군비를 입력하세요");
					$("input[name='tx_price3']:last").focus();
					return false;
				}
				if($("input[name='tx_price4']:last").val() == ""){
					alert("기타현금을 입력하세요");
					$("input[name='tx_price4']:last").focus();
					return false;
				}
				if($("input[name='tx_price5']:last").val() == ""){
					alert("현물을 입력하세요");
					$("input[name='tx_price5']:last").focus();
					return false;
				}
				if($("input[name='tx_price5']:last").val() == ""){
					alert("현물을 입력하세요");
					$("input[name='tx_price5']:last").focus();
					return false;
				}
				
				if($("#typeAformContent"+nCont).find("#JnrdtypeaFile1").val() == ""){
					alert("사업공고문을 추가하세요");
					$("#typeAformContent"+nCont).find("#JnrdtypeaFile1").trigger("click");
					return false;
				}
				if($("#typeAformContent"+nCont).find("#JnrdtypeaFile2").val() == ""){
					alert("사업신청서표지를 추가하세요");
					$("#typeAformContent"+nCont).find("#JnrdtypeaFile2").trigger("click");
					return false;
				}
				/* if($("#typeAformContent"+nCont).find("#JnrdtypeaFile3").val() == ""){
					alert("기타자료를 추가하세요");
					$("#typeAformContent"+nCont).find("#JnrdtypeaFile3").trigger("click");
					return false;
				} */
				
				
			//}
			
			/* if($("#typeAformContent"+nCont).find("#JnrdtypeaFile4").val() == ""){
				alert("사업비 확보 노력 현황자료를 추가하세요");
				$("#typeAformContent"+nCont).find("#JnrdtypeaFile4").trigger("click");
				return false;
			} */
			
			
			$.ajax({
	            type: "POST",
	            data: {count:typeACount},
	            url : '/sys/jntisJnrdTypeaAjax.do',
	            dataType : 'HTML',
	            success : function(data){
	            	
	            	alert("사업지원현황이 추가되었습니다.");
	            	$(".typeAContent").append(data);
	            	
	            	$("#tx_sdate"+typeACount+", #tx_edate"+typeACount+", #txdate"+typeACount).datepicker({
	            	   	showMonthAfterYear : true,
	            	   	changeMonth : true,
	            	   	changeYear : true,
	            	   	dateFormat : "yy-mm-dd",
	            	   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	            	   	dayNamesMin : ['일','월','화','수','목','금','토'],
	            	   	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	            	   	onClose: function(dateText, inst) {
	            	   		//var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            	   		//eDateYear = parseInt(year);
	            	   	}
	            	});
	            	
	            	typeACount++;
	            	$(".typeAContent").find(".hideBox").hide();
	            	
	            	       		
	            }
			});
		}else{
			alert("5개까지 등록가능합니다.");
			return false;
		}
		
	}else{ //typeB
		
		$(".typeBContent").find(".hideBox").hide();
		
		if(typeBCount < 6){
			
			if(typeBCount > 1){
				
				if($("select[name='yxyear']:last").val() == ""){
					alert("조사연도를 선택하세요");
					$("select[name='yxyear']:last").focus();
					return false;
				}
				
				if(!$("input[name='yxstatus']:last").is(":checked")){
					
					
					if($("select[name='yx_name']:last").val() == ""){
						alert("지원부처(청)명을 선택하세요");
						$("select[name='yx_name']:last").focus();
						return false;
					}
					if($("input[name='yx_dname']:last").val() == ""){
						alert("부처(전남도)사업명을 선택하세요");
						$("input[name='yx_dname']:last").focus();
						return false;
					}
					if($("input[name='yx_bname']:last").val() == ""){
						alert("과제명을 선택하세요");
						$("input[name='yx_bname']:last").focus();
						return false;
					}
					
					if($("input[name='yx_sdate']:last").val() == ""){
						alert("시작년월일을 입력하세요");
						$("input[name='yx_sdate']:last").focus();
						return false;
					}
					
					if(!$("input[name='ming']:last").is(":checked")){
						
						if($("input[name='yx_edate']:last").val() == ""){
							alert("종료년월일을 입력하세요");
							$("input[name='yx_edate']:last").focus();
							return false;
						}
					}
					
					if($("input[name='yx_price1']:last").val() == ""){
						alert("국비를 입력하세요");
						$("input[name='yx_price1']:last").focus();
						return false;
					}
					if($("input[name='yx_price2']:last").val() == ""){
						alert("도비를 입력하세요");
						$("input[name='yx_price2']:last").focus();
						return false;
					}
					if($("input[name='yx_price3']:last").val() == ""){
						alert("시군비를 입력하세요");
						$("input[name='yx_price3']:last").focus();
						return false;
					}
					if($("input[name='yx_price4']:last").val() == ""){
						alert("기타현금을 입력하세요");
						$("input[name='yx_price4']:last").focus();
						return false;
					}
					if($("input[name='yx_price5']:last").val() == ""){
						alert("현물를 입력하세요");
						$("input[name='yx_price5']:last").focus();
						return false;
					}
					
					
					/* if($("#typeBformContent"+xCont).find("#JnrdtypebFile1").val() == ""){
						alert("사업(과제)계획서 표지를 추가하세요");
						$("#typeBformContent"+xCont).find("#JnrdtypebFile1").trigger("click");
						return false;
					}
					if($("#typeBformContent"+xCont).find("#JnrdtypebFile2").val() == ""){
						alert("사업(과제)협약서를 추가하세요");
						$("#typeBformContent"+xCont).find("#JnrdtypebFile2").trigger("click");
						return false;
					}
					if($("#typeBformContent"+xCont).find("#JnrdtypebFile3").val() == ""){
						alert("기타자료를 추가하세요");
						$("#typeBformContent"+xCont).find("#JnrdtypebFile3").trigger("click");
						return false;
					} */
					
					
					if($("select[name='yx_ctype']:last").val() == ""){
						alert("기관유형을 선택하세요");
						$("select[name='yx_ctype']:last").focus();
						return false;
					}
					if($("input[name='yx_cname']:last").val() == ""){
						alert("관리기관을 선택하세요");
						$("input[name='yx_cname']:last").focus();
						return false;
					}
					if($("input[name='yx_yname']:last").val() == ""){
						alert("주관기관을 선택하세요");
						$("input[name='yx_yname']:last").focus();
						return false;
					}
					
					
					if($("#typeBformContent"+xCont).find("input[name='yx_cont1']:checked").val() == "국외"){
						
						if($("input[name='yx_cont1_text']:last").val() == ""){
							alert("국외명을 입력하세요");
							$("input[name='yx_cont1_text']:last").focus();
							return false;
						}
					}
					
					if($("input[name='yx_cont2']:last").val() == ""){
						alert("소속부서(학과)를 입력하세요");
						$("input[name='yx_cont2']:last").focus();
						return false;
					}
					if($("input[name='yx_cont3']:last").val() == ""){
						alert("소속부서(학과)소재지를 입력하세요");
						$("input[name='yx_cont3']:last").focus();
						return false;
					}
					if($("input[name='yx_cont4']:last").val() == ""){
						alert("연구책임자이름을 입력하세요");
						$("input[name='yx_cont4']:last").focus();
						return false;
					}
					if($("input[name='yx_cont5']:last").val() == ""){
						alert("연구책임자직위를 입력하세요");
						$("input[name='yx_cont5']:last").focus();
						return false;
					}
					
					
					if($("#typeBformContent"+xCont).find("input[name='yx_cont7']:checked").val() == "타시도" || $("#typeBformContent"+xCont).find("input[name='yx_cont7']:checked").val() == "기타"){
						
						if($("input[name='yx_cont8']:last").val() == ""){
							alert("시도를 입력하세요");
							$("input[name='yx_cont8']:last").focus();
							return false;
						}
					}
					
					if($("input[name='yx_hcont1']:last").val() == ""){
						alert("실국/사업소를 입력하세요");
						$("input[name='yx_hcont1']:last").focus();
						return false;
					}
					if($("input[name='yx_hcont2']:last").val() == ""){
						alert("부서(과)를 입력하세요");
						$("input[name='yx_hcont2']:last").focus();
						return false;
					}
					if($("input[name='yx_hcont3']:last").val() == ""){
						alert("담당자이름을 입력하세요");
						$("input[name='yx_hcont3']:last").focus();
						return false;
					}
					if($("input[name='yx_hcont4']:last").val() == ""){
						alert("담당자직위를 입력하세요");
						$("input[name='yx_hcont4']:last").focus();
						return false;
					}
					if($("input[name='yx_hcont5']:last").val() == ""){
						alert("담당자전화번호를 입력하세요");
						$("input[name='yx_hcont5']:last").focus();
						return false;
					}
					if($("input[name='yx_hcont6']:last").val() == ""){
						alert("담당자휴대전화를 입력하세요");
						$("input[name='yx_hcont6']:last").focus();
						return false;
					}
					if($("input[name='yxmail1']:last").val() == "" || $("input[name='yxmail2']:last").val() == ""){
						alert("담당자이메일을 입력하세요");
						$("input[name='yxmail1']:last").focus();
						return false;
					}
					
					
					
					
				}
				
				
			
			}
			
			
			
			$.ajax({
	            type: "POST",
	            data: {count:typeBCount},
	            url : '/sys/jntisJnrdTypebAjax.do',
	            dataType : 'HTML',
	            success : function(data){
	            	
	            	$(".typeBContent").append(data);
	            	
	            	var sDateYear = 0;
	            	var eDateYear = 0;
	            	
	            	
	            	
	            	$("#yx_sdate"+typeBCount).datepicker({
	            	   	showMonthAfterYear : true,
	            	   	changeMonth : true,
	            	   	changeYear : true,
	            	   	dateFormat : "yy-mm-dd",
	            	   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	            	   	dayNamesMin : ['일','월','화','수','목','금','토'],
	            	   	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	            	   	onClose: function(dateText, inst) {
	            	   		var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            	   		sDateYear = parseInt(year);
	            	   	}
	            	});
	            	
	            	$("#yx_edate"+typeBCount).datepicker({
	            	   	showMonthAfterYear : true,
	            	   	changeMonth : true,
	            	   	changeYear : true,
	            	   	dateFormat : "yy-mm-dd",
	            	   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	            	   	dayNamesMin : ['일','월','화','수','목','금','토'],
	            	   	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	            	   	onClose: function(dateText, inst) {
	            	   		var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            	   		eDateYear = parseInt(year);
	            	   		
	            	   		if(sDateYear == ""){
	            				alert("사업기간 시작일을 선택하세요");
	            				$("input[name='yx_sdate']:last").focus();
	            				$("input[name='yx_edate']:last").val("");
	            				return false;
	            			}
	            			var sdate = $("input[name='yx_sdate']:last").val().split("-");
	            			var edate = $("input[name='yx_edate']:last").val().split("-");
	            			var sy = new Date(sdate[0],sdate[1],sdate[2]);
	            			var ey = new Date(edate[0],edate[1],edate[2]);
	            			var dif = ey - sy;
	            			var cDay = 86400*1000;
	            			var cMonth = cDay*30;
	            			var monthTot = parseInt((dif/cMonth));
	            			var xxx = parseInt(typeBCount)-1;
	            			
	            			$("input[name='yx_tmonth']:last").val(monthTot);
	            			$("#yx_tmonth_text"+xxx).html(monthTot+"개월");
	            	   		
	            	   	}
	            	});
	            	
	            	typeBCount++;
	            	       		
	            }
			});
		}else{
			alert("5개까지 등록가능합니다.");
			return false;
		}
		
	}
}



$(document).on("change","input[name='tx_edate']",function(){
	
	if($(this).parents(".typeAformContent").find("input[name='tx_sdate']").val() == ""){
		alert("사업과제시작일을 선택하세요");
		$(this).parents(".typeAformContent").find("input[name='tx_sdate']").focus();
		$(this).parents(".typeAformContent").find("input[name='tx_edate']").val("");
		return false;
	}
	var sdate = $("input[name='tx_sdate']:last").val().split("-");
	var sy = new Date(sdate[0],sdate[1],sdate[2]);
	var ey = new Date($(this).val());
	var dif = ey - sy;
	var cDay = 86400*1000;
	var cMonth = cDay*30;
	var monthTot = parseInt((dif/cMonth)+1);
	
	$("input[name='tx_tmonth']:last").val(monthTot);
	$(this).parents(".typeAformContent").find(".monthTit").html(monthTot+"개월");
});


$(document).on("change","input[name='tx_price1'],input[name='tx_price2'],input[name='tx_price3'],input[name='tx_price4'],input[name='tx_price5']",function(){
	var tp1 = ($(this).parents(".typeAformContent").find("input[name='tx_price1']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price1']").val()):0;
	var tp2 = ($(this).parents(".typeAformContent").find("input[name='tx_price2']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price2']").val()):0;
	var tp3 = ($(this).parents(".typeAformContent").find("input[name='tx_price3']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price3']").val()):0;
	var tp4 = ($(this).parents(".typeAformContent").find("input[name='tx_price4']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price4']").val()):0;
	var tp5 = ($(this).parents(".typeAformContent").find("input[name='tx_price5']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price5']").val()):0;
	
	$(this).parents(".typeAformContent").find("input[name='tx_price6']").val(tp1+tp2+tp3+tp4+tp5);
	
});



//접수정보
$(document).on("change","input[name='txtype']",function(){
	if($(this).val() != "접수"){
		
		//$(this).parents(".typeAformContent").find("input").not("input[name='txtype'], #JnrdtypeaFile4, :button").prop("disabled",true);
				
	}else{
		//$(this).parents(".typeAformContent").find("input").prop("disabled",false);
	}
});

//정부사업지원현황등록
$(document).on("click",".typeainsert",function(){
	
	var formData = new FormData($(this).parents(".typeAformContent").find("form")[0]);
	var $this = $(this);
	
	if($("#cxidx").val() == ""){
		alert("기본정보를 먼저 등록하세요");
		return false;
	}
	
	formData.set("cxidx",$("#cxidx").val());
	
	
	if($(this).parents(".typeAformContent").find("select[name='txyear']").val() == ""){
		alert("조사연도를 선택하세요");
		$(this).parents(".typeAformContent").find("select[name='txyear']").focus();
		return false;
	}
	
	//if($(this).parents(".typeAformContent").find("input[name=txtype]:checked").val() == "접수" ){
	
	
		if($(this).parents(".typeAformContent").find("input[name='txdate']").val() == ""){
			alert("사업(과제)신청일을 선택하세요");
			$(this).parents(".typeAformContent").find("input[name='txdate']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='txname']").val() == ""){
			alert("제안부처명을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='txname']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_bname']").val() == ""){
			alert("부처사업명을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_bname']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_cname']").val() == ""){
			alert("관리기관명을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_cname']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_sdate']").val() == ""){
			alert("시작일을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_sdate']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_edate']").val() == ""){
			alert("종료일을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_edate']").focus();
			return false;
		}
		
		if($(this).parents(".typeAformContent").find("input[name='tx_price1']").val() == ""){
			alert("국비를 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_price1']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_price2']").val() == ""){
			alert("도비를 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_price2']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_price3']").val() == ""){
			alert("시군비를 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_price3']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_price4']").val() == ""){
			alert("기타현금을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_price4']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_price5']").val() == ""){
			alert("현물을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_price5']").focus();
			return false;
		}
		if($(this).parents(".typeAformContent").find("input[name='tx_price5']").val() == ""){
			alert("현물을 입력하세요");
			$(this).parents(".typeAformContent").find("input[name='tx_price5']").focus();
			return false;
		}
		
		if($(this).parents(".typeAformContent").find("#JnrdtypeaFile1").val() == ""){
			alert("사업공고문을 추가하세요");
			$(this).parents(".typeAformContent").find("#JnrdtypeaFile1").trigger("click");
			return false;
		}
		if($(this).parents(".typeAformContent").find("#JnrdtypeaFile2").val() == ""){
			alert("사업신청서표지를 추가하세요");
			$(this).parents(".typeAformContent").find("#JnrdtypeaFile2").trigger("click");
			return false;
		}
		/* if($(this).parents(".typeAformContent").find("#JnrdtypeaFile3").val() == ""){
			alert("기타자료를 추가하세요");
			$(this).parents(".typeAformContent").find("#JnrdtypeaFile3").trigger("click");
			return false;
		} */
		
		
	//}
	
	/*
	if($(this).parents(".typeAformContent").find("#JnrdtypeaFile4").val() == ""){
		alert("사업비 확보 노력 현황자료를 추가하세요");
		$(this).parents(".typeAformContent").find("#JnrdtypeaFile4").trigger("click");
		return false;
	}*/
	
	
	$.ajax({
        cache : false,
        url : "/sys/jntisJnrdTypeaWriteProcAjax.do",
        processData: false,
        contentType: false,
        type : 'POST', 
        data : formData,
        dataType : 'JSON',
        success : function(data) {
        	
        	var tidx = data.paramMap.tidx;
        	
        	if(data.status == "OK" && tidx > 0){
        		
        		alert('지원현황이 등록되었습니다.');
        		$this.removeClass("typeainsert");
        		$this.addClass("typeainsert_off");
        		$this.text("등록완료");
        		$(".typeainsert_off").attr("data-tidx",tidx);
        		
        	}
            
        }, // success
        error : function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
	
	
	
	
	
	
});




//선정과제기본정보등록
$(document).on("click",".typebinsert",function(){
	
	var formData = new FormData($(this).parents(".typeBformContent").find("form")[0]);
	var $this = $(this);
	
	if($("#cxidx").val() == ""){
		alert("기본정보를 먼저 등록하세요");
		return false;
	}
	
	formData.set("cxidx",$("#cxidx").val());
	
	if($(this).parents(".typeBformContent").find("select[name='yxyear']").val() == ""){
		alert("조사연도를 선택하세요");
		$(this).parents(".typeBformContent").find("select[name='yxyear']").focus();
		return false;
	}
	
	if(!$(this).parents(".typeBformContent").find("input[name='yxstatus']").is(":checked")){
		
		
		if($(this).parents(".typeBformContent").find("select[name='yx_name']").val() == ""){
			alert("지원부처(청)명을 선택하세요");
			$(this).parents(".typeBformContent").find("select[name='yx_name']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_dname']").val() == ""){
			alert("부처(전남도)사업명을 선택하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_dname']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_bname']").val() == ""){
			alert("과제명을 선택하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_bname']").focus();
			return false;
		}
		
		if($(this).parents(".typeBformContent").find("input[name='yx_sdate']").val() == ""){
			alert("시작년월일을 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_sdate']").focus();
			return false;
		}
		
		if(!$(this).parents(".typeBformContent").find("input[name='ming']").is(":checked")){
			
			if($(this).parents(".typeBformContent").find("input[name='yx_edate']").val() == ""){
				alert("종료년월일을 입력하세요");
				$(this).parents(".typeBformContent").find("input[name='yx_edate']").focus();
				return false;
			}
		
		}
		
		if($(this).parents(".typeBformContent").find("input[name='yx_price1']").val() == ""){
			alert("국비를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_price1']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_price2']").val() == ""){
			alert("도비를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_price2']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_price3']").val() == ""){
			alert("시군비를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_price3']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_price4']").val() == ""){
			alert("기타현금을 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_price4']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_price5']").val() == ""){
			alert("현물를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_price5']").focus();
			return false;
		}
		
		/* if($(this).parents(".typeBformContent").find("#JnrdtypebFile1").val() == ""){
			alert("사업(과제)계획서 표지를 추가하세요");
			$(this).parents(".typeBformContent").find("#JnrdtypebFile1").trigger("click");
			return false;
		}
		if($(this).parents(".typeBformContent").find("#JnrdtypebFile2").val() == ""){
			alert("사업(과제)협약서를 추가하세요");
			$(this).parents(".typeBformContent").find("#JnrdtypebFile2").trigger("click");
			return false;
		}
		if($(this).parents(".typeBformContent").find("#JnrdtypebFile3").val() == ""){
			alert("기타자료를 추가하세요");
			$(this).parents(".typeBformContent").find("#JnrdtypebFile3").trigger("click");
			return false;
		} */
		
		
		if($(this).parents(".typeBformContent").find("select[name='yx_ctype']").val() == ""){
			alert("기관유형을 선택하세요");
			$(this).parents(".typeBformContent").find("select[name='yx_ctype']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_cname']").val() == ""){
			alert("관리기관을 선택하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_cname']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_yname']").val() == ""){
			alert("주관기관을 선택하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_yname']").focus();
			return false;
		}
		
		
		if($(this).parents(".typeBformContent").find("input[name='yx_cont1']:checked").val() == "국외"){
			
			if($(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").val() == ""){
				alert("국외명을 입력하세요");
				$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").focus();
				return false;
			}
		}
		
		if($(this).parents(".typeBformContent").find("input[name='yx_cont2']").val() == ""){
			alert("소속부서(학과)를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_cont2']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_cont3']").val() == ""){
			alert("소속부서(학과)소재지를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_cont3']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_cont4']").val() == ""){
			alert("연구책임자이름을 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_cont4']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_cont5']").val() == ""){
			alert("연구책임자직위를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_cont5']").focus();
			return false;
		}
		
		
		if($(this).parents(".typeBformContent").find("input[name='yx_cont7']:checked").val() == "타시도" || $(this).parents(".typeBformContent").find("input[name='yx_cont7']:checked").val() == "기타"){
			
			if($(this).parents(".typeBformContent").find("input[name='yx_cont8']").val() == ""){
				alert("시도를 입력하세요");
				$(this).parents(".typeBformContent").find("input[name='yx_cont8']").focus();
				return false;
			}
		}
		
		/* if($(this).parents(".typeBformContent").find("input[name='yx_hcont1']").val() == ""){
			alert("실국/사업소를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_hcont1']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_hcont2']").val() == ""){
			alert("부서(과)를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_hcont2']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_hcont3']").val() == ""){
			alert("담당자이름을 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_hcont3']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_hcont4']").val() == ""){
			alert("담당자직위를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_hcont4']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_hcont5']").val() == ""){
			alert("담당자전화번호를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_hcont5']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yx_hcont6']").val() == ""){
			alert("담당자휴대전화를 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_hcont6']").focus();
			return false;
		}
		if($(this).parents(".typeBformContent").find("input[name='yxmail1']").val() == "" || $(this).parents(".typeBformContent").find("input[name='yxmail2']").val() == ""){
			alert("담당자이메일을 입력하세요");
			$(this).parents(".typeBformContent").find("input[name='yxmail1']").focus();
			return false;
		} */
		
		
	}
	
	
	
	//11111111111111
	$.ajax({
        cache : false,
        url : "/sys/jntisJnrdTypebWriteProcAjax.do",
        processData: false,
        contentType: false,
        type : 'POST', 
        data : formData,
        dataType : 'JSON',
        success : function(data) {
        	
        	var tidx = data.paramMap.tidx;
        	
        	if(data.status == "OK" && tidx > 0){
        		
        		alert('선정과제가 등록되었습니다.');
        		$this.removeClass("typebinsert");
        		$this.addClass("typebinsert_off");
        		$this.val("등록완료");
        		$(".typebinsert_off").attr("data-tidx",tidx);
        		
        		$this.parents(".typeBformContent").find("input, option, textarea").prop("disabled",true);
        		
        	}
            
        }, // success
        error : function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
	
	
	
	
	
	
});




$("select[name='cxyear']").on("change",function(){
	var year = $(this).val();
	if(year != ""){
		//코드번호생성ddd
        $.ajax({
            type: "POST",
            data: {year:year},
            url : '/sys/jntisJnrdCxCodeAjax.do',
            dataType : 'json',
            success : function(data){	            	
            	if(data.dataList != null){
            		xNum = String(data.dataList.IDX).padStart(5,"0");
            		$("#cxcode").val(year+"-R-"+xNum);
            	}else{
            		$("#cxcode").val(year+"-R-00001");
            	}           		
            }
		}); 
	}
});



function goSubmit(mode,proState){
	$('#mode').val(mode);
	$('#fwrite').submit();
}

$(document).on("click",".btn_inp_b_01",function(){
	
	var formData = new FormData($("#fwrite")[0]);
	var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx|xls)$";
    var fileCount = $("input[type=file]").length;
    var $this = $(this);
    
    formData.set("mode","writeProc");
	
	
	if($("select[name='cxyear']").val() == ""){
		alert("지원과제지원연도를 선택하세요");
		$("select[name='cxyear']").focus();
		return false;
	}
	
	if($("input[name='cx_cname']").val() == ""){
		alert("기획명을 입력하세요");
		$("input[name='cx_cname']").focus();
		return false;
	}
	
	if($("input[name='cx_pname']").val() == ""){
		alert("부서명을 입력하세요");
		$("input[name='cx_pname']").focus();
		return false;
	}
	
	if($("input[name='cx_uname']").val() == ""){
		alert("담당자를 입력하세요");
		$("input[name='cx_uname']").focus();
		return false;
	}
	if($("input[name='cx_spot']").val() == ""){
		alert("직위를 입력하세요");
		$("input[name='cx_spot']").focus();
		return false;
	}
	if($("input[name='cx_tel']").val() == ""){
		alert("전화번호를 입력하세요");
		$("input[name='cx_tel']").focus();
		return false;
	}
	if($("input[name='cx_hp']").val() == ""){
		alert("휴대전화를 입력하세요");
		$("input[name='cx_hp']").focus();
		return false;
	}
	if($("input[name='mail1_1']").val() == "" || $("input[name='mail1_2']").val() == ""){
		alert("기획지원 기관 및 담당자 이메일을 입력하세요");
		$("input[name='mail1_1']").focus();
		return false;
	}
	
	
	
	if(!$("#cx_xuser").is(":checked")){
		
		if($("input[name='cx_xtext1']").val() == ""){
			alert("기관명을 입력하세요");
			$("input[name='cx_xtext1']").focus();
			return false;
		}
		if($("input[name='cx_xtext2']").val() == ""){
			alert("부서(실국)명을 입력하세요");
			$("input[name='cx_xtext2']").focus();
			return false;
		}
		if($("input[name='cx_xtext3']").val() == ""){
			alert("담당과명을 입력하세요");
			$("input[name='cx_xtext3']").focus();
			return false;
		}
		if($("input[name='cx_xtext4']").val() == ""){
			alert("담당자명을 입력하세요");
			$("input[name='cx_xtext4']").focus();
			return false;
		}
		if($("input[name='cx_xtext5']").val() == ""){
			alert("직위를 입력하세요");
			$("input[name='cx_xtext5']").focus();
			return false;
		}
		if($("input[name='cx_xtext6']").val() == ""){
			alert("연락처를 입력하세요");
			$("input[name='cx_xtext6']").focus();
			return false;
		}
		if($("input[name='mail2_1']").val() == "" || $("input[name='mail2_2']").val() == ""){
			alert("전라남도 담당자 이메일을 입력하세요");
			$("input[name='mail2_1']").focus();
			return false;
		}
	
	}
	
	
	if(!$("input[name='cx_a2']").is(":checked")){
		
		if($("input[name='cx_a1']").val() == ""){
			alert("기획과제지원 사업명을 입력하세요");
			$("input[name='cx_a1']").focus();
			return false;
		}
		if($("input[name='cx_a2']").val() == ""){
			alert("기획과제 공고명을 입력하세요");
			$("input[name='cx_a2']").focus();
			return false;
		}
		if($("input[name='cx_a3']").val() == ""){
			alert("공고시작일을 입력하세요");
			$("input[name='cx_a3']").focus();
			return false;
		}
		if($("input[name='cx_a4']").val() == ""){
			alert("공고마감일을 입력하세요");
			$("input[name='cx_a4']").focus();
			return false;
		}
		if($("input[name='cx_a5']").val() == ""){
			alert("기획과제선정일을 입력하세요");
			$("input[name='cx_a5']").focus();
			return false;
		}
		if($("input[name='cx_a6']").val() == ""){
			alert("기획과제협약일을 입력하세요");
			$("input[name='cx_a6']").focus();
			return false;
		}
	
	}
	
	
	if($("input[name='cx_b1']").val() == ""){
		alert("기획과제명을 입력하세요");
		$("input[name='cx_b1']").focus();
		return false;
	}
	if($("select[name='cx_b2']").val() == ""){
		alert("기관유형을 입력하세요");
		$("select[name='cx_b2']").focus();
		return false;
	}
	if($("input[name='cx_b3']").val() == ""){
		alert("주관기관(기업)명을 입력하세요");
		$("input[name='cx_b3']").focus();
		return false;
	}
	if($("input[name='cx_b4']").val() == ""){
		alert("부서(학과)명을 입력하세요");
		$("input[name='cx_b4']").focus();
		return false;
	}
	if($("input[name='cx_b5']").val() == ""){
		alert("기획총괄책임자을 입력하세요");
		$("input[name='cx_b5']").focus();
		return false;
	}
	if($("input[name='cx_b6']").val() == ""){
		alert("직위을 입력하세요");
		$("input[name='cx_b6']").focus();
		return false;
	}
	if($("input[name='cx_b7']").val() == ""){
		alert("전화번호을 입력하세요");
		$("input[name='cx_b7']").focus();
		return false;
	}
	if($("input[name='mail3_1']").val() == "" || $("input[name='mail3_2']").val() == ""){
		alert("기획기관(기업)이메일을 입력하세요");
		$("input[name='mail3_1']").focus();
		return false;
	}
	
	
	
	if($("input[name='cx_c1']").val() == ""){
		alert("기획시작일을 입력하세요");
		$("input[name='cx_c1']").focus();
		return false;
	}
	if($("input[name='cx_c2']").val() == ""){
		alert("기획종료일을 입력하세요");
		$("input[name='cx_c2']").focus();
		return false;
	}
	
	
	
	
	if($("input[name='cx_d1']").val() == ""){
		alert("도비를 입력하세요");
		$("input[name='cx_d1']").focus();
		return false;
	}
	if($("input[name='cx_d2']").val() == ""){
		alert("시군명을 입력하세요");
		$("input[name='cx_d2']").focus();
		return false;
	}
	if($("input[name='cx_d3']").val() == ""){
		alert("시군비를 입력하세요");
		$("input[name='cx_d3']").focus();
		return false;
	}
	if($("input[name='cx_d4']").val() == ""){
		alert("기타기관명을 입력하세요");
		$("input[name='cx_d4']").focus();
		return false;
	}
	if($("input[name='cx_d5']").val() == ""){
		alert("기타비를 입력하세요");
		$("input[name='cx_d5']").focus();
		return false;
	}	
	if($("input[name='cx_d7']").val() == ""){
		alert("기획비집행액을 입력하세요");
		$("input[name='cx_d7']").focus();
		return false;
	}
	
	
	
	
	
	if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File1").val()) && $('#<%=fileFullGrp%>File1').val() != ""){

	}else if($("#<%=fileFullGrp%>File1").val() == ""){
		alert("기획과제 협약서 파일을 첨부하세요.");
		return false;
	}else{
		alert("문서 파일만 첨부하실 수 있습니다.");
		return false;
	}
	
	if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File2").val()) && $('#<%=fileFullGrp%>File2').val() != ""){

	}else if($("#<%=fileFullGrp%>File2").val() == ""){
		alert("기획보고서 요약서 파일을 첨부하세요.");
		return false;
	}else{
		alert("문서 파일만 첨부하실 수 있습니다.");
		return false;
	}
	
	<%-- if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File3").val()) && $('#<%=fileFullGrp%>File3').val() != ""){

	}else if($("#<%=fileFullGrp%>File3").val() == ""){
		alert("기타자료 파일을 첨부하세요.");
		return false;
	}else{
		alert("문서 파일만 첨부하실 수 있습니다.");
		return false;
	} --%>

	
	
    
	
	
	//goSubmit('writeProc','10');
	
	$.ajax({
        cache : false,
        url : "/sys/jntisJnrd_cx.do",
        processData: false,
        contentType: false,
        type : 'POST', 
        data : formData,
        dataType : 'JSON',
        success : function(data) {
        	
        	var cxidx = data.paramMap.cxidx;
        	
        	if(data.status == "OK" && cxidx > 0){
        		
        		alert('기본정보가 저장되었습니다.');
        		$this.removeClass("btn_inp_b_01");
        		$this.addClass("btn_inp_w_01");
        		$this.val("등록완료");
        		
        		$(".skin_basic_write").find("input").prop("disabled",true);
        		$(".skin_basic_write").find("option").prop("disabled",true);
        		$(".skin_basic_write").find("textarea").prop("disabled",true);
        		
        		$("#cxidx").val(cxidx);
        		
        		
        		
        		
        		
        		
        	}
            
        }, // success
        error : function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
	
	
	
	
	
});



$("#cx_d1,#cx_d3,#cx_d5").on("change",function(){
	var cd1 = ($("#cx_d1").val() != "")?parseInt($("#cx_d1").val()):0;
	var cd3 = ($("#cx_d3").val() != "")?parseInt($("#cx_d3").val()):0;
	var cd5 = ($("#cx_d5").val() != "")?parseInt($("#cx_d5").val()):0;
	var cd7 = ($("#cx_d7").val() != "")?parseInt($("#cx_d7").val()):0;
	
	$("#cx_d6").val(cd1+cd3+cd5);
	
});


$("#cx_d7").on("change",function(){
	
	var cd6 = ($("#cx_d6").val() != "")?parseInt($("#cx_d6").val()):0;
	var cd7 = parseInt($(this).val());
	
	
	$("#cx_d8").val(cd6-cd7);
	
});



$("input[name='cx_a2']").on("click",function(){
	if($(this).is(":checked")){
		$("#cx_a1, #cx_a3, #cx_a4, #cx_a5, #cx_a6, #cx_a7").prop("disabled",true);
	}else{
		$("#cx_a1, #cx_a3, #cx_a4, #cx_a5, #cx_a6, #cx_a7").prop("disabled",false);
	}
});


$("input[name='cx_xuser']").on("click",function(){
	if($(this).is(":checked")){
		$("#cx_xtext1, #cx_xtext2, #cx_xtext3, #cx_xtext4, #cx_xtext5, #cx_xtext6, #mail2_1, #mail2_2").prop("disabled",true);
		$("#emailDomainChoise2 option").prop("disabled",true);
	}else{
		$("#cx_xtext1, #cx_xtext2, #cx_xtext3, #cx_xtext4, #cx_xtext5, #cx_xtext6, #mail2_1, #mail2_2").prop("disabled",false);
		$("#emailDomainChoise2 option").prop("disabled",false);
	}
});



$(document).on("click","input[name='yxstatus']",function(){
	if($(this).is(":checked")){
		
		$(this).parents(".typeBformContent").find("input, option").not($(this)).prop("disabled",true);
		$(this).parents(".typeBformContent").find("#yxyear option").prop("disabled",false);
		$(this).parents(".typeBformContent").find(":button, input[name='fileSn']").prop("disabled",false);
	}else{
		$(this).parents(".typeBformContent").find("input, option").not($(this)).prop("disabled",false);
	}
});





$("#emailDomainChoise1").change(function() {
	if(this.value==""){
		$("#mail1_2").css("background-color","");
		$("#mail1_2").removeAttr("readonly");
		$("#mail1_2").val("");
	}else{
		$("#mail1_2").val(this.value);
		$("#mail1_2").css("background-color", "#EEEEEE");
		$("#mail1_2").attr("readonly", true);
	}
});
$("#emailDomainChoise2").change(function() {
	if(this.value==""){
		$("#mail2_2").css("background-color","");
		$("#mail2_2").removeAttr("readonly");
		$("#mail2_2").val("");
	}else{
		$("#mail2_2").val(this.value);
		$("#mail2_2").css("background-color", "#EEEEEE");
		$("#mail2_2").attr("readonly", true);
	}
});
$("#emailDomainChoise3").change(function() {
	if(this.value==""){
		$("#mail3_2").css("background-color","");
		$("#mail3_2").removeAttr("readonly");
		$("#mail3_2").val("");
	}else{
		$("#mail3_2").val(this.value);
		$("#mail3_2").css("background-color", "#EEEEEE");
		$("#mail3_2").attr("readonly", true);
	}
});


$("#cx_a4, #cx_a5, #cx_a6, #cx_a7, #cx_c1, #cx_c2").datepicker({
   	showMonthAfterYear : true,
   	changeMonth : true,
   	changeYear : true,
   	dateFormat : "yy-mm-dd",
   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
   	dayNamesMin : ['일','월','화','수','목','금','토'],
   	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
   	onClose: function(dateText, inst) {
   		var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
   		eDateYear = parseInt(year);
   	}
});


$(document).on("click","input[name='yx_cont1']",function(){
	if($(this).val() == "전라남도외"){
		
		$(this).parents(".typeBformContent").find("select[name='yx_cont1_text']").show();
		$(this).parents(".typeBformContent").find("select[name='yx_cont1_text']").prop("disabled",false);
		
		$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").hide();
		$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").prop("disabled",true);
		
	}else if($(this).val() == "국외"){
		
		$(this).parents(".typeBformContent").find("select[name='yx_cont1_text']").hide();
		$(this).parents(".typeBformContent").find("select[name='yx_cont1_text']").prop("disabled",true);
		
		$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").show();
		$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").prop("disabled",false);
		
	}else{
		
		$(this).parents(".typeBformContent").find("select[name='yx_cont1_text']").hide();
		$(this).parents(".typeBformContent").find("select[name='yx_cont1_text']").prop("disabled",true);
		
		$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").hide();
		$(this).parents(".typeBformContent").find("input[name='yx_cont1_text']").prop("disabled",true);
		
	}
});

//ㅇㅇㅇㅇㅇㅇㅇ
$(document).on("click","input[name='yx_cont7']",function(){
	if($(this).val() == "전라남도시군"){
		$(this).parents(".typeBformContent").find("select[name='yx_cont8']").show();
		$(this).parents(".typeBformContent").find("select[name='yx_cont8']").prop("disabled",false);
		
		$(this).parents(".typeBformContent").find("input[name='yx_cont8']").hide();
		$(this).parents(".typeBformContent").find("input[name='yx_cont8']").prop("disabled",true);
		
	}else if($(this).val() == "타시도" || $(this).val() == "기타"){
		
		$(this).parents(".typeBformContent").find("select[name='yx_cont8']").hide();
		$(this).parents(".typeBformContent").find("select[name='yx_cont8']").prop("disabled",true);
		
		$(this).parents(".typeBformContent").find("input[name='yx_cont8']").show();
		$(this).parents(".typeBformContent").find("input[name='yx_cont8']").prop("disabled",false);
		
	}else{
		
		$(this).parents(".typeBformContent").find("select[name='yx_cont8']").hide();
		$(this).parents(".typeBformContent").find("select[name='yx_cont8']").prop("disabled",true);
		
		$(this).parents(".typeBformContent").find("input[name='yx_cont8']").hide();
		$(this).parents(".typeBformContent").find("input[name='yx_cont8']").prop("disabled",true);
		
	}
});


$(document).on("change","input[name='yx_price1'],input[name='yx_price2'],input[name='yx_price3'],input[name='yx_price4'],input[name='yx_price5']",function(){
	
	var yp1 = ($(this).parents(".typeBformContent").find("input[name='yx_price1']").val() != "")?parseInt($(this).parents(".typeBformContent").find("input[name='yx_price1']").val()):0;
	var yp2 = ($(this).parents(".typeBformContent").find("input[name='yx_price2']").val() != "")?parseInt($(this).parents(".typeBformContent").find("input[name='yx_price2']").val()):0;
	var yp3 = ($(this).parents(".typeBformContent").find("input[name='yx_price3']").val() != "")?parseInt($(this).parents(".typeBformContent").find("input[name='yx_price3']").val()):0;
	var yp4 = ($(this).parents(".typeBformContent").find("input[name='yx_price4']").val() != "")?parseInt($(this).parents(".typeBformContent").find("input[name='yx_price4']").val()):0;
	var yp5 = ($(this).parents(".typeBformContent").find("input[name='yx_price5']").val() != "")?parseInt($(this).parents(".typeBformContent").find("input[name='yx_price5']").val()):0;
	
	$(this).parents(".typeBformContent").find("input[name='yx_price6']").val(yp1+yp2+yp3+yp4+yp5);
	
});



$(document).on("click","input[name='ming']",function(){
	
	var toDate = new Date();
	var toDateYear = toDate.getFullYear();
	
	if($(this).is(":checked")){
		
		eDateYear = parseInt(toDateYear);
		
		$(this).parents(".typeBformContent").find("input[name='yx_edate']").val(null);
		$(this).parents(".typeBformContent").find("input[name='yx_edate']").prop("disabled",true);
		$(this).parents(".typeBformContent").find("input[name='yx_tmonth']").prop("disabled",true);;
		$(this).parents(".typeBformContent").find(".yx_tmonth_text").html("연차계속");
	}else{
		eDateYear = "";
		$(this).parents(".typeBformContent").find("input[name='yx_edate']").attr("disabled",false);
		$(this).parents(".typeBformContent").find(".yx_tmonth_text").html("");
	}		
});


$(document).on("change","#emailDomainChoise",function() {
	if(this.value==""){
		$(this).parents(".typeBformContent").find("#yxmail2").css("background-color","");
		$(this).parents(".typeBformContent").find("#yxmail2").removeAttr("readonly");
		$(this).parents(".typeBformContent").find("#yxmail2").val("");
	}else{
		$(this).parents(".typeBformContent").find("#yxmail2").val(this.value);
		$(this).parents(".typeBformContent").find("#yxmail2").css("background-color", "#EEEEEE");
		$(this).parents(".typeBformContent").find("#yxmail2").attr("readonly", true);
	}
});


</script>








