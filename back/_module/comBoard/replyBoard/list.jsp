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
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");

	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
%>
<div class="skin_list">
	<div>
		<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="replyIdx" id="replyIdx" value="" />

			<div class="bbs-top">

				<br/>
				<div class="total">
					[?????? <span><%=staticVO.getTotalCount() %></span>???, <span><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				</div>
				<br/>

				<div class="board-search">
					<label for="searchType" class="hide">??????????????????</label>
					<!-- searchCnd s -->
					<select name="searchType" id="searchType" class="select" style="height: 24px">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>??????</option>
						<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>??????</option>
					</select>
					<!-- searchCnd e -->

					<label for="keyword" class="hide">?????????</label>
					<input type="text" name="searchWord" id="searchWord" class="board-input"  value="<%=util.getStr(paramMap.get("searchWord"))%>" />

					<!-- ???????????? s -->
					<input type="image" class="input_submit" value="??????" src='/imgs/board/btn_search.gif' alt="??????" class="vmiddle"/>
					</a>
					<!-- ???????????? e -->
				</div>
				<!-- board-search e -->


			</div>
			<!-- bbs-top e -->
		</form>
		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 40%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {
				if(util.getStr(rs.get("ARTICLE_PARNTS_ID")).equals("0")){%>
				<tr>
					<td>
						<%=cont%>
					</td>
					<td class="subject">
						<a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("ARTICLE_ID"))%>','N')"><%=util.getStr(rs.get("SUBJECT"))%></a>
					</td>
					<td><%=util.getStr(rs.get("WRITER_ID"))%></td>
					<td>
						<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
					</td>
					<td><%=util.getStr(rs.get("HITS"))%></td>
				</tr>
				
			<%
					cont--;
				}
				for(HashMap rs2:dataList) {
					if(util.getStr(rs.get("ARTICLE_ID")).equals(util.getStr(rs2.get("ARTICLE_PARNTS_ID")))){

					%>
					<tr>
						<td><%=cont%></td>
						<td class="subject">
							<a href="#" onclick="goSubmit('reView','<%=util.getStr(rs.get("ARTICLE_ID"))%>','<%=util.getStr(rs2.get("ARTICLE_ID"))%>')">???<%=util.getStr(rs2.get("SUBJECT"))%></a>
						</td>
						<td><%=util.getStr(rs2.get("WRITER_ID"))%></td>
						<td>
							<%=util.getStr(rs2.get("FRST_REGIST_PNTTM"))%>
						</td>
						<td><%=util.getStr(rs2.get("HITS"))%></td>
					</tr>
				<% 	

						cont--;
					}
				}
			} %>

			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;

			<%if(util.loginCheck()) {%>
			<div class="btn_right_box">
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write')"/>
			</div>
			<%}%>
		</div>


	</div>

</div>

<%=util.getPaging(staticVO, nowPage) %>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,boardIdx,replyIdx){
		$('#mode').val(mode);
		$('#boardIdx').val(boardIdx);
		$('#replyIdx').val(replyIdx);
		$('#searchForm').submit();
	}
</script>