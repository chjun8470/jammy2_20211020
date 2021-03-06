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
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	String list_mode = util.getStr(paramMap.get("list_mode"));
	ArrayList<HashMap<String, String>> dataList = new ArrayList();
	//ArrayList<HashMap<String, String>> imgfileList = new ArrayList();
	StaticVO staticVO = new StaticVO();

	if(list_mode.equals("utility")){
		dataList = request.getAttribute("utilityList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("utilityList");
		staticVO = request.getAttribute("utilityStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("utilityStaticVO");
		//imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("design")){
		dataList = request.getAttribute("designList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("designList");
		staticVO = request.getAttribute("designStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("designStaticVO");
		//imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("brand")){
		dataList = request.getAttribute("brandList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("brandList");
		staticVO = request.getAttribute("brandStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("brandStaticVO");
		//imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("program")){
		dataList = request.getAttribute("programList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("programList");
		staticVO = request.getAttribute("programStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("programStaticVO");
		//imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("knowhow")){
		dataList = request.getAttribute("knowHowList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("knowHowList");
		staticVO = request.getAttribute("knowHowStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("knowHowStaticVO");
		//imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}

	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "registration";
	String fileImgGrp = "registartion_img";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String fileFullImgGrp = fileImgGrp+fileSubGrp;

	int scCnt = 0;
%>
<style type="text/css">
	#utility_list {display:none;}
	#design_list {display:none;}
	#brand_list {display:none;}
	#program_list {display:none;}
	#knowhow_list {display:none;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	var skin = "<%=list_mode%>";
	$('#utility_list').css('display', 'none');
	$('#design_list').css('display', 'none');
	$('#brand_list').css('display', 'none');
	$('#program_list').css('display', 'none');
	$('#knowhow_list').css('display', 'none');
	$('#'+skin+'_list').css('display', 'block');
});
</script>

<div id="skin_list">

		<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage%>">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name ="list_mode" id = "list_mode" value ="<%=list_mode%>" />
			<input type="hidden" name ="idx" id = "idx" />
			<input type="hidden" 	id="state" 			name="state" 		value=""/>

			<div class="tabBox_pub">
				<ul>
					<li <%if(util.getStr(paramMap.get("list_mode")).equals("utility") || util.getStr(paramMap.get("list_mode")).equals("")) { %> class="on" <% } %> id="tab1"><a href="#" onclick="list('utility')">????????????</a></li>
					<li <%if(util.getStr(paramMap.get("list_mode")).equals("design")) { %> class="on" <% } %> ><a href="#" onclick="list('design')">?????????</a></li>
					<li <%if(util.getStr(paramMap.get("list_mode")).equals("brand")) { %> class="on" <% } %>id="tab2" ><a href="#" onclick="list('brand')">??????</a></li>
					<li <%if(util.getStr(paramMap.get("list_mode")).equals("program")) { %> class="on" <% } %>id="tab3" ><a href="#" onclick="list('program')">????????????</a></li>
					<li <%if(util.getStr(paramMap.get("list_mode")).equals("knowhow")) { %> class="on" <% } %>id="tab4" ><a href="#" onclick="list('knowhow')">?????????</a></li>
				</ul>
			</div>

			<div class="bbs-top">
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<!--Patent_search S-->
						<div class="Patent_search">

						<div class="p_srchBox" style="display:inline-block;">
						<span class="p_kinds">????????? :</span>

							<select class="p_select" name="reDeth1" id="reDeth1<%=scCnt %>" onchange="standardDeth1('reDeth2<%=scCnt %>')" style="width:150px;">
								<option value="">?????????</option>
									<%
									int num = 1;
									for(HashMap rs:standardList) {
									%>
								<option id="mCode<%=num%>" <%if(util.getStr(paramMap.get("reDeth1")).equals(util.getStr(rs.get("CODE")))) { %>selected <% } %>
								value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
								<% num++; } %>
							</select>

							<select class="p_select2" name="reDeth2" id="reDeth2<%=scCnt %>" style="width:150px;">
								<option value="">?????????</option>
							</select>

						</div>
						&nbsp;&nbsp;&nbsp;
						<div class="p_srchBox" style="display:inline-block">
							<span class="p_kinds">????????? :</span>

							<input id="ownOrgNmText" class="p_srch_txt2" name="ownOrgNmText" type="text" title="??????????????????" value="<%=util.getStr(paramMap.get("ownOrgNmText"))%>" />

						</div>
						&nbsp;&nbsp;&nbsp;
						<div class="p_srchBox" style="display:inline-block">
							<span class="p_kinds">????????? :</span>

							<select class="p_select" name="searchArea" id="searchArea">
								<option value="">???????????????</option>
								<%
									int numArea = 1;
									for(HashMap rs:areaSigunguList) {
									%>
								<option id="sigunguCode<%=numArea%>" <%if(util.getStr(paramMap.get("searchArea")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
								value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% numArea++; } %>
							</select>
						</div>
						&nbsp;&nbsp;&nbsp;
						<div class="p_srchBox" style="display:inline-block">
							<span class="p_kinds">?????? :</span>

						<select class="p_select" name="searchState" id="searchState">
							<option value="">????????????</option>
							<option value="1" <%if(util.getStr(paramMap.get("searchState")).equals("1")) { %> selected="selected" <% } %>>????????????</option>
							<option value="2" <%if(util.getStr(paramMap.get("searchState")).equals("2")) { %> selected="selected" <% } %>>????????????</option>
							<option value="3" <%if(util.getStr(paramMap.get("searchState")).equals("3")) { %> selected="selected" <% } %>>????????????</option>
						</select>
						</div>

						<div class="p_srchBox" style="display:inline-block;">
							<span class="p_kinds">????????? :</span>

							<select class="p_select" name="searchSelect" id="searchSelect">
								<%if(util.getStr(paramMap.get("list_mode")).equals("utility") || util.getStr(paramMap.get("list_mode")).equals("design") || util.getStr(paramMap.get("list_mode")).equals("")) { %>
									<option value="10">??????</option>
									<option value="1" <%if(util.getStr(paramMap.get("searchSelect")).equals("1")) { %> selected <% } %>>????????????</option>
									<option value="2" <%if(util.getStr(paramMap.get("searchSelect")).equals("2")) { %> selected <% } %>>????????????</option>
									<option value="3" <%if(util.getStr(paramMap.get("searchSelect")).equals("3")) { %> selected <% } %>>?????????</option>
									<option value="4" <%if(util.getStr(paramMap.get("searchSelect")).equals("4")) { %> selected <% } %>>?????????</option>
									<option value="5" <%if(util.getStr(paramMap.get("searchSelect")).equals("5")) { %> selected <% } %>>??????</option>
								<% } %>
								<%if(util.getStr(paramMap.get("list_mode")).equals("brand")) { %>
									<option value="10">??????</option>
									<option value="1" <%if(util.getStr(paramMap.get("searchSelect")).equals("1")) { %> selected <% } %>>????????????</option>
									<option value="2" <%if(util.getStr(paramMap.get("searchSelect")).equals("2")) { %> selected <% } %>>????????????</option>
									<option value="3" <%if(util.getStr(paramMap.get("searchSelect")).equals("3")) { %> selected <% } %>>?????????</option>
									<option value="5" <%if(util.getStr(paramMap.get("searchSelect")).equals("5")) { %> selected <% } %>>??????</option>
								<% } %>
								<%if(util.getStr(paramMap.get("list_mode")).equals("program")) { %>
									<option value="10">??????</option>
									<option value="2" <%if(util.getStr(paramMap.get("searchSelect")).equals("2")) { %> selected <% } %>>????????????</option>
									<option value="4" <%if(util.getStr(paramMap.get("searchSelect")).equals("4")) { %> selected <% } %>>?????????????????????</option>
									<option value="5" <%if(util.getStr(paramMap.get("searchSelect")).equals("5")) { %> selected <% } %>>??????</option>
								<% } %>
								<%if(util.getStr(paramMap.get("list_mode")).equals("knowhow")) { %>
									<option value="10">??????</option>
									<option value="4" <%if(util.getStr(paramMap.get("searchSelect")).equals("4")) { %> selected <% } %>>?????????</option>
									<option value="5" <%if(util.getStr(paramMap.get("searchSelect")).equals("5")) { %> selected <% } %>>??????</option>
								<% } %>
							</select>

							<input id="p_srch_txt" class="p_srch_txt" name="searchSelectText" type="text" title="??????????????????" value="<%=util.getStr(paramMap.get("searchSelectText"))%>" />

							<div class="p_btnBox" style="float:right;margin-left:10px;">
								<button class="btn_inp_g_01" onclick="pageSearchGo()" >??????</button>
							</div>
						</div>




						</div>
						<!--Patent_search E-->

					 </div>
				</div>
			<!-- bbs-top e -->
			</div>
</form>

	<div id="utility_list">
		<div class="total" style="margin-top: 10px;">
			[???????????? ?????? <span><%=staticVO.getTotalCount()%></span>???]
			<button type="button" id="excelUp" onclick="excelForm()" style="float:right; margin-bottom: 5px;" class="btn_inp_b_01">???????????????</button>
			<button type="button" id="excelDownload" class="btn_inp_b_01" style="float:right;"" onclick="location.href='/sys/registrationExcel.do?list_mode=<%=list_mode%>'">??????????????????</button>
		</div>
		<div>
			<!-- skin_basic_list s -->
			<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
				<colgroup>
					<%-- <col width="5%" />
					<col width="5%" />
					<col width="15%" />
					<col width="23%" />
					<col width="35%" />
					<col width="10%" /> --%>
					<col width="5%" />
					<col width="13%" />
					<col width="32%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????</th>
					<!-- <th scope="col">??????</th> -->
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????/??????</th>
				</tr>

				<%
				int cont1 = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
				for(HashMap rs:dataList) {%>
					<tr onclick="location.href='./<%=myPage%>?mode=view&amp;idx=<%=util.getStr(rs.get("SEARCH_PATENT_IDX"))%>&amp;list_mode=utility&amp;nowPage=<%=nowPage %>'" style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='#ffffff'">
						<td><%=cont1%></td>
						<td><%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_2.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_6.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
<%--
						<td scope="col">
						<img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+"s/"+util.getStr(rs.get("IMG_TITLE")))%>" alt="???????????????" style="width: 119px; height: 96px"/>
						</td>
 --%>
						<td  style="text-align:left;">
							<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("10")) { %>
								<img alt="??????/??????" src="/img/board/shape11.gif" />
								<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("20")) { %>
								<img alt="??????/??????" src="/img/board/shape12.gif" />
								<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("30")) { %>
								<img alt="????????????" src="/img/board/shape13.gif" />
								<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("40")) { %>
								<img alt="??????" src="/img/board/shape14.gif" />
								<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("50")) { %>
								<img alt="?????????/??????" src="/img/board/shape15.gif" />
								<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("60")) { %>
								<img alt="?????????/??????" src="/img/board/shape16.gif" />
								<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("70")) { %>
								<img alt="???????????????" src="/img/board/shape17.gif" />
								<% } %><%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("80")) { %>
								<img alt="?????????" src="/img/board/shape25.gif" />
								<% } %>
							<%=util.getStr(rs.get("INVENTION_KOR_NM"))%>(<%=util.getStr(rs.get("INVENTION_ENG_NM"))%>)
						</td>
						<td style="text-align:left;">
						<span style="display:block;float:left;width:50%;">
						IPC : <%=util.getStr(rs.get("ICP_CL"))%><br />
						???????????? : <%=util.getStr(rs.get("APLC_NO"))%><br />
						???????????? : <%=util.getStr(rs.get("REG_NO"))%><br />
						???????????? : <%=util.getStr(rs.get("PUBLIC_NO"))%><br />
						????????? : <%=util.getStr(rs.get("AGENT"))%>
						</span>
						<span style="display:block;">
						????????? : <%=util.getStr(rs.get("APLC_USER"))%><br />
						???????????? : <%=util.getStr(rs.get("APLC_DT"))%><br />
						???????????? : <%=util.getStr(rs.get("REG_DT"))%><br />
						???????????? : <%=util.getStr(rs.get("PUBLIC_DT"))%><br />
						????????? : <%=util.getStr(rs.get("INVENTOR"))%>
						</span>
						</td>
						<td>
							<%if(util.getStr(rs.get("ORG_GRP_NM")).equals(null) || util.getStr(rs.get("ORG_GRP_NM")).equals("")){ %>
								<%=util.getStr(rs.get("OWN_ORG_NM")) %>/<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
							<%}else{ %>
								<%=util.getStr(rs.get("ORG_GRP_NM")) %>/<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
							<%} %>
						</td>
					</tr>
			<%	cont1--;} %>
				</tbody>
			</table>
		<%=util.getPaging(staticVO, nowPage) %>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write', 'utility')"/>
		</div>
	</div>

	<div id="design_list">
		<div class="total" style="margin-top: 10px;">
			[????????? ?????? <span><%=staticVO.getTotalCount()%></span>???]
			<button type="button" id="excelUp" onclick="excelForm()" style="float:right; margin-bottom: 5px;" class="btn_inp_b_01">???????????????</button>
			<button type="button" id="excelDownload" class="btn_inp_b_01" style="float:right;" onclick="location.href='/sys/registrationExcel.do?list_mode=<%=list_mode%>'">??????????????????</button>
		</div>

		<div>
			<!-- skin_basic_list s -->
			<table class="skin_basic_list">
				<colgroup>
					<%-- <col width="5%" />
					<col width="8%" />
					<col width="25%" />
					<col width="30%" />
					<col width="30%" /> --%>
					<col width="5%" />
					<col width="13%" />
					<col width="32%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????</th>
					<!-- <th scope="col">??????</th> -->
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????/??????</th>
				</tr>
			<%
			int cont2 = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;idx=<%=util.getStr(rs.get("SEARCH_DESIGN_IDX"))%>&amp;list_mode=design&amp;nowPage=<%=nowPage %>'" style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='#ffffff'" >
					<td><%=cont2%></td>
						<td><%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_2.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_6.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
					<%-- <td scope="col">
						<img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+"s/"+util.getStr(rs.get("IMG_TITLE")))%>" alt="???????????????" style="width: 119px; height: 96px"/>
					</td> --%>
					<td  style="text-align:left;">
						<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("10")) { %>
							<img alt="??????/??????" src="/img/board/shape11.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("20")) { %>
							<img alt="??????/??????" src="/img/board/shape12.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("30")) { %>
							<img alt="????????????" src="/img/board/shape13.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("40")) { %>
							<img alt="??????" src="/img/board/shape14.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("50")) { %>
							<img alt="?????????/??????" src="/img/board/shape15.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("60")) { %>
							<img alt="?????????/??????" src="/img/board/shape16.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("70")) { %>
							<img alt="???????????????" src="/img/board/shape17.gif" />
							<% } %><%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("80")) { %>
								<img alt="?????????" src="/img/board/shape25.gif" />
								<% } %>
						<%=util.getStr(rs.get("USE_NM"))%>
					</td>
					<td  style="text-align:left;">
					<span style="display:block;float:left;width:50%;">
					?????? : <%if(util.getStr(rs.get("KOREA_CL")).equals("A")){%>
							????????????<br />
						<%}else{%>
							<%=util.getStr(rs.get("INTRL_CL"))%><br />
						<%} %>
					???????????? : <%=util.getStr(rs.get("APLC_NO"))%><br />
					??????????????? : <%=util.getStr(rs.get("DESIGN_NO"))%><br />
					????????? : <%=util.getStr(rs.get("AGENT"))%>
					</span>
					<span style="display:block;">
					????????? : <%=util.getStr(rs.get("APLC_USER"))%><br />
					???????????? : <%=util.getStr(rs.get("APLC_DT"))%><br />
					???????????? : <%=util.getStr(rs.get("REG_DT"))%><br />
					????????? : <%=util.getStr(rs.get("CREATION_USER"))%>
					</span>
					</td>
					<td>
						<%=util.getStr(rs.get("ORG_GRP_NM"))%>/<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
					</td>
				</tr>
		<%	cont2--;} %>
				</tbody>
			</table>
		<%=util.getPaging(staticVO, nowPage) %>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write', 'design')"/>
		</div>
	</div>

	<div id="brand_list">
		<div class="total" style="margin-top: 10px;">
			[?????? ?????? <span><%=staticVO.getTotalCount()%></span>???]
			<button type="button" id="excelUp" onclick="excelForm()" style="float:right; margin-bottom: 5px;" class="btn_inp_b_01">???????????????</button>
			<button type="button" id="excelDownload" class="btn_inp_b_01" style="float:right;" onclick="location.href='/sys/registrationExcel.do?list_mode=<%=list_mode%>'">??????????????????</button>
		</div>

		<div>
			<!-- skin_basic_list s -->
			<table class="skin_basic_list">
				<colgroup>
					<%-- <col width="5%" />
					<col width="8%" />
					<col width="25%" />
					<col width="30%" />
					<col width="30%" /> --%>
					<col width="5%" />
					<col width="13%" />
					<col width="32%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????</th>
					<!-- <th scope="col">??????</th> -->
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????/??????</th>
				</tr>
			<%
			int cont3 = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;idx=<%=util.getStr(rs.get("SEARCH_BRAND_IDX"))%>&amp;list_mode=brand&amp;nowPage=<%=nowPage %>'" style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='#ffffff'" >
					<td><%=cont3%></td>
						<td><%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_2.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_6.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
					<%-- <td>
						<img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+"s/"+util.getStr(rs.get("IMG_TITLE")))%>" alt="???????????????" style="width: 119px; height: 96px"/>
					</td> --%>
					<td  style="text-align:left;">
						<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????/??????" src="/img/board/shape11.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????/??????" src="/img/board/shape12.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="????????????" src="/img/board/shape13.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????" src="/img/board/shape14.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("?????????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="?????????/??????" src="/img/board/shape15.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("?????????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="?????????/??????" src="/img/board/shape16.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") ) { %>
							<img alt="???????????????" src="/img/board/shape17.gif" />
							<% } %><%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("80")) { %>
								<img alt="?????????" src="/img/board/shape25.gif" />
								<% } %>
						<%=util.getStr(rs.get("USE_NM"))%>
					</td>
					<td style="text-align:left;">
					<span style="display:block;float:left;width:50%;">
					???????????? : <%=util.getStr(rs.get("GOODS_CL"))%><br />
					???????????? : <%=util.getStr(rs.get("INTRL_APLC_NO"))%><br />
					???????????? : <%=util.getStr(rs.get("REG_NO"))%><br />
					???????????? : <%=util.getStr(rs.get("PBLANC_NO"))%><br />
					????????? : <%=util.getStr(rs.get("AGENT"))%>
					</span>
					<span style="display:block;">
					????????? : <%=util.getStr(rs.get("APLC_USER"))%><br />
					???????????? : <%=util.getStr(rs.get("INTRL_APLC_DT"))%><br />
					???????????? : <%=util.getStr(rs.get("REG_DT"))%><br />
					???????????? : <%=util.getStr(rs.get("PBLANC_DT"))%><br />
					???????????? : <%=util.getStr(rs.get("FIGURE_CODE"))%>
					</span>
					</td>
					<td>
						<%=util.getStr(rs.get("ORG_GRP_NM"))%>/<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
					</td>
				</tr>
			<% cont3--;} %>
				</tbody>
			</table>
		<%=util.getPaging(staticVO, nowPage) %>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write', 'brand')"/>
		</div>
	</div>

	<div id="program_list">
		<div class="total" style="margin-top: 10px;">
			[???????????? ?????? <span><%=staticVO.getTotalCount()%></span>???]
			<button type="button" id="excelUp" onclick="excelForm()" style="float:right; margin-bottom: 5px;" class="btn_inp_b_01">???????????????</button>
			<button type="button" id="excelDownload" class="btn_inp_b_01" style="float:right;" onclick="location.href='/sys/registrationExcel.do?list_mode=<%=list_mode%>'">??????????????????</button>
		</div>

		<div>
			<!-- skin_basic_list s -->
			<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
				<colgroup>
					<%-- <col width="5%" />
					<col width="8%" />
					<col width="25%" />
					<col width="30%" />
					<col width="30%" /> --%>
					<col width="5%" />
					<col width="13%" />
					<col width="32%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????</th>
					<!-- <th scope="col">??????</th> -->
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????/??????</th>
				</tr>
			<%
			int cont4 = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;idx=<%=util.getStr(rs.get("SEARCH_PROGRAM_IDX"))%>&amp;list_mode=program&amp;nowPage=<%=nowPage %>'" style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='#ffffff'" >
					<td><%=cont4%></td>
						<td><%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_2.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_6.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
					<%-- <td scope="col">
						<img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+"s/"+util.getStr(rs.get("IMG_TITLE")))%>" alt="???????????????" style="width: 119px; height: 96px"/>
					</td> --%>
					<td style="text-align:left;">
						<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????/??????" src="/img/board/shape11.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????/??????" src="/img/board/shape12.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="????????????" src="/img/board/shape13.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????" src="/img/board/shape14.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("?????????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="?????????/??????" src="/img/board/shape15.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("?????????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="?????????/??????" src="/img/board/shape16.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") ) { %>
							<img alt="???????????????" src="/img/board/shape17.gif" />
							<% } %><%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("80")) { %>
								<img alt="?????????" src="/img/board/shape25.gif" />
								<% } %>
						<%=util.getStr(rs.get("USE_NM"))%>
					</td>
					<td style="text-align:left;">
					<span style="display:block;float:left;width:50%;">
					???????????? : <%=util.getStr(rs.get("REG_NO"))%><br />
					????????? : <%=util.getStr(rs.get("PGM_AUTHOR"))%><br />
					???????????? : <%=util.getStr(rs.get("CRT_WORK_DE"))%>

					</span>
					<span style="display:block;">
					???????????? : <%=util.getStr(rs.get("REG_DE"))%><br />
					????????? : <%=util.getStr(rs.get("CRT_PARTICIPANT"))%><br />
					???????????? : <%=util.getStr(rs.get("PUBLICT_DE"))%>

					</span>
					</td>
					<td>
						<%=util.getStr(rs.get("ORG_GRP_NM"))%>/<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
					</td>
				</tr>
			<%	cont4--;} %>
				</tbody>
			</table>
		<%=util.getPaging(staticVO, nowPage) %>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write', 'program')"/>
		</div>
	</div>

	<div id="knowhow_list">
		<div class="total" style="margin-top: 10px;">
			[????????? ?????? <span><%=staticVO.getTotalCount()%></span>???]
			<button type="button" id="excelUp" onclick="excelForm()" style="float:right; margin-bottom: 5px;" class="btn_inp_b_01">???????????????</button>
			<button type="button" id="excelDownload" class="btn_inp_b_01" style="float:right;" onclick="location.href='/sys/registrationExcel.do?list_mode=<%=list_mode%>'">??????????????????</button>
		</div>

		<div>
			<!-- skin_basic_list s -->
			<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
				<colgroup>
					<%-- <col width="5%" />
					<col width="8%" />
					<col width="25%" />
					<col width="30%" />
					<col width="30%" /> --%>
					<col width="5%" />
					<col width="13%" />
					<col width="32%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????</th>
					<!-- <th scope="col">??????</th> -->
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????/??????</th>
				</tr>
			<%
			int cont5 = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;idx=<%=util.getStr(rs.get("SEARCH_KNOWHOW_IDX"))%>&amp;list_mode=knowhow&amp;nowPage=<%=nowPage %>'" style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='#ffffff'" >
					<td><%=cont5%></td>
						<td><%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_2.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_6.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
					<%-- <td scope="col">
						<img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+"s/"+util.getStr(rs.get("IMG_TITLE")))%>" alt="???????????????" style="width: 119px; height: 96px"/>
					</td> --%>
					<td  style="text-align:left;">
						<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????/??????" src="/img/board/shape11.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????/??????" src="/img/board/shape12.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="????????????" src="/img/board/shape13.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="??????" src="/img/board/shape14.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("?????????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="?????????/??????" src="/img/board/shape15.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("?????????") || util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????")) { %>
							<img alt="?????????/??????" src="/img/board/shape16.gif" />
							<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("??????") ) { %>
							<img alt="???????????????" src="/img/board/shape17.gif" />
							<% } %><%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("80")) { %>
								<img alt="?????????" src="/img/board/shape25.gif" />
								<% } %>
						<%=util.getStr(rs.get("TCHNLGY_NM"))%>
					</td>
					<td style="text-align:left;">
					<span style="display:block;float:left;width:50%;">
					??????????????? : <%=util.getStr(rs.get("RSPNBER_USER_NM"))%><br />
					????????? : <%=util.getStr(rs.get("RSPNBER_TEL_NO"))%><br />
					????????? : <%=util.getStr(rs.get("RSPNBER_EMAIL"))%>
					</span>
					<span style="display:block;">
					?????? : <%=util.getStr(rs.get("RSPNBER_OFC_POSITION"))%><br />
					????????? : <%=util.getStr(rs.get("RSPNBER_MOBILE_PHONE"))%><br />
					???????????? : <%if(util.getStr(rs.get("BEFORE_INFO")).equals("G")) { %>
							????????????
							<% } %> <%if(util.getStr(rs.get("BEFORE_INFO")).equals("E")) { %>
							????????????
							<% } %>
							<br />

					</span>
					</td>
					<td>
						<%=util.getStr(rs.get("ORG_GRP_NM"))%>/<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
					</td>
				</tr>
			<%	cont5--;} %>
				</tbody>
			</table>
		<%=util.getPaging(staticVO, nowPage) %>
		</div>
		<div class="btn_right_box">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write', 'knowhow')"/>
		</div>
	</div>
</div>


<script type="text/javascript">
	function goSubmit(mode, list_mode){
		$('#mode').val(mode);
		$('#list_mode').val(list_mode);
		$('#searchForm').submit();
	}

	function view(mode, idx, list_mode){
		$('#mode').val(mode);
		$('#idx').val(idx);
		$('#list_mode').val(list_mode);
		$('#searchForm').submit();
	}
	function list(list_mode){
		$('#list_mode').val(list_mode);
		$('#searchForm').submit();
	}
	function pageSearchGo(){
		$('#mode').val('list');
		$('#state').val(state);
		$('#searchForm').submit();
	}
	function excelForm() {
		$("#mode").val("excel");
		$("#searchForm").submit();
	}

<%if(!util.getStr(paramMap.get("reDeth1")).equals(null) && !util.getStr(paramMap.get("reDeth1")).equals("")) { %>
standardDeth1('reDeth2<%=scCnt %>');
<% } %>

	function standardDeth1(mode){
		//alert("mode" + mode);
		<%-- <%if(!util.getStr(paramMap.get("reDeth2")).equals("") || !util.getStr(paramMap.get("reDeth2")).equals(null)) { %>
			var reDeth2 = "<%=util.getStr(paramMap.get("reDeth2"))%>";
			alert("reDeth2 : "+ reDeth2);
		<% } %> --%>
		//var selectDeth = "";
		var result = "";
		var mode = mode;
		var name = mode.substr(0,2);
		var name2 = mode.substring(7,8);
		var tchnlgyS = "${paramMap.reDeth2}";
		$('#mCode').val($('#reDeth1'+name2).val());
		if(name == "re"){
			var deth3 = $('#reDeth1'+name2).val();
		}else if(name == "ev"){
			var deth3 = $('#evDeth1'+name2).val();
		}else if(name == "co"){
			var deth3 = $('#coDeth1'+name2).val();
		}
	 	$.ajax({
	         type: "POST",
	         data : {
	        	 deth3 : deth3
	         },
	         url : '/sys/dethCheck.do',
	         dataType : 'json',
	         success : function(data){
	        	 $('#'+mode).html("");
	        	result += "<option value=''>???????????????.</option>";
	        	for(i=0; i<data.cnt; i++){
	        		if(tchnlgyS == data.dataList[i].CODE){
	        			result += "<option value=\""+data.dataList[i].CODE+"\" id=deth"+i+" selected>"+data.dataList[i].NAME+"</option>";
	        		} else {
						result += "<option value=\""+data.dataList[i].CODE+"\" id=deth"+i+">"+data.dataList[i].NAME+"</option>";
	        		}
	        	}
	        	$('#'+mode).append(result);
	         }
		});
	}

</script>


<!--// bo_btn -->
