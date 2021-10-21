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

%>
<script type="text/javascript">
	function submitGo(){

	if($('#eqNm').val() == ''){
		alert("장비를 선택 해주세요");
		return false;
	}
	if($('#equUserName').val() == ''){
		alert("담당자를 입력해주세요");
		$('#equUserName').focus();
		return false;
	}
	if($('#startDate').val() == '' || $('endDate').val() == ''){
		alert("사용일시를 입력해주세요");
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
		alert("사용목적을 입력해주세요");
		$('#userNote').focus();
		return false;
	}
	if($('#sampleCnt').val() == ''){
		alert("시료수를 입력해주세요");
		$('#sampleCnt').focus();
		return false;
	}
	if($('#rentalFee').val() == ''){
		alert("사용료를 입력해주세요");
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

		$('#startDate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#endDate").datepicker( "option", "minDate", selectedDate );
	    });

		$('#endDate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#startDate").datepicker( "option", "maxDate", selectedDate );
	    });

		$("#sampleCnt, #rentalFee").keyup(function(event){
	        if (!(event.keyCode >=37 && event.keyCode<=40)) {
	            var inputVal = $(this).val();
	            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
	        }
	    });

	});

	function popupWindow(mode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/equOperDiary.do?mode="+mode;
		var popOption="width=750, height=600, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);

	}

	function setPopup(obj){
		if(obj['pop_mode'] == "equ") {
			$("#eqNm").val(obj['equ_nm']);
			$("#eqserial").val(obj['fixed_aset_no']);
			$("#equIdx").val(obj['rnd_equ_idx']);
			$("#equUserName").val(obj['psn_nm']);
		} else if(obj['pop_mode'] == "org") {
			$("#orgCd").val(obj['org_grp_cd']);
			$("#orgNm").val(obj['org_grp_nm']);
		}
	}
</script>
	  <form name="fedit" id="fedit" action="./equOperDiaryProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOperDiaryIdx" name = "equOperDiaryIdx" value="<%=util.getStr(String.valueOf(dataMap.get("EQU_OPER_DIARY_IDX")))%>"/>

		<div class="skin_bbs_write" style="margin-top:30px">
			<table class="skin_basic_write">

			<!-- colgroup s -->

			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
			</colgroup>

			<!-- colgroup e -->

			<tr>
				<th scope="col">연구시설장비</th>
				<td scope="col">
					<input type="hidden" name="equIdx" id="equIdx" value="<%=util.getStr(String.valueOf(dataMap.get("RND_EQU_IDX"))) %>" />
					<input type="text" class="inp_text" name="eqNm" id="eqNm" readonly="readonly" value="<%=util.getStr(dataMap.get("KOR_NM")) %> (<%=util.getStr(dataMap.get("ENG_NM")) %>)"/>
					<button type="button" id="searchEqu" onclick="popupWindow('equPop')">장비검색</button>
				</td>
				<th scope="col">고정자산번호</th>
				<td scope="col"><input type="text" class="inp_text" name="eqserial" id="eqserial" readonly="readonly" value="<%=util.getStr(dataMap.get("FIXED_ASET_NO")) %>"/></td>
			</tr>
			<tr>
				<th colspan="4">담당자 정보</th>
			</tr>
			<tr>
				<th scope="col">기관</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserOrg" id="equUserOrg" value="<%=util.getStr(dataMap.get("EQU_USER_ORG")) %>" readonly="readonly"/>
				</td>
				<th scope="col">부서</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserDept" id="equUserDept" value="<%=util.getStr(dataMap.get("EQU_USER_DEPT")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="col">담당자</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserName" id="equUserName" value="<%=util.getStr(dataMap.get("EQU_USER_NM")) %>" readonly="readonly"/>
				</td>
				<th scope="col">직위</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserPosition" id="equUserPosition" value="<%=util.getStr(dataMap.get("EQU_USER_POSITION")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="col">전화번호</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserPhone" id="equUserPhone" value="<%=util.getStr(dataMap.get("EQU_USER_PHONE")) %>" readonly="readonly"/>
				</td>
				<th scope="col">이메일</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserEmail" id="equUserEmail" value="<%=util.getStr(dataMap.get("EQU_USER_EMAIL")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th colspan="4">사용정보</th>
			</tr>
			<tr>
				<th scope="col">사용일시</th>
				<td colspan="3">
					<input type="text"  class="inp_text" name="startDate" id="startDate" title="시작날짜" value="<%=util.getStr(String.valueOf(dataMap.get("START_DT"))) %>"/>
					<select title="시작시간" name="startTime" id="startTime">
						<%for(int i = 0; i <= 23; i++) {
							if(i < 10) {%>
								<option value="0<%=i%>" <%if(i == util.getInt(dataMap.get("START_TIME"))) { %> selected="selected" <% } %>>0<%=i%></option>
							<%} else { %>
								<option vlaue="<%=i %>" <%if(i == util.getInt(dataMap.get("START_TIME"))) { %> selected="selected" <% } %>><%=i%></option>
							<%} %>
						<% } %>
					</select> ~
					<input type="text"  class="inp_text" name="endDate" id="endDate" title="종료날짜" value="<%=util.getStr(String.valueOf(dataMap.get("END_DT"))) %>"/>
					<select title="종료시간" name="endTime" id="endTime">
						<%for(int i = 0; i <= 23; i++) {
							if(i < 10) {%>
								<option value="0<%=i%>" <%if(i == util.getInt(dataMap.get("END_TIME"))) { %> selected="selected" <% } %>>0<%=i%></option>
							<%} else { %>
								<option vlaue="<%=i %>" <%if(i == util.getInt(dataMap.get("END_TIME"))) { %> selected="selected" <% } %>><%=i%></option>
							<%} %>
						<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col">사용기관</th>
				<td colspan="3">
					<label for="orgSe">구분 : </label>
					<select name="orgSe" id="orgSe">
						<option value="01" <%if(util.getStr(dataMap.get("ORG_SELECT")) == "01") {%> selected="selected" <%}%>>기관  내 동일부서</option>
						<option value="02" <%if(util.getStr(dataMap.get("ORG_SELECT")) == "02") {%> selected="selected" <%}%>>기관 내 타부서</option>
						<option value="03" <%if(util.getStr(dataMap.get("ORG_SELECT")) == "03") {%> selected="selected" <%}%>>외부기관</option>
					</select>
					<label for="orgNm">기관명 : </label><input type="hidden" name="orgCd" id="orgCd" value="<%=util.getStr(dataMap.get("ORG_GRP_CD")) %>" /><input type="text" class="inp_text" name="orgNm" id="orgNm" readonly="readonly" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>"/>
					<button type="button" onclick="popupWindow('orgPop')">찾기</button>
					<label for="depNm">부서명 : </label><input type="text" class="inp_text" name="deptNm" id="deptNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
				</td>
			</tr>
			<tr>
				<th scope="col">사용자</th>
				<td scope="col"><input type="text" class="inp_text" name="userNm" id="userNm" value="<%=util.getStr(dataMap.get("USE_USER_NM")) %>" /></td>
				<th scope="col">연락처</th>
				<td scope="col"><input type="text" class="inp_text" name="phone" id="phone" value="<%=util.getStr(dataMap.get("USE_USER_PHONE")) %>" /></td>
			</tr>
			<tr>
				<th scope="col">사용목적</th>
				<td colspan="3"><input type="text" class="inp_text" name="purpose" id="purpose" value="<%=util.getStr(dataMap.get("PURPOSE")) %>" /></td>
			</tr>
			<tr>
				<th scope="col"><label for="useNote">사용내용</label></th>
				<td colspan="3">
					<textarea class="inp_text" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;"><%=util.getStr(dataMap.get("USE_NOTE")) %></textarea>
				</td>
			</tr>
			<tr>
				<th scope="col">시료수</th>
				<td colspan="3"><input type="text" class="inp_text" name="sampleCnt" id="sampleCnt" value="<%=util.getStr(String.valueOf(dataMap.get("SAMPLE_CNT"))) %>" />건</td>
			</tr>
			<tr>
				<th scope="col">사용료</th>
				<td>
					<input type="text" class="inp_text" name="rentalFee" id="rentalFee" value="<%=util.getStr(String.valueOf(dataMap.get("RENTAL_FEE"))) %>" />원
				</td>
			</tr>

			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<input type="submit" class="btn_inp_b_01" value="수정" id="btn_submit"  class="btn_submit" style="cursor: pointer;" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>