<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%
String reUrl = "";
%>



      <div class="login_logo">
		            	<img src="/imgs/main/bg_main_01.jpg" alt="login"/>
                	</div>


      <div>


         <div class="Id">회원ID</div>
<%--                                 <div class="InputIdBox"><input type="text" class="input-id" id="login_id" name="login_id" onfocus="if($(this).val()== '아이디를 입력해주세요') $(this).val('');" onblur="if($(this).val()== '') $(this).val('아이디를 입력해주세요');" onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');" value="admin" /><br/></div> --%>
                                <div class="InputIdBox"><input type="text" class="input-id" id="login_id" name="login_id"  onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');"  /><br/></div>
      </div>


                    <!----login_box----->
                    <div class="login_box">


                        <div class="LoginInputBox">
                            <div class="IdBox">

                            </div>
                            <div class="PwBox">
                                <div class="Pw">비밀번호</div>
<%--                                 <div class="InputPwBox"><input type="password" class="input-pw" id="login_pwd" name="login_pwd" onfocus="if($(this).val()== '페스워드를 입력해주세요'){ $(this).val(''); $(this).attr('type','password');}" onblur="if($(this).val()== '') {$(this).val('페스워드를 입력해주세요'); $(this).attr('type','text');}" onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');" value="1q2w3e4r5t" /><br/></div> --%>
                                <div class="InputPwBox"><input type="password" class="input-pw" id="login_pwd" name="login_pwd" onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');"  /><br/></div>
                            </div>
                        </div>


                        <div class="LoginBtnBox">
							<img src="/imgs/main/bg_main_login02.jpg" alt="로그인"  style="cursor:pointer" onclick="actlogin('<%=reUrl%>')"/>
                        </div>
                        <div class="LoginBtnBox_1">
                        	<img src="/imgs/main/bg_main_login03.jpg" alt="회원가입" style="cursor:pointer" onclick="goJoin();" />
                    	</div>

                        <div class="LogintextBox">

                        	<div class="Logintext_1">
                            	<ul>
                                <li><a href="#"><img src="/imgs/main/bg_main_text.jpg" alt="아이디 찾기"/></a></li>
                                <li><a href="#"><img src="/imgs/main/bg_main_text.jpg" alt="비밀번호 찾기"/></a></li>
                                </ul>
                            </div>

                        </div>



                    </div>


<form method="post" id="actForm" name="actForm">
	<input type="hidden" id="mode" name="mode" value=""/>
</form>



<script type="text/javascript">
//<![CDATA[
	function goJoin(){
		location.href="/sso/join.do";

	}

	$('#login_id').focus();
//]]>	
</script>