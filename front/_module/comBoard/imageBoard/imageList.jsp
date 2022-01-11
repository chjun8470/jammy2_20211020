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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
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
<div class="com_board_imglist" >
<!--list_top S-->
<div class="list_top005">
<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="m" id="m" value="<%=m%>" />

<div class="board_count005">전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건</div>


<div class="b_srchBox005">

<select name="searchType" id="searchType" class="b_select005" title="검색조건 선택">
<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
</select>
	
<div class="b_srch005">
<label class="hide" for="searchWord">검색어를 입력하세요</label>
<input type="text" name="searchWord" id="searchWord" class="b_srch_txt005" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
<input type="image" alt="검색" class="b_go_btn005" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list','image')" />
</div>
			
</div>

<div class="b_srchBox_gap005"><img src="/img/board/srch_box_gap.gif" alt="srch_box_gap"/></div>

<div class="b_btn_listBox005">
	<button type="button" class="b_btn_block005" onclick="goSubmit('list','image')" title="이미지리스트"><img src="/img/board/btn_block.png" /></button>
	<button type="button" class="b_btn_blog005" onclick="goSubmit('list','imageList')" title="블러그리스트"><img src="/img/board/btn_blog_ovr.png" /></button>
	<button type="button" class="b_btn_list005" onclick="goSubmit('list','list')" title="리스트"><img src="/img/board/btn_list.png" /></button>
</div>

</form>
</div>
<!--list_top E-->
<div class="pub_list03" id="cont_block">
	<ul class="pub_list03_blog">
	<%
		int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
		if(dataList.size()>0){
		%>
			<%for(HashMap rs:dataList) {
				if(fileList.size() > 0){
					String title ="";
					for(HashMap rs2:fileList){
						if((util.getStr(rs2.get("DATA_IDX"))).equals(util.getStr(rs.get("ARTICLE_ID")))){
							title = util.getStr(rs2.get("TITLE"));
						}
					}
			%>
			<li>
				<p class="img_publist03_blog" style="width:194px;height:154px" >
					<a href="javascript:goSubmit('view','imageList','<%=util.getStr(rs.get("ARTICLE_ID"))%>')" title="<%=util.getStr(rs.get("SUBJECT"))%> 상세보기" >
						<%if(util.getStr(rs.get("FILE_ID")).equals("") || util.getStr(rs.get("FILE_ID")).equals(null)){ %>
							<img  style="width:194px;height:154px" src="/img/main/no_image01.gif" alt="이미지 없음"/>
						<%}else{%>
							<img  style="width:194px;height:154px" src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" alt="<%=util.getStr(rs.get("SUBJECT")).length()>12?util.getStr(rs.get("SUBJECT")).substring(0, 11):util.getStr(rs.get("SUBJECT")) %>" />
						<%}%>
					</a>
				</p>
				<div class="explanation" >
					
						<p class="tit_publist03_blog01" >
					<a href="javascript:goSubmit('view','imageList','<%=util.getStr(rs.get("ARTICLE_ID"))%>')" title="<%=util.getStr(rs.get("SUBJECT"))%> 상세보기" >
						<%if(util.getStr(rs.get("SUBJECT")).length()>20){%>
							<%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%>
						<%}else{%>
							<%=util.getStr(rs.get("SUBJECT"))%>
						<%}%>
					</a>
						</p>
					<p class="txt_publist03_blog01" >작성자 : <%=util.getStr(rs.get("WRITER_ID"))%> / 작성일  : <%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%> / 조회 : <%=util.getStr(rs.get("HITS"))%></p>
					<p class="txt_publist03_blog02"><%=util.getStr(String.valueOf(rs.get("CONTENT")).replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""))%></p>
				</div>
			</li>
	<% cont--;}}%>
	<%
	}else{%>
			 <li style="text-align: center;">데이터가 없습니다.</li>
	<%}%>
		</ul>
		<div class="b_btn_area">
		<% if(util.loginCheck() && authLv >= writeAuth) { %>
			<button class="btn_rgt" onclick="goSubmit('write')">글쓰기</button>
			<% }  %>
		</div>
</div>

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
		alert("로그인이 필요합니다.");
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
		
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
		
			$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			$('#cont_block > .pub_list03_blog > ul').css('width','100%');
			$('#cont_block > .pub_list03_blog > ul').css('margin','0px auto');
			$('#cont_block > .pub_list03_blog > ul').css('width','768px');
			
			$('#cont_block > .pub_list03_blog > ul').css('padding-left','40px');
			
					
			$('.txt_publist03_blog02').css({'overflow':'hidden','text-overflow':'ellipsis'});

			
		}else if(win_w < 768){ //모바일 769 이하일때 100% 
			
			$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			$('#cont_block > .pub_list03_blog > ul').css('width','100%');
			$('#cont_block > .pub_list03_blog > ul').css('margin','0px auto');
			$('#cont_block > .pub_list03_blog > ul').css('min-width','320px');
			$('#cont_block > .pub_list03_blog > ul').css('max-width','768px');
			
			$('#cont_block > .pub_list03_blog > ul').css('padding-left','40px');
			$('#cont_block > .pub_list03_blog > ul > li').css('overflow','hidden');
			
			$('.txt_publist03_blog02').css('overflow','hidden');
			$('.txt_publist03_blog02').css('text-overflow','ellipsis');
			
			///$('.explanation > .txt_publist03_blog02').css('height','90px');
			//$('.txt_publist03_blog02').css('white-space','nowrap');
			
			
		}else{ //기본사이즈
			//
			$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			$('#cont_block > .pub_list03_blog > ul').css('width','100%');

		
		}
		
	}
	//]]>
</script>