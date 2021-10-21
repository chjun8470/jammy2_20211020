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
	String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));

%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">

var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

//이용희망시간 달력
	$(document).ready(function(){
		$( "#realUseStDt" ).datepicker({
	    dateFormat: 'yy-mm-dd'
	  });
	  	$( "#realUseEdDt" ).datepicker({
	    dateFormat: 'yy-mm-dd'
	  });

});


function orgPost(){
	new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById('zipCode').value = data.zonecode;

			if (data.userSelectedType === 'R') {
				// 도로명 주소 선택시
				var adrs = data.roadAddress;
				if (data.buildingName != undefined && data.buildingName.length > 0) {
					adrs += ' (' + data.buildingName + ')';
				}
				document.getElementById('addr1').value = adrs;
			} else {
				// 지번 주소 선택시
				document.getElementById('addr1').value = data.jibunAddress;
			}
			document.getElementById('addr2').focus();
		}
	}).open();
}

function reservationGo(){

	$('#mode').val('editSubmit');

	if($('#zipCode').val() == ''  || $("#zipCode").val()=="" ){
		alert("우편번호를 입력해주세요");
		$('#zipCode').focus();
		return false;
	}
	if($('#addr1').val() == ''  || $("#addr1").val()=="" ){
		alert("주소를 입력해주세요");
		$('#addr').focus();
		return false;
	}
	if($('#corpPosition').val() == ''  || $("#corpPosition").val()=="" ){
		alert("신청자 직위를 입력해주세요");
		$('#corpPosition').focus();
		return false;
	}
	if($('#corpResponsibleUser').val() == ''  || $("#corpResponsibleUser").val()=="" ){
		alert("책임자를 입력해주세요");
		$('#corpResponsibleUser').focus();
		return false;
	}
	if($('#sampleNm').val() == ''  || $("#sampleNm").val()=="" ){
		alert("시료명을 입력해주세요");
		$('#sampleNm').focus();
		return false;
	}
	if($('#sampleNo').val() == ''  || $("#sampleNo").val()=="" ){
		alert("시료수를 입력해주세요");
		$('#sampleNo').focus();
		return false;
	}


	var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
	$('#userType').val(userTypeCheck);



	if(confirm("정말 수정하시겠습니까?")){
		$('#fedit').submit();
	} else {
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
	  <form name="fedit" id="fedit" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value="<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>

		<div class="skin_bbs_write" style="margin-top:30px">
			<table id="step1"  class="skin_basic_write">







	                	<colgroup>
	               			<col width="20%">
	               			<col width="30%">
	               			<col width="20%">
	               			<col width="30%">
	                	</colgroup>
	                	<tbody>

                		<tr>
                			<th scope="col">시설장비분류</th>
                			<td scope="col">
                			<%if(util.getStr(dataMap.get("EQUIP_CD")).equals("1")) { %> 연구장비 <% } %>
                			<%if(util.getStr(dataMap.get("EQUIP_CD")).equals("2")) { %> 연구시설 <% } %>
                			</td>
                			<th scope="col">장비명</th>
                			<td scope="col">
	                			<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col">취득방법</th>
                			<td scope="col">
	                			<%if(util.getStr(dataMap.get("TAKE_CD")).equals("1")) { %> 구매 <% } %>
                				<%if(util.getStr(dataMap.get("TAKE_CD")).equals("2")) { %> 개발 <% } %>
                			</td>
                			<th scope="col">취득금액</th>
                			<td scope="col">
	                			<%=util.getStr(dataMap.get("TAKE_PRC"))%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col">예약자 기관명</th>
                			<td scope="col">
	                			<%=util.getStr(dataMap.get("CORP_NM"))%>
                			</td>
                			<th scope="col">예약자 기관주소</th>
                			<td scope="col">
	                			<%=util.getStr(dataMap.get("BLNG_ORG_ADDR_DTL"))%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col"><font color="red">*</font> 예약자명</th>
                			<td scope="col">
                				<%=util.getStr(dataMap.get("PSN_NM"))%>
                			</td>
                			<th scope="col">성별</th>
                			<td scope="col">
                				<%if(util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("M")) { %> 남자 <% } %>
                				<%if(util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("F")) { %> 여자 <% } %>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">사업자구분</th>
                			<td scope="col">

                			<input type="hidden" id="userType" name="userType" value="">
							<input type="radio" id="userType1" name="userTypeCheck" value="A"
							<%if(util.getStr(dataMap.get("USER_TYPE")).equals("A")) { %> checked="checked" <% } %>>사업자&nbsp;&nbsp;&nbsp;
							<input type="radio" id="userType2" name="userTypeCheck" value="B"
							<%if(util.getStr(dataMap.get("USER_TYPE")).equals("B")) { %> checked="checked" <% } %>>비사업자
                			</td>

                			<th scope="col">연락처</th>
                			<td scope="col">
                			<%=util.getStr(dataMap.get("EMAIL"))%><br />
                			<%=util.getStr(dataMap.get("CP_NO"))%>
                			</td>
                		</tr>
                		<tr>
							<th scope="col"><font color="red">*</font> 사용구분</th>
							<td>
								<select id="useMean" name="useMean">
								<option value=""  >사용구분선택</option>
								<option value="1" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> selected="selected" <% } %>>서비스의뢰</option>
								<option value="2" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> selected="selected" <% } %>>직접사용</option>
								<option value="3" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> selected="selected" <% } %>>야간및휴일사용</option>
                				</select>
							</td>
							<th scope="col"><font color="red">*</font> 기타</th>
							<td>기타</td>
						</tr>
                		<tr>
                			<th scope="col"><font color="red">*</font> 주소</th>
                			<td scope="col">
                				<input type="text" name="zipCode" maxlength="10" value="<%=util.getStr(dataMap.get("ZIPCODE"))%>" id="zipCode"  class="inp_text" title="신청자주소" style="width:100px" readonly = "readonly" >
								<br /><input type="text" name="addr1" maxlength="100" value="<%=util.getStr(dataMap.get("ADDR1"))%>" id="addr1"  class="inp_text" title="신청자주소" style="width:250px" readonly="readonly">
								<input type="button" id = "deptPostButton" value="찾아보기" class="btn_inp_b_01" onclick = "orgPost()" />
                			</td>
                			<th scope="col"><font color="red">*</font> 상세주소</th>
                			<td scope="col">
								<input type="text" name="addr2" maxlength="100" value="<%=util.getStr(dataMap.get("ADDR2"))%>" id="addr2"  class="inp_text" title="신청자주소" style="width:300px">
                			</td>
                		</tr>

                		<tr>
                			<th scope="col"><font color="red">*</font> 소속부서/센터</th>
                			<td colspan="3">
                			<input type="text" name="deptNm" maxlength="100" value="<%=util.getStr(dataMap.get("DEPT_NM"))%>" id="deptNm"  class="inp_text" title="부서센터" style="width:300px" >
                		</tr>
                		<tr>
                			<th scope="col"><font color="red">*</font> 신청자 직위</th>
                			<td scope="col">
                			<input type="text" name="corpPosition" maxlength="50" value="<%=util.getStr(dataMap.get("CORP_POSITION"))%>" id="corpPosition"  class="inp_text" title="직위" style="width:200px" >
                			</td>
                			<th scope="col"><font color="red">*</font> 책임자</th>
                			<td scope="col">
                			<input type="text" name="corpResponsibleUser" maxlength="50" value="<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%>" id="corpResponsibleUser"  class="inp_text" title="책임자" style="width:200px" >
                			</td>
                		</tr>

                		<tr>
                			<th scope="col"><font color="red">*</font> 이용희망시작일</th>
                			<td scope="col">
                			<%=util.getStr(dataMap.get("USE_ST_DT"))%>

                			</td>
                			<th scope="col"><font color="red">*</font> 이용희망종료일</th>
                			<td scope="col">
                			<%=util.getStr(dataMap.get("USE_ED_DT"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">실사용시작일</th>
                			<td scope="col">
                			<input type="text" class="inp_text" name="realUseStDt" id="realUseStDt" value="<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>" size="15"/>
					<!-- <select id="realUseStDt2" name="realUseStDt2">
						<option value="00" >오전&nbsp;12</option>
						<option value="01" >오전&nbsp;&nbsp;1</option>
						<option value="02" >오전&nbsp;&nbsp;2</option>
						<option value="03" >오전&nbsp;&nbsp;3</option>
						<option value="04" >오전&nbsp;&nbsp;4</option>
						<option value="05" >오전&nbsp;&nbsp;5</option>
						<option value="06" >오전&nbsp;&nbsp;6</option>
						<option value="07" >오전&nbsp;&nbsp;7</option>
						<option value="08" >오전&nbsp;&nbsp;8</option>
						<option value="09" >오전&nbsp;&nbsp;9</option>
						<option value="10" >오전&nbsp;10</option>
						<option value="11" >오전&nbsp;11</option>
						<option value="12" >오후&nbsp;12</option>
						<option value="13" >오후&nbsp;&nbsp;1</option>
						<option value="14" >오후&nbsp;&nbsp;2</option>
						<option value="15" >오후&nbsp;&nbsp;3</option>
						<option value="16" >오후&nbsp;&nbsp;4</option>
						<option value="17" >오후&nbsp;&nbsp;5</option>
						<option value="18" >오후&nbsp;&nbsp;6</option>
						<option value="19" >오후&nbsp;&nbsp;7</option>
						<option value="20" >오후&nbsp;&nbsp;8</option>
						<option value="21" >오후&nbsp;&nbsp;9</option>
						<option value="22" >오후&nbsp;10</option>
						<option value="23" >오후&nbsp;11</option>
					</select>시 -->
				<!-- <input type="text" class="inp_text" name="realUseStDt3" id="realUseStDt3" value="" size="3"/>분 -->
                			</td>
                			<th scope="col">실사용종료일</th>
                			<td scope="col">
                			<input type="text" class="inp_text" name="realUseEdDt" id="realUseEdDt" value="<%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>" size="15"/>
		 		<!-- <select id="realUseEdDt2" name="realUseEdDt2">
						<option value="00" >오전&nbsp;12</option>
						<option value="01" >오전&nbsp;&nbsp;1</option>
						<option value="02" >오전&nbsp;&nbsp;2</option>
						<option value="03" >오전&nbsp;&nbsp;3</option>
						<option value="04" >오전&nbsp;&nbsp;4</option>
						<option value="05" >오전&nbsp;&nbsp;5</option>
						<option value="06" >오전&nbsp;&nbsp;6</option>
						<option value="07" >오전&nbsp;&nbsp;7</option>
						<option value="08" >오전&nbsp;&nbsp;8</option>
						<option value="09" >오전&nbsp;&nbsp;9</option>
						<option value="10" >오전&nbsp;10</option>
						<option value="11" >오전&nbsp;11</option>
						<option value="12" >오후&nbsp;12</option>
						<option value="13" >오후&nbsp;&nbsp;1</option>
						<option value="14" >오후&nbsp;&nbsp;2</option>
						<option value="15" >오후&nbsp;&nbsp;3</option>
						<option value="16" >오후&nbsp;&nbsp;4</option>
						<option value="17" >오후&nbsp;&nbsp;5</option>
						<option value="18" >오후&nbsp;&nbsp;6</option>
						<option value="19" >오후&nbsp;&nbsp;7</option>
						<option value="20" >오후&nbsp;&nbsp;8</option>
						<option value="21" >오후&nbsp;&nbsp;9</option>
						<option value="22" >오후&nbsp;10</option>
						<option value="23" >오후&nbsp;11</option>
					</select>시 -->
				<!-- <input type="text" class="inp_text" name="realUseEdDt3" id="realUseEdDt3" value="" size="3"/>분 -->
                			</td>
                		</tr>


                		<tr>
                			<th scope="col">접수일</th>
                			<td colspan="3">
                			<%=util.getStr(dataMap.get("ORDER_DT"))%>
                			</td>
                		</tr>

                		<tr>
                			<th scope="col">이용목적</th>
                			<td colspan="3">
                			<input type="text" name="usePurpose" maxlength="150" value="<%=util.getStr(dataMap.get("USE_PURPOSE"))%>" id="usePurpose"  class="inp_text" title="부서센터" style="width:300px" >
                			</td>
                		</tr>

                		<tr>
                			<th scope="col"><font color="red">*</font>시료명</th>
                			<td scope="col">
                			<input type="text" name="sampleNm" maxlength="100" value="<%=util.getStr(dataMap.get("SAMPLE_NM"))%>" id="sampleNm"  class="inp_text" title="시료명" style="width:200px" >
                			</td>
                			<th scope="col"><font color="red">*</font>시료수</th>
                			<td scope="col">
                			<input type="text" name="sampleNo" maxlength="50" value="<%=util.getStr(dataMap.get("SAMPLE_NO"))%>" id="sampleNo"  class="inp_text" title="시료수" style="width:200px" >
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">특기사항</th>
                			<td colspan="3">
                			<textarea rows="3" cols="50" id="sampleMatter" name="sampleMatter"><%=util.getStr(dataMap.get("SAMPLE_MATTER"))%></textarea>
                			</td>
                		</tr>

                		<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- 기관담당자 이상 -->
                		<tr>
                			<th scope="col"><font color="red">*</font>예약현황</th>
                			<td colspan="3">
                			<select id="orderState" name="orderState">
								<option value="1" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> selected="selected" <% } %> >승인요청</option>
								<option value="2" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> selected="selected" <% } %> >이용승인</option>
								<option value="3" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> selected="selected" <% } %> >승인거절</option>
								<option value="4" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> selected="selected" <% } %> >이용완료</option>
								<option value="5" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> selected="selected" <% } %> >승인취소</option>
                			</td>
                		</tr>
                		<% } %>

                	</tbody>
                </table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<input type="button" class="btn_inp_b_01" value="수정완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="reservationGo()"/>
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>