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
	
	
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	
	ArrayList<HashMap<String, String>> m1PriceList = request.getAttribute("m1PriceList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1PriceList");
	ArrayList<HashMap<String, String>> m1ResultData = request.getAttribute("m1ResultData") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultData");

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
.submitBtn{margin:50px auto 30px; border:1px solid #ddd; background:#498944; color:#fff; padding:10px 30px; display:block; font-size:14px;}
.addPriceInfo{margin:50px auto 30px; border:1px solid #ddd; background:#498944; color:#fff; padding:10px 30px; display:block; width:100px; text-align:center; font-size:14px; float:unset;}
.addPriceInfo_off{margin:50px auto 30px; border:1px solid #ddd; background:#f7f7f7; color:#999; padding:10px 30px; display:block; width:100px; text-align:center; font-size:14px; float:unset;}
</style>

<jsp:useBean id="currTime" class="java.util.Date" />


<div class="skin_bbs_write" style="margin-top: 30px">
	
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
           			<%=util.getStr(dataMap.get("M_CODE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">R&D?????? ??????</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("M_TYPE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">????????????</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("B_TYPE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">??????????????????</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("C_TYPE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">????????????(???)???</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("M_NAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">??????(?????????)?????????</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("M_BNAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">?????????</th>
           		<td colspan="3">
           			<%=util.getStr(dataMap.get("H_NAME"))%>
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
	         		<th scope="row" class="tit">???????????????</th>
	         		<td>
	         			<%=util.getStr(String.valueOf(dataMap.get("M_SDATE")))%>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">???????????????</th>
	         		<td>
	         		<%	
	         			if(util.getStr(dataMap.get("M_ING")).equals("1")){
	         				out.println("????????????");
	         			}else{
	         				out.println(util.getStr(String.valueOf(dataMap.get("M_EDATE"))));
	         			}
	         		%>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">????????????(??????)</th>
	         		<td>
	         			<%=util.getStr(String.valueOf(dataMap.get("M_MONTH")))%>??????
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
	
	</div>
    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="????????????" data-idx="<%=util.getStr(String.valueOf(dataMap.get("IDX")))%>"/>
           <input type="button" class="btn_inp_w_01" value="??????"/>
    </div>
    <!--// bo_btn -->



<div style="padding-top:15px"></div>




<div id="ncontentBox" style="clear:both;">
	
	<h2 class="tit">?????????????????????</h2>
	<div class="zoom"></div>
	
	<%
	int ii = 0;
	if(m1PriceList.size() > 0){
	for(HashMap pr:m1PriceList){
		if(util.getStr(pr.get("NP_SET")) != "1"){
			
			ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList"+ii) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList"+ii);
			
	%>
	
	<div id="ncontent<%=util.getStr(pr.get("NP_YEAR"))%>" class="ncontent">
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
		          		<th scope="row" class="tit">??????????????????</th>
		          		<td colspan="3">
		          			<%=util.getStr(pr.get("NP_YEAR"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_TYPE1"))%>
		          		</td>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_TYPE2"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">??????/??????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_TYPE3"))%>
		          		</td>
		          		<th scope="row" class="tit">????????????<br>(?????? : ?????????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_TPRICE"))%> 
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">??????<br>(?????? : ?????????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_PRICE1"))%>
		          		</td>
		          		<th scope="row" class="tit">??????<br>(?????? : ?????????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_PRICE2"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">?????????<br>(?????? : ?????????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_PRICE3"))%>
		          		</td>
		          		<th scope="row" class="tit">??????<br>(?????? : ?????????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_PRICE4"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">???<br>(?????? : ?????????)</th>
		          		<td colspan="3">
		          			<%=util.getStr(pr.get("NP_PRICE5"))%>
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
		          		<th scope="row" class="tit">??????????????????????????????</th>
		          		<td>
		          			<%=(util.getStr(pr.get("NP_FTYPE1")).equals("yes"))?"??????":"?????????"%>
		          		</td>
		          		<th scope="row" class="tit">NTIS</th>
		          		<td>
		          			<%=(util.getStr(pr.get("NP_FTYPE2")).equals("yes"))?"??????":"?????????"%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">?????????</th>
		          		<td>
		          			<%=(util.getStr(pr.get("NP_FTYPE3")).equals("yes"))?"??????":"?????????"%>
		          		</td>
		          		<th scope="row" class="tit">?????????</th>
		          		<td>
		          			<%=(util.getStr(pr.get("NP_FTYPE4")).equals("yes"))?"??????":"?????????"%>
		          		</td>
		          	</tr>
		          	<%
		          	String fileNm[] = {"??????????????? ????????????", "??????????????????????????????<br>??????????????????", "??????????????????"};
		          	
					Map<Integer, Object> file = new  HashMap<Integer, Object>();
			        
			        if(fileList.size() == 1){
			        	
			        	file.put(0,fileList.get(0));
			        	file.put(1,null);
			        	file.put(2,null);
			        	
			        }else if(fileList.size() == 2){
			        	
			        	file.put(0,fileList.get(0));
			        	file.put(1,fileList.get(1));
			        	file.put(2,null);
			        	
			        }else if(fileList.size() == 3){
			        	
			        	file.put(0,fileList.get(0));
			        	file.put(1,fileList.get(1));
			        	file.put(2,fileList.get(2));
			        }
		          	
		          	if(fileList.size() > 0){
		          		String fileParamB = "";
		          		for(int xx = 0; xx<fileNm.length; xx++){
		          			if(file.get(xx) != null){
		          				
		          				fileParamB = "?dataGrp="+util.getStr(fileList.get(xx).get("DATA_GRP"))
		    					+"&amp;fileId="+util.getStr(String.valueOf(fileList.get(xx).get("FILE_ID")))
		    					+"&amp;dataIdx="+util.getStr(fileList.get(xx).get("DATA_IDX"));
		          			
		          	%>
		          	<tr>
		          		<th scope="row" class="tit"><%=fileNm[xx]%></th>
		          		<td colspan="3">
		          			???????????? <%=xx+1%> :
		          			<a href="/cmm/fms/ComFileDown.do<%=fileParamB%>">
		          			<%=util.getStr(fileList.get(xx).get("TITLE_ORG"))%> (<%=util.getStr(fileList.get(xx).get("FILE_SIZE")) %> Byte)[????????????]
		          			</a>
		          		
		          		</td>
		          	</tr>
		          	<%
		          			}else{
		          	%>
		          	<tr>
		          		<th scope="row" class="tit"><%=fileNm[xx]%></th>
		          		<td colspan="3">
		          		
		          			-
		          		
		          		</td>
		          	</tr>
		          	<%			
		          			}
		          		}
		          	}
		          	%>
		          	
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
		          		<th scope="row" class="tit">????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT1"))%>
		          		</td>
		          		<th scope="row" class="tit">????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT2"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT3"))%>
		          		</td>
		          		<th scope="row" class="tit">????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT4"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">?????????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OCODE"))%>
		          		</td>
		          		<th scope="row" class="tit">????????????(??????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT6"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">??????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT7"))%>
		          		</td>
		          		<th scope="row" class="tit">?????????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT8"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">??????????????? ????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT9"))%>
		          		</td>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_OTEXT10"))%>
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
		          		<th scope="row" class="tit">????????????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT1"))%>
		          		</td>
		          		<th scope="row" class="tit">??????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT2"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">????????????????????????(??????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT3"))%>
		          		</td>
		          		<th scope="row" class="tit">????????????????????????(?????????)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT4"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">????????????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT5"))%>
		          		</td>
		          		<th scope="row" class="tit">6T??????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT6"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">????????????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT7"))%>
		          		</td>
		          		<th scope="row" class="tit">????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_WTEXT8"))%>
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
		          			<%=util.getStr(pr.get("NP_XTEXT1"))%>
		          		</td>
		          		<th scope="row" class="tit">??????(???)</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_XTEXT2"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_XTEXT3"))%>
		          		</td>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_XTEXT4"))%>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th scope="row" class="tit">???????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_XTEXT5"))%>
		          		</td>
		          		<th scope="row" class="tit">?????????????????????</th>
		          		<td>
		          			<%=util.getStr(pr.get("NP_XTEXT6"))%>
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
		          			<textarea name="xcomment" id="xcomment" class="inp_txt" rows="5" style="width:100%;"><%=util.getStr(pr.get("XCOMMENT"))%></textarea>
		          		</td>
		          	</tr>      	
		   	</tbody>
		</table>
		
		</form>
		
	</div>
	
	<div style="padding-top:15px"></div>
	
	
	<%
		}
		ii++;
	} //for end
	}else{
	%>
	
	<div class="hideBox">
		????????? ???????????????.
	</div>
	<%
	}
	%>
	
		
</div>
<div style="padding-top:15px"></div>


<div id="resultBox" style="clear:both;">
	
	<h2 class="tit">????????????</h2>
	<div class="zoom"></div>
	
	<%
	int kk = 0;
	if(m1ResultData.size() > 0){
	for(HashMap re:m1ResultData){
		if(!util.getStr(re.get("RE_SET")).equals("1")){
			
			ArrayList<HashMap<String, String>> m1ResultInfo = request.getAttribute("m1ResultInfo_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultInfo_"+kk);
			ArrayList<HashMap<String, String>> m1ResultSe = request.getAttribute("m1ResultSe_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultSe_"+kk);
			ArrayList<HashMap<String, String>> m1ResultTech = request.getAttribute("m1ResultTech_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultTech_"+kk);
			ArrayList<HashMap<String, String>> m1ResultBus = request.getAttribute("m1ResultBus_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultBus_"+kk);
			ArrayList<HashMap<String, String>> m1ResultPps = request.getAttribute("m1ResultPps_"+kk) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("m1ResultPps_"+kk);
			
	%>
	
	<div id="result_content<%=util.getStr(re.get("RE_YEAR"))%>" class="result_content">
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
		          		<th scope="row" class="tit">??????????????????</th>
		          		<td colspan="3">
		          			<%=util.getStr(re.get("RE_YEAR"))%>
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
		          		<th scope="row" class="tit">??????????????????</th>
		          		<td colspan="3">
		          			<%=util.getStr(re.get("RE_TYPE"))%>
		          		</td>
		          	</tr>
		          	<% if(util.getStr(re.get("RE_TYPE")).equals("??????") || util.getStr(re.get("RE_TYPE")).equals("??????/??????")){ %>
		          	<tr>
		          		<th scope="row" class="tit">??????</th>
		          		<td colspan="3">
		          			<%=util.getStr(re.get("RE_PERSON"))%>???
		          		</td>
		          	</tr>
		          	<% } %>
		          	<% if(util.getStr(re.get("RE_TYPE")).equals("??????") || util.getStr(re.get("RE_TYPE")).equals("??????/??????")){ %>
		          	<tr>
		          		<th scope="row" class="tit">??????</th>
		          		<td colspan="3">
		          			<%=util.setFormatNum(String.valueOf(re.get("RE_PRICE")), "comma") %>
		          		</td>
		          	</tr>
		          	<% } %>		          	
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
		          			<textarea name="recomment" class="inp_txt" rows="3" style="min-width:80%"><%=util.getStr(re.get("RE_COMMENT"))%></textarea>
		          		</td>
		          	</tr>          	
		   	</tbody>
		</table>
		
		<% if(m1ResultInfo.size() > 0){ %>
		<h3 class="tit"> - <%=util.getStr(re.get("RE_YEAR"))%>??? ????????????</h3>
		<div class="zoom_x"></div>
		<div id="resultInfo_t1_<%=util.getStr(re.get("RE_YEAR"))%>">
		<%
		for(HashMap in:m1ResultInfo){
		%>
			<table class="skin_basic_write">
				<caption>????????????</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
			   <tbody>
				  	<tr>
			      		<th scope="row" class="tit">????????????</th>
			      		<td colspan="3">
			      			<%=util.getStr(in.get("R_TYPE")) %>
			          	</td>
			       </tr>
			       <tr>
			       	<th scope="row" class="tit">?????????</th>
			       	<td>
			       		<%=util.getStr(in.get("R_NAME")) %>
			       	</td>
			       	<th scope="row" class="tit">????????????</th>
			       	<td>
			       		<%=util.getStr(in.get("R_ANAME")) %>
			       	</td>
			       </tr>
			       <tr>
			       	<th scope="row" class="tit">?????????</th>
			       	<td colspan="3">
			       		<%=util.getStr(String.valueOf(in.get("R_DATE"))) %>
			       	</td>
			       </tr>
			   </tbody>
			</table>
		<% } %>
		</div>
		<% } %>
		
		<% if(m1ResultSe.size() > 0){ %>
		<h3 class="tit"> - <%=util.getStr(re.get("RE_YEAR"))%>??? ??????????????????</h3>
		<div class="zoom_x"></div>
		<div id="resultInfo_t2_<%=util.getStr(re.get("RE_YEAR"))%>">
		<% for(HashMap se:m1ResultSe){ %>
			<table class="skin_basic_write">
				<caption>??????????????????</caption>
			       <colgroup>
				       <col style="width:20%" />
			          <col style="width:30%" />
			          <col style="width:20%" />
			          <col style="width:30%" />
			       </colgroup>
			   <tbody>
			<tr>
	      		<th scope="row" class="tit">??????/????????????</th>
	      		<td colspan="3">
	      	      	<%=util.getStr(se.get("SE_TYPE"))%>	      			
	      		</td>
	      	</tr>
	      	<tr>
	      		<th scope="row" class="tit">????????????(????????????)</th>
	      		<td>
	      			<%=util.getStr(String.valueOf(se.get("SE_NUMBER")))%>	
	      		</td>
	      		<th scope="row" class="tit">?????????(?????????)</th>
	      		<td>
	      			<%=util.getStr(String.valueOf(se.get("SE_DATE")))%>
	      		</td>
	      	</tr>
	      	<tr>
	      		<th scope="row" class="tit">??????????????????</th>
	      		<td>
	      			<%=util.getStr(se.get("SE_NAME"))%>
	      		</td>
	      		<th scope="row" class="tit">????????????</th>
	      		<td>
	      			<%=util.getStr(String.valueOf(se.get("SE_SETDATE")))%>
	      		</td>
	      	</tr>
			   </tbody>
			</table>
		<% } %>
		</div>
		<% } %>
		
		<% if(m1ResultTech.size() > 0){ %>
		<h3 class="tit"> - <%=util.getStr(re.get("RE_YEAR"))%>??? ??????????????????</h3>
		<div class="zoom_x"></div>
		<div id="resultInfo_t3_<%=util.getStr(re.get("RE_YEAR"))%>">
		<% for(HashMap te:m1ResultTech){ %>
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
	      		<th scope="row" class="tit">??????????????????</th>
	      		<td colspan="3">
	      	      	<%=util.getStr(te.get("TE_TYPE"))%>	      			
	      		</td>
	      	</tr>
	      	<tr>
	      		<th scope="row" class="tit">????????????</th>
	      		<td colspan="3">
	      	      	<%=util.getStr(te.get("TE_TYPE1"))%>
	      		</td>
	      	</tr>
	      	<tr>
	      		<th scope="row" class="tit">?????????????????????</th>
	      		<td colspan="3">
	      	       <%=util.getStr(te.get("TE_TYPE2"))%>
	      		</td>
	      	</tr>
	      	<tr>
	      		<th scope="row" class="tit">?????????</th>
	      		<td>
	      			<%=util.getStr(te.get("TE_PRICE"))%>
	      		</td>
	      		<th scope="row" class="tit">???????????????</th>
	      		<td>
	      			<%=util.setFormatNum(String.valueOf(te.get("TE_NPRICE")), "comma") %>
	      		</td>
	      	</tr>
	      	<tr>
	      		<th scope="row" class="tit">????????????(??????)</th>
	      		<td>
	      			<%=util.getStr(te.get("TE_NNAME"))%>
	      		</td>
	      		<th scope="row" class="tit">????????????(??????)</th>
	      		<td>
	      			<%=util.getStr(te.get("TE_GNAME"))%>
	      		</td>
	      	</tr>
			   </tbody>
			</table>
		<% } %>
		</div>
		<% } %>
		
		<% if(m1ResultBus.size() > 0){ %>
		<h3 class="tit"> - <%=util.getStr(re.get("RE_YEAR"))%>??? ??????????????????????????????</h3>
		<div class="zoom_x"></div>
		<div id="resultInfo_t4_<%=util.getStr(re.get("RE_YEAR"))%>">
		<% for(HashMap bu:m1ResultBus){ %>
			<table class="skin_basic_write info'+ScCnt+'" >
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
	      	      	<%=util.getStr(bu.get("BUS_TYPE"))%>
	      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>
		      		<td colspan="3">
		      	       <%=util.getStr(bu.get("BUS_NAME"))%>
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<%=util.getStr(bu.get("BUS_STATUS"))%>
		      		</td>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<%=util.setFormatNum(String.valueOf(bu.get("BUS_PRICE")), "comma") %>
		      		</td>
		      	</tr>
		      	<tr>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
		      		<td>
		      			<%=util.setFormatNum(String.valueOf(bu.get("BUS_NUM")), "comma") %>
		      		</td>
		      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(??????)</th>
		      		<td>
		      			<%=util.setFormatNum(String.valueOf(bu.get("BUS_TOTPRICE")), "comma") %>
		      		</td>
		      	</tr>
			   </tbody>
			</table>
		<% } %>
		</div>
		<% } %>
		
		<% if(m1ResultPps.size() > 0){ %>
		<h3 class="tit"> - <%=util.getStr(re.get("RE_YEAR"))%>??? ?????????????????????</h3>
		<div class="zoom_x"></div>		
		<div id="resultInfo_t5_<%=util.getStr(re.get("RE_YEAR"))%>">
		<% for(HashMap ps:m1ResultPps){ %>	
		
			<table class="skin_basic_write" >
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
			      	      	<%=util.getStr(ps.get("PPS_TYPE1"))%>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;">*</span> ????????????</th>
			      		<td colspan="3">
			      	    	<%=util.getStr(ps.get("PPS_NAME"))%>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
			      		<td>
			      			<%=util.getStr(ps.get("PPS_XNAME"))%>
			      		</td>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>
			      		<td>
			      			<%=util.getStr(ps.get("PPS_TYPE"))%>
			      		</td>
			      	</tr>
			      	<tr>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>
			      		<td>
			      			<%=util.setFormatNum(String.valueOf(ps.get("PPS_NUM")), "comma") %>
			      		</td>
			      		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>
			      		<td>
			      			<%=util.getStr(String.valueOf(ps.get("PPS_DATE")))%>
			      		</td>
			      	</tr>
			   </tbody>
			</table>
			
		<% } %>
		</div>
		<% } %>
		
		
		
		
		
		
	</div>
	
	<%
		}
		kk++;
	} //for end
	}else{
	%>
	
	<div class="hideBox">
		????????? ???????????????.
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
	
	var sDateYear = 0;
	var eDateYear = 0;
	var yearOption = "";
	
	
	
	
	

	function goSubmit(mode,proState){
		$('#proState').val(proState);
		$('#mode').val(mode);
		
		var formData = new FormData($("#fwrite")[0]);
		
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
            		
            		alert("??????????????? ?????????????????????.\n??????????????? ????????? ?????????.");
            		var midx = data.paramMap.midx;
            		
            		for(var y=sDateYear; y<=eDateYear; y++){
            			
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
            		}
            		
            		
            		$("#ncontentBox").show();
        			$(".hideBox").hide();
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
    }
	
	
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



$(document).on("click",".btn_inp_b_01",function(){	
	
	var idx = $(this).data("idx");
	location.href="/sys/sys_jnrd_m1.do?mode=modify&IDX="+idx;
	
	
});



$(document).on("click",".btn_inp_w_01",function(){	
	location.href="/sys/sys_jnrd_m1.do";
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
            
            //??????????????????
            $.ajax({
	            type: "POST",
	            data: {year:year},
	            url : '/sys/jntisJnrdM1Ajax.do',
	            dataType : 'json',
	            success : function(data){	            	
	            	if(data.dataList != null){
	            		xNum = String(data.dataList.IDX).padStart(5,"0");
	            		$("#MCODE").val("JNR-"+year+"-"+xNum);
	            	}else{
	            		$("#MCODE").val("JNR-"+year+"-00001");
	            	}           		
	            }
   			});            
        }
	});
	
	var toDate = new Date();
	var toDateYear = toDate.getFullYear();
	
	
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
			//$(this).prop("disabled",false);
			
		}else{
			
			/* ???????????? ????????? */
			$(this).parents("div.ncontent").find("input").not(this).prop("disabled",false);
			$(this).parents("div.ncontent").find("option").attr("disabled",false);
			$(this).parents("div.ncontent").find("textarea").attr("disabled",false);
			
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
	
	/*
	var ncontentNum = 1;
	
	function addRow(mode){
		
		$.ajax({
            cache : false,
            url : "/sys/sysJnrd_ncontentAjax.do", // ?????????
            type : 'POST', 
            data : {num:ncontentNum},
            dataType : 'HTML',
            success : function(data) {
            	
            	$("#ncontentBox").append(data);
            	
            	for(var y=sDateYear; y<=eDateYear; y++){
        			yearOption += "<option>"+y+"</option>";
        		}
            	$("#ncontent"+ncontentNum).find("#npyear"+ncontentNum).append(yearOption);
            	ncontentNum ++;
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
	}*/
	
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
		
		$(".ncontent:last").remove();
		ncontentNum --;
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
		
		var totP = parseInt(npp1)+parseInt(npp2);
		$(this).parents(".skin_basic_write").find("input[name='bustotprice']").val(totP);
		$(this).parents(".skin_basic_write").find(".bustotprice").text(totP);
		
	});
	
	
	
	$(document).on("click",".submitBtn",function (){
		var f = $(this).parents(".result_content").find("form")[0];
		var formData = new FormData(f);
		var $this = $(this);
			
		if(formData.get("reperson") == ""){
			alert("??????????????? ???????????????");
			$(this).parents(".result_content").find("#reperson").focus();
			return false;
		}
		if(formData.get("reprice") == ""){
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
	
	
	
	$(document).on("click",".addPriceInfo",function(){
		var year = $(this).data("year");
		var formData = new FormData($("#ncontForm_"+year)[0]);
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
		var $this = $(this);
		
		if($(this).parents(".ncontent").find("input[name='npset']").is(":checked")){
			
			
			
			
		}else{
		
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
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File1").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File1").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File2").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File2").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File3").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File3").val() == ""){
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
			
			var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
			var delCnt = cnt-1;
			
			if(delCnt == 0){
				$("#resultInfo_t1_"+year).html('<div class="hideBox_n">+????????? ????????? ??????????????? ???????????????</div>');
			}
			$("#resultInfo_t1_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "se"){
			
			var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
			var delCnt = cnt-1;
			
			if(delCnt == 0){
				$("#resultInfo_t2_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t2_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "tech"){
			//ddddddddddddd
			var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t3_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t3_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "bus"){
			
			var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t4_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t4_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "pps"){
			
			var cnt = $("#resultInfo_t5_"+year).find('input[name=chk_pps]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t5_"+year).html('<div class="hideBox_n">+????????? ????????? ???????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t5_"+year).find(".info"+cnt).remove();
			
		}
	}


</script>