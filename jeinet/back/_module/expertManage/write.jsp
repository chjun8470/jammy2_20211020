<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
       ArrayList<HashMap<String, String>> majorList = request.getAttribute("majorList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList");
       ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
       ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	   ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");

       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String userIdx = util.getStr(paramMap.get("userIdx"));
       if("".equals(mode)) mode = "write";

       String fileGrp = "expertManage";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

       int scCnt = 0;

%>
<style  scoped>
.ui-datepicker-calendar {
    display: none;
    }
button.ui-datepicker-current { display: none; }
</style>
<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	<input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID")) %>" />
	<input type="hidden" name="proState" id="proState" value="" />
	<div class="skin_bbs_write" style="margin-top: 30px">
	<p style="color:red;">*) 필수 입력사항입니다.</p>

<!-- 기본정보 S -->
	<h2 class="tit">기본정보</h2>
	<div class="zoom">
	<input type="button" value="회원검색" class="btn_inp_b_01" onclick="popupWindow('exUserList')" >
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
            		<th scope="row" class="tit">* 이름</th>
            		<td>
            			<input type="text" name="psnNm" id="psnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" class="inp_txt" style="border:0px;"  readonly  maxlength="20">
            		</td>
            		<th scope="row" class="tit">* 성별</th>
            		<td>
            			<input type="text" name="GenderTypeCd" id="GenderTypeCd"  value="<%=util.getStr(dataMap.get("GENDER_TYPE_CD")) %>" class="inp_txt" style="border:0px;"  readonly  maxlength="20">

            		</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">* 생년월일</th>
            		<td>
            			<%if(util.getStr(dataMap.get("BIRTH_DATE")).equals("")||util.getStr(dataMap.get("BIRTH_DATE")).equals(null)){ %>
            				<input type="text" name="birthDate" id="birthDate"  class="inp_txt" style="width:100%;" maxlength="100">
            			<%}else{ %>
            				<input type="text" name="birthDate" id="birthDate"  value="<%=util.getStr(dataMap.get("BIRTH_DATE")) %>" class="inp_txt" style="border:0px;"  readonly  maxlength="4">
            			<%} %>
            		</td>
            		<th scope="row" class="tit">* email</th>
            		<td>
            			<%if(util.getStr(dataMap.get("EMAIL")).equals("")||util.getStr(dataMap.get("EMAIL")).equals(null)){ %>
            				<input type="text" name="email" id="email"  class="inp_txt" style="width:100%;" maxlength="100">
            			<%}else{ %>
            				<input type="text" name="email" id="email"  value="<%=util.getStr(dataMap.get("EMAIL")) %>" class="inp_txt" style="border:0px;"  readonly  maxlength="20">
            			<%} %>
            		</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">* 국적</th>
            		<td>
            			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
            				if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
            					<input type="text" name="proUserForg" id="proUserForg"  class="inp_txt" style="width:100%;" maxlength="100">
            				<%}else{%>
            					<input type="text" name="proUserForg" id="proUserForg"  value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>" class="inp_txt" style="width:100%;"  readonly style="border:0px;" >
            				<%} %>
            			<%}else{ %>
            				대한민국
            			<%} %>
            		</td>
            		<th scope="row" class="tit">* 출생지역</th>
            		<td>
            			<%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals("") || util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(null)){%>
            					&nbsp;&nbsp;전라남도 <input type="radio" name="Area" value="1"  checked="checked" onclick="area('1')"/>
								&nbsp;&nbsp;전라남도 외 지역 <input type="radio" name="Area" value="2"  onclick="area('2')"/>&nbsp;&nbsp;
								<select class="p_select" name="ProUserBirthplace" id="ProUserBirthplace1">
									<option value="">선택하세요</option>
									<%
										int utilitynumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(paramMap.get("searchArea")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea++; } %>
								</select>
								<select class="p_select" name="ProUserBirthplace" id="ProUserBirthplace2" style="display:none;">
									<option value="">선택하세요</option>
									<%
										int utilitynumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(paramMap.get("searchArea")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea2++; } %>
								</select>
            			<%}else{%>
            					<input type="text" name="ProUserBirthplace" id="ProUserBirthplace" value="<%=util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")) %>"  class="inp_txt" style="width:100%;"  readonly  style="border:0px;">
            			<%} %>

            		</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">* 전화번호</th>
            		<td>
            			<%if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
            				<input type="text" name="telNo" id="telNo"  class="inp_txt" style="width:100%;" maxlength="100">
            			<%}else{ %>
            				<input type="text" name="telNo" id="telNo"  value="<%=util.getStr(dataMap.get("TEL_NO")) %>" class="inp_txt" style="border:0px;"  readonly  maxlength="20">
            			<%} %>
	         		</td>
	         		<th scope="row" class="tit">* 휴대전화</th>
            		<td>
            			<%if(util.getStr(dataMap.get("CP_NO")).equals("")||util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
            				<input type="text" name="cpNo" id="cpNo"  class="inp_txt" style="width:100%;" maxlength="100">
            			<%}else{ %>
            				<input type="text" name="cpNo" id="cplNo"  value="<%=util.getStr(dataMap.get("CP_NO")) %>" class="inp_txt" style="border:0px;"  readonly  maxlength="20">
            			<%} %>
         			</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">* 사진첨부</th>
                   	<td colspan="3">
                   		<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
                        	<div>
                            	<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
                            </div>
                        </div>
						<input type="checkbox" name="photoCheck" id="photoCheck" value="N" />&nbsp;사진미등록
                	</td>
            	</tr>
            	<tr>
      	   			<th scope="row" class="tit">* 전문가구분</th>
            		<td colspan="3">
						정책기획 <input type="checkbox" name="proJntisPlanning" value="Y" />&nbsp;&nbsp;
						연구개발 <input type="checkbox" name="proJntisRnd" value="Y" />&nbsp;&nbsp;
						기업지원 <input type="checkbox" name="proJntisCompany" value="Y" />&nbsp;&nbsp;
						연구장비 <input type="checkbox" name="proJeinet" value="Y" />&nbsp;&nbsp;
						지식재산 <input type="checkbox" name="proJipbank" value="Y" />&nbsp;&nbsp;
						인력양성 <input type="checkbox" name="proJntisEducation" value="Y" />&nbsp;&nbsp;
						컨설팅 <input type="checkbox" name="proJntisConsulting" value="Y" />&nbsp;&nbsp;
						마케팅 <input type="checkbox" name="proJntisMarketing" value="Y" />&nbsp;&nbsp;
						기타 <input type="checkbox" name="proJntisEtc" value="Y" />&nbsp;&nbsp;
					</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">관심분야</th>
            		<td colspan="3">
						<textarea name="proUserInterestWorld" style="width:100%"></textarea>
					</td>
            	</tr>
     		</tbody>
	   	</table>
<!-- 기본정보 E -->

<!-- 소속정보 S -->
<%if(!(util.getStr(dataMap.get("ORG_GRP_CD"))).equals("") && !(util.getStr(dataMap.get("ORG_GRP_CD"))).equals(null)){ %>
        <div style="padding-top:15px"></div>
        <h2 class="tit">소속정보</h2>
        <table class="skin_basic_write" >
       		<caption>소속정보</caption>
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
	           			<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
	           		</td>
	           		<th scope="row" class="tit">기관유형</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("ORG_TYPE")) %>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">홈페이지</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("HOMEPAGE")) %>
	           		</td>
	           		<th scope="row" class="tit">대표전화</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("CORP_PHONE")) %>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">부서명</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("DEPT_NM")) %>
	           		</td>
	           		<th scope="row" class="tit">직위</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("POSITION_NM")) %>
	           		</td>
	           	</tr>
            </tbody>
	   	</table>
<%} %>
<!-- 소속정보 E -->
<!-- 학력정보 S -->
<div style="padding-top:15px"></div>
		<h2 class="tit">학력정보</h2>
        <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('academic')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('academic')" /></div>
   		<table class="skin_basic_write"  >
   			<caption>학력정보</caption>
            <colgroup>
	            <col style="width:25%" />
          		<col style="width:25%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:25%" />
            </colgroup>
         	<tr>
         		<th scope="row" class="tit">* 학교명</th>
         		<th scope="row" class="tit">* 소재지</th>
         		<th scope="row" class="tit" colspan="2">* 기간</th>
         		<th scope="row" class="tit">* 취득학위</th>
         	</tr>
		<tbody id="academiclist">
            <tr id="academic_career_info<%=scCnt%>">
          		<td><input type="text" name="scNm"  style="width:100%;" class="inp_txt"></td>
          		<td><input type="text" name="scLocation" style="width:100%;" class="inp_txt"></td>
          		<td><input type="text" name="scStart" id="scStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
          		<td><input type="text" name="scFinish" id="scFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scDegree">
						<option value="">선택하세요</option>
						<option value="고졸">고졸</option>
						<option value="전문학사">전문학사</option>
						<option value="학사">학사</option>
						<option value="석사">석사</option>
						<option value="박사">박사</option>
						<option value="기타">기타</option>
					</select>
				</td>
          	</tr>
   		</tbody>
		</table>
		<h3>○ 전공분야</h3>
		<table class="skin_basic_write"  >
		<caption>전문분야</caption>
		<colgroup>
			  <col style="width:15%" />
			  <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		</colgroup>
		<tr>
			<th scope="row" class="tit">* 전공계열</th>
			<td>
				<select class="select_box"  style="width:100%;" name="exMajor" onchange="majorDeth1('exRealm')" >
					<option value="">선택하세요</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" class="tit">* 전공분야</th>
			<td>
				<select class="select_box"  style="width:100%;" name="exRealm"></select>
			</td>
			<th scope="row" class="tit">* 세부전공</th>
			<td>
				<input type="text" name="exDetail" style="width:100%;" class="inp_txt">
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">복수전공계열</th>
			<td>
				<select class="select_box"  style="width:100%;" name="pluralExMajor" onchange="majorDeth1('pluralExRealm')">
					<option value="">선택하세요</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" class="tit">전공분야</th>
			<td>
				<select class="select_box"  style="width:100%;" name="pluralExRealm" ></select>
			</td>
			<th scope="row" class="tit">세부전공</th>
			<td>
				<input type="text" name="pluralExDetail" style="width:100%;" class="inp_txt">
			</td>
		</tr>
	</table>

<!-- 학력정보 E -->
		<div style="padding-top:15px"></div>
        <h2 class="tit">경력정보</h2>
        <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('career')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('career')" />
        </div>
   		<table class="skin_basic_write"  >
   			<caption>경력정보</caption>
            <colgroup>
	            <col style="width:20%" />
          		<col style="width:15%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
<!-- 경력정보 S -->
          	<tr>
          		<th scope="row" class="tit">* 직장명</th>
          		<th scope="row" class="tit">* 소재지</th>
          		<th scope="row" class="tit" colspan="2">* 기간</th>
          		<th scope="row" class="tit">* 최종직위</th>
          		<th scope="row" class="tit">* 주요업무</th>
			</tr>
		<tbody id="careerlist">
        	<tr id="career_info<%=scCnt%>">
				<td><input type="text" name="crNm"  style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crLocation" style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crStart" id="crStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crFinish" id="crFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crDept" style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crWork" style="width:100%;" class="inp_txt"></td>
            </tr>
		</tbody>
<!-- 경력정보 E -->
		</table>
		<div style="padding-top:15px"></div>
        <h2 class="tit">대외활동</h2>
        <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('activity')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('activity')" /></div>
   		<table class="skin_basic_write"  >
   			<caption>대외활동</caption>
            <colgroup>
          		<col style="width:35%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
<!-- 대외활동 S -->
           	<tr>
           		<th scope="row" class="tit">조직(학회)명</th>
           		<th scope="row" class="tit" colspan="2">기간</th>
           		<th scope="row" class="tit">직위</th>
           		<th scope="row" class="tit">주요업무</th>
           	</tr>
		<tbody id="activitylist">
         	<tr id="activity<%=scCnt%>">
         		<td><input type="text" name="acNm" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acStart" id="acStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acFinish" id="acFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acDept" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acWork" style="width:100%;" class="inp_txt"></td>
         	</tr>
		</tbody>
	</table>
<!-- 대외활동 E -->
<!-- 전문분야 S -->
<%-- 	<div style="padding-top:15px"></div>
        <h2 class="tit">전문분야</h2>
	<table class="skin_basic_write"  >
		<caption>전문분야</caption>
		<colgroup>
			  <col style="width:15%" />
			  <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		</colgroup>
		<tr>
			<td colspan="6">
				정책기획 <input type="checkbox" name="policyPlan" value="Y" />&nbsp;&nbsp;
				연구개발 <input type="checkbox" name="researchDev" value="Y" />&nbsp;&nbsp;
				기업지원 <input type="checkbox" name="companySupport" value="Y" />&nbsp;&nbsp;
				지식재산 <input type="checkbox" name="jip" value="Y" />&nbsp;&nbsp;
				연구장비 <input type="checkbox" name="jnsp" value="Y" />&nbsp;&nbsp;
				인력양성 <input type="checkbox" name="training" value="Y" />&nbsp;&nbsp;
				기반구축 <input type="checkbox" name="baseContracture" value="Y" />&nbsp;&nbsp;
				컨설팅 <input type="checkbox" name="consulting" value="Y" />&nbsp;&nbsp;
				마케팅 <input type="checkbox" name="marketing" value="Y" />
			</td>
		</tr>
	</table> --%>
<!-- 전문분야 E -->
<!-- 연구개발과제(프로젝트) 수행실적 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">연구개발과제(프로젝트) 수행실적</h2>
	<div class="zoom"><input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('RnDresult')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('RnDresult')" /></div>
	<table class="skin_basic_write">
		<caption>연구개발과제(프로젝트) 수행실적</caption>
	        <colgroup>
	              <col style="width:10%" />
	              <col style="width:15%" />
	              <col style="width:15%" />
	              <col style="width:15%" />
	              <col style="width:10%" />
	              <col style="width:10%" />
	              <col style="width:10%" />
	              <col style="width:15%" />
	        </colgroup>
       	<tr>
       		<th scope="row" class="tit">연번</th>
       		<th scope="row" class="tit">부처/기관/발주처명</th>
       		<th scope="row" class="tit">사업명</th>
       		<th scope="row" class="tit">과제명</th>
       		<th scope="row" class="tit" colspan="2">총사업참여기간</th>
       		<th scope="row" class="tit">사업비</th>
       		<th scope="row" class="tit">참여형태</th>
       	</tr>
 	<tbody id="RnDresultlist">
     	<tr id="RnDresult<%=scCnt%>">
     		<td><input type="text" name="rdSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdOrgNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdBusinessNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdStart" id="rdStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdFinish" id="rdFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdExpenses" style="width:100%;" class="inp_txt"></td>
       		<td>
       			<select class="select_box"   name="rdForm">
       				<option value="">선택</option>
       				<option value="총괄책임자">총괄책임자</option>
       				<option value="참여or위탁책임자">참여or위탁책임자</option>
       				<option value="실무담당자">실무담당자</option>
       				<option value="참여연구원">참여연구원</option>
       			</select>
       		</td>
		</tr>
	</tbody>
	</table>
<!-- 연구개발과제(프로젝트) 수행실적 E -->
<!-- 외부평가 수행실적 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">외부평가 수행실적</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('resultEv')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('resultEv')" /></div>
	<table class="skin_basic_write"  >
		<caption>외부평가 수행실적</caption>
        <colgroup>
        	<col style="width:30%" />
		    <col style="width:20%" />
		    <col style="width:10%" />
		    <col style="width:10%" />
		    <col style="width:30%" />
        </colgroup>
	<tbody id="resultEvlist">
		<tr>
	 		<th scope="row" class="tit">평가대상 사업명(평가명)</th>
	 		<th scope="row" class="tit">요청기관명</th>
	 		<th scope="row" class="tit" colspan="2">평가기간</th>
	 		<th scope="row" class="tit">평가내용</th>
	 	</tr>
    	<tr id="resultEv<%=scCnt%>">
 	  		<td>
 	  			<input type="text" name="evName" id="evName<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evOrg" id="evOrg<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evSdate" id="evSdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
   			<td>
   				<input type="text" name="evContent" id="evContent<%=scCnt %>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
	</tbody>
	</table>
<!-- 외부평가 수행실적 E -->
<!-- 컨설팅 수행실적 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">컨설팅 수행실적</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('resultCon')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('resultCon')" /></div>
	<table class="skin_basic_write"  >
		<caption>컨설팅 수행실적</caption>
        <colgroup>
        	<col style="width:30%" />
		    <col style="width:20%" />
		    <col style="width:10%" />
		    <col style="width:10%" />
		    <col style="width:30%" />
        </colgroup>
	<tbody id="resultConlist">
		<tr>
	 		<th scope="row" class="tit">컨설팅 사업명(컨설팅명)</th>
	 		<th scope="row" class="tit">요청기관명</th>
	 		<th scope="row" class="tit" colspan="2">컨설팅기간</th>
	 		<th scope="row" class="tit">컨설팅내용</th>
	 	</tr>
    	<tr id="resultCon<%=scCnt%>">
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conSdate" id="conSdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conEdate" id="conEdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
   			<td>
   				<input type="text" name="conContent" id="conContent<%=scCnt %>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
	</tbody>
	</table>
<!-- 컨설팅 수행실적 E -->
<!-- 연구논문 실적 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">연구논문 실적</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('researchPaper')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('researchPaper')" /></div>
	<table class="skin_basic_write" >
		<caption>연구논문 실적</caption>
	       <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
	       </colgroup>
       	<tr>
       		<th scope="row" class="tit">연번</th>
       		<th scope="row" class="tit">논문명</th>
       		<th scope="row" class="tit">논문유형</th>
       		<th scope="row" class="tit">학술지명</th>
       		<th scope="row" class="tit">게제년도</th>

       	</tr>
 	<tbody id="researchPaperlist">
     	<tr id="researchPaper<%=scCnt%>">
     		<td><input type="text" name="rpSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rpNm" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="rpType" style='width:100%;'>
       				<option value="">선택</option>
       				<option value="국내학술지">국내학술지</option>
       				<option value="국내학술대회">국내학술대회</option>
       				<option value="국외학술지">국외학술지</option>
       				<option value="국외학술대회">국외학술대회</option>
       				<option value="기타학술지">기타학술지</option>
       			</select>
     		</td>
     		<td><input type="text" name="rpJournalNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rpStart" id="rpStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
		</tr>
	</tbody>
	</table>
<!-- 연구논문 실적 E -->
<!-- 지식재산 실적 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">지식재산 실적</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('inProperty')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('inProperty')" />
    </div>
	<table class="skin_basic_write">
		<caption>지식재산 실적</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
        </colgroup>
       	<tr>
       		<th scope="row" class="tit">연번</th>
       		<th scope="row" class="tit">지식재산명</th>
       		<th scope="row" class="tit">지식재산유형</th>
       		<th scope="row" class="tit">인증/발행처</th>
       		<th scope="row" class="tit">등록년도</th>

       	</tr>
 	<tbody id="inPropertylist">
     	<tr id="inProperty<%=scCnt%>">
     		<td><input type="text" name="ipSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="ipNm" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="ipType" style='width:100%;'>
       				<option value="">선택</option>
       				<option value="특허">특허</option>
       				<option value="실용신안">실용실안</option>
       				<option value="상표">상표</option>
       				<option value="디자인">디자인</option>
       				<option value="프로그램">프로그램</option>
       				<option value="저작권">저작권</option>
       				<option value="기타지식재산">기타지식재산</option>
       			</select>
     		</td>
     		<td><input type="text" name="ipPublication" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="ipStart" id="ipStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
		</tr>
	</tbody>
	</table>
<!-- 지식재산 실적 E -->
<!-- 수상 실적 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">수상실적</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('awardCareer')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('awardCareer')" />
    </div>
	<table class="skin_basic_write">
		<caption>수상 실적</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
        </colgroup>
       	<tr>
       		<th scope="row" class="tit">연번</th>
       		<th scope="row" class="tit">훈격</th>
       		<th scope="row" class="tit">수여일자</th>
       		<th scope="row" class="tit">수여기관</th>
       		<th scope="row" class="tit">공적내용</th>

       	</tr>
 	<tbody id="awardCareerlist">
     	<tr id="awardCareer<%=scCnt%>">
     		<td><input type="text" name="awSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="awBadge" style='width:100%;'>
       				<option value="">선택</option>
       				<option value="훈장">훈장</option>
       				<option value="포장">포장</option>
       				<option value="표창">표창</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart" id="awStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awPresent" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awContent" style="width:100%;" class="inp_txt"></td>
		</tr>
	</tbody>
	</table>
<!-- 수상 실적 E -->
<!-- 자격사항 S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">자격사항</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('qualification')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('qualification')" /></div>
	<table class="skin_basic_write">
		<caption>자격사항</caption>
	    <colgroup>
			<col style="width:10%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
		</colgroup>
       	<tr>
       		<th scope="row" class="tit">연번</th>
       		<th scope="row" class="tit">취득일</th>
       		<th scope="row" class="tit">발급기관명</th>
       		<th scope="row" class="tit">자격구분</th>
       		<th scope="row" class="tit">자격명</th>
       	</tr>
	<tbody id="qualificationlist">
       	<tr id="qualification<%=scCnt%>">
       		<td><input type="text" name="quSerialNum" style="width:100%;" class="inp_txt"></td>
       		<td><input type="text" name="quStart" id="quStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
       		<td><input type="text" name="quOrgNm" style="width:100%;" class="inp_txt"></td>
       		<td>
       			<select class="select_box"  name="quDivide" style="width:100%;">
       				<option value="">선택하세요</option>
       				<option value="국가공인">국가공인</option>
       				<option value="국제공인">국제공인</option>
       				<option value="시설가격">시설가격</option>
       			</select>
       		</td>
       		<td><input type="text" name="quNm" style="width:100%;" class="inp_txt"></td>
       	</tr>
	</tbody>
	</table>
<!-- 자격사항 E -->
	</div>
    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="신청하기" onclick="goCheck()"/>
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
//기본정보-출생지역 S
	function area(no){
		var mode ="ProUserBirthplace";
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
		var imgFormat = "\.(bmp|gif|jpg|jpeg|png)$";
        var fileCount = $("input[type=file]").length;
		if($("#photoCheck").is(":checked") == false){
           	for(i=1;i<=fileCount;i++){
           		if((new RegExp(imgFormat)).test($('#<%=fileFullGrp%>File'+i).val()) && $('#<%=fileFullGrp%>File'+i).val() != ""){

           		}else if($('#<%=fileFullGrp%>File'+i).val() == ""){
           			alert("파일을 첨부하세요.");
           			return false;
           		}else{
           			alert("이미지 파일만 첨부하실 수 있습니다.");
           			return false;
           		}
           	}
		}
		if($('input[name=proJntisConsulting]').is(":checked") == false && $('input[name=proJntisMarketing]').is(":checked") == false && $('input[name=proJntisPlanning]').is(":checked") == false && $('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
			alert("전문가구분을 선택해주세요");
			return false;
		}
		if($('input[name=scNm]:last').val() == "" || $('input[name=scNm]:last').val() == null || $('input[name=scLocation]:last').val() == "" || $('input[name=scLocation]:last').val() == null || $('input[name=scStart]:last').val() == "" || $('input[name=scStart]:last').val() == null || $('input[name=scFinish]:last').val() == "" || $('input[name=scFinish]:last').val() == null || $('select[name=scDegree]:last').val() == "" || $('select[name=scDegree]:last').val() == null){
			alert("학력정보는 필수 값 입니다.");
			$('input[name=scNm]:last').focus();
			return false;
		}
		if($('select[name=exMajor]:last').val() == "" || $('select[name=exMajor]:last').val() == null ||$('select[name=exRealm]:last').val() == "" || $('select[name=exRealm]:last').val() == null || $('input[name=exDetail]:last').val() == "" || $('input[name=exDetail]:last').val() == null ){
			alert("전공계열은 필수 값 입니다.");
			$('input[name=exDetail]:last').focus();
			return false;
		}
		if($('input[name=crNm]:last').val() == "" || $('input[name=crNm]:last').val() == null || $('input[name=crLocation]:last').val() == "" || $('input[name=crLocation]:last').val() == null || $('input[name=crStart]:last').val() == "" || $('input[name=crStart]:last').val() == null || $('input[name=crFinish]:last').val() == "" || $('input[name=crFinish]:last').val() == null ||  $('input[name=crDept]:last').val() == "" || $('input[name=crDept]:last').val() == null ||  $('input[name=crWork]:last').val() == "" || $('input[name=crWork]:last').val() == null ){
			alert("경력정보는 필수 값 입니다.");
			$('input[name=crNm]:last').focus();
			return false;
		}
          	if($('input[name=scStart]:last').val() != "" && $('input[name=scStart]:last').val() != null){
				if(datePattern.test($('input[name=scStart]:last').val()) == false){
						alert("학력정보(기간) : ex) 2016-01");
						$('input[name=scStart]:last').focus();
						return false;
				}
           	}
           	if($('input[name=scFinish]:last').val() != "" && $('input[name=scFinish]:last').val() != null){
				if(datePattern.test($('input[name=scFinish]:last').val()) == false){
						alert("학력정보(기간) : ex) 2016-01");
						$('input[name=scFinish]:last').focus();
						return false;
				}
           	}
			if($('input[name=crStart]:last').val() != "" && $('input[name=crStart]:last').val() != null){
				if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
			}
			if($('input[name=crFinish]:last').val() != "" && $('input[name=crFinish]:last').val() != null){
				if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=acStart]:last').val() != "" && $('input[name=acStart]:last').val() != null){
				if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
					return false;
				}
			}
			if($('input[name=acFinish]:last').val() != "" && $('input[name=acFinish]:last').val() != null){
				if(datePattern.test($('input[name=acFinish]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=rdStart]:last').val() != "" && $('input[name=rdStart]:last').val() != null){
				if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
			}
			if($('input[name=rdFinish]:last').val() != "" && $('input[name=rdFinish]:last').val() != null){
				if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=rdExpenses]:last').val() != "" && $('input[name=rdExpenses]:last').val() != null){
				if(isNaN($('input[name=rdExpenses]:last').val())){
					alert("연구개발과제(프로젝트) 수행실적(사업비) : 숫자만 입력해주세요. ex)10000");
					$('input[name=rdExpenses]:last').focus();
					return false;
				}
			}
			if($('input[name=quStart]:last').val() != "" && $('input[name=quStart]:last').val() != null){
				if(datePattern.test($('input[name=quStart]:last').val()) == false){
					alert("자격사항(취득일) : ex) 2016-01");
					$('input[name=quStart]:last').focus();
					return false;
				}
			}
			if($('input[name=rpStart]:last').val() != "" && $('input[name=rpStart]:last').val() != null){
				if(datePattern.test($('input[name=rpStart]:last').val()) == false){
					alert("연구논문 실적(게제년도) : ex) 2016-01");
					$('input[name=rpStart]:last').focus();
					return false;
				}
			}

			if($('input[name=awStart]:last').val() != "" && $('input[name=awStart]:last').val() != null){
				if(datePattern.test($('input[name=awStart]:last').val()) == false){
					alert("수상실적(수여일자) : ex) 2016-01");
					$('input[name=awStart]:last').focus();
					return false;
				}
			}
			if($('input[name=ipStart]:last').val() != "" && $('input[name=ipStart]:last').val() != null){
				if(datePattern.test($('input[name=ipStart]:last').val()) == false){
					alert("지식재산 실적(등록년도) : ex) 2016-01");
					$('input[name=ipStart]:last').focus();
					return false;
				}
			}
			if($('input[name=evSdate]:last').val() != "" && $('input[name=evSdate]:last').val() != null){
				if(datePattern.test($('input[name=evSdate]:last').val()) == false){
					alert("외부평가 수행실적(평가기간) : ex) 2016-01");
					$('input[name=evSdate]:last').focus();
					return false;
				}
			}
			if($('input[name=evEdate]:last').val() != "" && $('input[name=evEdate]:last').val() != null){
				if(datePattern.test($('input[name=evEdate]:last').val()) == false){
					alert("외부평가 수행실적(평가기간) : ex) 2016-01");
					$('input[name=evEdate]:last').focus();
					return false;
				}
			}
			if($('input[name=conSdate]:last').val() != "" && $('input[name=conSdate]:last').val() != null){
				if(datePattern.test($('input[name=conSdate]:last').val()) == false){
					alert("컨설팅 수행실적(평가기간) : ex) 2016-01");
					$('input[name=conSdate]:last').focus();
					return false;
				}
			}
			if($('input[name=conEdate]:last').val() != "" && $('input[name=conEdate]:last').val() != null){
				if(datePattern.test($('input[name=conEdate]:last').val()) == false){
					alert("컨설팅 수행실적(평가기간) : ex) 2016-01");
					$('input[name=conEdate]:last').focus();
					return false;
				}
			}
		goSubmit('writeProc','10');
	}
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
	$("#evSdate0,#evEdate0,#conSdate0,#conEdate0,#scStart0, #scFinish0, #crStart0, #crFinish0, #acStart0, #acFinish0, #rdStart0, #rdFinish0, #quStart0, #rpStart0, #ipStart0, #awStart0").datepicker({
       	showMonthAfterYear : true,
       	showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	nextText : '다음 달',
       	prevText : '이전 달',

       	closeText : '닫기',
       	dateFormat : "yy-mm",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['월','화','수','목','금','토','일'],
       	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
        },
        showButtonPanel:true,
		yearRange: '1980:2020'
	});
//기본datePicker E
//addRow S
	function addRow(mode){
   		if(mode=="academic"){
    			var StartId = $('input[name=scStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=scNm]:last').val() == ""){
    				alert("학교명을 입력 해주세요");
    				$('input[name=scNm]:last').focus();
    				return false;
    			}

    			if($('input[name=scLocation]:last').val() == ""){
    				$('input[name=scLocation]:last').focus();
    				alert("소재지을 입력 해주세요");
    				return false;
    			}

    			if($('input[name=scStart]:last').val() == "" || $('input[name=scFinish]:last').val() == "" ){
    				$('input[name=scStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=scStart]:last').val()) == false){
					alert("학력정보(기간) : ex) 2016-01");
					$('input[name=scStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=scFinish]:last').val()) == false){
					alert("학력정보(기간) : ex) 2016-01");
					$('input[name=scFinish]:last').focus();
					return false;
				}

    			if($('input[name=scDegree]:last').val() == ""){
    				$('input[name=scDegree]:last').focus();
    				alert("취득학위를 입력 해주세요");
    				return false;
    			}


    			var row = "";
    		 	row += "<tr id='academic_career_info"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='scNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scLocation' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scStart' id='scStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scFinish' id='scFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scDegree' style='width:100%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		    $("#academiclist").append(row);

    		}else if(mode == "career"){
    			var StartId = $('input[name=crStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=crNm]:last').val() == ""){
    				alert("직장명을 입력 해주세요");
    				$('input[name=crNm]:last').focus();
    				return false;
    			}

    			if($('input[name=crLocation]:last').val() == ""){
    				$('input[name=crLocation]:last').focus();
    				alert("작장 소재지을 입력 해주세요");
    				return false;
    			}

    			if($('input[name=crStart]:last').val() == "" || $('input[name=crFinish]:last').val() == "" ){
    				$('input[name=crStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
    			if($('input[name=crDept]:last').val() == ""){
    				$('input[name=crDept]:last').focus();
    				alert("최종직위를 입력 해주세요");
    				return false;
    			}

    			if($('input[name=crWork]:last').val() == ""){
    				$('input[name=crWork]:last').focus();
    				alert("주요업무를 입력 해주세요");
    				return false;
    			}

    			var row = "";
    		 	row += "<tr id='career_info"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='crNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crLocation' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crStart' id='crStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crFinish' id='crFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crDept' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crWork' style='width:100%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		    $("#careerlist").append(row);

    		}else if(mode == "activity"){
    			var StartId = $('input[name=acStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=acNm]:last').val() == ""){
    				alert("조직(학회)명을 입력 해주세요");
    				$('input[name=acNm]:last').focus();
    				return false;
    			}

    			if($('input[name=acStart]:last').val() == "" || $('input[name=acFinish]:last').val() == "" ){
    				$('input[name=acStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=acFinish]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acFinish]:last').focus();
					return false;
				}
    			if($('input[name=acDept]:last').val() == ""){
    				$('input[name=acDept]:last').focus();
    				alert("직위를 입력 해주세요");
    				return false;
    			}

    			if($('input[name=acWork]:last').val() == ""){
    				$('input[name=acWork]:last').focus();
    				alert("주요업무를 입력 해주세요");
    				return false;
    			}


    			var row = "";
    		 	row += "<tr id='activity"+plusScCnt+"'>";
    		 	row += "<td colspan='2'><input type='text' name='acNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acStart' id='acStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acFinish' id='acFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acDept' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acWork' style='width:100%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		    $("#activitylist").append(row);

    		}else if(mode == "RnDresult"){
    			var StartId = $('input[name=rdStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=rdSerialNum]:last').val() == ""){
    				alert("연번을 입력 해주세요");
    				$('input[name=rdSerialNum]:last').focus();
    				return false;
    			}
    			if($('input[name=rdOrgNm]:last').val() == ""){
    				alert("부처/기관명/발주처명을 입력 해주세요");
    				$('input[name=rdOrgNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdBusinessNm]:last').val() == ""){
    				alert("사업명을 입력 해주세요");
    				$('input[name=rdBusinessNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdNm]:last').val() == ""){
    				alert("과제명을 입력 해주세요");
    				$('input[name=rdNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdStart]:last').val() == "" || $('input[name=rdFinish]:last').val() == "" ){
    				$('input[name=rdStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdFinish]:last').focus();
					return false;
				}
    			if($('input[name=rdExpenses]:last').val() == ""){
    				$('input[name=rdExpenses]:last').focus();
    				alert("사업비를 입력 해주세요");
    				return false;
    			}
    			if(isNaN($('input[name=rdExpenses]:last').val())){
					alert("연구개발과제(프로젝트) 수행실적(사업비) : 숫자만 입력해주세요. ex)10000");
					$('input[name=rdExpenses]:last').focus();
					return false;
				}
    			if($('select[name=rdForm]:last').val() == ""){
    				$('select[name=rdForm]:last').focus();
    				alert("참여형태를 선택 해주세요");
    				return false;
    			}

    			var row = "";
    		 	row += "<tr id='RnDresult"+plusScCnt+"'>";
    		 	row += "<td ><input type='text' name='rdSerialNum' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td ><input type='text' name='rdOrgNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td ><input type='text' name='rdBusinessNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td ><input type='text' name='rdNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='rdStart' id='rdStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='rdFinish' id='rdFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='rdExpenses' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><select name='rdForm' class='select_box'>";
    		 	row += "<option value=''>선택</option>";
    		 	row += "<option value='총괄책임자'>총괄책임자</option>";
    		 	row += "<option value='참여or위탁책임자'>참여or위탁책임자</option>";
    		 	row += "<option value='실무담당자'>실무담당자</option>";
    			row += "<option value='참여연구원'>참여연구원</option>";
    			row += "</select></td>";
    		   	row += "</tr>";
    		    $("#RnDresultlist").append(row);

    		}else if(mode == "qualification"){
   			var StartId = $('input[name=quStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=quSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=quSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=quStart]:last').val() == "" ){
   				$('input[name=quStart]:last').focus();
   				alert("취득일을 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=quStart]:last').val()) == false){
				alert("자격사항(취득일) : ex) 2016-01");
				$('input[name=quStart]:last').focus();
				return false;
			}
   			if($('input[name=quOrgNm]:last').val() == ""){
   				$('input[name=quOrgNm]:last').focus();
   				alert("발급기관명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=quDivide]:last').val() == ""){
   				$('select[name=quDivide]:last').focus();
   				alert("자격구분을 선택 해주세요");
   				return false;
   			}
   			if($('input[name=quNm]:last').val() == ""){
   				$('input[name=quNm]:last').focus();
   				alert("자격명을 입력 해주세요");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='qualification"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='quSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='quStart' id='quStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='quOrgNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box' name='quDivide' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='국가공인'>국가공인</option>";
   		 	row += "<option value='국제공인'>국제공인</option>";
   			row += "<option value='시설가격'>시설가격</option>";
   			row += "</select>";
   			row += "</td>";
   		 	row += "<td><input type='text' name='quNm' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#qualificationlist").append(row);

  		}else if(mode == "research"){
  			var StartId = $('input[name=reNote]:last').attr('id');
  			var cnt = StartId.substring(7,8); //0으로 자름
  		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
  			var option = $('#reDeth1'+cnt).html();
		if($('select[name=reDeth1]:last').val() == ""){
  				$('select[name=reDeth1]:last').focus();
  				alert("대분류를 선택 해주세요");
  				return false;
  			}

		if($('select[name=reDeth2]:last').val() == ""){
  				$('select[name=reDeth2]:last').focus();
  				alert("중분류를 선택 해주세요");
  				return false;
  			}

		if($('select[name=reDeth3]:last').val() == ""){
  				$('select[name=reDeth3]:last').focus();
  				alert("소분류를 선택 해주세요");
  				return false;
  			}
  			var row = "";
  		 	row += "<tr id='research"+plusScCnt+"'>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth1' id='reDeth1"+plusScCnt+"' onchange=\"standardDeth1('reDeth2"+plusScCnt+"')\">"+option+"</select></td>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth2' id='reDeth2"+plusScCnt+"' onchange=\"standardDeth2('reDeth3"+plusScCnt+"')\"></select></td>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth3' id='reDeth3"+plusScCnt+"'></select></td>";
  		 	row += "<td colspan='2'><input type='text' name='reNote' id='resNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='비고'></td>";
  		   	row += "</tr>";
  		    $("#researchlist").append(row);

   		}else if(mode == "evaluate"){
   			var StartId = $('input[name=evNote]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   		    var option = $('#evDeth1'+cnt).html();

   			var row = "";

   			if($('select[name=evDeth1]:last').val() == ""){
   				$('select[name=evDeth1]:last').focus();
   				alert("대분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=evDeth2]:last').val() == ""){
   				$('select[name=evDeth2]:last').focus();
   				alert("중분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=evDeth3]:last').val() == ""){
   				$('select[name=evDeth3]:last').focus();
   				alert("소분류를 선택 해주세요");
   				return false;
   			}
   		 	row += "<tr id='evaluate"+plusScCnt+"'>";
   		 	row += "<td><select class='select_box' style='width:100%' name='evDeth1' id='evDeth1"+plusScCnt+"' onchange=\"standardDeth1('evDeth2"+plusScCnt+"')\">"+option+"</select></td>";
   		 	row += "<td><select class='select_box' style='width:100%' name='evDeth2' id='evDeth2"+plusScCnt+"' onchange=\"standardDeth2('evDeth3"+plusScCnt+"')\"></select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='evDeth3' id='evDeth3"+plusScCnt+"' ></select></td>";
   		 	row += "<td colspan='2'><input type='text' name='evNote' id='evlNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='비고'></td>";
   		   	row += "</tr>";
   		    $("#evaluatelist").append(row);

   		}else if(mode == "consulting"){
   			var StartId = $('input[name=coNote]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   		    var option = $('#coDeth1'+cnt).html();
			if($('select[name=coDeth1]:last').val() == ""){
   				$('select[name=coDeth1]:last').focus();
   				alert("대분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=coDeth2]:last').val() == ""){
   				$('select[name=coDeth2]:last').focus();
   				alert("중분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=coDeth3]:last').val() == ""){
   				$('select[name=coDeth3]:last').focus();
   				alert("소분류를 선택 해주세요");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='consulting"+plusScCnt+"'>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth1' id='coDeth1"+plusScCnt+"' onchange=\"standardDeth1('coDeth2"+plusScCnt+"')\">"+option+"</select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth2' id='coDeth2"+plusScCnt+"' onchange=\"standardDeth2('coDeth3"+plusScCnt+"')\"></select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth3' id='coDeth3"+plusScCnt+"'></select></td>";
   		 	row += "<td colspan='2'><input type='text' name='conNote' id='conNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='비고'></td>";
   		   	row += "</tr>";
   		    $("#consultinglist").append(row);

   		}else if(mode == "researchPaper"){
   			var StartId = $('input[name=rpStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=rpSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=rpSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=rpStart]:last').val() == "" ){
   				$('input[name=rpStart]:last').focus();
   				alert("게제년도를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=rpStart]:last').val()) == false){
				alert("연구논문 실적(게제년도) : ex) 2016-01");
				$('input[name=rpStart]:last').focus();
				return false;
			}
   			if($('input[name=rpJournalNm]:last').val() == ""){
   				$('input[name=rpJournalNm]:last').focus();
   				alert("학술지명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=rpNm]:last').val() == ""){
   				$('select[name=rpNm]:last').focus();
   				alert("논문명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=rpType]:last').val() == ""){
   				$('select[name=rpType]:last').focus();
   				alert("논문유형을 선택 해주세요");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='researchPaper"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='rpSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='rpNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box' name='rpType' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='국내학술지'>국내학술지</option>";
   		 	row += "<option value='국내학술대회'>국내학술대회</option>";
   		 	row += "<option value='국외학술지'>국외학술지</option>";
   		 	row += "<option value='국외학술대회'>국외학술대회</option>";
   			row += "<option value='기타학술지'>기타학술지</option>";
   			row += "</select>";
   			row += "</td>";
   			row += "<td><input type='text' name='rpJournalNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='rpStart' id='rpStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#researchPaperlist").append(row);

   		}else if(mode == "inProperty"){
   			var StartId = $('input[name=ipStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=ipSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=ipSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=ipNm]:last').val() == ""){
   				$('input[name=ipNm]:last').focus();
   				alert("지식재산명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=ipType]:last').val() == ""){
   				$('select[name=ipType]:last').focus();
   				alert("지식재산유형을 선택 해주세요");
   				return false;
   			}
   			if($('input[name=ipPubliccation]:last').val() == ""){
   				$('input[name=ipPubliccation]:last').focus();
   				alert("인증/발행처를 입력 해주세요");
   				return false;
   			}
   			if($('input[name=ipStart]:last').val() == "" ){
   				$('input[name=ipStart]:last').focus();
   				alert("등록년도를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=ipStart]:last').val()) == false){
				alert("지식재산 실적(등록년도) : ex) 2016-01");
				$('input[name=ipStart]:last').focus();
				return false;
			}
   			var row = "";
   		 	row += "<tr id='inProperty"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='ipSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='ipNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box'  name='ipType' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='특허'>특허</option>";
   		 	row += "<option value='실용실안'>실용실안</option>";
   			row += "<option value='상표'>상표</option>";
   			row += "<option value='디자인'>디자인</option>";
   			row += "<option value='프로그램'>프로그램</option>";
   			row += "<option value='저작권'>저작권</option>";
   			row += "<option value='기타지식재산'>기타지식재산</option>";
   			row += "</select>";
   			row += "</td>";
   			row += "<td><input type='text' name='ipPublication' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='ipStart' id='ipStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#inPropertylist").append(row);

   		}else if(mode == "awardCareer"){
   			var StartId = $('input[name=awStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=awSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=awSerialNum]:last').focus();
   				return false;
   			}
   		    if($('select[name=awBadge]:last').val() == ""){
   				$('select[name=awBadge]:last').focus();
   				alert("훈격을 선택 해주세요");
   				return false;
   			}
   			if($('input[name=awStart]:last').val() == "" ){
   				$('input[name=awStart]:last').focus();
   				alert("수여일자를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=awStart]:last').val()) == false){
				alert("수상실적(수여일자) : ex) 2016-01");
				$('input[name=awStart]:last').focus();
				return false;
			}

   			if($('input[name=awPresent]:last').val() == ""){
   				$('input[name=awPresent]:last').focus();
   				alert("수여기관을 입력 해주세요");
   				return false;
   			}
   			if($('input[name=awContent]:last').val() == ""){
   				$('input[name=awContent]:last').focus();
   				alert("공적내용을 입력 해주세요");
   				return false;
   			}

   			var row = "";
   		 	row += "<tr id='awardCareer"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='awSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box'  name='awBadge' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='훈장'>훈장</option>";
   		 	row += "<option value='포장'>포장</option>";
   			row += "<option value='표창'>표창</option>";
   			row += "</select>";
   			row += "</td>";
   		 	row += "<td><input type='text' name='awStart' id='awStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='awPresent' style='width:100%;' class='inp_txt'></td>";
   			row += "<td><input type='text' name='awContent' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#awardCareerlist").append(row);

   		}else if(mode == "resultEv"){
   			var StartId = $('input[name=evSdate]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=evName]:last').val() == ""){
   				alert("평가대상 사업명(평가명)을 입력 해주세요");
   				$('input[name=evName]:last').focus();
   				return false;
   			}
   		    if($('select[name=evOrg]:last').val() == ""){
   				$('select[name=evOrg]:last').focus();
   				alert("요청기관명을 입력 해주세요");
   				return false;
   			}
   			if($('input[name=evSdate]:last').val() == "" ){
   				$('input[name=evSdate]:last').focus();
   				alert("평가기간를 선택 해주세요");
   				return false;
   			}
   			if($('input[name=evEdate]:last').val() == "" ){
   				$('input[name=evEdate]:last').focus();
   				alert("평가기간를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=evSdate]:last').val()) == false){
				alert("평가기간 : ex) 2016-01");
				$('input[name=evSdate]:last').focus();
				return false;
			}
   			if(datePattern.test($('input[name=evEdate]:last').val()) == false){
				alert("평가기간 : ex) 2016-01");
				$('input[name=evEdate]:last').focus();
				return false;
			}
   			if($('input[name=evContent]:last').val() == ""){
   				$('input[name=evContent]:last').focus();
   				alert("평가내용을 입력 해주세요");
   				return false;
   			}

   			var row = "";
   		 	row += "<tr id='resultEv"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='evName' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='evOrg' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='evSdate' id='evSdate"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='evEdate' id='evEdate"+plusScCnt+"'  style='width:100%;' class='inp_txt'></td>";
   			row += "<td><input type='text' name='evContent' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#resultEvlist").append(row);
  		}else if(mode == "resultCon"){
  			var StartId = $('input[name=conSdate]:last').attr('id');
  			var cnt = StartId.substring(8,9); //0으로 자름
  		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
  			/* 입력제어  */
  			if($('input[name=conName]:last').val() == ""){
  				alert("컨설팅 사업명(컨설팅명)을 입력 해주세요");
  				$('input[name=conName]:last').focus();
  				return false;
  			}
  		    if($('select[name=conOrg]:last').val() == ""){
  				$('select[name=conOrg]:last').focus();
  				alert("요청기관명을 입력 해주세요");
  				return false;
  			}
  			if($('input[name=conSdate]:last').val() == "" ){
  				$('input[name=conSdate]:last').focus();
  				alert("평가기간를 선택 해주세요");
  				return false;
  			}
  			if($('input[name=conEdate]:last').val() == "" ){
  				$('input[name=conEdate]:last').focus();
  				alert("평가기간를 선택 해주세요");
  				return false;
  			}
  			if(datePattern.test($('input[name=conSdate]:last').val()) == false){
				alert("컨설팅기간 : ex) 2016-01");
				$('input[name=conSdate]:last').focus();
				return false;
			}
  			if(datePattern.test($('input[name=conEdate]:last').val()) == false){
				alert("컨설팅기간 : ex) 2016-01");
				$('input[name=conEdate]:last').focus();
				return false;
			}
  			if($('input[name=conContent]:last').val() == ""){
  				$('input[name=conContent]:last').focus();
  				alert("컨설팅내용을 입력 해주세요");
  				return false;
  			}
  			var row = "";
  		 	row += "<tr id='resultCon"+plusScCnt+"'>";
  		 	row += "<td><input type='text' name='conName' style='width:100%;' class='inp_txt'></td>";
  		 	row += "<td><input type='text' name='conOrg' style='width:100%;' class='inp_txt'></td>";
  		 	row += "<td><input type='text' name='conSdate' id='conSdate"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
  		 	row += "<td><input type='text' name='conEdate' id='conEdate"+plusScCnt+"'  style='width:100%;' class='inp_txt'></td>";
  			row += "<td><input type='text' name='conContent' style='width:100%;' class='inp_txt'></td>";
  		   	row += "</tr>";
  		    $("#resultConlist").append(row);
  		}
    	//date
		setLicenseBtn(plusScCnt, mode);
	}
//addRow E
//delRow S
	function delRow(mode){
   		if(mode=="academic"){
   			if($('input[name=scNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=scNm]').size() - 1;
   			var parenttr = $("#academic_career_info"+delCnt).remove();
   		}else if(mode == "career"){
   			if($('input[name=crNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=crNm]').size() - 1;
   			var parenttr = $("#career_info"+delCnt).remove();
   		}else if(mode == "activity"){
   			if($('input[name=acNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=acNm]').size() - 1;
   			var parenttr = $("#activity"+delCnt).remove();
   		}else if(mode == "RnDresult"){
   			if($('input[name=rdNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=rdNm]').size() - 1;
   			var parenttr = $("#RnDresult"+delCnt).remove();
   		}else if(mode == "qualification"){
   			if($('input[name=quNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=quNm]').size() - 1;
   			var parenttr = $("#qualification"+delCnt).remove();
   		}else if(mode == "research"){
   			if($('input[name=reNote]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=reNote]').size() - 1;
   			var parenttr = $("#research"+delCnt).remove();

   		}else if(mode == "evaluate"){
   			if($('input[name=evNote]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=evNote]').size() - 1;
   			var parenttr = $("#evaluate"+delCnt).remove();

   		}else if(mode == "consulting"){
   			if($('input[name=coNote]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=coNote]').size() - 1;
   			var parenttr = $("#consulting"+delCnt).remove();

   		}else if(mode == "researchPaper"){
   			if($('input[name=rpNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=rpNm]').size() - 1;
   			var parenttr = $("#researchPaper"+delCnt).remove();

   		}else if(mode == "inProperty"){
   			if($('input[name=ipNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=ipNm]').size() - 1;
   			var parenttr = $("#inProperty"+delCnt).remove();

   		}else if(mode == "awardCareer"){
   			if($('input[name=awStart]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=awStart]').size() - 1;
   			var parenttr = $("#awardCareer"+delCnt).remove();
   		}else if(mode == "resultEv"){
   			if($('input[name=evSdate]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=evSdate]').size() - 1;
   			var parenttr = $("#resultEv"+delCnt).remove();
   		}else if(mode == "resultCon"){
   			if($('input[name=conSdate]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=conSdate]').size() - 1;
   			var parenttr = $("#resultCon"+delCnt).remove();
   		}
   		setLicenseBtn();
   	}
//delRow E
//addRow시 datePicker S
	function setLicenseBtn(plusScCnt, mode){
    	/* DatePicker 설정 */
   		var date ="";
   		if(mode == "academic"){
   			date = "#scStart"+plusScCnt+", #scFinish"+plusScCnt;
   		}else if(mode == "career"){
   			date = "#crStart"+plusScCnt+", #crFinish"+plusScCnt;
   		}else if(mode == "activity"){
   			date = "#acStart"+plusScCnt+", #acFinish"+plusScCnt;
   		}else if(mode == "RnDresult"){
   			date = "#rdStart"+plusScCnt+", #rdFinish"+plusScCnt;
   		}else if(mode == "qualification"){
   			date = "#quStart"+plusScCnt;
   		}else if(mode == "researchPaper"){
   			date = "#rpStart"+plusScCnt;
   		}else if(mode == "inProperty"){
   			date = "#ipStart"+plusScCnt;
   		}else if(mode == "awardCareer"){
   			date = "#awStart"+plusScCnt;
   		}else if(mode == "resultEv"){
   			date = "#evSdate"+plusScCnt+", #evEdate"+plusScCnt;
   		}else if(mode == "resultCon"){
   			date = "#conSdate"+plusScCnt+", #conEdate"+plusScCnt;
   		}

		$(date).datepicker({
			showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',

			closeText : '닫기',
			dateFormat : "yy-mm",
			dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
			dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ],
			 onClose: function(dateText, inst) {
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).datepicker('setDate', new Date(year, month, 1));
		        },

			showButtonPanel:true,
			yearRange: '1980:2020'
		});
	};
//addRow시 datePicker E
</script>