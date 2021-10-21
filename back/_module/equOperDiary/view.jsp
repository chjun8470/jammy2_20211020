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
	<h3><%=util.getStr(dataMap.get("MB_NM")) %> 정보</h3>
	<div class="box_in">
		<table id="step1"  class="skin_basic_write">
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
			</colgroup>

			<!-- colgroup e -->
			<tbody>
				<tr>
					<th scope="col">연구시설장비</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("KOR_NM")) %> (<%=util.getStr(dataMap.get("ENG_NM")) %>)
					</td>
					<th scope="col">고정자산번호</th>
					<td scope="col"><%=util.getStr(dataMap.get("FIXED_ASET_NO")) %></td>
				</tr>
				<tr>
					<th colspan="4">담당자 정보</th>
				</tr>
				<tr>
					<th scope="col">기관</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("EQU_USER_ORG")) %>
					</td>
					<th scope="col">부서</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("EQU_USER_DEPT")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">담당자</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("OPER_CHARGER")) %>
					</td>
					<th scope="col">직위</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("OPER_POSITION")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">전화번호</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("OPER_TEL")) %>
					</td>
					<th scope="col">이메일</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("OPER_EMAIL")) %>
					</td>
				</tr>
				<tr>
					<th colspan="4">사용정보</th>
				</tr>
				<tr>
					<th scope="col">사용일시</th>
					<td colspan="3">
						<%=util.getStr(String.valueOf(dataMap.get("START_DT"))) %>
						~
						<%=util.getStr(String.valueOf(dataMap.get("END_DT"))) %>
					</td>
				</tr>
				<tr>
					<th scope="col">사용시간</th>
					<td colspan="3">
						<%=util.getStr(String.valueOf(dataMap.get("USE_TIME"))) %>
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
					<td scope="col"><%=util.getStr(dataMap.get("USE_USER_NM")) %></td>
					<th scope="col">연락처</th>
					<td scope="col"><%=util.getStr(dataMap.get("USE_USER_PHONE")) %></td>
				</tr>
				<tr>
					<th scope="col">사용목적</th>
					<td colspan="3"><%=util.getStr(dataMap.get("PURPOSE")) %></td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">사용내용</label></th>
					<td colspan="3">
						<%=util.getStr(dataMap.get("USE_NOTE")) %>
					</td>
				</tr>
				<tr>
					<th scope="col">시료수</th>
					<td colspan="3"><%=util.getStr(String.valueOf(dataMap.get("SAMPLE_CNT"))) %>건</td>
				</tr>
				<tr>
					<th scope="col">사용료</th>
					<td>
						<%=util.setFormatNum(String.valueOf(dataMap.get("RENTAL_FEE")), "comma") %>원
					</td>
				</tr>
			</tbody>
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
