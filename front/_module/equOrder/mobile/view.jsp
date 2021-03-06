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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");
	//ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	
	String mode = util.getStr(paramMap.get("mode"));
	String siteId = util.getStr(paramMap.get("siteId"));
	
	Boolean userCheck = false;
	String paramUserIdx = util.getStr(paramMap.get("userIdx"));
	String loginUserIdx = util.getStr(loginVO.getUserIdx());
	if(paramUserIdx.equals(loginUserIdx)) {
		userCheck = true;
	}
%>

	<div class="MPTit">???????????? ?????? ?????????</div>
	
	<div class="basic_viewWrap">
		<table class="skin_view01">
			<colgroup>
				<col width="30%"/>
				<col width="70%"/>
			</colgroup>
			<tbody>
				<tr>
         			<th scope="col">JEINET ????????????</th>
         			<td scope="col" class="r_line_none">
         				J-<%=util.getStr(paramMap.get("equOrderIdx"))%>
         			</td>
         		</tr>
         		<tr>
         			<th scope="col">??????????????????</th>
         			<td scope="col" class="r_line_none">
         			</td>
        		</tr>
				<tr>
        			<th scope="col">?????????</th>
        			<td scope="col" class="r_line_none">
        				<%=util.getStr(dataMap.get("ORDER_OPERATOR"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("ORDER_OPERATOR_DT"))%>
        			</td>
       			</tr>
				<tr>
          			<th scope="col">????????????</th>
          			<td scope="col" class="r_line_none">
          				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> <!-- <img alt="????????????" src="/img/back/comm/order_state_img_1.png" /> --><div class="br01">????????????</div> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- <img alt="????????????" src="/img/back/comm/order_state_img_2.png" /> --><div class="yw01">????????????</div> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> 
						<!-- <img alt="????????????" src="/img/back/comm/order_state_img_3.png" /> --><div class="rd01">????????????</div><br /> ???????????? :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <!-- <img alt="????????????" src="/img/back/comm/order_state_img_4.png" /> --><div class="gr01">????????????</div> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> <!-- <img alt="????????????" src="/img/back/comm/order_state_img_5.png" /> --><div class="br02">????????????</div> <% } %>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="MPTit MAT20">????????????</div>
		
			<table class="skin_view01">
				<colgroup>
					<col width="30%" />
					<col width="70%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="col">???????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("ORDER_DT"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">???????????????</th>
						<td scope="col" class="r_line_none"></td>
					</tr>
					<tr>
						<th scope="col">??????????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("USE_ST_DT"))%>
							~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>
					
						</td>
					</tr>
					<tr>
						<th scope="col">??????????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>
							~ <%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(userMap.get("PSN_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">?????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(userMap.get("EMAIL"))%>
							<br /><%=util.getStr(userMap.get("PHONE"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">???????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(userMap.get("ORG_GRP_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????/??????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("DEPT_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">????????? ??????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("CORP_POSITION"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">?????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">?????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
						</td>
					</tr>
					<tr>
						<th scope="col">?????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("MODEL_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">?????????(?????????)</th>
						<td scope="col" class="r_line_none">
							<%
							String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
							String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
							String sampleNmArr[] = sampleNm.split("\\|\\|");
							String sampleNoArr[] = sampleNo.split("\\|\\|");
							
							for(int i = 1 ; i < sampleNmArr.length ; i++ ){
								if( i != 1 ){
									//out.println(", ");
								}
								out.println(sampleNmArr[i]);
								out.println("(");
								out.println(sampleNoArr[i]);
								out.println(")");
								out.println("<br />");
							}
							%>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> ??????????????? <% } %>
							<%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> ???????????? <% } %>
							<%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> ????????????????????? <% } %>
						</td>
					</tr>
					<tr>
						<th scope="col">???????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("RENTAL_INFO"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("USE_PURPOSE"))%>
						</td>
					</tr>
					<tr>	
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("SAMPLE_MATTER"))%>
					 	</td>
					</tr>
				</tbody>
			</table>
	</div><!-- basic_viewWrap e -->
	
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %>
	<table id="satisfaction"  class="skin_view01">
		<colgroup>
			<col width="*%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="10%">
		</colgroup>
		<tbody>
			<tr>
				<th scope="col">??????<br /> ?????????</th>
				<td scope="col">
					<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "1" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("1")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="??????1???" src="/img/board/star1.png">
				</td>
				<td scope="col">
					<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "2" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("2")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="??????2???" src="/img/board/star2.png">
				</td>
       			<td scope="col">
       				<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "3" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("3")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="??????3???" src="/img/board/star3.png">
       			</td>
			    <td scope="col">
				    <input type="radio" id = "satisfaction" 	name = "satisfaction" value = "4" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("4")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="??????4???" src="/img/board/star4.png">
			    </td>
			    <td scope="col">
				    <input type="radio" id = "satisfaction" 	name = "satisfaction" value = "5" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("5") || util.getStr(dataMap.get("EQU_SATISFACTION")).equals("")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="??????5???" src="/img/board/star5.png">
			    </td>
			    <td scope="col" class="r_line_none">
			    	<button class="btn_inp_g_01" type="button" onclick="satisfactionGo()">????????????</button>
				</td>
			</tr>
		</tbody>
	</table>
	<% } %>

	<%-- <div id="satisfactionDiv" style="display:block;border:1px solid gray; "> 
	<h3>?????? ?????????</h3>
	
	<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "1" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("1")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="??????1???" src="/img/board/star1.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "2" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("2")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="??????2???" src="/img/board/star2.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "3" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("3")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="??????3???" src="/img/board/star3.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "4" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("4")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="??????4???" src="/img/board/star4.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "5" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("5") || util.getStr(dataMap.get("EQU_SATISFACTION")).equals("")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="??????5???" src="/img/board/star5.png">
	<!-- ?????? ?????? : <input type="text" id = "rejectTxt" 	name = "rejectTxt" value = "" /> -->
	<button class="btn_inp_g_01" type="button" onclick="satisfactionGo()">????????????</button> 
	</div> 
	
	<% } %>--%>

	<!-- <div class="btn_left_box" >
	<button class="btn_inp_b_01" type="button" onclick="resveConsentGo()">??????</button>
	<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">??????</button>
	</div> -->
		
	<div class="MPBtnWrap MAT10">
		<button class="btn_inp_b_01 FloatL" type="button" onclick="pageListGo()">??????</button>
		<% if(util.loginCheck() || userCheck) { %>
		<button class="btn_inp_w_01" type="button" onclick="pageDelGo()" style="float:right;">??????</button>
		<% } %>
		<% if(util.loginCheck() || userCheck) { %>
		<button class="btn_inp_b_01" type="button" onclick="pageEditGo()" style="float:right;">??????</button>
		<% } %>
	</div>


<form id = "fview" name = "fview" method="post" action="./equorder.do">
	<input type="hidden" id = "mode" 			name = "mode" 				value = "<%=mode%>"/>
	<input type="hidden" id = "reUrl"  			name = "reUrl" 				value = "./equorder.do?siteId=<%=siteId %>" />
	<input type="hidden" id = "reject"  		name = "reject" 			value = "" />
	<input type="hidden" id = "equSatisfaction" name = "equSatisfaction" 	value = "" />
	<input type="hidden" id = "equOrderIdx" 	name = "equOrderIdx"		value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
	<input type="hidden" id = "siteId" name = "siteId" 	value = "<%=siteId %>" />
</form>
<script type="text/javascript">
//<![CDATA[
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageDelGo(){
		var stateResult = "";
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> stateResult = "????????????" <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> stateResult = "????????????" <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> stateResult = "??????" <% } %>
		if(confirm("'"+stateResult+"' ????????? ??????????????????. ?????????????????????????")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
	function satisfactionGo(){
		var equSatisfactionCheck = $(":input:radio[name=satisfaction]:checked").val();
		$('#equSatisfaction').val(equSatisfactionCheck);
		$('#mode').val('view');
		$('#fview').submit();
	}
//]]>	
</script>
