<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	ArrayList<HashMap<String, String>> listSC = request.getAttribute("listSC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listSC");
	ArrayList<HashMap<String, String>> listCR = request.getAttribute("listCR") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCR");
	ArrayList<HashMap<String, String>> listAC = request.getAttribute("listAC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAC");
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	ArrayList<HashMap<String, String>> listRP = request.getAttribute("listRP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRP");
	ArrayList<HashMap<String, String>> listIP = request.getAttribute("listIP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listIP");
	ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	ArrayList<HashMap<String, String>> listEX = request.getAttribute("listEX") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEX");
	ArrayList<HashMap<String, String>> listRE = request.getAttribute("listRE") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRE");
	ArrayList<HashMap<String, String>> listEV = request.getAttribute("listEV") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEV");
	ArrayList<HashMap<String, String>> listCO = request.getAttribute("listCO") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCO");
	ArrayList<HashMap<String, String>> listResultEv = request.getAttribute("listResultEv") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultEv");
	ArrayList<HashMap<String, String>> listResultCon = request.getAttribute("listResultCon") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultCon");
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
	String siteId = siteInfoVO.getSiteId();
	LoginVO loginVO = util.getLoginInfo(request) == null ?new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String fileGrp = "expertManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String userIdx = util.getIntStr(paramMap.get("userIdx"));
	String m = util.getStr(paramMap.get("m"));


%>
<form name="fview" id="fview" action="sub.do" method="post" >
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID"))%>" />
	<div class="skin_bbs_write" style="margin-top: 30px">

		<h2 class="h4_tit">기본정보</h2>
		<table id="profileTable" class="skin_view" >
			<caption>기본정보</caption>
			<colgroup>
				<col style="width:20%" />
				<col style="width:15%" />
				<col style="width:25%" />
				<col style="width:15%" />
				<col style="width:25%" />
			</colgroup>
			<tbody>


				<tr id="profile1">
					<td rowspan="4" style="text-align: center; vertical-align: middle;">
						<%if(util.getIntStr(dataMap.get("FILE_ID")).equals("") || util.getIntStr(dataMap.get("FILE_ID")).equals(null) || util.getIntStr(dataMap.get("FILE_ID")).equals("0")){ %>
							<img style="width:135px; height:150px;" src="/img/main/no_image01.gif" alt="프로필사진" />
						<%}else{%>
							<img src = "/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" style="width:135px;height:150px;" alt="프로필사진" />
						<%}%>
					</td>
					<th scope="col" >이름</th>
					<td><%=util.getStr(dataMap.get("PSN_NM")) %></td>
			 		<th scope="col" >성별</th>
			 		<td class="r_line_none"><input type="text" <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='남자'" : "value='여자'" %> class="inp_txt02" style="border:0px;" readonly='readonly' /></td>
			 	</tr>
			 	<tr id="profile2" style="display:none">
					<td class="table_img_box img_size_new" colspan="4" style="width:135px;height:150px; text-align: center; vertical-align: middle;">
						<%if(util.getIntStr(dataMap.get("FILE_ID")).equals("") || util.getIntStr(dataMap.get("FILE_ID")).equals(null)){ %>
							<imgstyle="width:135px;height:150px;" src="/img/main/no_image01.gif" alt="프로필사진" />
						<%}else{%>
							<img src = "/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" style="" alt="프로필사진" />
						<%}%>
					</td>
			 	</tr>
			 	<tr id="profile3" style="display:none">
						<th scope="col" >이름</th>
						<td><%=util.getStr(dataMap.get("PSN_NM")) %></td>
				 		<th scope="col" >성별</th>
				 		<td class="r_line_none"><input type="text" <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='남자'" : "value='여자'" %> class="inp_txt02" style="border:0px;" readonly='readonly' /></td>
			 	</tr>

				<tr>
					<th scope="col" >생년월일</th>
					<td><%=util.getStr(dataMap.get("BIRTH_DATE")) %></td>
			 		<th scope="col" >email</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("EMAIL")) %></td>
				</tr>
				<tr>
			 		<th scope="col" >국적</th>
			 		<td>
			 			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
							if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
								<input type="text" name="proUserForg" id="proUserForg"class="inp_txt" style="width:100%;" maxlength="100">
							<%}else{%>
								<input type="text" name="proUserForg" id="proUserForg"value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>" class="inp_txt" style="width:100%;"readonly style="border:0px;" >
							<%} %>
						<%}else{ %>
							대한민국
						<%} %>
			 		</td>
			 		<th scope="col" >출생지역</th>
			 		<td class="r_line_none"><%=util.getStr(dataMap.get("PRO_USER_BIRTHPLACE"))%></td>
				</tr>
				<tr>
					<th scope="col" >전화번호</th>
					<td><%=util.getStr(dataMap.get("TEL_NO")) %></td>
		 			<th scope="col" >휴대전화</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("CP_NO")) %></td>
				</tr>
<%if(siteId.endsWith("jntis")){ %>
				<tr>
					<th scope="col" >전문가 구분</th>
					 <td class="r_line_none" colspan="4">
						정책기획 <input type="checkbox" name="proJntisPlanning" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_PLANNING"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						연구개발 <input type="checkbox" name="proJntisRnd" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_RND"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						기업지원 <input type="checkbox" name="proJntisCompany" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_COMPANY"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						연구장비 <input type="checkbox" name="proJeinet" value="Y" <%=(util.getStr(dataMap.get("PRO_JEINET"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						지식재산 <input type="checkbox" name="proJipbank" value="Y" <%=(util.getStr(dataMap.get("PRO_JIPBANK"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						인력양성 <input type="checkbox" name="proJntisEducation" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_EDUCATION"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						컨설팅 <input type="checkbox" name="proJntisConsulting" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_CONSULTING"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						마케팅 <input type="checkbox" name="proJntisMarketing" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_MARKETING"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						기타 <input type="checkbox" name="proJntisEtc" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_ETC"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
					</td>
				</tr>
<%} %>
				<tr>
            		<th scope="row" class="tit">관심분야</th>
            		<td colspan="4">
						<%=util.getStr(dataMap.get("PRO_USER_INTEREST_WORLD"))%>
					</td>
            	</tr>
			</tbody>
		</table>
		<%if(!(util.getStr(dataMap.get("ORG_GRP_CD"))).equals("") && !(util.getStr(dataMap.get("ORG_GRP_CD"))).equals(null)){ %>
		<h2 class="h4_tit">소속정보</h2>
		<table class="skin_view">
			<caption>소속정보</caption>
			<colgroup>
				<col style="width:15%" />
				<col style="width:35%" />
				<col style="width:15%" />
				<col style="width:35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" >기관명</th>
					<td><%=util.getStr(dataMap.get("ORG_GRP_NM")) %></td>
					<th scope="col" >기관유형</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("ORG_TYPE")) %></td>
				</tr>
				<tr>
					<th scope="col" >홈페이지</th>
					<td><%=util.getStr(dataMap.get("HOMEPAGE")) %></td>
					<th scope="col" >대표전화</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("CORP_PHONE")) %></td>
				</tr>
				<tr>
					<th scope="col" >부서명</th>
					<td><%=util.getStr(dataMap.get("DEPT_NM")) %></td>
					<th scope="col" >직위</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("POSITION_NM")) %></td>
				</tr>
			</tbody>
		</table>
		<%} %>
		<h2 class="h4_tit">학력정보</h2>
		<table class="skin_list textCenter">
			<caption>학력정보</caption>
				<colgroup>
	            <col style="width:25%" />
          		<col style="width:25%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:25%" />
				</colgroup>
			<%if(listSC.size()>0){ %>
			 	<tr>
			 		<th scope="col" >학교명</th>
			 		<th scope="col" >소재지</th>
			 		<th scope="col"colspan="2">기간</th>
			 		<th scope="col" class="r_line_none">취득학위</th>
			 	</tr>
				<% for(HashMap rs:listSC) {%>
			 	<tr>
			 		<td><%=util.getStr(rs.get("SC_NM"))%></td>
			 		<td><%=util.getStr(rs.get("SC_LOCATION"))%></td>
			 		<td><%=util.getStr(rs.get("SC_START"))%></td>
			 		<td><%=util.getStr(rs.get("SC_FINISH"))%></td>
			 		<td class="r_line_none"><%=util.getStr(rs.get("SC_DEGREE"))%></td>
			 	</tr>
				<%} %>
			<%} %>
		</table>
		<h3>○ 전공분야</h3>
		<table class="skin_view textCenter">
			<caption>전문분야</caption>
			<colgroup>
			<col style="width:15%" />
			<col style="width:18%" />
			<col style="width:15%" />
			<col style="width:18%" />
			<col style="width:15%" />
			<col style="width:18%" />
			</colgroup>

		<%if(listEX.size()>0){ %>
			<% for(HashMap rs:listEX) {%>
			<tr>
				<th scope="col">전공계열</th>
				<td ><%=util.getStr(rs.get("EX_MAJOR_NAME"))%></td>
				<th scope="col" >전공분야</th>
				<td><%=util.getStr(rs.get("EX_REALM_NAME"))%></td>
				<th scope="col" >세부전공</th>
				<td class="r_line_none"><%=util.getStr(rs.get("EX_DETAIL_NAME"))%></td>
			</tr>
			<tr>
				<th scope="col" >복수전공계열</th>
				<td><%=util.getStr(rs.get("EX_MAJOR_PLURAL_NAME"))%></td>
				<th scope="col" >전공분야</th>
				<td><%=util.getStr(rs.get("EX_REALM_PLURAL_NAME"))%></td>
				<th scope="col" >세부전공</th>
				<td class="r_line_none"><%=util.getStr(rs.get("EX_DETAIL_PLURAL_NAME"))%></td>
			</tr>
		<%
			}
		} else{%>
			<tr>
				<th scope="col">전공계열</th>
				<td ></td>
				<th scope="col" >전공분야</th>
				<td></td>
				<th scope="col" >세부전공</th>
				<td class="r_line_none"></td>
			</tr>
			<tr>
				<th scope="col" >복수전공계열</th>
				<td></td>
				<th scope="col" >전공분야</th>
				<td></td>
				<th scope="col" >세부전공</th>
				<td class="r_line_none"></td>
			</tr>
		<%} %>
		</table>
		<h2 class="h4_tit">경력정보</h2>
		<table class="skin_list textCenter">
			<caption>경력정보</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:20%" />
				</colgroup>
			 	<tr>
			 		<th scope="col" >직장명</th>
			 		<th scope="col" >소재지</th>
			 		<th scope="col"colspan="2">기간</th>
			 		<th scope="col" >최종직위</th>
			 		<th scope="col"class="r_line_none">주요업무</th>
			 	</tr>
			<%if(listCR.size()>0){ %>
				<% for(HashMap rs:listCR) {%>
				<tr>
					<td><%=util.getStr(rs.get("CR_NM"))%></td>
					<td><%=util.getStr(rs.get("CR_LOCATION"))%></td>
					<td><%=util.getStr(rs.get("CR_START"))%></td>
					<td><%=util.getStr(rs.get("CR_FINISH"))%></td>
					<td><%=util.getStr(rs.get("CR_DEPT"))%></td>
					<td class="r_line_none"><%=util.getStr(rs.get("CR_WORK"))%></td>
				</tr>
				<%} %>
			<%} else{%>
				<tr>
					<td style="text-align:center;"colspan="6">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<h2 class="h4_tit">대외활동</h2>
		<table class="skin_list textCenter">
			<caption>대외활동</caption>
				<colgroup>
					<col style="width:30%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tr>
					<th scope="col" >조직(학회)명</th>
					<th scope="col"colspan="2">기간</th>
					<th scope="col" >직위</th>
					<th scope="col" class="r_line_none" >주요업무</th>
				</tr>
			<%if(listAC.size()>0){ %>
				<% for(HashMap rs:listAC) {%>
				<tr>
					<td><%=util.getStr(rs.get("AC_NM"))%></td>
					<td><%=util.getStr(rs.get("AC_START"))%></td>
					<td><%=util.getStr(rs.get("AC_FINISH"))%></td>
					<td><%=util.getStr(rs.get("AC_DEPT"))%></td>
					<td class="r_line_none"><%=util.getStr(rs.get("AC_WORK"))%></td>
				</tr>
			<%} %>
			<%} else{%>
				<tr>
					<td style="text-align:center;"colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<h2 class="h4_tit">연구개발과제(프로젝트) 수행실적</h2>
		<table class="skin_list textCenter">
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
					<th scope="col" >연번</th>
					<th scope="col" >부처/기관/발주처명</th>
					<th scope="col" >사업명</th>
					<th scope="col" >과제명</th>
					<th scope="col"colspan="2">총사업참여기간</th>
					<th scope="col" >사업비</th>
					<th scope="col" class="r_line_none" >참여형태</th>
				</tr>

		<%if(listRD.size()>0){ %>
			<%
				for (HashMap rs : listRD) {
			%>
				<tr>
					<td><%=util.getStr(rs.get("RD_SERIAL_NUM"))%></td>
					<td><%=util.getStr(rs.get("RD_ORG_NM"))%></td>
					<td><%=util.getStr(rs.get("RD_BUSINESS_NM"))%></td>
					<td><%=util.getStr(rs.get("RD_NM"))%></td>
					<td><%=util.getStr(rs.get("RD_START"))%></td>
					<td><%=util.getStr(rs.get("RD_FINISH"))%></td>
					<td><%=util.getStr(rs.get("RD_EXPENSES"))%></td>
					<td class="r_line_none"><%=util.getStr(rs.get("RD_FORM"))%></td>
				</tr>
			<%} %>
		<%} else{%>
				<tr>
					<td style="text-align:center;"colspan="8" class="r_line_none">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<h2 class="h4_tit">외부평가 수행실적</h2>
		<table class="skin_list textCenter">
			<caption>외부평가 수행실적</caption>
			<colgroup>
	        	<col style="width:30%" />
			    <col style="width:20%" />
			    <col style="width:10%" />
			    <col style="width:10%" />
			    <col style="width:30%" />
			</colgroup>
		 	<tr>
		 		<th scope="row" class="tit">평가대상 사업명(평가명)</th>
		 		<th scope="row" class="tit">요청기관명</th>
		 		<th scope="row" class="tit" colspan="2">평가기간</th>
		 		<th scope="row" class="tit">평가내용</th>
		 	</tr>
	 	<%
		if (listResultEv.size() > 0) {
		%>
			<% for(HashMap rs:listResultEv) {%>
		 	<tr>
				<td><%=util.getStr(rs.get("EV_NAME"))%></td>
		  		<td><%=util.getStr(rs.get("EV_ORG"))%></td>
		  		<td><%=util.getStr(rs.get("EV_SDATE"))%></td>
		  		<td><%=util.getStr(rs.get("EV_EDATE"))%></td>
		  		<td><%=util.getStr(rs.get("EV_CONTENT"))%></td>
		 	</tr>
		 	<%}%>
		<%} else{%>
				<tr  class="r_line_none">
					<td style="text-align:center;" colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<h2 class="h4_tit">컨설팅 수행실적</h2>
		<table class="skin_list textCenter">
			<caption>컨설팅 수행실적</caption>
			<colgroup>
	        	<col style="width:30%" />
			    <col style="width:20%" />
			    <col style="width:10%" />
			    <col style="width:10%" />
			    <col style="width:30%" />
	        </colgroup>
			<tr>
		 		<th scope="row" class="tit">컨설팅 사업명(컨설팅명)</th>
		 		<th scope="row" class="tit">요청기관명</th>
		 		<th scope="row" class="tit" colspan="2">컨설팅기간</th>
		 		<th scope="row" class="tit">컨설팅내용</th>
		 	</tr>
		 	<%if(listResultCon.size()>0){ %>
				<% for(HashMap rs:listResultCon) {%>
		    	<tr>
		 	  		<td><%=util.getStr(rs.get("CON_NAME"))%></td>
			  		<td><%=util.getStr(rs.get("CON_ORG"))%></td>
			  		<td><%=util.getStr(rs.get("CON_SDATE"))%></td>
			  		<td><%=util.getStr(rs.get("CON_EDATE"))%></td>
			  		<td><%=util.getStr(rs.get("CON_CONTENT"))%></td>
			 	  	</tr>
		 	<%}%>
		<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>


		<!-- 연구논문 실적 S -->
		<h2 class="h4_tit">연구논문 실적</h2>
		<table class="skin_list textCenter" >
			<caption>연구논문 실적</caption>
			 <colgroup>
				<col style="width:10%" />
				<col style="width:34%" />
				<col style="width:23%" />
				<col style="width:23%" />
			 	<col style="width:10%" />
			 </colgroup>
			 	<tr>
					<th scope="col" >연번</th>
					<th scope="col" >논문명</th>
					<th scope="col" >논문유형</th>
					<th scope="col" >학술지명</th>
					<th scope="col" class="r_line_none" >게제년도</th>
				</tr>
		<%if(listRP.size()>0){ %>
			<%
				for (HashMap rs : listRP) {
			%>
				<tr>
					<td><%=util.getStr(rs.get("RP_SERIAL_NUM"))%></td>
					<td><%=util.getStr(rs.get("RP_NM"))%></td>
					<td><%=util.getStr(rs.get("RP_TYPE"))%></td>
					<td><%=util.getStr(rs.get("RP_JOURNAL_NM"))%></td>
					<td class="r_line_none"><%=util.getStr(rs.get("RP_START"))%></td>
				</tr>
		<%} %>
		<%} else{%>
				<tr>
					<td style="text-align:center;"colspan="5" class="r_line_none">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<!-- 연구논문 실적 E -->
		<!-- 지식재산 실적 S -->
		<h2 class="h4_tit">지식재산 실적</h2>
		<table class="skin_list textCenter">
			<caption>지식재산 실적</caption>
				<colgroup>
					<col style="width:10%" />
					<col style="width:34%" />
					<col style="width:23%" />
					<col style="width:23%" />
				 	<col style="width:10%" />
				</colgroup>
			 	<tr>
					<th scope="col" >연번</th>
					<th scope="col" >지식재산명</th>
					<th scope="col" >지식재산유형</th>
					<th scope="col" >인증/발행처</th>
					<th scope="col" class="r_line_none" >등록년도</th>
				</tr>
		<%if(listIP.size()>0){ %>
			 	<%
			 		for (HashMap rs : listIP) {
			 	%>
			 	<tr>
			 		<td><%=util.getStr(rs.get("IP_SERIAL_NUM"))%></td>
			 		<td><%=util.getStr(rs.get("IP_NM"))%></td>
			 		<td><%=util.getStr(rs.get("IP_TYPE"))%></td>
			 		<td><%=util.getStr(rs.get("IP_PUBLICATION"))%></td>
			 		<td class="r_line_none"><%=util.getStr(rs.get("RP_START"))%></td>
				</tr>
				<%} %>
		<%} else{%>
				<tr>
					<td style="text-align:center;"colspan="5" class="r_line_none">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<!-- 지식재산 실적 E -->
		<!-- 수상 실적 S -->
		<h2 class="h4_tit">수상실적</h2>
		<table class="skin_list textCenter">
			<caption>수상 실적</caption>
				<colgroup>
					<col style="width:10%" />
					<col style="width:23%" />
					<col style="width:10%" />
					<col style="width:23%" />
				 	<col style="width:34%" />
				</colgroup>
			 	<tr>
					<th scope="col" >연번</th>
					<th scope="col" >훈격</th>
					<th scope="col" >수여일자</th>
					<th scope="col" >수여기관</th>
					<th scope="col" class="r_line_none" >공적내용</th>

				</tr>
		<%if(listAW.size()>0){ %>
			 	<%
			 		for (HashMap rs : listAW) {
			 	%>
			 	<tr>
			 		<td><%=util.getStr(rs.get("AW_SERIAL_NUM"))%></td>
			 		<td><%=util.getStr(rs.get("AW_BADGE"))%></td>
			 		<td><%=util.getStr(rs.get("AW_START"))%></td>
			 		<td><%=util.getStr(rs.get("AW_PRESENT"))%></td>
			 		<td class="r_line_none"><%=util.getStr(rs.get("AW_CONTENT"))%></td>
				</tr>
				<%} %>
			<%} else{%>
				<tr>
					<td style="text-align:center;"colspan="5" class="r_line_none">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<!-- 수상 실적 E -->
		<h2 class="h4_tit">자격사항</h2>
		<table class="skin_list textCenter">
			<caption>자격사항</caption>
			<colgroup>
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:23%" />
				<col style="width:23%" />
			 	<col style="width:34%" />
			</colgroup>
			<tr>
				<th scope="col" >연번</th>
				<th scope="col" >취득일</th>
				<th scope="col" >발급기관명</th>
				<th scope="col" >자격구분</th>
				<th scope="col" class="r_line_none" >자격명</th>
			</tr>

		<%if(listQU.size()>0){ %>
				 <%
				 	for (HashMap rs : listQU) {
				 %>
			<tr>
				<td><%=util.getStr(rs.get("QU_SERIAL_NUM"))%></td>
							<td><%=util.getStr(rs.get("QU_START"))%></td>
							<td><%=util.getStr(rs.get("QU_ORG_NM"))%></td>
							<td><%=util.getStr(rs.get("QU_DIVIDE"))%></td>
							<td class="r_line_none"><%=util.getStr(rs.get("QU_NM"))%></td>
						</tr>
					<%} %>
			 <%} else{%>
				<tr>
					<td style="text-align:center;" colspan="5" class="r_line_none">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<div class="b_btn_area">
			<%if(util.loginCheck()){
				if(util.getStr(loginVO.getUserIdx()).equals(userIdx) || util.getInt(loginVO.getAuthLv()) <= 99){%>
					<button class="btn_rgt" onclick="goSubmit('del')">삭제</button>
					<button class="btn_rgt" onclick="goSubmit('edit')">수정</button>
			<%	}
			} %>
					<button class="btn_lft2" onclick="goSubmit('list')">목록</button>
		</div>
	</div>
</form>


<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		if(mode == "edit" || mode == "del"){
			$('#searchForm').attr('method','get');
		}
		$('#fview').submit();
	}


	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});

	function winResize(){
		var win_w = $(window).width();

		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
			$("#profile1").show();
			$("#profile2,#profile3").hide();

			if($('#profileTable colgroup col').size()<5){
				$('#profileTable').find('col:eq(0)').after("<col style='width: 15%'>");
			}

		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$("#profile1").hide();
			$("#profile2,#profile3").show();

			if($('#profileTable colgroup col').size()>=5){
				$('#profileTable').find('col:eq(1)').remove();
			}

		}else{ //기본사이즈

		}

	}




</script>