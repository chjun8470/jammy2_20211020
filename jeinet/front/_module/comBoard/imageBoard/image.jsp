<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(paramMap.get("m"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	if("".equals(listMode)) mode = "list";
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));

	int authLv = 0;
	if(loginVO.getAuthLv() != null) {
		authLv = Integer.parseInt(loginVO.getAuthLv());
	}

	int writeAuth = Integer.parseInt(boardMap.get("PERM_LVL_WRITE"));

%>
<div class="img_list">
<!--list_top S-->
<div class="list_top005">
<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="m" id="m" value="<%=m%>" />

<div class="board_count005">?????? <span class="blue1"><%=staticVO.getTotalCount()%></span>???</div>


<div class="b_srchBox005">

<select name="searchType" id="searchType" class="b_select005">
<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
</select>
	
<div class="b_srch005">
<input type="text" title="??????????????????" name="searchWord" id="searchWord" class="b_srch_txt005" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
<input type="image" alt="????????????" class="b_go_btn005" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list','image')" />
</div>
			
</div>

<div class="b_srchBox_gap005"><img src="/img/board/srch_box_gap.gif" alt="srch_box_gap"/></div>

<div class="b_btn_listBox005">
	<button type="button" class="b_btn_block005" onclick="goSubmit('list','image')"><img src="/img/board/btn_block_ovr.png" alt="??????????????????" /></button>
	<button type="button" class="b_btn_blog005" onclick="goSubmit('list','imageList')"><img src="/img/board/btn_blog.png" alt="??????????????????" /></button>
	<button type="button" class="b_btn_list005" onclick="goSubmit('list','list')"><img src="/img/board/btn_list.png" alt="?????????" /></button>
</div>

</form>
</div>
<!--list_top E-->


<!--cont_list S-->
<div id="cont_block">
<!--basic_listWrap S-->
	<div class="skin_list_img">
		<%
		int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
		int num = 1;
		if(dataList.size()>0){
		%>
		<ul>
		<% for(HashMap rs:dataList) {
			int fileCnt = 1;
				String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
									+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
									+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
		%>
			<li style="margin-right:18px;">
					<div class="info_agency">
						<div class="logo_agency">
							<p style="cursor:pointer;" onclick="goSubmit('view','<%=listMode %>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
							<%if(util.getStr(rs.get("FILE_ID")).equals("") || util.getStr(rs.get("FILE_ID")).equals(null)){ %>
								<img  width="180" height="140" src="/img/main/no_image01.gif" alt="????????? ??????"/>
							<%}else{%>
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" alt="?????????<%=cont%>"/>
							<%}%>
							</p>
						</div>
						<div class="cont_agency">
							<p class="name_agency" style="cursor:pointer;" onclick="goSubmit('view','<%=listMode %>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
									<%if(util.getStr(rs.get("SUBJECT")).length()>12){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 11)+" ??????"%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
							</p>
							<p>????????? : <%=util.getStr(rs.get("WRITER_ID"))%></p>
							<p>????????? : <%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%></p>
							<p>????????? : <%=util.getStr(rs.get("HITS"))%></p>
						</div>
					</div>

			</li>
			<% if(num%5 == 0) { %><br/><% }
			num++; cont--;
		}%>
		</ul>
		<%
		}else{%>
 			 <p style="text-align: center;">???????????? ????????????.</p>
		<%}%>


		<!--b_btn_area S-->
		<div class="b_btn_area">
			&nbsp;
			<% if(util.loginCheck() && authLv >= writeAuth) { %>
			<button class="btn_rgt" onclick="goSubmit('write')">?????????</button>
			<% } else { %>
			<button class="btn_rgt" onclick="goLogin()">?????????</button>
			<% } %>
		</div>
		<!--b_btn_area E-->

	</div>
	<!--basic_listWrap E-->
</div></div>
<!--cont_list E-->

<%=util.getPaging(staticVO, nowPage)%>

<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,listMode,boardIdx){

		if(mode == 'view'){

				$('#searchForm').attr('method','get');
		}
		$('#boardIdx').val(boardIdx);
		$('#listMode').val(listMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

	function goLogin() {
		alert("???????????? ???????????????.");
		javascript:ssoPopupShow('login');
	}

	$(function(){
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});
	
	
	
	function winResize(){
		var win_w = $(window).width();
		if(win_w < 1198 && win_w >= 768){ //?????????
			
			//
			$('#cont_block > .skin_list_img > ul').css('float','none');	
			$('#cont_block > .skin_list_img > ul').css('width','100%');
			$('#cont_block > .skin_list_img > ul').css('margin','0px auto');
			$('#cont_block > .skin_list_img > ul').css('max-width','1198px');
			$('#cont_block > .skin_list_img > ul').css('width','768px');
			$('#cont_block > .skin_list_img > ul').css('padding-left','40px');
			
		}else if(win_w < 768){ //?????????
			$('#cont_block > .skin_list_img > ul').css('float','none');	
			$('#cont_block > .skin_list_img > ul').css('width','100%');
			$('#cont_block > .skin_list_img > ul').css('margin','0px auto');
			$('#cont_block > .skin_list_img > ul').css('min-width','320px');
			$('#cont_block > .skin_list_img > ul').css('max-width','768px');
			$('#cont_block > .skin_list_img > ul').css('padding-left','40px');
		}else{ //???????????????
			//
			$('#cont_block > .skin_list_img > ul').css('float','none');	
			$('#cont_block > .skin_list_img > ul').css('width','100%');
			$('#cont_block > .skin_list_img > ul').css('margin','0px auto');
			$('#cont_block > .skin_list_img > ul').css('width','100%');
		
		}
		
	}
//]]>
</script>