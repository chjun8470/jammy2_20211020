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
	HashMap<String, String> eventMap = request.getAttribute("eventMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("eventMap");
	HashMap<String, String> loginUserInfo = request.getAttribute("loginUserInfo") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("loginUserInfo");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> eventApplicantList = request.getAttribute("eventApplicantList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventApplicantList");
	ArrayList<HashMap<String, String>> eventConsentList = request.getAttribute("eventConsentList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventConsentList");
	ArrayList<HashMap<String, String>> eventReturnList = request.getAttribute("eventReturnList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventReturnList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String eventReqIdx = util.getStr(paramMap.get("eventReqIdx"));
	String authLv = util.getStr(loginUserInfo.get("AUTH_LV"));
	String userIdx = util.getStr(eventMap.get("REG_IDX"));

%>


<form name="fview" id="fview" action="<%=myPage%>" method="post">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
	<input type="hidden" name="eventReqIdx" id="eventReqIdx" value="<%=eventReqIdx%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />

	<div class="clear_wrap">

    	<h3>[행사정보]</h3>
        <table class="skin_basic_write">
	    	<colgroup>
	   			<col style="width: 20%;" />
				<col style="width: 50%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
	       	</colgroup>
	      	<tbody>
	      		<tr>
	  	         	<th scope="col">행사등록여부 상태</th>
	           		<td scope="col" colspan="3" style="vertical-align: bottom;">
	           			<% if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("10")){ %>
						<img alt="승인요청" src="/img/back/comm/order_state_img_1.png" />
						<% }else if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("20")){ %>
						<img alt="승인" src="/img/back/comm/edu_state_img_07.png" />
						<% }else if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("30")){ %>
						<img alt="승인거절" src="/img/back/comm/order_state_img_3.png" />
						<% }else{%>
						<img alt="승인취소" src="/img/back/comm/order_state_img_5.png" />
						<% } %>


						<!-- 최고관리자(99) -->
						<%
							if(authLv.equals("99")){
								if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("10")){
						%>
								<span>
									&nbsp;&nbsp;
									<input type="checkbox" name="stateCheck" id="approvalState" value="A" onclick="check_only(this)"> &nbsp;
									<label for="approvalState">승인</label>
								</span>
						<%
								}
								if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("10") || util.getStr(eventMap.get("CONFIRM_STATE")).equals("20")){
						%>
								<span>
									&nbsp;&nbsp;
									<input type="checkbox" name="stateCheck" id="rejectState" value="R" onclick="check_only(this)"> &nbsp;
									<label for="rejectState">반려</label>
								</span>
								<span id="rejectSpan" style="display: none;">
									&nbsp;&nbsp; 반려사유:
									<input type="text" name="confirmReject" id="confirmReject" maxlength="20" value="" style="width:40%;">
								</span>
						<%
								}
							}
						%>

	               	</td>
               	</tr>
				<tr>
	      			<th scope="col">행사분류</th>
	       			<td scope="col">
	      				<%=util.getStr(eventMap.get("EVENT_TYPE_NM"))%>
	      			</td>
	       			<th scope="col">행사상태</th>
	          		<td scope="col" style="text-align: center;">
	       				<% if("접수중".equals(util.getStr(eventMap.get("EVENT_STATE")))){ %>
						<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("접수전".equals(util.getStr(eventMap.get("EVENT_STATE")))){ %>
						<img alt="접수전" src="/img/back/comm/edu_state_img_02.png" />
						<% }else if("접수마감".equals(util.getStr(eventMap.get("EVENT_STATE")))){ %>
						<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
						<% }else{%>
						<img alt="행사종료" src="/img/back/comm/edu_state_img_06.png" />
						<% } %>
	            	</td>
                </tr>
				<tr>
	            	<th scope="col">행사명</th>
	            	<td scope="col" colspan="3">
	                	<%=util.getStr(eventMap.get("EVENT_NM"))%>
	                </td>
               	</tr>
               	<tr>
	            	<th scope="col">행사주최</th>
	            	<td scope="col" colspan="3">
	                	<%=util.getStr(eventMap.get("EVENT_AUSPICES_NM"))%>
	                </td>
               	</tr>
               	<tr>
	            	<th scope="col">행사주관</th>
	            	<td scope="col" colspan="3">
	                	<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_NM"))%>
	                	<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_SUB_NM"))%>
	                </td>
               	</tr>
                <tr>
	             	<th scope="col">참여신청기간</th>
	             	<td scope="col" colspan="3">
	             		<%if(util.getStr(eventMap.get("RREQ_ST_DT")).equals("")) { %>
							정보없음
						<% } else { %>
							<%=util.getStr(eventMap.get("RREQ_ST_DT"))%> ~ <%=util.getStr(eventMap.get("RREQ_ED_DT"))%>
						<% } %>
	                </td>
               	</tr>
               	<tr>
	           		<th scope="col">행사기간</th>
	           		<td scope="col" colspan="3">
		           		<%if(util.getStr(eventMap.get("EEVENT_ST_DT")).equals("")) { %>
							정보없음
						<% } else { %>
							<%=util.getStr(eventMap.get("EEVENT_ST_DT"))%> ~ <%=util.getStr(eventMap.get("EEVENT_ED_DT"))%>
						<% } %>
	             	</td>
                </tr>
                <tr>
	           		<th scope="col">행사장소</th>
	           		<td scope="col" colspan="3">
	           			<%=util.getStr(eventMap.get("EVENT_PLACE"))%><br>
	           			<%=util.getStr(eventMap.get("EVENT_PLACE_DETAIL"))%>
	           		</td>
               	</tr>
               	<!-- 지도구현 -->
				<tr>
					<th scope="col" class="tit">지도</th>
					<td scope="col" colspan="3">
						<!--X축 -->
						<input type="hidden" maxlength="20" class="inputBox_1" id="mapX" name="mapX" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_X"))%>"/>
						<!--Y축 -->
						<input type="hidden" maxlength="20" class="inputBox_1" id="mapY" name="mapY" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_Y"))%>"/>
						<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
					</td>
				</tr>
               	<tr>
               		<th scope="col">참가대상</th>
	           		<td scope="col" colspan="3">
	           			<%=util.getStr(eventMap.get("EVENT_TARGET"))%>
	                </td>
              	</tr>
              	<tr>
              		<th scope="col">참가인원</th>
	           		<td scope="col" colspan="3">
	           			<%=util.getStr(eventMap.get("EVENT_PEOPLE"))%> 명
	           			<input type="hidden" id="eventPeople" value="<%=util.getIntStr(eventMap.get("EVENT_PEOPLE"))%> ">
	           			<input type="hidden" id="reqPeople" value="<%=util.getIntStr(eventMap.get("REQ_PEOPLE"))%> ">
	                </td>
              	</tr>
              	<tr>
	              	<th scope="col">행사참가비</th>
	             	<td scope="col" colspan="3">
	              	<%
	              		String cash = util.getStr(eventMap.get("EVENT_PAY"));
	              		if(util.getStr(eventMap.get("EVENT_FREE_YN")).equals("Y")){
	              	%>
						<%=cash%> 원
						<%-- <%=util.setFormatNum(cash,"comma")%> 원 --%>
					<%}else{ %>
						무료
					<%} %>
	                </td>
                </tr>
                <tr>
                	<th scope="col">행사내용</th>
					<td colspan="3" scope="col">
						<div class="img_box2"><%=eventMap.get("EVENT_CONTENTS").trim()%></div>

						<!-- 파일첨부 이미지일 경우 화면에 출력  -->
						<%
							int imgCnt = 1;
							for(HashMap rs:fileList){
							String ext = util.getStr(rs.get("FILE_CAT")).toLowerCase();

								if("jpeg".equals(ext) || "jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
						%>
								<div>
									&#60; File_Image <%=imgCnt%> &#62;<br/>
									<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:500px; vertical-align:middle "/>
								</div>
						<%
								imgCnt++;

								}
							}
						%>
					</td>
				</tr>
                <tr>
	            	<th scope="col">안내문</th>
	            	<td scope="col" colspan="3">
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
										<li class="text"> 첨부파일 <%=fileCnt%> :
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
				    </td>
                </tr>
                <tr>
	            	<th scope="col">문의처</th>
	            	<td scope="col" colspan="3">
		            	<div>
							<table class="skin_basic_write">
							<caption>작성하기</caption>
					        <colgroup>
								<col style="width: 30%;" />
								<col style="width: 70%;" />
							</colgroup>
							<tbody>
			            		<tr>
				        			<th scope="col">기관명</th>
					       			<td scope="col" colspan="3">
					       				<%=util.getStr(eventMap.get("REFERENCE_ORG_NM"))%>
					       			</td>
					       		</tr>
				         		<tr>
					         		<th scope="col">부서명</th>
					         		<td scope="col" colspan="3">
					         			<%=util.getStr(eventMap.get("REFERENCE_ORG_SUB_NM"))%>
					         		</td>
				             	</tr>
				             	<tr>
					         		<th scope="col">담당자명</th>
					         		<td scope="col" colspan="3">
					            		<%=util.getStr(eventMap.get("REFERENCE_CHARGER"))%>
					                </td>
				               	</tr>
				               	<tr>
					           		<th scope="col">전화번호</th>
					           		<td scope="col" colspan="3">
					           			<%=util.getStr(eventMap.get("REFERENCE_PHONE"))%>
					           		</td>
				               	</tr>
				               	<tr>
					           		<th scope="col">이메일</th>
					           		<td scope="col" colspan="3">
					           			<%=util.getStr(eventMap.get("REFERENCE_EMAIL"))%>
					           		</td>
				               	</tr>
				            </tbody>
							</table>
						</div>
	               	</td>
                </tr>
              </tbody>
            </table>



			<!-- bo_btn  S-->
			<div class="btn_right_box" style="text-align: right; vertical-align: middle; width: 980px;">
			<%
				/*로그인 체크*/
				if(util.loginCheck() == true){

					/*최고관리자(99) 일때*/
					if(authLv.equals("99")){
						if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("10")){ //승인요청일때
			%>
						<input type="button" class="btn_inp_b_01" value="행사승인" onclick="goConfirm('apvProc','<%=eventIdx%>','승인')" style="float:left;"/>
						<input type="button" class="btn_inp_b_01" value="행사반려" onclick="goConfirm('companionProc','<%=eventIdx%>','반려')" style="float:left;"/>
			<%
						}
						if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("20")){ //승인일때
			%>
						<input type="button" class="btn_inp_b_01" value="승인반려" onclick="goConfirm('companionProc','<%=eventIdx%>','반려')" style="float:left;"/>
			<% 			}
					}

					/*행사등록여부 상태가 반려 및 취소 일때*/
					if(util.getStr(eventMap.get("CONFIRM_STATE")).equals("30") || util.getStr(eventMap.get("CONFIRM_STATE")).equals("40")){ //승인요청일때
			%>
					<input type="button" class="btn_inp_b_01" value="행사정보 삭제" onclick="goSubmit('del','삭제')" style="float:left;"/>
			<%		}%>

				<input type="button" class="btn_inp_b_01" value="행사정보 수정" onclick="goSubmit('edit','수정')"/>
			<%	}%>

			 	<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
			 </div>
			 <!-- bo_btn  E-->

			<br /><br /><br /><hr /><br /><br /><br />


			<div id = "returnReasonTr" style="display:none; vertical-align:middle;">
			<h3>[반려사유]</h3>
				<table class="skin_basic_list">
					<tr>
					<th>반려사유</th>
					<td>
							<input type="text" name="returnReason" id="returnReason" value="" style="width: 80%;">
							<input type="hidden" name="returnReqIdx" id="returnReqIdx" value="">
							<input type="button" class="btn_inp_b_01" value="확인" onclick="goButton('reservation','confirm',' ','반려')"/>
							<input type="button" class="btn_inp_w_01" value="닫기" onclick="goExit()"/>
					</td>
					</tr>
				</table>
			</div>
			<div id = "cancleReasonTr" style="display:none; vertical-align:middle;">
			<h3>[취소사유]</h3>
				<table class="skin_basic_list">
					<tr>
					<th>취소사유</th>
					<td>
							<input type="text" name="cancleReason" id="cancleReason" value="" style="width: 80%;">
							<input type="hidden" name="cancleReqIdx" id="cancleReqIdx" value="">
							<input type="button" class="btn_inp_b_01" value="확인" onclick="goButton('reservation','cancleconfirm',' ','승인취소')"/>
							<input type="button" class="btn_inp_w_01" value="닫기" onclick="goExit()"/>
					</td>
					</tr>
				</table>
			</div>

			<h3>[참가신청자목록] <span style="float:right;">(<%=eventApplicantList.size()%>) 건</span></h3>


			<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 15%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">회원명</th>
						<th scope="col">소속</th>
						<th scope="col">성별</th>
						<th scope="col">직위</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">신청일자</th>
						<th scope="col">승인처리</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont1 = 1;

						if(eventApplicantList.size() == 0){
					%>
						<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
					<%
						}

								for(HashMap rs:eventApplicantList) {
					%>
					<tr>
						<td><%=cont1%></td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("ORG_GRP_NM"))%><br />
							<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_GENDER_TYPE_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_POSITION"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_PHONE")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_EMAIL")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("REG_DT")) %>
						</td>
						<td>
							<input type="button" class="btn_inp_y_01" value="승인" onclick="goButton('reservation','applicant','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','승인')"/>
							<input type="button" class="btn_inp_y_01" value="반려" onclick="goButton('reservation','rreturn','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','반려')"/>
						</td>
					</tr>
					<% cont1 ++; } %>
				</tbody>
			</table>





			<h3>[참가승인자목록] <span style="float:right;">(<%=eventConsentList.size()%>) 건</span></h3>


			<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 15%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">회원명</th>
						<th scope="col">소속</th>
						<th scope="col">성별</th>
						<th scope="col">직위</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">승인일자</th>
						<th scope="col">승인취소처리</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont2 = 1;

						if(eventConsentList.size() == 0){
					%>
						<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
					<%
						}

								for(HashMap rs:eventConsentList) {
					%>
					<tr>
						<td><%=cont2%></td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("ORG_GRP_NM"))%><br />
							<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_GENDER_TYPE_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_POSITION"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_PHONE")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_EMAIL")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("UP_DT")) %>
						</td>
						<td>
						<input type="button" class="btn_inp_y_01" value="승인취소" onclick="goButton('reservation','cancle','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','반려')"/>
						</td>
					</tr>
					<% cont2 ++; } %>
				</tbody>
			</table>

			<h3>[참가취소자/반려자목록] <span style="float:right;">(<%=eventReturnList.size()%>) 건</span></h3>


			<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 5%;" />
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: 12%;" />
					<col style="width: 12%;" />
					<col style="width: 16%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">상태</th>
						<th scope="col">회원명</th>
						<th scope="col">소속</th>
						<th scope="col">전화번호</th>
						<th scope="col">이메일</th>
						<th scope="col">반려사유</th>
						<th scope="col">반려/취소일자</th>
						<th scope="col">삭제처리</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont3 = 1;

						if(eventReturnList.size() == 0){
					%>
						<tr><td colspan="9">데이터가 존재하지 않습니다</td></tr>
					<%
						}
							for(HashMap rs:eventReturnList) {
					%>
					<tr>
						<td><%=cont3%></td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_STATE_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("ORG_GRP_NM"))%><br />
							<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_PHONE")) %>
						</td>
						<td>
							<%=util.getStr(rs.get("APPLICANT_EMAIL")) %>
						</td>
						<td>
							<%if(util.getStr(rs.get("RETURN_REASON")).length()>8){%><%=util.getStr(rs.get("RETURN_REASON")).substring(0, 8)+" · · · "%><%}else{%><%=util.getStr(rs.get("RETURN_REASON"))%><%}%>
						</td>
						<td>
							<%=util.getStr(rs.get("UP_DT")) %>
						</td>
						<td>
							<input type="button" class="btn_inp_y_01" value="삭제" onclick="goButton('reservation','delete','<%=util.getStr(rs.get("EVENT_REQ_IDX"))%>','삭제')"/>
						</td>
					</tr>
					<% cont3 ++; } %>
				</tbody>
			</table>


			<br /><br /><hr />
			 <!-- bo_btn  -->
			 <div class="btn_right_box" style="text-align: right; width: 980px;">
			 	<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
			 </div>
			<!--// bo_btn -->

	</div>


</form>


<script type="text/javascript">

	$(document).ready(function() {

		/*---------지도 S-----------*/
		var korPattern = /[가-힣]/;
		var onlyKorPattern = /[^가-힣]/;
		var engPattern = /[a-zA-Z]/;
		var numPattern = /[\d]/;
		var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
		var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
		var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

		var mapX = $("#mapX").val(); //지도값 가져오기
		var mapY = $("#mapY").val(); //지도값 가져오기

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		mapOption = {
			center: new daum.maps.LatLng(mapX,mapY), // 지도의 중심좌표
			level: 5 // 지도의 확대 레벨
		};

		//지도를 미리 생성
		var map = new daum.maps.Map(mapContainer, mapOption);
		//주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new daum.maps.Marker({
			position: new daum.maps.LatLng(mapX, mapY),
			map: map
		});
		/*---------지도 E-----------*/

	});

	function goSubmit(mode,text){

		if(mode == 'edit' || mode == 'del'){
			if(confirm(""+text+" 하시겠습니까?")) {
				$('#mode').val(mode);
				$('#fview').submit();
			}else{
			 return;
			}
		}

		$('#mode').val(mode);
		$('#fview').submit();
	}

	function goButton(mode,listMode,eventReqIdx,text){

		//alert(mode+" "+listMode+" "+eventReqIdx+" "+text);

		if(listMode == 'applicant'){ //승인버튼을 클릭할때

			/* 신청인원이 가득차면 승인처리 제어 */
			if( $('#reqPeople').val() >= $('#eventPeople').val()){
				alert("참여인원이 모집되어 더 이상 승인처리가 불가합니다.");
				return false;
			}
		}

		if(listMode == 'rreturn'){ //반려버튼을 클릭할때
			if($('#returnReason').val() == ""){
				alert("반려사유를 입력해주세요");
				$('#returnReqIdx').val(eventReqIdx); //반려사유 확인버튼에 eventReqIdx값 보관
				$('#returnReasonTr').show();
				$("#returnReason").focus();
				return false;
			}
		}

		if(listMode == 'cancle'){ //취소버튼을 클릭할때
			if($('#cancleReason').val() == ""){
				alert("취소사유를 입력해주세요");
				$('#cancleReqIdx').val(eventReqIdx); //취소사유 확인버튼에 eventReqIdx값 보관
				$('#cancleReasonTr').show();
				$("#cancleReason").focus();
				return false;
			}
		}

		if(confirm(""+text+" 하시겠습니까?")) {

			$("#mode").val(mode);
			$('#listMode').val(listMode);

			if(listMode == 'confirm'){ //반려사유의 '확인'버튼을 클릭할때
				$('#eventReqIdx').val($('#returnReqIdx').val());
			}else if(listMode == 'cancleconfirm'){ //취소사유의 '확인'버튼을 클릭할때
				$('#eventReqIdx').val($('#cancleReqIdx').val());
			}else{
				$('#eventReqIdx').val(eventReqIdx);
			}

			var formData = $("#fview").serialize();

			$.ajax({
				url:"/sys/reservation_event.do",
				data:formData,
				type:"POST",
				success:function() {
					alert(text + "되었습니다");
					window.location.reload();
				}
			});
			('#returnReason').val('');
			$('#returnReasonTr').hide();
			('#cancleReason').val('');
			$('#cancleReasonTr').hide();

		}else{
			('#returnReason').val('');
			$('#returnReasonTr').hide();
			('#cancleReason').val('');
			$('#cancleReasonTr').hide();
			return;
		}

	}

	//반려사유 닫기버튼
	function goExit(){
		$('#returnReqIdx').val('');
		$('#returnReason').val('');
		$('#returnReasonTr').hide();
		$('#cancleReqIdx').val('');
		$('#cancleReason').val('');
		$('#cancleReasonTr').hide();
	}


	function goConfirm(mode,eventIdx,text){

		//alert(mode+" "+eventIdx+" "+text);

		if(mode == 'apvProc'){ //승인일때

			if($("input:checkbox[id='approvalState']").is(":checked") == false){

				$("input:checkbox[id='approvalState']").prop("checked", true); //강제체크
			}
		}

		if(mode == 'companionProc'){ //반려일때

			if($("input:checkbox[id='rejectState']").is(":checked") == false){

				$("input:checkbox[id='rejectState']").prop("checked", true); //강제체크
				$('#rejectSpan').show();
			}

			if($('#confirmReject').val() == ""){
				alert("반려사유를 입력해주세요");
				$("#confirmReject").focus();
				return false;
			}
		}


		if(confirm(""+text+" 하시겠습니까?")) {

			$("#mode").val(mode);

			var formData = $("#fview").serialize();

			$.ajax({
				url:"/sys/confirm_event.do",
				data:formData,
				type:"POST",
				success:function() {
					alert("정상적으로 "+text+" 처리 되었습니다");
					window.location.reload();
				}
			});

		}else{

			$('#confirmReject').val('');
			$('#rejectSpan').hide();
			$("input:checkbox[id='rejectState']").prop("checked", false);
			$("input:checkbox[id='approvalState']").prop("checked", false);
			return;
		}

	}

	//행사등록상태여부 checkBox
 	function check_only(chk){

        var obj = document.getElementsByName("stateCheck");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != chk){
                obj[i].checked = false;
            }
        }


        if($('#rejectState:checked').val() == 'R'){
        	$('#rejectSpan').show();
        }else{
        	$('#rejectSpan').hide();
        	$('#confirmReject').val('');
        }

    }

</script>
