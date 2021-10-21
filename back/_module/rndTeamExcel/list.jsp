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

	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> rndExcelDataList = request.getAttribute("rndExcelDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndExcelDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>

<div class="skin_list">

	<span class="excelBtn" onclick="location.href='?mode=write'">엑셀업로드</span>

<form id = "searchForm" name = "searchForm" method="post">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<select name="searchMain" id="searchMain" class="select" style="height: 24px">
								<option value="">분류전체</option>
								<option value="scienceB" <%if(util.getStr(paramMap.get("searchMain")).equals("scienceB")) { %> selected="selected" <% } %> >과학기술표준분류</option>
								<option value="emphasisB" <%if(util.getStr(paramMap.get("searchMain")).equals("emphasisB")) { %> selected="selected" <% } %>>중점과학기술분류</option>
								<option value="6TB" <%if(util.getStr(paramMap.get("searchMain")).equals("6TB")) { %> selected="selected" <% } %>>6T관련기술분류</option>
							</select>
							<select name="searchSub" id="searchSub" class="select" style="height: 24px">
								<option value="">분류선택</option>
							</select>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="COM_NM" <%if(util.getStr(paramMap.get("searchType")).equals("COM_NM")) { %> selected="selected" <% } %> >사업명</option>
								<option value="COM_TEAM" <%if(util.getStr(paramMap.get("searchType")).equals("COM_TEAM")) { %> selected="selected" <% } %>>부처명</option>
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
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">사업명</th>
					<th scope="col">부처명</th>
					<th scope="col">지역</th>
					<th scope="col">과학기술표준분류(대)</th>
					<th scope="col">중점과학기술분류(대)</th>
					<th scope="col">6T관련기술(대)</th>
					<th scope="col">사업비</th>					
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:rndExcelDataList) {%>
				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("COM_NM"))%></td>
					<td><%=util.getStr(rs.get("COM_TEAM"))%></td>
					<td><%=util.getStr(rs.get("AR_NM"))%></td>
					<td><%=util.getStr(rs.get("S_TYPE_A1"))%></td>
					<td><%=util.getStr(rs.get("SIC_TYPE1"))%></td>
					<td><%=util.getStr(rs.get("T6_TYPE1"))%></td>
					<td><%=util.getComma(String.valueOf(rs.get("SUM_PRICE")))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<!-- div class="bbs_btn">
			<input class="btn_inp_b_01" type="button" onclick="location.href='/sys/sys_rnd_team.do'" value="등록" />
		</div-->
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">

	var searchSub = "<%=util.getStr(paramMap.get("searchSub"))%>";
	
	if(searchSub != ""){
		var codeX = "<%=util.getStr(paramMap.get("searchMain"))%>";
		var mode = "ajax";
		
		$.post("/sys/smbRndTeamExcel.do",{mode:mode, codeX:codeX},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("#searchSub").find("option").remove().end().append("<option value=''>분류선택</option>");
				//$("#code_s").find("option").remove().end().append("<option value=''>산업기술소분류</option>");
				
				$.each(data.dataList,function(idx,obj){
					var selected = (obj.CODE_NM == searchSub)?"selected":"";
					html += "<option value='"+obj.CODE_NM+"' "+selected+">"+obj.CODE_NM+"</option>";
				});
				$("#searchSub").append(html);
			}
		},"JSON");
	}

	$("#searchMain").on("change",function(){
		var codeX = $(this).val();
		var mode = "ajax";
		
		$.post("/sys/smbRndTeamExcel.do",{mode:mode, codeX:codeX},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("#searchSub").find("option").remove().end().append("<option value=''>분류선택</option>");
				//$("#code_s").find("option").remove().end().append("<option value=''>산업기술소분류</option>");
				
				$.each(data.dataList,function(idx,obj){
					html += "<option value='"+obj.CODE_NM+"'>"+obj.CODE_NM+"</option>";
				});
				$("#searchSub").append(html);
			}
		},"JSON");
		
		
	});



	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#moduleInfoIdx').val(idx);
		$('#searchForm').submit();
	}
</script>


<!--// bo_btn -->
