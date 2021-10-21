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
	String listMode = util.getStr(paramMap.get("listMode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String orgSearchWord = util.getStr(paramMap.get("orgSearchWord"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	</script>
<%
		return;
	}
%>

	<div class="list_top006">
		<form class="boardSearch" name="searchForm" id="searchForm" action="sub.do"  method="post">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />

		<div class="board_count006">
			전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
		</div>

		<div class="b_srchBox002">
			<div class="b_srch002" style="float:right;">
				<input id="orgSearchWord" class="b_srch_txt002" name="orgSearchWord"  value="<%=orgSearchWord%>" type="text" title="기관명" placeholder="기관명을 입력하세요"/>
				<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn002" alt="바로가기" />
			</div>
		</div>

		</form>
	</div>

	<!--cont_block S-->
	<div id="cont_block" style="margin-top: 20px">

			<table class="skin_list">
				<!-- colgroup s -->
			    <colgroup>
			     <col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 35%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
			    </colgroup>
				<!-- colgroup e -->

				<!-- thead s -->
				<thead>
				 <tr>
					<th scope="col">NO</th>
					<th scope="col">CI 로고</th>
					<th scope="col">기관명</th>
					<th scope="col">대표전화</th>
					<th scope="col" class="r_line_none">담당자보기</th>
				</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

						if(dataList.size() == 0){
					%>
						<tr><td class="r_line_none" colspan="5">데이터가 존재하지 않습니다</td></tr>
					<%
						}

						for(HashMap rs:dataList) {
					%>
					<tr>
						<td class="number"><%=cont%></td>
						<td class="b_notice">
							<%if(!(util.getStr(rs.get("CI_FILE_SRC"))).equals("") && !(util.getStr(rs.get("CI_FILE_SRC"))).equals(null)){ %>
								<img src="<%=util.getStr(rs.get("CI_FILE_SRC"))%>" alt="<%=util.getStr(rs.get("CI_FILE_TITLE"))%>" style="width:150px;height:50px;" />
							<%}else{ %>
								<img src="/img/no-image.gif" alt="이미지 없음" style="width:150px;height:50px;" />
							<%}%>

						</td>
						<td class="r_line_none2">
							<%=util.getStr(rs.get("ORG_GRP_NM"))%>
						</td>
						<td class="r_line_none2" >
							<%=util.getStr(rs.get("CORP_PHONE"))%>
						</td>
						<td class="r_line_none">
							<a href="./sub.do?m=<%=m%>&amp;mode=list&amp;listMode=list&amp;orgSearchWord=<%=orgSearchWord%>&amp;searchWord=<%=searchWord%>&amp;orgGrpCd=<%=util.getStr(rs.get("ORG_GRP_CD"))%>"><img src="/img/cont/icon_main04.png" alt="담당자보기" /></a>
						</td>
					</tr>
					<% cont--; } %>
				</tbody>
			</table>

	</div>
	<!--cont_block E-->


<%=util.getPaging(staticVO, nowPage)%>


<script type="text/javascript">
function goSubmit(mode,boardIdx,beforeBoardComIdx){

	//alert("mode: "+mode+"  boardIdx: "+boardIdx+"  boardComIdx:: "+beforeBoardComIdx);
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
	alert("이 글은 비밀글입니다.");
}

$(document).ready(function() {
	$(window).resize(function(){
		winResize();
	});
	winResize();
});

function winResize(){
	var win_w = $(window).width();

	if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
		if($('#cont_block .skin_list colgroup col').size()<4){
			$('#cont_block .skin_list').find('col:eq(2)').after("<col style='width: 10%'>");
			$('#cont_block .skin_list').find('col:eq(3)').after("<col style='width: 10%'>");
		}
		$('#cont_block .skin_list tr').find('th:eq(2)').show();
		$('#cont_block .skin_list tr').find('th:eq(3)').show();
		$('#cont_block .skin_list tr').find('td:eq(2)').show();
		$('#cont_block .skin_list tr').find('td:eq(3)').show();


	}else if(win_w < 768){ //모바일 769 이하일때 100%
		if($('#cont_block .skin_list colgroup col').size()>=4){
			$('#cont_block .skin_list').find('col:eq(3)').remove();
			$('#cont_block .skin_list').find('col:eq(3)').remove();
		}
		$('#cont_block .skin_list tr').find('td:eq(2)').hide();
		$('#cont_block .skin_list tr').find('td:eq(3)').hide();
		$('#cont_block .skin_list tr').find('th:eq(2)').hide();
		$('#cont_block .skin_list tr').find('th:eq(3)').hide();

	}else{ //기본사이즈
		//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //네번째 td 없애기
		//$('#cont_block > .pub_list03_blog > ul').css('float','none');

	}

}

$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});
</script>