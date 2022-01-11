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

	String m = util.getStr(request.getQueryString());

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));

%>

	  <form name="fwrite" id="fwrite" action="?<%=m%>" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="?<%=m%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="userIdx" id="userIdx" value="<%=loginVO.getUserIdx()%>" />
		<input type="hidden" name="rndEquIdx" id="rndEquIdx" value="<%=util.getStr(paramMap.get("rndEquIdx"))%>" />
		<input type="hidden" name="corpIdx" id="corpIdx" value="<%=util.getStr(userMap.get("ORG_GRP_CD"))%>" />

		<div class="skin_bbs_write" style="margin-top:30px">
			<table class="skin_basic_write">

			<!-- colgroup s -->

			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 80%;" />
			</colgroup>

			<!-- colgroup e -->

			<tr>
				<th scope="col">장비명</th>
				<td scope="col"><%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("RND_EQU_IDX"))%>)</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 이용희망기간</th>
				<td>
		 			<input type="text" class="inp_text" name="useStDt" id="useStDt" value="" size="15"/>
				~
		 		<input type="text" class="inp_text" name="useEdDt" id="useEdDt" value="" size="15"/>
				&nbsp;&nbsp;&nbsp;
				* 이용희망기간은 실제 이용기간과 다를수 있습니다. 담당자가 접수처리시 실제 이용기간을 확정하게 됩니다.
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 사용구분</th>
				<td><select name="useMean" id="useMean" class="b_select2" style="height: 24px;width: 150px">
						<option value="1">분석시험의뢰</option>
						<option value="2">이용자직접사용</option>
						<option value="3">야간및휴일사용</option>
					</select></td>
			</tr>
			<tr>
				<th scope="col">이용목적</th>
				<td>
					<input type="text" class="inp_text box_style_1" name="usePurpose" id="usePurpose" value="" size="70"/>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 시료정보</th>
				<td id="sampleBox" >
						<div id="sampleItem1" >
							<label>시료명 : </label><input type="text" class="inp_text box_style_2" name="sampleNm" id="sampleNm" value="" size="30" />
							&nbsp;<label>시료수 : </label><input type="text" class="inp_text box_style_3" name="sampleNo" id="sampleNo" value="0" size="10" />
							<button class="b_btn_00401" type="button" onclick="sampleBox('p');" title="시료항목 추가"><img src="/img/board/btn_plus.gif"/></button>
							<button class="b_btn_00401" type="button" onclick="sampleBox('m');" title="시료항목 감소"><img src="/img/board/btn_del.gif"/></button>
						</div>
				</td>
			</tr>
			<tr>
				<th scope="col">특기사항</th>
				<td>
					<textarea id="contents" name="sampleMatter" rows="5" cols="100" style="width:99%" ></textarea>
					<br />* 시험항목 및 예상치, 분석조건/시료특성/분석방법/분석성분/사용용매/결과회신방법 등
				</td>
			</tr>




			<!-- 신청자 정보 -->

			<tr>
				<th scope="col"><font color="red">*</font> 신청자명</th>
				<td>
				<%=util.getStr(userMap.get("PSN_NM"))%>(<%=util.getStr(userMap.get("EMAIL"))%> / <%=util.getStr(userMap.get("CP_NO"))%>)
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 소속기관</th>
				<td>
					<%=util.getStr(userMap.get("ORG_GRP_NM"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 소속부서/센터</th>
				<td>
					<input type="text" class="inp_text box_style_4" name="deptNm" id="deptNm" value="<%=util.getStr(userMap.get("DEPT_NM"))%>" size="50"/>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 신청자 직책</th>
				<td>
					<input type="text" class="inp_text box_style_5" name="corpPosition" id="corpPosition" value="<%=util.getStr(userMap.get("POSITION_NM"))%>" size="30"/>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 대표자</th>
				<td>
					<input type="text" class="inp_text box_style_6" name="corpResponsibleUser" id="corpResponsibleUser" value="<%=util.getStr( userMap.get("ORNER_NM") ) %>" size="30"/>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 연락처</th>
				<td>
					<input type="text" class="inp_text box_style_7" name="phone" id="phone" value="<%=util.getStr(userMap.get("TEL_NO"))%>" size="12"/>
					* ex) 061-1234-4567
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font> 주소</th>
				<td>
					<input type="text" class="inp_text box_style_8"  name="zipCode" maxlength="10" value="<%=util.getStr(userMap.get("ZIPCD"))%>" id="zipCode"  title="신청자주소" style="" readonly = "readonly" />
					<input type="text" class="inp_text box_style_9"  name="addr1" maxlength="100" value="<%=util.getStr(userMap.get("ADDR1"))%>" id="addr1"  title="신청자주소" style="" readonly="readonly"/>

					<input type="button" id = "deptPostButton" value="찾아보기" class="btn_inp_w_01_2 btn_fnd"  onclick = "orgPost()" />
					<input type="text" class="inp_text box_style_10"  name="addr2" maxlength="100" value="<%=util.getStr(userMap.get("ADDR2"))%>" id="addr2"  title="신청자주소" style="" />
				</td>
			</tr>
			<!-- <tr>
				<th scope="col"><font color="red">*</font> 결제방법</th>
				<td>
					<input type="hidden" id="priceHow" name="priceHow" value="">
					<input type="radio" id="priceHow1" name="priceHowCheck" value="A">카드&nbsp;&nbsp;&nbsp;
					<input type="radio" id="priceHow2" name="priceHowCheck" value="B">계좌이체&nbsp;&nbsp;&nbsp;
					<input type="radio" id="priceHow3" name="priceHowCheck" value="C">전자계산서
				</td>
			</tr> -->
			<tr>
				<th scope="col"><font color="red">*</font> 구분</th>
				<td>
					<input type="hidden" id="userType" name="userType" value="" />
					<input type="radio" id="userType1" name="userTypeCheck" value="A" /><label for="userType1">사업자</label>&nbsp;&nbsp;&nbsp;
					<input type="radio" id="userType2" name="userTypeCheck" value="B" /><label for="userType2">비사업자</label>
				</td>
			</tr>

			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="b_btn_area">
		        	<!-- <input type="submit" class="btn_inp_b_01" value="등록" id="btn_submit"  class="btn_submit" style="cursor: pointer;" /> -->
		        	<button class="btn_rgt" type="button" onclick="reservationGo()">예약신청</button>
		        	<button class="btn_lft2 color_box_1" type="button" onclick="pageListGo()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>



<script type="text/javascript">
//<![CDATA[
var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

	//이용희망시간 달력
 	$(document).ready(function(){
 		$( "#useStDt" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });
		  $( "#useEdDt" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });

		//$('input:radio[name="priceHow1"][value="A"]').attr('checked', 'checked');
		$('input:radio[name="userType1"][value="A"]').attr('checked', 'checked');

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

	function pageListGo(){
		$('#mode').val('list');
		$('#fwrite').submit();
	}


function reservationGo(){ //submit
		$('#mode').val('writeSubmit');

		if($('#useStDt').val() == ''){
			alert("이용희망기간 시작일(년/월/일)을 입력해주세요.");
			$('#useStDt').focus();
			return false;
		}
		/* if($('#useStDt').val() == ''){
			alert("이용희망기간 시작일(시간)을 입력해주세요.");
			$('#useStDt').focus();
			return false;
		} */
		/* if($('#useStDt3').val() == ''){
			alert("이용희망기간 시작일(분)을 입력해주세요.");
			$('#useStDt3').focus();
			return false;
		} */

		//var useStDt = $('#useStDt1').val() +" "+$('#useStDt2').val()+":00";

		//$('#useStDt').val(useStDt);
		//alert("$(#useStDt).val() >> "+ $('#useStDt').val());

		if($('#useEdDt').val() == ''){
			alert("이용희망기간 종료일(년/월/일)을 입력해주세요.");
			$('#useEdDt').focus();
			return false;
		}
		/* if($('#useEdDt2').val() == ''){
			alert("이용희망기간 종료일(시간)을 입력해주세요.");
			$('#useEdDt2').focus();
			return false;
		} */
		/* if($('#useEdDt3').val() == ''){
			alert("이용희망기간 종료일(분)을 입력해주세요.");
			$('#useEdDt3').focus();
			return false;
		} */

		//var useEdDt = $('#useEdDt1').val() +" "+$('#useEdDt2').val()+":00";
		//$('#useEdDt').val(useEdDt);

		if($('#sampleNm').val() == ''){
			alert("시료명을 입력해주세요");
			$('#sampleNm').focus();
			return false;
		}
		if($('#sampleNo').val() == ''){
			alert("시료수를 입력해주세요");
			$('#sampleNo').focus();
			return false;
		}

		/* if($('#orderPassword').val() == ''){
			alert("예약 비밀번호를 입력해주세요");
			$('#orderPassword').focus();
			return false;
		} */
		if($('#deptNm').val() == ''){
			alert("소속부서/센터를 입력해주세요");
			$('#deptNm').focus();
			return false;
		}
		if($('#corpPosition').val() == ''){
			alert("신청자 직책를 입력해주세요");
			$('#corpPosition').focus();
			return false;
		}
		if($('#corpResponsibleUser').val() == ''){
			alert("책임자를 입력해주세요");
			$('#corpResponsibleUser').focus();
			return false;
		}

		var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
		$('#userType').val(userTypeCheck);
		$('#fwrite').submit();
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
	
	var sample_cnt = 1;
	function sampleBox( state ){
		if( state == 'p' ){
			if( sample_cnt < 10){
				sample_cnt++;
				var sampleHtml = "<div id='sampleItem"+(sample_cnt)+"' >";
				sampleHtml += "<label>시료명 : </label><input type='text' class='inp_text box_style_2' name='sampleNm' id='sampleNm"+(sample_cnt)+"' value='' size='30'/>";
				sampleHtml += "&nbsp;&nbsp;<label>시료수 : </label><input type='text' class='inp_text box_style_3' name='sampleNo' id='sampleNo"+(sample_cnt)+"' value='0' size='10'/>";
				sampleHtml += "</div>";
				$( '#sampleBox' ).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( sample_cnt > 1){
				$( '#sampleItem'+sample_cnt ).remove();
				sample_cnt--;
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");				
			}
		}
	};
//]]>
</script>