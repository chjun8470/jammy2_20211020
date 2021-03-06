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
	String searchState = util.getStr(paramMap.get("searchState"));

	String userTp = util.getStr(paramMap.get("userTp"));
	String orgGrpCd = util.getStr(paramMap.get("orgGrpCd"));
	String orgGrpSubCd = util.getStr(paramMap.get("orgGrpSubCd"));
	String deptNm = util.getStr(paramMap.get("deptNm"));
	String authLv = util.getStr(paramMap.get("authLv"));
	String searchNameOrg = util.getStr(paramMap.get("searchNameOrg"));

%>


<div class="skin_list">
	<div>
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>"/>
			<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>"/>
			<input type="hidden" name="tmenu" id="tmenu" value="2"/>
			<input type="hidden" name="rndEquIdx" id="rndEquIdx" value="<%=rndEquIdx%>"/>
			<input type="hidden" name="equipCd" id="equipCd" value="<%=equipCd%>"/>
			<input type="hidden" name="orgGrpSubCd" id="orgGrpSubCd" value="<%=orgGrpSubCd%>"/>
			<input type="hidden" name="state" id="state" value=""/>
			<input type="hidden" name="pageName" id="pageName" value="jnspTotal"/>

			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<div style="position:relative;">

						<span>???????????? :</span>
						<select class="select" name="searchState" id="searchState" >
							<option value="">??????</option>
							<option value="1" <%if(util.getStr(paramMap.get("searchState")).equals("1")) { %> selected="selected" <% } %>>????????????</option>
							<option value="2" <%if(util.getStr(paramMap.get("searchState")).equals("2")) { %> selected="selected" <% } %>>??????</option>
							<option value="3" <%if(util.getStr(paramMap.get("searchState")).equals("3")) { %> selected="selected" <% } %>>????????????</option>
							<option value="5" <%if(util.getStr(paramMap.get("searchState")).equals("5")) { %> selected="selected" <% } %>>????????????</option>
							<option value="6" <%if(util.getStr(paramMap.get("searchState")).equals("6")) { %> selected="selected" <% } %>>????????????</option>
							<option value="7" <%if(util.getStr(paramMap.get("searchState")).equals("7")) { %> selected="selected" <% } %>>????????????</option>
						</select>

						<%if(authLv.equals("99")){//???????????????%>
						<span style="margin-left:17px;">?????? :</span>
						<input type="text" name="searchNameOrg" id="searchNameOrg" class="inp_txt" value="<%=util.getStr(paramMap.get("searchNameOrg"))%>" />
						<select class="select" name="searchOrgGrp" id="searchOrgGrp" style="width:200px;">
							<option value="">??????</option>
							<%for(HashMap rs:orgGrpList) {%>
							<option value="<%=util.getStr(rs.get("ORG_GRP_CD"))%>" <%if(util.getStr(paramMap.get("searchOrgGrp")).equals(util.getStr(rs.get("ORG_GRP_CD")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("ORG_GRP_NM"))%></option>
							<%}%>
						</select>
						<input type="button" class="btn_inp_g_01" value="????????????" onclick="searchNameCheck()"/>
						<%
							}else{

								for(HashMap rs:orgGrpList) {

									if(orgGrpCd.equals(util.getStr(rs.get("ORG_GRP_CD")))){
						%>
									<input type="hidden" name="searchOrgGrp" id="searchOrgGrp" class="inp_txt" value="<%=orgGrpCd%>"/>
									<input type="text" name="searchOrgGrpNm" id="searchOrgGrpNm" class="inp_txt" value="<%=util.getStr(rs.get("ORG_GRP_NM"))%>" style="width:192px; display: none;" readonly/>
						<%			}
								}
							}
						%>

						<%if(authLv.equals("99")){//???????????????%>
							<span style="margin-left:18px;">?????? :</span>
							<input type="text" name="searchOrgSub" id="searchOrgSub" class="inp_txt" value="<%=util.getStr(paramMap.get("searchOrgSub"))%>" style="width:300px;"/>
						<%}else if(authLv.equals("80")){%>
							<span>?????? :</span>
							<input type="text" name="searchOrgSub" id="searchOrgSub" class="inp_txt" value="<%=util.getStr(paramMap.get("searchOrgSub"))%>" style="width:300px;"/>
						<%} else {%>
							<input type="text" name="searchOrgSub" id="searchOrgSub" class="inp_txt" value="<%=deptNm%>" style="width:300px; display: none;" readonly/>
						<% } %>
					</div>

					<div style="position:relative;">
						<select name="searchType" id="searchType" class="select" style="width:132px;">
							<option value="jeinetNo" <%if("jeinetNo".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>JEINET ????????????</option>
							<option value="ntisNo" <%if("ntisNo".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>ZEUS ????????????</option>
							<option value="etubeNo" <%if("etubeNo".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>E-TUBE ????????????</option>
							<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????/?????????</option>
							<option value="model" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
							<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
						</select>
						<!-- ????????? -->
						<input type="text" name="searchWord" id="searchWord" class="inp_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:745px;"/>

						<!-- ???????????? -->
						<input type="button" class="btn_inp_g_01" value="??????" onclick="pageSearchGo()" style="float:right;"/>
					</div>
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

		</form>
		<!-- searchForm e -->

		<div class="total" style="margin:10px;">
			[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]

			<span style="float:right; margin-bottom:5px;">
				<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="goExcel()">??????????????????</button>
			</span>
		</div>

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 25%;" />
				<col style="width: 15%;" />
				<col style="width: 255%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">????????????</th>
					<th scope="col">JEINET ????????????</th>
					<th scope="col">????????????????????????</th>
					<th scope="col">
						<%if(equipCd.equals("1")){%>
							?????????
						<%}else{%>
							?????????
						<%}%>
					</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????/?????????</th>
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
							<%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="??????" src="/img/back/comm/edu_state_img_07.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("6")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_6.png"> <% } %>
							<%if(util.getStr(rs.get("STATE")).equals("7")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_7.png"> <% } %>
						</td>
	               		<td><%=util.getStr(rs.get("RND_EQU_IDX"))%></td>
						<td><%=util.getStr(rs.get("FIXED_ASET_NO_YN")).equals("Y") ? "???????????? ??????":util.getStr(rs.get("FIXED_ASET_NO"))%></td>
						<td class="subject"><%=util.getStr(rs.get("KOR_NM"))%><br/>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
						<td><%=util.getStr(rs.get("MODEL_NM")).equals("") ? "????????? ??????":util.getStr(rs.get("MODEL_NM"))%></td>
						<td><%=util.getStr(rs.get("ORG_GRP_NM"))%><br/><%=util.getStr(rs.get("DEPT_NM"))%></td>
					</tr>
				<%
						cont--;
						}
					}else{
							out.println("<tr><td colspan='7'>????????? ????????? ????????????.</td></tr>");
					}
				%>
			</tbody>
		</table>

		<%=util.getPaging(staticVO, nowPage) %>
	</div>

	<div class="btn_box">
		<div class="btn_right_box" >
		<%if(Integer.parseInt(loginVO.getAuthLv()) >= 70) {%>
	    	<input type="button" class="btn_inp_b_01" value="??????" onclick="pageWriteGo()" />
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
		$('#rndEquIdx').val(idx);
		$('#mode').val('view');

		if($('#equipCd').val() == '2'){
			$('#searchForm').attr("action","/sys/sys_jnsptotal_fc.do");
		}else{
			$('#searchForm').attr("action","/sys/sys_jnsptotal_eq.do");
		}

		$('#searchForm').submit();
	}

	function searchNameCheck(){
		$.ajax({
			url : "/sys/searchNameCheck.do",
			type : "POST",
			data : {
				searchNameOrg : $('#searchNameOrg').val()
			},
			success : function(data) {
				var txt = "";
						txt += "<option value=''>??????</option>";
					for(i = 0; i < data.orgGrpList.length; i++){
						txt += "<option value='"+data.orgGrpList[i].ORG_GRP_CD+"'>"+data.orgGrpList[i].ORG_GRP_NM;
						txt += "</option>";
					}

	      		$("#searchOrgGrp").html(txt);
	        }
		})
	}


	function goExcel(){
		$('#searchForm').attr("action","/sys/excel.do");
		$('#searchForm').submit();
		$('#searchForm').attr("action","/sys/sys_jnsptotal_fc.do");
	}
</script>
