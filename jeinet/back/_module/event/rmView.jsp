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

			<h3>[??????????????????] <span style="float:right;">(<%=eventApplicantList.size()%>) ???</span></h3>


			<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
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
						<th scope="col">??????</th>
						<th scope="col">?????????</th>
						<th scope="col">??????</th>
						<th scope="col">??????</th>
						<th scope="col">??????</th>
						<th scope="col">????????????</th>
						<th scope="col">?????????</th>
						<th scope="col">????????????</th>
						<th scope="col">????????????</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont1 = 1;

						if(eventApplicantList.size() == 0){
					%>
						<tr><td colspan="9">???????????? ???????????? ????????????</td></tr>
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
							<input type="button" class="btn_inp_y_01" value="??????" onclick="goButton('reservation','applicant','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','??????')"/>
							<input type="button" class="btn_inp_y_01" value="??????" onclick="goButton('reservation','rreturn','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','??????')"/>
						</td>
					</tr>
					<% cont1 ++; } %>
				</tbody>
			</table>





			<h3>[??????????????????] <span style="float:right;">(<%=eventConsentList.size()%>) ???</span></h3>


			<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
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
						<th scope="col">??????</th>
						<th scope="col">?????????</th>
						<th scope="col">??????</th>
						<th scope="col">??????</th>
						<th scope="col">??????</th>
						<th scope="col">????????????</th>
						<th scope="col">?????????</th>
						<th scope="col">????????????</th>
						<th scope="col">??????????????????</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont2 = 1;

						if(eventConsentList.size() == 0){
					%>
						<tr><td colspan="9">???????????? ???????????? ????????????</td></tr>
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
						<input type="button" class="btn_inp_y_01" value="??????" onclick="goButton('reservation','rreturn','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','??????')"/>
						</td>
					</tr>
					<% cont2 ++; } %>
				</tbody>
			</table>

			<h3>[??????/????????????] <span style="float:right;">(<%=eventReturnList.size()%>) ???</span></h3>


			<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
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
						<th scope="col">??????</th>
						<th scope="col">??????</th>
						<th scope="col">?????????</th>
						<th scope="col">??????</th>
						<th scope="col">????????????</th>
						<th scope="col">?????????</th>
						<th scope="col">????????????</th>
						<th scope="col">??????/????????????</th>
						<th scope="col">????????????</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont3 = 1;

						if(eventReturnList.size() == 0){
					%>
						<tr><td colspan="9">???????????? ???????????? ????????????</td></tr>
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
							<%if(util.getStr(rs.get("RETURN_REASON")).length()>8){%><%=util.getStr(rs.get("RETURN_REASON")).substring(0, 8)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("RETURN_REASON"))%><%}%>
						</td>
						<td>
							<%=util.getStr(rs.get("UP_DT")) %>
						</td>
						<td>
							<input type="button" class="btn_inp_y_01" value="??????" onclick="goButton('reservation','delete','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','??????')"/>
						</td>
					</tr>
					<% cont3 ++; } %>
				</tbody>
			</table>


			<br /><br /><hr />
			 <!-- bo_btn  -->
			 <div class="btn_right_box" style="text-align: right; width: 980px;">
			 	<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
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

		if(listMode == 'applicant'){ //??????????????? ????????????

			/* ??????????????? ???????????? ???????????? ?????? */
			if( $('#reqPeople').val() >= $('#eventPeople').val()){
				alert("??????????????? ???????????? ??? ?????? ??????????????? ???????????????.");
				return false;
			}
		}

		if(listMode == 'rreturn'){ //??????????????? ????????????
			if($('#returnReason').val() == ""){
				alert("??????????????? ??????????????????");
				$('#returnReqIdx').val(eventReqIdx); //???????????? ??????????????? eventReqIdx??? ??????
				$('#returnReasonTr').show();
				$("#returnReason").focus();
				return false;
			}
		}

		if(confirm(""+text+" ???????????????????")) {

			$("#mode").val(mode);
			$('#listMode').val(listMode);

			if(listMode == 'confirm'){ //??????????????? '??????'????????? ????????????
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
					alert(text + "???????????????");
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
