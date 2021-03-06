<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String noticeYn = util.getStr(boardMap.get("PERM_NOTICE")); //????????????
	String siteId = util.getStr(paramMap.get("siteId")); //???????????????

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
	//<![CDATA[
		alert("????????? ???????????????.");
		history.back(-1); //??????????????????
	//]]>	
	</script>
<%
		return;
	}
%>

	<div class="MPTit MPTit02 MAB0">??????????????????</div>

	<div class="list_top h30">
		<form class="boardSearch" name="searchForm" id="searchForm" action="./changeboard.do"  method="post">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />

		<div class="board_count">
			?????? <span class="blue1"><%=staticVO.getTotalCount()%></span>???
		</div>

		<div class="b_srchBox">

			<!-- ?????????????????? -->
			<select name="searchType" id="searchType" class="b_select">
				<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
				<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
				<option value="WRITER" <%if("WRITER".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
			</select>

			<div class="b_srch">
				<!-- ????????? -->
				<input class="b_srch_txt" type="text" title="??????????????????" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<!-- ???????????? -->
				<input type="image" class="b_go_btn" value="??????" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list')" />
			</div>
		</div>

		</form>
	</div>

		<!--basic_listWrap S-->
		<div class="basic_listWrap">

			<table class="skin_list01">
				<!-- colgroup s -->
			    <colgroup>
			      <col style="width:10%;" />
			      <col style="width:45%;" />
			      <col style="width:15%;" />
			      <col style="width:15%;" />
			      <col style="width:10%;" />
			    </colgroup>
				<!-- colgroup e -->

				<!-- thead s -->
				<thead>
				  <tr>
				    <th scope="col" >??????</th>
				    <th scope="col" >??????</th>
				    <th scope="col" >?????????</th>
				    <th scope="col" >?????????</th>
				    <th scope="col" class="r_line_none">??????</th>
				  </tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

						if(dataList.size() == 0){
					%>
						<tr><td class="r_line_none" colspan="6">???????????? ???????????? ????????????</td></tr>
					<%
						}

						for(HashMap rs:dataList) {
					%>
					<tr>
						<td><%=cont%></td>
						<td>
								<a href="javascript:goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')" title="<%=util.getStr(rs.get("SUBJECT"))%> ????????????" >
									<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
								</a>
						</td>
						<td>
							<%=util.getStr(rs.get("WRITER_NM"))%>(<%=util.getStr(rs.get("WRITER_ID"))%>)
						</td>
						<td>
							<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
						</td>
						<td class="r_line_none">
							<%=util.getStr(String.valueOf(rs.get("HITS")))%>
						</td>
					</tr>
					<% cont--; } %>
				</tbody>
			</table>

			<div class="MPBtnWrap MAT10">
				<input type="button" class="btn_inp_b_01 FloatR" value="??????" onclick="goSubmit('write')"/>
			</div>
			<%=util.getPaging(staticVO, nowPage)%>
	</div>
	<!--basic_listWrap E-->




<script type="text/javascript">
//<![CDATA[
function goSubmit(mode,boardIdx,beforeBoardComIdx){
	$('#boardIdx').val(boardIdx);
	$('#mode').val(mode);
	$('#searchForm').submit();
}
//]]>
</script>