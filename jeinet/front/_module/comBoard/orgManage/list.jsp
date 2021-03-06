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
	HashMap<String, String> orgMap = request.getAttribute("orgMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("orgMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String orgGrpCd = util.getStr(paramMap.get("orgGrpCd"));
	String ciFileSrc = util.getStr(orgMap.get("CI_FILE_SRC"));
	String orgGrpNm = util.getStr(orgMap.get("ORG_GRP_NM"));
	String siteId = util.getStr(paramMap.get("siteId")); //???????????????
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String orgSearchWord = util.getStr(paramMap.get("orgSearchWord"));

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
		alert("????????? ???????????????.");
		history.back(-1); //??????????????????
	</script>
<%
		return;
	}
%>

	<div class="list_top006">
		<form class="boardSearch" name="searchForm" id="searchForm" action="sub.do"  method="post">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
			<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
			<input type="hidden" name="orgSearchWord" id="orgSearchWord" value="<%=orgSearchWord%>" />

		<div class="board_count006">
			?????? <span class="blue1"><%=staticVO.getTotalCount()%></span>???
		</div>

		<div class="b_srchBox006">

			<!-- ?????????????????? -->

			<div class="b_srch006">
				<!-- ????????? -->
				<input class="b_srch_txt006" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" placeholder="????????? ???????????????" />
				<!-- ???????????? -->
				<input type="image" class="b_go_btn006" value="??????" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list')" />
			</div>

		</div>

		</form>
	</div>
	<!--cont_block S-->
	<div id="cont_block" style="margin-top: 20px">
			<table class="skin_list" style="width:50%;">
				<!-- colgroup s -->
			    <colgroup>
			      <col style="width:40%;" />
			      <col style="width:60%;" />
			    </colgroup>
				<!-- colgroup e -->

				<tbody>
				  <tr>
				    <th scope="col" class="number">?????? CI</th>
				    <th scope="col" class="b_notice">?????????</th>
				  </tr>
				  <tr>
				  	<td>
				  		<%if(!(ciFileSrc).equals(null) && !(ciFileSrc).equals("")){ %>
				  			<img src="<%=ciFileSrc%>" alt="<%=orgGrpNm%>" style="width:150px;height:50px;" />
						<%}else{ %>
							<img src="/img/no-image.gif" alt="????????? ??????" style="width:150px;height:50px;" />
						<%}%>
				  	</td>
				  	<td><%=orgGrpNm%></td>
				  </tr>
				</tbody>
			</table>

			<table class="skin_list">
				<!-- colgroup s -->
			    <colgroup>
			      <col style="width:10%;" />
			      <%-- <col style="width:30%;" /> --%>
			      <col style="width:30%;" />
			      <col style="width:20%;" />
			      <col style="width:20%;" />
			      <col style="width:20%;" />
			    </colgroup>
				<!-- colgroup e -->

				<!-- thead s -->
				<thead>
				  <tr>
				    <th scope="col" class="number">NO</th>
				   <!--  <th scope="col" class="b_notice">?????????</th> -->
				    <th scope="col" class="r_line_none2">?????????</th>
				    <th scope="col" class="r_line_none2">??????</th>
				    <th scope="col" class="lookup">??????</th>
				    <th scope="col" class="r_line_none file">?????????</th>
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
						<td class="number"><%=cont%></td>
						<%-- <td class="b_notice">
							<%=util.getStr(rs.get("ORG_GRP_NM"))%>
						</td> --%>
						<td class="r_line_none2">
							<%=util.getStr(rs.get("DATA02"))%>
						</td>
						<td class="r_line_none2" >
							<%=util.getStr(rs.get("DATA04"))%>
						</td>
						<td class="lookup">
							<%=util.getStr(rs.get("DATA05"))%>
						</td>

						<td class="r_line_none file">
								<a href="./sub.do?m=<%=m%>&amp;mode=view&amp;listMode=list&amp;orgSearchWord=<%=orgSearchWord%>&amp;searchWord=<%=searchWord%>&amp;orgGrpCd=<%=orgGrpCd%>&amp;boardIdx=<%=util.getStr(rs.get("ARTICLE_ID"))%>"><img src="/img/cont/ico_mid02_tab02.png" alt="???????????????" /></a>
						</td>
					</tr>
					<% cont--; } %>
				</tbody>
			</table>

	</div>
	<!--cont_block E-->


	<!--basic_listWrap E-->
		<div class="b_btn_area">

			<!-- class="btn_lft2"  -->
				<a href="./sub.do?m=<%=m%>&amp;mode=list&amp;listMode=orgList&amp;orgSearchWord=<%=orgSearchWord%>"><input type="button" class="btn_rgt" value="????????????"/></a>
		</div>
		<!--b_btn_area E-->


<%=util.getPaging(staticVO, nowPage)%>


<script type="text/javascript">
function goSubmit(mode,boardIdx,beforeBoardComIdx){

	if(mode == 'view'){
		$('#searchForm').attr('method','get');
	}

	if(mode == 'noticeView'){
		$('#beforeBoardComIdx').val(beforeBoardComIdx);
	}


	$('#boardIdx').val(boardIdx);
	$('#mode').val(mode);
	$('#searchForm').submit();
}

function sCheck(){
	alert("??? ?????? ??????????????????.");
}

$(document).ready(function() {
	$(window).resize(function(){
		winResize();
	});
	winResize();
});

function winResize(){
	var win_w = $(window).width();

	if(win_w < 1198 && win_w >= 768){ //????????? 1198 , 768 ???????????? 100%
		if($('#cont_block .skin_list colgroup col').size()<4){
			$('#cont_block .skin_list').find('col:eq(2)').after("<col style='width: 10%'>");
			$('#cont_block .skin_list').find('col:eq(3)').after("<col style='width: 10%'>");
		}
		$('#cont_block .skin_list tr').find('th:eq(2)').show();
		$('#cont_block .skin_list tr').find('th:eq(3)').show();
		$('#cont_block .skin_list tr').find('td:eq(2)').show();
		$('#cont_block .skin_list tr').find('td:eq(3)').show();


	}else if(win_w < 768){ //????????? 769 ???????????? 100%
		if($('#cont_block .skin_list colgroup col').size()>=4){
			$('#cont_block .skin_list').find('col:eq(3)').remove();
			$('#cont_block .skin_list').find('col:eq(3)').remove();
		}
		$('#cont_block .skin_list tr').find('td:eq(2)').hide();
		$('#cont_block .skin_list tr').find('td:eq(3)').hide();
		$('#cont_block .skin_list tr').find('th:eq(2)').hide();
		$('#cont_block .skin_list tr').find('th:eq(3)').hide();

	}else{ //???????????????
		//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //????????? td ?????????
		//$('#cont_block > .pub_list03_blog > ul').css('float','none');

	}

}

$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});
</script>