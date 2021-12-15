<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "edu";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;


	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String eduId = util.getStr(paramMap.get("eduId"));
	String m = util.getStr(paramMap.get("m"));

	String listMode = util.getStr(paramMap.get("listMode"));
	if("".equals(listMode)) mode = "list";

	//Calendar 객체 생성
	Calendar cal = Calendar.getInstance();

	//오늘 날짜 구하기
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1; //월은 0부터 시작하므로 1월 표시를 위해 1을 더해 준다

%>

<!--list_top S-->
<div class="list_top">
	<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="eduId" id="eduId" value="<%=eduId%>" />
			<input type="hidden" name="year" id="year"  value="" />
			<input type="hidden" name="month" id="month"  value="" />


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
			<div class="b_srchBox_gap"><img src="/img/board/srch_box_gap.gif" alt="GAP"/></div>
		</div>
		<div class="b_srchBox">
			<select name="searchType" id="searchType" class="b_select" title="검색조건 선택">
					<option value="TEACHING" <%=util.getStr(paramMap.get("searchType")).equals("TEACHING")? "selected='selected'":""%>>교육명</option>
					<option value="INSTITUTIONS" <%=util.getStr(paramMap.get("searchType")).equals("INSTITUTIONS")? "selected='selected'":""%>>교육기관</option>
				</select>
				<div class="b_srch">
                    <label class="hide" for="searchWord">검색어를 입력하세요</label>
					<input id="searchWord" class="b_srch_txt" name="searchWord" type="text" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
					<input type="image" class="b_go_btn" alt="검색" src="/img/board/btn_ico_srch.png" onclick="goButton('list','list')" />
				</div>
		</div>
	</form>
</div>
<!--list_top E-->

	<div class="DateList03" id="cont_block">
			<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					for(HashMap rs:dataList) {

				%>
			
			<dl class="dat_list">
				

				<dt>
					<a href="#" onclick="goSubmit('view','imageList','<%=util.getIntStr(rs.get("EDU_ID"))%>')">
						<span class="noL"><%=cont %></span>
						<span class="titL"><%=util.getStr(rs.get("EDU_NM")) %></span>
					</a>
				</dt>
				<dd>- 교육기간 : <%=util.getStr(rs.get("EDU_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ED_DT"))%>
				</dd>
				<dd>- 교육장소 : <%=util.getStr(rs.get("EDU_PLACE"))%>
				</dd>
				<dd>- 접수기간 : <%=util.getStr(rs.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ORD_ED_DT"))%>
				</dd>
				<dd>- 교육비 : <%=util.getStr(rs.get("EDU_FREE_YN")).equals("Y")? "무료" : util.getComma(util.getInt(rs.get("EDU_PAY")))+"(원)"%>
				</dd>
				<dd>- 모집인원 : <%=util.getIntStr(rs.get("EDU_ORD_PEOPLE"))%> / <%=util.getIntStr(rs.get("EDU_PEOPLE"))%>
				</dd>
				<%-- <dd>- 교육상태 : <%=util.getIntStr(rs.get("EDU_ORD_STATE"))%> --%>
				<dd>교육상태 :
					<% if("접수중".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
							<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
					<% }else if("접수대기".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
							<img alt="접수대기" src="/img/back/comm/edu_state_img_02.png" />
					<% }else if("접수마감".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
							<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
					<% }else if("수업중".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
							<img alt="수업중" src="/img/back/comm/edu_state_img_04.png" />
					<% }else{%>
							<img alt="수업종료" src="/img/back/comm/edu_state_img_05.png" />
					<% } %>
				</dd>

						
			</dl>
<% cont--;  }%>
	</div>
	<%=util.getPaging(staticVO, nowPage)%>

<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,listMode,eduId){
		$('#eduId').val(eduId);
		$('#listMode').val(listMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	function goSubmit(mode,listMode,year,month,eduId){

		if(listMode == 'calendar'){
			$('#year').val(year);
			$('#month').val(month);
		}

        $('#eduId').val(eduId);
        $('#listMode').val(listMode);
        $('#mode').val(mode);
        $('#searchForm').submit();
  }
//]]>	
</script>