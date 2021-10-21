<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ include file="/front/_item/basic/i_header.jsp" %>
<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));

	int areaCd = Integer.parseInt(util.getStr(dataMap.get("AREA_CD")));
%>
<form id="fview" name="fview" method="get" action="/<%=request.getAttribute("SITE_ID") %>/sub.do">
	<input type="hidden" id="mode" name="mode" value="<%=mode%>" />
	<input type="hidden" id="m" name="m" value="<%=util.getStr(paramMap.get("m"))%>" />
	<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>"/>
</form>

	<div class="b_ContBox">
		<%--
		 <div class="imgBox">
			<img class='ci_img' src="<%=(util.getStr(dataMap.get("CI_FILE_SRC")).equals("") ? "/img/noimg.png" : util.getStr(dataMap.get("CI_FILE_SRC")))%>" alt='CI이미지' />
		</div>
		--%>

		<div class="basic_viewWrap">

			<div class="h4_tit"><%=util.getStr(dataMap.get("ORG_TYPE")).equals("2")?"기관":"기업" %> 기본정보</div>
				<table class="skin_view2" summary="기관분류, 기관명, 소속지역, 대표자명, 사업자등록번호, 법인등록번호, 대표전화번호, 홈페이지로 구성된 표입니다.">
	  			<caption>기업/기관 정보</caption>
					<colgroup>
					  <col style="width:15%;" />
					  <col style="width:35%;" />
					  <col style="width:15%;" />
					  <col style="width:35%;" />
					</colgroup>

				<tbody>
					<tr>
						<th scope="col">기업/기관 분류</th>
						<td>
							<span class="notice_blue">
							<c:choose>
								<c:when test="${dataMap.ORG_TYPE eq '1'}">기업</c:when>
								<c:when test="${dataMap.ORG_TYPE eq '2'}">기관/센터</c:when>
								<c:otherwise>알수없음</c:otherwise>
							</c:choose>
							</span>
						</td>
						<td class="table_box_line_lft" rowspan="2" colspan="2" style="text-align:center">
							<img class='ci_img' style="width:150px;height:50px" src="<%=(util.getStr(dataMap.get("CI_FILE_SRC")).equals("") ? "/img/noimg.png" : util.getStr(dataMap.get("CI_FILE_SRC")))%>" alt='CI이미지'  />
						</td>
					</tr>
					<tr>
						<th>
							<c:choose>
								<c:when test="${dataMap.ORG_TYPE eq '1'}">기업구분</c:when>
								<c:when test="${dataMap.ORG_TYPE eq '2'}">기관구분</c:when>
								<c:otherwise>알수없음</c:otherwise>
							</c:choose>
						</th>
						<td><%=util.getStr(dataMap.get("COMPANY_NAME"))%></td>
					</tr>
					<tr>
						<th>
							<c:choose>
								<c:when test="${dataMap.ORG_TYPE eq '1'}">기업명</c:when>
								<c:when test="${dataMap.ORG_TYPE eq '2'}">기관명</c:when>
								<c:otherwise>알수없음</c:otherwise>
							</c:choose>
						</th>
						<td colspan="3"><%=util.getStr(dataMap.get("ORG_GRP_NM"))%></td>
					</tr>
					<tr>
						<th scope="col">소속지역</th>
						<td colspan="3">
							<input type="checkbox" disabled="disabled" <%=util.getStr(dataMap.get("AREA_CD")).equals("1")?"checked='checked'":""%> /> 전라남도 기관
							<input type="checkbox" disabled="disabled" <%=!util.getStr(dataMap.get("AREA_CD")).equals("1")?"checked='checked'":""%> /> 지역외 기관
						</td>
					</tr>
					<tr>
						<th scope="col">소재지</th>
						<%if(areaCd == 1) { %>
						<td colspan="3"><%=util.getStr(dataMap.get("AREA_NAME")) %></td>
						<% } else { %>
						<td colspan="3"><%=util.getStr(dataMap.get("OTHER_AREA")) %></td>
						<% } %>
					</tr>
					<tr>
						<th scope="col">대표자명</th>
						<td><%=util.getStr(dataMap.get("ORNER_NM"))%></td>
						<th class="table_box_line_lft" scope="col">사업자등록번호</th>
						<td>
							<% if(!util.getStr(dataMap.get("CORP_NUM_1")).equals("")){ %>
								<%=util.getStr(dataMap.get("CORP_NUM_1")).substring(0,3)%> -
								<%=util.getStr(dataMap.get("CORP_NUM_1")).substring(3,5)%> -
								<%=util.getStr(dataMap.get("CORP_NUM_1")).substring(5)%>
							<% } %>
						</td>
					</tr>
					<%--
						  <tr style="display:none;">
							<th scope="col">법인등록번호</th>
							<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("CORP_NUM_2"))%></td>
						  </tr>
					--%>
					<tr>
						<th scope="col">대표전화번호</th>
						<td><%=util.getStr(dataMap.get("CORP_PHONE"))%></td>
						<th class="table_box_line_lft" scope="col">FAX번호</th>
						<td><%=util.getStr(dataMap.get("CORP_FAX"))%></td>
					</tr>
					<tr>
						<th scope="col">홈페이지</th>
						<td colspan="3"><a href="http://www.jntp.or.kr"><%=util.getStr(dataMap.get("HOMEPAGE"))%></a></td>
					</tr>
					<% if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %>
					<tr>
						<th scope="col">기관관리자</th>
						<td colspan="3">
						<%
							if (!util.getStr(dataMap.get("PSN_NM")).equals("")){
								out.println(util.getStr(dataMap.get("PSN_NM"))+"("+util.getStr(dataMap.get("USER_ID")) +")");
							}else{
								out.println("정보 없음");
							}
						%>
						</td>
					</tr>
					<% } %>

					<tr>
						<th scope="col">주소</th>
						<td colspan="3"><%=util.getStr(dataMap.get("ZIPCODE"))%> <%=util.getStr(dataMap.get("ADDR1"))%></td>
					</tr>
					<tr>
						<th scope="col">상세주소</th>
						<td colspan="3"><%=util.getStr(dataMap.get("ADDR2"))%></td>
					</tr>

					<tr>
						<th scope="col">지도</th>
						<td colspan="3">
						<% if(!util.getStr(dataMap.get("MAP_X")).equals("")&&!util.getStr(dataMap.get("MAP_Y")).equals("")){%>
													<div id="map" style="width: 98%; height: 300px; margin-top: 10px;"></div>
													<%}else{out.println("정보 없음");}%>
						</td>
				    </tr>
					<tr>
						<th scope="col">소개</th>
						<td colspan="3"><%=util.getStr(dataMap.get("ORG_NOTE_1"))%></td>
					</tr>
					<tr>
						<th scope="col"><%=util.getStr(dataMap.get("ORG_TYPE")).equals("2")?"기관":"기업" %>소개자료</th>
						<td colspan="3">
							<%if(!util.getIntStr(dataMap.get("ORG_FILE_ID")).equals("")){%>
							<a href="/cmm/fms/ComFileDown.do?dataGrp=orgManage&amp;fileId=<%=util.getIntStr(dataMap.get("ORG_FILE_ID"))%>&amp;dataIdx=<%=util.getStr(paramMap.get("orgGrpCd"))%>">
								<%=util.getStr(dataMap.get("ORG_FILE_INFO_TITLE_ORG"))%>
							</a>
							<%} %>
						</td>
					</tr>
				</tbody>
				</table>
		</div>
		<!--basic_listWrap E-->

	</div>
	<!--b_ContBox E-->


	<div class="b_btn_area">
		<button class="btn_rgt" type="button" onclick="pageListGo()">목록</button>
	</div>

<script type="text/javascript">
	function pageListGo() {
		$('#mode').val('list');
		$('#fview').submit();
	}
</script>

<%
	if(!util.getStr(dataMap.get("MAP_X")).equals("")&&!util.getStr(dataMap.get("MAP_Y")).equals("")){
%>
<script type="text/javascript">
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center : new daum.maps.LatLng(
<%=util.getStr(dataMap.get("MAP_X"))%>
	,
<%=util.getStr(dataMap.get("MAP_Y"))%>
	), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨
	};

	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
		position : new daum.maps.LatLng(
<%=util.getStr(dataMap.get("MAP_X"))%>
	,
<%=util.getStr(dataMap.get("MAP_Y"))%>
	),
		map : map
	});
</script>
<%
	}
%>