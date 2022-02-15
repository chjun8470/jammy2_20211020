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
	ArrayList<HashMap<String, String>> rndNationExcelDataList = request.getAttribute("rndNationExcelDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndNationExcelDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	int rndYear = Integer.parseInt(sf.format(nowTime));
	
%>

<div class="skin_list">
	<span class="excelBtn" onclick="location.href='?mode=write'">엑셀업로드</span>
	
	<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_nation_rnd_write.do">
		<input type="hidden" name = "nowPage" id = "nowPage" />
		<input type="hidden" name = "mode" id = "mode" />
		<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
			<div class="basic_grid">
				<div class="search_box" style="padding:10px">
					<div class="board-search">
						
						<select name="searchYear" id="searchYear" class="select">
							<option value="">::년도선택::</option>
							<%
								String selected = ""; 
								for(int i=rndYear; i>1950; i--){
									selected = util.getInt(paramMap.get("searchYear")).equals(i)?"selected":"";
									out.println("<option value='"+i+"' "+selected+">"+i+"년</option>");
								}
							%>
						</select>					
					
						<select name="searchType" id="searchType" class="select">
							<option value="EX_1" <%if(util.getStr(paramMap.get("searchType")).equals("EX_1")) { %> selected="selected" <% } %> >부처명</option>
							<option value="EX_3" <%if(util.getStr(paramMap.get("searchType")).equals("EX_3")) { %> selected="selected" <% } %>>사업명</option>
							<option value="EX_4" <%if(util.getStr(paramMap.get("searchType")).equals("EX_4")) { %> selected="selected" <% } %>>내역사업명</option>
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
				<col style="width: 10%;" />
				<col style="width: 30%;" />
				<col style="width: 35%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">부처</th>
					<th scope="col">사업명</th>
					<th scope="col">내역사업명</th>
					<th scope="col">접수시작일</th>
					<th scope="col">접수마감일</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:rndNationExcelDataList) {%>
				<tr onclick="location.href='?mode=view&IDX=<%=util.getStr(rs.get("IDX"))%>'">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("EX_1"))%></td>
					<td style="text-align:left;"><%=util.getStr(rs.get("EX_3"))%></td>
					<td style="text-align:left;"><%=util.getStr(rs.get("EX_4"))%></td>
					<td><%=util.getStr(rs.get("EX_6"))%></td>
					<td><%=util.getStr(rs.get("EX_7"))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<div class="bbs_btn">
			<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="goExcel()">엑셀다운로드</button>
		</div>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#moduleInfoIdx').val(idx);
		$('#searchForm').submit();
	}
	
	
	function goExcel(){
		
		if($("#searchYear").val() == ""){
			alert("다운받을 년도를 선택하세요");
			$("#searchYear").focus();
			return false;
		}
		
		$('#searchForm').attr("action","/sys/smbNationRndExcelListDown.do");
		$('#searchForm').submit();
		$('#searchForm').attr("action","");
	}
	
</script>





</body>
</html>