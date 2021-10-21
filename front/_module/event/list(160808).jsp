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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> eventTypeList = request.getAttribute("eventTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventTypeList");
	ArrayList<HashMap<String, String>> eventList = request.getAttribute("eventList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String m = util.getStr(paramMap.get("m"));

	String listMode = util.getStr(paramMap.get("listMode"));
	if("".equals(listMode)) mode = "list";


	//Calendar 객체 생성
	Calendar cal = Calendar.getInstance();

	//오늘 날짜 구하기
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1; //월은 0부터 시작하므로 1월 표시를 위해 1을 더해 준다

%>

<div class="skin_list">
	<div>
		 <form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
			<input type="hidden" name="year" id="year"  value="" />
			<input type="hidden" name="month" id="month"  value="" />


			<div class="basic_grid basic_grid2">
               	<h4 style="">행사분류 </h4>
             		<div class="search_box" style="">
                    	<div class="board-search" style="line-height:25px;">
                        	<div style="position:relative;">
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
	                            <!-- <label class="hide" for="searchType"></label> -->
	                    	</div>
                        </div>
                        <!-- board-search e -->
                    </div>
                    <!-- search_box e -->


                    <div class="list_top_1 margin_left_20px">
                     	<div class="b_srchBox_1 ">

                        	<div class="b_srchBox_1_du">행사상태 :&nbsp;</div>
                            <select class="b_select_1" name="searchState" id="searchState" style="margin-right:20px;">
                             	<option value="">전체</option>
								<option value="접수전" <%if("접수전".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수전</option>
								<option value="접수중" <%if("접수중".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수중</option>
								<option value="접수마감" <%if("접수마감".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수마감</option>
								<option value="행사종료" <%if("행사종료".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>행사종료</option>
							</select>

							<div class="b_srchBox_1_du">
								행사참가비 :
								&nbsp;&nbsp;<input type="radio" name="searchPay" value="" <%if("".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%>> 전체
								&nbsp;&nbsp;<input type="radio" name="searchPay" value="N" <%if("N".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%>> 무료
								&nbsp;&nbsp;<input type="radio" name="searchPay" value="Y" <%if("Y".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%>> 유료
							</div>

						</div>
					</div>
					<!-- list_top_1 margin_left_20px e -->


					<div class="list_top_1">
                     	<div class="b_srchBox_1" style="width: auto;">

							<div style="margin: 0px 0px 0px 20px; height: 35px; line-height: 35px; float: left;">검색필드 :&nbsp;</div>
							<select class="b_select_1" name="searchType" id="searchType">
                            	<option value="EVENT_NM" <%if("EVENT_NM".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사명</option>
								<option value="EVENT_CONTENTS" <%if("EVENT_CONTENTS".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사내용</option>
							</select>
							<!-- 키워드 -->
                            <div class="b_srch">
                            	<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:97%;"/>
                            </div>
							<!-- 검색버튼 -->
							<div class="b_srch_dn">
                            	<input type="button" class="b_go_btn" value="검색" onclick="goSubmit('list','list')" />
                            </div>
                     	</div>
                     </div>

			</div>
            <!-- basic_grid basic_grid2 e -->

		</form>
		<!-- searchForm e -->


		<!--list_top S-->
		<div class="list_top">

			<div class="board_count">
				전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
			</div>

			<!-- 리스트보기 종류선택 -->
			<div class="publist_top_wrap02">
				<div class="b_btn_listBox" style="margin-right:10px;">
					<button type="button" class="b_btn_list" onclick="goSubmit('list','list')"><img src="/img/board/btn_list_ovr.png" alt="게시판형"/></button>
					<button type="button" class="b_btn_blog" onclick="goSubmit('list','imageList')"><img src="/img/board/btn_blog.png" alt="블로그형"/></button>
					<button type="button" class="b_btn_blog" onclick="goSubmit('list','calendar',<%=nowYear%>,<%=nowMonth%>)"><img src="/img/board/btn_calendar.png" alt="달력형"/></button>
				</div>
			</div>
		</div>
		<!--list_top E-->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
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
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(eventList.size() == 0){
				%>
					<tr><td colspan="8">데이터가 존재하지 않습니다</td></tr>
				<%
					}

							for(HashMap rs:eventList) {
				%>
				<tr>
					<td><%=cont%></td>
					<td>
						<%=util.getStr(rs.get("EVENT_TYPE_NM"))%>
					</td>
					<td class="subject" style="cursor:pointer;"  onclick="goSubmit('view','list','','','<%=util.getStr(rs.get("EVENT_IDX"))%>')">
							<%if(util.getStr(rs.get("EVENT_NM")).length()>13){%><%=util.getStr(rs.get("EVENT_NM")).substring(0, 13)+" · · · "%><%}else{%><%=util.getStr(rs.get("EVENT_NM"))%><%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("EEVENT_ST_DT"))%><br> ~&nbsp;<%=util.getStr(rs.get("EEVENT_ED_DT"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("RREQ_ST_DT"))%><br> ~&nbsp;<%=util.getStr(rs.get("RREQ_ED_DT"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("EVENT_FREE_YN")).equals("Y")){%>
							유료 <br> (<%=util.getComma(util.getIntStr(rs.get("EVENT_PAY")))%> 원)
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
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

	</div>
</div>
<!-- skin_list e -->
<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

	function goSubmit(mode,listMode,year,month,eventIdx){

		if(mode == 'view'){
			$('#eventIdx').val(eventIdx);
		}

		if(listMode == 'calendar'){
			$('#year').val(year);
			$('#month').val(month);
		}

		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#searchForm').submit();
	}


</script>
