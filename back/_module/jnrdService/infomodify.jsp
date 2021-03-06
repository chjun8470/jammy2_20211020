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
       
       HashMap<String, String> infoData = request.getAttribute("infoData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("infoData");
       ArrayList<HashMap<String, String>> infoBusinessList = request.getAttribute("infoBusinessList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("infoBusinessList");
       
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

       int scCnt = infoBusinessList.size();
       
       
       
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
	
	<input type="hidden" name="info_idx" value="<%=util.getStr(String.valueOf(paramMap.get("idx")))%>">
	
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
           			<input type="text" name="code" id="CODE" value="<%=util.getStr(infoData.get("CODE")) %>" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)??????</th>
           		<td colspan="3">
           			<label><input type="radio" name="typeA" value="??????R&D" <%=(util.getStr(infoData.get("TYPE_A")).equals("??????R&D") || util.getStr(infoData.get("TYPE_A")).equals(""))?"checked":""%>> ??????R&D</label>
           			<label><input type="radio" name="typeA" value="??????R&D" <%=(util.getStr(infoData.get("TYPE_A")).equals("??????R&D"))?"checked":""%>> ??????R&D</label>
           			<label><input type="radio" name="typeA" value="?????????R&D" <%=(util.getStr(infoData.get("TYPE_A")).equals("?????????R&D"))?"checked":""%>> ?????????R&D</label>
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
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("CNAME")).equals(util.getStr(sup.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(?????????)?????????</th>
           		<td>
           			<input type="text" name="bname" id="BNAME" class="inp_txt" value="<%=util.getStr(infoData.get("BNAME")) %>"/>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)???</th>
           		<td>
           			<input type="text" name="baname" id="B_ANAME" class="inp_txt" value="<%=util.getStr(infoData.get("B_ANAME")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td colspan="3">
           			?????? : <input type="text" name="sdate" id="S_DATE" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("S_DATE"))) %>"/>
           			?????? : <input type="text" name="edate" id="E_DATE" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("E_DATE"))) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="btprice" id="B_TPRICE" class="inp_txt" value="<%=util.getStr(String.valueOf(infoData.get("B_TPRICE"))) %>"/>(??????:100??????)
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td>
           			<label><input type="radio" name="yeartype" value="????????????" <%=(util.getStr(infoData.get("YEAR_TYPE")).equals("????????????") || util.getStr(infoData.get("YEAR_TYPE")).equals(""))?"checked":""%>> ????????????</label>
           			<label><input type="radio" name="yeartype" value="????????????" <%=(util.getStr(infoData.get("YEAR_TYPE")).equals("????????????"))?"checked":""%>> ????????????</label>
           			<label><input type="radio" name="yeartype" value="??????????????????" <%=(util.getStr(infoData.get("YEAR_TYPE")).equals("??????????????????"))?"checked":""%>> ??????????????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)????????????</th>
           		<td colspan="3">
           			<label><input type="checkbox" name="bch1" value="????????????" <%=(util.getStr(infoData.get("B_CH")).contains("????????????"))?"checked":""%>> ????????????</label>
           			<label><input type="checkbox" name="bch2" value="NTIS" <%=(util.getStr(infoData.get("B_CH")).contains("NTIS"))?"checked":""%>> NTIS</label>
           			<label><input type="checkbox" name="bch3" value="?????????" <%=(util.getStr(infoData.get("B_CH")).contains("?????????"))?"checked":""%>> ?????????</label>
           			<label><input type="checkbox" name="bch4" value="?????????" <%=(util.getStr(infoData.get("B_CH")).contains("?????????"))?"checked":""%>> ?????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)????????????</th>
           		<td colspan="3">
           			?????? : <input type="text" name="bsd" id="B_SD" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("B_SD"))) %>"/>
           			?????? : <input type="text" name="bed" id="B_ED" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(infoData.get("B_ED"))) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)?????????</th>
           		<td colspan="3">
           		<%
           		String fileParam = "?dataGrp="+util.getStr(fileList.get(0).get("DATA_GRP"))+"&amp;fileId="+util.getStr(String.valueOf(fileList.get(0).get("FILE_ID")))+"&amp;dataIdx="+util.getStr(fileList.get(0).get("DATA_IDX"));
           		%>
           			<input type="hidden" name="fileSn" value="1">
           			<input type="hidden" name="fileFlog" value="">
           			<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????"  data-fileid="<%=util.getStr(String.valueOf(fileList.get(0).get("FILE_ID"))) %>" data-filesn="1"/>
           			????????????  :
           			<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(fileList.get(0).get("TITLE_ORG"))%> (<%=util.getComma(util.getStr(fileList.get(0).get("FILE_SIZE"))) %> Byte)</a>
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
	<fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
	<%
	int ibNum = 0;
	for(HashMap ib:infoBusinessList){
		pageContext.setAttribute("bisyear", util.getStr(ib.get("BIS_YEAR")));
		int ibCount = ibNum + 1;
	%>
	
  		<table class="skin_basic_write" id="businesslist_cont_<%=ibNum%>" data-type="on">
  			<input type="hidden" name="checkNum" value="<%=ibCount%>">
  			<input type="hidden" name="bid" value="<%=util.getStr(String.valueOf(ib.get("IDX")))%>">
  			<caption>????????????(??????)??????</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr >
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
	         		<td>
	         			
	         			<select name="bisyear" id="BIS_YEAR_<%=ibNum%>" class="select_box">
	         				<option value="">:::??????:::</option>
	         				<c:forEach var="i" begin="2018" end="${currTime}">
	            			<option value="${i}" <c:if test="${i eq bisyear}">selected</c:if>>${i}</option>
	            			</c:forEach>
	         			</select>
	         			
	         			<%-- <label><input type="checkbox" name="delCode" value="<%=util.getStr(String.valueOf(ib.get("IDX")))%>">[??????]</label> --%>
	         			
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">???????????? ????????????</th>
	         		<td>
	         			?????? : <input type="text" name="bissdate" id="BIS_SDATE_<%=ibNum%>" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(ib.get("BIS_SDATE")))%>"/>
	          			?????? : <input type="text" name="bisedate" id="BIS_EDATE_<%=ibNum%>" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(ib.get("BIS_EDATE")))%>"/>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
	         		<td>
	         			<label><input type="radio" name="bistype_<%=ibNum%>" id="" value="????????????" <%=(util.getStr(ib.get("BIS_TYPE")).equals("????????????") || util.getStr(dataMap.get("BIS_TYPE")).equals(""))?"checked":""%>> ????????????</label>
	           			<label><input type="radio" name="bistype_<%=ibNum%>" id="" value="????????????" <%=(util.getStr(ib.get("BIS_TYPE")).equals("????????????"))?"checked":""%>> ????????????</label>
	           			<label><input type="radio" name="bistype_<%=ibNum%>" id="" value="??????" <%=(util.getStr(ib.get("BIS_TYPE")).equals("??????"))?"checked":""%>> ??????</label>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????? ?????????</th>
	         		<td class="padding_none">
	         			<p><span>?????? : </span><input type="text" name="bisprice_1" class="inp_txt" value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_1")))%>"> (??????:100??????)</p>
	         			<p><span>????????? : </span><input type="text" name="bisprice_2" class="inp_txt" value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_2")))%>"> (??????:100??????)</p>
	         			<p><span>?????? : </span><input type="text" name="bisprice_3" class="inp_txt" value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_3")))%>"> (??????:100??????)</p>
	         			<p><span>?????? : </span><input type="text" name="bisprice_4" class="inp_txt read_only" readonly value="<%=util.getStr(String.valueOf(ib.get("BIS_PRICE_4")))%>"> (??????:100??????)</p>
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
		
	<%
		ibNum++;
	}//for end
	%>
	
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
           			<input type="text" name="anname" id="AN_NAME" class="inp_txt" value="<%=util.getStr(infoData.get("AN_NAME")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="cnname" id="CN_NAME" class="inp_txt" value="<%=util.getStr(infoData.get("CN_NAME")) %>"/>
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
           				<option value="??????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("??????"))?"selected":""%>>??????</option>
           				<option value="??????????????????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("??????????????????"))?"selected":""%>>??????????????????</option>
           				<option value="???????????????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("???????????????"))?"selected":""%>>???????????????</option>
           				<option value="????????????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("????????????"))?"selected":""%>>????????????</option>
           				<option value="?????????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("?????????"))?"selected":""%>>?????????</option>
           				<option value="????????????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("????????????"))?"selected":""%>>????????????</option>
           				<option value="????????????" <%=(util.getStr(infoData.get("CEN_TYPE")).equals("????????????"))?"selected":""%>>????????????</option>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="orgage" id="ORG_AGE" class="inp_txt" value="<%=util.getStr(infoData.get("ORG_AGE")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)???</th>
           		<td colspan="3">
           			<input type="text" name="depname" id="DEP_NAME" class="inp_txt" value="<%=util.getStr(infoData.get("DEP_NAME")) %>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(??????)?????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="deptype" value="1" <%=(util.getStr(infoData.get("DEP_TYPE")).equals("1") || util.getStr(infoData.get("DEP_TYPE")).equals(""))?"checked":""%> onclick="areaClick('depcode','1')"> ???????????????</label>
           			<label><input type="radio" name="deptype" value="2" <%=(util.getStr(infoData.get("DEP_TYPE")).equals("2"))?"checked":""%> onclick="areaClick('depcode','2')"> ????????????</label>
           			<select name="<%=(util.getStr(infoData.get("DEP_TYPE")).equals("1"))?"depcode":"0"%>" id="depcode1" class="select_box"  <%=(util.getStr(infoData.get("DEP_TYPE")).equals("2"))?"style='display:none'":""%>>
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DEP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<select name="<%=(util.getStr(infoData.get("DEP_TYPE")).equals("2"))?"depcode":"0"%>" id="depcode2" class="select_box" <%=(util.getStr(infoData.get("DEP_TYPE")).equals("1"))?"style='display:none'":""%>>
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaSigunguList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DEP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????? ?????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="busimptype" value="1"  <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("1") || util.getStr(infoData.get("BUS_IMP_TYPE")).equals(""))?"checked":""%> onclick="areaClick('busimpcode','1')"> ???????????????</label>
           			<label><input type="radio" name="busimptype" value="2" <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("2"))?"checked":""%> onclick="areaClick('busimpcode','2')"> ????????????</label>
           			<select name="<%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("1"))?"busimpcode":"0"%>" id="busimpcode1" class="select_box" <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("2"))?"style='display:none'":""%>>
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("BUS_IMP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           			<select name="<%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("2"))?"busimpcode":"0"%>" id="busimpcode2" class="select_box" <%=(util.getStr(infoData.get("BUS_IMP_TYPE")).equals("1"))?"style='display:none'":""%>>
           				<option value="">:::??????:::</option>
           				<%
							for(HashMap rs:areaSigunguList) {
						%>
						<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("BUS_IMP_CODE")).equals(util.getStr(rs.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(rs.get("CODE_NM"))%></option>
						<% } %>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
           		<td>
           			<input type="text" name="director" id="DIRECTOR" class="inp_txt" value="<%=util.getStr(infoData.get("DIRECTOR"))%>"/>
           		</td>
           		<th scope="row" class="tit">??????????????? ??????</th>
           		<td>
           			<input type="text" name="dirtel" id="DIR_TEL" class="inp_txt" value="<%=util.getStr(infoData.get("DIR_TEL"))%>"/>
           		</td>
           	</tr>
           	<tr>
           	<%
       		String yxmail1 = "";
       		String yxmail2 = "";
       		
       		if(!util.getStr(infoData.get("DIR_EMAIL")).equals("@") || !util.getStr(infoData.get("DIR_MAIL")).equals("")){
       			
       			String[] yxmail = util.getStr(infoData.get("DIR_EMAIL")).split("@");
       			
       			yxmail1 = yxmail[0];
       			yxmail2 = yxmail[1];
       			
       			
       		}
       		
       		%>
           		<th scope="row" class="tit">??????????????? ?????????</th>
           		<td colspan="3">
           			<input type="text" name="mail1" id="mail1" value="<%=yxmail1 %>" class="inp_txt" style="width:15%"  maxlength="20" title="??????????????????"> @
					<input type="text" name="mail2" id="mail2" value="<%=yxmail2 %>" class="inp_txt" style="width:15%"  maxlength="50" title="??????????????????">
					<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="??????????????????????????????" >
						<option value="">????????????</option>
						<option value="gmail.com" <%=(util.getStr(yxmail2).equals("gmail.com"))?"selected":"" %> >?????????</option>
						<option value="empal.com" <%=(util.getStr(yxmail2).equals("empal.com"))?"selected":"" %>>?????????</option>
						<option value="naver.com" <%=(util.getStr(yxmail2).equals("naver.com"))?"selected":"" %>>?????????</option>
						<option value="hanmail.net" <%=(util.getStr(yxmail2).equals("hanmail.net"))?"selected":"" %>>??????</option>
						<option value="hotmail.com" <%=(util.getStr(yxmail2).equals("hotmail.com"))?"selected":"" %>>?????????</option>
						<option value="yahoo.co.kr" <%=(util.getStr(yxmail2).equals("yahoo.co.kr"))?"selected":"" %>>??????</option>
						<option value="nate.com" <%=(util.getStr(yxmail2).equals("nate.com"))?"selected":"" %>>?????????</option>
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
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE1")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
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
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE2")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
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
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE3")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
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
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE4")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
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
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE5")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
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
						<option value="<%=util.getStr(va.get("CODE_NM"))%>" <%=(util.getStr(infoData.get("DIR_TYPE6")).equals(util.getStr(va.get("CODE_NM"))))?"selected":"" %>><%=util.getStr(va.get("CODE_NM"))%></option>
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
           			<input type="text" name="mancname" id="MAN_CNAME" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_CNAME"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
           		<td colspan="3">
           			<input type="text" name="manpname" id="MAN_PNAME" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_PNAME"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="mananame" id="MAN_ANAME" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_ANAME"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>
           		<td colspan="3">
           			<input type="text" name="manspot" id="MAN_SPOT" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_SPOT"))%>"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<input type="text" name="mantel" id="MAN_TEL" class="inp_txt" value="<%=util.getStr(infoData.get("MAN_TEL"))%>"/>
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
           		<td colspan="4">
           			<textarea name="comment" rows="5" style="width:100%;" class="inp_txt"><%=util.getStr(infoData.get("COMMENT"))%></textarea>
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
	
	
	
	$(":file").on("change",function(){
		var fileid = $(this).data("fileid");
		var filesn = $(this).data("filesn");
		//var xxx = $(this).attr("name");
		
		$(this).prevAll("input[name='fileFlog']").val(fileid);
		$(this).prevAll("input[name='fileSn']").val(filesn);
		
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
		
		<%-- <%
		if(fileList.size() == 0)
		%>
		
		if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File1").val()) && $('#<%=fileFullGrp%>File1').val() != ""){

   		}else if($("#<%=fileFullGrp%>File1").val() == ""){
   			alert("????????? ???????????????.");
   			return false;
   		}else{
   			alert("?????? ????????? ???????????? ??? ????????????.");
   			return false;
   		} --%>
		
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
	    
		
		
		goSubmit('modifyProc','10');
	}
	
	
	
	
	$(document).on("change","input[name='bisprice_3']:last,input[name='bisprice_1']:last,input[name='bisprice_2']:last",function(){
		if(isNaN($(this).val())){
			alert("????????? ???????????????");
			$(this).val("");
			$(this).focus();
			return false;
		}
		var totP = parseInt($("input[name='bisprice_1']:last").val())+parseInt($("input[name='bisprice_2']:last").val())+parseInt($("input[name='bisprice_3']:last").val());
		$("input[name='bisprice_4']:last").val(totP);
	});
	
	
	$("#B_TPRICE").on("change",function(){
		if(isNaN($(this).val())){
			alert("????????? ???????????????");
			$(this).val("");
			$(this).focus();
			return false;
		}
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
	$("#E_DATE,#B_SD,#B_ED,input[name='bisedate'],input[name='bissdate']").datepicker({
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
   			row += '<input type="hidden" name="bid" value="">';
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
   			
   			var typex = $("#businesslist").find(".skin_basic_write:last").data("type");
   			
   			if(typex != "on"){
   				
	   			if($('input[name=checkNum]').size() == 1){
	   				alert("?????? ??? ??? ????????????.");
	   				return false;
	   			};
	   			var delCnt = $('input[name=checkNum]').size() - 1;
	   			var parenttr = $("#businesslist_cont_"+delCnt).remove();
   			}
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