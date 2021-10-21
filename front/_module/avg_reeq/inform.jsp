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
	ArrayList<HashMap<String, String>> ghouseDataList = request.getAttribute("ghouseDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("ghouseDataList");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dayList = request.getAttribute("dayList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dayList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String tab = util.getStr(paramMap.get("tab"));

%>
<%!
	public String Checked(String radioCheck, String selectValue){
		String check="";
		if(radioCheck.equals(selectValue))check="checked";
		return check;
	}
%>

<div class="tabBox" style="margin-top:30px;">
	<ul>
			<li class="<%if(tab.equals("build")){ %>on<%}%>" style="float:left;margin-left:10px;" onclick="goSubmit('build')"><a href="javascript:void(0);">장비구축</a></li>
			<li class="<%if(tab.equals("man")){ %>on<%}%>" style="float:left;margin-left:10px;" onclick="goSubmit('man')"><a href="javascript:void(0);">장비인력</a></li>
			<li class="<%if(tab.equals("uses")){ %>on<%}%>" style="float:left;margin-left:10px;" onclick="goSubmit('uses')"><a href="javascript:void(0);">공동활용</a></li>
			<li class="<%if(tab.equals("connect")){ %>on<%}%>" style="float:lef t;margin-left:10px;" onclick="goSubmit('connect')"><a href="javascript:void(0);">접속자</a></li>
	</ul>
</div>

<div class="list_top" style="margin-bottom:15px; margin-top:70px;">
	<div class="board_count">
		<h2 id="heaname"></h2>
		<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="tab" id="tab"  value="<%=tab %>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="m" value="<%=m%>" />
		</form>
		[전체 <span class="blue1"><%=staticVO.getTotalCount() %></span>건, <span class="blue1"><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]

		<!-- skin_basic_list s -->
		<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 15%;" />
				<col style="width: 14%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 14%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col" class="r_line_none2" id ="datanm" ></th>
					<th scope="col" class="number" id = "datacnt"></th>


				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dayList) {%>
				<tr>
					<td class="r_line_none2"><%=util.getStr(rs.get("AXIS"))%></td>
					<td class="number"><%=util.getStr(rs.get("CNT"))%></td>
				</tr>
			<%
				}
			%>

			</tbody>
		</table>
<%=util.getPaging(staticVO, nowPage) %>
		</div>
	</div>


<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
function goSubmit(tab){
	$('#tab').val(tab);
	$('#searchForm').submit();
}
$( document ).ready(function() {
	<%if(tab.equals("build")){%>
		$("#datanm").html("기관명");
 		$("#datacnt").html("건 수");
 		$("#heaname").html("장비구축");
 	<%} else if(tab.equals("man")){%>
 		$("#datanm").html("기관명");
		$("#datacnt").html("명 수");
		$("#heaname").html("장비인력");
 	<%} else if(tab.equals("uses")){%>
	 	$("#datanm").html("공동활용 장비명");
		$("#datacnt").html("건 수");
		$("#heaname").html("공동활용");
 	<%} else if(tab.equals("connect")){%>
	 	$("#datanm").html("일별");
		$("#datacnt").html("명 수");
		$("#heaname").html("접속자 통계");
	<%}%>
});
//]]>

</script>
