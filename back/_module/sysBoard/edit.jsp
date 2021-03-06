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
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> codeList = request.getAttribute("codeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("codeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	//String userId = util.getStr(paramMap.get("userId"));
	if("".equals(mode)) mode = "edit";

	if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) < 99){
%>
	<script type="text/javascript" >
		alert("????????? ???????????????.");
		history.back(-1); //??????????????????
	</script>
<%
		return;
	}
%>
	  <form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="dataIdx" id="dataIdx" value="<%=util.getStr(dataMap.get("BOARD_ID")) %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
		<span style="color:red; font-size:10pt;">* ?????? ?????????????????????.</span>
	        <table class="skin_basic_write">
	          <caption>????????????</caption>
	          <colgroup>
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          </colgroup>
	          <tbody>
	            <tr>
	              <th scope="row" class="tit">
	            	<span style="color:red; font-size:11pt;">*</span> ?????????ID</th>
	              <td>
	              	<%=util.getStr(dataMap.get("BOARD_ID")) %>
	              </td>
	              <th scope="row" class="tit" style="height: 24px"><span style="color:red; font-size:11pt;">*</span> ?????????</th>
	              <td>
	            	<select name="siteType" id="siteType" class="select_box" style="width: 310px; height: 24px">
						<option value="jeinet"  <%if("jeinet".equals(util.getStr(dataMap.get("SITE_ID")))) {%>selected="selected"<%}%>>?????????????????????</option>
						<option value="jntis"   <%if("jntis".equals(util.getStr(dataMap.get("SITE_ID")))) {%>selected="selected"<%}%>>?????????????????????????????????</option>
						<option value="jipbank" <%if("jipbank".equals(util.getStr(dataMap.get("SITE_ID")))) {%>selected="selected"<%}%>>????????????????????????</option>
						<option value="smbrnd" <%if("smbrnd".equals(util.getStr(dataMap.get("SITE_ID")))) {%>selected="selected"<%}%>>??????????????????R&D?????????</option>
						<option value="sample"  <%if("sample".equals(util.getStr(dataMap.get("SITE_ID")))) {%>selected="selected"<%}%>>sample</option>
					</select>
	              </td>
                </tr>
                 <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span><label for="boardNm"> ????????????</label>
	              </th>
	              <td colspan="3">
	              	<input type="text" name="boardNm" id="boardNm" value="<%=util.getStr(dataMap.get("BOARD_NM")) %>" style="width:97%;" maxlength="100" class="inp_txt" />
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span> ???????????????</th>
	              <td colspan="3">
	              	<select name="skinNm" id="skinNm" class="select_box" style="width: 340px; height: 24px">
	              	<%
			        	for(HashMap rs:codeList) {
			            String CODE_NM = util.getStr(rs.get("CODE_NM"));
			            String CMT = util.getStr(rs.get("CMT"));
				        	if(util.getStr(dataMap.get("SKIN_NM")).equals(CODE_NM)){
				    %>
				             		 <option value="<%=CODE_NM%>" selected="selected"><%=CODE_NM%>(<%=CMT%>)</option>
					<%		}else{ %>
		              	   			<option value="<%=CODE_NM%>"><%=CODE_NM%>(<%=CMT%>)</option>
		            <%		}
				        }
				    %>
	              	</select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span><label for="boardSummary"> ???????????????</label>
	              </th>
	              <td colspan="3">
		            <input type="text" name="boardSummary" id="boardSummary" value="<%=util.getStr(dataMap.get("BOARD_SUMMARY")) %>" style="width:97%;" maxlength="100" class="inp_txt" />
		          </td>
		        </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="blockPage">????????? ???</label></th>
	              <td colspan="3">
	              	<input type="text" name="blockPage" id="blockPage" value="<%=util.getStr(dataMap.get("BLOCK_PAGE")) %>" style="width:5%;" maxlength="100" class="inp_txt" />???  &nbsp;&nbsp;(??? ???????????? ????????? ????????? ???)
	              </td>
	             </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="listSize">????????? ??????</label></th>
	              <td colspan="3">
	              	<input type="text" name="listSize" id="listSize" value="<%=util.getStr(dataMap.get("LIST_SIZE")) %>" style="width:5%;" maxlength="100" class="inp_txt" />???  &nbsp;&nbsp;(??? ???????????? ????????? ????????? ??? ???)
	              </td>
	            </tr>

	            <tr>
	              <th scope="row" class="tit"><label for="permNotice">???????????? ??????</label></th>
	              <td>
	              		?????? : <input type="radio" value="Y" id="permNotice" name="permNotice" <%if(util.getStr(dataMap.get("PERM_NOTICE")).equals("Y")) {%> checked="checked" <%}%>/>
	              		????????? : <input type="radio" value="N" id="permNotice_N" name="permNotice" <%if(util.getStr(dataMap.get("PERM_NOTICE")).equals("N")) {%> checked="checked" <%}%>/>
	              </td>
	              <th scope="row" class="tit"><label for="permCmt">???????????? ??????</label></th>
	              <td>
			           	?????? : <input type="radio" value="Y" id="permCmt" name="permCmt" <%if(util.getStr(dataMap.get("PERM_CMT")).equals("Y")) {%> checked="checked" <%}%>/>
			           	????????? : <input type="radio" value="N" id="permCmt_N" name="permCmt" <%if(util.getStr(dataMap.get("PERM_CMT")).equals("N")) {%> checked="checked" <%}%>/>
		          </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permEditor">??????????????? ??????</label></th>
	              <td>
	              		?????? : <input type="radio" value="Y" id="permEditor" name="permEditor" <%if(util.getStr(dataMap.get("PERM_EDITOR")).equals("Y")) {%> checked="checked" <%}%>/>
	              		????????? : <input type="radio" value="N" id="permEditor_N" name="permEditor" <%if(util.getStr(dataMap.get("PERM_EDITOR")).equals("N")) {%> checked="checked" <%}%>/>
	              </td>
	              <th scope="row" class="tit">???????????????  ??????</th>
	              <td>
		             <select name="auth_cmt_list" id="auth_cmt_list" class="select_box">
		             	<%
			            	for(HashMap rs:dataList) {
				            	String CODE_CD = util.getStr(rs.get("CODE_CD"));
				            	String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String LIST = util.getStr(String.valueOf(dataMap.get("PERM_LVL_CMT_LIST")));
				            	if(LIST.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permHtml">HTML?????? ??????</label></th>
	               <td>
			          	?????? : <input type="radio" value="Y" id="permHtml" name="permHtml" <%if(util.getStr(dataMap.get("PERM_HTML")).equals("Y")) {%> checked="checked" <%}%>/>
	              		????????? : <input type="radio" value="N" id="permHtml_N" name="permHtml" <%if(util.getStr(dataMap.get("PERM_HTML")).equals("N")) {%> checked="checked" <%}%>/>
	              </td>
	              <th scope="row" class="tit">????????????  ??????</th>
	              <td>
		             <select name="auth_cmt_write" id="auth_cmt_write" class="select_box">
		             	<%
			            	for(HashMap rs:dataList) {
				            	String CODE_CD = util.getStr(rs.get("CODE_CD"));
				            	String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String WRITE = util.getStr(String.valueOf(dataMap.get("PERM_LVL_CMT_WRITE")));
				            	if(WRITE.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permFile">???????????? ??????</label></th>
	              <td>
			          	?????? : <input type="radio" value="Y" id="permFile" name="permFile" <%if(util.getStr(dataMap.get("PERM_FILE")).equals("Y")) {%>  checked="checked" <%}%>/>
	              		????????? : <input type="radio" value="N" id="permFile_N" name="permFile" <%if(util.getStr(dataMap.get("PERM_FILE")).equals("N")) {%> checked="checked" <%}%>/>
	              </td>
	              <th scope="row" class="tit">????????????  ??????</th>
	              <td>
		             <select name="auth_cmt_del" id="auth_cmt_del" class="select_box" >
		             	<%
			            	for(HashMap rs:dataList) {
				           		String CODE_CD = util.getStr(rs.get("CODE_CD"));
				           		String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String DEL = util.getStr(String.valueOf(dataMap.get("PERM_LVL_CMT_DEL")));
				            	if(DEL.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">????????? ??????</th>
	              <td colspan="3">
		             <select name="auth_list" id="auth_list" class="select_box">
			            <%
			            	for(HashMap rs:dataList) {
				           		String CODE_CD = util.getStr(rs.get("CODE_CD"));
				           		String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String DEL = util.getStr(String.valueOf(dataMap.get("PERM_LVL_LIST")));
				            	if(DEL.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	             <tr>
	              <th scope="row" class="tit">?????? ??????</th>
	              <td colspan="3">
		             <select name="auth_read" id="auth_read" class="select_box">
			           <%
			            	for(HashMap rs:dataList) {
				           		String CODE_CD = util.getStr(rs.get("CODE_CD"));
				           		String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String DEL = util.getStr(String.valueOf(dataMap.get("PERM_LVL_READ")));
				            	if(DEL.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">?????? ??????</th>
	              <td colspan="3">
		             <select name="auth_write" id="auth_write" class="select_box">
			         	<%
			            	for(HashMap rs:dataList) {
				           		String CODE_CD = util.getStr(rs.get("CODE_CD"));
				           		String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String DEL = util.getStr(String.valueOf(dataMap.get("PERM_LVL_WRITE")));
				            	if(DEL.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">?????? ??????</th>
	              <td colspan="3">
		             <select name="auth_modify" id="auth_modify" class="select_box">
		             	<%
			            	for(HashMap rs:dataList) {
				           		String CODE_CD = util.getStr(rs.get("CODE_CD"));
				           		String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String DEL = util.getStr(String.valueOf(dataMap.get("PERM_LVL_EDITOR")));
				            	if(DEL.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">?????? ??????</th>
	              <td colspan="3">
		             <select name="auth_del" id="auth_del" class="select_box">
		             	<%
			            	for(HashMap rs:dataList) {
				           		String CODE_CD = util.getStr(rs.get("CODE_CD"));
				           		String CODE_NM = util.getStr(rs.get("CODE_NM"));
				            	String DEL = util.getStr(String.valueOf(dataMap.get("PERM_LVL_DEL")));
				            	if(DEL.equals(CODE_CD)){
				        %>
				        			<option value="<%=CODE_CD%>" selected><%=CODE_CD%>(<%=CODE_NM%>)</option>
				        <%		}else{ %>
			             			<option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			            <%		}
				         	}
		             	 %>
		             </select>
	              </td>
	            </tr>
	          </tbody>
	        </table>

	        <!-- bo_btn  -->
		    <div class="btn_box">
		        <div class="bo_btn_box textC">
		        </div>
		        
				 <div class="btn_right_box">
				 	&nbsp;

				 	<%if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99){%>
					<input type="button" class="btn_inp_b_01" value="??????" onclick="check('editProc')"/>
				 	<%}%>
				 	<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
				</div>
	        </div>
              <!--// bo_btn -->
         </div>
      </form>

<script type="text/javascript">

	function goSubmit(mode){
		if(mode=='editProc'){
			if (confirm("??????????????????????????") == true){ //??????
				$('#mode').val(mode);
				$('#fedit').submit();
			}else{ //??????
			    return;
			}
		}
		$('#mode').val(mode);
		$('#fedit').submit();
	}

	function check(mode){
		var boardNm = $("#boardNm").val();
		var boardSummary = $("#boardSummary").val();

		if(boardNm ==null || boardNm == ""){
			alert("??????????????? ??????????????????");
			return false;
		}
		if(boardSummary ==null || boardSummary == ""){
			alert("?????????????????? ??????????????????");
			return false;
		}
			goSubmit(mode);

	}
</script>


