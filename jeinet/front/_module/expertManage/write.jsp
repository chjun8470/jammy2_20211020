<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO"%>
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

       SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
       String siteId = siteInfoVO.getSiteId();

       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String userIdx = util.getStr(paramMap.get("userIdx"));
       String m = util.getStr(paramMap.get("m"));
       if("".equals(mode)) mode = "write";

       String fileGrp = "expertManage";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

       int scCnt = 0;

%>
<style type="text/css">
.ui-datepicker-calendar {
    display: none;
    }
    button.ui-datepicker-current { display: none; }
</style>
<form name="fwrite" id="fwrite" action="/web/expertManage.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="proState" id="proState"  />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID")) %>" />

	<div class="basic_writeWrap005">
	<div class="redTxt" style="margin-bottom:10px">* ?????? ?????????????????????.</div>

<!-- ???????????? S -->
	<h2 class="h4_tit">????????????</h2>
	<table class="skin_write005" >
		<caption>????????????</caption>
	        <colgroup>
	              <col style="width:15%" />
	              <col style="width:35%" />
	              <col style="width:15%" />
	              <col style="width:35%" />
	        </colgroup>
            <tbody>
            	<tr>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ??????</th>
            		<td>
            			<%=util.getStr(dataMap.get("PSN_NM")) %>
            		</td>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ??????</th>
            		<td class="r_line_none">
            			<%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "??????" : "??????" %>

            		</td>
            	</tr>
            	<tr>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
            		<td>
            			<%if(util.getStr(dataMap.get("BIRTH_DATE")).equals("")||util.getStr(dataMap.get("BIRTH_DATE")).equals(null)){ %>
            				<input type="text" name="birthDate" id="birthDate"  class="input_txt00501" maxlength="4" />
            			<%}else{ %>
            				<input type="text" name="birthDate" id="birthDate" value="<%=util.getStr(dataMap.get("BIRTH_DATE")) %>"  style="border:0px;"  readonly  />
            			<%} %>
            		</td>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> email</th>
            		<td class="r_line_none">
            			<%if(util.getStr(dataMap.get("EMAIL")).equals("")||util.getStr(dataMap.get("EMAIL")).equals(null)){ %>
            				<input type="text" name="email" id="email"  class="input_txt00501" maxlength="100" />
            			<%}else{ %>
            				<input type="text" name="email" id="email" value="<%=util.getStr(dataMap.get("EMAIL")) %>"  style="border:0px;"  readonly  />
            			<%} %>
            		</td>
            	</tr>
            	<tr>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ??????</th>
            		<td>
            			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
            				if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
            					<input type="text" name="proUserForg" id="proUserForg"  class="input_txt00501" maxlength="100" />
            				<%}else{%>
            					<input type="text" name="proUserForg" id="proUserForg" value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>"  style="border:0px;"  readonly  />
            				<%} %>
            			<%}else{ %>
            				????????????
            			<%} %>
            		</td>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
            		<td class="r_line_none">
            			<%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals("") || util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(null)){%>
            					&nbsp;&nbsp;???????????? <input type="radio" name="Area" value="1"  checked="checked" onclick="area('1')"/>
								&nbsp;&nbsp;??? ??? ?????? <input type="radio" name="Area" value="2"  onclick="area('2')"/>&nbsp;&nbsp;
								<select class="select00501" style="width:40%" name="ProUserBirthplace" id="ProUserBirthplace1">
									<option value="">???????????????</option>
									<%
										int utilitynumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(paramMap.get("searchArea")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea++; } %>
								</select>
								<select class="select00501" name="ProUserBirthplace" id="ProUserBirthplace2" style="display:none; width:40%">
									<option value="">???????????????</option>
									<%
										int utilitynumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(paramMap.get("searchArea")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea2++; } %>
								</select>
            			<%}else{%>
            					<input type="text" name="ProUserBirthplace" id="ProUserBirthplace" value="<%=util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")) %>"  style="border:0px;"  readonly  />
            			<%} %>


            		</td>
            	</tr>
            	<tr>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
            		<td>
            			<%if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
            				<input type="text" name="telNo" id="telNo"  class="input_txt00501" maxlength="100" />
            			<%}else{ %>
            				<input type="text" name="telNo" id="telNo" value="<%=util.getStr(dataMap.get("TEL_NO")) %>"  style="border:0px;"  readonly />
            			<%} %>
	         		</td>
	         		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
            		<td class="r_line_none">
            			<%if(util.getStr(dataMap.get("CP_NO")).equals("")||util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
            				<input type="text" name="cpNo" id="cpNo"  class="input_txt00501" maxlength="100" />
            			<%}else{ %>
            				<input type="text" name="cpNo" id="cpNo" value="<%=util.getStr(dataMap.get("CP_NO")) %>"  style="border:0px;"  readonly  />
            			<%} %>
         			</td>
            	</tr>
            	<tr>
            		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
                   	<td colspan="3"  class="r_line_none">
                   		<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
                        	<div>
                            	<input type="file" class="select_file00501" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="????????????" />
                            </div>
                        </div>
						<input type="checkbox" name="photoCheck" id="photoCheck" value="N" />&nbsp;???????????????
                	</td>
            	</tr>
<%if(siteId.endsWith("jntis")){ %>
            	<tr>
      	   			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ???????????????</th>
            		<td colspan="3"  class="r_line_none">
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
            		<th scope="row">????????????</th>
            		<td colspan="3" class="r_line_none">
						<textarea name="proUserInterestWorld" style="width:100%; height:40px;"></textarea>
					</td>
            	</tr>
<%} %>
     		</tbody>
	   	</table>
<!-- ???????????? E -->

<!-- ???????????? S -->
<%if(!(util.getStr(dataMap.get("ORG_GRP_CD"))).equals("") && !(util.getStr(dataMap.get("ORG_GRP_CD"))).equals(null)){ %>

	<h2 class="h4_tit">????????????</h2>
        <table class="skin_write005" >
       		<caption>????????????</caption>
            <colgroup>
                  <col style="width:15%" />
                  <col style="width:35%" />
                  <col style="width:15%" />
                  <col style="width:35%" />
            </colgroup>
            <tbody>
	           	<tr>
	           		<th scope="row" >?????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
	           		</td>
	           		<th scope="row" >????????????</th>
	           		<td class="r_line_none">
	           			<%=util.getStr(dataMap.get("ORG_TYPE")) %>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" >????????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("HOMEPAGE")) %>
	           		</td>
	           		<th scope="row" >????????????</th>
	           		<td class="r_line_none">
	           			<%=util.getStr(dataMap.get("CORP_PHONE")) %>
	           		</td>
	           	</tr>
	           	<tr>
	           		<th scope="row" >?????????</th>
	           		<td>
	           			<%=util.getStr(dataMap.get("DEPT_NM")) %>
	           		</td>
	           		<th scope="row" >??????</th>
	           		<td class="r_line_none">
	           			<%=util.getStr(dataMap.get("POSITION_NM")) %>
	           		</td>
	           	</tr>
            </tbody>
	   	</table>
<%} %>
<!-- ???????????? E -->
<!-- ???????????? S -->
		<h2 class="h4_tit">????????????</h2>
        <div class="zoom005 PAT15">
		<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('academic')" />
		<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('academic')" /></div>
   		<table class="skin_write005 AlignCenter"  >
   			<colgroup>
	            <col style="width:25%" />
          		<col style="width:25%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:25%" />
            </colgroup>
		<tbody id="academiclist">

         	<tr>
         		<th scope="row" class="tit"><span style="color:red; font-size:11pt;">*</span> ?????????</th>
         		<th scope="row" class="tit"><span style="color:red; font-size:11pt;">*</span> ?????????</th>
         		<th scope="row" class="tit" colspan="2"><span style="color:red; font-size:11pt;">*</span> ??????</th>
         		<th scope="row" class="tit"><span style="color:red; font-size:11pt;">*</span> ????????????</th>
         	</tr>
            <tr id="academic_career_info<%=scCnt%>">
          		<td><input type="text" name="scNm" class="input_txt00502" /></td>
          		<td><input type="text" name="scLocation" class="input_txt00502" /></td>
          		<td><input type="text" name="scStart" id="scStart<%=scCnt%>" class="input_txt00503" /></td>
          		<td><input type="text" name="scFinish" id="scFinish<%=scCnt%>" class="input_txt00503" /></td>
          		<td class="r_line_none">
          			<select class="select00501"  name="scDegree">
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
		<table class="skin_write005 AlignCenter"  >
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
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
			<td>
				<select class="select00501" name="exMajor" onchange="majorDeth1('exRealm')" >
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
			<td>
				<select class="select00501" name="exRealm" onchange="majorDeth2('exDetail')"><option >???????????????.</option></select>
			</td>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
			<td class="r_line_none">
				<input type="text" name="exDetail" id="exDetail<%=scCnt%>" class="input_txt00502" />
			</td>
		</tr>
		<tr>
			<th scope="row" >??????????????????</th>
			<td>
				<select class="select00501" name="pluralExMajor" onchange="majorDeth1('pluralExRealm')">
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" >????????????</th>
			<td>
				<select class="select00501" name="pluralExRealm" onchange="majorDeth2('pluralExDetail')"><option >???????????????.</option></select>
			</td>
			<th scope="row" >????????????</th>
			<td class="r_line_none">
				<input type="text" name="pluralExDetail" id="pluralExDetail" class="input_txt00502" />
			</td>
		</tr>
	</table>
<!-- ???????????? E -->
		<h2 class="h4_tit">????????????</h2>
        <div class="zoom005 PAT15">
		<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('career')" />
		<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('career')" />
        </div>
   		<table class="skin_write005 AlignCenter"  >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:20%" />
          		<col style="width:15%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
<!-- ???????????? S -->
          <tbody id="careerlist">
          	<tr>
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ?????????</th>
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ?????????</th>
          		<th scope="row"  colspan="2"><span style="color:red; font-size:11pt;">*</span> ??????</th>
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> ????????????</th>
          		<th scope="row" class="r_line_none"><span style="color:red; font-size:11pt;">*</span> ????????????</th>
			</tr>
        	<tr id="career_info<%=scCnt%>">
				<td><input type="text" name="crNm" class="input_txt00502" /></td>
				<td><input type="text" name="crLocation" class="input_txt00502" /></td>
				<td><input type="text" name="crStart" id="crStart<%=scCnt%>" class="input_txt00503" /></td>
				<td><input type="text" name="crFinish" id="crFinish<%=scCnt%>" class="input_txt00503" /></td>
				<td><input type="text" name="crDept" class="input_txt00502" /></td>
				<td class="r_line_none"><input type="text" name="crWork" class="input_txt00501" /></td>
            </tr>
		</tbody>
<!-- ???????????? E -->
		</table>


		<h2 class="h4_tit">????????????</h2>
        <div class="zoom005 PAT15">
		<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('activity')" />
		<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('activity')" /></div>
   		<table class="skin_write005 AlignCenter"  >
   			<caption>????????????</caption>
            <colgroup>
          		<col style="width:35%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
<!-- ???????????? S -->
		<tbody id="activitylist">
           	<tr>
           		<th scope="row" >??????(??????)???</th>
           		<th scope="row"  colspan="2">??????</th>
           		<th scope="row" >??????</th>
           		<th scope="row"  class="r_line_none">????????????</th>
           	</tr>
         	<tr id="activity<%=scCnt%>">
         		<td><input type="text" name="acNm" class="input_txt00501" /></td>
         		<td><input type="text" name="acStart" id="acStart<%=scCnt%>" class="input_txt00503" /></td>
         		<td><input type="text" name="acFinish" id="acFinish<%=scCnt%>" class="input_txt00503" /></td>
         		<td><input type="text" name="acDept" class="input_txt00502" /></td>
         		<td class="r_line_none"><input type="text" name="acWork" class="input_txt00501" /></td>
         	</tr>
		</tbody>
	</table>
<!-- ???????????? E -->
<!-- ??????????????????(????????????) ???????????? S -->

	<h2 class="h4_tit">??????????????????(????????????) ????????????</h2>
	<div class="zoom005 PAT15"><input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('RnDresult')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('RnDresult')" /></div>
	<table class="skin_write005 AlignCenter">
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
	<tbody id="RnDresultlist">
       	<tr>
       		<th scope="row" >??????</th>
       		<th scope="row" >??????/??????/????????????</th>
       		<th scope="row" >?????????</th>
       		<th scope="row" >?????????</th>
       		<th scope="row"  colspan="2">?????????????????????</th>
       		<th scope="row" >?????????</th>
       		<th scope="row" class="r_line_none">????????????</th>
       	</tr>
     	<tr id="RnDresult<%=scCnt%>">
     		<td><input type="text" name="rdSerialNum" class="input_txt00503" /></td>
     		<td><input type="text" name="rdOrgNm" class="input_txt00502" /></td>
     		<td><input type="text" name="rdBusinessNm" class="input_txt00502" /></td>
     		<td><input type="text" name="rdNm" class="input_txt00502" /></td>
     		<td><input type="text" name="rdStart" id="rdStart<%=scCnt%>" class="input_txt00503" /></td>
     		<td><input type="text" name="rdFinish" id="rdFinish<%=scCnt%>" class="input_txt00503" /></td>
     		<td><input type="text" name="rdExpenses" class="input_txt00503" /></td>
       		<td class="r_line_none">
       			<select class="select00501" name="rdForm">
       				<option value="">??????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????or???????????????">??????or???????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="???????????????">???????????????</option>
       			</select>
       		</td>
		</tr>
	</tbody>
	</table>
<!-- ??????????????????(????????????) ???????????? E -->
<!-- ???????????? ???????????? S -->
	<h2 class="h4_tit">???????????? ????????????</h2>
    <div class="zoom005 PAT15">
	<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('resultEv')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('resultEv')" /></div>
	<table class="skin_write005 AlignCenter"  >
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
   			<td><input type="text" name="evName" id="evName<%=scCnt %>" class="input_txt00501" /></td>
   			<td><input type="text" name="evOrg" id="evOrg<%=scCnt %>" class="input_txt00501" /></td>
   			<td><input type="text" name="evSdate" id="evSdate<%=scCnt %>" class="input_txt00503" /></td>
   			<td><input type="text" name="evEdate" id="evEdate<%=scCnt %>" class="input_txt00503" /></td>
   			<td class="r_line_none"><input type="text" name="evContent" id="evContent<%=scCnt %>" class="input_txt00501"/></td>
     	</tr>
	</tbody>
	</table>
<!-- ???????????? ???????????? E -->
<!-- ????????? ???????????? S -->
	<h2 class="h4_tit">????????? ????????????</h2>
    <div class="zoom005 PAT15">
	<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('resultCon')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('resultCon')" /></div>
	<table class="skin_write005 AlignCenter"  >
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
   			<td><input type="text" name="conName" id="conName<%=scCnt %>" class="input_txt00501" /></td>
   			<td><input type="text" name="conOrg" id="conOrg<%=scCnt %>" class="input_txt00501" /></td>
   			<td><input type="text" name="conSdate" id="conSdate<%=scCnt %>" class="input_txt00503" /></td>
   			<td><input type="text" name="conEdate" id="conEdate<%=scCnt %>" class="input_txt00503" /></td>
   			<td class="r_line_none"><input type="text" name="conContent" id="conContent<%=scCnt %>" class="input_txt00501" /></td>
     	</tr>
	</tbody>
	</table>
<!-- ????????? ???????????? E -->

<!-- ???????????? ?????? S -->

	<h2 class="h4_tit">???????????? ??????</h2>
    <div class="zoom005 PAT15">
	<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('researchPaper')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('researchPaper')" /></div>
	<table class="skin_write005 AlignCenter" >
		<caption>???????????? ??????</caption>
	       <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
	       </colgroup>
	<tbody id="researchPaperlist">
       	<tr>
       		<th scope="row" >??????</th>
       		<th scope="row" >?????????</th>
       		<th scope="row" >????????????</th>
       		<th scope="row" >????????????</th>
       		<th scope="row" class="r_line_none">????????????</th>

       	</tr>
     	<tr id="researchPaper<%=scCnt%>">
     		<td><input type="text" name="rpSerialNum" class="input_txt00503" /></td>
     		<td><input type="text" name="rpNm" class="input_txt00501" /></td>
     		<td>
				<select class="select00501" name="rpType">
       				<option value="">??????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????????????????">??????????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????????????????">??????????????????</option>
       				<option value="???????????????">???????????????</option>
       			</select>
     		</td>
     		<td><input type="text" name="rpJournalNm" class="input_txt00502"  /></td>
     		<td class="r_line_none"><input type="text" name="rpStart" id="rpStart<%=scCnt%>" class="input_txt00503" /></td>
		</tr>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->
<!-- ???????????? ?????? S -->

	<h2 class="h4_tit">???????????? ??????</h2>
    <div class="zoom005 PAT15 ">
	<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('inProperty')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('inProperty')" />
    </div>
	<table class="skin_write005 AlignCenter">
		<caption>???????????? ??????</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
        </colgroup>
	<tbody id="inPropertylist">
       	<tr>
       		<th scope="row" >??????</th>
       		<th scope="row" >???????????????</th>
       		<th scope="row" >??????????????????</th>
       		<th scope="row" >??????/?????????</th>
       		<th scope="row" class="r_line_none">????????????</th>

       	</tr>
     	<tr id="inProperty<%=scCnt%>">
     		<td><input type="text" name="ipSerialNum" class="input_txt00503" /></td>
     		<td><input type="text" name="ipNm" class="input_txt00501" /></td>
     		<td>
				<select class="select00501" name="ipType">
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
     		<td><input type="text" name="ipPublication" class="input_txt00502" /></td>
     		<td class="r_line_none"><input type="text" name="ipStart" id="ipStart<%=scCnt%>" class="input_txt00503" /></td>
		</tr>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->
<!-- ?????? ?????? S -->

	<h2 class="h4_tit">????????????</h2>
    <div class="zoom005 PAT15">
	<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('awardCareer')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('awardCareer')" />
    </div>
	<table class="skin_write005 AlignCenter">
		<caption>?????? ??????</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
        </colgroup>
 	<tbody id="awardCareerlist">
 		<tr>
       		<th scope="row" >??????</th>
       		<th scope="row" >??????</th>
       		<th scope="row" >????????????</th>
       		<th scope="row" >????????????</th>
       		<th scope="row" class="r_line_none">????????????</th>

       	</tr>
     	<tr id="awardCareer<%=scCnt%>">
     		<td><input type="text" name="awSerialNum" class="input_txt00503" /></td>
     		<td>
				<select class="select00501" name="awBadge" >
       				<option value="">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart" id="awStart<%=scCnt%>" class="input_txt00503" /></td>
     		<td><input type="text" name="awPresent" class="input_txt00502" /></td>
     		<td class="r_line_none"><input type="text" name="awContent" class="input_txt00501" /></td>
		</tr>
	</tbody>
	</table>
<!-- ?????? ?????? E -->
<!-- ???????????? S -->

	<h2 class="h4_tit">????????????</h2>
    <div class="zoom005 PAT15">
	<input type="button" name="addbtn" value="+" class="btn_add005" onclick="addRow('qualification')" />
	<input type="button" name="delbtn" value="-" class="btn_del005" onclick="delRow('qualification')" /></div>
	<table class="skin_write005 AlignCenter">
		<caption>????????????</caption>
	    <colgroup>
			<col style="width:10%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
		</colgroup>
	<tbody id="qualificationlist">
       	<tr>
       		<th scope="row" >??????</th>
       		<th scope="row" >?????????</th>
       		<th scope="row" >???????????????</th>
       		<th scope="row" >????????????</th>
       		<th scope="row" class="r_line_none">?????????</th>
       	</tr>
       	<tr id="qualification<%=scCnt%>">
       		<td><input type="text" name="quSerialNum" class="input_txt00503" /></td>
       		<td><input type="text" name="quStart" id="quStart<%=scCnt%>" class="input_txt00503" /></td>
       		<td><input type="text" name="quOrgNm" class="input_txt00502" /></td>
       		<td>
       			<select class="select00501" name="quDivide">
       				<option value="">???????????????</option>
       				<option value="????????????">????????????</option>
       				<option value="????????????">????????????</option>
       				<option value="????????????">????????????</option>
       			</select>
       		</td>
       		<td class="r_line_none"><input type="text" name="quNm" class="input_txt00501" /></td>
       	</tr>
	</tbody>
	</table>
<!-- ???????????? E -->
	   </div>
              <!-- bo_btn  -->
              <div class="b_btn_area">
                     <input type="button" id="bnt" class="btn_rgt" value="????????????" onclick="goSubmit('writeProc','10')"/>
                     <input type="button" class="btn_lft2" value="??????" onclick="goSubmit('list')"/>
              </div>
              <!--// bo_btn -->
</form>


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function(){
    	if($('#siteId').val() == "jntis"){
    	$('#bnt').attr("onclick","goCheck()");
    	}
    });

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
//????????????-???????????? S
	function area(no){
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

	function goCheck(){
			if($('input[name=proJntisConsulting]').is(":checked") == false && $('input[name=proJntisMarketing]').is(":checked") == false && $('input[name=proJntisPlanning]').is(":checked") == false && $('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
				alert("?????????????????? ??????????????????");
				return false;
			}
			var imgFormat = "\.(bmp|gif|jpg|jpeg|png)$";
		  	var fileCount = $("input[type=file]").length;

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
			if($('input[name=crFinish]:last').val() != "" && $('input[name=crFinish]:last').val() != null){
				if(datePattern.test($('input[name=crFinish]:last').val()) == false){
					alert("????????????(??????) : ex) 2016-01");
					$('input[name=crFinish]:last').focus();
					return false;
				}
			}
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

	function goSubmit(mode,proState){
  	   	$('#proState').val(proState);
  		$('#mode').val(mode);
  		if(mode == "list"){
			$('#fwrite').attr('action','sub.do');
		}
          $('#fwrite').submit();
    }

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
	            	$('select[name='+mode+']:last').html("");
	            	$('select[name='+mode+']:last').append(result);
	             }
	    	});
		}
		function majorDeth2(mode){
			var result = "";
			var mode = mode;
			if(mode == "exDetail"){
				var deth2 = $('select[name=exRealm]:last').val();
			}else if(mode == "pluralExDetail"){
				var deth2 = $('select[name=pluralExRealm]:last').val();
			}
			$.ajax({
	             type: "POST",
	             data : {
	            	 deth2 : deth2
	             },
	             url : '/sys/dethCheck.do',
	             dataType : 'json',
	             success : function(data){
	            	 $('select[name='+mode+']:last').html("");
	            	result += "<option value=''>???????????????.</option>";
	            	for(i=0; i<data.cnt; i++){
						result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
					}
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

       function popupWindow(listMode){
			var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

			var popUrl="/sys/popup/"+listMode+".do";
			var popOption="width=500, height=550, resizable=no, scrollbars=no, status=no;";
			window.open(popUrl,"",popOption);
		}

       $("#evSdate0,#evEdate0,#conSdate0,#conEdate0,#scStart0, #scFinish0, #crStart0, #crFinish0, #acStart0, #acFinish0, #rdStart0, #rdFinish0, #quStart0, #rpStart0, #ipStart0, #awStart0").datepicker({
       	showMonthAfterYear : true,
       	showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	nextText : '?????? ???',
       	prevText : '?????? ???',
      	currentText : '?????? ??????',
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
        },
        ////////////////////
	    beforeShow: function( input ) {
           $(input).datepicker("widget").find(".ui-datepicker-current").hide();
        },
        showButtonPanel:true,
		yearRange: '1980:2020'

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
    		 	row += "<td><input type='text' name='scDegree' style='width:100%;' class='inp_txt'></td>";
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
    		 	row += "<td><input type='text' name='crStart' id='crStart"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
    		 	row += "<td><input type='text' name='crFinish' id='crFinish"+plusScCnt+"' style='width:100%;' class='inp_txt'></td>";
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
    		 	row += "<td colspan='2'><input type='text' name='acNm' style='width:100%;' class='inp_txt'></td>";
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
    		 	row += "<td><input type='text' name='quSerialNum' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='quStart' id='quStart"+plusScCnt+"' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='quOrgNm' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td>";
    		 	row += "<select class='select_box' name='quDivide' style='width:95%;'>";
    		 	row += "<option value='''>???????????????</option>";
    		 	row += "<option value='????????????'>????????????</option>";
    		 	row += "<option value='????????????'>????????????</option>";
    			row += "<option value='????????????'>????????????</option>";
    			row += "</select>";
    			row += "</td>";
    		 	row += "<td><input type='text' name='quNm' style='width:95%;' class='inp_txt02'></td>";
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
    		 	row += "<td colspan='2'><input type='text' name='reNote' id='resNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' placeholder='??????'></td>";
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
    		 	row += "<td colspan='2'><input type='text' name='evNote' id='evlNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' placeholder='??????'></td>";
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
    		 	row += "<td colspan='2'><input type='text' name='conNote' id='conNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' placeholder='??????'></td>";
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
    		 	row += "<td><input type='text' name='rpSerialNum' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='rpNm' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td>";
    		 	row += "<select class='select_box' name='rpType' style='width:95%;'>";
    		 	row += "<option value='''>???????????????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    		 	row += "<option value='??????????????????'>??????????????????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    		 	row += "<option value='??????????????????'>??????????????????</option>";
    			row += "<option value='???????????????'>???????????????</option>";
    			row += "</select>";
    			row += "</td>";
    			row += "<td><input type='text' name='rpJournalNm' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='rpStart' id='rpStart"+plusScCnt+"' style='width:95%;' class='inp_txt02'></td>";
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
    		 	row += "<td><input type='text' name='ipSerialNum' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='ipNm' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td>";
    		 	row += "<select class='select_box'  name='ipType' style='width:95%;'>";
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
    			row += "<td><input type='text' name='ipPublication' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='ipStart' id='ipStart"+plusScCnt+"' style='width:95%;' class='inp_txt02'></td>";
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
    		 	row += "<td><input type='text' name='awSerialNum' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td>";
    		 	row += "<select class='select_box'  name='awBadge' style='width:95%;'>";
    		 	row += "<option value='''>???????????????</option>";
    		 	row += "<option value='??????'>??????</option>";
    		 	row += "<option value='??????'>??????</option>";
    			row += "<option value='??????'>??????</option>";
    			row += "</select>";
    			row += "</td>";
    		 	row += "<td><input type='text' name='awStart' id='awStart"+plusScCnt+"' style='width:95%;' class='inp_txt02'></td>";
    		 	row += "<td><input type='text' name='awPresent' style='width:95%;' class='inp_txt02'></td>";
    			row += "<td><input type='text' name='awContent' style='width:95%;' class='inp_txt02'></td>";
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
   		 	row += "<td><input type='text' name='evName'  style='width:95%;' class='inp_txt02'></td>";
   		 	row += "<td><input type='text' name='evOrg'  style='width:95%;' class='inp_txt02'></td>";
   		 	row += "<td><input type='text' name='evSdate' id='evSdate"+plusScCnt+"'  style='width:95%;' class='inp_txt02'></td>";
   		 	row += "<td><input type='text' name='evEdate' id='evEdate"+plusScCnt+"'   style='width:95%;' class='inp_txt02'></td>";
   			row += "<td><input type='text' name='evContent' style='width:95%;' class='inp_txt02'></td>";
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
  		 	row += "<td><input type='text' name='conName' style='width:95%;' class='inp_txt02'></td>";
  		 	row += "<td><input type='text' name='conOrg' style='width:95%;' class='inp_txt02'></td>";
  		 	row += "<td><input type='text' name='conSdate' id='conSdate"+plusScCnt+"' style='width:95%;' class='inp_txt02'></td>";
  		 	row += "<td><input type='text' name='conEdate' id='conEdate"+plusScCnt+"' style='width:95%;' class='inp_txt02'></td>";
  			row += "<td><input type='text' name='conContent' style='width:95%;' class='inp_txt02'></td>";
  		   	row += "</tr>";
  		    $("#resultConlist").append(row);
  		}


    		//date
    	   setLicenseBtn(plusScCnt, mode);
    	}
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
    				currentText : '?????? ??????',
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
    			    },
    				showButtonPanel:true,
    				yearRange: '1980:2020'

    			});


    	};

//]]>
</script>