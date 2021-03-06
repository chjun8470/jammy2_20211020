<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String eventReqIdx = util.getStr(paramMap.get("eventReqIdx"));
	String tap = util.getStr(paramMap.get("tap"));
	String applicantState = util.getStr(dataMap.get("APPLICANT_STATE"));
%>

<form id = "fview" name = "fview" method="post" action="./event.do">
	<input type="hidden" id = "mode" 			name = "mode" 				value = "<%=mode%>"/>
	<input type="hidden" id = "nowPage"  		name = "nowPage" 			value = "<%=nowPage%>" />
	<input type="hidden" id = "reUrl"  			name = "reUrl" 				value = "./event.do?mode=view&amp;eventReqIdx=<%=eventReqIdx%>" />
	<input type="hidden" id = "eventIdx" 	    name = "eventIdx" 		    value = "<%=eventIdx%>" />
	<input type="hidden" id = "eventReqIdx" 	name = "eventReqIdx" 		value = "<%=eventReqIdx%>" />
	<input type="hidden" id = "applicantState" 	name = "applicantState" 	value = "<%=applicantState %>" />
	<input type="hidden" id = "tap" 			name = "tap"				value = "<%=tap%>"/>
</form>

<div class="MPTit">????????????</div>

	<div class="basic_viewWrap MAT10">
		
		<table class="skin_view01">
		
			<colgroup>
				<col width="30%"/>
				<col width="70%"/>
			</colgroup>
			
			<tbody>
			
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" class="r_line_none">
						<%if(applicantState.equals("10")) { %>
						<!-- <img alt="????????????" src="/img/back/comm/edu_state_img_08.png" /> --><div class="br01">????????????</div>
						<% } %> <%if(applicantState.equals("20")) { %>
						<!-- <img alt="??????" src="/img/back/comm/edu_state_img_07.png" /> --><div class="br01">??????</div>
						<% } %> <%if(applicantState.equals("30")) { %>
						<!-- <img alt="????????????" src="/img/back/comm/order_state_img_3.png" /> --><div class="rd01">????????????</div>
						<% } %> <%if(applicantState.equals("40")) { %>
						<!-- <img alt="????????????" src="/img/back/comm/order_state_img_5.png" /> --><div class="br02">????????????</div>
						<% } %>
					</td>
				</tr>
				
				<tr>
	          		<th scope="col">?????????</th>
	          		<td scope="col" class="r_line_none">
	          				<%=util.getStr(dataMap.get("APPLICANT_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">??????</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("APPLICANT_GENDER_TYPE"))%>
	          		</td>
				</tr>
				
				<tr>
					<th scope="col">??????</th>
				    <td scope="col" class="r_line_none">
				    	<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">??????</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("APPLICANT_POSITION"))%>
					</td>
				</tr>
				
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("APPLICANT_PHONE"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">?????????</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("EMAIL"))%>
					</td>
				</tr>
				
				<!-- ???????????? -->
				<%if(util.getStr(dataMap.get("APPLICANT_STATE")).equals("30")){ %>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" class="r_line_none">
						<%=util.getStr(dataMap.get("RETURN_REASON"))%>
					</td>
				</tr>
				<%} %>
				
			</tbody>
			
		</table>
	

	<div class="MPTit MAT20">???????????? <input type="button" class="btn_w_01 MAT5 FloatR" value="???????????????" onclick="pageViewGo('<%=util.getStr(dataMap.get("EVENT_IDX"))%>');"/></div>
	
		<div class="basic_viewWrap MAT10">
	
			<table class="skin_view01">
			
				<colgroup>
					<col style="width: 30%;" />
					<col style="width: 70%;" />
				</colgroup>
				
				<tbody>
				
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<% if("?????????".equals(util.getStr(dataMap.get("EVENT_STATE")))){ %>
							<img alt="?????????" src="/img/back/comm/edu_state_img_01.png" />
							<% }else if("?????????".equals(util.getStr(dataMap.get("EVENT_STATE")))){ %>
							<img alt="?????????" src="/img/back/comm/edu_state_img_02.png" />
							<% }else if("????????????".equals(util.getStr(dataMap.get("EVENT_STATE")))){ %>
							<img alt="????????????" src="/img/back/comm/edu_state_img_03.png" />
							<% }else{%>
							<img alt="????????????" src="/img/back/comm/edu_state_img_06.png" />
							<% } %>
	          			</td>
	         		</tr>
	         		
					<tr>
	        			<th scope="col">?????????</th>
	        			<td scope="col" class="r_line_none">
	        				<%=util.getStr(dataMap.get("EVENT_NM"))%>
	        			</td>
					</tr>
					
					<tr>
	          			<th scope="col">????????????</th>
	          			<td scope="col" class="r_line_none">
	          				<%=util.getStr(dataMap.get("CODE_NM"))%>
						</td>
					</tr>
					
					<tr>
						<th scope="col">??????????????????</th>
						<td scope="col" class="r_line_none">
							<%if(util.getStr(dataMap.get("REQ_ST_DT")).equals("")) { %>
							????????????
							<% } else { %>
							<%=util.getStr(dataMap.get("REQ_ST_DT"))%> ~ <%=util.getStr(dataMap.get("REQ_ED_DT"))%>
							<% } %>
						</td>
					</tr>
					
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%if(util.getStr(dataMap.get("EVENT_ST_DT")).equals("")) { %>
							????????????
							<% } else { %>
							<%=util.getStr(dataMap.get("EVENT_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EVENT_ED_DT"))%>
							<% } %>
						</td>
					</tr>
					
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("EVENT_PLACE"))%><br>
							<%=util.getStr(dataMap.get("EVENT_PLACE_DETAIL"))%>
						</td>
					</tr>
					
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" class="r_line_none">
							<%=util.getStr(dataMap.get("EVENT_PEOPLE"))%> ???
						</td>
					</tr>
					
					<tr>
						<th scope="col">???????????????</th>
						<td scope="col" class="r_line_none">
							<% String cash = util.getStr(dataMap.get("EVENT_PAY"));
							if(util.getStr(dataMap.get("EVENT_FREE_YN")).equals("Y")){%>
							<%=util.setFormatNum(cash,"comma")%> ???
							<%}else{ %>
							??????
							<%} %>
						</td>
					</tr>
					
	     			<tr>
	      				<th scope="col">?????????</th>
	      				<td scope="col" colspan="3" class="r_line_none">
							<div style="clear:both;">
								<%if(fileList.size() > 0){%>
								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
									int fileCnt = 1;
									for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
									<li class="text"> ???????????? <%=fileCnt%> :
										<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
										<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="???????????? ????????????"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
									</li>
									<% fileCnt++; }%>
								</ul>
								<%} %>
							</div>
						  </td>
	       			</tr>
	       			
	       			<tr>
	        			<th scope="col">?????????</th>
	        			<td class="lineH20 r_line_none">
							?????????&nbsp;&nbsp;<b><%=util.getStr(dataMap.get("REFERENCE_ORG_NM"))%></b><br/>
							?????????&nbsp;&nbsp;<b><%=util.getStr(dataMap.get("REFERENCE_ORG_SUB_NM"))%></b><br/>
							????????????&nbsp;&nbsp;<b><%=util.getStr(dataMap.get("REFERENCE_CHARGER"))%></b><br/>
							????????????&nbsp;&nbsp;<b><%=util.getStr(dataMap.get("REFERENCE_PHONE"))%></b><br/>
							?????????&nbsp;&nbsp;<b><%=util.getStr(dataMap.get("REFERENCE_EMAIL"))%></b>
	        			</td>
	       			</tr>
	       			
				</tbody>
				
			</table>
		       	
		</div>
		
		<div class="MPBtnWrap MAT10">
			<button class="btn_inp_w_01" type="button" onclick="goSubmit('list')" style="float:left;">??????</button>
			<button class="btn_inp_b_01" type="button" onclick="pageDelGo('del','<%=eventReqIdx%>')" style="float:right;">??????</button>
			<%if(applicantState.equals("10") || applicantState.equals("20")) { %>
			<button class="btn_inp_b_01" type="button" onclick="goSubmit('cancel','<%=eventReqIdx%>','40')" style="float:right;">????????????</button>
			<%} %>
		</div>
	
	</div>

<script type="text/javascript">
//<![CDATA[
	function pageViewGo(idx){
		/*window.open("/jntis/sub.do?m=32&amp;mode=view&amp;eventReqIdx="+idx,'eventpopup');*/
		window.open("/jntis/sub.do?m=32&mode=view&listMode=list&eventIdx="+idx,'eventpopup');
	}
	function goSubmit(mode,idx,applicantState){

		if(mode == 'cancel'){

			if (confirm("?????? ???????????? ????????????????????") == true){ //??????
				$('#mode').val(mode);
				$('#eventReqIdx').val(idx);
				$('#applicantState').val(applicantState);
				$('#fview').submit();
			}else{ //??????
				return;
			}
		}
		$('#mode').val(mode);
		$('#fview').submit();
	}

	function pageDelGo(mode,idx){

		var stateResult = $("applicantState").val();
		if(stateResult == '10'){
			stateResult = "????????????";
		}else if(stateResult == '20'){
			stateResult = "??????";
		}else if(stateResult == '30'){
			stateResult = "??????";
		}else{
			stateResult = "????????????";
		}

		if(confirm("'"+stateResult+"' ???????????????. ?????????????????????????")){
			$('#reUrl').val('./event.do?');
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
//]]>	
</script>
