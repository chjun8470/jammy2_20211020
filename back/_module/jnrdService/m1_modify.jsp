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
	
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
   
   

	ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	ArrayList<HashMap<String, String>> applicationList = request.getAttribute("applicationList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("applicationList");
	ArrayList<HashMap<String, String>> technologyList = request.getAttribute("technologyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("technologyList");
	
	
	ArrayList<HashMap<String, String>> m1PriceList = request.getAttribute("m1PriceList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1PriceList");
	ArrayList<HashMap<String, String>> m1ResultData = request.getAttribute("m1ResultData") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultData");
	
	
	

	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	ArrayList<HashMap<String, String>> rndStageList = request.getAttribute("rndStageList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
	ArrayList<HashMap<String, String>> rndPurposeList = request.getAttribute("rndPurposeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndPurposeList");
	ArrayList<HashMap<String, String>> scienceBList = request.getAttribute("scienceBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("scienceBList");
	ArrayList<HashMap<String, String>> emphasisBList = request.getAttribute("emphasisBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("emphasisBList");
	ArrayList<HashMap<String, String>> rndTbList = request.getAttribute("rndTbList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndTbList");
	ArrayList<HashMap<String, String>> IndustryList = request.getAttribute("IndustryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("IndustryList");
	ArrayList<HashMap<String, String>> blueList = request.getAttribute("blueList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("blueList");
	ArrayList<HashMap<String, String>> agencyList = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");


   String mode = util.getStr(paramMap.get("mode"));
   String nowPage = util.getStr(paramMap.get("nowPage"));
   String userIdx = util.getStr(paramMap.get("userIdx"));
   if("".equals(mode)) mode = "write";

   String fileGrp = "Jnrdm1";
   String fileSubGrp = "";
   String fileFullGrp =fileGrp+fileSubGrp;

   int scCnt = 0;
   
%>

<style>
table.skin_basic_write td.padding_none{padding:0;}
#businesslist td p{padding:10px 0; border-top:1px solid #ddd;}
#businesslist td p:first-child{border-top:none;}

#businesslist td p span{display:inline-block; width:100px; text-align:center;}

.htmlSet{clear:both; font-size:14px; border:1px solid #ddd; margin-bottom:15px; padding:30px 20px; text-align:left;}
.htmlBtn{float:right; padding:5px 10px; margin-left:5px; background:#333; color:#f8f8f8; cursor:pointer; vertical-align:middle;}
.cRed{background:#fd4343;}
.cGreen{background:#3fc127;}
.cGreay{background:#b9b9b9 !important; cursor:unset;}
.cBlue{background:#2d93fd;}
.hideBox{clear:both; border:1px solid #ddd; color:#999; font-size:14px; margin-bottom:15px; padding:30px 20px; text-align:center;}
.hideBox_n{clear:both; border:1px solid #ddd; background:#f8f8f8; color:#999; font-size:14px; margin-bottom:15px; padding:15px 0; text-align:center;}
.bdText{color:#ff0000; margin-left:30px;}

.htmlResultSet{clear:both; font-size:14px; border:1px solid #ddd; margin-bottom:15px; padding:30px 20px; text-align:left;}

.result_content{border-bottom:1px dashed #ddd; padding-bottom:20px; margin-bottom:30px;}
.submitBtn, .modifyBtn{margin:50px auto 30px; border:1px solid #ddd; background:#498944; color:#fff; padding:10px 30px; display:block; font-size:14px;}
.addPriceInfo{margin:50px auto 30px; border:1px solid #ddd; background:#498944; color:#fff; padding:10px 30px; display:block; width:100px; text-align:center; font-size:14px; float:unset;}
.addPriceInfo_off{margin:50px auto 30px; border:1px solid #ddd; background:#f7f7f7; color:#999; padding:10px 30px; display:block; width:100px; text-align:center; font-size:14px; float:unset;}
</style>

<jsp:useBean id="currTime" class="java.util.Date" />


<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	
	<input type="hidden" name="midx" id="midx" value="<%=util.getStr(String.valueOf(dataMap.get("IDX"))) %>" />
	
	
	<div class="skin_bbs_write" style="margin-top: 30px">
	
	<p style="color:red;"><span style="color:red;" >*</span>) ?????? ?????????????????????.</p>

	<!-- ???????????? S -->
	<h2 class="tit">??????(??????) ????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????(??????) ????????????</caption>
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
           			<input type="text" name="mcode" id="MCODE" value="<%=util.getStr(dataMap.get("M_CODE")) %>" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> R&D?????? ??????</th>
           		<td colspan="3">
           			<label><input type="radio" name="mtype" value="??????R&D" <%=(util.getStr(dataMap.get("M_TYPE")).equals("??????R&D") || util.getStr(dataMap.get("M_TYPE")).equals(""))?"checked":""%>> ?????? R&D</label>
           			<label><input type="radio" name="mtype" value="?????????R&D" <%=(util.getStr(dataMap.get("M_TYPE")).equals("?????????R&D"))?"checked":""%>> ?????????R&D</label>
           			<label><input type="radio" name="mtype" value="??????R&D" <%=(util.getStr(dataMap.get("M_TYPE")).equals("??????R&D"))?"checked":""%>> ??????R&D</label>
           			<label><input type="radio" name="mtype" value="?????????R&D" <%=(util.getStr(dataMap.get("M_TYPE")).equals("?????????R&D"))?"checked":""%>> ?????????R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="btype" value="????????????" <%=(util.getStr(dataMap.get("B_TYPE")).equals("????????????") || util.getStr(dataMap.get("B_TYPE")).equals(""))?"checked":""%>> ????????????</label>
           			<label><input type="radio" name="btype" value="????????????" <%=(util.getStr(dataMap.get("B_TYPE")).equals("????????????"))?"checked":""%>> ????????????</label>
           			<label><input type="radio" name="btype" value="????????????" <%=(util.getStr(dataMap.get("B_TYPE")).equals("????????????"))?"checked":""%>> ????????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="ctype" value="??????R&D" <%=(util.getStr(dataMap.get("C_TYPE")).equals("??????R&D") || util.getStr(dataMap.get("C_TYPE")).equals(""))?"checked":""%>> ??????R&D</label>
           			<label><input type="radio" name="ctype" value="??????R&D" <%=(util.getStr(dataMap.get("C_TYPE")).equals("??????R&D"))?"checked":""%>> ??????R&D</label>
           			<label><input type="radio" name="ctype" value="?????????R&D" <%=(util.getStr(dataMap.get("C_TYPE")).equals("?????????R&D"))?"checked":""%>> ?????????R&D</label>
           			<label><input type="radio" name="ctype" value="?????????R&D" <%=(util.getStr(dataMap.get("C_TYPE")).equals("?????????R&D"))?"checked":""%>> ?????????R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(???)???</th>
           		<td colspan="3">
           			<select name="mname" class="select_box">
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap sup:supportList){
						%>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>" <% if(util.getStr(dataMap.get("M_NAME")).equals(util.getStr(sup.get("CODE_NM")))){ %>selected<% } %>><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(?????????)?????????</th>
           		<td colspan="3">
           			<input type="text" name="mbname" id="MBNAME" class="inp_txt" value="<%=util.getStr(dataMap.get("M_BNAME")) %>" size="50"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
           		<td colspan="3">
           			<input type="text" name="hname" id="HNAME" class="inp_txt" value="<%=util.getStr(dataMap.get("H_NAME")) %>" size="50"/>
           			
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- ???????????? E -->



	<!-- ???????????? -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????????</h2>
    <div class="zoom">
		
	</div>
	<div id="businesslist">
  		<table class="skin_basic_write">
  			<caption>????????????</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
	         		<td>
	         			<input type="text" name="msdate" id="MSDATE" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(dataMap.get("M_SDATE"))) %>"/>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
	         		<td>
	         			<input type="text" name="medate" id="MEDATE" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(dataMap.get("M_EDATE"))) %>" <%=(util.getStr(dataMap.get("M_ING")).equals("1"))?"disabled":""%>/>
	         			<label><input type="checkbox" name="ming" id="MING" value="1" <%=(util.getStr(dataMap.get("M_ING")).equals("1"))?"checked":""%>/>????????????</label>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">????????????(??????)</th>
	         		<td>
	         			<input type="hidden" name="mMonth" value="<%=util.getStr(String.valueOf(dataMap.get("M_MONTH"))) %>" />
	         			<span id="monthTit"></span>
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
	
	</div>
    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="????????????" onclick="goCheck()"/>
    </div>
    <!--// bo_btn -->
</form>


<div style="padding-top:15px"></div>




<div id="ncontentBox" style="clear:both;">
	
	<h2 class="tit">?????????????????????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('typeA')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('typeA')" />
	</div>
	<%
	int ii = 0;
	if(m1PriceList.size() > 0){
	for(HashMap pr:m1PriceList){
		//if(util.getStr(pr.get("NP_SET")) != "1"){
			
			ArrayList<HashMap<String, String>> fileListA = request.getAttribute("fileList"+ii) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList"+ii);
			
	%>
	
	<div id="ncontent<%=util.getStr(pr.get("NP_YEAR"))%>" class="ncontent"  data-type="on">
		<form method="post" name="ncontForm_<%=util.getStr(pr.get("NP_YEAR"))%>" id="ncontForm_<%=util.getStr(pr.get("NP_YEAR"))%>" action="<%=myPage%>">
		<input type="hidden" name="mode" value="modifyProc">
		<input type="hidden" name="midx" value="<%=util.getStr(String.valueOf(pr.get("M_IDX")))%>">
		<input type="hidden" name="xidx" value="<%=util.getStr(String.valueOf(pr.get("IDX")))%>">
		
		<input type="hidden" name="orgStatus" value="<%=util.getStr(pr.get("NP_SET"))%>">
		
		<table class="skin_basic_write" >
			<caption>?????????????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
		          		<td colspan="3">
		          			<!-- select name="npyear" id="npyear1" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          			</select-->
		          			<input type="text" name="npyear" id="npyear1" value="<%=util.getStr(pr.get("NP_YEAR"))%>" readonly class="inp_txt read_only" />
		          			<label><input type="checkbox" name="npset" id="npset1" value="1" <%=util.getStr(pr.get("NP_SET")) %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"checked":"" %>/> ?????????</label>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<label><input type="radio" name="nptype1" value="????????????" <% if(util.getStr(pr.get("NP_TYPE1")).equals("????????????") || util.getStr(pr.get("NP_TYPE1")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ????????????</label>
		           			<label><input type="radio" name="nptype1" value="????????????" <% if(util.getStr(pr.get("NP_TYPE1")).equals("????????????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ????????????</label>
		           			<label><input type="radio" name="nptype1" value="??????" <% if(util.getStr(pr.get("NP_TYPE1")).equals("????????????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="nptype1" value="???????????????" <% if(util.getStr(pr).equals("????????????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ???????????????</label>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
		          		<td>
		          			<label><input type="radio" name="nptype2" value="??????" <% if(util.getStr(pr.get("NP_TYPE2")).equals("??????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="nptype2" value="?????????" <% if(util.getStr(pr.get("NP_TYPE2")).equals("?????????") || util.getStr(pr.get("NP_TYPE2")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ?????????</label>
		           			<label><input type="radio" name="nptype2" value="?????????" <% if(util.getStr(pr.get("NP_TYPE2")).equals("?????????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ?????????</label>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/??????</th>
		          		<td>
		          			<label><input type="radio" name="nptype3" value="??????" <% if(util.getStr(pr.get("NP_TYPE3")).equals("??????") || util.getStr(pr.get("NP_TYPE3")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="nptype3" value="??????" <% if(util.getStr(pr.get("NP_TYPE3")).equals("??????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="nptype3" value="??????" <% if(util.getStr(pr.get("NP_TYPE3")).equals("??????")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<input type="text" name="nptotprice" id="nptotprice" class="inp_txt" value="<%=util.getStr(String.valueOf(pr.get("NP_TPRICE")))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1") || util.getStr(pr.get("NP_TYPE2")).equals("?????????"))?"disabled":"" %>/> (?????? : ?????????)
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
		          		<td>
		          			<input type="text" name="npprice1" id="npprice1" class="inp_txt" value="<%=util.getStr(pr.get("NP_PRICE1"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1") || util.getStr(pr.get("NP_TYPE2")).equals("?????????"))?"disabled":"" %>/> (?????? : ?????????)
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
		          		<td>
		          			<input type="text" name="npprice2" id="npprice2" class="inp_txt" value="<%=util.getStr(pr.get("NP_PRICE2"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1") || util.getStr(pr.get("NP_TYPE2")).equals("?????????"))?"disabled":"" %>/> (?????? : ?????????)
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
		          		<td>
		          			<input type="text" name="npprice3" id="npprice3" class="inp_txt" value="<%=util.getStr(pr.get("NP_PRICE3"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1") || util.getStr(pr.get("NP_TYPE2")).equals("?????????"))?"disabled":"" %>/> (?????? : ?????????)
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
		          		<td>
		          			<input type="text" name="npprice4" id="npprice4" class="inp_txt" value="<%=util.getStr(pr.get("NP_PRICE4"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1") || util.getStr(pr.get("NP_TYPE2")).equals("?????????"))?"disabled":"" %>/> (?????? : ?????????)
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???</th>
		          		<td colspan="3">
		          			<input type="text" name="npprice5" id="npprice5" class="inp_txt read_only" readonly value="<%=util.getStr(pr.get("NP_TPRICE"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1") || util.getStr(pr.get("NP_TYPE2")).equals("?????????"))?"disabled":"" %>/> (?????? : ?????????)
		          		</td>
		          	</tr>
		          	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ??????????????????</h3>
		<div class="zoom"></div>
		<table class="skin_basic_write" >
			<caption>??????????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????????????????</th>
		          		<td>
		          			<label><input type="radio" name="npftype1" value="yes" <% if(util.getStr(pr.get("NP_FTYPE1")).equals("yes") || util.getStr(pr.get("NP_FTYPE1")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="npftype1" value="no" <% if(util.getStr(pr.get("NP_FTYPE1")).equals("no")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ?????????</label>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> NTIS</th>
		          		<td>
		          			<label><input type="radio" name="npftype2" value="yes" <% if(util.getStr(pr.get("NP_FTYPE2")).equals("yes") || util.getStr(pr.get("NP_FTYPE2")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="npftype2" value="no" <% if(util.getStr(pr.get("NP_FTYPE2")).equals("no")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ?????????</label>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
		          		<td>
		          			<label><input type="radio" name="npftype3" value="yes" <% if(util.getStr(pr.get("NP_FTYPE3")).equals("yes") || util.getStr(pr.get("NP_FTYPE3")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="npftype3" value="no" <% if(util.getStr(pr.get("NP_FTYPE3")).equals("no")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ?????????</label>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
		          		<td>
		          			<label><input type="radio" name="npftype4" value="yes" <% if(util.getStr(pr.get("NP_FTYPE4")).equals("yes") || util.getStr(pr.get("NP_FTYPE4")).equals("") ){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ??????</label>
		           			<label><input type="radio" name="npftype4" value="no" <% if(util.getStr(pr.get("NP_FTYPE4")).equals("no")){ %>checked<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ?????????</label>
		          		</td>
		          	</tr>
		          	
		          	<%
			        String[] fileTitleA = {"??????????????? ??????","??????????????????????????????<br>????????????","????????????"};
			        
			        String fileGrpA = "Jnrdm1";
			        String fileSubGrpA = "";
			        String fileFullGrpA =fileGrpA+fileSubGrpA;
			        
			        Map<Integer, Object> file = new  HashMap<Integer, Object>();
			        
			        if(fileListA.size() == 1){
			        	
			        	file.put(0,fileListA.get(0));
			        	file.put(1,null);
			        	file.put(2,null);
			        	
			        }else if(fileListA.size() == 2){
			        	
			        	file.put(0,fileListA.get(0));
			        	file.put(1,fileListA.get(1));
			        	file.put(2,null);
			        	
			        }else if(fileListA.size() == 3){
			        	
			        	file.put(0,fileListA.get(0));
			        	file.put(1,fileListA.get(1));
			        	file.put(2,fileListA.get(2));
			        }
			        
			        			        
			        if(fileListA.size() > 0){
			        	//for(HashMap rs:fileListA){
			        	for(int x=0; x<fileTitleA.length; x++){
			        		
			        		if(file.get(x) != null){
			        			
			        			String fileParamxx = "?dataGrp="+util.getStr(fileListA.get(x).get("DATA_GRP"))
			    				+"&amp;fileId="+util.getStr(String.valueOf(fileListA.get(x).get("FILE_ID")))
			    				+"&amp;dataIdx="+util.getStr(fileListA.get(x).get("DATA_IDX"));
			        			
			        %>
			       
			        <tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitleA[x]%></th>
		           		<td colspan="3">
		           			<input type="hidden" name="fileSn" value="">
           					<input type="hidden" name="fileFlog" value="">
		           			<input type="file" name="<%=fileFullGrpA%>File<%=x+1 %>" id="<%=fileFullGrpA%>File<%=x+1 %>" value="" data-fileid="<%=util.getStr(String.valueOf(fileListA.get(x).get("FILE_ID"))) %>"  data-filesn="<%=x+1%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		           			???????????? <%=x+1%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileParamxx%>"><%=util.deStr(fileListA.get(x).get("TITLE_ORG"))%> (<%=util.getComma(fileListA.get(x).get("FILE_SIZE")) %> Byte)</a>
		           		</td>
		           	</tr>
			        <% 
			        		}else{
			        %>
			        <tr>
		           		<th scope="row" class="tit"><span style="color:red;" >*</span> <%=fileTitleA[x]%></th>
		           		<td colspan="3">
		           			-
		           		</td>
		           	</tr>
			        <%			
			        		}
			        		//fileCntA++;
			        	}
			        }else{
			        %>
		          	
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????? ????????????</th>
		          		<td colspan="3">
		          			<input type="hidden" name="fileSn" value="1">
	           				<input type="hidden" name="fileFlog" value="">
		          			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" value="" data-fileid="" data-filesn="1" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????????????????<br>??????????????????</th>
		          		<td colspan="3">
		          			<input type="hidden" name="fileSn" value="2">
	           				<input type="hidden" name="fileFlog" value="">
		          			<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" value="" data-fileid="" data-filesn="1" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
		          		<td colspan="3">
		          			<input type="hidden" name="fileSn" value="3">
	           				<input type="hidden" name="fileFlog" value="">
		          			<input type="file" name="<%=fileFullGrp%>File3" id="<%=fileFullGrp%>File3" value="" data-fileid="" data-filesn="1" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>
		          		</td>
		          	</tr>
		          	
		          	<% } %>
		          	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ??????(??????)??????</h3>
		<div class="zoom"></div>
		<table class="skin_basic_write" >
			<caption>??????(??????)??????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<input type="text" name="npotext1" id="npotext1" class="inp_txt" value="<%=util.getStr(pr.get("NP_OTEXT1"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<input type="text" name="npotext2" id="npotext2" class="inp_txt" value="<%=util.getStr(pr.get("NP_OTEXT2"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<select name="npotext3" id="npotext3" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<% for(HashMap va:agencyList){ %>
								<option value="<%=util.getStr(va.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_OTEXT3")).equals(util.getStr(va.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<input type="text" name="npotext4" id="npotext4" class="inp_txt" value="<%=util.getStr(pr.get("NP_OTEXT4"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
		          		<td>
		          			<label><input type="radio" name="npotext5" value="1" checked="checked" onclick="areaClick('npocode','1')" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ???????????????</label>
		           			<label><input type="radio" name="npotext5" value="2" onclick="areaClick('npocode','2')" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>> ????????????</label>
		           			<select name="npocode" id="npocode1" class="select_box">
		           				<option value="">:::??????:::</option>
		           				<%
									for(HashMap rs:areaList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_OCODE")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		           			</select>
		           			<select name="0" id="npocode2" class="select_box" style="display:none;">
		           				<option value="">:::??????:::</option>
		           				<%
									for(HashMap rs:areaSigunguList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_OCODE")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		           			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>
		          		<td>
		          			<input type="text" name="npotext6" id="npotext6" class="inp_txt" value="<%=util.getStr(pr.get("NP_OTEXT6"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
		          		<td>
		          			<input type="text" name="npotext7" id="npotext7" class="inp_txt" value="<%=util.getStr(pr.get("NP_OTEXT7"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
		          		<td>
		          			<input type="text" name="npotext8" id="npotext8" class="inp_txt" value="<%=util.getStr(pr.get("NP_OTEXT8"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">??????????????? ????????????</th>
		          		<td>
		          			<select name="npotext9" id="npotext9" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<option value="??????" <% if(util.getStr(pr.get("NP_OTEXT9")).equals("??????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>??????</option>
		          				<option value="????????????" <% if(util.getStr(pr.get("NP_OTEXT9")).equals("????????????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>????????????</option>
		          				<option value="??????" <% if(util.getStr(pr.get("NP_OTEXT9")).equals("??????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>??????</option>
		          				<option value="??????" <% if(util.getStr(pr.get("NP_OTEXT9")).equals("??????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>??????</option>
		          				<option value="??????" <% if(util.getStr(pr.get("NP_OTEXT9")).equals("??????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>??????</option>
		          			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
		          		<td>
		          			<select name="npotext10" id="npotext10" class="select_box" style="min-width:150px;">
		          				<option value="">::??????::</option>
		          				<%
								for(HashMap rs:areaList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_OTEXT10")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          	</tr>      	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ????????????</h3>
		<div class="zoom"></div>
		<table class="skin_basic_write" >
			<caption>????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
		          		<td>
		          			<select name="npwtext1" id="npwtext1" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<% for(HashMap va:rndStageList){ %>
								<option value="<%=util.getStr(va.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT1")).equals(util.getStr(va.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
		          		<td>
		          			<select name="npwtext2" id="npwtext2" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<%
								for(HashMap rs:rndPurposeList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT2")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????(??????)</th>
		          		<td>
		          			<select name="npwtext3" id="npwtext3" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<option <% if(util.getStr(pr.get("NP_WTEXT3")).equals("????????????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>????????????</option>
		          				<option <% if(util.getStr(pr.get("NP_WTEXT3")).equals("??????????????????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>??????????????????</option>
		          				<option <% if(util.getStr(pr.get("NP_WTEXT3")).equals("??????")){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>>??????</option>
		          			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????(?????????)</th>
		          		<td>
		          			<select name="npwtext4" id="npwtext4" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<%
								for(HashMap rs:scienceBList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT4")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
		          		<td>
		          			<select name="npwtext5" id="npwtext5" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<%
								for(HashMap rs:emphasisBList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT5")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 6T??????</th>
		          		<td>
		          			<select name="npwtext6" id="npwtext6" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<%
								for(HashMap rs:rndTbList) {
								%>
								<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT6")).equals(util.getStr(rs.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????????????????</th>
		          		<td>
		          			<select name="npwtext7" id="npwtext7" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<% for(HashMap va:blueList){ %>
								<option value="<%=util.getStr(va.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT7")).equals(util.getStr(va.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
								<% } %>	          				
		          			</select>
		          		</td>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		          		<td>
		          			<select name="npwtext8" id="npwtext8" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          				<% for(HashMap va:IndustryList){ %>
								<option value="<%=util.getStr(va.get("CODE_NM"))%>" <% if(util.getStr(pr.get("NP_WTEXT8")).equals(util.getStr(va.get("CODE_NM")))){ %>selected<% } %> <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
								<% } %>
		          			</select>
		          		</td>
		          	</tr>      	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ?????????(?????????)???????????? ??? ?????????</h3>
		<div class="zoom"></div>
		<table class="skin_basic_write" >
			<caption>????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit">??????/?????????</th>
		          		<td>
		          			<input type="text" name="npxtext1" id="npxtext1" class="inp_txt" value="<%=util.getStr(pr.get("NP_XTEXT1"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          		<th scope="row" class="tit">??????(???)</th>
		          		<td>
		          			<input type="text" name="npxtext2" id="npxtext2" class="inp_txt" value="<%=util.getStr(pr.get("NP_XTEXT2"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td colspan="3">
		          			<input type="text" name="npxtext3" id="npxtext3" class="inp_txt" value="<%=util.getStr(pr.get("NP_XTEXT3"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          		
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td>
		          			<input type="text" name="npxtext5" id="npxtext5" class="inp_txt" value="<%=util.getStr(pr.get("NP_XTEXT5"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          		<th scope="row" class="tit">?????????????????????</th>
		          		<td>
		          			<input type="text" name="npxtext6" id="npxtext6" class="inp_txt" value="<%=util.getStr(pr.get("NP_XTEXT6"))%>" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>/>
		          		</td>
		          	</tr> 	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ??????</h3>
		<div class="zoom"></div>
		<table class="skin_basic_write" >
			<caption>??????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<td colspan="4">
		          			<textarea name="xcomment" id="xcomment" class="inp_txt" rows="5" style="width:100%;" <%=(util.getStr(pr.get("NP_SET")).equals("1"))?"disabled":"" %>><%=util.getStr(pr.get("XCOMMENT"))%></textarea>
		          			<span class="htmlBtn cGreen modPriceInfo" data-year="<%=util.getStr(pr.get("NP_YEAR"))%>">??????</span>
		          			<span class="htmlBtn delPriceInfo" data-xidx="<%=util.getStr(pr.get("IDX"))%>">??????</span>
		          		</td>
		          	</tr>      	
		   	</tbody>
		</table>
		
		</form>
		
	</div>
	
	<div style="padding-top:15px"></div>
	
	
	<%
		//}
		ii++;
	} //for end
	}else{ //if end
	%>
	
	<div class="hideBox">
		+ ????????? ????????? ???????????? ???????????????
	</div>
	
	<%
	}
	%>
</div>
<div style="padding-top:15px"></div>


<div id="resultBox" style="clear:both;">
	
	<h2 class="tit">????????????</h2>
	<div class="zoom">
		<input type="button" name="addbtn" value="+" class="btn_add" onclick="addRow('typeB')" />
		<input type="button" name="delbtn" value="-" class="btn_del" onclick="delRow('typeB')" />
	</div>
	
	<%
	if(m1ResultData.size() > 0){
		int xn = 0;
		for(HashMap rs:m1ResultData){
			
			ArrayList<HashMap<String, String>> m1ResultInfo = request.getAttribute("m1ResultInfo_"+xn) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultInfo_"+xn);
			ArrayList<HashMap<String, String>> m1ResultSe   = request.getAttribute("m1ResultSe_"+xn) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultSe_"+xn);
			ArrayList<HashMap<String, String>> m1ResultTech = request.getAttribute("m1ResultTech_"+xn) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultTech_"+xn);
			ArrayList<HashMap<String, String>> m1ResultBus  = request.getAttribute("m1ResultBus_"+xn) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultBus_"+xn);
			ArrayList<HashMap<String, String>> m1ResultPps  = request.getAttribute("m1ResultPps_"+xn) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultPps_"+xn);
			
	
	%>
	
	<div id="result_content<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>" class="result_content">
		<form method="post" name="resultForm_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>" id="resultForm_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>" action="<%=myPage%>">
		<input type="hidden" name="mode" value="writeProc">
		<input type="hidden" name="xidx" value="<%=util.getStr(String.valueOf(rs.get("IDX")))%>">
		
		<table class="skin_basic_write" >
			<caption>????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
		          		<td colspan="3">
		          			<!-- select name="npyear" id="npyear1" class="select_box" style="min-width:150px;">
		          				<option value="">::????????????::</option>
		          			</select-->
		          			<input type="text" name="reyear" id="reyear" value="<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>" class="inp_txt read_only" readonly />
		          			<label><input type="checkbox" name="reset" id="reset" value="1" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"checked":""%>/> ?????????</label>
		          		</td>
		          	</tr>		          	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ???????????????</h3>
		<div class="zoom_x"></div>
		<table class="skin_basic_write" >
			<caption>???????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
		          		<td colspan="3">
		          			<label><input type="radio" name="retype" value="??????" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????") || util.getStr(rs.get("RE_TYPE")).equals(""))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ??????</label>
		           			<label><input type="radio" name="retype" value="??????" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????"))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ??????</label>
		           			<label><input type="radio" name="retype" value="??????/??????" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????/??????"))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ??????/??????</label>
		          		</td>
		          	</tr>
		          	<tr class="gg" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????"))?"style='display:none'":""%>>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
		          		<td colspan="3">
		          			<input type="text" name="reperson" id="reperson" value="<%=util.getStr(String.valueOf(rs.get("RE_PERSON")))%>" class="inp_txt" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????"))?"disabled":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />(???)
		          		</td>
		          	</tr>
		          	<tr class="mm" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????"))?"style='display:none'":""%>>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
		          		<td colspan="3">
		          			<input type="text" name="reprice" id="reprice" value="<%=util.getStr(String.valueOf(rs.get("RE_PRICE")))%>" class="inp_txt" <%=(util.getStr(rs.get("RE_TYPE")).equals("??????"))?"disabled":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />(??????:?????????)
		          		</td>
		          	</tr>		          	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - ????????????</h3>
		<div class="zoom_x"></div>
		<table class="skin_basic_write" >
			<caption>????????????</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<td colspan="4">
		          			<textarea name="recomment" class="inp_txt" rows="3" style="min-width:80%" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>><%=util.getStr(rs.get("RE_COMMENT"))%></textarea>
		          		</td>
		          	</tr>          	
		   	</tbody>
		</table>
		
		
		<h3 class="tit"> - <%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>??? ????????????</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('info',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>);" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('info',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>);" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		</div>
		
		<div id="resultInfo_t1_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>">
			<%
			if(m1ResultInfo.size() > 0){
				int infox = 0;
				for(HashMap rn:m1ResultInfo){
					
			%>
			
			<table class="skin_basic_write info<%=infox+1%>" data-type="on">
				<caption>????????????</caption>
			       <colgroup>
				      <col style="width:20%" />
			          <col style="width:30%" />
			          <col style="width:20%" />
			          <col style="width:30%" />
			       </colgroup>
			   <tbody>
				  	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			      		<td colspan="3">
			      			<input type="hidden" name="chk_info" value="<%=infox+1%>">
			      			<input type="hidden" name="info_idx" value="<%=util.getStr(String.valueOf(rn.get("IDX")))%>">
			          		<label><input type="radio" name="re1type_<%=infox+1%>" value="SCI(E)??????" <%=(util.getStr(rn.get("R_TYPE")).equals("SCI(E)??????") || util.getStr(rn.get("R_TYPE")).equals(""))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> SCI(E)??????</label>
			           	<label><input type="radio" name="re1type_<%=infox+1%>" value="???SCI(E)??????" <%=util.getStr(rn.get("R_TYPE")).equals("???SCI(E)??????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ???SCI(E)??????</label>
			           	<label><input type="radio" name="re1type_<%=infox+1%>" value="????????????" <%=util.getStr(rn.get("R_TYPE")).equals("????????????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ????????????</label>
			           	<label><input type="radio" name="re1type_<%=infox+1%>" value="??????" <%=util.getStr(rn.get("R_TYPE")).equals("??????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ??????</label>
			          	</td>
			       </tr>
			       <tr>
			       	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
			       	<td>
			       		<input type="text" name="re1name" id="re1name_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>_<%=infox+1%>" value="<%=util.getStr(rn.get("R_NAME"))%>" class="inp_txt" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			       	</td>
			       	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			       	<td>
			       		<input type="text" name="re1aname" id="re1aname_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>_<%=infox+1%>" value="<%=util.getStr(rn.get("R_ANAME"))%>" class="inp_txt" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			       	</td>
			       </tr>
			       <tr>
			       	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
			       	<td colspan="3">
			       		<input type="text" name="re1date" id="re1date_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>_<%=infox+1%>" readonly value="<%=util.getStr(String.valueOf(rn.get("R_DATE")))%>" class="inp_txt read_only" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			       	</td>
			       </tr>
			   </tbody>
			</table>
			
			<%
					infox++;
				}//for end
			}else{
			%>
			<div class="hideBox_n">+ ????????? ????????? ????????? ???????????????</div>
			<%
			}
			%>		
		</div>
		
		<h3 class="tit"> - <%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>??? ??????????????????</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('se',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('se',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		</div>
		
		<div id="resultInfo_t2_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>">
			<%
			if(m1ResultSe.size() > 0){
				int se = 0;
				for(HashMap rn:m1ResultSe){
					
			%>
			
			
			<table class="skin_basic_write info<%=se+1%>" data-type="on">
				<caption>??????????????????</caption>
			       <colgroup>
				       <col style="width:20%" />
			          <col style="width:30%" />
			          <col style="width:20%" />
			          <col style="width:30%" />
			       </colgroup>
			   	<tbody>
				<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>
		      		<td colspan="3">
		      	      	<input type="hidden" name="chk_se" value="<%=se+1%>">
		      	      	<input type="hidden" name="se_idx" value="<%=util.getStr(String.valueOf(rn.get("IDE")))%>">
		      			<select class="select_box" name="setype">
		      				<option value="">::??????::</option>
					      	<%
							for(HashMap ap:applicationList){
							%>
							<option value="<%=util.getStr(ap.get("CODE_NM"))%>" <%=util.getStr(rn.get("SE_TYPE")).equals(util.getStr(ap.get("CODE_NM")))?"selected":"" %> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>><%=util.getStr(ap.get("CODE_NM"))%></option>
							<% 
							}
							%>
		      			</select>
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>
		      		<td>
		      			<input type="text" class="inp_txt" name="senumber" value="<%=util.getStr(rn.get("SE_NUMBER"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      		</td>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>
		      		<td>
		      			<input type="text" class="inp_txt read_only" readonly name="sedate" value="<%=util.getStr(String.valueOf(rn.get("SE_DATE")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
		      		<td>
		      			<input type="text" class="inp_txt" name="sename" value="<%=util.getStr(rn.get("SE_NAME"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      		</td>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<input type="text" class="inp_txt" name="sesetdate" value="<%=util.getStr(rn.get("SE_SETDATE"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      		</td>
		      	</tr>
			   	</tbody>
			</table>
			
			<%
					se++;
				}//for end
			}else{
			%>
			<div class="hideBox_n">+ ????????? ????????? ????????? ???????????????</div>
			<%
			}
			%>
		</div>
		
		<h3 class="tit"> - <%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>??? ??????????????????</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('tech',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('tech',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		</div>
		
		<div id="resultInfo_t3_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>">
		<%
		if(m1ResultTech.size() > 0){
			int te = 0;
			for(HashMap rn:m1ResultTech){
				
		%>
		
			
			<table class="skin_basic_write info<%=te+1%>" data-type="on">
				<caption>??????????????????</caption>
			       <colgroup>
				       <col style="width:20%" />
			          <col style="width:30%" />
			          <col style="width:20%" />
			          <col style="width:30%" />
			       </colgroup>
			   	<tbody>
					<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
			      		<td colspan="3">
			      	      	<input type="hidden" name="chk_tech" value="<%=te+1%>">
			      	      	<input type="hidden" name="tech_idx" value="<%=util.getStr(String.valueOf(rn.get("IDX")))%>">
			      			<select class="select_box" name="tetype">
			      				<option value="">::??????::</option>
						      	<%
								for(HashMap tec:technologyList){
								%>
								<option value="<%=util.getStr(tec.get("CODE_NM"))%>" <%=util.getStr(rn.get("TE_TYPE")).equals(util.getStr(tec.get("CODE_NM")))?"selected":"" %> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>><%=util.getStr(tec.get("CODE_NM"))%></option>
								<% } %>
			      			</select>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			      		<td colspan="3">
			      	      	<label><input type="radio" name="tetype1_<%=te+1%>" value="??????/??????" <%=(util.getStr(rn.get("TE_TYPE1")).equals("??????/??????") || util.getStr(rn.get("TE_TYPE1")).equals(""))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ??????/??????</label>
					       <label><input type="radio" name="tetype1_<%=te+1%>" value="????????????" <%=util.getStr(rn.get("TE_TYPE1")).equals("????????????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ????????????</label>
					       <label><input type="radio" name="tetype1_<%=te+1%>" value="????????????" <%=util.getStr(rn.get("TE_TYPE1")).equals("????????????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ????????????</label>
					       <label><input type="radio" name="tetype1_<%=te+1%>" value="????????????" <%=util.getStr(rn.get("TE_TYPE1")).equals("????????????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ????????????</label>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
			      		<td colspan="3">
			      	       <label><input type="radio" name="tetype2_<%=te+1%>" value="???????????????" <%=(util.getStr(rn.get("TE_TYPE2")).equals("???????????????") || util.getStr(rn.get("TE_TYPE2")).equals(""))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ???????????????</label>
					       <label><input type="radio" name="tetype2_<%=te+1%>" value="???????????????" <%=(util.getStr(rn.get("TE_TYPE2")).equals("???????????????"))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ???????????????</label>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
			      		<td>
			      			<input type="text" class="inp_txt" name="teprice" value="<%=util.getStr(String.valueOf(rn.get("TE_PRICE")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>/>(??????:?????????)
			      		</td>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
			      		<td>
			      			<input type="text" class="inp_txt" name="te_nprice" value="<%=util.getStr(String.valueOf(rn.get("TE_NPRICE")))%>" onkeyup="commaCheck(this)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>/>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>
			      		<td>
			      			<input type="text" class="inp_txt" name="tenname" value="<%=util.getStr(rn.get("TE_NNAME"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			      		</td>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>
			      		<td>
			      			<input type="text" class="inp_txt" name="tegname" value="<%=util.getStr(rn.get("TE_GNAME"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			      		</td>
			      	</tr>
			   	</tbody>
			</table>
		
		
		<%
				te++;
			}//for end
		}else{
		%>
			<div class="hideBox_n">+ ????????? ????????? ????????? ???????????????</div>
		<%
		}
		%>
		</div>
		
		<h3 class="tit"> - <%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>??? ??????????????????????????????</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('bus',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('bus',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		</div>
		
		<div id="resultInfo_t4_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>">
		<%
		if(m1ResultBus.size() > 0){
			int bu = 0;
			for(HashMap rn:m1ResultBus){
				
		%>
			
			<table class="skin_basic_write info<%=bu+1%>" data-type="on">
				<caption>??????????????????????????????</caption>
				<colgroup>
					<col style="width:20%" />
			        <col style="width:30%" />
			        <col style="width:20%" />
			        <col style="width:30%" />
			    </colgroup>
			   	<tbody>
				<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
		      		<td colspan="3">
		      	      	<input type="hidden" name="chk_bus" value="<%=bu+1%>">
		      	      	<input type="hidden" name="bus_idx" value="<%=util.getStr(String.valueOf(rn.get("IDX")))%>">
		      	      	<label><input type="radio" name="bustype1_<%=bu+1%>" value="?????????" <%=(util.getStr(rn.get("BUS_TYPE")).equals("?????????") || util.getStr(rn.get("BUS_TYPE")).equals(""))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>> ?????????</label>
				       <label><input type="radio" name="bustype1_<%=bu+1%>" value="????????????" <%=util.getStr(rn.get("BUS_TYPE")).equals("????????????")?"checked":""%>> ????????????</label>
				       <label><input type="radio" name="bustype1_<%=bu+1%>" value="????????????" <%=util.getStr(rn.get("BUS_TYPE")).equals("????????????")?"checked":""%>> ????????????</label>
				       <label><input type="radio" name="bustype1_<%=bu+1%>" value="??????" <%=util.getStr(rn.get("BUS_TYPE")).equals("??????")?"checked":""%>> ??????</label>
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
		      		<td colspan="3">
		      	       <input type="text" class="inp_txt" name="busname" value="<%=util.getStr(rn.get("BUS_NAME"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<input type="text" class="inp_txt" name="busstatus" value="<%=util.getStr(rn.get("BUS_STATUS"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      		</td>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<input type="text" class="inp_txt" name="busprice" value="<%=util.getStr(String.valueOf(rn.get("BUS_PRICE")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />(??????:?????????)
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<input type="text" class="inp_txt" name="busnum" value="<%=util.getStr(String.valueOf(rn.get("BUS_NUM")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />(1???/EA)
		      		</td>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(??????)</th>
		      		<td>
		      			<input type="hidden" class="inp_txt" name="bustotprice" value="<%=util.getStr(String.valueOf(rn.get("BUS_TOTPRICE")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		      			<span class="bustotprice"></span>
		      		</td>
		      	</tr>
			   	</tbody>
			</table>
		
		
		<%
				bu++;
			}//for end
		}else{
		%>
			<div class="hideBox_n">+ ????????? ????????? ????????? ???????????????</div>
		<%
		}
		%>
		</div>
		
		<h3 class="tit"> - <%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>??? ?????????????????????</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('pps',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('pps',<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>)" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
		</div>
		
		<div id="resultInfo_t5_<%=util.getStr(String.valueOf(rs.get("RE_YEAR")))%>">
		<%
		if(m1ResultPps.size() > 0){
			int ps = 0;
			for(HashMap rn:m1ResultPps){
				
		%>
		
			<table class="skin_basic_write info<%=ps+1%>" data-type="on">
				<caption>??????????????????????????????</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
			   	<tbody>
					<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
			      		<td colspan="3">
			      	      	<input type="hidden" name="chk_pps" value="<%=ps+1%>">
			      	      	<input type="hidden" name="pps_idx" value="<%=util.getStr(String.valueOf(rn.get("IDX")))%>">
			      	      	<label><input type="radio" name="ppstype1_<%=ps+1%>" value="???????????????(??????)??????" <%=(util.getStr(rn.get("PPS_TYPE1")).equals("???????????????(??????)??????") || util.getStr(rn.get("PPS_TYPE1")).equals(""))?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>>???????????????(??????)??????</label>
					       <label><input type="radio" name="ppstype1_<%=ps+1%>" value="???????????????(??????)??????" <%=util.getStr(rn.get("PPS_TYPE1")).equals("???????????????(??????)??????")?"checked":""%> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>>???????????????(??????)??????</label>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;">*</span> ????????????</th>
			      		<td colspan="3">
			      	       <input type="text" class="inp_txt" name="ppsname" value="<%=util.getStr(rn.get("PPS_NAME"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			      		<td>
			      			<input type="text" class="inp_txt" name="ppsxname" value="<%=util.getStr(rn.get("PPS_NAME"))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			      		</td>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>
			      		<td>
			      			<select class="select_box" name="ppstype">
			      				<option value="">::??????::</option>
						      	<%
								for(HashMap app:applicationList){
								%>
								<option value="<%=util.getStr(app.get("CODE_NM"))%>" <%=util.getStr(rn.get("PPS_TYPE")).equals(util.getStr(app.get("CODE_NM")))?"selected":"" %> <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%>><%=util.getStr(app.get("CODE_NM"))%></option>
								<% 
								}
								%>
			      	
			      			</select>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>
			      		<td>
			      			<input type="text" class="inp_txt" name="ppsnum" value="<%=util.getStr(String.valueOf(rn.get("PPS_NUM")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			      		</td>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>
			      		<td>
			      			<input type="text" class="inp_txt read_only" readonly name="ppsdate" value="<%=util.getStr(String.valueOf(rn.get("PPS_DATE")))%>" <%=(util.getStr(rs.get("RE_SET")).equals("1"))?"disabled":""%> />
			      		</td>
			      	</tr>
			   	</tbody>
			</table>
		
		<%
				ps++;
			}//for end
		}else{
		%>
			<div class="hideBox_n">+ ????????? ????????? ????????? ???????????????</div>
		<%
		}
		%>
		</div>
		
		<input type="button" class="modifyBtn" value="????????????" />
		
		</form>
		
		
	</div>
	
	
	
	
	<%
			xn++;
		}//for end
	}else{
	%>
	<div class="hideBox">
		+ ????????? ????????? ????????? ???????????????
	</div>
	<%
	}
	%>
	
	
	
		
</div>








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
	
	var mSdate = $("#MSDATE").val().split("-");
	var mEdate = $("#MEDATE").val().split("-");
	var toDate = new Date();
	var toDateYear = toDate.getFullYear();
	
	var sDateYear = mSdate[0];
	var eDateYear = mEdate[0];
	var yearOption = "";
	
	if($("#MING").is(":checked")==true){
		eDateYear = toDateYear;
	}
	
	
	var setAYear = sDateYear;
	var setBYear = sDateYear;
	var submitChk = false;

	function goSubmit(mode,proState){
		$('#proState').val(proState);
		$('#mode').val(mode);
		
		var formData = new FormData($("#fwrite")[0]);
		
		if(submitChk){
			return false;
		}else{
			submitChk = true;
		}
			
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdM1_formAjax.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	if(data.status == "OK"){
            		
            		alert("??????????????? ?????????????????????.");
            		
            		
            		
            		//var midx = data.paramMap.midx;
            		
            		/* for(var y=sDateYear; y<=eDateYear; y++){
            			
            			var htmlSet1 = "";
            			var htmlSet2 = "";
            			
            			htmlSet1 += '<div class="htmlSet" id="htmlCont_'+y+'">';
            			htmlSet1 += '<input type="hidden" name="midx" value="'+midx+'">'
	            		htmlSet1 += '?????????????????? : <strong>'+y+'</strong>??? <span class="bdText"></span>';
	            		htmlSet1 += '<span class="htmlBtn add addPriceSet" data-year="'+y+'" data-midx="'+midx+'">????????????</span>';
	            		htmlSet1 += '<span class="htmlBtn nps addNpSet cRed" data-year="'+y+'" data-midx="'+midx+'">???????????????</span>';
	            		htmlSet1 += '</div>';
	            		
	            		htmlSet2 += '<div class="htmlResultSet" id="htmlResultCont_'+y+'">';
            			htmlSet2 += '<input type="hidden" name="midx" value="'+midx+'">'
	            		htmlSet2 += '?????????????????? : <strong>'+y+'</strong>??? <span class="bdText"></span>';
	            		htmlSet2 += '<span class="htmlBtn addx addResultSet" data-year="'+y+'" data-midx="'+midx+'">????????????</span>';
	            		//htmlSet2 += '<span class="htmlBtn npsx addResultNpSet cRed" data-year="'+y+'" data-midx="'+midx+'">???????????????</span>';
	            		htmlSet2 += '</div>';
	            		
	            		$("#ncontentBox").append(htmlSet1);
	            		$("#resultBox").append(htmlSet2);
            		} */
            		
            		
            		//$("#ncontentBox").show();
        			//$(".hideBox").hide();
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
    }
	
	
	
	
	
	
	
	$(":file").on("change",function(){
		var fileid = $(this).data("fileid");
		var filesn = $(this).data("filesn");
		//var xxx = $(this).attr("name");
		
			$(this).prevAll("input[name='fileFlog']").val(fileid);
			$(this).prevAll("input[name='fileSn']").val(filesn);
		
		
	});
	
	
	
	$(document).on("click",".delPriceInfo",function(){
		var xidx = $(this).data("xidx");
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdM1PriceInfoDelete.do",
            //processData: false,
            //contentType: false,
            type : 'POST', 
            data : {xidx:xidx},
            dataType : 'JSON',
            success : function(data) {
            	if(data.status == "OK"){
            		
            		alert("?????????????????????.");
            		
            	}
            },
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
		});
	});
	
	
	
	
	
	
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


//????????????-????????? ?????? S
	function goCheck(){
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
        var fileCount = $("input[type=file]").length;
		
        if($("select[name='mname']").val() == ""){
        	alert('????????????(???)?????? ???????????????');
        	$("select[name='mname']").focus();
        	return false;
        }
        
        if($("input[name='mbname']").val() == ""){
        	alert('??????(?????????)???????????? ???????????????');
        	$("input[name='mbname']").focus();
        	return false;
        }
        
        if($("input[name='hname']").val() == ""){
        	alert('???????????? ???????????????');
        	$("input[name='hname']").focus();
        	return false;
        }
        
        if($("#MSDATE").val() == ""){
        	alert('?????????????????? ???????????????');
        	$("#MSDATE").focus();
        	return false;
        }
        
        if($("#MEDATE").val() == "" && !$("#MING").is(":checked")){
        	alert('?????????????????? ???????????????');
        	$("#MEDATE").focus();
        	return false;
        }
        
        
		
	    
		goSubmit('modifyProc','10');
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
	$("#MEDATE").datepicker({
       	showMonthAfterYear : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	onClose: function(dateText, inst) {
       		var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
       		eDateYear = parseInt(year);
       		
       		console.log(sDateYear+"------"+eDateYear);
       	}
	});
	
	$("#MSDATE").datepicker({
       	showMonthAfterYear : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            var xNum = "";
            
            sDateYear = parseInt(year);
                   
        }
	});
	
	
	
	
	$(document).on("click","#npset1",function(){
		if($(this).is(":checked") && $(this).parents("div.ncontent").find("#npyear1").val() == ""){
			alert("????????????????????? ?????? ???????????????");
			$(this).parents("div.ncontent").find("#npyear1").focus();
			$(this).prop("checked",false);
			
		}else if($(this).is(":checked") && $(this).parents("div.ncontent").find("#npyear1").val() != ""){
			
			$(this).parents("div.ncontent").find("input").not(this).prop("disabled",true);
			$(this).parents("div.ncontent").find("option").attr("disabled",true);
			$(this).parents("div.ncontent").find("textarea").attr("disabled",true);
			$(this).parents("div.ncontent").find("input[name='midx']").prop("disabled",false);
			$(this).parents("div.ncontent").find("input[name='npyear']").prop("disabled",false);
			$(this).parents("div.ncontent").find("input[name='fileSn'],input[name='fileFlog']").prop("disabled",false);
			//$(this).prop("disabled",false);
			
		}else{
			
			/* ???????????? ????????? */
			$(this).parents("div.ncontent").find("input").not(this).prop("disabled",false);
			$(this).parents("div.ncontent").find("option").attr("disabled",false);
			$(this).parents("div.ncontent").find("textarea").attr("disabled",false);
			
			if($(this).parents("div.ncontent").find("input[name='nptype2']:checked").val() == "?????????"){
				
				$(this).parents("div.ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",true);
			}
			
		}
	});
	
	
	$(document).on("click","#reset",function(){
		if($(this).is(":checked") && $(this).parents("div.result_content").find("#reyear").val() == ""){
			alert("????????????????????? ?????? ???????????????");
			//$(this).parents("div.result_content").find("#reyear").focus();
			$(this).prop("checked",false);
			
		}else if($(this).is(":checked") && $(this).parents("div.result_content").find("#reyear").val() != ""){
			
			$(this).parents("div.result_content").find("input").not(this).prop("disabled",true);
			$(this).parents("div.result_content").find("option").attr("disabled",true);
			$(this).parents("div.result_content").find("textarea").attr("disabled",true);
			$(this).parents("div.result_content").find(".hideBox_n").text("???????????????????????? ????????? ????????? ??? ????????????.");
			$(this).parents("div.result_content").find(".submitBtn").prop("disabled",false);
			$(this).parents("div.result_content").find("input[name='midx']").prop("disabled",false);
			$(this).parents("div.result_content").find("input[name='reyear']").prop("disabled",false);
			
		}else{
			
			/* ???????????? ????????? */
			$(this).parents("div.result_content").find("input").not(this).prop("disabled",false);
			$(this).parents("div.result_content").find("option").attr("disabled",false);
			$(this).parents("div.result_content").find("textarea").attr("disabled",false);
			$(this).parents("div.result_content").find(".hideBox_n").text("+ ????????? ????????? ????????? ???????????????");
			//$(this).parents("div.result_content").find(":button").removeClass("cGreay");
		}
	});
	
	
	$("input[name='medate']").on("change",function(){
		if($("input[name='msdate']").val() == ""){
			alert("???????????? ???????????? ???????????????");
			$("input[name='msdate']").focus();
			$("input[name='medate']").val("");
			return false;
		}
		var sdate = $("input[name='msdate']").val().split("-");
		var sy = new Date(sdate[0],sdate[1],sdate[2]);
		var ey = new Date($(this).val());
		var dif = ey - sy;
		var cDay = 86400*1000;
		var cMonth = cDay*30;
		var monthTot = parseInt((dif/cMonth)+1);
		
		$("input[name='mMonth']").val(monthTot);
		$("#monthTit").html(monthTot+"??????");
	});
	
	$("input[name='ming']").on("click",function(){
		if($(this).is(":checked")){
			eDateYear = parseInt(toDateYear);
			$("input[name='medate']").val("");
			$("input[name='medate']").attr("disabled",true);
			$("input[name='mMonth']").val(0);
			$("#monthTit").html("????????????");
		}else{
			eDateYear = "";
			$("input[name='medate']").attr("disabled",false);
			$("#monthTit").html("");
		}		
	});
	
	
	var ncontentNum = 1;
	
	function addRow(mode){
		
		if(mode == "typeA"){
			
			var xxy = $(".ncontent:last").find("input[name='npyear']").val();
			var year = parseInt(setAYear);
			var midx = $("#midx").val();
			var $this = $(this);
			
			
			
			if(xxy != null){
				year = parseInt(xxy)+1;
			}else{
				//alert("asdfasf");
			}
			
			if(setAYear > eDateYear){
				alert("??????????????? ???????????????");
				return false;
			}
			
			
			$.ajax({
				cache : false,
				url : "/sys/sysJnrd_ncontentAjax.do", // ?????????
				type : 'POST',
				data : {year:year,midx:midx},
				dataType : 'HTML',
				success : function(data) {
					
					setAYear = year+1;
					$("#ncontentBox").append(data);
					$("#ncontentBox").find(".hideBox").hide();
					//$("#htmlCont_"+year).after(data);
					//$this.parents(".htmlSet").find(".htmlBtn").addClass("cGreay");
					//$this.removeClass("addPriceSet");
				},
				error : function(xhr, status) {
					alert(xhr + " : " + status);
				}
			});
			
		}else{
			
			
			var xxy = $(".result_content:last").find("input[name='reyear']").val();
			var year = parseInt(setBYear);
			var midx = $("#midx").val();
			var $this = $(this);
			
			if(xxy != null){
				year = parseInt(xxy)+1;
			}else{
				//alert("asdfasf");
			}
			
			if(setBYear > eDateYear){
				alert("??????????????? ???????????????");
				return false;
			}
			
			
			$.ajax({
				cache : false,
				url : "/sys/sysJnrd_resultWriteAjax.do", // ?????????
				type : 'POST',
				data : {year:year,midx:midx},
				dataType : 'HTML',
				success : function(data) {
					
					setBYear = year+1;
					
					$("#resultBox").append(data);
					$("#resultBox").find(".hideBox").hide();
					//$("#htmlResultCont_"+year).after(data);
					//$this.parents(".htmlResultSet").find(".htmlBtn").addClass("cGreay");
					//$this.removeClass("addResultSet");
				},
				error : function(xhr, status) {
					alert(xhr + " : " + status);
				}
			});
			
			
			
			
		}
		
	}
	
	$(document).on("click",".addPriceSet",function(){
		
		if(year == ""){
			alert("????????????????????? ????????? ??? ????????????.");
			$("#MSDATE").focus();
			return false;
		}
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrd_ncontentAjax.do", // ?????????
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'HTML',
			success : function(data) {
				$("#htmlCont_"+year).after(data);
				$this.parents(".htmlSet").find(".htmlBtn").addClass("cGreay");
				$this.removeClass("addPriceSet");
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	$(document).on("click",".addResultSet",function(){
		
		if(year == ""){
			alert("????????????????????? ????????? ??? ????????????.");
			$("#MSDATE").focus();
			return false;
		}
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrd_resultWriteAjax.do", // ?????????
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'HTML',
			success : function(data) {
				$("#htmlResultCont_"+year).after(data);
				$this.parents(".htmlResultSet").find(".htmlBtn").addClass("cGreay");
				$this.removeClass("addResultSet");
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	//???????????????
	$(document).on("click",".addNpSet",function(){
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrdNpSetAjax.do", // ?????????
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'JSON',
			success : function(data) {
				
				if(data.state == "OK"){
				
					$this.parents(".htmlSet").find(".htmlBtn").addClass("cGreay");
					$this.parents(".htmlSet").find(".htmlBtn").removeClass("addPriceSet");
					$this.parents(".htmlSet").find(".htmlBtn").removeClass("addNpSet");
					$this.text("?????????????????????");
					$this.parents(".htmlSet").find(".bdText").text("???????????? ????????? ?????????");
					$this.removeClass("cGreay");
					$this.addClass("ageNpset cBlue");
					
				
				}else{
					alert("????????? ?????????????????????. ??????????????? ???????????????");
				}
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	$(document).on("click",".ageNpset",function(){
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrdNpSetDelAjax.do",
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'HTML',
			success : function(data) {
				
				$this.parents(".htmlSet").find(".add").addClass("addPriceSet");
				$this.parents(".htmlSet").find(".htmlBtn").removeClass("cGreay cBlue");
				$this.text("???????????????");
				$this.parents(".htmlSet").find(".bdText").text("");
				$this.removeClass("ageNpset");
				$this.addClass("ageNpset");
				
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	
	function delRow(mode){
		
		if(mode == "typeA"){
			
			var typex = $(".ncontent:last").data("type");
			if(typex != "on"){
				
				if($(".ncontent").length == 1){
					$("#ncontentBox").find(".hideBox").css("display","block");
				}
				
				var xxy = $(".ncontent:last").find("input[name='npyear']").val();
				setAYear = xxy;
				
				$(".ncontent:last").remove();
				//ncontentNum --;
			}
			
		}else{
			
			var typex = $(".result_content:last").data("type");
			if(typex != "on"){
				
				if($(".result_content").length == 1){
					$("#resultBox").find(".hideBox").css("display","block");
				}
				
				var xxy = $(".result_content:last").find("input[name='reyear']").val();
				setBYear = xxy;
				
				$(".result_content:last").remove();
				//ncontentNum --;
			}
			
		}
	}
	
	
	
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
	
	
	$(document).on("change","#npprice1,#npprice2,#npprice3,#npprice4",function(){
		
		var np1 = $(this).parents(".ncontent").find("#npprice1").val();
		var np2 = $(this).parents(".ncontent").find("#npprice2").val();
		var np3 = $(this).parents(".ncontent").find("#npprice3").val();
		var np4 = $(this).parents(".ncontent").find("#npprice4").val();
		
		var npp1 = (np1 == "")?0:np1;
		var npp2 = (np2 == "")?0:np2;
		var npp3 = (np3 == "")?0:np3;
		var npp4 = (np4 == "")?0:np4;
		
		var totP = parseInt(npp1)+parseInt(npp2)+parseInt(npp3)+parseInt(npp4);
		$(this).parents(".ncontent").find("#npprice5").val(totP);
		
	});
	
	
	$(document).on("change","input[name='busprice'],input[name='busnum']",function(){
		
		var np1 = $(this).parents(".skin_basic_write").find("input[name='busprice']").val();
		var np2 = $(this).parents(".skin_basic_write").find("input[name='busnum']").val();
		
		var npp1 = (np1 == "")?0:np1;
		var npp2 = (np2 == "")?0:np2;
		
		var totP = parseInt(npp1)*parseInt(npp2);
		$(this).parents(".skin_basic_write").find("input[name='bustotprice']").val(totP);
		$(this).parents(".skin_basic_write").find(".bustotprice").text(totP);
		
	});
	
	
	
	$(document).on("click",".submitBtn",function (){
		var f = $(this).parents(".result_content").find("form")[0];
		var formData = new FormData(f);
		var $this = $(this);
			
		if(formData.get("reperson") == "" && (formData.get("retype") == "??????" || formData.get("retype") == "??????/??????" )){
			alert("??????????????? ???????????????");
			$(this).parents(".result_content").find("#reperson").focus();
			return false;
		}
		if(formData.get("reprice") == "" && (formData.get("retype") == "??????" || formData.get("retype") == "??????/??????" )){
			alert("????????? ???????????????");
			$(this).parents(".result_content").find("#reprice").focus();
			return false;
		}
		
		if(formData.has("chk_info")){
			
			if($(this).parents(".result_content").find("input[name='re1name']:last").val() == ""){
				alert("??????????????? ???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1name']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1aname']:last").val() == ""){
				alert("??????????????? ??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1aname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1date']:last").val() == ""){
				alert("??????????????? ???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1date']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_se")){
			
			if($(this).parents(".result_content").find("select[name='setype']:last").val() == ""){
				alert("??????/??????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='setype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='senumber']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='senumber']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='sedate']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sedate']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sename']:last").val() == ""){
				alert("????????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sename']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sesetdate']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sesetdate']:last").focus();
				return false;
			}
		}
		
		
		if(formData.has("chk_tech")){
			
			if($(this).parents(".result_content").find("select[name='tetype']:last").val() == ""){
				alert("????????????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='tetype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='teprice']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='teprice']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='te_nprice']:last").val() == ""){
				alert("?????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='te_nprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tenname']:last").val() == ""){
				alert("????????????(??????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='tenname']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tegname']:last").val() == ""){
				alert("????????????(??????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='tegname']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_bus")){
			
			if($(this).parents(".result_content").find("input[name='busname']:last").val() == ""){
				alert("???????????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busstatus']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busstatus']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busprice']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='busnum']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busnum']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_pps")){
			
			if($(this).parents(".result_content").find("input[name='ppsname']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='ppsxname']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsxname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("select[name='ppstype']:last").val() == ""){
				alert("??????/??????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='ppstype']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsnum']:last").val() == ""){
				alert("????????????(????????????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsnum']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsdate']:last").val() == ""){
				alert("?????????(?????????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsdate']:last").focus();
				return false;
			}
		}		
		
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdResultFormWriteProc.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	
            	var midx = data.paramMap.mridx;
            	
            	if(data.status == "OK" && midx > 0){
            		
            		alert('????????????!!');
            		$this.prop("disabled",true);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		return false;
	});
	
	
	
	$(document).on("click",".modifyBtn",function (){
		var f = $(this).parents(".result_content").find("form")[0];
		var formData = new FormData(f);
		var $this = $(this);
		
		
		if(formData.get("reperson") == "" && (formData.get("retype") == "??????" || formData.get("retype") == "??????/??????" )){
			alert("??????????????? ???????????????");
			$(this).parents(".result_content").find("#reperson").focus();
			return false;
		}
		if(formData.get("reprice") == "" && (formData.get("retype") == "??????" || formData.get("retype") == "??????/??????" )){
			alert("????????? ???????????????");
			$(this).parents(".result_content").find("#reprice").focus();
			return false;
		}
		
		if(formData.has("chk_info")){
			
			if($(this).parents(".result_content").find("input[name='re1name']:last").val() == ""){
				alert("??????????????? ???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1name']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1aname']:last").val() == ""){
				alert("??????????????? ??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1aname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1date']:last").val() == ""){
				alert("??????????????? ???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1date']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_se")){
			
			if($(this).parents(".result_content").find("select[name='setype']:last").val() == ""){
				alert("??????/??????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='setype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='senumber']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='senumber']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='sedate']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sedate']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sename']:last").val() == ""){
				alert("????????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sename']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sesetdate']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sesetdate']:last").focus();
				return false;
			}
		}
		
		
		if(formData.has("chk_tech")){
			
			if($(this).parents(".result_content").find("select[name='tetype']:last").val() == ""){
				alert("????????????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='tetype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='teprice']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='teprice']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='te_nprice']:last").val() == ""){
				alert("?????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='te_nprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tenname']:last").val() == ""){
				alert("????????????(??????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='tenname']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tegname']:last").val() == ""){
				alert("????????????(??????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='tegname']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_bus")){
			
			if($(this).parents(".result_content").find("input[name='busname']:last").val() == ""){
				alert("???????????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busstatus']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busstatus']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busprice']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='busnum']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busnum']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_pps")){
			
			if($(this).parents(".result_content").find("input[name='ppsname']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='ppsxname']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsxname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("select[name='ppstype']:last").val() == ""){
				alert("??????/??????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='ppstype']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsnum']:last").val() == ""){
				alert("????????????(????????????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsnum']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsdate']:last").val() == ""){
				alert("?????????(?????????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsdate']:last").focus();
				return false;
			}
		}		
		
		
		
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdResultFormModifyProc.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	
            	//var midx = data.paramMap.mridx;
            	
            	if(data.status == "OK"){
            		
            		alert('????????????!!');
            		//$this.prop("disabled",true);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		return false;
	});
	
	
	
	// ???????????? (????????????)
	$(document).on("click",".addPriceInfo",function(){
		var year = $(this).data("year");
		var formData = new FormData($("#ncontForm_"+year)[0]);
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
		var $this = $(this);
		
		if($(this).parents(".ncontent").find("input[name='npset']").is(":checked")){
			
			
			
			
		}else{
			
			if($(this).parents(".ncontent").find("input[name='nptype2']:checked").val() != "?????????"){
				if($(this).parents(".ncontent").find("#nptotprice").val() == ""){
					alert("???????????? ??????");
					$(this).parents(".ncontent").find("#nptotprice").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice1").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice1").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice2").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice2").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice3").val() == ""){
					alert("????????? ??????");
					$(this).parents(".ncontent").find("#npprice3").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice4").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice4").focus();
					return false;
				}
			}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#Jnrdm1File1").val()) && $(this).parents(".ncontent").find('#Jnrdm1File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#Jnrdm1File1").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#Jnrdm1File2").val()) && $(this).parents(".ncontent").find('#Jnrdm1File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#Jnrdm1File2").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#Jnrdm1File3").val()) && $(this).parents(".ncontent").find('#Jnrdm1File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#Jnrdm1File3").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			if($(this).parents(".ncontent").find("#npotext1").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext1").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext2").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext2").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext3").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext3").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext4").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext4").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext5").val() == ""){
				alert("????????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext5").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext6").val() == ""){
				alert("????????????(??????) ??????");
				$(this).parents(".ncontent").find("#npotext6").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext7").val() == ""){
				alert("?????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext7").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext8").val() == ""){
				alert("????????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext8").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext9").val() == ""){
				alert("??????????????? ???????????? ??????");
				$(this).parents(".ncontent").find("#npotext9").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext10").val() == ""){
				alert("??????????????? ??????");
				$(this).parents(".ncontent").find("#npotext10").focus();
				return false;
			}
			
			if($(this).parents(".ncontent").find("#npwtext1").val() == ""){
				alert("???????????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext1").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext2").val() == ""){
				alert("?????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext2").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext3").val() == ""){
				alert("????????????????????????(??????) ??????");
				$(this).parents(".ncontent").find("#npwtext3").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext4").val() == ""){
				alert("????????????????????????(?????????) ??????");
				$(this).parents(".ncontent").find("#npwtext4").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext5").val() == ""){
				alert("???????????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext5").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext6").val() == ""){
				alert("6T?????? ??????");
				$(this).parents(".ncontent").find("#npwtext6").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext7").val() == ""){
				alert("???????????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext7").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext8").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npwtext8").focus();
				return false;
			}
			
		}	
			
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdM1PriceInfoWriteProc.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	
            	var midx = data.paramMap.midx;
            	
            	if(data.status == "OK" && midx > 0){
            		
            		alert('????????????!!');
            		$this.removeClass("addPriceInfo");
            		$this.addClass("addPriceInfo_off");
            		$this.text("????????????");
            		$(".addPriceInfo_off").attr("data-midx",midx);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		
	});
	
	
	
	
	// ????????????
	$(document).on("click",".modPriceInfo",function(){
		var year = $(this).data("year");
		var formData = new FormData($("#ncontForm_"+year)[0]);
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
		var $this = $(this);
		
		if($(this).parents(".ncontent").find("input[name='npset']").is(":checked")){
			
			
			
			
		}else{
			
			if($(this).parents(".ncontent").find("input[name='nptype2']:checked").val() != "?????????"){
		
				if($(this).parents(".ncontent").find("#nptotprice").val() == ""){
					alert("???????????? ??????");
					$(this).parents(".ncontent").find("#nptotprice").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice1").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice1").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice2").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice2").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice3").val() == ""){
					alert("????????? ??????");
					$(this).parents(".ncontent").find("#npprice3").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice4").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice4").focus();
					return false;
				}
			
			}
			
			
			if($(this).parents(".ncontent").find("input[name='orgStatus']").val() == "1"){
			
				if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#Jnrdm1File1").val()) && $(this).parents(".ncontent").find('#Jnrdm1File1').val() != ""){
		
		   		}else if($(this).parents(".ncontent").find("#Jnrdm1File1").val() == ""){
		   			alert("??????????????? ???????????? ????????? ???????????????.");
		   			return false;
		   		}else{
		   			alert("?????? ????????? ???????????? ??? ????????????.");
		   			return false;
		   		}
				
				if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#Jnrdm1File2").val()) && $(this).parents(".ncontent").find('#Jnrdm1File1').val() != ""){
		
		   		}else if($(this).parents(".ncontent").find("#Jnrdm1File2").val() == ""){
		   			alert("?????????????????????????????? ???????????? ????????? ???????????????.");
		   			return false;
		   		}else{
		   			alert("?????? ????????? ???????????? ??? ????????????.");
		   			return false;
		   		}
				
				if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#Jnrdm1File3").val()) && $(this).parents(".ncontent").find('#Jnrdm1File1').val() != ""){
		
		   		}else if($(this).parents(".ncontent").find("#Jnrdm1File3").val() == ""){
		   			alert("???????????? ????????? ???????????????.");
		   			return false;
		   		}else{
		   			alert("?????? ????????? ???????????? ??? ????????????.");
		   			return false;
		   		}
	   		
			}
			
			if($(this).parents(".ncontent").find("#npotext1").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext1").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext2").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext2").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext3").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext3").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext4").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext4").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext5").val() == ""){
				alert("????????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext5").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext6").val() == ""){
				alert("????????????(??????) ??????");
				$(this).parents(".ncontent").find("#npotext6").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext7").val() == ""){
				alert("?????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext7").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext8").val() == ""){
				alert("????????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext8").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext9").val() == ""){
				alert("??????????????? ???????????? ??????");
				$(this).parents(".ncontent").find("#npotext9").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext10").val() == ""){
				alert("??????????????? ??????");
				$(this).parents(".ncontent").find("#npotext10").focus();
				return false;
			}
			
			if($(this).parents(".ncontent").find("#npwtext1").val() == ""){
				alert("???????????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext1").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext2").val() == ""){
				alert("?????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext2").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext3").val() == ""){
				alert("????????????????????????(??????) ??????");
				$(this).parents(".ncontent").find("#npwtext3").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext4").val() == ""){
				alert("????????????????????????(?????????) ??????");
				$(this).parents(".ncontent").find("#npwtext4").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext5").val() == ""){
				alert("???????????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext5").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext6").val() == ""){
				alert("6T?????? ??????");
				$(this).parents(".ncontent").find("#npwtext6").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext7").val() == ""){
				alert("???????????????????????? ??????");
				$(this).parents(".ncontent").find("#npwtext7").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npwtext8").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npwtext8").focus();
				return false;
			}
			
		}	
			
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdM1PriceInfoModifyProc.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	
            	//var midx = data.paramMap.midx;
            	
            	if(data.status == "OK"){
            		
            		alert('????????????!!');
            		//$this.removeClass("addPriceInfo");
            		//$this.addClass("addPriceInfo_off");
            		//$this.text("????????????");
            		//$(".addPriceInfo_off").attr("data-midx",midx);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		
	});
	
	
	
	
	
	
	
	
	
	// ?????????????????????????????????ddd
	function addResultRow(mode,year){ //????????????
		
		if(mode == "info"){
			
			var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t1_"+year).find('input[name=re1name]:last').val() == ""){
					alert("???????????? ???????????????");
					$("#resultInfo_t1_"+year).find('input[name=re1name]:last').focus();
					return false;
				}
				if($("#resultInfo_t1_"+year).find('input[name="re1aname"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t1_"+year).find('input[name="re1aname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t1_"+year).find('input[name="re1date"]:last').val() == ""){
					alert("???????????? ???????????????");
					$("#resultInfo_t1_"+year).find('input[name="re1date"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '	  	<tr>';
			htmlCont += '      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
			htmlCont += '      		<td colspan="3">';
			htmlCont += '      			<input type="hidden" name="chk_info" value="'+ScCnt+'">';
			htmlCont += '      			<input type="hidden" name="info_idx" value="">';
			htmlCont += '          		<label><input type="radio" name="re1type_'+ScCnt+'" value="SCI(E)??????" checked="checked"> SCI(E)??????</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="???SCI(E)??????"> ???SCI(E)??????</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="??????"> ??????</label>';
			htmlCont += '          	</td>';
			htmlCont += '       </tr>';
			htmlCont += '       <tr>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
			htmlCont += '       	<td>';
			htmlCont += '       		<input type="text" name="re1name" id="re1name_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
			htmlCont += '       	<td>';
			htmlCont += '       		<input type="text" name="re1aname" id="re1aname_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       </tr>';
			htmlCont += '       <tr>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
			htmlCont += '       	<td colspan="3">';
			htmlCont += '       		<input type="text" name="re1date" id="re1date_'+year+'_'+ScCnt+'" readonly value="" class="inp_txt read_only" />';
			htmlCont += '       	</td>';
			htmlCont += '       </tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t1_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t1_"+year).append(htmlCont);
			
			$("input[name='re1date']").datepicker({
		       	showMonthAfterYear : true,
		       	changeMonth : true,
		       	changeYear : true,
		       	dateFormat : "yy-mm-dd",
		       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		       	dayNamesMin : ['???','???','???','???','???','???','???'],
		       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
		
		}else if(mode == "se"){ //??????????????????
			
			var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t2_"+year).find('select[name=setype]:last').val() == ""){
					alert("??????/??????????????? ???????????????");
					$("#resultInfo_t2_"+year).find('select[name=setype]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="senumber"]:last').val() == ""){
					alert("????????????(????????????)??? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="senumber"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sedate"]:last').val() == ""){
					alert("?????????(?????????)??? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="sedate"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sename"]:last').val() == ""){
					alert("????????????????????? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="sename"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sesetdate"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="sesetdate"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_se" value="'+ScCnt+'">';
	      	htmlCont += '      	<input type="hidden" name="se_idx" value="">';
	      	htmlCont += '		<select class="select_box" name="setype">';
	      	htmlCont += '			<option value="">::??????::</option>';
	      	<%
			for(HashMap rs:applicationList){
			%>
			htmlCont += '			<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>';
			<% 
			}
			%>
	      	
	      	htmlCont += '		</select>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="senumber" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt read_only" name="sedate" readonly value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sename" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sesetdate" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t2_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t2_"+year).append(htmlCont);
			
			$("input[name='sedate']").datepicker({
		       	showMonthAfterYear : true,
		       	changeMonth : true,
		       	changeYear : true,
		       	dateFormat : "yy-mm-dd",
		       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		       	dayNamesMin : ['???','???','???','???','???','???','???'],
		       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
			
		}else if(mode == "tech"){ //??????????????????
			
			var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t3_"+year).find('select[name=tetype]:last').val() == ""){
					alert("????????????????????? ???????????????");
					$("#resultInfo_t3_"+year).find('select[name=tetype]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="teprice"]:last').val() == ""){
					alert("???????????? ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="teprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="te_nprice"]:last').val() == ""){
					alert("?????????????????? ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="te_nprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="tenname"]:last').val() == ""){
					alert("????????????(??????) ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="tenname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="tegname"]:last').val() == ""){
					alert("????????????(??????) ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="tegname"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_tech" value="'+ScCnt+'">';
	      	htmlCont += '      	<input type="hidden" name="tech_idx" value="">';
	      	htmlCont += '		<select class="select_box" name="tetype">';
	      	htmlCont += '			<option value="">::??????::</option>';
	      	<%
			for(HashMap rs:technologyList){
			%>
			htmlCont += '			<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>';
			<% 
			}
			%>
	      	
	      	htmlCont += '		</select>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<label><input type="radio" name="tetype1_'+ScCnt+'" value="??????/??????" checked="checked"> ??????/??????</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="????????????"> ????????????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <label><input type="radio" name="tetype2_'+ScCnt+'" value="???????????????" checked="checked"> ???????????????</label>';
			htmlCont += '       <label><input type="radio" name="tetype2_'+ScCnt+'" value="???????????????"> ???????????????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="teprice" value=""/>(??????:?????????)';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="te_nprice" value="" onkeyup="commaCheck(this)"/>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="tenname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="tegname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t3_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t3_"+year).append(htmlCont);
			
		}else if(mode == "bus"){ //??????????????????????????????
			
			var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t4_"+year).find('input[name=busname]:last').val() == ""){
					alert("???????????????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name=busname]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busstatus"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name="busstatus"]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busprice"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name="busprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busnum"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name="busnum"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '	<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_bus" value="'+ScCnt+'">';
	      	htmlCont += '      	<input type="hidden" name="bus_idx" value="">';
	      	htmlCont += '      	<label><input type="radio" name="bustype1_'+ScCnt+'" value="?????????" checked="checked"> ?????????</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="??????"> ??????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <input type="text" class="inp_txt" name="busname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busstatus" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busprice" value="" />(??????:?????????)';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busnum" value="" />(1???/EA)';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(??????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="hidden" class="inp_txt" name="bustotprice" value="" />';
	      	htmlCont += '		<span class="bustotprice"></span>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t4_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t4_"+year).append(htmlCont);
			
		}else if(mode == "pps"){
			
			
			var cnt = $("#resultInfo_t5_"+year).find('input[name=chk_pps]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t5_"+year).find('input[name=ppsname]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name=ppsname]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsxname"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name="ppsxname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('select[name="ppstype"]:last').val() == ""){
					alert("??????/????????? ???????????????");
					$("#resultInfo_t5_"+year).find('select[name="ppstype"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsnum"]:last').val() == ""){
					alert("????????????(????????????)??? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name="ppsnum"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsdate"]:last').val() == ""){
					alert("?????????(?????????)??? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name="ppsdate"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_pps" value="'+ScCnt+'">';
	      	htmlCont += '      	<input type="hidden" name="pps_idx" value="">';
	      	htmlCont += '      	<label><input type="radio" name="ppstype1_'+ScCnt+'" value="???????????????(??????)??????" checked="checked">???????????????(??????)??????</label>';
			htmlCont += '       <label><input type="radio" name="ppstype1_'+ScCnt+'" value="???????????????(??????)??????">???????????????(??????)??????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;">*</span> ????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <input type="text" class="inp_txt" name="ppsname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsxname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<select class="select_box" name="ppstype">';
	      	htmlCont += '			<option value="">::??????::</option>';
	      	<%
			for(HashMap rs:applicationList){
			%>
			htmlCont += '			<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>';
			<% 
			}
			%>
	      	
	      	htmlCont += '		</select>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsnum" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt read_only" readonly name="ppsdate" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t5_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t5_"+year).append(htmlCont);
			
			$("input[name='ppsdate']").datepicker({
		       	showMonthAfterYear : true,
		       	changeMonth : true,
		       	changeYear : true,
		       	dateFormat : "yy-mm-dd",
		       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		       	dayNamesMin : ['???','???','???','???','???','???','???'],
		       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
			
		}
		
	}
	
	$(document).on("click","input[name^='tetype2_']",function(){
		var code = $(this).val();
		if(code == "???????????????"){
			$(this).parents(".skin_basic_write").find("input[name='teprice']").val("");
		}else{
			$(this).parents(".skin_basic_write").find("input[name='teprice']").val("????????????3%");
		}
	});
	
	
	
	
	
	
	
	function delResultRow(mode,year){
		
		if(mode == "info"){
			var typex = $("#resultInfo_t1_"+year).find('table:last').data("type");
			if(typex != "on"){
				var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
				var delCnt = cnt-1;
				
				if(delCnt == 0){
					$("#resultInfo_t1_"+year).html('<div class="hideBox_n">+????????? ????????? ??????????????? ???????????????</div>');
				}
				$("#resultInfo_t1_"+year).find(".info"+cnt).remove();
			}
			
		}else if(mode == "se"){
			
			var se_type = $("#resultInfo_t2_"+year).find('table:last').data("type");
			if(se_type != "on"){
				var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
				var delCnt = cnt-1;
				
				if(delCnt == 0){
					$("#resultInfo_t2_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????? ???????????????</div>');
				}
				$("#resultInfo_t2_"+year).find(".info"+cnt).remove();
			}
			
		}else if(mode == "tech"){
			
			var tech_type = $("#resultInfo_t3_"+year).find('table:last').data("type");
			if(tech_type != "on"){
				var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
				var delCnt = cnt-1;
				if(delCnt == 0){
					$("#resultInfo_t3_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????? ???????????????</div>');
				}
				$("#resultInfo_t3_"+year).find(".info"+cnt).remove();
			}
			
		}else if(mode == "bus"){
			
			var bus_type = $("#resultInfo_t4_"+year).find('table:last').data("type");
			if(bus_type != "on"){
				var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
				var delCnt = cnt-1;
				if(delCnt == 0){
					$("#resultInfo_t4_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????????????????? ???????????????</div>');
				}
				$("#resultInfo_t4_"+year).find(".info"+cnt).remove();
			}
			
		}else if(mode == "pps"){
			
			var pps_type = $("#resultInfo_t5_"+year).find('table:last').data("type");
			if(pps_type != "on"){
				var cnt = $("#resultInfo_t5_"+year).find('input[name=chk_pps]').size();
				var delCnt = cnt-1;
				if(delCnt == 0){
					$("#resultInfo_t5_"+year).html('<div class="hideBox_n">+????????? ????????? ???????????????????????? ???????????????</div>');
				}
				$("#resultInfo_t5_"+year).find(".info"+cnt).remove();
			}
			
		}
	}
	
	
	$(document).on("change","input[name='retype']",function(){
		if($(this).val() == "??????"){
			$(".mm").hide();
			$(".gg").show();
			$(this).parents(".result_content").find("input[name='reprice']").prop("disabled",true);
			$(this).parents(".result_content").find("input[name='reperson']").prop("disabled",false);
		}else if($(this).val() == "??????"){
			$(".mm").show();
			$(".gg").hide();
			$(this).parents(".result_content").find("input[name='reprice']").prop("disabled",false);
			$(this).parents(".result_content").find("input[name='reperson']").prop("disabled",true);
		}else{
			$(".mm").show();
			$(".gg").show();
			$(this).parents(".result_content").find("input[name='reprice']").prop("disabled",false);
			$(this).parents(".result_content").find("input[name='reperson']").prop("disabled",false);
		}
	});
	
	
	
	
	$("input[name='re1date'], input[name='sedate'], input[name='ppsdate']").datepicker({
       	showMonthAfterYear : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	onClose: function(dateText, inst) {
                        
        }
	});
	
	$(document).on("click","input[name='nptype2']",function(){
		if($(this).val() == "?????????"){
			$(this).parents(".ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",true);
		}else{
			$(this).parents(".ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",false);
		}
	});
	
	
	


</script>