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
	System.out.println("nowPage : "+nowPage);
	System.out.println("myPage : "+myPage);
	System.out.println("myPage : "+nowPage2);

%>
<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="/web/web_jnsptotal.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "rndEquIdx" id = "rndEquIdx" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<label for="" >?????????????????? : </label>
							<select name="equipCd" id="equipCd" class="select" style="height: 24px">
								<option value="" >??????</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>????????????</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>????????????</option>
							</select>
							
							<label for="searchType" class="hide">??????????????????</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????/?????????</option>
								<option value="manufacture" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
								<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
							</select>
							<!-- ????????? -->
							<label for="keyword" class="hide">?????????</label> 
							<input type="text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
							<!-- ???????????? -->
							<input type="button" class="btn_inp_g_01" value="??????" onclick="pageSearchGo()" />
						</div>
						<!-- board-search e -->
					</div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????????????????</th>
					<th scope="col">????????????????????????</th>
					<th scope="col">??????/?????????</th>
					<th scope="col">?????????</th>
				</tr>
			</thead>
			<tbody>
				<tr>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("RND_EQU_IDX")%>');">
						<td><%=cont%></td>
						<td><%=util.getStr(rs.get("EQUIP_CD")).equals("1")?"????????????":"????????????"%></td>
						<td><%=util.getStr(rs.get("FIXED_ASET_NO_YN")).equals("Y") ? "???????????? ??????.":util.getStr(rs.get("FIXED_ASET_NO"))%></td>
						<td><%=util.getStr(rs.get("KOR_NM"))%>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
						<td><%=util.getStr(rs.get("MANUFACTURE_NM"))%></td>
					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='5'>????????? ????????? ????????????.</td></tr>");}
			%>
			</tbody>
		</table>
		<div class="btn_box">
			&nbsp;
		</div>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#rndEquIdx').val(idx);
		$('#searchForm').submit();
	}
</script>


<!--// bo_btn -->
