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

	String fileGrp = "jipUseStatus";
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
	$("#transferStDt, #transferEdDt, #transferDate").datepicker({
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

	$('#transferStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#transferEdDt").datepicker( "option", "minDate", selectedDate );
    });

	$('#transferEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#transferStDt").datepicker( "option", "maxDate", selectedDate );
    });

	$("#transferDate, #transferStDt, #transferEdDt").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
    });

	$("#transferPhone1, #transferPhone2").keyup(function(event) {
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
	});

	$("#flatSumSkillFee").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });
});
</script>

<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage%>">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<label for="stateType" class="hide">상태</label>
							<select name="stateType" id="stateType" class="select" style="height: 24px;">
								<option value="">상태</option>
								<option value="1" <%if(util.getStr(paramMap.get("stateType")).equals("1")) { %> selected="selected" <% } %>>요청</option>
								<option value="2" <%if(util.getStr(paramMap.get("stateType")).equals("2")) { %> selected="selected" <% } %>>승인</option>
								<option value="3" <%if(util.getStr(paramMap.get("stateType")).equals("3")) { %> selected="selected" <% } %>>반려</option>
							</select>

							<label for="seType">권리구분</label>
							<select name="seType" id="seType" class="select" style="height: 24px;">
								<option value="">전체</option>
								<option value="1" <%if(util.getStr(paramMap.get("seType")).equals("1")) { %> selected="selected" <% } %>>특허</option>
								<option value="2" <%if(util.getStr(paramMap.get("seType")).equals("2")) { %> selected="selected" <% } %>>실용신안</option>
								<option value="3" <%if(util.getStr(paramMap.get("seType")).equals("3")) { %> selected="selected" <% } %>>디자인</option>
								<option value="4" <%if(util.getStr(paramMap.get("seType")).equals("4")) { %> selected="selected" <% } %>>상표</option>
								<option value="5" <%if(util.getStr(paramMap.get("seType")).equals("5")) { %> selected="selected" <% } %>>프로그램</option>
								<option value="6" <%if(util.getStr(paramMap.get("seType")).equals("6")) { %> selected="selected" <% } %>>노하우</option>
							</select>

							<label for="tfSe">이전구분</label>
							<select name="tfSe" id="tfSe" class="select" style="height: 24px">
								<option value="">전체</option>
								<option value="01" <%if(util.getStr(paramMap.get("tfSe")).equals("01")) { %> selected="selected" <% } %>>양도</option>
								<option value="02" <%if(util.getStr(paramMap.get("tfSe")).equals("02")) { %> selected="selected" <% } %>>전용실시</option>
								<option value="03" <%if(util.getStr(paramMap.get("tfSe")).equals("03")) { %> selected="selected" <% } %>>독점적 통상실시</option>
								<option value="04" <%if(util.getStr(paramMap.get("tfSe")).equals("04")) { %> selected="selected" <% } %>>통상실시</option>
								<option value="05" <%if(util.getStr(paramMap.get("tfSe")).equals("05")) { %> selected="selected" <% } %>>노하우이전</option>
								<option value="06" <%if(util.getStr(paramMap.get("tfSe")).equals("06")) { %> selected="selected" <% } %>>기타</option>
							</select>&nbsp;

							<label for="searchType" class="hide">검색구분</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px;">
								<option value="">선택</option>
								<option value="name" <%if(util.getStr(paramMap.get("searchType")).equals("name")) { %> selected="selected" <% } %>>지식재산명</option>
								<option value="code" <%if(util.getStr(paramMap.get("searchType")).equals("code")) { %> selected="selected" <% } %>>등록정보</option>
							</select>
							<!-- 키워드 -->
							 <label for="searchWord" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
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
				<button type="button" id="excelUp" onclick="excelForm()" class="btn_inp_b_01">엑셀업로드</button>
				<button type="button" class="btn_inp_b_01" onclick="location.href='/sys/jipUseStatusExcel.do'">엑셀 다운로드</button>
				</span>
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col width="10%" />
				<col width="10%" />
				<col width="30%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">권리구분</th>
					<th scope="col">지식재산명(등록정보)</th>
					<th scope="col">이전구분</th>
					<th scope="col">보유기관명</th>
					<th scope="col">실시권자<br/>(양수자)</th>
					<th scope="col">실시기간</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataMap) {%>
				<tr>
					<td scope="col"><%=util.getStr(rs.get("JIP_USE_IDX")) %></td>
					<td scope="col">
						<%if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("1")) {
						 out.println("특허");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("2")) {
						 out.println("실용신안");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("3")) {
						 out.println("디자인");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("4")) {
						 out.println("상표");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("5")) {
						 out.println("프로그램");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("6")) {
						 out.println("노하우");
						} %>
					</td>
					<td scope="col" style="cursor: pointer;" onclick="statusView('<%=util.getStr(rs.get("JIP_USE_IDX")) %>')">
						<%if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("1")) {
							out.println(util.getStr(rs.get("INVENTION_KOR_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("2")) {
							out.println(util.getStr(rs.get("INVENTION_KOR_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("3")) {
							out.println(util.getStr(rs.get("D_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("4")) {
							out.println(util.getStr(rs.get("B_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("5")) {
							out.println(util.getStr(rs.get("P_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("6")) {
							out.println(util.getStr(rs.get("TCHNLGY_NM")));
						} %>
						<%="(" + util.getStr(rs.get("REGIST_INFO")) + ")" %>
					</td>
					<td scope="col">
						<%if(util.getStr(rs.get("TRANSFER_SECTION")).equals("01")) {
							out.println("양도");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("02")) {
							out.println("전용실시");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("03")) {
							out.println("독점적 통상실시");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("04")) {
							out.println("통상실시");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("05")) {
							out.println("노하우 이전");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("06")) {
							out.println("기타");
						}
						%>
					</td>
					<td scope="col">
						<%=util.getStr(rs.get("ORG_GRP_NM")) %>
					</td>
					<td scope="col"><%=util.getStr(rs.get("TRANSFER_PERSON"))%></td>
					<td scope="col">
						<%if(util.getStr(rs.get("ETERNITY_YN")).equals("Y")) { %>
							영구
						<% } else { %>
							<%=util.getStr(rs.get("TRANSFER_ST_DT")) %><br/>
							<%=util.getStr(rs.get("TRANSFER_ED_DT")) %>
						<% } %>
					</td>
					<td>
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
		<div align="right">
			<button type="button" class="btn_inp_b_01" onclick="goWrite()" >등록</button>
		</div>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<div class="layer2">
	<div class="bg2"></div>
	<div id="viewLayer" class="pop-layer2">
	<input type="hidden" name="viewStatusIdx"	id="viewStatusIdx" />
		<h3>지식재산 이전 실적</h3>
		<table class="skin_basic_write" id="viewStatus">
			<colgroup>
				<col width="22%">
				<col width="25%">
				<col width="23%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" colspan="4">지식재산정보</th>
				</tr>
				<tr>
					<th scope="col">권리구분</th>
					<td scope="col" id="viewRightSection"></td>
					<th scope="col">등록정보</th>
					<td scope="col" id="viewRegistInfo"></td>
				</tr>
				<tr>
					<th scope="col">지식재산명</th>
					<td colspan="3" id="viewName"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">이전정보</th>
				</tr>
				<tr>
					<th scope="col">이전구분</th>
					<td scope="col" id="viewTransferSection"></td>
					<th scope="col">이전일</th>
					<td scope="col" id="viewTransferDate"></td>
				</tr>
				<tr>
					<th scope="col">보유기관</th>
					<td scope="col" id="viewPossessOrg"></td>
					<th scope="col">중개기관</th>
					<td scope="col" id="viewBInstitution"></td>
				</tr>
				<tr>
					<th scope="col">정액기술료(원)</th>
					<td scope="col" id="viewFlaSumSkillFee"></td>
					<th scope="col">경상기술료</th>
					<td scope="col" id="viewOrdinarySkillFee"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">실시기간</th>
				</tr>
				<tr id="eternityLine">
					<td colspan="4" id="eternity"></td>
				</tr>
				<tr id="viewTransferTerm">
					<th scope="col">시작일</th>
					<td scope="col" id="viewTransferStDt"></td>
					<th scope="col">종료일</th>
					<td scope="col" id="viewTransferEdDt"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">실시권자</th>
				</tr>
				<tr>
					<th scope="col">양수자(기업명)</th>
					<td scope="col" id="viewTransferPerson"></td>
					<th scope="col">대표자</th>
					<td scope="col" id="viewTransferDelegate"></td>
				</tr>
				<tr>
					<th scope="col">담당자/직위</th>
					<td scope="col" id="viewTransferPosition"></td>
					<th scope="col">전화번호</th>
					<td scope="col" id="viewTransferPhone1"></td>
				</tr>
				<tr>
					<th scope="col">휴대전화</th>
					<td scope="col" id="viewTransferPhone2"></td>
					<th scope="col">이메일</th>
					<td scope="col" id="viewTransferEmail"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">비고</th>
				</tr>
				<tr>
					<td colspan="4" id="viewNote"></td>
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
		<button type="button" class="btn_inp_b_01" style="float: right" onclick="statusEdit()">수정</button>
	<%if(util.getStr(loginVO.getAuthLv()).equals("99")) { %>
		<div align="left">
			<button type="button" class="btn_inp_b_01" id="btnAdmission" onclick="stateAdmission('2')">승인</button>
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
	<form name="editStatus" id="editStatus" method="post" action="">
		<input type="hidden" name="jipUseIdx" id="jipUseIdx" />
		<h3>지식재산 이전현황 수정</h3>
		<table class="skin_basic_write" id="editViewStatus">
			<colgroup>
				<col width="22%">
				<col width="25%">
				<col width="23%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" colspan="4">지식재산정보</th>
				</tr>
				<tr>
					<th scope="col"><label for="rightSection">권리구분</label></th>
					<td scope="col">
						<select name="rightSection" id="rightSection" class="inp_text">
							<option value="1">특허</option>
							<option value="2">실용신안</option>
							<option value="3">디자인</option>
							<option value="4">상표</option>
							<option value="5">프로그램</option>
							<option value="6">노하우</option>
						</select>
					</td>
					<th scope="col"><label for="registInfo">등록정보</label></th>
					<td scope="col"><input type="text" name="registInfo" id="registInfo" class="inp_text"/>&nbsp;<button class="btn_inp_w_01" type="button" onclick="popupWindow()">검색</button></td>
				</tr>
				<tr>
					<th scope="col">지식재산명</th>
					<td colspan="3" id="name"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">이전정보</th>
				</tr>
				<tr>
					<th scope="col"><label for="transferSection">이전구분</label></th>
					<td scope="col">
						<select name="transferSection" id="transferSection" class="inp_text">
							<option value="01">양도</option>
							<option value="02">전용실시</option>
							<option value="03">독점적 통상실시</option>
							<option value="04">통상실시</option>
							<option value="05">노하우이전</option>
							<option value="06">기타</option>
						</select>
					</td>
					<th scope="col"><label for="transferDate">이전일</label></th>
					<td scope="col"><input type="text" name="transferDate" id="transferDate" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col">보유기관</th>
					<td scope="col" id="possessOrg"></td>
					<th scope="col"><label for="brokerageInstitution">중개기관</label></th>
					<td scope="col"><input type="text" name="brokerageInstitution" id="brokerageInstitution" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col"><label for="flatSumSkillFee">정액기술료(원)</label></th>
					<td scope="col"><input type="text" name="flatSumSkillFee" id="flatSumSkillFee" class="inp_text"/></td>
					<th scope="col"><label for="ordinarySkillFee">경상기술료</label></th>
					<td scope="col"><input type="text" name="ordinarySkillFee" id="ordinarySkillFee" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">실시기간 <input type="checkbox" name="eternityYN" id="eternityYN" value="N" /><label for="eternityYN">영구</label></th>
				</tr>
				<tr id="transferTerm">
					<th scope="col"><label for="transferStDt">시작일</label></th>
					<td scope="col"><input type="text" name="transferStDt" id="transferStDt" class="inp_text"/></td>
					<th scope="col"><label for="transferEdDt">종료일</label></th>
					<td scope="col"><input type="text" name="transferEdDt" id="transferEdDt" class="inp_text"/> </td>
				</tr>
				<tr>
					<th scope="col" colspan="4">실시권자</th>
				</tr>
				<tr>
					<th scope="col"><label for="transferPerson">양수자(기업명)</label></th>
					<td scope="col"><input type="text" name="transferPerson" id="transferPerson" class="inp_text"/></td>
					<th scope="col"><label for="transferDelegate">대표자</label></th>
					<td scope="col"><input type="text" name="transferDelegate" id="transferDelegate" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="col"><label for="transferPosition">담당자/직위</label></th>
					<td scope="col"><input type="text" name="transferPosition" id="transferPosition" class="inp_text" /></td>
					<th scope="col"><label for="transferPhone1">전화번호</label></th>
					<td scope="col"><input type="text" name="transferPhone1" id="transferPhone1" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="col"><label for="transferPhone2">휴대전화</label></th>
					<td scope="col"><input type="text" name="transferPhone2" id="transferPhone2" class="inp_text" /></td>
					<th scope="col"><label for="transferEmail">이메일</label></th>
					<td scope="col"><input type="text" name="transferEmail" id="transferEmail" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="col" colspan="4"><label for="note">비고</label></th>
				</tr>
				<tr>
					<td colspan="4"><textarea name="note" id="note" rows="" cols="" style="width: 100%;"></textarea></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn_inp_w_01" id="cbtn" style="float: right">닫기</button>
		<button type="button" class="btn_inp_b_01" id="pbtn" style="float: right" onclick="editProc()">수정</button>
	</form>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#jipUseStatusIdx').val(idx);
		$('#searchForm').submit();
	}
	function excelForm() {
		$("#mode").val("excel");
		$("#searchForm").submit();
	}

	function statusView(idx) {
		$("#viewStatus td").text("");
		$.ajax({
			url : "/sys/jipUseStatus.do",
			type : "POST",
			data : {"mode" : "view", "jipUseIdx" : idx},
			success : function(data) {
				$("#viewStatusIdx").val(idx);
				if(data.dataMap.RIGHT_SECTION == "1") {
					$("#viewRightSection").text("특허");
					$("#viewName").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "2") {
					$("#viewRightSection").text("실용신안");
					$("#viewName").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "3") {
					$("#viewRightSection").text("디자인");
					$("#viewName").text(data.dataMap.D_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "4") {
					$("#viewRightSection").text("상표");
					$("#viewName").text(data.dataMap.B_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "5") {
					$("#viewRightSection").text("프로그램");
					$("#viewName").text(data.dataMap.P_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "6") {
					$("#viewRightSection").text("노하우");
					$("#viewName").text(data.dataMap.TCHNLGY_NM);
				}
				$("#viewPossessOrg").text(data.dataMap.ORG_GRP_NM);
				$("#viewRegistInfo").text(data.dataMap.REGIST_INFO);
				$("#viewTransferSection").text(data.dataMap.TRANSFER_SECTION);
				$("#viewTransferDate").text(data.dataMap.TRANSFER_DATE);
				if(data.dataMap.ETERNITY_YN == 'Y') {
					$("#eternityLine").show();
					$("#viewTransferTerm").hide();
					$("#eternity").text("영구");
				} else {
					$("#eternityLine").hide();
					$("#viewTransferTerm").show();
					$("#viewTransferStDt").text(data.dataMap.TRANSFER_ST_DT);
					$("#viewTransferEdDt").text(data.dataMap.TRANSFER_ED_DT);
				}
				$("#viewTransferPerson").text(data.dataMap.TRANSFER_PERSON);
				$("#viewBInstitution").text(data.dataMap.BROKERAGE_INSTITUTION);
				$("#viewFlaSumSkillFee").text(data.dataMap.FLAT_SUM_SKILL_FEE);
				$("#viewOrdinarySkillFee").text(data.dataMap.ORDINARY_SKILL_FEE);
				$("#viewTransferDelegate").text(data.dataMap.TRANSFER_DELEGATE);
				$("#viewTransferPosition").text(data.dataMap.TRANSFER_POSITION);
				$("#viewTransferPhone1").text(data.dataMap.TRANSFER_PHONE1);
				$("#viewTransferPhone2").text(data.dataMap.TRANSFER_PHONE2);
				$("#viewTransferEmail").text(data.dataMap.TRANSFER_EMAIL);
				$("#viewNote").text(data.dataMap.NOTE);
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

	function stateAdmission(value) {
		var idx = $("#viewStatusIdx").val();
		var reject = $("#reject").val("");
		if(confirm('승인하시겠습니까?')) {
			$.ajax({
				url : "/sys/jipUseStatus.do",
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
				url : "/sys/jipUseStatus.do",
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

	function goWrite() {
		$("#name").text("");
		$("#possessOrg").text("");
		$("#eternityYN").attr("checked", false);
		$("#eternityYN").val("N");
		$("#transferTerm").show();
		$("#editStatus").each(function() {
			this.reset();
		});
		$("#editStatus > h3").text("지식재산 이전현황 등록");
		$("#pbtn").attr("onclick", "writeProc()").text("등록");
		$("#dbtn").hide();

		var temp = $("#layer2");
		var bg = temp.prev().hasClass('bg');

		if(bg){
			$('.layer').fadeIn();
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
				$('.layer').fadeOut();
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});

		$('.layer .bg').click(function(e){
			$('.layer').fadeOut();
			e.preventDefault();
		});
	}

	function statusEdit() {
		$("#name").text("");
		$("#possessOrg").text("");
		$("#editStatus > h3").text("지식재산 이전현황 수정");
		var value = $("#viewStatusIdx").val();
		$.ajax({
			url : "/sys/jipUseStatus.do",
			data : {"mode" : "edit", "jipUseIdx" : value},
			success : function(data) {
				$("#jipUseIdx").val(value);
				$("#rightSection").val(data.dataMap.RIGHT_SECTION).attr("selcted", "selected");
				if(data.dataMap.RIGHT_SECTION == "1") {
					$("#name").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "2") {
					$("#name").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "3") {
					$("#name").text(data.dataMap.D_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "4") {
					$("#name").text(data.dataMap.B_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "5") {
					$("#name").text(data.dataMap.P_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "6") {
					$("#name").text(data.dataMap.TCHNLGY_NM);
				}
				$("#possessOrg").text(data.dataMap.ORG_GRP_NM);
				$("#registInfo").val(data.dataMap.REGIST_INFO);
				$("#transferSection").val(data.dataMap.TRANSFER_SECTION).attr("selcted", "selected");
				$("#transferDate").val(data.dataMap.TRANSFER_DATE);
				$("#transferStDt").val(data.dataMap.TRANSFER_ST_DT);
				$("#transferEdDt").val(data.dataMap.TRANSFER_ED_DT);
				$("#transferPerson").val(data.dataMap.TRANSFER_PERSON);
				$("#brokerageInstitution").val(data.dataMap.BROKERAGE_INSTITUTION);
				$("#flatSumSkillFee").val(data.dataMap.FLAT_SUM_SKILL_FEE);
				$("#ordinarySkillFee").val(data.dataMap.ORDINARY_SKILL_FEE);
				$("#transferDelegate").val(data.dataMap.TRANSFER_DELEGATE);
				$("#transferPosition").val(data.dataMap.TRANSFER_POSITION);
				$("#transferPhone1").val(data.dataMap.TRANSFER_PHONE1);
				$("#transferPhone2").val(data.dataMap.TRANSFER_PHONE2);
				$("#transferEmail").val(data.dataMap.TRANSFER_EMAIL);
				if(data.dataMap.ETERNITY_YN == "Y") {
					$("#eternityYN").attr("checked", true);
					$("#eternityYN").val("Y");
					$("#transferTerm").hide();
				} else {
					$("#eternityYN").attr("checked", false);
					$("#eternityYN").val("N");
					$("#transferTerm").show();
				}
				$("#note").val(data.dataMap.NOTE);

				$("#statusForm > h3").text("지식재산 이전현황 수정");
				$("#pbtn").attr("onclick", "editProc()").text("수정");
				$("#dbtn").show();

				var temp = $("#layer2");
				var bg = temp.prev().hasClass('bg');

				if(bg){
					$('.layer').fadeIn();
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
						$('.layer').fadeOut();
					}else{
						temp.fadeOut();
					}
					e.preventDefault();
				});

				$('.layer .bg').click(function(e){
					$('.layer').fadeOut();
					e.preventDefault();
				});


			}
		});
	}
	function editProc() {
		if(confirm("수정하시겠습니까?")) {
			if($("#registInfo").val() == "") {
				alert("등록정보를 입력해 주세요.");
				$("#registInfo").focus();
			} else if($("#transferDate").val() == "") {
				alert("이전일을 입력해 주세요");
				$("#transferDate").focus();
			} else if($("#transferPerson").val() == "") {
				alert("실시권자를 입력해 주세요.");
				$("#transferPerson").focus();
			} else if($("#flatSumSkillFee").val() == "") {
				alert("정액기술료를 입력해 주세요.");
				$("#flatSumSkillFee").focus();
			} else {
				var formData = $("#editStatus").serialize();
				$.ajax({
					url : "/sys/jipUseStatusProc.do?mode=edit",
					type : "POST",
					data : formData,
					success : function(){
						alert("정상적으로 처리되었습니다.");
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
				url : "/sys/jipUseStatusProc.do?mode=del",
				type : "POST",
				data : {"jipUseIdx" : idx},
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
			if($("#registInfo").val() == "") {
				alert("등록정보를 입력해 주세요.");
				$("#registInfo").focus();
			} else if($("#transferDate").val() == "") {
				alert("이전일을 입력해 주세요");
				$("#transferDate").focus();
			} else if($("#transferPerson").val() == "") {
				alert("실시권자를 입력해 주세요.");
				$("#transferPerson").focus();
			} else if($("#flatSumSkillFee").val() == "") {
				alert("정액기술료를 입력해 주세요.");
				$("#flatSumSkillFee").focus();
			} else {
				var formData = $("#editStatus").serialize();
				$.ajax({
					url : "/sys/jipUseStatusProc.do?mode=write",
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
		var listMode = "";
		if($("#rightSection").val() == '3') {
			listMode = "design";
		} else if($("#rightSection").val() == '4') {
			listMode = "brand";
		} else if($("#rightSection").val() == '5') {
			listMode = "program";
		} else if($("#rightSection").val() == '6') {
			listMode = "knowhow";
		} else {
			listMode = "utility";
		}
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/jipUseStatus.do?mode=registPop&listmode="+listMode;
		var popOption="width=800, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);

	}

	function setPopup(obj){
		$("#registInfo").val(obj['registNo']);
	}

	$("#eternityYN").click(function() {
		if($(this).is(":checked")) {
			$(this).val("Y");
			$("#transferTerm").hide();
			$("#transferStDt").val(null);
			$("#transferEdDt").val(null);
		} else {
			$(this).val("N");
			$("#transferTerm").show();
		}
	});

	$("#rightSection").change(function() {
		$("#registInfo").val(null);
		$("#name").text("");
		$("#possessOrg").text("");
	});
</script>


<!--// bo_btn -->
