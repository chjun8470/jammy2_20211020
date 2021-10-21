<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>

<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> dataInfo = request.getAttribute("dataInfo") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataInfo");
	
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
		
	//StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	//LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	//out.println(dataInfo);
%>

    
    
    
 
	<div class="expert_modal">
		<header>
			<h3>전문가 정보 상세보기<span class="close_modal"><img src="/img/smbrnd/cont/close_black.svg"></span></h3>
		</header>
		<div class="expert_modal01">
			<h4 class="mo_tit first">전문가 정보</h4>
			<div class="scroll">
				<table class="tbl04">
					<tr>
						<th>이름</th>
						<td><%=util.getStr(dataInfo.get("PSN_NM"))%></td>
					</tr>
					<tr>
						<th>지역</th>
						<td colspan="2"><%=util.getStr(dataInfo.get("PRO_USER_BIRTHPLACE")) %></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="2"><%=util.getStr(dataInfo.get("EMAIL")) %></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td colspan="2"><%=util.getStr(dataInfo.get("TEL_NO")) %><%//=util.getStr(dataInfo.get("CP_NO")) %></td>
					</tr>
					<tr>
						<th>전문가 구분</th>
						<td colspan="2">
							<ul class="keyword02">
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_PLANNING")).equals("Y")){%><li>정책기획</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_RND")).equals("Y")){%><li>연구개발</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_COMPANY")).equals("Y")){%><li>기업지원</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JEINET")).equals("Y")){%><li>연구장비</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JIPBANK")).equals("Y")){%><li>지식재산</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_EDUCATION")).equals("Y")){%><li>인력양성</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_CONSULTING")).equals("Y")){%><li>컨설팅</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_MARKETING")).equals("Y")){%><li>마케팅</li><% } %>
								<%if(util.getStr(dataInfo.get("PRO_JNTIS_ETC")).equals("Y")){%><li>기타</li><% } %>
							</ul>
						</td>
					</tr>
					<tr class="center">
						<th>산업기술분류(대)</th>
						<th>산업기술분류(중)</th>
						<th>산업기술분류(소)</th>
					</tr>
					<tr class="center">
						<td><%=util.getStr(dataInfo.get("PRO_SMB_CODE1"))%></td>
						<td><%=util.getStr(dataInfo.get("PRO_SMB_CODE2"))%></td>
						<td><%=util.getStr(dataInfo.get("PRO_SMB_CODE3"))%></td>
					</tr>
				</table>
			</div>

			<h4 class="mo_tit">소속정보</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:20%;">
						<col style="width:25%;">
						<col style="width:20%;">
						<col style="width:25% ">
					</colgroup>
					<tr>
						<th>관심분야</th>
						<td colspan="3"><%=util.getStr(dataInfo.get("PRO_USER_INTEREST_WORLD")) %></td>
					</tr>
					<tr>
						<th>기관명</th>
						<td><%=util.getStr(dataInfo.get("ORG_GRP_NM")) %></td>
						<th>기관유형</th>
						<td><%=util.getStr(dataInfo.get("ORG_TYPE")) %></td>
					</tr>
					<tr>
						<th>취득학위</th>
						<td><%=util.getStr(dataInfo.get("SC_DEGREE")) %></td>
						<th>세부전공</th>
						<td><%=util.getStr(dataInfo.get("EX_DETAIL")) %></td>
					</tr>
				</table>
			</div>

			<h4 class="mo_tit">연구개발과제(프로젝트) 수행실적</h4>
			<div class="scroll">
				<table class="tbl04">
					<tr class="center">
						<th>사업명</th>
						<th>과제명</th>
						<th>총사업참여기간</th>
						<th>참여형태</th>
					</tr>
					<%
					if(listRD.size() > 0){
					for(HashMap rd:listRD){
					%>
					<tr>
						<td><%=util.getStr(rd.get("RD_BUSINESS_NM"))%></td>
						<td><%=util.getStr(rd.get("RD_NM"))%></td>
						<td><%=util.getStr(rd.get("RD_START"))%>~<%=util.getStr(rd.get("RD_FINISH"))%></td>
						<td><%=util.getStr(rd.get("RD_FORM"))%></td>
					</tr>
					<%
					}
					}else{
					%>
					<tr>
						<td colspan="4" style="text-align:center;">입력된 정보가 없습니다.</td>
					</tr>
					<% } %>
				</table>
			</div>

			<h4 class="mo_tit">수상실적 및 자격사항</h4>
			<h5>수상실적</h5>
			<div class="scroll">
				<table class="tbl04">
					<tr class="center">
						<th>연번</th>
						<th>훈격</th>
						<th>수여일자</th>
						<th>수여기관</th>
						<th>공적내용</th>
					</tr> 
					<%
					if(listAW.size() > 0){
					for(HashMap rd:listAW){
					%>
					<tr>
						<td><%=util.getStr(rd.get("AW_SERIAL_NUM"))%></td>
						<td><%=util.getStr(rd.get("AW_BADGE"))%></td>
						<td><%=util.getStr(rd.get("AW_START"))%></td>
						<td><%=util.getStr(rd.get("AW_PRESENT"))%></td>
						<td><%=util.getStr(rd.get("AW_CONTENT"))%></td>
					</tr>
					<%
					}
					}else{
					%>
					<tr>
						<td colspan="5" style="text-align:center;">입력된 정보가 없습니다.</td>
					</tr>
					<% } %>
				</table>
			</div>

			<h5 style="margin-top:15px;">자격사항</h5>
			<div class="scroll">
				<table class="tbl04">
					<tr class="center">
						<th>연번</th>
						<th>취득일</th>
						<th>발급기관명</th>
						<th>자격구분</th>
						<th>자격명</th>
					</tr>
					<%
					if(listQU.size() > 0){
					for(HashMap rd:listQU){
					%>
					<tr>
						<td><%=util.getStr(rd.get("QU_SERIAL_NUM"))%></td>
						<td><%=util.getStr(rd.get("QU_START"))%></td>
						<td><%=util.getStr(rd.get("QU_ORG_NM"))%></td>
						<td><%=util.getStr(rd.get("QU_DIVIDE"))%></td>
						<td><%=util.getStr(rd.get("QU_NM"))%></td>
					</tr>
					<%
					}
					}else{
					%>
					<tr>
						<td colspan="5" style="text-align:center;">입력된 정보가 없습니다.</td>
					</tr>
					<% } %>
				</table>
			</div>
		</div>
	</div>
