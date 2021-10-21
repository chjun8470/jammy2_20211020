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

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));
	String siteId = util.getStr(paramMap.get("siteId"));

	String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
	String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
	String sampleNmArr[] = sampleNm.split("\\|\\|");
	String sampleNoArr[] = sampleNo.split("\\|\\|");
%>
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
		$( "#realUseStDt" ).datepicker({
	    dateFormat: 'yy-mm-dd'
	  });
	  	$( "#realUseEdDt" ).datepicker({
	    dateFormat: 'yy-mm-dd'
	  });
	 
  	$(document).scroll(function(){
		$("input:text").blur();
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
	sampleCnt = $('#sampleBox > div').size();
	if($("#useMean option:selected").val() == ''){
		alert("사용구분을 선택 해주세요");
		$('#useMean').focus();
		return false;
	}
	if($('#zipCode').val() == ''  || $("#zipCode").val() == "" ){
		alert("우편번호를 입력해주세요");
		$('#zipCode').focus();
		return false;
	}
	if($('#addr1').val() == ''  || $("#addr1").val() == "" ){
		alert("주소를 입력해주세요");
		$('#addr1').focus();
		return false;
	}
	if(checkSpace('addr2') == ''){
		alert("상세주소를 입력해주세요");
		$('#addr2').focus();
		return false;
	}
	if(checkSpace('deptNm') == ''){
		alert("소속부서/센터를 입력해주세요");
		$('#deptNm').focus();
		return false;
	}
	if(checkSpace('corpPosition') == ''){
		alert("신청자 직위를 입력해주세요");
		$('#corpPosition').focus();
		return false;
	}
	if(checkSpace('corpResponsibleUser') == ''){
		alert("책임자를 입력해주세요");
		$('#corpResponsibleUser').focus();
		return false;
	}
	if(checkSpace('usePurpose') == ''){
		alert("이용목적 입력해주세요");
		$('#usePurpose').focus();
		return false;
	}
	for(i=1; i < sampleCnt+1; i++){
		if(checkSpace('sampleNm'+i) == ''  || $('#sampleNm'+i).val() == null){
			alert("시료명을 입력해주세요");
			$('#sampleNm'+i).focus();
			return false;
		}
		if(checkSpace('sampleNo'+i) == '' || $('#sampleNo'+i).val() == null){
			alert("시료수를 입력해주세요");
			$('#sampleNo'+i).focus();
			return false;
		}else if(!numPattern.test($('#sampleNo'+i).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#sampleNo'+i).val("");
			$('#sampleNo'+i).focus();
			return false;
		};
	}
	if(checkSpace('sampleMatter') == ''){
		alert("특이사항을 입력해주세요");
		$('#sampleMatter').focus();
		return false;
	}
	/* if($('#realUseStDt1').val() != ''  && $("#realUseStDt1").val()!=null ){ //년월일
		var realUseStDt = $('#realUseStDt1').val() +" "+$('#realUseStDt2').val()+":00";
		$('#realUseStDt').val(realUseStDt);
	}
	if($('#realUseEdDt1').val() != ''  && $("#realUseEdDt1").val()!=null ){ //년월일
		var realUseEdDt = $('#realUseEdDt1').val() +" "+$('#realUseEdDt2').val()+":00";
		$('#realUseEdDt').val(realUseEdDt);
	} */
	
	var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
	$('#userType').val(userTypeCheck);
	
	if(confirm("정말 수정하시겠습니까?")){
		$('#fedit').submit();
	} else {
		return false;
	}
}

	//공백제거
	function checkSpace(id){
		var str = $('#'+id).val();
		console.log(str);
		if(str.search(/\s/) != -1){
			$('#'+id).val(str.trim());
			//$('#'+id).val(str.replace(/ /g, ""));
		}
		return $('#'+id).val();
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

		 for(var i=0; i < str_len; i++){
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

	var sample_cnt = <%=sampleNmArr.length-1%>;
	function sampleBox( state ){
		if( state == 'p' ){
			if( sample_cnt < 10){
				sample_cnt++;
				var sampleHtml = "<div id='sampleItem"+(sample_cnt)+"' >";
				sampleHtml += "<label>시료명 : </label><input type='text' class='inp_text box_style_2' name='sampleNm' id='sampleNm"+(sample_cnt)+"' value='' maxlength='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>시료수 : </label><input type='text' class='inp_text box_style_3' name='sampleNo' id='sampleNo"+(sample_cnt)+"' value='0' maxlength='2'/>";
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
	  <form name="fedit" id="fedit" action="./equorder.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="./equorder.do?siteId=<%=siteId%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value="<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>

		<div class="MPTit">예약수정</div>

		<div class="basic_writeWrap">
			<table class="skin_write01">
	                	<colgroup>
	               			<col width="30%">
	               			<col width="70%">
	                	</colgroup>
	                	<tbody>
                		<tr>
                			<th scope="col">시설장비분류</th>
                			<td scope="col" class="r_line_none">
	                			<%if(util.getStr(dataMap.get("EQUIP_CD")).equals("1")) { %> 연구장비 <% } %>
	                			<%if(util.getStr(dataMap.get("EQUIP_CD")).equals("2")) { %> 연구시설 <% } %>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">장비명</th>
                			<td scope="col" class="r_line_none">
	                			<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col">취득방법</th>
                			<td scope="col" class="r_line_none">
	                			<%if(util.getStr(dataMap.get("TAKE_CD")).equals("1")) { %> 구매 <% } %>
                				<%if(util.getStr(dataMap.get("TAKE_CD")).equals("2")) { %> 개발 <% } %>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">취득금액</th>
                			<td scope="col" class="r_line_none">
	                			<%=util.getStr(dataMap.get("TAKE_PRC"))%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col">예약자 기관명</th>
                			<td scope="col" class="r_line_none">
	                			<%=util.getStr(dataMap.get("CORP_NM"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">예약자 기관주소</th>
                			<td scope="col" class="r_line_none">
	                			<%=util.getStr(dataMap.get("BLNG_ORG_ADDR_DTL"))%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col">예약자명 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                				<%=util.getStr(dataMap.get("PSN_NM"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">성별</th>
                			<td scope="col" class="r_line_none">
                				<%if(util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("M")) { %> 남자 <% } %>
                				<%if(util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("F")) { %> 여자 <% } %>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">사업자구분</th>
                			<td scope="col" class="r_line_none">
	                			<input type="hidden" id="userType" name="userType" value="" />
								<input type="radio" id="userType1" name="userTypeCheck" value="A" 
								<%if(util.getStr(dataMap.get("USER_TYPE")).equals("A")) { %> checked="checked" <% } %> />사업자&nbsp;&nbsp;&nbsp;
								<input type="radio" id="userType2" name="userTypeCheck" value="B" 
								<%if(util.getStr(dataMap.get("USER_TYPE")).equals("B")) { %> checked="checked" <% } %> />비사업자
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">연락처</th>
                			<td scope="col" class="r_line_none">
                			<%=util.getStr(dataMap.get("EMAIL"))%><br />
                			<%=util.getStr(dataMap.get("CP_NO"))%>
                			</td>
                		</tr>
                		<tr>
							<th scope="col">사용구분 <font color="red">*</font></th>
							<td scope="col" class="r_line_none">
								<select id="useMean" name="useMean">
								<option value=""  >사용구분선택</option>
								<option value="1" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> selected="selected" <% } %>>서비스의뢰</option>
								<option value="2" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> selected="selected" <% } %>>직접사용</option>
								<option value="3" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> selected="selected" <% } %>>야간및휴일사용</option>
                				</select>
							</td>
						</tr>
						<tr>
							<th scope="col">기타 <font color="red">*</font></th>
							<td scope="col" class="r_line_none">기타</td>
						</tr>
                		<tr>
                			<th scope="col">주소 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                				<input type="text" name="zipCode" maxlength="10" value="<%=util.getStr(dataMap.get("ZIPCODE"))%>" id="zipCode"  class="txt002" title="신청자주소" readonly = "readonly" />
                				<input type="button" id = "deptPostButton" value="찾아보기" class="btn_inp_b_01" onclick = "orgPost()" />
								<input type="text" name="addr1" maxlength="100" value="<%=util.getStr(dataMap.get("ADDR1"))%>" id="addr1"  class="txtbox MAT5" title="신청자주소" readonly="readonly" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">상세주소 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
								<input type="text" name="addr2" maxlength="100" value="<%=util.getStr(dataMap.get("ADDR2"))%>" id="addr2"  class="txtbox" title="신청자주소" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">소속부서/센터 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                				<input type="text" name="deptNm" maxlength="100" value="<%=util.getStr(dataMap.get("DEPT_NM"))%>" id="deptNm"  class="txtbox" title="부서센터" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">신청자 직위 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                			<input type="text" name="corpPosition" maxlength="50" value="<%=util.getStr(dataMap.get("CORP_POSITION"))%>" id="corpPosition"  class="txtbox" title="직위" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">책임자 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                			<input type="text" name="corpResponsibleUser" maxlength="50" value="<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%>" id="corpResponsibleUser"  class="txtbox" title="책임자" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">이용희망시작일 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                				<%=util.getStr(dataMap.get("USE_ST_DT"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">이용희망종료일 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                			<%=util.getStr(dataMap.get("USE_ED_DT"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">실사용시작일</th>
                			<td scope="col" class="r_line_none">
                			<input type="text" class="inp_text" name="realUseStDt" id="realUseStDt" value="<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>" maxlength="15"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">실사용종료일</th>
                			<td scope="col" class="r_line_none">
                			<input type="text" class="inp_text" name="realUseEdDt" id="realUseEdDt" value="<%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>" maxlength="15"/>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">접수일</th>
                			<td scope="col" class="r_line_none">
                			<%=util.getStr(dataMap.get("ORDER_DT"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">이용목적 <font color="red">*</font></th>
                			<td scope="col" class="r_line_none">
                			<input type="text" name="usePurpose" maxlength="150" value="<%=util.getStr(dataMap.get("USE_PURPOSE"))%>" id="usePurpose"  class="txtbox" title="부서센터" />
                			</td>
                		</tr>
                		<tr>
                			<th scope="col">시료명 <font color="red">*</font></th>
                			<td scope="col" id="sampleBox" class="r_line_none">
		                			<%
	                					for(int i = 1 ; i < sampleNmArr.length ; i++ ){
		                			%>
										<div id="sampleItem<%=i%>" class="itemBox">
										
											<% if( i == 1 ){ %>
												<button class="b_btn_00401" type="button" onclick="sampleBox('p');" title="시료항목 추가"><img src="/img/board/btn_plus.gif"/></button>
												<button class="b_btn_00401" type="button" onclick="sampleBox('m');" title="시료항목 감소"><img src="/img/board/btn_del.gif"/></button>
											<% } %>
										
											<label>시료명</label>
											
											<input type="text" class="MAT5" name="sampleNm" id="sampleNm<%=i%>" value="<%=sampleNmArr[i]%>" maxlength="20" />
											
											<label>시료수</label>
											
											<input type="text" class="txt003 MAT5" name="sampleNo" id="sampleNo<%=i%>" value="<%=sampleNoArr[i]%>" maxlength="2" />
											
										</div>
									<% } %>
							</td>
                		</tr>
                		<tr>
                			<th scope="col">특기사항 <font color="red">*</font></th>
                			<td scope="col" colspan="3" class="r_line_none">
                			<textarea id="sampleMatter" name="sampleMatter" rows="5" cols="20" style="width:100%;"><%=util.getStr(dataMap.get("SAMPLE_MATTER"))%></textarea>
                			</td>
                		</tr>
                		
                	</tbody>
                </table>


	        <!-- bo_btn  -->
	        	<div class="MPBtnWrap MAT10">
		        	<input type="button" class="btn_inp_b_01" value="수정완료" id="btn_submit" onclick="reservationGo()" />
		        	<a href="./equorder.do?siteId=mjeinet" class="btn_inp_w_01">취소</a>
	        	</div>
	        <!--// bo_btn -->

        	</div>
      </form>