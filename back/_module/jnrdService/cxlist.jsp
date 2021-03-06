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
									<h3 class="list_tit">????????????</h3>
									<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
				         			<select name="searchYear" id="searchYear" class="select_box">
				         				<option value="">:::??????:::</option>
				         				<c:forEach var="i" begin="2018" end="${currTime}">
				         				<%
				         				pageContext.setAttribute("cxyearX", util.getStr(paramMap.get("searchYear")));
				         				%>
				            			<option value="${i}" <c:if test="${i eq cxyearX}">selected</c:if>>${i}</option>
				            			</c:forEach>
				         			</select>
									<h3 class="list_tit"  style="margin-left:5px">????????????</h3>
									<input type="text" class="inp_text" name="sdate" id="sdate" value="<%=util.getStr(String.valueOf(paramMap.get("sdate")))%>"> ~ <input type="text" class="inp_text" name="edate" id="edate" value="<%=util.getStr(String.valueOf(paramMap.get("edate")))%>">
								</li>
								<li>
									<h3 class="list_tit">????????????</h3>
									<ul class="checkbox">
										<li>
											<label><input type="checkbox" name="ctype1" value="????????????" <%=(util.getStr(paramMap.get("ctype1")).equals("????????????"))?"checked":""%>>????????????</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctype2" value="R&D" <%=(util.getStr(paramMap.get("ctype2")).equals("R&D"))?"checked":""%>>R&D</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctype3" value="???R&D" <%=(util.getStr(paramMap.get("ctype3")).equals("???R&D"))?"checked":""%>>???R&D</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctype4" value="??????" <%=(util.getStr(paramMap.get("ctype4")).equals("??????"))?"checked":""%>>??????</label>
										</li>
									</ul>
								</li>
								<li>
									<h3 class="list_tit">????????????</h3>
									<ul class="checkbox">
										<li>
											<label><input type="checkbox" name="ctypex1" value="????????????" <%=(util.getStr(paramMap.get("ctypex1")).equals("????????????"))?"checked":""%>>????????????</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctypex2" value="????????????" <%=(util.getStr(paramMap.get("ctypex2")).equals("????????????"))?"checked":""%>>????????????</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctypex3" value="???????????????" <%=(util.getStr(paramMap.get("ctypex3")).equals("???????????????"))?"checked":""%>>???????????????</label>
										</li><li>
											<label><input type="checkbox" name="ctypex4" value="??????????????????" <%=(util.getStr(paramMap.get("ctypex4")).equals("??????????????????"))?"checked":""%>>??????????????????</label>
										</li>
										<li>
											<label><input type="checkbox" name="ctypex5" value="??????" <%=(util.getStr(paramMap.get("ctypex5")).equals("??????"))?"checked":""%>>??????</label>
										</li>
									</ul>
								</li>
								
								<li>
									<select class="select sel01" name="searchType" id="searchType" width="200">
										<option value="CX_B1" <%=(util.getStr(paramMap.get("searchType")).equals("CX_B1"))?"selected":""%>>???????????????</option>
										<option value="CX_B3" <%=(util.getStr(paramMap.get("searchType")).equals("CX_B3"))?"selected":""%>>?????????</option>
									</select>
									<input type="text" class="inp_text" name="searchKey" id="searchKey" value="<%=util.getStr(paramMap.get("searchKey")) %>" width="600">
									<input type="button" class="btn_inp_g_01" value="??????" onclick="pageSearchGo()" />
								</li>
							</ul>
							<!--<%-- <label for="" >?????????????????? : </label>
							<select name="equipCd" id="equipCd" class="select" style="height: 24px">
								<option value="" >??????</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>????????????</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>????????????</option>
							</select> --%>

							<%-- <label for="searchType" class="hide">??????????????????</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????/?????????</option>
								<option value="manufacture" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
								<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
							</select>
							<!-- ????????? 
							<input type="text" class="inp_text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" /> --%>
							?????????
							<input type="text" class="inp_text" name="eduNm" id="eduNm" class="board-input" value="<%//=util.getStr(paramMap.get("eduNm"))%>" />
							| ????????????
							<input type="text" class="inp_text" name="eduStDt" id="eduStDt" class="board-input" value="<%//=util.getStr(paramMap.get("eduStDt"))%>" /> ~
							<input type="text" class="inp_text" name="eduEdDt" id="eduEdDt" class="board-input" value="<%//=util.getStr(paramMap.get("eduEdDt"))%>" />
							<!-- ???????????? 
							<input type="button" class="btn_inp_g_01" value="??????" onclick="pageSearchGo()" />-->
						</div>
						<!-- board-search e -->
					</div>
				</div>
			<!-- bbs-top e -->
</form>
 
			<div class="btn_box">
				[?????? <span><%//=staticVO.getTotalCount()%></span>???, <span><%//=staticVO.getNowPage()%></span>/<%//=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<div class="btn_right_box">
					<!-- <button type="button" id="excelDownload" class="btn_inp_b_01" onclick="goExcel()">??????????????????</button> -->
				</div>
			</div>

	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<caption>?????????????????? ???????????? ?????????????????????.</caption>
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
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
				</tr>
				<!--<tr>
					<th scope="col">NO</th>
					<th scope="col">?????????(?????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????<br/>(??????/??????)</th>
					<th scope="col">???????????????</th>
					<!--<th scope="col">????????????</th>
					<th scope="col">????????????</th>
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
			}else{out.println("<tr><td colspan='8'>????????? ????????? ????????????.</td></tr>");}
			%>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
	<div class="btn_box">
		<div class="btn_right_box" >
		<%if(Integer.parseInt(loginVO.getAuthLv()) >= 70) {%>
						<input type="button" class="btn_inp_g_01" value="??????" onclick="pageWriteGo()" />
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
		nextText : '?????? ???',
		prevText : '?????? ???',
		currentText : '?????? ??????',
		closeText : '??????',
		dateFormat : "yy-mm-dd",
		dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		dayNamesMin : ['???','???','???','???','???','???','???'],
		monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	});

	function goExcel(){
		$('#searchForm').attr("action","/sys/eduExcel.do");
		$('#searchForm').submit();
		$('#searchForm').attr("action","/sys/sys_edu.do");
	}

</script>


<!--// bo_btn -->
