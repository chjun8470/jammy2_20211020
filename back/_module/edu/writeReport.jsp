<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>

<!DOCTYPE html>
<html lang="ko" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>전남과학기술센터</title>

		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_3.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/contents.css" /> -->

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_2.css" /> -->
		<link href="/css/cms/sub.css" media="all" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>

		<script type="text/javascript" src="/js/board.js"></script>
		<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js"></script>

		<!--그래프  -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-3d.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>

		<!-- 날짜 선택 위젯 jQuery datepicker S -->
		<!-- jQuery UI CSS파일 -->
		<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
		<!-- jQuery UI 라이브러리 js파일 -->
		<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>
		<!-- 날짜 선택 위젯 jQuery datepicker E -->

		<script src="/js/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="/js/amcharts/serial.js" type="text/javascript"></script>
	</head>
<body>

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

	if($('#mbNm').val() == ''){
		alert("모둘명을 입력 해주세요");
		$('#mbNm').focus();
		return false;
	}
	if($('#mbUrl').val() == ''){
		alert("주소를 입력해주세요");
		$('#mbUrl').focus();
		return false;
	}
	if($('#pageCd').val() == ''){
		alert("관리자페이지 코드를 입력해주세요");
		$('#pageCd').focus();
		return false;
	}
	if($('#mbNote').val() == ''){
		alert("노트를 입력해주세요");
		$('#mbNote').focus();
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
	  <form name="fwrite" id="fwrite" action="./equOperDiaryProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

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
				<td scope="col"><input type="text" class="inp_text" class="inp_text" name="eqNm" id="eqNm" value="<%=util.getStr(dataMap.get("KOR_NM")) %>" /></td>
				<th scope="col">고정자산번호</th>
				<td scope="col"><input type="text" class="inp_text" class="inp_text" name="eqserial" id="eqserial" value="<%=util.getStr(dataMap.get("FIXED_ASET_NO")) %>" /></td>
			</tr>
			<tr>
				<th scope="col">책임자</th>
				<td colspan="3"><input type="text" class="inp_text" class="inp_text" name="rspnber" id="rspnber" value="<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER")) %>" /></td>
			</tr>
			<tr>
				<th scope="col">사용일시</th>
				<td colspan="3">
					<input type="text" class="inp_text"  class="inp_text" name="useDate1" id="useDate1" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ST_DT")))) { %> <%=util.getStr(dataMap.get("USE_ST_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ST_DT")) %> <% } %>"/>
					<input type="text" class="inp_text"  class="inp_text" name="useTime1" id="useTime2"/> ~
					<input type="text" class="inp_text"  class="inp_text" name="useDate2" id="useDate2"/>
					<input type="text" class="inp_text"  class="inp_text" name="useTime2" id="useTime2"/>
				</td>
			</tr>

			<tr>
				<th scope="col">사용기관</th>
				<td colspan="3">
					<label for="institutionSe">구분 : </label>
					<select class="select" name="institutionSe" id="institutionSe" style="height:24px;">
						<option value="01">기관  내 동일부서</option>
						<option value="02">기관 내 타부서</option>
						<option value="03">외부기관</option>
					</select>
					<label for="institutionNm">기관명 : </label><input type="text" class="inp_text" name="institutionNm" id="institutionNm" />
					<label for="depNm">부서명 : </label><input type="text" class="inp_text" name="deptNm" id="deptNm" />
				</td>
			</tr>
			<tr>
				<th scope="col">사용자</th>
				<td scope="col"><input type="text" class="inp_text" name="userNm" id="userNm" /></td>
				<th scope="col">연락처</th>
				<td scope="col"><input type="text" class="inp_text" name="phone" id="phone" /></td>
			</tr>
			<tr>
				<th scope="col">사용목적</th>
				<td colspan="3"><input type="text" class="inp_text" name="purpose" id="purpose" /></td>
			</tr>
			<tr>
				<th scope="col">시료종수</th>
				<td colspan="3"><input type="text" class="inp_text" name="sampleCnt" id="sampleCnt" />건</td>
			</tr>
			<tr>
				<th scope="col">사용료</th>
				<td>
					<input type="text" class="inp_text" name="rentalFee" id="rentalFee" />원
				</td>
			</tr>
			<tr>
				<th scope="col"><label for="useNote">사용내용</label></th>
				<td colspan="3">
					<textarea class="inp_text" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
					<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
				</td>
			</tr>
			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="submit" class="btn_inp_b_01" value="등록완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>

</body>
</html>
