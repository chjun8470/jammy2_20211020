<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> publicTypeList = request.getAttribute("publicTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("publicTypeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	/* 대표이미지 출력때문에 필요 imagelist, bloglist에서 필요 */
	//String fileGrp = "public";
	//String fileSubGrp = "";
	//String fileFullGrp =fileGrp+fileSubGrp;

	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String ArrayCheck = util.getStr(paramMap.get("ArrayCheck")); // 게시판분류 체크값 담아두는곳
	if("".equals(listMode)) mode = "list";
%>

<div class="skin_list">
	<div>
		<form action="?<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="ArrayCheck" id="ArrayCheck" value="<%=ArrayCheck%>" />


			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search" style="line-height:27px;">
					<div style="position:relative;clear:both;">
						<label  for="searchState">접수상태 :</label>
						<select class="select" name="searchState" id="searchState" style="height: 24px;">
							<option value="">전체</option>
							<option value="10" <%if("10".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인요청</option>
							<option value="20" <%if("20".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인</option>
							<option value="30" <%if("30".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인거절</option>
						</select><br>

						<!-- 검색종류선택 -->
						<label  for="searchType" >검색구분 :</label>
						<select name="searchType" id="searchType" class="select" style="height: 24px;">
							<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
							<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
							<option value="GROUP" <%if("GROUP".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>발행기관</option>
						</select>

						<!-- 키워드 -->
						<input type="text" class="inp_txt" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:74%;" />

						<!-- 검색버튼 -->
						<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" style="float:right"/>
					</div>
				</div>
				<!-- board-search e -->
			</div>
			</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]

				<!--이미지리스트 버튼-->
				<input type="button" class="btn_inp_w_01" value="이미지리스트" style="float:right;" onclick="goSubmit('list','imagelist')"/>

				<%--
				<div class="btn_right_box">
					<input type="button" class="btn_inp_w_01" value="최신순" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"/>
					<input type="button" class="btn_inp_w_01" value="인기순" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"/>
					<input type="button" class="btn_inp_w_01" value="다운로드순" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"/>
					<input type="button" class="btn_inp_w_01" value="리스트" onclick="goSubmit('list', 'list', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="이미지리스트" onclick="goSubmit('list','imagelist', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="블로그리스트" onclick="goSubmit('list','bloglist', '<%=sortMode%>')"/>
				</div>
				--%>
			</div>

		</form>
		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 8%;" />
				<col style="width: 8%;" />
				<col style="width: 14%;" />
				<col style="width: 27%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 8%;" />
				<col style="width: 10%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">사이트</th>
					<th scope="col">게시판분류</th>
					<th scope="col">제목</th>
					<th scope="col">발행기관</th>
					<th scope="col">발행일</th>
					<th scope="col">조회수</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(dataList.size() == 0){
				%>
					<tr><td colspan="8">데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("SITE_ID"))%></td>
					<td>
						<% if(rs.get("DATA03").equals("POLICY")) { %> 정책이슈
						<% } else if(rs.get("DATA03").equals("LAWORD")) { %> 관련법령
						<% } else if(rs.get("DATA03").equals("STATS")) { %> 통계자료
						<% } else if(rs.get("DATA03").equals("TECHNOLOGY")) { %> 기술자료
						<% } else if(rs.get("DATA03").equals("MENUAL")) { %> 연구장비 메뉴얼
						<% } else if(rs.get("DATA03").equals("BROCHURE")) { %> 연구장비 브로슈어
						<% } else if(rs.get("DATA03").equals("SCIENCE")) { %> 과학기술정보
						<% } else if(rs.get("DATA03").equals("INDUSTRIAL")) { %> 산업기술자료
						<% } else if(rs.get("DATA03").equals("EXCELLENCE")) { %> 우수기술
						<% } else if(rs.get("DATA03").equals("KICT")) { %> KICT우수기술
						<% } else { %> 발간물   <% } %>
					</td>
					<td class="subject">
						<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
							<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
					</td>
					<td>
						<%if(util.getStr(rs.get("DATA04")).length()>8){%><%=util.getStr(rs.get("DATA04")).substring(0, 8)+" · · · "%><%}else{%><%=util.getStr(rs.get("DATA04"))%><%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA05"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("HITS"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("DATA06")).equals("10")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("DATA06")).equals("20")) { %> <img alt="승인" src="/img/back/comm/edu_state_img_07.png"> <% } %>
						<%if(util.getStr(rs.get("DATA06")).equals("30")) { %> <img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <% } %>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck()) { %>
			<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="등록" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,listMode,sortMode,boardIdx){

		/*for(var i=1; i<$('input[name="searchPublicType[]"]').length; i++){
			if($('input:checkbox[id="sstp'+i+'"]').is(":checked")==true){
				alert($('input:checkbox[id="sstp'+i+'"]').val());
			}
		}*/

		var ArrayCheck = new Array();	//Array선언
		var CheckArr = document.getElementsByName("searchPublicType[]");	//체크박스의 이름을 가져온다.

		for(var i=0; i<CheckArr.length; i++){
			if(CheckArr[i].checked) {
				//alert(CheckArr[i].value);
				ArrayCheck.push(CheckArr[i].value);
			}
		}
		//alert(ArrayCheck);
		$("#ArrayCheck").val(ArrayCheck);

		$('#boardIdx').val(boardIdx);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

</script>