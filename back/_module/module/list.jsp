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
	ArrayList<HashMap<String, String>> moduleDataList = request.getAttribute("moduleDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("moduleDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>
<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_module.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="name" <%if(util.getStr(paramMap.get("searchType")).equals("name")) { %> selected="selected" <% } %> >?????????</option>
								<option value="url" <%if(util.getStr(paramMap.get("searchType")).equals("url")) { %> selected="selected" <% } %>>????????? ??????</option>
							</select>
							<!-- ????????? -->
							 <label for="keyword" class="hide">?????????</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
							<!-- ???????????? -->
						<input type="button" class="btn_inp_g_01" value="??????" onclick="pageSearchGo()" style="float: right;" />
						</div>
						<!-- board-search -->
					 </div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 10px;">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:moduleDataList) {%>
				<tr style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("MODULE_INFO_IDX")%>');">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("MB_NM"))%></td>
					<td><%=util.getStr(rs.get("PAGE_CD"))%></td>
					<td><%=util.getStr(rs.get("PSN_NM"))%></td>
					<td><%=format.format(rs.get("REG_DT"))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<div class="bbs_btn">
			<input class="btn_inp_b_01" type="button" onclick="location.href='/sys/sys_module.do?mode=write'" value="??????" />
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
		$('#moduleInfoIdx').val(idx);
		$('#searchForm').submit();
	}
</script>


<!--// bo_btn -->
