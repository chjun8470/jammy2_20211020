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
	
	ArrayList<HashMap<String, String>> listSC = request.getAttribute("listSC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listSC");
	ArrayList<HashMap<String, String>> listRP = request.getAttribute("listRP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRP");
	ArrayList<HashMap<String, String>> listIP = request.getAttribute("listIP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listIP");
	ArrayList<HashMap<String, String>> listAC = request.getAttribute("listAC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAC");
	
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	
	ArrayList<HashMap<String, String>> bizList = request.getAttribute("bizList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("bizList");
	ArrayList<HashMap<String, String>> scibList = request.getAttribute("scibList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scibList");
		
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
					<caption>기본정보</caption>
                    <colgroup>
	                    <col style="width:15%" />
	                    <col style="width:35%" />
	                    <col style="width:15%" />
	                    <col style="width:35%" />
                    </colgroup>
					<tr>
						<th>이름</th>
						<td><%=util.getStr(dataInfo.get("PSN_NM"))%></td>
						<th>성별</th>
						<td><%=util.getStr(dataInfo.get("GENDER_TYPE_CD"))%></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3"><%=util.getStr(dataInfo.get("EMAIL")) %></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td colspan="3"><%=util.getStr(dataInfo.get("TEL_NO")) %><%//=util.getStr(dataInfo.get("CP_NO")) %></td>
					</tr>
					<tr>
						<th>전문가 구분</th>
						<td colspan="3">
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
					<!-- tr class="center">
						<th>산업기술분류(대)</th>
						<th>산업기술분류(중)</th>
						<th>산업기술분류(소)</th>
					</tr>
					<tr class="center">
						<td><%=util.getStr(dataInfo.get("PRO_SMB_CODE1"))%></td>
						<td><%=util.getStr(dataInfo.get("PRO_SMB_CODE2"))%></td>
						<td><%=util.getStr(dataInfo.get("PRO_SMB_CODE3"))%></td>
					</tr-->
				</table>
			</div>

			<h4 class="mo_tit">소속정보</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:15%;">
						<col style="width:35%;">
						<col style="width:15%;">
						<col style="width:35% ">
					</colgroup>
					<tr>
						<th>소속기관명</th>
						<td><%=util.getStr(dataInfo.get("COM_NM")) %></td>
						<th>소속기관유형</th>
						<td><%=util.getStr(dataInfo.get("PRO_SMB_TEAM1")) %></td>
					</tr>
					<tr>
						<th>부서</th>
						<td><%=util.getStr(dataInfo.get("DEPT_NM")) %></td>
						<th>직위</th>
						<td><%=util.getStr(dataInfo.get("POSITION_NM")) %></td>
					</tr>
					<tr>
						<th>회사주소</th>
						<td colspan="3"><%=util.getStr(dataInfo.get("COM_ADDR1")) %> <%=util.getStr(dataInfo.get("COM_ADDR2")) %></td>
					</tr>
				</table>
			</div>
			
			
			<h4 class="mo_tit">최종학위</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:15%;">
						<col style="width:35%;">
						<col style="width:15%;">
						<col style="width:35% ">
					</colgroup>
					<% for(HashMap sc:listSC){ %>
					<tr>
						<th>학교명</th>
						<td><%=util.getStr(sc.get("SC_NM")) %></td>
					</tr>
					<tr>
						<th>전공</th>
						<td><%=util.getStr(sc.get("SC_CONAME")) %></td>
					</tr>
					<tr>
						<th>취득학위</th>
						<td><%=util.getStr(sc.get("SC_DEGNAME")) %></td>
						<th>회사주소</th>
						<td><%=util.getStr(sc.get("SC_DATE")) %></td>
					</tr>
					<% } %>
				</table>
			</div>
			
			
			<h4 class="mo_tit">연구논문실적</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:15%;">
						<col style="width:35%;">
						<col style="width:15%;">
						<col style="width:35% ">
					</colgroup>
					<% for(HashMap rs:listRP){ %>
					<tr>
						<th>논문명</th>
						<td><%=util.getStr(rs.get("RP_NM")) %></td>
					</tr>
					<tr style="border-bottom:3px solid #ddd;">
						<th>게제년도</th>
						<td><%=util.getStr(rs.get("RP_START")) %></td>
						<th>SCI 논문여부구분</th>
						<td><%=util.getStr(rs.get("RP_TYPE")) %></td>
					</tr>
					<% } %>
				</table>
			</div>
			
			
			<h4 class="mo_tit">지식재산실적</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:15%;">
						<col>
						<col style="width:15%;">
						<col>
						<col style="width:15%;">
						<col>
					</colgroup>
					<% for(HashMap rs:listIP){ %>
					<tr>
						<th>지식재산명</th>
						<td colspan="5"><%=util.getStr(rs.get("IP_NM")) %></td>
					</tr>
					<tr style="border-bottom:3px solid #ddd;">
						<th>지식재산유형</th>
						<td><%=util.getStr(rs.get("IP_TYPE")) %></td>
						<th>출원등록구분</th>
						<td><%=util.getStr(rs.get("IP_STATE")) %></td>
						<th>출원등록일자</th>
						<td><%=util.getStr(rs.get("IP_START")) %></td>
					</tr>
					<% } %>
				</table>
			</div>
			
			
			<h4 class="mo_tit">대외활동</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:15%;">
						<col>
						<col style="width:15%;">
						<col>
						<col style="width:15%;">
						<col>
					</colgroup>
					<% 
					if(listRD.size() > 0){
					for(HashMap rs:listAC){ %>
					<tr>
						<th>조직(학회)명</th>
						<td colspan="3"><%=util.getStr(rs.get("AC_NM")) %></td>
					</tr>
					<tr style="border-bottom:3px solid #ddd;">
						<th>참여일</th>
						<td><%=util.getStr(rs.get("AC_START")) %></td>
						<th>직위</th>
						<td><%=util.getStr(rs.get("AC_DEPT")) %></td>
					</tr>
					<tr>
						<th>주요업무</th>
						<td colspan="3"><%=util.getStr(rs.get("AC_WORK")) %></td>
					</tr>
					<% }
					}else{%>
					<tr>
						<td colspan="4" style="text-align:center;">입력된 정보가 없습니다.</td>
					</tr>
					<% } %>
				</table>
			</div>
			

			<h4 class="mo_tit">연구개발과제(프로젝트) 수행실적</h4>
			<div class="scroll">
				<table class="tbl04">
					<colgroup>
						<col style="width:15%;">
						<col>
						<col style="width:15%;">
						<col>
						<col style="width:15%;">
						<col>
					</colgroup>
					<%
					if(listRD.size() > 0){
					for(HashMap rd:listRD){
					%>
					<tr>
						<th>사업명</th>
						<td colspan="3"><%=util.getStr(rd.get("RD_BUSINESS_NM"))%></td>
					</tr>
					<tr>
						<th>과제명</th>
						<td><%=util.getStr(rd.get("RD_NM"))%></td>
					</tr>
					<tr>
						<th>시업시작기간</th>
						<td><%=util.getStr(rd.get("RD_START"))%></td>
						<th>사업종료기간</th>
						<td><%=util.getStr(rd.get("RD_FINISH"))%></td>
						<th>참여형태</th>
						<td><%=util.getStr(rd.get("RD_FORM"))%></td>
					</tr>
					<%
					}
					}else{
					%>
					<tr>
						<td colspan="6" style="text-align:center;">입력된 정보가 없습니다.</td>
					</tr>
					<% } %>
				</table>
			</div>
			
			<h4 class="mo_tit">기술분야</h4>
			<div class="scroll">
				
				<h6>산업기술분류</h6>
				<table class="tbl04">
					<colgroup>
						<col style="width:25%;">
						<col>
					</colgroup>
					<%
					int k = 1;
					for(HashMap rs:bizList){
					%>
					<tr>
						<th><%=k %>순위</th>
						<td colspan="3"><%=util.getStr(rs.get("PCODE1"))%> > <%=util.getStr(rs.get("PCODE2"))%> > <%=util.getStr(rs.get("PCODE3"))%></td>
					</tr>
					<% k++; } %>
				</table>
			
			
			
				<h6>과학기술분류</h6>
				<table class="tbl04">
					<colgroup>
						<col style="width:25%;">
						<col>
					</colgroup>
					<%
					int i = 1;
					for(HashMap rs:scibList){
					%>
					<tr>
						<th><%=i %>순위</th>
						<td colspan="3"><%=util.getStr(rs.get("SCCODE1"))%> > <%=util.getStr(rs.get("SCCODE2"))%></td>
					</tr>
					<% i++; } %>
				</table>
			</div>
			
			
			<h4 class="mo_tit">전문가분야</h4>
			<div class="scroll">
				
				<table class="tbl04">
					<colgroup>
						<col style="width:25%;">
						<col>
					</colgroup>
					<tr>
						<th>기술사업화 코디네이터</th>
						<td>
							<input type="checkbox" name="expert_pro1" id="expert_pro1" disabled value="Y" <%=(util.getStr(dataInfo.get("EXPERT_PRO1")).equals("Y"))?"checked":""%>> 
							<label for="expert_pro1">
							<span>* 해당 기술분야 시장성, 사업성평가 전문가(벤처캐피탈, 창업투자 등 관련분야 소속)</span>
							</label>
						</td>
					</tr>
					<tr>
						<th>해외전문가</th>
						<td>
							<input type="checkbox" name="expert_pro2" id="expert_pro2" disabled value="Y" <%=(util.getStr(dataInfo.get("EXPERT_PRO2")).equals("Y"))?"checked":""%>> 
							<label for="expert_pro2">
							<span>* 외국인, 재외한인공학인, 해외기관 근무 경력자, 해외학위 취득자 등</span>
							</label>
						</td>
					</tr>
					<tr>
						<th>IP전문가</th>
						<td>
							<input type="checkbox" name="expert_pro3" id="expert_pro3" disabled value="Y" <%=(util.getStr(dataInfo.get("EXPERT_PRO3")).equals("Y"))?"checked":""%>> 
							<label for="expert_pro3">
							<span>* 변리사, 특허분야 전문가</span>
							</label>
						</td>
					</tr>
					<tr>
						<th>표준인증전문가</th>
						<td colspan="3">
							<input type="checkbox" name="expert_pro4" id="expert_pro4" disabled value="Y" <%=(util.getStr(dataInfo.get("EXPERT_PRO4")).equals("Y"))?"checked":""%>> 
							<label for="expert_pro4">
							<span>* KS, IOS, IEC 등 국내, 국제표준화 업무 전문가(의장, 간사, PROJECT LEADER 등의 수입경력포함)<br/>
							* 표준특허전문가, 표준물질생산, 적합성평가 등 제품인증 분야 전문가, 기타 표준분야 전문가
							</span>
							</label>
						</td>
					</tr>
					<tr>
						<th>안전전문가 신청</th>
						<td>
							<input type="checkbox" name="expert_pro5" id="expert_pro5" disabled value="Y" <%=(util.getStr(dataInfo.get("EXPERT_PRO5")).equals("Y"))?"checked":""%>> 
							<label for="expert_pro5">
							<span>* 전기, 기계, 화학, 가스 등 산업 안전분야 기사, 기술사 자격 소지자<br/>
							* 산업안전분야 관련 기업, 협회, 안전관리전문기관 등에 소속된 자<br/>
							* 소속기관에서 안전분야 관련 업무를 수행하거나 관련 지식을 보유한 자 등
							</span>
							</label>
						</td>
					</tr>					
				</table>
			</div>

			
		</div>
	</div>
