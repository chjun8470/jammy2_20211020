<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	String m = util.getStr(request.getQueryString());

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> reservationDataList = request.getAttribute("reservationDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("reservationDataList");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));

	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));

	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>
<div class="skin_list">
<form id = "searchForm" name = "searchForm" method="post" action="?<%=m%>" class="boardSearch">
			<input type="hidden" name="nowPage" 	id="nowPage" />
			<input type="hidden" name="mode" 		id="mode" />
			<input type="hidden" name="listMode" 	id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="sortMode" 	id="sortMode" value="<%=sortMode%>" />
			<input type="hidden" name="rndEquIdx"	id="rndEquIdx" value="" />

			<div class="bbs-top">
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<select name="searchUseScope" id="searchUseScope" class="b_select" style="height: 24px">
								<option value="">??????</option>
								<option value="1" <%if(util.getStr(paramMap.get("searchUseScope")).equals("1")) { %> selected="selected" <% } %>>?????????</option>
								<option value="2" <%if(util.getStr(paramMap.get("searchUseScope")).equals("2")) { %> selected="selected" <% } %>>?????????(??????, ??????)</option>
								<option value="3" <%if(util.getStr(paramMap.get("searchUseScope")).equals("3")) { %> selected="selected" <% } %>>?????????(??????, ??????)</option>
								<option value="4" <%if(util.getStr(paramMap.get("searchUseScope")).equals("4")) { %> selected="selected" <% } %>>?????????</option>
								<option value="5" <%if(util.getStr(paramMap.get("searchUseScope")).equals("5")) { %> selected="selected" <% } %>>????????????</option>
								<option value="6" <%if(util.getStr(paramMap.get("searchUseScope")).equals("6")) { %> selected="selected" <% } %>>????????????</option>
								<option value="7" <%if(util.getStr(paramMap.get("searchUseScope")).equals("7")) { %> selected="selected" <% } %>>NTIS ????????????</option>
								<option value="8" <%if(util.getStr(paramMap.get("searchUseScope")).equals("8")) { %> selected="selected" <% } %>>e-tube ????????????</option>
								<option value="9" <%if(util.getStr(paramMap.get("searchUseScope")).equals("9")) { %> selected="selected" <% } %>>JEINET ????????????</option>
								<option value="10" <%if(util.getStr(paramMap.get("searchUseScope")).equals("10")) { %> selected="selected" <% } %>>????????????????????????</option>
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
			</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 10px;">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>
			<div class="btn_right_box">
					<%-- <input type="button" class="btn_inp_w_01" value="?????????" onclick="listPageSubmit('list', '<%=listMode%>', 'new_list')"/>
					<input type="button" class="btn_inp_w_01" value="?????????" onclick="listPageSubmit('list', '<%=listMode%>', 'popular_list')"/>
					<input type="button" class="btn_inp_w_01" value="???????????????" onclick="listPageSubmit('list', '<%=listMode%>', 'down_list')"/> --%>
					<input type="button" class="btn_inp_w_01" value="?????????" onclick="listPageSubmit('list', 'list', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="??????????????????" onclick="listPageSubmit('list','imagelist', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="??????????????????" onclick="listPageSubmit('list','bloglist', '<%=sortMode%>')"/>
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 13%;" />
				<col style="width: *%;" />
				<col style="width: 13%;" />
				<col style="width: 13%;" />
				<col style="width: 15%;" />
				<%if(!"".equals(util.getStr(loginVO.getUserIdx()))) {%>
				<col style="width: 7%;" />
				<%} %>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<%if(!"".equals(util.getStr(loginVO.getUserIdx()))) {%>
					<th scope="col">??????</th>
					<%} %>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:reservationDataList) {%>
				<tr style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("RND_EQU_IDX")%>');">
					<td><%=cont%></td>
					<td>
					<%if(util.getStr(rs.get("EQUIP_CD")).equals("1")) { %> ???????????? <% } %>
					<%if(util.getStr(rs.get("EQUIP_CD")).equals("2")) { %> ???????????? <% } %></td>
					<td><%=util.getStr(rs.get("KOR_NM"))%>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
					<td><%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("1")) { %> ?????????????????????1 <% } %>
					<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("2")) { %> ??????????????????2 <% } %>
					<%if(util.getStr(rs.get("USE_SCOPE_CD")).equals("3")) { %> ??????????????????3 <% } %></td>
					<td><%=util.getStr(rs.get("USE_SCOPE_RANGE"))%></td>
					<td><%=util.getStr(rs.get("USE_SCOPE_MEAN"))%></td>

					<%if(!"".equals(util.getStr(loginVO.getUserIdx()))) {%>
					<td><%=cont%></td>
					<%} %>

				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<!-- <div class="bbs_btn">
			<input class="btn_inp_b_01" type="button" onclick="pageWriteGo()" value="??????" />
		</div> -->
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#rndEquIdx').val(idx);
		$('#searchForm').submit();
	}
	function pageWriteGo(){
		$('#mode').val('write');
		$('#searchForm').submit();
	}
	function listPageSubmit(mode,listMode,sortMode){
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
//]]>	
</script>


<!--// bo_btn -->
