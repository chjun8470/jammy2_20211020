<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.util.CriptUtil"%>
<%

	siteId = util.getStr(paramMap.get("siteId"));
	
%>
		<script type="text/javascript">
		//<![CDATA[
			function submitGo(){
				if($('#pwd').val() == ""){
					alert("비밀 번호를 입력 해주세요");
					return false;
				}else{
					if($('#pwd').val() != $('#rePwd').val()){
						alert("비밀 번호가 일치하지 않습니다.");
						return false;
					}
				}
				jQuery.post('./userPassCheck.do',
					{
						"pwd" : $('#pwd').val(),
					},
					function(data){
						var successCode = data.successCode;

						if(successCode == "OK"){
							if(confirm("수정페이지로 이동하시겠습니까?")){
								$("#fwrite").submit();
							}
						}else{
							alert("비밀번호를 확인해주세요.");
							return false;
						}
					}
				);

				return false;
			}
		//]]>
		</script>

	<div class="MPTit">
	<h2>정보수정</h2>
		<p class="MP_P">회원 정보의 수정을 원하실 경우, 본인확인을 위해 비밀번호를 입력해주세요</p>
	</div>
	
	<form name="fwrite" id="fwrite" action="./mypage.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>">
	
		<div class="basic_writeWrap">
		
			<table class="skin_write01" id="write_table">
				<colgroup>
					<col style="width:30%" />
					<col style="width:70%" />
				</colgroup>
				<tr>
					<!--<td colspan="2" class="r_line_none">회원 정보의 수정을 원하실 경우. 본인확인을 위해 비밀번호를 입력해주세요</td>-->
				</tr>
				<tr>
					<th>비밀번호</th>
					<td class="r_line_none">
						<input type="password" id="pwd" name="pwd" value=""/>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td class="r_line_none">
						<input type="password" id="rePwd" name="rePwd" value=""/>
					</td>
				</tr>
			</table>
		
			<!-- bo_btn  -->
				<div class="MPBtnWrap MAT10">
					<input type="button" onclick="submitGo()" value="확인" class="btn_inp_b_01 FloatR" />
				</div>
			<!--// bo_btn -->
		
		</div>
	
	</form>
