<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
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
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String diary = util.getStr(paramMap.get("diary"));
	String reportType = util.getStr(paramMap.get("reportType"));

	SimpleDateFormat df= new SimpleDateFormat("yyyyMMdd");

	Date date = new Date();
	String today = df.format(date);

	String fileGrp = "";
	String fileSubGrp = "";
	String fileFullGrp ="";

%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<div class="clear_wrap">

<form id = "fview" name = "fview" method="post" action="/sys/sys_eq_reservation.do">
	<input type="hidden" id="mode" 			name="mode" 		value="<%=mode%>"/>
	<input type="hidden" id="orderState" 	name="orderState"	value="<%=util.getStr(paramMap.get("orderState"))%>"/>
	<input type="hidden" id="searchType" 	name="searchType"	value="<%=util.getStr(paramMap.get("searchType"))%>"/>
	<input type="hidden" id="searchStDt" 	name="searchStDt"	value="<%=util.getStr(paramMap.get("searchStDt"))%>"/>
	<input type="hidden" id="searchEdDt" 	name="searchEdDt"	value="<%=util.getStr(paramMap.get("searchEdDt"))%>"/>
	<input type="hidden" id="searchWord" 	name="searchWord"	value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
	<input type="hidden" id="reUrl"  		name="reUrl" 		value="<%=myPage%>" />
	<input type="hidden" id="reject"  		name="reject" 		value="" />
	<input type="hidden" id="equOrderIdx"	 name="equOrderIdx" value="<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
	<input type="hidden" name="reportType"	value="<%if(util.getStr(paramMap.get("orderState")).equals("4")) { out.print(util.getStr(paramMap.get("reportType"))); } %>"/>
</form>


	<!-- 공통사항(장비이용 예약정보, 장비 사용자 정보) -->
	<div class="box_in">
		<h2>장비이용 예약 처리상태</h2>
		<table id="step1"  class="skin_basic_write">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">JEINET 예약번호</th>
					<td scope="col">
					J-<%=util.getStr(paramMap.get("equOrderIdx"))%>
					</td>
					<th scope="col">처리상태</th>
					<td colspan="3">
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <img alt="이용승인" src="/img/back/comm/order_state_img_2.png"> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %>
					<img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <br /> 반려사유 :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <img alt="이용완료" src="/img/back/comm/order_state_img_4.png"> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> <% } %>
					</td>
				</tr>
				<tr>
					<th scope="col">처리부서</th>
					<td scope="col">
					<%=util.getStr(dataMap.get("ORDER_DEPT_NM"))%>
					</td>
					<th scope="col">처리자</th>
					<td scope="col">
					<%=util.getStr(dataMap.get("ORDER_OPERATOR"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">처리시간</th>
					<td scope="col">
					<%=util.getStr(dataMap.get("ORDER_OPERATOR_DT"))%>
					</td>
					<th scope="col">예약정보 인쇄</th>
					<td scope="col">
					<%-- <button class="btn_inp_y_01" onclick="printPop('<%=dataMap.get("RND_EQU_IDX")%>','<%=dataMap.get("USER_IDX")%>','<%=util.getStr(paramMap.get("equOrderIdx"))%>')">인쇄하기</button> --%>
					<button class="btn_inp_y_01" onclick="goPrint('<%=dataMap.get("RND_EQU_IDX")%>','<%=dataMap.get("USER_IDX")%>','<%=util.getStr(paramMap.get("equOrderIdx"))%>')">인쇄하기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<div class="box_in" id="equUserDiv">
		<h3>장비 사용자 정보</h3>
		<!-- 신청자 정보 -->
		<table class="skin_basic_write">
			<colgroup>
			<col style="width: 20%;" />
			<col style="width: 80%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col"> 신청자명</th>
					<td><%=util.getStr(userMap.get("PSN_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> 소속기관명</th>
					<td><%=util.getStr(userMap.get("ORG_GRP_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> 소속부서/센터</th>
					<td><%=util.getStr(dataMap.get("DEPT_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> 신청자 직위</th>
					<td><%=util.getStr(userMap.get("POSITION_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> 책임자</th>
					<td><%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%></td>
				</tr>
				<tr>
					<th scope="col"> 연락처</th>
					<td><%=util.getStr(userMap.get("EMAIL"))%>
					<br /><%=util.getStr(userMap.get("PHONE"))%></td>
				</tr>
				<tr>
					<th scope="col"> 주소</th>
					<td><%=util.getStr(userMap.get("ADDR1"))%>
					<br/><%=util.getStr(userMap.get("ADDR2"))%></td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="box_in" id="equResDiv">
		<h3>장비이용 예약정보</h3>
		<table class="skin_basic_write">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 26.6%;" />
				<col style="width: 26.6%;" />
				<col style="width: 26.6%;" />
			</colgroup>
			<!-- colgroup e -->
			<tr>
				<th scope="col">예약신청일</th>
       			<td scope="col" colspan="3"><%=util.getStr(dataMap.get("ORDER_DT"))%></td>
           	</tr>
           	<tr>
				<th scope="col">장비명</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
				</td>
			</tr>
			<tr>
				<th scope="col">등록번호</th>
				<td scope="col">
					JEINET 등록번호 : <%=util.getStr(dataMap.get("RND_EQU_IDX"))%>
				</td>
				<td scope="col">
					Zeus 등록번호 : <%if(!util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("NTIS_EQUIP_INFO")));}else {out.print("Zeus 미등록 장비");}%>
				</td>
				<td scope="col">
					i-Tube 등록번호 : <%if(!util.getStr(dataMap.get("ETUBE_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("ETUBE_EQUIP_INFO")));}else {out.print("i-Tube 미등록 장비");}%>
				</td>
			</tr>
			<tr>
				<th scope="col">보유기관</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>(<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM"))%>)
				</td>
			</tr>
			<tr>
				<th scope="col"> 이용희망기간</th>
				<td scope="col" colspan="3">
		 			<%=util.getStr(dataMap.get("USE_ST_DT"))%> ~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"> 사용구분</th>
				<td scope="col" colspan="3">
					<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> 서비스의뢰 <% } %>
                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> 직접사용 <% } %>
                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> 야간및휴일사용 <% } %>
				</td>
			</tr>
			<tr>
				<th scope="col"> 이용목적</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("USE_PURPOSE"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"> 실사용기간</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>
                			~ <%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"> 시료예약정보</th>
				<td colspan="3">
					<%
	                				String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
                					String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
                					String sampleNmArr[] = sampleNm.split("\\|\\|");
                					String sampleNoArr[] = sampleNo.split("\\|\\|");
                					for(int i = 1 ; i < sampleNmArr.length ; i++ ){
                						if( i != 1 ){
                							//out.println(", ");
                						}
                						out.println(i+". 시료 : " + sampleNmArr[i]);
                						out.println("(");
                						out.println(sampleNoArr[i]);
                						out.println(")");
                						out.println("<br />");
                					}
	                			%>
				</td>
			</tr>
			<tr>
				<th>장비사용신청서</th>
				<td>
					<div style="clear:both;">
							<%if(fileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:fileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text"> 첨부파일 <%=fileCnt%> :
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
				</td>
			</tr>
			<tr>
				<th scope="col">특이사항</th>
				<td colspan="3">
					<%=util.getStr(dataMap.get("SAMPLE_MATTER")).replace("\n", "<br/>")%>
				</td>
			</tr>
			<tr>
				<th scope="col">기관접수일</th>
       			<td scope="col" colspan="3"><%=util.getStr(dataMap.get("USE_ED_DT"))%></td>
			</tr>
		</table>
	</div>
	<div class="btn_box" >
		<div class="btn_left_box" >
              		<!-- 권한주기 최고,기관관리자,담당자 -->
              		<% if(util.loginCheck()) {%>
	              		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
		            		<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('2')">예약접수</button>

<!-- 	            			<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">승인요청 거절</button> -->
		            	<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
		            		<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
		            			<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('4')">이용 완료</button>
		            		<% } %> --%>
		            			<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('5')">이용승인 취소</button>

						<% } %>
	            	<% } %>
              	</div>

		<div class="btn_right_box" >
		<% if(util.loginCheck()) {%>
			<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">예약수정</button>
			<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ) {%>
				<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">예약삭제</button>
			<% } %>
		<% } %>
		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
		</div>

	</div>
	<div class="btn_box" style="margin-top:10px;">
		<div class="btn_left_box">
		<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- 기관담당자 이상 -->
			<% if(util.getStr(paramMap.get("mode")).equals("view")){ %>
				<% if(!util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %>
					<button class="btn_inp_b_01" id="diaryWriteBtn" type="button" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1") || (util.getStr(paramMap.get("reportType")).equals("diary") && util.getStr(paramMap.get("diary")).equals("view"))){ %>style="display:none;"<%} %> onclick="resveReport()">운영일지 작성</button>
				<% }else { %>
					<button class="btn_inp_b_01" id="diaryEditBtn" type="button" onclick="diaryEditView()">운영일지 수정</button>
				<% } %>
				<% if(!util.getStr(dataMap.get("INNER_YN")).equals("Y")) { %>
<%-- 					<button class="btn_inp_b_01" id="innerWriteBtn" type="button" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1") || (util.getStr(paramMap.get("reportType")).equals("inner") && util.getStr(paramMap.get("diary")).equals("view"))){ %>style="display:none;"<%} %> onclick="innerResveReport()">내부활용 등록</button> --%>
				<% }else { %>
<!-- 					<button class="btn_inp_b_01" id="innerEditBtn" type="button" onclick="innerEditView()">내부활용 수정</button> -->
				<% } %>
				<% if(!util.getStr(dataMap.get("LEGAL_YN")).equals("Y")) { %>
					<%-- <button class="btn_inp_b_01" id="legalWriteBtn" type="button" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1") || (util.getStr(paramMap.get("reportType")).equals("legal") && util.getStr(paramMap.get("diary")).equals("view"))){ %>style="display:none;"<%} %> onclick="legalResveReport()">법정검사 등록</button> --%>
				<% }else { %>
					<!-- <button class="btn_inp_b_01" id="legalEditBtn" type="button" onclick="legalEditView()">법정검사 수정</button> -->
				<% } %>
			<% } %>
		<% } %>
		</div>
	</div>

<%-- <%if(reportType.equals("") || reportType.equals("diary") || util.getStr(dataMap.get("DIARY_YN")).equals("Y")){ %> --%>
<%if(util.getStr(paramMap.get("mode")).equals("view")){ %>
	<%@include file="diary.jsp" %>
<%-- <%}if(reportType.equals("") || reportType.equals("inner") || util.getStr(dataMap.get("INNER_YN")).equals("Y")){ %> --%>
<%-- 	<%@include file="inner.jsp" %> --%>
	<%-- <%@include file="legal.jsp" %> --%>
<%} %>
<%--
	<div class="btn_box" >
		<div class="btn_left_box" >
		<!-- 권한주기 최고,기관관리자,담당자 -->
		<% if(util.loginCheck()) {%>
			<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
				<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('2')">예약접수</button>
				<!--<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">승인요청 거절</button> -->
			<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
				<%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
					<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('4')">이용 완료</button>
            		<% } %>
					<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('5')">이용승인 취소</button>
			<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <!-- 이용완료상태일경우 -->
				<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- 기관담당자 이상 -->
					<% if(!util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %> <!-- 기관담당자 이상 -->
						<button class="btn_inp_b_01" type="button" onclick="resveReport(<%=util.getStr(paramMap.get("equOrderIdx"))%>)resveReport()">운영일지 작성</button>
					<% } %>
				<% } %>
			<% } %>
		<% } %>
		</div>

		<div class="btn_right_box" >
		<% if(util.loginCheck()) {%>
			<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
			<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ) {%>
				<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
			<% } %>
		<% } %>
		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
		</div>
	</div> --%>
	<br/>
	<div id="rejectDisplayDiv" style="display:none; " class="skin_bbs_write">
		<table class="skin_basic_write 444">
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: *%;" />
				<col style="width: 5%;" />
			</colgroup>
			<tbody>
				<tr>
					<th>반려사유</th>
					<td><textarea rows="4" cols="100" id="rejectTxt" name="rejectTxt" class="inp_txt" style="width:100%; overflow: auto; resize:none;"></textarea></td>
					<td><button class="btn_inp_b_01" type="button" onclick="resveConsentGo('3')">반려확인</button></td>
				</tr>
			</tbody>
		</table>
	</div>


</div>

<script type="text/javascript">

$(document).on("keyup",".numberOnly",function(){
	if (!(event.keyCode >=37 && event.keyCode<=40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9;]/gi,''));
    }
});

$("input:text[numberOnlyDot]").on("keyup", function() {
    $(this).val($(this).val().replace(/^[^0-9]|[^0-9\\.]|[\.]+[^0-9]|[0-9].[0-9]+[\D]/g,""));
});

//공백제거
function checkSpace(id){
	var str = $('#'+id).val();
	if(str.search(/\s/) != -1){
		$('#'+id).val(str.trim());
		//$('#'+id).val(str.replace(/ /g, ""));
	}
	return $('#'+id).val();
}

//예약정보(수정, 삭제, 목록) 버튼
function pageListGo(){
	$('#mode').val('list');
	//$('#fview').find('input[name=reportType]').val();
	$('#fview').submit();
}
function pageDelGo(){
	var stateResult = "";
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> stateResult = "승인요청"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> stateResult = "이용승인"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> stateResult = "승인거절"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> stateResult = "이용완료"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> stateResult = "승인취소"; <% } %>
	if(confirm("'"+stateResult+"' 상태인 사용자입니다. 삭제하시겠습니까?")){
		$('#mode').val('del');
		$('#fview').submit();
	}
}
function pageEditGo(){
	$('#mode').val('edit');
	$('#fview').submit();
}
function resveConsentGo(orderState){
	var rejectTxt = document.getElementById('rejectTxt').value;

	if(orderState == '2'){ //이용승인
		if(confirm("예약 승인 하시겠습니까?")){
			$('#mode').val('stateEdit');
			document.fview.action = "./eqReservationProc.do"
			$('#orderState').val(orderState);
			//alert("승인 되었습니다.");
			$('#fview').submit();
		} else {
			return false;
		}
	}

	if(orderState == '3'){ //승인취소
		if(confirm("정말 승인거절 하시겠습니까?")){
			$('#mode').val('stateEdit');
			document.fview.action = "./eqReservationProc.do"
			$('#orderState').val(orderState);
			$('#reject').val(rejectTxt);
			alert("반려 되었습니다.");
			$('#fview').submit();
		} else {
			return false;
		}
	}

	if(orderState == '5'){ //승인취소
		if(confirm("정말 예약 승인 취소 하시겠습니까?")){
			$('#mode').val('stateEdit');
			document.fview.action = "./eqReservationProc.do"
			$('#orderState').val(orderState);
			//alert("승인 되었습니다.");
			$('#fview').submit();
		} else {
			return false;
		}
	}
}
function resveReturnGo(){
	var rejectTxt = document.getElementById('rejectTxt').value;
	if(confirm("정말 반려처리 하시겠습니까?")){
		$('#mode').val('stateEdit');
		document.fview.action = "./eqReservationProc.do"
		$('#orderState').val('3');
		$('#reject').val(rejectTxt);
		alert("반려 되었습니다.");
		$('#fview').submit();
	} else {
		return false;
	}

}


function popupWindow(mode, order){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
	var popUrl="/sys/eqReservation.do?mode="+mode+"&order="+order;
	var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"popup"+order,popOption);
}

function setPopup(obj, mode){
	$("#"+obj['order']+"fwrite").find('input[name=equUserOrg]').val(obj['org_grp_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserDept]').val(obj['dept_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserName]').val(obj['user_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserPosition]').val(obj['position_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserPhone]').val(obj['cp_no']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserEmail]').val(obj['email']);
}

function move(id) {
	var offset = $("#"+id).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
}

/* 출력 기능 */
function goPrint(rndEquIdx, userIdx, equOrderIdx){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
	var popUrl='/back/page/print_popup.jsp?rndEquIdx='+rndEquIdx+'&userIdx='+userIdx+'&equOrderIdx='+equOrderIdx;
	var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"print_popup",popOption);
};

function bytecheck(obj, maxByte){
	 var str = obj.value;
	 var str_len = str.length;

	 var rbyte = 0;
	 var rlen = 0;
	 var one_char = "";
	 var str2 = "";

	 for(var i=0; i<str_len; i++){
	 one_char = str.charAt(i);
	 if(escape(one_char).length > 4){
	     rbyte += 2;                                         //한글2Byte
	 }else{
	     rbyte++;                                            //영문 등 나머지 1Byte
	 }

	 if(rbyte <= maxByte){
	     rlen = i+1;                                          //return할 문자열 갯수
	 }
	 }

	 if(rbyte > maxByte){
	     alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	     str2 = str.substr(0,rlen);                                  //문자열 자르기
	     obj.value = str2;
	     bytecheck(obj, maxByte);
	 }else{
	     document.getElementById('byteInfo').innerText = rbyte;
	 }
};


$(document).ready(function() {
	$(function() {
	    $("input:text").keydown(function(evt) {
	        if (evt.keyCode == 13)
	            return false;
	    });
	});

	$("#diaryStartDate, #diaryEndDate, #innerStartDate, #innerEndDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		nextText : '다음 달',
		prevText : '이전 달',
		currentText : '오늘 날짜',
		closeText : '닫기',
		dateFormat : "yy-mm-dd",
		dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin : ['월','화','수','목','금','토','일'],
		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
		maxDate:'+0d'
	});

	$('#startTime').datepicker("option", "onClose", function ( selectedDate ) {
        $("#endTime").datepicker( "option", "minDate", selectedDate );
    });

	$('#endTime').datepicker("option", "onClose", function ( selectedDate ) {
        $("#startTime").datepicker( "option", "maxDate", selectedDate );
    });

	$("#diaryRentalFee, #legalRentalFee").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });
	<%if(util.getStr(paramMap.get("reportType")).equals("diary")) { %> $("#diaryWriteBtn").hide(); <% } %>
<%-- 	<%if(util.getStr(paramMap.get("reportType")).equals("inner")) { %> $("#innerWriteBtn").hide(); <% } %> --%>
	<%-- <%if(util.getStr(paramMap.get("reportType")).equals("legal")) { %> $("#legalWriteBtn").hide(); <% } %> --%>
});



</script>
