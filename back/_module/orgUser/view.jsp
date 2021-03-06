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
	String userAppState = util.getStr(paramMap.get("userAppState"));
	String orgGrpCd = util.getStr(dataMap.get("ORG_GRP_CD"));
	String deptNm = util.getStr(dataMap.get("DEPT_NM"));
%>
<form id = "fview" name = "fview" method="post" action="<%=myPage%>" >
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "userIdx" name = "userIdx" value = "<%=util.getStr(String.valueOf(dataMap.get("USER_IDX")))%>"/>
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	<input type="hidden" name="userAppState" id="userAppState" value="<%=userAppState%>" />
	<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=orgGrpCd%>" />
	<input type="hidden" name="deptNm" id="deptNm" value="<%=deptNm%>" />
	<div class="skin_bbs_write" style="margin-top: 30px">
		<table class="skin_basic_write">
			<caption>???????????????</caption>
			<colgroup>
				<col style="width:20%" />
				<col style="width:30%" />
				<col style="width:20%" />
				<col style="width:30%" />
			</colgroup>
			<tbody id="userTr">
				<tr>
					<th scope="row" class="tit" colspan="4">????????????</th>
				</tr>
				<tr>
					<th scope="row" class="tit">??????</th>
					<td>
						<%=util.getStr(dataMap.get("PSN_NM")) %>
					</td>
					<th scope="row" class="tit">????????????</th>
					<td>
						<%=util.getStr(dataMap.get("USER_APP_STATE")) %>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">?????????</th>
					<td>
						<%=util.getStr(dataMap.get("USER_ID")) %>
					</td>
					<th scope="row" class="tit">?????????</th>
					<td>
						<%=util.getStr(dataMap.get("EMAIL")) %>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">??????</th>
					<td>
						<%=util.getStr(dataMap.get("GENDER_TYPE_CD")) %>
					</td>
					<th scope="row" class="tit">??????</th>
					<td>
						<%if(util.getStr(dataMap.get("FRGN_YN")).equals("N")){ %>
							????????????
						<%}else{%>
							?????????
						<%} %>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">????????????</th>
					<td>
						<%=util.getStr(dataMap.get("TEL_NO")) %>
					</td>
					<th scope="row" class="tit">?????????</th>
					<td>
						<%=util.getStr(dataMap.get("CP_NO")) %>
					</td>
				</tr>

				<tr>
					<th scope="row" class="tit" colspan="4">????????????
						<a href="/sys/sys_org_manage.do?orgGrpCd=<%=util.getStr(dataMap.get("ORG_GRP_CD")) %>&mode=view">
						<button class="btn_inp_w_01" type="button">????????????</button>
						</a>
					</th>
				</tr>
				<tr>
					<th scope="row" class="tit">?????????</th>
					<td>
						<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
					</td>
					<th scope="row" class="tit">?????????</th>
					<td>
						<%=util.getStr(dataMap.get("DEPT_NM")) %>
					</td>

				</tr>
				<tr>
					<th scope="row" class="tit">??????</th>
					<td colspan="3">
						<%=util.getStr(dataMap.get("POSITION_NM")) %>
					</td>
				</tr>
			<%if((util.getStr(dataMap.get("USER_APP_STATE"))).equals("??????")){%>
				<tr>
					<th scope="row" class="tit" colspan="4">????????????</th>
				</tr>
				<tr>
					<td colspan="4">
						<%=util.getStr(dataMap.get("REJECT"))%>
					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
	</div>
			<%if((util.getStr(dataMap.get("USER_APP_STATE"))).equals("??????")){%>
				<div>
					<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('20','<%=util.getIntStr(dataMap.get("USER_IDX")) %>')"/>
					<input type="button" class="btn_inp_b_01" id="reButton" value="??????" onclick="goReturn('30','<%=util.getIntStr(dataMap.get("USER_IDX")) %>')"/>
				</div>
			<%}%>
		<div class="btn_box" >
           	<div class="btn_right_box" >
           		<button class="btn_inp_b_01" type="button" onclick="location.href='./<%=myPage%>?mode=edit&amp;userIdx=<%=util.getIntStr(dataMap.get("USER_IDX"))%>'" >??????</button>
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('del','<%=util.getIntStr(dataMap.get("USER_IDX")) %>')">??????</button>
           		<button class="btn_inp_w_01" type="button" onclick="goSubmit('list')">??????</button>
           	</div>
       </div>
</form>
<script type="text/javascript">
	function goSubmit(mode,idx){
		$('#mode').val(mode);
		$('#userIdx').val(idx);
		$('#fview').submit();
	}
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
	function goReturn(mode, idx){
		var reject ="";
		reject += "<tr>";
		reject += "<th scope='row' class='tit' colspan='4'>????????????</th>";
		reject += "</tr>";
		reject += "<tr>";
		reject += "<td colspan='4'><input type='text' name='reject' id='reject' style='width:100%;'/></td>"
		reject += "</tr>";
		$("#userTr").append(reject);

		$("#reButton").attr("value","????????????");
		$("#reButton").attr("onclick","goSubmit('"+mode+"', '"+idx+"')");
	}
</script>