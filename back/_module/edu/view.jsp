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
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	
	String eduType = util.getStr(paramMap.get("type")).equals("jntis")?"":"_smbrnd";
%>

<div class="clear_wrap">
						<div class="left_box w75">
				<div class="box_in" style="width:80%">
					<p class="tr mb5"></p>
					<table id="step1" class="skin_basic_write">
						<caption>교육정보 상세정보표</caption>
						<colgroup>
				   			<col style="width:200px">
				   			<col style="width:800">
						</colgroup>
						<tbody>

						<tr>
							<th scope="col" class="top_sell bln">교육명</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_NM"))%>
							</td>
							<!--
							<th scope="col" class="top_sell bln">교육분류</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_CATE_NM"))%>
							</td>-->
						</tr>
						<th scope="col" class="top_sell bln">JNTIS 사용여부</th>
							<td class="top_sell brn">
								<%=util.getIntStr(dataMap.get("EDU_USE_FLAG")).equals("10")? "사용":"사용안함"%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육과정</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_CUR"))%>
							</td>
						</tr>
						<%-- <tr>
							<th scope="col" class="top_sell bln">신청상태</th>
							<td class="top_sell brn" >
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("10")?"신청":"" %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("20")?"승인":"" %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"반려":"" %>
							</td>
							<th scope="col" class="top_sell bln">교육상태</th>
							<td class="top_sell brn">
								<% if("접수중".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
										<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
								<% }else if("접수대기".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
										<img alt="접수대기" src="/img/back/comm/edu_state_img_02.png" />
								<% }else if("접수마감".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
										<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
								<% }else if("수업중".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
										<img alt="수업중" src="/img/back/comm/edu_state_img_04.png" />
								<% }else{%>
										<img alt="수업종료" src="/img/back/comm/edu_state_img_05.png" />
								<% } %>
							</td>
						</tr>

						<tr id="rejectTr" <%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"":"style='display:none'" %>>
							<th scope="col" class="top_sell bln" >반려내용</th>
							<td class="top_sell brn" colspan="3">
							<pre><%=util.getStr(dataMap.get("EDU_REJECT"))%></pre>
							</td>
						</tr> --%>
						<tr>
							<th scope="col" class="top_sell bln">주최/후원</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_AUSPICES_NM"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육기관</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("ORG_GRP_NM"))%><%if(!util.getStr(dataMap.get("EDU_ORG_SUB_NM")).equals("")){ %> (<%=util.getStr(dataMap.get("EDU_ORG_SUB_NM"))%>)<%} %>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">접수기간</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>
							</td>
							<th scope="col" class="top_sell bln">교육기간</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ED_DT"))%>
							</td>
						</tr>

						<tr>
							<%-- <th scope="col" class="top_sell bln">안내사항</th>
							<td class="top_sell brn">
								<pre><%=util.getStr(dataMap.get("EDU_TIME"))%></pre>
							</td> --%>
							<th scope="col" class="top_sell bln">총교육시간</th>
							<td class="top_sell brn" colspan="3" >
								<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>(시간)
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육장소</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_PLACE"))%>
								<br/>
								<%=util.getStr(dataMap.get("EDU_PLACE_DETAIL"))%>
							</td>
						</tr>
						<tr>
							<th scope="col">지도</th>
							<td colspan="3">
							<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육대상</th>
							<td class="top_sell brn" colspan="3">
							<pre><%=util.getStr(dataMap.get("EDU_TARGET"))%></pre>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">수강인원</th>
							<td class="top_sell brn">
								<%=util.getIntStr(dataMap.get("EDU_ORD_PEOPLE"))%>/<%=util.getIntStr(dataMap.get("EDU_PEOPLE"))%>
						</td>
						<tr>
							<th scope="col" class="top_sell bln">교육비</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "무료" : util.getComma(dataMap.get("EDU_PAY"))%>
							</td>
							<th scope="col" class="top_sell bln">고용보험적용여부</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("Y")?"적용":"미적용"%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">강사정보</th>
							<td class="top_sell brn" colspan="3">
							<table class="skin_basic_write">
									<tr>
										<th style="width:100px;">소속</th>
										<td style="width:200px;">
											<%=util.getStr(dataMap.get("EDU_USER_SECTOR"))%>
										</td>
										<th style="width:100px;">직위</th>
										<td style="width:200px;">
											<%=util.getStr(dataMap.get("EDU_USER_DEPT"))%>
										</td>
									</tr>
									<tr>
										<th style="width:100px;">강사명</th>
										<td style="width:200px;">
											<%=util.getStr(dataMap.get("EDU_USER_NM"))%>
										</td>
										<th>전화번호</th>
										<td>
											<%=util.getStr(dataMap.get("EDU_USER_TEL"))%>
										</td>
									</tr>
									<tr>
										<th>휴대전화</th>
										<td>
											<%=util.getStr(dataMap.get("EDU_USER_CP_NO"))%>
										</td>
										<th>이메일</th>
										<td>
											<%=util.getStr(dataMap.get("EDU_USER_EMAIL"))%>
										</td>
									</tr>

								</table>

							</td>
						</tr>
						<%-- <tr>
							<th scope="col" class="top_sell bln">문의연락처</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_TEL"))%>
							</td>
						</tr> --%>
						<tr>
							<th scope="col" class="top_sell bln">교육내용</th>
							<td class="top_sell brn" colspan="3">
							<%=dataMap.get("EDU_CONTENT")%>
							</td>
						</tr>
						<tr>
						<th scope="col">교육안내문</th>
							<td colspan="3">
						<%
						if(fileList.size() > 0){
						for(HashMap rs:fileList){
						String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
					%>
						<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드">
							<img src="/img/board/ico_file.png" alt="첨부파일 아이콘" />&nbsp;<%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
						</a><br/>
					<% 	} }%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육문의</th>
							<td class="top_sell brn" colspan="3">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;">
	                						<%=util.getStr(dataMap.get("MANAGER_ORG_GRP_NM"))%>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;">
	                						<%=util.getStr(dataMap.get("MANAGER_DEPT_NM"))%>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;">
	                						<%=util.getStr(dataMap.get("MANAGER_USER_NM"))%>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;">
	                						<%=util.getStr(dataMap.get("MANAGER_POSITION_NM"))%>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td>
	                						<%=util.getStr(dataMap.get("MANAGER_TEL_NO")) %>
	                					</td>
	                					<th>이메일</th>
	                					<td>
	                						<%=util.getStr(dataMap.get("MANAGER_EMAIL"))%>
	                					</td>
	                				</tr>
	                			</table>
							</td>
						</tr>
						<tr>
							<th>수료증발급 여부</th>
							<td colspan="3">
								<% if( util.getStr(String.valueOf(dataMap.get("CERTI_YN"))).equals("1") ){ %>
									직접등록
								<% }else{ %>
									온라인발급
								<% } %>
							</td>
						</tr>
						<tr>
						<th scope="col">대표 직인(도장)</th>
							<td colspan="3">
								<img class='stamp_img' src="<%=(util.getStr(dataMap.get("STAMP_FILE_SRC")).equals("") ? "/img/no-image.gif" : util.getStr(dataMap.get("STAMP_FILE_SRC")))%>" alt='도장이미지' style='width:100px;height:100px'/>
							</td>
						</tr>
						<tr id="certiTR">
							<th scope="col">교육 수료증</th>
							<td colspan="3">
							<p>수료증 발급시 수료증 하단에 표시될 내용입니다.</p>
							<table class="skin_basic_write">
								<caption>수료증 하단내용</caption>
								<colgroup>
									<col width="40%">
									<col width="60%">
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">발급기관</th>
										<td><%=util.getStr(dataMap.get("CERTI_ORG"))%></td>
									</tr>
									<tr>
										<th scope="col">발급자</th>
										<td><%=util.getStr(dataMap.get("CERTI_DIRECTOR"))%></td>
									</tr>
								</tbody>
							</table>
							</td>
						</tr>
					</tbody>
				</table>
			  </div>
			  <div class="btn_box" >
			  			<div class="btn_left_box" >
					<%if(!loginVO.getAuthLv().equals("99")){
						if(util.getStr(dataMap.get("EDU_STATE")).equals("10")){%>
							<!-- <button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button> -->
						<%}
					}else{%>
							<!-- <button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button> -->
					<%} %>
						</div>
						<div class="btn_right_box" >
						<button class="btn_inp_g_01" type="button" onclick="pageResvGo()">신청자보기</button>
					<%if(!loginVO.getAuthLv().equals("99")){
						if(util.getStr(dataMap.get("EDU_STATE")).equals("10")){%>
							<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
							<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
						<%}
					}else{%>
							<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
							<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
					<%} %>
							<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>

						</div>
			 </div>
			</div>
</div>
<form id = "fview" name = "fview" method="post" action="/sys/sys<%=eduType%>_edu.do">
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" name = "eduId" id = "eduId" value="<%=util.getStr(paramMap.get("eduId"))%>"/>
</form>

<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').attr("action","/sys/sys<%=eduType%>_edu.do");
		$('#fview').submit();
	}
	function pageResvGo(){
		$('#mode').val('resvList');
		$('#fview').attr("action","/sys/sys<%=eduType%>_edu.do");
		$('#fview').submit();
	}
	function pageDelGo(){
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fview').attr("action","/sys/jnspEduProc.do");
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').attr("action","/sys/sys<%=eduType%>_edu.do");
		$('#fview').submit();
	}
</script>

<script type="text/javascript">
////////////////지이도

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>), // 지도의 중심좌표
		level: 5 // 지도의 확대 레벨
	};

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
	position: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>),
	map: map
});
</script>