<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.util.CriptUtil"%>
<%
	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String mode = util.getStr(paramMap.get("mode"));
	String send = util.getStr(paramMap.get("send"));

	String reg_ip = request.getRemoteAddr();

%>
		<script type="text/javascript">
		//<![CDATA[
		function submitGo(mode){
			if(mode == "PWFEMAIL"){
				if($('#id').val() == ""){
					alert("ID를 입력 해주세요");
					return false;
				}
				if($('#email').val() == ""){
					alert("E-mail을 입력 해주세요");
					return false;
				}
				$("#fwrite").submit();
			} else if(mode == "PWFPHONE") {
				$("#fwrite").attr("action","/sso/findPassword.do");
				$("#fwrite").submit();
			} else {
					$("#mode").val(mode);
					$("#fwrite").submit();
			}
		}

		function selectCt(){
			var selectVal = $(":input:radio[name=certify]:checked").val();
			if(selectVal == "mail"){
				$(".txt_pop1").show();
				$("#id").show();
				$(".txt_pop2").show();
				$("#email").show();
				$("#showGpin").hide();
				$("#showPhone").hide();
				$("#showMail").removeAttr("style");
			}
			else if(selectVal == "gpin"){
				$(".txt_pop1").hide();
				$("#id").hide();
				$(".txt_pop2").hide();
				$("#email").hide();
				$("#showMail").hide();
				$("#showPhone").hide();
				$("#showGpin").show();
			}
			else if(selectVal == "phone"){
				$(".txt_pop1").hide();
				$("#id").hide();
				$(".txt_pop2").hide();
				$("#email").hide();
				$("#showMail").hide();
				$("#showGpin").hide();
				$("#showPhone").removeAttr("style");
			}
		}

			$(document).ready(function(){

				$('#email').change(function(){
					var value = $('#email').val();
					var pattern = /^[_0-9a-zA-Z-.]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)$/;
					var match = pattern.exec(value);

					if(match == null){
							alert("email 형식으로 입력해야 합니다.");
							$('#email').val('').focus();
							return;
						};
					});


		});
		//]]>
		</script>


	 <form name="fwrite" id="fwrite" action="./findProc.do" method="post" enctype="multipart/form-data">
	  	<input type="hidden" name="myPage" id="myPage"  value="<%=myPage%>" />
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="reg_ip" id="reg_ip" value="<%=reg_ip%>" />


			<%if(send.equals("send")){ %>
				<div class="tit_login"><img src="/img/login/tit_mail_send.png" alt="mail send"></div>


				<div class="noticeBox">
					<div class="notice_pop1">등록된 이메일로<br />비밀번호 변경 URL이<br/>발송되었습니다.</div><br/>
				</div>

				<div class="pop_btnBox">
					<input type="button" class="btn_pop7" onclick="location.href='./login.do'"value="확인"/>
				</div>

				<% }else{ %>

			<div class="tit_login"><img src="/img/login/tit_find_pw.png" alt="PASSWORD FIND"></div>
				<div class="inputBox">
					<%if(send.equals("none")){ %>
						<div class="re_input">ID 와 E-mail이 존재하지 않거나 일치하지 않습니다. 다시 입력하여 주십시오</div><br/><br/>
					<% }%>
				
				<div align="center"><b><h3>인증방식을 선택해 주세요</h3></b>
					<div style="margin:10px">
						<input type="radio" name="certify" id="certifyMail" value="mail" checked="checked" onclick="selectCt()" /> 메일인증
						<input type="radio" name="certify" id="certifyGpin" value="gpin" onclick="selectCt()" /> G-pin 인증
						<input type="radio" name="certify" id="certifyPhone" value="phone" onclick="selectCt()" /> 휴대폰 인증
					</div>
				</div>
					<!--<div class="txt_pop1">아이디</div>-->
					<input type="text" name="id" maxlength="20" value="" id="id" class="input_pop4" title="이름" placeholder="아이디를 입력하세요">
					<!--<div class="txt_pop2">E-mail</div>-->
					<input type="text" name="email" maxlength="30" value="" id="email" class="input_pop402" title="이메일" placeholder="E-Mail을 입력하세요">


			</div>
			<div class="pop_btnBox">
				<input type="button" class="btn_pop5" id="showMail" value="메일인증" onclick="submitGo('PWFEMAIL')" />
				<input type="button" class="btn_pop5" id="showGpin" value="G-pin 인증" style="display:none" onclick="submitGo('PWFGPIN')" />
				<input type="button" class="btn_pop5" id="showPhone" value="휴대폰 인증" style="display:none" onclick="submitGo('PWFPHONE')" />
				<input type="button" class="btn_pop6" onclick="location.href='./login.do'" value="이전"/>
			</div>
				<%} %>
      </form>