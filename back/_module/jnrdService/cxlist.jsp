<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
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
	
	System.out.println("cxlist.jsp");

%>

<jsp:useBean id="currTime" class="java.util.Date" />

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

							<ul class="schbox00">
								<li>
									<h3 class="list_tit">지원연도</h3>
									<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
				         			<select name="searchYear" id="searchYear" class="select_box">
				         				<option value="">:::선택:::</option>
				         				<c:forEach var="i" begin="2018" end="${currTime}">
				         				<%
				         				pageContext.setAttribute("cxyearX", util.getStr(paramMap.get("searchYear")));
				         				%>
				            			<option value="${i}" <c:if test="${i eq cxyearX}">selected</c:if>>${i}</option>
				            			</c:forEach>
				         			</select>
									<h3 class="list_tit"  style="margin-left:5px">기획기간</h3>
									<input type="text" class="inp_text" name="sdate" id="sdate" value="<%=util.getStr(String.valueOf(paramMap.get("sdate")))%>"> ~ <input type="text" class="inp_text" name="edate" id="edate" value="<%=util.getStr(String.valueOf(paramMap.get("edate")))%>">
								</li>
								<li>
									<h3 class="list_tit">기획유형</h3>
									<ul class="checkbox">
										<li>
											<label><input type="checkbox" name="ctype1" value="정책연구" <%=(util.getStr(paramMap.get("ctype1")).equals("정책연구"))?"checked":""%>>정책연구</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctype2" value="R&D" <%=(util.getStr(paramMap.get("ctype2")).equals("R&D"))?"checked":""%>>R&D</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctype3" value="비R&D" <%=(util.getStr(paramMap.get("ctype3")).equals("비R&D"))?"checked":""%>>비R&D</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctype4" value="기타" <%=(util.getStr(paramMap.get("ctype4")).equals("기타"))?"checked":""%>>기타</label>
										</li>
									</ul>
								</li>
								<li>
									<h3 class="list_tit">기획주제</h3>
									<ul class="checkbox">
										<li>
											<label><input type="checkbox" name="ctypex1" value="자체기획" <%=(util.getStr(paramMap.get("ctypex1")).equals("자체기획"))?"checked":""%>>자체기획</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctypex2" value="기획과제" <%=(util.getStr(paramMap.get("ctypex2")).equals("기획과제"))?"checked":""%>>기획과제</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctypex3" value="기획연구회" <%=(util.getStr(paramMap.get("ctypex3")).equals("기획연구회"))?"checked":""%>>기획연구회</label>
										</li><li>
											<label><input type="checkbox" name="ctypex4" value="학술연구용역" <%=(util.getStr(paramMap.get("ctypex4")).equals("학술연구용역"))?"checked":""%>>학술연구용역</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctypex5" value="기타" <%=(util.getStr(paramMap.get("ctypex5")).equals("기타"))?"checked":""%>>기타</label>
										</li>
									</ul>
								</li>
								
								<li>
									<select class="select sel01" name="searchType" id="searchType" width="200">
										<option value="CX_B1" <%=(util.getStr(paramMap.get("searchType")).equals("CX_B1"))?"selected":""%>>기획과제명</option>
										<option value="CX_B3" <%=(util.getStr(paramMap.get("searchType")).equals("CX_B3"))?"selected":""%>>기관명</option>
									</select>
									<input type="text" class="inp_text" name="searchKey" id="searchKey" value="<%=util.getStr(paramMap.get("searchKey")) %>" width="600">
									<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" />
								</li>
							</ul>
							<!--<%-- <label for="" >시설장비분류 : </label>
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
							<!-- 키워드 
							<input type="text" class="inp_text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" /> --%>
							교육명
							<input type="text" class="inp_text" name="eduNm" id="eduNm" class="board-input" value="<%//=util.getStr(paramMap.get("eduNm"))%>" />
							| 교육기간
							<input type="text" class="inp_text" name="eduStDt" id="eduStDt" class="board-input" value="<%//=util.getStr(paramMap.get("eduStDt"))%>" /> ~
							<input type="text" class="inp_text" name="eduEdDt" id="eduEdDt" class="board-input" value="<%//=util.getStr(paramMap.get("eduEdDt"))%>" />
							<!-- 검색버튼 
							<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" />-->
						</div>
						<!-- board-search e -->
					</div>
				</div>
			<!-- bbs-top e -->
</form>
 
			<div class="btn_box">
				[전체 <span><%//=staticVO.getTotalCount()%></span>건, <span><%//=staticVO.getNowPage()%></span>/<%//=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<div class="btn_right_box">
					<!-- <button type="button" id="excelDownload" class="btn_inp_b_01" onclick="goExcel()">엑셀다운로드</button> -->
				</div>
			</div>

	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<caption>등록되어있는 교육정보 리스트표입니다.</caption>
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 30%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<!--<col style="width: 10%;" />-->
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">관리코드</th>
					<th scope="col">기획유형</th>
					<th scope="col">기획주제</th>
					<th scope="col">기획과제명</th>
					<th scope="col">기관명</th>
					<th scope="col">기획기간</th>
					<th scope="col">기획비</th>
				</tr>
				<!--<tr>
					<th scope="col">NO</th>
					<th scope="col">교육명(과정명)</th>
					<th scope="col">접수기간</th>
					<th scope="col">교육기간</th>
					<th scope="col">교육시간</th>
					<th scope="col">수강인원<br/>(수료/신청)</th>
					<th scope="col">수강생관리</th>
					<!--<th scope="col">신청상태</th>
					<th scope="col">교육상태</th>
				</tr>-->
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr>
						<td><%=cont%></td>
						<td><%=rs.get("CX_CODE")%></td>
						<td><%=util.getStr(rs.get("CX_TYPE1"))%></td>
						<td><%=util.getStr(rs.get("CX_TYPE2"))%></td>
						<td><a href="/sys/<%=myPage%>?mode=view&IDX=<%=util.getStr(rs.get("IDX"))%>"><%=util.getStr(rs.get("CX_B1"))%></a></td>
						<td><%=util.getStr(rs.get("CX_B3"))%></td>
						<td><%=util.getStr(rs.get("CX_C1"))%> ~ <%=util.getStr(rs.get("CX_C2"))%></td>
						<td><%=util.getStr(rs.get("D6"))%><td>
						
					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='8'>조회된 결과가 없습니다.</td></tr>");}
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


	$("#sdate, #edate").datepicker({
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
		dayNamesMin : ['일','월','화','수','목','금','토'],
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
