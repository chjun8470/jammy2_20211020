<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataMap = request.getAttribute("dataMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "useStatus";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>
<style type="text/css">
	.layer {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10;}
		.layer .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
		.layer .pop-layer {display:block;}

	.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 50%;   background-color:#fff; border: 1px solid black; z-index: 5; padding: 10px;}
	.pop-layer .pop-container {padding: 20px 25px;}
	.pop-layer p.ctxt {color: #666; line-height: 25px;}
	.pop-layer .btn-r {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}

	a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}
	a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}


	.layer2 {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10;}
		.layer2 .bg2 {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
		.layer2 .pop-layer2 {display:block;}

	.pop-layer2 {display:none; position: absolute; top: 50%; left: 50%; width: 50%;   background-color:#fff; border: 1px solid black; z-index: 5; padding: 10px;}
	.pop-layer2 .pop-container2 {padding: 20px 25px;}
	.pop-layer2 p.ctxt2 {color: #666; line-height: 25px;}
	.pop-layer2 .btn-r2 {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}

	a.cbtn2 {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}
	a.cbtn2:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}

</style>

<script type="text/javascript">
$(document).ready(function() {
	$("#jointUseStDt, #jointUseEdDt").datepicker({
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
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	});

	$('#jointUseStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#jointUseEdDt").datepicker( "option", "minDate", selectedDate );
    });

	$('#jointUseEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#jointUseStDt").datepicker( "option", "maxDate", selectedDate );
    });

	$("#jointUseStDt, #jointUseEdDt").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
    });

	$('#jointYear').datepicker( {
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		dateFormat: 'yy',
		onClose: function(dateText, inst) {
			var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			$(this).datepicker( "option", "defaultDate", new Date(year, month, 1));
			$(this).datepicker('setDate', new Date(year, month, 1));
		}
	});

	$('#userPhone').change(function(){
		var value = $('#userPhone').val();
		var pattern = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		var match = pattern.exec(value);

		if(match == null){
			alert("전화번호 형식으로 입력해야 합니다.");
			$('#userPhone').val('').focus();
			return false;
		};
	});

	$("#userPhone").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
    });

	$("#useTime").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\.]/gi,''));
        }
    });

	$("#earnings").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });

	$("#sampleCount").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });

	$('#userEmail').change(function(){
		var value = $('#userEmail').val();
		var pattern = /^[_0-9a-zA-Z-.]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)$/;
		var match = pattern.exec(value);

		if(match == null){
			alert("email 형식으로 입력해야 합니다.");
			$('#userEmail').val('').focus();
			return false;
		};
	});

});
</script>

<div class="skin_list">
	<div class="tabBox_pub">
		<ul>
			<li <%if(util.getStr(paramMap.get("useState")).equals("1") || util.getStr(paramMap.get("useState")).equals("")) { %> class="on" <% } %> ><a href="#" onclick="useTab('1')">공동 리스트</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("2")) { %> class="on" <% } %> ><a href="#" onclick="useTab('2')">공동 등록</a></li>
		</ul>
	</div>
	<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage%>">
		<input type="hidden" name = "nowPage" id = "nowPage" />
		<input type="hidden" name = "mode" id = "mode" />
		<input type="hidden" name = "useState" id = "useState" />
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<label for="search_year">기간</label>
						<select name="useYear" id="useYear" class="select" >
							<option value="" >전체</option>
							<%
								int stYear = 2010;
								int nowYear = Calendar.getInstance().get(Calendar.YEAR);
								int edYear = nowYear + 3;
								String selected2="";
								for(int i=stYear ; i<=edYear ; i++){
							%>
							<option value="<%=i%>" <%if(util.getStr(paramMap.get("useYear")).equals(String.valueOf(i))) { %> selected="selected" <% } %>><%=i%></option>
							<%}%>
						</select>
					&nbsp;&nbsp;
					<label for="orgGrpNm">기관</label>
						<input type="text" class="inp_txt" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(paramMap.get("orgGrpNm")) %>" />
						<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm1" class="btn_inp_b_01" style="display: inline-block;" onclick="popupOrgWindow('orgList','2')" />
					&nbsp;&nbsp;
					<label for="searchType" >검색종류</label>
						<select name="searchType" id="searchType" class="select">
							<option value="">선택</option>
							<option value="data1" <%if(util.getStr(paramMap.get("searchType")).equals("data1")) { %> selected="selected" <% } %>>JEINET 장비등록번호</option>
							<option value="data2" <%if(util.getStr(paramMap.get("searchType")).equals("data2")) { %> selected="selected" <% } %>>공동활용기관</option>
							<option value="data3" <%if(util.getStr(paramMap.get("searchType")).equals("data3")) { %> selected="selected" <% } %>>장비명</option>
						</select>
					<label for="searchWord" class="hide">키워드</label>
						<input type="text" name="searchWord" id="searchWord" class="inp_txt" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
					&nbsp;&nbsp;
					<label for="stateType" >상태</label>
						<select name="stateType" id="stateType" class="select">
							<option value="">선택</option>
							<option value="1" <%if(util.getStr(paramMap.get("stateType")).equals("1")) { %> selected="selected" <% } %>>요청</option>
							<option value="2" <%if(util.getStr(paramMap.get("stateType")).equals("2")) { %> selected="selected" <% } %>>승인</option>
							<option value="3" <%if(util.getStr(paramMap.get("stateType")).equals("3")) { %> selected="selected" <% } %>>반려</option>
						</select>

					<!-- 검색버튼 -->
					<button type="button" class="btn_inp_g_01" onclick="pageSearchGo()" style="float: right;">검색</button>
				</div>
				<!-- board-search -->
			 </div>
		</div>
		<!-- bbs-top e -->
	</form>

	<div class="total" style="margin-top: 10px;">
		[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		<span style="float: right; margin-bottom: 5px;">
		<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="excelDown()">엑셀다운로드</button>
		</span>
	</div>
	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col width="8%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="12%" />
				<col width="12%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">공동활용년도</th>
					<th scope="col">장비<br/>(JEINET 등록번호)</th>
					<th scope="col">공동활용기관</th>
					<th scope="col">사용자</th>
					<th scope="col">공동활용 시작일</th>
					<th scope="col">공동활용 종료일</th>
					<th scope="col">등록상태</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataMap) {%>
				<tr>
					<td scope="col"><%=cont %></td>
					<td><%=util.getStr(rs.get("JOINT_YEAR"))%></td>
					<td scope="col" style="cursor: pointer;" onclick="statusView('<%=util.getStr(rs.get("USE_STATUS_IDX")) %>')">
						<%=util.getStr(rs.get("KOR_NM")) %><br/>
						<%=util.getStr(rs.get("JEINET_EQU_NO")) %><br/>
					</td>
					<td scope="col">
						<%=util.getStr(rs.get("JOINT_USE_INSTITUTION"))%><br/>
						<%if(util.getStr(rs.get("JOINT_USE_SECTION")).equals("02")) {
						 	out.println("외부기관/기업");
						 } else if(util.getStr(rs.get("JOINT_USE_SECTION")).equals("01")) {
						 	out.println("보유기관 소속 타부서");
						 } else if(util.getStr(rs.get("JOINT_USE_SECTION")).equals("03")) {
							out.println("보유기관 자체활용");
						 } %>
					</td>
					<td scope="col">
						<%=util.getStr(rs.get("USER_NAME"))%><br/>
						<%=util.getStr(rs.get("DEPARTMENT"))%><br/>
						<%=util.getStr(rs.get("USER_EMAIL"))%>
					</td>
					<td scope="col"><%=util.getStr(rs.get("JOINT_USE_ST_DT"))%></td>
					<td scope="col"><%=util.getStr(rs.get("JOINT_USE_ED_DT"))%></td>
					<td scope="col">
						<%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="승인" src="/img/back/comm/edu_state_img_07.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> <% } %>

					</td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<%=util.getPaging(staticVO, nowPage) %>
		<div align="right">
			<button type="button" class="btn_inp_b_01" onclick="goWrite()" >등록</button>
		</div>
	</div>
</div>

<div class="layer2">
	<div class="bg2"></div>
	<div id="viewLayer" class="pop-layer2">
	<input type="hidden" name="viewStatusIdx"	id="viewStatusIdx" />
		<h3>시설장비공동활용실적</h3>
		<table class="skin_basic_write">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">JEINET 장비등록번호</th>
					<td scope="col" id="viewJeinetNo"></td>
					<th scope="col">NTIS 장비등록번호</th>
					<td scope="col" id="viewNtisNo"></td>
				</tr>
				<tr>
					<th scope="col">공동활용대상구분</th>
					<td scope="col" id="viewUseSection"></td>
					<th scope="col">기관명</th>
					<td scope="col" id="viewOrgNm"></td>
				</tr>
				<tr>
					<th scope="col">공동활용년도</th>
					<td scope="col" id="viewJointYear"></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th scope="col">공동활용기관명</th>
					<td scope="col" id="viewUseInstitution"></td>
					<th scope="col">부서명</th>
					<td scope="col" id="viewDepartment"></td>
				</tr>
				<tr>
					<th scope="col">공동활용 시작일</th>
					<td scope="col" id="viewUseStDt"></td>
					<th scope="col">공동활용 종료일</th>
					<td scope="col" id="viewUseEdDt"></td>
				</tr>
				<tr>
					<th scope="col">사용자 성명</th>
					<td scope="col" id="viewUserName"></td>
					<th scope="col">사용자 이메일</th>
					<td scope="col" id="viewUserEmail"></td>
				</tr>
				<tr>
					<th scope="col">사용자 전화번호</th>
					<td scope="col" id="viewUserPhone"></td>
					<th scope="col">사용시간</th>
					<td scope="col" id="viewUseTime"></td>
				</tr>
				<tr>
					<th scope="col">수익금</th>
					<td scope="col" id="viewEarnings"></td>
					<th scope="col">시료수/지원건수</th>
					<td scope="col" id="viewSampleCount"></td>
				</tr>
				<tr>
					<th scope="col">상태</th>
					<td scope="col" id="viewState"></td>
					<th scope="col" id="rejectCell"></th>
					<td scope="col" id="viewReject"></td>
				</tr>
			</tbody>
		</table>

		<button type="button" class="btn_inp_w_01" id="vcbtn" style="float: right">닫기</button>
		<button type="button" class="btn_inp_b_01" id="dbtn" style="float: right" onclick="delProc()">삭제</button>
		<button type="button" class="btn_inp_b_01" style="float: right;" onclick="statusEdit()">수정</button>
	<%if(util.getStr(loginVO.getAuthLv()).equals("99")) { %>
		<div align="left">
			<button type="button" class="btn_inp_b_01" id="btnAdmission"  onclick="stateAdmission('2')">승인</button>
			<button type="button" class="btn_inp_b_01" id="btnReject" onclick="showRejectArea()">반려</button>
		</div>
		<div id="rejectArea" style="display:none;">
			<label for="reject">반려사유</label>
			<input type="text" class="inp_text" name="reject" id="reject">
			<button type="button" class="btn_inp_b_01" id="rejectInput" onclick="stateReject('3')">반려입력</button>
			<button type="button" class="btn_inp_b_01" id="rejectCancle" onclick="hideRejectArea()">취소</button>
		</div>
	<% } %>
	</div>
</div>

<div class="layer">
	<div class="bg"></div>
	<div id="layer2" class="pop-layer">
	<form name="statusForm" id="statusForm" method="post" action="">
		<input type="hidden" name="useStatusIdx"	id="useStatusIdx" />
		<h3>시설장비공동활용실적 수정</h3>
		<table class="skin_basic_write">
			<colgroup>
				<col width="22%">
				<col width="30%">
				<col width="23%">
				<col width="25%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col"><label for="jeinetEquNo">JEINET 장비등록번호</label></th>
					<td scope="col"><input type="text" name="jeinetEquNo" id="jeinetEquNo" class="inp_text"/>&nbsp;<button class="btn_inp_w_01" type="button" onclick="popupWindow()">검색</button></td>
					<th scope="col"><label for="ntisEquNo">NTIS 장비등록번호</label></th>
					<td scope="col"><input type="text" name="ntisEquNo" id="ntisEquNo" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col"><label for="jointUseSection">공동활용대상구분</label></th>
					<td scope="col">
						<select name="jointUseSection" id="jointUseSection" class="inp_text">
							<option value="01">보유기관 소속 타부서</option>
							<option value="02">외부기관/기업</option>
							<option value="03">보유기관 자체활용</option>
						</select>
					</td>
					<th scope="col"><label for="orgNm">기관명</label></th>
					<td scope="col"><input type="text" class="inp_txt" name="orgNm" id="orgNm" disabled style="background-color:#fdfdfd">
					<input type="button" name="orgNm1" value="기관검색" id="orgNm1" class="btn_inp_b_01" style="display: inline-block;" onclick="OrgWindow('orgList','2')"></td>
				</tr>
				<tr>
					<th scope="col"><label for="jointYear">공동활용 년도</label></th>
					<td><select name="jointYear" id="jointYear" class="select" >
					<option value="" selected="selected">선택</option>
					<%
						int nowJointYear = Calendar.getInstance().get(Calendar.YEAR);
						int stJointYear = 2010;
						int edJointYear = nowJointYear+3;
						String selectedYear = "";

						for(int i= stJointYear ; i <= edJointYear ; i++){
							if(i == nowJointYear) selectedYear = "selected";
							else selectedYear = "";
					%>
						<option value="<%=i%>" <%=selectedYear%>><%=i%></option>

					<%}%>
					</select></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th scope="col"><label for="jointUseInstitution">공동활용기관명</label></th>
					<td scope="col"><input type="text" name="jointUseInstitution" id="jointUseInstitution" class="inp_text" /></td>
					<th scope="col"><label for="department">부서명</label></th>
					<td scope="col"><input type="text" name="department" id="department" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col"><label for="jointUseStDt">공동활용 시작일</label></th>
					<td scope="col"><input type="text" name="jointUseStDt" id="jointUseStDt" class="inp_text"/></td>
					<th scope="col"><label for="jointUseEdDt">공동활용 종료일</label></th>
					<td scope="col"><input type="text" name="jointUseEdDt" id="jointUseEdDt" class="inp_text"/> </td>
				</tr>
				<tr>
					<th scope="col"><label for="userName">사용자 성명</label></th>
					<td scope="col"><input type="text" name="userName" id="userName" class="inp_text"/></td>
					<th scope="col"><label for="userEmail">사용자 이메일</label></th>
					<td scope="col"><input type="text" name="userEmail" id="userEmail" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col"><label for="userPhone">사용자 전화번호</label></th>
					<td scope="col"><input type="text" name="userPhone" id="userPhone" class="inp_text" /></td>
					<th scope="col"><label for="useTime">사용시간</label></th>
					<td scope="col"><input type="text" name="useTime" id="useTime" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col"><label for="earnings">수익금</label></th>
					<td scope="col"><input type="text" name="earnings" id="earnings" class="inp_text" /></td>
					<th scope="col"><label for="sampleCount">시료수/지원건수</label></th>
					<td scope="col"><input type="text" name="sampleCount" id="sampleCount" class="inp_text" /></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn_inp_w_01" id="cbtn" style="float: right">닫기</button>
		<button type="button" class="btn_inp_b_01" id="pbtn" style="float: right" onclick="editProc()">수정</button>
	</form>
	</div>
</div>

<script type="text/javascript">
	function excelDown(){
 		var stateType	= $("#stateType option:selected").val();
 		var orgGrpNm    = $("#orgGrpNm").val();
 		var useYear     = $("#useYear").val();
 		var searchType  = $("#searchType").val();
 		var searchWord  = $("#searchWord").val();

 		location.href='/sys/useEquipStatusExcel.do?stateType='+stateType+'&orgGrpNm='+orgGrpNm+'&useYear='+useYear+'&searchType='+searchType+'&searchWord='+searchWord;
 	}

	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function excelForm() {
		$("#mode").val("excel");
		$("#searchForm").submit();
	}
	function statusView(idx) {
		$.ajax({
			url : "/sys/useStatus.do",
			type : "POST",
			data : {"mode" : "view", "useStatusIdx" : idx},
			success : function(data) {
				$("#viewStatusIdx").val(idx);
				$("#viewOrgNm").text(data.dataMap.ORG_GRP_NM);
				$("#viewJointYear").text(data.dataMap.JOINT_YEAR);
				$("#viewJeinetNo").text(data.dataMap.JEINET_EQU_NO);
				$("#viewNtisNo").text(data.dataMap.NTIS_EQU_NO);
				$("#viewUseSection").text(data.dataMap.JOINT_USE_SECTION);
				$("#viewUseInstitution").text(data.dataMap.JOINT_USE_INSTITUTION);
				$("#viewDepartment").text(data.dataMap.DEPARTMENT);
				$("#viewUseStDt").text(data.dataMap.JOINT_USE_ST_DT);
				$("#viewUseEdDt").text(data.dataMap.JOINT_USE_ED_DT);
				$("#viewUserName").text(data.dataMap.USER_NAME);
				$("#viewUserEmail").text(data.dataMap.USER_EMAIL);
				$("#viewUserPhone").text(data.dataMap.USER_PHONE);
				$("#viewUseTime").text(data.dataMap.USE_TIME);
				$("#viewEarnings").text(data.dataMap.EARNINGS);
				$("#viewSampleCount").text(data.dataMap.SAMPLE_COUNT);
				if(data.dataMap.STATE != '1') {
					$("#btnAdmission").hide();
					$("#btnReject").hide();
				}
				if(data.dataMap.STATE == '1') {
					$("#btnAdmission").show();
					$("#btnReject").show();
					$("#viewState").text("승인요청");
					$("#rejectCell").text("");
					$("#viewReject").text("");
				}
				if(data.dataMap.STATE == '2') {
					$("#viewState").text("승인");
					$("#rejectCell").text("");
					$("#viewReject").text("");
				}
				if(data.dataMap.STATE == '3') {
					$("#viewState").text("반려");
					$("#rejectCell").text("반려사유");
					$("#viewReject").text(data.dataMap.REJECT);
				}


				var temp = $("#viewLayer");
				var bg = temp.prev().hasClass('bg2');	//dimmed 레이어를 감지하기 위한 boolean 변수

				if(bg){
					$('.layer2').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다.
				}else{
					temp.fadeIn();
				}

				// 화면의 중앙에 레이어를 띄운다.
				if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
				else temp.css('top', '0px');
				if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
				else temp.css('left', '0px');

				temp.find('#vcbtn').click(function(e){
					if(bg){
						$('.layer2').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다.
						$("#reject").val("");
						$("#rejectArea").hide();
					}else{
						temp.fadeOut();
					}
					e.preventDefault();
				});

				$('.layer2 .bg2').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
					$('.layer2').fadeOut();
					$("#reject").val("");
					$("#rejectArea").hide();
					e.preventDefault();
				});


				}
		});
	}
	function goWrite() {
		$("#statusForm").each(function() {
			this.reset();
		});
		$("#statusForm > h3").text("시설장비공동활용실적 등록");
		$("#pbtn").attr("onclick", "writeProc()").text("등록");
		$("#dbtn").hide();

		var temp = $("#layer2");
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

		if(bg){
			$('.layer').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다.
		}else{
			temp.fadeIn();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');

		temp.find('#cbtn').click(function(e){
			if(bg){
				$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다.
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});

		$('.layer .bg').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
			$('.layer').fadeOut();
			e.preventDefault();
		});
	}
	function stateAdmission(value) {
		var idx = $("#viewStatusIdx").val();
		var reject = $("#reject").val("");
		if(confirm('승인하시겠습니까?')) {
			$.ajax({
				url : "/sys/useStatus.do",
				type : "POST",
				data : {"mode" : "state", "idx" : idx, "state" : value},
				success : function() {
					alert("승인되었습니다.");
					location.reload();
				},
				error : function() {
					alert("문제가 발생했습니다.");
				}
			});
		}
	}

	function showRejectArea() {
		$("#rejectArea").show();
	}

	function hideRejectArea() {
		$("#reject").val("");
		$("#rejectArea").hide();
	}

	function stateReject(value) {
		var idx = $("#viewStatusIdx").val();
		var reject = $("#reject").val();
		if(confirm('반려하시겠습니까?')) {
			$.ajax({
				url : "/sys/useStatus.do",
				type : "POST",
				data : {"mode" : "state", "idx" : idx, "state" : value, "reject" : reject},
				success : function() {
					alert("반려되었습니다.");
					location.reload();
				},
				error : function() {
					alert("문제가 발생했습니다.");
				}
			});
		}
	}
	function statusEdit() {
		var value = $("#viewStatusIdx").val();
		$.ajax({
			url : "/sys/useStatus.do",
			data : {"mode" : "edit", "useStatusIdx" : value},
			success : function(data) {
				$("#statusForm > h3").text("시설장비공동활용실적 수정");
				$("#pbtn").attr("onclick", "editProc()").text("수정");
				$("#dbtn").show();

				$("#useStatusIdx").val(value);
				$("#orgNm").val(data.dataMap.ORG_GRP_NM);
				$("#jointYear").val(data.dataMap.JOINT_YEAR);
				$("#jeinetEquNo").val(data.dataMap.JEINET_EQU_NO);
				$("#ntisEquNo").val(data.dataMap.NTIS_EQU_NO);
				$("#jointUseSection").val(data.dataMap.JOINT_USE_SECTION).attr("selcted", "selected");
				$("#jointUseInstitution").val(data.dataMap.JOINT_USE_INSTITUTION);
				$("#department").val(data.dataMap.DEPARTMENT);
				$("#jointUseStDt").val(data.dataMap.JOINT_USE_ST_DT);
				$("#jointUseEdDt").val(data.dataMap.JOINT_USE_ED_DT);
				$("#userName").val(data.dataMap.USER_NAME);
				$("#userEmail").val(data.dataMap.USER_EMAIL);
				$("#userPhone").val(data.dataMap.USER_PHONE);
				$("#useTime").val(data.dataMap.USE_TIME);
				$("#earnings").val(data.dataMap.EARNINGS);
				$("#sampleCount").val(data.dataMap.SAMPLE_COUNT);


				var temp = $("#layer2");
				var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

				if(bg){
					$('.layer').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다.
				}else{
					temp.fadeIn();
				}

				// 화면의 중앙에 레이어를 띄운다.
				if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
				else temp.css('top', '0px');
				if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
				else temp.css('left', '0px');

				temp.find('#cbtn').click(function(e){
					if(bg){
						$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다.
					}else{
						temp.fadeOut();
					}
					e.preventDefault();
				});

				$('.layer .bg').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
					$('.layer').fadeOut();
					e.preventDefault();
				});


			}
		});
	}
	function editProc() {
		if(confirm("수정하시겠습니까?")) {
			if($("#jeinetEquNo").val() == "") {
				alert("JEINET 장비등륵번호를 입력해 주세요.");
				$("#jeinetEquNo").focus();
			} else if($("#jointUseInstitution").val() == "") {
				alert("공동활용기관명을 입력해 주세요");
				$("#jointUseInstitution").focus();
			} else if($("#jointUseStDt").val() == "") {
				alert("공동활용 시작일을 입력해 주세요.");
				$("#jointUseStDt").focus();
			} else if($("#jointUseEdDt").val() == "") {
				alert("공동활용 종료일을 입력해 주세요.");
				$("#jointUseEdDt").focus();
			} else if($("#userName").val() == "") {
				alert("사용자 이름을 입력해 주세요");
				$("#userName").focus();
			} else if($("#useTime").val() == "") {
				alert("사용시간을 입력해 주세요");
				$("#useTime").focus();
			} else if($("#earnings").val() == "") {
				alert("수익금을 입력해 주세요.");
				$("#earnings").focus();
			} else if($("#sampleCount").val() == "") {
				alert("시료수/지원건수를 입력해 주세요.");
				$("#sampleCount").focus();
			} else {
				var formData = $("#statusForm").serialize();
				$.ajax({
					url : "/sys/useStatusProc.do?mode=edit",
					type : "POST",
					data : formData,
					success : function(){
						alert("수정 되었습니다.");
						location.reload();
					},
					error : function() {
						alert("문제가 발생했습니다.");
					}
				});
			}
		}
	}

	function delProc() {
		if(confirm("삭제하시겠습니까?")) {
			var idx = $("#viewStatusIdx").val();
			$.ajax({
				url : "/sys/useStatusProc.do?mode=del",
				type : "POST",
				data : {"useStatusIdx" : idx},
				success : function() {
					alert("삭제 되었습니다.");
					location.reload();
				},
				error : function() {
					alert("문제가 발생했습니다.");
				}
			})
		}
	}

	function writeProc() {
		if(confirm("등록하시겠습니까?")) {
			if($("#jeinetEquNo").val() == "") {
				alert("JEINET 장비등륵번호를 입력해 주세요.");
				$("#jeinetEquNo").focus();
			} else if($("#jointUseInstitution").val() == "") {
				alert("공동활용기관명을 입력해 주세요");
				$("#jointUseInstitution").focus();
			} else if($("#jointUseStDt").val() == "") {
				alert("공동활용 시작일을 입력해 주세요.");
				$("#jointUseStDt").focus();
			} else if($("#jointUseEdDt").val() == "") {
				alert("공동활용 종료일을 입력해 주세요.");
				$("#jointUseEdDt").focus();
			} else if($("#userName").val() == "") {
				alert("사용자 이름을 입력해 주세요");
				$("#userName").focus();
			} else if($("#useTime").val() == "") {
				alert("사용시간을 입력해 주세요");
				$("#useTime").focus();
			} else if($("#earnings").val() == "") {
				alert("수익금을 입력해 주세요.");
				$("#earnings").focus();
			} else if($("#sampleCount").val() == "") {
				alert("시료수/지원건수를 입력해 주세요.");
				$("#sampleCount").focus();
			} else {
				var formData = $("#statusForm").serialize();
				$.ajax({
					url : "/sys/useStatusProc.do?mode=write",
					type : "POST",
					data : formData,
					success : function() {
						alert("등록 되었습니다.");
						location.reload();
					},
					error : function() {
						alert("문제가 발생했습니다");
					}
				})
			}
		}
	}

	function popupWindow(){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/useEquipStatus.do?mode=equPop";
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);
	}

	function setPopup(obj){
		$("#jeinetEquNo").val(obj['equ_idx']);
		$("#ntisEquNo").val(obj['ntis_no']);
	}

 	//기관검색 팝업
	function popupOrgWindow(listMode,userTp){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		if(listMode == 'orgList'){
			var popUrl="/sys/popup/"+listMode+".do?userTp="+userTp;
		}else if(listMode == 'orgSubList'){
			var popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('#orgGrpCd').val();
		}
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	//기관정보
	function orgInfo(orgGrpCd, cnt){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),
		function(data){
			if(cnt != 'cnt'){$("#deptNm").val("");$("#positionNm").val("");}
			orgGrpNm = data.dataMap.ORG_GRP_NM;
			$("#orgGrpNm").val(orgGrpNm);
			if($("input[type=radio][name='userTp']:checked").val() == '2'){
	    		$('#blngOrgNm').show();
	    		$("#deptNm").removeAttr("readonly");
			}else if($("input[type=radio][name='userTp']:checked").val() == '3'){
	    		$('#deptTh').show();
	    		$('#deptTd').show();
	    	}
		});
	}

	function useTab(useState){
		$('#mode').val('');
		$('#useState').val(useState);
		$('#searchForm').submit();
	}

</script>

