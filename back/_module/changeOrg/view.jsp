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
					<table class="skin_basic_write" summary="회원정보를 나타내는 표 입니다">
	                	<caption>회원상세정보</caption>
	                	<colgroup>
	               			<col width="30%">
	               			<col width="25%">
	               			<col width="">
	                	</colgroup>
	                	<tbody>
	                	<tr>
                			<th scope="col"><label for="regDt">요청날짜</label></th>
                			<td colspan="3"><%=util.getStr(dataMap.get("CHANGE_ORG_DATE"))%></td>
                		</tr>
                		<tr>	
                			<th scope="col"><label for="state">상태</label></th>
                			<td colspan="3"><%=util.getStr(dataMap.get("CHANGE_ORG"))%></td>
                		</tr>
                		<tr id="trAcceptNo" <%if(!util.getStr(dataMap.get("CHANGE_ORG")).equals("반려")) { %>style="display:none" <% } %>>
                			<th scope="col"><label for="">반려사유</label></th>
                			<td colspan="3"><%=util.getStr(dataMap.get("CHANGE_ORG_NO"))%></td>
                		</tr>
                    	<tr>
                			<th scope="col"><label for="blngOrgNm">기관</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_NM"))%></td>
<!--                 			<th scope="col"><label for="blngOrgGubun">기관구분</label></th> -->
<%--                 			<td><%=util.getStr(dataMap.get("BLNG_ORG_GUBUN"))%></td> --%>
						</tr>
						<tr>
                			<th scope="col"><label for="blngOrgAddr">기관주소</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_ADDR"))%></td>
                			<th scope="col"><label for="blngOrgAddrDtl">기관상세주소</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_ADDR_DTL"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="deptNm">부서명</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_NM"))%></td>
                			<th scope="col"><label for="deptZipCode">부서우편번호</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_ZIP_CODE"))%></td>
                		</tr>
                		<tr>	
                			<th scope="col"><label for="deptAddr">부서주소</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_ADDR"))%></td>
                			<th scope="col"><label for="deptAddrDtl">부서상세주소</label></th>
                			<td><%=util.getStr(dataMap.get("DEPT_ADDR_DTL"))%></td>
                		</tr>
                		
                		
                		<tr>
                			<th scope="col"><label for="psnNm">이름</label></th>
                			<td><%=util.getStr(dataMap.get("PSN_NM"))%></td>
                			<th scope="col"><label for="engPsnNm">영문명</label></th>
                			<td><%=util.getStr(dataMap.get("ENG_PSN_NM"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="birthDate">생일</label></th>
                			<td><%=util.getStr(dataMap.get("BIRTH_DATE"))%></td>
                			<th scope="col"><label for="genderTypeCd">성별</label></th>
                			<td><%=util.getStr(dataMap.get("GENDER_TYPE_CD"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="userId">아이디</label></th>
                			<td><%=util.getStr(dataMap.get("USER_ID"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="jobDivCd">직업</label></th>
                			<td><%=util.getStr(dataMap.get("JOB_DIV_CD"))%></td>
                			<th scope="col"><label for="position">직급</label></th>
                			<td><%=util.getStr(dataMap.get("POSITION"))%></td>
                		</tr>
                		<tr>	
                			<th scope="col"><label for="positionNm">직책</label></th>
                			<td><%=util.getStr(dataMap.get("POSITION_NM"))%></td>
                			<th scope="col"><label for="institJobNm">담당업무</label></th>
                			<td><%=util.getStr(dataMap.get("INSTIT_JOB_NM"))%></td>
                		</tr>
                		
                		<tr>
                			
                			<th scope="col"><label for="frgnYn">외국인여부</label></th>
                			<td><%=util.getStr(dataMap.get("FRGN_YN"))%></td>
                			<th scope="col"><label for="dmabrSlctCd">거주자구분</label></th>
                			<td><%=util.getStr(dataMap.get("DMABR_SLCT_CD"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="blngOrgZipCode">우편번호</label></th>
                			<td><%=util.getStr(dataMap.get("BLNG_ORG_ZIP_CODE"))%></td>
                		</tr>
                		<tr>
                		<th>신청자정보</th>
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
                			<th scope="col"><label for="emialId">이메일</label></th>
                			<td><%=util.getStr(dataMap.get("EMAIL_ID"))%></td>
                			<th scope="col"><label for="emailDomain">이메일도메인</label></th>
                			<td><%=util.getStr(dataMap.get("EMAIL_DOMAIN"))%></td>
                			<th scope="col"><label for="emailRecvYn">메일수신여부</label></th>
                			<td><%=util.getStr(dataMap.get("EMAIL_RECV_YN"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="telNo1">전화번호1</label></th>
                			<td><%=util.getStr(dataMap.get("TEL_NO1"))%></td>
                			<th scope="col"><label for="telNo2">전화번호2</label></th>
                			<td><%=util.getStr(dataMap.get("TEL_NO2"))%></td>
                			<th scope="col"><label for="telNo3">전화번호3</label></th>
                			<td><%=util.getStr(dataMap.get("TEL_NO3"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="cpNo1">휴대폰1</label></th>
                			<td><%=util.getStr(dataMap.get("CP_NO1"))%></td>
                			<th scope="col"><label for="cpNo2">휴대폰2</label></th>
                			<td><%=util.getStr(dataMap.get("CP_NO2"))%></td>
                			<th scope="col"><label for="cpNo3">휴대폰3</label></th>
                			<td><%=util.getStr(dataMap.get("CP_NO3"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="faxNo1">팩스번호1</label></th>
                			<td><%=util.getStr(dataMap.get("FAX_NO1"))%></td>
                			<th scope="col"><label for="faxNo2">팩스번호2</label></th>
                			<td><%=util.getStr(dataMap.get("FAX_NO2"))%></td>
                			<th scope="col"><label for="faxNo3">팩스번호3</label></th>
                			<td><%=util.getStr(dataMap.get("FAX_NO3"))%></td>
                		</tr>
                		</tbody>
                		</table>
                		
                		</td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="userTypeCd">사용자유형</label></th>
                			<td><%=util.getStr(dataMap.get("USER_TYPE_CD"))%></td>
                			<th scope="col"><label for="recommenderId">추천인ID</label></th>
                			<td><%=util.getStr(dataMap.get("RECOMMENDER_ID"))%></td>
                		</tr>
                		<tr>
                			<th scope="col"><label for="upDt">수정일</label></th>
                			<td><%=util.getStr(dataMap.get("UP_DT"))%></td>
                			<th scope="col"><label for="upIp">수정아이피</label></th>
                			<td><%=util.getStr(dataMap.get("UP_IP"))%></td>
                		</tr>
                		
                		
                		</tbody>
                </table>
              </div>
              <div class="btn_box" >
	                	<div class="btn_right_box" >
	                		<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
	                		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
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
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
</script>
