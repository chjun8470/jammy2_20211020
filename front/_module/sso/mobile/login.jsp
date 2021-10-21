<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%session.invalidate(); %>

				<script type="text/javascript">
				//<![CDATA[
					// 타이틀 변겅
					document.title = '로그인 - 전남과학기술정보시스템';

					function goJoin(){
						location.href="/sso/join.do?siteId=mjeinet";
					}
					$('#login_id').focus();
				//]]>	
				</script>
                
                <div class="header_login">회원 로그인</div>
                
                <div class="tit_login">
                    <h2>LOGIN</h2>
                    <P>로그인 하시면 JEINET의 서비스를 이용하실 수 있습니다.</P>
                </div>

				<!-- <div class="tit_login"><img src="/img/login/tit_login.png" alt="Member Login" /></div> -->

				<!--inputBox S-->
				<form method="post" id="actForm" name="actForm" action="/sso/login.do">
					<input type="hidden" id="mode" name="mode" value="" />
					<input type="hidden" id="siteId" name="siteId" value="mjeinet" />

					<div class="inputBox">
							<%-- <input type="button" class="btn_pop1" onclick="actlogin('<%=util.getStr(request.getHeader("referer"))!=""?util.getStr(request.getHeader("referer")): "/jeinet/main.do"%>')" value="로그인"/> --%>
							
                            
							<!-- <div class="txt_pop1"><label for="login_id">ID</label></div> -->
							<input type="text" name="login_id" class="input_pop1" id="login_id" onfocus="if($(this).val()== '') $(this).val('');" onblur="if($(this).val()== '') $(this).val('');" placeholder="아이디를 입력하세요"/>
                            
							<!-- <div class="txt_pop2"><label for="login_pwd">P/W</label></div> -->
							<input type="password" class="input_pop2" id="login_pwd" onkeydown="if(event.keyCode==13) actlogin('');" placeholder="비밀번호를 입력하세요"/>
                            
                            <input type="button" class="btn_pop1" onclick="actlogin('/mjeinet/main.do')" value="로그인"/>
					</div>
					<!--inputBox E-->

				</form>
				<!--pop_btn_Box S-->
				<!-- <div class="pop_btnBox">
					<input type="button" class="btn_pop2" onclick="goJoin();" value="회원가입&nbsp;&nbsp;&nbsp;&gt;"/>
					<input type="button" class="btn_pop3" onclick="location.href='/sso/idpwd.do?mode=idfind';" value="ID 찾기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;"/>
					<input type="button" class="btn_pop4" onclick="location.href='/sso/idpwd.do?mode=pwfind';" value="P/W 찾기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;"/>
				</div> -->
				<div class="pop_btnBox">
                    <ul class="joinlogin">
                        <li><a onclick="location.href='/sso/join.do?siteId=mjeinet'" value="회원가입&nbsp;&nbsp;&nbsp;&gt;">회원가입</a></li>
                        <li><a onclick="location.href='/sso/idpwd.do?mode=idfind&siteId=mjeinet';" value="ID 찾기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;">아이디 찾기</a></li>
                        <li><a onclick="location.href='/sso/idpwd.do?mode=pwfind&siteId=mjeinet';" value="P/W 찾기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;">비밀번호 찾기</a></li>
                    </ul>
                </div>
				<!--pop_btn_Box E-->