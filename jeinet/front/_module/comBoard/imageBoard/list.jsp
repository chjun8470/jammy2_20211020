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
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));

	String m = util.getStr(paramMap.get("m"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	if("".equals(listMode)) mode = "list";
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String noticeYn = util.getStr(boardMap.get("PERM_NOTICE"));

	int authLv = 0;
	if(loginVO.getAuthLv() != null) {
		authLv = Integer.parseInt(loginVO.getAuthLv());
	}

	int writeAuth = Integer.parseInt(boardMap.get("PERM_LVL_WRITE"));


%>
<div class="com_board_img" >
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

<select name="searchType" id="searchType" class="b_select005">
<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
</select>
	
<div class="b_srch005">
<input type="text" title="검색단어입력" name="searchWord" id="searchWord" class="b_srch_txt005" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
<input type="image" alt="바로가기" class="b_go_btn005" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list','image')" />
</div>
			
</div>

<div class="b_srchBox_gap005"><img src="/img/board/srch_box_gap.gif" alt="srch_box_gap"/></div>

<div class="b_btn_listBox005">
	<button type="button" class="b_btn_block005" onclick="goSubmit('list','image')"><img src="/img/board/btn_block.png" alt="이미지리스트" /></button>
	<button type="button" class="b_btn_blog005" onclick="goSubmit('list','imageList')"><img src="/img/board/btn_blog.png" alt="블러그리스트" /></button>
	<button type="button" class="b_btn_list005" onclick="goSubmit('list','list')"><img src="/img/board/btn_list_ovr.png" alt="리스트" /></button>
</div>

</form>
</div>
<!--list_top E-->

<!--cont_block S-->
<div id="cont_block">
<!--basic_listWrap S-->
<div class="basic_listWrap">

<table class="skin_list">
  <caption>번호, 제목, 작성일, 첨부, 조회로 구성된 표입니다.</caption>
    <colgroup>
      <col style="width:6%;" />
      <col style="width:58%;" />
      <col style="width:10%;" />
      <col style="width:12%;" />
      <col style="width:8%;" />
      <col style="width:5%;" />
    </colgroup>

<tbody>
  <tr>
    <th scope="col" class="number">번호</th>
    <th scope="col">제목</th>
    <th scope="col" class="r_line_none2">글쓴이</th>
    <th scope="col" class="r_line_none2">작성일</th>
    <th scope="col" class="lookup">조회수</th>
    <th scope="col" class="r_line_none file">첨부</th>
  </tr>
					<%
                           if(noticeYn.equals("Y")){
                                for(HashMap rs:noticeList) {
                     %>
                     <tr>
                           <td class="number"><img src="/img/board/ico_notice.png" alt="공지 아이콘" /></td>
                           <td class="b_notice" style="cursor:pointer;" onclick="goSubmit('noticeView','<%=util.getStr(rs.get("ARTICLE_ID"))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')">

								<%if(util.getStr(rs.get("SUBJECT")).length()>20){%>
									<%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%>
								<%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>

                           </td>
                           <td class="r_line_none2">
                                <%=util.getStr(rs.get("WRITER_NM"))%>(<%=util.getStr(rs.get("WRITER_ID"))%>)
                           </td>
                           <td class="r_line_none2">
                                <%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
                           </td>
                           <td class="lookup">
                                <%=util.getStr(rs.get("HITS"))%>
                           </td>
                           <td class="r_line_none file">
                          <%if(!(util.getStr(rs.get("FILE_ID"))).equals(null) && !(util.getStr(rs.get("FILE_ID"))).equals("")){
                                String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
                                                          +"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
                                                          +"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
                                %>
                     <a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>
                    <%}%>
                           </td>
                     </tr>
                     <%
                                }
                           }
                     %>


	<%
		int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
							for(HashMap rs:dataList) {
	%>
  <tr>
    <td class="number"><%=cont%></td>
    <td class="b_notice" style="cursor:pointer;" onclick="goSubmit('view','','<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><%=util.getStr(rs.get("SUBJECT"))%></a></td>
    <td class="r_line_none2"><%=util.getStr(rs.get("WRITER_ID"))%></td>
    <td class="r_line_none2"><%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%></td>
    <td class="lookup"><%=util.getStr(rs.get("HITS"))%></td>
    <td class="r_line_none file"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></td>
  </tr>

  <% cont--; } %>

</tbody>
</table>



<!--b_btn_area S-->
<div class="b_btn_area">
			&nbsp;
		<% if(util.loginCheck() && authLv >= writeAuth) { %>
			<button class="btn_rgt" onclick="goSubmit('write')">글쓰기</button>
			<% } else { %>
			<button class="btn_rgt" onclick="goLogin()">글쓰기</button>
			<% } %>
</div>
<!--b_btn_area E-->

</div>
<!--basic_listWrap E-->
</div>
<!--cont_block E-->
</div>
<%=util.getPaging(staticVO, nowPage)%>


<!--// bo_btn -->
<script type="text/javascript">
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
	
	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});
	
	function winResize(){
		var win_w = $(window).width();
		
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
			$('.b_btn_area .btn_rgt').css("margin-bottom","0px");
		
			if($('.basic_listWrap .skin_list colgroup col').size()<4){
				$('.basic_listWrap .skin_list').find('col:eq(2)').after("<col style='width: 10%'>");
				$('.basic_listWrap .skin_list').find('col:eq(3)').after("<col style='width: 10%'>");
			}
			$('.basic_listWrap .skin_list tr').find('th:eq(2)').show();
			$('.basic_listWrap .skin_list tr').find('th:eq(3)').show();
			$('.basic_listWrap .skin_list tr').find('td:eq(2)').show();
			$('.basic_listWrap .skin_list tr').find('td:eq(3)').show();
			
			
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$('.b_btn_area .btn_rgt').css("margin-bottom","10px");
		
			if($('.basic_listWrap .skin_list colgroup col').size()>=4){
				$('.basic_listWrap .skin_list').find('col:eq(3)').remove();
				$('.basic_listWrap .skin_list').find('col:eq(3)').remove();
			}
			$('.basic_listWrap .skin_list tr').find('td:eq(2)').hide();
			$('.basic_listWrap .skin_list tr').find('td:eq(3)').hide();
			$('.basic_listWrap .skin_list tr').find('th:eq(2)').hide();
			$('.basic_listWrap .skin_list tr').find('th:eq(3)').hide();
			
			
		}else{ //기본사이즈
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //네번째 td 없애기
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			
		}
		
	}
</script>