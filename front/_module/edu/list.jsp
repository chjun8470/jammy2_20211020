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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));

	String listMode = util.getStr(paramMap.get("listMode"));
	if("".equals(listMode)) mode = "list";


	//Calendar 객체 생성
	Calendar cal = Calendar.getInstance();

	//오늘 날짜 구하기
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1; //월은 0부터 시작하므로 1월 표시를 위해 1을 더해 준다

%>


<div class="list_top">
	<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="eduId" id="eduId" value="" />
			<input type="hidden" name="year" id="year"  value="" />
			<input type="hidden" name="month" id="month"  value="" />


		<div class="board_count">
			전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
		</div>

		<!-- 검색종류선택 -->
		<div class="publist_top_wrap02">
			
			<div class="b_srchBox0001">
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
            
            <div class="b_srchBox_gap0001"><img src="/img/board/srch_box_gap.gif" alt=""/></div>
            
            <div class="b_btn_listBox0001">
				<button type="button" class="b_btn_list" onclick="goButton('list','list')" title="게시판형(선택됨)"><img src="/img/board/btn_list_ovr.png" /></button>
				<button type="button" class="b_btn_blog" onclick="goButton('list','imageList')" title="블로그형"><img src="/img/board/btn_blog.png" /></button>
				<button type="button" class="b_btn_blog" onclick="goButton('list','calendar',<%=nowYear%>,<%=nowMonth%>)" title="달력형"><img src="/img/board/btn_calendar.png" /></button>
			</div>
            
		</div>
	</form>
</div>
<!--list_top E-->

		<!--cont_block S-->
		<div id="cont_block">
			<!--basic_listWrap S-->
			<div class="basic_listWrap">

				<table class="skin_list" summary="교육정보 게시글 목록으로 글번호, 교육명(과정명), 접수기간, 교육기간, 참여인원, 교육상태로 구성되어 있습니다.">
				<caption>교육정보</caption>
					<!--<colgroup>
						<col style="width: 10%;" />
						<col style="width: 50%;" />
						<col style="width: 20%;" />
						<col style="width: 20%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>-->

				<thead>
				<tr>
						<th scope="col" class="number m_not">번호</th>
						<th scope="col">교육명(과정명)</th>
						<th scope="col">접수기간</th>
						<th scope="col" class="m_not">교육기간</th>
						<th scope="col" class="number m_not">참여인원</th>
						<th scope="col" class="r_line_none">교육상태</th>
				</tr>
				</thead>
				<tbody>
					<%
						int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					if(dataList.size()>0){
						for(HashMap rs:dataList) {
					%>
						<tr onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'" >
							<td class="number m_not"><%=cont%></td>
							<td>
								<a href="javascript:goSubmit('view','<%=util.getStr(rs.get("EDU_ID"))%>')"  title="<%=util.getStr(rs.get("EDU_NM")).replaceAll("&amp;","&").replaceAll("&","&amp;")%>(<%=util.getStr(rs.get("EDU_CUR"))%>) 상세보기"  >
							<%=util.getStr(rs.get("EDU_NM")).replaceAll("&amp;","&").replaceAll("&","&amp;")%>(<%=util.getStr(rs.get("EDU_CUR"))%>)
							</a>
							</td>
							<td><%=util.getStr(rs.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ORD_ED_DT"))%></td>
							<td class="m_not"><%=util.getStr(rs.get("EDU_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ED_DT"))%></td>
							<td class="number m_not"><%=util.getIntStr(rs.get("EDU_ORD_PEOPLE"))%>/<%=util.getIntStr(rs.get("EDU_PEOPLE"))%></td>
							<td class="r_line_none line_cnci_lft">
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
							</td>
						</tr>

					<%
					cont--;
						}
					}else{out.println("<tr><td colspan='6' class='r_line_none' >조회된 결과가 없습니다.</td></tr>");}
					%>

					</tbody>
				</table>
			</div>
			<!--basic_listWrap E-->
		</div>
		<!--cont_block E-->
	<br/>
	<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,idx){
		$('#eduId').val(idx);
		$('#mode').val(mode);
		if(mode == "view"){
			$('#searchForm').attr("method","get");
		}
		$('#searchForm').submit();
	}

	function goButton(mode,listMode,year,month){
		if(listMode == 'calendar'){
			$('#year').val(year);
			$('#month').val(month);
		}

		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#searchForm').submit();
	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});
//]]>
</script>