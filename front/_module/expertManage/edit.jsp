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

	String option ="<option value=''>선택하세요</option>";
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
        	result += "<option value=''>선택하세요.</option>";
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
        	result += "<option value=''>선택하세요.</option>";

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

			<h2 style="margin-bottom:10px">전문가 정보 등록</h2>
			<div class="redTxt" >* 필수 입력사항입니다.</div>
			<h4 class="title003">기본정보</h4>
			<table class="skin_view"  summary="기본정보 표입니다. 이름,성별,출생년도,이메일,국적 출생지역,전화번호,휴대전화 등을 입력합니다." >
	   			<caption>기본정보</caption>
                     <colgroup>
                            <col style="width:15%" />
                            <col style="width:35%" />
                            <col style="width:15%" />
                            <col style="width:35%" />
                     </colgroup>
                     <tbody>
                           	<tr>
                           		<th scope="row" ><label for="psnNm">* 이름</label></th>
                           		<td>
                           			<input type="text" name="psnNm" id="psnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" class="inp_txt02" style="border:0px;" readonly/>
                           		</td>
                           		<th scope="row" ><label for="GenderTypeCd">* 성별</label></th>
                           		<td class="r_line_none">
                           		<input type="text" name="GenderTypeCd" id="GenderTypeCd"  <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='남자'" : "value='여자'" %> class="inp_txt02" style="border:0px;"  readonly="readonly"  maxlength="20" />
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" ><label for="birthDate">* 출생년도</label></th>
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
                           		<th scope="row" ><label for="proUserForg">* 국적</label></th>
                           		<td>
                           			<%if(util.getStr(dataMap.get("FRGN_YN")).equals("Y")){
			            				if(util.getStr(dataMap.get("PRO_USER_FORG")).equals("") || util.getStr(dataMap.get("PRO_USER_FORG")).equals(null)){%>
			            					<input type="text" name="proUserForg" id="proUserForg"  class="inp_txt02" style="width:95%;" maxlength="100" />
			            				<%}else{%>
			            					<input type="text" name="proUserForg" id="proUserForg"  value="<%=util.getStr(dataMap.get("PRO_USER_FORG")) %>" readonly="readonly" style="border:0px;" />
			            				<%} %>
			            			<%}else{ %>
			            				<input type="text" name="proUserForg" id="proUserForg"  value="대한민국" class="inp_txt" readonly style="border:0px;" >
			            			<%} %>
                           		</td>
                           		<th scope="row" ><label for="ProUserBirthplace">* 출생지역</label></th>
                           		<td class="r_line_none">
			        					&nbsp;&nbsp;<label for="area_01" >전라남도</label><input type="radio" name="area" id="area_01" value="1"  onclick="areaClick('1')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> checked="checked" <% } %> />
										&nbsp;&nbsp;<label for="area_02" >그 외 지역</label><input type="radio" name="area" id="area_02"value="2"  onclick="areaClick('2')" <% if( util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> checked="checked" <% } %> />&nbsp;&nbsp;
										<select class="select00501" style="width:40%" name="ProUserBirthplace" id="ProUserBirthplace1" title="출생지역 선택(지역 내 목록)" <% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("1") ){ %> style="display:none;"<% } %>>
											<option value="">선택하세요</option>
											<%
												int utilitynumArea = 1;
												for(HashMap rs:areaSigunguList) {
												%>
											<option <%if(util.getStr(dataMap.get("PRO_USER_BIRTHPLACE")).equals(util.getStr(rs.get("CODE_NM")))) { %>selected <% } %>
											value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
											<% utilitynumArea++; } %>
										</select>
										<select class="select00501" name="0" id="ProUserBirthplace2" style="<% if( !util.getStr(dataMap.get("PRO_USER_AREA")).equals("2") ){ %> display:none;<% } %> >width:40%" title="출생지역 선택(지역 외 목록)">
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
                           		<th scope="row" ><label for="telNo">* 전화번호</label></th>
                           		<td>
                           			<%if(util.getStr(dataMap.get("TEL_NO")).equals("")||util.getStr(dataMap.get("TEL_NO")).equals(null)){ %>
                           				<input type="text" name="telNo" id="telNo"  class="inp_txt02" style="width:95%;" maxlength="100" />
                           			<%}else{ %>
                           				<input type="text" name="telNo" id="telNo"  value="<%=util.getStr(dataMap.get("TEL_NO")) %>" class="inp_txt02" style="border:0px;" readonly/>
                           			<%} %>
                        		</td>
                        		<th scope="row" ><label for="cpNo">* 휴대전화</label></th>
                           		<td class="r_line_none">
                           			<%if(util.getStr(dataMap.get("CP_NO")).equals("")||util.getStr(dataMap.get("CP_NO")).equals(null)){ %>
                           				<input type="text" name="cpNo" id="cpNo"  class="inp_txt02" style="width:95%;" maxlength="100" />
                           			<%}else{ %>
                           				<input type="text" name="cpNo" id="cpNo"  value="<%=util.getStr(dataMap.get("CP_NO")) %>" class="inp_txt02" style="border:0px;" readonly />
                           			<%} %>
                        		</td>
                           	</tr>
                           	<tr>
			            		<th scope="row">* 사진첨부</th>
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
													<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;
													<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
													<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

												</li>
											<% fileCnt++; }%>
											</ul>
										</div>
                   						<div id="fileDiv">
											<div style="display: none;" id="<%=fileFullGrp%>fileGrpBox" >
												<div>
													<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
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
									            <input type="checkbox" name="photoCheck" id="photoCheck" value="N"/>&nbsp;사진미등록
						            <% }else{ %>
											<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
												<div>
													<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" />
												</div>
											</div>
											<input type="checkbox" name="photoCheck" id="photoCheck" value="N" checked='checked'/>&nbsp;사진미등록
								      <% } %>
			                	</td>
			            	</tr>
<%if(siteId.endsWith("jntis")){ %>
			            	<tr>
			      	   			<th scope="row" >* 전문가구분</th>
			            		<td colspan="3" class="r_line_none">
									<label for="proJntisPlanning">정책기획</label> <input type="checkbox" name="proJntisPlanning" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_PLANNING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisRnd">연구개발</label> <input type="checkbox" name="proJntisRnd" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_RND"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisCompany">기업지원</label> <input type="checkbox" name="proJntisCompany" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_COMPANY"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJeinet">연구장비</label> <input type="checkbox" name="proJeinet" value="Y" <%=(util.getStr(dataMap.get("PRO_JEINET"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJipbank">지식재산</label> <input type="checkbox" name="proJipbank" value="Y" <%=(util.getStr(dataMap.get("PRO_JIPBANK"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisEducation">인력양성</label> <input type="checkbox" name="proJntisEducation" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_EDUCATION"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisConsulting">컨설팅</label> <input type="checkbox" name="proJntisConsulting" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_CONSULTING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisMarketing">마케팅</label> <input type="checkbox" name="proJntisMarketing" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_MARKETING"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
									<label for="proJntisEtc">기타</label> <input type="checkbox" name="proJntisEtc" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_ETC"))).equals("Y")? "checked='checked'" : "" %> />&nbsp;&nbsp;
								</td>
			            	</tr>
			            	<tr>
			            		<th scope="row" class="tit"><label for="proUserInterestWorld">관심분야</th>
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
<!-- 기본정보 E -->
<!-- 소속정보 S -->
<%if(!(util.getStr(dataMap.get("ORG_GRP_CD"))).equals("") && !(util.getStr(dataMap.get("ORG_GRP_CD"))).equals(null)){ %>
	   		<div style="padding-top:15px"></div>
			<h4 class="title003">소속정보</h4>
            <table class="skin_view" summary="소속정보 표입니다. 기관명,기관유형,홈페이지,대표전화 등을 확인합니다." >
            	<caption>소속정보</caption>
                     <colgroup>
                            <col style="width:15%" />
                            <col style="width:35%" />
                            <col style="width:15%" />
                            <col style="width:35%" />
                     </colgroup>
                     <tbody>
                           	<tr>
                           		<th scope="row" >기관명</th>
                           		<td>
                           			<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
                           		</td>
                           		<th scope="row" >기관유형</th>
                           		<td class="r_line_none">
                           			<%=util.getStr(dataMap.get("ORG_TYPE")) %>
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" >홈페이지</th>
                           		<td>
                           			<%=util.getStr(dataMap.get("HOMEPAGE")) %>
                           		</td>
                           		<th scope="row" >대표전화</th>
                           		<td class="r_line_none">
                           			<%=util.getStr(dataMap.get("CORP_PHONE")) %>
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" >부서명</th>
                           		<td>
                           			<%=util.getStr(dataMap.get("DEPT_NM")) %>
                           		</td>
                           		<th scope="row" >직위</th>
                           		<td class="r_line_none">
                           			<%=util.getStr(dataMap.get("POSITION_NM")) %>
                           		</td>
                           	</tr>
                     </tbody>
	   		</table>
<%} %>
<!-- 소속정보 E -->
<!-- 학력정보 S -->
		<div style="padding-top:15px"></div>
		<h4 class="title003">학력정보</h4>
		<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('academic')" title="학력정보 추가"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('academic')" title="학력정보 제거" /></div>
		</div>
   		<table class="skin_list AlignCenter" summary="학력정보 표입니다.학교명,소재지,취득학위,재학기간,학력정보 등의 정보를 입력합니다." >
   			<caption>학력정보</caption>
            <colgroup>
	            <col style="width:25%" />
          		<col style="width:25%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:25%" />
            </colgroup>
        <tbody id="academiclist">
         	<tr>
         		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="scNm1">학교명</label></th>
         		<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="scLocation1">소재지</label></th>
         		<th scope="row"  colspan="2"><span style="color:red; font-size:11pt;">*</span><label for="scStart1">기간</label></th>
         		<th scope="row" class="r_line_none"><span style="color:red; font-size:11pt;">*</span> <label for="scDegree1">취득학위</label></th>
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
          		<td><input type="text" name="scStart" id="scStart<%=listScInt %>"  value="<%=util.getStr(rs.get("SC_START"))%>" class="input_txt00503" title="학력정보 시작"/></td>
          		<td><input type="text" name="scFinish" id="scFinish<%=listScInt %>"  value="<%=util.getStr(rs.get("SC_FINISH"))%>"class="input_txt00503" title="학력정보 종료"/></td>
          		<td class="r_line_none">
          			<select class="select00501"  name="scDegree" id="scDegree<%=listScInt %>" title="학위 선택">
						<option value="">선택하세요</option>
						<option value="고졸" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("고졸")? "selected='selected'" : "" %>>고졸</option>
						<option value="전문학사" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("전문학사")? "selected='selected'" : "" %>>전문학사</option>
						<option value="학사" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("학사")? "selected='selected'" : "" %>>학사</option>
						<option value="석사" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("석사")? "selected='selected'" : "" %>>석사</option>
						<option value="박사" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("박사")? "selected='selected'" : "" %>>박사</option>
						<option value="기타" <%=(util.getStr(rs.get("SC_DEGREE"))).equals("기타")? "selected='selected'" : "" %>>기타</option>
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
          			<select class="select00501"  name="scDegree" id="scDegree1" title="학위 선택">
						<option value="">선택하세요</option>
						<option value="고졸">고졸</option>
						<option value="전문학사">전문학사</option>
						<option value="학사" >학사</option>
						<option value="석사">석사</option>
						<option value="박사">박사</option>
						<option value="기타">기타</option>
					</select>
          		</td>
          	</tr>
      <%} %>
   		</tbody>
</table>
	<div style="padding-top:15px"></div>
	<h3>○ 전공분야</h3>
	<table class="skin_view"  summary="전공분야 표입니다. 전공계열,복수전공계열 등의 정보를 입력할수 있습니다." >
		<caption>전문분야</caption>
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
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="exMajor<%=listExInt%>">전공계열</label></th>
			<td>
				<select class="select00501" name="exMajor" onchange="majorDeth1('exRealm')" id="exMajor<%=listExInt%>" title="전공계열선택">
					<option value="">선택하세요</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_MAJOR"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="exRealm<%=listExInt %>">전공분야</label></th>
			<td>
<%if(util.getStr(rsEx.get("EX_REALM")).equals("") || util.getStr(rsEx.get("EX_REALM")).equals(null)){ %>
				<select  class="select00501" name="exRealm" id="exRealm<%=listExInt %>" onchange="majorDeth2('exDetail')" title="전공분야 선택"><option>선택하세요.</option></select>
<%}else{ %>
				<select class="select00501"  name="exRealm" id="exRealm<%=listExInt %>" onchange="majorDeth2('exDetail')" title="전공분야 선택">
					<option value="">선택하세요</option>
					<% for(HashMap rs:majorList2) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_REALM"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
<%}%>
			</td>
			<th scope="row" ><span style="color:red; font-size:11pt;">*</span> <label for="exDetail<%=listExInt %>">세부전공</label></th>
			<td class="r_line_none">
<%if(util.getStr(rsEx.get("EX_DETAIL_NAME")).equals("") || util.getStr(rsEx.get("EX_DETAIL_NAME")).equals(null)){ %>
				<input type="text" name="exDetail" class="input_txt00502" id="exDetail<%=listExInt %>">
<%}else{ %>
				<input type="text" name="exDetail" id="exDetail<%=listExInt %>" value="<%=util.getStr(rsEx.get("EX_DETAIL_NAME"))%>" class="input_txt00502">
<%} %>
			</td>
		</tr>
		<tr>
			<th scope="row" ><label for="pluralExMajor<%=listExInt%>">복수전공계열</label></th>
			<td>
				<select class="select00501" name="pluralExMajor" id="pluralExMajor<%=listExInt %>" onchange="majorDeth1('pluralExRealm')" title="복수전공계열 선택">
					<option value="">선택하세요</option>
					<% for(HashMap rs:majorList) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_MAJOR_PLURAL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
			</td>
			<th scope="row" ><label for="pluralExRealm<%=listExInt%>">전공분야</label></th>
			<td>
<%if(util.getStr(rsEx.get("EX_REALM_PLURAL")).equals("") || util.getStr(rsEx.get("EX_REALM_PLURAL")).equals(null)){ %>
				<select class="select00501"  name="pluralExRealm" id="pluralExRealm<%=listExInt%>" onchange="majorDeth2('pluralExDetail')" title="전공분야 선택"><option>선택하세요.</option></select>
<%}else{ %>

				<select class="select00501"  name="pluralExRealm" id="pluralExRealm<%=listExInt%>" onchange="majorDeth2('pluralExDetail')" title="전공분야 선택">
					<option value="">선택하세요</option>
					<% for(HashMap rs:majorList2) {%>
					<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(rsEx.get("EX_REALM_PLURAL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
					<%}%>
				</select>
<%} %>
			</td>
			<th scope="row" ><label for="pluralExDetail<%=listExInt%>">세부전공</label></th>
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
<!-- 학력정보 E -->
<!-- 경력정보 S -->
		<div style="padding-top:15px"></div>
		<h4 class="title003">경력정보</h4>
		<div class="zoom005 PAT20">
			<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('career')" title="경력정보 추가"/>
			<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('career')" title="경력정보 삭제"/>
   		</div>
   		<table class="skin_list AlignCenter" summary="경력정보 표입니다. 직장명,소재지,재직기간,최종직위,주요업무 등의 정보를 입력합니다." >
   			<caption>경력정보</caption>
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
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span><label for="crNm1">직장명</label></th>
          		<th scope="row" ><span style="color:red; font-size:11pt;">*</span><label for="crLocation1">소재지</label></th>
          		<th scope="row"  colspan="2"><span style="color:red; font-size:11pt;">*</span><label for="crStart1">기간</label></th>
				<th scope="row" ><span style="color:red; font-size:11pt;">*</span><label for="crDept1">최종직위</label></th>
          		<th scope="row" class="r_line_none"><span style="color:red; font-size:11pt;">*</span><label for="crWork1">주요업무</label></th>
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
				<td><input type="text" id="crStart<%=listCrInt%>" name="crStart" value="<%=util.getStr(rs.get("CR_START"))%>" class="input_txt00503" title="경력정보 시작" style="width:60px;" /></td>
				<td><input type="text" id="crFinish<%=listCrInt%>" name="crFinish" value="<%=util.getStr(rs.get("CR_FINISH"))%>" class="input_txt00503" title="경력정보 종료" style="width:60px;" />
					<label><input type="checkbox" name="crCheck" id="crCheck<%=listCrInt%>"  value="<%=listCrInt%>"  <%=util.getStr(rs.get("CR_FINISH")).equals("재직 중")?" checked='checked' ":""%>/>재직중</label>
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
				<td><input type="text" name="crStart" id="crStart<%=crCnt%>"  class="input_txt00503"  title="경력정보 시작" style="width:60px;" /></td>
				<td><input type="text" name="crFinish" id="crFinish<%=crCnt%>"  class="input_txt00503"  title="경력정보 종료" style="width:60px;" />
					<label><input type="checkbox" name="crCheck" id="crCheck<%=crCnt%>"  value="<%=crCnt%>" />재직중</label>
				</td>
				<td><input type="text" id="crDept1" name="crDept"  class="input_txt00502" /></td>
				<td class="r_line_none"><input type="text" id="crWork1" name="crWork"  class="input_txt00501" /></td>
			</tr>
		<%}%>
		</tbody>
		</table>
<!-- 경력정보 E -->
<!-- 대외활동 S -->
		<div style="padding-top:15px"></div>
		<h4 class="title003">대외활동</h4>
		<div class="zoom005 PAT20">
			<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('activity')" title="대외활동 추가" />
			<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('activity')" title="대외활동 삭제" />
   		</div>
   		<table class="skin_list AlignCenter"   summary="대외활동 표입니다. 조직(학회)명, 참여기간,직위,주요업무 등을 입력합니다." >
   			<caption>대외활동</caption>
            <colgroup>
          		<col style="width:35%" />
          		<col style="width:10%" />
          		<col style="width:10%" />
         		<col style="width:15%" />
         		<col style="width:30%" />
            </colgroup>
		<tbody id="activitylist">
           	<tr>
           		<th scope="row" ><label for="acNm1">조직(학회)명</label></th>
           		<th scope="row" colspan="2"><label for="acStart1">기간</label></th>
           		<th scope="row" ><label for="acDept1">직위</label></th>
           		<th scope="row" class="r_line_none"><label for="acWork1">주요업무</label></th>
           	</tr>
		<%if(listAC.size()>0){ 
		int listAcInt = 0;
		%>
			<% for(HashMap rs:listAC) {
			listAcInt++;
			%>
         	<tr id="activity<%=acCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'activity')">
         		<td><input type="text" id="acNm<%=listAcInt %>" name="acNm" value="<%=util.getStr(rs.get("AC_NM"))%>" class="input_txt00501" /></td>
         		<td><input type="text" id="acStart<%=listAcInt %>" name="acStart" id="acStart<%=acCnt%>" value="<%=util.getStr(rs.get("AC_START"))%>" class="input_txt00503" title="대외활동기간 시작" /></td>
         		<td><input type="text" id="acFinish<%=listAcInt %>" name="acFinish" id="acFinish<%=acCnt%>" value="<%=util.getStr(rs.get("AC_FINISH"))%>" class="input_txt00503"  title="대외활동기간 종료" /></td>
         		<td><input type="text" id="acDept<%=listAcInt %>" name="acDept" value="<%=util.getStr(rs.get("AC_DEPT"))%>" class="input_txt00502" /></td>
         		<td class="r_line_none"><input type="text" id="acWork<%=listAcInt %>" name="acWork" value="<%=util.getStr(rs.get("AC_WORK"))%>" class="input_txt00501" /></td>
         	</tr>
         	<%acCnt++;
         	}
		}else{%>
			<tr id="activity<%=acCnt%>">
         		<td><input type="text" name="acNm" id="acNm1" class="input_txt00501" /></td>
         		<td><input type="text" name="acStart" id="acStart1" class="input_txt00503" title="대외활동기간 시작"/></td>
         		<td><input type="text" name="acFinish" id="acFinish1" class="input_txt00503" title="대외활동기간 종료"/></td>
         		<td><input type="text" name="acDept" id="acDept1" class="input_txt00502" /></td>
         		<td class="r_line_none"><input type="text" name="acWork" id="acWork1" class="input_txt00501" /></td>
         	</tr>
		<%} %>
		</tbody>
	</table>
<!-- 대외활동 E -->
<!-- 연구개발과제(프로젝트) 수행실적 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">연구개발과제(프로젝트) 수행실적</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('RnDresult')" title="연구개발과제 추가" />
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('RnDresult')" title="연구개발과제 삭제" />
	</div>
	<table class="skin_list AlignCenter" summary="연구개발과제(프로젝트) 수행실적 표입니다. 부처/기관/발주처명, 사업명,과제명,총사업참여기간,사업비,참여형태 등을 입력합니다." >
		<caption>연구개발과제(프로젝트) 수행실적</caption>
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
       		<th scope="row" ><label for="rdSerialNum1">연번</label></th>
       		<th scope="row" ><label for="rdOrgNm1">부처/기관/발주처명</label></th>
       		<th scope="row" ><label for="rdBusinessNm1">사업명</label></th>
       		<th scope="row" ><label for="rdNm1">과제명</label></th>
       		<th scope="row"  colspan="2"><label for="rdStart<%=rdCnt%>">총사업참여기간</label></th>
       		<th scope="row" ><label for="rdExpenses1">사업비</label></th>
       		<th scope="row" class="r_line_none"><label for="rdForm1">참여형태</label></th>
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
     		<td><input type="text" id="rdStart<%=rdCnt%>" name="rdStart" value="<%=util.getStr(rs.get("RD_START"))%>" class="input_txt00503" title="사업기간 시작" /></td>
     		<td><input type="text" id="rdFinish<%=rdCnt%>" name="rdFinish" value="<%=util.getStr(rs.get("RD_FINISH"))%>" class="input_txt00503" title="사업기간 종료" /></td>
     		<td><input type="text" id="rdExpenses<%=listRdInt %>" name="rdExpenses" value="<%=util.getStr(rs.get("RD_EXPENSES"))%>" class="input_txt00503" /></td>
       		<td class="r_line_none">
       			<select class="select00501" id="rdForm<%=listRdInt %>" name="rdForm" title="참여형태 선택">
       				<option value="" <%=(util.getStr(rs.get("RD_FORM"))).equals("")? "selected='selected'" : "" %>>선택</option>
       				<option value="총괄책임자" <%=(util.getStr(rs.get("RD_FORM"))).equals("총괄책임자")? "selected='selected'" : "" %>>총괄책임자</option>
       				<option value="참여or위탁책임자" <%=(util.getStr(rs.get("RD_FORM"))).equals("참여or위탁책임자")? "selected='selected'" : "" %>>참여or위탁책임자</option>
       				<option value="실무담당자" <%=(util.getStr(rs.get("RD_FORM"))).equals("실무담당자")? "selected='selected'" : "" %>>실무담당자</option>
       				<option value="참여연구원" <%=(util.getStr(rs.get("RD_FORM"))).equals("참여연구원")? "selected='selected'" : "" %>>참여연구원</option>
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
     		<td><input type="text" id="rdStart0" name="rdStart" class="input_txt00503" title="사업기간 시작" /></td>
     		<td><input type="text" id="rdFinish0" name="rdFinish" class="input_txt00503" title="사업기간 종료" /></td>
     		<td><input type="text" id="rdExpenses1" name="rdExpenses" class="input_txt00503" /></td>
       		<td class="r_line_none">
       			<select class="select00501"  id="rdForm1" name="rdForm">
       				<option value="">선택</option>
       				<option value="총괄책임자">총괄책임자</option>
       				<option value="참여or위탁책임자">참여or위탁책임자</option>
       				<option value="실무담당자">실무담당자</option>
       				<option value="참여연구원">참여연구원</option>
       			</select>
       		</td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- 연구개발과제(프로젝트) 수행실적 E -->

<!-- 외부평가 수행실적 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">외부평가 수행실적</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('resultEv')" title="실적 추가" />
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('resultEv')" title="실적 삭제" />
	</div>
	<table class="skin_list"  summary="외부평가 수행실적 표입니다. 평가대상 사업명,요청기관명,평가기간,평가내용 등을 입력합니다."  >
		<caption>외부평가 수행실적</caption>
        <colgroup>
	        	<col style="width:30%" />
			    <col style="width:20%" />
			    <col style="width:10%" />
			    <col style="width:10%" />
			    <col style="width:30%" />
        </colgroup>
	<tbody id="resultEvlist">
		<tr>
	 		<th scope="row" ><label for="evName0">평가대상 사업명(평가명)</label></th>
	 		<th scope="row" ><label for="evOrg0">요청기관명</label></th>
	 		<th scope="row" colspan="2"><label for="evSdate0">평가기간</label></th>
	 		<th scope="row" class="r_line_none"><label for="evContent0">평가내용</label></th>
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
 	  			<input type="text" name="evSdate" id="evSdate<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_SDATE"))%>" class="input_txt00503" title="평가기간 시작">
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%=resultEvCnt %>" value="<%=util.getStr(rs.get("EV_EDATE"))%>" class="input_txt00503" title="평가기간 삭제">
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
 	  			<input type="text" name="evSdate" id="evSdate<%=resultEvCnt %>" class="input_txt00503" title="평가기간 시작" >
 	  		</td>
 	  		<td>
 	  			<input type="text" name="evEdate" id="evEdate<%=resultEvCnt %>" class="input_txt00503" title="평가기간 종료" >
 	  		</td>
   			<td class="r_line_none">
   				<input type="text" name="evContent" id="evContent<%=resultEvCnt %>" class="input_txt00501" >
   			</td>
     	</tr>
<%} %>
	</tbody>
	</table>
<!-- 외부평가 수행실적 E -->
<!-- 컨설팅 수행실적 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">컨설팅 수행실적</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('resultCon')" title="수행실적 추가"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('resultCon')" title="수행실적 제거"/>
	</div>
	<table class="skin_list"   summary="컨설팅 수행실적 표입니다. 컨설팅 사업명,요청기관명,컨설팅기간,컨설팅 내용 등을 입력합니다." >
		<caption>컨설팅 수행실적</caption>
        <colgroup>
	        	<col style="width:30%" />
			    <col style="width:20%" />
			    <col style="width:10%" />
			    <col style="width:10%" />
			    <col style="width:30%" />
        </colgroup>
	<tbody id="resultConlist">
		<tr>
	 		<th scope="row" class="tit"><label for="conName<%=resultConCnt %>">컨설팅 사업명(컨설팅명)</label></th>
	 		<th scope="row" class="tit"><label for="conOrg<%=resultConCnt %>">요청기관명</label></th>
	 		<th scope="row" class="tit" colspan="2"><label for="conSdate<%=resultConCnt %>">컨설팅기간</label></th>
	 		<th scope="row" class="tit"><label for="conContent<%=resultConCnt %>">컨설팅내용</label></th>
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
<!-- 컨설팅 수행실적 E -->



<!-- 연구논문 실적 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">연구논문 실적</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('researchPaper')" title="연구논문 실적 추가"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('researchPaper')" title="연구논문 실적 삭제"/>
	</div>
	<table class="skin_list AlignCenter" summary="연구논문 실적표입니다.연번,논문명,논문유형,학술지명,게제년도 등을 입력합니다." >
		<caption>연구논문 실적</caption>
	       <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
	       </colgroup>
 	<tbody id="researchPaperlist">
       	<tr>
       		<th scope="row" ><label for="rpSerialNum<%=rpCnt%>">연번</label></th>
       		<th scope="row" ><label for="rpNm<%=rpCnt%>">논문명</label></th>
       		<th scope="row" ><label for="rpType<%=rpCnt%>">논문유형</label></th>
       		<th scope="row" ><label for="rpJournalNm<%=rpCnt%>">학술지명</label></th>
       		<th scope="row" class="r_line_none"><label for="rpStart<%=rpCnt%>">게제년도</label></th>

       	</tr>
 	<%if(listRP.size()>0){ %>
		<% for(HashMap rs:listRP) {%>
     	<tr id="researchPaper<%=rpCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'researchPaper')">
     		<td><input type="text" id="rpSerialNum<%=rpCnt%>" name="rpSerialNum" value="<%=util.getStr(rs.get("RP_SERIAL_NUM"))%>" class="input_txt00503" /></td>
     		<td><input type="text" id="rpNm<%=rpCnt%>" name="rpNm" value="<%=util.getStr(rs.get("RP_NM"))%>" class="input_txt00501" /></td>
     		<td>
				<select  class="select00501"  name="rpType" id="rpType<%=rpCnt%>" title="논문유형 선택">
       				<option value="" <%=(util.getStr(rs.get("RP_TYPE"))).equals("")? "selected='selected'" : "" %>>선택</option>
       				<option value="국내학술지" <%=(util.getStr(rs.get("RP_TYPE"))).equals("국내학술지")? "selected='selected'" : "" %>>국내학술지</option>
       				<option value="국내학술대회" <%=(util.getStr(rs.get("RP_TYPE"))).equals("국내학술대회")? "selected='selected'" : "" %>>국내학술대회</option>
       				<option value="국외학술지" <%=(util.getStr(rs.get("RP_TYPE"))).equals("국외학술지")? "selected='selected'" : "" %>>국외학술지</option>
       				<option value="국외학술대회" <%=(util.getStr(rs.get("RP_TYPE"))).equals("국외학술대회")? "selected='selected'" : "" %>>국외학술대회</option>
       				<option value="기타학술지" <%=(util.getStr(rs.get("RP_TYPE"))).equals("기타학술지")? "selected='selected'" : "" %>>기타학술지</option>
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
				<select class="select00501"  name="rpType" id="rpType<%=rpCnt%>" title="논문유형 선택">
       				<option value="">선택</option>
       				<option value="국내학술지">국내학술지</option>
       				<option value="국내학술대회">국내학술대회</option>
       				<option value="국외학술지">국외학술지</option>
       				<option value="국외학술대회">국외학술대회</option>
       				<option value="기타학술지">기타학술지</option>
       			</select>
     		</td>
     		<td><input type="text" name="rpJournalNm" class="input_txt00502" id="rpJournalNm<%=rpCnt%>" /></td>
     		<td class="r_line_none"><input type="text" name="rpStart" id="rpStart<%=rpCnt%>" class="input_txt00503" /></td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- 연구논문 실적 E -->
<!-- 지식재산 실적 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">지식재산 실적</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('inProperty')" title="지적재산 실적 추가"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('inProperty')" title="지적재산 실적 삭제"/>
	</div>
	<table class="skin_list AlignCenter" summary="지식재산 실적 표입니다. 연번,지식재산명,지식재산유형,인증/발행처,등록년도 등을 입력합니다." >
		<caption>지식재산 실적</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:34%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:10%" />
        </colgroup>
 	<tbody id="inPropertylist">
       	<tr>
       		<th scope="row" ><label for="ipSerialNum<%=ipCnt%>">연번</label></th>
       		<th scope="row" ><label for="ipNm<%=ipCnt%>">지식재산명</label></th>
       		<th scope="row" ><label for="ipType<%=ipCnt%>">지식재산유형</label></th>
       		<th scope="row" ><label for="ipPublication<%=ipCnt%>">인증/발행처</label></th>
       		<th scope="row" class="r_line_none"><label for="ipStart<%=ipCnt%>">등록년도</label></th>

       	</tr>
 	<%if(listIP.size()>0){ %>
		<% for(HashMap rs:listIP) {%>
     	<tr id="inProperty<%=ipCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'inProperty')">
     		<td><input type="text" id="ipSerialNum<%=ipCnt%>" name="ipSerialNum" value="<%=util.getStr(rs.get("IP_SERIAL_NUM"))%>" class="input_txt00503"  /></td>
     		<td><input type="text" id="ipNm<%=ipCnt%>" name="ipNm" value="<%=util.getStr(rs.get("IP_NM"))%>"  class="input_txt00501"  /></td>
     		<td>
				<select class="select00501" name="ipType" id="ipType<%=ipCnt%>" title="지식재산유형 선택">
       				<option value=""  <%=(util.getStr(rs.get("IP_TYPE"))).equals("")? "selected='selected'" : "" %>>선택</option>
       				<option value="특허" <%=(util.getStr(rs.get("IP_TYPE"))).equals("특허")? "selected='selected'" : "" %>>특허</option>
       				<option value="실용신안" <%=(util.getStr(rs.get("IP_TYPE"))).equals("실용신안")? "selected='selected'" : "" %>>실용실안</option>
       				<option value="상표" <%=(util.getStr(rs.get("IP_TYPE"))).equals("상표")? "selected='selected'" : "" %>>상표</option>
       				<option value="디자인" <%=(util.getStr(rs.get("IP_TYPE"))).equals("디자인")? "selected='selected'" : "" %>>디자인</option>
       				<option value="프로그램" <%=(util.getStr(rs.get("IP_TYPE"))).equals("프로그램")? "selected='selected'" : "" %>>프로그램</option>
       				<option value="저작권" <%=(util.getStr(rs.get("IP_TYPE"))).equals("저작권")? "selected='selected'" : "" %>>저작권</option>
       				<option value="기타지식재산" <%=(util.getStr(rs.get("IP_TYPE"))).equals("기타지식재산")? "selected='selected'" : "" %>>기타지식재산</option>
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
				<select class="select00501"  name="ipType" id="ipType<%=ipCnt%>" title="지식재산유형 선택">
       				<option value="">선택</option>
       				<option value="득허">특허</option>
       				<option value="실용신안">실용실안</option>
       				<option value="상표">상표</option>
       				<option value="디자인">디자인</option>
       				<option value="프로그램">프로그램</option>
       				<option value="저작권">저작권</option>
       				<option value="기타지식재산">기타지식재산</option>
       			</select>
     		</td>
     		<td><input type="text" id="ipPublication<%=ipCnt%>" name="ipPublication" class="input_txt00502" /></td>
     		<td class="r_line_none"><input type="text" name="ipStart" id="ipStart<%=ipCnt%>" class="input_txt00503" /></td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- 지식재산 실적 E -->
<!-- 수상 실적 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">수상실적</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('awardCareer')" />
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('awardCareer')" />
	</div>
	<table class="skin_list AlignCenter" summary="수상실적 표입니다. 연번,훈격,수여일자,수여기관,공적내용 등을 입력합니다." >
		<caption>수상 실적</caption>
        <colgroup>
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
        </colgroup>
 	<tbody id="awardCareerlist">
       	<tr>
       		<th scope="row" ><label for="awSerialNum<%=awCnt%>">연번</label></th>
       		<th scope="row" ><label for="awBadge<%=awCnt%>">훈격</label></th>
       		<th scope="row" ><label for="awStart<%=awCnt%>">수여일자</label></th>
       		<th scope="row" ><label for="awPresent<%=awCnt%>">수여기관</label></th>
       		<th scope="row" class="r_line_none"><label for="awContent<%=awCnt%>">공적내용</label></th>

       	</tr>
 	<%if(listAW.size()>0){ %>
		<% for(HashMap rs:listAW) {%>
     	<tr id="awardCareer<%=awCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'awardCareer')">
     		<td><input type="text" id="awSerialNum<%=awCnt%>" name="awSerialNum" value="<%=util.getStr(rs.get("AW_SERIAL_NUM"))%>"  class="input_txt00503" /></td>
     		<td>
				<select class="select00501"   name="awBadge" id="awBadge<%=awCnt%>" title="훈격 선택">
       				<option value="" <%=(util.getStr(rs.get("AW_BADGE"))).equals("")? "selected='selected'" : "" %>>선택</option>
       				<option value="훈장" <%=(util.getStr(rs.get("AW_BADGE"))).equals("훈장")? "selected='selected'" : "" %>>훈장</option>
       				<option value="포장" <%=(util.getStr(rs.get("AW_BADGE"))).equals("포장")? "selected='selected'" : "" %>>포장</option>
       				<option value="표창" <%=(util.getStr(rs.get("AW_BADGE"))).equals("표창")? "selected='selected'" : "" %>>표창</option>
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
				<select class="select00501"   name="awBadge"  id="awBadge<%=awCnt%>" title="훈격 선택">
       				<option value="">선택</option>
       				<option value="훈장">훈장</option>
       				<option value="포장">포장</option>
       				<option value="표창">표창</option>
       			</select>
     		</td>
     		<td><input type="text" name="awStart" id="awStart<%=awCnt%>"  class="input_txt00503" /></td>
     		<td><input type="text" name="awPresent"  id="awPresent<%=awCnt%>" class="input_txt00502"  /></td>
     		<td class="r_line_none"><input type="text"  id="awContent<%=awCnt%>" name="awContent"  class="input_txt00501" /></td>
		</tr>
	<%} %>
	</tbody>
	</table>
<!-- 수상 실적 E -->

<!-- 자격사항 S -->
	<div style="padding-top:15px"></div>
	<h4 class="title003">자격사항</h4>
	<div class="zoom005 PAT20">
		<input type="button" name="addbtn" class="btn_add005"  value="+" style="" onclick="addRow('qualification')" title="자격사항 추가"/>
		<input type="button" name="delbtn" class="btn_add005" value="-" style="" onclick="delRow('qualification')" title="자격사항 삭제"/>
	</div>
	<table class="skin_list AlignCenter" summary="자격사항 표입니다.연번,취득일,발급기관명,자격구분,자격명등을 입력합니다." >
		<caption>자격사항</caption>
	    <colgroup>
			<col style="width:10%" />
	        <col style="width:10%" />
	        <col style="width:23%" />
	        <col style="width:23%" />
	       	<col style="width:34%" />
		</colgroup>
	<tbody id="qualificationlist">
       	<tr>
       		<th scope="row" ><label for="quSerialNum<%=quCnt%>">연번</label></th>
       		<th scope="row" ><label for="quStart<%=quCnt%>">취득일</label></th>
       		<th scope="row" ><label for="quOrgNm<%=quCnt%>">발급기관명</label></th>
       		<th scope="row" ><label for="quDivide<%=quCnt%>">자격구분</label></th>
       		<th scope="row" class="r_line_none"><label for="quNm<%=quCnt%>">자격명</label></th>
       	</tr>
	<%if(listQU.size()>0){ %>
		<% for(HashMap rs:listQU) {%>
       	<tr id="qualification<%=quCnt%>" onclick="setLicenseBtn(<%=scCnt%>, 'qualification')">
       		<td><input type="text" id="quSerialNum<%=quCnt%>" name="quSerialNum" value="<%=util.getStr(rs.get("QU_SERIAL_NUM"))%>"  class="input_txt00503"/></td>
       		<td><input type="text" name="quStart" id="quStart<%=quCnt%>"  value="<%=util.getStr(rs.get("QU_START"))%>"  class="input_txt00503"/></td>
       		<td>
       		<input type="text" id="quOrgNm<%=quCnt%>" name="quOrgNm" value="<%=util.getStr(rs.get("QU_ORG_NM"))%>"  class="input_txt00502" /></td>
       		<td>
       			<select class="select_box" id="quDivide<%=quCnt%>" name="quDivide" title="자격구분 선택">
       				<option value=""  <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("")? "selected='selected'" : "" %>>선택하세요</option>
       				<option value="국가공인" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("국가공인")? "selected='selected'" : "" %>>국가공인</option>
       				<option value="국제공인" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("국제공인")? "selected='selected'" : "" %>>국제공인</option>
       				<option value="시설가격" <%=(util.getStr(rs.get("QU_DIVIDE"))).equals("시설가격")? "selected='selected'" : "" %>>시설가격</option>
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
       			<select class="select_box"  name="quDivide" id="quDivide<%=quCnt%>" title="자격구분 선택">
       				<option value="">선택하세요</option>
       				<option value="국가공인">국가공인</option>
       				<option value="국제공인">국제공인</option>
       				<option value="시설가격">시설가격</option>
       			</select>
       		</td>
       		<td class="r_line_none"><input type="text" name="quNm" id="quNm<%=quCnt%>" class="input_txt00501" /></td>
       	</tr>
	<%} %>
	</tbody>
	</table>
<!-- 자격사항 E -->
              <!-- bo_btn  -->
              <div class="b_btn_area" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_rgt" value="수정하기" onclick="goCheck()"/>
                     <input type="button" class="btn_lft2" value="목록" onclick="goSubmit('list')"/>
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
		alert("전문가등록 요청중입니다.");
	}
	if($('#proState').val() == "20"){
		alert("전문가등록이 되어있습니다. 수정페이지로 이동합니다.");
	}
});

	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^가-힣]/;
	var characPattern = /[^a-zA-Z0-9][^가-힣]/;
	var engPattern  = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var datePattern = /^[0-9]{4}-[0-9]{2}/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
	var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;

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
//사진미등록 선택 S
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
//사진미등록 선택 E
//기본정보-출생지역 E
function goCheck(){
		if($('input[name=proJipbank]').is(":checked") == false && $('input[name=proJeinet]').is(":checked") == false && $('input[name=proJntisRnd]').is(":checked") == false && $('input[name=proJntisCompany]').is(":checked") == false && $('input[name=proJntisEducation]').is(":checked") == false && $('input[name=proJntisEtc]').is(":checked") == false ){
			alert("전문가구분을 선택해주세요");
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
	           			alert("파일을 첨부하세요.");
	           			return false;
	           		}else{
	           			alert("이미지 파일만 첨부하실 수 있습니다.");
	           			return false;
	           		}
			  	}
			}
		}
		if($('#birthDate').val() == "" || $('#birthDate').val() == null || $('#email').val() == "" || $('#email').val() == null || $('#proUserForg').val() == "" || $('#proUserForg').val() == null || $('#telNo').val() == "" || $('#telNo').val() == null || $('#cpNo').val() == "" || $('#cpNo').val() == null ){
			alert("기본정보는 필수 값 입니다.");
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
        	result += "<option value=''>선택하세요.</option>";
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
        	result += "<option value=''>선택하세요.</option>";
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
        	result += "<option value=''>선택하세요.</option>";
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
        	result += "<option value=''>선택하세요.</option>";

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
   	nextText : '다음 달',
   	prevText : '이전 달',
   	currentText : '오늘 날짜',
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
   	/* showButtonPanel:true,
	yearRange: '1980:2020' */
   });

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
    		 	row += "<td><input type='text' name='scNm' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='scLocation' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='scStart' id='scStart"+plusScCnt+"' class='input_txt00503' title='학력기간 시작'></td>";
    		 	row += "<td><input type='text' name='scFinish' id='scFinish"+plusScCnt+"' class='input_txt00503' title='학력기간 종료'></td>";
    		 	row += "<td class='r_line_none' ><select name='scDegree' class='select00501' title='학위 선택'>";
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
    		 	row += "<td><input type='text' name='crNm' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='crLocation' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='crStart' id='crStart"+plusScCnt+"' class='input_txt00503' title='경력기간 시작' style='width:60px;' /></td>";
    		 	row += "<td><input type='text' name='crFinish' id='crFinish"+plusScCnt+"' class='input_txt00503' title='경력기간 종료' style='width:60px;' />";
    		 	row += "<label><input type='checkbox' name='crCheck' id='crCheck"+plusScCnt+"' value='"+plusScCnt+"' />재직중</label>";
    		 	row += "</td>";
    		 	row += "<td><input type='text' name='crDept' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='crWork' class='input_txt00501' ></td>";
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
    		 	row += "<td><input type='text' name='acNm' class='input_txt00501' ></td>";
    		 	row += "<td><input type='text' name='acStart' id='acStart"+plusScCnt+"' class='input_txt00503'  title='대외활동기간 시작'></td>";
    		 	row += "<td><input type='text' name='acFinish' id='acFinish"+plusScCnt+"' class='input_txt00503'  title='대외활동기간 종료'></td>";
    		 	row += "<td><input type='text' name='acDept' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='acWork' class='input_txt00501' ></td>";
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
    		 	row += "<td ><input type='text' name='rdSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td ><input type='text' name='rdOrgNm' class='input_txt00502' ></td>";
    		 	row += "<td ><input type='text' name='rdBusinessNm' class='input_txt00502' ></td>";
    		 	row += "<td ><input type='text' name='rdNm' class='input_txt00502' ></td>";
    		 	row += "<td><input type='text' name='rdStart' id='rdStart"+plusScCnt+"' class='input_txt00503'  title='사업기간 시작'></td>";
    		 	row += "<td><input type='text' name='rdFinish' id='rdFinish"+plusScCnt+"' class='input_txt00503'  title='사업기간 종료'></td>";
    		 	row += "<td><input type='text' name='rdExpenses' class='input_txt00503' ></td>";
    		 	row += "<td class='r_line_none' ><select name='rdForm' class='select00501' title='참여형태 선택'>";
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
    		 	row += "<td><input type='text' name='quSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='quStart' id='quStart"+plusScCnt+"' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='quOrgNm' class='input_txt00502' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501' name='quDivide' title='자격구분 선택'>";
    		 	row += "<option value='''>선택하세요</option>";
    		 	row += "<option value='국가공인'>국가공인</option>";
    		 	row += "<option value='국제공인'>국제공인</option>";
    			row += "<option value='시설가격'>시설가격</option>";
    			row += "</select>";
    			row += "</td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='quNm' class='input_txt00501' ></td>";
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
    		 	row += "<td colspan='2' class='r_line_none' ><input type='text' name='reNote' id='resNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' /></td>";
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
    		 	row += "<td colspan='2' class='r_line_none' ><input type='text' name='evNote' id='evlNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' /></td>";
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
    		 	row += "<td colspan='2' class='r_line_none' ><input type='text' name='conNote' id='conNote"+plusScCnt+"' style='width:95%;' class='inp_txt02' /></td>";
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
    		 	row += "<td><input type='text' name='rpSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='rpNm' class='input_txt00501' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501' name='rpType' title='논문유형 선택'>";
    		 	row += "<option value='''>선택하세요</option>";
    		 	row += "<option value='국내학술지'>국내학술지</option>";
    		 	row += "<option value='국내학술대회'>국내학술대회</option>";
    		 	row += "<option value='국외학술지'>국외학술지</option>";
    		 	row += "<option value='국외학술대회'>국외학술대회</option>";
    			row += "<option value='기타학술지'>기타학술지</option>";
    			row += "</select>";
    			row += "</td>";
    			row += "<td><input type='text' name='rpJournalNm' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='rpStart' id='rpStart"+plusScCnt+"' class='input_txt00503' ></td>";
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
    		 	row += "<td><input type='text' name='ipSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='ipNm' class='input_txt00501' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501'  name='ipType' title='지식재산유형 선택'>";
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
    			row += "<td><input type='text' name='ipPublication' class='input_txt00502' ></td>";
    		 	row += "<td class='r_line_none' ><input type='text' name='ipStart' id='ipStart"+plusScCnt+"' class='input_txt00503' ></td>";
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
    		 	row += "<td><input type='text' name='awSerialNum' class='input_txt00503' ></td>";
    		 	row += "<td>";
    		 	row += "<select class='select00501'  name='awBadge' title='훈격 선택'>";
    		 	row += "<option value='''>선택하세요</option>";
    		 	row += "<option value='훈장'>훈장</option>";
    		 	row += "<option value='포장'>포장</option>";
    			row += "<option value='표창'>표창</option>";
    			row += "</select>";
    			row += "</td>";
    		 	row += "<td><input type='text' name='awStart' id='awStart"+plusScCnt+"' class='input_txt00503' ></td>";
    		 	row += "<td><input type='text' name='awPresent' class='input_txt00502' ></td>";
    			row += "<td class='r_line_none' ><input type='text' name='awContent' class='input_txt00501' ></td>";
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
   		 	row += "<td><input type='text' name='evName' class='input_txt00501' ></td>";
   		 	row += "<td><input type='text' name='evOrg'  class='input_txt00501' ></td>";
   		 	row += "<td><input type='text' name='evSdate' id='evSdate"+plusScCnt+"' class='input_txt00503' title='평가기간 시작'></td>";
   		 	row += "<td><input type='text' name='evEdate' id='evEdate"+plusScCnt+"' class='input_txt00503' title='평가기간 종료'></td>";
   			row += "<td class='r_line_none' ><input type='text' name='evContent' class='input_txt00501' ></td>";
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
				currentText : '오늘 날짜',
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

				/* showButtonPanel:true,
				yearRange: '1980:2020' */
			});


	};
//]]>
</script>