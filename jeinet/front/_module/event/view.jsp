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
		<h2 class="h4_tit">????????????</h2>
        <table class="skin_view">
	    	<colgroup>
	   			<col style="width: 20%;" />
				<col style="width: 50%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
	       	</colgroup>
	      	<tbody>
				<tr>
	      			<th scope="col">????????????</th>
	       			<td scope="col">
	      				<%=util.getStr(eventMap.get("EVENT_TYPE_NM"))%>
	      			</td>
	       			<th class="table_box_line_lft" scope="col">????????????</th>
	          		<td scope="col" style="text-align: center;">
	       				<% if("?????????".equals(util.getStr(eventMap.get("EVENT_STATE")))){ %>
						<img alt="?????????" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("?????????".equals(util.getStr(eventMap.get("EVENT_STATE")))){ %>
						<img alt="?????????" src="/img/back/comm/edu_state_img_02.png" />
						<% }else if("????????????".equals(util.getStr(eventMap.get("EVENT_STATE")))){ %>
						<img alt="????????????" src="/img/back/comm/edu_state_img_03.png" />
						<% }else{%>
						<img alt="????????????" src="/img/back/comm/edu_state_img_06.png" />
						<% } %>
						<input type="hidden" id="eventState" value="<%=util.getIntStr(eventMap.get("EVENT_STATE"))%>">
	            	</td>
                </tr>
				<tr>
	            	<th scope="col">?????????</th>
	            		<td scope="col" colspan="3">
	                		<%=util.getStr(eventMap.get("EVENT_NM"))%>
	                	</td>
               	</tr>
               	<tr>
	            	<th scope="col">????????????</th>
	            		<td scope="col" colspan="3">
	                		<%=util.getStr(eventMap.get("EVENT_AUSPICES_NM"))%>
	                	</td>
               	</tr>
               	<tr>
	            	<th scope="col">????????????</th>
	            		<td scope="col" colspan="3">
	                		<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_NM"))%>
	                		<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_SUB_NM"))%>
	                	</td>
               	</tr>
                <tr>
	             	<th scope="col">??????????????????</th>
	             	<td scope="col" colspan="3">
	             		<%if(util.getStr(eventMap.get("RREQ_ST_DT")).equals("")) { %>
							????????????
						<% } else { %>
							<%=util.getStr(eventMap.get("RREQ_ST_DT"))%> ~ <%=util.getStr(eventMap.get("RREQ_ED_DT"))%>
						<% } %>
	                </td>
               	</tr>
               	<tr>
	           		<th scope="col">????????????</th>
	           		<td scope="col" colspan="3">
	           		<%if(util.getStr(eventMap.get("EEVENT_ST_DT")).equals("")) { %>
						????????????
					<% } else { %>
						<%=util.getStr(eventMap.get("EEVENT_ST_DT"))%> ~ <%=util.getStr(eventMap.get("EEVENT_ED_DT"))%>
					<% } %>
	             	</td>
                </tr>
                <tr>
	           		<th scope="col">????????????</th>
	           		<td scope="col" colspan="3">
	           			<%=util.getStr(eventMap.get("EVENT_PLACE"))%><br>
	           			<%=util.getStr(eventMap.get("EVENT_PLACE_DETAIL"))%>
	           		</td>
               	</tr>
               	<!-- ???????????? -->
				<tr>
					<th scope="col" class="tit">??????</th>
					<td scope="col" colspan="3" style="padding-top: 5px;">
						<!--X??? -->
						<input type="hidden" class="inputBox_1" id="mapX" name="mapX" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_X"))%>"/>
						<!--Y??? -->
						<input type="hidden" class="inputBox_1" id="mapY" name="mapY" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_Y"))%>"/>
						<div id="map" style="width:99%;height:400px;margin-top:10px;"></div>
					</td>
				</tr>
               	<tr>
               		<th scope="col">????????????</th>
	           		<td scope="col" colspan="3">
	           			<%=util.getStr(eventMap.get("EVENT_TARGET"))%>
	                </td>
              	</tr>
              	<tr>
              		<th scope="col">????????????</th>
	           		<td scope="col" colspan="3">
	           			<%=util.getStr(eventMap.get("EVENT_PEOPLE"))%> ???
	           			<input type="hidden" id="eventPeople" value="<%=util.getIntStr(eventMap.get("EVENT_PEOPLE"))%> ">
	           			<input type="hidden" id="reqPeople" value="<%=util.getIntStr(eventMap.get("REQ_PEOPLE"))%> ">
	                </td>
              	</tr>
              	<tr>
	              	<th scope="col">???????????????</th>
	             	<td scope="col" colspan="3">
	              	<%
	              		String cash = util.getStr(eventMap.get("EVENT_PAY"));
	              		if(util.getStr(eventMap.get("EVENT_FREE_YN")).equals("Y")){
	              	%>
						<%=util.setFormatNum(cash,"comma")%> ???
					<%}else{ %>
						??????
					<%} %>
	                </td>
                </tr>
                <tr>
                	<th scope="col">????????????</th>
					<td colspan="3" scope="col">
						<div class="img_box2"><%=eventMap.get("EVENT_CONTENTS").trim()%></div>

						<!-- ???????????? ???????????? ?????? ????????? ??????  -->
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
	            	<th scope="col">?????????</th>
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
										<li class="text"> ???????????? <%=fileCnt%> :
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
	            	<th scope="col">?????????</th>
	            	<td scope="col" colspan="3">
		            	<div>
							<table class="skin_basic_write">
							<caption>????????????</caption>
					        <colgroup>
								<col style="width: 30%;" />
								<col style="width: 70%;" />
							</colgroup>
							<tbody>
			            		<tr>
				        			<th scope="col">?????????</th>
					       			<td scope="col" colspan="3">
					       				<%=util.getStr(eventMap.get("REFERENCE_ORG_NM"))%>
					       			</td>
					       		</tr>
				         		<tr>
					         		<th scope="col">?????????</th>
					         		<td scope="col" colspan="3">
					         			<%=util.getStr(eventMap.get("REFERENCE_ORG_SUB_NM"))%>
					         		</td>
				             	</tr>
				             	<tr>
					         		<th scope="col">????????????</th>
					         		<td scope="col" colspan="3">
					            		<%=util.getStr(eventMap.get("REFERENCE_CHARGER"))%>
					                </td>
				               	</tr>
				               	<tr>
					           		<th scope="col">????????????</th>
					           		<td scope="col" colspan="3">
					           			<%=util.getStr(eventMap.get("REFERENCE_PHONE"))%>
					           		</td>
				               	</tr>
				               	<tr>
					           		<th scope="col">?????????</th>
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
				<input type="button" id = "requestButton" value="??????" class="btn_rgt" onclick ="popupWindow('request','<%=userIdx%>','<%=eventIdx%>')" />
				<input type="button" class="btn_lft2" value="??????" onclick="goSubmit('list','<%=listMode%>')"/>
			</div>
			<!--b_btn_area E-->

		</div>
		<!--basic_listWrap E-->

</form>

<script type="text/javascript">

	$(document).ready(function() {
		/*---------?????? S-----------*/
		var korPattern = /[???-???]/;
		var onlyKorPattern = /[^???-???]/;
		var engPattern = /[a-zA-Z]/;
		var numPattern = /[\d]/;
		var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
		var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
		var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

		var mapX = $("#mapX").val(); //????????? ????????????
		var mapY = $("#mapY").val(); //????????? ????????????

		var mapContainer = document.getElementById('map'), // ????????? ????????? div
		mapOption = {
			center: new daum.maps.LatLng(mapX,mapY), // ????????? ????????????
			level: 5 // ????????? ?????? ??????
		};

		//????????? ?????? ??????
		var map = new daum.maps.Map(mapContainer, mapOption);
		//??????-?????? ?????? ????????? ??????
		var geocoder = new daum.maps.services.Geocoder();
		//????????? ?????? ??????
		var marker = new daum.maps.Marker({
			position: new daum.maps.LatLng(mapX, mapY),
			map: map
		});
		/*---------?????? E-----------*/

	});

	function goSubmit(mode,listMode){

		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#fview').submit();

	}

	function popupWindow(listMode,userIdx,eventIdx){
		//alert(listMode+" "+userIdx+" "+eventIdx);

		//???????????????
		if(!<%=util.loginCheck()%>){

			alert("????????? ?????????");
			return;

		}else{

			if($('#eventState').val() == '????????????' || $('#eventState').val() == '????????????'){ //??????????????? '????????????','????????????' ????????? ????????? ??? ??????
				alert($('#eventState').val() +" ?????? ????????? ??? ????????????.");
				return false;
			}

			if($('#reqPeople').val() >= $('#eventPeople').val()){ // ??????????????? >= ???????????? ????????? ??? ??????
				alert("??????????????? ???????????? ?????? ??? ??? ????????????. ???????????? ??????????????? ????????????.")
				return false;
			}


			var params = {
				"eventIdx" : eventIdx,
				"userIdx" : userIdx
			};

			jQuery.post("/web/eventCheck.do", $.param(params),
			function(data) { //?????????????????? AJAX

				if (data.succEventReq == "MISS") {

					alert('????????? ?????????????????????.\n?????? ????????? MYPAGE??? ?????????????????? ?????????????????????.');
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
