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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> eventMap = request.getAttribute("eventMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("eventMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String userIdx = util.getStr(paramMap.get("userIdx"));

%>


<form name="fview" id="fview" action="sub.do" method="post">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>" />
	<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	<input type="hidden" name="m"  value="<%=m%>" />

	<div class="basic_viewWrap">
		<h2 class="h4_tit">행사정보</h2>
        <table class="skin_view">
	    	<colgroup>
	   			<col style="width: 20%;" />
				<col style="width: 50%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
	       	</colgroup>
	      	<tbody>
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
						<input type="hidden" id="eventState" value="<%=util.getIntStr(eventMap.get("EVENT_STATE"))%>">
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
					<td scope="col" colspan="3" style="padding-top: 5px;">
						<!--X축 -->
						<input type="hidden" class="inputBox_1" id="mapX" name="mapX" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_X"))%>"/>
						<!--Y축 -->
						<input type="hidden" class="inputBox_1" id="mapY" name="mapY" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_Y"))%>"/>
						<div id="map" style="width:99%;height:400px;margin-top:10px;"></div>
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
						<%=util.setFormatNum(cash,"comma")%> 원
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
											<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
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

            <!--b_btn_area S-->
			<div class="b_btn_area">
				<input type="button" id = "requestButton" value="신청" class="btn_rgt" onclick ="popupWindow('request','<%=userIdx%>','<%=eventIdx%>')" />
				<input type="button" class="btn_lft2" value="목록" onclick="goSubmit('list','<%=listMode%>')"/>
			</div>
			<!--b_btn_area E-->

		</div>
		<!--basic_listWrap E-->

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

	function goSubmit(mode,listMode){

		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#fview').submit();

	}

	function popupWindow(listMode,userIdx,eventIdx){
		//alert(listMode+" "+userIdx+" "+eventIdx);

		//로그인체크
		if(!<%=util.loginCheck()%>){

			alert("로그인 하세요");
			return;

		}else{

			if($('#eventState').val() == '접수마감' || $('#eventState').val() == '행사종료'){ //접수상태가 '접수마감','행사종료' 일때는 신청할 수 없음
				alert($('#eventState').val() +" 되어 신청할 수 없습니다.");
				return false;
			}

			if($('#reqPeople').val() >= $('#eventPeople').val()){ // 신청인원이 >= 참여인원 신청할 수 없음
				alert("신청인원이 가득차서 신청 할 수 없습니다. 문의처에 연락하시기 바랍니다.")
				return false;
			}


			var params = {
				"eventIdx" : eventIdx,
				"userIdx" : userIdx
			};

			jQuery.post("/web/eventCheck.do", $.param(params),
			function(data) { //신청중복체크 AJAX

				if (data.succEventReq == "MISS") {

					alert('중복된 신청내역입니다.\n신청 내역은 MYPAGE의 행사정보에서 확인가능합니다.');
					return;

				}else{

					/* popup S*/
					var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
					var popUrl="/web/popup/"+listMode+".do?m="+<%=m%>+"&eventIdx="+eventIdx+"";
					var popOption="width=500, height=450, resizable=no, scrollbars=no, status=no;";
						window.open(popUrl,"",popOption);
					/* popup E*/
				}
			}); //end function()

		}

	}

</script>
