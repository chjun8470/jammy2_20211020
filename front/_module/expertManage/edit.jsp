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
	ArrayList<HashMap<String, String>> listSC = request.getAttribute("listSC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listSC");
	ArrayList<HashMap<String, String>> listCR = request.getAttribute("listCR") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCR");
	ArrayList<HashMap<String, String>> listAC = request.getAttribute("listAC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAC");
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	ArrayList<HashMap<String, String>> listRP = request.getAttribute("listRP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRP");
	ArrayList<HashMap<String, String>> listIP = request.getAttribute("listIP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listIP");
	ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	ArrayList<HashMap<String, String>> listEX = request.getAttribute("listEX") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEX");
	ArrayList<HashMap<String, String>> listRE = request.getAttribute("listRE") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRE");
	ArrayList<HashMap<String, String>> listEV = request.getAttribute("listEV") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEV");
	ArrayList<HashMap<String, String>> listCO = request.getAttribute("listCO") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCO");
	ArrayList<HashMap<String, String>> listResultEv = request.getAttribute("listResultEv") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultEv");
	ArrayList<HashMap<String, String>> listResultCon = request.getAttribute("listResultCon") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultCon");
	ArrayList<HashMap<String, String>> majorList = request.getAttribute("majorList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList");
	ArrayList<HashMap<String, String>> majorList2 = request.getAttribute("majorList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList2");
	ArrayList<HashMap<String, String>> majorList3 = request.getAttribute("majorList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("majorList3");
    ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
    ArrayList<HashMap<String, String>> standardList2 = request.getAttribute("standardList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList2");
    ArrayList<HashMap<String, String>> standardList3 = request.getAttribute("standardList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList3");
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

	String option ="<option value=''>???????????????</option>";
	for(HashMap rs:standardList) {
		option += "<option value='"+util.getStr(rs.get("CODE"))+"'>"+util.getStr(rs.get("NAME"))+"</option>";
	}
%>
<style type="text/css">
.ui-datepicker-calendar {
    display: none;
    }
    button.ui-datepicker-current { display: none; }
</style>
<script type="text/javascript">
//<![CDATA[
function standard1(mode,value){
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
        		if(value == data.dataList[i].CODE){
        			result += "<option value=\""+data.dataList[i].CODE+"\" selected='selected'>"+data.dataList[i].NAME+"</option>";

        		}else{
        			result += "<option value=\""+data.dataList[i].CODE+"\" >"+data.dataList[i].NAME+"</option>";
        		}
			}
        	$('#'+mode).append(result);
         }
	});
}

	function standard2(mode, value, value2){
	var result = "";
	var mode = mode;
	var name = mode.substr(0,2);
	if(name == "re"){
		var deth4 = value2;
	}else if(name == "ev"){
		var deth4 = value2;
	}else if(name == "co"){
		var deth4 = value2;
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
        		if(value == data.dataList[i].CODE){
        			result += "<option value=\""+data.dataList[i].CODE+"\" selected='selected'>"+data.dataList[i].NAME+"</option>";

        		}else{
        			result += "<option value=\""+data.dataList[i].CODE+"\" >"+data.dataList[i].NAME+"</option>";
        		}
			}
        	$('#'+mode).append(result);
         }
	});
}
//]]>
</script>
??????????????????????????????????????????
<form name="fedit" id="fedit" action="/web/expertManage.do" method="post" enctype="multipart/form-data">
       <input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
       <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
       <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
       <input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&amp;mode=view&amp;userIdx=<%=userIdx%>" />
	   <input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	   <input type="hidden" name="proState" id="proState" value="<%=util.getStr(dataMap.get("PRO_STATE")) %>" />
	   <input type="hidden" name="m" id="m" value="<%=m%>" />
	   <input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	   <input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID")) %>" />
	   <input type="hidden" name="option" id="option" value="<%=option%>" />

			<h2 style="margin-bottom:10px">????????? ?????? ??????</h2>
			<div class="redTxt" >* ?????? ?????????????????????.</div>
			<h4 class="title003">????????????</h4>
			<table class="skin_view"  summary="???????????? ????????????. ??????,??????,????????????,?????????,?????? ????????????,????????????,???????????? ?????? ???????????????." >
	   			<caption>????????????</caption>
                     <colgroup>
                            <col style="width:15%" />
                            <col style="width:35%" />
                            <col style="width:15%" />
                            <col style="width:35%" />
                     </colgroup>
                     <tbody>
                           	<tr>
                           		<th scope="row" ><label for="psnNm">* ??????</label></th>
                           		<td>
                           			<input type="text" name="psnNm" id="psnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" class="inp_txt02" style="border:0px;" readonly/>
                           		</td>
                           		<th scope="row" ><label for="GenderTypeCd">* ??????</label></th>
                           		<td class="r_line_none">
                           		<input type="text" name="GenderTypeCd" id="GenderTypeCd"  <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='??????'" : "value='??????'" %> class="inp_txt02" style="border:0px;"  readonly="readonly"  maxlength="20" />
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" ><label for="birthDate">* ????????????</label></th>
                           		<td>
                           			<%if(util.getStr(dataMap.get("BIRTH_DATE")).equals("")||util.getStr(dataMap.get("BIRTH_DATE")).equals(null)){ %>
                           				<input type="text" name="birthDate" id="birthDate"  class="inp_txt02" style="width:95%;" maxlength="100" />
                           			<%}else{ %>
                           				<input type="text" name="birthDate" id="birthDate"  value="<% if(util.getStr(dataMap.get("BIRTH_DATE")).length() > 4){ out.println( util.getStr(dataMap.get("BIRTH_DATE")).substring(0,4) );  }else{ out.println( util.getStr(dataMap.get("BIRTH_DATE")) ); } %>" class="inp_txt02" style="border:0px;" readonly/>
                           			<%} %>
                           		</td>
                           		<th scope="row" ><label for="email">* email</label></th>
                           		<td class="r_line_none">
                           			<%if(util.getStr(dataMap.get("EMAIL")).equals("")||util.getStr(dataMap.get("EMAIL")).equals(null)){ %>
                           				<input type="text" name="email" id="email"  class="inp_txt02" style="width:95%;" maxlength="100" />
                           			<%}else{ %>
                           				<input type="text" name="email" id="email"  value="<%=util.getStr(dataMap.get("EMAIL")) %>" class="inp_txt02" style="border:0px;" readonly />
                           			<%} %>
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" ><label for="proUserForg">* ??????</label></th>
                           		<td>
                           			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
			            				if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
			            					<input type="text" name="proUserForg" id="proUserForg"  class="inp_txt02" style="width:95%;" maxlength="100" />
			            				<%}else{%>
			            					<input type="text" name="proUserForg" id="proUserForg"  value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>" readonly="readonly" style="border:0px;" />
			            				<%} %>
			            			<%}else{ %>
			            				<input type="text" name="proUserForg" id="proUserForg"  value="????????????" class="inp_txt" readonly style="border:0px;" >
			            			<%} %>
                           		</td>
                           		<th scope="row" ><label for="ProUserBirthplace">* ????????????</label></th>
                           		<td class="r_line_none">
			        					&nbsp;&nbsp;<label for="area_01" >????????????</label><input type="radio" name="area" id="area_01" value="1"  onclick="areaClick('1')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> checked="checked" <% } %> />
										&nbsp;&nbsp;<label for="area_02" >??? ??? ??????</label><input type="radio" name="area" id="area_02"value="2"  onclick="areaClick('2')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> checked="checked" <% } %> />&nbsp;&nbsp;
										<select class="select00501" style="width:40%" name="ProUserBirthplace" id="ProUserBirthplace1" title="???????????? ??????(?????? ??? ??????)" <% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> style="display:none;"<% } %>>
											<option value="">???????????????</option>
											<%
												int utilitynumArea = 1;
												for(HashMap rs:areaSigunguList) {
												%>
											<option <%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
											value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
											<% utilitynumArea++; } %>
										</select>
										<select class="select00501" name="0" id="ProUserBirthplace2" style="<% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> display:none;<% } %> >width:40%" title="???????????? ??????(?????? ??? ??????)">
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
                           		<th scope="row" ><label for="telNo">* ????????????</label></th>
                           		<td>
                           			<%if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
                           				<input type="text" name="telNo" id="telNo"  class="inp_txt02" style="width:95%;" maxlength="100" />
                           			<%}else{ %>
                           				<input type="text" name="telNo" id="telNo"  value="<%=util.getStr(dataMap.get("TEL_NO")) %>" class="inp_txt02" style="border:0px;" readonly/>
                           			<%} %>
                        		</td>
                        		<th scope="row" ><label for="cpNo">* ????????????</label></th>
                           		<td class="r_line_none">
                           			<%if(util.getStr(dataMap.get("CP_NO")).equals("")||util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
                           				<input type="text" name="cpNo" id="cpNo"  class="inp_txt02" style="width:95%;" maxlength="100" />
                           			<%}else{ %>
                           				<input type="text" name="cpNo" id="cpNo"  value="<%=util.getStr(dataMap.get("CP_NO")) %>" class="inp_txt02" style="border:0px;" readonly />
                           			<%} %>
                        		</td>
                           	</tr>
                           	<tr>
			            		<th scope="row">* ????????????</th>
			                   	<td  colspan="3" class="r_line_none">
			                   		<%
										if(fileList.size() > 0){
									%>
										<div id="fileDivEdit">
											<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
											<%
												int fileCnt = 1;
												for(HashMap rs:fileList){
													String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																		+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																		+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
											%>
												<li class="text">
													<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
															value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" />&nbsp;
													<label for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;
													<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
													<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

												</li>
											<% fileCnt++; }%>
											</ul>
										</div>
                   						<div id="fileDiv">
											<div style="display: none;" id="<%=fileFullGrp%>fileGrpBox" >
												<div>
													<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
												</div>
											</div>
										</div>
												<script type="text/javascript">
												//<![CDATA[
													var arrfileCnt = new Array();
													arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';

													function fileSet(fileCnt){
														if($('#fileFlog_'+fileCnt).is(':checked')){
															$('#fileBox_'+fileCnt).show();
															$('#<%=fileFullGrp%>fileGrpBox').attr("style","display:inline-block;");
														}else{
															$('#<%=fileFullGrp%>File1').val("");
															$('#fileBox_'+fileCnt).hide();
															$('#<%=fileFullGrp%>fileGrpBox').attr("style","display:none;");
														}
													}
												//]]>	
									            </script>
									            <input type="checkbox" name="photoCheck" id="photoCheck" value="N"/>&nbsp;???????????????
						            <% }else{ %>
											<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
												<div>
													<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
												</div>
											</div>
											<input type="checkbox" name="photoCheck" id="photoCheck" value="N" checked='checked'/>&nbsp;???????????????
								      <% } %>
			                	</td>
			            	</tr>
<%if(siteId.endsWith("jntis")){ %>
			            	<tr>
			      	   			<th scope="row" >* ???????????????</th>
			            		<td colspan="3" class="r_line_none">
									<label for="proJntisPlanning">????????????</label> <input type="checkbox" name="proJntisPlanning" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_PLANNING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisRnd">????????????</label> <input type="checkbox" name="proJntisRnd" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_RND"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisCompany">????????????</label> <input type="checkbox" name="proJntisCompany" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_COMPANY"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJeinet">????????????</label> <input type="checkbox" name="proJeinet" value="Y" <%=(util.getStr(dataMap.get("PRO_JEINET"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJipbank">????????????</label> <input type="checkbox" name="proJipbank" value="Y" <%=(util.getStr(dataMap.get("PRO_JIPBANK"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisEducation">????????????</label> <input type="checkbox" name="proJntisEducation" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_EDUCATION"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisConsulting">?????????</label> <input type="checkbox" name="proJntisConsulting" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_CONSULTING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisMarketing">?????????</label> <input type="checkbox" name="proJntisMarketing" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_MARKETING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisEtc">??????</label> <input type="checkbox" name="proJntisEtc" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_ETC"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
								</td>
			            	</tr>
			            	<tr>
			            		<th scope="row" class="tit"><label for="proUserInterestWorld">????????????</th>
			            		<td colspan="3">
			            			<%if(util.getStr(dataMap.get("PRO_USER_INTEREST_WORLD")).equals(null) || util.getStr(dataMap.get("PRO_USER_INTEREST_WORLD")).equals("")){%>
										<textarea id="proUserInterestWorld" name="proUserInterestWorld" style="width:100%"></textarea>
			            			<%}else{%>
										<textarea id="proUserInterestWorld" name="proUserInterestWorld" style="width:100%"><%=dataMap.get("PRO_USER_INTEREST_WORLD")%></textarea>
			            			<%}%>
								</td>
			            	</tr>
<%} %>
                    </tbody>
	   		</table>
<!-- ???????????? E -->
<!-- ???????????? S -->
<%if(!(util.getStr(dataMap.get("ORG_GRP_CD"))).equals("") && !(util.getStr(dataMap.get("ORG_GRP_CD"))).equals(null)){ %>
	   		<div style="padding-top:15px"></div>
			<h4 class="title003">????????????</h4>
            <table class="skin_view" summary="???????????? ????????????. ?????????,????????????,????????????,???????????? ?????? ???????????????." >
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
		<div style="padding-top:15px"></div>
		<h4 class="title003">????????????</h4>
		<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('academic')" title="???????????? ??????"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('academic')" title="???????????? ??????" /></div>
		</div>
   		<table class="skin_list AlignCenter" summary="???????????? ????????????.?????????,?????????,????????????,????????????,???????????? ?????? ????????? ???????????????." >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:25%" />
          		<col style="width:25%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:25%" />
            </colgroup>
        <tbody id="academiclist">
         	<tr>
         		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="scNm1">?????????</label></th>
         		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="scLocation1">?????????</label></th>
         		<th scope="row"  colspan="2"><span style="color:red; font-size:11pt;">*</span><label for="scStart1">??????</label></th>
         		<th scope="row" class="r_line_none"><span style="color:red; font-size:11pt;">*</span> <label for="scDegree1">????????????</label></th>
         	</tr>
	<%if(listSC.size()>0){
		int listScInt = 0;
		
			String academic = "academic";%>
		<% for(HashMap rs:listSC) {
			listScInt ++;
		%>
            <tr id="academic_career_info<%=scCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'academic')">
          		<td><input type="text" name="scNm"  id="scNm<%=listScInt %>" value="<%=util.getStr(rs.get("SC_NM"))%>" class="input_txt00502" /></td>
          		<td><input type="text" name="scLocation" id="scLocation<%=listScInt %>" value="<%=util.getStr(rs.get("SC_LOCATION"))%>" class="input_txt00502" /></td>
          		<td><input type="text" name="scStart" id="scStart<%=listScInt %>"  value="<%=util.getStr(rs.get("SC_START"))%>" class="input_txt00503" title="???????????? ??????"/></td>
          		<td><input type="text" name="scFinish" id="scFinish<%=listScInt %>"  value="<%=util.getStr(rs.get("SC_FINISH"))%>"class="input_txt00503" title="???????????? ??????"/></td>
          		<td class="r_line_none">
          			<select class="select00501"  name="scDegree" id="scDegree<%=listScInt %>" title="?????? ??????">
						<option value="">???????????????</option>
						<option value="??????" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
						<option value="????????????" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("????????????")? "selected='selected'" : "" %>>????????????</option>
						<option value="??????" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
						<option value="??????" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
						<option value="??????" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
						<option value="??????" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
					</select>
          		</td>
          	</tr>
          <%
          		scCnt++;
			}
      }else{%>
      		<tr id="academic_career_info<%=scCnt%>">
          		<td><input type="text" name="scNm" name="scNm1" class="input_txt00502" /></td>
          		<td><input type="text" name="scNm"name="scLocation1" class="input_txt00502" /></td>
          		<td><input type="text" name="scStart" id="scStart1" class="input_txt00503" /></td>
          		<td><input type="text" name="scFinish" id="scFinish1" class="input_txt00503" /></td>
          		<td class="r_line_none">
          			<select class="select00501"  name="scDegree" id="scDegree1" title="?????? ??????">
						<option value="">???????????????</option>
						<option value="??????">??????</option>
						<option value="????????????">????????????</option>
						<option value="??????" >??????</option>
						<option value="??????">??????</option>
						<option value="??????">??????</option>
						<option value="??????">??????</option>
					</select>
          		</td>
          	</tr>
      <%} %>
   		</tbody>
</table>
	<div style="padding-top:15px"></div>
	<h3>??? ????????????</h3>
	<table class="skin_view"  summary="???????????? ????????????. ????????????,?????????????????? ?????? ????????? ???????????? ????????????." >
		<caption>????????????</caption>
		<colgroup>
			  <col style="width:15%" />
			  <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		</colgroup>
<%if(listEX.size()>0) {
int listExInt = 0;
%>
		<% for(HashMap rsEx:listEX) {
		listExInt++;
		%>
		<tr>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="exMajor<%=listExInt%>">????????????</label></th>
			<td>
				<select class="select00501" name="exMajor" onchange="majorDeth1('exRealm')" id="exMajor<%=listExInt%>" title="??????????????????">
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_MAJOR"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="exRealm<%=listExInt %>">????????????</label></th>
			<td>
<%if(util.getStr(rsEx.get("EX_REALM")).equals("") || util.getStr(rsEx.get("EX_REALM")).equals(null)){ %>
				<select  class="select00501" name="exRealm" id="exRealm<%=listExInt %>" onchange="majorDeth2('exDetail')" title="???????????? ??????"><option>???????????????.</option></select>
<%}else{ %>
				<select class="select00501"  name="exRealm" id="exRealm<%=listExInt %>" onchange="majorDeth2('exDetail')" title="???????????? ??????">
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList2) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_REALM"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
<%}%>
			</td>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="exDetail<%=listExInt %>">????????????</label></th>
			<td class="r_line_none">
<%if(util.getStr(rsEx.get("EX_DETAIL_NAME")).equals("") || util.getStr(rsEx.get("EX_DETAIL_NAME")).equals(null)){ %>
				<input type="text" name="exDetail" class="input_txt00502" id="exDetail<%=listExInt %>">
<%}else{ %>
				<input type="text" name="exDetail" id="exDetail<%=listExInt %>" value="<%=util.getStr(rsEx.get("EX_DETAIL_NAME"))%>" class="input_txt00502">
<%} %>
			</td>
		</tr>
		<tr>
			<th scope="row" ><label for="pluralExMajor<%=listExInt%>">??????????????????</label></th>
			<td>
				<select class="select00501" name="pluralExMajor" id="pluralExMajor<%=listExInt %>" onchange="majorDeth1('pluralExRealm')" title="?????????????????? ??????">
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_MAJOR_PLURAL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" ><label for="pluralExRealm<%=listExInt%>">????????????</label></th>
			<td>
<%if(util.getStr(rsEx.get("EX_REALM_PLURAL")).equals("") || util.getStr(rsEx.get("EX_REALM_PLURAL")).equals(null)){ %>
				<select class="select00501"  name="pluralExRealm" id="pluralExRealm<%=listExInt%>" onchange="majorDeth2('pluralExDetail')" title="???????????? ??????"><option>???????????????.</option></select>
<%}else{ %>

				<select class="select00501"  name="pluralExRealm" id="pluralExRealm<%=listExInt%>" onchange="majorDeth2('pluralExDetail')" title="???????????? ??????">
					<option value="">???????????????</option>
					<% for(HashMap rs:majorList2) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_REALM_PLURAL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
<%} %>
			</td>
			<th scope="row" ><label for="pluralExDetail<%=listExInt%>">????????????</label></th>
			<td class="r_line_none">
<%if(util.getStr(rsEx.get("EX_DETAIL_PLURAL")).equals("") || util.getStr(rsEx.get("EX_DETAIL_PLURAL")).equals(null)){ %>
				<input type="text" name="pluralExDetail" id="pluralExDetail<%=listExInt%>" class="input_txt00502">
<%}else{ %>
				<input type="text" name="pluralExDetail" id="pluralExDetail<%=listExInt%>" value="<%=util.getStr(rsEx.get("EX_DETAIL_PLURAL"))%>" class="input_txt00502">
<%} %>
			</td>
		</tr>
<%}
		} %>
	</table>
<!-- ???????????? E -->
<!-- ???????????? S -->
		<div style="padding-top:15px"></div>
		<h4 class="title003">????????????</h4>
		<div class="zoom005 PAT20">
			<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('career')" title="???????????? ??????"/>
			<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('career')" title="???????????? ??????"/>
   		</div>
   		<table class="skin_list AlignCenter" summary="???????????? ????????????. ?????????,?????????,????????????,????????????,???????????? ?????? ????????? ???????????????." >
   			<caption>????????????</caption>
            <colgroup>
	            <col style="width:20%" />
          		<col style="width:15%" />
          		<col style="width:6%" />
          		<col style="width:14%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
		<tbody id="careerlist">
          	<tr>
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span><label for="crNm1">?????????</label></th>
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span><label for="crLocation1">?????????</label></th>
          		<th scope="row"  colspan="2"><span style="color:red; font-size:11pt;">*</span><label for="crStart1">??????</label></th>
				<th scope="row" ><span style="color:red; font-size:11pt;">*</span><label for="crDept1">????????????</label></th>
          		<th scope="row" class="r_line_none"><span style="color:red; font-size:11pt;">*</span><label for="crWork1">????????????</label></th>
			</tr>
		<%if(listCR.size()>0){ 
		int listCrInt=0;
		
		%>
			<% for(HashMap rs:listCR) {
			listCrInt++;
			%>
        	<tr id="career_info<%=crCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'career')">
				<td><input type="text" id="crNm<%=listCrInt%>" name="crNm"  value="<%=util.getStr(rs.get("CR_NM"))%>" class="input_txt00502" /></td>
				<td><input type="text" id="crLocation<%=listCrInt%>" name="crLocation" value="<%=util.getStr(rs.get("CR_LOCATION"))%>" class="input_txt00502" /></td>
				<td><input type="text" id="crStart<%=listCrInt%>" name="crStart" value="<%=util.getStr(rs.get("CR_START"))%>" class="input_txt00503" title="???????????? ??????" style="width:60px;" /></td>
				<td><input type="text" id="crFinish<%=listCrInt%>" name="crFinish" value="<%=util.getStr(rs.get("CR_FINISH"))%>" class="input_txt00503" title="???????????? ??????" style="width:60px;" />
					<label><input type="checkbox" name="crCheck" id="crCheck<%=listCrInt%>"  value="<%=listCrInt%>"  <%=util.getStr(rs.get("CR_FINISH")).equals("?????? ???")?" checked='checked' ":""%>/>?????????</label>
				</td>
				<td><input type="text" id="crDept<%=listCrInt%>" name="crDept" value="<%=util.getStr(rs.get("CR_DEPT"))%>" class="input_txt00502" /></td>
				<td class="r_line_none"><input type="text" id="crWork<%=listCrInt%>" name="crWork" value="<%=util.getStr(rs.get("CR_WORK"))%>" class="input_txt00501" /></td>
			</tr>
            <%crCnt++;
			}
		}else{%>
			<tr id="career_info<%=crCnt%>">
				<td><input type="text" id="crNm1" name="crNm" class="input_txt00502" /></td>
				<td><input type="text" id="crLocation1" name="crLocation" class="input_txt00502" /></td>
				<td><input type="text" name="crStart" id="crStart<%=crCnt%>"  class="input_txt00503"  title="???????????? ??????" style="width:60px;" /></td>
				<td><input type="text" name="crFinish" id="crFinish<%=crCnt%>"  class="input_txt00503"  title="???????????? ??????" style="width:60px;" />
					<label><input type="checkbox" name="crCheck" id="crCheck<%=crCnt%>"  value="<%=crCnt%>" />?????????</label>
				</td>
				<td><input type="text" id="crDept1" name="crDept"  class="input_txt00502" /></td>
				<td class="r_line_none"><input type="text" id="crWork1" name="crWork"  class="input_txt00501" /></td>
			</tr>
		<%}%>
		</tbody>
		</table>
<!-- ???????????? E -->
<!-- ???????????? S -->
		<div style="padding-top:15px"></div>
		<h4 class="title003">????????????</h4>
		<div class="zoom005 PAT20">
			<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('activity')" title="???????????? ??????" />
			<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('activity')" title="???????????? ??????" />
   		</div>
   		<table class="skin_list AlignCenter"   summary="???????????? ????????????. ??????(??????)???, ????????????,??????,???????????? ?????? ???????????????." >
   			<caption>????????????</caption>
            <colgroup>
          		<col style="width:35%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
		<tbody id="activitylist">
           	<tr>
           		<th scope="row" ><label for="acNm1">??????(??????)???</label></th>
           		<th scope="row" colspan="2"><label for="acStart1">??????</label></th>
           		<th scope="row" ><label for="acDept1">??????</label></th>
           		<th scope="row" class="r_line_none"><label for="acWork1">????????????</label></th>
           	</tr>
		<%if(listAC.size()>0){ 
		int listAcInt = 0;
		%>
			<% for(HashMap rs:listAC) {
			listAcInt++;
			%>
         	<tr id="activity<%=acCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'activity')">
         		<td><input type="text" id="acNm<%=listAcInt %>" name="acNm" value="<%=util.getStr(rs.get("AC_NM"))%>" class="input_txt00501" /></td>
         		<td><input type="text" id="acStart<%=listAcInt %>" name="acStart" id="acStart<%=acCnt%>" value="<%=util.getStr(rs.get("AC_START"))%>" class="input_txt00503" title="?????????????????? ??????" /></td>
         		<td><input type="text" id="acFinish<%=listAcInt %>" name="acFinish" id="acFinish<%=acCnt%>" value="<%=util.getStr(rs.get("AC_FINISH"))%>" class="input_txt00503"  title="?????????????????? ??????" /></td>
         		<td><input type="text" id="acDept<%=listAcInt %>" name="acDept" value="<%=util.getStr(rs.get("AC_DEPT"))%>" class="input_txt00502" /></td>
         		<td class="r_line_none"><input type="text" id="acWork<%=listAcInt %>" name="acWork" value="<%=util.getStr(rs.get("AC_WORK"))%>" class="input_txt00501" /></td>
         	</tr>
         	<%acCnt++;
         	}
		}else{%>
			<tr id="activity<%=acCnt%>">
         		<td><input type="text" name="acNm" id="acNm1" class="input_txt00501" /></td>
         		<td><input type="text" name="acStart" id="acStart1" class="input_txt00503" title="?????????????????? ??????"/></td>
         		<td><input type="text" name="acFinish" id="acFinish1" class="input_txt00503" title="?????????????????? ??????"/></td>
         		<td><input type="text" name="acDept" id="acDept1" class="input_txt00502" /></td>
         		<td class="r_line_none"><input type="text" name="acWork" id="acWork1" class="input_txt00501" /></td>
         	</tr>
		<%} %>
		</tbody>
	</table>
<!-- ???????????? E -->
<!-- ??????????????????(????????????) ???????????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">??????????????????(????????????) ????????????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('RnDresult')" title="?????????????????? ??????" />
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('RnDresult')" title="?????????????????? ??????" />
	</div>
	<table class="skin_list AlignCenter" summary="??????????????????(????????????) ???????????? ????????????. ??????/??????/????????????, ?????????,?????????,?????????????????????,?????????,???????????? ?????? ???????????????." >
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
       		<th scope="row" ><label for="rdSerialNum1">??????</label></th>
       		<th scope="row" ><label for="rdOrgNm1">??????/??????/????????????</label></th>
       		<th scope="row" ><label for="rdBusinessNm1">?????????</label></th>
       		<th scope="row" ><label for="rdNm1">?????????</label></th>
       		<th scope="row"  colspan="2"><label for="rdStart<%=rdCnt%>">?????????????????????</label></th>
       		<th scope="row" ><label for="rdExpenses1">????????????(??????:?????????)</label></th>
       		<th scope="row" class="r_line_none"><label for="rdForm1">????????????</label></th>
       	</tr>
 	<%if(listRD.size()>0){ 
 	int listRdInt = 0;
 	%>
			<% for(HashMap rs:listRD) {
			listRdInt++;
			%>
     	<tr id="RnDresult<%=rdCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'RnDresult')">
     		<td><input type="text" id="rdSerialNum<%=listRdInt %>" name="rdSerialNum" value="<%=util.getStr(rs.get("RD_SERIAL_NUM"))%>" class="input_txt00503" /></td>
     		<td><input type="text" id="rdOrgNm<%=listRdInt %>" name="rdOrgNm" value="<%=util.getStr(rs.get("RD_ORG_NM"))%>" class="input_txt00502" /></td>
     		<td><input type="text" id="rdBusinessNm<%=listRdInt %>" name="rdBusinessNm" value="<%=util.getStr(rs.get("RD_BUSINESS_NM"))%>"  class="input_txt00502" /></td>
     		<td><input type="text" id="rdNm<%=listRdInt %>" name="rdNm" value="<%=util.getStr(rs.get("RD_NM"))%>" class="input_txt00502" /></td>
     		<td><input type="text" id="rdStart<%=rdCnt%>" name="rdStart" value="<%=util.getStr(rs.get("RD_START"))%>" class="input_txt00503" title="???????????? ??????" /></td>
     		<td><input type="text" id="rdFinish<%=rdCnt%>" name="rdFinish" value="<%=util.getStr(rs.get("RD_FINISH"))%>" class="input_txt00503" title="???????????? ??????" /></td>
     		<td><input type="text" id="rdExpenses<%=listRdInt %>" name="rdExpenses" value="<%=util.getStr(rs.get("RD_EXPENSES"))%>" class="input_txt00503" /></td>
       		<td class="r_line_none">
       			<select class="select00501" id="rdForm<%=listRdInt %>" name="rdForm" title="???????????? ??????">
       				<option value="" <%=(util.getStr(rs.get("RD_FORM"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="??????or???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("??????or???????????????")? "selected='selected'" : "" %>>??????or???????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RD_FORM"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       			</select>
       		</td>
		</tr>
		<%rdCnt++;}
	}else{%>
		<tr id="RnDresult<%=rdCnt%>">
     		<td><input type="text" id="rdSerialNum1" name="rdSerialNum" class="input_txt00503" /></td>
     		<td><input type="text" id="rdOrgNm1" name="rdOrgNm" class="input_txt00502" /></td>
     		<td><input type="text" id="rdBusinessNm1" name="rdBusinessNm" class="input_txt00502" /></td>
     		<td><input type="text" id="rdNm1" name="rdNm" class="input_txt00502" /></td>
     		<td><input type="text" id="rdStart0" name="rdStart" class="input_txt00503" title="???????????? ??????" /></td>
     		<td><input type="text" id="rdFinish0" name="rdFinish" class="input_txt00503" title="???????????? ??????" /></td>
     		<td><input type="text" id="rdExpenses1" name="rdExpenses" class="input_txt00503" /></td>
       		<td class="r_line_none">
       			<select class="select00501"  id="rdForm1" name="rdForm">
       				<option value="">??????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????or???????????????">??????or???????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="???????????????">???????????????</option>
       			</select>
       		</td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- ??????????????????(????????????) ???????????? E -->

<!-- ???????????? ???????????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">???????????? ????????????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('resultEv')" title="?????? ??????" />
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('resultEv')" title="?????? ??????" />
	</div>
	<table class="skin_list"  summary="???????????? ???????????? ????????????. ???????????? ?????????,???????????????,????????????,???????????? ?????? ???????????????."  >
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
	 		<th scope="row" ><label for="evName0">???????????? ?????????(?????????)</label></th>
	 		<th scope="row" ><label for="evOrg0">???????????????</label></th>
	 		<th scope="row" colspan="2"><label for="evSdate0">????????????</label></th>
	 		<th scope="row" class="r_line_none"><label for="evContent0">????????????</label></th>
	 	</tr>
<%
	if(listResultEv.size()>0){
	%>
		<% for(HashMap rs:listResultEv) {
		%>
    	<tr id="resultEv<%=resultEvCnt%>">
 	  		<td>
 	  			<input type="text" name="evName" id="evName<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_NAME"))%>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evOrg" id="evOrg<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_ORG"))%>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evSdate" id="evSdate<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_SDATE"))%>" class="input_txt00503" title="???????????? ??????">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_EDATE"))%>" class="input_txt00503" title="???????????? ??????">
 	  		</td>
   			<td  class="r_line_none">
   				<input type="text" name="evContent" id="evContent<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_CONTENT"))%>" class="input_txt00501" >
   			</td>
     	</tr>

<%			resultEvCnt++;
		}
}else{%>
		<tr id="research<%=resultConCnt%>">
 	  		<td>
 	  			<input type="text" name="evName" id="evName<%=resultEvCnt %>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evOrg" id="evOrg<%=resultEvCnt %>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evSdate" id="evSdate<%=resultEvCnt %>" class="input_txt00503" title="???????????? ??????" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%=resultEvCnt %>" class="input_txt00503" title="???????????? ??????" >
 	  		</td>
   			<td class="r_line_none">
   				<input type="text" name="evContent" id="evContent<%=resultEvCnt %>" class="input_txt00501" >
   			</td>
     	</tr>
<%} %>
	</tbody>
	</table>
<!-- ???????????? ???????????? E -->
<!-- ????????? ???????????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">????????? ????????????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('resultCon')" title="???????????? ??????"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('resultCon')" title="???????????? ??????"/>
	</div>
	<table class="skin_list"   summary="????????? ???????????? ????????????. ????????? ?????????,???????????????,???????????????,????????? ?????? ?????? ???????????????." >
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
	 		<th scope="row" class="tit"><label for="conName<%=resultConCnt %>">????????? ?????????(????????????)</label></th>
	 		<th scope="row" class="tit"><label for="conOrg<%=resultConCnt %>">???????????????</label></th>
	 		<th scope="row" class="tit" colspan="2"><label for="conSdate<%=resultConCnt %>">???????????????</label></th>
	 		<th scope="row" class="tit"><label for="conContent<%=resultConCnt %>">???????????????</label></th>
	 	</tr>
<%
	if(listResultCon.size()>0){%>
		<% for(HashMap rs:listResultCon) {%>
    	<tr id="resultCon<%=resultConCnt%>">
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_NAME"))%>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_ORG"))%>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conSdate" id="conSdate<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_SDATE"))%>" class="input_txt00503" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conEdate" id="conEdate<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_EDATE"))%>" class="input_txt00503" >
 	  		</td>
   			<td  class="r_line_none">
   				<input type="text" name="conContent" id="conContent<%=resultConCnt %>" value="<%=util.getStr(rs.get("CON_CONTENT"))%>" class="input_txt00501" >
   			</td>
     	</tr>

<%			resultConCnt++;
		}
}else{%>
		<tr id="research<%=resultConCnt%>">
 	  		<td>
 	  			<input type="text" name="conName" id="conName<%=resultConCnt %>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conOrg" id="conOrg<%=resultConCnt %>" class="input_txt00501" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conSdate" id="conSdate<%=resultConCnt %>" class="input_txt00503" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="conEdate" id="conEdate<%=resultConCnt %>" class="input_txt00503" >
 	  		</td>
   			<td class="r_line_none">
   				<input type="text" name="conContent" id="conContent<%=resultConCnt %>" class="input_txt00501" >
   			</td>
     	</tr>
<%} %>
	</tbody>
	</table>
<!-- ????????? ???????????? E -->



<!-- ???????????? ?????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">???????????? ??????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('researchPaper')" title="???????????? ?????? ??????"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('researchPaper')" title="???????????? ?????? ??????"/>
	</div>
	<table class="skin_list AlignCenter" summary="???????????? ??????????????????.??????,?????????,????????????,????????????,???????????? ?????? ???????????????." >
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
       		<th scope="row" ><label for="rpSerialNum<%=rpCnt%>">??????</label></th>
       		<th scope="row" ><label for="rpNm<%=rpCnt%>">?????????</label></th>
       		<th scope="row" ><label for="rpType<%=rpCnt%>">????????????</label></th>
       		<th scope="row" ><label for="rpJournalNm<%=rpCnt%>">????????????</label></th>
       		<th scope="row" class="r_line_none"><label for="rpStart<%=rpCnt%>">????????????</label></th>

       	</tr>
 	<%if(listRP.size()>0){ %>
		<% for(HashMap rs:listRP) {%>
     	<tr id="researchPaper<%=rpCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'researchPaper')">
     		<td><input type="text" id="rpSerialNum<%=rpCnt%>" name="rpSerialNum" value="<%=util.getStr(rs.get("RP_SERIAL_NUM"))%>" class="input_txt00503" /></td>
     		<td><input type="text" id="rpNm<%=rpCnt%>" name="rpNm" value="<%=util.getStr(rs.get("RP_NM"))%>" class="input_txt00501" /></td>
     		<td>
				<select  class="select00501"  name="rpType" id="rpType<%=rpCnt%>" title="???????????? ??????">
       				<option value="" <%=(util.getStr(rs.get("RP_TYPE"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RP_TYPE"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="??????????????????" <%=(util.getStr(rs.get("RP_TYPE"))).equals("??????????????????")? "selected='selected'" : "" %>>??????????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RP_TYPE"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="??????????????????" <%=(util.getStr(rs.get("RP_TYPE"))).equals("??????????????????")? "selected='selected'" : "" %>>??????????????????</option>
       				<option value="???????????????" <%=(util.getStr(rs.get("RP_TYPE"))).equals("???????????????")? "selected='selected'" : "" %>>???????????????</option>
       			</select>
     		</td>
     		<td><input type="text" id="rpJournalNm<%=rpCnt%>" name="rpJournalNm"  value="<%=util.getStr(rs.get("RP_JOURNAL_NM"))%>"  class="input_txt00502"  /></td>
     		<td class="r_line_none">
     		<input type="text" name="rpStart" id="rpStart<%=rpCnt%>"  value="<%=util.getStr(rs.get("RP_START"))%>" class="input_txt00503" /></td>
		</tr>
		<%rpCnt++;}
	}else{%>
		<tr id="researchPaper<%=rpCnt%>">
     		<td><input type="text" name="rpSerialNum" id="rpSerialNum<%=rpCnt%>" class="input_txt00503" /></td>
     		<td><input type="text" name="rpNm" id="rpNm<%=rpCnt%>" class="input_txt00501" /></td>
     		<td>
				<select class="select00501"  name="rpType" id="rpType<%=rpCnt%>" title="???????????? ??????">
       				<option value="">??????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????????????????">??????????????????</option>
       				<option value="???????????????">???????????????</option>
       				<option value="??????????????????">??????????????????</option>
       				<option value="???????????????">???????????????</option>
       			</select>
     		</td>
     		<td><input type="text" name="rpJournalNm" class="input_txt00502" id="rpJournalNm<%=rpCnt%>" /></td>
     		<td class="r_line_none"><input type="text" name="rpStart" id="rpStart<%=rpCnt%>" class="input_txt00503" /></td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->
<!-- ???????????? ?????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">???????????? ??????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('inProperty')" title="???????????? ?????? ??????"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('inProperty')" title="???????????? ?????? ??????"/>
	</div>
	<table class="skin_list AlignCenter" summary="???????????? ?????? ????????????. ??????,???????????????,??????????????????,??????/?????????,???????????? ?????? ???????????????." >
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
       		<th scope="row" ><label for="ipSerialNum<%=ipCnt%>">??????</label></th>
       		<th scope="row" ><label for="ipNm<%=ipCnt%>">???????????????</label></th>
       		<th scope="row" ><label for="ipType<%=ipCnt%>">??????????????????</label></th>
       		<th scope="row" ><label for="ipPublication<%=ipCnt%>">??????/?????????</label></th>
       		<th scope="row" class="r_line_none"><label for="ipStart<%=ipCnt%>">????????????</label></th>

       	</tr>
 	<%if(listIP.size()>0){ %>
		<% for(HashMap rs:listIP) {%>
     	<tr id="inProperty<%=ipCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'inProperty')">
     		<td><input type="text" id="ipSerialNum<%=ipCnt%>" name="ipSerialNum" value="<%=util.getStr(rs.get("IP_SERIAL_NUM"))%>" class="input_txt00503"  /></td>
     		<td><input type="text" id="ipNm<%=ipCnt%>" name="ipNm" value="<%=util.getStr(rs.get("IP_NM"))%>"  class="input_txt00501"  /></td>
     		<td>
				<select class="select00501" name="ipType" id="ipType<%=ipCnt%>" title="?????????????????? ??????">
       				<option value=""  <%=(util.getStr(rs.get("IP_TYPE"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="????????????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("????????????")? "selected='selected'" : "" %>>????????????</option>
       				<option value="??????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="?????????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("?????????")? "selected='selected'" : "" %>>?????????</option>
       				<option value="????????????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("????????????")? "selected='selected'" : "" %>>????????????</option>
       				<option value="?????????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("?????????")? "selected='selected'" : "" %>>?????????</option>
       				<option value="??????????????????" <%=(util.getStr(rs.get("IP_TYPE"))).equals("??????????????????")? "selected='selected'" : "" %>>??????????????????</option>
       			</select>
     		</td>
     		<td><input type="text" id="ipPublication<%=ipCnt%>" name="ipPublication" value="<%=util.getStr(rs.get("IP_PUBLICATION"))%>" class="input_txt00502"  /></td>
     		<td class="r_line_none"><input type="text" name="ipStart" id="ipStart<%=ipCnt%>" value="<%=util.getStr(rs.get("IP_START"))%>" class="input_txt00503" /></td>
		</tr>
		<%ipCnt++;}
	}else{ %>
		<tr id="inProperty<%=ipCnt%>">
     		<td><input type="text" id="ipSerialNum<%=ipCnt%>" name="ipSerialNum" class="input_txt00503" /></td>
     		<td><input type="text" id="ipNm<%=ipCnt%>" name="ipNm" class="input_txt00501" /></td>
     		<td>
				<select class="select00501"  name="ipType" id="ipType<%=ipCnt%>" title="?????????????????? ??????">
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
     		<td><input type="text" id="ipPublication<%=ipCnt%>" name="ipPublication" class="input_txt00502" /></td>
     		<td class="r_line_none"><input type="text" name="ipStart" id="ipStart<%=ipCnt%>" class="input_txt00503" /></td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- ???????????? ?????? E -->
<!-- ?????? ?????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">????????????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('awardCareer')" />
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('awardCareer')" />
	</div>
	<table class="skin_list AlignCenter" summary="???????????? ????????????. ??????,??????,????????????,????????????,???????????? ?????? ???????????????." >
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
       		<th scope="row" ><label for="awSerialNum<%=awCnt%>">??????</label></th>
       		<th scope="row" ><label for="awBadge<%=awCnt%>">??????</label></th>
       		<th scope="row" ><label for="awStart<%=awCnt%>">????????????</label></th>
       		<th scope="row" ><label for="awPresent<%=awCnt%>">????????????</label></th>
       		<th scope="row" class="r_line_none"><label for="awContent<%=awCnt%>">????????????</label></th>

       	</tr>
 	<%if(listAW.size()>0){ %>
		<% for(HashMap rs:listAW) {%>
     	<tr id="awardCareer<%=awCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'awardCareer')">
     		<td><input type="text" id="awSerialNum<%=awCnt%>" name="awSerialNum" value="<%=util.getStr(rs.get("AW_SERIAL_NUM"))%>"  class="input_txt00503" /></td>
     		<td>
				<select class="select00501"   name="awBadge" id="awBadge<%=awCnt%>" title="?????? ??????">
       				<option value="" <%=(util.getStr(rs.get("AW_BADGE"))).equals("")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%=(util.getStr(rs.get("AW_BADGE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%=(util.getStr(rs.get("AW_BADGE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       				<option value="??????" <%=(util.getStr(rs.get("AW_BADGE"))).equals("??????")? "selected='selected'" : "" %>>??????</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart"  value="<%=util.getStr(rs.get("AW_START"))%>"  id="awStart<%=awCnt%>"  class="input_txt00503" /></td>
     		<td><input type="text" name="awPresent" value="<%=util.getStr(rs.get("AW_PRESENT"))%>"  class="input_txt00502" id="awPresent<%=awCnt%>" /></td>
     		<td class="r_line_none"><input type="text" id="awContent<%=awCnt%>" name="awContent" value="<%=util.getStr(rs.get("AW_CONTENT"))%>"   class="input_txt00501" /></td>
		</tr>
	<%	awCnt++;}
	}else{%>
		<tr id="awardCareer<%=awCnt%>">
     		<td><input type="text" id="awSerialNum<%=awCnt%>" name="awSerialNum"  class="input_txt00503"  /></td>
     		<td>
				<select class="select00501"   name="awBadge"  id="awBadge<%=awCnt%>" title="?????? ??????">
       				<option value="">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       				<option value="??????">??????</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart" id="awStart<%=awCnt%>"  class="input_txt00503" /></td>
     		<td><input type="text" name="awPresent"  id="awPresent<%=awCnt%>" class="input_txt00502"  /></td>
     		<td class="r_line_none"><input type="text"  id="awContent<%=awCnt%>" name="awContent"  class="input_txt00501" /></td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- ?????? ?????? E -->

<!-- ???????????? S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">????????????</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('qualification')" title="???????????? ??????"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('qualification')" title="???????????? ??????"/>
	</div>
	<table class="skin_list AlignCenter" summary="???????????? ????????????.??????,?????????,???????????????,????????????,??????????????? ???????????????." >
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
       		<th scope="row" ><label for="quSerialNum<%=quCnt%>">??????</label></th>
       		<th scope="row" ><label for="quStart<%=quCnt%>">?????????</label></th>
       		<th scope="row" ><label for="quOrgNm<%=quCnt%>">???????????????</label></th>
       		<th scope="row" ><label for="quDivide<%=quCnt%>">????????????</label></th>
       		<th scope="row" class="r_line_none"><label for="quNm<%=quCnt%>">?????????</label></th>
       	</tr>
	<%if(listQU.size()>0){ %>
		<% for(HashMap rs:listQU) {%>
       	<tr id="qualification<%=quCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'qualification')">
       		<td><input type="text" id="quSerialNum<%=quCnt%>" name="quSerialNum" value="<%=util.getStr(rs.get("QU_SERIAL_NUM"))%>"  class="input_txt00503"/></td>
       		<td><input type="text" name="quStart" id="quStart<%=quCnt%>"  value="<%=util.getStr(rs.get("QU_START"))%>"  class="input_txt00503"/></td>
       		<td>
       		<input type="text" id="quOrgNm<%=quCnt%>" name="quOrgNm" value="<%=util.getStr(rs.get("QU_ORG_NM"))%>"  class="input_txt00502" /></td>
       		<td>
       			<select class="select_box" id="quDivide<%=quCnt%>" name="quDivide" title="???????????? ??????">
       				<option value=""  <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("")? "selected='selected'" : "" %>>???????????????</option>
       				<option value="????????????" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("????????????")? "selected='selected'" : "" %>>????????????</option>
       				<option value="????????????" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("????????????")? "selected='selected'" : "" %>>????????????</option>
       				<option value="????????????" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("????????????")? "selected='selected'" : "" %>>????????????</option>
       			</select>
       		</td>
       		<td class="r_line_none"><input type="text" id="quNm<%=quCnt%>" name="quNm" value="<%=util.getStr(rs.get("QU_NM"))%>" class="input_txt00501"/></td>
       	</tr>
       	<%quCnt++;}
	}else{%>
		<tr id="qualification<%=quCnt%>">
       		<td><input type="text" name="quSerialNum" id="quSerialNum<%=quCnt%>" class="input_txt00503"/></td>
       		<td><input type="text" name="quStart" id="quStart<%=quCnt%>"  class="input_txt00503" /></td>
       		<td><input type="text" name="quOrgNm" id="quOrgNm<%=quCnt%>" class="input_txt00502" /></td>
       		<td>
       			<select class="select_box"  name="quDivide" id="quDivide<%=quCnt%>" title="???????????? ??????">
       				<option value="">???????????????</option>
       				<option value="????????????">????????????</option>
       				<option value="????????????">????????????</option>
       				<option value="????????????">????????????</option>
       			</select>
       		</td>
       		<td class="r_line_none"><input type="text" name="quNm" id="quNm<%=quCnt%>" class="input_txt00501" /></td>
       	</tr>
	<%} %>
	</tbody>
	</table>
<!-- ???????????? E -->
              <!-- bo_btn  -->
              <div class="b_btn_area" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_rgt" value="????????????" onclick="goCheck()"/>
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
	if($('#proState').val() == "10"){
		alert("??????????????? ??????????????????.");
	}
	if($('#proState').val() == "20"){
		alert("?????????????????? ??????????????????. ?????????????????? ???????????????.");
	}
});

	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^???-???]/;
	var characPattern = /[^a-zA-Z0-9][^???-???]/;
	var engPattern  = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var datePattern = /^[0-9]{4}-[0-9]{2}/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
	var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;

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
//????????????-???????????? E
function goCheck(){
		if($('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
			alert("?????????????????? ??????????????????");
				$('#proJntisPlanning').focus();
			return false;
		}
		var imgFormat = "\.(bmp|gif|jpg|jpeg|png)$";
	  	var fileCount = $("input[type=file]").length;

		if($("#photoCheck").is(":checked") == false){
			if( $('input[name=fileFlog]').is(":checked") == true ){
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
		}
		if($('#birthDate').val() == "" || $('#birthDate').val() == null || $('#email').val() == "" || $('#email').val() == null || $('#proUserForg').val() == "" || $('#proUserForg').val() == null || $('#telNo').val() == "" || $('#telNo').val() == null || $('#cpNo').val() == "" || $('#cpNo').val() == null ){
			alert("??????????????? ?????? ??? ?????????.");
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
					alert("??????????????????(????????????) ????????????(????????????) : ????????? ??????????????????. ex)10000");
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

		goSubmit('editProc');
}
function goSubmit(mode){
    $('#mode').val(mode);
    if(mode == "list"){
			$('#fedit').attr('action','sub.do');
	}
    $('#fedit').submit();
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


$("#evSdate0,#evEdate0,#conSdate0,#conEdate0,#scStart0, #scStart0, #scFinish0, #crStart0, #crFinish0, #acStart0, #acFinish0, #rdStart0, #rdFinish0, #quStart0, #rpStart0, #ipStart0, #awStart0").datepicker({
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
    		 	row += "<td><input type='text' name='scNm' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='scLocation' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='scStart' id='scStart"+plusScCnt+"' class='input_txt00503' title='???????????? ??????'></td>";
    		 	row += "<td><input type='text' name='scFinish' id='scFinish"+plusScCnt+"' class='input_txt00503' title='???????????? ??????'></td>";
    		 	row += "<td class='r_line_none' ><select name='scDegree' class='select00501' title='?????? ??????'>";
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
    		 	row += "<td><input type='text' name='crNm' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='crLocation' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='crStart' id='crStart"+plusScCnt+"' class='input_txt00503' title='???????????? ??????' style='width:60px;' /></td>";
    		 	row += "<td><input type='text' name='crFinish' id='crFinish"+plusScCnt+"' class='input_txt00503' title='???????????? ??????' style='width:60px;' />";
    		 	row += "<label><input type='checkbox' name='crCheck' id='crCheck"+plusScCnt+"' value='"+plusScCnt+"' />?????????</label>";
    		 	row += "</td>";
    		 	row += "<td><input type='text' name='crDept' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='crWork' class='input_txt00501' ></td>";
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
    		 	row += "<td><input type='text' name='acNm' class='input_txt00501' ></td>";
    		 	row += "<td><input type='text' name='acStart' id='acStart"+plusScCnt+"' class='input_txt00503'  title='?????????????????? ??????'></td>";
    		 	row += "<td><input type='text' name='acFinish' id='acFinish"+plusScCnt+"' class='input_txt00503'  title='?????????????????? ??????'></td>";
    		 	row += "<td><input type='text' name='acDept' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='acWork' class='input_txt00501' ></td>";
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
					alert("??????????????????(????????????) ????????????(????????????) : ????????? ??????????????????. ex)10000");
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
    		 	row += "<td ><input type='text' name='rdSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td ><input type='text' name='rdOrgNm' class='input_txt00502' ></td>";
    		 	row += "<td ><input type='text' name='rdBusinessNm' class='input_txt00502' ></td>";
    		 	row += "<td ><input type='text' name='rdNm' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='rdStart' id='rdStart"+plusScCnt+"' class='input_txt00503'  title='???????????? ??????'></td>";
    		 	row += "<td><input type='text' name='rdFinish' id='rdFinish"+plusScCnt+"' class='input_txt00503'  title='???????????? ??????'></td>";
    		 	row += "<td><input type='text' name='rdExpenses' class='input_txt00503' ></td>";
    		 	row += "<td class='r_line_none' ><select name='rdForm' class='select00501' title='???????????? ??????'>";
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
    		 	row += "<td><input type='text' name='quSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='quStart' id='quStart"+plusScCnt+"' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='quOrgNm' class='input_txt00502' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501' name='quDivide' title='???????????? ??????'>";
    		 	row += "<option value='''>???????????????</option>";
    		 	row += "<option value='????????????'>????????????</option>";
    		 	row += "<option value='????????????'>????????????</option>";
    			row += "<option value='????????????'>????????????</option>";
    			row += "</select>";
    			row += "</td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='quNm' class='input_txt00501' ></td>";
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
    		 	row += "<td colspan='2' class='r_line_none' ><input type='text' name='reNote' id='resNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' /></td>";
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
    		 	row += "<td colspan='2' class='r_line_none' ><input type='text' name='evNote' id='evlNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' /></td>";
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
    		 	row += "<td colspan='2' class='r_line_none' ><input type='text' name='conNote' id='conNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' /></td>";
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
    		 	row += "<td><input type='text' name='rpSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='rpNm' class='input_txt00501' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501' name='rpType' title='???????????? ??????'>";
    		 	row += "<option value='''>???????????????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    		 	row += "<option value='??????????????????'>??????????????????</option>";
    		 	row += "<option value='???????????????'>???????????????</option>";
    		 	row += "<option value='??????????????????'>??????????????????</option>";
    			row += "<option value='???????????????'>???????????????</option>";
    			row += "</select>";
    			row += "</td>";
    			row += "<td><input type='text' name='rpJournalNm' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='rpStart' id='rpStart"+plusScCnt+"' class='input_txt00503' ></td>";
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
    		 	row += "<td><input type='text' name='ipSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='ipNm' class='input_txt00501' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501'  name='ipType' title='?????????????????? ??????'>";
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
    			row += "<td><input type='text' name='ipPublication' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='ipStart' id='ipStart"+plusScCnt+"' class='input_txt00503' ></td>";
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
    		 	row += "<td><input type='text' name='awSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501'  name='awBadge' title='?????? ??????'>";
    		 	row += "<option value='''>???????????????</option>";
    		 	row += "<option value='??????'>??????</option>";
    		 	row += "<option value='??????'>??????</option>";
    			row += "<option value='??????'>??????</option>";
    			row += "</select>";
    			row += "</td>";
    		 	row += "<td><input type='text' name='awStart' id='awStart"+plusScCnt+"' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='awPresent' class='input_txt00502' ></td>";
    			row += "<td class='r_line_none' ><input type='text' name='awContent' class='input_txt00501' ></td>";
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
   		 	row += "<td><input type='text' name='evName' class='input_txt00501' ></td>";
   		 	row += "<td><input type='text' name='evOrg'  class='input_txt00501' ></td>";
   		 	row += "<td><input type='text' name='evSdate' id='evSdate"+plusScCnt+"' class='input_txt00503' title='???????????? ??????'></td>";
   		 	row += "<td><input type='text' name='evEdate' id='evEdate"+plusScCnt+"' class='input_txt00503' title='???????????? ??????'></td>";
   			row += "<td class='r_line_none' ><input type='text' name='evContent' class='input_txt00501' ></td>";
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
  		 	row += "<td><input type='text' name='conName' class='input_txt00501' ></td>";
  		 	row += "<td><input type='text' name='conOrg' class='input_txt00501' ></td>";
  		 	row += "<td><input type='text' name='conSdate' id='conSdate"+plusScCnt+"' class='input_txt00503' ></td>";
  		 	row += "<td><input type='text' name='conEdate' id='conEdate"+plusScCnt+"' class='input_txt00503' ></td>";
  			row += "<td class='r_line_none' ><input type='text' name='conContent' class='input_txt00501' ></td>";
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
			        }

				/* showButtonPanel:true,
				yearRange: '1980:2020' */
			});


	};
//]]>
</script>