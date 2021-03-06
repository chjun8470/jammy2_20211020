<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
// 	String fileGrp = "jntptotal";
// 	String fileSubGrp = "";
// 	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));
%>
<form id = "fview" name = "fview" method="post" action="/sys/sys_org_user_change.do" >
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "userIdx" name = "userIdx" value = "<%=util.getStr(String.valueOf(dataMap.get("USER_IDX")))%>"/>
	<div class="clear_wrap">
			<div class="left_box w75">
				<div class="box_in">
					<table class="skin_basic_write" summary="??????????????? ???????????? ??? ?????????">
	                	<caption>??????????????????</caption>
	                	<colgroup>
	               			<col width="30%">
	               			<col width="25%">
	               			<col width="">
	                	</colgroup>
	                	<tbody>
	                	<tr>
                			<th scope="col"><label for="regDt">????????????</label></th>
                			<td colspan="3"><%=util.getStr(dataMap.get("CHANGE_ORG_DATE"))%></td>
                		</tr>
                		<tr>	
                			<th scope="col"><label for="state">??????</label></th>
                			<td colspan="3"><%=util.getStr(dataMap.get("CHANGE_ORG"))%></td>
                		</tr>
                		<tr id="trAcceptNo" <%if(!util.getStr(dataMap.get("CHANGE_ORG")).equals("??????")) { %>style="display:none" <% } %>>
                			<th scope="col"><label for="">????????????</label></th>
                			<td colspan="3"><%=util.getStr(dataMap.get("CHANGE_ORG_NO"))%></td>
                		</tr>
                    	<tr>
                			<th scope="col"><label for="blngOrgNm">??????</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_NM"))%></td>
<!--                 			<th scope="col"><label for="blngOrgGubun">????????????</label></th> -->
<%--                 			<td><%=util.getStr(dataMap.get("BLNG_ORG_GUBUN"))%></td> --%>
						</tr>
						<tr>
                			<th scope="col"><label for="blngOrgAddr">????????????</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_ADDR"))%></td>
                			<th scope="col"><label for="blngOrgAddrDtl">??????????????????</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_ADDR_DTL"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="deptNm">?????????</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_NM"))%></td>
                			<th scope="col"><label for="deptZipCode">??????????????????</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_ZIP_CODE"))%></td>
                		</tr>
                		<tr>	
                			<th scope="col"><label for="deptAddr">????????????</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_ADDR"))%></td>
                			<th scope="col"><label for="deptAddrDtl">??????????????????</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_ADDR_DTL"))%></td>
                		</tr>
                		
                		
                		<tr>
                			<th scope="col"><label for="psnNm">??????</label></th>
                			<td><%=util.getStr(dataMap.get("PSN_NM"))%></td>
                			<th scope="col"><label for="engPsnNm">?????????</label></th>
                			<td><%=util.getStr(dataMap.get("ENG_PSN_NM"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="birthDate">??????</label></th>
                			<td><%=util.getStr(dataMap.get("BIRTH_DATE"))%></td>
                			<th scope="col"><label for="genderTypeCd">??????</label></th>
                			<td><%=util.getStr(dataMap.get("GENDER_TYPE_CD"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="userId">?????????</label></th>
                			<td><%=util.getStr(dataMap.get("USER_ID"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="jobDivCd">??????</label></th>
                			<td><%=util.getStr(dataMap.get("JOB_DIV_CD"))%></td>
                			<th scope="col"><label for="position">??????</label></th>
                			<td><%=util.getStr(dataMap.get("POSITION"))%></td>
                		</tr>
                		<tr>	
                			<th scope="col"><label for="positionNm">??????</label></th>
                			<td><%=util.getStr(dataMap.get("POSITION_NM"))%></td>
                			<th scope="col"><label for="institJobNm">????????????</label></th>
                			<td><%=util.getStr(dataMap.get("INSTIT_JOB_NM"))%></td>
                		</tr>
                		
                		<tr>
                			
                			<th scope="col"><label for="frgnYn">???????????????</label></th>
                			<td><%=util.getStr(dataMap.get("FRGN_YN"))%></td>
                			<th scope="col"><label for="dmabrSlctCd">???????????????</label></th>
                			<td><%=util.getStr(dataMap.get("DMABR_SLCT_CD"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="blngOrgZipCode">????????????</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_ZIP_CODE"))%></td>
                		</tr>
                		<tr>
                		<th>???????????????</th>
                		<td colspan="3">
                		<table class="skin_basic_write">
                		<colgroup>
	               			<col width="13%">
	               			<col width="20%">
	               			<col width="12%">
	               			<col width="20%">
	               			<col width="15%">
	               			<col width="20%">
	                	</colgroup>
	                	<tbody>
                		<tr>
                			<th scope="col"><label for="emialId">?????????</label></th>
                			<td><%=util.getStr(dataMap.get("EMAIL_ID"))%></td>
                			<th scope="col"><label for="emailDomain">??????????????????</label></th>
                			<td><%=util.getStr(dataMap.get("EMAIL_DOMAIN"))%></td>
                			<th scope="col"><label for="emailRecvYn">??????????????????</label></th>
                			<td><%=util.getStr(dataMap.get("EMAIL_RECV_YN"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="telNo1">????????????1</label></th>
                			<td><%=util.getStr(dataMap.get("TEL_NO1"))%></td>
                			<th scope="col"><label for="telNo2">????????????2</label></th>
                			<td><%=util.getStr(dataMap.get("TEL_NO2"))%></td>
                			<th scope="col"><label for="telNo3">????????????3</label></th>
                			<td><%=util.getStr(dataMap.get("TEL_NO3"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="cpNo1">?????????1</label></th>
                			<td><%=util.getStr(dataMap.get("CP_NO1"))%></td>
                			<th scope="col"><label for="cpNo2">?????????2</label></th>
                			<td><%=util.getStr(dataMap.get("CP_NO2"))%></td>
                			<th scope="col"><label for="cpNo3">?????????3</label></th>
                			<td><%=util.getStr(dataMap.get("CP_NO3"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="faxNo1">????????????1</label></th>
                			<td><%=util.getStr(dataMap.get("FAX_NO1"))%></td>
                			<th scope="col"><label for="faxNo2">????????????2</label></th>
                			<td><%=util.getStr(dataMap.get("FAX_NO2"))%></td>
                			<th scope="col"><label for="faxNo3">????????????3</label></th>
                			<td><%=util.getStr(dataMap.get("FAX_NO3"))%></td>
                		</tr>
                		</tbody>
                		</table>
                		
                		</td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="userTypeCd">???????????????</label></th>
                			<td><%=util.getStr(dataMap.get("USER_TYPE_CD"))%></td>
                			<th scope="col"><label for="recommenderId">?????????ID</label></th>
                			<td><%=util.getStr(dataMap.get("RECOMMENDER_ID"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="upDt">?????????</label></th>
                			<td><%=util.getStr(dataMap.get("UP_DT"))%></td>
                			<th scope="col"><label for="upIp">???????????????</label></th>
                			<td><%=util.getStr(dataMap.get("UP_IP"))%></td>
                		</tr>
                		
                		
                		</tbody>
                </table>
              </div>
              <div class="btn_box" >
	                	<div class="btn_right_box" >
	                		<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">??????</button>
	                		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">??????</button>
	                	</div>
             </div>
            </div>

	
</form>
<script type="text/javascript">

	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageDelGo(){
		if(confirm("?????????????????????????")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
</script>
