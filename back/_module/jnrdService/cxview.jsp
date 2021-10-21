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
   
   
       
       
%>

<style>
.hideBox{clear:both; border:1px solid #ddd; color:#999; font-size:14px; margin-bottom:15px; padding:30px 20px; text-align:center;}
</style>


<jsp:useBean id="currTime" class="java.util.Date" />



<div class="skin_bbs_write" style="margin-top: 30px">

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
           		<th scope="row" class="tit">기획과제 지원년도</th>
           		<td colspan="3">
           			
          			<%=util.getStr(dataMap.get("CX_YEAR"))%>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">사업(과제)관리번호</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_CODE"))%>
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
           		<th scope="row" class="tit">기획유형</th>
           		<td colspan="3">
           			
          			<%=util.getStr(dataMap.get("CX_TYPE1"))%>
           			
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">기획주제</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_TYPE2"))%>
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
           		<th scope="row" class="tit">기획명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_CNAME"))%>
           		</td>
           		<th scope="row" class="tit">부서명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_PNAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">담당자</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_UNAME"))%>
           		</td>
           		<th scope="row" class="tit">직위</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_SPOT"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">전화번호</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_TEL"))%>
           		</td>
           		<th scope="row" class="tit">휴대전화</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_HP"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">이메일</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_MAIL1"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<% if(!util.getStr(dataMap.get("CX_XUSER")).equals("1")){ %>
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
           		<th scope="row" class="tit">기관명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_XTEXT1"))%>
           		</td>
           		<th scope="row" class="tit">부서(실국)명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_XTEXT2"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">담당과명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_XTEXT3"))%>
           		</td>
           		<th scope="row" class="tit">담당자명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_XTEXT4"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">직위</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_XTEXT5"))%>
           		</td>
           		<th scope="row" class="tit">연락처</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_XTEXT6"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">이메일</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_MAIL2"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	<% } %>
   	
   	<% if(!util.getStr(dataMap.get("CX_A2")).equals("on")){ %>
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
           		<th scope="row" class="tit">기획과제지원 사업명</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_A1"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">기획과제 공고명</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_A3"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">공고기간</th>
           		<td colspan="3">
           			공고시작일 : <%=util.getStr(String.valueOf(dataMap.get("CX_A4")))%> ~  
           			공고마감일 : <%=util.getStr(String.valueOf(dataMap.get("CX_A5")))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">선정 및 협약</th>
           		<td colspan="3">
           			기획과제선정일 : <%=util.getStr(String.valueOf(dataMap.get("CX_A6")))%> ~  
           			기획과제협약일 : <%=util.getStr(String.valueOf(dataMap.get("CX_A7")))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	<% } %>
   	
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
           		<th scope="row" class="tit">기획과제명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_B1"))%>
           		</td>
           		<th scope="row" class="tit">기관유형</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_B2"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">주관기관(기업)명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_B3"))%>
           		</td>
           		<th scope="row" class="tit">부서(학과)명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_B4"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">기획총괄책임자</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_B5"))%>
           		</td>
           		<th scope="row" class="tit">직위</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_B6"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">전화번호</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_B7"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">이메일</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("CX_MAIL3"))%>
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
           		<th scope="row" class="tit">기획기간</th>
           		<td colspan="3">
           			시작일 : <%=util.getStr(String.valueOf(dataMap.get("CX_C1")))%><br/>
           			종료일 : <%=util.getStr(String.valueOf(dataMap.get("CX_C2")))%>
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
           		<th scope="row" class="tit">도비</th>
           		<td>
           			<%=util.getComma(String.valueOf(dataMap.get("CX_D1")))%>
           		</td>
           		<th scope="row" class="tit">시군명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_D2"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">시군비</th>
           		<td>
           			<%=util.getComma(String.valueOf(dataMap.get("CX_D3")))%>
           		</td>
           		<th scope="row" class="tit">기타기관명</th>
           		<td>
           			<%=util.getStr(dataMap.get("CX_D4"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">기타</th>
           		<td>
           			<%=util.getComma(String.valueOf(dataMap.get("CX_D5")))%>
           		</td>
           		<th scope="row" class="tit">합계</th>
           		<td>
           			<%=util.getComma(String.valueOf(dataMap.get("CX_D6")))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">기획비집행액</th>
           		<td>
           			<%=util.getComma(String.valueOf(dataMap.get("CX_D7")))%>
           		</td>
           		<th scope="row" class="tit">기획비정산잔액</th>
           		<td>
           			<%=util.getComma(String.valueOf(dataMap.get("CX_D8")))%>
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
        
        Map<Integer, Object> file = new  HashMap<Integer, Object>();
        
        if(fileList.size() == 1){
        	
        	file.put(0,fileList.get(0));
        	file.put(1,null);
        	file.put(2,null);
        	
        }else if(fileList.size() == 2){
        	
        	file.put(0,fileList.get(0));
        	file.put(1,fileList.get(1));
        	file.put(2,null);
        	
        }else if(fileList.size() == 3){
        	
        	file.put(0,fileList.get(0));
        	file.put(1,fileList.get(1));
        	file.put(2,fileList.get(2));
        }
        
        if(fileList.size() > 0){
        	for(int xx = 0; xx< fileTitle.length; xx++){
      			
        		if(file.get(xx) != null){
        			
        			//out.println(fileList.get(xx));
      				String fileParamxx = "?dataGrp="+util.getStr(fileList.get(xx).get("DATA_GRP"))
				+"&amp;fileId="+util.getStr(String.valueOf(fileList.get(xx).get("FILE_ID")))
				+"&amp;dataIdx="+util.getStr(fileList.get(xx).get("DATA_IDX"));
        		
        %>
        
        	<tr>
           		<th scope="row" class="tit"><%=fileTitle[xx]%></th>
           		<td colspan="3">
           			첨부파일 <%=xx+1%> :
           			<a href="/cmm/fms/ComFileDown.do<%=fileParamxx%>"><%=util.deStr(fileList.get(xx).get("TITLE_ORG"))%> (<%=util.getStr(fileList.get(xx).get("FILE_SIZE")) %> Byte)</a>
           		</td>
           	</tr>
        <%
        		}else{
        %>
        	
        	<tr>
          		<th scope="row" class="tit"><%=fileTitle[xx]%></th>
          		<td colspan="3">
          		
          			-
          		
          		</td>
          	</tr>
        
        <% 
          		}
      			
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
           			<%=util.getStr(dataMap.get("CX_COMMENT"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>

    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" data-idx="<%=util.getStr(String.valueOf(dataMap.get("IDX")))%>" value="수정하기"/>
           <input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
    </div>
    <!--// bo_btn -->



<div style="padding-top:15px"></div>


<input type="hidden" name="cxidx" id="cxidx" value="">

<% if(cxTypeAList.size() > 0){ %>
<h2 class="tit">정부사업지원현황</h2>
<div class="zoom"></div>
<div class="typeAContent">
<%
int kk = 0;
for(HashMap ca:cxTypeAList){
	
	ArrayList<HashMap<String, String>> fileListA = request.getAttribute("fileListA_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileListA_"+kk);
	
	
%>
	<div class="typeAformContent" id="typeAformContent<%=util.getStr(ca.get("TX_YEAR"))%>">
		<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">지원현황-<%=util.getStr(ca.get("TX_YEAR"))%></h3>
		
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
	           		<th scope="row" class="tit">조사연도</th>
	           		<td colspan="3">
	           			
	           			<%=util.getStr(ca.get("TX_YEAR"))%>
	           			
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">접수정보</th>
	           		<td colspan="3">
	           			<%=util.getStr(ca.get("TX_TYPE"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">사업(과제)신청일</th>
	           		<td>
	           			<%=util.getStr(String.valueOf(ca.get("TX_DATE")))%>
	           		</td>
	           		<th scope="row" class="tit">제안부처명</th>
	           		<td>
	           			<%=util.getStr(ca.get("TX_NAME"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">부처사업명</th>
	           		<td>
	           			<%=util.getStr(ca.get("TX_BNAME"))%>
	           		</td>
	           		<th scope="row" class="tit">관리기관명</th>
	           		<td>
	           			<%=util.getStr(ca.get("TX_CNAME"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">사업과제날짜</th>
	           		<td>
	           			시작일 : <%=util.getStr(String.valueOf(ca.get("TX_SDATE")))%><br/>
	           			종료일 : <%=util.getStr(String.valueOf(ca.get("TX_EDATE")))%>
	           		</td>
	           		<th scope="row" class="tit">사업기간</th>
	           		<td>
	           			<%=util.getStr(String.valueOf(ca.get("TX_MONTH")))%>개월
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
	        		<th scope="row" class="tit">국비</th>
	           		<td>
	           			<%=(util.getStr(ca.get("TX_TYPE")).equals("접수"))?util.getComma(util.getStr(String.valueOf(ca.get("TX_PRICE1")))):"-"%>
	           		</td>
	           		<th scope="row" class="tit">도비</th>
	           		<td>
	           			<%=(util.getStr(ca.get("TX_TYPE")).equals("접수"))?util.getComma(util.getStr(String.valueOf(ca.get("TX_PRICE2")))):"-"%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">시군비</th>
	           		<td>
	           			<%=(util.getStr(ca.get("TX_TYPE")).equals("접수"))?util.getComma(util.getStr(String.valueOf(ca.get("TX_PRICE3")))):"-"%>
	           		</td>
	           		<th scope="row" class="tit">기타현금</th>
	           		<td>
	           			<%=(util.getStr(ca.get("TX_TYPE")).equals("접수"))?util.getComma(util.getStr(String.valueOf(ca.get("TX_PRICE4")))):"-"%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">현물</th>
	           		<td>
	           			<%=(util.getStr(ca.get("TX_TYPE")).equals("접수"))?util.getComma(util.getStr(String.valueOf(ca.get("TX_PRICE5")))):"-"%>
	           		</td>
	           		<th scope="row" class="tit">총사업비</th>
	           		<td>
	           			<%=(util.getStr(ca.get("TX_TYPE")).equals("접수"))?util.getComma(util.getStr(String.valueOf(ca.get("TX_PRICE6")))):"-"%>
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
	        String[] fileNmA = {"사업공고문","사업신청서표지","기타자료","사업비 확보 노력 현황자료"};
	        
	        Map<Integer, Object> filex = new  HashMap<Integer, Object>();
	        
	        if(fileListA.size() == 1){
	        	
	        	filex.put(0,fileListA.get(0));
	        	filex.put(1,null);
	        	filex.put(2,null);
	        	
	        }else if(fileListA.size() == 2){
	        	
	        	filex.put(0,fileListA.get(0));
	        	filex.put(1,fileListA.get(1));
	        	filex.put(2,null);
	        	
	        }else if(fileListA.size() == 3){
	        	
	        	filex.put(0,fileListA.get(0));
	        	filex.put(1,fileListA.get(1));
	        	filex.put(2,fileListA.get(2));
	        }else if(fileListA.size() == 4){
	        	
	        	filex.put(0,fileListA.get(0));
	        	filex.put(1,fileListA.get(1));
	        	filex.put(2,fileListA.get(2));
	        	filex.put(3,fileListA.get(3));
	        }
	        
	        if(fileListA.size() > 0){
	        	for(int xx = 0; xx<fileNmA.length; xx++){
	        		String fileParamA = "?dataGrp="+util.getStr(fileListA.get(xx).get("DATA_GRP"))
					+"&amp;fileId="+util.getStr(String.valueOf(fileListA.get(xx).get("FILE_ID")))
					+"&amp;dataIdx="+util.getStr(fileListA.get(xx).get("DATA_IDX"));
					
					if(filex.get(xx) != null){
					
	        %>
	        	<tr>
	        		<th scope="row" class="tit"><%=fileNmA[xx] %></th>
	           		<td colspan="3">
	           			
	           			첨부파일 <%=xx+1%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileParamA%>"><%=util.deStr(fileListA.get(xx).get("TITLE_ORG"))%> (<%=util.getStr(fileListA.get(xx).get("FILE_SIZE")) %> Byte)</a>
	           			
	           		</td>
	           	</tr>
	        <%
					}else{
			%>
				<tr>
	          		<th scope="row" class="tit"><%=fileNmA[xx]%></th>
	          		<td colspan="3">
	          		
	          			-
	          		
	          		</td>
	          	</tr>
			
			<%			
					}
	        		
	        	}
	        }
	        %>
	           	
	    	</tbody>
	   	</table>
	   	
		   	
		   	
	</div>
<%
	
	kk++;
}//for end
%>
</div>


<div style="padding-top:15px; clear:both;"></div>
<% } %>

<% if(cxTypeBList.size() > 0){ %>
<h2 class="tit">선정과제기본정보</h2>
<div class="zoom"></div>
<div class="typeBContent">
<%
int ii = 0;
for(HashMap cb:cxTypeBList){
	
	ArrayList<HashMap<String, String>> fileListB = request.getAttribute("fileListB_"+ii) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileListB_"+ii);
	
	
%>

	<div class="typeBformContent" id="typeBformContent<%=util.getStr(cb.get("YX_YEAR"))%>">
	<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">선정과제-<%=util.getStr(cb.get("YX_YEAR"))%><%=(util.getStr(cb.get("YX_STATUS")).equals("1"))?"[미선정]":"" %></h3>
	
		<% if(!util.getStr(cb.get("YX_STATUS")).equals("1")){ %>
		
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
	           		<th scope="row" class="tit">조사연도</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_YEAR"))%>
	           		</td>
	           	</tr>
	           	
	           	<tr>
	           		<th scope="row" class="tit">사업(과제)신청일</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_TYPE1"))%>
	           		</td>
	           	</tr>
	           	
	           	<tr>
	           		<th scope="row" class="tit">사업성격</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_TYPE2"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">지원부처(청)명</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_NAME"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">부처(전남도)사업명</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_DNAME"))%>
	           		</td>
	           		<th scope="row" class="tit">과제명</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_BNAME"))%>
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
	        		<th scope="row" class="tit">시작년월일</th>
	           		<td colspan="3">
	           			<%=util.getStr(String.valueOf(cb.get("YX_SDATE")))%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">종료년월일</th>
	           		<td colspan="3">
	           		<%
	           		if(util.getStr(String.valueOf(cb.get("MING"))).equals("1")){
	           			out.println("연차계속");
	           		}else{
	           			out.println(util.getStr(String.valueOf(cb.get("YX_EDATE"))));
	           		}
	           		%>
	           		</td>
	           	</tr>
	           	<% if(!util.getStr(String.valueOf(cb.get("MING"))).equals("1")){ %>
	           	<tr>
	        		<th scope="row" class="tit">사업(과제)기간</th>
	           		<td colspan="3">
	           			<%=util.getStr(String.valueOf(cb.get("YX_TMONTH")))%>
	           		</td>
	           	</tr>
	           	<% } %>
	           	
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
	       		<th scope="row" class="tit">국비</th>
	          		<td>
	          			<%=util.getComma(String.valueOf(cb.get("YX_PRICE1")))%>
	          		</td>
	          		<th scope="row" class="tit">도비</th>
	          		<td>
	          			<%=util.getComma(String.valueOf(cb.get("YX_PRICE2")))%>
	          		</td>
	          	</tr>
	          	<tr>
	       		<th scope="row" class="tit">시군비</th>
	          		<td>
	          			<%=util.getComma(String.valueOf(cb.get("YX_PRICE3")))%>
	          		</td>
	          		<th scope="row" class="tit">기타현금</th>
	          		<td>
	          			<%=util.getComma(String.valueOf(cb.get("YX_PRICE4")))%>
	          		</td>
	          	</tr>
	          	<tr>
	       		<th scope="row" class="tit">현물</th>
	          		<td>
	          			<%=util.getComma(String.valueOf(cb.get("YX_PRICE5")))%>
	          		</td>
	          		<th scope="row" class="tit">총사업비</th>
	          		<td>
	          			<%=util.getComma(String.valueOf(cb.get("YX_PRICE6")))%>
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
		          	String fileNm[] = {"사업(과제)계획서 표지등록", "사업(과제)협약서 등록", "기타자료"};
		          	
					Map<Integer, Object> fileY = new  HashMap<Integer, Object>();
			        
			        if(fileListB.size() == 1){
			        	
			        	fileY.put(0,fileListB.get(0));
			        	fileY.put(1,null);
			        	fileY.put(2,null);
			        	
			        }else if(fileListB.size() == 2){
			        	
			        	fileY.put(0,fileListB.get(0));
			        	fileY.put(1,fileListB.get(1));
			        	fileY.put(2,null);
			        	
			        }else if(fileListB.size() == 3){
			        	
			        	fileY.put(0,fileListB.get(0));
			        	fileY.put(1,fileListB.get(1));
			        	fileY.put(2,fileListB.get(2));
			        }
		          	
		          	if(fileListB.size() > 0){
		          		for(int xx = 0; xx<fileNm.length; xx++){
		          			if(fileY.get(xx) != null){
		          			
		          	%>
		          	<tr>
		          		<th scope="row" class="tit"><%=fileNm[xx]%></th>
		          		<td colspan="3">
		          		
		          			<%=util.getStr(fileListB.get(xx).get("TITLE_ORG"))%>
		          		
		          		</td>
		          	</tr>
		          	<%
		          			}else{
		          	%>
		          	<tr>
		          		<th scope="row" class="tit"><%=fileNm[xx]%></th>
		          		<td colspan="3">
		          		
		          			-
		          		
		          		</td>
		          	</tr>
		          	<%			
		          			}
		          		}
		          	}
		          	%>
	        	
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
	        		<th scope="row" class="tit">기관유형</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_TYPE"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">관리기관</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_CNAME"))%>
	           		</td>
	        		<th scope="row" class="tit">주관기관</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_YNAME"))%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">주관기관소재지</th>
	           		<td colspan="3">
	           		<%
	           		if(util.getStr(cb.get("YX_CONT1")).equals("전라남도")){
	           		%>
	           			<%=util.getStr(cb.get("YX_CONT1"))%>
	           		<%
	           		}else{
	           		%>
	           			<%=util.getStr(cb.get("YX_CONT1_TEXT"))%>
	           		<%
	           		}
	           		%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">소속부서(학과)</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_CONT2"))%>
	           		</td>
	        		<th scope="row" class="tit">소속부서(학과)소재지</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_CONT3"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">연구책임자이름</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_CONT4"))%>
	           		</td>
	        		<th scope="row" class="tit">연구책임자직위</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_CONT5"))%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">연구책임자 최종학위</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_CONT6"))%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">사업시행지</th>
	           		<td colspan="3">
	           		<%
	           		if(util.getStr(cb.get("YX_CONT7")).equals("전라남도")){
	           		%>
	           			<%=util.getStr(cb.get("YX_CONT7"))%>
	           		<%
	           		}else{
	           		%>
	           			<%=util.getStr(cb.get("YX_CONT8"))%>
	           		<%
	           		}
	           		%>
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
	           			<%=util.getStr(cb.get("YX_HCONT1"))%>
	           		</td>
	        		<th scope="row" class="tit">부서(과)</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_HCONT2"))%>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">담당자이름</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_HCONT3"))%>
	           		</td>
	        		<th scope="row" class="tit">담당자직위</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_HCONT4"))%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">담당자 전화번호</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_HCONT5"))%>
	           		</td>
	        		<th scope="row" class="tit">담당자 휴대전화</th>
	           		<td>
	           			<%=util.getStr(cb.get("YX_HCONT6"))%>
	           		</td>
	           	</tr>
	           	<tr>
	        		<th scope="row" class="tit">담당자이메일</th>
	           		<td colspan="3">
	           			<%=util.getStr(cb.get("YX_MAIL"))%>
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
	           			<%=util.getStr(cb.get("YX_COMMENT"))%>
	           		</td>
	           	</tr>
	    	</tbody>
	   	</table>

	  <% } %> 	

	</div>


<%
	//}
	ii++;
}//for end 
%>
</div>
<% } %>










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
/* function addRow(mode){
	
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
			
			if($("input[name=txtype]:checked").val() == "접수" ){
			
			
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
				if($("#typeAformContent"+nCont).find("#JnrdtypeaFile3").val() == ""){
					alert("기타자료를 추가하세요");
					$("#typeAformContent"+nCont).find("#JnrdtypeaFile3").trigger("click");
					return false;
				}
				
				
			}
			
			if($("#typeAformContent"+nCont).find("#JnrdtypeaFile4").val() == ""){
				alert("사업비 확보 노력 현황자료를 추가하세요");
				$("#typeAformContent"+nCont).find("#JnrdtypeaFile4").trigger("click");
				return false;
			}
			
			
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
	            	   	dayNamesMin : ['월','화','수','목','금','토','일'],
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
					
					
					if($("#typeBformContent"+xCont).find("#JnrdtypebFile1").val() == ""){
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
	            	   	dayNamesMin : ['월','화','수','목','금','토','일'],
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
	            	   	dayNamesMin : ['월','화','수','목','금','토','일'],
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
} */



/* $(document).on("change","input[name='tx_edate']",function(){
	
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
}); */


/* $(document).on("change","input[name='tx_price1'],input[name='tx_price2'],input[name='tx_price3'],input[name='tx_price4'],input[name='tx_price5']",function(){
	var tp1 = ($(this).parents(".typeAformContent").find("input[name='tx_price1']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price1']").val()):0;
	var tp2 = ($(this).parents(".typeAformContent").find("input[name='tx_price2']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price2']").val()):0;
	var tp3 = ($(this).parents(".typeAformContent").find("input[name='tx_price3']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price3']").val()):0;
	var tp4 = ($(this).parents(".typeAformContent").find("input[name='tx_price4']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price4']").val()):0;
	var tp5 = ($(this).parents(".typeAformContent").find("input[name='tx_price5']").val() > 0)?parseInt($(this).parents(".typeAformContent").find("input[name='tx_price5']").val()):0;
	
	$(this).parents(".typeAformContent").find("input[name='tx_price6']").val(tp1+tp2+tp3+tp4+tp5);
	
});
 */


//접수정보
/* $(document).on("change","input[name='txtype']",function(){
	if($(this).val() != "접수"){
		
		$(this).parents(".typeAformContent").find("input").not("input[name='txtype'], #JnrdtypeaFile4, :button").prop("disabled",true);
				
	}else{
		$(this).parents(".typeAformContent").find("input").prop("disabled",false);
	}
}); */

//정부사업지원현황등록
/* $(document).on("click",".typeainsert",function(){
	
	var formData = new FormData($(this).parents(".typeAformContent").find("form")[0]);
	var $this = $(this);
	
	formData.set("cxidx",$("#cxidx").val());
	
	
	if($(this).parents(".typeAformContent").find("select[name='txyear']").val() == ""){
		alert("조사연도를 선택하세요");
		$(this).parents(".typeAformContent").find("select[name='txyear']").focus();
		return false;
	}
	
	if($(this).parents(".typeAformContent").find("input[name=txtype]:checked").val() == "접수" ){
	
	
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
		if($(this).parents(".typeAformContent").find("#JnrdtypeaFile3").val() == ""){
			alert("기타자료를 추가하세요");
			$(this).parents(".typeAformContent").find("#JnrdtypeaFile3").trigger("click");
			return false;
		}
		
		
	}
	
	if($(this).parents(".typeAformContent").find("#JnrdtypeaFile4").val() == ""){
		alert("사업비 확보 노력 현황자료를 추가하세요");
		$(this).parents(".typeAformContent").find("#JnrdtypeaFile4").trigger("click");
		return false;
	}
	
	
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
	
	
	
	
	
	
}); */




//선정과제기본정보등록
/* $(document).on("click",".typebinsert",function(){
	
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
		
		if($(this).parents(".typeBformContent").find("input[name='yx_hcont1']").val() == ""){
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
		}
		
		
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
 */



/* $("select[name='cxyear']").on("change",function(){
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
}); */



function goSubmit(mode,proState){
	location.href="/sys/sys_jnrd_cx.do";
}

$(document).on("click",".btn_inp_b_01",function(){	
	
	var idx = $(this).data("idx");
	location.href="/sys/sys_jnrd_cx.do?mode=modify&IDX="+idx;
	
	
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
		$(this).parents(".typeBformContent").find(":button").prop("disabled",false);
	}else{
		$(this).parents(".typeBformContent").find("input, option").not($(this)).prop("disabled",false);
	}
});





/* $("#emailDomainChoise1").change(function() {
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
}); */


/* $("#cx_a4, #cx_a5, #cx_a6, #cx_a7, #cx_c1, #cx_c2").datepicker({
   	showMonthAfterYear : true,
   	changeMonth : true,
   	changeYear : true,
   	dateFormat : "yy-mm-dd",
   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
   	dayNamesMin : ['월','화','수','목','금','토','일'],
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
}); */


</script>








