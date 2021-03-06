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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> publicTypeList = request.getAttribute("publicTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("publicTypeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	//String fileGrp = "public";
	//String fileSubGrp = "";
	//String fileFullGrp =fileGrp+fileSubGrp;

	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String dataIdx = util.getStr(paramMap.get("dataIdx"));
	String ArrayCheck = util.getStr(paramMap.get("ArrayCheck"));

%>

<div class="skin_list">
	<div>
		<form action="?<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="dataIdx" id="dataIdx" value="<%=dataIdx%>" />
			<input type="hidden" name="ArrayCheck" id="ArrayCheck" value="<%=ArrayCheck%>" />


			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search" style="line-height:27px;">
					<div style="position:relative;">
					<span style="float:left; padding:0px 0px;">????????? ?????? :</span>
					<%
						int cnt = 1;
						for(HashMap rs:publicTypeList) {

							String ckChecked = "NO";

							if(util.getStr(paramMap.get("ArrayCheck")) != null){
								String[] arrChk = util.getStr(paramMap.get("ArrayCheck")).split(",");

								for(int i =0;  i < arrChk.length ; i++){
									if(util.getStr(rs.get("CODE_CD")).equals(arrChk[i])){
										//System.out.println(arrChk[i]);
										ckChecked = "YES";
									}
								}

							}else{

								if(request.getParameterValues("searchPublicType[]") != null){
									String[] ckTp = request.getParameterValues("searchPublicType[]");

									for(int i =0;  i < ckTp.length ; i++){
										if(util.getStr(rs.get("CODE_CD")).equals(ckTp[i])){
											ckChecked = "YES";
										}
									}
								}
							}
					%>
					<span style="float:left; padding:0px 5px;"><input type="checkbox" name="searchPublicType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>>
						  <label for="sstp<%=cnt%>"><%=util.getStr(rs.get("CODE_NM"))%></label>
					</span>
					<%
						cnt++;
						}
					%>
					</div>
					<div style="position:relative;clear:both;">
						<label  for="searchState">???????????? :</label>
						<select class="select" name="searchState" id="searchState" style="height: 24px;">
							<option value="">??????</option>
							<option value="10" <%if("10".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>????????????</option>
							<option value="20" <%if("20".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>??????</option>
							<option value="30" <%if("30".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>????????????</option>
						</select><br>

						<!-- ?????????????????? -->
						<label  for="searchType" >???????????? :</label>
						<select name="searchType" id="searchType" class="select" style="height: 24px;">
							<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
							<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
							<option value="GROUP" <%if("GROUP".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>????????????</option>
						</select>

						<!-- ????????? -->
						<input type="text" class="inp_txt" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:74%;" />

						<!-- ???????????? -->
						<input type="button" class="btn_inp_g_01" value="??????" onclick="goSubmit('list')" style="float:right"/>
					</div>
				</div>
				<!-- board-search e -->
			</div>
			</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="float:left; text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]

				<%--
				<div class="btn_right_box">
					<input type="button" class="btn_inp_w_01" value="?????????" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"/>
					<input type="button" class="btn_inp_w_01" value="?????????" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"/>
					<input type="button" class="btn_inp_w_01" value="???????????????" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"/>
					<input type="button" class="btn_inp_w_01" value="?????????" onclick="goSubmit('list', 'list', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="??????????????????" onclick="goSubmit('list','imagelist', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="??????????????????" onclick="goSubmit('list','bloglist', '<%=sortMode%>')"/>
				</div>
				--%>
			</div>

		</form>
		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 8%;" />
				<col style="width: 8%;" />
				<col style="width: 14%;" />
				<col style="width: 27%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 8%;" />
				<%-- <col style="width: 10%;" /> --%>
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<!-- <th scope="col">??????</th> -->
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(dataList.size() == 0){
				%>
					<tr><td colspan="8">???????????? ???????????? ????????????</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("SITE_ID"))%></td>
					<td>
						<% if(rs.get("DATA03").equals("POLICY")) { %> ????????????
						<% } else if(rs.get("DATA03").equals("LAWORD")) { %> ????????????
						<% } else if(rs.get("DATA03").equals("STATS")) { %> ????????????
						<% } else if(rs.get("DATA03").equals("TECHNOLOGY")) { %> ????????????
						<% } else if(rs.get("DATA03").equals("MENUAL")) { %> ???????????? ?????????
						<% } else if(rs.get("DATA03").equals("BROCHURE")) { %> ???????????? ????????????
						<% } else if(rs.get("DATA03").equals("SCIENCE")) { %> ??????????????????
						<% } else if(rs.get("DATA03").equals("INDUSTRIAL")) { %> ??????????????????
						<% } else { %> ?????????   <% } %>
					</td>
					<td class="subject">
						<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
							<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
					</td>
					<td>
						<%if(util.getStr(rs.get("DATA04")).length()>8){%><%=util.getStr(rs.get("DATA04")).substring(0, 8)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("DATA04"))%><%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA05"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("HITS"))%>
					</td>
					<%-- <td>
						<%if(util.getStr(rs.get("DATA06")).equals("10")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("DATA06")).equals("20")) { %> <img alt="??????" src="/img/back/comm/edu_state_img_07.png"> <% } %>
						<%if(util.getStr(rs.get("DATA06")).equals("30")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
					</td> --%>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck()) { %>
			<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="?????????" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,listMode,sortMode,dataIdx){

		/*for(var i=1; i<$('input[name="searchPublicType[]"]').length; i++){
			if($('input:checkbox[id="sstp'+i+'"]').is(":checked")==true){
				alert($('input:checkbox[id="sstp'+i+'"]').val());
			}
		}*/

		var ArrayCheck = new Array();	//Array??????
		var CheckArr = document.getElementsByName("searchPublicType[]");	//??????????????? ????????? ????????????.

		for(var i=0; i<CheckArr.length; i++){
			if(CheckArr[i].checked) {
				//alert(CheckArr[i].value);
				ArrayCheck.push(CheckArr[i].value);
			}
		}
		//alert(ArrayCheck);
		$("#ArrayCheck").val(ArrayCheck);

		$('#dataIdx').val(dataIdx);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

</script>