<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> eventMap = request.getAttribute("eventMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("eventMap");
	HashMap<String, String> loginUserInfo = request.getAttribute("loginUserInfo") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("loginUserInfo");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> eventApplicantList = request.getAttribute("eventApplicantList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventApplicantList");
	ArrayList<HashMap<String, String>> eventConsentList = request.getAttribute("eventConsentList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventConsentList");
	ArrayList<HashMap<String, String>> eventReturnList = request.getAttribute("eventReturnList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventReturnList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String eventReqIdx = util.getStr(paramMap.get("eventReqIdx"));
	String authLv = util.getStr(loginUserInfo.get("AUTH_LV"));
	String userIdx = util.getStr(eventMap.get("REG_IDX"));

%>


<form name="fview" id="fview" action="<%=myPage%>" method="post">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
	<input type="hidden" name="eventReqIdx" id="eventReqIdx" value="<%=eventReqIdx%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />

			<h3>[참가신청목록] <span style="float:right;">(<%=eventApplicantList.size()%>) 건</span></h3>


			<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 15%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">회원명</th>
						<th scope="col">소속</th>
						<th scope="col">성별</th>
						<th scope="col">직위</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">신청일자</th>
						<th scope="col">승인처리</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont1 = 1;

						if(eventApplicantList.size() == 0){
					%>
						<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
					<%
						}

								for(HashMap rs:eventApplicantList) {
					%>
					<tr>
						<td><%=cont1%></td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("ORG_GRP_NM"))%><br />
							<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_GENDER_TYPE_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_POSITION"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_PHONE")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_EMAIL")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("REG_DT")) %>
						</td>
						<td>
							<input type="button" class="btn_inp_y_01" value="승인" onclick="goButton('reservation','applicant','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','승인')"/>
							<input type="button" class="btn_inp_y_01" value="반려" onclick="goButton('reservation','rreturn','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','반려')"/>
						</td>
					</tr>
					<% cont1 ++; } %>
				</tbody>
			</table>





			<h3>[참가승인목록] <span style="float:right;">(<%=eventConsentList.size()%>) 건</span></h3>


			<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 15%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">회원명</th>
						<th scope="col">소속</th>
						<th scope="col">성별</th>
						<th scope="col">직위</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">승인일자</th>
						<th scope="col">승인취소처리</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont2 = 1;

						if(eventConsentList.size() == 0){
					%>
						<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
					<%
						}

								for(HashMap rs:eventConsentList) {
					%>
					<tr>
						<td><%=cont2%></td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("ORG_GRP_NM"))%><br />
							<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_GENDER_TYPE_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_POSITION"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_PHONE")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_EMAIL")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("UP_DT")) %>
						</td>
						<td>
						<input type="button" class="btn_inp_y_01" value="반려" onclick="goButton('reservation','rreturn','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','반려')"/>
						</td>
					</tr>
					<% cont2 ++; } %>
				</tbody>
			</table>

			<h3>[취소/반려목록] <span style="float:right;">(<%=eventReturnList.size()%>) 건</span></h3>


			<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 12%;" />
					<col style="width: 12%;" />
					<col style="width: 16%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">상태</th>
						<th scope="col">회원명</th>
						<th scope="col">소속</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">반려사유</th>
						<th scope="col">반려/취소일자</th>
						<th scope="col">삭제처리</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont3 = 1;

						if(eventReturnList.size() == 0){
					%>
						<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
					<%
						}
							for(HashMap rs:eventReturnList) {
					%>
					<tr>
						<td><%=cont3%></td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_STATE_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("ORG_GRP_NM"))%><br />
							<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_PHONE")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_EMAIL")) %>
						</td>
						<td>
							<%if(util.getStr(rs.get("RETURN_REASON")).length()>8){%><%=util.getStr(rs.get("RETURN_REASON")).substring(0, 8)+" · · · "%><%}else{%><%=util.getStr(rs.get("RETURN_REASON"))%><%}%>
						</td>
						<td>
							<%=util.getStr(rs.get("UP_DT")) %>
						</td>
						<td>
							<input type="button" class="btn_inp_y_01" value="삭제" onclick="goButton('reservation','delete','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','삭제')"/>
						</td>
					</tr>
					<% cont3 ++; } %>
				</tbody>
			</table>


			<br /><br /><hr />
			 <!-- bo_btn  -->
			 <div class="btn_right_box" style="text-align: right; width: 980px;">
			 	<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
			 </div>
			<!--// bo_btn -->

	</div>


</form>


<script type="text/javascript">
	function goSubmit(mode,text){

		$('#mode').val(mode);
		$('#fview').submit();
	}

	function goButton(mode,listMode,eventReqIdx,text){

		//alert(mode+" "+listMode+" "+eventReqIdx+" "+text);

		if(listMode == 'applicant'){ //승인버튼을 클릭할때

			/* 신청인원이 가득차면 승인처리 제어 */
			if( $('#reqPeople').val() >= $('#eventPeople').val()){
				alert("참여인원이 모집되어 더 이상 승인처리가 불가합니다.");
				return false;
			}
		}

		if(listMode == 'rreturn'){ //반려버튼을 클릭할때
			if($('#returnReason').val() == ""){
				alert("반려사유를 입력해주세요");
				$('#returnReqIdx').val(eventReqIdx); //반려사유 확인버튼에 eventReqIdx값 보관
				$('#returnReasonTr').show();
				$("#returnReason").focus();
				return false;
			}
		}

		if(confirm(""+text+" 하시겠습니까?")) {

			$("#mode").val(mode);
			$('#listMode').val(listMode);

			if(listMode == 'confirm'){ //반려사유의 '확인'버튼을 클릭할때
				$('#eventReqIdx').val($('#returnReqIdx').val());
			}else{
				$('#eventReqIdx').val(eventReqIdx);
			}

			var formData = $("#fview").serialize();

			$.ajax({
				url:"/sys/reservation_event.do",
				data:formData,
				type:"POST",
				success:function() {
					alert(text + "되었습니다");
					window.location.reload();
				}
			});
			('#returnReason').val('');
			$('#returnReasonTr').hide();

		}else{
			('#returnReason').val('');
			$('#returnReasonTr').hide();
			return;
		}

	}

</script>
