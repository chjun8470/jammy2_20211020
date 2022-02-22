<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
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
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
	
	//out.println(loginVO);
	//out.println(paramMap);
	
%>

<div class="skin_list">

	<span class="excelBtn" onclick="location.href='?mode=write'">RSS업로드</span>

<form id = "searchForm" name = "searchForm" method="get" action="">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							
							<p>
								<label for="searchDate" class="hide">공고일 : </label>
								<input type="text" name="searchDate" id="searchDate" class="inp_text" value="<%=util.getStr(paramMap.get("searchDate")) %>" />
							</p>
							
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="TITLE" <%if(util.getStr(paramMap.get("searchType")).equals("TITLE")) { %> selected="selected" <% } %> >공고명</option>
								<option value="AUTHOR" <%if(util.getStr(paramMap.get("searchType")).equals("AUTHOR")) { %> selected="selected" <% } %>>공고기관</option>
							</select>
							<!-- 키워드 -->
							<label for="keyword" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
							<!-- 검색버튼 -->
							
							<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" style="float: right;" />
						</div>
						<!-- board-search -->
					 </div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 10px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 5%;" />
				<col/>
				<col style="width: 20%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">공고명</th>
					<th scope="col">공고기관</th>
					<th scope="col">공고일</th>			
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr onclick="detailRow('<%=util.getInt(rs.get("IDX"))%>')">
					<td><%=cont%></td>
					<td class="subject"><%=util.getStr(rs.get("TITLE"))%></td>
					<td><%=util.getStr(rs.get("AUTHOR"))%></td>
					<td><%=util.getStr(rs.get("PUBDATE"))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		
	</div>
	<%=util.getPaging(staticVO, nowPage) %>
</div>

<script>

function detailRow(idx){
	location.href="/sys/sys_rss_parser.do?mode=view&idx="+idx;
}

function pageSearchGo(){
	$('#mode').val('');
	$('#searchForm').submit();
}

$("#searchDate").datepicker({
	
	showMonthAfterYear : true,
   	showButtonPanel : true,
   	changeMonth : true,
   	changeYear : true,
   	nextText : '다음 달',
   	prevText : '이전 달',
   	minDate: '-100y',
   	closeText : '닫기',
   	dateFormat : "yy.mm.dd",
   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
   	dayNamesMin : ['월','화','수','목','금','토','일'],
   	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
   	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
   	onClose: function(dateText, inst) {
        //var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        //var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        //$(this).datepicker('setDate', new Date(year, month, 1));
    }
   	/* showButtonPanel:true,
	yearRange: '1980:2020' */
});

</script>
