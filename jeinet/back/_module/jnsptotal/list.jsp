<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> orgGrpList = request.getAttribute("orgGrpList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("orgGrpList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	//String nowPage2 = util.getStr(paramMap.get("searchWord"));
	String rndEquIdx = util.getStr(paramMap.get("rndEquIdx"));
	String equipCd = util.getStr(paramMap.get("equipCd"));
	String state = util.getStr(paramMap.get("state"));

	String userTp = util.getStr(paramMap.get("userTp"));
	String orgGrpCd = util.getStr(paramMap.get("orgGrpCd"));
	String deptNm = util.getStr(paramMap.get("deptNm"));
	String authLv = util.getStr(paramMap.get("authLv"));

%>


<div class="skin_list">
	<div>
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>"/>
			<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>"/>
			<input type="hidden" name="tmenu" id="tmenu" value="2"/>
			<input type="hidden" name="rndEquIdx" id="rndEquIdx" value="<%=rndEquIdx%>"/>
			<input type="hidden" name="equipCd" id="equipCd" value="<%=equipCd%>"/>
			<input type="hidden" name="state" id="state" value=""/>

			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<div style="position:relative;">

						<span>요청상태 :</span>
						<select class="select" name="searchState" id="searchState" style="height:24px;">
							<option value="">전체</option>
							<option value="1" <%if(util.getStr(paramMap.get("searchState")).equals("1")) { %> selected="selected" <% } %>>승인요청</option>
							<option value="2" <%if(util.getStr(paramMap.get("searchState")).equals("2")) { %> selected="selected" <% } %>>승인</option>
							<option value="3" <%if(util.getStr(paramMap.get("searchState")).equals("3")) { %> selected="selected" <% } %>>승인거절</option>
							<option value="5" <%if(util.getStr(paramMap.get("searchState")).equals("5")) { %> selected="selected" <% } %>>승인취소</option>
							<option value="6" <%if(util.getStr(paramMap.get("searchState")).equals("6")) { %> selected="selected" <% } %>>수정요청</option>
							<option value="7" <%if(util.getStr(paramMap.get("searchState")).equals("7")) { %> selected="selected" <% } %>>수정반려</option>
						</select>

						<span style="margin-left:40px;">기관 :</span>
						<%if(authLv.equals("99")){//최고관리자%>
						<select class="select" name="searchOrgGrp" id="searchOrgGrp" style="width:200px; height:24px;">
							<option value="">전체</option>
							<%for(HashMap rs:orgGrpList) {%>
							<option value="<%=util.getStr(rs.get("ORG_GRP_CD"))%>" <%if(util.getStr(paramMap.get("searchOrgGrp")).equals(util.getStr(rs.get("ORG_GRP_CD")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("ORG_GRP_NM"))%></option>
							<%}%>
						</select>
						<%
							}else{

								for(HashMap rs:orgGrpList) {

									if(orgGrpCd.equals(util.getStr(rs.get("ORG_GRP_CD")))){
						%>
									<input type="hidden" name="searchOrgGrp" id="searchOrgGrp" class="inp_text" value="<%=orgGrpCd%>"/>
									<input type="text" name="searchOrgGrpNm" id="searchOrgGrpNm" class="inp_text" value="<%=util.getStr(rs.get("ORG_GRP_NM"))%>" style="height:24px; width:192px;" readonly/>
						<%			}
								}
							}
						%>

						<span>부서 :</span>
						<%if(authLv.equals("99")){//최고관리자%>
							<input type="text" name="searchOrgSub" id="searchOrgSub" class="inp_text" value="<%=util.getStr(paramMap.get("searchOrgSub"))%>" style="height:24px; width:430px;"/>
						<%}else{%>
							<input type="text" name="searchOrgSub" id="searchOrgSub" class="inp_text" value="<%=deptNm%>" style="height:24px; width:430px;" readonly/>
						<%}%>
					</div>

					<div style="position:relative;">
						<select name="searchType" id="searchType" class="select" style="width:132px; height:24px;">
							<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>장비/시설명</option>
							<option value="model" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>모델명</option>
							<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>키워드</option>
						</select>
						<!-- 키워드 -->
						<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="height:24px; width:745px;"/>

						<!-- 검색버튼 -->
						<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" style="float:right;"/>
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
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 25%;" />
				<col style="width: 15%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">승인상태</th>
					<th scope="col">시설장비분류</th>
					<th scope="col">고정자산관리번호</th>
					<th scope="col">
						<%if(equipCd.equals("1")){%>
							장비명
						<%}else{%>
							시설명
						<%}%>
					</th>
					<th scope="col">모델명</th>
					<th scope="col">등록기관/부서명</th>
				</tr>
			</thead>
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					if(dataList.size()>0){
						for(HashMap rs:dataList) {
				%>
					<tr style="cursor:pointer" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'" onclick = "pageViewGo('<%=rs.get("RND_EQU_IDX")%>','<%=rs.get("STATE")%>');">
						<td><%=cont%></td>
						<td>
							<%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="승인" src="/img/back/comm/edu_state_img_07.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="수정요청" src="/img/back/comm/order_state_img_6.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="수정반려" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
	               		<td><%=util.getStr(rs.get("EQUIP_CD")).equals("1")?"연구장비":"연구시설"%></td>
						<td><%=util.getStr(rs.get("FIXED_ASET_NO_YN")).equals("Y") ? "사용하지 않음":util.getStr(rs.get("FIXED_ASET_NO"))%></td>
						<td class="subject"><%=util.getStr(rs.get("KOR_NM"))%><br/>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
						<td><%=util.getStr(rs.get("MODEL_NM")).equals("") ? "모델명 없음":util.getStr(rs.get("MODEL_NM"))%></td>
						<td><%=util.getStr(rs.get("ORG_GRP_NM"))%><br/><%=util.getStr(rs.get("DEPT_NM"))%></td>
					</tr>
				<%
						cont--;
						}
					}else{
							out.println("<tr><td colspan='7'>조회된 결과가 없습니다.</td></tr>");
					}
				%>
			</tbody>
		</table>

		<%=util.getPaging(staticVO, nowPage) %>
	</div>

	<div class="btn_box">
		<div class="btn_right_box" >
		<%if(Integer.parseInt(loginVO.getAuthLv()) >= 70) {%>
	    	<input type="button" class="btn_inp_b_01" value="등록" onclick="pageWriteGo()" />
	    <%} %>
		</div>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		if($('#equipCd').val() == '2'){
			 $('#searchForm').attr('action','./sys_jnsptotal_fc.do');
		}else{
			$('#searchForm').attr('action','./sys_jnsptotal_eq.do');
		}
		$('#searchForm').submit();
	}
	function pageWriteGo(){
		 if($('#equipCd').val() == '2'){
			 //$('#searchForm').attr('action','./sys_jnsptotalRscReg.do');
			 $('#searchForm').attr('action','./sys_jnsptotal_fc.do');
			 $('#mode').val('rscWrite');
		}else{
			//$('#searchForm').attr('action','./sys_jnsptotalReg.do');
			$('#searchForm').attr('action','./sys_jnsptotal_eq.do');
			$('#mode').val('write');

		}

		$('#searchForm').submit();
	}
	function pageViewGo(idx,state){

		$('#state').val(state);

		if($('#equipCd').val() == '2'){
			 location.href= "/sys/sys_jnsptotal_fc.do?equipCd=2&rndEquIdx="+idx+"&mode=view&state="+state;
		}else{
			location.href= "/sys/sys_jnsptotal_eq.do?equipCd=1&rndEquIdx="+idx+"&mode=view&state="+state;
		}

	}
</script>
