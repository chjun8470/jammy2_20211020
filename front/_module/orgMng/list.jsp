<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>


<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	List<HashMap<String, String>> userDataList = request.getAttribute("userDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("userDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));

	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

%>

<form id="searchForm" name="searchForm" method="post" action="/<%=request.getAttribute("SITE_ID") %>/sub.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "m" id = "m" value="<%=util.getStr(paramMap.get("m")) %>" />
			<input type="hidden" name = "mode" id = "mode" value="list" />
			<input type="hidden" name = "orgGrpCd" id = "orgGrpCd"  />
	<div class="list_top002">

		<div class="board_count002">
			?????? <span class="blue1"><c:out value="${totalCount}"/></span>???
		</div>

		<div class="b_srchBox002">
			<div class="b_srch002" style="float:right;">
                <label class="hide" for="orgGrpNm">???????????? ???????????????</label>
				<!--<input name="orgGrpNm" id="srch_txt" class="b_srch_txt002"  type="text" value="<%=util.getStr(paramMap.get("orgGrpNm")) %>" />-->
                <input name="orgGrpNm" id="orgGrpNm" class="b_srch_txt002"  type="text" value="<%=util.getStr(paramMap.get("orgGrpNm")) %>" />
				<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn002" alt="??????" onclick="submitGo()" />
			</div>
		</div>
	</div>
</form>

<!-- skin_basic_list s -->
	<div class="basic_listWrap">
		<table class="skin_list" summary="????????????????????????????????? ???????????? ????????? ???????????? ?????????, CI??????, ??????/?????????, ??????, ??????????????? ???????????? ????????????.">
          <caption>????????????????????????????????? ????????????</caption>
			<colgroup>
				<col style="width: 6%;" />
				<col style="width: 22%;" />
				<col style="width: 28%;" /> 
				<col style="width: 30%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">CI ??????</th>
					<th class="line_del_1" scope="col"><%=util.getStr(paramMap.get("userTp")).equals("2")?"??????":"??????" %>???</th>
					<th scope="col">??????</th>
					<th scope="col" class="r_line_none">?????? ??????</th>

				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${totalCount ne 0}">
						<c:forEach var="data" items="${dataMap}" varStatus="status">
						<%-- <tr style="cursor:pointer" onclick="pageViewGo('${data.ORG_GRP_CD}');"> --%>
						<tr>
							<td class="number">${totalCount-(((staticVO.nowPage-1)*staticVO.pageSize)+status.index)}</td>
							<td>
								<a href="javascript:pageViewGo('${data.ORG_GRP_CD}');" title="${data.ORG_GRP_NM} ?????? ????????????" >
							<c:choose>
								<c:when test="${data.CI_FILE_SRC eq null || data.CI_FILE_SRC eq ''}">
									<img src="/img/no-image.gif" alt="????????? ??????"  style="width:150px;height:50px" />
								</c:when>
								<c:otherwise>
									<img src="${data.CI_FILE_SRC}" alt="${data.ORG_GRP_NM}" style="width:150px;height:50px;" />
								</c:otherwise>
							</c:choose>
								</a>
							</td>
							<td class="line_del_1" >
								<a href="javascript:pageViewGo('${data.ORG_GRP_CD}');" title="${data.ORG_GRP_NM} ?????? ????????????" >
								${data.ORG_GRP_NM}
								</a>
							</td>
							<td>${data.ADDR1} ${data.ADDR2}</td>
							<td  class="r_line_none">${data.CORP_PHONE}</td>
						</tr>
						</c:forEach>
					</c:when>
					<c:when test="${totalCount eq 0}">
						<tr><td colspan='5'>????????? ????????? ????????????.</td></tr>
					</c:when>
					<c:otherwise>
						<tr><td colspan='5'>????????? ????????? ????????????.</td></tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>

	<div class="b_btn_area"></div>
	<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
//<![CDATA[
	function submitGo() {
		$('#mode').val('list');
		$('#searchForm').submit();
	}

	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
 		$('#orgGrpCd').val(idx);
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
			if($('.basic_listWrap .skin_list colgroup col').size()<4){
				$('.basic_listWrap .skin_list').find('col:eq(3)').after("<col style='width: 25%'>");
				$('.basic_listWrap .skin_list').find('col:eq(4)').after("<col style='width: 20%'>");
			}
			$('.basic_listWrap .skin_list tr').find('th:eq(3)').show();
			$('.basic_listWrap .skin_list tr').find('th:eq(4)').show();
			$('.basic_listWrap .skin_list tr').find('td:eq(3)').show();
			$('.basic_listWrap .skin_list tr').find('td:eq(4)').show();


		}else if(win_w < 768){ //????????? 769 ???????????? 100%
			if($('.basic_listWrap .skin_list colgroup col').size()>=4){
				$('.basic_listWrap .skin_list').find('col:eq(4)').remove();
				$('.basic_listWrap .skin_list').find('col:eq(3)').remove();
			}
			$('.basic_listWrap .skin_list tr').find('td:eq(3)').hide();
			$('.basic_listWrap .skin_list tr').find('td:eq(4)').hide();
			$('.basic_listWrap .skin_list tr').find('th:eq(3)').hide();
			$('.basic_listWrap .skin_list tr').find('th:eq(4)').hide();

		}else{ //???????????????
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //????????? td ?????????
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');

		}

	}

//]]>
</script>