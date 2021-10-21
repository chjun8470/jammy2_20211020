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
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> reservationDataList = request.getAttribute("reservationDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("reservationDataList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(request.getQueryString());
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	//String favMsg = util.getStr(paramMap.get("favMsg"));
%>

	<div class="list_top003">

            <form action="?<%=m%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
                  <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
                  <input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
                  <input type="hidden" name="m" id="m" value="53" />
                  <input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
                  <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
                  <input type="hidden" name ="rndEquIdx" id="rndEquIdx" value="" />

            <div class="board_count003">
                  [전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
            </div>

            <div class="publist_top_wrap003">

            <div class="b_srchBox003">

                  <div class="b_srch003">
                        <input type="text" name="searchWord" id="searchWord" class="b_srch_txt003" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
                        <!-- 검색버튼 -->
                        <input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn003" alt="바로가기" value="검색" onclick="pageSearchGo()" />
                  </div>
                  <div class="b_selectBox003">
                  <select name="searchUseScope" id="searchUseScope" class="b_select003 b_select003_single">
						<option value="">전체</option>
						<option value="1" <%if(util.getStr(paramMap.get("searchUseScope")).equals("1")) { %> selected="selected" <% } %>>기관명</option>
						<option value="2" <%if(util.getStr(paramMap.get("searchUseScope")).equals("2")) { %> selected="selected" <% } %>>장비명(국문, 영문)</option>
						<option value="3" <%if(util.getStr(paramMap.get("searchUseScope")).equals("3")) { %> selected="selected" <% } %>>키워드(국문, 영문)</option>
						<option value="4" <%if(util.getStr(paramMap.get("searchUseScope")).equals("4")) { %> selected="selected" <% } %>>모델명</option>
						<option value="5" <%if(util.getStr(paramMap.get("searchUseScope")).equals("5")) { %> selected="selected" <% } %>>제조사명</option>
						<option value="6" <%if(util.getStr(paramMap.get("searchUseScope")).equals("6")) { %> selected="selected" <% } %>>담당자명</option>
						<option value="7" <%if(util.getStr(paramMap.get("searchUseScope")).equals("7")) { %> selected="selected" <% } %>>NTIS 등록번호</option>
						<option value="8" <%if(util.getStr(paramMap.get("searchUseScope")).equals("8")) { %> selected="selected" <% } %>>JEINET 등록번호</option>
						<option value="9" <%if(util.getStr(paramMap.get("searchUseScope")).equals("9")) { %> selected="selected" <% } %>>고정자산관리번호</option>
					</select>
                    </div>

            </div>


            <div class="b_btn_listBox003">
                  <button type="button" class="b_btn_block003" id="cont_block" onclick="pageListGo('list','imagelist')" title="블럭형"><img src="/img/board/btn_block.png" /></button>
                  <button type="button" class="b_btn_blog003" id="cont_blog" onclick="pageListGo('list','bloglist')" title="블로그형"><img src="/img/board/btn_blog_ovr.png" /> </button>

            </div>

            <div class="b_srchBox_gap003"><img src="/img/board/srch_box_gap.gif" alt="검색줄라인"/></div>
      </div>
      </form>
</div>




	<!-- skin_basic_list s -->
		<div class="pub_list02" id="cont_block02">
			<ul class="pub_list_blog" >
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					int num = 1;
							for(HashMap rs:reservationDataList) {
				%>
				<li>
					<p class="img_publist_blog" style="cursor:pointer;" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>')"><img src="<%=util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("TITLE"))%>" width="199" height="199" /></p>
					<div class="explanation">
						<p class="tit_publist_blog01" style="cursor:pointer;" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>')"><%=util.getStr(rs.get("KOR_NM"))%> <span style="font-size: 18px;">(<%=util.getStr(rs.get("ENG_NM"))%>)</span>
						</p>


							<div class="txt_publist_blog01">
								<%=util.getStr(rs.get("OWN_ORG_NM"))%>
								<% if( !util.getStr(rs.get("OWN_ORG_SUB_NM")).equals("") ){ %>
									&nbsp;<%=util.getStr(rs.get("OWN_ORG_SUB_NM"))%>
								<% } %>
								&nbsp;/&nbsp;<%=util.getStr(rs.get("OPER_CHARGER")) %>&nbsp;<%=util.getStr(rs.get("OPER_POSITION")) %>
								&nbsp;/&nbsp;<%=util.getStr(rs.get("OPER_TEL")) %>
							</div>
							<div class="star_publist_blog01">
							
							</div>
							<br />
							<p class="txt_publist_blog02"><a href="#" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>')">
							제조사 : <%=util.getStr(rs.get("MANUFACTURE_NM"))%> <br />
							모델명 : <%=util.getStr(rs.get("MODEL_NM"))%> <br />


							<% if(util.getStr(rs.get("EQUIP_DETAIL_FEATURE")).length() > 170){ %>
							장비설명 : <%=util.getStr(rs.get("EQUIP_DETAIL_FEATURE")).substring(0, 168)+"...."%>
							<% } else { %>
							장비설명 : <%=util.getStr(rs.get("EQUIP_DETAIL_FEATURE"))%>
							<% } %>


							</a></p>


					</div>
				</li>
					<% if(num%4 == 0) { %>
				<% } num++; cont--; } %>
				<% if( reservationDataList.size() <= 0 ){ %>
					<li class="nodata" >
						데이터가 없습니다.
					</li>
				<% } %>
			</ul>


		</div>
		<%-- <div class="b_btn_area">
		<% if(util.loginCheck()) { %>
		<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
			<button class="btn_rgt" onclick="goSubmit('write')">글쓰기</button>
		<% } } %>
		</div> --%>

<%=util.getPaging(staticVO, nowPage)%>


<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
<%-- <%if(util.getStr(paramMap.get("favMsg")) != null) { %>
	<%if(!"".equals(util.getStr(paramMap.get("favMsg")))) {%>
	alert("<%=favMsg%>");
	<%} %>
<%} %> --%>
function pageSearchGo(){
	$('#mode').val('list');
	$('#searchForm').submit();
}
/* function pageFavGo(listMode,idx){
	$('#mode').val('list');
	$('#rndEquIdx').val(idx);
	$('#searchForm').submit();
} */
/* function pageViewGo(mode,listMode,idx){
	$('#mode').val(mode);
	$('#listMode').val(listMode);
	$('#rndEquIdx').val(idx);
	$('#searchForm').submit();
} */

function pageViewGo(mode,listMode,idx){
	$('#mode').val('view');
	$('#listMode').val(listMode);
	$('#rndEquIdx').val(idx);
	$('#searchForm').attr('action','sub.do')
	$('#searchForm').attr('method','get');
	$('#searchForm').submit();
}

function pageListGo(mode,listMode){
	$('#mode').val('list');
	$('#listMode').val(listMode);
	$('#searchForm').submit();
}

//]]>
</script>