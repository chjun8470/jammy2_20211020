<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<%
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	siteId = util.getStr(paramMap.get(siteId));
%>

		<script type="text/javascript">
		//<![CDATA[
			var submitFlag = 'N';
			function submitGo(){				
			
				if(submitFlag != 'Y'){
					if($('#pwd').val() == ""){
						alert("비밀 번호를 입력 해주세요");
						return false;
					}else{
						if($('#pwd').val() != $('#rePwd').val()){
							alert("비밀 번호가 일치하지 않습니다.");
							return false;
						}
					}
					
	
					if(confirm("비밀번호를 수정하시겠습니까?")){
						submitFlag = 'Y';
						jQuery.post('./pass_change.do',
							{
								"pwd" : $('#pwd').val(),
								"rePwd" : $('#rePwd').val(),
								"passCheck" : $('#passCheck').val()
							},
							function(data){
								var successCode = data.successCode;
		
								if(successCode == "OK"){
										alert("비밀번호 수정이 성공하였습니다.");
										location.href ="./home.do?siteId=mjeinet";
									
								}else if(successCode == "IDX_MISS"){
									alert("비밀번호가 틀립니다.");
									submitFlag = 'N';
								}else{
									alert("비밀번호 수정이 실패하였습니다.");
									submitFlag = 'N';
								}
							}
						);
					}
				}else{
					alert("처리 중입니다.");					
				}
				return false;
			}

			$(document).ready(function(){

				$('#pwd').change(function(){
					var value = $('#pwd').val();
					var pattern = /^[a-zA-z0-9]{8,20}$/;
					var match = pattern.exec(value);

					if(match == null || value.length < 8 || value.length > 20){
						alert("영문자, 숫자 8자이상 20자 이내 입력해야 합니다.");
						$('#pwd').val('').focus();
						return;
					};
				});

				/* $('#rePwd').change(function(){
					if($('#pwd').val() == $('#rePwd').val()){
						$('#pwd_signed').html('비밀 번호가 일치합니다.').css('color','black');
					}else if($('#pwd').val() != $('#rePwd').val()){
						$('#pwd_signed').html('비밀 번호가 일치하지 않습니다.').css('color','red');
					}else{
						$('#pwd_signed').html('');
					}
				}); */
})
	//]]>
		</script>

	
	<div class="MPTit">비밀번호 변경</div>
	
	 <form name="fwrite" id="fwrite" action="./main.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="myPage" id="myPage"  value="<%=myPage%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
	  	<input type="hidden" name="siteId" id="siteId"  value="<%=siteId%>" />
			
			<div class="basic_writeWrap">
				<table class="skin_write01">
					<caption>비밀번호변경</caption>
					<colgroup>
						<col style="width:30%" />
						<col style="width:70%" />
					</colgroup>
					<tr>
						<th class="th">현재 비밀번호</th>
						<td class="tdh r_line_none"><input type="password" name="passCheck" maxlength="20" value="" id="passCheck" class="txtbox" title="현재비밀번호"></td>
					</tr>
					<tr>	
						<th class="th">변경할 비밀번호</th>
						<td class="td r_line_none"><input type="password" name="pwd" maxlength="20" value="" id="pwd" class="txtbox" title="비밀번호"></td>
					</tr>
					<tr>
						<th class="th">변경할 비밀번호 확인 </th>
						<td class="td r_line_none"><input type="password" name="rePwd" maxlength="20" value="" id="rePwd" class="txtbox" title="비밀번호 확인"></td>
					</tr>
				
				</table>
			</div>	
			<div class="MPBtnWrap MAT10">
				<input type="button" class="btn_inp_b_01 FloatR" value="수정" onclick="submitGo()"/>
				<input type="button" class="btn_inp_w_01 FloatR" onclick="location.href='./home.do?siteId=mjeinet'" value="취소"/>
			</div>

      </form>
 