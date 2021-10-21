<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page
	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
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
	ArrayList<HashMap<String, String>> applyFav = request.getAttribute("applyFav") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("applyFav");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String siteId = util.getStr(paramMap.get("siteId"));
	
%>
<script type="text/javascript">
//<![CDATA[
var equ_cnt = <%=applyFav.size()%>;
var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

	//이용희망시간 달력
 	$(document).ready(function(){
 		$( "input:text[name='useStDt']" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    minDate: 0,
		    onClose: function( selectedDate ) {
		    	$("#useEdDt"+$(this).attr('id').replace('useStDt','')).datepicker( "option", "minDate", selectedDate );
            }
		  });
		  $( "input:text[name='useEdDt']" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    minDate: 0
		  });

		  $('#userType1').attr('checked', 'checked');
		
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

	function pageListGo(){
		$('#mode').val('list');
		$('#fwrite').submit();
	}

	function reservationGo(){ //submit
		$('#mode').val('writeSubmit');
		
		if(checkSpace("deptNm") == ''){
			alert("소속부서/센터를 입력해주세요");
			$('#deptNm').focus();
			return false;
		}
		if(checkSpace("corpPosition") == ''){
			alert("신청자 직책를 입력해주세요");
			$('#corpPosition').focus();
			return false;
		}
		if(checkSpace("corpResponsibleUser") == ''){
			alert("책임자를 입력해주세요");
			$('#corpResponsibleUser').focus();
			return false;
		}
		if($('#phone').val() == ''  || $("#phone").val()=="" ){
			alert("핸드폰을 입력해주세요");
			$('#phone').focus();
			return false;
		}else if(!telPattern.test($('#phone').val())){
			alert("전화번호 : 양식에 맞게 입력해주세요.\n(ex:010-0000-0000)");
		}
		if(checkSpace("zipCode") == ''){
			alert("주소를 입력해주세요");
			$('#zipCode').focus();
			return false;
		}
		if(checkSpace("addr1") == ''){
			alert("주소를 입력해주세요");
			$('#addr1').focus();
			return false;
		}
		if(checkSpace("addr2") == ''){
			alert("주소를 입력해주세요");
			$('#addr2').focus();
			return false;
		}
  
		for(var i=1; i < equ_cnt+1; i++){

			if($('#useStDt'+i).val() == "" || $('#useStDt'+i).val() == null){
				alert("이용희망기간 시작일(년/월/일)을 입력해주세요.");
				$('#useStDt'+i).focus();
				return false;
			};

			if($('#useEdDt'+i).val() == "" || $('#useEdDt'+i).val() == null){
				alert("이용희망기간 종료일(년/월/일)을 입력해주세요.");
				$('#useEdDt'+i).focus();
				return false;
			};

			for(var j=1; j < sample_cnt[i-1]+1; j++){
				if(checkSpace('sampleNm'+i+'_'+j) == ''  || $('#sampleNm'+i+'_'+j).val() == null){
					alert("시료명을 입력해주세요");
					$('#sampleNm'+i+'_'+j).focus();
					return false;
				}
				if(checkSpace('sampleNo'+i+'_'+j) == '' || $('#sampleNo'+i+'_'+j).val() == null){
					alert("시료수를 입력해주세요");
					$('#sampleNo'+i+'_'+j).focus();
					return false;
				}else if(isNaN($('#sampleNo'+i+'_'+j).val())){
					alert("시료수는 숫자만 입력해주세요.");
					$('#sampleNo'+i+'_'+j).focus();
					return false;
				};
				 
			}

		}
 
		var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
		$('#userType').val(userTypeCheck);

		$('#fwrite').submit();

	}
	//공백제거
	function checkSpace(id){
		var str = $('#'+id).val();
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
	
	var sample_cnt = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
	function sampleBox( state, equcnt ){
		if( state == 'p' ){
			if( sample_cnt[equcnt-1] < 10){
			sample_cnt[equcnt-1]++;
				var sampleHtml = "<div id='sampleItem"+ equcnt + "_" + sample_cnt[equcnt-1] +"' class='itemBox'>";
				sampleHtml += "<div class='mp_itemL'><label>" + sample_cnt[equcnt-1] +".시료명 : </label><input type='text' class='inp_txt' name='sampleNm"+(equcnt)+"' id='sampleNm"+(equcnt)+"_"+(sample_cnt[equcnt-1])+"' value='' size='30'/></div>";
				sampleHtml += "<div class='mp_itemR'><label>" + sample_cnt[equcnt-1] +".시료수 : </label><input type='text' class='inp_txt' name='sampleNo"+(equcnt)+"' id='sampleNo"+(equcnt)+"_"+(sample_cnt[equcnt-1])+"' value='' size='10'/></div>";
				sampleHtml += "</div>";
				$( '#sampleBox' + equcnt).append(sampleHtml).trigger("create");
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( sample_cnt[equcnt-1] > 1){
				$( '#sampleItem' + equcnt + "_" +sample_cnt[equcnt-1] ).remove();
				sample_cnt[equcnt-1]--;
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");
			}
		}
	};
//]]>
</script>

<form name="fwrite" id="fwrite" action="./myfav.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>"/>
	<input type="hidden" name="reUrl" id="reUrl" value="?siteId=<%=siteId%>"/>
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>"/>
	<input type="hidden" name="userIdx" id="userIdx" value="<%=loginVO.getUserIdx()%>"/>
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>"/>
	<input type="hidden" name="rndEquIdx" id="rndEquIdx" value="<%=util.getStr(paramMap.get("rndEquIdx"))%>"/>


	<div class="MPTit MPTit02">장비예약</div>
	
	<div class="MPTit">공통입력사항</div>
	
	<div class="essentialInfo MAT5">
		<font color="red" font-size="12px"><b> * 필수입력 사항 입니다 </b></font>
	</div>
	
	<div class="basic_writeWrap MAT10">
	
		<table class="skin_write01">
		
			<colgroup>
				<col style="width: 20%;"/>
				<col style="width: 80%;"/>
			</colgroup>
			
			<tbody>
	
				<tr>
					<th scope="col" class="">신청자명 <font color="red">*</font></th>
					<td class="r_line_none">
						<%=util.getStr(userMap.get("PSN_NM"))%> (<%=util.getStr(userMap.get("EMAIL"))%>
						/ <%=util.getStr(userMap.get("CP_NO"))%>)
					</td>
				</tr>
		
				<tr>
					<th scope="col">소속기관 <font color="red">*</font></th>
					<td class="r_line_none">
						<%=util.getStr(userMap.get("ORG_GRP_NM"))%><!-- 예)전남테크노파크 전남과학기술진흥센터 -->
					</td>
				</tr>
				
				<tr>
					<th scope="col">소속부서/센터 <font color="red">*</font></th>
					<td class="r_line_none">
						<input type="text" class="" name="deptNm" id="deptNm" value="<%=util.getStr(userMap.get("DEPT_NM"))%>"/>
					</td>
				</tr>
				
				<tr>
					<th scope="col">신청자 직책 <font color="red">*</font></th>
					<td class="r_line_none">
						<input type="text" class="" name="corpPosition"	id="corpPosition" value="<%=util.getStr(userMap.get("POSITION_NM"))%>"/>
					</td>
				</tr>
				
				<tr>
					<th scope="col">책임자 <font color="red">*</font></th>
					<td class="r_line_none">
						<input type="text" class=""	name="corpResponsibleUser" id="corpResponsibleUser"	value="<%=util.getStr(userMap.get("ORNER_NM"))%>"/>
					</td>
				</tr>
				
				<tr>
					<th scope="col">연락처 <font color="red">*</font></th>
					<td class="r_line_none">
						<input type="text" class="" name="phone" id="phone" value="<%=util.getStr(userMap.get("CP_NO"))%>"/>
						<div class="MAT5">* ex) 010-0123-4567</div>
					</td>
				</tr>
				
				<tr>
					<th scope="col">주소 <font color="red">*</font></th>
					<td class="r_line_none">
						<input type="text" class="txt003" name="zipCode" maxlength="10" value="<%=util.getStr(userMap.get("ZIPCODE"))%>" id="zipCode" title="신청자주소" readonly="readonly" />
						<input type="text" class="txt003"	name="addr1" maxlength="100" value="<%=util.getStr(userMap.get("ORG_ADDR1"))%>" id="addr1" title="신청자주소" readonly="readonly" />
						<input type="button" id="deptPostButton" value="찾아보기"	class="btn_inp_w_01" onclick="orgPost()" />
						<input type="text" class="MAT5" name="addr2" maxlength="100" value="<%=util.getStr(userMap.get("ORG_ADDR2"))%>" id="addr2" title="신청자주소"/>
					</td>
				</tr>
		
				<tr>
					<th scope="col"><font color="red">*</font> 구분</th>
					<td class="r_line_none">
						<input type="hidden" id="userType" name="userType" value=""/>
						<input type="radio" id="userType1" name="userTypeCheck" value="A"/>사업자
						&nbsp;&nbsp;&nbsp;
						<input type="radio" id="userType2" name="userTypeCheck" value="B"/>비사업자
					</td>
				</tr>
				
			</tbody>
			
		</table>
	
	<!-- 신청자 정보 -->
	
	<%
	int cnt = 1;
	%>
	<%
	for (HashMap rs : applyFav) {
	%>
	
	<div class="MPTit MAT20"><%=util.getStr(rs.get("KOR_NM"))%> 장비입력 사항</div>
	
	<div class="essentialInfo MAT5">
		<font color="red" font-size="12px"><b> * 필수입력 사항 입니다 </b></font>
	</div>
	
	<div class="basic_writeWrap MAT10">
	
		<table class="skin_write01">
		
			<colgroup>
				<col style="width: 13%;"/>
				<col style="width: 19%;"/>
				<col style="width: 13%;"/>
				<col style="width: 19%;"/>
				<col style="width: 13%;"/>
				<col style="width: *%;"/>
			</colgroup>
		
			<input type="hidden" name="arrRndEquIdx" id="arrRndEquIdx" value="<%=util.getStr(rs.get("RND_EQU_IDX"))%>"/>
			
			<tr>
				<th scope="col" class="">장비명</th>
				<td scope="col" class="r_line_none" colspan="5"><%=util.getStr(rs.get("KOR_NM"))%></td>
			</tr>
			<tr>
				<th scope="col">JEINET 등록번호</th>
				<td scope="col"><%=util.getStr(rs.get("RND_EQU_IDX"))%></td>
				<th scope="col">Zeus 등록번호</th>
				<td scope="col"><%=util.getStr(rs.get("NTIS_EQUIP_INFO")).equals("") ? "NTIS 미등록장비": util.getStr(rs.get("NTIS_EQUIP_INFO"))%></td>
				<th scope="col">e-tube 등록번호</th>
				<td scope="col"><%=util.getStr(rs.get("ETUBE_EQUIP_INFO")).equals("") ? "e-tube 미등록장비": util.getStr(rs.get("ETUBE_EQUIP_INFO"))%></td>
			</tr>
			<tr>
				<th scope="col">이용희망기간 <font color="red">*</font></th>
				<td class="r_line_none" colspan="5">
					<input type="text" class="txt004" name="useStDt" id="useStDt<%=cnt%>" readonly="readonly" value=""/> 
					<div class="btw">~</div> 
					<input type="text" class="txt004" name="useEdDt" id="useEdDt<%=cnt%>" readonly="readonly" value=""/>
					<div class="MAT5">* 이용희망기간은 실제 이용기간과 다를수 있습니다. 담당자가 접수처리시 실제 이용기간을 확정하게 됩니다.</div>
				</td>
			</tr>
			
			<tr>
				<th scope="col">사용구분 <font color="red">*</font></th>
				<td class="r_line_none" colspan="5">
					<select name="useMean" id="useMean<%=cnt%>" class="h30">
						<option value="1">분석시험의뢰</option>
						<option value="2">이용자직접사용</option>
						<option value="3">야간및휴일사용</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th scope="col">이용목적</th>
				<td class="r_line_none" colspan="5">
					<input type="text" class="" name="usePurpose" id="usePurpose<%=cnt%>" value=""/>
				</td>
			</tr>
			
			<tr>
				<th scope="col">시료정보 <font color="red">*</font></th>
				<td class="r_line_none" id="sampleBox<%=cnt%>" colspan="5">
					<button class="b_btn_00401" type="button" onclick="sampleBox('p',<%=cnt%>);" title="시료항목 추가"><img src="/img/board/btn_plus.gif"/></button>
					<button class="b_btn_00401" type="button" onclick="sampleBox('m',<%=cnt%>);" title="시료항목 감소"><img src="/img/board/btn_del.gif" /></button>
					<div id="sampleItem<%=cnt%>_1" class="itemBox">
					
						
						<div class="mp_itemL">
							<label>1.시료명 : </label>
							<input type="text" class="MAT5"	name="sampleNm<%=cnt%>" id="sampleNm<%=cnt%>_1" value="" maxlength="20"/>
						</div>
						<div class="mp_itemR">
							<label>1.시료수 : </label>
							<input type="text" class="MAT5" name="sampleNo<%=cnt%>" id="sampleNo<%=cnt%>_1" value="" maxlength="2"/>
						</div>
					</div>
				</td>
			</tr>
		
			<tr>
				<th scope="col">특기사항</th>
				<td class="r_line_none" colspan="5">
					<textarea id="contents" name="sampleMatter" rows="5" cols="100"></textarea>
					<div class="MAT5">* 시험항목 및 예상치, 분석조건/시료특성/분석방법/분석성분/사용용매/결과회신방법 등</div>
				</td>
			</tr>
		</table>
	
	</div>
	
	<%
	cnt++;
	}
	%>
	
	<!-- bo_btn  -->
		<div class="MPBtnWrap MAT10">
			<button class="btn_inp_b_01" type="button" onclick="reservationGo()">신청하기</button>
			<button class="btn_inp_w_01" type="button" onclick="pageListGo()">취소</button>
		</div>
	<!--// bo_btn -->
	
	</div>
	
</form>

