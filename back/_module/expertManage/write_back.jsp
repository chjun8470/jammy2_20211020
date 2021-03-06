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
       
       
%>
<style  scoped>
.ui-datepicker-calendar {
    display: none;
    }
button.ui-datepicker-current { display: none; }
</style>


<jsp:useBean id="currTime" class="java.util.Date" />



<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	<input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID")) %>" />
	<input type="hidden" name="proState" id="proState" value="" />
	<div class="skin_bbs_write" style="margin-top: 30px">
	<p style="color:red;"><span style="color:red;" >*</span>) ?????? ?????????????????????.</p>

<!-- ???????????? S -->
	<h2 class="tit">????????????</h2>
	<div class="zoom">
	<input type="button" value="????????????" class="btn_inp_b_01" onclick="popupWindow('exUserList')" >
	</div>
	<table class="skin_basic_write" >
		<caption>????????????</caption>
	        <colgroup>
	              <col style="width:15%" />
	              <col style="width:35%" />
	              <col style="width:15%" />
	              <col style="width:35%" />
	        </colgroup>
            <tbody>
            	<tr>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
            		<td>
            			<input type="text" name="psnNm" id="psnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" class="inp_txt" maxlength="20">
            		</td>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
            		<td>
            			<!-- input type="text" name="GenderTypeCd" id="GenderTypeCd"  value="<%=util.getStr(dataMap.get("GENDER_TYPE_CD")) %>" class="inp_txt" maxlength="20"-->
						<select name="GenderTypeCd" id="GenderTypeCd" class="select_box">
							<option>??????</option>
							<option>??????</option>
						</select>
            		</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
            		<td>
            			<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
            			<%if(util.getStr(dataMap.get("BIRTH_DATE")).equals("")||util.getStr(dataMap.get("BIRTH_DATE")).equals(null)){ %>
            			<select name="birthDate" id="birthDate" class="select_box">
            			<option value="">??????</option>
            			<c:forEach var="i" begin="1950" end="${currTime}">
            				<option value="${i}">${i}</option>
            			</c:forEach>
						</select>
            			<%}else{ 
            				String births = util.getStr(dataMap.get("BIRTH_DATE")).substring(0,4);
            			%>
            			
            			<select name="birthDate" id="birthDate" class="select_box">
            			<option value="">??????</option>
            			<c:forEach var="idx" begin="1950" end="${currTime}">
            				<c:set var="birthx" value="<%=births%>" />
            				<option value="${idx}" ${idx == birthx?'selected="selected"':''} >${idx}</option>            				
            			</c:forEach>
						</select>
						<%}  %>
            		<!-- 
            			<%if(util.getStr(dataMap.get("BIRTH_DATE")).equals("")||util.getStr(dataMap.get("BIRTH_DATE")).equals(null)){ %>
            				<input type="text" name="birthDate" id="birthDate"  class="inp_txt" style="width:100%;" maxlength="100">EX)1988?????? => 1988
            			<%}else{ %>
            				<input type="text" name="birthDate" id="birthDate"  value="<% if(util.getStr(dataMap.get("BIRTH_DATE")).length() > 4){ out.println( util.getStr(dataMap.get("BIRTH_DATE")).substring(0,4) );  }else{ out.println( util.getStr(dataMap.get("BIRTH_DATE")) ); } %>" class="inp_txt" style="border:0px;"  readonly  maxlength="4">
            			<%} %>
            		 -->
            		</td>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> email</th>
            		<td>
            			<input type="hidden" name="email" id="email"  value="" class="inp_txt" maxlength="20">
            			<%if(util.getStr(dataMap.get("EMAIL")).equals("")||util.getStr(dataMap.get("EMAIL")).equals(null)){ %>
            			
            			<input type="text" name="mail1" id="mail1" value="" class="inp_txt" style="width:35%"  maxlength="20" title="??????????????????"> @
						<input type="text" name="mail2" id="mail2" value="" class="inp_txt" style="width:30%"  maxlength="50" title="??????????????????">
						<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="??????????????????????????????" >
							<option value="" selected="selected">????????????</option>
							<option value="gmail.com">?????????</option>
							<option value="empal.com">?????????</option>
							<option value="naver.com">?????????</option>
							<option value="hanmail.net">??????</option>
							<option value="hotmail.com">?????????</option>
							<option value="yahoo.co.kr">??????</option>
							<option value="nate.com">?????????</option>
						</select>
            			
            			<%}else{%>
            			
            			<%
            				int xidx = util.getStr(dataMap.get("EMAIL")).indexOf("@");
            				String mail1 = util.getStr(dataMap.get("EMAIL")).substring(0,xidx);
            				String mail2 = util.getStr(dataMap.get("EMAIL")).substring(xidx+1);
            			%>
           				<input type="text" name="mail1" id="mail1" value="<%=mail1%>" class="inp_txt" style="width:35%"  maxlength="20" title="??????????????????"> @
						<input type="text" name="mail2" id="mail2" value="<%=mail2%>" class="inp_txt" style="width:30%"  maxlength="50" title="??????????????????">
						<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="??????????????????????????????" >
							<option value="" <%if(mail2.equals("") || mail2.equals(null) ) { %> selected="selected" <% } %>>????????????</option>
							<option value="gmail.com" <%if(mail2.equals("gmail.com")) { %> selected="selected" <% } %>>?????????</option>
							<option value="empal.com" <%if(mail2.equals("empal.com")) { %> selected="selected" <% } %>>?????????</option>
							<option value="naver.com" <%if(mail2.equals("naver.com")) { %> selected="selected" <% } %>>?????????</option>
							<option value="hanmail.net" <%if(mail2.equals("hanmail.net")) { %> selected="selected" <% } %>>??????</option>
							<option value="hotmail.com" <%if(mail2.equals("hotmail.com")) { %> selected="selected" <% } %>>?????????</option>
							<option value="yahoo.co.kr" <%if(mail2.equals("yahoo.co.kr")) { %> selected="selected" <% } %>>??????</option>
							<option value="nate.com" <%if(mail2.equals("nate.com")) { %> selected="selected" <% } %>>?????????</option>
						</select>
            			<% } %>
            		</td>
            	</tr>
            	<tr>
            		<!-- 
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
            		<td>
            			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
            				if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
            					<input type="text" name="proUserForg" id="proUserForg"  class="inp_txt" style="width:100%;" maxlength="100">
            				<%}else{%>
            					<input type="text" name="proUserForg" id="proUserForg"  value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>" class="inp_txt" style="width:100%;"  readonly style="border:0px;" >
            				<%} %>
            			<%}else{ %>
			            		<input type="text" name="proUserForg" id="proUserForg"  value="????????????" class="inp_txt" readonly style="border:0px;" >
            			<%} %>
            		</td>
            		 -->
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
            		<td colspan="3">
           					&nbsp;&nbsp;???????????? <input type="radio" name="area" value="1"  checked="checked" onclick="areaClick('1')"/>
							&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="area" value="2"  onclick="areaClick('2')"/>&nbsp;&nbsp;
							<select class="select_box" name="ProUserBirthplace" id="ProUserBirthplace1">
								<option value="">???????????????</option>
								<%
									int utilitynumArea = 1;
									for(HashMap rs:areaSigunguList) {
									%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% utilitynumArea++; } %>
							</select>
							<select class="select_box" name="0" id="ProUserBirthplace2" style="display:none;">
								<option value="">???????????????</option>
								<%
									int utilitynumArea2 = 1;
									for(HashMap rs:areaList) {
									%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% utilitynumArea2++; } %>
							</select>
            		</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
            		<td>
            			<input type="hidden" name="telNo" id="telNo"  value="" class="inp_txt"  maxlength="20">
            			<%if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
            				<select name="tel1" id="tel1" class="select_box" title="????????????????????? ??????">
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
							<input type="text" name="tel2" id="tel2" value="" maxlength="4" size="5" class="inp_txt" title="??????????????? ?????????"> -
							<input type="text" name="tel3" id="tel3" value="" maxlength="4" size="5" class="inp_txt" title="??????????????? ?????????">
            			<%
            			}else{ 
            				String telox = util.getStr(dataMap.get("TEL_NO"));
            				String telA[] = telox.split("-"); 
            			%>
            			
            				<select name="tel1" id="tel1" class="select_box" title="????????????????????? ??????" style="width:30%">
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
							<input type="text" name="tel2" id="tel2" value="<%=telA[1]%>" maxlength="4" style="width:30%" class="inp_txt" title="??????????????? ?????????"> -
							<input type="text" name="tel3" id="tel3" value="<%=telA[2]%>" maxlength="4" style="width:30%" class="inp_txt" title="??????????????? ?????????">
            				
            			<%} %>
	         		</td>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
            		<td>
            			<input type="hidden" name="cpNo" id="cpNo"  value="" class="inp_txt" style="border:0px;"  maxlength="20">
            			<%if(util.getStr(dataMap.get("CP_NO")).equals("")||util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
            				<select name="cp1" id="cp1" class="select_box"  style="width: 30%" title="????????? ??????">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> -
							<input type="text" name="cp2" id="cp2" value="" style="width:30%" maxlength="4"  class="inp_txt" title="????????? ?????????"> -
							<input type="text" name="cp3" id="cp3" value="" style="width:30%" maxlength="4"  class="inp_txt" title="????????? ?????????">
            			<%
            			}else{
            				String cpox = util.getStr(dataMap.get("CP_NO"));
            				String cpA[] = cpox.split("-"); 
            			%>
            				<select name="cp1" id="cp1" class="select_box"  style="width: 30%" title="????????? ??????">
								<option value="010" <%if(cpA[0].equals("010")) { %> selected="selected" <% } %>>010</option>
								<option value="011" <%if(cpA[0].equals("011")) { %> selected="selected" <% } %>>011</option>
								<option value="016" <%if(cpA[0].equals("016")) { %> selected="selected" <% } %>>016</option>
								<option value="017" <%if(cpA[0].equals("017")) { %> selected="selected" <% } %>>017</option>
								<option value="018" <%if(cpA[0].equals("018")) { %> selected="selected" <% } %>>018</option>
								<option value="019" <%if(cpA[0].equals("019")) { %> selected="selected" <% } %>>019</option>
							</select> -
							<input type="text" name="cp2" id="cp2" value="<%=cpA[1]%>" style="width:30%" maxlength="4"  class="inp_txt" title="????????? ?????????"> -
							<input type="text" name="cp3" id="cp3" value="<%=cpA[2]%>" style="width:30%" maxlength="4"  class="inp_txt" title="????????? ?????????">
            			<%} %>
         			</td>
            	</tr>
            	<!-- tr>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
                   	<td colspan="3">
                   		<div id="fileDiv">
                   		<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
                        	<div>
                            	<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="????????????" />
                            </div>
                        </div>
                        </div>
						<input type="checkbox" name="photoCheck" id="photoCheck"/>&nbsp;???????????????
                	</td>
            	</tr-->
            	<tr>
      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
            		<td colspan="3">
						???????????? <input type="checkbox" name="proJntisPlanning" value="Y" />&nbsp;&nbsp;
						???????????? <input type="checkbox" name="proJntisRnd" value="Y" />&nbsp;&nbsp;
						???????????? <input type="checkbox" name="proJntisCompany" value="Y" />&nbsp;&nbsp;
						???????????? <input type="checkbox" name="proJeinet" value="Y" />&nbsp;&nbsp;
						???????????? <input type="checkbox" name="proJipbank" value="Y" />&nbsp;&nbsp;
						???????????? <input type="checkbox" name="proJntisEducation" value="Y" />&nbsp;&nbsp;
						????????? <input type="checkbox" name="proJntisConsulting" value="Y" />&nbsp;&nbsp;
						????????? <input type="checkbox" name="proJntisMarketing" value="Y" />&nbsp;&nbsp;
						?????? <input type="checkbox" name="proJntisEtc" value="Y" />&nbsp;&nbsp;
					</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
	            	<td colspan="3">
	         			<select class="select_box" name="code_b" id="code_b">
							<option value="">?????????????????????</option>
							<%
							for(HashMap bz:bizList1){
							%>
							<option value="<%=util.getStr(bz.get("CODE_CD"))%>"><%=util.getStr(bz.get("CODE_NM"))%></option>
							<% 
							}
							%>
						</select>
						<select class="select_box" name="code_m" id="code_m">
							<option value="">?????????????????????</option>
						</select>
						<select class="select_box" name="code_s" id="code_s">
							<option value="">?????????????????????</option>
						</select>
	           		</td>
	           	</tr>
            	
            	<tr>
      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
            		<td colspan="3">
					<% for(HashMap te:teamList){ %>
						<%=util.getStr(te.get("CODE_NM"))%> <input type="checkbox" name="team_<%=util.getStr(te.get("CODE_CD"))%>" value="Y" />
					<% } %>	
					</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">????????????</th>
            		<td colspan="3">
						<textarea name="proUserInterestWorld" style="width:100%"></textarea>
					</td>
            	</tr>
     		</tbody>
	   	</table>
<!-- ???????????? E -->

<!-- ???????????? S -->
<%if(!(util.getStr(dataMap.get("ORG_GRP_CD"))).equals("") && !(util.getStr(dataMap.get("ORG_GRP_CD"))).equals(null)){ %>
        <div style="padding-top:15px"></div>
        <h2 class="tit">????????????</h2>
        <table class="skin_basic_write" >
       		<caption>????????????</caption>
            <colgroup>
                  <col style="width:15%" />
                  <col style="width:35%" />
                  <col style="width:15%" />
                  <col style="width:35%" />
            </colgroup>
            <tbody>
	           	<tr>
	           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
	           		</td>
	           		<th scope="row" class="tit">????????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("ORG_TYPE")) %>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">????????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("HOMEPAGE")) %>
	           		</td>
	           		<th scope="row" class="tit">????????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("CORP_PHONE")) %>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" class="tit">?????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("DEPT_NM")) %>
	           		</td>
	           		<th scope="row" class="tit">??????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("POSITION_NM")) %>
	           		</td>
	           	</tr>
            </tbody>
	   	</table>
<%} %>
<!-- ???????????? E -->
<!-- ???????????? S -->
<div style="padding-top:15px"></div>
		<h2 class="tit">????????????</h2>
        <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('academic')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('academic')" /></div>
   		<table class="skin_basic_write"  >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:25%" />
          		<col style="width:25%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:25%" />
            </colgroup>
         	<tr>
         		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
         		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
         		<th scope="row" class="tit" colspan="2"><span style="color:red;" >*</span> ??????</th>
         		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
         	</tr>
		<tbody id="academiclist">
            <tr id="academic_career_info<%=scCnt%>">
          		<td><input type="text" name="scNm"  style="width:100%;" class="inp_txt"></td>
          		<td><input type="text" name="scLocation" style="width:100%;" class="inp_txt"></td>
          		<td><input type="text" name="scStart" id="scStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
          		<td><input type="text" name="scFinish" id="scFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scDegree">
						<option value="">???????????????</option>
						<option value="??????">??????</option>
						<option value="????????????">????????????</option>
						<option value="??????">??????</option>
						<option value="??????">??????</option>
						<option value="??????">??????</option>
						<option value="??????">??????</option>
					</select>
				</td>
          	</tr>
   		</tbody>
		</table>
		<h3>??? ????????????</h3>
		<table class="skin_basic_write"  >
		<caption>????????????</caption>
		<colgroup>
			  <col style="width:15%" />
			  <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		</colgroup>
		<tr>
			<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			<td>
				<select class="select_box"  style="width:100%;" name="exMajor" onchange="majorDeth1('exRealm')" >
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			<td>
				<select class="select_box"  style="width:100%;" name="exRealm"></select>
			</td>
			<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			<td>
				<input type="text" name="exDetail" style="width:100%;" class="inp_txt">
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">??????????????????</th>
			<td>
				<select class="select_box"  style="width:100%;" name="pluralExMajor" onchange="majorDeth1('pluralExRealm')">
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" class="tit">??????????????????</th>
			<td>
				<select class="select_box"  style="width:100%;" name="pluralExRealm" ></select>
			</td>
			<th scope="row" class="tit">???????????????</th>
			<td>
				<input type="text" name="pluralExDetail" style="width:100%;" class="inp_txt">
			</td>
		</tr>
	</table>

<!-- ???????????? E -->
		<div style="padding-top:15px"></div>
        <h2 class="tit">????????????</h2>
        <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('career')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('career')" />
        </div>
   		<table class="skin_basic_write"  >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:20%" />
          		<col style="width:15%" />
          		<col style="width:6%" />
          		<col style="width:14%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
<!-- ???????????? S -->
          	<tr>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
          		<th scope="row" class="tit" colspan="2"><span style="color:red;" >*</span> ??????</th>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			</tr>
		<tbody id="careerlist">
        	<tr id="career_info<%=scCnt%>">
				<td><input type="text" name="crNm"  style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crLocation" style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crStart" id="crStart<%=scCnt%>" style="width:60px;" class="inp_txt"></td>
				<td>
					<input type="text" name="crFinish" id="crFinish<%=scCnt%>" style="width:60px;" class="inp_txt">
					<label><input type="checkbox" name="crCheck" id="crCheck<%=scCnt%>"  value="<%=scCnt%>" />?????????</label>
				</td>
				<td><input type="text" name="crDept" style="width:100%;" class="inp_txt"></td>
				<td><input type="text" name="crWork" style="width:100%;" class="inp_txt"></td>
            </tr>
		</tbody>
<!-- ???????????? E -->
		</table>
		<div style="padding-top:15px"></div>
        <h2 class="tit">????????????</h2>
        <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('activity')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('activity')" /></div>
   		<table class="skin_basic_write"  >
   			<caption>????????????</caption>
            <colgroup>
          		<col style="width:35%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
<!-- ???????????? S -->
           	<tr>
           		<th scope="row" class="tit">??????(??????)???</th>
           		<th scope="row" class="tit" colspan="2">??????</th>
           		<th scope="row" class="tit">??????</th>
           		<th scope="row" class="tit">????????????</th>
           	</tr>
		<tbody id="activitylist">
         	<tr id="activity<%=scCnt%>">
         		<td><input type="text" name="acNm" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acStart" id="acStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acFinish" id="acFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acDept" style="width:100%;" class="inp_txt"></td>
         		<td><input type="text" name="acWork" style="width:100%;" class="inp_txt"></td>
         	</tr>
		</tbody>
	</table>
<!-- ???????????? E -->
<!-- ???????????? S -->
<%-- 	<div style="padding-top:15px"></div>
        <h2 class="tit">????????????</h2>
	<table class="skin_basic_write"  >
		<caption>????????????</caption>
		<colgroup>
			  <col style="width:15%" />
			  <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		</colgroup>
		<tr>
			<td colspan="6">
				???????????? <input type="checkbox" name="policyPlan" value="Y" />&nbsp;&nbsp;
				???????????? <input type="checkbox" name="researchDev" value="Y" />&nbsp;&nbsp;
				???????????? <input type="checkbox" name="companySupport" value="Y" />&nbsp;&nbsp;
				???????????? <input type="checkbox" name="jip" value="Y" />&nbsp;&nbsp;
				???????????? <input type="checkbox" name="jnsp" value="Y" />&nbsp;&nbsp;
				???????????? <input type="checkbox" name="training" value="Y" />&nbsp;&nbsp;
				???????????? <input type="checkbox" name="baseContracture" value="Y" />&nbsp;&nbsp;
				????????? <input type="checkbox" name="consulting" value="Y" />&nbsp;&nbsp;
				????????? <input type="checkbox" name="marketing" value="Y" />
			</td>
		</tr>
	</table> --%>
<!-- ???????????? E -->
<!-- ??????????????????(????????????) ???????????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">??????????????????(????????????) ????????????</h2>
	<div class="zoom"><input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('RnDresult')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('RnDresult')" /></div>
	<table class="skin_basic_write">
		<caption>??????????????????(????????????) ????????????</caption>
	        <colgroup>
	              <col style="width:10%" />
	              <col style="width:15%" />
	              <col style="width:15%" />
	              <col style="width:15%" />
	              <col style="width:10%" />
	              <col style="width:10%" />
	              <col style="width:10%" />
	              <col style="width:15%" />
	        </colgroup>
       	<tr>
       		<th scope="row" class="tit">??????</th>
       		<th scope="row" class="tit">??????/??????/????????????</th>
       		<th scope="row" class="tit">?????????</th>
       		<th scope="row" class="tit">?????????</th>
       		<th scope="row" class="tit" colspan="2">?????????????????????</th>
       		<th scope="row" class="tit">?????????</th>
       		<th scope="row" class="tit">????????????</th>
       	</tr>
 	<tbody id="RnDresultlist">
     	<tr id="RnDresult<%=scCnt%>">
     		<td><input type="text" name="rdSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdOrgNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdBusinessNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdStart" id="rdStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdFinish" id="rdFinish<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rdExpenses" style="width:100%;" class="inp_txt"></td>
       		<td>
       			<select class="select_box"   name="rdForm">
       				<option value="">??????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="???????????????">???????????????</option>
       			</select>
       		</td>
		</tr>
	</tbody>
	</table>
<!-- ??????????????????(????????????) ???????????? E -->
<!-- ???????????? ???????????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">???????????? ????????????</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('resultEv')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('resultEv')" /></div>
	<table class="skin_basic_write"  >
		<caption>???????????? ????????????</caption>
        <colgroup>
        	<col style="width:30%" />
		    <col style="width:20%" />
		    <col style="width:10%" />
		    <col style="width:10%" />
		    <col style="width:30%" />
        </colgroup>
	<tbody id="resultEvlist">
		<tr>
	 		<th scope="row" class="tit">???????????? ?????????(?????????)</th>
	 		<th scope="row" class="tit">???????????????</th>
	 		<th scope="row" class="tit" colspan="2">????????????</th>
	 		<th scope="row" class="tit">????????????</th>
	 	</tr>
    	<tr id="resultEv<%=scCnt%>">
 	  		<td>
 	  			<input type="text" name="evName" id="evName<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evOrg" id="evOrg<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evSdate" id="evSdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
   			<td>
   				<input type="text" name="evContent" id="evContent<%=scCnt %>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
	</tbody>
	</table>
<!-- ???????????? ???????????? E -->
<!-- ????????? ???????????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">????????? ????????????</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('resultCon')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('resultCon')" /></div>
	<table class="skin_basic_write"  >
		<caption>????????? ????????????</caption>
        <colgroup>
        	<col style="width:30%" />
		    <col style="width:20%" />
		    <col style="width:10%" />
		    <col style="width:10%" />
		    <col style="width:30%" />
        </colgroup>
	<tbody id="resultConlist">
		<tr>
	 		<th scope="row" class="tit">????????? ?????????(????????????)</th>
	 		<th scope="row" class="tit">???????????????</th>
	 		<th scope="row" class="tit" colspan="2">???????????????</th>
	 		<th scope="row" class="tit">???????????????</th>
	 	</tr>
    	<tr id="resultCon<%=scCnt%>">
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conSdate" id="conSdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conEdate" id="conEdate<%=scCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
   			<td>
   				<input type="text" name="conContent" id="conContent<%=scCnt %>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
	</tbody>
	</table>
<!-- ????????? ???????????? E -->
<!-- ???????????? ?????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">???????????? ??????</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('researchPaper')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('researchPaper')" /></div>
	<table class="skin_basic_write" >
		<caption>???????????? ??????</caption>
	       <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
	       </colgroup>
       	<tr>
       		<th scope="row" class="tit">??????</th>
       		<th scope="row" class="tit">?????????</th>
       		<th scope="row" class="tit">????????????</th>
       		<th scope="row" class="tit">????????????</th>
       		<th scope="row" class="tit">????????????</th>

       	</tr>
 	<tbody id="researchPaperlist">
     	<tr id="researchPaper<%=scCnt%>">
     		<td><input type="text" name="rpSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rpNm" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="rpType" style='width:100%;'>
       				<option value="">??????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????????????????">??????????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????????????????">??????????????????</option>
       				<option value="???????????????">???????????????</option>
       			</select>
     		</td>
     		<td><input type="text" name="rpJournalNm" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="rpStart" id="rpStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
		</tr>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->
<!-- ???????????? ?????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">???????????? ??????</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('inProperty')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('inProperty')" />
    </div>
	<table class="skin_basic_write">
		<caption>???????????? ??????</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
        </colgroup>
       	<tr>
       		<th scope="row" class="tit">??????</th>
       		<th scope="row" class="tit">???????????????</th>
       		<th scope="row" class="tit">??????????????????</th>
       		<th scope="row" class="tit">??????/?????????</th>
       		<th scope="row" class="tit">????????????</th>

       	</tr>
 	<tbody id="inPropertylist">
     	<tr id="inProperty<%=scCnt%>">
     		<td><input type="text" name="ipSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="ipNm" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="ipType" style='width:100%;'>
       				<option value="">??????</option>
       				<option value="??????">??????</option>
       				<option value="????????????">????????????</option>
       				<option value="??????">??????</option>
       				<option value="?????????">?????????</option>
       				<option value="????????????">????????????</option>
       				<option value="?????????">?????????</option>
       				<option value="??????????????????">??????????????????</option>
       			</select>
     		</td>
     		<td><input type="text" name="ipPublication" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="ipStart" id="ipStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
		</tr>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->
<!-- ?????? ?????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">????????????</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('awardCareer')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('awardCareer')" />
    </div>
	<table class="skin_basic_write">
		<caption>?????? ??????</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
        </colgroup>
       	<tr>
       		<th scope="row" class="tit">??????</th>
       		<th scope="row" class="tit">??????</th>
       		<th scope="row" class="tit">????????????</th>
       		<th scope="row" class="tit">????????????</th>
       		<th scope="row" class="tit">????????????</th>

       	</tr>
 	<tbody id="awardCareerlist">
     	<tr id="awardCareer<%=scCnt%>">
     		<td><input type="text" name="awSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="awBadge" style='width:100%;'>
       				<option value="">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart" id="awStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awPresent" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awContent" style="width:100%;" class="inp_txt"></td>
		</tr>
	</tbody>
	</table>
<!-- ?????? ?????? E -->
<!-- ???????????? S -->
	<div style="padding-top:15px"></div>
        <h2 class="tit">????????????</h2>
    <div class="zoom">
	<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('qualification')" />
	<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('qualification')" /></div>
	<table class="skin_basic_write">
		<caption>????????????</caption>
	    <colgroup>
			<col style="width:10%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
		</colgroup>
       	<tr>
       		<th scope="row" class="tit">??????</th>
       		<th scope="row" class="tit">?????????</th>
       		<th scope="row" class="tit">???????????????</th>
       		<th scope="row" class="tit">????????????</th>
       		<th scope="row" class="tit">?????????</th>
       	</tr>
	<tbody id="qualificationlist">
       	<tr id="qualification<%=scCnt%>">
       		<td><input type="text" name="quSerialNum" style="width:100%;" class="inp_txt"></td>
       		<td><input type="text" name="quStart" id="quStart<%=scCnt%>" style="width:100%;" class="inp_txt"></td>
       		<td><input type="text" name="quOrgNm" style="width:100%;" class="inp_txt"></td>
       		<td>
       			<select class="select_box"  name="quDivide" style="width:100%;">
       				<option value="">???????????????</option>
       				<option value="????????????">????????????</option>
       				<option value="????????????">????????????</option>
       				<option value="????????????">????????????</option>
       			</select>
       		</td>
       		<td><input type="text" name="quNm" style="width:100%;" class="inp_txt"></td>
       	</tr>
	</tbody>
	</table>
<!-- ???????????? E -->
	</div>
    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="????????????" onclick="goCheck()"/>
           <input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
    </div>
    <!--// bo_btn -->
</form>


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^???-???]/;
	var characPattern = /[^a-zA-Z0-9^???-???]/;
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
				
				$("#code_m").find("option").remove().end().append("<option value=''>?????????????????????</option>");
				$("#code_s").find("option").remove().end().append("<option value=''>?????????????????????</option>");
				
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
				
				$("#code_s").find("option").remove().end().append("<option value=''>?????????????????????</option>");
				
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
//????????? ????????? ??????
	function userInfo(){
		$('#mode').val("write");
	    $('#fwrite').submit();
	}
//??????????????? ?????? S
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
//??????????????? ?????? E
//????????????-???????????? S
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
//????????????-???????????? E
//????????????-???????????? S
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
	           	result += "<option value=''>???????????????.</option>";
	           	for(i=0; i<data.cnt; i++){
					result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
				}
	           	$('select[name='+mode+']:last').val("");
	           	$('select[name='+mode+']:last').append(result);
	            }
	   	});
	}
//????????????-???????????? E
//????????????-????????? ?????? S
	function goCheck(){
		var imgFormat = "\.(bmp|gif|jpg|jpeg|png|BMP|GIF|JPG|JJPEG|PNG)$";
        var fileCount = $("input[type=file]").length;
		/*
        if($("#photoCheck").is(":checked") == false){
           	for(i=1;i<=fileCount;i++){
           		if((new RegExp(imgFormat)).test($('#<%=fileFullGrp%>File'+i).val()) && $('#<%=fileFullGrp%>File'+i).val() != ""){

           		}else if($('#<%=fileFullGrp%>File'+i).val() == ""){
           			alert("????????? ???????????????.");
           			return false;
           		}else{
           			alert("????????? ????????? ???????????? ??? ????????????.");
           			return false;
           		}
           	}
		}
		*/
		
		$("#email").val($('#mail1').val()+"@"+$('#mail2').val());
		$("#telNo").val($('#tel1').val()+"-"+$('#tel2').val()+"-"+$('#tel3').val());
		$("#cpNo").val($('#cp1').val()+"-"+$('#cp2').val()+"-"+$('#cp3').val());
		
		if($('#birthDate').val() == "" || $('#birthDate').val() == null || $('#email').val() == "" || $('#email').val() == null || $('#telNo').val() == "" || $('#telNo').val() == null || $('#cpNo').val() == "" || $('#cpNo').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
			return false;
		}
		
		if($('input[name=proJntisConsulting]').is(":checked") == false && $('input[name=proJntisMarketing]').is(":checked") == false && $('input[name=proJntisPlanning]').is(":checked") == false && $('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
			alert("?????????????????? ??????????????????");
			return false;
		}
		
		
		if($("#code_b").val() == "" || $("#code_b").val() == null ){
			
			alert("???????????? ???????????? ???????????????.");
			return false;
		}
		
		if($("#code_m").val() == "" || $("#code_m").val() == null ){
			
			alert("???????????? ???????????? ???????????????.");
			return false;
		}
		
		
		if($("#code_s").val() == "" || $("#code_s").val() == null ){
			
			alert("???????????? ???????????? ???????????????.");
			return false;
		}
		
		
		if( $(':radio[name="Area"]:checked').val() == 2 ){
			if( $('#ProUserBirthplace2').val() == null || $('#ProUserBirthplace2').val() == "" ){
				alert('????????????(????????????)??? ?????? ????????????!');
				$('#ProUserBirthplace2').focus();
				return;
			}
		}else{
			
			if( $('#ProUserBirthplace1').val() == null || $('#ProUserBirthplace1').val() == "" ){
				alert('????????????(????????????)??? ?????? ????????????.');
				$('#ProUserBirthplace1').focus();
				return;
			}
		}
		if(phonePattern.test($("#telNo").val()) == false){
			alert("????????????(????????????) : ex)061-0000-0000");
			return false;
		}
		if(mobilePhonePattern.test($("#cpNo").val()) == false){
			alert("????????????(????????????) : ex)010-0000-0000");
			return false;
		}
		if(isNaN($("#birthDate").val())){
			alert("????????????(????????????) : ex)2016");
			return false;
		}
		
		
		
		if($('input[name=team_1]').is(":checked") == false && $('input[name=team_2]').is(":checked") == false && $('input[name=team_3]').is(":checked") == false && $('input[name=team_4]').is(":checked") == false && $('input[name=team_5]').is(":checked") == false && $('input[name=team_6]').is(":checked") == false && $('input[name=team_7]').is(":checked") == false && $('input[name=team_8]').is(":checked") == false ){
			alert("????????????????????? ??????????????????");
			return false;
		}
		
		
		if($('input[name=scNm]:last').val() == "" || $('input[name=scNm]:last').val() == null || $('input[name=scLocation]:last').val() == "" || $('input[name=scLocation]:last').val() == null || $('input[name=scStart]:last').val() == "" || $('input[name=scStart]:last').val() == null || $('input[name=scFinish]:last').val() == "" || $('input[name=scFinish]:last').val() == null || $('select[name=scDegree]:last').val() == "" || $('select[name=scDegree]:last').val() == null){
			alert("??????????????? ?????? ??? ?????????.");
			$('input[name=scNm]:last').focus();
			return false;
		}
		if($('select[name=exMajor]:last').val() == "" || $('select[name=exMajor]:last').val() == null ||$('select[name=exRealm]:last').val() == "" || $('select[name=exRealm]:last').val() == null || $('input[name=exDetail]:last').val() == "" || $('input[name=exDetail]:last').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
			$('input[name=exDetail]:last').focus();
			return false;
		}
		if($('input[name=crNm]:last').val() == "" || $('input[name=crNm]:last').val() == null || $('input[name=crLocation]:last').val() == "" || $('input[name=crLocation]:last').val() == null || $('input[name=crStart]:last').val() == "" || $('input[name=crStart]:last').val() == null || $('input[name=crFinish]:last').val() == "" || $('input[name=crFinish]:last').val() == null ||  $('input[name=crDept]:last').val() == "" || $('input[name=crDept]:last').val() == null ||  $('input[name=crWork]:last').val() == "" || $('input[name=crWork]:last').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
			$('input[name=crNm]:last').focus();
			return false;
		}
		
		$("input[name=crCheck]:checked").each(function() {
			var selId = $(this).val();
			$("#crFinish"+selId).val("?????? ???");	
		});
		
        if($('input[name=scStart]:last').val() != "" && $('input[name=scStart]:last').val() != null){
			if(datePattern.test($('input[name=scStart]:last').val()) == false){
				alert("????????????(??????) : ex) 2016-01");
				$('input[name=scStart]:last').focus();
				return false;
			}
        }
        if($('input[name=scFinish]:last').val() != "" && $('input[name=scFinish]:last').val() != null){
			if(datePattern.test($('input[name=scFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=scFinish]:last').focus();
					return false;
			}
	    }
			if($('input[name=crStart]:last').val() != "" && $('input[name=crStart]:last').val() != null){
				if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
			}
			/*
			if($('input[name=crFinish]:last').val() != "" && $('input[name=crFinish]:last').val() != null){
				if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
			}
			*/
			if($('input[name=acStart]:last').val() != "" && $('input[name=acStart]:last').val() != null){
				if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
					return false;
				}
			}
			if($('input[name=acFinish]:last').val() != "" && $('input[name=acFinish]:last').val() != null){
				if(datePattern.test($('input[name=acFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=acFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=rdStart]:last').val() != "" && $('input[name=rdStart]:last').val() != null){
				if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("??????????????????(????????????) ????????????(??????) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
			}
			if($('input[name=rdFinish]:last').val() != "" && $('input[name=rdFinish]:last').val() != null){
				if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
					alert("??????????????????(????????????) ????????????(??????) : ex) 2016-01");
					$('input[name=rdFinish]:last').focus();
					return false;
				}
			}
			if($('input[name=rdExpenses]:last').val() != "" && $('input[name=rdExpenses]:last').val() != null){
				if(isNaN($('input[name=rdExpenses]:last').val())){
					alert("??????????????????(????????????) ????????????(?????????) : ????????? ??????????????????. ex)10000");
					$('input[name=rdExpenses]:last').focus();
					return false;
				}
			}
			if($('input[name=quStart]:last').val() != "" && $('input[name=quStart]:last').val() != null){
				if(datePattern.test($('input[name=quStart]:last').val()) == false){
					alert("????????????(?????????) : ex) 2016-01");
					$('input[name=quStart]:last').focus();
					return false;
				}
			}
			if($('input[name=rpStart]:last').val() != "" && $('input[name=rpStart]:last').val() != null){
				if(datePattern.test($('input[name=rpStart]:last').val()) == false){
					alert("???????????? ??????(????????????) : ex) 2016-01");
					$('input[name=rpStart]:last').focus();
					return false;
				}
			}

			if($('input[name=awStart]:last').val() != "" && $('input[name=awStart]:last').val() != null){
				if(datePattern.test($('input[name=awStart]:last').val()) == false){
					alert("????????????(????????????) : ex) 2016-01");
					$('input[name=awStart]:last').focus();
					return false;
				}
			}
			if($('input[name=ipStart]:last').val() != "" && $('input[name=ipStart]:last').val() != null){
				if(datePattern.test($('input[name=ipStart]:last').val()) == false){
					alert("???????????? ??????(????????????) : ex) 2016-01");
					$('input[name=ipStart]:last').focus();
					return false;
				}
			}
			if($('input[name=evSdate]:last').val() != "" && $('input[name=evSdate]:last').val() != null){
				if(datePattern.test($('input[name=evSdate]:last').val()) == false){
					alert("???????????? ????????????(????????????) : ex) 2016-01");
					$('input[name=evSdate]:last').focus();
					return false;
				}
			}
			if($('input[name=evEdate]:last').val() != "" && $('input[name=evEdate]:last').val() != null){
				if(datePattern.test($('input[name=evEdate]:last').val()) == false){
					alert("???????????? ????????????(????????????) : ex) 2016-01");
					$('input[name=evEdate]:last').focus();
					return false;
				}
			}
			if($('input[name=conSdate]:last').val() != "" && $('input[name=conSdate]:last').val() != null){
				if(datePattern.test($('input[name=conSdate]:last').val()) == false){
					alert("????????? ????????????(????????????) : ex) 2016-01");
					$('input[name=conSdate]:last').focus();
					return false;
				}
			}
			if($('input[name=conEdate]:last').val() != "" && $('input[name=conEdate]:last').val() != null){
				if(datePattern.test($('input[name=conEdate]:last').val()) == false){
					alert("????????? ????????????(????????????) : ex) 2016-01");
					$('input[name=conEdate]:last').focus();
					return false;
				}
			}
			
		
		goSubmit('writeProc','10');
	}
//????????????-????????? ?????? E
//????????? S
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=620, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
//????????? E
//??????datePicker S
	$("#evSdate0,#evEdate0,#conSdate0,#conEdate0,#scStart0, #scFinish0, #crStart0, #crFinish0, #acStart0, #acFinish0, #rdStart0, #rdFinish0, #quStart0, #awStart0").datepicker({
       	showMonthAfterYear : true,
       	showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	nextText : '?????? ???',
       	prevText : '?????? ???',

       	closeText : '??????',
       	dateFormat : "yy-mm",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
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
       	//nextText : '?????? ???',
       	//prevText : '?????? ???',

       	closeText : '??????',
       	dateFormat : "yy",
       	//dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	//dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
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
	
//??????datePicker E
//addRow S
	function addRow(mode){
   		if(mode=="academic"){
    			var StartId = $('input[name=scStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
    			/* ????????????  */
    			if($('input[name=scNm]:last').val() == ""){
    				alert("???????????? ?????? ????????????");
    				$('input[name=scNm]:last').focus();
    				return false;
    			}

    			if($('input[name=scLocation]:last').val() == ""){
    				$('input[name=scLocation]:last').focus();
    				alert("???????????? ?????? ????????????");
    				return false;
    			}

    			if($('input[name=scStart]:last').val() == "" || $('input[name=scFinish]:last').val() == "" ){
    				$('input[name=scStart]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=scStart]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=scStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=scFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=scFinish]:last').focus();
					return false;
				}

    			if($('input[name=scDegree]:last').val() == ""){
    				$('input[name=scDegree]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}


    			var row = "";
    		 	row += "<tr id='academic_career_info"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='scNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scLocation' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scStart' id='scStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='scFinish' id='scFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><select name='scDegree' class='select_box' style='width:100%;' >";
    		 	row += "<option value=''>??????</option>";
    		 	row += "<option value='??????'>??????</option>";
    		 	row += "<option value='????????????'>????????????</option>";
    		 	row += "<option value='??????'>??????</option>";
    			row += "<option value='??????'>??????</option>";
    			row += "<option value='??????'>??????</option>";
    			row += "</select></td>";
    		   	row += "</tr>";
    		    $("#academiclist").append(row);

    		}else if(mode == "career"){
    			var StartId = $('input[name=crStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
    			/* ????????????  */
    			if($('input[name=crNm]:last').val() == ""){
    				alert("???????????? ?????? ????????????");
    				$('input[name=crNm]:last').focus();
    				return false;
    			}

    			if($('input[name=crLocation]:last').val() == ""){
    				$('input[name=crLocation]:last').focus();
    				alert("?????? ???????????? ?????? ????????????");
    				return false;
    			}

    			if($('input[name=crStart]:last').val() == "" || $('input[name=crFinish]:last').val() == "" ){
    				$('input[name=crStart]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
    			if($('input[name=crDept]:last').val() == ""){
    				$('input[name=crDept]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}

    			if($('input[name=crWork]:last').val() == ""){
    				$('input[name=crWork]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}

    			var row = "";
    		 	row += "<tr id='career_info"+plusScCnt+"'>";
    		 	row += "<td><input type='text' name='crNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crLocation' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crStart' id='crStart"+plusScCnt+"' style='width:60px;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crFinish' id='crFinish"+plusScCnt+"' style='width:60px;' class='inp_txt'>";
    		 	row += "<label><input type='checkbox' name='crCheck' id='crCheck"+plusScCnt+"' value='"+plusScCnt+"' />?????????</label>";
    		 	row += "</td>";
    		 	row += "<td><input type='text' name='crDept' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crWork' style='width:100%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		    $("#careerlist").append(row);

    		}else if(mode == "activity"){
    			var StartId = $('input[name=acStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
    			/* ????????????  */
    			if($('input[name=acNm]:last').val() == ""){
    				alert("??????(??????)?????? ?????? ????????????");
    				$('input[name=acNm]:last').focus();
    				return false;
    			}

    			if($('input[name=acStart]:last').val() == "" || $('input[name=acFinish]:last').val() == "" ){
    				$('input[name=acStart]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=acFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=acFinish]:last').focus();
					return false;
				}
    			if($('input[name=acDept]:last').val() == ""){
    				$('input[name=acDept]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}

    			if($('input[name=acWork]:last').val() == ""){
    				$('input[name=acWork]:last').focus();
    				alert("??????????????? ?????? ????????????");
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
    			var cnt = StartId.substring(7,8); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
    			/* ????????????  */
    			if($('input[name=rdSerialNum]:last').val() == ""){
    				alert("????????? ?????? ????????????");
    				$('input[name=rdSerialNum]:last').focus();
    				return false;
    			}
    			if($('input[name=rdOrgNm]:last').val() == ""){
    				alert("??????/?????????/??????????????? ?????? ????????????");
    				$('input[name=rdOrgNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdBusinessNm]:last').val() == ""){
    				alert("???????????? ?????? ????????????");
    				$('input[name=rdBusinessNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdNm]:last').val() == ""){
    				alert("???????????? ?????? ????????????");
    				$('input[name=rdNm]:last').focus();
    				return false;
    			}

    			if($('input[name=rdStart]:last').val() == "" || $('input[name=rdFinish]:last').val() == "" ){
    				$('input[name=rdStart]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("??????????????????(????????????) ????????????(??????) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
    			if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
					alert("??????????????????(????????????) ????????????(??????) : ex) 2016-01");
					$('input[name=rdFinish]:last').focus();
					return false;
				}
    			if($('input[name=rdExpenses]:last').val() == ""){
    				$('input[name=rdExpenses]:last').focus();
    				alert("???????????? ?????? ????????????");
    				return false;
    			}
    			if(isNaN($('input[name=rdExpenses]:last').val())){
					alert("??????????????????(????????????) ????????????(?????????) : ????????? ??????????????????. ex)10000");
					$('input[name=rdExpenses]:last').focus();
					return false;
				}
    			if($('select[name=rdForm]:last').val() == ""){
    				$('select[name=rdForm]:last').focus();
    				alert("??????????????? ?????? ????????????");
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
    		 	row += "<option value=''>??????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    		 	row += "<option value='??????or???????????????'>??????or???????????????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    			row += "<option value='???????????????'>???????????????</option>";
    			row += "</select></td>";
    		   	row += "</tr>";
    		    $("#RnDresultlist").append(row);

    		}else if(mode == "qualification"){
   			var StartId = $('input[name=quStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   			/* ????????????  */
   			if($('input[name=quSerialNum]:last').val() == ""){
   				alert("????????? ?????? ????????????");
   				$('input[name=quSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=quStart]:last').val() == "" ){
   				$('input[name=quStart]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}
   			if(datePattern.test($('input[name=quStart]:last').val()) == false){
				alert("????????????(?????????) : ex) 2016-01");
				$('input[name=quStart]:last').focus();
				return false;
			}
   			if($('input[name=quOrgNm]:last').val() == ""){
   				$('input[name=quOrgNm]:last').focus();
   				alert("?????????????????? ?????? ????????????");
   				return false;
   			}
   			if($('select[name=quDivide]:last').val() == ""){
   				$('select[name=quDivide]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=quNm]:last').val() == ""){
   				$('input[name=quNm]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='qualification"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='quSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='quStart' id='quStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='quOrgNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box' name='quDivide' style='width:100%;'>";
   		 	row += "<option value='''>???????????????</option>";
   		 	row += "<option value='????????????'>????????????</option>";
   		 	row += "<option value='????????????'>????????????</option>";
   			row += "<option value='????????????'>????????????</option>";
   			row += "</select>";
   			row += "</td>";
   		 	row += "<td><input type='text' name='quNm' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#qualificationlist").append(row);

  		}else if(mode == "research"){
  			var StartId = $('input[name=reNote]:last').attr('id');
  			var cnt = StartId.substring(7,8); //0?????? ??????
  		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
  			var option = $('#reDeth1'+cnt).html();
		if($('select[name=reDeth1]:last').val() == ""){
  				$('select[name=reDeth1]:last').focus();
  				alert("???????????? ?????? ????????????");
  				return false;
  			}

		if($('select[name=reDeth2]:last').val() == ""){
  				$('select[name=reDeth2]:last').focus();
  				alert("???????????? ?????? ????????????");
  				return false;
  			}

		if($('select[name=reDeth3]:last').val() == ""){
  				$('select[name=reDeth3]:last').focus();
  				alert("???????????? ?????? ????????????");
  				return false;
  			}
  			var row = "";
  		 	row += "<tr id='research"+plusScCnt+"'>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth1' id='reDeth1"+plusScCnt+"' onchange=\"standardDeth1('reDeth2"+plusScCnt+"')\">"+option+"</select></td>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth2' id='reDeth2"+plusScCnt+"' onchange=\"standardDeth2('reDeth3"+plusScCnt+"')\"></select></td>";
  		 	row += "<td><select  class='select_box' style='width:100%' name='reDeth3' id='reDeth3"+plusScCnt+"'></select></td>";
  		 	row += "<td colspan='2'><input type='text' name='reNote' id='resNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='??????'></td>";
  		   	row += "</tr>";
  		    $("#researchlist").append(row);

   		}else if(mode == "evaluate"){
   			var StartId = $('input[name=evNote]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   		    var option = $('#evDeth1'+cnt).html();

   			var row = "";

   			if($('select[name=evDeth1]:last').val() == ""){
   				$('select[name=evDeth1]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}

			if($('select[name=evDeth2]:last').val() == ""){
   				$('select[name=evDeth2]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}

			if($('select[name=evDeth3]:last').val() == ""){
   				$('select[name=evDeth3]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}
   		 	row += "<tr id='evaluate"+plusScCnt+"'>";
   		 	row += "<td><select class='select_box' style='width:100%' name='evDeth1' id='evDeth1"+plusScCnt+"' onchange=\"standardDeth1('evDeth2"+plusScCnt+"')\">"+option+"</select></td>";
   		 	row += "<td><select class='select_box' style='width:100%' name='evDeth2' id='evDeth2"+plusScCnt+"' onchange=\"standardDeth2('evDeth3"+plusScCnt+"')\"></select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='evDeth3' id='evDeth3"+plusScCnt+"' ></select></td>";
   		 	row += "<td colspan='2'><input type='text' name='evNote' id='evlNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='??????'></td>";
   		   	row += "</tr>";
   		    $("#evaluatelist").append(row);

   		}else if(mode == "consulting"){
   			var StartId = $('input[name=coNote]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   		    var option = $('#coDeth1'+cnt).html();
			if($('select[name=coDeth1]:last').val() == ""){
   				$('select[name=coDeth1]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}

			if($('select[name=coDeth2]:last').val() == ""){
   				$('select[name=coDeth2]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}

			if($('select[name=coDeth3]:last').val() == ""){
   				$('select[name=coDeth3]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='consulting"+plusScCnt+"'>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth1' id='coDeth1"+plusScCnt+"' onchange=\"standardDeth1('coDeth2"+plusScCnt+"')\">"+option+"</select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth2' id='coDeth2"+plusScCnt+"' onchange=\"standardDeth2('coDeth3"+plusScCnt+"')\"></select></td>";
   		 	row += "<td><select class='select_box'  style='width:100%' name='coDeth3' id='coDeth3"+plusScCnt+"'></select></td>";
   		 	row += "<td colspan='2'><input type='text' name='conNote' id='conNote"+plusScCnt+"' style='width:100%;' class='inp_txt' placeholder='??????'></td>";
   		   	row += "</tr>";
   		    $("#consultinglist").append(row);

   		}else if(mode == "researchPaper"){
   			var StartId = $('input[name=rpStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   			/* ????????????  */
   			if($('input[name=rpSerialNum]:last').val() == ""){
   				alert("????????? ?????? ????????????");
   				$('input[name=rpSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=rpStart]:last').val() == "" ){
   				$('input[name=rpStart]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if(datePattern.test($('input[name=rpStart]:last').val()) == false){
				alert("???????????? ??????(????????????) : ex) 2016-01");
				$('input[name=rpStart]:last').focus();
				return false;
			}
   			if($('input[name=rpJournalNm]:last').val() == ""){
   				$('input[name=rpJournalNm]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if($('select[name=rpNm]:last').val() == ""){
   				$('select[name=rpNm]:last').focus();
   				alert("???????????? ?????? ????????????");
   				return false;
   			}
   			if($('select[name=rpType]:last').val() == ""){
   				$('select[name=rpType]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			var row = "";
   		 	row += "<tr id='researchPaper"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='rpSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='rpNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box' name='rpType' style='width:100%;'>";
   		 	row += "<option value='''>???????????????</option>";
   		 	row += "<option value='???????????????'>???????????????</option>";
   		 	row += "<option value='??????????????????'>??????????????????</option>";
   		 	row += "<option value='???????????????'>???????????????</option>";
   		 	row += "<option value='??????????????????'>??????????????????</option>";
   			row += "<option value='???????????????'>???????????????</option>";
   			row += "</select>";
   			row += "</td>";
   			row += "<td><input type='text' name='rpJournalNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='rpStart' id='rpStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#researchPaperlist").append(row);

   		}else if(mode == "inProperty"){
   			var StartId = $('input[name=ipStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   			/* ????????????  */
   			if($('input[name=ipSerialNum]:last').val() == ""){
   				alert("????????? ?????? ????????????");
   				$('input[name=ipSerialNum]:last').focus();
   				return false;
   			}
   			if($('input[name=ipNm]:last').val() == ""){
   				$('input[name=ipNm]:last').focus();
   				alert("?????????????????? ?????? ????????????");
   				return false;
   			}
   			if($('select[name=ipType]:last').val() == ""){
   				$('select[name=ipType]:last').focus();
   				alert("????????????????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=ipPubliccation]:last').val() == ""){
   				$('input[name=ipPubliccation]:last').focus();
   				alert("??????/???????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=ipStart]:last').val() == "" ){
   				$('input[name=ipStart]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if(datePattern.test($('input[name=ipStart]:last').val()) == false){
				alert("???????????? ??????(????????????) : ex) 2016-01");
				$('input[name=ipStart]:last').focus();
				return false;
			}
   			var row = "";
   		 	row += "<tr id='inProperty"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='ipSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='ipNm' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box'  name='ipType' style='width:100%;'>";
   		 	row += "<option value='''>???????????????</option>";
   		 	row += "<option value='??????'>??????</option>";
   		 	row += "<option value='????????????'>????????????</option>";
   			row += "<option value='??????'>??????</option>";
   			row += "<option value='?????????'>?????????</option>";
   			row += "<option value='????????????'>????????????</option>";
   			row += "<option value='?????????'>?????????</option>";
   			row += "<option value='??????????????????'>??????????????????</option>";
   			row += "</select>";
   			row += "</td>";
   			row += "<td><input type='text' name='ipPublication' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='ipStart' id='ipStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#inPropertylist").append(row);

   		}else if(mode == "awardCareer"){
   			var StartId = $('input[name=awStart]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   			/* ????????????  */
   			if($('input[name=awSerialNum]:last').val() == ""){
   				alert("????????? ?????? ????????????");
   				$('input[name=awSerialNum]:last').focus();
   				return false;
   			}
   		    if($('select[name=awBadge]:last').val() == ""){
   				$('select[name=awBadge]:last').focus();
   				alert("????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=awStart]:last').val() == "" ){
   				$('input[name=awStart]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if(datePattern.test($('input[name=awStart]:last').val()) == false){
				alert("????????????(????????????) : ex) 2016-01");
				$('input[name=awStart]:last').focus();
				return false;
			}

   			if($('input[name=awPresent]:last').val() == ""){
   				$('input[name=awPresent]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=awContent]:last').val() == ""){
   				$('input[name=awContent]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}

   			var row = "";
   		 	row += "<tr id='awardCareer"+plusScCnt+"'>";
   		 	row += "<td><input type='text' name='awSerialNum' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td>";
   		 	row += "<select class='select_box'  name='awBadge' style='width:100%;'>";
   		 	row += "<option value='''>???????????????</option>";
   		 	row += "<option value='??????'>??????</option>";
   		 	row += "<option value='??????'>??????</option>";
   			row += "<option value='??????'>??????</option>";
   			row += "</select>";
   			row += "</td>";
   		 	row += "<td><input type='text' name='awStart' id='awStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
   		 	row += "<td><input type='text' name='awPresent' style='width:100%;' class='inp_txt'></td>";
   			row += "<td><input type='text' name='awContent' style='width:100%;' class='inp_txt'></td>";
   		   	row += "</tr>";
   		    $("#awardCareerlist").append(row);

   		}else if(mode == "resultEv"){
   			var StartId = $('input[name=evSdate]:last').attr('id');
   			var cnt = StartId.substring(7,8); //0?????? ??????
   		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   			/* ????????????  */
   			if($('input[name=evName]:last').val() == ""){
   				alert("???????????? ?????????(?????????)??? ?????? ????????????");
   				$('input[name=evName]:last').focus();
   				return false;
   			}
   		    if($('select[name=evOrg]:last').val() == ""){
   				$('select[name=evOrg]:last').focus();
   				alert("?????????????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=evSdate]:last').val() == "" ){
   				$('input[name=evSdate]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if($('input[name=evEdate]:last').val() == "" ){
   				$('input[name=evEdate]:last').focus();
   				alert("??????????????? ?????? ????????????");
   				return false;
   			}
   			if(datePattern.test($('input[name=evSdate]:last').val()) == false){
				alert("???????????? : ex) 2016-01");
				$('input[name=evSdate]:last').focus();
				return false;
			}
   			if(datePattern.test($('input[name=evEdate]:last').val()) == false){
				alert("???????????? : ex) 2016-01");
				$('input[name=evEdate]:last').focus();
				return false;
			}
   			if($('input[name=evContent]:last').val() == ""){
   				$('input[name=evContent]:last').focus();
   				alert("??????????????? ?????? ????????????");
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
  			var cnt = StartId.substring(8,9); //0?????? ??????
  		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
  			/* ????????????  */
  			if($('input[name=conName]:last').val() == ""){
  				alert("????????? ?????????(????????????)??? ?????? ????????????");
  				$('input[name=conName]:last').focus();
  				return false;
  			}
  		    if($('select[name=conOrg]:last').val() == ""){
  				$('select[name=conOrg]:last').focus();
  				alert("?????????????????? ?????? ????????????");
  				return false;
  			}
  			if($('input[name=conSdate]:last').val() == "" ){
  				$('input[name=conSdate]:last').focus();
  				alert("??????????????? ?????? ????????????");
  				return false;
  			}
  			if($('input[name=conEdate]:last').val() == "" ){
  				$('input[name=conEdate]:last').focus();
  				alert("??????????????? ?????? ????????????");
  				return false;
  			}
  			if(datePattern.test($('input[name=conSdate]:last').val()) == false){
				alert("??????????????? : ex) 2016-01");
				$('input[name=conSdate]:last').focus();
				return false;
			}
  			if(datePattern.test($('input[name=conEdate]:last').val()) == false){
				alert("??????????????? : ex) 2016-01");
				$('input[name=conEdate]:last').focus();
				return false;
			}
  			if($('input[name=conContent]:last').val() == ""){
  				$('input[name=conContent]:last').focus();
  				alert("?????????????????? ?????? ????????????");
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
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=scNm]').size() - 1;
   			var parenttr = $("#academic_career_info"+delCnt).remove();
   		}else if(mode == "career"){
   			if($('input[name=crNm]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=crNm]').size() - 1;
   			var parenttr = $("#career_info"+delCnt).remove();
   		}else if(mode == "activity"){
   			if($('input[name=acNm]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=acNm]').size() - 1;
   			var parenttr = $("#activity"+delCnt).remove();
   		}else if(mode == "RnDresult"){
   			if($('input[name=rdNm]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=rdNm]').size() - 1;
   			var parenttr = $("#RnDresult"+delCnt).remove();
   		}else if(mode == "qualification"){
   			if($('input[name=quNm]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=quNm]').size() - 1;
   			var parenttr = $("#qualification"+delCnt).remove();
   		}else if(mode == "research"){
   			if($('input[name=reNote]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=reNote]').size() - 1;
   			var parenttr = $("#research"+delCnt).remove();

   		}else if(mode == "evaluate"){
   			if($('input[name=evNote]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=evNote]').size() - 1;
   			var parenttr = $("#evaluate"+delCnt).remove();

   		}else if(mode == "consulting"){
   			if($('input[name=coNote]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=coNote]').size() - 1;
   			var parenttr = $("#consulting"+delCnt).remove();

   		}else if(mode == "researchPaper"){
   			if($('input[name=rpNm]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=rpNm]').size() - 1;
   			var parenttr = $("#researchPaper"+delCnt).remove();

   		}else if(mode == "inProperty"){
   			if($('input[name=ipNm]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=ipNm]').size() - 1;
   			var parenttr = $("#inProperty"+delCnt).remove();

   		}else if(mode == "awardCareer"){
   			if($('input[name=awStart]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=awStart]').size() - 1;
   			var parenttr = $("#awardCareer"+delCnt).remove();
   		}else if(mode == "resultEv"){
   			if($('input[name=evSdate]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=evSdate]').size() - 1;
   			var parenttr = $("#resultEv"+delCnt).remove();
   		}else if(mode == "resultCon"){
   			if($('input[name=conSdate]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=conSdate]').size() - 1;
   			var parenttr = $("#resultCon"+delCnt).remove();
   		}
   		setLicenseBtn();
   	}
//delRow E
//addRow??? datePicker S
	function setLicenseBtn(plusScCnt, mode){
    	/* DatePicker ?????? */
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
			nextText : '?????? ???',
			prevText : '?????? ???',

			closeText : '??????',
			dateFormat : "yy-mm",
			dayNames : [ '?????????', '?????????', '?????????', '?????????', '?????????', '?????????', '?????????' ],
			dayNamesMin : [ '???', '???', '???', '???', '???', '???', '???' ],
			monthNames : [ '1???', '2???', '3???', '4???', '5???', '6???', '7???', '8???', '9???', '10???', '11???', '12???' ],
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
//addRow??? datePicker E
</script>