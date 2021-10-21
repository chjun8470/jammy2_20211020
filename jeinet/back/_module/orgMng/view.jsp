<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
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

<form id="fview" name="fview" method="post"	action="/sys/sys_org_manage.do">
	<input type="hidden" id="mode" name="mode" value="<%=mode%>" />
	<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>"/>

	<div class="clear_wrap">
		<div class="left_box w75">

		<!-- 기본정보영역 -->
		<h3>기업/기관 기본정보</h3>
			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 30%;" />
					<col style="width: 20%;" />
					<col style="width: 30%;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="col"><label for="CI이미지">CI이미지</label></th>
							<td colspan="3">
								<img class='ci_img' src="<%=(util.getStr(dataMap.get("CI_FILE_SRC")).equals("") ? "/img/no-image.gif" : util.getStr(dataMap.get("CI_FILE_SRC")))%>" alt='CI이미지' style='width:150px;height:50px'/>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">기업/기관구분</label></th>
							<td colspan="3"><c:choose>
								<c:when test="${dataMap.ORG_TYPE eq '1'}">기업</c:when>
								<c:when test="${dataMap.ORG_TYPE eq '2'}">기관/센터</c:when>
								<c:otherwise>알수없음</c:otherwise>
								</c:choose></td>
						</tr>
						<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %>
						<tr>
							<th scope="col">기업구분</th>
							<td colspan="3"><%=util.getStr(dataMap.get("COMPANY_NAME")) %></td>
						</tr>
						<% } %>
						<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %>
						<tr>
							<th scope="col">기관구분</th>
							<td colspan="3"><%=util.getStr(dataMap.get("AGENCY_NAME")) %></td>
						</tr>
						<% } %>
						<tr>
							<th scope="col"><%=util.getStr(dataMap.get("ORG_TYPE")).equals("1")?"기업명":"기관명(국문)"%></th>
							<td <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %> colspan="3" <% } else { %> scope="col" <% } %>><%=util.getStr(dataMap.get("ORG_GRP_NM"))%></td>
							<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %>
							<th scope="col">기관명(영문)</th>
								<td scope="col"><%=util.getStr(dataMap.get("ORG_ENG_NM")) %></td>
							<% } %>
						</tr>
						<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %>
						<tr>
							<th scope="col"><label for="authCd1">관리권한</label></th>
							<td colspan="3">
								<%=util.getStr(dataMap.get("AUTH_CD")).equals("1")? "일반": "관리자"%>
							</td>
						</tr>
						<%}%>
						<%if((util.getStr(dataMap.get("ORG_TYPE")).equals("2")) && (util.getStr(dataMap.get("AUTH_CD")).equals("2"))) { %>
						<tr>
							<th scope="col">관리기관</th>
							<td colspan="3">
								연구장비정보망 :
								<%=util.getStr(dataMap.get("AUTH_ORG_SITE_1")).equals("Y")?"Y":"N"%><br/>
								지식재산센터 :
								<%=util.getStr(dataMap.get("AUTH_ORG_SITE_2")).equals("Y")?"Y":"N"%><br/>
								과학기술진흥센터 :
								<%=util.getStr(dataMap.get("AUTH_ORG_SITE_3")).equals("Y")?"Y":"N"%>
							</td>
						</tr>
						<%}%>
						<tr>
							<th scope="col">신청상태</th>
							<td colspan="3"><%=util.getStr(dataMap.get("APPLY_CD")).equals("10")?"신청":""%>
								 <%=util.getStr(dataMap.get("APPLY_CD")).equals("20")?"승인":""%>
								 <%=util.getStr(dataMap.get("APPLY_CD")).equals("30")?"반려":""%>
							</td>
						</tr>
						<tr <%=!util.getStr(dataMap.get("APPLY_CD")).equals("30")?"style='display:none'":""%>>
							<th scope="col">반려내용</th>
							<td colspan="3"><%=util.getStr(dataMap.get("APPLY_REJECT"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">소속지역</label></th>
							<td colspan="3">
								<label>
									<input type="checkbox" disabled="disabled" <%=util.getStr(dataMap.get("AREA_CD")).equals("1")?"checked='checked'":""%>/>
									&nbsp;전라남도 기관
								</label>
								<label>
									<input type="checkbox" disabled="disabled" <%=!util.getStr(dataMap.get("AREA_CD")).equals("1")?"checked='checked'":""%>/>
									&nbsp;지역 외 기관
								</label>
							</td>
						</tr>
						<tr>
							<th scope="col">소재지</th>
							<%if(areaCd == 1){%>
							<td colspan="3"><%=util.getStr(dataMap.get("AREA_NAME")) %></td>
							<%}else{%>
							<td colspan="3"><%=util.getStr(dataMap.get("OTHER_AREA")) %></td>
							<%}%>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">대표자명</label></th>
							<td colspan="3"><%=util.getStr(dataMap.get("ORNER_NM"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">사업자등록번호</label></th>
							<td <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %> colspan="3" <% } else { %> scope="col" <% } %> >
								<% if(!util.getStr(dataMap.get("CORP_NUM_1")).equals("")){ %>
									<%=util.getStr(dataMap.get("CORP_NUM_1")).substring(0,3)%> -
									<%=util.getStr(dataMap.get("CORP_NUM_1")).substring(3,5)%> -
									<%=util.getStr(dataMap.get("CORP_NUM_1")).substring(5)%>
								<% } %>
							</td>
							<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")){%>
							<th scope="col">업종</th>
							<td scope="col"><%=util.getStr(dataMap.get("WORK_TYPE")) %></td>
							<%}%>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">법인등록번호</label></th>
							<td <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %> colspan="3" <% } else { %> scope="col" <% } %> >
								<% if(!util.getStr(dataMap.get("CORP_NUM_2")).equals("")){ %>
									<%=util.getStr(dataMap.get("CORP_NUM_2")).substring(0,3)%> -
									<%=util.getStr(dataMap.get("CORP_NUM_2")).substring(3,5)%> -
									<%=util.getStr(dataMap.get("CORP_NUM_2")).substring(5)%>
								<%}%>
							</td>
							<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")){%>
							<th scope="col">업태</th>
							<td scope="col"><%=util.getStr(dataMap.get("BUSINESSCON")) %></td>
							<%}%>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">대표전화</label></th>
							<td><%=util.getStr(dataMap.get("CORP_PHONE"))%></td>
							<th scope="col"><label for="emialId">FAX번호</label></th>
							<td><%=util.getStr(dataMap.get("CORP_FAX"))%></td>
						</tr>
						<tr>
							<th scope="col"><label for="emialId">홈페이지</label></th>
							<td colspan="3"><%=util.getStr(dataMap.get("HOMEPAGE"))%></td>
						</tr>
						<%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %>
						<tr>
							<th scope="col">사업자등록증</th>
							<td colspan="3">
							<%if(!util.getIntStr(dataMap.get("BIZ_REG_DOC_FILE_ID")).equals("")){%>
								<a href="/cmm/fms/ComFileDown.do?dataGrp=bizRegDoc&amp;fileId=<%=util.getIntStr(dataMap.get("BIZ_REG_DOC_FILE_ID"))%>&amp;dataIdx=<%=util.getStr(paramMap.get("orgGrpCd"))%>">
								<%=util.getStr(dataMap.get("BIZ_REG_DOC_FILE_TITLE"))%>
								</a>
							<%}%>
							</td>
						</tr>
						<%}%>
					</tbody>
					</table>


					<div class="box_in">
						<!-- 상세정보영역 -->
						<h3>기업/기관 상세정보</h3>
						<table class="skin_basic_write" summary="기엄/기관 상세정보를 나타내는 표 입니다">
							<caption>기업/기관 상세정보</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 80%;" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="col"><label for="blngOrgAddr">주소</label></th>
									<td><%=util.getStr(dataMap.get("ZIPCODE"))%> <%=util.getStr(dataMap.get("ADDR1"))%></td>
								</tr>
								<tr>
									<th scope="col"><label for="blngOrgAddrDtl">상세주소</label></th>
									<td><%=util.getStr(dataMap.get("ADDR2"))%></td>
								</tr>
								<tr>
									<th scope="col"><label for="deptAddr">지도</label></th>
									<td>
										<% if(!util.getStr(dataMap.get("MAP_X")).equals("")&&!util.getStr(dataMap.get("MAP_Y")).equals("")){%>
										<div id="map" style="width: 100%; height: 300px; margin-top: 10px;"></div>
										<%}else{out.println("정보 없음");}%>
									</td>
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
								<%}%>
								<tr>
									<th scope="col"><label for="birthDate">소개</label></th>
									<td><%=util.getStr(dataMap.get("ORG_NOTE_1"))%></td>
								</tr>
								<tr>
									<th scope="col"><label for="frgnYn">기업/기관 소개자료</label></th>
									<td>
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

					<% if(util.getStr(dataMap.get("ORG_TYPE")).equals("1") && util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %>
					<div class="box_in">
						<!-- 연구소 상세정보영역 -->
						<h3>연구소 정보</h3>
						<table class="skin_basic_write" summary="연구소 정보를 나타내는 표 입니다">
							<caption>연구소 정보</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 80%;" />
							</colgroup>
							<tr>
								<th scope="col">연구소 이름</th>
								<td scope="col"><%=util.getStr(dataMap.get("LAB_NM")) %></td>
							</tr>
							<tr>
								<th scope="col">연구소 전화번호</th>
								<td scope="col"><%=util.getStr(dataMap.get("LAB_PHONE")) %></td>
							</tr>
							<tr>
								<th scope="col">연구소 FAX</th>
								<td scope="col"><%=util.getStr(dataMap.get("LAB_FAX")) %></td>
							</tr>
							<tr>
								<th scope="col">연구소 주소</th>
								<td><%=util.getStr(dataMap.get("LAB_ZIPCODE"))%> <%=util.getStr(dataMap.get("LAB_ADDR1"))%></td>
							</tr>
							<tr>
								<th scope="col">연구소 상세주소</th>
								<td><%=util.getStr(dataMap.get("LAB_ADDR2"))%></td>
							</tr>
							<tr>
								<th scope="col">지도</th>
								<td>
									<% if(!util.getStr(dataMap.get("LAB_MAP_X")).equals("")&&!util.getStr(dataMap.get("LAB_MAP_Y")).equals("")){%>
									<div id="labMap" style="width: 100%; height: 300px; margin-top: 10px;"></div>
									<%}else{out.println("정보 없음");}%>
								</td>
							</tr>
						</table>
					</div>
					<% } %>

			<!-- 버튼  -->
			<div class="btn_box">
				<%if(util.getStr(dataMap.get("APPLY_CD")).equals("10")) { %>
				<div class="btn_left_box">
					<button class="btn_inp_b_01" id="applyButton" type="button">승인</button>
					<!--<button class="btn_inp_b_01" id="rejectButton" type="button">반려</button>-->
				</div>
				<% } %>
				<div class="btn_right_box">
					<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
					<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
				</div>
			</div>

			<!-- 반려사유  -->
			<!--<div id="rejectArea" style="margin-top: 10px; display:none;">
				<input type="text" class="inp_text" style="width:50%;" id="reject" name="reject" onkeydown="return captureReturnKey(event)"/>
				<button type="button" class="btn_inp_b_01" id="rejectInput">반려입력</button>
			</div> -->

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

	$("#rejectButton").click(function() {
		$("#rejectArea").toggle();
	});

	$("#applyButton").click(function() {
		if(confirm("승인하시겠습니까?")) {

			$.ajax({
				url : "/sys/orgApply.do",
				data : {"status" : "20", "orgGrpCd" : $("#orgGrpCd").val()},
				success : function(data) {
					alert("승인되었습니다.");
					location.reload();
				},
				error : function() {
					alert("문제가 발생하였습니다.");
				}
			});
		}
	});

	$("#rejectInput").click(function() {
		if(confirm("반려하시겠습니까?")) {
			$.ajax({
				url : "/sys/orgReject.do",
				data : {"status" : "30", "reject" : $("#reject").val(), "orgGrpCd" : $("#orgGrpCd").val()},
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data) {
					alert("반려되었습니다.");
					location.reload();
				},
				error : function() {
					alert("문제가 발생하였습니다.");
				}
			});
		}
	});

	function captureReturnKey(e) {
	    if(e.keyCode==13 && e.srcElement.type != 'textarea')
	    return false;
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

<%
	if(!util.getStr(dataMap.get("LAB_MAP_X")).equals("")&&!util.getStr(dataMap.get("LAB_MAP_Y")).equals("")){
%>

<script type="text/javascript">
	var mapContainer = document.getElementById('labMap'), // 지도를 표시할 div
	mapOption = {
		center : new daum.maps.LatLng(
<%=util.getStr(dataMap.get("LAB_MAP_X"))%>
	,
<%=util.getStr(dataMap.get("LAB_MAP_Y"))%>
	), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨
	};

	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
		position : new daum.maps.LatLng(
<%=util.getStr(dataMap.get("LAB_MAP_X"))%>
	,
<%=util.getStr(dataMap.get("LAB_MAP_Y"))%>
	),
		map : map
	});
</script>
<%
	}
%>