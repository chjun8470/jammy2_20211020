<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
%>

<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />

<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/board.js"></script>

<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>

<div class="skin_list">

	<form id = "searchForm" name = "searchForm" method="post">
		<input type="hidden" name = "nowPage" id = "nowPage" />
		<input type="hidden" name = "mode" id = "mode" value="userPop"/>
		
		<input type="hidden" name = "order" id = "order" value = "<%=util.getStr(paramMap.get("order"))%>" />
		<input type="hidden" name = "userIdx" id = "userIdx" />

		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<!-- 키워드 -->
					
					<select name="searchType" id="searchType" class="select_box">
						<option value="NAME" <%=util.getStr(paramMap.get("searchType")).equals("NAME")?"selected":""%>>이름</option>
						<option value="GRPNM" <%=util.getStr(paramMap.get("searchType")).equals("GRPNM")?"selected":""%>>기관명</option>
					</select>
					<input type="text" name="searchWord" id="searchWord" class="inp_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" />
				</div>
				<!-- board-search e -->
			</div>
		</div>
	</form>
	<div class="total">
		[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
	</div>

	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">기관</th>
					<th scope="col">이름</th>
					<th scope="col">이메일</th>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
				<tr>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			if(dataList.size()>0){
				for(HashMap rs:dataList) {
					String name = "";
					name = util.getStr(rs.get("PSN_NM")) + " ( " + util.getStr(rs.get("EMAIL")) + " / " + util.getStr(rs.get("CP_NO")) + " )";

					String corpName = "";
					if(!util.getStr(rs.get("ORG_GRP_NM")).equals("") && !util.getStr(rs.get("ORG_GRP_TYPE")).equals("")){
						corpName = util.getStr(rs.get("ORG_GRP_NM")) + " ( " + util.getStr(rs.get("ORG_GRP_TYPE")) + " )";
					}
			%>
					<tr>
						<td>
							<%=cont%>
						</td>
						<td onclick="viewGo('<%=util.getStr(String.valueOf(rs.get("USER_IDX")))%>');" style="cursor:pointer;">
							<%=util.getStr(rs.get("ORG_GRP_NM"))%>
						</td>
						<td onclick="viewGo('<%=util.getStr(String.valueOf(rs.get("USER_IDX")))%>');" style="cursor:pointer;">
							<%=util.getStr(rs.get("PSN_NM"))%>
						</td>
						<td onclick="viewGo('<%=util.getStr(String.valueOf(rs.get("USER_IDX")))%>');" style="cursor:pointer;">
							<%=util.getStr(rs.get("EMAIL"))%>
						</td>
						<td>
							<button type="button" class="btn_inp_y_01"
								onclick="clickToBtn('<%=util.getStr(rs.get("PSN_NM"))%>'
								, '<%=util.getStr(String.valueOf(rs.get("USER_IDX")))%>'
								, '<%=corpName%>'
								, '<%=util.getStr(rs.get("ORG_GRP_NM")) %>'
								, '<%=util.getStr(rs.get("OWNER_NM")) %>'
								, '<%=util.getStr(rs.get("CORP_NO")) %>'
								, '<%=util.getStr(rs.get("DEPT_NM")) %>'
								, '<%=util.getStr(rs.get("POSITION_NM")) %>'
								, '<%=util.getStr(rs.get("TEL_NO")) %>'
								, '<%=util.getStr(rs.get("CP_NO")) %>'
								, '<%=util.getStr(rs.get("EMAIL")) %>'
								, '<%=util.getStr(rs.get("ZIPCD")) %>'
								, '<%=util.getStr(rs.get("ADDR1")) %>'
								, '<%=util.getStr(rs.get("ADDR2")) %>'
								)">
								선택
							</button>
						</td>
					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='5'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>
		<%
			if(dataList.size()>0){
				out.print(util.getPaging(staticVO, nowPage));
			}
		%>
	</div>

	<%
		if(mode.equals("userPop")){
	%>
	<div class="bbs_btn">
		<button class="btn_inp_b_01" type="button" onclick="writeGo()">등록</button>
	</div>
	<%
		}
	%>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		var mode = '<%=mode%>';
		if(mode == "userPop"){
			$('#mode').val('list');
			$('#searchForm').attr('action','./eqReservation.do?mode=userPop');
			$('#searchForm').submit();
		}else if(mode == "subUserPop"){
			$('#searchForm').attr('action','./eqReservation.do?mode=subUserPop');
			$('#searchForm').submit();
		}
	}

	function writeGo(){
		$('#mode').val('write');
		$('#searchForm').attr('action','./eqReservationUser.do');
		$('#searchForm').submit();
	}

	function viewGo(idx){
		var mode = '<%=mode%>';
		if(mode == "userPop"){
			$('#mode').val('view');
			$('#userIdx').val(idx);
			$('#searchForm').attr('action','./eqReservationUser.do');
			$('#searchForm').submit();
		}

	}

	function clickToBtn(user_nm, user_idx, corpName, org_grp_nm, orner_nm, corp_no, dept_nm, position_nm, tel_no, cp_no, email, zipcode, addr1, addr2){
		var obj = new Object();
		obj['user_nm'] = user_nm;
		obj['user_idx'] = user_idx;
		obj['corpName'] = corpName;
		obj['org_grp_nm'] = org_grp_nm;
		obj['orner_nm'] = orner_nm;
		obj['corp_no'] = corp_no;
		obj['dept_nm'] = dept_nm;
		obj['position_nm'] = position_nm;
		obj['tel_no'] = tel_no;
		obj['cp_no'] = cp_no;
		obj['email'] = email;
		obj['zipcode'] = zipcode;
		obj['addr1'] = addr1;
		obj['addr2'] = addr2;

		var mode = '<%=mode%>';
		if(mode == "userPop"){
			obj['pop_mode'] = "user";
		}else if(mode == "subUserPop"){
			obj['pop_mode'] = "subUserPop";
		}

		obj['order'] = $('#order').val();
		opener.setPopup(obj);

		window.close();
	}
</script>


<!--// bo_btn -->
