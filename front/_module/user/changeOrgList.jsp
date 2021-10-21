<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	//response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

    HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	String userIdx = util.getStr(paramMap.get("userIdx"));
%>


<form name="authForm" id="authForm" action="/web/changeOrg.do" method="post" >
	<input type="hidden" name="mode" id="mode" value="upOrg" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />

	<div id="container" style="width:800px; background-color:#FFFFFF;" >
		<!--div class="contents_box"-->
		<div style="margin-right:10px;padding-left:5px;">

<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 50%;" />
	
			</colgroup>
			<thead>
				<tr>
					<th scope="col">신청날짜</th>
					<th scope="col">상태</th>
					<th scope="col">반려사유</th>
				</tr>
			</thead>
			<tbody>
			<% if(util.getStr(dataMap.get("CHANGE_ORG_DATE")).equals("") || util.getStr(dataMap.get("CHANGE_ORG_DATE")).equals(null)) { %>
				<tr>
					<td colspan="3">신청한 데이터가 없습니다.</td>
				</tr>
			<%}else{ %>
				<tr>
					<td><%=util.getStr(dataMap.get("CHANGE_ORG_DATE")) %></td>
					<td><%=util.getStr(dataMap.get("CHANGE_ORG")) %></td>
					<td><%=util.getStr(dataMap.get("CHANGE_ORG_NO")) %></td>
				</tr>
			<%} %>
			</tbody>
		</table>

			<!-- btn -->
			<div class="btn_box" >
				<div class="btn_right_box" >
					<input type="button" class="btn_inp_b_01" value="기관회원변경신청" onclick="changeOrgPopup('changeOrgPop')" />
				</div>
			</div>

		</div>
	</div>
</form>
	<script type="text/javascript">
	//<![CDATA[
	//기관회원변경신청 팝업
	function changeOrgPopup(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/web/web_popup.do?listMode="+listMode;
 		var popOption="width=850, height=400, resizable=no, scrollbars=no, status=no;";		
 		window.open(popUrl,"",popOption);
		
	}
	//]]>
	</script>