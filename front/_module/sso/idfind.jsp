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
		function submitGo(){			
			
			if($('#email').val() == ""){
				alert("E-mail을 입력 해주세요");
				return false;
			}

			return true;
		}

		$(document).ready(function(){	
			$('#email').change(function(){
				var value = $('#email').val();
				var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
				var match = pattern.exec(value);

				if(match == null){
					alert("email 형식으로 입력해야 합니다.");
					$('#email').val('').focus();
					return;
				};
				*/
			});
		});
	//]]>
		</script>
	

	 <form name="fwrite" id="fwrite" action="./findProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="myPage" id="myPage"  value="<%=myPage%>" />
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="reg_ip" id="reg_ip" value="<%=reg_ip%>" />

			<% if(send.equals("send")){ %>
		 
			<div class="tit_login"><img src="/img/login/tit_mail_send.png" alt="mail send"></div>
			<div class="noticeBox">
				<!-- <div class="notice_pop1">메일이 발송 되었습니다.<br>메일 인증을 해주십시오.</div> -->
				<div class="notice_pop1">등록된 이메일로<br />ID가 발송되었습니다.</div><br />
			</div>
			<div class="pop_btnBox">
				<input type="button" class="btn_pop7" onclick="location.href='./login.do'"value="확인"/>
			</div>
			</div>
		<%}else{%>
			<div class="tit_login"><img src="/img/login/tit_find_id.png" alt="Member Login" /></div>
			<div class="inputBox">
				<%if(send.equals("none")){ %>
					<div class="re_input">E-mail이 존재하지 않거나 일치 하지 않습니다.<br/>다시 입력하여 주십시오</div><br/><br/>
				<%} %>
				<div class="txt_pop1">이름</div>
				<input type="text" name="psnNm" maxlength="20" value="" id="psnNm" class="input_pop4" title="이름">
				<div class="txt_pop2">E-mail</div>
				<input type="text" name="email" maxlength="20" value="" id="email" class="input_pop402" title="이메일">
			</div>
			
			<div class="pop_btnBox">
				<input type="submit" class="btn_pop5" value="찾기" />
				<input type="button" class="btn_pop6" onclick="location.href='./login.do'" value="이전"/>
			</div>
		<%}%>        	
     </form>