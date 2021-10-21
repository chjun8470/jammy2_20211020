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
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "jnspmodule";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));
%>

<div class="clear_wrap">
		<h3>장비담당자 정보</h3>
			<table id="step1"  class="skin_basic_write">
				<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				</colgroup>
				<tbody>
					<tr style="display: none;">
						<th scope="col">연구시설장비</th>
						<td scope="col"><%=util.getStr(dataMap.get("KOR_NM")) %> (<%=util.getStr(dataMap.get("ENG_NM")) %>)</td>
						<th scope="col">고정자산번호</th>
						<td scope="col"><%=util.getStr(dataMap.get("FIXED_ASET_NO")) %></td>
					</tr>
					<tr>
						<th colspan="4">담당자 정보 </th>
					</tr>
					<tr>
						<th scope="col">기관</th>
						<td scope="col"><%=util.getStr(dataMap.get("EQU_USER_ORG")) %></td>
						<th scope="col">부서</th>
						<td scope="col"><%=util.getStr(dataMap.get("EQU_USER_DEPT")) %></td>
					</tr>
					<tr>
						<th scope="col">담당자</th>
						<td scope="col"><%=util.getStr(dataMap.get("EQU_USER_NM")) %></td>
						<th scope="col">직위</th>
						<td scope="col"><%=util.getStr(dataMap.get("EQU_USER_POSITION")) %></td>
					</tr>
					<tr>
						<th scope="col">전화번호</th>
						<td scope="col"><%=util.getStr(dataMap.get("EQU_USER_PHONE")) %></td>
						<th scope="col">이메일</th>
						<td scope="col"><%=util.getStr(dataMap.get("EQU_USER_EMAIL")) %></td>
					</tr>
				</tbody>
			</table>
			
			<h3>장비 예약 정보</h3>
			<table class="skin_basic_write">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 26.6%;" />
					<col style="width: 26.6%;" />
					<col style="width: 26.6%;" />
				</colgroup>
				<!-- colgroup e -->
				<tr>
					<th scope="col">장비명</th>
					<td scope="col" colspan="3">
						<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
					</td>
				</tr>
				<tr>
					<th scope="col">등록번호</th>
					<td scope="col">
						JEINET 등록번호 : <%=util.getStr(dataMap.get("RND_EQU_IDX"))%>
					</td>
					<td scope="col">
						Zeus 등록번호 : <%if(!util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("NTIS_EQUIP_INFO")));}else {out.print("NTIS 미등록 장비");}%>
					</td>
					<td scope="col">
						e-Tube 등록번호 : <%if(!util.getStr(dataMap.get("ETUBE_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("ETUBE_EQUIP_INFO")));}else {out.print("e-Tube 미등록 장비");}%>
					</td>
				</tr>
				<tr>
					<th scope="col">보유기관</th>
					<td scope="col" colspan="3">
						<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>(<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM"))%>)
					</td>
				</tr>
				<tr>
					<th scope="col">사용기관</th>
					<td colspan="3">
						구분 : <%if(util.getStr(dataMap.get("ORG_SELECT")).equals("01")) {
							out.println("기관 내 동일부서");
						 }else if(util.getStr(dataMap.get("ORG_SELECT")).equals("02")) {
							out.println("기관 내 타부서");
						 } else if(util.getStr(dataMap.get("ORG_SELECT")).equals("03")) {
							out.println("외부기관");
						 }%> /
						기관명 : <%=util.getStr(dataMap.get("ORG_GRP_NM")) %> /
						부서명 : <%=util.getStr(dataMap.get("DEPT_NM")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">사용자</th>
					<td scope="col" colspan="3"><%=util.getStr(dataMap.get("USE_USER_NM")) %></td>
				</tr>
				<tr>
					<th scope="col">연락처</th>
					<td scope="col" colspan="3"><%=util.getStr(dataMap.get("USE_USER_PHONE")) %></td>
				</tr>
				<tr>
					<th scope="col">이용목적</th>
					<td scope="col" colspan="3"><%=util.getStr(dataMap.get("PURPOSE")) %></td>
				</tr>
				<tr>
					<th scope="col">장비가동기간</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(dataMap.get("START_DT"))) %>	~ <%=util.getStr(String.valueOf(dataMap.get("END_DT"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비보조가동시간(A)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(dataMap.get("USE_TIME_A"))) %></td>
				</tr>
				<tr>
					<th scope="col">예비실험등 가동시간(B)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(dataMap.get("USE_TIME_B"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비실질가동시간(C)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(dataMap.get("USE_TIME_C"))) %></td>
				</tr>
				<tr>
					<th scope="col">장비가동시간(A+B+C)</th>
					<td scope="col" colspan="3"><%=util.getStr(String.valueOf(dataMap.get("USE_TIME"))) %></td>
				</tr>
				<tr>
					<th scope="col"> 시료처리정보</th>
					<td colspan="3">
						<%
		                				String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
	                					String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
	                					String sampleNmArr[] = sampleNm.split("\\|\\|");
	                					String sampleNoArr[] = sampleNo.split("\\|\\|");
	                					for(int i = 1 ; i < sampleNmArr.length ; i++ ){
	                						if( i != 1 ){
	                							//out.println(", ");
	                						}
	                						out.println(i+". 시료 : " + sampleNmArr[i]);
	                						out.println("(");
	                						out.println(sampleNoArr[i]);
	                						out.println(")");
	                						out.println("<br />");
	                					}
		                			%>
					</td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">장비운영내용</label></th>
					<td colspan="3"><%=util.getStr(String.valueOf(dataMap.get("USE_NOTE"))) %></td>
				</tr>
			</table>
			
	</div>
			  <div class="btn_box" >
			  	<div class="btn_left_box" >

			  	</div>
				<div class="btn_right_box" >
					<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
					<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
					<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
			 	</div>
			 </div>
</div>
<form id = "fview" name = "fview" method="post" action="./<%=myPage%>">
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "equOperDiaryIdx" name = "equOperDiaryIdx" value="<%=util.getStr(String.valueOf(dataMap.get("EQU_OPER_DIARY_IDX")))%>"/>
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
