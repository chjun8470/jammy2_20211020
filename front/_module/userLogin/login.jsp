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
	ComUtil util = new ComUtil();
// 	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	String reUrl = util.getStr(request.getHeader("referer"),"/web/main.do");
	if(reUrl.toLowerCase().indexOf("proc.do") > 0){
		reUrl = "/web/web_jnsptotal.do";
	}

	if(reUrl.indexOf("/login.do") > 0){
		reUrl = "/web/web_jnsptotal.do";
	}
	
	
%>
		<!-------->
		<div class="header">
		        <div class="img">
					<img src="/imgs/main/img_test.png" alt="지역 연구장비를 한곳에! 연구장비정보망  Jeonnam Research &Development Equipment Infomation Network"/>
                </div>
        </div>
		<!-------->

        <!---contents----->
		<div class="contents">

            <!----contents_btn----->
			<div class="contents_btn">



                    <!----login_box----->
                    <div class="login_box">

                    <div class="login_logo">
		            	<img src="/imgs/main/bg_main_01.jpg" alt="login"/>
                	</div>
                        <div class="LoginInputBox">
                            <div class="IdBox">
                                <div class="Id">회원ID</div>
<%--                                 <div class="InputIdBox"><input type="text" class="input-id" id="login_id" name="login_id" onfocus="if($(this).val()== '아이디를 입력해주세요') $(this).val('');" onblur="if($(this).val()== '') $(this).val('아이디를 입력해주세요');" onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');" value="admin" /><br/></div> --%>
                                <div class="InputIdBox"><input type="text" class="input-id" id="login_id" name="login_id"  onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');"  /><br/></div>
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
                        	<img src="/imgs/main/bg_main_login03.jpg" alt="회원가입" style="cursor:pointer" onclick="goSign();" />
                    	</div>

                        <div class="LogintextBox">

                        	<div class="Logintext_1">
                            	<ul>
                            	<!--
                                <li><input type="checkbox" class="" name="stay_sign" value=""/>로그인 상태 유지</li>
                                <li><input type="checkbox" class="" name="stay_sign" value=""/>아이디 저장</li>
                                <li><a href="#"><img src="/imgs/main/bg_main_text.jpg" alt="아이디 찾기"/></a></li>
                                <li><a href="#"><img src="/imgs/main/bg_main_text.jpg" alt="비밀번호 찾기"/></a></li>
                                 -->
                                </ul>
                            </div>

                        </div>


                        <div class="login_text">
                        	<img src="/imgs/main/bg_main_02.jpg" alt="문의처 : 전남과학진흥센터  안영진 선임연구원  123-456-7891 / 최지은 연구원  123-456-7891"/>
                        </div>

                    </div>
                    <!----login_box----->

                    <div class="cont_left">
                    	<img src="/imgs/main/bg_main_03.jpg" alt="장비등록시 로그인을 하셔야합니다./ · 회원 가입에 필요한 정보는 추후 개인정보 취급에 관한 내용을 게시 하겠습니다./· 본 사이트는 임시 페이지로 추후 개인정보 취급에 관한 내용을 게시 하겠습니다." />
                    </div>


            </div>
            <!----contents_btn----->

        </div>
		<!----contents---->

<form method="post" id="actForm" name="actForm">
	<input type="hidden" id="mode" name="mode" value=""/>
</form>



<script type="text/javascript">
//<![CDATA[
	function goSign(){
		$("#mode").val("sign");
		$("#actForm").attr("action","/sso/login.do#container");
		$("#actForm").submit();
	}

	$('#login_id').focus();
//]]>	
</script>