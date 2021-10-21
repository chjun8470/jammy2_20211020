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
	String nowPage = util.getIntStr(paramMap.get("nowPage"));


%>

<div class="skin_list">
<form id = "searchForm" name = "searchForm" method="post">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "eduId" id = "eduId" />
			<input type="hidden" name = "tmenu" id = "tmenu" value="2"/>
			<input type="hidden" name = "pageCheck" id = "pageCheck" value="1"/>
			
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<%-- <label for="" >시설장비분류 : </label>
							<select name="equipCd" id="equipCd" class="select" style="height: 24px">
								<option value="" >선택</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>연구장비</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>연구시설</option>
							</select> --%>

							<%-- <label for="searchType" class="hide">검색종류선택</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>장비/시설명</option>
								<option value="manufacture" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>모델명</option>
								<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>키워드</option>
							</select>
							<!-- 키워드 -->
							<input type="text" class="inp_text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" /> --%>
							교육명
							<input type="text" class="inp_text" name="eduNm" id="eduNm" class="board-input" value="<%=util.getStr(paramMap.get("eduNm"))%>" />
							| 교육기간
							<input type="text" class="inp_text" name="eduStDt" id="eduStDt" class="board-input" value="<%=util.getStr(paramMap.get("eduStDt"))%>" /> ~
							<input type="text" class="inp_text" name="eduEdDt" id="eduEdDt" class="board-input" value="<%=util.getStr(paramMap.get("eduEdDt"))%>" />
							<!-- 검색버튼 -->
							<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" />
						</div>
						<!-- board-search e -->
					</div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>
			<div class="btn_box">
						<div class="btn_right_box">
							<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="goExcel()">엑셀다운로드</button>
						</div>
			</div>

	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<caption>등록되어있는 교육정보 리스트표입니다.</caption>
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 30%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">교육명(과정명)</th>
					<th scope="col">접수기간</th>
					<th scope="col">교육기간</th>
					<th scope="col">교육시간</th>
					<th scope="col">수강인원<br/>(수료/신청)</th>
					<th scope="col">수강생관리</th>
					<!--<th scope="col">신청상태</th>-->
					<th scope="col">교육상태</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr>
						<td><%=cont%></td>
						<td style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EDU_ID")%>');"><%=util.getStr(rs.get("EDU_NM"))%>(<%=util.getStr(rs.get("EDU_CUR"))%>)</td>
						<td style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EDU_ID")%>');"><%=util.getStr(rs.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ORD_ED_DT"))%></td>
						<td style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EDU_ID")%>');"><%=util.getStr(rs.get("EDU_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ED_DT"))%></td>
						<td style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EDU_ID")%>');"><%=util.getIntStr(rs.get("EDU_TOTAL_TIME"))%>시간</td>
						
						<td style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EDU_ID")%>');"><%=util.getIntStr(rs.get("EDU_ORD_PEOPLE"))%>/<%=util.getIntStr(rs.get("EDU_PEOPLE"))%></td>
						<td><button class="btn_inp_g_01" type="button" onclick="pageResvGo('<%=rs.get("EDU_ID")%>')">상세보기</button></td>
						<!-- <td><%=util.getStr(rs.get("EDU_STATE"))%></td> -->
						<td>
						<% if("접수중".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("접수대기".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								<img alt="접수대기" src="/img/back/comm/edu_state_img_02.png" />
						<% }else if("접수마감".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
						<% }else if("수업중".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								<img alt="수업중" src="/img/back/comm/edu_state_img_04.png" />
						<% }else{%>
								<img alt="수업종료" src="/img/back/comm/edu_state_img_05.png" />
						<% } %>
						<%-- <%=util.getStr(rs.get("EDU_ORD_STATE"))%> --%>
						</td>

					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='7'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
	<div class="btn_box">
			<div class="btn_right_box" >
			<%if(Integer.parseInt(loginVO.getAuthLv()) >= 70) {%>
							<input type="button" class="btn_inp_g_01" value="등록" onclick="pageWriteGo()" />
			<%} %>
			</div>
		</div>
</div>

<script type="text/javascript">
function pageResvGo(eduId){
	$('#eduId').val(eduId);
	$('#mode').val('resvList');
	$('#searchForm').attr("action","/sys/sys_edu.do");
	$('#searchForm').submit();
}

	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageWriteGo(){
			$('#mode').val('write');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val("view");
		$('#eduId').val(idx);
		$('#searchForm').submit();
	}


	$("#eduStDt, #eduEdDt").datepicker({
//		showOn : "both",
//		buttonImage: "button.png",

		showMonthAfterYear : true,
		showButtonPanel : true,
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
	
	function goExcel(){
		$('#searchForm').attr("action","/sys/eduExcel.do");
		$('#searchForm').submit();
		$('#searchForm').attr("action","/sys/sys_edu.do");
	}

</script>


<!--// bo_btn -->
