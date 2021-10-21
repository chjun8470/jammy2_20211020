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
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	//if(dataMap.get("DIARY_YN").equals("Y")) {
	HashMap<String, String> diaryDataMap = request.getAttribute("diaryDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("diaryDataMap");
	//}

	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));
	String diary = util.getStr(paramMap.get("diary"));

	SimpleDateFormat df= new SimpleDateFormat("yyyyMMdd");

	Date date = new Date();
	String today = df.format(date);
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
	function submitGo(){

		if($('#eqNm').val() == ''){
			alert("장비를 선택 해주세요");
			return false;
		}
		if($('#equUserName').val() == ''){
			alert("책임자를 입력해주세요");
			$('#equUserName').focus();
			return false;
		}
		if($('#startDate').val() == '' || $('endDate').val() == ''){
			alert("사용일시를 입력해주세요");
			return false;
		}

		if($('#useTime').val() == ''){
			alert("사용시간을 입력해주세요");
			$('#useTime').focus();
			return false;
		}
		if($('#orgNm').val() == ''){
			alert("기관을 선택해주세요");
			return false;
		}
		if($('#userNm').val() == ''){
			alert("사용자를 입력해주세요");
			$('#userNm').focus();
			return false;
		}
		if($('#phone').val() == ''){
			alert("연락처를 입력해주세요");
			$('#phone').focus();
			return false;
		}
		if($('#purpose').val() == ''){
			alert("사용목적을 입력해주세요");
			$('#purpose').focus();
			return false;
		}
		if($('#useNote').val() == ''){
			alert("사용내용을 입력해주세요");
			$('#userNote').focus();
			return false;
		}
		if($('#sampleCnt').val() == ''){
			alert("시료수를 입력해주세요");
			$('#sampleCnt').focus();
			return false;
		}
		if($('#rentalFee').val() == ''){
			alert("사용료(VAT 제외)를 입력해주세요");
			$('#rentalFee').focus();
			return false;
		}

}
	$(document).ready(function() {
		$(function() {
		    $("input:text").keydown(function(evt) {
		        if (evt.keyCode == 13)
		            return false;
		    });
		});

		$("#startDate, #endDate").datepicker({
    		showMonthAfterYear : true,
    		changeMonth : true,
    		changeYear : true,
    		nextText : '다음 달',
    		prevText : '이전 달',
    		currentText : '오늘 날짜',
    		closeText : '닫기',
    		dateFormat : "yy-mm-dd",
    		dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
    		dayNamesMin : ['월','화','수','목','금','토','일'],
    		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
    		maxDate:'+0d'
		});

		$('#startTime').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#endTime").datepicker( "option", "minDate", selectedDate );
	    });

		$('#endTime').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#startTime").datepicker( "option", "maxDate", selectedDate );
	    });

		$("#sampleCnt, #rentalFee").keyup(function(event){
	        if (!(event.keyCode >=37 && event.keyCode<=40)) {
	            var inputVal = $(this).val();
	            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
	        }
	    });
	});

	 function bytecheck(obj, maxByte){
		 var str = obj.value;
		 var str_len = str.length;

		 var rbyte = 0;
		 var rlen = 0;
		 var one_char = "";
		 var str2 = "";

		 for(var i=0; i<str_len; i++){
		 one_char = str.charAt(i);
		 if(escape(one_char).length > 4){
		     rbyte += 2;                                         //한글2Byte
		 }else{
		     rbyte++;                                            //영문 등 나머지 1Byte
		 }

		 if(rbyte <= maxByte){
		     rlen = i+1;                                          //return할 문자열 갯수
		 }
		 }

		 if(rbyte > maxByte){
		     alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
		     str2 = str.substr(0,rlen);                                  //문자열 자르기
		     obj.value = str2;
		     bytecheck(obj, maxByte);
		 }else{
		     document.getElementById('byteInfo').innerText = rbyte;
		 }
	};

</script>

<div class="clear_wrap">
	<h2>예약 정보</h2>
				<div class="box_in">
					<table id="step1"  class="skin_basic_write">
	                	<colgroup>
	               			<col width="20%">
	               			<col width="30%">
	               			<col width="20%">
	               			<col width="30%">
	                	</colgroup>
	                	<tbody>
							<tr>
	                			<th scope="col">JEINET 예약번호</th>
	                			<td scope="col">
	                				J-<%=util.getStr(paramMap.get("equOrderIdx"))%>
	                			</td>
	                			<th scope="col">처리상태</th>
	                			<td colspan="3">
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <img alt="이용승인" src="/img/back/comm/order_state_img_2.png"> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %>
	                				<img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <br /> 반려사유 :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <img alt="이용완료" src="/img/back/comm/order_state_img_4.png"> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> <% } %>
	                			</td>
                			</tr>
							<tr>
	                			<th scope="col">처리부서</th>
	                			<td scope="col">
	                				<%=util.getStr(dataMap.get("ORDER_DEPT_NM"))%>
	                			</td>
	                			<th scope="col">처리자</th>
	                			<td scope="col">
	                				<%=util.getStr(dataMap.get("ORDER_OPERATOR"))%>
	                			</td>
                			</tr>
							<tr>
	                			<th scope="col">처리시간</th>
	                			<td scope="col">
	                				<%=util.getStr(dataMap.get("ORDER_OPERATOR_DT"))%>
	                			</td>
	                			<th scope="col">예약정보 인쇄</th>
	                			<td scope="col">
 									<button class="btn_inp_y_01" onclick="printPop('<%=dataMap.get("RND_EQU_IDX")%>','<%=dataMap.get("USER_IDX")%>','<%=util.getStr(paramMap.get("equOrderIdx"))%>')">인쇄하기</button>
	                			</td>
	                		</tr>
                		</tbody>
                	</table>






                	<h3>장비이용 예약정보</h3>
                	<table id="step1"  class="skin_basic_write">
	                	<colgroup>
	               			<col width="20%">
	               			<col width="30%">
	               			<col width="20%">
	               			<col width="30%">
	                	</colgroup>
	                	<tbody>
	                		<tr>
	                			<th scope="col">예약신청일</th>
	                			<td scope="col">
	                			<%=util.getStr(dataMap.get("ORDER_DT"))%>
	                			</td>
	                			<th scope="col">기관접수일</th>
	                			<td scope="col">
								
	                			</td>
	                		</tr>

	                		<tr>
	                			<th scope="col">이용희망기간</th>
	                			<td scope="col">
	                			<%=util.getStr(dataMap.get("USE_ST_DT"))%>
	                			~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>

	                			</td>
	                			<th scope="col">이용확정기간</th>
	                			<td scope="col">
	                			<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>
	                			~ <%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>
	                			</td>
	                		</tr>

	                		<tr>
	                			<th scope="col">이용자명</th>
	                			<td scope="col">
	                			<%=util.getStr(userMap.get("PSN_NM"))%>
	                			</td>
	                			<th scope="col">연락처</th>
	                			<td scope="col">
	                			<%=util.getStr(userMap.get("EMAIL"))%>
	                			<br /><%=util.getStr(userMap.get("PHONE"))%>
	                			</td>
	                		</tr>
	                		<tr>
	                			<th scope="col">소속기관명</th>
	                			<td scope="col">
	                			<%=util.getStr(userMap.get("ORG_GRP_NM"))%>
	                			</td>
	                			<th scope="col">소속부서/센터</th>
	                			<td scope="col">
	                			<%=util.getStr(dataMap.get("DEPT_NM"))%>
	                			</td>
	                		</tr>
	                		<tr>
	                			<th scope="col">신청자 직위</th>
	                			<td scope="col">
	                			<%=util.getStr(userMap.get("POSITION_NM"))%>
	                			</td>
	                			<th scope="col">책임자</th>
	                			<td scope="col">
	                			<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%>
	                			</td>
	                		</tr>
	                		<tr>
	                			<th scope="col">장비명</th>
	                			<td scope="col">
		                			<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
	                			</td>
	                			<th scope="col">모델명</th>
	                			<td scope="col">
	                			<%=util.getStr(dataMap.get("MODEL_NM"))%>
	                			</td>
	                		</tr>
	                		<tr>
	                		<tr>
	                			<th scope="col">시료명(시료수)</th>
	                			<td scope="col">
		                			<%
		                				String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
	                					String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
	                					String sampleNmArr[] = sampleNm.split("\\|\\|");
	                					String sampleNoArr[] = sampleNo.split("\\|\\|");
	                					for(int i = 1 ; i < sampleNmArr.length ; i++ ){
	                						if( i != 1 ){
	                							//out.println(", ");
	                						}
	                						out.println(i+". 시료 : " + sampleNmArr[i]);
	                						out.println("(");
	                						out.println(sampleNoArr[i]);
	                						out.println(")");
	                						out.println("<br />");
	                					}
		                			%>
	                			</td>
	                			<th scope="col">사용구분</th>
	                			<td scope="col">
	                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> 서비스의뢰 <% } %>
	                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> 직접사용 <% } %>
	                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> 야간및휴일사용 <% } %>
	                			</td>
	                		</tr>
	                		<tr>
	                			<th scope="col">이용료안내</th>
	                			<td colspan="3">
		                			<%=util.getStr(dataMap.get("RENTAL_INFO"))%>
	                			</td>

	                		</tr>
	                			<th scope="col">이용목적</th>
	                			<td colspan="3">
	                			<%=util.getStr(dataMap.get("USE_PURPOSE"))%>
	                			</td>
	                		</tr>
	                		<tr>
	                			<th scope="col">특기사항</th>
	                			<td colspan="3">
	                			<%=util.getStr(dataMap.get("SAMPLE_MATTER")).replace("\n", "<br/>")%>
	                			</td>
	                		</tr>

                	</tbody>
                </table>
              </div>
              <!-- 운영일지 작성시 -->
              	<%if(util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %>

              	<h3>운영일지 등록 정보</h3>
              	<div class="box_in">
		<table id="step1"  class="skin_basic_write">
	        <colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
			</colgroup>

			<!-- colgroup e -->
			<tbody>
				<tr style="display: none;">
					<th scope="col">연구시설장비</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("KOR_NM")) %> (<%=util.getStr(diaryDataMap.get("ENG_NM")) %>)
					</td>
					<th scope="col">고정자산번호</th>
					<td scope="col"><%=util.getStr(diaryDataMap.get("FIXED_ASET_NO")) %></td>
				</tr>
				<tr>
					<th colspan="4">담당자 정보</th>
				</tr>
				<tr>
					<th scope="col">기관</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("EQU_USER_ORG")) %>
					</td>
					<th scope="col">부서</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("EQU_USER_DEPT")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">담당자</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("EQU_USER_NM")) %>
					</td>
					<th scope="col">직위</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("EQU_USER_POSITION")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">전화번호</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("EQU_USER_PHONE")) %>
					</td>
					<th scope="col">이메일</th>
					<td scope="col">
						<%=util.getStr(diaryDataMap.get("EQU_USER_EMAIL")) %>
					</td>
				</tr>
				<tr>
					<th colspan="4">사용정보</th>
				</tr>
				<tr>
					<th scope="col">사용일시</th>
					<td colspan="3">
						<%=util.getStr(String.valueOf(diaryDataMap.get("START_DT"))) %>
						 ~
						<%=util.getStr(String.valueOf(diaryDataMap.get("END_DT"))) %>
					</td>
				</tr>
				<tr>
					<th scope="col">사용시간</th>
					<td colspan="3">
						<%=util.getStr(String.valueOf(diaryDataMap.get("USE_TIME"))) %>시간
					</td>
				</tr>
				<tr style="display: none;">
					<th scope="col">사용기관</th>
					<td colspan="3">
						구분 : <%if(util.getStr(diaryDataMap.get("ORG_SELECT")).equals("01")) {
							out.println("기관 내 동일부서");
						 }else if(util.getStr(diaryDataMap.get("ORG_SELECT")).equals("02")) {
							out.println("기관 내 타부서");
						 } else if(util.getStr(diaryDataMap.get("ORG_SELECT")).equals("03")) {
							out.println("외부기관");
						 }%> /
						기관명 : <%=util.getStr(diaryDataMap.get("ORG_GRP_NM")) %> /
						부서명 : <%=util.getStr(diaryDataMap.get("DEPT_NM")) %>
					</td>
				</tr>
				<tr style="display: none;">
					<th scope="col">사용자</th>
					<td scope="col"><%=util.getStr(diaryDataMap.get("USE_USER_NM")) %></td>
					<th scope="col">연락처</th>
					<td scope="col"><%=util.getStr(diaryDataMap.get("USE_USER_PHONE")) %></td>
				</tr>
				<tr style="display: none;">
					<th scope="col">사용목적</th>
					<td colspan="3"><%=util.getStr(diaryDataMap.get("PURPOSE")) %></td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">사용내용</label></th>
					<td colspan="3">
						<%=util.getStr(diaryDataMap.get("USE_NOTE")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">시료수</th>
					<td colspan="3"><%=util.getStr(String.valueOf(diaryDataMap.get("SAMPLE_CNT"))) %>건</td>
				</tr>
				<tr>
					<th scope="col">사용료(VAT 제외)</th>
					<td>
						<%=util.setFormatNum(String.valueOf(diaryDataMap.get("RENTAL_FEE")), "comma") %>원
					</td>
				</tr>
        	</tbody>
		</table>
	</div>
              	<% } %>
              	<!-- 운영일지 작성시 완료 -->

              <div class="btn_box" >
              	<div class="btn_left_box" >

              		<!-- 권한주기 최고,기관관리자,담당자 -->
              		<% if(util.loginCheck()) {%>
	              		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
		            		<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('2')">예약접수</button>

<!-- 	            			<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">승인요청 거절</button> -->
		            	<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
		            		<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
		            			<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('4')">이용 완료</button>
		            		<% } %> --%>
		            			<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('5')">이용승인 취소</button>

						<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <!-- 이용완료상태일경우 -->
							<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- 기관담당자 이상 -->
								<% if(!util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %> <!-- 기관담당자 이상 -->
								<button class="btn_inp_b_01" type="button" onclick="<%-- resveReport(<%=util.getStr(paramMap.get("equOrderIdx"))%>) --%>resveReport()">장비 운영일지</button>
								<% } %>
							<% } %>
						<% } %>
	            	<% } %>
              	</div>


	            <div class="btn_right_box" >
	                <% if(util.loginCheck()) {%>
	            	<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
	            		<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ) {%>
							<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
						<% } %>
	            	<% } %>
	            	<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
	         	</div>
             </div>

			<br/>
			<div id="rejectDisplayDiv" style="display:none; " class="skin_bbs_write">
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 20%;" />
						<col style="width: *%;" />
						<col style="width: 5%;" />
					</colgroup>
					<tbody>
						<tr>
							<th>반려사유</th>
							<td><textarea rows="4" cols="100" id="rejectTxt" name="rejectTxt" class="inp_txt" style="width:100%; overflow: auto; resize:none;"></textarea></td>
							<td><button class="btn_inp_b_01" type="button" onclick="resveConsentGo('3')">반려확인</button></td>
						</tr>
					</tbody>
				</table>
			</div>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4") && util.getStr(dataMap.get("DIARY_YN")).equals("")) { %>
		 <form name="fwrite" id="fwrite" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" value="editReport" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
		<input type="hidden" name="startTime" value="" />
		<input type="hidden" name="endTime" value="" />
		<div class="skin_bbs_write" id="operDiaryWrite" <%if( !diary.equals("view") ){ %>style="display:none;"<% } %> >
		<h3>장비 운영일지 작성</h3>
			<table class="skin_basic_write">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
			</colgroup>
			<!-- colgroup e -->
			<tr style="display: none;">
				<th scope="col">연구시설장비</th>
				<td scope="col"><input type="text" class="inp_txt" name="eqNm" id="eqNm" value="<%=util.getStr(dataMap.get("KOR_NM")) %>" /></td>
				<th scope="col">고정자산번호</th>
				<td scope="col"><input type="text" class="inp_txt" name="eqserial" id="eqserial" value="<%=util.getStr(dataMap.get("FIXED_ASET_NO")) %>" /></td>
			</tr>
			<tr>
				<th colspan="4">담당자 정보</th>
			</tr>
			<tr>
				<th scope="col">기관</th>
				<td scope="col">
					<input type="text" class="inp_txt" name="equUserOrg" id="equUserOrg" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" readonly="readonly"/>
				</td>
				<th scope="col">부서</th>
				<td scope="col">
					<input type="text" class="inp_txt" name="equUserDept" id="equUserDept" value="<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="col">담당자</th>
				<td scope="col">
					<input type="text" class="inp_txt" name="equUserName" id="equUserName" value="<%=util.getStr(dataMap.get("OPER_CHARGER")) %>" readonly="readonly"/>
				</td>
				<th scope="col">직위</th>
				<td scope="col">
					<input type="text" class="inp_txt" name="equUserPosition" id="equUserPosition" value="<%=util.getStr(dataMap.get("OPER_POSITION")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="col">전화번호</th>
				<td scope="col">
					<input type="text" class="inp_txt" name="equUserPhone" id="equUserPhone" value="<%=util.getStr(dataMap.get("OPER_TEL")) %>" readonly="readonly"/>
				</td>
				<th scope="col">이메일</th>
				<td scope="col">
					<input type="text" class="inp_txt" name="equUserEmail" id="equUserEmail" value="<%=util.getStr(dataMap.get("OPER_EMAIL")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th colspan="4">사용정보</th>
			</tr>
			<tr>
				<th scope="col">사용일시</th>
				<td colspan="3">
					<input type="text"  class="inp_txt" name="startDate" id="startDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ST_DT")))) { %> <%=util.getStr(dataMap.get("USE_ST_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ST_DT")) %> <% } %>" title="시작날짜"/>
					<%-- <select title="시작시간" name="startTime" id="startTime">
						<%for(int i = 0; i <= 23; i++) {
							if(i < 10) {%>
								<option value="0<%=i%>">0<%=i%></option>
							<%} else { %>
								<option vlaue="<%=i %>"><%=i%></option>
							<%} %>
						<% } %>
					</select> --%> ~
					<input type="text"  class="inp_txt" name="endDate" id="endDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ED_DT")))) { %> <%=util.getStr(dataMap.get("USE_ED_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ED_DT")) %> <% } %>"  title="종료날짜"/>
					<%-- <select title="종료시간" name="endTime" id="endTime">
						<%for(int i = 0; i <= 23; i++) {
							if(i < 10) {%>
								<option value="0<%=i%>">0<%=i%></option>
							<%} else { %>
								<option vlaue="<%=i %>"><%=i%></option>
							<%} %>
						<% } %>
					</select> --%>
				</td>
			</tr>
			<tr>
				<th scope="col">사용시간</th>
				<td colspan="3">
					<input type="text"  class="inp_txt" name="useTime" id="useTime"  value="0"  title="사용시간" />ex)5.6시간 > 5.6
				</td>
			</tr>
			<tr style="display: none;">
				<th scope="col">사용기관</th>
				<td colspan="3">
					<label for="orgSe">구분 : </label>
					<select name="orgSe" id="orgSe" >
						<option value="01" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기업")){ %>checked<%} %>>기관  내 동일부서</option>
						<option value="02>" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기관/센터")){ %>checked<%} %>>기관 내 타부서</option>
						<option value="03" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("")){ %>checked<%} %>>외부기관</option>
					</select>
					<label for="orgNm">기관명 : </label><input type="hidden" class="inp_txt" name="orgCd" id="orgCd" value="<%=util.getStr(userMap.get("ORG_GRP_CD")) %>" />
					<input type="text" class="inp_txt" name="orgNm" id="orgNm" readonly="readonly" value="<%=util.getStr(userMap.get("ORG_GRP_NM")) %>"/>
					<label for="depNm">부서명 : </label><input type="text" class="inp_txt" name="deptNm" id="deptNm"  value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
				</td>
			</tr>
			<tr style="display: none;">
				<th scope="col">사용자</th>
				<td scope="col"><input type="text" class="inp_txt" name="userNm" id="userNm" value="<%=util.getStr(userMap.get("PSN_NM")) %>" /></td>
				<th scope="col">연락처</th>
				<td scope="col"><input type="text" class="inp_txt" name="phone" id="phone" value="<%=util.getStr(userMap.get("CP_NO")) %>"  /></td>
			</tr>
			<tr style="display: none;">
				<th scope="col">사용목적</th>
				<td colspan="3"><input type="text" class="inp_txt" name="purpose" id="purpose" value="<%=util.getStr(dataMap.get("USE_PURPOSE")) %>" /></td>
			</tr>
			<tr>
				<th scope="col">시료수</th>
				<td colspan="3"><input type="text" class="inp_txt" name="sampleCnt" id="sampleCnt" value=""  />건</td>
			</tr>
			<tr>
				<th scope="col">사용료(VAT 제외)</th>
				<td>
					<input type="text" class="inp_txt" name="rentalFee" id="rentalFee" />원
				</td>
			</tr>
			<tr>
				<th scope="col"><label for="useNote">사용내용</label></th>
				<td colspan="3">
					<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
					<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
				</td>
			</tr>
			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="button" class="btn_inp_b_01" value="등록완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="diarySubmit()" />
		        	<button type="button" class="btn_inp_w_01" style="text-align: center;" onclick="diaryCancle()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>
	<% } %>


</div>
<form id = "fview" name = "fview" method="post" action="/sys/sys_eq_reservation.do">
	<input type="hidden" id="mode" 			name="mode" 		value="<%=mode%>"/>
	<input type="hidden" id="orderState" 	name="orderState"	value="<%=util.getStr(paramMap.get("orderState"))%>"/>
	<input type="hidden" id="searchType" 	name="searchType"	value="<%=util.getStr(paramMap.get("searchType"))%>"/>
	<input type="hidden" id="searchStDt" 	name="searchStDt"	value="<%=util.getStr(paramMap.get("searchStDt"))%>"/>
	<input type="hidden" id="searchEdDt" 	name="searchEdDt"	value="<%=util.getStr(paramMap.get("searchEdDt"))%>"/>
	<input type="hidden" id="searchWord" 	name="searchWord"	value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
	<input type="hidden" id="reUrl"  		name="reUrl" 		value="<%=myPage%>" />
	<input type="hidden" id="reject"  		name="reject" 		value="" />
	<input type="hidden" id="equOrderIdx"	 name="equOrderIdx" value="<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
</form>
<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageDelGo(){
		var stateResult = "";
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> stateResult = "승인요청"; <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> stateResult = "이용승인"; <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> stateResult = "승인거절"; <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> stateResult = "이용완료"; <% } %>
		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> stateResult = "승인취소"; <% } %>
		if(confirm("'"+stateResult+"' 상태인 사용자입니다. 삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
	function resveConsentGo(orderState){
		var rejectTxt = document.getElementById('rejectTxt').value;

		if(orderState == '2'){ //이용승인
			if(confirm("예약 승인 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./eqReservationProc.do"
				$('#orderState').val(orderState);
				//alert("승인 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(orderState == '3'){ //승인취소
			if(confirm("정말 승인거절 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./eqReservationProc.do"
				$('#orderState').val(orderState);
				$('#reject').val(rejectTxt);
				alert("반려 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(orderState == '5'){ //승인취소
			if(confirm("정말 예약 승인 취소 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./eqReservationProc.do"
				$('#orderState').val(orderState);
				//alert("승인 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}
	}


	function resveReturnDisplay(){
		$('#rejectDisplayDiv').show();
	}

	/* function resveReport(equOrderIdx){ //운영일지 작성
		window.open("/sys/writeReport.do?equOrderIdx="+equOrderIdx,"SYS","width=800,height=800,scrollbars=auto,,resizable=yes,toolbar=0,directories=0,status=no");
		//$('#rejectDisplayDiv').show();
	} */

	function resveReport() {
		$("#operDiaryWrite").toggle();
	}

	function diaryCancle() {
		$("#operDiaryWrite").toggle();
	}

	function diarySubmit() {
		var formData = $("#fwrite").serialize();

		if($('#rentalFee').val() == ''){
			alert("사용료(VAT 제외)를 입력해주세요");
			$('#rentalFee').focus();
			return false;
		}
		$.ajax({
			url : "/sys/eqReservationProc.do",
			type : "POST",
			data : formData,
			success : function() {
				alert("등록하였습니다.");
				location.reload();
			},
			error : function() {
				alert("문제가 발생했습니다.");
			}
		});
	}

	function resveReturnGo(){
		var rejectTxt = document.getElementById('rejectTxt').value;
		if(confirm("정말 반려처리 하시겠습니까?")){
			$('#mode').val('stateEdit');
			document.fview.action = "./eqReservationProc.do"
			$('#orderState').val('3');
			$('#reject').val(rejectTxt);
			alert("반려 되었습니다.");
			$('#fview').submit();
		} else {
			return false;
		}

	}
	function printPop(rndEquIdx,userIdx,equOrderIdx){
		window.open('/AIViewer55/temp/yeyaprint.jsp?reportParams=showScrollNext:false,showScrollTop:false,showScrollBottom:false,showScrollPrev:false,showScrollPage:false,showPdf:false,showExcel:false,showHwp:false,showZoomOut:false,showZoomIn:false,showZoomPers:false&menu=old&rndEquIdx='+rndEquIdx+'&userIdx='+userIdx+'&equOrderIdx='+equOrderIdx+'','win','width=797,height=800,toolbar=0,scrollbars=0,resizable=0')
	}
</script>
