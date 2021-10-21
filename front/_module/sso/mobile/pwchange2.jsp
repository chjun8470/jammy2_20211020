<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.util.CriptUtil"%>
<%@include file="/front/_item/sso/i_header.jsp" %>
<%
	ComUtil util = new ComUtil();
	CriptUtil cutil = new CriptUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String mode = util.getStr(paramMap.get("mode"));
	String enc = util.getStr(paramMap.get("enc"));
	String encIdx = util.getStr(paramMap.get("encIdx"));
	String view = util.getStr(paramMap.get("view"));

	String reg_ip = request.getRemoteAddr();
	
%>
<!--<%=encIdx%> -->
		<script type="text/javascript">
		//<![CDATA[
			function submitGo(){

				if($('#pwd').val() == ""){
					alert("비밀 번호를 입력 해주세요");
					$("#pwd").focus();
					return false;
				}else if( !chkPwd( $("#pwd").val() ) ){
					//alert("비밀번호 : 8자이상 20자이하까지만 입력이 가능합니다.");
					$("#pwd").focus();
					return false;
				}else{
					if($('#pwd').val() != $('#rePwd').val()){
						alert("비밀 번호가 일치하지 않습니다.");
						$("#rePwd").focus();
						return false;
					}
				}
				jQuery.post('./reset_pw2.do',
					{
						"encIdx" : '<%=enc%>',
						"pwd" : $('#pwd').val(),
						"rePwd" : $('#rePwd').val()
					},
					function(data){
						var successCode = data.successCode;

						if(successCode == "OK"){
							alert("비밀번호 재설정이 성공하였습니다.");
							location.href ="login.do";
						}else{
							alert("비밀번호 재설정이 실패하였습니다."+successCode);
						}
					}
				);

				return false;
			}

			$(document).ready(function(){
				window.resizeTo("836", "800");

				$('#pwd').change(function(){
					var value = $('#pwd').val();
					var pattern = /^[a-zA-z0-9]{8,20}$/;
					var match = pattern.exec(value);

					if( value.length < 8 || value.length > 20){
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

	<div class="popWrap">
	 <form name="fwrite" id="fwrite" action="./pwdProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="myPage" id="myPage"  value="<%=myPage%>" />
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="enc" id="enc" value="<%=enc%>" />
		<div class="tit_login"><img src="/img/login/tit_change_pw.png" alt="change P/W"></div>

			<%if(view.equals("")){ %>
			<div class="noticeBox">
				<div class="notice_pop1">정상적인 접근이 아닙니다.<br/>다시 확인해주세요.</div>
			</div>
			<div class="pop_btnBox">
			<input type="button" class="btn_pop5" onclick="location.href='/sso/idpwd.do?mode=pwfind'" value="비밀번호 찾기"/>
			<input type="button" class="btn_pop6" onclick="location.href='./login.do'" value="취소"/>
			</div>
			<% }else if(view.equals("idx")){ %>
			<div class="noticeBox">
				<div class="notice_pop1">회원 정보가 존재하지 않습니다.</div>
			</div>
			<div class="pop_btnBox">
			<input type="button" class="btn_pop5" onclick="location.href='/sso/idpwd.do?mode=pwfind'" value="비밀번호찾기"/>
			<input type="button" class="btn_pop6" onclick="location.href='./login.do'" value="취소"/>
			</div>
			<% }else if(view.equals("date")){ %>
			<div class="noticeBox">
				<div class="notice_pop1">유효 시간이 초과하였습니다.<br />다시 진행하여 주시기 바랍니다.</div>
			</div>
			<div class="pop_btnBox">
			<input type="button" class="btn_pop5" onclick="location.href='/sso/idpwd.do?mode=pwfind'" value="비밀번호찾기"/>
			<input type="button" class="btn_pop6" onclick="location.href='./login.do'" value="취소"/>
			</div>
			<% }else if(view.equals("change")){ %>
			<div class="inputBox">
				<div class="txt_pop1">P/W</div>
				<input type="password" name="pwd" maxlength="20" value="" id="pwd" class="input_pop4" title="비밀번호">
				<div class="txt_pop2">P/W 확인</div>
				<input type="password" name="rePwd" maxlength="20" value="" id="rePwd" class="input_pop402" title="비밀번호 확인">
			</div>
			<div class="pop_btnBox">
				<input type="submit" class="btn_pop5" value="재설정"/>
				<input type="button" class="btn_pop6" onclick="location.href='./login.do'" value="취소"/>
			</div>
			<%} %>

      </form>
    </div>
