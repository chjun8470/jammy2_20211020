<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String uid = util.getStr(paramMap.get("uid"));

%>
<style>
a:hover {
    text-decoration: underline;
}
</style>


  <form name="fview" id="fview" action="./sub.do" method="post" >
	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
  	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/jntis/sub.do?m=<%=m%>&amp;uid=<%=uid%>" />
	<input type="hidden" name="uid" id="uid" value="<%=uid%>" />
	<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />

	<div class="basic_viewWrap">

	<h4 class="title003">?????? R&amp;D ????????????</h4>
	<table class="skin_view" style="" summary="?????? ???????????? ?????? ???????????? ?????????, ????????????, ?????????, ?????????, ??????URL??????, ?????????????????? ???????????? ????????????.">
	  	<caption>?????? ???????????? ??????</caption>
		<colgroup>
		  <col style="width:15%;" />
		  <col style="width:35%;" />
		  <col style="width:15%;" />
		  <col style="width:35%;" />
		</colgroup>

		<tbody>
	 		<tr>
				<th scope="row">?????????</th>
				<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("SUBJECT"))%></td>
			</tr>
			<tr>
				<th scope="row">????????????</th>
				<td><%=util.getStr(dataMap.get("NEW_TYPE1"))%></td>
				<th class="line_edt_reg" scope="row">?????????</th>
				<td class="r_line_none"><%=util.getStr(dataMap.get("NEW_TYPE4"))%></td>
			</tr>
			<tr>
				<th scope="row">?????????</th>
				<%if(m.equals("Y")){%>
					<td><%=util.getStr(dataMap.get("NEW_TYPE3"))%></td>
					<th scope="row">?????????</th>
					<td class="r_line_none">
						<input type="checkbox" name="hiddenYn" id="hidden_Y" value="0" <%if(util.getIntStr(dataMap.get("HIDDEN")).equals("0")){%>checked="checked"<%}%> onclick="check_only(this)"/>
						<label for="hidden_Y"> ??????</label>&nbsp;&nbsp;
						<input type="checkbox" name="hiddenYn" id="hidden_N" value="1" <%if(util.getIntStr(dataMap.get("HIDDEN")).equals("1")){%>checked="checked"<%}%> onclick="check_only(this)"/>
						<label for="hidden_N"> ?????????</label>
					</td>
				<%}else{%>
					<td class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("NEW_TYPE3"))%></td>
				<%}%>
			</tr>
			<tr>
				<th scope="row">??????URL??????</th>
			    <td class="r_line_none" colspan="3">
					<a href="#" title="????????????" onclick="window.open('<%=util.getStr(dataMap.get("NEW_TYPE2"))%>','url','width=750,height=700,scrollbars=yes')">
						<%=util.getStr(dataMap.get("NEW_TYPE2"))%>
					</a>
				</td>
			</tr>
			<tr>
				<th scope="col" colspan="4" style="border-right:0px;">????????????</th>
			</tr>
			<tr>
				<td class="r_line_none" colspan="4">
					<%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="b_btn_area">
		<div class="btn_hr_new btn_right_box">
			<input type="button" class="btn_rgt lft_btn_box_new" value="??????" onclick="pageGo('list')" title="??????"/>
			<%if(m.equals("Y")){%>
		    <input type="button" class="btn_rgt" value="??????" onclick="pageGo('editProc')" title="??????"/>
		    <%}%>
	 	</div>
	</div>

	</div>
	</form>

<script type="text/javascript">
//<![CDATA[
	//????????? checkBox
	function check_only(chk){
		var obj = document.getElementsByName("hiddenYn");
	    for(var i=0; i<obj.length; i++){
	        if(obj[i] != chk){
	            obj[i].checked = false;
	        }
	    }
	}

	function pageGo(mode){

		var m = $('#m').val();
		var myPage = $('#myPage').val();

		$('#mode').val(mode);

		if(m == 'Y'){
			// ?????????(back)???????????? action??? ??????
			$('#fview').attr("action",myPage);
			$('#fview').submit();
		}else{
			$('#fview').submit();
		}
	}
//]]>	
</script>