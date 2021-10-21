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
	  <form name="fwrite" id="fwrite" action="./moduleProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
			<table class="skin_basic_write">

			<!-- colgroup s -->

			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 80%;" />
			</colgroup>

			<!-- colgroup e -->

			<tr>
				<th scope="col"><label for="mbNm">모듈명</label></th>
				<td scope="col"><input type="text" class="inp_text" name="mbNm" id="mbNm" value="" size="50"/></td>
			</tr>
			<tr>
				<th scope="col"><label for="mbUrl">주소(URL)</label></th>
				<td><input type="text" class="inp_text" name="mbUrl" id="mbUrl" value="" size="50"/></td>
			</tr>
			<tr>
				<th scope="col"><label for="pageCd">관리자페이지 코드</label></th>
				<td><input type="text"  class="inp_text" name="pageCd" id="pageCd" size="50"/></td>
			</tr>
			<tr>
				<th scope="col"><label for="mbNote">모듈정보</label></th>
				<td>
					<textarea class="inp_text" name="mbNote" id="mbNote" cols="110" style="height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
					<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
				</td>
			</tr>
			<tr>
				<th scope="col"><label for="auth">권한</label></th>
				<td>
					<input type="checkbox" name="authList" id="authList" value="Y"/><label for="authList">리스트</label>
					<input type="checkbox" name="authWrite" id="authWrite" value="Y" /><label for="authWrite">등록</label>
					<input type="checkbox" name="authEdit" id="authEdit" value="Y" /><label for="authEdit">수정</label>
					<input type="checkbox" name="authDel" id="authDel" value="Y" /><label for="authDel">삭제</label>
					<input type="checkbox" name="authCmt" id="authCmt" value="Y" /><label for="authCmt">코멘트</label>
					<input type="checkbox" name="authReply" id="authReply" value="Y" /><label for="authReply">답변</label>
				</td>
			</tr>
			<tr>
				<th scope="col"><label for="useYN">사용여부</label></th>
				<td>
					<input type="radio" name="useYN" id="useY" value="Y" checked="checked" /><label for="useY">Y</label>
					<input type="radio" name="useYN" id="useN" value="N"/><label for="useN">N</label>
				</td>
			</tr>

			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="submit" class="btn_inp_b_01" value="등록" id="btn_submit"  class="btn_submit" style="cursor: pointer;" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>


