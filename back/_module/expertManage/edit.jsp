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
	
	ArrayList<HashMap<String, String>> listSC = request.getAttribute("listSC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listSC");
	ArrayList<HashMap<String, String>> listCR = request.getAttribute("listCR") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCR");
	ArrayList<HashMap<String, String>> listAC = request.getAttribute("listAC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAC");
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	ArrayList<HashMap<String, String>> listRP = request.getAttribute("listRP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRP");
	ArrayList<HashMap<String, String>> listIP = request.getAttribute("listIP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listIP");
	//ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	
	//????????????------????????????
	//ArrayList<HashMap<String, String>> listEX = request.getAttribute("listEX") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEX");
	//ArrayList<HashMap<String, String>> listRE = request.getAttribute("listRE") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRE");
	//ArrayList<HashMap<String, String>> listEV = request.getAttribute("listEV") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEV");
	//ArrayList<HashMap<String, String>> listCO = request.getAttribute("listCO") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCO");
	//ArrayList<HashMap<String, String>> listResultEv = request.getAttribute("listResultEv") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultEv");
	
	ArrayList<HashMap<String, String>> listResultCon = request.getAttribute("listResultCon") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultCon");
	
	ArrayList<HashMap<String, String>> major = request.getAttribute("major") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("major");
	ArrayList<HashMap<String, String>> academicCode = request.getAttribute("academicCode") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("academicCode");
	ArrayList<HashMap<String, String>> jipCd = request.getAttribute("jipCd") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("jipCd");
	
	ArrayList<HashMap<String, String>> majorList = request.getAttribute("majorList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList");
	//ArrayList<HashMap<String, String>> majorList2 = request.getAttribute("majorList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList2");
	//ArrayList<HashMap<String, String>> majorList3 = request.getAttribute("majorList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList3");
    //ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
    //ArrayList<HashMap<String, String>> standardList2 = request.getAttribute("standardList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList2");
    //ArrayList<HashMap<String, String>> standardList3 = request.getAttribute("standardList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList3");
    ArrayList<HashMap<String, String>> listProCode = request.getAttribute("listProCode") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listProCode");
    ArrayList<HashMap<String, String>> listScCode = request.getAttribute("listScCode") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listScCode");
    ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	
	ArrayList<HashMap<String, String>> bizList1 = request.getAttribute("bizList1") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("bizList1");
	ArrayList<HashMap<String, String>> scList = request.getAttribute("scibList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scibList");
	ArrayList<HashMap<String, String>> teamList = request.getAttribute("teamList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamList");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
    String userIdx = util.getStr(paramMap.get("userIdx"));

	if("".equals(mode)) mode = "edit";

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
	
	//out.println(sf.format(nowTime));
%>
<style scoped >
.ui-datepicker-calendar {
    display: none;
}
button.ui-datepicker-current { display: none; }
</style>


<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
       <input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
       <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
       <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
       <input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	   <input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	   <input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID")) %>" />
	   <input type="hidden" name="delFiles" value="" />
	   
	   
	   
		<p style="color:red;">* ) ?????? ?????????????????????.</p>
			<h2 class="tit">????????????</h2>
			<!-- bo_btn  -->
              <div class="btn_right_box" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_inp_b_01" value="????????????" onclick="goCheck()"/>
                     <% if(util.getStr(paramMap.get("xt")).equals("1")){ %>
                     <input type="button" class="btn_inp_w_01" value="??????" onclick="history.go(-1)"/>
                     <% }else{ %>
                     <input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
                     <% } %>
              </div>
              <!--// bo_btn -->
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
                           			<input type="text" name="psnNm" id="psnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" class="inp_txt" >
                           		</td>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
                           		<td>
                           			<select name="GenderTypeCd" id="GenderTypeCd" class="select_box">
										<option <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='??????' selected" : "" %>>??????</option>
										<option <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "" : "value='??????' selected" %>>??????</option>
									</select>
                           			
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
                           		<td>
                          			<select name="birthDate" id="birthDate" class="select_box">
				            			<option value="">??????1</option>
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
                           			<% }else{ %>
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
                           			<%} %>
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
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
                           		<td colspan="3">
                           			
		            					&nbsp;&nbsp;???????????? <input type="radio" name="area" value="1"  onclick="areaClick('1')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> checked="checked" <% } %> />
										&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="area" value="2"  onclick="areaClick('2')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> checked="checked" <% } %> />&nbsp;&nbsp;
										<select class="select_box" name="ProUserBirthplace" id="ProUserBirthplace1" <% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> style="display:none;"<% } %>>
											<option value="">???????????????</option>
											<%
												int utilitynumArea = 1;
												for(HashMap rs:areaSigunguList) {
												%>
											<option <%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
											value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
											<% utilitynumArea++; } %>
										</select>
										<select class="select_box" name="0" id="ProUserBirthplace2" <% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> style="display:none;"<% } %> >
											<option value="">???????????????</option>
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
                           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
                           		<td>
                           			<input type="hidden" name="telNo" id="telNo"  value="" class="inp_txt"  maxlength="20">
                           			<%
                           			
                           			if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
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
                           			<%}else{ 
                           				String telox = util.getStr(dataMap.get("TEL_NO"));
                        				String telA[] = telox.split("-"); 
                           			%>
                           				<select name="tel1" id="tel1" class="select_box" title="????????????????????? ??????" style="width:20%">
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
                           			<%
                           			//out.println(util.getStr(dataMap.get("CP_NO")));
                           			if(util.getStr(dataMap.get("CP_NO")).equals("") || util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
                           				<select name="cp1" id="cp1" class="select_box"  style="width: 20%" title="????????? ??????">
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
                           				<select name="cp1" id="cp1" class="select_box"  style="width: 20%" title="????????? ??????">
											<option value="010" <%if(cpA[0].equals("010")) { %> selected="selected" <% } %>>010</option>
											<option value="011" <%if(cpA[0].equals("011")) { %> selected="selected" <% } %>>011</option>
											<option value="016" <%if(cpA[0].equals("016")) { %> selected="selected" <% } %>>016</option>
											<option value="017" <%if(cpA[0].equals("017")) { %> selected="selected" <% } %>>017</option>
											<option value="018" <%if(cpA[0].equals("018")) { %> selected="selected" <% } %>>018</option>
											<option value="019" <%if(cpA[0].equals("019")) { %> selected="selected" <% } %>>019</option>
										</select> -
										<input type="text" name="cp2" id="cp2" value="<%=cpA[1]%>" style="width:30%" maxlength="4"  class="inp_txt" title="????????? ?????????"> -
										<input type="text" name="cp3" id="cp3" value="<%=cpA[2]%>" style="width:30%" maxlength="4"  class="inp_txt" title="????????? ?????????">
                           			<% } %>
                        		</td>
                           	</tr>
                           	
                           	<% //if( util.getInt( loginVO.getAuthLv() ) > 70 ){ %>
				                <tr>
				                	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
				                	<td colspan="3">
				                		<select  class="select_box" name="proState" id="proState" >
				                			<option value="10" <%=(util.getStr(dataMap.get("PRO_STATE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
				                			<option value="20" style="<%=(util.getStr(paramMap.get("xt"))).equals("1")?"display:none;":"" %>" <%=(util.getStr(dataMap.get("PRO_STATE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
				                			<option value="30" style="<%=(util.getStr(paramMap.get("xt"))).equals("1")?"display:none;":"" %>" <%=(util.getStr(dataMap.get("PRO_STATE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
				                		</select>
				                	</td>
				            	</tr>
			            	<% //} %>
			            	
			            	<tr>
			      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
			            		<td colspan="3">
									???????????? <input type="checkbox" name="proJntisPlanning" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_PLANNING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									???????????? <input type="checkbox" name="proJntisRnd" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_RND"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									???????????? <input type="checkbox" name="proJntisCompany" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_COMPANY"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									???????????? <input type="checkbox" name="proJeinet" value="Y" <%=(util.getStr(dataMap.get("PRO_JEINET"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									???????????? <input type="checkbox" name="proJipbank" value="Y" <%=(util.getStr(dataMap.get("PRO_JIPBANK"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									???????????? <input type="checkbox" name="proJntisEducation" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_EDUCATION"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									????????? <input type="checkbox" name="proJntisConsulting" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_CONSULTING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									????????? <input type="checkbox" name="proJntisMarketing" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_MARKETING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									?????? <input type="checkbox" name="proJntisEtc" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_ETC"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
								</td>
			            	</tr>
			            	
			            	
			            	</tbody>
			            </table>
			            
			            <h2 class="tit">????????????</h2>
			            <table class="skin_basic_write">
				   			<caption>????????????</caption>
		                     <colgroup>
		                            <col style="width:15%">
		                            <col style="width:35%">
		                            <col style="width:15%">
		                            <col style="width:35%">
		                     </colgroup>
			                <tbody>
			            	<tr>
			            		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
			            		<td colspan="3"><input type="text" name="COM_NM" id="COM_NM" value="<%=(util.getStr(dataMap.get("COM_NM")))%>" class="inp_txt"></td>
			            	</tr>
			            	<tr>
			      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
			            		<td colspan="3">
								<% 
								for(HashMap te:teamList){ %>
									<%=util.getStr(te.get("CODE_NM"))%> <input type="radio" name="team_1" <%=(util.getStr(dataMap.get("PRO_SMB_TEAM1"))).equals(util.getStr(te.get("CODE_CD")))? "checked='checked'" : "" %> value="<%=util.getStr(te.get("CODE_CD"))%>" />
								<% } %>	
								</td>
			            	</tr>
			            	<tr>
                           		<th scope="row" class="tit"><span style="color:red;">*</span> ??????</th>
                           		<td>
                           			<input type="text" name="DEPT_NM" id="DEPT_NM" value="<%=(util.getStr(dataMap.get("DEPT_NM")))%>" class="inp_txt">
                           		</td>
                           		<th scope="row" class="tit"><span style="color:red;">*</span> ??????</th>
                           		<td>
                           			<input type="text" name="POSITION_NM" id="POSITION_NM" value="<%=(util.getStr(dataMap.get("POSITION_NM")))%>" class="inp_txt">                           			
                           		</td>
                           	</tr>
                           	<tr>
			            		<th scope="row" rowspan="2" class="tit"><span style="color:red;" >*</span> ????????????</th>
			            		<td colspan="3">
			            			<input type="text" class="inp_txt" id="COM_ZIP" name="COM_ZIP" maxlength="10" value="<%=(util.getStr(dataMap.get("COM_ZIP")))%>" readonly="readonly">
									<input type="text" class="inp_txt" id="COM_ADDR1" name="COM_ADDR1" maxlength="50" value="<%=(util.getStr(dataMap.get("COM_ADDR1")))%>" readonly="readonly" style="width:37%;">
									<input type="button" id="orgPostButton" value="????????????" class="btn_inp_g_01" onclick="orgPost()">
			            		</td>
			            	</tr>
			            	<tr>
			            		<td colspan="3"><input type="text" class="inp_txt" id="COM_ADDR2" name="COM_ADDR2" value="<%=(util.getStr(dataMap.get("COM_ADDR2")))%>" maxlength="50" style="width:37%;"></td>
			            	</tr>
			            	<tr>
			            		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			            		<td colspan="3">
			            		<%
			            		String[] comTel = util.getStr(dataMap.get("COM_TEL")).split("-");
			            		if(!util.getStr(dataMap.get("COM_TEL")).equals("")){
			            						            			
			            		%>
			            			<select name="ctel1" id="ctel1" class="select_box" title="????????????????????? ??????" style="width:90px;">
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
									<input type="text" name="ctel2" id="ctel2" value="<%=comTel[1] %>" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="??????????????? ?????????"> -
									<input type="text" name="ctel3" id="ctel3" value="<%=comTel[2] %>" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="??????????????? ?????????">
								<% 
								}else{
								%>
									
									<select name="ctel1" id="ctel1" class="select_box" title="????????????????????? ??????" style="width:90px;">
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
									<input type="text" name="ctel2" id="ctel2" value="" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="??????????????? ?????????"> -
									<input type="text" name="ctel3" id="ctel3" value="" maxlength="4" size="5" class="inp_txt" style="width:150px;" title="??????????????? ?????????">
								
								<%
								}
								%>
								
			            		</td>
			            	</tr>
			            	
                    </tbody>
	   		</table>
<!-- ???????????? E -->

		<!-- ???????????? S -->
		
		<div style="padding-top:15px"></div>
	   	<h2 class="tit">????????????</h2>
		<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('academic')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('academic')" />
		</div>
   		<table class="skin_basic_write" >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:15%" />
          		<col />
          		<col style="width:15%" />
          		<col />
            </colgroup>
         	
		<tbody id="academiclist">
	<%if(listSC.size()>0){
			String academic = "academic";%>
		<% for(HashMap rs:listSC) {%>
            <tr class="academic_career_info<%=scCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'academic')">
            	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
          		<td><input type="text" name="scNm" id="scNm"  value="<%=util.getStr(rs.get("SC_NM"))%>" class="inp_txt"></td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scCode">
					<option value="">???????????????</option>
					
					<% for(HashMap rsx:major) {%>
					<option value="<%=util.getStr(rsx.get("CODE_CD"))%>" <%=(util.getStr(rs.get("SC_CODE"))).equals(util.getStr(rsx.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(rsx.get("CODE_NM"))%></option>
					<% } %>
					<option value="ex">??????</option>
				</select>
          		</td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>">
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
          		<td><input type="text" name="scStart" readonly id="scStart<%=scCnt%>"  value="<%=util.getStr(rs.get("SC_START"))%>" class="inp_txt"></td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
          		<td>
          			<input type="text" name="scFinish" readonly id="scFinish<%=scCnt%>"  value="<%=util.getStr(rs.get("SC_FINISH"))%>" class="inp_txt" style="width:60%">
          			<label><input type="checkbox" name="scIng<%=scCnt%>" <%=util.getStr(rs.get("SC_ING")).equals("1")?"checked":""%> id="scIng<%=scCnt%>" value="1" />?????????</label>
          		</td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>">
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scDegree">
						<option value="">???????????????</option>
						<% for(HashMap rsx:academicCode) {%>
						<option value="<%=util.getStr(rsx.get("CODE_CD"))%>" <%=(util.getStr(rs.get("SC_DEGREE"))).equals(util.getStr(rsx.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(rsx.get("CODE_NM"))%></option>
						<% } %>
						
					</select>
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
          		<td><input type="text" name="scDate" id="scDate<%=scCnt%>"  value="<%=util.getStr(rs.get("SC_DATE"))%>" class="inp_txt"></td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>" style="border-bottom:3px solid #ddd;">
          		<th scope="row" class="tit">????????????</th>
          		<td colspan="3">
          			<input type="hidden" name="acFile" id="acFile<%=scCnt%>" value="<%=util.getStr(rs.get("SC_FILE"))%>">
          			<input type="file" name="academicFile<%=scCnt%>" id="academicFile<%=scCnt%>" value="" />
          		<%
          			
					if(!util.getStr(rs.get("SC_FILE")).equals("")){
						
				%>
						<%=util.getStr(rs.get("TITLE_ORG")) %>(<%=util.getIntStr(rs.get("FILE_SIZE")) %>)
          				<input type="checkbox" name="scFileDel<%=scCnt%>" id="scFileDel<%=scCnt%>" value="<%=util.getIntStr(rs.get("SC_FILE")) %>"><label for="scFileDel<%=scCnt%>">????????????</label>
          		<%
						
					}
          		%>
          		</td>
          	</tr>
          <%
          		scCnt++;
			}
      }else{%>
      		<tr class="academic_career_info<%=scCnt%>">
            	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
          		<td><input type="text" name="scNm" id="scNm" value="" class="inp_txt"></td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scCode">
					<option value="">???????????????</option>
					<% for(HashMap rsx:major) {%>
					<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>
					<% } %>
					<option value="ex">??????</option>
				</select>
          		</td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>">
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
          		<td><input type="text" name="scStart" readonly id="scStart<%=scCnt%>"  value="" class="inp_txt"></td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
          		<td>
          			<input type="text" name="scFinish" readonly id="scFinish<%=scCnt%>"  value="" class="inp_txt" style="width:60%">
          			<label><input type="checkbox" name="scIng<%=scCnt%>" id="scIng<%=scCnt%>" value="1" />?????????</label>
          		</td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>">
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
          		<td>
          			<select class="select_box"  style="width:100%;" name="scDegree">
						<option value="">???????????????</option>
						<% for(HashMap rsx:academicCode) {%>
						<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>
						<% } %>
						
					</select>
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
          		<td><input type="text" name="scDate" id="scDate<%=scCnt%>" value="" class="inp_txt"></td>
          	</tr>
          	<tr class="academic_career_info<%=scCnt%>" style='border-bottom:3px solid #ddd'>
          		<th scope="row" class="tit">????????????</th>
          		<td colspan="3">
          			<input type="hidden" name="acFile" id="acFile<%=scCnt%>" value="">
          			<input type="file" name="academicFile<%=scCnt%>" id="academicFile<%=scCnt%>" value="" />
          		</td>
          	</tr>
      <%} %>
   		</tbody>
	</table>
		
	
	
	
<!-- ???????????? E -->
<!-- ???????????? S -->
		<div style="padding-top:15px"></div>
	   	<h2 class="tit">????????????</h2>
		<div class="zoom">
			<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('career')" />
			<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('career')" />
   		</div>
   		<table class="skin_basic_write"  >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:15%" />
          		<col />
         		<col style="width:15%" />
         		<col />
            </colgroup>
          	
		<tbody id="careerlist">
		<%if(listCR.size()>0){ %>
			<% for(HashMap rs:listCR) {%>
        	<tr class="career_info<%=crCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'career')">
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
				<td><input type="text" name="crNm"  value="<%=util.getStr(rs.get("CR_NM"))%>" class="inp_txt"></td>
				<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
				<td><input type="text" name="crDept" value="<%=util.getStr(rs.get("CR_DEPT"))%>" class="inp_txt"></td>
			</tr>
			<tr class="career_info<%=crCnt%>">
				<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
				<td>
					<input type="text" name="crStart" id="crStart<%=crCnt%>" value="<%=util.getStr(rs.get("CR_START"))%>" class="inp_txt">
				</td>
				<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
				<td>
					<input type="text" name="crFinish" id="crFinish<%=crCnt%>" value="<%=util.getStr(rs.get("CR_FINISH"))%>" class="inp_txt" style="width:60%">
					<label><input type="checkbox" name="crIng<%=crCnt%>" id="crIng<%=crCnt%>"  value="1"  <%=util.getStr(rs.get("CR_ING")).equals("1")?" checked='checked' ":""%>/>?????????</label>					
				</td>
			</tr>
			<tr class="career_info<%=crCnt%>">
				<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
				<td colspan="3"><input type="text" name="crWork" value="<%=util.getStr(rs.get("CR_WORK"))%>" class="inp_txt" style="width:80%"></td>
            </tr>
            <tr class="career_info<%=crCnt%>" style='border-bottom:3px solid #ddd'>
				<th scope="row" class="tit">????????????</th>
				<td colspan="3">
					<input type="hidden" name="crFile" id="crFile<%=crCnt%>" value="<%=util.getStr(rs.get("CR_FILE"))%>">
					<input type="file" name="careerFile<%=crCnt %>"  id="careerFile<%=crCnt %>" value="">
					<%
          			
						if(!util.getStr(rs.get("CR_FILE")).equals("")){
							
					%>
							<%=util.getStr(rs.get("TITLE_ORG")) %>(<%=util.getIntStr(rs.get("FILE_SIZE")) %>)
	          				<input type="checkbox" name="crFileDel<%=crCnt%>" id="crFileDel<%=crCnt%>" value="<%=util.getIntStr(rs.get("CR_FILE")) %>"><label for="crFileDel<%=crCnt%>">????????????</label>
	          		<%
							
						}
	          		%>
				</td>
            </tr>
            <%crCnt++;
			}
		}else{%>
			<tr class="career_info<%=crCnt%>">
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
				<td><input type="text" name="crNm"  value="" class="inp_txt"></td>
				<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
				<td><input type="text" name="crDept" value="" class="inp_txt"></td>
			</tr>
			<tr class="career_info<%=crCnt%>">
				<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
				<td>
					<input type="text" name="crStart" id="crStart<%=crCnt%>" value="" class="inp_txt">
				</td>
				<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
				<td>
					<input type="text" name="crFinish" id="crFinish<%=crCnt%>" value="" class="inp_txt" style="width:60%">
					<label><input type="checkbox" name="crIng<%=crCnt%>" id="crIng<%=crCnt%>"  value="1" />?????????</label>					
				</td>
			</tr>
			<tr class="career_info<%=crCnt%>">
				<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
				<td colspan="3"><input type="text" name="crWork" value="" class="inp_txt" style="width:80%"></td>
            </tr>
            <tr class="career_info<%=crCnt%>" style='border-bottom:3px solid #ddd'>
				<th scope="row" class="tit">????????????</th>
				<td colspan="3">
					<input type="hidden" name="crFile" id="crFile<%=crCnt%>" value="">
					<input type="file" name="careerFile<%=crCnt %>"  id="careerFile<%=crCnt %>" value="">
				</td>
            </tr>
            
		<%}%>
		</tbody>
		</table>
<!-- ???????????? E -->

<!-- ???????????? S -->

	<div style="padding-top:15px"></div>
	<h2 class="tit">???????????? ??????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('researchPaper')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('researchPaper')" />
	</div>
	<table class="skin_basic_write" >
		<caption>???????????? ??????</caption>
	       <colgroup>
	        <col style="width:15%" />
	        <col />
	        <col style="width:15%" />
	        <col />
	       </colgroup>
       	
 	<tbody id="researchPaperlist">
 	<%if(listRP.size()>0){ %>
		<% for(HashMap rs:listRP) {%>
     	<tr class="researchPaper<%=rpCnt%>" onclick="setLicenseBtn(<%=rpCnt%>, 'researchPaper')">
     		<th scope="row" class="tit">?????????</th>
     		<td><input type="text" name="rpNm" id="rpNm<%=rpCnt%>" value="<%=util.getStr(rs.get("RP_NM"))%>"  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">????????????</th>
     		<td>
     			<select name="rpStart" class="select_box">
           			<option value="">??????</option>
           			<%
           			for(int i=1950; i<=util.getInt(sf.format(nowTime)); i++){
           				String selDate = util.getStr(rs.get("RP_START")).substring(0, 4);
           				String selected = util.getInt(selDate).equals(i)?"selected":"";
           			%>
           			<option value="<%=i%>" <%=selected%>><%=i%></option>
          			<% } %>
				</select>
     			
     		</td>
     	</tr>
     	<tr class="researchPaper<%=rpCnt%>">
     		<th scope="row" class="tit">????????????</th>
     		<td><input type="text" name="rpJournalNm"  value="<%=util.getStr(rs.get("RP_JOURNAL_NM"))%>"  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">SCI ??????????????????</th>
     		<td>
				<select  class="select_box"  name="rpType" style='width:100%;'>
       				<option value="Y" <%=(util.getStr(rs.get("RP_TYPE"))).equals("Y")? "selected='selected'" : "" %>>Y</option>
       				<option value="N" <%=(util.getStr(rs.get("RP_TYPE"))).equals("N")? "selected='selected'" : "" %>>N</option>
       			</select>
     		</td>
		</tr>
		<tr class="researchPaper<%=rpCnt%>" style='border-bottom:3px solid #ddd'>
			<th scope="row" class="tit">????????????</th>
			<td colspan="3">
				<input type="hidden" name="rpFile" id="rpFile<%=rpCnt%>" value="<%=util.getStr(rs.get("RP_FILE"))%>">
				<input type="file" name="researchPaperFile<%=rpCnt %>"  id="researchPaperFile<%=rpCnt %>" value="">
				<%
         			if(!util.getStr(rs.get("RP_FILE")).equals("")){
						
				%>
						<%=util.getStr(rs.get("TITLE_ORG")) %>(<%=util.getIntStr(rs.get("FILE_SIZE")) %>)
          				<input type="checkbox" name="rpFileDel<%=rpCnt%>" id="rpFileDel<%=rpCnt%>" value="<%=util.getIntStr(rs.get("RP_FILE")) %>"><label for="rpFileDel<%=rpCnt%>">????????????</label>
          		<%
						
					}
          		%>
			</td>
         </tr>
		
		<%rpCnt++;}
	}else{%>
		<tr class="researchPaper<%=rpCnt%>">
     		<th scope="row" class="tit">?????????</th>
     		<td><input type="text" name="rpNm" id="rpNm<%=rpCnt%>" value=""  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">????????????</th>
     		<td>
     			<select name="rpStart" class="select_box">
           			<option value="">??????</option>
           			<%
           			for(int i=1950; i<=util.getInt(sf.format(nowTime)); i++){
           			%>
           			<option value="<%=i%>"><%=i%></option>
          			<% } %>
				</select>
     		</td>
     	</tr>
     	<tr class="researchPaper<%=rpCnt%>">
     		<th scope="row" class="tit">????????????</th>
     		<td><input type="text" name="rpJournalNm"  value=""  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">SCI ??????????????????</th>
     		<td>
				<select  class="select_box"  name="rpType" style='width:100%;'>
       				<option value="Y">Y</option>
       				<option value="N">N</option>
       			</select>
     		</td>
		</tr>
		<tr class="researchPaper<%=rpCnt%>" style='border-bottom:3px solid #ddd'>
			<th scope="row" class="tit">????????????</th>
			<td colspan="3">
				<input type="hidden" name="rpFile" id="rpFile<%=rpCnt%>" value="">
				<input type="file" name="researchPaperFile<%=rpCnt %>"  id="researchPaperFile<%=rpCnt %>" value="">
			</td>
		</tr>
	<%} %>
	</tbody>
	</table>

<!-- ???????????? E -->



<!-- ???????????? ?????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">???????????? ??????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('inProperty')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('inProperty')" />
	</div>
	<table class="skin_basic_write">
		<caption>???????????? ??????</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col />
	        <col style="width:15%" />
	       	<col />
        </colgroup>
       	
 	<tbody id="inPropertylist">
 	<%if(listIP.size()>0){ %>
		<% for(HashMap rs:listIP) {%>
     	<tr class="inProperty<%=ipCnt%>" onclick="setLicenseBtn(<%=ipCnt%>, 'inProperty')">
     		<th scope="row" class="tit">???????????????</th>
     		<td><input type="text" name="ipNm" value="<%=util.getStr(rs.get("IP_NM"))%>"  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">??????????????????</th>
     		<td>
				<select class="select_box" name="ipType" style='width:100%;'>
       				<option value=""  <%=(util.getStr(rs.get("IP_TYPE"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<% for(HashMap rsx:jipCd) {%>
					<option value="<%=util.getStr(rsx.get("CODE_CD"))%>" <%=(util.getStr(rs.get("IP_TYPE"))).equals(util.getStr(rsx.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(rsx.get("CODE_NM"))%></option>
					<% } %>
       			</select>
     		</td>
     	</tr>
     	<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">??????????????????</th>
     		<td>
     			<select name="ipState" class="select_box" style='width:100%;'>
     				<option value="??????" <%=(util.getStr(rs.get("IP_STATE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
     				<option value="??????" <%=(util.getStr(rs.get("IP_STATE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
     			</select>
     		</td>
     		<th scope="row" class="tit">??????????????????</th>
     		<td><input type="text" name="ipStart" readonly id="ipStart<%=ipCnt%>" value="<%=util.getStr(rs.get("IP_START"))%>"  style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">??????/?????????</th>
     		<td colspan="3"><input type="text" name="ipPublication" value="<%=util.getStr(rs.get("IP_PUBLICATION"))%>" style="width:100%;" class="inp_txt"></td>
		</tr>
		<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">????????????</th>
     		<td colspan="3">
     			<input type="hidden" name="ipFile" id="ipFile<%=ipCnt%>" value="<%=util.getStr(rs.get("IP_FILE"))%>">
				<input type="file" name="inPropertyFile<%=ipCnt %>"  id="inPropertyFile<%=ipCnt %>" value="">
				<%
         			if(!util.getStr(rs.get("IP_FILE")).equals("")){						
				%>
						<%=util.getStr(rs.get("TITLE_ORG")) %>(<%=util.getIntStr(rs.get("FILE_SIZE")) %>)
          				<input type="checkbox" name="ipFileDel<%=ipCnt%>" id="ipFileDel<%=ipCnt%>" value="<%=util.getIntStr(rs.get("IP_FILE")) %>"><label for="ipFileDel<%=ipCnt%>">????????????</label>
          		<%
						
					}
          		%>
     		</td>
		</tr>
		<%ipCnt++;}
	}else{ %>
		
		<tr class="inProperty<%=ipCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'inProperty')">
     		<th scope="row" class="tit">???????????????</th>
     		<td><input type="text" name="ipNm" value=""  style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit">??????????????????</th>
     		<td>
				<select class="select_box" name="ipType" style='width:100%;'>
       				<option value="">??????</option>
       				<% for(HashMap rsx:jipCd) {%>
						<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>
					<% } %>
       			</select>
     		</td>
     	</tr>
     	<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">??????????????????</th>
     		<td>
     			<select name="ipState" class="select_box" style='width:100%;'>
     				<option value="??????">??????</option>
     				<option value="??????">??????</option>
     			</select>
     		</td>
     		<th scope="row" class="tit">??????????????????</th>
     		<td><input type="text" name="ipStart" readonly id="ipStart<%=ipCnt%>" value=""  style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">??????/?????????</th>
     		<td colspan="3"><input type="text" name="ipPublication" value="" style="width:100%;" class="inp_txt"></td>
		</tr>
		<tr class="inProperty<%=ipCnt%>">
     		<th scope="row" class="tit">????????????</th>
     		<td colspan="3">
     			<input type="hidden" name="ipFile" id="ipFile<%=ipCnt%>" value="">
				<input type="file" name="inPropertyFile<%=ipCnt %>" id="inPropertyFile<%=ipCnt %>" value="">
     		</td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->




<!-- ???????????? S -->
		<div style="padding-top:15px"></div>
	   	<h2 class="tit">????????????</h2>
		<div class="zoom">
			<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('activity')" />
			<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('activity')" />
   		</div>
   		<table class="skin_basic_write"  >
   			<caption>????????????</caption>
            <colgroup>
          		<col style="width:15%" />
          		<col />
          		<col style="width:15%" />
          		<col />
            </colgroup>
		<tbody id="activitylist">
		<%if(listAC.size()>0){ %>
			<% for(HashMap rs:listAC) {%>
         	<tr class="activity<%=acCnt%>" onclick="setLicenseBtn(<%=acCnt%>, 'activity')">
         		<th scope="row" class="tit">??????(??????)???</th>
         		<td colspan="3"><input type="text" name="acNm" value="<%=util.getStr(rs.get("AC_NM"))%>" style="width:60%;" class="inp_txt"></td>
         	</tr>
         	<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">?????????</th>
         		<td><input type="text" name="acStart" readonly id="acStart<%=acCnt%>" value="<%=util.getStr(rs.get("AC_START"))%>"  style="width:100%;" class="inp_txt"></td>
         		<th scope="row" class="tit">??????</th>
         		<td><input type="text" name="acDept" value="<%=util.getStr(rs.get("AC_DEPT"))%>" style="width:100%;" class="inp_txt"></td>
         	</tr>
         	<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">????????????</th>
         		<!-- td><input type="text" name="acFinish" id="acFinish<%//=acCnt%>" value="<%//=util.getStr(rs.get("AC_FINISH"))%>" style="width:100%;" class="inp_txt"></td-->
         		<td colspan="3"><input type="text" name="acWork" value="<%=util.getStr(rs.get("AC_WORK"))%>" style="width:100%;" class="inp_txt"></td>
         	</tr>
         	<%acCnt++;
         	}
		}else{%>
			<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">??????(??????)???</th>
         		<td colspan="3"><input type="text" name="acNm" value="" style="width:60%;" class="inp_txt"></td>
         	</tr>
         	<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">?????????</th>
         		<td><input type="text" name="acStart" readonly id="acStart<%=acCnt%>" value=""  style="width:100%;" class="inp_txt"></td>
         		<th scope="row" class="tit">??????</th>
         		<td><input type="text" name="acDept" value="" style="width:100%;" class="inp_txt"></td>
         	</tr>
         	<tr class="activity<%=acCnt%>">
         		<th scope="row" class="tit">????????????</th>
         		<!-- td><input type="text" name="acFinish" id="acFinish<%//=acCnt%>" value="<%//=util.getStr(rs.get("AC_FINISH"))%>" style="width:100%;" class="inp_txt"></td-->
         		<td colspan="3"><input type="text" name="acWork" value="" style="width:100%;" class="inp_txt"></td>
         	</tr>
		<%} %>
		</tbody>
	</table>
<!-- ???????????? E -->

<!-- ???????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">??????/??????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('qualification')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('qualification')" />
	</div>
	<table class="skin_basic_write">
		<caption>????????????</caption>
	    <colgroup>
	    	<col style="width:15%" />
	    	<col />
	    	<col style="width:15%" />
	    	<col />
	    </colgroup>
	<tbody id="qualificationlist">
	<%if(listQU.size()>0){ %>
		<% for(HashMap rs:listQU) {%>
       	<tr class="qualification<%=quCnt%>" onclick="setLicenseBtn(<%=quCnt%>, 'qualification')">
       		<th scope="row" class="tit">??????</th>
       		<td colspan="3">
       			<select class="select_box"  name="quDivide" style="width:30%;">
       				<option value="??????"  <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="?????????" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("?????????")? "selected='selected'" : "" %>>?????????</option>
       			</select>
       		</td>
       	</tr>
		<tr class="qualification<%=quCnt%>">
			<th scope="row" class="tit">??????/????????????</th>   	
       		<td><input type="text" name="quNm" value="<%=util.getStr(rs.get("QU_NM"))%>"  style="width:100%;" class="inp_txt"></td>
       		<th scope="row" class="tit">????????????</th>
       		<td><input type="text" name="quStart" readonly id="quStart<%=quCnt%>"  value="<%=util.getStr(rs.get("QU_START"))%>"  style="width:100%;" class="inp_txt"></td>
       	</tr>
       	<tr class="qualification<%=quCnt%>">
       		<th scope="row" class="tit">???????????????</th>
       		<td colspan="3"><input type="text" name="quOrgNm" value="<%=util.getStr(rs.get("QU_ORG_NM"))%>"  style="width:100%;" class="inp_txt"></td>
       	</tr>
       	<tr class="qualification<%=quCnt%>" style="border-bottom:3px solid #ddd">
       		<th scope="row" class="tit">????????????</th>
       		<td colspan="3">
       			<input type="hidden" name="quFile" id="quFile<%=quCnt%>" value="<%=util.getStr(rs.get("QU_FILE"))%>">
				<input type="file" name="qualificationFile<%=quCnt %>"  id="qualificationFile<%=quCnt %>" value="">
				<%
         			if(!util.getStr(rs.get("QU_FILE")).equals("")){
						
				%>
						<%=util.getStr(rs.get("TITLE_ORG")) %>(<%=util.getIntStr(rs.get("FILE_SIZE")) %>)
          				<input type="checkbox" name="quFileDel<%=quCnt%>" id="quFileDel<%=quCnt%>" value="<%=util.getIntStr(rs.get("QU_FILE")) %>"><label for="quFileDel<%=quCnt%>">????????????</label>
          		<%
						
					}
          		%>
       		</td>
       	</tr>
       	<%quCnt++;}
	}else{%>
		<tr class="qualification<%=quCnt%>" onclick="setLicenseBtn(<%=quCnt%>, 'qualification')">
       		<th scope="row" class="tit">??????</th>
       		<td colspan="3">
       			<select class="select_box"  name="quDivide" style="width:30%;">
       				<option value="??????">??????</option>
       				<option value="?????????">?????????</option>
       			</select>
       		</td>
       	</tr>
		<tr class="qualification<%=quCnt%>">
			<th scope="row" class="tit">??????/????????????</th>   	
       		<td><input type="text" name="quNm" value=""  style="width:100%;" class="inp_txt"></td>
       		<th scope="row" class="tit">????????????</th>
       		<td><input type="text" name="quStart" readonly id="quStart<%=quCnt%>"  value=""  style="width:100%;" class="inp_txt"></td>
       	</tr>
       	<tr class="qualification<%=quCnt%>">
       		<th scope="row" class="tit">???????????????</th>
       		<td colspan="3"><input type="text" name="quOrgNm" value=""  style="width:100%;" class="inp_txt"></td>
       	</tr>
       	<tr class="qualification<%=quCnt%>" style="border-bottom:3px solid #ddd">
       		<th scope="row" class="tit">????????????</th>
       		<td colspan="3">
       			<input type="hidden" name="quFile" id="quFile<%=quCnt%>" value="">
				<input type="file" name="qualificationFile<%=quCnt %>"  id="qualificationFile<%=quCnt %>" value="">
       		</td>
       	</tr>
	<%} %>
	</tbody>
	</table>
<!-- ???????????? E -->







<!-- ??????????????????(????????????) ???????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">??????????????????(????????????) ????????????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('RnDresult')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('RnDresult')" />
	</div>
	<table class="skin_basic_write">
		<caption>??????????????????(????????????) ????????????</caption>
	        <colgroup>
		    	<col style="width:15%" />
		    	<col />
		    	<col style="width:15%" />
		    	<col />
		    </colgroup>
       	
 	<tbody id="RnDresultlist">
 	<%if(listRD.size()>0){ %>
		<% for(HashMap rs:listRD) { %>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
     		<td colspan="3">
     			<label><input type="radio" name="rdType<%=rdCnt%>" value="Y" <%=util.getStr(rs.get("RD_TYPE")).equals("Y")?"checked":""%>/>??????</label>
     			<label><input type="radio" name="rdType<%=rdCnt%>" value="N" <%=util.getStr(rs.get("RD_TYPE")).equals("N")?"checked":""%>/>??????</label>
     		</td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/??????/????????????</th>
     		<td colspan="3"><input type="text" name="rdOrgNm" value="<%=util.getStr(rs.get("RD_ORG_NM"))%>" style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
     		<td><input type="text" name="rdBusinessNm" value="<%=util.getStr(rs.get("RD_BUSINESS_NM"))%>" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
     		<td><input type="text" name="rdNm" value="<%=util.getStr(rs.get("RD_NM"))%>" style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
     		<td><input type="text" name="rdStart" readonly value="<%=util.getStr(rs.get("RD_START"))%>" id="rdStart<%=rdCnt%>" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
     		<td>
     			<input type="text" name="rdFinish" readonly id="rdFinish<%=rdCnt%>" value="<%=util.getStr(rs.get("RD_FINISH"))%>" style="width:60%;" class="inp_txt">
     			<label><input type="checkbox" name="rdIng<%=rdCnt%>" <%=util.getStr(rs.get("RD_ING")).equals("1")?"checked":""%> id="rdIng<%=rdCnt%>" value="1" />?????????</label>
     		</td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')" style='border-bottom:3px solid #ddd'>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????:?????????)</th>
     		<td><input type="text" name="rdExpenses" value="<%=util.getStr(rs.get("RD_EXPENSES"))%>" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
       		<td>
       			<select class="select_box" name="rdForm">
       				<option value="" <%=(util.getStr(rs.get("RD_FORM"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       			</select>
       		</td>
		</tr>
		<%rdCnt++;}
	}else{%>
		<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
     		<td colspan="3">
     			<label><input type="radio" name="rdType<%=rdCnt%>" value="Y" checked/>??????</label>
     			<label><input type="radio" name="rdType<%=rdCnt%>" value="N"/>??????</label>
     		</td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/??????/????????????</th>
     		<td colspan="3"><input type="text" name="rdOrgNm" value="" style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
     		<td><input type="text" name="rdBusinessNm" value="" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
     		<td><input type="text" name="rdNm" value="" style="width:100%;" class="inp_txt"></td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')">
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
     		<td><input type="text" name="rdStart" readonly value="" id="rdStart<%=rdCnt%>" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
     		<td>
     			<input type="text" name="rdFinish" readonly id="rdFinish<%=rdCnt%>" value="" style="width:60%;" class="inp_txt">
     			<label><input type="checkbox" name="rdIng<%=rdCnt%>"  id="rdIng<%=rdCnt%>" value="1" />?????????</label>
     		</td>
     	</tr>
     	<tr class="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=rdCnt%>, 'RnDresult')" style='border-bottom:3px solid #ddd'>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????:?????????)</th>
     		<td><input type="text" name="rdExpenses" value="" style="width:100%;" class="inp_txt"></td>
     		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
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
	<%} %>
	</tbody>
	</table>
<!-- ??????????????????(????????????) ???????????? E -->


<!-- ????????? ???????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????? ????????????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('resultCon')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('resultCon')" />
	</div>
	<table class="skin_basic_write"  >
		<caption>????????? ????????????</caption>
        <colgroup>
	    	<col style="width:15%" />
	    	<col />
	    	<col style="width:15%" />
	    	<col />
	    </colgroup>
	<tbody id="resultConlist">
		
	<%if(listResultCon.size()>0){%>
		<% for(HashMap rs:listResultCon) {%>
		<tr class="resultCon<%=resultConCnt%>">
			<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ??????????????????</th>
			<td colspan="3">
     			<label><input type="radio" name="conType<%=resultConCnt%>" value="Y"  <%=util.getStr(rs.get("CON_TYPE")).equals("Y")?"checked":""%>/>??????</label>
     			<label><input type="radio" name="conType<%=resultConCnt%>" value="N"  <%=util.getStr(rs.get("CON_TYPE")).equals("N")?"checked":""%>/>??????</label>
     		</td>
		</tr>
    	<tr class="resultCon<%=resultConCnt%>">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ?????????(????????????)</th>
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_NAME"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_ORG"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  	</tr>
 	  	<tr class="resultCon<%=resultConCnt%>">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ????????????</th>
 	  		<td>
 	  			<input type="text" name="conSdate" readonly id="conSdate<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_SDATE"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ????????????</th>
 	  		<td>
 	  			<input type="text" name="conEdate" readonly id="conEdate<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_EDATE"))%>" style="width:60%;" class="inp_txt">
 	  			<label><input type="checkbox" name="conIng<%=resultConCnt%>" <%=util.getStr(rs.get("CON_ING")).equals("1")?"checked":""%> id="conIng<%=resultConCnt%>" value="1" />?????????</label>
 	  		</td>
 	  	</tr>
 	  	<tr class="resultCon<%=resultConCnt%>" style="border-bottom:3px solid #ddd">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
   			<td colspan="3">
   				<input type="text" name="conContent" id="conContent<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_CONTENT"))%>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
<%			resultConCnt++;
		}
}else{%>
		<tr class="resultCon<%=resultConCnt%>">
			<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ??????????????????</th>
			<td colspan="3">
     			<label><input type="radio" name="conType<%=resultConCnt%>" value="Y" checked/>??????</label>
     			<label><input type="radio" name="conType<%=resultConCnt%>" value="N"/>??????</label>
     		</td>
		</tr>
    	<tr class="resultCon<%=resultConCnt%>">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span>????????? ?????????(????????????)</th>
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=resultConCnt %>" value="" class="inp_txt">
 	  		</td>
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=resultConCnt %>" value="" class="inp_txt">
 	  		</td>
 	  	</tr>
 	  	<tr class="resultCon<%=resultConCnt%>">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ????????????</th>
 	  		<td>
 	  			<input type="text" name="conSdate" id="conSdate<%=resultConCnt %>" readonly value="" class="inp_txt">
 	  		</td>
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ????????????</th>
 	  		<td>
 	  			<input type="text" name="conEdate" id="conEdate<%=resultConCnt %>" readonly value="" style="width:60%" class="inp_txt">
 	  			<label><input type="checkbox" name="conIng<%=resultConCnt%>" id="conIng<%=resultConCnt%>" value="1" />?????????</label>
 	  		</td>
 	  	</tr>
 	  	<tr class="resultCon<%=resultConCnt%>" style="border-bottom:3px solid #ddd">
 	  		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
   			<td colspan="3">
   				<input type="text" name="conContent" id="conContent<%=resultConCnt %>" value="" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
<%} %>
	</tbody>
	</table>
<!-- ????????? ???????????? E -->




<!-- ???????????? ???????????? S -->
	<!--
	<div style="padding-top:15px"></div>
	<h2 class="tit">???????????? ????????????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('resultEv')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('resultEv')" />
	</div>
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
<%//if(listResultEv.size()>0){%>
		<% //for(HashMap rs:listResultEv) {%>
    	<tr id="resultEv<%//=resultEvCnt%>">
 	  		<td>
 	  			<input type="text" name="evName" id="evName<%//=resultEvCnt %>" value="<%//=util.getStr(rs.get("EV_NAME"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evOrg" id="evOrg<%//=resultEvCnt %>" value="<%//=util.getStr(rs.get("EV_ORG"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evSdate" id="evSdate<%//=resultEvCnt %>" value="<%//=util.getStr(rs.get("EV_SDATE"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%//=resultEvCnt %>" value="<%//=util.getStr(rs.get("EV_EDATE"))%>" style="width:100%;" class="inp_txt">
 	  		</td>
   			<td>
   				<input type="text" name="evContent" id="evContent<%//=resultEvCnt %>" value="<%//=util.getStr(rs.get("EV_CONTENT"))%>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
<%			//resultEvCnt++;
		//}
//}else{%>
		<tr id="resultEv<%//=resultEvCnt%>">
 	  		<td>
 	  			<input type="text" name="evName" id="evName<%//=resultEvCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evOrg" id="evOrg<%//=resultEvCnt %>" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evSdate" id="evSdate<%//=resultEvCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%//=resultEvCnt %>" style="width:100%;" class="inp_txt">
 	  		</td>
   			<td>
   				<input type="text" name="evContent" id="evContent<%//=resultEvCnt %>" style="width:100%;" class="inp_txt">
   			</td>
     	</tr>
<%//} %>
	</tbody>
	</table>
	-->
<!-- ???????????? ???????????? E -->

<!-- ?????????????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????????</h2>
	<table class="skin_basic_write">
		<caption>????????????</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????? 1??????</th>
	       	<td colspan="3">
	    			<select class="select_box" name="code_b" id="code_b_1">
					<option value="">?????????????????????</option>
					<%
					String Pcode1= (listProCode.size() > 0)?listProCode.get(0).get("P_CODE1"):"";
					out.println(listProCode);
					for(HashMap bz:bizList1){						
					%>
					<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%=(util.getStr(Pcode1)).equals(util.getStr(bz.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(bz.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="code_m" id="code_m_1">
					<option value="">?????????????????????</option>
				</select>
				<select class="select_box" name="code_s" id="code_s_1">
					<option value="">?????????????????????</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">?????????????????? 2??????</th>
	       	<td colspan="3">
	    			<select class="select_box" name="code_b" id="code_b_2">
					<option value="">?????????????????????</option>
					<%
					String Pcode2= (listProCode.size() > 1)?listProCode.get(1).get("P_CODE1"):"";
					for(HashMap bz:bizList1){
					%>
					<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%=(util.getStr(Pcode2)).equals(util.getStr(bz.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(bz.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="code_m" id="code_m_2">
					<option value="">?????????????????????</option>
				</select>
				<select class="select_box" name="code_s" id="code_s_2">
					<option value="">?????????????????????</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">?????????????????? 3??????</th>
	       	<td colspan="3">
	    			<select class="select_box" name="code_b" id="code_b_3">
					<option value="">?????????????????????</option>
					<%
					String Pcode3= (listProCode.size() > 2)?listProCode.get(2).get("P_CODE1"):"";
					for(HashMap bz:bizList1){						
					%>
					<option value="<%=util.getStr(bz.get("CODE_CD"))%>" <%=(util.getStr(Pcode3)).equals(util.getStr(bz.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(bz.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="code_m" id="code_m_3">
					<option value="">?????????????????????</option>
				</select>
				<select class="select_box" name="code_s" id="code_s_3">
					<option value="">?????????????????????</option>
				</select>
	     	</td>
		</tr>
		
		<tr>
			<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????? 1??????</th>
	       	<td colspan="3">
	    			<select class="select_box" name="scib" id="scib_1">
					<option value="">?????????????????????</option>
					<%
					String scCode1= (listScCode.size() > 0)?listScCode.get(0).get("SC_CODE1"):"";
					for(HashMap sc:scList){						
					%>
					<option value="<%=util.getStr(sc.get("CODE_CD"))%>" <%=(util.getStr(scCode1)).equals(util.getStr(sc.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(sc.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="scim" id="scim_1">
					<option value="">?????????????????????</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">?????????????????? 2??????</th>
	       	<td colspan="3">
	    			<select class="select_box" name="scib" id="scib_2">
					<option value="">?????????????????????</option>
					<%
					String scCode2= (listScCode.size() > 1)?listScCode.get(1).get("SC_CODE1"):"";
					for(HashMap sc:scList){						
					%>
					<option value="<%=util.getStr(sc.get("CODE_CD"))%>" <%=(util.getStr(scCode2)).equals(util.getStr(sc.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(sc.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="scim" id="scim_2">
					<option value="">?????????????????????</option>
				</select>
	     	</td>
		</tr>
		<tr>
			<th scope="row" class="tit">?????????????????? 3??????</th>
	       	<td colspan="3">
	    			<select class="select_box" name="scib" id="scib_3">
					<option value="">?????????????????????</option>
					<%
					String scCode3= (listScCode.size() > 2)?listScCode.get(2).get("SC_CODE1"):"";
					for(HashMap sc:scList){						
					%>
					<option value="<%=util.getStr(sc.get("CODE_CD"))%>" <%=(util.getStr(scCode3)).equals(util.getStr(sc.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(sc.get("CODE_NM"))%></option>
					<% 
					}
					%>
				</select>
				<select class="select_box" name="scim" id="scim_3">
					<option value="">?????????????????????</option>
				</select>
	     	</td>
		</tr>
		</tbody>
	</table>
<!-- ?????????????????? E -->

<!-- ??????????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">???????????????</h2>
	<table class="skin_basic_write">
		<caption>???????????????</caption>
        <colgroup>
	        <col style="width:20%" />
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<th scope="row" class="tit">??????????????? ??????????????? ??????</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro1" id="expert_pro1" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO1")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro1">
				??????????????? ?????????????????? ???????????? ??????????????????.
				<span style="color:#e15512">* ?????? ???????????? ?????????, ??????????????? ?????????(???????????????, ???????????? ??? ???????????? ??????)</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">??????????????? ??????</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro2" id="expert_pro2" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO2")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro2">
				?????????????????? ???????????? ??????????????????.
				<span style="color:#e15512">* ?????????, ?????????????????????, ???????????? ?????? ?????????, ???????????? ????????? ???</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">IP????????? ??????</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro3" id="expert_pro3" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO3")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro3">
				IP???????????? ???????????? ??????????????????.
				<span style="color:#e15512">* ?????????, ???????????? ?????????</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">????????????????????? ??????</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro4" id="expert_pro4" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO4")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro4">
				???????????????????????? ???????????? ??????????????????.<br>
				<span style="color:#e15512">* KS, IOS, IEC ??? ??????, ??????????????? ?????? ?????????(??????, ??????, PROJECT LEADER ?????? ??????????????????)<br/>
				* ?????????????????????, ??????????????????, ??????????????? ??? ???????????? ?????? ?????????, ?????? ???????????? ?????????
				</span>
				</label>
			</td>
		</tr>
		<tr>
			<th scope="row" class="tit">??????????????? ??????</th>
			<td colspan="3">
				<input type="checkbox" name="expert_pro5" id="expert_pro5" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO5")).equals("Y"))?"checked":""%>> 
				<label for="expert_pro5">
				?????????????????? ???????????? ??????????????????.<br>
				<span style="color:#e15512">* ??????, ??????, ??????, ?????? ??? ?????? ???????????? ??????, ????????? ?????? ?????????<br/>
				* ?????????????????? ?????? ??????, ??????, ???????????????????????? ?????? ????????? ???<br/>
				* ?????????????????? ???????????? ?????? ????????? ??????????????? ?????? ????????? ????????? ??? ???
				</span>
				</label>
			</td>
		</tr>
		</tbody>
	</table>
<!-- ??????????????? E -->

<!-- ?????????????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">??????????????????</h2>
	<table class="skin_basic_write">
		<caption>??????????????????</caption>
        <colgroup>
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<td>
				<span style="color:red;" >*</span> ???????????? ????????? ?????? ??????/????????? ?????? ??? ?????? ????????? ?????? ???????????? R&D???????????? ???????????? ???????????? ?????? ?????? ?????????????<br/>
				(??? ????????? ?????? ??????????????? ????????? ???????????? ????????????.)
				
			</td>
		</tr>
		<tr>
			<td>
				<div style="height:100px; overflow-y:scroll; border:1px solid #ddd; padding:10px 5px;">?????????????????? ??????</div>
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				<label><input type="radio" name="expert_ok" value="Y" <%=(util.getStr(dataMap.get("EXPERT_OK")).equals("Y") || util.getStr(dataMap.get("EXPERT_OK")).equals(null))?"checked":""%>> ??????????????? ???????????????.</label>
				<label><input type="radio" name="expert_ok" value="N" <%=(util.getStr(dataMap.get("EXPERT_OK")).equals("N"))?"checked":""%>> ??????????????? ???????????? ????????????.</label>
			</td>
		</tr>
		</tbody>
	</table>
	
	<table class="skin_basic_write">
		<caption>??????????????????2</caption>
        <colgroup>
	        <col />
        </colgroup>
        <tbody>
		<tr>
			<td>
				<span style="color:red;" >*</span> ???????????? ????????? ?????? ??????/????????? ?????? ??? ?????? ????????? ?????? ???????????? R&D???????????? ???????????? ???????????? ?????? ?????? ?????????????<br/>
				(??? ????????? ?????? ??????????????? ????????? ???????????? ????????????.)
				
			</td>
		</tr>
		<tr>
			<td>
				<div style="height:100px; overflow-y:scroll; border:1px solid #ddd; padding:10px 5px;">?????????????????? ??????</div>
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				<label><input type="radio" name="expert_ok2" value="Y" <%=(dataMap.get("EXPERT_OK2").isEmpty() || (util.getStr(dataMap.get("EXPERT_OK2")).equals("Y") || util.getStr(dataMap.get("EXPERT_OK2")).equals(null)))?"checked":""%>> ??????????????? ???????????????.</label>
				<label><input type="radio" name="expert_ok2" value="N" <%=(util.getStr(dataMap.get("EXPERT_OK2")).equals("N"))?"checked":""%>> ??????????????? ???????????? ????????????.</label>
			</td>
		</tr>
		</tbody>
	</table>
<!-- ?????????????????? E -->


<!-- ???????????????????????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">???????????? ?????? ?????????</h2>
	<table class="skin_basic_write">
		<caption>???????????? ?????? ?????????</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col style="width:35%" />
	        <col style="width:15%" />
	        <col style="width:35%" />
        </colgroup>
        <tbody>
		<!-- tr>
			<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ??????</th>
			<td>
				<%
					//if(fileList.size() > 0){
				%>
					<div id="fileDivEdit">
						<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
						<%
							/* int fileCnt = 1;
							for(HashMap rs:fileList){
								String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX")); */
						%>
							<li><input type="file" name="<%//=fileFullGrp%>File1" id="<%//=fileFullGrp%>File1" title="????????????" /></li>
							<li class="text">
								<input type="hidden" name="fileCode" id="fileCode" value="<%//=util.getStr(rs.get("FILE_ID"))%>" />
								<input type="checkbox" name="fileFlog" id="fileFlog_<%//=fileCnt%>"
										value="<%//=util.getStr(rs.get("FILE_ID"))%>" />&nbsp;
								<label for="fileFlog_<%//=fileCnt%>">????????????</label>&nbsp;&nbsp;
								<%//=util.deStr(rs.get("TITLE_ORG"))%>(<%//=util.getStr(rs.get("FILE_SIZE"))%> Byte)
	
							</li>
							
						<% //fileCnt++; }%>
						</ul>
					</div>
	
	            <% //}else{ %>
	
	             	<div id="fileDiv">
						<div id="<%//=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%//=fileFullGrp%>File1" id="<%//=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
					</div>
						
			      <% //} %>
			</td>
			<th scope="row" class="tit">????????? ??????</th>
			<td>
				?????????
			</td>
		</tr-->
		<tr>
			<th scope="row" class="tit">????????????</th>
			<td>
				<%=util.getStr(dataMap.get("EX_COMFIRM_SDATE")).equals("")?"-":util.getStr(dataMap.get("EX_COMFIRM_SDATE"))%>
			</td>
			<th scope="row" class="tit">????????????</th>
			<td>
				<%=util.getStr(dataMap.get("EX_COMFIRM_EDATE")).equals("")?"-":util.getStr(dataMap.get("EX_COMFIRM_EDATE"))%>
			</td>
		</tr>
		</tbody>
	</table>
<!-- ???????????????????????? E -->



<!-- ?????? ?????? S -->
	<!-- 
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow('awardCareer')" />
		<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow('awardCareer')" />
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
 	<% //if(listAW.size()>0){ %>
		<% //for(HashMap rs:listAW) {%>
     	<tr id="awardCareer<%=awCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'awardCareer')">
     		<td><input type="text" name="awSerialNum" value="<%//=util.getStr(rs.get("AW_SERIAL_NUM"))%>"  style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="awBadge" style='width:100%;'>
       				<option value="" <%//=(util.getStr(rs.get("AW_BADGE"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%//=(util.getStr(rs.get("AW_BADGE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%//=(util.getStr(rs.get("AW_BADGE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%//=(util.getStr(rs.get("AW_BADGE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart"  value="<%//=util.getStr(rs.get("AW_START"))%>"  id="awStart<%=awCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awPresent" value="<%//=util.getStr(rs.get("AW_PRESENT"))%>"   style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awContent" value="<%//=util.getStr(rs.get("AW_CONTENT"))%>"  style="width:100%;" class="inp_txt"></td>
		</tr>
	<%	//awCnt++;}
	//}else{%>
		<tr id="awardCareer<%=awCnt%>">
     		<td><input type="text" name="awSerialNum" style="width:100%;" class="inp_txt"></td>
     		<td>
				<select class="select_box"   name="awBadge" style='width:100%;'>
       				<option value="">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart" id="awStart<%=awCnt%>" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awPresent" style="width:100%;" class="inp_txt"></td>
     		<td><input type="text" name="awContent" style="width:100%;" class="inp_txt"></td>
		</tr>
	<% //} %>
	</tbody>
	</table>
	 -->
<!-- ?????? ?????? E -->


              <!-- bo_btn  -->
              <div class="btn_right_box" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_inp_b_01" value="????????????" onclick="goCheck()"/>
                     <% if(util.getStr(paramMap.get("xt")).equals("1")){ %>
                     <input type="button" class="btn_inp_w_01" value="??????" onclick="history.go(-1)"/>
                     <% }else{ %>
                     <input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
                     <% } %>
              </div>
              <!--// bo_btn -->
</form>


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	
	window.resizeTo( "1150", "700");


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
	
	
	
	for(var xx=0; xx<3; xx++){
		
		var smbCode1 = "";
		var smbCode2 = "";
		var smbCode3 = "";
		var num = 0;
		
		
		if(xx == 0){
			<% if(listProCode.size() > 0){ %>
			smbCode1 = "<%=util.getStr(listProCode.get(0).get("P_CODE1"))%>";
			smbCode2 = "<%=util.getStr(listProCode.get(0).get("P_CODE2"))%>";
			smbCode3 = "<%=util.getStr(listProCode.get(0).get("P_CODE3"))%>";
			num = 1;
			<% } %>
		}else if(xx == 1){
			<% if(listProCode.size() > 1){ %>
			smbCode1 = "<%=util.getStr(listProCode.get(1).get("P_CODE1"))%>";
			smbCode2 = "<%=util.getStr(listProCode.get(1).get("P_CODE2"))%>";
			smbCode3 = "<%=util.getStr(listProCode.get(1).get("P_CODE3"))%>";
			num = 2;
			<% } %>
		}else{
			<% if(listProCode.size() > 2){ %>
			smbCode1 = "<%=util.getStr(listProCode.get(2).get("P_CODE1"))%>";
			smbCode2 = "<%=util.getStr(listProCode.get(2).get("P_CODE2"))%>";
			smbCode3 = "<%=util.getStr(listProCode.get(2).get("P_CODE3"))%>";
			num = 3;
			<% } %>
		}
		
		
		if(smbCode1 != ""){
			var codeX = smbCode1;
			var codeNext = 2;
			var mode = "biz";
			
			$.ajax({
				url : "/sys/expertManage.do",
				async : false,
				type : "POST",
				data : {codeX:codeX, codeNext:codeNext, mode:mode},
				dataType : "JSON",
				success : function(data){
					if(data.state == "OK"){
						var html = "";
						$.each(data.dataList,function(idx,obj){
							var selectx = (obj.CODE_CD == smbCode2)?"selected":""; 
							html += "<option value='"+obj.CODE_CD+"' "+selectx+">"+obj.CODE_NM+"</option>";
						});
						$("#code_m_"+num).append(html);
					}
				}
			});			
			
		}
		
		if(smbCode2 != ""){
		
			var codeX = smbCode2;
			var codeNext = 3;
			var mode = "biz";
			
			$.ajax({
				url : "/sys/expertManage.do",
				async : false,
				type : "POST",
				data : {codeX:codeX, codeNext:codeNext, mode:mode},
				dataType : "JSON",
				success : function(data){
					if(data.state == "OK"){
						var html = "";						
						$.each(data.dataList,function(idx,obj){
							var selectx = (obj.CODE_CD == smbCode3)?"selected":""; 
							html += "<option value='"+obj.CODE_CD+"' "+selectx+">"+obj.CODE_NM+"</option>";
						});						
						$("#code_s_"+num).append(html);
					}
				}
			});
		
		}
		
	}
	
	
for(var yy=0; yy<2; yy++){
		
		var scCode1 = "";
		var scCode2 = "";
		var num = 0;
		
		
		if(yy == 0){
			<% if(listScCode.size() > 0){ %>
			scCode1 = "<%=util.getStr(listScCode.get(0).get("SC_CODE1"))%>";
			scCode2 = "<%=util.getStr(listScCode.get(0).get("SC_CODE2"))%>";
			num = 1;
			<% } %>
		}else if(yy == 1){
			<% if(listScCode.size() > 1){ %>
			scCode1 = "<%=util.getStr(listScCode.get(1).get("SC_CODE1"))%>";
			scCode2 = "<%=util.getStr(listScCode.get(1).get("SC_CODE2"))%>";
			num = 2;
			<% } %>
		}else{
			<% if(listScCode.size() > 2){ %>
			scCode1 = "<%=util.getStr(listScCode.get(2).get("SC_CODE1"))%>";
			scCode2 = "<%=util.getStr(listScCode.get(2).get("SC_CODE2"))%>";
			num = 3;
			<% } %>
		}
		
		
		
		if(scCode1 != ""){
			var codeX = scCode1;
			var codeNext = 2;
			var mode = "scib";
			
			$.ajax({
				url : "/sys/expertManage.do",
				async : false,
				type : "POST",
				data : {codeX:codeX, codeNext:codeNext, mode:mode},
				dataType : "JSON",
				success : function(data){
					if(data.state == "OK"){
						var html = "";
						$.each(data.dataList,function(idx,obj){
							var selectx = (obj.CODE_CD == scCode2)?"selected":""; 
							html += "<option value='"+obj.CODE_CD+"' "+selectx+">"+obj.CODE_NM+"</option>";
						});
						$("#scim_"+num).append(html);
					}
				}
			});			
			
		}
		
	}
	
	
	
	$("select[name='code_b']").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 2;
		var mode = "biz";
		var idx = $("select[name='code_b']").index(this);
		if(codeX != ""){
			$.post("/sys/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
				if(data.state == "OK"){
					var html = "";
					
					$("select[name='code_m']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");
					$("select[name='code_s']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");
					
					$.each(data.dataList,function(idx,obj){
						html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
					});
					$("select[name='code_m']").eq(idx).append(html);
				}
			},"JSON");
		}else{
			$("select[name='code_m']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");
			$("select[name='code_s']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");
		}
	});
	
	$("select[name='code_m']").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 3;
		var mode = "biz";
		var idx = $("select[name='code_m']").index(this);
		
		$.post("/sys/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
			if(data.state == "OK"){
				var html = "";
				
				$("select[name='code_s']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");
				
				$.each(data.dataList,function(idx,obj){
					html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
				});
				$("select[name='code_s']").eq(idx).append(html);
			}
		},"JSON");
	});
	
	
	$("select[name='scib']").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 2;
		var mode = "scib";
		var idx = $("select[name='scib']").index(this);
		
		if(codeX != ""){
			$.post("/sys/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
				if(data.state == "OK"){
					var html = "";
					
					$("select[name='scim']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");
					
					
					$.each(data.dataList,function(idx,obj){
						html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
					});
					$("select[name='scim']").eq(idx).append(html);
				}
			},"JSON");
		}else{
			$("select[name='scim']").eq(idx).find("option").remove().end().append("<option value=''>?????????????????????</option>");			
		}
	});
	
	
	
//????????? ????????? ??????
function userInfo(){
	$('#mode').val("write");
    $('#fwrite').submit();
}
//??????????????? ?????? S
	$("#photoCheck").click(function() {
		if($("#photoCheck").val() == null || $("#photoCheck").val() == "" || $("#photoCheck").val() == "on" ||$("#photoCheck").val() == "Y"){
			$("#fileFlog_1").attr("checked",true);
			$("#photoCheck").val("N");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDivEdit').hide();
			$('#fileDiv').hide();
		}else{
			$("#fileFlog_1").attr("checked",false);
			$("#photoCheck").val("Y");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDivEdit').show();
			$('#fileDiv').show();
		}
	});
//??????????????? ?????? E
//????????????-???????????? S

	var areaNo = "<%=util.getStr(dataMap.get("area"))%>";
	areaClick(areaNo);


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
$(document).ready(function(){
	/*
		if($('#proState').val() == "10"){
			alert("??????????????? ??????????????????.");
		}if($('#proState').val() == "20"){
			alert("?????????????????? ??????????????????.");
		}
	*/
});


$(document).on("change","select[name='scCode']",function(){
	
	var StartId = $(this).parents("tr").next("tr").find("input[name='scStart']").attr("id");
	var cnt = StartId.substring(7,8); //0?????? ??????
    var plusCnt = parseInt(cnt);//???::1 int????????? ??????
	
	if($(this).val() == "ex"){
		$(this).css("width","40%");
		$(this).after("<input type='text' name='scCodeText"+plusCnt+"' value='' style='margin-left:10px; width:40%' class='inp_txt'/>");
		$(this).next('input').focus();
	}else{
		$(this).css("width","100%");
		$(this).next('input').remove();		
	}
});



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
        	$('select[name='+mode+'] option').remove();
        	$('select[name='+mode+']:last').append(result);
         }
	});
}
function standardDeth1(mode){
	var result = "";
	var mode = mode;
	var name = mode.substr(0,2);
	var name2 = mode.substring(7,8)
	if(name == "re"){
		var deth3 = $('#reDeth1'+name2).val();
	}else if(name == "ev"){
		var deth3 = $('#evDeth1'+name2).val();
	}else if(name == "co"){
		var deth3 = $('#coDeth1'+name2).val();
	}
 	$.ajax({
         type: "POST",
         data : {
        	 deth3 : deth3
         },
         url : '/sys/dethCheck.do',
         dataType : 'json',
         success : function(data){
        	 $('#'+mode).html("");
        	result += "<option value=''>???????????????.</option>";
        	for(i=0; i<data.cnt; i++){
				result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
			}
        	$('#'+mode).append(result);
         }
	});
}

	function standardDeth2(mode){
	var result = "";
	var mode = mode;
	var name = mode.substr(0,2);
	var name2 = mode.substring(7,8);
	if(name == "re"){
		var deth4 = $('#reDeth2'+name2).val();
	}else if(name == "ev"){
		var deth4 = $('#evDeth2'+name2).val();
	}else if(name == "co"){
		var deth4 = $('#coDeth2'+name2).val();
	}
 	$.ajax({
         type: "POST",
         data : {
        	 deth4 : deth4
         },
         url : '/sys/dethCheck.do',
         dataType : 'json',
         success : function(data){
        	 $('#'+mode).html("");
        	result += "<option value=''>???????????????.</option>";

        	for(i=0; i<data.cnt; i++){
        		result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
			}
        	$('#'+mode).append(result);
         }
	});
}



function goSubmit(mode){
    $('#mode').val(mode);
    $('#fedit').submit();
}



	

function goCheck(){
	

	
	
	
	if(delFiles.length > 0){
		$("input[name='delFiles']").val(delFiles);
	}
	
	
	
		
	$("#email").val($('#mail1').val()+"@"+$('#mail2').val());
	$("#telNo").val($('#tel1').val()+"-"+$('#tel2').val()+"-"+$('#tel3').val());
	$("#cpNo").val($('#cp1').val()+"-"+$('#cp2').val()+"-"+$('#cp3').val());
		
		
		if($('#birthDate').val() == "" || $('#birthDate').val() == null || $('#email').val() == "" || $('#email').val() == null || $('#telNo').val() == "" || $('#telNo').val() == null || $('#cpNo').val() == "" || $('#cpNo').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
			return false;
		}
		
		
		if($('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
			alert("?????????????????? ??????????????????");
			return false;
		}
		
		/*
		if($("#code_b_x").val() == "" || $("#code_b_x").val() == null ){
			
			alert("??????????????? ???????????????.");
			return false;
		}
		*/
		
		if( $(':radio[name="area"]:checked').val() == 2 ){
			if( $('#ProUserBirthplace2').val() == null || $('#ProUserBirthplace2').val() == "" ){
				alert('????????????(??????)??? ?????? ????????????!');
				$('#ProUserBirthplace2').focus();
				return;
			}
		}else{
			if( $('#ProUserBirthplace1').val() == null || $('#ProUserBirthplace1').val() == "" ){
				alert('????????????(??????)??? ?????? ????????????.');
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
			//alert("????????????(????????????) : ex)2016");
			//return false;
		}
		if($('input[name=scNm]:last').val() == ""){
			alert("???????????? ?????? ??? ?????????.");
			$('input[name=scNm]:last').focus();
			return false;
		}
		if($('select[name=scCode]:last').val() == ""){
			alert("??????????????? ?????? ??? ?????????.");
			$('select[name=scCode]:last').focus();
			return false;
		}
		if($('input[name=scStart]:last').val() == ""){
			alert("?????????????????? ?????? ??? ?????????.");
			$('select[name=scStart]:last').focus();
			return false;
		}
		if(!$("input[name^=scIng]:last").is(":checked")){
			if($('input[name=scFinish]:last').val() == ""){
				alert("?????????????????? ?????? ??? ?????????.");
				$('select[name=scFinish]:last').focus();
				return false;
			}
		}
		if($('select[name=scDegree]:last').val() == ""){
			alert("???????????? ????????? ?????? ??? ?????????.");
			$('select[name=scDegree]:last').focus();
			return false;
		}
		if($('input[name=scDate]:last').val() == ""){
			alert("????????????????????? ?????? ??? ?????????.");
			$('select[name=scDate]:last').focus();
			return false;
		}
		
		
		
		/*
		if($('select[name=exMajor]:last').val() == "" || $('select[name=exMajor]:last').val() == null ||$('select[name=exRealm]:last').val() == "" || $('select[name=exRealm]:last').val() == null || $('input[name=exDetail]:last').val() == "" || $('input[name=exDetail]:last').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
			$('input[name=exDetail]:last').focus();
			return false;
		}*/
		if($('input[name=crNm]:last').val() == "" || $('input[name=crNm]:last').val() == null || $('input[name=crStart]:last').val() == "" || $('input[name=crStart]:last').val() == null || $('input[name=crFinish]:last').val() == "" || $('input[name=crFinish]:last').val() == null ||  $('input[name=crDept]:last').val() == "" || $('input[name=crDept]:last').val() == null ||  $('input[name=crWork]:last').val() == "" || $('input[name=crWork]:last').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
			$('input[name=crNm]:last').focus();
			return false;
		}
		
		/*
		if($("#code_b").val() == ""){
			alert("???????????????????????? ???????????????");
			$("#code_b").focus();
			return false;
		}
		if($("#code_m").val() == ""){
			alert("???????????????????????? ???????????????");
			$("#code_m").focus();
			return false;
		}
		if($("#code_s").val() == ""){
			alert("???????????????????????? ???????????????");
			$("#code_s").focus();
			return false;
		}
*/
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
		
	    
	    
		/** ???????????????????????? ?????? **/
		//if(!$("input[name^=rdType]:last").is(":checked")){
		    
			/* if($('input[name=rdSerialNum]:last').val() == ""){
				alert("????????? ?????? ????????????");
				$('input[name=rdSerialNum]:last').focus();
				return false;
			} */
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
	
			if($('input[name=rdStart]:last').val() == "" ){
				$('input[name=rdStart]:last').focus();
				alert("??????????????? ?????? ????????????");
				return false;
			}
			
			if(!$("input[name^=rdIng]:last").is(":checked")){
				
				if($('input[name=rdFinish]:last').val() == "" ){
    				$('input[name=rdFinish]:last').focus();
    				alert("?????????????????? ?????? ????????????");
    				return false;
    			}
				
			}
			
			
			if($('input[name=rdExpenses]:last').val() == ""){
				$('input[name=rdExpenses]:last').focus();
				alert("??????????????? ?????? ????????????");
				return false;
			}
			if(isNaN($('input[name=rdExpenses]:last').val())){
				alert("???????????? : ????????? ??????????????????. ex)10000");
				$('input[name=rdExpenses]:last').val("");
				$('input[name=rdExpenses]:last').focus();
				return false;
			}
			if($('select[name=rdForm]:last').val() == ""){
				$('select[name=rdForm]:last').focus();
				alert("??????????????? ?????? ????????????");
				return false;
			}
			
		//}else{
			
			
			
		//}
		
			
			if($('input[name=conName]:last').val() == ""){
				alert("????????? ?????????(????????????)??? ?????? ????????????");
				$('input[name=conName]:last').focus();
				return false;
			}
			if($('input[name=conOrg]:last').val() == ""){
				alert("?????????????????? ?????? ????????????");
				$('input[name=conOrg]:last').focus();
				return false;
			}
	
			if($('input[name=conSdate]:last').val() == "" ){
				$('input[name=conSdate]:last').focus();
				alert("????????? ???????????? ?????? ????????????");
				return false;
			}
			
			if(!$("input[name^=conIng]:last").is(":checked")){
				
				if($('input[name=conEdate]:last').val() == "" ){
    				$('input[name=conEdate]:last').focus();
    				alert("????????? ???????????? ?????? ????????????");
    				return false;
    			}
				
			}
			if($('input[name=conContent]:last').val() == ""){
				$('input[name=conContent]:last').focus();
				alert("?????????????????? ??????????????????");
				return false;
			}
			
			
			
			
			if($("#code_b_1").val() == "" || $("#code_b_1").val() == null ){
				$("#code_b_1").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}			
			if($("#code_m_1").val() == "" || $("#code_m_1").val() == null ){
				$("#code_m_1").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}
			if($("#code_s_1").val() == "" || $("#code_s_1").val() == null ){
				$("#code_s_1").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}
			
			if($("#code_b_2").val() != "" && ($("#code_m_2").val() == "" || $("#code_m_2").val() == null)){
				$("#code_m_2").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}
			
			if($("#code_m_2").val() != "" && $("#code_s_2").val() == ""){
				
				$("#code_s_2").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}
			
			if($("#code_b_3").val() != "" && ($("#code_m_3").val() == "" || $("#code_m_3").val() == null)){
				$("#code_m_3").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}
			
			if($("#code_m_3").val() != "" && $("#code_s_3").val() == ""){
				
				$("#code_s_3").focus();
				alert("???????????? ???????????? ???????????????.");
				return false;
			}
			
			
			
			/* ----------- */
			
			if($("#scib_1").val() == "" || $("#scib_1").val() == null ){
				$("#scib_1").focus();
				alert("???????????????????????? ???????????????.");
				return false;
			}			
			if($("#scim_1").val() == "" || $("#scim_1").val() == null ){
				$("#scim_1").focus();
				alert("???????????????????????? ???????????????.");
				return false;
			}
			
			
			if($("#scib_2").val() != "" && ($("#scim_2").val() == "" || $("#scim_2").val() == null)){
				$("#scim_2").focus();
				alert("???????????????????????? ???????????????.");
				return false;
			}
			
			if($("#scib_3").val() != "" && ($("#scim_3").val() == "" || $("#scim_3").val() == null)){
				$("#scim_3").focus();
				alert("???????????????????????? ???????????????.");
				return false;
			}
			
			
			
			
			<%-- if($("input[name='fileCode']").val() == ""){
				if($("#<%=fileFullGrp%>File1").val() == ""){
					alert("?????????????????? ???????????????");
					return false;
				}
			}else{
				if($("input[name='fileFlog']").is(":checked") && $("#<%=fileFullGrp%>File1").val() == ""){
					alert("??????????????? ?????????????????? ?????? ??????????????????");
					return false;
				}else if($("#<%=fileFullGrp%>File1").val() != "" && !$("input[name='fileFlog']").is(":checked")){
					alert("????????? ???????????? ????????? ??????????????? ??????????????? ?????????.");
					$("input[name='fileFlog']").attr("checked",true);
					return false;
				}
				
			} --%>
			
			
			
		
			
			
			/*
			
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
			
			*/
			

	goSubmit('editProc');
}
function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/sys/popup/"+listMode+".do";
	var popOption="width=500, height=550, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}


/* $("input[name^='scFileDel']").on("click",function(){
	var file = $(this).parents("td").find("input[name^='academicFile']");
	if($(this).is(":checked") && file.val() == ""){
		alert("??????????????? ????????? ??????????????? ?????? ??????????????????");
		file.focus();
		$(this).attr("checked",false);
	}
}); */

/* $("input[name^='crFileDel']").on("click",function(){
	var file = $(this).parents("td").find("input[name^='careerFile']");
	if($(this).is(":checked") && file.val() == ""){
		alert("??????????????? ????????? ??????????????? ?????? ??????????????????");
		$(this).attr("checked",false);
	}
}); */


$(document).on("click","input[name^='rdIng']",function(){
	var file = $(this).parents("td").find("input[name='rdFinish']");
	if($(this).is(":checked")){
		//file.prop("disabled",true);
		file.val("");
	}else{
		//file.prop("disabled",false);
	}
});

$(document).on("click","input[name^='scIng']",function(){
	var file = $(this).parents("td").find("input[name='scFinish']");
	if($(this).is(":checked")){
		//file.prop("disabled",true);
		file.val("");
	}else{
		//file.prop("disabled",false);
	}
});

$(document).on("click","input[name^='crIng']",function(){
	var file = $(this).parents("td").find("input[name='crFinish']");
	if($(this).is(":checked")){
		//file.prop("disabled",true);
		file.val("");
	}else{
		//file.prop("disabled",false);
	}
});


$(document).on("click","input[name^='conIng']",function(){
	var file = $(this).parents("td").find("input[name='crEdate']");
	if($(this).is(":checked")){
		//file.prop("disabled",true);
		file.val("");
	}else{
		//file.prop("disabled",false);
	}
});



$("#evSdate0,#evEdate0,#conSdate0,#conEdate0,#scStart0, #scFinish0, #scDate0, #crStart0, #crFinish0, #acStart0, #acFinish0, #rdStart0, #rdFinish0, #quStart0, #rpStart0, #ipStart0, #awStart0").datepicker({
	
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
   	/* showButtonPanel:true,
	yearRange: '1980:2020' */
   });


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

    			if($('select[name=scCode]:last').val() == ""){
    				$('select[name=scCode]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}

    			if($('input[name=scStart]:last').val() == ""){
    				$('input[name=scStart]:last').focus();
    				alert("?????? ???????????? ?????? ????????????");
    				return false;
    			}
    			
    			if(datePattern.test($('input[name=scStart]:last').val()) == false){
					alert("???????????????(??????) : ex) 2021-01-01");
					$('input[name=scStart]:last').focus();
					return false;
				}
    			
    			
				if(!$("input[name^=scIng]:last").is(":checked")){
    				
    				if($('input[name=scFinish]:last').val() == "" ){
        				$('input[name=scFinish]:last').focus();
        				alert("?????????????????? ?????? ????????????");
        				return false;
        			}
    				
					if(datePattern.test($('input[name=scFinish]:last').val()) == false){
						alert("???????????????(??????) : ex) 2021-01-01");
						$('input[name=scFinish]:last').focus();
						return false;
					}
    				
    			}

    			if($('select[name=scDegree]:last').val() == ""){
    				$('select[name=scDegree]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}
    			
    			if(datePattern.test($('input[name=scDate]:last').val()) == false){
					alert("???????????????(??????) : ex) 2021-01-01");
					$('input[name=scDate]:last').focus();
					return false;
				}
				
    			/* if($('input[name^=academicFile]:last').val() == "" && $("input[name=acFile]:last").val() == ""){
    				alert("??????????????? ?????? ????????????");
    				return false;
    			} */

    			var row = "";
    		 	row += "<tr class='academic_career_info"+plusScCnt+"'>";
    		 	row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ?????????</th>";
    		 	row += "<td><input type='text' name='scNm' class='inp_txt'></td>";
    		 	row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ??????</th>";
    		 	row += "<td><select class='select_box'  style='width:100%;' name='scCode'><option value=''>???????????????</option>";
    		 	<% for(HashMap rsx:major) {%>
				row += "<option value='<%=util.getStr(rsx.get("CODE_CD"))%>'><%=util.getStr(rsx.get("CODE_NM"))%></option>";
				<% } %>
				row += "<option value='ex'>??????</option>";
    		 	row += "</select></td>";
    		 	row += "</tr><tr class='academic_career_info"+plusScCnt+"'>";
    		 	row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ???????????????</th>";
    		 	row += "<td><input type='text' name='scStart' readonly id='scStart"+plusScCnt+"' class='inp_txt'></td>";
    		 	row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ???????????????</th>";
    		 	row += "<td><input type='text' name='scFinish' readonly id='scFinish"+plusScCnt+"' style='width:60%' class='inp_txt'>";
    		 	row += '<label><input type="checkbox" name="scIng'+plusScCnt+'" id="scIng'+plusScCnt+'" value="1" />?????????</label>';
    		 	row += "</td>";
    		 	row += "</tr><tr class='academic_career_info"+plusScCnt+"'>";
    		 	row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ????????????</th>";
    		 	row += "<td><select name='scDegree' class='select_box' style='width:100%;' >";
    		 	row += "<option value=''>??????</option>";
    		 	<% for(HashMap rsx:academicCode) {%>
				row += "<option value='<%=util.getStr(rsx.get("CODE_CD"))%>'><%=util.getStr(rsx.get("CODE_NM"))%></option>";
				<% } %>
    			row += "</select></td>";
    			row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ??????????????????</th>";
    			row += "<td><input type='text' name='scDate' id='scDate"+plusScCnt+"' class='inp_txt'></td>";    			
    			row += "</tr><tr class='academic_career_info"+plusScCnt+"' style='border-bottom:3px solid #ddd'>";
    			row += "<th scope='row' class='tit'>????????????</th>";
    			row += "<td colspan='3'><input type='hidden' name='acFile' id='acFile"+plusScCnt+"' value=''><input type='file' name='academicFile"+plusScCnt+"' id='academicFile"+plusScCnt+"' class='inp_txt'></td>";
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

    			if($('input[name=crDept]:last').val() == ""){
    				$('input[name=crDept]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}

    			if($('input[name=crStart]:last').val() == ""){
    				$('input[name=crStart]:last').focus();
    				alert("?????????????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=crStart]:last').val()) == false){
					alert("??????????????? : ex) 2016-01");
					$('input[name=crStart]:last').focus();
					return false;
				}
    			
				if(!$("input[name^=crIng]:last").is(":checked")){
    				
    				if($('input[name=crFinish]:last').val() == "" ){
        				$('input[name=crFinish]:last').focus();
        				alert("?????????????????? ?????? ????????????");
        				return false;
        			}
    				
					if(datePattern.test($('input[name=crFinish]:last').val()) == false){
						alert("?????????????????? : ex) 2021-01-01");
						$('input[name=crFinish]:last').focus();
						return false;
					}
    				
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
    			
    			/* if($('input[name^=careerFile]:last').val() == "" && $("input[name=crFile]:last").val() == ""){
    				alert("??????????????? ?????? ????????????");
    				return false;
    			} */
    			

    			var row = "";
    		 	row += "<tr class='career_info"+plusScCnt+"'>";
    		 	row += "<th scope='row' class='tit'><span style='color:red;'>*</span> ?????????</th>";
    		 	row += "<td><input type='text' name='crNm' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
    		 	row += "<td><input type='text' name='crDept' class='inp_txt'></td>";
    		 	row += '</tr>';
    		 	row += "<tr class='career_info"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
    		 	row += "<td><input type='text' name='crStart' readonly id='crStart"+plusScCnt+"' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
    		 	row += "<td><input type='text' name='crFinish' readonly id='crFinish"+plusScCnt+"' style='width:60%' class='inp_txt'>";
    		 	row += "<label><input type='checkbox' name='crIng"+plusScCnt+"' id='crIng"+plusScCnt+"' value='"+plusScCnt+"' />?????????</label>";
    		 	row += "</td>";
    		 	row += '</tr>';
    		 	row += "<tr class='career_info"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
    		 	row += "<td colspan='3'><input type='text' name='crWork' style='width:80%;' class='inp_txt'></td>";
    		   	row += "</tr>";
    		   	row += "<tr class='career_info"+plusScCnt+"'>";
    		   	row += '<th scope="row" class="tit">????????????</th>';
    		   	row += '<td colspan="3" style="border-bottom:3px solid #ddd">';
    		   	row += '<input type="hidden" name="crFile" id="crFile'+plusScCnt+'" value="">';
    		   	row += '<input type="file" name="careerFile'+plusScCnt+'"  id="careerFile'+plusScCnt+'" value="">';
    		   	row += '</td>';
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

    			if($('input[name=acStart]:last').val() == "" ){
    				$('input[name=acStart]:last').focus();
    				alert("????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=acStart]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=acStart]:last').focus();
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
    		 	row += '<th scope="row" class="tit">??????(??????)???</th>';
    		 	row += '<td colspan="3"><input type="text" name="acNm" value="" style="width:60%;" class="inp_txt"></td>';
    		 	row += '</tr>';
    		 	row += "<tr id='activity"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit">??????(??????)???</th>';
    		 	row += '<td><input type="text" name="acStart" readonly id="acStart'+plusScCnt+'" value=""  style="width:100%;" class="inp_txt"></td>';
    		 	row += '<th scope="row" class="tit">??????</th>';
    		 	row += '<td><input type="text" name="acDept" value="" style="width:100%;" class="inp_txt"></td>';
    		 	row += '</tr>';
    		 	row += "<tr id='activity"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit">????????????</th>';
    		 	row += '<td colspan="3"><input type="text" name="acWork" value="" style="width:100%;" class="inp_txt"></td>';
    		   	row += "</tr>";
    		    $("#activitylist").append(row);

    		}else if(mode == "RnDresult"){
    			var StartId = $('input[name=rdStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ?????????
    			/* ????????????  */
    			
    			/* if($('input[name=rdSerialNum]:last').val() == ""){
    				alert("????????? ?????? ????????????");
    				$('input[name=rdSerialNum]:last').focus();
    				return false;
    			} */
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

    			if($('input[name=rdStart]:last').val() == "" ){
    				$('input[name=rdStart]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}
    			
    			if(!$("input[name^=rdIng]:last").is(":checked")){
    				
    				if($('input[name=rdFinish]:last').val() == "" ){
        				$('input[name=rdFinish]:last').focus();
        				alert("?????????????????? ?????? ????????????");
        				return false;
        			}
    				
    				if(datePattern.test($('input[name=rdFinish]:last').val()) == false){
    					alert("??????????????????(????????????) ????????????(??????) : ex) 2016-01");
    					$('input[name=rdFinish]:last').focus();
    					return false;
    				}
    				
    			}
    			
    			if(datePattern.test($('input[name=rdStart]:last').val()) == false){
					alert("??????????????????(????????????) ????????????(??????) : ex) 2016-01");
					$('input[name=rdStart]:last').focus();
					return false;
				}
    			
    			if($('input[name=rdExpenses]:last').val() == ""){
    				$('input[name=rdExpenses]:last').focus();
    				alert("??????????????? ?????? ????????????");
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
    		 	row += "<tr class='RnDresult"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
    		 	row += '<td colspan="3">';
    		 	row += '<label><input type="radio" name="rdType'+plusScCnt+'" value="Y" checked/>??????</label>';
    		 	row += '<label><input type="radio" name="rdType'+plusScCnt+'" value="N"/>??????</label>';
    		 	row += '</td>';
    		 	row += '</tr>';
    		 	row += "<tr class='RnDresult"+plusScCnt+"'>";
    		 	//row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>';
    		 	//row += "<td ><input type='text' name='rdSerialNum' style='width:100%;' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/??????/????????????</th>';
    		 	row += "<td colspan='3'><input type='text' name='rdOrgNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += '</tr>';
    		 	row += "<tr class='RnDresult"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
    		 	row += "<td ><input type='text' name='rdBusinessNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
    		 	row += "<td ><input type='text' name='rdNm' style='width:100%;' class='inp_txt'></td>";
    		 	row += '</tr>';
    		 	row += "<tr class='RnDresult"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
    		 	row += "<td><input type='text' name='rdStart' readonly id='rdStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
    		 	row += "<td><input type='text' name='rdFinish' readonly id='rdFinish"+plusScCnt+"' style='width:60%;' class='inp_txt'>";
    		 	row += '<label><input type="checkbox" name="rdIng'+plusScCnt+'" id="rdIng'+plusScCnt+'" value="1" />?????????</label></td>';
    		 	row += '</tr>';
    		 	row += "<tr class='RnDresult"+plusScCnt+"' style='border-bottom:3px solid #ddd'>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????:?????????)</th>';
    		 	row += "<td><input type='text' name='rdExpenses' style='width:100%;' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
    		 	row += "<td><select name='rdForm' class='select_box'>";
    		 	row += "<option value=''>??????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    			row += "<option value='???????????????'>???????????????</option>";
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
    			if($('input[name=quNm]:last').val() == ""){
    				alert("??????/??????????????? ?????? ????????????");
    				$('input[name=quNm]:last').focus();
    				return false;
    			}
    			if($('input[name=quStart]:last').val() == "" ){
    				$('input[name=quStart]:last').focus();
    				alert("???????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=quStart]:last').val()) == false){
					alert("????????????(?????????) : ex) 2016-01-01");
					$('input[name=quStart]:last').focus();
					return false;
				}
    			if($('input[name=quOrgNm]:last').val() == ""){
    				$('input[name=quOrgNm]:last').focus();
    				alert("?????????????????? ?????? ????????????");
    				return false;
    			}

    			/* if($('input[name^=qualificationFile]:last').val() == "" && $("input[name=quFile]:last").val() == ""){
    				alert("??????????????? ?????? ????????????");
    				return false;
    			} */
    			/*
    			if($('input[name=quNm]:last').val() == ""){
    				$('input[name=quNm]:last').focus();
    				alert("???????????? ?????? ????????????");
    				return false;
    			} */
    			
    			var row = "";
    			
    			row += '<tr class="qualification'+plusScCnt+'">';
    			row += '	<th scope="row" class="tit">??????</th>';
    			row += '	<td colspan="3">';
    			row += '		<select class="select_box"  name="quDivide" style="width:30%;">';
    			row += '			<option value="??????">??????</option>';
    			row += '			<option value="?????????">?????????</option>';
    			row += '		</select>';
    			row += '	</td>';
    			row += '</tr>';
    			row += '<tr class="qualification'+plusScCnt+'">';
    			row += '	<th scope="row" class="tit">??????/????????????</th>';   	
    			row += '	<td><input type="text" name="quNm" value=""  style="width:100%;" class="inp_txt"></td>';
    			row += '	<th scope="row" class="tit">????????????</th>';
    			row += '	<td><input type="text" name="quStart" readonly id="quStart'+plusScCnt+'"  value=""  style="width:100%;" class="inp_txt"></td>';
    			row += '</tr>';
    			row += '<tr class="qualification'+plusScCnt+'">';
    			row += '	<th scope="row" class="tit">???????????????</th>';
    			row += '	<td colspan="3"><input type="text" name="quOrgNm" value=""  style="width:100%;" class="inp_txt"></td>';
    			row += '</tr>';
    			row += '<tr class="qualification'+plusScCnt+'" style="border-bottom:3px solid #ddd">';
    			row += '	<th scope="row" class="tit">????????????</th>';
    			row += '	<td colspan="3">';
    			row += '		<input type="hidden" name="quFile" id="quFile'+plusScCnt+'" value="">';
    			row += '		<input type="file" name="qualificationFile'+plusScCnt+'"  id="qualificationFile'+plusScCnt+'" value="">';
    			row += '	</td>';
    			row += '</tr>';
    			
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
    			var StartId = $('input[name=rpNm]:last').attr('id');
    			var cnt = StartId.substring(4,5); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
    			/* ????????????  */
    			/* if($('input[name=rpSerialNum]:last').val() == ""){
    				alert("????????? ?????? ????????????");
    				$('input[name=rpSerialNum]:last').focus();
    				return false;
    			} */
    			
    		    if($('input[name=rpNm]:last').val() == ""){
    				$('input[name=rpNm]:last').focus();
    				alert("???????????? ?????? ????????????");
    				return false;
    			}
    			
    			if($('input[name=rpStart]:last').val() == "" ){
    				$('input[name=rpStart]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}
    			if($('select[name=rpStart]:last').val() == ""){
					alert("???????????? ??????(????????????) : ex) 2016");
					$('select[name=rpStart]:last').focus();
					return false;
				}
    			if($('input[name=rpJournalNm]:last').val() == ""){
    				$('input[name=rpJournalNm]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}
    			if($('select[name=rpType]:last').val() == ""){
    				$('select[name=rpType]:last').focus();
    				alert("??????????????? ?????? ????????????");
    				return false;
    			}
    			/* if($('input[name^=researchPaperFile]:last').val() == "" && $("input[name=rpFile]:last").val() == ""){
    				alert("??????????????? ?????? ????????????");
    				return false;
    			} */
    			

    			var row = "";
    		 	row += "<tr class='researchPaper"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit">?????????</th>';
    		 	row += "<td><input type='text' name='rpNm' id='rpNm"+plusScCnt+"' class='inp_txt'></td>";
    		 	row += '<th scope="row" class="tit">????????????</th>';
    		 	row += "<td>";
    		 	row += '<select name="rpStart" class="select_box">';
	       		row += '<option value="">??????</option>';
	       		for(var i=1950; i<=<%=util.getInt(sf.format(nowTime))%>; i++){
	       			row += '<option value="'+i+'">'+i+'</option>';
	      		}
				row += '</select>';
    		 	row += "</td>";
    		 	row += '</tr>';
    		 	row += "<tr class='researchPaper"+plusScCnt+"'>";
    		 	row += '<th scope="row" class="tit">????????????</th>';
    		 	row += '<td><input type="text" name="rpJournalNm"  value="" class="inp_txt"></td>';
    		 	row += '<th scope="row" class="tit">SCI ??????????????????</th>';
    		 	row += "<td>";
    		 	row += "<select class='select_box' name='rpType' style='width:100%;'>";
    		 	row += "<option value='Y'>Y</option>";
    			row += "<option value='N'>N</option>";
    			row += "</select>";
    			row += "</td>";
    			row += "</tr>";
    			row += "<tr class='researchPaper"+plusScCnt+"' style='border-bottom:3px solid #ddd'>";
    			row += '<th scope="row" class="tit">????????????</th>';
    			row += '<td colspan="3">';
    			row += '<input type="hidden" name="rpFile" id="rpFile'+plusScCnt+'" value="">';
    			row += '<input type="file" name="researchPaperFile'+plusScCnt+'"  id="researchPaperFile'+plusScCnt+'" value="">';
    			row += '</td>';
    		   	row += "</tr>";
    		    $("#researchPaperlist").append(row);

    		}else if(mode == "inProperty"){
    			var StartId = $('input[name=ipStart]:last').attr('id');
    			var cnt = StartId.substring(7,8); //0?????? ??????
    		    var plusScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
    			/* ????????????  */
    			
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
    			

    			if($('input[name=ipStart]:last').val() == "" ){
    				$('input[name=ipStart]:last').focus();
    				alert("????????????????????? ?????? ????????????");
    				return false;
    			}
    			if(datePattern.test($('input[name=ipStart]:last').val()) == false){
					alert("?????????????????? : ex) 2016-01-01");
					$('input[name=ipStart]:last').focus();
					return false;
				}
    			
    			if($('input[name=ipPublication]:last').val() == ""){
    				$('input[name=ipPublication]:last').focus();
    				alert("??????/???????????? ?????? ????????????");
    				return false;
    			}
    			
    			/* if($('input[name^=inPropertyFile]:last').val() == "" && $("input[name=ipFile]:last").val() == ""){
    				alert("??????????????? ?????? ????????????");
    				return false;
    			} */
    			
    			var row = "";
    			row += '<tr class="inProperty'+plusScCnt+'">';
         		row += '<th scope="row" class="tit">???????????????</th>';
         		row += '<td><input type="text" name="ipNm" value="" style="width:100%;" class="inp_txt"></td>';
         		row += '<th scope="row" class="tit">??????????????????</th>';
         		row += '<td>';
    			row += '<select class="select_box" name="ipType" style="width:100%;">';
           		row += '	<option value="">??????</option>';
           				<% for(HashMap rsx:jipCd) {%>
    			row += '	<option value="<%=util.getStr(rsx.get("CODE_CD"))%>"><%=util.getStr(rsx.get("CODE_NM"))%></option>';
    					<% } %>
           		row += '</select>';
         		row += '</td>';
         		row += '</tr>';
         		row += '<tr class="inProperty'+plusScCnt+'">';
         		row += '<th scope="row" class="tit">??????????????????</th>';
         		row += '<td>';
         		row += '<select name="ipState" class="select_box" style="width:100%;">';
         		row += '	<option value="??????">??????</option>';
         		row += '	<option value="??????">??????</option>';
         		row += '</select>';
         		row += '</td>';
         		row += '<th scope="row" class="tit">??????????????????</th>';
         		row += '<td><input type="text" name="ipStart" readonly id="ipStart'+plusScCnt+'" value="" style="width:100%;" class="inp_txt"></td>';
         		row += '</tr>';
         		row += '<tr class="inProperty'+plusScCnt+'">';
         		row += '<th scope="row" class="tit">??????/?????????</th>';
         		row += '<td colspan="3"><input type="text" name="ipPublication" value="" style="width:100%;" class="inp_txt"></td>';
    			row += '</tr>';
    			row += '<tr class="inProperty'+plusScCnt+'">';
         		row += '<th scope="row" class="tit">????????????</th>';
         		row += '<td colspan="3">';
         		row += '	<input type="hidden" name="ipFile" id="ipFile'+plusScCnt+'" value="">';
    			row += '	<input type="file" name="inPropertyFile'+plusScCnt+'" id="inPropertyFile'+plusScCnt+'" value="">';
         		row += '</td>';
    			row += '</tr>';

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
  		    if($('input[name=conOrg]:last').val() == ""){
  				$('input[name=conOrg]:last').focus();
  				alert("?????????????????? ?????? ????????????");
  				return false;
  			}
  			if($('input[name=conSdate]:last').val() == "" ){
  				$('input[name=conSdate]:last').focus();
  				alert("?????????????????? ?????? ????????????");
  				return false;
  			}
  			if(datePattern.test($('input[name=conSdate]:last').val()) == false){
				alert("?????????????????? : ex) 2016-01-01");
				$('input[name=conSdate]:last').focus();
				return false;
			}
  			if(!$("input[name^=conIng]:last").is(":checked")){
	  			if($('input[name=conEdate]:last').val() == "" ){
	  				$('input[name=conEdate]:last').focus();
	  				alert("?????????????????? ?????? ????????????");
	  				return false;
	  			}
	  			if(datePattern.test($('input[name=conEdate]:last').val()) == false){
					alert("??????????????????: ex) 2016-01-01");
					$('input[name=conEdate]:last').focus();
					return false;
				}
  			}
  			
  			
  			if($('input[name=conContent]:last').val() == ""){
  				$('input[name=conContent]:last').focus();
  				alert("?????????????????? ?????? ????????????");
  				return false;
  			}
  			
  			var row = "";
  			
  			row += "<tr class='resultCon"+plusScCnt+"'>";
  			row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ??????????????????</th>';
  			row += '<td colspan="3">';
  			row += '	<label><input type="radio" name="conType'+plusScCnt+'" value="Y" checked/>??????</label>';
  			row += '	<label><input type="radio" name="conType'+plusScCnt+'" value="N"/>??????</label>';
  			row += '</td>';
  			row += '</tr>';
  			row += '<tr class="resultCon'+plusScCnt+'">';
  			row += '	<th scope="row" class="tit"><span style="color:red;" >*</span>????????? ?????????(????????????)</th>';
  			row += '	<td>';
  			row += '		<input type="text" name="conName" id="conName'+plusScCnt+'" value="" class="inp_txt">';
  			row += '	</td>';
  			row += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
  			row += '	<td>';
  			row += '		<input type="text" name="conOrg" id="conOrg'+plusScCnt+'" value="" class="inp_txt">';
  			row += '	</td>';
  			row += '</tr>';
  			row += '<tr class="resultCon'+plusScCnt+'">';
  			row += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ????????????</th>';
  			row += '	<td>';
  			row += '		<input type="text" name="conSdate" readonly id="conSdate'+plusScCnt+'" value="" class="inp_txt">';
  			row += '	</td>';
  			row += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????? ????????????</th>';
  			row += '	<td>';
  			row += '		<input type="text" name="conEdate" readonly id="conEdate'+plusScCnt+'" value="" style="width:60%" class="inp_txt">';
  			row += '		<label><input type="checkbox" name="conIng'+plusScCnt+'" id="conIng'+plusScCnt+'" value="1" />?????????</label>';
  			row += '	</td>';
  			row += '</tr>';
  			row += '<tr class="resultCon'+plusScCnt+'" style="border-bottom:3px solid #ddd">';
  			row += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
  			row += '	<td colspan="3">';
  			row += '		<input type="text" name="conContent" id="conContent'+plusScCnt+'" value="" style="width:100%;" class="inp_txt">';
  			row += '	</td>';
  			row += '</tr>';
  			
  			
  		    $("#resultConlist").append(row);
  		}


		//date
	   setLicenseBtn(plusScCnt, mode);
	}
	
	
	
	var delFiles = new Array();
	
	function delRow(mode){
		if(mode=="academic"){
			if($('input[name=scNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=scNm]').size() - 1;
			if($("#acFile"+delCnt).val() != ""){
				delFiles.push($("#acFile"+delCnt).val());
			}
			var parenttr = $(".academic_career_info"+delCnt).remove();
		}else if(mode == "career"){
			if($('input[name=crNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=crNm]').size() - 1;
			var parenttr = $(".career_info"+delCnt).remove();
		}else if(mode == "activity"){
			if($('input[name=acNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=acNm]').size() - 1;
			var parenttr = $(".activity"+delCnt).remove();
		}else if(mode == "RnDresult"){
			if($('input[name=rdNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=rdNm]').size() - 1;
			var parenttr = $(".RnDresult"+delCnt).remove();
		}else if(mode == "qualification"){
			if($('input[name=quNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=quNm]').size() - 1;
			var parenttr = $(".qualification"+delCnt).remove();
		}else if(mode == "research"){
			if($('input[name=reNote]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=reNote]').size() - 1;
			var parenttr = $(".research"+delCnt).remove();

		}else if(mode == "evaluate"){
			if($('input[name=evNote]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=evNote]').size() - 1;
			var parenttr = $(".evaluate"+delCnt).remove();

		}else if(mode == "consulting"){
			if($('input[name=coNote]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=coNote]').size() - 1;
			var parenttr = $(".consulting"+delCnt).remove();

		}else if(mode == "researchPaper"){
			if($('input[name=rpNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=rpNm]').size() - 1;
			var parenttr = $(".researchPaper"+delCnt).remove();

		}else if(mode == "inProperty"){
			if($('input[name=ipNm]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=ipNm]').size() - 1;
			var parenttr = $(".inProperty"+delCnt).remove();

		}else if(mode == "awardCareer"){
			if($('input[name=awStart]').size() == 1){
				alert("?????? ??? ??? ????????????.");
				return false;
			};
			var delCnt = $('input[name=awStart]').size() - 1;
			var parenttr = $(".awardCareer"+delCnt).remove();

		}else if(mode == "resultEv"){
   			if($('input[name=evSdate]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=evSdate]').size() - 1;
   			var parenttr = $(".resultEv"+delCnt).remove();
   		}else if(mode == "resultCon"){
   			if($('input[name=conSdate]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=conSdate]').size() - 1;
   			var parenttr = $(".resultCon"+delCnt).remove();
   		}


		setLicenseBtn();
	}

	function setLicenseBtn(plusScCnt, mode){
		/* DatePicker ?????? */
		var date ="";
		if(mode == "academic"){
			date = "#scStart"+plusScCnt+", #scFinish"+plusScCnt+", #scDate"+plusScCnt;
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

				/* showButtonPanel:true,
				yearRange: '1980:2020' */
			});


	};
	
	
	function orgPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#COM_ZIP").val(data.zonecode);
	             $("#COM_ADDR1").val(data.address);
	             $("#COM_ADDR2").focus();

	             if(data.address.indexOf("??????")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').trigger("click");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').trigger("click");
	            	}

	             /**/
	                // ??? ????????? ?????? ????????? ?????? ????????? ????????????.
	                // ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
	                var fullAddr = data.address; // ?????? ?????? ??????
	                var extraAddr = ''; // ????????? ?????? ??????

	                // ?????? ????????? ????????? ???????????? ????????????.
	                if(data.addressType === 'R'){
	                    //??????????????? ?????? ?????? ????????????.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // ???????????? ?????? ?????? ????????????.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // ?????????????????? ????????? ?????? ????????? ????????? ???????????? ?????? ????????? ?????????.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                

	        }
	    }).open();
	}

</script>