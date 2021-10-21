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
	String m = util.getStr(request.getQueryString());

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>

	<!--tabBox S-->
	<%-- <div class="tabBox">
		<ul>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("ALL") || util.getStr(paramMap.get("orderState")).equals("")) { %> class="on" <% } %> id="tabALL" style="width:90px;"><a href="#" onclick="orderTab('ALL')">전체</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("1")) { %> class="on" <% } %> ><a href="#" onclick="orderTab('1')">승인요청</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("2")) { %> class="on" <% } %>id="tab2" class="" style="width:90px;" ><a href="#" onclick="orderTab('2')">이용승인</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("3")) { %> class="on" <% } %>id="tab3" class="" style="width:90px;" ><a href="#" onclick="orderTab('3')">승인거절</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("4")) { %> class="on" <% } %>id="tab4" class="" style="width:90px;" ><a href="#" onclick="orderTab('4')">이용완료</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("5")) { %> class="on" <% } %>id="tab5" class="" style="width:90px;" ><a href="#" onclick="orderTab('5')">승인취소</a></li>
		</ul>
	</div> --%>
	<!--tabBox E-->

	<!--list_top S-->
	<div class="list_top">
		<form id="searchForm" name="searchForm" method="post" action="./equorder.do">
			<input type="hidden" name="nowPage" id="nowPage" />
			<input type="hidden" name="mode" id="mode" />
		</form>

		<div class="b_srchBox" style="width:100%">
			교육기간조회
			<input type="text" class="b_txtbox2" id="datepicker1" name ="DateStart" style="width:15%;" size ="13" value="" /><b> ~ </b><input type="text" class="b_txtbox2" id="datepicker2" name ="DateEnd" style="width:15%;" size ="13" value="" />

			<div class="b_srch" style="width:40%; float:right;margin-right:25px;">
				<select name="searchType" id="searchType" class="b_select" style="height:27px;border-top-width:0px;border-left-width: 0px;">
					<option value="TEACHING" <%if("TEACHING".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>교육명</option>
					<option value="INSTITUTIONS" <%if("INSTITUTIONS".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>교육기관</option>
			</select>
				<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" style="height: 26px;width:100px;margin-top:0px;" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<input type="image" class="b_go_btn" alt="검색" src="../img/board/btn_ico_srch.png"/>
			</div>
		</div>
	</div>

	<div class="board_count">
			전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
	</div>

	<div id="cont_block">
		<div class="basic_listWrap">
			<table class="skin_list" summary="일반게시판의 게시글 목록으로 순번, 제목, 등록일, 조회수, 첨부로 구성되어 있습니다.">
				<caption>번호, 제목, 작성일, 첨부, 조회로 구성된 표입니다.</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 25%;" />
					<col style="width: 25%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>

				<thead>
					<tr>
						<th scope="col" class="">NO</th>
						<th scope="col" >교육명(과정명)</th>
						<th scope="col" >교육기관</th>
						<th scope="col" >교육기간</th>
						<th scope="col" >신청상태</th>
						<th scope="col" class="r_line_none2">수료증</th>
					</tr>
				</thead>
				<tbody>
			<%
				int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

				if(dataList.size() == 0){
			%>
				<tr><td colspan="6">데이터가 존재하지 않습니다</td></tr>
			<%
				}

				for(HashMap rs:dataList) {
			%>
					<tr>
						<td class="">
							<%=cont%>
						</td>
						<td class="" style="cursor: pointer" onclick="pageViewGo('<%=rs.get("EDU_ID")%>');">
							<%=util.getStr(rs.get("EDU_NM"))%>(<%=util.getStr(rs.get("EDU_CUR"))%>)
						</td>
						<td class="">
							<%=util.getStr(rs.get("ORG_GRP_NM"))%>
						</td>
						<td class="">
							<%=util.getStr(rs.get("EDU_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ED_DT"))%>
						</td>
						<td class="">
							<%if(util.getStr(rs.get("RESV_STATE")).equals("10")) { %>
							승인대기
							<!-- <img alt="승인요청" src="/img/back/comm/order_state_img_1.png" /> -->
							<% }else if(util.getStr(rs.get("RESV_STATE")).equals("20")) { %>
							참가승인
							<!-- <img alt="이용승인" src="/img/back/comm/order_state_img_2.png" /> -->
							<% }else if(util.getStr(rs.get("RESV_STATE")).equals("30")) { %>
							반려
							<!-- <img alt="승인거절" src="/img/back/comm/order_state_img_3.png" /> -->
							<% }else if(util.getStr(rs.get("RESV_STATE")).equals("40")) { %>
							접수취소
							<!-- <img alt="승인취소" src="/img/back/comm/order_state_img_5.png" /> -->
							<% }else if(util.getStr(rs.get("RESV_STATE")).equals("50")) { %>
							교육수료
							<% }else if(util.getStr(rs.get("RESV_STATE")).equals("60")) { %>
							미수료
							<% } %>
						</td>
						<td class="">
						<%if(util.getStr(rs.get("RESV_STATE")).equals("50")){ 
							if(util.getStr(rs.get("RESV_CERTI_FILE")).equals("")){
						%>
							<input type="button" value="발급받기" class="btn_inp_w_01" onclick="if(confirm('정말로 수료증을 발급하시겠습니까?'))window.open('/AIViewer55/temp/educer.jsp?reportParams=showScrollNext:false,showScrollTop:false,showScrollBottom:false,showScrollPrev:false,showScrollPage:false&menu=old&resvid=<%=util.getIntStr(rs.get("EDU_RESV_ID"))%>&state=<%=util.getStr(rs.get("RESV_STATE")) %>','win','width=797,height=800,toolbar=0,scrollbars=0,resizable=0')" />
						<%
							}else{
							String resvFileParam = "?dataGrp=resvCerti"
										+"&amp;fileId="+util.getIntStr(rs.get("RESV_CERTI_FILE"))
										+"&amp;dataIdx="+util.getIntStr(rs.get("EDU_RESV_ID"));
						%>
						<input type="button" onclick="if(confirm('정말로 수료증을 발급하시겠습니까?'))location.href='/cmm/fms/ComFileDown.do<%=resvFileParam%>'" class="btn_inp_w_01" value="발급받기">
							
							
								
							<% }
						} %>
						</td>
					</tr>
					<% cont--; } %>
				</tbody>
			</table>
			<%=util.getPaging(staticVO, nowPage) %>
		</div>
	</div>
<script type="text/javascript">
	function pageViewGo(idx){
		window.open("/jntis/sub.do?m=34&mode=view&eduId="+idx,'edupopup');

	}

/* 달력 */
$(document).ready(function(){
    $("#datepicker1, #datepicker2").datepicker({
        showMonthAfterYear : true,
        showButtonPanel : true,
        changeMonth : true,
        changeYear : true,
        nextText : '다음 달',
        prevText : '이전 달',
        currentText : '오늘 날짜',
        closeText : '닫기',
        dateFormat : "yy-mm-dd",
        dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
        dayNamesMin : ['월','화','수','목','금','토','일'],
        monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
    });

      // 작업 시작일 값에 따른 작업 종료일 선택 값 제한
     $('#datepicker1').datepicker("option", "maxDate", $("#datepicker2").val());
     $('#datepicker1').datepicker("option", "onClose", function ( selectedDate ) {
     $("#datepicker2").datepicker("option", "minDate", selectedDate );
     });

    // 작업 종료일 값에 따른 작업 시작일 선택 값 제한
     $('#datepicker2').datepicker("option", "minDate", $("#datepicker1").val());
     $('#datepicker2').datepicker("option", "onClose", function ( selectedDate ) {
     $("#datepicker1").datepicker("option", "maxDate", selectedDate );
    });
});
</script>