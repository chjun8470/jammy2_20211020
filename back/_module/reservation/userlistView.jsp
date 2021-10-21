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

	<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css" />
	<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />
	<link rel="stylesheet" type="text/css" href="/css/cms/back/board_3.css" />
	<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />

	<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/board.js"></script>

	<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
	<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js" type="text/javascript"></script>

<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
%>
<div style="margin: 10px;">
	<form name="fwrite" id="fwrite" action="/sys/eqReservationUser.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name = "searchType" id = "searchType" value="NAME"/>
		<input type="hidden" name = "searchWord" id = "searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
		<input type="hidden" name = "order" id = "order" value = "<%=util.getStr(paramMap.get("order"))%>" />
		<input type="hidden" name = "userIdx" id = "userIdx" value = "<%=util.getStr(paramMap.get("userIdx"))%>" />

		<div class="skin_bbs_write">
		<div style="margin:10px"><h3><b>OFFLINE 사용자 정보</b></h3></div>
			<table class="skin_basic_write">
				<caption>OFFLINE 사용자정보</caption>
				<colgroup>
					<col style="width: 20%">
					<col style="width: 30%">
					<col style="width: 20%">
					<col style="width: 30%">
				</colgroup>
				<tbody>
					<tr>
						<th>
							이름
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("PSN_NM")) %>
						</td>
					</tr>
					<tr>
						<th>
							성별구분
						</th>
						<td>
							<%if(util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("M")){ %>
								남자
							<%}else{%>
								여자
							<%} %>
						</td>
						<th style="align: center; valign: middle">
							외국인여부
						</th>
						<td>
							<%if(util.getStr(dataMap.get("FRGN_YN")).equals("N")){ %>
								대한민국
							<%}else{%>
								외국인
							<%} %>
						</td>
					</tr>
					<tr>
						<th>
							전화번호
						</th>
						<td>
							<%=util.getStr(dataMap.get("TEL_NO")) %>
						</td>
						<th>
							핸드폰번호
						</th>
						<td>
							<%=util.getStr(dataMap.get("CP_NO")) %>
						</td>
					</tr>
					<tr>
						<th>
							이메일
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("EMAIL")) %>
						</td>
					</tr>
					<tr>
						<th>
							주소
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("ZIPCD")) %> ) <%=util.getStr(dataMap.get("ADDR1")) %>
						</td>
					</tr>
					<tr>
						<th scope="col">
							상세주소
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("ADDR2")) %>
						</td>
					</tr>
					<tr>
						<th id="thNm">
							기업/기관명
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("ORG_GRP_TYPE")) %> <%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
						</td>
					</tr>
					<tr>
						<th>
							대표자명
						</th>
						<td id="deptNmTd" colspan="3">
							<%=util.getStr(dataMap.get("OWNER_NM")) %>
						</td>
					</tr>
					<tr>
						<th>
							사업자등록번호
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("CORP_NO")) %>
						</td>
					</tr>
					<tr>
						<th id="deptNmTh">
							소속부서/센터
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("DEPT_NM")) %>
						</td>
					</tr>
					<tr>
						<th>
							직위
						</th>
						<td colspan="3">
							<%=util.getStr(dataMap.get("POSITION_NM")) %>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_box">
			<div class="btn_right_box">
				<input type="button" onclick="editGo()" value="수정" class="btn_inp_b_01" />
				<input type="button" onclick="deleteGo()" value="삭제" class="btn_inp_y_01" />
				<input type="button" onclick="goList()" class="btn_inp_w_01" value="목록" />
			</div>
		</div>

	</form>
</div>
<script type="text/javascript">
	function goList(){
		$("#mode").val("userPop");
		$('#fwrite').attr("action","/sys/eqReservation.do");
		$('#fwrite').submit();
	}

	function editGo(){
		$("#mode").val("edit");
		$('#userIdx').val();
		$('#fwrite').attr("action","/sys/eqReservationUser.do");
		$('#fwrite').submit();
	}
	
	
	function deleteGo(){
		$("#mode").val("delete");
		$('#userIdx').val();
		$('#fwrite').attr("action","/sys/eqReservationUser.do");
		$('#fwrite').submit();
	}
	
</script>