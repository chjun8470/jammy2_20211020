<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
       String display = "sub";
       request.setCharacterEncoding("utf-8");
       ComUtil util = new ComUtil();

       String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
       HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
       HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
       HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
       StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
       ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
       LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
       
       
       
       ArrayList<HashMap<String, String>> major = request.getAttribute("major") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("major");
       ArrayList<HashMap<String, String>> academicCode = request.getAttribute("academicCode") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("academicCode");
       ArrayList<HashMap<String, String>> jipCd = request.getAttribute("jipCd") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("jipCd");
       ArrayList<HashMap<String, String>> scList = request.getAttribute("scibList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scibList");
       
       ArrayList<HashMap<String, String>> majorList = request.getAttribute("majorList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList");
       ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
       ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	   ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	   
	   ArrayList<HashMap<String, String>> bizList1 = request.getAttribute("bizList1") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("bizList1");
	   ArrayList<HashMap<String, String>> teamList = request.getAttribute("teamList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamList");

       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String userIdx = util.getStr(paramMap.get("userIdx"));
       if("".equals(mode)) mode = "write";

       String fileGrp = "expertManage";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

		
       
       	int scCnt = 0;
		int crCnt = 0;
		int acCnt = 0;
		int rdCnt = 0;
		int rpCnt = 0;
		int ipCnt = 0;
		int awCnt = 0;
		int quCnt = 0;
		int exCnt = 0;
		int reCnt = 0;
		int evCnt = 0;
		int coCnt = 0;
		int resultEvCnt = 0;
		int resultConCnt = 0;
       
       	Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
       
       
%>
<style  scoped>
.ui-datepicker-calendar {
    display: none;
    }
button.ui-datepicker-current { display: none; }
</style>


<jsp:useBean id="currTime" class="java.util.Date" />
<div class="zoom">
	<input type="button" value="회원검색" class="btn_inp_b_01" onclick="popupWindow('exUserList')" >
</div>

<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
       <input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
       <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
       <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
       <input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	   <input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	   <input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID")) %>" />
	   <input type="hidden" name="delFiles" value="" />
	   
	   
	   
		<p style="color:red;">* ) 필수 입력사항입니다.</p>
			<h2 class="tit">기본정보</h2>
			<!-- bo_btn  -->
              <div class="btn_right_box" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_inp_b_01" value="수정하기" onclick="goCheck()"/>
                     <% if(util.getStr(paramMap.get("xt")).equals("1")){ %>
                     <input type="button" class="btn_inp_w_01" value="이전" onclick="history.go(-1)"/>
                     <% }else{ %>
                     <input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
                     <% } %>
              </div>
              <!--// bo_btn -->
	   		<table class="skin_basic_write" >
	   			<caption>기본정보</caption>
                     <colgroup>
                            <col style="width:15%" />
                            <col style="width:35%" />
                            <col style="width:15%" />
                            <col style="width:35%" />
                     </colgroup>
                     <tbody>
                           	<tr>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> 이름</th>
                           		<td>
                           			<input type="text" name="psnNm" id="psnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" class="inp_txt" >
                           		</td>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> 성별</th>
                           		<td>
                           			<select name="GenderTypeCd" id="GenderTypeCd" class="select_box">
										<option <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='남자' selected" : "" %>>남자</option>
										<option <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "" : "value='여자' selected" %>>여자</option>
									</select>
                           			
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> 출생년도</th>
                           		<td>
                          			<select name="birthDate" id="birthDate" class="select_box">
				            			<option value="">선택1</option>
				            			<%
				            			for(int i=1950; i<=util.getInt(sf.format(nowTime)); i++){
				            				String selected = util.getInt(dataMap.get("BIRTH_DATE")).equals(i)?"selected":"";
				            			%>
				            			<option value="<%=i%>" <%=selected%>><%=i%></option>
			            				<% } %>
									</select>
                           			
                           		</td>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> email</th>
                           		<td>
                           			<input type="hidden" name="email" id="email"  value="" class="inp_txt" maxlength="20">
                           			<%if(util.getStr(dataMap.get("EMAIL")).equals("")||util.getStr(dataMap.get("EMAIL")).equals(null)){ %>
                           				<input type="text" name="mail1" id="mail1" value="" class="inp_txt" style="width:35%"  maxlength="20" title="이메일아이디"> @
										<input type="text" name="mail2" id="mail2" value="" class="inp_txt" style="width:30%"  maxlength="50" title="이메일도메인">
										<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="이메일주소도메인선택" >
											<option value="" selected="selected">직접입력</option>
											<option value="gmail.com">지메일</option>
											<option value="empal.com">엠파스</option>
											<option value="naver.com">네이버</option>
											<option value="hanmail.net">다음</option>
											<option value="hotmail.com">핫메일</option>
											<option value="yahoo.co.kr">야후</option>
											<option value="nate.com">네이트</option>
										</select>
                           			<% }else{ %>
                           			<%
			            				int xidx = util.getStr(dataMap.get("EMAIL")).indexOf("@");
			            				String mail1 = util.getStr(dataMap.get("EMAIL")).substring(0,xidx);
			            				String mail2 = util.getStr(dataMap.get("EMAIL")).substring(xidx+1);
			            			%>
                           				<input type="text" name="mail1" id="mail1" value="<%=mail1%>" class="inp_txt" style="width:35%"  maxlength="20" title="이메일아이디"> @
										<input type="text" name="mail2" id="mail2" value="<%=mail2%>" class="inp_txt" style="width:30%"  maxlength="50" title="이메일도메인">
										<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="이메일주소도메인선택" >
											<option value="" <%if(mail2.equals("") || mail2.equals(null) ) { %> selected="selected" <% } %>>직접입력</option>
											<option value="gmail.com" <%if(mail2.equals("gmail.com")) { %> selected="selected" <% } %>>지메일</option>
											<option value="empal.com" <%if(mail2.equals("empal.com")) { %> selected="selected" <% } %>>엠파스</option>
											<option value="naver.com" <%if(mail2.equals("naver.com")) { %> selected="selected" <% } %>>네이버</option>
											<option value="hanmail.net" <%if(mail2.equals("hanmail.net")) { %> selected="selected" <% } %>>다음</option>
											<option value="hotmail.com" <%if(mail2.equals("hotmail.com")) { %> selected="selected" <% } %>>핫메일</option>
											<option value="yahoo.co.kr" <%if(mail2.equals("yahoo.co.kr")) { %> selected="selected" <% } %>>야후</option>
											<option value="nate.com" <%if(mail2.equals("nate.com")) { %> selected="selected" <% } %>>네이트</option>
										</select>
                           			<%} %>
                           		</td>
                           	</tr>
                           	<tr>
                           		<!-- 
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> 국적</th>
                           		<td>
                           			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
			            				if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
			            					<input type="text" name="proUserForg" id="proUserForg"  class="inp_txt" style="width:100%;" maxlength="100">
			            				<%}else{%>
			            					<input type="text" name="proUserForg" id="proUserForg"  value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>" class="inp_txt" style="width:100%;"  readonly style="border:0px;" >
			            				<%} %>
			            			<%}else{ %>
			            				<input type="text" name="proUserForg" id="proUserForg"  value="대한민국" class="inp_txt" readonly style="border:0px;" >
			            			<%} %>
                           		</td>
                           		-->
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> 지역</th>
                           		<td colspan="3">
                           			
		            					&nbsp;&nbsp;전라남도 <input type="radio" name="area" value="1"  onclick="areaClick('1')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> checked="checked" <% } %> />
										&nbsp;&nbsp;전라남도 외 지역 <input type="radio" name="area" value="2"  onclick="areaClick('2')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> checked="checked" <% } %> />&nbsp;&nbsp;
										<select class="select_box" name="ProUserBirthplace" id="ProUserBirthplace1" <% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> style="display:none;"<% } %>>
											<option value="">선택하세요</option>
											<%
												int utilitynumArea = 1;
												for(HashMap rs:areaSigunguList) {
												%>
											<option <%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
											value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
											<% utilitynumArea++; } %>
										</select>
										<select class="select_box" name="0" id="ProUserBirthplace2" <% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> style="display:none;"<% } %> >
											<option value="">선택하세요</option>
											<%
												int utilitynumArea2 = 1;
												for(HashMap rs:areaList) {
												%>
											<option <%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
											value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
											<% utilitynumArea2++; } %>
										</select>
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> 전화번호</th>
                           		<td>
                           			<input type="hidden" name="telNo" id="telNo"  value="" class="inp_txt"  maxlength="20">
                           			<%
                           			
                           			if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
                           				<select name="tel1" id="tel1" class="select_box" title="사무실전화번호 국번">
			                          		<option value="02">02</option>
											<option value="031">031</option>
											<option value="032">032</option>
											<option value="033">033</option>
											<option value="041">041</option>
											<option value="042">042</option>
											<option value="043">043</option>
											<option value="044">044</option>
											<option value="051">051</option>
											<option value="052">052</option>
											<option value="053">053</option>
											<option value="054">054</option>
											<option value="055">055</option>
											<option value="061">061</option>
											<option value="062">062</option>
											<option value="063">063</option>
											<option value="064">064</option>
											<option value="070">070</option>
										</select> -
										<input type="text" name="tel2" id="tel2" value="" maxlength="4" size="5" class="inp_txt" title="사무실전화 앞번호"> -
										<input type="text" name="tel3" id="tel3" value="" maxlength="4" size="5" class="inp_txt" title="사무실전화 뒷번호">
                           			<%}else{ 
                           				String telox = util.getStr(dataMap.get("TEL_NO"));
                        				String telA[] = telox.split("-"); 
                           			%>
                           				<select name="tel1" id="tel1" class="select_box" title="사무실전화번호 국번" style="width:20%">
			                          		<option value="02" 	<%if(telA[0].equals("02")) { %> selected="selected" <% } %>>02</option>
											<option value="031" <%if(telA[0].equals("031")) { %> selected="selected" <% } %>>031</option>
											<option value="032" <%if(telA[0].equals("032")) { %> selected="selected" <% } %>>032</option>
											<option value="033" <%if(telA[0].equals("033")) { %> selected="selected" <% } %>>033</option>
											<option value="041" <%if(telA[0].equals("041")) { %> selected="selected" <% } %>>041</option>
											<option value="042" <%if(telA[0].equals("042")) { %> selected="selected" <% } %>>042</option>
											<option value="043" <%if(telA[0].equals("043")) { %> selected="selected" <% } %>>043</option>
											<option value="044" <%if(telA[0].equals("044")) { %> selected="selected" <% } %>>044</option>
											<option value="051" <%if(telA[0].equals("051")) { %> selected="selected" <% } %>>051</option>
											<option value="052" <%if(telA[0].equals("052")) { %> selected="selected" <% } %>>052</option>
											<option value="053" <%if(telA[0].equals("053")) { %> selected="selected" <% } %>>053</option>
											<option value="054" <%if(telA[0].equals("054")) { %> selected="selected" <% } %>>054</option>
											<option value="055" <%if(telA[0].equals("055")) { %> selected="selected" <% } %>>055</option>
											<option value="061" <%if(telA[0].equals("061")) { %> selected="selected" <% } %>>061</option>
											<option value="062" <%if(telA[0].equals("062")) { %> selected="selected" <% } %>>062</option>
											<option value="063" <%if(telA[0].equals("063")) { %> selected="selected" <% } %>>063</option>
											<option value="064" <%if(telA[0].equals("064")) { %> selected="selected" <% } %>>064</option>
											<option value="070" <%if(telA[0].equals("070")) { %> selected="selected" <% } %>>070</option>
										</select> -
										<input type="text" name="tel2" id="tel2" value="<%=telA[1]%>" maxlength="4" style="width:30%" class="inp_txt" title="사무실전화 앞번호"> -
										<input type="text" name="tel3" id="tel3" value="<%=telA[2]%>" maxlength="4" style="width:30%" class="inp_txt" title="사무실전화 뒷번호">
                           			<%} %>
                        		</td>
                        		<th scope="row" class="tit"><span style="color:red;" >*</span> 휴대전화</th>
                           		<td>
                           			<input type="hidden" name="cpNo" id="cpNo"  value="" class="inp_txt" style="border:0px;"  maxlength="20">
                           			<%
                           			//out.println(util.getStr(dataMap.get("CP_NO")));
                           			if(util.getStr(dataMap.get("CP_NO")).equals("") || util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
                           				<select name="cp1" id="cp1" class="select_box"  style="width: 20%" title="휴대폰 국번">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select> -
										<input type="text" name="cp2" id="cp2" value="" style="width:30%" maxlength="4"  class="inp_txt" title="휴대폰 앞번호"> -
										<input type="text" name="cp3" id="cp3" value="" style="width:30%" maxlength="4"  class="inp_txt" title="휴대폰 뒷번호">
                           			<%
                           			}else{ 
                           				String cpox = util.getStr(dataMap.get("CP_NO"));
                        				String cpA[] = cpox.split("-");
                           			%>
                           				<select name="cp1" id="cp1" class="select_box"  style="width: 20%" title="휴대폰 국번">
											<option value="010" <%if(cpA[0].equals("010")) { %> selected="selected" <% } %>>010</option>
											<option value="011" <%if(cpA[0].equals("011")) { %> selected="selected" <% } %>>011</option>
											<option value="016" <%if(cpA[0].equals("016")) { %> selected="selected" <% } %>>016</option>
											<option value="017" <%if(cpA[0].equals("017")) { %> selected="selected" <% } %>>017</option>
											<option value="018" <%if(cpA[0].equals("018")) { %> selected="selected" <% } %>>018</option>
											<option value="019" <%if(cpA[0].equals("019")) { %> selected="selected" <% } %>>019</option>
										</select> -
										<input type="text" name="cp2" id="cp2" value="<%=cpA[1]%>" style="width:30%" maxlength="4"  class="inp_txt" title="휴대폰 앞번호"> -
										<input type="text" name="cp3" id="cp3" value="<%=cpA[2]%>" style="width:30%" maxlength="4"  class="inp_txt" title="휴대폰 뒷번호">
                           			<% } %>
                        		</td>
                           	</tr>
                           	
                           	<% //if( util.getInt( loginVO.getAuthLv() ) > 70 ){ %>
				                <tr>
				                	<th scope="row" class="tit"><span style="color:red;" >*</span> 승인요청</th>
				                	<td colspan="3">
				                		<select  class="select_box" name="proState" id="proState" >
				                			<option value="10" <%=(util.getStr(dataMap.get("PRO_STATE"))).equals("요청")? "selected='selected'" : "" %>>요청</option>
				                			<option value="20" style="<%=(util.getStr(paramMap.get("xt"))).equals("1")?"display:none;":"" %>" <%=(util.getStr(dataMap.get("PRO_STATE"))).equals("승인")? "selected='selected'" : "" %>>승인</option>
				                			<option value="30" style="<%=(util.getStr(paramMap.get("xt"))).equals("1")?"display:none;":"" %>" <%=(util.getStr(dataMap.get("PRO_STATE"))).equals("반려")? "selected='selected'" : "" %>>반려</option>
				                		</select>
				                	</td>
				            	</tr>
			            	<% //} %>
			            	
			            	<tr>
			      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> 전문가구분</th>
			            		<td colspan="3">
									정책기획 <input type="checkbox" name="proJntisPlanning" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_PLANNING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									연구개발 <input type="checkbox" name="proJntisRnd" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_RND"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									기업지원 <input type="checkbox" name="proJntisCompany" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_COMPANY"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									연구장비 <input type="checkbox" name="proJeinet" value="Y" <%=(util.getStr(dataMap.get("PRO_JEINET"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									지식재산 <input type="checkbox" name="proJipbank" value="Y" <%=(util.getStr(dataMap.get("PRO_JIPBANK"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									인력양성 <input type="checkbox" name="proJntisEducation" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_EDUCATION"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									컨설팅 <input type="checkbox" name="proJntisConsulting" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_CONSULTING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									마케팅 <input type="checkbox" name="proJntisMarketing" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_MARKETING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									기타 <input type="checkbox" name="proJntisEtc" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_ETC"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
								</td>
			            	</tr>
			            	
			            	
			            	</tbody>
			            </table>
			            
			            <h2 class="tit">소속정보</h2>
			            <table class="skin_basic_write">
				   			<caption>소속정보</caption>
		                     <colgroup>
		                            <col style="width:15%">
		                            <col style="width:35%">
		                            <col style="width:15%">
		                            <col style="width:35%">
		                     </colgroup>
			                <tbody>
			            	<tr>
			            		<th scope="row" class="tit"><span style="color:red;" >*</span> 소속기관명</th>
			            		<td colspan="3"><input type="text" name="COM_NM" id="COM_NM" value="<%=(util.getStr(dataMap.get("COM_NM")))%>" class="inp_txt"></td>
			            	</tr>
			            	<tr>
			      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> 소속기관유형</th>
			            		<td colspan="3">
								<% 
								for(HashMap te:teamList){ %>
									<%=util.getStr(te.get("CODE_NM"))%> <input type="radio" name="team_1" <%=(util.getStr(dataMap.get("PRO_SMB_TEAM1"))).equals(util.getStr(te.get("CODE_CD")))? "checked='checked'" : "" %> value="<%=util.getStr(te.get("CODE_CD"))%>" />
								<% } %>	
								</td>
			            	</tr>
			            	<tr>
                           		<th scope="row" class="tit"><span style="color:red;">*</span> 부서</th>
                           		<td>
                           			<input type="text" name="DEPT_NM" id="DEPT_NM" value="<%=(util.getStr(dataMap.get("DEPT_NM")))%>" class="inp_txt">
                           		</td>
                           		<th scope="row" class="tit"><span style="color:red;">*</span> 직위</th>
                           		<td>
                           			<input type="text" name="POSITION_NM" id="POSITION_NM" value="<%=(util.getStr(dataMap.get("POSITION_NM")))%>" class="inp_txt">                           			
                           		</td>
                           	</tr>
                           	<tr>
			            		<th scope="row" rowspan="2" class="tit"><span style="color:red;" >*</span> 회사주소</th>
			            		<td colspan="3">
			            			<input type="text" class="inp_txt" id="COM_ZIP" name="COM_ZIP" maxlength="10" value="<%=(util.getStr(dataMap.get("COM_ZIP")))%>" readonly="readonly">
									<input type="text" class="inp_txt" id="COM_ADDR1" name="COM_ADDR1" maxlength="50" value="<%=(util.getStr(dataMap.get("COM_ADDR1")))%>" readonly="readonly" style="width:37%;">
									<input type="button" id="orgPostButton" value="찾아보기" class="btn_inp_g_01" onclick="orgPost()">
			            		</td>
			            	</tr>
			            	<tr>
			            		<td colspan="3"><input type="text" class="inp_txt" id="COM_ADDR2" name="COM_ADDR2" value="<%=(util.getStr(dataMap.get("COM_ADDR2")))%>" maxlength="50" style="width:37%;"></td>
			            	</tr>
			            	<tr>
			            		<th scope="row" class="tit"><span style="color:red;" >*</span> 대표번호</th>
			            		<td colspan="3">
			            		<%
			            		String[] comTel = util.getStr(dataMap.get("COM_TEL")).split("-");
			            		if(!util.getStr(dataMap.get("COM_TEL")).equals("")){
			            						            			
			            		%>
			            			<select name="ctel1" id="ctel1" class="select_box" title="사무실전화번호 국번" style="width:90px;">
		                          		<option value="02" <%=(comTel[0].equals("02"))?"selected":"" %>>02</option>
										<option value="031" <%=(comTel[0].equals("031"))?"selected":"" %>>031</option>
										<option value="032" <%=(comTel[0].equals("032"))?"selected":"" %>>032</option>
										<option value="033" <%=(comTel[0].equals("033"))?"selected":"" %>>033</option>
										<option value="041" <%=(comTel[0].equals("041"))?"selected":"" %>>041</option>
										<option value="042" <%=(comTel[0].equals("042"))?"selected":"" %>>042</option>
										<option value="043" <%=(comTel[0].equals("043"))?"selected":"" %>>043</option>
										<option value="044" <%=(comTel[0].equals("044"))?"selected":"" %>>044</option>
										<option value="051" <%=(comTel[0].equals("051"))?"selected":"" %>>051</option>
										<option value="052" <%=(comTel[0].equals("052"))?"selected":"" %>>052</option>
										<option value="053" <%=(comTel[0].equals("053"))?"selected":"" %>>053</option>
										<option value="054" <%=(comTel[0].equals("054"))?"selected":"" %>>054</option>
										<option value="055" <%=(comTel[0].equals("055"))?"selected":"" %>>055</option>
										<option value="061" <%=(comTel[0].equals("061"))?"selected":"" %>>061</option>
										<option value="062" <%=(comTel[0].equals("062"))?"selected":"" %>>062</option>
										<option value="063" <%=(comTel[0].equals("063"))?"selected":"" %>>063</option>
										<option value="064" <%=(comTel[0].equals("064"))?"selected":"" %>>064</option>
										<option value="070" <%=(comTel[0].equals("070"))?"selected":"" %>>070</option>
									</select> -
									<input type="text" name="ctel2" id="ctel2" value="<%=comTel[1] %>" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="사무실전화 앞번호"> -
									<input type="text" name="ctel3" id="ctel3" value="<%=comTel[2] %>" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="사무실전화 뒷번호">
								<% 
								}else{
								%>
									
									<select name="ctel1" id="ctel1" class="select_box" title="사무실전화번호 국번" style="width:90px;">
		                          		<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="070">070</option>
									</select> -
									<input type="text" name="ctel2" id="ctel2" value="" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="사무실전화 앞번호"> -
									<input type="text" name="ctel3" id="ctel3" value="" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="사무실전화 뒷번호">
								
								<%
								}
								%>
								
			            		</td>
			            	</tr>
			            	
                    </tbody>
	   		</table>
<!-- 기본정보 E -->

		<!-- 학력정보 S -->
		
		<div style="padding-top:15px"></div>
	   	<h2 class="tit">학력정보</h2>
		<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('academic')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('academic')" />
		</div>
   		<table class="skin_basic_write" >
   			<caption>학력정보</caption>
            <colgroup>
	            <col style="width:15%" />
          		<col />
          		<col style="width:15%" />
          		<col />
            </colgroup>
         	
		<tbody id="academiclist">
	
      		<tr class="academic_career_info<%=scCnt%>">
            	<th scope="row" class="tit"><span style="color:red;" >*</span> 학교명</th>
          		<td><input type="text" name="scNm" id="scNm" value="" class="inp_txt"></td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 전공</th>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scCode">
					<option value="">선택하세요</option>
					<% for(HashMap rsx:major) {%>
					<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>
					<% } %>
					<option value="ex">기타</option>
				</select>
          		</td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>">
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 교육시작일</th>
          		<td><input type="text" name="scStart" readonly id="scStart<%=scCnt%>"  value="" class="inp_txt"></td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 교육종료일</th>
          		<td>
          			<input type="text" name="scFinish" readonly id="scFinish<%=scCnt%>"  value="" class="inp_txt" style="width:60%">
          			<label><input type="checkbox" name="scIng<%=scCnt%>" id="scIng<%=scCnt%>" value="1" />진행중</label>
          		</td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>">
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 취득학위</th>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scDegree">
						<option value="">선택하세요</option>
						<% for(HashMap rsx:academicCode) {%>
						<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>
						<% } %>
						
					</select>
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> 학위취득일자</th>
          		<td><input type="text" name="scDate" id="scDate<%=scCnt%>" value="" class="inp_txt"></td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>" style='border-bottom:3px solid #ddd'>
          		<th scope="row" class="tit">증빙문서</th>
          		<td colspan="3">
          			<input type="hidden" name="acFile" id="acFile<%=scCnt%>" value="">
          			<input type="file" name="academicFile<%=scCnt%>" id="academicFile<%=scCnt%>" value="" />
          		</td>
          	</tr>
      
   		</tbody>
	</table>
		
	
	
	
<!-- 학력정보 E -->
<!-- 경력정보 S -->
		<div style="padding-top:15px"></div>
	   	<h2 class="tit">경력정보</h2>
		<div class="zoom">
			<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('career')" />
			<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('career')" />
   		</div>
   		<table class="skin_basic_write"  >
   			<caption>경력정보</caption>
            <colgroup>
	            <col style="width:15%" />
          		<col />
         		<col style="width:15%" />
         		<col />
            </colgroup>
          	
		<tbody id="careerlist">
		
			<tr class="career_info<%=crCnt%>">
        		<th scope="row" class="tit"><span style="color:red;" >*</span> 근무처</th>
				<td><input type="text" name="crNm"  value="" class="inp_txt"></td>
				<th scope="row" class="tit"><span style="color:red;" >*</span> 최종직위</th>
				<td><input type="text" name="crDept" value="" class="inp_txt"></td>
			</tr>
			<tr class="career_info<%=crCnt%>">
				<th scope="row" class="tit"><span style="color:red;" >*</span> 근무시작일</th>
				<td>
					<input type="text" name="crStart" id="crStart<%=crCnt%>" value="" class="inp_txt">
				</td>
				<th scope="row" class="tit"><span style="color:red;" >*</span> 근무종료일</th>
				<td>
					<input type="text" name="crFinish" id="crFinish<%=crCnt%>" value="" class="inp_txt" style="width:60%">
					<label><input type="checkbox" name="crIng<%=crCnt%>" id="crIng<%=crCnt%>"  value="1" />재직중</label>					
				</td>
			</tr>
			<tr class="career_info<%=crCnt%>">
				<th scope="row" class="tit"><span style="color:red;" >*</span> 주요업무</th>
				<td colspan="3"><input type="text" name="crWork" value="" class="inp_txt" style="width:80%"></td>
            </tr>
            <tr class="career_info<%=crCnt%>" style='border-bottom:3px solid #ddd'>
				<th scope="row" class="tit">증빙문서</th>
				<td colspan="3">
					<input type="hidden" name="crFile" id="crFile<%=crCnt%>" value="">
					<input type="file" name="careerFile<%=crCnt %>"  id="careerFile<%=crCnt %>" value="">
				</td>
            </tr>
        
		</tbody>
		</table>
<!-- 경력정보 E -->

<!-- 연구논문 S -->

	<div style="padding-top:15px"></div>
	<h2 class="tit">연구논문 실적</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('researchPaper')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('researchPaper')" />
	</div>
	<table class="skin_basic_write" >
		<caption>연구논문 실적</caption>
	       <colgroup>
	        <col style="width:15%" />
	        <col />
	        <col style="width:15%" />
	        <col />
	       </colgroup>
       	
 	<tbody id="researchPaperlist">
 	
		<tr class="researchPaper<%=rpCnt%>">
     		<th scope="row" class="tit">논문명</th>
     		<td><input type="text" name="rpNm" id="rpNm<%=rpCnt%>" value=""  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">게제년도</th>
     		<td>
     			<select name="rpStart" class="select_box">
           			<option value="">선택</option>
           			<%
           			for(int i=1950; i<=util.getInt(sf.format(nowTime)); i++){
           			%>
           			<option value="<%=i%>"><%=i%></option>
          			<% } %>
				</select>
     		</td>
     	</tr>
     	<tr class="researchPaper<%=rpCnt%>">
     		<th scope="row" class="tit">학술지명</th>
     		<td><input type="text" name="rpJournalNm"  value=""  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">SCI 논문여부구분</th>
     		<td>
				<select  class="select_box"  name="rpType" style='width:100%;'>
       				<option value="Y">Y</option>
       				<option value="N">N</option>
       			</select>
     		</td>
		</tr>
		<tr class="researchPaper<%=rpCnt%>" style='border-bottom:3px solid #ddd'>
			<th scope="row" class="tit">증빙문서</th>
			<td colspan="3">
				<input type="hidden" name="rpFile" id="rpFile<%=rpCnt%>" value="">
				<input type="file" name="researchPaperFile<%=rpCnt %>"  id="researchPaperFile<%=rpCnt %>" value="">
			</td>
		</tr>
	
	</tbody>
	</table>

<!-- 연구논문 E -->



<!-- 지식재산 실적 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">지식재산 실적</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('inProperty')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('inProperty')" />
	</div>
	<table class="skin_basic_write">
		<caption>지식재산 실적</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col />
	        <col style="width:15%" />
	       	<col />
        </colgroup>
       	
 	<tbody id="inPropertylist">
 	
		
		<tr class="inProperty<%=ipCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'inProperty')">
     		<th scope="row" class="tit">지식재산명</th>
     		<td><input type="text" name="ipNm" value=""  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">지식재산유형</th>
     		<td>
				<select class="select_box" name="ipType" style='width:100%;'>
       				<option value="">선택</option>
       				<% for(HashMap rsx:jipCd) {%>
						<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>
					<% } %>
       			</select>
     		</td>
     	</tr>
     	<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">출원등록구분</th>
     		<td>
     			<select name="ipState" class="select_box" style='width:100%;'>
     				<option value="출원">출원</option>
     				<option value="등록">등록</option>
     			</select>
     		</td>
     		<th scope="row" class="tit">출원등록일자</th>
     		<td><input type="text" name="ipStart" readonly id="ipStart<%=ipCnt%>" value=""  style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">인증/발행처</th>
     		<td colspan="3"><input type="text" name="ipPublication" value="" style="width:100%;" class="inp_txt"></td>
		</tr>
		<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">증빙문서</th>
     		<td colspan="3">
     			<input type="hidden" name="ipFile" id="ipFile<%=ipCnt%>" value="">
				<input type="file" name="inPropertyFile<%=ipCnt %>" id="inPropertyFile<%=ipCnt %>" value="">
     		</td>
		</tr>
	
	</tbody>
	</table>
<!-- 지식재산 실적 E -->




<!-- 대외활동 S -->
		<div style="padding-top:15px"></div>
	   	<h2 class="tit">대외활동</h2>
		<div class="zoom">
			<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('activity')" />
			<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('activity')" />
   		</div>
   		<table class="skin_basic_write"  >
   			<caption>대외활동</caption>
            <colgroup>
          		<col style="width:15%" />
          		<col />
          		<col style="width:15%" />
          		<col />
            </colgroup>
		<tbody id="activitylist">
		
			<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">조직(학회)명</th>
         		<td colspan="3"><input type="text" name="acNm" value="" style="width:60%;" class="inp_txt"></td>
         	</tr>
         	<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">참여일</th>
         		<td><input type="text" name="acStart" readonly id="acStart<%=acCnt%>" value=""  style="width:100%;" class="inp_txt"></td>
         		<th scope="row" class="tit">직위</th>
         		<td><input type="text" name="acDept" value="" style="width:100%;" class="inp_txt"></td>
         	</tr>
         	<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">주요업무</th>
         		<!-- td><input type="text" name="acFinish" id="acFinish<%//=acCnt%>" value="<%//=util.getStr(rs.get("AC_FINISH"))%>" style="width:100%;" class="inp_txt"></td-->
         		<td colspan="3"><input type="text" name="acWork" value="" style="width:100%;" class="inp_txt"></td>
         	</tr>
		
		</tbody>
	</table>
<!-- 대외활동 E -->

<!-- 자격사항 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">자격/포상</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('qualification')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('qualification')" />
	</div>
	<table class="skin_basic_write">
		<caption>자격사항</caption>
	    <colgroup>
	    	<col style="width:15%" />
	    	<col />
	    	<col style="width:15%" />
	    	<col />
	    </colgroup>
	<tbody id="qualificationlist">
	
		<tr class="qualification<%=quCnt%>" onclick="setLicenseBtn(<%=quCnt%>, 'qualification')">
       		<th scope="row" class="tit">구분</th>
       		<td colspan="3">
       			<select class="select_box"  name="quDivide" style="width:30%;">
       				<option value="포상">포상</option>
       				<option value="자격증">자격증</option>
       			</select>
       		</td>
       	</tr>
		<tr class="qualification<%=quCnt%>">
			<th scope="row" class="tit">포상/자격증명</th>   	
       		<td><input type="text" name="quNm" value=""  style="width:100%;" class="inp_txt"></td>
       		<th scope="row" class="tit">취득일자</th>
       		<td><input type="text" name="quStart" readonly id="quStart<%=quCnt%>"  value=""  style="width:100%;" class="inp_txt"></td>
       	</tr>
       	<tr class="qualification<%=quCnt%>">
       		<th scope="row" class="tit">발급기관명</th>
       		<td colspan="3"><input type="text" name="quOrgNm" value=""  style="width:100%;" class="inp_txt"></td>
       	</tr>
       	<tr class="qualification<%=quCnt%>" style="border-bottom:3px solid #ddd">
       		<th scope="row" class="tit">증빙서류</th>
       		<td colspan="3">
       			<input type="hidden" name="quFile" id="quFile<%=quCnt%>" value="">
				<input type="file" name="qualificationFile<%=quCnt %>"  id="qualificationFile<%=quCnt %>" value="">
       		</td>
       	</tr>
	
	</tbody>
	</table>
<!-- 자격사항 E -->







<!-- 연구개발과제(프로젝트) 수행실적 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">연구개발과제(프로젝트) 수행실적</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('RnDresult')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('RnDresult')" />
	</div>
	<table class="skin_basic_write">
		<caption>연구개발과제(프로젝트) 수행실적</caption>
	        <colgroup>
		    	<col style="width:15%" />
		    	<col />
		    	<col style="width:15%" />
		    	<col />
		    </colgroup>
       	
 	<tbody id="RnDresultlist">
 	
		<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 수행실적여부</th>
     		<td colspan="3">
     			<label><input type="radio" name="rdType<%=rdCnt%>" value="Y" checked/>있음</label>
     			<label><input type="radio" name="rdType<%=rdCnt%>" value="N"/>없음</label>
     		</td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처/기관/발주처명</th>
     		<td colspan="3"><input type="text" name="rdOrgNm" value="" style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업명</th>
     		<td><input type="text" name="rdBusinessNm" value="" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 과제명</th>
     		<td><input type="text" name="rdNm" value="" style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업시작시간</th>
     		<td><input type="text" name="rdStart" readonly value="" id="rdStart<%=rdCnt%>" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업종료시간</th>
     		<td>
     			<input type="text" name="rdFinish" readonly id="rdFinish<%=rdCnt%>" value="" style="width:60%;" class="inp_txt">
     			<label><input type="checkbox" name="rdIng<%=rdCnt%>"  id="rdIng<%=rdCnt%>" value="1" />진행중</label>
     		</td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')" style='border-bottom:3px solid #ddd'>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 총사업비(단위:백만원)</th>
     		<td><input type="text" name="rdExpenses" value="" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> 참여형태</th>
       		<td>
       			<select class="select_box"   name="rdForm">
       				<option value="">선택</option>
       				<option value="총괄책임자">총괄책임자</option>
       				<option value="참여책임자">참여책임자</option>
       				<option value="위탁책임자">위탁책임자</option>
       				<option value="실무담당자">실무담당자</option>
       				<option value="참여연구원">참여연구원</option>
       			</select>
       		</td>
		</tr>
	
	</tbody>
	</table>
<!-- 연구개발과제(프로젝트) 수행실적 E -->


<!-- 컨설팅 수행실적 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">컨설팅 수행실적</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('resultCon')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('resultCon')" />
	</div>
	<table class="skin_basic_write"  >
		<caption>컨설팅 수행실적</caption>
        <colgroup>
	    	<col style="width:15%" />
	    	<col />
	    	<col style="width:15%" />
	    	<col />
	    </colgroup>
	<tbody id="resultConlist">
		
	
		<tr class="resultCon<%=resultConCnt%>">
			<th scope="row" class="tit"><span style="color:red;" >*</span> 컨설팅 수행실적여부</th>
			<td colspan="3">
     			<label><input type="radio" name="conType<%=resultConCnt%>" value="Y" checked/>있음</label>
     			<label><input type="radio" name="conType<%=resultConCnt%>" value="N"/>없음</label>
     		</td>
		</tr>
    	<tr class="resultCon<%=resultConCnt%>">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span>컨설팅 사업명(컨설팅명)</th>
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=resultConCnt %>" value="" class="inp_txt">
 	  		</td>
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> 요청기관명</th>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=resultConCnt %>" value="" class="inp_txt">
 	  		</td>
 	  	</tr>
 	  	<tr class="resultCon<%=resultConCnt%>">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> 컨설팅 시작시간</th>
 	  		<td>
 	  			<input type="text" name="conSdate" id="conSdate<%=resultConCnt %>" readonly value="" class="inp_txt">
 	  		</td>
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> 컨설팅 종료시간</th>
 	  		<td>
 	  			<input type="text" name="conEdate" id="conEdate<%=resultConCnt %>" readonly value="" style="width:60%" class="inp_txt">
 	  			<label><input type="checkbox" name="conIng<%=resultConCnt%>" id="conIng<%=resultConCnt%>" value="1" />진행중</label>
 	  		</td>
 	  	</tr>
 	  	<tr class="resultCon<%=resultConCnt%>" style="border-bottom:3px solid #ddd">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> 컨설팅내용</th>
   			<td colspan="3">
   				<input type="text" name="conContent" id="conContent<%=resultConCnt %>" value="" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>

	</tbody>
	</table>
<!-- 컨설팅 수행실적 E -->





<!-- 기술분야선택 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">기술분야</h2>
	<table class="skin_basic_write">
		<caption>기술분야</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<th scope="row" class="tit"><span style="color:red;" >*</span> 산업기술분류 1순위</th>
	       	<td colspan="3">
	    			<select class="select_box" name="code_b" id="code_b_1">
					<option value="">산업기술대분류</option>
					<%
					//String Pcode1= (listProCode.size() > 0)?listProCode.get(0).get("P_CODE1"):"";
					
					for(HashMap bz:bizList1){						
					%>
					<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%//=(util.getStr(Pcode1)).equals(util.getStr(bz.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(bz.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="code_m" id="code_m_1">
					<option value="">산업기술중분류</option>
				</select>
				<select class="select_box" name="code_s" id="code_s_1">
					<option value="">산업기술소분류</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">산업기술분류 2순위</th>
	       	<td colspan="3">
	    			<select class="select_box" name="code_b" id="code_b_2">
					<option value="">산업기술대분류</option>
					<%
					//String Pcode2= (listProCode.size() > 1)?listProCode.get(1).get("P_CODE1"):"";
					for(HashMap bz:bizList1){
					%>
					<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%//=(util.getStr(Pcode2)).equals(util.getStr(bz.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(bz.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="code_m" id="code_m_2">
					<option value="">산업기술중분류</option>
				</select>
				<select class="select_box" name="code_s" id="code_s_2">
					<option value="">산업기술소분류</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">산업기술분류 3순위</th>
	       	<td colspan="3">
	    			<select class="select_box" name="code_b" id="code_b_3">
					<option value="">산업기술대분류</option>
					<%
					//String Pcode3= (listProCode.size() > 2)?listProCode.get(2).get("P_CODE1"):"";
					for(HashMap bz:bizList1){						
					%>
					<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%//=(util.getStr(Pcode3)).equals(util.getStr(bz.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(bz.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="code_m" id="code_m_3">
					<option value="">산업기술중분류</option>
				</select>
				<select class="select_box" name="code_s" id="code_s_3">
					<option value="">산업기술소분류</option>
				</select>
	     	</td>
		</tr>
		
		<tr>
			<th scope="row" class="tit"><span style="color:red;" >*</span> 과학기술분류 1순위</th>
	       	<td colspan="3">
	    			<select class="select_box" name="scib" id="scib_1">
					<option value="">과학기술대분류</option>
					<%
					//String scCode1= (listScCode.size() > 0)?listScCode.get(0).get("SC_CODE1"):"";
					for(HashMap sc:scList){						
					%>
					<option value="<%=util.getStr(sc.get("CODE_CD"))%>" <%//=(util.getStr(scCode1)).equals(util.getStr(sc.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(sc.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="scim" id="scim_1">
					<option value="">과학기술중분류</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">과학기술분류 2순위</th>
	       	<td colspan="3">
	    			<select class="select_box" name="scib" id="scib_2">
					<option value="">과학기술대분류</option>
					<%
					//String scCode2= (listScCode.size() > 1)?listScCode.get(1).get("SC_CODE1"):"";
					for(HashMap sc:scList){						
					%>
					<option value="<%=util.getStr(sc.get("CODE_CD"))%>" <%//=(util.getStr(scCode2)).equals(util.getStr(sc.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(sc.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="scim" id="scim_2">
					<option value="">과학기술중분류</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">과학기술분류 3순위</th>
	       	<td colspan="3">
	    			<select class="select_box" name="scib" id="scib_3">
					<option value="">과학기술대분류</option>
					<%
					//String scCode3= (listScCode.size() > 2)?listScCode.get(2).get("SC_CODE1"):"";
					for(HashMap sc:scList){						
					%>
					<option value="<%=util.getStr(sc.get("CODE_CD"))%>" <%//=(util.getStr(scCode3)).equals(util.getStr(sc.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(sc.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="scim" id="scim_3">
					<option value="">과학기술중분류</option>
				</select>
	     	</td>
		</tr>
		</tbody>
	</table>
<!-- 기술분야선택 E -->

<!-- 전문가분야 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">전문가분야</h2>
	<table class="skin_basic_write">
		<caption>전문가분야</caption>
        <colgroup>
	        <col style="width:20%" />
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<th scope="row" class="tit">기술사업화 코디네이터 신청</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro1" id="expert_pro1" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO1")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro1">
				기술사업화 코디네이터에 해당하면 선택하십시오.
				<span style="color:#e15512">* 해당 기술분야 시장성, 사업성평가 전문가(벤처캐피탈, 창업투자 등 관련분야 소속)</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">해외전문가 신청</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro2" id="expert_pro2" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO2")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro2">
				해외전문가에 해당하면 선택하십시오.
				<span style="color:#e15512">* 외국인, 재외한인공학인, 해외기관 근무 경력자, 해외학위 취득자 등</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">IP전문가 신청</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro3" id="expert_pro3" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO3")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro3">
				IP전문가에 해당하면 선택하십시오.
				<span style="color:#e15512">* 변리사, 특허분야 전문가</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">표준인증전문가 신청</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro4" id="expert_pro4" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO4")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro4">
				표준인증전문가에 해당하면 선택하십시오.<br>
				<span style="color:#e15512">* KS, IOS, IEC 등 국내, 국제표준화 업무 전문가(의장, 간사, PROJECT LEADER 등의 수입경력포함)<br/>
				* 표준특허전문가, 표준물질생산, 적합성평가 등 제품인증 분야 전문가, 기타 표준분야 전문가
				</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">안전전문가 신청</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro5" id="expert_pro5" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO5")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro5">
				안전전문가에 해당하면 선택하십시오.<br>
				<span style="color:#e15512">* 전기, 기계, 화학, 가스 등 산업 안전분야 기사, 기술사 자격 소지자<br/>
				* 산업안전분야 관련 기업, 협회, 안전관리전문기관 등에 소속된 자<br/>
				* 소속기관에서 안전분야 관련 업무를 수행하거나 관련 지식을 보유한 자 등
				</span>
				</label>
			</td>
		</tr>
		</tbody>
	</table>
<!-- 전문가분야 E -->

<!-- 정보공개동의 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">정보공개동의</h2>
	<table class="skin_basic_write">
		<caption>정보공개동의</caption>
        <colgroup>
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<td>
				<span style="color:red;" >*</span> 회원님의 정보를 각종 기관/기업에 조회 및 사업 매칭을 위해 중소기업 R&D혁신성장 플랫폼에 공개되는 것에 동의 하십니까?<br/>
				(미 동의시 다른 회원들에게 정보는 공개되지 않습니다.)
				
			</td>
		</tr>
		<tr>
			<td>
				<div style="height:100px; overflow-y:scroll; border:1px solid #ddd; padding:10px 5px;">정보공개동의 내용</div>
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				<label><input type="radio" name="expert_ok" value="Y" checked <%//=(util.getStr(dataMap.get("EXPERT_OK")).equals("Y") || util.getStr(dataMap.get("EXPERT_OK")).equals(null))?"checked":""%>> 정보제공에 동의합니다.</label>
				<label><input type="radio" name="expert_ok" value="N" <%//=(util.getStr(dataMap.get("EXPERT_OK")).equals("N"))?"checked":""%>> 정보제공에 동의하지 않습니다.</label>
			</td>
		</tr>
		</tbody>
	</table>
	
	<table class="skin_basic_write">
		<caption>정보공개동의2</caption>
        <colgroup>
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<td>
				<span style="color:red;" >*</span> 회원님의 정보를 각종 기관/기업에 조회 및 사업 매칭을 위해 중소기업 R&D혁신성장 플랫폼에 공개되는 것에 동의 하십니까?<br/>
				(미 동의시 다른 회원들에게 정보는 공개되지 않습니다.)
				
			</td>
		</tr>
		<tr>
			<td>
				<div style="height:100px; overflow-y:scroll; border:1px solid #ddd; padding:10px 5px;">정보공개동의 내용</div>
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				<label><input type="radio" name="expert_ok2" value="Y" checked <%//=(dataMap.get("EXPERT_OK2").isEmpty() || (util.getStr(dataMap.get("EXPERT_OK2")).equals("Y") || util.getStr(dataMap.get("EXPERT_OK2")).equals(null)))?"checked":""%>> 정보제공에 동의합니다.</label>
				<label><input type="radio" name="expert_ok2" value="N" <%//=(util.getStr(dataMap.get("EXPERT_OK2")).equals("N"))?"checked":""%>> 정보제공에 동의하지 않습니다.</label>
			</td>
		</tr>
		</tbody>
	</table>
<!-- 정보공개동의 E -->


<!-- 개인정보이용동의 S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">개인정보 이용 동의서</h2>
	<table class="skin_basic_write">
		<caption>개인정보 이용 동의서</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col style="width:35%" />
	        <col style="width:15%" />
	        <col style="width:35%" />
        </colgroup>
        <tbody>
		
		<tr>
			<th scope="row" class="tit">승인일자</th>
			<td>
				<%=util.getStr(dataMap.get("EX_COMFIRM_SDATE")).equals("")?"-":util.getStr(dataMap.get("EX_COMFIRM_SDATE"))%>
			</td>
			<th scope="row" class="tit">만료일자</th>
			<td>
				<%=util.getStr(dataMap.get("EX_COMFIRM_EDATE")).equals("")?"-":util.getStr(dataMap.get("EX_COMFIRM_EDATE"))%>
			</td>
		</tr>
		</tbody>
	</table>
<!-- 개인정보이용동의 E -->



              <!-- bo_btn  -->
              <div class="btn_right_box" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_inp_b_01" value="등록하기" onclick="goCheck()"/>
                     <% if(util.getStr(paramMap.get("xt")).equals("1")){ %>
                     <input type="button" class="btn_inp_w_01" value="이전" onclick="history.go(-1)"/>
                     <% }else{ %>
                     <input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
                     <% } %>
              </div>
              <!--// bo_btn -->
</form>



<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^가-힣]/;
	var characPattern = /[^a-zA-Z0-9^가-힣]/;
	var engPattern  = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var datePattern = /^[0-9]{4}-[0-9]{2}/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
	var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	
	
	
	
	$("#code_b").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 2;
		var mode = "biz";
		
		$.post("/sys/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("#code_m").find("option").remove().end().append("<option value=''>산업기술중분류</option>");
				$("#code_s").find("option").remove().end().append("<option value=''>산업기술소분류</option>");
				
				$.each(data.dataList,function(idx,obj){
					html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
				});
				$("#code_m").append(html);
			}
		},"JSON");
	});
	
	$("#code_m").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 3;
		var mode = "biz";
		
		$.post("/sys/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("#code_s").find("option").remove().end().append("<option value=''>산업기술소분류</option>");
				
				$.each(data.dataList,function(idx,obj){
					html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
				});
				$("#code_s").append(html);
			}
		},"JSON");
	});
	
	
	
	
	

	function goSubmit(mode,proState){
		$('#proState').val(proState);
		$('#mode').val(mode);
		$('#fwrite').submit();
    }
//팝업창 검색시 사용
	function userInfo(){
		$('#mode').val("write");
	    $('#fwrite').submit();
	}
//사진미등록 선택 S
	$("#photoCheck").click(function() {
		if($("#photoCheck").val() == null || $("#photoCheck").val() == "" ||$("#photoCheck").val() == "on" ||$("#photoCheck").val() == "Y"){
			$("#photoCheck").val("N");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDiv').hide();
		}else{
			$("#photoCheck").val("Y");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDiv').show();
		}
	});
//사진미등록 선택 E
//기본정보-출생지역 S
	function areaClick(no){
		var mode ="ProUserBirthplace";
		if(no =="2"){

			$("#"+mode+"1").val("");

			$("#"+mode+"1").attr("name","0");
			$("#"+mode+"2").attr("name",mode);
			$("#"+mode+"1").hide();
			$("#"+mode+"2").show();
		}else{
			$("#"+mode+"2").val("");
			$("#"+mode+"2").attr("name","0");
			$("#"+mode+"1").attr("name",mode);
			$("#"+mode+"2").hide();
			$("#"+mode+"1").show();
		}
	}
//기본정보-출생지역 E
//학력정보-전공분야 S
	function majorDeth1(mode){
		var result = "";
		var mode = mode;
		if(mode == "exRealm"){
			var deth1 = $('select[name=exMajor]:last').val();
		}else if(mode == "pluralExRealm"){
			var deth1 = $('select[name=pluralExMajor]:last').val();
		}
		$.ajax({
	            type: "POST",
	            data : {
	           	 deth1 : deth1
	            },
	            url : '/sys/dethCheck.do',
	            dataType : 'json',
	            success : function(data){
	           	result += "<option value=''>선택하세요.</option>";
	           	for(i=0; i<data.cnt; i++){
					result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
				}
	           	$('select[name='+mode+']:last').val("");
	           	$('select[name='+mode+']:last').append(result);
	            }
	   	});
	}
//학력정보-전공분야 E
//신청하기-데이터 체크 S
	function goCheck(){
		var imgFormat = "\.(bmp|gif|jpg|jpeg|png|BMP|GIF|JPG|JJPEG|PNG)$";
        var fileCount = $("input[type=file]").length;
		/*
        if($("#photoCheck").is(":checked") == false){
           	for(i=1;i<=fileCount;i++){
           		if((new RegExp(imgFormat)).test($('#<%=fileFullGrp%>File'+i).val()) && $('#<%=fileFullGrp%>File'+i).val() != ""){

           		}else if($('#<%=fileFullGrp%>File'+i).val() == ""){
           			alert("파일을 첨부하세요.");
           			return false;
           		}else{
           			alert("이미지 파일만 첨부하실 수 있습니다.");
           			return false;
           		}
           	}
		}
		*/
		
		$("#email").val($('#mail1').val()+"@"+$('#mail2').val());
		$("#telNo").val($('#tel1').val()+"-"+$('#tel2').val()+"-"+$('#tel3').val());
		$("#cpNo").val($('#cp1').val()+"-"+$('#cp2').val()+"-"+$('#cp3').val());
		
		if($('#birthDate').val() == "" || $('#birthDate').val() == null || $('#email').val() == "" || $('#email').val() == null || $('#telNo').val() == "" || $('#telNo').val() == null || $('#cpNo').val() == "" || $('#cpNo').val() == null ){
			alert("기본정보는 필수 값 입니다.");
			return false;
		}
		
		if($('input[name=proJntisConsulting]').is(":checked") == false && $('input[name=proJntisMarketing]').is(":checked") == false && $('input[name=proJntisPlanning]').is(":checked") == false && $('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
			alert("전문가구분을 선택해주세요");
			return false;
		}
		
		
		if($("#code_b").val() == "" || $("#code_b").val() == null ){
			
			alert("산업기술 대분류를 선택하세요.");
			return false;
		}
		
		if($("#code_m").val() == "" || $("#code_m").val() == null ){
			
			alert("산업기술 중분류를 선택하세요.");
			return false;
		}
		
		
		if($("#code_s").val() == "" || $("#code_s").val() == null ){
			
			alert("산업기술 소분류를 선택하세요.");
			return false;
		}
		
		
		if( $(':radio[name="Area"]:checked').val() == 2 ){
			if( $('#ProUserBirthplace2').val() == null || $('#ProUserBirthplace2').val() == "" ){
				alert('기본정보(출생지역)은 필수 값입니다!');
				$('#ProUserBirthplace2').focus();
				return;
			}
		}else{
			
			if( $('#ProUserBirthplace1').val() == null || $('#ProUserBirthplace1').val() == "" ){
				alert('기본정보(출생지역)은 필수 값입니다.');
				$('#ProUserBirthplace1').focus();
				return;
			}
		}
		if(phonePattern.test($("#telNo").val()) == false){
			alert("기본정보(전화번호) : ex)061-0000-0000");
			return false;
		}
		if(mobilePhonePattern.test($("#cpNo").val()) == false){
			alert("기본정보(휴대전화) : ex)010-0000-0000");
			return false;
		}
		if(isNaN($("#birthDate").val())){
			alert("기본정보(출생년도) : ex)2016");
			return false;
		}
		
		
		
		if($('input[name=team_1]').is(":checked") == false && $('input[name=team_2]').is(":checked") == false && $('input[name=team_3]').is(":checked") == false && $('input[name=team_4]').is(":checked") == false && $('input[name=team_5]').is(":checked") == false && $('input[name=team_6]').is(":checked") == false && $('input[name=team_7]').is(":checked") == false && $('input[name=team_8]').is(":checked") == false ){
			alert("소속기관유형을 선택해주세요");
			return false;
		}
		
		
		if($('input[name=scNm]:last').val() == "" || $('input[name=scNm]:last').val() == null || $('input[name=scLocation]:last').val() == "" || $('input[name=scLocation]:last').val() == null || $('input[name=scStart]:last').val() == "" || $('input[name=scStart]:last').val() == null || $('input[name=scFinish]:last').val() == "" || $('input[name=scFinish]:last').val() == null || $('select[name=scDegree]:last').val() == "" || $('select[name=scDegree]:last').val() == null){
			alert("학력정보는 필수 값 입니다.");
			$('input[name=scNm]:last').focus();
			return false;
		}
		if($('select[name=exMajor]:last').val() == "" || $('select[name=exMajor]:last').val() == null ||$('select[name=exRealm]:last').val() == "" || $('select[name=exRealm]:last').val() == null || $('input[name=exDetail]:last').val() == "" || $('input[name=exDetail]:last').val() == null ){
			alert("전공계열은 필수 값 입니다.");
			$('input[name=exDetail]:last').focus();
			return false;
		}
		if($('input[name=crNm]:last').val() == "" || $('input[name=crNm]:last').val() == null || $('input[name=crLocation]:last').val() == "" || $('input[name=crLocation]:last').val() == null || $('input[name=crStart]:last').val() == "" || $('input[name=crStart]:last').val() == null || $('input[name=crFinish]:last').val() == "" || $('input[name=crFinish]:last').val() == null ||  $('input[name=crDept]:last').val() == "" || $('input[name=crDept]:last').val() == null ||  $('input[name=crWork]:last').val() == "" || $('input[name=crWork]:last').val() == null ){
			alert("경력정보는 필수 값 입니다.");
			$('input[name=crNm]:last').focus();
			return false;
		}
		
		$("input[name=crCheck]:checked").each(function() {
			var selId = $(this).val();
			$("#crFinish"+selId).val("재직 중");	
		});
		
        if($('input[name=scStart]:last').val() != "" && $('input[name=scStart]:last').val() != null){
			if(datePattern.test($('input[name=scStart]:last').val()) == false){
				alert("학력정보(기간) : ex) 2016-01");
				$('input[name=scStart]:last').focus();
				return false;
			}
        }
        if($('input[name=scFinish]:last').val() != "" && $('input[name=scFinish]:last').val() != null){
			if(datePattern.test($('input[name=scFinish]:last').val()) == false){
					alert("학력정보(기간) : ex) 2016-01");
					$('input[name=scFinish]:last').focus();
					return false;
			}
	    }
			if($('input[name=crStart]:last').val() != "" && $('input[name=crStart]:last').val() != null){
				if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
			}
			/*
			if($('input[name=crFinish]:last').val() != "" && $('input[name=crFinish]:last').val() != null){
				if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
			}
			*/
			if($('input[name=acStart]:last').val() != "" && $('input[name=acStart]:last').val() != null){
				if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
					return false;
				}
			}
			if($('input[name=acFinish]:last').val() != "" && $('input[name=acFinish]:last').val() != null){
				if(datePattern.test($('input[name=acFinish]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=rdStart]:last').val() != "" && $('input[name=rdStart]:last').val() != null){
				if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
			}
			if($('input[name=rdFinish]:last').val() != "" && $('input[name=rdFinish]:last').val() != null){
				if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=rdExpenses]:last').val() != "" && $('input[name=rdExpenses]:last').val() != null){
				if(isNaN($('input[name=rdExpenses]:last').val())){
					alert("연구개발과제(프로젝트) 수행실적(사업비) : 숫자만 입력해주세요. ex)10000");
					$('input[name=rdExpenses]:last').focus();
					return false;
				}
			}
			if($('input[name=quStart]:last').val() != "" && $('input[name=quStart]:last').val() != null){
				if(datePattern.test($('input[name=quStart]:last').val()) == false){
					alert("자격사항(취득일) : ex) 2016-01");
					$('input[name=quStart]:last').focus();
					return false;
				}
			}
			if($('input[name=rpStart]:last').val() != "" && $('input[name=rpStart]:last').val() != null){
				if(datePattern.test($('input[name=rpStart]:last').val()) == false){
					alert("연구논문 실적(게제년도) : ex) 2016-01");
					$('input[name=rpStart]:last').focus();
					return false;
				}
			}

			if($('input[name=awStart]:last').val() != "" && $('input[name=awStart]:last').val() != null){
				if(datePattern.test($('input[name=awStart]:last').val()) == false){
					alert("수상실적(수여일자) : ex) 2016-01");
					$('input[name=awStart]:last').focus();
					return false;
				}
			}
			if($('input[name=ipStart]:last').val() != "" && $('input[name=ipStart]:last').val() != null){
				if(datePattern.test($('input[name=ipStart]:last').val()) == false){
					alert("지식재산 실적(등록년도) : ex) 2016-01");
					$('input[name=ipStart]:last').focus();
					return false;
				}
			}
			if($('input[name=evSdate]:last').val() != "" && $('input[name=evSdate]:last').val() != null){
				if(datePattern.test($('input[name=evSdate]:last').val()) == false){
					alert("외부평가 수행실적(평가기간) : ex) 2016-01");
					$('input[name=evSdate]:last').focus();
					return false;
				}
			}
			if($('input[name=evEdate]:last').val() != "" && $('input[name=evEdate]:last').val() != null){
				if(datePattern.test($('input[name=evEdate]:last').val()) == false){
					alert("외부평가 수행실적(평가기간) : ex) 2016-01");
					$('input[name=evEdate]:last').focus();
					return false;
				}
			}
			if($('input[name=conSdate]:last').val() != "" && $('input[name=conSdate]:last').val() != null){
				if(datePattern.test($('input[name=conSdate]:last').val()) == false){
					alert("컨설팅 수행실적(평가기간) : ex) 2016-01");
					$('input[name=conSdate]:last').focus();
					return false;
				}
			}
			if($('input[name=conEdate]:last').val() != "" && $('input[name=conEdate]:last').val() != null){
				if(datePattern.test($('input[name=conEdate]:last').val()) == false){
					alert("컨설팅 수행실적(평가기간) : ex) 2016-01");
					$('input[name=conEdate]:last').focus();
					return false;
				}
			}
			
		
		goSubmit('writeProc','10');
	}
//신청하기-데이터 체트 E
//팝업창 S
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=620, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
//팝업창 E
//기본datePicker S
	$("#evSdate0,#evEdate0,#conSdate0,#conEdate0,#scStart0, #scFinish0, #crStart0, #crFinish0, #acStart0, #acFinish0, #rdStart0, #rdFinish0, #quStart0, #awStart0").datepicker({
       	showMonthAfterYear : true,
       	showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	nextText : '다음 달',
       	prevText : '이전 달',

       	closeText : '닫기',
       	dateFormat : "yy-mm",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['월','화','수','목','금','토','일'],
       	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
        }
        //showButtonPanel:true,
		//yearRange: '1980:2020'
	});
	
	
	
	
	$("#rpStart0, #ipStart0").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	//changeMonth : false,
       	changeYear : true,
       	//nextText : '다음 달',
       	//prevText : '이전 달',

       	closeText : '닫기',
       	dateFormat : "yy",
       	//dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	//dayNamesMin : ['월','화','수','목','금','토','일'],
       	//monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	//monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
       	onClose: function(dateText, inst) {
            //var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year,1));
        }
        //showButtonPanel:true,
		//yearRange: '1980:2020'
	});
	
	$("#rpStart0, #ipStart0").focus(function () {
        $(".ui-datepicker-month").hide();
});
	
//기본datePicker E
//addRow S
	function addRow(mode){
   		if(mode=="academic"){
    			var StartId = $('input[name=scStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=scNm]:last').val() == ""){
    				alert("학교명을 입력 해주세요");
    				$('input[name=scNm]:last').focus();
    				return false;
    			}

    			if($('input[name=scLocation]:last').val() == ""){
    				$('input[name=scLocation]:last').focus();
    				alert("소재지을 입력 해주세요");
    				return false;
    			}

    			if($('input[name=scStart]:last').val() == "" || $('input[name=scFinish]:last').val() == "" ){
    				$('input[name=scStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=scStart]:last').val()) == false){
					alert("학력정보(기간) : ex) 2016-01");
					$('input[name=scStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=scFinish]:last').val()) == false){
					alert("학력정보(기간) : ex) 2016-01");
					$('input[name=scFinish]:last').focus();
					return false;
				}

    			if($('input[name=scDegree]:last').val() == ""){
    				$('input[name=scDegree]:last').focus();
    				alert("취득학위를 입력 해주세요");
    				return false;
    			}


    			var row = "";
    		 	row += "<tr id='academic_career_info"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='scNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scLocation' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scStart' id='scStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scFinish' id='scFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><select name='scDegree' class='select_box' style='width:100%;' >";
    		 	row += "<option value=''>선택</option>";
    		 	row += "<option value='고졸'>고졸</option>";
    		 	row += "<option value='전문학사'>전문학사</option>";
    		 	row += "<option value='학사'>학사</option>";
    			row += "<option value='석사'>석사</option>";
    			row += "<option value='박사'>박사</option>";
    			row += "</select></td>";
    		   	row += "</tr>";
    		    $("#academiclist").append(row);

    		}else if(mode == "career"){
    			var StartId = $('input[name=crStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=crNm]:last').val() == ""){
    				alert("직장명을 입력 해주세요");
    				$('input[name=crNm]:last').focus();
    				return false;
    			}

    			if($('input[name=crLocation]:last').val() == ""){
    				$('input[name=crLocation]:last').focus();
    				alert("작장 소재지을 입력 해주세요");
    				return false;
    			}

    			if($('input[name=crStart]:last').val() == "" || $('input[name=crFinish]:last').val() == "" ){
    				$('input[name=crStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("경력정보(기간) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
    			if($('input[name=crDept]:last').val() == ""){
    				$('input[name=crDept]:last').focus();
    				alert("최종직위를 입력 해주세요");
    				return false;
    			}

    			if($('input[name=crWork]:last').val() == ""){
    				$('input[name=crWork]:last').focus();
    				alert("주요업무를 입력 해주세요");
    				return false;
    			}

    			var row = "";
    		 	row += "<tr id='career_info"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='crNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crLocation' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crStart' id='crStart"+plusScCnt+"' style='width:60px;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crFinish' id='crFinish"+plusScCnt+"' style='width:60px;' class='inp_txt'>";
    		 	row += "<label><input type='checkbox' name='crCheck' id='crCheck"+plusScCnt+"' value='"+plusScCnt+"' />재직중</label>";
    		 	row += "</td>";
    		 	row += "<td><input type='text' name='crDept' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crWork' style='width:100%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		    $("#careerlist").append(row);

    		}else if(mode == "activity"){
    			var StartId = $('input[name=acStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=acNm]:last').val() == ""){
    				alert("조직(학회)명을 입력 해주세요");
    				$('input[name=acNm]:last').focus();
    				return false;
    			}

    			if($('input[name=acStart]:last').val() == "" || $('input[name=acFinish]:last').val() == "" ){
    				$('input[name=acStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=acFinish]:last').val()) == false){
					alert("대외활동(기간) : ex) 2016-01");
					$('input[name=acFinish]:last').focus();
					return false;
				}
    			if($('input[name=acDept]:last').val() == ""){
    				$('input[name=acDept]:last').focus();
    				alert("직위를 입력 해주세요");
    				return false;
    			}

    			if($('input[name=acWork]:last').val() == ""){
    				$('input[name=acWork]:last').focus();
    				alert("주요업무를 입력 해주세요");
    				return false;
    			}


    			var row = "";
    		 	row += "<tr id='activity"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='acNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acStart' id='acStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acFinish' id='acFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acDept' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='acWork' style='width:100%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		    $("#activitylist").append(row);

    		}else if(mode == "RnDresult"){
    			var StartId = $('input[name=rdStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0으로 자름
    		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
    			/* 입력제어  */
    			if($('input[name=rdSerialNum]:last').val() == ""){
    				alert("연번을 입력 해주세요");
    				$('input[name=rdSerialNum]:last').focus();
    				return false;
    			}
    			if($('input[name=rdOrgNm]:last').val() == ""){
    				alert("부처/기관명/발주처명을 입력 해주세요");
    				$('input[name=rdOrgNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdBusinessNm]:last').val() == ""){
    				alert("사업명을 입력 해주세요");
    				$('input[name=rdBusinessNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdNm]:last').val() == ""){
    				alert("과제명을 입력 해주세요");
    				$('input[name=rdNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdStart]:last').val() == "" || $('input[name=rdFinish]:last').val() == "" ){
    				$('input[name=rdStart]:last').focus();
    				alert("기간을 입력 해주세요");
    				return false;
    			}
    			if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
					alert("연구개발과제(프로젝트) 수행실적(기간) : ex) 2016-01");
					$('input[name=rdFinish]:last').focus();
					return false;
				}
    			if($('input[name=rdExpenses]:last').val() == ""){
    				$('input[name=rdExpenses]:last').focus();
    				alert("사업비를 입력 해주세요");
    				return false;
    			}
    			if(isNaN($('input[name=rdExpenses]:last').val())){
					alert("연구개발과제(프로젝트) 수행실적(사업비) : 숫자만 입력해주세요. ex)10000");
					$('input[name=rdExpenses]:last').focus();
					return false;
				}
    			if($('select[name=rdForm]:last').val() == ""){
    				$('select[name=rdForm]:last').focus();
    				alert("참여형태를 선택 해주세요");
    				return false;
    			}

    			var row = "";
    		 	row += "<tr id='RnDresult"+plusScCnt+"'>";
    		 	row += "<td ><input type='text' name='rdSerialNum' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td ><input type='text' name='rdOrgNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td ><input type='text' name='rdBusinessNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td ><input type='text' name='rdNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='rdStart' id='rdStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='rdFinish' id='rdFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='rdExpenses' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><select name='rdForm' class='select_box'>";
    		 	row += "<option value=''>선택</option>";
    		 	row += "<option value='총괄책임자'>총괄책임자</option>";
    		 	row += "<option value='참여or위탁책임자'>참여or위탁책임자</option>";
    		 	row += "<option value='실무담당자'>실무담당자</option>";
    			row += "<option value='참여연구원'>참여연구원</option>";
    			row += "</select></td>";
    		   	row += "</tr>";
    		    $("#RnDresultlist").append(row);

    		}else if(mode == "qualification"){
   			var StartId = $('input[name=quStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=quSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=quSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=quStart]:last').val() == "" ){
   				$('input[name=quStart]:last').focus();
   				alert("취득일을 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=quStart]:last').val()) == false){
				alert("자격사항(취득일) : ex) 2016-01");
				$('input[name=quStart]:last').focus();
				return false;
			}
   			if($('input[name=quOrgNm]:last').val() == ""){
   				$('input[name=quOrgNm]:last').focus();
   				alert("발급기관명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=quDivide]:last').val() == ""){
   				$('select[name=quDivide]:last').focus();
   				alert("자격구분을 선택 해주세요");
   				return false;
   			}
   			if($('input[name=quNm]:last').val() == ""){
   				$('input[name=quNm]:last').focus();
   				alert("자격명을 입력 해주세요");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='qualification"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='quSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='quStart' id='quStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='quOrgNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box' name='quDivide' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='국가공인'>국가공인</option>";
   		 	row += "<option value='국제공인'>국제공인</option>";
   			row += "<option value='시설가격'>시설가격</option>";
   			row += "</select>";
   			row += "</td>";
   		 	row += "<td><input type='text' name='quNm' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#qualificationlist").append(row);

  		}else if(mode == "research"){
  			var StartId = $('input[name=reNote]:last').attr('id');
  			var cnt = StartId.substring(7,8); //0으로 자름
  		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
  			var option = $('#reDeth1'+cnt).html();
		if($('select[name=reDeth1]:last').val() == ""){
  				$('select[name=reDeth1]:last').focus();
  				alert("대분류를 선택 해주세요");
  				return false;
  			}

		if($('select[name=reDeth2]:last').val() == ""){
  				$('select[name=reDeth2]:last').focus();
  				alert("중분류를 선택 해주세요");
  				return false;
  			}

		if($('select[name=reDeth3]:last').val() == ""){
  				$('select[name=reDeth3]:last').focus();
  				alert("소분류를 선택 해주세요");
  				return false;
  			}
  			var row = "";
  		 	row += "<tr id='research"+plusScCnt+"'>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth1' id='reDeth1"+plusScCnt+"' onchange=\"standardDeth1('reDeth2"+plusScCnt+"')\">"+option+"</select></td>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth2' id='reDeth2"+plusScCnt+"' onchange=\"standardDeth2('reDeth3"+plusScCnt+"')\"></select></td>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth3' id='reDeth3"+plusScCnt+"'></select></td>";
  		 	row += "<td colspan='2'><input type='text' name='reNote' id='resNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='비고'></td>";
  		   	row += "</tr>";
  		    $("#researchlist").append(row);

   		}else if(mode == "evaluate"){
   			var StartId = $('input[name=evNote]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   		    var option = $('#evDeth1'+cnt).html();

   			var row = "";

   			if($('select[name=evDeth1]:last').val() == ""){
   				$('select[name=evDeth1]:last').focus();
   				alert("대분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=evDeth2]:last').val() == ""){
   				$('select[name=evDeth2]:last').focus();
   				alert("중분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=evDeth3]:last').val() == ""){
   				$('select[name=evDeth3]:last').focus();
   				alert("소분류를 선택 해주세요");
   				return false;
   			}
   		 	row += "<tr id='evaluate"+plusScCnt+"'>";
   		 	row += "<td><select class='select_box' style='width:100%' name='evDeth1' id='evDeth1"+plusScCnt+"' onchange=\"standardDeth1('evDeth2"+plusScCnt+"')\">"+option+"</select></td>";
   		 	row += "<td><select class='select_box' style='width:100%' name='evDeth2' id='evDeth2"+plusScCnt+"' onchange=\"standardDeth2('evDeth3"+plusScCnt+"')\"></select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='evDeth3' id='evDeth3"+plusScCnt+"' ></select></td>";
   		 	row += "<td colspan='2'><input type='text' name='evNote' id='evlNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='비고'></td>";
   		   	row += "</tr>";
   		    $("#evaluatelist").append(row);

   		}else if(mode == "consulting"){
   			var StartId = $('input[name=coNote]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   		    var option = $('#coDeth1'+cnt).html();
			if($('select[name=coDeth1]:last').val() == ""){
   				$('select[name=coDeth1]:last').focus();
   				alert("대분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=coDeth2]:last').val() == ""){
   				$('select[name=coDeth2]:last').focus();
   				alert("중분류를 선택 해주세요");
   				return false;
   			}

			if($('select[name=coDeth3]:last').val() == ""){
   				$('select[name=coDeth3]:last').focus();
   				alert("소분류를 선택 해주세요");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='consulting"+plusScCnt+"'>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth1' id='coDeth1"+plusScCnt+"' onchange=\"standardDeth1('coDeth2"+plusScCnt+"')\">"+option+"</select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth2' id='coDeth2"+plusScCnt+"' onchange=\"standardDeth2('coDeth3"+plusScCnt+"')\"></select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth3' id='coDeth3"+plusScCnt+"'></select></td>";
   		 	row += "<td colspan='2'><input type='text' name='conNote' id='conNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='비고'></td>";
   		   	row += "</tr>";
   		    $("#consultinglist").append(row);

   		}else if(mode == "researchPaper"){
   			var StartId = $('input[name=rpStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=rpSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=rpSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=rpStart]:last').val() == "" ){
   				$('input[name=rpStart]:last').focus();
   				alert("게제년도를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=rpStart]:last').val()) == false){
				alert("연구논문 실적(게제년도) : ex) 2016-01");
				$('input[name=rpStart]:last').focus();
				return false;
			}
   			if($('input[name=rpJournalNm]:last').val() == ""){
   				$('input[name=rpJournalNm]:last').focus();
   				alert("학술지명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=rpNm]:last').val() == ""){
   				$('select[name=rpNm]:last').focus();
   				alert("논문명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=rpType]:last').val() == ""){
   				$('select[name=rpType]:last').focus();
   				alert("논문유형을 선택 해주세요");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='researchPaper"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='rpSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='rpNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box' name='rpType' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='국내학술지'>국내학술지</option>";
   		 	row += "<option value='국내학술대회'>국내학술대회</option>";
   		 	row += "<option value='국외학술지'>국외학술지</option>";
   		 	row += "<option value='국외학술대회'>국외학술대회</option>";
   			row += "<option value='기타학술지'>기타학술지</option>";
   			row += "</select>";
   			row += "</td>";
   			row += "<td><input type='text' name='rpJournalNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='rpStart' id='rpStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#researchPaperlist").append(row);

   		}else if(mode == "inProperty"){
   			var StartId = $('input[name=ipStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=ipSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=ipSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=ipNm]:last').val() == ""){
   				$('input[name=ipNm]:last').focus();
   				alert("지식재산명을 입력 해주세요");
   				return false;
   			}
   			if($('select[name=ipType]:last').val() == ""){
   				$('select[name=ipType]:last').focus();
   				alert("지식재산유형을 선택 해주세요");
   				return false;
   			}
   			if($('input[name=ipPubliccation]:last').val() == ""){
   				$('input[name=ipPubliccation]:last').focus();
   				alert("인증/발행처를 입력 해주세요");
   				return false;
   			}
   			if($('input[name=ipStart]:last').val() == "" ){
   				$('input[name=ipStart]:last').focus();
   				alert("등록년도를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=ipStart]:last').val()) == false){
				alert("지식재산 실적(등록년도) : ex) 2016-01");
				$('input[name=ipStart]:last').focus();
				return false;
			}
   			var row = "";
   		 	row += "<tr id='inProperty"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='ipSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='ipNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box'  name='ipType' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='특허'>특허</option>";
   		 	row += "<option value='실용실안'>실용실안</option>";
   			row += "<option value='상표'>상표</option>";
   			row += "<option value='디자인'>디자인</option>";
   			row += "<option value='프로그램'>프로그램</option>";
   			row += "<option value='저작권'>저작권</option>";
   			row += "<option value='기타지식재산'>기타지식재산</option>";
   			row += "</select>";
   			row += "</td>";
   			row += "<td><input type='text' name='ipPublication' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='ipStart' id='ipStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#inPropertylist").append(row);

   		}else if(mode == "awardCareer"){
   			var StartId = $('input[name=awStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=awSerialNum]:last').val() == ""){
   				alert("연번을 입력 해주세요");
   				$('input[name=awSerialNum]:last').focus();
   				return false;
   			}
   		    if($('select[name=awBadge]:last').val() == ""){
   				$('select[name=awBadge]:last').focus();
   				alert("훈격을 선택 해주세요");
   				return false;
   			}
   			if($('input[name=awStart]:last').val() == "" ){
   				$('input[name=awStart]:last').focus();
   				alert("수여일자를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=awStart]:last').val()) == false){
				alert("수상실적(수여일자) : ex) 2016-01");
				$('input[name=awStart]:last').focus();
				return false;
			}

   			if($('input[name=awPresent]:last').val() == ""){
   				$('input[name=awPresent]:last').focus();
   				alert("수여기관을 입력 해주세요");
   				return false;
   			}
   			if($('input[name=awContent]:last').val() == ""){
   				$('input[name=awContent]:last').focus();
   				alert("공적내용을 입력 해주세요");
   				return false;
   			}

   			var row = "";
   		 	row += "<tr id='awardCareer"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='awSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box'  name='awBadge' style='width:100%;'>";
   		 	row += "<option value='''>선택하세요</option>";
   		 	row += "<option value='훈장'>훈장</option>";
   		 	row += "<option value='포장'>포장</option>";
   			row += "<option value='표창'>표창</option>";
   			row += "</select>";
   			row += "</td>";
   		 	row += "<td><input type='text' name='awStart' id='awStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='awPresent' style='width:100%;' class='inp_txt'></td>";
   			row += "<td><input type='text' name='awContent' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#awardCareerlist").append(row);

   		}else if(mode == "resultEv"){
   			var StartId = $('input[name=evSdate]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0으로 자름
   		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
   			/* 입력제어  */
   			if($('input[name=evName]:last').val() == ""){
   				alert("평가대상 사업명(평가명)을 입력 해주세요");
   				$('input[name=evName]:last').focus();
   				return false;
   			}
   		    if($('select[name=evOrg]:last').val() == ""){
   				$('select[name=evOrg]:last').focus();
   				alert("요청기관명을 입력 해주세요");
   				return false;
   			}
   			if($('input[name=evSdate]:last').val() == "" ){
   				$('input[name=evSdate]:last').focus();
   				alert("평가기간를 선택 해주세요");
   				return false;
   			}
   			if($('input[name=evEdate]:last').val() == "" ){
   				$('input[name=evEdate]:last').focus();
   				alert("평가기간를 선택 해주세요");
   				return false;
   			}
   			if(datePattern.test($('input[name=evSdate]:last').val()) == false){
				alert("평가기간 : ex) 2016-01");
				$('input[name=evSdate]:last').focus();
				return false;
			}
   			if(datePattern.test($('input[name=evEdate]:last').val()) == false){
				alert("평가기간 : ex) 2016-01");
				$('input[name=evEdate]:last').focus();
				return false;
			}
   			if($('input[name=evContent]:last').val() == ""){
   				$('input[name=evContent]:last').focus();
   				alert("평가내용을 입력 해주세요");
   				return false;
   			}

   			var row = "";
   		 	row += "<tr id='resultEv"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='evName' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='evOrg' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='evSdate' id='evSdate"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='evEdate' id='evEdate"+plusScCnt+"'  style='width:100%;' class='inp_txt'></td>";
   			row += "<td><input type='text' name='evContent' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#resultEvlist").append(row);
  		}else if(mode == "resultCon"){
  			var StartId = $('input[name=conSdate]:last').attr('id');
  			var cnt = StartId.substring(8,9); //0으로 자름
  		    var plusScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
  			/* 입력제어  */
  			if($('input[name=conName]:last').val() == ""){
  				alert("컨설팅 사업명(컨설팅명)을 입력 해주세요");
  				$('input[name=conName]:last').focus();
  				return false;
  			}
  		    if($('select[name=conOrg]:last').val() == ""){
  				$('select[name=conOrg]:last').focus();
  				alert("요청기관명을 입력 해주세요");
  				return false;
  			}
  			if($('input[name=conSdate]:last').val() == "" ){
  				$('input[name=conSdate]:last').focus();
  				alert("평가기간를 선택 해주세요");
  				return false;
  			}
  			if($('input[name=conEdate]:last').val() == "" ){
  				$('input[name=conEdate]:last').focus();
  				alert("평가기간를 선택 해주세요");
  				return false;
  			}
  			if(datePattern.test($('input[name=conSdate]:last').val()) == false){
				alert("컨설팅기간 : ex) 2016-01");
				$('input[name=conSdate]:last').focus();
				return false;
			}
  			if(datePattern.test($('input[name=conEdate]:last').val()) == false){
				alert("컨설팅기간 : ex) 2016-01");
				$('input[name=conEdate]:last').focus();
				return false;
			}
  			if($('input[name=conContent]:last').val() == ""){
  				$('input[name=conContent]:last').focus();
  				alert("컨설팅내용을 입력 해주세요");
  				return false;
  			}
  			var row = "";
  		 	row += "<tr id='resultCon"+plusScCnt+"'>";
  		 	row += "<td><input type='text' name='conName' style='width:100%;' class='inp_txt'></td>";
  		 	row += "<td><input type='text' name='conOrg' style='width:100%;' class='inp_txt'></td>";
  		 	row += "<td><input type='text' name='conSdate' id='conSdate"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
  		 	row += "<td><input type='text' name='conEdate' id='conEdate"+plusScCnt+"'  style='width:100%;' class='inp_txt'></td>";
  			row += "<td><input type='text' name='conContent' style='width:100%;' class='inp_txt'></td>";
  		   	row += "</tr>";
  		    $("#resultConlist").append(row);
  		}
    	//date
		setLicenseBtn(plusScCnt, mode);
	}
//addRow E
//delRow S
	function delRow(mode){
   		if(mode=="academic"){
   			if($('input[name=scNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=scNm]').size() - 1;
   			var parenttr = $("#academic_career_info"+delCnt).remove();
   		}else if(mode == "career"){
   			if($('input[name=crNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=crNm]').size() - 1;
   			var parenttr = $("#career_info"+delCnt).remove();
   		}else if(mode == "activity"){
   			if($('input[name=acNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=acNm]').size() - 1;
   			var parenttr = $("#activity"+delCnt).remove();
   		}else if(mode == "RnDresult"){
   			if($('input[name=rdNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=rdNm]').size() - 1;
   			var parenttr = $("#RnDresult"+delCnt).remove();
   		}else if(mode == "qualification"){
   			if($('input[name=quNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=quNm]').size() - 1;
   			var parenttr = $("#qualification"+delCnt).remove();
   		}else if(mode == "research"){
   			if($('input[name=reNote]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=reNote]').size() - 1;
   			var parenttr = $("#research"+delCnt).remove();

   		}else if(mode == "evaluate"){
   			if($('input[name=evNote]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=evNote]').size() - 1;
   			var parenttr = $("#evaluate"+delCnt).remove();

   		}else if(mode == "consulting"){
   			if($('input[name=coNote]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=coNote]').size() - 1;
   			var parenttr = $("#consulting"+delCnt).remove();

   		}else if(mode == "researchPaper"){
   			if($('input[name=rpNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=rpNm]').size() - 1;
   			var parenttr = $("#researchPaper"+delCnt).remove();

   		}else if(mode == "inProperty"){
   			if($('input[name=ipNm]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=ipNm]').size() - 1;
   			var parenttr = $("#inProperty"+delCnt).remove();

   		}else if(mode == "awardCareer"){
   			if($('input[name=awStart]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=awStart]').size() - 1;
   			var parenttr = $("#awardCareer"+delCnt).remove();
   		}else if(mode == "resultEv"){
   			if($('input[name=evSdate]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=evSdate]').size() - 1;
   			var parenttr = $("#resultEv"+delCnt).remove();
   		}else if(mode == "resultCon"){
   			if($('input[name=conSdate]').size() == 1){
   				alert("삭제 할 수 없습니다.");
   				return false;
   			};
   			var delCnt = $('input[name=conSdate]').size() - 1;
   			var parenttr = $("#resultCon"+delCnt).remove();
   		}
   		setLicenseBtn();
   	}
//delRow E
//addRow시 datePicker S
	function setLicenseBtn(plusScCnt, mode){
    	/* DatePicker 설정 */
   		var date ="";
   		if(mode == "academic"){
   			date = "#scStart"+plusScCnt+", #scFinish"+plusScCnt;
   		}else if(mode == "career"){
   			date = "#crStart"+plusScCnt+", #crFinish"+plusScCnt;
   		}else if(mode == "activity"){
   			date = "#acStart"+plusScCnt+", #acFinish"+plusScCnt;
   		}else if(mode == "RnDresult"){
   			date = "#rdStart"+plusScCnt+", #rdFinish"+plusScCnt;
   		}else if(mode == "qualification"){
   			date = "#quStart"+plusScCnt;
   		}else if(mode == "researchPaper"){
   			date = "#rpStart"+plusScCnt;
   		}else if(mode == "inProperty"){
   			date = "#ipStart"+plusScCnt;
   		}else if(mode == "awardCareer"){
   			date = "#awStart"+plusScCnt;
   		}else if(mode == "resultEv"){
   			date = "#evSdate"+plusScCnt+", #evEdate"+plusScCnt;
   		}else if(mode == "resultCon"){
   			date = "#conSdate"+plusScCnt+", #conEdate"+plusScCnt;
   		}

		$(date).datepicker({
			showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',

			closeText : '닫기',
			dateFormat : "yy-mm",
			dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
			dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ],
			 onClose: function(dateText, inst) {
		            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
		            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
		            $(this).datepicker('setDate', new Date(year, month, 1));
		        }

			//showButtonPanel:true,
			//yearRange: '1980:2020'
		});
	};
	
	
	$("#emailDomainChoise").change(function() {
		if(this.value==""){
			$("#mail2").css("background-color","");
			$("#mail2").removeAttr("readonly");
			$("#mail2").val("");
		}else{
			$("#mail2").val(this.value);
			$("#mail2").css("background-color", "#EEEEEE");
			$("#mail2").attr("readonly", true);
		}
	});
//addRow시 datePicker E
</script>