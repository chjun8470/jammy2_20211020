<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));

%>
<script type="text/javascript">

$(document).on("keyup",".numberOnly",function(){
	if (!(event.keyCode >=37 && event.keyCode<=40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9;]/gi,''));
    }
});

$("input:text[numberOnlyDot]").on("keyup", function() {
    $(this).val($(this).val().replace(/^[^0-9]|[^0-9\\.]|[\.]+[^0-9]|[0-9].[0-9]+[\D]/g,""));
});

$(document).on("change","#orgSe",function(){
	var selectVal = $(this).val();
	
	var equUserOrg = $("#equUserOrg").val();
	var equUserDept = $("#equUserDept").val();
	
	if(selectVal == "01"){
		$("#orgNm").val(equUserOrg);
		$("#deptNm").val(equUserDept);		
	}else if(selectVal == "02"){
		$("#orgNm").val(equUserOrg);
		$("#deptNm").val("");	
	}else{
		$("#orgNm").val("");
		$("#deptNm").val("");	
	}
});



$(document).ready(function() {
	
	
	
	$(function() {
	    $("input:text").keydown(function(evt) {
	        if (evt.keyCode == 13)
	            return false;
	    });
	});

	$('.innerUseTime').blur(function() {
		var useTimeA = parseFloat($('#innerUseTimeA').val());
		var useTimeB = parseFloat($('#innerUseTimeB').val());
		var useTimeC = parseFloat($('#innerUseTimeC').val());
		var useTime = useTimeA+useTimeB+useTimeC;
		$('#innerUseTime').val(useTime.toFixed(1))
	});

	$("#innerStartDate, #innerEndDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		nextText : '?????? ???',
		prevText : '?????? ???',
		currentText : '?????? ??????',
		closeText : '??????',
		dateFormat : "yy-mm-dd",
		dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		dayNamesMin : ['???','???','???','???','???','???','???'],
		monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
		//minDate: 0
	});

	$('#innerStartDate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#innerEndDate").datepicker( "option", "minDate", selectedDate );
    });

	$('#innerEndDate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#innerStartDate").datepicker( "option", "maxDate", selectedDate );
    });

	$("#sampleCnt, #rentalFee").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });
});

	function submitGo(mode){
		var sampleCnt = $('#innerSampleBox > div').size();

		if($('#equUserIdx').val() == "" || $('#equUserIdx').val() == null){
			alert("???????????? ??????????????????.");
			$('#searchUser').focus();
			return false;
		};

		if($('#equIdx').val() == "" || $('#equIdx').val() == null){
			alert("????????? ??????????????????.");
			$('#searchEqu').focus();
			return false;
		};

		if($('#innerStartDate').val() == '' || $('#innerStartDate').val() == null){
			alert("???????????? ????????? ??????????????????.");
			$('#innerStartDate').focus();
			return false;
		}

		if($('#innerEndDate').val() == '' || $('#innerEndDate').val() == null){
			alert("???????????? ????????? ??????????????????.");
			$('#innerEndDate').focus();
			return false;
		}

		if($('#innerUseTimeA').val() == ''){
			alert("??????????????? ??????????????????.");
			$('#innerUseTimeA').focus();
			return false;
		}
		if($('#innerUseTimeB').val() == ''){
			alert("??????????????? ??????????????????.");
			$('#innerUseTimeB').focus();
			return false;
		}
		if($('#innerUseTimeC').val() == ''){
			alert("??????????????? ??????????????????.");
			$('#innerUseTimeC').focus();
			return false;
		}
		if($('#innerUseTime').val() == ''){
			alert("??????????????? ??????????????????.");
			$('#innerUseTime').focus();
			return false;
		}

		for(i=1; i < sampleCnt+1; i++){
			if(checkSpace('innerSampleNm'+i) == ''  || $('#innerSampleNm'+i).val() == null){
				alert("???????????? ??????????????????.");
				$('#innerSampleNm'+i).focus();
				return false;
			}
			if(checkSpace('innerSampleNo'+i) == '' || $('#innerSampleNo'+i).val() == null){
				alert("???????????? ??????????????????.");
				$('#innerSampleNo'+i).focus();
				return false;
			}else if(isNaN($('#innerSampleNo'+i).val())){
				alert("???????????? ????????? ??????????????????.");
				$('#innerSampleNo'+i).focus();
				return false;
			};
		}

		if($('#innerUseNote').val() == '' || $('#innerUseNote').val() == null){
			alert("???????????? ????????? ??????????????????.");
			$('#useNote').focus();
			return false;
		}

		$('#fwrite').submit();
	}




	//?????? ??????, ???????????? ?????????
	function innerSampleBox( state ){
		var innerSample_cnt = $('#innerSampleBox > div').length;

		if(innerSample_cnt < 1){
			innerSample_cnt = 1;
		}
		if( state == 'p' ){
			if( innerSample_cnt < 10){
				innerSample_cnt++;
				var sampleHtml = "<div id='innerSampleItem"+(innerSample_cnt)+"' >";
				sampleHtml += "<label>"+(innerSample_cnt)+". ????????? : </label><input type='text' class='inp_txt' name='innerSampleNm' id='innerSampleNm"+(innerSample_cnt)+"' value='' size='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>"+(innerSample_cnt)+". ????????? : </label><input type='text' class='inp_txt numberOnly' name='innerSampleNo' id='innerSampleNo"+(innerSample_cnt)+"' value='' size='2'/>";
				sampleHtml += "</div>";
				$( '#innerSampleCnt').val(innerSample_cnt);
				$( '#innerSampleBox' ).append(sampleHtml);
			}else{
				alert("?????? 10?????? ?????? ????????? ??????????????? ????????????.");
			}
		}else{
			if( innerSample_cnt > 1){
				$( '#innerSampleItem'+innerSample_cnt ).remove();
				innerSample_cnt--;
				$( '#innerSampleCnt').val(innerSample_cnt);
			}else{
				alert("?????? 1?????? ?????? ????????? ??????????????? ?????????.");
			}
		}
	};

  	function popupWindow(mode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/eqReservation.do?mode="+mode;
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,mode+"popup",popOption);
	}

  	function popupWindowTest(mode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/equOperInner.do?mode="+mode;
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);
	}

	function setPopup(obj){
		if(obj['pop_mode'] == "equ") {
			var ntisNo = obj['ntis_no'];
			if(obj['ntis_no'] == ""){
				ntisNo = "NTIS ????????? ??????"
			}

			var etubeNo = obj['etube_no'];
			if(obj['etube_no'] == ""){
				etubeNo = "e-Tube ????????? ??????"
			}

			$("#eqNm").text(obj['equ_nm']);
			$("#equIdx").val(obj['rnd_equ_idx']);

			$("#jeinetNo").text(obj['rnd_equ_idx']);
			$("#ntisNo").text(ntisNo);
			$("#etubeNo").text(etubeNo);
			$("#orgName").text(obj['org_nm']);
			
			$("#equUserIdx").val(obj['equ_user_idx']);
			$("#equUserOrg").val(obj['org_grp_nm']);
			$("#equUserDept").val(obj['org_sub_nm']);
			$("#equUserName").val(obj['psn_nm']);
			$("#equUserPosition").val(obj['oper_position']);
			$("#equUserPhone").val(obj['oper_tel']);
			$("#equUserEmail").val(obj['oper_email']);
			
		} else if(obj['pop_mode'] == "subUserPop") {
			$("#equUserIdx").val(obj['user_idx']);
			$("#equUserOrg").val(obj['org_grp_nm']);
			$("#equUserDept").val(obj['dept_nm']);
			$("#equUserName").val(obj['user_nm']);
			$("#equUserPosition").val(obj['position_nm']);
			$("#equUserPhone").val(obj['cp_no']);
			$("#equUserEmail").val(obj['email']);
			$("#orgNm").val(obj['org_grp_nm']);
			$("#deptNm").val(obj['dept_nm']);
			
		} else if(obj['pop_mode'] == "org") {
			$("#orgCd").val(obj['org_grp_cd']);
			$("#orgNm").val(obj['org_grp_nm']);
		}
	}

	//????????????
	function checkSpace(id){
		var str = $('#'+id).val();
		if(str.search(/\s/) != -1){
			$('#'+id).val(str.trim());
			//$('#'+id).val(str.replace(/ /g, ""));
		}
		return $('#'+id).val();
	}

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
		     rbyte += 2;                                         //??????2Byte
		 }else{
		     rbyte++;                                            //?????? ??? ????????? 1Byte
		 }

		 if(rbyte <= maxByte){
		     rlen = i+1;                                          //return??? ????????? ??????
		 }
		 }

		 if(rbyte > maxByte){
		     alert("?????? "+(maxByte/2)+"??? / ?????? "+maxByte+"?????? ?????? ????????? ??? ????????????.");
		     str2 = str.substr(0,rlen);                                  //????????? ?????????
		     obj.value = str2;
		     bytecheck(obj, maxByte);
		 }else{
		     document.getElementById('byteInfo').innerText = rbyte;
		 }
	};


</script>
	  <form name="fwrite" id="fwrite" action="./equOperInnerProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
	  	<!-- <input type="hidden" name="startTime" id="startTime"  value="" />
	  	<input type="hidden" name="endTime" id="endTime"  value="" /> -->
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

			<h3>??????????????? ??????</h3>
				<table id="step1"  class="skin_basic_write">
			        <colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tbody>
						<tr>
							<!-- <th colspan="4">????????? ??????<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop', 'inner')" value="????????? ??????"></th> -->
							<th colspan="4">????????? ??????<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop')" value="????????? ??????"></th>
							<input type="hidden" class="inp_txt" name="equUserIdx" id="equUserIdx" />
						</tr>
						<tr>
							<th scope="col">??????</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserOrg" id="equUserOrg" readonly="readonly"/>
							</td>
							<th scope="col">??????</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserDept" id="equUserDept" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="col">?????????</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserName" id="equUserName" readonly="readonly"/>
							</td>
							<th scope="col">??????</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserPosition" id="equUserPosition" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="col">????????????</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserPhone" id="equUserPhone" readonly="readonly"/>
							</td>
							<th scope="col">?????????</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserEmail" id="equUserEmail" readonly="readonly"/>
							</td>
						</tr>
					</tbody>
				</table>

				<h3>?????? ???????????? ??????</h3>
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
					</colgroup>
					<tr>
						<th scope="col">?????????</th>
						<td scope="col" colspan="3">
							<input type="hidden" name="equIdx" id="equIdx" />
							<span id="eqNm"></span>
							<!-- <input type="button" id="searchEqu1" class="btn_inp_b_01" onclick="popupWindow('equPop','1')" value="????????????" /> -->
							<button type="button" class="btn_inp_b_01" id="searchEqu" onclick="popupWindow('equPop')">????????????</button>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????</th>
						<td scope="col">
							JEINET ???????????? : <span id="jeinetNo"></span>
						</td>
						<td scope="col">
							Zeus ???????????? : <span id="ntisNo"></span>
						</td>
						<td scope="col">
							e-Tube ???????????? : <span id="etubeNo"></span>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????</th>
						<td scope="col" colspan="3">
							<span id="orgName"></span>
						</td>
					</tr>
					<tr>
						<th scope="col">????????????</th>
						<td colspan="3">
							<label for="orgSe">?????? : </label>
							<select name="orgSe" id="orgSe" class="select" >
								<option value="01">??????  ??? ????????????</option>
								<option value="02">?????? ??? ?????????</option>
								<option value="03">????????????</option>
							</select>
							<label for="orgNm">????????? : </label><input type="hidden" name="orgCd" id="orgCd" /><input type="text" class="inp_txt" name="orgNm" id="orgNm" readonly="readonly"/>
							<button type="button" class="btn_inp_b_01" onclick="popupWindowTest('orgPop')">??????</button>
							<label for="depNm">????????? : </label><input type="text" class="inp_txt" name="deptNm" id="deptNm" />
						</td>
					</tr>
					<tr>
						<th scope="col">?????????</th>
						<td scope="col"><input type="text" class="inp_txt" name="userNm" id="userNm" /></td>
						<th scope="col">?????????</th>
						<td scope="col"><input type="text" class="inp_txt" name="phone" id="phone" /></td>
					</tr>
					<tr>
						<th scope="col"> ????????????</th>
						<td scope="col" colspan="3">
							<input type="text" class="inp_txt" name="purpose" id="purpose" value="" size="70"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> ??????????????????</th>
						<td colspan="3">
							<input type="text"  class="inp_txt" name="startDate" id="innerStartDate" value="" autocomplete="off" title="????????????"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="innerEndDate" value="" autocomplete="off" title="????????????"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> ????????????????????????(A)</th>
						<td colspan="3"><input type="text"  class="inp_txt innerUseTime" name="useTimeA" id="innerUseTimeA"  value="0"  title="????????????" numberOnlyDot />ex)5.6?????? > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> ??????????????? ????????????(B)</th>
						<td colspan="3"><input type="text"  class="inp_txt innerUseTime" name="useTimeB" id="innerUseTimeB"  value="0"  title="????????????" numberOnlyDot />ex)5.6?????? > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> ????????????????????????(C)</th>
						<td colspan="3"><input type="text"  class="inp_txt innerUseTime" name="useTimeC" id="innerUseTimeC"  value="0"  title="????????????" numberOnlyDot />ex)5.6?????? > 5.6</td>
					</tr>
					<tr>
						<th scope="col">??????????????????</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="innerUseTime"  value="0"  title="????????????" readonly />ex)5.6?????? > 5.6</td>
					</tr>

					<tr>
						<th scope="col"><font color="red">*</font> ??????????????????</th>
						<td id="innerSampleBox" colspan="3">
						<input type="hidden" name="innerSampleCnt" id="innerSampleCnt" value="1"/>
							<div id="sampleItem1" >
								<label>1. ????????? : </label><input type="text" class="inp_txt" name="innerSampleNm" id="innerSampleNm1" value="" size="20" />
								&nbsp;<label>1. ????????? : </label><input type="text" class="inp_txt numberOnly" name="innerSampleNo" id="innerSampleNo1" value="" size="2" />
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="innerSampleBox('p');" title="???????????? ??????">+</button>
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="innerSampleBox('m');" title="???????????? ??????">-</button>
							</div>
						</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">?????????(VAT ??????)</th>
						<td><input type="text" class="inp_txt" name="rentalFee" id="innerRentalFee" value="0" />???</td>
					</tr>
					<tr>
						<th scope="col"><label for="useNote"><font color="red">*</font> ??????????????????</label></th>
						<td colspan="3">
							<textarea class="inp_txt" name="useNote" id="innerUseNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
							<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
						</td>
					</tr>
				</table>

	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<input type="button" class="btn_inp_b_01" value="????????????" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="submitGo()" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">??????</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>


