<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userDataMap = request.getAttribute("userDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userDataMap");
	HashMap<String, String> resvDataMap = request.getAttribute("resvDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("resvDataMap");

	int nowDate = util.getInt(util.getDate("yyyyMMdd"));
	int eduOrdStDt = util.getInt(dataMap.get("EDU_ORD_ST_DT").replaceAll("-", ""));
	int eduOrdEdDt = util.getInt(dataMap.get("EDU_ORD_ED_DT").replaceAll("-", ""));

	int eduOrdPeople = util.getInt(util.getIntStr(dataMap.get("EDU_ORD_PEOPLE")));
	int eduPeople = util.getInt(util.getIntStr(dataMap.get("EDU_PEOPLE")));

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String eduId = util.getStr(paramMap.get("eduId"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String listMode = util.getStr(paramMap.get("listMode"));
	LoginVO loginVO = util.getLoginInfo(request);

%>

	  <form name="fview" id="fview" action="./sub.do" method="post" >
		<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="m" value="<%=m%>" />
	  	<input type="hidden" name="eduId" id="eduId" value="<%=eduId%>" />
	  	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="reUrl" id="reUrl" value="/jntis/sub.do?m=<%=m%>&amp;eduId=<%=eduId%>" />

<div class="basic_viewWrap">

<h2 class="h4_tit">????????????</h2>
<table class="skin_view">
  <caption>???????????? ???????????????</caption>
	<colgroup>
	  <col style="width:15%;" />
	  <col style="width:35%;" />
	  <col style="width:15%;" />
	  <col style="width:35%;" />
	</colgroup>

	<tbody>
			<tr>
				<th scope="col">?????????</th>
				<td class="r_line_none b_notice" colspan="3"><%=util.getStr(dataMap.get("EDU_NM"))%></td>
			</tr>
	 		<tr>
				<th scope="col">????????????</th>
				<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("EDU_CATE_NM"))%></td>
			</tr>
			<tr>
				  <th scope="col">????????????</th>
				  <td class="r_line_none">
				  	<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>
				  </td>
				  <th scope="col">????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ED_DT"))%>
				  </td>
				</tr>
				<tr>
				<th scope="col" class="top_sell bln">????????????</th>
					<td class="r_line_none">
						<%=util.getIntStr(dataMap.get("EDU_ST_TIME"))%>??? ~ <%=util.getIntStr(dataMap.get("EDU_ED_TIME"))%>???
					</td>
				<th scope="col">???????????????</th>
				  <td  class="r_line_none">
				  	<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>(??????)
				  </td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<% if("?????????".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="?????????" style="width: 86px;" src="/img/back/comm/edu_state_img_01.png" />
					<% }else if("????????????".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="????????????" style="width: 86px;" src="/img/back/comm/edu_state_img_02.png" />
					<% }else if("????????????".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="????????????" style="width: 86px;" src="/img/back/comm/edu_state_img_03.png" />
					<% }else if("?????????".equals(util.getStr(dataMap.get("EDU_ORD_STATE")))){ %>
							<img alt="?????????" style="width: 86px;" src="/img/back/comm/edu_state_img_04.png" />
					<% }else{%>
							<img alt="????????????" style="width: 86px;" src="/img/back/comm/edu_state_img_05.png" />
					<% } %>
				  </td>
				</tr>

				<tr>
				  <th scope="col">????????????</th>
				  <td class="r_line_none" colspan="3">
				  	<%=util.getIntStr(dataMap.get("EDU_ORD_PEOPLE"))%> / <%=util.getIntStr(dataMap.get("EDU_PEOPLE"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">??????</th>
				  <td class="r_line_none" >
				  	<%=util.getStr(dataMap.get("EDU_USER_NM"))%>(<%=util.getStr(dataMap.get("EDU_USER_DEPT"))%>)
				  </td>
				  <th scope="col">?????? ??????</th>
				  <td class="r_line_none" >
				  	<%=util.getStr(dataMap.get("EDU_USER_SECTOR"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">?????????</th>
				  <td  class="r_line_none">
				  	<%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "??????" : util.getComma(dataMap.get("EDU_PAY"))+"(???)"%>
				  </td>
				  <th scope="col">????????????????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("10")?"??????":"?????????"%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">???????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_TEL"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_TARGET"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_CONTENT"))%>
				  </td>
				</tr>
				<tr>
				  <th scope="col">???????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_INFO"))%>
				  </td>
				</tr>

	</tbody>
</table>

<br/>
<h2 class="h4_tit">????????????</h2>
<table class="skin_view" summary="???????????? ???????????????">
  <caption>???????????? ???????????????</caption>
	<colgroup>
	  <col style="width:15%;" />
	  <col style="width:35%;" />
	  <col style="width:15%;" />
	  <col style="width:35%;" />
	</colgroup>

	<tbody>
				<tr>
					<th scope="col" class="top_sell bln">????????????</th>
					<td class="r_line_none" colspan="3">
						<%=util.getStr(dataMap.get("EDU_AUSPICES_NM"))%>
					</td>
				</tr>
			<tr>
				  <th scope="col">????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>
				  </td>
				</tr>
								<tr>
				  <th scope="col">????????????</th>
				  <td  class="r_line_none" colspan="3">
				  	<%=util.getStr(dataMap.get("EDU_PLACE"))%>
					<br/>
					<%=util.getStr(dataMap.get("EDU_PLACE_DETAIL"))%>
				  </td>
				</tr>
				<tr>
						<th scope="col" class="top_sell bln">?????????</th>
							<td class="r_line_none">
							<table class="skin_view" style="width:100%">
							  <caption>?????? ???????????????</caption>
								<colgroup>
								  <col style="width:15%;" />
								  <col style="width:35%;" />
								  <col style="width:15%;" />
								  <col style="width:35%;" />
								</colgroup>
							<tbody>
							<tr>
								<th scope="col">?????????</th>
								<td class="r_line_none"><%=util.getStr(dataMap.get("MANAGER_USER_NM"))%></td>
								<th scope="col">????????????</th>
								<td class="r_line_none"><%=util.getStr(dataMap.get("MANAGER_TEL_NO"))%></td>
							</tr>
							<tr>
								<th scope="col">???????????????</th>
								<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("MANAGER_EMAIL"))%></td>
							</tr>
							<tr>
								<th scope="col">????????????</th>
								<td class="r_line_none"><%=util.getStr(dataMap.get("MANAGER_DEPT"))%></td>
								<th scope="col">??????</th>
								<td class="r_line_none"><%=util.getStr(dataMap.get("POSITION_NM"))%></td>
							</tr>
							</tbody>
							</table>

							</td>
				</tr>
				<tr>
				  <th scope="col">??????</th>
				  <td  class="r_line_none" colspan="3">
				  	<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
				  </td>
				</tr>
	</tbody>
</table>

<%if(util.loginCheck()|| (nowDate >= eduOrdStDt && nowDate <= eduOrdEdDt)){ %>
<br/>
<h2 class="h4_tit">????????????</h2>

				<table id="step1" class="skin_write">
						<caption>???????????? ???????????????</caption>
						<colgroup>
				   			<col style="width:200px">
				   			<col style="width:800">
						</colgroup>
						<tbody>

						<tr>
							<th scope="col" class="top_sell bln">?????????</th>
							<td class="r_line_none">
								<%=util.getStr(dataMap.get("EDU_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">????????????</th>
							<td class="r_line_none">
								<%=util.getStr(dataMap.get("EDU_CATE_NM"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">??????????????????</th>
							<td class="r_line_none" colspan="3">
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("10")?"??????":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("20")?"??????":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("30")?"??????":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("40")?"????????????":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("50")?"??????":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("60")?"?????????":"" %>
							</td>
						</tr>
						<tr id="rejectTr" <%=util.getStr(resvDataMap.get("RESV_STATE")).equals("30")?"":"style='display:none'" %>>
							<th scope="col" class="top_sell bln" >????????????</th>
							<td class="r_line_none" colspan="3">
							<pre><%=util.getStr(resvDataMap.get("RESV_REJECT"))%></pre>
							</td>
						</tr>

						<tr>
							<th scope="col" class="top_sell bln">????????????</th>
							<td class="r_line_none">
								<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>
							</td>
							<th scope="col" class="top_sell bln">????????????</th>
							<td class="r_line_none">
								<%=util.getStr(dataMap.get("EDU_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ED_DT"))%>
							</td>
						</tr>

						<tr>
							<th scope="col" class="top_sell bln">????????????</th>
							<td class="r_line_none">
								<%=util.getIntStr(dataMap.get("EDU_ST_TIME"))%>??? ~ <%=util.getIntStr(dataMap.get("EDU_ED_TIME"))%>???
							</td>
							<th scope="col" class="top_sell bln">???????????????</th>
							<td class="r_line_none">
								<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>(??????)
							</td>
						</tr>

						<tr>
							<th scope="col" class="top_sell bln">????????????</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("PSN_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">??????</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("GENDER_TYPE_CD")).equals("M")? "??????":"??????"%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">??????</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("ORG_GRP_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">??????</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("POSITION_NM"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">????????? ????????? ??????</th>
							<td class="r_line_none">
								<%if(util.getIntStr(resvDataMap.get("EDU_RESV_ID")).equals("0")){ %>
									<input type="hidden" name="phone" id="phone" />
									<input type="text" name="phone01" id="phone01" class="inp_txt02" style="width:50px" maxlength="4" /> - <input type="text" name="phone02" id="phone02" class="inp_txt02" style="width:75px" maxlength="4" /> - <input type="text" name="phone03" id="phone03" class="inp_txt02" style="width:75px" maxlength="4" />
								<%}else{ %>
								<%=util.getIntStr(resvDataMap.get("USER_TEL"))%>
								<%}%>

							</td>
							<th scope="col" class="top_sell bln">????????? ?????????</th>
							<td class="r_line_none">
								<%=util.getIntStr(userDataMap.get("EMAIL"))%>
							</td>
						</tr>

					</tbody>
				</table>
<% }%>
		<div class="b_btn_area">

			<span>
			<%if(util.loginCheck()){ %>
				<%if(nowDate >= eduOrdStDt && nowDate <= eduOrdEdDt){//?????????????????? ??????????????????%>
				<input type="hidden" name="eduResvId" id="eduResvId" value="<%=util.getIntStr(resvDataMap.get("EDU_RESV_ID")) %>" />
				<%if(util.getStr(resvDataMap.get("RESV_STATE")).equals("10")){%>
					<input type="button" class="btn_rgt2" value="????????????" onclick="actStateChange()"/>
				<%}else if(util.getStr(resvDataMap.get("RESV_STATE")).equals("30")||util.getStr(resvDataMap.get("RESV_STATE")).equals("40")){%>
					<input type="button" class="btn_rgt2" value="?????????" onclick="actStateChange()"/>
				<%}else{
				if(eduPeople > eduOrdPeople){%>
					<input type="button" class="btn_rgt2" value="??????" onclick="pageWriteGo()"/>
				<%}
				 }
				}%>
			<%}else{ %>
				<%if(nowDate >= eduOrdStDt && nowDate <= eduOrdEdDt && eduPeople > eduOrdPeople){//?????????????????? ??????????????????%>
					<input type="button" class="btn_rgt2" value="??????" onclick="alert('????????? ??? ????????? ???????????????.')"/>
					<% }
				}
			%>
			<input type="button" class="btn_lft" value="??????" onclick="pageListGo()"/>
			</span>
		</div>
	</div>
</form>
<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}

	function actStateChange(){
		$('#mode').val('stateChange');
		$('#fview').submit();
	}


	function pageWriteGo(){
		var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
		$('#mode').val('write');
		if($('#phone01').val() != '' && $('#phone02').val() != '' && $('#phone03').val() != ''){
			var phone_check = $('#phone01').val()+'-'+$('#phone02').val()+'-'+$('#phone03').val();
			$('#phone').val(phone_check);

			if(!regExp.test($('#phone').val())){
				alert("????????? ????????? ?????? ?????? ???????????????. ?????? ??????????????????");
				$('#phone01').focus();
				return false;
			}
		}
		$('#fview').submit();
	}

var mapContainer = document.getElementById('map'), // ????????? ????????? div
mapOption = {
	center: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>), // ????????? ????????????
	level: 5 // ????????? ?????? ??????
};

//????????? ?????? ??????
var map = new daum.maps.Map(mapContainer, mapOption);
//??????-?????? ?????? ????????? ??????
var geocoder = new daum.maps.services.Geocoder();
//????????? ?????? ??????
var marker = new daum.maps.Marker({
	position: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>),
	map: map
});


</script>