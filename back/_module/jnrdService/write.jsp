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
       
       ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	   ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	   
	   ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	   ArrayList<HashMap<String, String>> rndStageList = request.getAttribute("rndStageList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
	   ArrayList<HashMap<String, String>> rndPurposeList = request.getAttribute("rndPurposeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndPurposeList");
	   ArrayList<HashMap<String, String>> scienceBList = request.getAttribute("scienceBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scienceBList");
	   ArrayList<HashMap<String, String>> emphasisBList = request.getAttribute("emphasisBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("emphasisBList");
	   ArrayList<HashMap<String, String>> rndTbList = request.getAttribute("rndTbList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndTbList");
	   ArrayList<HashMap<String, String>> IndustryList = request.getAttribute("IndustryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("IndustryList");

       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String userIdx = util.getStr(paramMap.get("userIdx"));
       if("".equals(mode)) mode = "write";

       String fileGrp = "jntisJnrd";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

       int scCnt = 0;
       
       
%>

<style>
table.skin_basic_write td.padding_none{padding:0;}
#businesslist td p{padding:10px 0; border-top:1px solid #ddd;}
#businesslist td p:first-child{border-top:none;}

#businesslist td p span{display:inline-block; width:100px; text-align:center;}
</style>

<jsp:useBean id="currTime" class="java.util.Date" />



<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	<input type="hidden" name="proState" id="proState" value="" />
	<div class="skin_bbs_write" style="margin-top: 30px">
	
	<p style="color:red;"><span style="color:red;" >*</span>) ?????? ?????????????????????.</p>

	<!-- ???????????? S -->
	<h2 class="tit">????????????</h2>
	<div class="zoom">
		
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
           		<th scope="row" class="tit">??????(??????)????????????</th>
           		<td colspan="3">
           			<input type="text" name="code" id="CODE" value="JNP-" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)??????</th>
           		<td colspan="3">
           			<label><input type="radio" name="typeA" value="??????R&D" checked="checked"> ??????R&D</label>
           			<label><input type="radio" name="typeA" value="??????R&D"> ??????R&D</label>
           			<label><input type="radio" name="typeA" value="?????????R&D"> ?????????R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(???)???</th>
           		<td colspan="3">
           			<select name="cname" class="select_box">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap sup:supportList){
						%>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(?????????)?????????</th>
           		<td>
           			<input type="text" name="bname" id="BNAME" class="inp_txt" value=""/>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)???</th>
           		<td>
           			<input type="text" name="baname" id="B_ANAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td colspan="3">
           			?????? : <input type="text" name="sdate" id="S_DATE" class="inp_txt read_only" readonly value=""/>
           			?????? : <input type="text" name="edate" id="E_DATE" class="inp_txt read_only" readonly value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="btprice" id="B_TPRICE" class="inp_txt" value=""/>(??????:100??????)
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td>
           			<label><input type="radio" name="yeartype" value="????????????" checked="checked"> ????????????</label>
           			<label><input type="radio" name="yeartype" value="????????????"> ????????????</label>
           			<label><input type="radio" name="yeartype" value="??????????????????"> ??????????????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)????????????</th>
           		<td colspan="3">
           			<label><input type="checkbox" name="bch1" value="????????????"> ????????????</label>
           			<label><input type="checkbox" name="bch2" value="NTIS"> NTIS</label>
           			<label><input type="checkbox" name="bch3" value="?????????"> ?????????</label>
           			<label><input type="checkbox" name="bch4" value="?????????"> ?????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)????????????</th>
           		<td colspan="3">
           			?????? : <input type="text" name="bsd" id="B_SD" class="inp_txt read_only" readonly value=""/>
           			?????? : <input type="text" name="bed" id="B_ED" class="inp_txt read_only" readonly value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)?????????</th>
           		<td colspan="3">
           			<input type="hidden" name="fileSn" value="1">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- ???????????? E -->



	<!-- ????????????(??????)?????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????????(??????)??????</h2>
    <div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('business')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('business')" />
	</div>
	<div id="businesslist">
  		<table class="skin_basic_write" id="businesslist_cont_<%=scCnt%>">
  			<input type="hidden" name="checkNum" value="<%=scCnt%>">
  			<caption>????????????(??????)??????</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr >
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
	         		<td>
	         			<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
	         			<select name="bisyear" id="BIS_YEAR_<%=scCnt%>" class="select_box">
	         				<option value="">:::??????:::</option>
	         				<c:forEach var="i" begin="2018" end="${currTime}">
	            			<option value="${i}">${i}</option>
	            			</c:forEach>
	         			</select>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">???????????? ????????????</th>
	         		<td>
	         			?????? : <input type="text" name="bissdate" id="BIS_SDATE_<%=scCnt%>" class="inp_txt read_only" readonly value=""/>
	          			?????? : <input type="text" name="bisedate" id="BIS_EDATE_<%=scCnt%>" class="inp_txt read_only" readonly value=""/>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
	         		<td>
	         			<label><input type="radio" name="bistype_<%=scCnt%>" id="" value="????????????" checked="checked"> ????????????</label>
	           			<label><input type="radio" name="bistype_<%=scCnt%>" id="" value="????????????"> ????????????</label>
	           			<label><input type="radio" name="bistype_<%=scCnt%>" id="" value="??????"> ??????</label>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????? ?????????</th>
	         		<td class="padding_none">
	         			<p><span>?????? : </span><input type="number" name="bisprice_1" class="inp_txt"> (??????:100??????)</p>
	         			<p><span>????????? : </span><input type="number" name="bisprice_2" class="inp_txt"> (??????:100??????)</p>
	         			<p><span>?????? : </span><input type="number" name="bisprice_3" class="inp_txt"> (??????:100??????)</p>
	         			<p><span>?????? : </span><input type="number" name="bisprice_4" class="inp_txt read_only" readonly> (??????:100??????)</p>
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
	
	</div>
	
	<h2 class="tit">??????(??????)??????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????????????????</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="anname" id="AN_NAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="cnname" id="CN_NAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
        </tbody>
    </table>
	
	
	<!-- ???????????? S -->
	<h2 class="tit">??????????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????????????????</caption>
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
           			<select name="centype" id="CEN_TYPE" class="select_box">
           				<option value="">:::??????:::</option>
           				<option>??????</option>
           				<option>??????????????????</option>
           				<option>???????????????</option>
           				<option>????????????</option>
           				<option>?????????</option>
           				<option>????????????</option>
           				<option>????????????</option>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="orgage" id="ORG_AGE" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)???</th>
           		<td colspan="3">
           			<input type="text" name="depname" id="DEP_NAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)?????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="deptype" value="1" checked="checked" onclick="areaClick('depcode','1')"> ???????????????</label>
           			<label><input type="radio" name="deptype" value="2" onclick="areaClick('depcode','2')"> ????????????</label>
           			<select name="depcode" id="depcode1" class="select_box">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<select name="0" id="depcode2" class="select_box" style="display:none;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaSigunguList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????? ?????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="busimptype" value="1" checked="checked" onclick="areaClick('busimpcode','1')"> ???????????????</label>
           			<label><input type="radio" name="busimptype" value="2" onclick="areaClick('busimpcode','2')"> ????????????</label>
           			<select name="busimpcode" id="busimpcode1" class="select_box">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<select name="0" id="busimpcode2" class="select_box" style="display:none;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaSigunguList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td>
           			<input type="text" name="director" id="DIRECTOR" class="inp_txt" value=""/>
           		</td>
           		<th scope="row" class="tit">??????????????? ??????</th>
           		<td>
           			<input type="text" name="dirtel" id="DIR_TEL" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">??????????????? ?????????</th>
           		<td colspan="3">
           			<input type="text" name="mail1" id="mail1" value="" class="inp_txt" style="width:15%"  maxlength="20" title="??????????????????"> @
					<input type="text" name="mail2" id="mail2" value="" class="inp_txt" style="width:15%"  maxlength="50" title="??????????????????">
					<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="??????????????????????????????" >
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
	<!-- ???????????? E -->
	
	
	<h2 class="tit">??????(??????)??????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????(??????)??????</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
           		<td colspan="3">
           			<select name="dirtype1" id="DIR_TYPE1" class="select_box" style="min-width:150px;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap va:rndStageList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
           		<td colspan="3">
           			<select name="dirtype2" id="DIR_TYPE2" class="select_box" style="min-width:150px;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap va:rndPurposeList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
           		<td colspan="3">
           			<select name="dirtype3" id="DIR_TYPE3" class="select_box" style="min-width:150px;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap va:scienceBList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
           		<td colspan="3">
           			<select name="dirtype4" id="DIR_TYPE4" class="select_box" style="min-width:150px;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap va:emphasisBList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 6T??????</th>
           		<td colspan="3">
           			<select name="dirtype5" id="DIR_TYPE5" class="select_box" style="min-width:150px;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap va:rndTbList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<select name="dirtype6" id="DIR_TYPE6" class="select_box" style="min-width:150px;">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap va:IndustryList){
						%>
						<option value="<%=util.getStr(va.get("CODE_NM"))%>"><%=util.getStr(va.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	
   	<h2 class="tit">????????? ????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>????????? ????????????</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
           		<td colspan="3">
           			<input type="text" name="mancname" id="MAN_CNAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
           		<td colspan="3">
           			<input type="text" name="manpname" id="MAN_PNAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="mananame" id="MAN_ANAME" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
           		<td colspan="3">
           			<input type="text" name="manspot" id="MAN_SPOT" class="inp_txt" value=""/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="mantel" id="MAN_TEL" class="inp_txt" value=""/>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h2 class="tit">??????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????</caption>
        <tbody>
           	<tr>
           		<td colspan="3">
           			<textarea name="comment" rows="5" style="width:80%;" class="inp_txt"></textarea>
           		</td>
           	</tr>
    	</tbody>
   	</table>



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
//????????????-???????????? Sss
	function areaClick(mode,no){
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
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
        var fileCount = $("input[type=file]").length;
		
		
		if($("input[name='bname']").val() == ""){
			alert("?????????????????? ???????????????");
			$("input[name='bname']").focus();
			return false;
		}
		
		if($("input[name='baname']").val() == ""){
			alert("??????(??????)?????? ???????????????");
			$("input[name='baname']").focus();
			return false;
		}
		
		if($("input[name='sdate']").val() == ""){
			alert("??????????????? ???????????? ???????????????");
			$("input[name='sdate']").focus();
			return false;
		}
		
		if($("input[name='edate']").val() == ""){
			alert("??????????????? ???????????? ???????????????");
			$("input[name='edate']").focus();
			return false;
		}
		
		if($("input[name='btprice']").val() == ""){
			alert("??????????????? ???????????????");
			$("input[name='btprice']").focus();
			return false;
		}
		
		if(!$("input[name='bch1']").is(":checked") && !$("input[name='bch2']").is(":checked") && !$("input[name='bch3']").is(":checked") && !$("input[name='bch4']").is(":checked")){
			alert("??????(??????)??????????????? ???????????? ???????????????");
			$("input[name='bch1']").focus();
			return false;
		}
		
		if($("input[name='bsd']").val() == ""){
			alert("??????(??????)???????????? ???????????? ???????????????");
			$("input[name='bsd']").focus();
			return false;
		}
		
		if($("input[name='bed']").val() == ""){
			alert("??????(??????)???????????? ???????????? ???????????????");
			$("input[name='bed']").focus();
			return false;
		}
		
		if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File1").val()) && $('#<%=fileFullGrp%>File1').val() != ""){

   		}else if($("#<%=fileFullGrp%>File1").val() == ""){
   			alert("????????? ???????????????.");
   			return false;
   		}else{
   			alert("?????? ????????? ???????????? ??? ????????????.");
   			return false;
   		}
		
		if($("#BIS_YEAR_0").val() == ""){
			alert("??????????????? ??????????????? ???????????????");
			$("#BIS_YEAR_0").focus();
			return false;
		}
		
		if($('select[name="bisyear"]:last').val() == ""){
	    	alert("??????????????? ??????????????? ?????? ?????????");
	    	$('select[name="bisyear"]:last').focus();
			return false;
	    }
		
		if($('input[name="bisprice_1"]:last').val() == ""){
	    	alert("????????? ?????? ?????????");
	    	$('input[name="bisprice_1"]:last').focus();
			return false;
	    }
	    if($('input[name="bisprice_2"]:last').val() == ""){
	    	alert("???????????? ?????? ?????????");
	    	$('input[name="bisprice_2"]:last').focus();
			return false;
	    }
	    if($('input[name="bisprice_3"]:last').val() == ""){
	    	alert("????????? ?????? ?????????");
	    	$('input[name="bisprice_3"]:last').focus();
			return false;
	    }
	    
	    /* ???????????? ????????? */
	    if($('input[name="anname"]').val() == ""){
	    	alert("?????????????????? ???????????????");
	    	$('input[name="anname"]').focus();
			return false;
	    }
	    
	    
	    /* ?????????????????? ????????? */
	    if($('select[name="centype"]').val() == ""){
	    	alert("??????????????? ???????????????");
	    	$('select[name="centype"]').focus();
			return false;
	    }
	    if($('input[name="orgage"]').val() == ""){
	    	alert("??????????????? ?????? ?????????");
	    	$('input[name="orgage"]').focus();
			return false;
	    }
	    if($('input[name="depname"]').val() == ""){
	    	alert("??????(??????)?????? ?????? ?????????");
	    	$('input[name="depname"]').focus();
			return false;
	    }
	    if($('select[name="depcode"]').val() == ""){
	    	alert("??????(??????)???????????? ???????????????");
	    	$('select[name="depcode"]').focus();
			return false;
	    }
	    if($('select[name="busimpcode"]').val() == ""){
	    	alert("???????????? ???????????? ???????????????");
	    	$('select[name="busimpcode"]').focus();
			return false;
	    }
	    if($('input[name="director"]').val() == ""){
	    	alert("?????????????????? ?????? ?????????");
	    	$('input[name="director"]').focus();
			return false;
	    }
	    
	    /* ?????????????????? ????????? */
	    if($('select[name="dirtype1"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype1"]').focus();
			return false;
	    }
	    if($('select[name="dirtype2"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype2"]').focus();
			return false;
	    }
	    if($('select[name="dirtype3"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype3"]').focus();
			return false;
	    }
	    if($('select[name="dirtype4"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype4"]').focus();
			return false;
	    }
	    if($('select[name="dirtype5"]').val() == ""){
	    	alert("6T????????? ???????????????");
	    	$('select[name="dirtype5"]').focus();
			return false;
	    }
	    if($('select[name="dirtype6"]').val() == ""){
	    	alert("??????????????? ???????????????");
	    	$('select[name="dirtype6"]').focus();
			return false;
	    }
	    
	    /*????????? ???????????? ?????????*/
	    if($('input[name="mancname"]').val() == ""){
	    	alert("???????????? ???????????? ?????? ?????????");
	    	$('input[name="mancname"]').focus();
			return false;
	    }
	    if($('input[name="manpname"]').val() == ""){
	    	alert("???????????? ???????????? ?????? ?????????");
	    	$('input[name="manpname"]').focus();
			return false;
	    }
	    if($('input[name="mananame"]').val() == ""){
	    	alert("???????????? ??????????????? ?????? ?????????");
	    	$('input[name="mananame"]').focus();
			return false;
	    }
	    if($('input[name="manspot"]').val() == ""){
	    	alert("???????????? ????????? ????????? ?????? ?????????");
	    	$('input[name="manspot"]').focus();
			return false;
	    }
	    if($('input[name="mantel"]').val() == ""){
	    	alert("???????????? ??????????????? ?????? ?????????");
	    	$('input[name="mantel"]').focus();
			return false;
	    }
	    
		
		
		goSubmit('writeProc','10');
	}
	
	
	
	
	$(document).on("change","input[name='bisprice_3']:last",function(){
		var totP = parseInt($("input[name='bisprice_1']:last").val())+parseInt($("input[name='bisprice_2']:last").val())+parseInt($("input[name='bisprice_3']:last").val());
		$("input[name='bisprice_4']:last").val(totP);
	});
	
	
	
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
	$("#E_DATE,#B_SD,#B_ED,#BIS_SDATE_0,#BIS_EDATE_0").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	//nextText : '?????? ???',
       	//prevText : '?????? ???',

       	//closeText : '??????',
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	
        
		//yearRange: '1980:2020'
	});
	
	$("#S_DATE").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            var xNum = "";
            //??????????????????
            $.ajax({
	            type: "POST",
	            data: {year:year},
	            url : '/sys/jntisJnrdAjax.do',
	            dataType : 'json',
	            success : function(data){	            	
	            	if(data.dataList != null){
	            		xNum = String(data.dataList.IDX).padStart(5,"0");
	            		$("#CODE").val("JNP-"+year+"-"+xNum);
	            	}else{
	            		$("#CODE").val("JNP-"+year+"-00001");
	            	}         		
	            }
   			});            
        }
	});
	
	
	
	function fillZero(width, str){
		var xcode = "";
		if(str.length >= width){
			xcode = str;
		}else{
			var mm = "";
			for(var i=0; i<(width-str.length+1); i++){
				mm += "0";
			}
			xcode = mm+str;
		}
	    return xcode;
	}

	
//??????datePicker E
//addRow Sss

	var date = new Date(); 
	var year = date.getFullYear();

	function addRow(mode){
   		if(mode=="business"){
   			var cnt = $('input[name=checkNum]:last').val();
   		    var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   		        		    
   		    if($('#BIS_YEAR_'+cnt).val() == ""){
   				alert("??????????????? ?????? ?????????");
   				$('#BIS_YEAR_'+cnt).focus();
   				return false;
   			}
   		    
   		    if($('input[name="bisprice_1"]:last').val() == ""){
   		    	alert("????????? ?????? ?????????");
   		    	$('input[name="bisprice_1"]:last').focus();
   				return false;
   		    }
   		    if($('input[name="bisprice_2"]:last').val() == ""){
   		    	alert("???????????? ?????? ?????????");
   		    	$('input[name="bisprice_2"]:last').focus();
   				return false;
   		    }
   		    if($('input[name="bisprice_3"]:last').val() == ""){
   		    	alert("????????? ?????? ?????????");
   		    	$('input[name="bisprice_3"]:last').focus();
   				return false;
   		    }
   		    
   		    var totalP = parseInt($('input[name="bisprice_1"]:last').val())+parseInt($('input[name="bisprice_2"]:last').val())+parseInt($('input[name="bisprice_3"]:last').val());
   		 	$('input[name="bisprice_4"]:last').val(totalP);
   		    
   		    
   			var row = "";
   			row += '<table class="skin_basic_write" id="businesslist_cont_'+ScCnt+'">';
   			row += '<input type="hidden" name="checkNum" value="'+ScCnt+'">';
     			row += '<caption>????????????</caption>';
     			row += '<colgroup>';
               row += '<col style="width:15%" />';
              	row += '</colgroup>';
   			row += '<tr>';
         	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
         	row += '<td>';
         	row += '	<select name="bisyear" id="BIS_YEAR_'+ScCnt+'" class="select_box">';
         	row += '		<option value="">:::??????:::</option>'
         	for(var y=2018; y<=year; y++){
         		row += '<option>'+y+'</option>';
         	}
         	row += '	</select>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit">???????????? ????????????</th>';
         	row += '<td>';
         	row += '	?????? : <input type="text" name="bissdate" id="BIS_SDATE_'+ScCnt+'" class="inp_txt read_only" readonly value=""/>';
       		row += '	?????? : <input type="text" name="bisedate" id="BIS_EDATE_'+ScCnt+'" class="inp_txt read_only" readonly value=""/>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
         	row += '<td>';
         	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="????????????" checked="checked"> ????????????</label>';
           	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="????????????"> ????????????</label>';
           	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="??????"> ??????</label>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????? ?????????</th>';
         	row += '<td class="padding_none">';
         	row += '	<p><span>?????? : </span><input type="number" name="bisprice_1" class="inp_txt"> (??????:100??????)</p>';
         	row += '	<p><span>????????? : </span><input type="number" name="bisprice_2" class="inp_txt"> (??????:100??????)</p>';
         	row += '	<p><span>?????? : </span><input type="number" name="bisprice_3" class="inp_txt"> (??????:100??????)</p>';
         	row += '	<p><span>?????? : </span><input type="number" name="bisprice_4" class="inp_txt read_only" readonly> (??????:100??????)</p>';
         	row += '</td>';
         	row += '</tr>';
         	row += '</table>';
   		 	
   		    $("#businesslist").append(row);

    	}
    	//date
		setLicenseBtn(ScCnt, mode);
	}
//addRow E
//delRow S
	function delRow(mode){
   		if(mode=="business"){
   			if($('input[name=checkNum]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=checkNum]').size() - 1;
   			var parenttr = $("#businesslist_cont_"+delCnt).remove();
   		}
   		//setLicenseBtn();
   	}
//delRow E

	
	
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


function setLicenseBtn(plusScCnt, mode){
   	/* DatePicker ?????? */
  		var date ="";
  		if(mode == "business"){
  			date = "#BIS_SDATE_"+plusScCnt+", #BIS_EDATE_"+plusScCnt;
  		}

	$(date).datepicker({
		showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	//nextText : '?????? ???',
       	//prevText : '?????? ???',

       	//closeText : '??????',
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	/*onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
        }*/
        
		//yearRange: '1980:2020'
	});
};


</script>