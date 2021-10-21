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

	<div class="MPTit">장비이용 예약 신청서</div>
	
	<div class="basic_viewWrap">
		<table class="skin_view01">
			<colgroup>
				<col width="30%"/>
				<col width="70%"/>
			</colgroup>
			<tbody>
				<tr>
         			<th scope="col">JEINET 예약번호</th>
         			<td scope="col" class="r_line_none">
         				J-<%=util.getStr(paramMap.get("equOrderIdx"))%>
         			</td>
         		</tr>
         		<tr>
         			<th scope="col">기관접수번호</th>
         			<td scope="col" class="r_line_none">
         			</td>
        		</tr>
				<tr>
        			<th scope="col">처리자</th>
        			<td scope="col" class="r_line_none">
        				<%=util.getStr(dataMap.get("ORDER_OPERATOR"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">처리시간</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("ORDER_OPERATOR_DT"))%>
        			</td>
       			</tr>
				<tr>
          			<th scope="col">처리상태</th>
          			<td scope="col" class="r_line_none">
          				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> <!-- <img alt="승인요청" src="/img/back/comm/order_state_img_1.png" /> --><div class="br01">승인요청</div> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- <img alt="승인요청" src="/img/back/comm/order_state_img_2.png" /> --><div class="yw01">이용승인</div> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> 
						<!-- <img alt="승인요청" src="/img/back/comm/order_state_img_3.png" /> --><div class="rd01">승인거절</div><br /> 반려사유 :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <!-- <img alt="승인요청" src="/img/back/comm/order_state_img_4.png" /> --><div class="gr01">이용완료</div> <% } %>
						<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> <!-- <img alt="승인취소" src="/img/back/comm/order_state_img_5.png" /> --><div class="br02">승인취소</div> <% } %>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="MPTit MAT20">예약정보</div>
		
			<table class="skin_view01">
				<colgroup>
					<col width="30%" />
					<col width="70%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="col">예약신청일</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("ORDER_DT"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">기관접수일</th>
						<td scope="col" class="r_line_none"></td>
					</tr>
					<tr>
						<th scope="col">이용희망기간</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("USE_ST_DT"))%>
							~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>
					
						</td>
					</tr>
					<tr>
						<th scope="col">이용확정기간</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>
							~ <%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">이용자명</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(userMap.get("PSN_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">연락처</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(userMap.get("EMAIL"))%>
							<br /><%=util.getStr(userMap.get("PHONE"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">소속기관명</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(userMap.get("ORG_GRP_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">소속부서/센터</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("DEPT_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">신청자 직위</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("CORP_POSITION"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">책임자</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">장비명</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
						</td>
					</tr>
					<tr>
						<th scope="col">모델명</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("MODEL_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">시료명(시료수)</th>
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
						<th scope="col">사용구분</th>
						<td scope="col" class="r_line_none">
							<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> 서비스의뢰 <% } %>
							<%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> 직접사용 <% } %>
							<%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> 야간및휴일사용 <% } %>
						</td>
					</tr>
					<tr>
						<th scope="col">이용료안내</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("RENTAL_INFO"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">이용목적</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("USE_PURPOSE"))%>
						</td>
					</tr>
					<tr>	
						<th scope="col">특기사항</th>
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
				<th scope="col">장비<br /> 만족도</th>
				<td scope="col">
					<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "1" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("1")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="별점1개" src="/img/board/star1.png">
				</td>
				<td scope="col">
					<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "2" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("2")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="별점2개" src="/img/board/star2.png">
				</td>
       			<td scope="col">
       				<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "3" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("3")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="별점3개" src="/img/board/star3.png">
       			</td>
			    <td scope="col">
				    <input type="radio" id = "satisfaction" 	name = "satisfaction" value = "4" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("4")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="별점4개" src="/img/board/star4.png">
			    </td>
			    <td scope="col">
				    <input type="radio" id = "satisfaction" 	name = "satisfaction" value = "5" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("5") || util.getStr(dataMap.get("EQU_SATISFACTION")).equals("")) { %> checked="checked" <% } %>/>&nbsp;
					<img alt="별점5개" src="/img/board/star5.png">
			    </td>
			    <td scope="col" class="r_line_none">
			    	<button class="btn_inp_g_01" type="button" onclick="satisfactionGo()">별점주기</button>
				</td>
			</tr>
		</tbody>
	</table>
	<% } %>

	<%-- <div id="satisfactionDiv" style="display:block;border:1px solid gray; "> 
	<h3>장비 만족도</h3>
	
	<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "1" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("1")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="별점1개" src="/img/board/star1.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "2" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("2")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="별점2개" src="/img/board/star2.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "3" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("3")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="별점3개" src="/img/board/star3.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "4" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("4")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="별점4개" src="/img/board/star4.png">
	
	&nbsp;&nbsp;&nbsp;<input type="radio" id = "satisfaction" 	name = "satisfaction" value = "5" <%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("5") || util.getStr(dataMap.get("EQU_SATISFACTION")).equals("")) { %> checked="checked" <% } %>/>&nbsp;
	<img alt="별점5개" src="/img/board/star5.png">
	<!-- 반려 사유 : <input type="text" id = "rejectTxt" 	name = "rejectTxt" value = "" /> -->
	<button class="btn_inp_g_01" type="button" onclick="satisfactionGo()">별점주기</button> 
	</div> 
	
	<% } %>--%>

	<!-- <div class="btn_left_box" >
	<button class="btn_inp_b_01" type="button" onclick="resveConsentGo()">승인</button>
	<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">반려</button>
	</div> -->
		
	<div class="MPBtnWrap MAT10">
		<button class="btn_inp_b_01 FloatL" type="button" onclick="pageListGo()">목록</button>
		<% if(util.loginCheck() || userCheck) { %>
		<button class="btn_inp_w_01" type="button" onclick="pageDelGo()" style="float:right;">삭제</button>
		<% } %>
		<% if(util.loginCheck() || userCheck) { %>
		<button class="btn_inp_b_01" type="button" onclick="pageEditGo()" style="float:right;">수정</button>
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
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> stateResult = "승인요청" <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> stateResult = "이용승인" <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> stateResult = "반려" <% } %>
		if(confirm("'"+stateResult+"' 상태인 사용자입니다. 삭제하시겠습니까?")){
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
