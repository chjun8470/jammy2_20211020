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
   
   

	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	ArrayList<HashMap<String, String>> agencyList = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
	
	ArrayList<HashMap<String, String>> cxTypeAList = request.getAttribute("cxTypeAList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cxTypeAList");
	ArrayList<HashMap<String, String>> cxTypeBList = request.getAttribute("cxTypeBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cxTypeBList");
	


   String mode = util.getStr(paramMap.get("mode"));
   String nowPage = util.getStr(paramMap.get("nowPage"));
   String userIdx = util.getStr(paramMap.get("userIdx"));
   if("".equals(mode)) mode = "write";

   String fileGrp = "Jnrdcx";
   String fileSubGrp = "";
   String fileFullGrp =fileGrp+fileSubGrp;

   int scCnt = 0;
   
   pageContext.setAttribute("cxyearX", util.getStr(dataMap.get("CX_YEAR")));

       
       
%>

<style>
.hideBox{clear:both; border:1px solid #ddd; color:#999; font-size:14px; margin-bottom:15px; padding:30px 20px; text-align:center;}
</style>


<jsp:useBean id="currTime" class="java.util.Date" />
<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />

<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	
	<input type="hidden" name="cxIdx" id="cxIdx" value="<%=util.getStr(String.valueOf(dataMap.get("IDX"))) %>" />
	
	<div class="skin_bbs_write" style="margin-top: 30px">
	
	<p style="color:red;"><span style="color:red;" >*</span>) 필수 입력사항입니다.</p>
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
           			
          			
          			<select name="cxyear" id="cxyear" class="select_box" style="width:150px;">
         				<option value="">:::선택:::</option>
         				<c:forEach var="i" begin="2018" end="${currTime}">
         				<option value="${i}" <c:if test="${i eq cxyearX}">selected</c:if>>${i}</option>
            			</c:forEach>
         			</select>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)관리번호</th>
           		<td colspan="3">
           			<input type="text" name="cxcode" id="cxcode" value="<%=util.getStr(dataMap.get("CX_CODE")) %>" class="inp_txt read_only" readonly style="width:300px;">
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
           			
          			<label><input type="radio" name="cxtype1" value="정책연구" <%=(util.getStr(dataMap.get("CX_TYPE1")).equals("정책연구") || util.getStr(dataMap.get("CX_TYPE1")).equals(""))?"checked":""%>> 정책연구</label>
	           		<label><input type="radio" name="cxtype1" value="R&D" <%=(util.getStr(dataMap.get("CX_TYPE1")).equals("R&D"))?"checked":""%>> R&D</label>
	           		<label><input type="radio" name="cxtype1" value="비R&D" <%=(util.getStr(dataMap.get("CX_TYPE1")).equals("비R&D"))?"checked":""%>> 비R&D</label>
	           		<label><input type="radio" name="cxtype1" value="xx" <%=(util.getStr(dataMap.get("CX_TYPE1")).equals("xx"))?"checked":""%>> 기타</label>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획주제</th>
           		<td colspan="3">
           			<label><input type="radio" name="cxtype2" value="자체기획" <%=(util.getStr(dataMap.get("CX_TYPE2")).equals("자체기획") || util.getStr(dataMap.get("CX_TYPE2")).equals(""))?"checked":""%>> 자체기획</label>
	           		<label><input type="radio" name="cxtype2" value="기획과제" <%=(util.getStr(dataMap.get("CX_TYPE2")).equals("기획과제"))?"checked":""%>> 기획과제</label>
	           		<label><input type="radio" name="cxtype2" value="기획연구회" <%=(util.getStr(dataMap.get("CX_TYPE2")).equals("기획연구회"))?"checked":""%>> 기획연구회</label>
	           		<label><input type="radio" name="cxtype2" value="학술연구용역" <%=(util.getStr(dataMap.get("CX_TYPE2")).equals("학술연구용역"))?"checked":""%>> 학술연구용역</label>
	           		<label><input type="radio" name="cxtype2" value="xx" <%=(util.getStr(dataMap.get("CX_TYPE2")).equals("xx"))?"checked":""%>> 기타</label>
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
           			<input type="text" name="cx_cname" id="cx_cname" value="<%=util.getStr(dataMap.get("CX_CNAME")) %>" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서명</th>
           		<td>
           			<input type="text" name="cx_pname" id="cx_pname" value="<%=util.getStr(dataMap.get("CX_PNAME")) %>" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당자</th>
           		<td>
           			<input type="text" name="cx_uname" id="cx_uname" value="<%=util.getStr(dataMap.get("CX_UNAME")) %>" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td>
           			<input type="text" name="cx_spot" id="cx_spot" value="<%=util.getStr(dataMap.get("CX_SPOT")) %>" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전화번호</th>
           		<td>
           			<input type="text" name="cx_tel" id="cx_tel" value="<%=util.getStr(dataMap.get("CX_TEL")) %>" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 휴대전화</th>
           		<td>
           			<input type="text" name="cx_hp" id="cx_hp" value="<%=util.getStr(dataMap.get("CX_HP")) %>" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이메일</th>
           		<td colspan="3">
           		<%
           		String[] mail1 = util.getStr(dataMap.get("CX_MAIL1")).split("@");
           		%>
           			<input type="text" name="mail1_1" id="mail1_1" value="<%=mail1[0]%>" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="mail1_2" id="mail1_2" value="<%=mail1[1]%>" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise1" id="emailDomainChoise1" class="select_box" title="이메일주소도메인선택" >
						<option value="">직접입력</option>
						<option value="gmail.com" <%=(mail1[1].equals("gmail.com"))?"selected":""%>>지메일</option>
						<option value="empal.com" <%=(mail1[1].equals("empal.com"))?"selected":""%>>엠파스</option>
						<option value="naver.com" <%=(mail1[1].equals("naver.com"))?"selected":""%>>네이버</option>
						<option value="hanmail.net" <%=(mail1[1].equals("hanmail.net"))?"selected":""%>>다음</option>
						<option value="hotmail.com" <%=(mail1[1].equals("hotmail.com"))?"selected":""%>>핫메일</option>
						<option value="yahoo.co.kr" <%=(mail1[1].equals("yahoo.co.kr"))?"selected":""%>>야후</option>
						<option value="nate.com" <%=(mail1[1].equals("nate.com"))?"selected":""%>>네이트</option>
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
           			<label><input type="checkbox" name="cx_xuser" id="cx_xuser" value="1" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"checked":""%>> 담당자없음</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기관명</th>
           		<td>
           			<input type="text" name="cx_xtext1" id="cx_xtext1" value="<%=util.getStr(dataMap.get("CX_XTEXT1"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서(실국)명</th>
           		<td>
           			<input type="text" name="cx_xtext2" id="cx_xtext2" value="<%=util.getStr(dataMap.get("CX_XTEXT2"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당과명</th>
           		<td>
           			<input type="text" name="cx_xtext3" id="cx_xtext3" value="<%=util.getStr(dataMap.get("CX_XTEXT3"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당자명</th>
           		<td>
           			<input type="text" name="cx_xtext4" id="cx_xtext4" value="<%=util.getStr(dataMap.get("CX_XTEXT4"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td>
           			<input type="text" name="cx_xtext5" id="cx_xtext5" value="<%=util.getStr(dataMap.get("CX_XTEXT5"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연락처</th>
           		<td>
           			<input type="text" name="cx_xtext6" id="cx_xtext6" value="<%=util.getStr(dataMap.get("CX_XTEXT6"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이메일</th>
           		<td colspan="3">
           		<%
           		String mail2_1 = "";
           		String mail2_2 = "";
           		
           		if(!util.getStr(dataMap.get("CX_MAIL2")).equals("@")){
           			
           			String[] mail2 = util.getStr(dataMap.get("CX_MAIL2")).split("@");
           			
           			mail2_1 = mail2[0];
           			mail2_2 = mail2[1];
           		}
           		
           		%>
           			<input type="text" name="mail2_1" id="mail2_1" value="<%=mail2_1%>" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>> @
					<input type="text" name="mail2_2" id="mail2_2" value="<%=mail2_2%>" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인" <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
					<select name="emailDomainChoise2" id="emailDomainChoise2" class="select_box" title="이메일주소도메인선택"  <%=(util.getStr(dataMap.get("CX_XUSER")).equals("1"))?"disabled":""%>>
						<option value="">직접입력</option>
						<option value="gmail.com" <%=(mail2_2.equals("gmail.com"))?"selected":""%>>지메일</option>
						<option value="empal.com" <%=(mail2_2.equals("empal.com"))?"selected":""%>>엠파스</option>
						<option value="naver.com" <%=(mail2_2.equals("naver.com"))?"selected":""%>>네이버</option>
						<option value="hanmail.net" <%=(mail2_2.equals("hanmail.net"))?"selected":""%>>다음</option>
						<option value="hotmail.com" <%=(mail2_2.equals("hotmail.com"))?"selected":""%>>핫메일</option>
						<option value="yahoo.co.kr" <%=(mail2_2.equals("yahoo.co.kr"))?"selected":""%>>야후</option>
						<option value="nate.com" <%=(mail2_2.equals("nate.com"))?"selected":""%>>네이트</option>
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
           			<input type="text" name="cx_a1" id="cx_a1" value="<%=util.getStr(dataMap.get("CX_A1"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"disabled":""%>>
           			<label><input type="checkbox" name="cx_a2" value="on" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"checked":""%> /> 해당없음</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획과제 공고명</th>
           		<td colspan="3">
           			<input type="text" name="cx_a3" id="cx_a3" value="<%=util.getStr(dataMap.get("CX_A3"))%>" class="inp_txt" style="width:300px;" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"disabled":""%>>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 공고기간</th>
           		<td colspan="3">
           			공고시작일 : <input type="text" name="cx_a4" id="cx_a4" value="<%=util.getStr(String.valueOf(dataMap.get("CX_A4")))%>" class="inp_txt" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"disabled":""%>> ~  
           			공고마감일 : <input type="text" name="cx_a5" id="cx_a5" value="<%=util.getStr(String.valueOf(dataMap.get("CX_A5")))%>" class="inp_txt" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"disabled":""%>>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 선정 및 협약</th>
           		<td colspan="3">
           			기획과제선정일 : <input type="text" name="cx_a6" id="cx_a6" value="<%=util.getStr(String.valueOf(dataMap.get("CX_A6")))%>" class="inp_txt" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"disabled":""%>> ~  
           			기획과제협약일 : <input type="text" name="cx_a7" id="cx_a7" value="<%=util.getStr(String.valueOf(dataMap.get("CX_A7")))%>" class="inp_txt" <%=(util.getStr(dataMap.get("CX_A2")).equals("on"))?"disabled":""%>>
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
           			<input type="text" name="cx_b1" id="cx_b1" value="<%=util.getStr(dataMap.get("CX_B1"))%>" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기관유형</th>
           		<td>
           			<select name="cx_b2" class="select_box">
           			<%
						for(HashMap sup:agencyList){
					%>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>" <% if(util.getStr(dataMap.get("CX_B2")).equals(util.getStr(sup.get("CODE_NM")))){ %>selected<% } %> ><%=util.getStr(sup.get("CODE_NM"))%></option>
					<% 
					}
					%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관(기업)명</th>
           		<td>
           			<input type="text" name="cx_b3" id="cx_b3" value="<%=util.getStr(dataMap.get("CX_B3"))%>" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서(학과)명</th>
           		<td>
           			<input type="text" name="cx_b4" id="cx_b4" value="<%=util.getStr(dataMap.get("CX_B4"))%>" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획총괄책임자</th>
           		<td>
           			<input type="text" name="cx_b5" id="cx_b5" value="<%=util.getStr(dataMap.get("CX_B5"))%>" class="inp_txt" style="width:300px;">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td>
           			<input type="text" name="cx_b6" id="cx_b6" value="<%=util.getStr(dataMap.get("CX_B6"))%>" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전화번호</th>
           		<td colspan="3">
           			<input type="text" name="cx_b7" id="cx_b7" value="<%=util.getStr(dataMap.get("CX_B7"))%>" class="inp_txt" style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           	<%
           	String[] mail3 = util.getStr(dataMap.get("CX_MAIL3")).split("@");
           	%>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이메일</th>
           		<td colspan="3">
           			<input type="text" name="mail3_1" id="mail3_1" value="<%=mail3[0] %>" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="mail3_2" id="mail3_2" value="<%=mail3[1] %>" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise3" id="emailDomainChoise3" class="select_box" title="이메일주소도메인선택" >
						<option value="">직접입력</option>
						<option value="gmail.com" <%=(mail3[1].equals("gmail.com"))?"selected":""%>>지메일</option>
						<option value="empal.com" <%=(mail3[1].equals("empal.com"))?"selected":""%>>엠파스</option>
						<option value="naver.com" <%=(mail3[1].equals("naver.com"))?"selected":""%>>네이버</option>
						<option value="hanmail.net" <%=(mail3[1].equals("hanmail.net"))?"selected":""%>>다음</option>
						<option value="hotmail.com" <%=(mail3[1].equals("hotmail.com"))?"selected":""%>>핫메일</option>
						<option value="yahoo.co.kr" <%=(mail3[1].equals("yahoo.co.kr"))?"selected":""%>>야후</option>
						<option value="nate.com" <%=(mail3[1].equals("nate.com"))?"selected":""%>>네이트</option>
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
           			시작일 : <input type="text" name="cx_c1" id="cx_c1" value="<%=util.getStr(dataMap.get("CX_C1"))%>" class="inp_txt">
           			종료일 : <input type="text" name="cx_c2" id="cx_c2" value="<%=util.getStr(dataMap.get("CX_C2"))%>" class="inp_txt">
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
           			<input type="text" name="cx_d1" id="cx_d1" value="<%=util.getStr(String.valueOf(dataMap.get("CX_D1")))%>" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군명</th>
           		<td>
           			<input type="text" name="cx_d2" id="cx_d2" value="<%=util.getStr(dataMap.get("CX_D2"))%>" class="inp_txt">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
           		<td>
           			<input type="text" name="cx_d3" id="cx_d3" value="<%=util.getStr(String.valueOf(dataMap.get("CX_D3")))%>" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타기관명</th>
           		<td>
           			<input type="text" name="cx_d4" id="cx_d4" value="<%=util.getStr(dataMap.get("CX_D4"))%>" class="inp_txt">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타</th>
           		<td>
           			<input type="text" name="cx_d5" id="cx_d5" value="<%=util.getStr(String.valueOf(dataMap.get("CX_D5")))%>" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 합계</th>
           		<td>
           			<input type="text" name="cx_d6" id="cx_d6" value="<%=util.getStr(String.valueOf(dataMap.get("CX_D6")))%>" class="inp_txt read_only" readonly>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획비집행액</th>
           		<td>
           			<input type="text" name="cx_d7" id="cx_d7" value="<%=util.getStr(String.valueOf(dataMap.get("CX_D7")))%>" class="inp_txt">
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기획비정산잔액</th>
           		<td>
           			<input type="text" name="cx_d8" id="cx_d8" value="<%=util.getStr(String.valueOf(dataMap.get("CX_D8")))%>" class="inp_txt read_only" readonly>
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
        
        <%
        String[] fileTitle = {"기획과제협약서","기획보고서 요약서","기타자료"};
       
       
        
        if(fileList.size() > 0){
        	int fileCnt = 1;
        	for(HashMap rs:fileList){
        		String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
				+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
				+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
        		
        %>
        
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitle[fileCnt-1]%></th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" id="fileSn_<%=fileCnt %>" value="">
           			<input type="hidden" name="fileFlog" id="fileFlog_<%=fileCnt %>" value="">
           			<input type="file" name="<%=fileFullGrp%>File<%=fileCnt %>" id="<%=fileFullGrp%>File<%=fileCnt %>" value="" data-fileid="<%=util.getStr(rs.get("FILE_ID")) %>" data-filesn="<%=fileCnt %>">
           			첨부파일 <%=fileCnt%> :
           			<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
           		</td>
           	</tr>
        <%
        if(fileList.size() == 2 && fileCnt == 2){
        %>   	
           	
           	<tr>
           		<th scope="row" class="tit"><%=fileTitle[2]%></th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File3" id="<%=fileFullGrp%>File3" value="" data-fileid="" data-filesn="3">
           			
           		</td>
           	</tr>
        
        <%
        }
        %>   	
        
        <% 
        		fileCnt++;
        	}
        }
        %>
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
           			<textarea name="cx_comment" rows="5" class="inp_txt" style="width:100%"><%=util.getStr(dataMap.get("CX_COMMENT"))%></textarea>
           		</td>
           	</tr>
    	</tbody>
   	</table>

    
</form>


<!-- bo_btn  -->
<div class="btn_right_box" style="text-align: right; width: 980px; clear:both;">
       <input type="button" class="btn_inp_b_01" value="수정하기"/>
       <input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
</div>
<!--// bo_btn -->



<div style="padding-top:15px"></div>


<input type="hidden" name="cxidx" id="cxidx" value="<%=util.getStr(String.valueOf(dataMap.get("IDX")))%>">



<h2 class="tit">정부사업지원현황</h2>
<div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('addTypeA')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('delTypeA')" />
</div>
<div class="typeAContent">
<% if(cxTypeAList.size() > 0){ %>

<%
int kk = 0;
for(HashMap ca:cxTypeAList){
	
	ArrayList<HashMap<String, String>> fileListA = request.getAttribute("fileListA_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileListA_"+kk);
	int kkTot = kk+1;
	
	pageContext.setAttribute("txyear", util.getStr(ca.get("TX_YEAR")));
	
%>

	<div class="typeAformContent" id="typeAformContent<%=kkTot%>" data-type="on">
		<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">지원현황-<%=kkTot%></h3>
		<form name="typeaform_<%=kkTot%>" id="typeaform_<%=kkTot%>" action="<%=myPage%>" method="post" enctype="multipart/form-data">
			
			<input type="hidden" name="data1_idx" value="<%=util.getStr(String.valueOf(ca.get("IDX")))%>" />
			<input type="hidden" name="cxidx" value="<%=util.getStr(String.valueOf(ca.get("CX_IDX")))%>" />
			<input type="hidden" name="filesize" value="<%=fileListA.size()%>" />
			
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
		           			
		           			
		          			<select name="txyear" id="txyear" class="select_box" style="width:150px;">
		         				<option value="">:::선택:::</option>
		         				<c:forEach var="i" begin="2018" end="${currTime}">
		            			<option value="${i}" <c:if test="${i eq txyear}">selected</c:if>>${i}</option>
		            			</c:forEach>
		         			</select>
		           			
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 접수정보</th>
		           		<td colspan="3">
		           			<label><input type="radio" name="txtype" value="접수" <%=(util.getStr(ca.get("TX_TYPE")).equals("접수") || util.getStr(ca.get("TX_TYPE")).equals(""))?"checked":""%> > 접수</label>
			           		<label><input type="radio" name="txtype" value="미접수" <%=(util.getStr(ca.get("TX_TYPE")).equals("미접수"))?"checked":""%>> 미접수</label>
			           		<label><input type="radio" name="txtype" value="정책기획" <%=(util.getStr(ca.get("TX_TYPE")).equals("정책기획"))?"checked":""%>> 정책기획</label>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)신청일</th>
		           		<td>
		           			<input type="text" name="txdate" id="txdate<%=kkTot%>" value="<%=util.getStr(ca.get("TX_DATE"))%>" class="inp_txt read_only" readonly  <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%> />
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 제안부처명</th>
		           		<td>
		           			<input type="text" name="txname" id="txname" value="<%=util.getStr(ca.get("TX_NAME"))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처사업명</th>
		           		<td>
		           			<input type="text" name="tx_bname" id="tx_bname" value="<%=util.getStr(ca.get("TX_BNAME"))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%> />
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 관리기관명</th>
		           		<td>
		           			<input type="text" name="tx_cname" id="tx_cname" value="<%=util.getStr(ca.get("TX_CNAME"))%>" class="inp_txt"<%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업과제날짜</th>
		           		<td>
		           			시작일 : <input type="text" name="tx_sdate" id="tx_sdate<%=kkTot%>" value="<%=util.getStr(ca.get("TX_SDATE"))%>" class="inp_txt read_only" readonly <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>><br/>
		           			종료일 : <input type="text" name="tx_edate" id="tx_edate<%=kkTot%>" value="<%=util.getStr(ca.get("TX_EDATE"))%>" class="inp_txt read_only" readonly <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업기간</th>
		           		<td>
		           			<input type="hidden" name="tx_tmonth" id="tx_tmonth" value="<%=util.getStr(ca.get("TX_MONTH"))%>" class="inp_txt read_only" readonly <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			<span class="monthTit"><%=util.getStr(ca.get("TX_MONTH"))%>개월</span>
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
		           			<input type="text" name="tx_price1" id="tx_price1" value="<%=util.getStr(String.valueOf(ca.get("TX_PRICE1")))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 도비</th>
		           		<td>
		           			<input type="text" name="tx_price2" id="tx_price2" value="<%=util.getStr(String.valueOf(ca.get("TX_PRICE2")))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
		           		<td>
		           			<input type="text" name="tx_price3" id="tx_price3" value="<%=util.getStr(String.valueOf(ca.get("TX_PRICE3")))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타현금</th>
		           		<td>
		           			<input type="text" name="tx_price4" id="tx_price4" value="<%=util.getStr(String.valueOf(ca.get("TX_PRICE4")))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 현물</th>
		           		<td>
		           			<input type="text" name="tx_price5" id="tx_price5" value="<%=util.getStr(String.valueOf(ca.get("TX_PRICE5")))%>" class="inp_txt" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 총사업비</th>
		           		<td>
		           			<input type="text" name="tx_price6" id="tx_price6" value="<%=util.getStr(String.valueOf(ca.get("TX_PRICE6")))%>" class="inp_txt read_only" readonly <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>/>
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
		        <%
		        String[] fileTitleA = {"사업공고문","사업신청서표지","기타자료","사업비 확보 노력 현황자료"};
		        
		        String fileGrpA = "Jnrdtypea";
		        String fileSubGrpA = "";
		        String fileFullGrpA =fileGrpA+fileSubGrpA;
		        
		        int fileCntA = 1;
		        if(fileListA.size() == 4){
		        	
		        	for(HashMap rs:fileListA){
		        		String fileParamA = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
						+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
						+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
		        		
		        %>
		        	<tr>
		           		<th scope="row" class="tit"><% if(fileCntA < 3){ %><span style="color:red;" >*</span><% } %> <%=fileTitleA[fileCntA-1]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" id="fileSn_<%=fileCntA %>" value="" <% if(fileCntA < 4){ %><%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%><% } %>>
           					<input type="hidden" name="fileFlog" id="fileFlog_<%=fileCntA %>" value=""  <% if(fileCntA < 4){ %><%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%><% } %>>
		           			<input type="file" name="<%=fileFullGrpA%>File<%=fileCntA %>" id="<%=fileFullGrpA%>File<%=fileCntA %>" value="" data-fileid="<%=util.getStr(rs.get("FILE_ID")) %>" data-filesn="<%=fileCntA %>"  <% if(fileCntA < 4){ %><%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%><% } %>>
		           			첨부파일 <%=fileCntA%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileParamA%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
		           		</td>
		           	</tr>
		           	
		           	
		           	
		        <%
		        		fileCntA++;
		        	}
		        }else if(fileListA.size() == 3){
		        	for(HashMap rs:fileListA){
		        		String fileParamA = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
						+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
						+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
		        %>
		        	
		        	<tr>
		           		<th scope="row" class="tit"><% if(fileCntA < 3){ %><span style="color:red;" >*</span><% } %> <%=fileTitleA[fileCntA-1]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" id="fileSn_<%=fileCntA %>" value="" <% if(fileCntA < 4){ %><%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%><% } %>>
           					<input type="hidden" name="fileFlog" id="fileFlog_<%=fileCntA %>" value="" <% if(fileCntA < 4){ %><%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%><% } %>>
		           			<input type="file" name="<%=fileFullGrpA%>File<%=fileCntA %>" id="<%=fileFullGrpA%>File<%=fileCntA %>" value="" data-fileid="<%=util.getStr(rs.get("FILE_ID")) %>" data-filesn="<%=fileCntA %>" <% if(fileCntA < 4){ %><%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%><% } %>>
		           			첨부파일 <%=fileCntA%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileParamA%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
		           		</td>
		           	</tr>
		           	<%
		           	if(fileCntA == 3){
		           	%>
		           	<tr>
		           		<th scope="row" class="tit"> <%=fileTitleA[3]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpA%>File4" id="<%=fileFullGrpA%>File4" value="" data-fileid="" data-filesn="4">
		           		</td>
		           	</tr>
		           	<%
		           	}
		           	%>
		        
		        <%
		        		fileCntA++;
		        	}
		        }else if(fileListA.size() == 2){
		        	for(HashMap rs:fileListA){
		        		String fileParamA = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
						+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
						+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
		        %>
		        	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitleA[fileCntA-1]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" id="fileSn_<%=fileCntA %>" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
           					<input type="hidden" name="fileFlog" id="fileFlog_<%=fileCntA %>" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			<input type="file" name="<%=fileFullGrpA%>File<%=fileCntA %>" id="<%=fileFullGrpA%>File<%=fileCntA %>" value="" data-fileid="<%=util.getStr(rs.get("FILE_ID")) %>" data-filesn="<%=fileCntA %>" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			첨부파일 <%=fileCntA%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileParamA%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
		           		</td>
		           	</tr>
		           	<%
		           	if(fileCntA == 2){
		           	%>
		           	<tr>
		           		<th scope="row" class="tit"> <%=fileTitleA[2]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
           					<input type="hidden" name="fileFlog" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			<input type="file" name="<%=fileFullGrpA%>File3" id="<%=fileFullGrpA%>File3" value="" data-fileid="" data-filesn="3" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"> <%=fileTitleA[3]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpA%>File4" id="<%=fileFullGrpA%>File4" value="" data-fileid="" data-filesn="4">
		           		</td>
		           	</tr>
		           	<%
		           	}
		           	%>
		        
		        <%
		        		fileCntA++;
		        	}
		        }else{
		        %>
		        
		        	
		        	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitleA[0]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
           					<input type="hidden" name="fileFlog" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			<input type="file" name="<%=fileFullGrpA%>File1" id="<%=fileFullGrpA%>File1" value="" data-fileid="" data-filesn="1" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitleA[1]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
           					<input type="hidden" name="fileFlog" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			<input type="file" name="<%=fileFullGrpA%>File2" id="<%=fileFullGrpA%>File2" value="" data-fileid="" data-filesn="2" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"> <%=fileTitleA[2]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
           					<input type="hidden" name="fileFlog" value="" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           			<input type="file" name="<%=fileFullGrpA%>File3" id="<%=fileFullGrpA%>File3" value="" data-fileid="" data-filesn="3" <%=(!util.getStr(ca.get("TX_TYPE")).equals("접수"))?"disabled":""%>>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"> <%=fileTitleA[3]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpA%>File4" id="<%=fileFullGrpA%>File4" value="" data-fileid="" data-filesn="4">
		           		</td>
		           	</tr>
		        
		        
		        
		        <%
		        }
		        %>
		        </tbody>
		    </table>   	
  		
		   	
		   	<div style="clear:both;">
		   	<input type="button" class="typeamodify" value="수정">
		   	</div>
		   	
		</form>
	</div>

<% 
	kk++;
}//for end 
%>

	
		

<% }else{ %>
	<div class="hideBox">
		+버튼으로 지원현황을 추가하세요
	</div>
<% } %>
</div>

<div style="padding-top:15px; clear:both;"></div>


<h2 class="tit">선정과제기본정보</h2>
<div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('addTypeB')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('delTypeB')" />
</div>


<div class="typeBContent">
<% if(cxTypeBList.size() > 0){ %>
<%
int ii = 0;
for(HashMap cb:cxTypeBList){
	int iitot = ii+1;
	ArrayList<HashMap<String, String>> fileListB = request.getAttribute("fileListB_"+ii) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileListB_"+ii);
	
	pageContext.setAttribute("yxyear", util.getStr(cb.get("YX_YEAR")));
	
	
	
%>


	


	
	<div class="typeBformContent" id="typeBformContent<%=iitot%>" data-type="on">
		<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">선정과제-<%=iitot%></h3>
		<form name="typebform_<%=iitot%>" id="typebform_<%=iitot%>" action="<%=myPage%>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="xcount" value="<%=iitot%>" />
			<input type="hidden" name="yx_idx" value="<%=util.getStr(String.valueOf(cb.get("IDX")))%>" />
			<input type="hidden" name="cxidx" value="<%=util.getStr(String.valueOf(cb.get("CX_IDX")))%>" />
			<input type="hidden" name="filesize" value="<%=fileListB.size()%>" />
			
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
		           			
		           			<select name="yxyear" id="yxyear" class="select_box" style="width:150px;">
		         				<option value="">:::선택:::</option>
		         				<c:forEach var="i" begin="2018" end="${currTime}">
		            			<option value="${i}" <c:if test="${i == yxyear}">selected</c:if>>${i}</option>
		            			</c:forEach>
		         			</select>
		         			
		         			<label><input type="checkbox" name="yxstatus" value="1" <%=(util.getStr(cb.get("YX_STATUS")).equals("1"))?"checked":""%>> 미선정</label>
		           			
		           		</td>
		           	</tr>
		           	
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)신청일</th>
		           		<td colspan="3">
		           			<label><input type="radio" name="yxtype1" value="국가 R&D" <%=(util.getStr(cb.get("YX_TYPE1")).equals("국가 R&D") || util.getStr(cb.get("YX_TYPE1")).equals(""))?"checked":""%>> 국가R&D</label>
			           		<label><input type="radio" name="yxtype1" value="국가 비R&D" <%=(util.getStr(cb.get("YX_TYPE1")).equals("국가 비R&D"))?"checked":""%>> 국가 비R&D</label> 
			           		<label><input type="radio" name="yxtype1" value="도비 R&D" <%=(util.getStr(cb.get("YX_TYPE1")).equals("도비 R&D"))?"checked":""%>> 도비 R&D</label>
			           		<label><input type="radio" name="yxtype1" value="도비 비R&D" <%=(util.getStr(cb.get("YX_TYPE1")).equals("도비 비R&D"))?"checked":""%>> 도비 비R&D</label>
			           		<label><input type="radio" name="yxtype1" value="xx" <%=(util.getStr(cb.get("YX_TYPE1")).equals("xx"))?"checked":""%>> 기타</label>
		           		</td>
		           	</tr>
		           	
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업성격</th>
		           		<td colspan="3">
		           			<label><input type="radio" name="yxtype2" value="국비사업" <% if(util.getStr(cb.get("YX_TYPE2")).equals("국비사업") || util.getStr(cb.get("YX_TYPE2")).equals("")){ %>checked<% } %>> 국비사업</label>
			           		<label><input type="radio" name="yxtype2" value="국도비 매칭사업" <% if(util.getStr(cb.get("YX_TYPE2")).equals("국도비 매칭사업")){ %>checked<% } %>> 국도비 매칭사업</label> 
			           		<label><input type="radio" name="yxtype2" value="도비사업" <% if(util.getStr(cb.get("YX_TYPE2")).equals("도비사업")){ %>checked<% } %>> 도비사업</label>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 지원부처(청)명</th>
		           		<td colspan="3">
		           			<select name="yx_name" class="select_box">
			           			<option value="">:::선택:::</option>
			          			<% for(HashMap sup:supportList){ %>
								<option value="<%=util.getStr(sup.get("CODE_NM"))%>" <% if(util.getStr(cb.get("YX_NAME")).equals(util.getStr(sup.get("CODE_NM")))){ %>selected<% } %>><%=util.getStr(sup.get("CODE_NM"))%></option>
								<% } %>
		           			</select>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처(전남도)사업명</th>
		           		<td>
		           			<input type="text" name="yx_dname" id="yx_dname" value="<%=util.getStr(cb.get("YX_DNAME"))%>" class="inp_txt"/>
		           		</td>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 과제명</th>
		           		<td>
		           			<input type="text" name="yx_bname" id="yx_bname" value="<%=util.getStr(cb.get("YX_BNAME"))%>" class="inp_txt">
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
		           			<input type="text" name="yx_sdate" id="yx_sdate<%=iitot%>" value="<%=util.getStr(cb.get("YX_SDATE"))%>" class="inp_txt read_only" readonly />
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 종료년월일</th>
		           		<td colspan="3">
		           			<input type="text" name="yx_edate" id="yx_edate<%=iitot%>" value="<%=util.getStr(cb.get("YX_EDATE"))%>" <%=util.getStr(cb.get("MING")).equals("1")?"disabled":""%> class="inp_txt read_only" readonly />
		           			<label><input type="checkbox" name="ming" id="MING" value="1" <%=util.getStr(cb.get("MING")).equals("1")?"checked":""%>/>연차계속</label>
		           		</td>
		           	</tr>
		           	
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)기간</th>
		           		<td colspan="3">
		           			<input type="hidden" name="yx_tmonth" id="yx_tmonth" value="<%=util.getStr(cb.get("YX_TMONTH"))%>" class="inp_txt" <%=util.getStr(cb.get("MING")).equals("1")?"disabled":""%>/>
		           			<span id="yx_tmonth_text<%=iitot%>" class="yx_tmonth_text"> <%=(util.getStr(cb.get("MING")).equals("1"))?"연차계속":util.getStr(cb.get("YX_TMONTH"))+"개월"%></span>
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
		          			<input type="text" name="yx_price1" id="yx_price1" value="<%=util.getStr(String.valueOf(cb.get("YX_PRICE1")))%>" class="inp_txt" />
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 도비</th>
		          		<td>
		          			<input type="text" name="yx_price2" id="yx_price2" value="<%=util.getStr(String.valueOf(cb.get("YX_PRICE2")))%>" class="inp_txt" />
		          		</td>
		          	</tr>
		          	<tr>
		       		<th scope="row" class="tit"><span style="color:red;" >*</span> 시군비</th>
		          		<td>
		          			<input type="text" name="yx_price3" id="yx_price3" value="<%=util.getStr(String.valueOf(cb.get("YX_PRICE3")))%>" class="inp_txt" />
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타현금</th>
		          		<td>
		          			<input type="text" name="yx_price4" id="yx_price4" value="<%=util.getStr(String.valueOf(cb.get("YX_PRICE4")))%>" class="inp_txt" />
		          		</td>
		          	</tr>
		          	<tr>
		       		<th scope="row" class="tit"><span style="color:red;" >*</span> 현물</th>
		          		<td>
		          			<input type="text" name="yx_price5" id="yx_price5" value="<%=util.getStr(String.valueOf(cb.get("YX_PRICE5")))%>" class="inp_txt" />
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 총사업비</th>
		          		<td>
		          			<input type="text" name="yx_price6" id="yx_price6" value="<%=util.getStr(String.valueOf(cb.get("YX_PRICE6")))%>" class="inp_txt read_only" readonly />
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
		        	
		        <%
		        String[] fileTitleB = {"사업(과제)계획서 표지등록","사업(과제)협약서 등록","기타자료"};
		        
		        String fileGrpB = "Jnrdtypeb";
		        String fileSubGrpB = "";
		        String fileFullGrpB =fileGrpB+fileSubGrpB;
		        
		        if(fileListB.size() > 0){
		        	int fileCntB = 1;
		        	for(HashMap rs:fileListB){
		        		String fileParamB = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
						+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
						+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
		        		
		        %>
		        	
		        	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitleB[fileCntB-1]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpB%>File<%=fileCntB %>" id="<%=fileFullGrpB%>File<%=fileCntB %>" value="" data-fileid="<%=util.getStr(rs.get("FILE_ID")) %>"  data-filesn="<%=fileCntB%>"/>
		           			첨부파일 <%=fileCntB%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileFullGrpB%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
		           		</td>
		           	</tr>
		           	
		           	
		           	
		           			
		           	
		           	
		        <% 
		        fileCntB++;
		        	}
		        }else{
		        %>
		        	
		        	
		        	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)계획서 표지등록</th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpB%>File1" id="<%=fileFullGrpB%>File1" value="" data-filesn="1" />
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)협약서 등록</th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpB%>File2" id="<%=fileFullGrpB%>File2" value="" data-filesn="2" />
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 기타자료</th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpB%>File3" id="<%=fileFullGrpB%>File3" value="" data-filesn="3" />
		           		</td>
		           	</tr>
		           	
		           	
		        <% } %>
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
			          			<% 
			          				for(HashMap sup:agencyList){ %>
								<option value="<%=util.getStr(sup.get("CODE_NM"))%>" <% if(util.getStr(cb.get("YX_CTYPE")).equals(util.getStr(sup.get("CODE_NM")))){ %>selected<% } %>><%=util.getStr(sup.get("CODE_NM"))%></option>
								<% } %>
		           			</select>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 관리기관</th>
		           		<td>
		           			<input type="text" name="yx_cname" id="yx_cname" value="<%=util.getStr(cb.get("YX_CNAME")) %>" class="inp_txt" />
		           		</td>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관</th>
		           		<td>
		           			<input type="text" name="yx_yname" id="yx_yname" value="<%=util.getStr(cb.get("YX_YNAME")) %>" class="inp_txt" />
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관소재지</th>
		           		<td colspan="3">
		           			<label><input type="radio" name="yx_cont1" value="전라남도" <% if(util.getStr(cb.get("YX_CONT1")).equals("전라남도") || util.getStr(cb.get("YX_CONT1")).equals("")){ %>checked<% } %>> 전라남도</label>
		           			<label><input type="radio" name="yx_cont1" value="전라남도외" <% if(util.getStr(cb.get("YX_CONT1")).equals("전라남도외")){ %>checked<% } %>> 전라남도외</label>
		           			<label><input type="radio" name="yx_cont1" value="국외" <% if(util.getStr(cb.get("YX_CONT1")).equals("국외")){ %>checked<% } %>> 국외</label>
		           			
		           			<select name="yx_cont1_text" class="hide_select select_box" <% if(!util.getStr(cb.get("YX_CONT1")).equals("전라남도외")){ %>style="display:none;" disabled <% } %>>
		           				<%
									for(HashMap rs:areaList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(cb.get("YX_CONT1_TEXT")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		           			</select>
		           			<input type="text" name="yx_cont1_text" value="" class="inp_txt"  <% if(!util.getStr(cb.get("YX_CONT1")).equals("국외")){ %> style="display:none;" disabled <%}%>>
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 소속부서(학과)</th>
		           		<td>
		           			<input type="text" name="yx_cont2" id="yx_cont2" value="<%=util.getStr(cb.get("YX_CONT2")) %>" class="inp_txt" />
		           		</td>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 소속부서(학과)소재지</th>
		           		<td>
		           			<input type="text" name="yx_cont3" id="yx_cont3" value="<%=util.getStr(cb.get("YX_CONT3")) %>" class="inp_txt" />
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자이름</th>
		           		<td>
		           			<input type="text" name="yx_cont4" id="yx_cont4" value="<%=util.getStr(cb.get("YX_CONT4")) %>" class="inp_txt" />
		           		</td>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자직위</th>
		           		<td>
		           			<input type="text" name="yx_cont5" id="yx_cont5" value="<%=util.getStr(cb.get("YX_CONT5")) %>"  class="inp_txt"/>
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자 최종학위</th>
		           		<td colspan="3">
		           			<label><input type="radio" name="yx_cont6" value="고졸" <% if(util.getStr(cb.get("YX_CONT6")).equals("고졸")){ %>checked<% } %>> 고졸</label>
		           			<label><input type="radio" name="yx_cont6" value="전문학사" <% if(util.getStr(cb.get("YX_CONT6")).equals("전문학사")){ %>checked<% } %>> 전문학사</label>
		           			<label><input type="radio" name="yx_cont6" value="학사" <% if(util.getStr(cb.get("YX_CONT6")).equals("학사") || util.getStr(cb.get("YX_CONT6")).equals("")){ %>checked<% } %>> 학사</label>
		           			<label><input type="radio" name="yx_cont6" value="석사" <% if(util.getStr(cb.get("YX_CONT6")).equals("석사")){ %>checked<% } %>> 석사</label>
		           			<label><input type="radio" name="yx_cont6" value="박사" <% if(util.getStr(cb.get("YX_CONT6")).equals("박사")){ %>checked<% } %>> 박사</label>
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업시행지</th>
		           		<td colspan="3">
		           			<label><input type="radio" name="yx_cont7" value="전라남도" <% if(util.getStr(cb.get("YX_CONT7")).equals("전라남도") || util.getStr(cb.get("YX_CONT7")).equals("")){ %>checked<% } %>> 전라남도</label>
		           			<label><input type="radio" name="yx_cont7" value="전라남도시군" <% if(util.getStr(cb.get("YX_CONT7")).equals("전라남도시군")){ %>checked<% } %>> 전라남도시군</label>
		           			<label><input type="radio" name="yx_cont7" value="타시도" <% if(util.getStr(cb.get("YX_CONT7")).equals("타시도")){ %>checked<% } %>> 타시도</label>
		           			<label><input type="radio" name="yx_cont7" value="기타" <% if(util.getStr(cb.get("YX_CONT7")).equals("기타")){ %>checked<% } %>> 기타</label>
		           			
		           			<select name="yx_cont8" class="select_box" <% if(!util.getStr(cb.get("YX_CONT7")).equals("전라남도시군")){ %>style="display:none;"<%}%>>
		           			<% for(HashMap rs:areaSigunguList) { %>
							<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(cb.get("YX_CONT8")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %>><%=util.getStr(rs.get("CODE_NM"))%></option>
							<% } %>
		           			</select>
		           			
		           			<input type="text" name="yx_cont8" class="inp_txt" <% if(!util.getStr(cb.get("YX_CONT7")).equals("타시도") && !util.getStr(cb.get("YX_CONT7")).equals("기타")){ %>style="display:none;"<%}%>>
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
		           			<input type="text" name="yx_hcont1" id="yx_hcont1" value="<%=util.getStr(cb.get("YX_HCONT1")) %>" class="inp_txt" />
		           		</td>
		        		<th scope="row" class="tit">부서(과)</th>
		           		<td>
		           			<input type="text" name="yx_hcont2" id="yx_hcont2" value="<%=util.getStr(cb.get("YX_HCONT2")) %>" class="inp_txt" />
		           		</td>
		           	</tr>
		           	<tr>
		           		<th scope="row" class="tit">담당자이름</th>
		           		<td>
		           			<input type="text" name="yx_hcont3" id="yx_hcont3" value="<%=util.getStr(cb.get("YX_HCONT3")) %>" class="inp_txt" />
		           		</td>
		        		<th scope="row" class="tit">담당자직위</th>
		           		<td>
		           			<input type="text" name="yx_hcont4" id="yx_hcont4" value="<%=util.getStr(cb.get("YX_HCONT4")) %>" class="inp_txt" />
		           		</td>
		           	</tr>
		           	<tr>
		        		<th scope="row" class="tit">담당자 전화번호</th>
		           		<td>
		           			<input type="text" name="yx_hcont5" id="yx_hcont5" value="<%=util.getStr(cb.get("YX_HCONT5")) %>" class="inp_txt" />
		           		</td>
		        		<th scope="row" class="tit">담당자 휴대전화</th>
		           		<td>
		           			<input type="text" name="yx_hcont6" id="yx_hcont6" value="<%=util.getStr(cb.get("YX_HCONT6")) %>" class="inp_txt" />
		           		</td>
		           	</tr>
		           	<tr>
		           	<%
	           		String yxmail1 = "";
	           		String yxmail2 = "";
	           		
	           		if(!util.getStr(cb.get("YX_MAIL")).equals("@")){
	           			
	           			String[] yxmail = util.getStr(cb.get("YX_MAIL")).split("@");
	           			
	           			yxmail1 = yxmail[0];
	           			yxmail2 = yxmail[1];
	           			
	           			
	           		}
	           		
	           		%>
		        		<th scope="row" class="tit">담당자이메일</th>
		           		<td colspan="3">
		           			<input type="text" name="yxmail1" id="yxmail1" value="<%=yxmail1%>" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
							<input type="text" name="yxmail2" id="yxmail2" value="<%=yxmail2%>" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
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
		           			<textarea name="yx_comment" rows="5" class="inp_txt" style="width:100%;"><%=util.getStr(cb.get("YX_COMMENT"))%></textarea>
		           		</td>
		           	</tr>
		    	</tbody>
		   	</table>
		   	
		   	<input type="button" class="typebmodify" value="수정">
		   	
		</form>
	</div>

		<script>
		<% if(util.getStr(cb.get("YX_STATUS")).equals("1")){ %>
		var yxStatus = <%=util.getStr(cb.get("YX_STATUS"))%>;
		$("#typeBformContent"+<%=iitot%>).find("input").not("input[name='fileSn'], input[name='fileFlog'], input[name='yx_idx'], input[name='cxidx'], input[name='filesize']").prop("disabled",true);
		$("#typeBformContent"+<%=iitot%>).find("option").prop("disabled",true);
		$("#typeBformContent"+<%=iitot%>).find("textarea").prop("disabled",true);
		
		$("#typeBformContent"+<%=iitot%>).find(":button").prop("disabled",false);
		$("#typeBformContent"+<%=iitot%>).find("#yxyear option").prop("disabled",false);
		$("#typeBformContent"+<%=iitot%>).find("input[name='yxstatus']").prop("disabled",false);
		
		<% } %>
		
		
		
		</script>





<% 
	
	ii++;
}
%>
<% }else{ //if %>
	<div class="hideBox">
		+버튼으로 선정과제을 추가하세요
	</div>
<% } //if end %>
</div>











<script>

var typeACount = <%=cxTypeAList.size()%>;
var typeBCount = <%=cxTypeBList.size()%>;

var sDateOn = "";
var eDateOn = "";

$("input[name='yx_sdate']").datepicker({
   	showMonthAfterYear : true,
   	changeMonth : true,
   	changeYear : true,
   	dateFormat : "yy-mm-dd",
   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
   	dayNamesMin : ['일','월','화','수','목','금','토'],
   	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
   	onClose: function(dateText, inst) {
   		//var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
   		sDateOn = $(this).val();
   		
   	}
});


$("input[name='yx_edate']").datepicker({
   	showMonthAfterYear : true,
   	changeMonth : true,
   	changeYear : true,
   	dateFormat : "yy-mm-dd",
   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
   	dayNamesMin : ['일','월','화','수','목','금','토'],
   	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
   	onClose: function(dateText, inst) {
   		
   		//var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();

   		
   		
   		if(sDateOn == ""){
			alert("사업기간 시작일을 선택하세요");
			$(this).parents(".typeBformContent").find("input[name='yx_edate']").focus();
			$(this).val("");
			return false;
		}
   		
   		eDateOn = $(this).val();
   		
		var sdate = sDateOn.split("-");
		var edate = eDateOn.split("-");
		var sy = new Date(sdate[0],sdate[1],sdate[2]);
		var ey = new Date(edate[0],edate[1],edate[2]);
		var dif = ey - sy;
		var cDay = 86400*1000;
		var cMonth = cDay*30;
		var monthTot = parseInt((dif/cMonth));
		//var xxx = parseInt(typeBCount);
		
		$(this).parents(".typeBformContent").find("input[name='yx_tmonth']").val(monthTot);
		$(this).parents(".typeBformContent").find(".yx_tmonth_text").html(monthTot+"개월");
   	}
});






$(":file").on("change",function(){
	var fileid = $(this).data("fileid");
	var filesn = $(this).data("filesn");
	//var xxx = $(this).attr("name");
	
		$(this).prevAll("input[name='fileFlog']").val(fileid);
		$(this).prevAll("input[name='fileSn']").val(filesn);
	
	
});



function delRow(mode){
	
	var html = "";
	
	if(mode == "delTypeA"){
		
		var typex = $(".typeAformContent:last").data("type");
		
		if(typex != "on"){
		
			$(".typeAformContent:last").remove();
			typeACount--;
			if(typeACount == 0){
				//html += '<div class="hideBox" style="user-select: auto;">+버튼으로 지원현황을 추가하세요</div>';
				$(".typeAContent").find(".hideBox").show();
			}
		}
		
	}else{
		
		var typex = $(".typeBformContent:last").data("type");
		
		if(typex != "on"){
		
			$(".typeBformContent:last").remove();
			typeBCount--;
			if(typeBCount == 0){
				//html += '<div class="hideBox" style="user-select: auto;">+버튼으로 선정과제을 추가하세요</div>';
				$(".typeBContent").find(".hideBox").show();
			}
		}
	}
}



//정부사업지원현황
function addRow(mode){
	
	var nCont = typeACount;
	var xCont = typeBCount;
	
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
				
				//alert($("#typeAformContent"+nCont).find("input[name='data1_idx']").length);
				
				if($("#typeAformContent"+nCont).find("input[name='data1_idx']").length == 0){
				
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
				}
				
				
			//}
			
			
			
			typeACount++;
			$.ajax({
	            type: "POST",
	            data: {count:typeACount},
	            url : '/sys/jntisJnrdTypeaAjax.do',
	            dataType : 'HTML',
	            success : function(data){
	            	
	            	alert("사업지원현황이 추가되었습니다.");
	            	$(".typeAContent").append(data);
	            	
	            	$("#tx_sdate"+typeACount+",#tx_edate"+typeACount+", #txdate"+typeACount).datepicker({
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
					
					
					if($("#typeBformContent"+xCont).find("input[name='yx_idx']").length == 0){
					
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
					
					}
					
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
					
					/* if($("input[name='yx_hcont1']:last").val() == ""){
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
					} */
					
					
					
					
				}
				
				
			
			}
			
			
			typeBCount++;
			$.ajax({
	            type: "POST",
	            data: {count:typeBCount},
	            url : '/sys/jntisJnrdTypebAjax.do',
	            dataType : 'HTML',
	            success : function(data){
	            	
	            	
	            	alert("선정과제가 추가되었습니다.");
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
	            			var edate = $(this).val().split("-");
	            			var sy = new Date(sdate[0],sdate[1],sdate[2]);
	            			var ey = new Date(edate[0],edate[1],edate[2]);
	            			var dif = ey - sy;
	            			var cDay = 86400*1000;
	            			var cMonth = cDay*30;
	            			var monthTot = parseInt((dif/cMonth));
	            			var xxx = parseInt(typeBCount);
	            			
	            			$("input[name='yx_tmonth']:last").val(monthTot);
	            			$("#yx_tmonth_text"+xxx).html(monthTot+"개월");
	            	   		
	            	   	}
	            	});
	            	
	            	
	            	       		
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


$(document).on("click",".typebmodify",function(){
	
	var formData = new FormData($(this).parents(".typeBformContent").find("form")[0]);
	var $this = $(this);
	
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
		
		
		/* if($(this).parents(".typeBformContent").find("input[name='filesize']").val() == 0){
		
			if($(this).parents(".typeBformContent").find("#JnrdtypebFile1").val() == ""){
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
			}
		
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
		
		
	}
	
	//alert('aaaaaaa');
	//return false;
	
	//11111111111111
	$.ajax({
        cache : false,
        url : "/sys/jntisJnrdTypebModifyProcAjax.do",
        processData: false,
        contentType: false,
        type : 'POST', 
        data : formData,
        dataType : 'JSON',
        success : function(data) {
        	
        	var tidx = data.paramMap.tidx;
        	
        	if(data.status == "OK" && tidx > 0){
        		
        		alert('선정과제가 수정되었습니다.');
        		//$this.removeClass("typebinsert");
        		//$this.addClass("typebinsert_off");
        		//$this.val("등록완료");
        		//$(".typebinsert_off").attr("data-tidx",tidx);
        		
        		//$this.parents(".typeBformContent").find("input, option, textarea").prop("disabled",true);
        		
        	}
            
        }, // success
        error : function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
	
});



//접수정보
$(document).on("change","input[name='txtype']",function(){
	if($(this).val() != "접수"){
		
		//$(this).parents(".typeAformContent").find("input").not("input[name='txtype'], #JnrdtypeaFile4, :button").prop("disabled",true);
		//$(this).parents(".typeAformContent").find("#JnrdtypeaFile4").prevAll(":hidden").prop("disabled",false);
		
				
	}else{
		//$(this).parents(".typeAformContent").find("input").prop("disabled",false);
	}
});

//정부사업지원현황등록
$(document).on("click",".typeainsert",function(){
	
	var formData = new FormData($(this).parents(".typeAformContent").find("form")[0]);
	var $this = $(this);
	
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
		
		if($(this).parents(".typeAformContent").find("input[name='cxidx']").val() == ""){	
			
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
			
		}	
		
		
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
        		$this.val("등록완료");
        		$(".typeainsert_off").attr("data-tidx",tidx);
        		
        	}
            
        }, // success
        error : function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
	
	
	
	
	
	
});



$(document).on("click",".typeamodify",function(){
	
	var formData = new FormData($(this).parents(".typeAformContent").find("form")[0]);
	var $this = $(this);
	
	formData.set("tidx",$(this).parents(".typeAformContent").find("input[name='data1_idx']").val());
	formData.set("cxidx",$(this).parents(".typeAformContent").find("input[name='cxidx']").val());
	
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
		
		if($(this).parents(".typeAformContent").find("input[name='filesize']").val() == 0){
		
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
        url : "/sys/jntisJnrdTypeaModifyProcAjax.do",
        processData: false,
        contentType: false,
        type : 'POST', 
        data : formData,
        dataType : 'JSON',
        success : function(data) {
        	
        	var tidx = data.paramMap.tidx;
        	
        	if(data.status == "OK" && tidx > 0){
        		
        		alert('지원현황이 수정되었습니다.');
        		//$this.removeClass("typeainsert");
        		//$this.addClass("typeainsert_off");
        		//$this.text("등록완료");
        		//$(".typeainsert_off").attr("data-tidx",tidx);
        		
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
    
    formData.set("mode","modifyProc");
	
	
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
	
	
	
	
	<%-- 
	<% if(fileList.get(0).get("DATA_IDX").equals("")){ %>
	
	if((new RegExp(imgFormat)).test($("#JnrdcxFile1").val()) && $('#JnrdcxFile1').val() != ""){

	}else if($("#JnrdcxFile1").val() == ""){
		alert("기획과제 협약서 파일을 첨부하세요.");
		return false;
	}else{
		alert("문서 파일만 첨부하실 수 있습니다.");
		return false;
	}
	
	<% } %>
	
	<% if(fileList.get(1).get("DATA_IDX").equals("")){ %>
	if((new RegExp(imgFormat)).test($("#JnrdcxFile2").val()) && $('#JnrdcxFile2').val() != ""){

	}else if($("#JnrdcxFile2").val() == ""){
		alert("기획보고서 요약서 파일을 첨부하세요.");
		return false;
	}else{
		alert("문서 파일만 첨부하실 수 있습니다.");
		return false;
	}
	<% } %>
	
	<% if(fileList.get(2).get("DATA_IDX").equals("")){ %>
	if((new RegExp(imgFormat)).test($("#JnrdcxFile3").val()) && $('#JnrdcxFile3').val() != ""){

	}else if($("#JnrdcxFile3").val() == ""){
		alert("기타자료 파일을 첨부하세요.");
		return false;
	}else{
		alert("문서 파일만 첨부하실 수 있습니다.");
		return false;
	}
	<% } %> --%>

	
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
	$("#cx_d8").val((cd1+cd3+cd5)-cd7);
	
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
		$("#emailDomainChoise2").prop("disabled",false);
	}
});



$(document).on("click","input[name='yxstatus']",function(){
	if($(this).is(":checked")){
		
		$(this).parents(".typeBformContent").find("input, option").not($(this)).prop("disabled",true);
		$(this).parents(".typeBformContent").find("#yxyear option").prop("disabled",false);
		$(this).parents(".typeBformContent").find(":button").prop("disabled",false);
		$(this).parents(".typeBformContent").find("input[name='yx_idx'], input[name='cxidx'], input[name='fileSn'], input[name='fileFlog']").prop("disabled",false);
		$(this).parents(".typeBformContent").find("textarea").prop("disabled",true);
		//$(this).parents(".typeBformContent").find("input[name='cxidx']").prop("disabled",false);
		
	}else{
		$(this).parents(".typeBformContent").find("input, option").not($(this)).prop("disabled",false);
		$(this).parents(".typeBformContent").find("textarea").prop("disabled",false);
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


$("input[name='txdate'], input[name='tx_sdate'], input[name='tx_edate']").datepicker({
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
		
		//eDateYear = parseInt(toDateYear);
		
		$(this).parents(".typeBformContent").find("input[name='yx_edate']").val(null);
		$(this).parents(".typeBformContent").find("input[name='yx_edate']").prop("disabled",true);
		$(this).parents(".typeBformContent").find("input[name='yx_tmonth']").prop("disabled",true);
		$(this).parents(".typeBformContent").find(".yx_tmonth_text").html("연차계속");
	}else{
		//eDateYear = "";
		$(this).parents(".typeBformContent").find("input[name='yx_edate']").attr("disabled",false);
		$(this).parents(".typeBformContent").find("input[name='yx_tmonth']").prop("disabled",false);;
		$(this).parents(".typeBformContent").find(".yx_tmonth_text").html("");
	}		
});


$(document).on("change","#emailDomainChoise4",function() {
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








