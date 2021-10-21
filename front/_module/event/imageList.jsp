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
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
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
								<span style="float:left; padding:0px 5px;"><input type="checkbox" name="searchEventType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>/>
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

                        	<div class="b_srchBox_1_du"><label for="searchState">행사상태 :&nbsp;</label></div>
                            <select class="b_select_1" name="searchState" id="searchState"  style="margin-right:20px;" title="검색조건 선택">
                             	<option value="">전체</option>
								<option value="접수전" <%if("접수전".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수전</option>
								<option value="접수중" <%if("접수중".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수중</option>
								<option value="접수마감" <%if("접수마감".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수마감</option>
								<option value="행사종료" <%if("행사종료".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>행사종료</option>
							</select>&nbsp;&nbsp;

							<div class="b_srchBox_1_du">
								행사참가비 :
								&nbsp;&nbsp;<input type="radio" name="searchPay" id="searchPay" value="" <%if("".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%> title="행사참가비 전체"   /> <label for="searchPay">전체</label>
								&nbsp;&nbsp;<input type="radio" name="searchPay" id="searchPay" value="N" <%if("N".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%> title="행사참가비 무료"  /> <label for="searchPay">무료</label>
								&nbsp;&nbsp;<input type="radio" name="searchPay" id="searchPay" value="Y" <%if("Y".equals(util.getStr(paramMap.get("searchPay")))) {%> checked="checked" <%}%> title="행사참가비 유료"  /> <label for="searchPay">유료</label>
							</div>

						</div>
					</div>
					<!-- list_top_1 margin_left_20px e -->


					<div class="list_top_1">
                     	<div class="b_srchBox_1" style="width: auto;">

							<div style="margin: 0px 0px 0px 20px; height: 35px; line-height: 35px; float: left;"><label for="searchType">검색필드 :&nbsp;</label></div>
							<select class="b_select_1" name="searchType" id="searchType" title="검색조건 선택">
                            	<option value="EVENT_NM" <%if("EVENT_NM".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사명</option>
								<option value="EVENT_CONTENTS" <%if("EVENT_CONTENTS".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사내용</option>
							</select>
							<!-- 키워드 -->
                            <div class="b_srch">
                                <label class="hide" for="searchWord">검색어를 입력하세요</label>
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

			<!-- 검색종류선택 -->
			<div class="publist_top_wrap02">
				<div class="b_btn_listBox" style="margin-right:10px;">
					<button type="button" class="b_btn_list" onclick="goSubmit('list','list')" title="게시판형"><img src="/img/board/btn_list.png" /></button>
					<button type="button" class="b_btn_blog" onclick="goSubmit('list','imageList')" title="블로그형"><img src="/img/board/btn_blog_ovr.png" /></button>
					<button type="button" class="b_btn_blog" onclick="goSubmit('list','calendar',<%=nowYear%>,<%=nowMonth%>)" title="달력형"><img src="/img/board/btn_calendar.png" /></button>
				</div>
			</div>
		</div>
		<!--list_top E-->


		<!-- DateList03 s -->
		<div class="DateList03" id="cont_block">
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					for(HashMap rs:eventList) {

				%>
				<dl class="dat_list">
				<dt >
					<span class="noL"><%=cont %></span>
					<a href="javascript:goSubmit('view','imageList','','','<%=util.getStr(rs.get("EVENT_IDX"))%>')" title="<%=util.getStr(rs.get("EVENT_NM"))%>상세보기" ><span class="titL"><%if(util.getStr(rs.get("EVENT_NM")).length()>30){%><%=util.getStr(rs.get("EVENT_NM")).substring(0, 30)+" · · · "%><%}else{%><%=util.getStr(rs.get("EVENT_NM"))%><%}%></span>
					</a>
				</dt>
				<dd style="width: 40%;">- 행사구분 : <%=util.getStr(rs.get("EVENT_TYPE_NM"))%></dd>
				<dd style="width: 40%;">- 행사기간 : <%=util.getStr(rs.get("EEVENT_ST_DT"))%>&nbsp;~&nbsp;<%=util.getStr(rs.get("EEVENT_ED_DT"))%></dd>
				<dd style="width: 40%;">- 참가신청기간 : <%=util.getStr(rs.get("RREQ_ST_DT"))%>&nbsp;~&nbsp;<%=util.getStr(rs.get("RREQ_ED_DT"))%></dd>
				<dd style="width: 40%;">- 행사참가비 : <%if(util.getStr(rs.get("EVENT_FREE_YN")).equals("Y")){%>유료  (<%=util.getComma(util.getIntStr(rs.get("EVENT_PAY")))%> 원)<%}else{%>무료 <%}%></dd>
				<dd style="width: 40%;">- 참가인원 : <%=util.getStr(rs.get("EVENT_PEOPLE")) %> ( <%=util.getInt(rs.get("REQ_PEOPLE")) %> )</dd>
				<dd style="width: 40%;">- 행사상태 :
						<% if("접수중".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("접수전".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수전" src="/img/back/comm/edu_state_img_02.png" />
						<% }else if("접수마감".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
						<% }else{%>
						<img alt="행사종료" src="/img/back/comm/edu_state_img_06.png" />
						<% } %>
				</dd>
				</dl>
						<% cont--;  }%>


	</div>
	<!-- DateList03 e -->

	</div>
</div>
<!-- skin_list e -->
<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
//<![CDATA[
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
//]]>	
</script>
