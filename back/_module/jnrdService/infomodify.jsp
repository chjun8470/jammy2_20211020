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
       
       HashMap<String, String> infoData = request.getAttribute("infoData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("infoData");
       ArrayList<HashMap<String, String>> infoBusinessList = request.getAttribute("infoBusinessList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("infoBusinessList");
       
       ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	   ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	   
	   ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	   ArrayList<HashMap<String, String>> rndStageList = request.getAttribute("rndStageList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
	   ArrayList<HashMap<String, String>> rndPurposeList = request.getAttribute("rndPurposeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndPurposeList");
	   ArrayList<HashMap<String, String>> scienceBList = request.getAttribute("scienceBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scienceBList");
	   ArrayList<HashMap<String, String>> emphasisBList = request.getAttribute("emphasisBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("emphasisBList");
	   ArrayList<HashMap<String, String>> rndTbList = request.getAttribute("rndTbList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndTbList");
	   ArrayList<HashMap<String, String>> IndustryList = request.getAttribute("IndustryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("IndustryList");

       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String userIdx = util.getStr(paramMap.get("userIdx"));
       if("".equals(mode)) mode = "write";

       String fileGrp = "jntisJnrd";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

       int scCnt = infoBusinessList.size();
       
       
       
%>

<style>
table.skin_basic_write td.padding_none{padding:0;}
#businesslist td p{padding:10px 0; border-top:1px solid #ddd;}
#businesslist td p:first-child{border-top:none;}

#businesslist td p span{display:inline-block; width:100px; text-align:center;}
</style>

<jsp:useBean id="currTime" class="java.util.Date" />



<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	
	<input type="hidden" name="info_idx" value="<%=util.getStr(String.valueOf(paramMap.get("idx")))%>">
	
	<div class="skin_bbs_write" style="margin-top: 30px">
	
	<p style="color:red;"><span style="color:red;" >*</span>) 필수 입력사항입니다.</p>

	<!-- 기본정보 S -->
	<h2 class="tit">기본정보</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>기본정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit">사업(과제)관리번호</th>
           		<td colspan="3">
           			<input type="text" name="code" id="CODE" value="<%=util.getStr(infoData.get("CODE")) %>" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)구분</th>
           		<td colspan="3">
           			<label><input type="radio" name="typeA" value="주요R&D" <%=(util.getStr(infoData.get("TYPE_A")).equals("주요R&D") || util.getStr(infoData.get("TYPE_A")).equals(""))?"checked":""%>> 주요R&D</label>
           			<label><input type="radio" name="typeA" value="일반R&D" <%=(util.getStr(infoData.get("TYPE_A")).equals("일반R&D"))?"checked":""%>> 일반R&D</label>
           			<label><input type="radio" name="typeA" value="순도비R&D" <%=(util.getStr(infoData.get("TYPE_A")).equals("순도비R&D"))?"checked":""%>> 순도비R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 지원부처(청)명</th>
           		<td colspan="3">
           			<select name="cname" class="select_box">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap sup:supportList){
						%>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("CNAME")).equals(util.getStr(sup.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처(전남도)사업명</th>
           		<td>
           			<input type="text" name="bname" id="BNAME" class="inp_txt" value="<%=util.getStr(infoData.get("BNAME")) %>"/>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)명</th>
           		<td>
           			<input type="text" name="baname" id="B_ANAME" class="inp_txt" value="<%=util.getStr(infoData.get("B_ANAME")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 총연구기간</th>
           		<td colspan="3">
           			시작 : <input type="text" name="sdate" id="S_DATE" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("S_DATE"))) %>"/>
           			종료 : <input type="text" name="edate" id="E_DATE" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("E_DATE"))) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 총사업비</th>
           		<td colspan="3">
           			<input type="text" name="btprice" id="B_TPRICE" class="inp_txt" value="<%=util.getStr(String.valueOf(infoData.get("B_TPRICE"))) %>"/>(단위:100만원)
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연차계속</th>
           		<td>
           			<label><input type="radio" name="yeartype" value="단년사업" <%=(util.getStr(infoData.get("YEAR_TYPE")).equals("단년사업") || util.getStr(infoData.get("YEAR_TYPE")).equals(""))?"checked":""%>> 단년사업</label>
           			<label><input type="radio" name="yeartype" value="연차사업" <%=(util.getStr(infoData.get("YEAR_TYPE")).equals("연차사업"))?"checked":""%>> 연차사업</label>
           			<label><input type="radio" name="yeartype" value="연차계속사업" <%=(util.getStr(infoData.get("YEAR_TYPE")).equals("연차계속사업"))?"checked":""%>> 연차계속사업</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)정보출처</th>
           		<td colspan="3">
           			<label><input type="checkbox" name="bch1" value="시행계획" <%=(util.getStr(infoData.get("B_CH")).contains("시행계획"))?"checked":""%>> 시행계획</label>
           			<label><input type="checkbox" name="bch2" value="NTIS" <%=(util.getStr(infoData.get("B_CH")).contains("NTIS"))?"checked":""%>> NTIS</label>
           			<label><input type="checkbox" name="bch3" value="연지단" <%=(util.getStr(infoData.get("B_CH")).contains("연지단"))?"checked":""%>> 연지단</label>
           			<label><input type="checkbox" name="bch4" value="전남도" <%=(util.getStr(infoData.get("B_CH")).contains("전남도"))?"checked":""%>> 전남도</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)정보확정</th>
           		<td colspan="3">
           			입력 : <input type="text" name="bsd" id="B_SD" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("B_SD"))) %>"/>
           			확정 : <input type="text" name="bed" id="B_ED" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("B_ED"))) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업(과제)계획서</th>
           		<td colspan="3">
           		<%
           		String fileParam = "?dataGrp="+util.getStr(fileList.get(0).get("DATA_GRP"))+"&amp;fileId="+util.getStr(String.valueOf(fileList.get(0).get("FILE_ID")))+"&amp;dataIdx="+util.getStr(fileList.get(0).get("DATA_IDX"));
           		%>
           			<input type="hidden" name="fileSn" value="1">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부"  data-fileid="<%=util.getStr(String.valueOf(fileList.get(0).get("FILE_ID"))) %>" data-filesn="1"/>
           			첨부파일  :
           			<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(fileList.get(0).get("TITLE_ORG"))%> (<%=util.getComma(util.getStr(fileList.get(0).get("FILE_SIZE"))) %> Byte)</a>
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- 기본정보 E -->



	<!-- 연차사업(과제)정보 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">연차사업(과제)정보</h2>
    <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('business')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('business')" />
	</div>
	<div id="businesslist">
	<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
	<%
	int ibNum = 0;
	for(HashMap ib:infoBusinessList){
		pageContext.setAttribute("bisyear", util.getStr(ib.get("BIS_YEAR")));
		int ibCount = ibNum + 1;
	%>
	
  		<table class="skin_basic_write" id="businesslist_cont_<%=ibNum%>" data-type="on">
  			<input type="hidden" name="checkNum" value="<%=ibCount%>">
  			<input type="hidden" name="bid" value="<%=util.getStr(String.valueOf(ib.get("IDX")))%>">
  			<caption>연차사업(과제)정보</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr >
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> 당해년도</th>
	         		<td>
	         			
	         			<select name="bisyear" id="BIS_YEAR_<%=ibNum%>" class="select_box">
	         				<option value="">:::선택:::</option>
	         				<c:forEach var="i" begin="2018" end="${currTime}">
	            			<option value="${i}" <c:if test="${i eq bisyear}">selected</c:if>>${i}</option>
	            			</c:forEach>
	         			</select>
	         			
	         			<%-- <label><input type="checkbox" name="delCode" value="<%=util.getStr(String.valueOf(ib.get("IDX")))%>">[삭제]</label> --%>
	         			
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">당해년도 사업기간</th>
	         		<td>
	         			시작 : <input type="text" name="bissdate" id="BIS_SDATE_<%=ibNum%>" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(ib.get("BIS_SDATE")))%>"/>
	          			종료 : <input type="text" name="bisedate" id="BIS_EDATE_<%=ibNum%>" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(ib.get("BIS_EDATE")))%>"/>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> 재원구분</th>
	         		<td>
	         			<label><input type="radio" name="bistype_<%=ibNum%>" id="" value="일반회계" <%=(util.getStr(ib.get("BIS_TYPE")).equals("일반회계") || util.getStr(dataMap.get("BIS_TYPE")).equals(""))?"checked":""%>> 일반회계</label>
	           			<label><input type="radio" name="bistype_<%=ibNum%>" id="" value="특별회계" <%=(util.getStr(ib.get("BIS_TYPE")).equals("특별회계"))?"checked":""%>> 특별회계</label>
	           			<label><input type="radio" name="bistype_<%=ibNum%>" id="" value="기금" <%=(util.getStr(ib.get("BIS_TYPE")).equals("기금"))?"checked":""%>> 기금</label>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> 당해년도 사업비</th>
	         		<td class="padding_none">
	         			<p><span>국비 : </span><input type="text" name="bisprice_1" class="inp_txt" value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_1")))%>"> (단위:100만원)</p>
	         			<p><span>지방비 : </span><input type="text" name="bisprice_2" class="inp_txt" value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_2")))%>"> (단위:100만원)</p>
	         			<p><span>기타 : </span><input type="text" name="bisprice_3" class="inp_txt" value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_3")))%>"> (단위:100만원)</p>
	         			<p><span>합계 : </span><input type="text" name="bisprice_4" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_4")))%>"> (단위:100만원)</p>
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
		
	<%
		ibNum++;
	}//for end
	%>
	
	</div>
	
	<h2 class="tit">전문(관리)기관</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>연구수행주체</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전문기관</th>
           		<td colspan="3">
           			<input type="text" name="anname" id="AN_NAME" class="inp_txt" value="<%=util.getStr(infoData.get("AN_NAME")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> 관리기관</th>
           		<td colspan="3">
           			<input type="text" name="cnname" id="CN_NAME" class="inp_txt" value="<%=util.getStr(infoData.get("CN_NAME")) %>"/>
           		</td>
           	</tr>
        </tbody>
    </table>
	
	
	<!-- 기본정보 S -->
	<h2 class="tit">연구수행주체</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>연구수행주체</caption>
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
           			<select name="centype" id="CEN_TYPE" class="select_box">
           				<option value="">:::선택:::</option>
           				<option value="대학" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("대학"))?"selected":""%>>대학</option>
           				<option value="국공립연구소" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("국공립연구소"))?"selected":""%>>국공립연구소</option>
           				<option value="출연연구소" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("출연연구소"))?"selected":""%>>출연연구소</option>
           				<option value="기타기관" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("기타기관"))?"selected":""%>>기타기관</option>
           				<option value="대기업" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("대기업"))?"selected":""%>>대기업</option>
           				<option value="중견기업" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("중견기업"))?"selected":""%>>중견기업</option>
           				<option value="중소기업" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("중소기업"))?"selected":""%>>중소기업</option>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 주관기관</th>
           		<td colspan="3">
           			<input type="text" name="orgage" id="ORG_AGE" class="inp_txt" value="<%=util.getStr(infoData.get("ORG_AGE")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서(학과)명</th>
           		<td colspan="3">
           			<input type="text" name="depname" id="DEP_NAME" class="inp_txt" value="<%=util.getStr(infoData.get("DEP_NAME")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부서(학과)소재지</th>
           		<td colspan="3">
           			<label><input type="radio" name="deptype" value="1" <%=(util.getStr(infoData.get("DEP_TYPE")).equals("1") || util.getStr(infoData.get("DEP_TYPE")).equals(""))?"checked":""%> onclick="areaClick('depcode','1')"> 광역지자체</label>
           			<label><input type="radio" name="deptype" value="2" <%=(util.getStr(infoData.get("DEP_TYPE")).equals("2"))?"checked":""%> onclick="areaClick('depcode','2')"> 전라남도</label>
           			<select name="<%=(util.getStr(infoData.get("DEP_TYPE")).equals("1"))?"depcode":"0"%>" id="depcode1" class="select_box"  <%=(util.getStr(infoData.get("DEP_TYPE")).equals("2"))?"style='display:none'":""%>>
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DEP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<select name="<%=(util.getStr(infoData.get("DEP_TYPE")).equals("2"))?"depcode":"0"%>" id="depcode2" class="select_box" <%=(util.getStr(infoData.get("DEP_TYPE")).equals("1"))?"style='display:none'":""%>>
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap rs:areaSigunguList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DEP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업시행 소재지</th>
           		<td colspan="3">
           			<label><input type="radio" name="busimptype" value="1"  <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("1") || util.getStr(infoData.get("BUS_IMP_TYPE")).equals(""))?"checked":""%> onclick="areaClick('busimpcode','1')"> 광역지자체</label>
           			<label><input type="radio" name="busimptype" value="2" <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("2"))?"checked":""%> onclick="areaClick('busimpcode','2')"> 전라남도</label>
           			<select name="<%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("1"))?"busimpcode":"0"%>" id="busimpcode1" class="select_box" <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("2"))?"style='display:none'":""%>>
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("BUS_IMP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<select name="<%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("2"))?"busimpcode":"0"%>" id="busimpcode2" class="select_box" <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("1"))?"style='display:none'":""%>>
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap rs:areaSigunguList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("BUS_IMP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구책임자</th>
           		<td>
           			<input type="text" name="director" id="DIRECTOR" class="inp_txt" value="<%=util.getStr(infoData.get("DIRECTOR"))%>"/>
           		</td>
           		<th scope="row" class="tit">연구책임자 전화</th>
           		<td>
           			<input type="text" name="dirtel" id="DIR_TEL" class="inp_txt" value="<%=util.getStr(infoData.get("DIR_TEL"))%>"/>
           		</td>
           	</tr>
           	<tr>
           	<%
       		String yxmail1 = "";
       		String yxmail2 = "";
       		
       		if(!util.getStr(infoData.get("DIR_EMAIL")).equals("@") || !util.getStr(infoData.get("DIR_MAIL")).equals("")){
       			
       			String[] yxmail = util.getStr(infoData.get("DIR_EMAIL")).split("@");
       			
       			yxmail1 = yxmail[0];
       			yxmail2 = yxmail[1];
       			
       			
       		}
       		
       		%>
           		<th scope="row" class="tit">연구책임자 이메일</th>
           		<td colspan="3">
           			<input type="text" name="mail1" id="mail1" value="<%=yxmail1 %>" class="inp_txt" style="width:15%"  maxlength="20" title="이메일아이디"> @
					<input type="text" name="mail2" id="mail2" value="<%=yxmail2 %>" class="inp_txt" style="width:15%"  maxlength="50" title="이메일도메인">
					<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="이메일주소도메인선택" >
						<option value="">직접입력</option>
						<option value="gmail.com" <%=(util.getStr(yxmail2).equals("gmail.com"))?"selected":"" %> >지메일</option>
						<option value="empal.com" <%=(util.getStr(yxmail2).equals("empal.com"))?"selected":"" %>>엠파스</option>
						<option value="naver.com" <%=(util.getStr(yxmail2).equals("naver.com"))?"selected":"" %>>네이버</option>
						<option value="hanmail.net" <%=(util.getStr(yxmail2).equals("hanmail.net"))?"selected":"" %>>다음</option>
						<option value="hotmail.com" <%=(util.getStr(yxmail2).equals("hotmail.com"))?"selected":"" %>>핫메일</option>
						<option value="yahoo.co.kr" <%=(util.getStr(yxmail2).equals("yahoo.co.kr"))?"selected":"" %>>야후</option>
						<option value="nate.com" <%=(util.getStr(yxmail2).equals("nate.com"))?"selected":"" %>>네이트</option>
					</select>
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- 기본정보 E -->
	
	
	<h2 class="tit">사업(과제)분류</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>사업(과제)분류</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구개발단계분류</th>
           		<td colspan="3">
           			<select name="dirtype1" id="DIR_TYPE1" class="select_box" style="min-width:150px;">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap va:rndStageList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE1")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 연구개발목적분류</th>
           		<td colspan="3">
           			<select name="dirtype2" id="DIR_TYPE2" class="select_box" style="min-width:150px;">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap va:rndPurposeList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE2")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 과학기술표준분류</th>
           		<td colspan="3">
           			<select name="dirtype3" id="DIR_TYPE3" class="select_box" style="min-width:150px;">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap va:scienceBList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE3")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 중점과학기술분류</th>
           		<td colspan="3">
           			<select name="dirtype4" id="DIR_TYPE4" class="select_box" style="min-width:150px;">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap va:emphasisBList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE4")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 6T분류</th>
           		<td colspan="3">
           			<select name="dirtype5" id="DIR_TYPE5" class="select_box" style="min-width:150px;">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap va:rndTbList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE5")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 산업분류</th>
           		<td colspan="3">
           			<select name="dirtype6" id="DIR_TYPE6" class="select_box" style="min-width:150px;">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap va:IndustryList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE6")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	
   	<h2 class="tit">전남도 관리부서</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>전남도 관리부서</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 실국명</th>
           		<td colspan="3">
           			<input type="text" name="mancname" id="MAN_CNAME" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_CNAME"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 실과명</th>
           		<td colspan="3">
           			<input type="text" name="manpname" id="MAN_PNAME" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_PNAME"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 담당자명</th>
           		<td colspan="3">
           			<input type="text" name="mananame" id="MAN_ANAME" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_ANAME"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 직위</th>
           		<td colspan="3">
           			<input type="text" name="manspot" id="MAN_SPOT" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_SPOT"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전화번호</th>
           		<td colspan="3">
           			<input type="text" name="mantel" id="MAN_TEL" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_TEL"))%>"/>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h2 class="tit">비고</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>비고</caption>
        <tbody>
           	<tr>
           		<td colspan="4">
           			<textarea name="comment" rows="5" style="width:100%;" class="inp_txt"><%=util.getStr(infoData.get("COMMENT"))%></textarea>
           		</td>
           	</tr>
    	</tbody>
   	</table>



    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="수정하기" onclick="goCheck()"/>
           <input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
    </div>
    <!--// bo_btn -->
</form>


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^가-힣]/;
	var characPattern = /[^a-zA-Z0-9^가-힣]/;
	var engPattern  = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var datePattern = /^[0-9]{4}-[0-9]{2}/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
	var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;	
	
	
	
	$(":file").on("change",function(){
		var fileid = $(this).data("fileid");
		var filesn = $(this).data("filesn");
		//var xxx = $(this).attr("name");
		
		$(this).prevAll("input[name='fileFlog']").val(fileid);
		$(this).prevAll("input[name='fileSn']").val(filesn);
		
	});
	
	

	function goSubmit(mode,proState){
		$('#proState').val(proState);
		$('#mode').val(mode);
		$('#fwrite').submit();
    }
//팝업창 검색시 사용
	function userInfo(){
		$('#mode').val("write");
	    $('#fwrite').submit();
	}
//사진미등록 선택 S
	$("#photoCheck").click(function() {
		if($("#photoCheck").val() == null || $("#photoCheck").val() == "" ||$("#photoCheck").val() == "on" ||$("#photoCheck").val() == "Y"){
			$("#photoCheck").val("N");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDiv').hide();
		}else{
			$("#photoCheck").val("Y");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDiv').show();
		}
	});
//사진미등록 선택 E
//기본정보-출생지역 Sss
	function areaClick(mode,no){
		if(no =="2"){
			$("#"+mode+"1").val("");
			$("#"+mode+"1").attr("name","0");
			$("#"+mode+"2").attr("name",mode);
			$("#"+mode+"1").hide();
			$("#"+mode+"2").show();
		}else{
			$("#"+mode+"2").val("");
			$("#"+mode+"2").attr("name","0");
			$("#"+mode+"1").attr("name",mode);
			$("#"+mode+"2").hide();
			$("#"+mode+"1").show();
		}
	}
//기본정보-출생지역 E
//학력정보-전공분야 S
	function majorDeth1(mode){
		var result = "";
		var mode = mode;
		if(mode == "exRealm"){
			var deth1 = $('select[name=exMajor]:last').val();
		}else if(mode == "pluralExRealm"){
			var deth1 = $('select[name=pluralExMajor]:last').val();
		}
		$.ajax({
	            type: "POST",
	            data : {
	           	 deth1 : deth1
	            },
	            url : '/sys/dethCheck.do',
	            dataType : 'json',
	            success : function(data){
	           	result += "<option value=''>선택하세요.</option>";
	           	for(i=0; i<data.cnt; i++){
					result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
				}
	           	$('select[name='+mode+']:last').val("");
	           	$('select[name='+mode+']:last').append(result);
	            }
	   	});
	}
//학력정보-전공분야 E
//신청하기-데이터 체크 S
	function goCheck(){
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
        var fileCount = $("input[type=file]").length;
		
		
		if($("input[name='bname']").val() == ""){
			alert("부처사업명을 입력하세요");
			$("input[name='bname']").focus();
			return false;
		}
		
		if($("input[name='baname']").val() == ""){
			alert("사업(과제)명을 입력하세요");
			$("input[name='baname']").focus();
			return false;
		}
		
		if($("input[name='sdate']").val() == ""){
			alert("총연구기간 시작일을 입력하세요");
			$("input[name='sdate']").focus();
			return false;
		}
		
		if($("input[name='edate']").val() == ""){
			alert("총연구기간 종료일을 입력하세요");
			$("input[name='edate']").focus();
			return false;
		}
		
		if($("input[name='btprice']").val() == ""){
			alert("총사업비를 입력하세요");
			$("input[name='btprice']").focus();
			return false;
		}
		
		if(!$("input[name='bch1']").is(":checked") && !$("input[name='bch2']").is(":checked") && !$("input[name='bch3']").is(":checked") && !$("input[name='bch4']").is(":checked")){
			alert("사업(과제)정보출처를 하나이상 선택하세요");
			$("input[name='bch1']").focus();
			return false;
		}
		
		if($("input[name='bsd']").val() == ""){
			alert("사업(과제)정보확정 시작일을 입력하세요");
			$("input[name='bsd']").focus();
			return false;
		}
		
		if($("input[name='bed']").val() == ""){
			alert("사업(과제)정보확정 확정일을 입력하세요");
			$("input[name='bed']").focus();
			return false;
		}
		
		<%-- <%
		if(fileList.size() == 0)
		%>
		
		if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File1").val()) && $('#<%=fileFullGrp%>File1').val() != ""){

   		}else if($("#<%=fileFullGrp%>File1").val() == ""){
   			alert("파일을 첨부하세요.");
   			return false;
   		}else{
   			alert("문서 파일만 첨부하실 수 있습니다.");
   			return false;
   		} --%>
		
		if($("#BIS_YEAR_0").val() == ""){
			alert("연차사업의 당해년도를 선택하세요");
			$("#BIS_YEAR_0").focus();
			return false;
		}
		
		if($('select[name="bisyear"]:last').val() == ""){
	    	alert("연차사업의 당해년도를 입력 하세요");
	    	$('select[name="bisyear"]:last').focus();
			return false;
	    }
		
		if($('input[name="bisprice_1"]:last').val() == ""){
	    	alert("국비를 입력 하세요");
	    	$('input[name="bisprice_1"]:last').focus();
			return false;
	    }
	    if($('input[name="bisprice_2"]:last').val() == ""){
	    	alert("지방비를 입력 하세요");
	    	$('input[name="bisprice_2"]:last').focus();
			return false;
	    }
	    if($('input[name="bisprice_3"]:last').val() == ""){
	    	alert("기타를 입력 하세요");
	    	$('input[name="bisprice_3"]:last').focus();
			return false;
	    }
	    
	    /* 전문기관 폼체크 */
	    if($('input[name="anname"]').val() == ""){
	    	alert("전문기관명을 입력하세요");
	    	$('input[name="anname"]').focus();
			return false;
	    }
	    
	    
	    /* 연구수행주체 폼체크 */
	    if($('select[name="centype"]').val() == ""){
	    	alert("기관유형을 선택하세요");
	    	$('select[name="centype"]').focus();
			return false;
	    }
	    if($('input[name="orgage"]').val() == ""){
	    	alert("주관기관을 입력 하세요");
	    	$('input[name="orgage"]').focus();
			return false;
	    }
	    if($('input[name="depname"]').val() == ""){
	    	alert("부서(학과)명을 입력 하세요");
	    	$('input[name="depname"]').focus();
			return false;
	    }
	    if($('select[name="depcode"]').val() == ""){
	    	alert("부서(학과)소재지를 선택하세요");
	    	$('select[name="depcode"]').focus();
			return false;
	    }
	    if($('select[name="busimpcode"]').val() == ""){
	    	alert("사업시행 소재지를 선택하세요");
	    	$('select[name="busimpcode"]').focus();
			return false;
	    }
	    if($('input[name="director"]').val() == ""){
	    	alert("연구책임자를 입력 하세요");
	    	$('input[name="director"]').focus();
			return false;
	    }
	    
	    /* 사업과제분류 폼체크 */
	    if($('select[name="dirtype1"]').val() == ""){
	    	alert("연구개발단계분류를 선택하세요");
	    	$('select[name="dirtype1"]').focus();
			return false;
	    }
	    if($('select[name="dirtype2"]').val() == ""){
	    	alert("연구개발목적분류를 선택하세요");
	    	$('select[name="dirtype2"]').focus();
			return false;
	    }
	    if($('select[name="dirtype3"]').val() == ""){
	    	alert("과학기술표준분류를 선택하세요");
	    	$('select[name="dirtype3"]').focus();
			return false;
	    }
	    if($('select[name="dirtype4"]').val() == ""){
	    	alert("중점과학기술분류를 선택하세요");
	    	$('select[name="dirtype4"]').focus();
			return false;
	    }
	    if($('select[name="dirtype5"]').val() == ""){
	    	alert("6T분류를 선택하세요");
	    	$('select[name="dirtype5"]').focus();
			return false;
	    }
	    if($('select[name="dirtype6"]').val() == ""){
	    	alert("산업분류를 선택하세요");
	    	$('select[name="dirtype6"]').focus();
			return false;
	    }
	    
	    /*전남도 관리부서 폼체크*/
	    if($('input[name="mancname"]').val() == ""){
	    	alert("관리부서 실국명를 입력 하세요");
	    	$('input[name="mancname"]').focus();
			return false;
	    }
	    if($('input[name="manpname"]').val() == ""){
	    	alert("관리부서 실과명를 입력 하세요");
	    	$('input[name="manpname"]').focus();
			return false;
	    }
	    if($('input[name="mananame"]').val() == ""){
	    	alert("관리부서 담당자명를 입력 하세요");
	    	$('input[name="mananame"]').focus();
			return false;
	    }
	    if($('input[name="manspot"]').val() == ""){
	    	alert("관리부서 담당자 직위를 입력 하세요");
	    	$('input[name="manspot"]').focus();
			return false;
	    }
	    if($('input[name="mantel"]').val() == ""){
	    	alert("관리부서 전화번호를 입력 하세요");
	    	$('input[name="mantel"]').focus();
			return false;
	    }
	    
		
		
		goSubmit('modifyProc','10');
	}
	
	
	
	
	$(document).on("change","input[name='bisprice_3']:last,input[name='bisprice_1']:last,input[name='bisprice_2']:last",function(){
		if(isNaN($(this).val())){
			alert("숫자만 입력하세요");
			$(this).val("");
			$(this).focus();
			return false;
		}
		var totP = parseInt($("input[name='bisprice_1']:last").val())+parseInt($("input[name='bisprice_2']:last").val())+parseInt($("input[name='bisprice_3']:last").val());
		$("input[name='bisprice_4']:last").val(totP);
	});
	
	
	$("#B_TPRICE").on("change",function(){
		if(isNaN($(this).val())){
			alert("숫자만 입력하세요");
			$(this).val("");
			$(this).focus();
			return false;
		}
	});
	
	
	
//신청하기-데이터 체트 E
//팝업창 S
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=620, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
//팝업창 E
//기본datePicker S
	$("#E_DATE,#B_SD,#B_ED,input[name='bisedate'],input[name='bissdate']").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	//nextText : '다음 달',
       	//prevText : '이전 달',

       	//closeText : '닫기',
       	dateFormat : "yy-mm-dd",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['일','월','화','수','목','금','토'],
       	//monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
       	
        
		//yearRange: '1980:2020'
	});
	
	$("#S_DATE").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['일','월','화','수','목','금','토'],
       	//monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            var xNum = "";
            //코드번호생성
            $.ajax({
	            type: "POST",
	            data: {year:year},
	            url : '/sys/jntisJnrdAjax.do',
	            dataType : 'json',
	            success : function(data){	            	
	            	if(data.dataList != null){
	            		xNum = String(data.dataList.IDX).padStart(5,"0");
	            		$("#CODE").val("JNP-"+year+"-"+xNum);
	            	}else{
	            		$("#CODE").val("JNP-"+year+"-00001");
	            	}         		
	            }
   			});            
        }
	});
	
	
	
	function fillZero(width, str){
		var xcode = "";
		if(str.length >= width){
			xcode = str;
		}else{
			var mm = "";
			for(var i=0; i<(width-str.length+1); i++){
				mm += "0";
			}
			xcode = mm+str;
		}
	    return xcode;
	}

	
//기본datePicker E
//addRow Sss

	var date = new Date(); 
	var year = date.getFullYear();

	function addRow(mode){
   		if(mode=="business"){
   			var cnt = $('input[name=checkNum]:last').val();
   		    var ScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   		        		    
   		    if($('#BIS_YEAR_'+cnt).val() == ""){
   				alert("당해년도를 입력 하세요");
   				$('#BIS_YEAR_'+cnt).focus();
   				return false;
   			}
   		    
   		    if($('input[name="bisprice_1"]:last').val() == ""){
   		    	alert("국비를 입력 하세요");
   		    	$('input[name="bisprice_1"]:last').focus();
   				return false;
   		    }
   		    if($('input[name="bisprice_2"]:last').val() == ""){
   		    	alert("지방비를 입력 하세요");
   		    	$('input[name="bisprice_2"]:last').focus();
   				return false;
   		    }
   		    if($('input[name="bisprice_3"]:last').val() == ""){
   		    	alert("기타를 입력 하세요");
   		    	$('input[name="bisprice_3"]:last').focus();
   				return false;
   		    }
   		    
   		    var totalP = parseInt($('input[name="bisprice_1"]:last').val())+parseInt($('input[name="bisprice_2"]:last').val())+parseInt($('input[name="bisprice_3"]:last').val());
   		 	$('input[name="bisprice_4"]:last').val(totalP);
   		    
   		    
   			var row = "";
   			row += '<table class="skin_basic_write" id="businesslist_cont_'+ScCnt+'">';
   			row += '<input type="hidden" name="checkNum" value="'+ScCnt+'">';
   			row += '<input type="hidden" name="bid" value="">';
     			row += '<caption>학력정보</caption>';
     			row += '<colgroup>';
               row += '<col style="width:15%" />';
              	row += '</colgroup>';
   			row += '<tr>';
         	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> 당해년도</th>';
         	row += '<td>';
         	row += '	<select name="bisyear" id="BIS_YEAR_'+ScCnt+'" class="select_box">';
         	row += '		<option value="">:::선택:::</option>'
         	for(var y=2018; y<=year; y++){
         		row += '<option>'+y+'</option>';
         	}
         	row += '	</select>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit">당해년도 사업기간</th>';
         	row += '<td>';
         	row += '	시작 : <input type="text" name="bissdate" id="BIS_SDATE_'+ScCnt+'" class="inp_txt read_only" readonly value=""/>';
       		row += '	종료 : <input type="text" name="bisedate" id="BIS_EDATE_'+ScCnt+'" class="inp_txt read_only" readonly value=""/>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> 재원구분</th>';
         	row += '<td>';
         	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="일반회계" checked="checked"> 일반회계</label>';
           	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="특별회계"> 특별회계</label>';
           	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="기금"> 기금</label>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> 당해년도 사업비</th>';
         	row += '<td class="padding_none">';
         	row += '	<p><span>국비 : </span><input type="number" name="bisprice_1" class="inp_txt"> (단위:100만원)</p>';
         	row += '	<p><span>지방비 : </span><input type="number" name="bisprice_2" class="inp_txt"> (단위:100만원)</p>';
         	row += '	<p><span>기타 : </span><input type="number" name="bisprice_3" class="inp_txt"> (단위:100만원)</p>';
         	row += '	<p><span>합계 : </span><input type="number" name="bisprice_4" class="inp_txt read_only" readonly> (단위:100만원)</p>';
         	row += '</td>';
         	row += '</tr>';
         	row += '</table>';
   		 	
   		    $("#businesslist").append(row);

    	}
    	//date
		setLicenseBtn(ScCnt, mode);
	}
//addRow E
//delRow S
	function delRow(mode){
   		if(mode=="business"){
   			
   			var typex = $("#businesslist").find(".skin_basic_write:last").data("type");
   			
   			if(typex != "on"){
   				
	   			if($('input[name=checkNum]').size() == 1){
	   				alert("삭제 할 수 없습니다.");
	   				return false;
	   			};
	   			var delCnt = $('input[name=checkNum]').size() - 1;
	   			var parenttr = $("#businesslist_cont_"+delCnt).remove();
   			}
   		}
   		//setLicenseBtn();
   	}
//delRow E

	
	
	$("#emailDomainChoise").change(function() {
		if(this.value==""){
			$("#mail2").css("background-color","");
			$("#mail2").removeAttr("readonly");
			$("#mail2").val("");
		}else{
			$("#mail2").val(this.value);
			$("#mail2").css("background-color", "#EEEEEE");
			$("#mail2").attr("readonly", true);
		}
	});
//addRow시 datePicker E


function setLicenseBtn(plusScCnt, mode){
   	/* DatePicker 설정 */
  		var date ="";
  		if(mode == "business"){
  			date = "#BIS_SDATE_"+plusScCnt+", #BIS_EDATE_"+plusScCnt;
  		}

	$(date).datepicker({
		showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	//nextText : '다음 달',
       	//prevText : '이전 달',

       	//closeText : '닫기',
       	dateFormat : "yy-mm-dd",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['일','월','화','수','목','금','토'],
       	//monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	/*onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
        }*/
        
		//yearRange: '1980:2020'
	});
};


</script>