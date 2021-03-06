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
	
   	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
  	ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
  	ArrayList<HashMap<String, String>> agencyList  = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
  	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
  	
   	String xcount = util.getStr(paramMap.get("xcount"));
	
	String fileGrp = "Jnrdtypeb";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
     	
       
%>

<jsp:useBean id="currTime" class="java.util.Date" />


<div class="typeBformContent" id="typeBformContent<%=xcount%>">
<h3 style="clear:both; font-size:16px; padding:15px 20px; margin-top:15px; background:#f8f8f8;  ">????????????-<%=xcount%></h3>
<form name="typebform_<%=xcount%>" id="typebform_<%=xcount%>" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="xcount" value="<%=xcount%>" />
	
	<h3 class="tit">- ??????(??????)??????</h3>
	<table class="skin_basic_write" >
		<caption>??????(??????)??????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			
           			<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
          			<select name="yxyear" id="yxyear" class="select_box" style="width:150px;">
         				<option value="">:::??????:::</option>
         				<c:forEach var="i" begin="2018" end="${currTime}">
            			<option value="${i}">${i}</option>
            			</c:forEach>
         			</select>
         			
         			<label><input type="checkbox" name="yxstatus" value="1"> ?????????</label>
           			
           		</td>
           	</tr>
           	
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)?????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="yxtype1" value="?????? R&D" checked="checked"> ??????R&D</label>
	           		<label><input type="radio" name="yxtype1" value="?????? ???R&D"> ?????? ???R&D</label> 
	           		<label><input type="radio" name="yxtype1" value="?????? R&D"> ?????? R&D</label>
	           		<label><input type="radio" name="yxtype1" value="?????? ???R&D"> ?????? ???R&D</label>
	           		<label><input type="radio" name="yxtype1" value="xx"> ??????</label>
           		</td>
           	</tr>
           	
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="yxtype2" value="????????????" checked="checked"> ????????????</label>
	           		<label><input type="radio" name="yxtype2" value="????????? ????????????"> ????????? ????????????</label> 
	           		<label><input type="radio" name="yxtype2" value="????????????"> ????????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(???)???</th>
           		<td colspan="3">
           			<select name="yx_name" class="select_box">
	           			<option value="">:::??????:::</option>
	          			<% for(HashMap sup:supportList){ %>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(?????????)?????????</th>
           		<td>
           			<input type="text" name="yx_dname" id="yx_dname" value="" class="inp_txt"/>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
           		<td>
           			<input type="text" name="yx_bname" id="yx_bname" value="" class="inp_txt">
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- ???????????????</h3>
	<table class="skin_basic_write" >
		<caption>???????????????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td colspan="3">
           			<input type="text" name="yx_sdate" id="yx_sdate<%=xcount%>" value="" class="inp_txt read_only" readonly />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td colspan="3">
           			<input type="text" name="yx_edate" id="yx_edate<%=xcount%>" value="" class="inp_txt read_only" readonly />
           			<label><input type="checkbox" name="ming" id="MING" value="1"/>????????????</label>
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)??????</th>
           		<td colspan="3">
           			<input type="hidden" name="yx_tmonth" id="yx_tmonth" value="" class="inp_txt" />
           			<span id="yx_tmonth_text<%=xcount%>" class="yx_tmonth_text"></span>
           		</td>
           	</tr>
           	
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- ???????????????</h3>
	<table class="skin_basic_write" >
		<caption>???????????????</caption>
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
          			<input type="text" name="yx_price1" id="yx_price1" value="" class="inp_txt" />
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
          		<td>
          			<input type="text" name="yx_price2" id="yx_price2" value="" class="inp_txt" />
          		</td>
          	</tr>
          	<tr>
       		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
          		<td>
          			<input type="text" name="yx_price3" id="yx_price3" value="" class="inp_txt" />
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
          		<td>
          			<input type="text" name="yx_price4" id="yx_price4" value="" class="inp_txt" />
          		</td>
          	</tr>
          	<tr>
       		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
          		<td>
          			<input type="text" name="yx_price5" id="yx_price5" value="" class="inp_txt" />
          		</td>
          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
          		<td>
          			<input type="text" name="yx_price6" id="yx_price6" value="" class="inp_txt read_only" readonly />
          		</td>
          	</tr>
   	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- ???????????? ???????????? ??????</h3>
	<table class="skin_basic_write" >
		<caption>??????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit">??????(??????)????????? ????????????</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="1">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" value="" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">??????(??????)????????? ??????</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="2">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" value="" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">????????????</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="3">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File3" id="<%=fileFullGrp%>File3" value="" />
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	
   	
   	<h3 class="tit">- ??????(??????)??????</h3>
	<table class="skin_basic_write" >
		<caption>??????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<select name="yx_ctype" class="select_box">
	           			<option value="">:::??????:::</option>
	          			<% for(HashMap sup:agencyList){ %>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td>
           			<input type="text" name="yx_cname" id="yx_cname" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td>
           			<input type="text" name="yx_yname" id="yx_yname" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="yx_cont1" value="????????????" checked> ????????????</label>
           			<label><input type="radio" name="yx_cont1" value="???????????????"> ???????????????</label>
           			<label><input type="radio" name="yx_cont1" value="??????"> ??????</label>
           			
           			<select name="yx_cont1_text" class="hide_select select_box" style="display:none;" disabled>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<input type="text" name="yx_cont1_text" value="" class="inp_txt" style="display:none;" disabled>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>
           		<td>
           			<input type="text" name="yx_cont2" id="yx_cont2" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)?????????</th>
           		<td>
           			<input type="text" name="yx_cont3" id="yx_cont3" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
           		<td>
           			<input type="text" name="yx_cont4" id="yx_cont4" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
           		<td>
           			<input type="text" name="yx_cont5" id="yx_cont5" value=""  class="inp_txt"/>
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????? ????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="yx_cont6" value="??????"> ??????</label>
           			<label><input type="radio" name="yx_cont6" value="????????????"> ????????????</label>
           			<label><input type="radio" name="yx_cont6" value="??????" checked> ??????</label>
           			<label><input type="radio" name="yx_cont6" value="??????"> ??????</label>
           			<label><input type="radio" name="yx_cont6" value="??????"> ??????</label>
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="yx_cont7" value="????????????" checked> ????????????</label>
           			<label><input type="radio" name="yx_cont7" value="??????????????????"> ??????????????????</label>
           			<label><input type="radio" name="yx_cont7" value="?????????"> ?????????</label>
           			<label><input type="radio" name="yx_cont7" value="??????"> ??????</label>
           			
           			<select name="yx_cont8" class="select_box" style="display:none;">
           			<% for(HashMap rs:areaSigunguList) { %>
					<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
					<% } %>
           			</select>
           			
           			<input type="text" name="yx_cont8" class="inp_txt" style="display:none;">
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	<h3 class="tit">- ?????????(?????????)?????? ?????? ??? ?????????</h3>
	<table class="skin_basic_write" >
		<caption>?????????(?????????)?????? ?????? ??? ?????????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<th scope="row" class="tit">??????/?????????</th>
           		<td>
           			<input type="text" name="yx_hcont1" id="yx_hcont1" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit">??????(???)</th>
           		<td>
           			<input type="text" name="yx_hcont2" id="yx_hcont2" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">???????????????</th>
           		<td>
           			<input type="text" name="yx_hcont3" id="yx_hcont3" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit">???????????????</th>
           		<td>
           			<input type="text" name="yx_hcont4" id="yx_hcont4" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">????????? ????????????</th>
           		<td>
           			<input type="text" name="yx_hcont5" id="yx_hcont5" value="" class="inp_txt" />
           		</td>
        		<th scope="row" class="tit">????????? ????????????</th>
           		<td>
           			<input type="text" name="yx_hcont6" id="yx_hcont6" value="" class="inp_txt" />
           		</td>
           	</tr>
           	<tr>
        		<th scope="row" class="tit">??????????????????</th>
           		<td colspan="3">
           			<input type="text" name="yxmail1" id="yxmail1" value="" class="inp_txt" style="width:15%"  maxlength="20" title="??????????????????"> @
					<input type="text" name="yxmail2" id="yxmail2" value="" class="inp_txt" style="width:15%"  maxlength="50" title="??????????????????">
					<select name="emailDomainChoise4" id="emailDomainChoise4" class="select_box" title="??????????????????????????????" >
						<option value="">????????????</option>
						<option value="gmail.com">?????????</option>
						<option value="empal.com">?????????</option>
						<option value="naver.com">?????????</option>
						<option value="hanmail.net">??????</option>
						<option value="hotmail.com">?????????</option>
						<option value="yahoo.co.kr">??????</option>
						<option value="nate.com">?????????</option>
					</select>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h3 class="tit">- ??????</h3>
	<table class="skin_basic_write" >
		<caption>??????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
        	<tr>
        		<td colspan="4">
           			<textarea name="yx_comment" rows="5" class="inp_txt" style="width:100%;"></textarea>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<input type="button" class="typebinsert" value="??????">
   	
</form>
</div>