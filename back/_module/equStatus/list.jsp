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
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
%>


<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_equ_status.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" value="list" />
			<input type="hidden" name = "rndEquIdx" id = "rndEquIdx" />
			<input type="hidden" name = "tmenu" id = "tmenu" value="2"/>
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<label for="equCd" >분류 : </label>
							<select name="equCd" id="equCd" class="select" style="height: 24px">
								<option value="" >전체</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("equCd")))) {%> selected="selected" <%}%>>장비</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("equCd")))) {%> selected="selected" <%}%>>시설</option>
							</select>

							<label for="takeCd" >취득방법 : </label>
							<select name="takeCd" id="takeCd" class="select" style="height: 24px">
								<option value="" >전체</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("takeCd")))) {%> selected="selected" <%}%>>구매</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("takeCd")))) {%> selected="selected" <%}%>>개발</option>
							</select>

							<label for="scope" >활용범위 : </label>
							<select name="scope" id="scope" class="select" style="height: 24px">
								<option value="" >전체</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("scope")))) {%> selected="selected" <%}%>>단독활용</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("scope")))) {%> selected="selected" <%}%>>공동활용허용</option>
								<option value="3" <%if("3".equals(util.getStr(paramMap.get("scope")))) {%> selected="selected" <%}%>>공동활용서비스</option>
							</select>

							<label for="disUse">장비상태</label>
							<select name="disUse" id="disUse" class="select" style="height: 24px">
								<option value="" >전체</option>
								<option value="01" <%if("01".equals(util.getStr(paramMap.get("disUse")))) {%> selected="selected" <%}%>>활용</option>
								<option value="02" <%if("02".equals(util.getStr(paramMap.get("disUse")))) {%> selected="selected" <%}%>>저활용</option>
								<option value="03" <%if("03".equals(util.getStr(paramMap.get("disUse")))) {%> selected="selected" <%}%>>유휴</option>
								<option value="04" <%if("04".equals(util.getStr(paramMap.get("disUse")))) {%> selected="selected" <%}%>>불용(처분)</option>
							</select>

							<label for="searchType" class="hide">검색종류선택</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="">선택</option>
								<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>장비/시설명</option>
								<option value="manufacture" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>모델명</option>
								<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>키워드</option>
							</select>
							<!-- 키워드 -->
							<label for="keyword" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord"))%>" />

							<!-- 검색버튼 -->
							<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" />
						</div>
						<!-- board-search e -->
					</div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 5px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<!-- <span style="float: right; margin-bottom: 5px;">
					<button type="button" id="excelUp" onclick="location.href='/sys/sys_use_status.do'" class="btn_inp_b_01">공동활용실적 업로드</button>
					<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="location.href='/sys/sys_equ_oper_diary.do'">운영일지작성</button>
				</span> -->
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">시설장비분류</th>
					<th scope="col">고정자산관리번호</th>
					<th scope="col">장비/시설명</th>
					<th scope="col">모델명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr>
						<td><%=cont%></td>
						<td><%=util.getStr(rs.get("EQUIP_CD")).equals("1")?"연구장비":"연구시설"%></td>
						<td><%=util.getStr(rs.get("FIXED_ASET_NO_YN")).equals("Y") ? "사용하지 않음.":util.getStr(rs.get("FIXED_ASET_NO"))%></td>
						<td><%=util.getStr(rs.get("KOR_NM"))%>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
						<td><%=util.getStr(rs.get("MODEL_NM")).equals("") ? "모델명 없음":util.getStr(rs.get("MODEL_NM"))%></td>
					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='5'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}

	function onKeyDown()
	{
	     if(event.keyCode == 13)
	     {
	    	$('#mode').val('list');
	 		$('#searchForm').submit();
	     }
	}
</script>


<!--// bo_btn -->
