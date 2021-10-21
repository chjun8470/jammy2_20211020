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
				   			<col width="30%">
				   			<col width="70%">
						</colgroup>
						<tbody>
						<tr>
							<th scope="col">모듈인덱스</th>
							<td scope="col">
								<%=util.getStr(dataMap.get("MODULE_INFO_IDX")) %>
							</td>
						</tr>
						<tr>
							<th scope="col">모듈명</th>
							<td scope="col">
								<%=util.getStr(dataMap.get("MB_NM"))%>
							</td>
						</tr>
						<tr>
							<th scope="col">주소(URL)</th>
							<td scope="col">
								<%=util.getStr(dataMap.get("MB_URL"))%>
							</td>
						</tr>
						<tr>
							<th scope="col">관리자페이지 코드</th>
							<td scope="col">
								<%=util.getStr(dataMap.get("PAGE_CD"))%>
							</td>
						</tr>
						<tr>
							<th scope="col">모듈정보</th>
							<td scope="col">
								<%=util.getStr(dataMap.get("MB_NOTE")).replaceAll("\n", "<br>")%>
							</td>
						</tr>
						<tr>
							<th scope="col">권한</th>
							<td scope="col">
								<input type="checkbox" name="authList" id="authList" <%if(util.getStr(dataMap.get("AUTH_LIST")).equals("Y")) { %> checked="checked" <% } %>  disabled="disabled" /><label for="authList">리스트</label>
								<input type="checkbox" name="authWrite" id="authWrite" <%if(util.getStr(dataMap.get("AUTH_WRITE")).equals("Y")) { %> checked="checked" <% } %>  disabled="disabled"  /><label for="authWrite">등록</label>
								<input type="checkbox" name="authEdit" id="authEdit" <%if(util.getStr(dataMap.get("AUTH_EDIT")).equals("Y")) { %> checked="checked" <% } %>  disabled="disabled"  /><label for="authEdit">수정</label>
								<input type="checkbox" name="authDel" id="authDel" <%if(util.getStr(dataMap.get("AUTH_DEL")).equals("Y")) { %> checked="checked" <% } %>  disabled="disabled"  /><label for="authDel">삭제</label>
								<input type="checkbox" name="authCmt" id="authCmt" <%if(util.getStr(dataMap.get("AUTH_CMT")).equals("Y")) { %> checked="checked" <% } %>  disabled="disabled"  /><label for="authCmt">코멘트</label>
								<input type="checkbox" name="authReply" id="authReply" <%if(util.getStr(dataMap.get("AUTH_REPLY")).equals("Y")) { %> checked="checked" <% } %>  disabled="disabled"  /><label for="authReply">답변</label>
							</td>
						</tr>
						<tr>
							<th scope="col">사용여부</th>
							<td scope="col">
								<%=util.getStr(dataMap.get("USE_YN"))%>
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
<form id = "fview" name = "fview" method="post" action="/sys/sys_module.do">
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "moduleInfoIdx" name = "moduleInfoIdx" value="<%=util.getStr(dataMap.get("MODULE_INFO_IDX"))%>"/>
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
