<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page
	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
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
%>

<form id="fview" name="fview" method="post"
	action="/sys/sys_org_manage.do">
	<input type="hidden" id="mode" name="mode" value="<%=mode%>" />
	<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>"/>


	<div class="clear_wrap">
		<div class="left_box w75">

					<!-- 기본정보영역 -->
					<h3>기관명 기본정보</h3>
					<table class="skin_basic_write">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
						<tr>
						<th scope="col"><label for="CI이미지">CI이미지</label></th>
							<td colspan="3">
								<img class='ci_img' src="<%=(util.getStr(dataMap.get("CI_FILE_SRC")).equals("") ? "/img/noimg.png" : util.getStr(dataMap.get("CI_FILE_SRC")))%>" alt='CI이미지' style='width:210px;height:38px'/>
							</td>
						</tr>
							<tr>
								<th scope="col"><label for="emialId">기관구분</label></th>
								<td colspan="3"><c:choose>
										<c:when test="${dataMap.ORG_TYPE eq '1'}">기업</c:when>
										<c:when test="${dataMap.ORG_TYPE eq '2'}">기관/센터</c:when>
										<c:otherwise>알수없음</c:otherwise>
									</c:choose></td>

							</tr>
							<tr>
								<th scope="col"><label for="emialId">기관명</label></th>
								<td colspan="3"><%=util.getStr(dataMap.get("ORG_GRP_NM"))%></td>
							</tr>
							<tr>
								<th scope="col"><label for="emialId">소속지역</label></th>
								<td colspan="3"><label><input type="checkbox"
										disabled="disabled"
										<%=util.getStr(dataMap.get("AREA_CD")).equals("1")?"checked='checked'":""%> />전라남도
										기관</label> <label><input type="checkbox" disabled="disabled"
										<%=!util.getStr(dataMap.get("AREA_CD")).equals("1")?"checked='checked'":""%> />지역
										외 기관</label></td>
							</tr>
							<tr>
								<th scope="col"><label for="emialId">대표자명</label></th>
								<td colspan="3"><%=util.getStr(dataMap.get("ORNER_NM"))%></td>
							</tr>
							<tr>
								<th scope="col"><label for="emialId">사업자등록번호</label></th>
								<td colspan="3"><%=util.getStr(dataMap.get("CORP_NUM_1"))%></td>
							</tr>
							<tr>
								<th scope="col"><label for="emialId">법인등록번호</label></th>
								<td colspan="3"><%=util.getStr(dataMap.get("CORP_NUM_2"))%></td>
							</tr>
						</tbody>
						<tr>
							<th scope="col"><label for="emialId">대표전화번호</label></th>
							<td><%=util.getStr(dataMap.get("CORP_PHONE"))%></td>
							<th scope="col"><label for="emialId">대표FAX번호</label></th>
							<td><%=util.getStr(dataMap.get("CORP_FAX"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">홈페이지</label></th>
							<td colspan="3"><%=util.getStr(dataMap.get("HOMEPAGE"))%></td>
						</tr>

					</table>

			<div class="box_in">
				<!-- 상세정보영역 -->
				<h3>기관명 상세정보</h3>
				<table class="skin_basic_write" summary="회원정보를 나타내는 표 입니다">
					<caption>회원상세정보</caption>
					<colgroup>
						<col width="25%">
						<col width="75%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col"><label for="blngOrgAddr">기관주소</label></th>
							<td><%=util.getStr(dataMap.get("ZIPCODE"))%> <%=util.getStr(dataMap.get("ADDR1"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="blngOrgAddrDtl">기관상세주소</label></th>
							<td><%=util.getStr(dataMap.get("ADDR2"))%></td>
						</tr>
						<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")){%>
						<tr>
							<th scope="col"><label for="deptNm">기관관리자</label></th>
							<td>
								<%
									if (!util.getStr(dataMap.get("PSN_NM")).equals("")){
														out.println(util.getStr(dataMap.get("PSN_NM"))+"("+util.getStr(dataMap.get("USER_ID")) +")");
													}else{
														out.println("정보 없음");
													}
								%>
							
						</tr>
						<%} %>
						<tr>
							<th scope="col"><label for="deptAddr">지도</label></th>
							<td>
								<% if(!util.getStr(dataMap.get("MAP_X")).equals("")&&!util.getStr(dataMap.get("MAP_Y")).equals("")){%>
								<%-- X : <%=util.getStr(dataMap.get("MAP_X"))%>, Y : <%=util.getStr(dataMap.get("MAP_Y"))%> --%>
								<div id="map" style="width: 100%; height: 300px; margin-top: 10px;"></div> 
								<%}else{out.println("정보 없음");}%>
							</td>
						</tr>
						<%-- <tr>
							<th scope="col"><label for="psnNm">X,Y좌표</label></th>
							<td>X : <%=util.getStr(dataMap.get("MAP_X"))%>, Y : <%=util.getStr(dataMap.get("MAP_Y"))%></td>
						</tr> --%>
						<tr>
							<th scope="col"><label for="birthDate">기관분류</label></th>
							<td><%=util.getStr(dataMap.get("ORG_NOTE_1"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="userId">주요제품</label></th>
							<td><%=util.getStr(dataMap.get("ORG_NOTE_2"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="jobDivCd">보유기술현황</label></th>
							<td><%=util.getStr(dataMap.get("ORG_NOTE_3"))%></td>

						</tr>
						<tr>
							<th scope="col"><label for="position">연구분야</label></th>
							<td><%=util.getStr(dataMap.get("ORG_NOTE_4"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="frgnYn">기업소개자료</label></th>
							<td><%=util.getStr(dataMap.get("ORG_FILE_INFO_TITLE_ORG"))%></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn_box">
				<div class="btn_right_box">
					<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
					<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
				</div>
			</div>
		</div>
</form>
<script type="text/javascript">
	function pageListGo() {
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageEditGo() {
		$('#mode').val('edit');
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