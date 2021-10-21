<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> eventTypeList = request.getAttribute("eventTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventTypeList");
	ArrayList<HashMap<String, String>> eventList = request.getAttribute("eventList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));

	if("".equals(mode)) mode = "list";

	if(util.loginCheck() == false){
%>
	<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	</script>
<%
		return;
	}
%>

<div class="skin_list">
	<div>
		 <form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />
			<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />


			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<div style="position:relative;">
						<span style="float:left;">행사분류 :</span>
						<%
							int cnt = 1;
							for(HashMap rs:eventTypeList) {

								String ckChecked = "NO";
								if(request.getParameterValues("searchEventType[]") != null){
									String[] ckTp = request.getParameterValues("searchEventType[]");
									//System.out.println("*****"+request.getParameterValues("searchEventType[][]"));

									for(int i =0;  i < ckTp.length ; i++){
										if(util.getStr(rs.get("CODE_CD")).equals(ckTp[i])){
											ckChecked = "YES";
										}
									}
								}

						%>
						<span style="float:left; padding:0px 5px;"><input type="checkbox" name="searchEventType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>>
							  <label for="sstp<%=cnt%>"><%=util.getStr(rs.get("CODE_NM"))%></label>
						</span>
						<%
							cnt++;
							}
						%>
					</div>

					<div style="position:relative;clear:both;">
					<label  for="searchReceipt">행사상태 :</label>
					<select class="select" name="searchState" id="searchState" style="width:84px; height: 24px">
						<option value="">전체</option>
						<option value="접수전" <%if("접수전".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수전</option>
						<option value="접수중" <%if("접수중".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수중</option>
						<option value="접수마감" <%if("접수마감".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수마감</option>
						<option value="행사종료" <%if("행사종료".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>행사종료</option>
					</select>&nbsp;&nbsp;

					<label for="searchPay">행사참가비 :</label>
					&nbsp;&nbsp;<input type="radio" name="searchPay" value="" <%if("".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%>> 전체
					&nbsp;&nbsp;<input type="radio" name="searchPay" value="N" <%if("N".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%>> 무료
					&nbsp;&nbsp;<input type="radio" name="searchPay" value="Y" <%if("Y".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%>> 유료

					<br>
					<!-- 검색필드 -->
					<label for="searchType">검색필드 :</label>
					<select class="select" name="searchType" id="searchType" style="width:84px; height: 24px">
						<option value="EVENT_NM" <%if("EVENT_NM".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사명</option>
						<option value="EVENT_CONTENTS" <%if("EVENT_CONTENTS".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사내용</option>
					</select>
					<!-- 키워드 -->
					<label class="hide" for="keyword">키워드</label>
					<input class="board-input" title="검색단어입력"  type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:750px; height:20px" />

					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" />
					</div>
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

		</form>
		<!-- searchForm e -->

		<div class="total" style="float:left; text-align:left; vertical-align:middle; margin:10px; padding:2px;">
			[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		</div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">행사분류</th>
					<th scope="col">행사명</th>
					<th scope="col">행사기간</th>
					<th scope="col">참가신청기간</th>
					<th scope="col">행사참가비</th>
					<th scope="col">참가인원<br>(신청인원)</th>
					<th scope="col">행사상태</th>
					<th scope="col">등록여부<br>상태</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(eventList.size() == 0){
				%>
					<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:eventList) {
				%>
				<tr style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'" onclick="location.href='?mode=view&eventIdx=<%=util.getStr(rs.get("EVENT_IDX"))%>'">
					<td><%=cont%></td>
					<td>
						<%=util.getStr(rs.get("EVENT_TYPE_NM"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("EVENT_NM")).length() > 8){%><%=util.getStr(rs.get("EVENT_NM")).substring(0, 8)+" · · · "%><%}else{%><%=util.getStr(rs.get("EVENT_NM"))%><%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("EEVENT_ST_DT"))%> ~<br/>
						<%=util.getStr(rs.get("EEVENT_ED_DT"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("RREQ_ST_DT"))%> ~<br/>
						&nbsp;<%=util.getStr(rs.get("RREQ_ED_DT"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("EVENT_FREE_YN")).equals("Y")){%>
							유료 <br/> (<%=util.getComma(util.getIntStr(rs.get("EVENT_PAY")))%> 원)
						<%}else{%>
							무료
						<%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("EVENT_PEOPLE")) %> ( <%=util.getInt(rs.get("REQ_PEOPLE")) %> )
					</td>
					<td>
						<% if("접수중".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("접수전".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수전" src="/img/back/comm/edu_state_img_02.png" />
						<% }else if("접수마감".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
						<% }else{%>
						<img alt="행사종료" src="/img/back/comm/edu_state_img_06.png" />
						<% } %>
					</td>
					<td>
						<% if(util.getStr(rs.get("CONFIRM_STATE")).equals("10")){ %>
						<img alt="승인요청" src="/img/back/comm/order_state_img_1.png" />
						<% }else if(util.getStr(rs.get("CONFIRM_STATE")).equals("20")){ %>
						<img alt="승인" src="/img/back/comm/edu_state_img_07.png" />
						<% }else if(util.getStr(rs.get("CONFIRM_STATE")).equals("30")){ %>
						<img alt="승인거절" src="/img/back/comm/order_state_img_3.png" />
						<% }else{%>
							&nbsp;
						<% } %>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>
		<%=util.getPaging(staticVO, nowPage) %>
		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck() == true){%>
			<div class="btn_right_box">
				<input type="button" class="btn_inp_b_01" value="행사등록" onclick="goSubmit('write')"/>
			</div>
			<%}%>
		</div>

	</div>
</div>



<script type="text/javascript">
	function goSubmit(mode,eventIdx){

		if(mode == 'view'){
			$('#eventIdx').val(eventIdx);
			$('#searchForm').attr('method','get');
		}


		$('#mode').val(mode);
		$('#searchForm').submit();
	}
</script>
