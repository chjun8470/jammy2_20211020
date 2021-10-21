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
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));

	if("".equals(listMode)) mode = "list";
%>

	<!--list_top S-->
	<div class="list_top">
		<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
				<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
				<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
				<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />				
				<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
				<input type="hidden" name="m" id="m" value="<%=m%>" />


			<div class="board_count">전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건</div>
			<div class="publist_top_wrap02">

				<div class="b_srchBox srch_box" style="width:390px;">
					<select name="searchType" class="b_select" id="searchType" title="검색조건 선택">
						<option value="SUBJECT" <%=util.getStr(paramMap.get("searchType")).equals("SUBJECT")? "selected='selected'":""%>>제목</option>
						<option value="CONTENT" <%=util.getStr(paramMap.get("searchType")).equals("CONTENT")? "selected='selected'":""%>>내용</option>
					</select>
					<div class="b_srch wrt_box">
                        <label class="hide" for="searchWord">검색어를 입력하세요</label>
						<input id="searchWord" class="b_srch_txt" name="searchWord" type="text" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
						<input type="image" class="b_go_btn" alt="검색" src="/img/board/btn_ico_srch.png" onclick="goButton('list','list')" />
					</div>
				</div>
				<%if(m.equals("Y")){%>
					<div class="b_srchBox" style="width:280px;">
						<div class="board_count" style="padding-right:10px;"> 표시/미표시 :</div>
						<select name="outType" class="b_select" id="outType" title="검색조건 선택">
							<option value="" <%=util.getStr(paramMap.get("outType")).equals("")? "selected='selected'":""%>>전체</option>
							<option value="DISPLAY" <%=util.getStr(paramMap.get("outType")).equals("DISPLAY")? "selected='selected'":""%>>표시</option>
							<option value="HIDDEN" <%=util.getStr(paramMap.get("outType")).equals("HIDDEN")? "selected='selected'":""%>>미표시</option>
						</select>
					</div>
				<%}%>
			</div>
		</form>
	</div>
	<!--list_top E-->


	<!--cont_block S-->
	<div id="cont_block">
		<!--basic_listWrap S-->
		<div class="basic_listWrap">

			<table class="skin_list" summary="통합소식의 게시글 목록으로 글번호, 제목, 글쓴이, 등록일로 구성되어 있습니다.">
			<caption>통합소식</caption>
			<colgroup>
			  	<col style="width: 10%;" />
				<col style="width: 55%;" />
				<col style="width: 15%;" />
				<col style="width: 20%;" />
			</colgroup>

				<thead>
				  <tr>
				    <th scope="col" class="number">번호</th>
				    <th scope="col" class="b_notice">제목</th>
				    <th scope="col" class="r_line_none2">글쓴이</th>
				    <th scope="col" class="r_line_none">등록일</th>
				  </tr>
				</thead>
				<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(dataList.size() == 0){
				%>
					<tr><td class="r_line_none" colspan="4">데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:dataList) {

					  	String url = "/jntis/sub.do?m=99&amp;mode=view&amp;articleId="+util.getStr(rs.get("ARTICLE_ID"))+"";;
					  	
					  	String siteId = util.getStr(rs.get("SITE_ID"));			 
					  		
					  							  	
				 %>
					<tr onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'" >
					 <td class="number"><%=cont%></td>
					  <td class="b_notice">
						<a href="<%=url%>" title="<%=util.getStr(rs.get("SUBJECT"))%> 상세보기" >
					  	<%if(siteId.equals("jntis")){%>
					  	<img class="subject" src="/img/jntis/main/icon_jntis.png" alt="과학기술정보시스템 아이콘 박스" />
					  	<%}else if(siteId.equals("jipbank")){ %>
					  	<img class="subject" src="/img/jntis/main/icon_jipbank.png" alt="지식재산 아이콘 박스" />
					  	<%}else if(siteId.equals("jeinet")){ %>
					  	<img class="subject" src="/img/jntis/main/icon_jeinet.png" alt="연구장비 아이콘 박스" />
					  	<%} %>
					  	<%if(util.getStr(rs.get("SUBJECT")).length()>35){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 35)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
					  </td>
					  <td class="r_line_none2"><%=util.getStr(rs.get("WRITER_NM"))%></td>
					  <td class="r_line_none"><%=util.getStr(rs.get("REG_DT"))%></td>
					</tr>
			  	<%
				  	cont--;
				  	}
			 	%>
				</tbody>
			</table>
		</div>
		<!--basic_listWrap E-->
	</div>
	<!--cont_block E-->

	<!--b_btn_area S-->
	<div class="btn_box">
		<div class="b_btn_area">&nbsp;</div>
	</div>
	<!--b_btn_area E-->
	<%=util.getPaging(staticVO, nowPage)%>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){

		// 관리자(back)화면일때 action값 변경
		var m = $('#m').val();
		var myPage = $('#myPage').val();

		if(m == 'Y'){
			$('#searchForm').attr("action",myPage);
		}

	});


	/* function goSubmit(mode,idx){

		$('#uid').val(idx);
		$('#mode').val(mode);
		var m = $('#m').val();
		var myPage = $('#myPage').val();

		if(m == 'Y'){
			// 관리자(back)화면일때 action값 변경
			$('#searchForm').attr("action",myPage);
		}else{
			if(mode == "view"){
				$('#searchForm').attr("method","get");
			}
		}

		$('#searchForm').submit();

	} */

	function goButton(mode,listMode){
		var m = $('#m').val();
		var myPage = $('#myPage').val();

		$('#listMode').val(listMode);
	    $('#mode').val(mode);

		if(m == 'Y'){
			// 관리자(back)화면일때 action값 변경
			$('#searchForm').attr("action",myPage);
			$('#searchForm').submit();
		}else{
			$('#searchForm').submit();
		}
  	}
	//]]>
</script>