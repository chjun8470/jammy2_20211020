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
	HashMap<String, String> userDataMap = request.getAttribute("userDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userDataMap");
	HashMap<String, String> resvDataMap = request.getAttribute("resvDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("resvDataMap");

	int nowDate = util.getInt(util.getDate("yyyyMMdd"));
	int eduOrdStDt = util.getInt(dataMap.get("EDU_ORD_ST_DT").replaceAll("-", ""));
	int eduOrdEdDt = util.getInt(dataMap.get("EDU_ORD_ED_DT").replaceAll("-", ""));

	int eduOrdPeople = util.getInt(util.getIntStr(dataMap.get("EDU_ORD_PEOPLE")));
	int eduPeople = util.getInt(util.getIntStr(dataMap.get("EDU_PEOPLE")));

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String eduId = util.getStr(paramMap.get("eduId"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String listMode = util.getStr(paramMap.get("listMode"));
	LoginVO loginVO = util.getLoginInfo(request);

%>

	  <form name="fview" id="fview" action="./sub.do" method="post" >
		<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="m" value="<%=m%>" />
	  	<input type="hidden" name="eduId" id="eduId" value="<%=eduId%>" />
	  	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="reUrl" id="reUrl" value="/jntis/sub.do?m=<%=m%>&amp;eduId=<%=eduId%>" />

<div class="basic_viewWrap">

<h2 class="h4_tit">교육정보</h2>
<table class="skin_view">
  <caption>교육정보 상세정보표</caption>
	<colgroup>
	  <col style="width:15%;" />
	  <col style="width:35%;" />
	  <col style="width:15%;" />
	  <col style="width:35%;" />
	</colgroup>

	<tbody>
			<tr>
				<th scope="col">교육명</th>
				<td class="r_line_none b_notice" colspan="3"><%=util.getStr(dataMap.get("EDU_NM"))%></td>
			</tr>
			<tr>
				<th scope="col">과정명</th>
				<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("EDU_CUR"))%></td>
			</tr>
	 		<!-- <tr>
				<th scope="col">교육분류</th>
				<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("EDU_CATE_NM"))%></td>
			</tr>-->
			<tr>
			<th scope="col">교육상태</th>
				  <td  class="r_line_none" colspan="3">
				  	<% if("접수중".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="접수중" style="width: 86px;" src="/img/back/comm/edu_state_img_01.png" />
					<% }else if("접수대기".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="접수대기" style="width: 86px;" src="/img/back/comm/edu_state_img_02.png" />
					<% }else if("접수마감".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="접수마감" style="width: 86px;" src="/img/back/comm/edu_state_img_03.png" />
					<% }else if("수업중".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="수업중" style="width: 86px;" src="/img/back/comm/edu_state_img_04.png" />
					<% }else{%>
							<img alt="수업종료" style="width: 86px;" src="/img/back/comm/edu_state_img_05.png" />
					<% } %>
				  </td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln">교육주관</th>
					<td class="top_sell brn" colspan="3">
						<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln">주최/후원</th>
					<td class="top_sell brn" colspan="3">
						<%=util.getStr(dataMap.get("EDU_AUSPICES_NM"))%>
					</td>
				</tr>

			<tr>
				<th scope="col">접수기간</th>
				<td class="r_line_none" colspan="3">
					<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>
				</td>
			</tr>
			<tr>
				<th scope="col">교육기간</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ED_DT"))%>
				  </td>
			</tr>
			<tr>
				<th scope="col">총교육시간</th>
				<td  class="r_line_none" colspan="3">
					<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>(시간)
				</td>
			</tr>
			<tr>
				<th scope="col" class="top_sell bln">안내사항</th>
					<td class="r_line_none" colspan="3">
					<pre><%=util.getStr(dataMap.get("EDU_TIME"))%></pre>
					</td>
			</tr>
			<tr>
				<th scope="col">교육장소</th>
				<td  class="r_line_none" colspan="3">
					<%=util.getStr(dataMap.get("EDU_PLACE"))%>&nbsp;<%=util.getStr(dataMap.get("EDU_PLACE_DETAIL"))%>
				</td>
			</tr>
			<tr>
				  <th scope="col">지도</th>
				  <td  class="r_line_none" colspan="3">
				  	<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
				  </td>
			</tr>
			<tr>
				  <th scope="col">수강인원</th>
				  <td class="r_line_none" colspan="3">
				  	<%=util.getIntStr(dataMap.get("EDU_ORD_PEOPLE"))%> / <%=util.getIntStr(dataMap.get("EDU_PEOPLE"))%>
				  </td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduUserNm">강사정보</label></th>
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
				<tr>
				  <th scope="col">교육비</th>
				  <td  class="r_line_none">
				  	<%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "무료" : util.getComma(dataMap.get("EDU_PAY"))+"(원)"%>
				  </td>
				  <th scope="col">고용보험적용여부</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("10")?"적용":"미적용"%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">교육문의</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_TEL"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">교육대상</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_TARGET"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">교육내용</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_CONTENT"))%>
				  </td>
				</tr>
				<th scope="col">교육안내문</th>
					<td colspan="3">
				<%
					String fileParam = "?dataGrp=eduOrgInfo"
										+"&amp;fileId="+util.getIntStr(dataMap.get("INFO_FILE_ID"))
										+"&amp;dataIdx="+util.getIntStr(dataMap.get("EDU_ID"));
				%>
                       	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(dataMap.get("INFO_FILE_TITLE"))%></a>
					</td>
				</tr>

	</tbody>
</table>

<%if(util.loginCheck()&& (nowDate >= eduOrdStDt && nowDate <= eduOrdEdDt)){ %>
<br/>
<h2 class="h4_tit">신청정보</h2>

				<table id="step1" class="skin_write">
						<caption>신청정보 상세정보표</caption>
						<colgroup>
				   			<col style="width:200px">
				   			<col style="width:800">
						</colgroup>
						<tbody>

						<tr>
							<th scope="col" class="top_sell bln">교육명</th>
							<td class="r_line_none">
								<%=util.getStr(dataMap.get("EDU_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">관리번호</th>
							<td class="r_line_none">
								<%=util.getStr(resvDataMap.get("EDU_RESV_ID")) %>
							</td>
						</tr>
						<tr>
							<th scope="col">과정명</th>
							<td class="r_line_none"><%=util.getStr(dataMap.get("EDU_CUR"))%></td>
							<th>수료증발급</th>
							<td class="">
						<%if(util.getStr(resvDataMap.get("RESV_STATE")).equals("50")){ 
							if(util.getStr(resvDataMap.get("RESV_CERTI_FILE")).equals("")){
						%>
							<input type="button" value="발급받기" class="btn_inp_w_01" onclick="window.open('/AIViewer55/temp/educer.jsp?reportParams=showScrollNext:false,showScrollTop:false,showScrollBottom:false,showScrollPrev:false,showScrollPage:false&menu=old&resvid=<%=util.getStr(resvDataMap.get("EDU_RESV_ID"))%>&state=<%=util.getStr(resvDataMap.get("RESV_STATE")) %>','win','width=797,height=800,toolbar=0,scrollbars=0,resizable=0')" />
						<%
							}else{
							String resvFileParam = "?dataGrp=resvCerti"
										+"&amp;fileId="+util.getIntStr(resvDataMap.get("RESV_CERTI_FILE"))
										+"&amp;dataIdx="+util.getStr(resvDataMap.get("EDU_RESV_ID"));
						%>
						<a href="/cmm/fms/ComFileDown.do<%=resvFileParam%>" class="btn_inp_w_01">발급받기</a>
							
							
								
							<% }
						} %>
						</td>
						<tr>
							<th scope="col" class="top_sell bln">상태정보</th>
							<td class="r_line_none">
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("")?"접수중":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("10")?"승인대기":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("20")?"참가승인":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("30")?"반려":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("40")?"접수취소":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("50")?"교육수료":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("60")?"미수료":"" %>
							</td>
							<th scope="col" class="top_sell bln" >신청일</th>
							<td class="r_line_none">
								<%=!util.getStr(resvDataMap.get("REG_DATE")).equals("")?util.getStr(resvDataMap.get("REG_DATE")):util.getDate("yyyy-MM-dd") %>
							</td>
						</tr>
						<tr id="rejectTr" <%=util.getStr(resvDataMap.get("RESV_STATE")).equals("30")?"":"style='display:none'" %>>
							<th scope="col" class="top_sell bln" >반려내용</th>
							<td class="r_line_none" colspan="3">
							<pre><%=util.getStr(resvDataMap.get("RESV_REJECT"))%></pre>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">신청자명</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("PSN_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">성별</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("GENDER_TYPE_CD")).equals("M")? "남성":"여성"%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">소속</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("ORG_GRP_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">직위</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("POSITION_NM"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">휴대전화</th>
							<td class="r_line_none">
								<%if(util.getStr(resvDataMap.get("EDU_RESV_ID")).equals("")){ %>
									<input type="hidden" name="phone" id="phone" />
									<input type="text" name="phone01" id="phone01" class="inp_txt02" style="width:50px" maxlength="4" /> - <input type="text" name="phone02" id="phone02" class="inp_txt02" style="width:75px" maxlength="4" /> - <input type="text" name="phone03" id="phone03" class="inp_txt02" style="width:75px" maxlength="4" />
								<%}else{ %>
								<%=util.getIntStr(resvDataMap.get("USER_TEL"))%>
								<%}%>

							</td>
							<th scope="col" class="top_sell bln">이메일</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("EMAIL"))%>
							</td>
						</tr>

					</tbody>
				</table>
<% }%>
		<div class="b_btn_area">

			<span>
			<%if(util.loginCheck()){ %>
				<%if(nowDate >= eduOrdStDt && nowDate <= eduOrdEdDt){//접수기간에만 동작수행가능%>
				<input type="hidden" name="eduResvId" id="eduResvId" value="<%=util.getStr(resvDataMap.get("EDU_RESV_ID")) %>" />
				<%if(util.getStr(resvDataMap.get("RESV_STATE")).equals("10")){%>
					<input type="button" class="btn_rgt2" value="신청취소" onclick="actStateChange()"/>
				<%}else if(util.getStr(resvDataMap.get("RESV_STATE")).equals("30")||util.getStr(resvDataMap.get("RESV_STATE")).equals("40")){%>
					<input type="button" class="btn_rgt2" value="재신청" onclick="actStateChange()"/>
				<%}else{
				if(eduPeople > eduOrdPeople && util.getStr(resvDataMap.get("EDU_RESV_ID")).equals("")){%>
					<input type="button" class="btn_rgt2" value="신청" onclick="pageWriteGo()"/>
				<%}
				 }
				}%>
			<%}else{ %>
				<%if(nowDate >= eduOrdStDt && nowDate <= eduOrdEdDt && eduPeople > eduOrdPeople){//접수기간에만 동작수행가능%>
					<input type="button" class="btn_rgt2" value="신청" onclick="alert('로그인 후 신청이 가능합니다.')"/>
					<% }
				}
			%>
			<input type="button" class="btn_lft" value="목록" onclick="pageListGo()"/>
			</span>
		</div>
	</div>
</form>
<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}

	function actStateChange(){
		$('#mode').val('stateChange');
		$('#fview').submit();
	}


	function pageWriteGo(){
		var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
		$('#mode').val('write');
		if($('#phone01').val() != '' && $('#phone02').val() != '' && $('#phone03').val() != ''){
			var phone_check = $('#phone01').val()+'-'+$('#phone02').val()+'-'+$('#phone03').val();
			$('#phone').val(phone_check);

			if(!regExp.test($('#phone').val())){
				alert("핸드폰 번호를 잘못 입력 하셨습니다. 다시 입력해주세요");
				$('#phone01').focus();
				return false;
			}
		}
		$('#fview').submit();
	}

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