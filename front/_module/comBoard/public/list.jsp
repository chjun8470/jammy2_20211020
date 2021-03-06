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
<%@ page import="egovframework.jammy2.site.service.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(paramMap.get("m"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode")); //??????(?????????, ?????????, ???????????????)
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //???????????????
	
	SiteMenuVO siteMenuVO = (SiteMenuVO)request.getAttribute("SITE_MENU");
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");

	HashMap<Integer, SiteMenuVO> parntsSiteMenuVOList = new HashMap<Integer, SiteMenuVO>();

	//String sclas = util.getStr(paramMap.get("sclas")); //????????? ??????1
	//String allYN = util.getStr(paramMap.get("allYN")); //????????? ??????2

%>
	<!--list_top S-->
	<div class="list_top013">
	<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />

		<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
		<%-- <input type="hidden" name="sclas" id="sclas" value="<%=sclas%>" />
		<input type="hidden" name="allYN" id="allYN" value="<%=allYN%>" /> --%>


		<div class="board_count013">?????? <span class="blue1"><%=staticVO.getTotalCount()%></span>???</div>


			<div class="b_srchBox013">
                <label class="hide" for="searchType">????????????</label>
				<select name="searchType" id="searchType" class="b_select013">
					<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
					<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
					<option value="GROUP" <%if("GROUP".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>????????????</option>
				</select>

				<div class="b_srch013">
                    <label class="hide" for="searchWord">?????????</label>
					<input type="text" class="b_srch_txt013" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<input type="image" class="b_go_btn013" alt="??????" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list','image')" />
				</div>
			</div>
			<div class="list_sort">
				<% if("new_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
					<button class="sort01_over" id="pcont_block01_over" onclick="goSubmit('list', '<%=listMode%>', 'new_list')" title="??????????????? ??????(?????????)"><img src="/img/board/btn_order_new_ovr.gif" alt="?????????"/></button>
					<button class="sort02" id="pcont_block02" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')" title="??????????????? ??????"><img src="/img/board/btn_order_popularity.gif" alt="?????????" /></button>
					<button class="sort03" id="pcont_block03" onclick="goSubmit('list', '<%=listMode%>', 'down_list')" title="????????????????????? ??????"><img src="/img/board/btn_order_down.gif" alt="???????????????" /></button>
				<% } else if("popular_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
					<button class="sort01" id="pcont_block01" onclick="goSubmit('list', '<%=listMode%>', 'new_list')" title="??????????????? ??????"><img src="/img/board/btn_order_new.gif" alt="?????????"/></button>
					<button class="sort02_over" id="pcont_block02_over" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')" title="??????????????? ??????(?????????)"><img src="/img/board/btn_order_popularity_ovr.gif" alt="?????????"/></button>
					<button class="sort03" id="pcont_block03" onclick="goSubmit('list', '<%=listMode%>', 'down_list')" title="????????????????????? ??????"><img src="/img/board/btn_order_down.gif" alt="???????????????"/></button>
				<% } else { %>
					<button class="sort01" id="pcont_block01" onclick="goSubmit('list', '<%=listMode%>', 'new_list')" title="??????????????? ??????"><img src="/img/board/btn_order_new.gif" alt="?????????"/></button>
					<button class="sort02" id="pcont_block02" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')" title="??????????????? ??????"><img src="/img/board/btn_order_popularity.gif" alt="?????????"/></button>
					<button class="sort03_over" id="pcont_block03_over" onclick="goSubmit('list', '<%=listMode%>', 'down_list')" title="????????????????????? ??????(?????????)"><img src="/img/board/btn_order_down_ovr.gif" alt="???????????????"/></button>
				<% } %>
			</div>

			<div class="b_srchBox_gap013"><img src="/img/board/srch_box_gap.gif" alt=""/></div>
			<div class="b_btn_listBox013">
				<button type="button" class="b_btn_block013" onclick="goSubmit('list','image')"><img src="/img/board/btn_block.png" alt="??????????????????" /></button>
				<button type="button" class="b_btn_blog013" onclick="goSubmit('list','bloglist')"><img src="/img/board/btn_blog.png" alt="??????????????????" /></button>
				<button type="button" class="b_btn_list013" onclick="goSubmit('list','list')"><img src="/img/board/btn_list_ovr.png" alt="?????????(?????????)" /></button>
			</div>

	</form>
	</div>
	<!--list_top E-->

<!--cont_block S-->
<div id="cont_block">
<!--basic_listWrap S-->
<div class="basic_listWrap">
	<% if("new_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
		<h2 class="sound_only">????????? ??????</h2>
	<% } else if("popular_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
		<h2 class="sound_only">????????? ??????</h2>
	<% } else { %>
		<h2 class="sound_only">??????????????? ??????</h2>
	<% } %>
	<!-- skin_basic_list s -->
	<table class="skin_list" summary="<% if (siteMenuVO.getLvl() > 3) {%><%=parntsSiteMenuVOList.get(3).getMenuNm()%><%}else{%><%=siteMenuVO.getMenuNm()%><%}%> ????????? ????????? ???????????? ????????????..">
	<caption><% if (siteMenuVO.getLvl() > 3) {%><%=parntsSiteMenuVOList.get(3).getMenuNm()%><%}else{%><%=siteMenuVO.getMenuNm()%><%}%>  ????????? ??????</caption>
		<!-- colgroup s -->
		<colgroup>
			<col style="width: 10%;" />
			<col style="width: 55%;" />
			<col style="width: 15%;" />
			<col style="width: 10%;" />
			<col style="width: 10%;" />
		</colgroup>
		<!-- colgroup e -->
		<!-- thead s -->
		<thead>
			<tr>
				<th scope="col" class="number">??????</th>
				<th scope="col">??????</th>
				<th scope="col" class="r_line_none2 m_not">?????????</th>
				<th scope="col" class="lookup m_not">?????????</th>
				<th scope="col" class="r_line_none file">?????????</th>
			</tr>
		</thead>
		<!-- thead s -->
		<!-- tbody s -->
		<tbody>
			<%
				int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
						for(HashMap rs:dataList) {
			%>
			<tr>
				<td class="number"><%=cont%></td>
				<td class="b_notice">
					<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><%=util.getStr(rs.get("SUBJECT"))%></a>
				</td>
				<td class="r_line_none2 m_not">
					<%=util.getStr(rs.get("WRITER_ID"))%>
				</td>
				<td class="number m_not">
					<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
				</td>
				<td class="r_line_none file">
					<%=util.getStr(rs.get("HITS"))%>
				</td>
			</tr>
			<% cont--; }
					if(dataList.size() == 0){
				%>
					<tr><td colspan="5" class="r_line_none" >???????????? ???????????? ????????????</td></tr>
				<%
					}
				%>
		</tbody>
	</table>

	<div class="b_btn_area">
	&nbsp;
	<%--
	<% if(util.loginCheck()) { %>
		<div class="btn_right_box">
			<input type="button" class="btn_rgt" value="??????" onclick="goSubmit('write')"/>
		</div>
	<% } %>
	--%>
	</div>
</div>
<!--basic_listWrap E-->
</div>
<!--cont_block E-->

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,listMode,sortMode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		if(mode == "list" || mode == "view"){
	           $('#searchForm').attr('method','get');
	     }
		$('#searchForm').submit();
	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

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

</script>