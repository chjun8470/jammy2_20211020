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
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	
	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String tab = util.getStr(paramMap.get("tab"));
	String auth_lv = util.getStr(paramMap.get("auth_lv"));
	String userId = util.getStr(paramMap.get("userId"));
	String sttus = util.getStr(dataMap.get("DATA15"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
		
	if("".equals(mode)) mode = "edit";
	
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	
	
%>
<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="tab" id="tab" value="<%=tab%>" />
	<input type="hidden" name="auth_lv" id="auth_lv" value="<%=auth_lv%>" />
	<input type="hidden" name="userId" id="userId" value="<%=userId%>" />
	<input type="hidden" name="sttus" id="sttus" value="<%=sttus%>" /> 
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="skin_bbs_write" style="margin-top: 30px">
		<span style="color:red;">* ?????? ?????????????????????.</span>
	        <table class="skin_basic_write">
	          <caption>
	          ????????????
	          </caption>
	          <colgroup>
	          <col style="width:140px;" />
	          <col style="width:*;" />
	          </colgroup>
	          <tbody>
	          	<tr>
					<th scope="col">
					<label for="subject">?????????</label>
					</th>
					<td class="r_line_none p_top_btm_6">
					<select name="siteId" id="siteId" class="b_select2" style="height: 24px">
						<option value="" <%if("".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>??????</option>
						<option value="jeinet" <%if("jeinet".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>?????????????????????</option>
						<option value="jipbank" <%if("jipbank".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>????????????????????????</option>
						<option value="jntis" <%if("jntis".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>?????????????????????????????????</option>
					</select>
					</td>
				</tr>
	            <tr>
	              <th scope="row" class="tit"><span style="color:red;"> * </span><label for="subject">??????</label></th>
	              <td><input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT")) %>" style="width:100%;" maxlength="100" /></td>
	            </tr>
				<tr>
	              <th scope="row" class="tit"><label for="pollurl">?????? ???????????? URL</label></th>
	              <td>
             		  	<input type="text" name="pollurl" id="pollurl" value="<%=util.getStr(dataMap.get("DATA01")) %>" style="width:100%;" maxlength="145" />
             		  	ex) http://naver.com
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="pollfax01">?????????</label></th>
	              <td>
	              	<input type="hidden" name="pollemail" id="pollemail"/>
	              	<input type="hidden" name="email03" id="email03"/>
	              	<input type="hidden" name="pollfax" id="pollfax" />
	              	FAX : <input type="text" name="pollfax01" id="pollfax01" value="<%=util.getStr(dataMap.get("DATA10")) %>" style="width:3%;" maxlength="100" /> - <input type="text" name="pollfax02" id="pollfax02" value="<%=util.getStr(dataMap.get("DATA11")) %>" style="width:3%;" maxlength="100" /> - <input type="text" name="pollfax03" id="pollfax03" value="<%=util.getStr(dataMap.get("DATA12")) %>" style="width:3%;" maxlength="100" />
	              	ex) xxx-xxxx-xxxx ?????? xxx-xxx-xxxx
	              	<br/>
	              	<br/>
	              	EMAIL : <input type="text" name="email01" id="email01" value="<%=util.getStr(dataMap.get("DATA08")) %>" style="width:15%;" maxlength="100" title="????????? ??????" /> @ <input type="text" name="email02" id="email02" style="width:150px;" value="<%=util.getStr(dataMap.get("DATA09")) %>">
	              		<select style="width:100px;margin-right:10px; padding:0px" name="selectEmail" id="selectEmail">
						     <option value="1" selected>????????????</option>
						     <option value="naver.com" >naver.com</option>
						     <option value="hanmail.net">hanmail.net</option>
						     <option value="hotmail.com">hotmail.com</option>
						     <option value="nate.com">nate.com</option>
						     <option value="yahoo.co.kr">yahoo.co.kr</option>
						     <option value="empas.com">empas.com</option>
						     <option value="dreamwiz.com">dreamwiz.com</option>
						     <option value="freechal.com">freechal.com</option>
						     <option value="lycos.co.kr">lycos.co.kr</option>
						     <option value="korea.com">korea.com</option>
						     <option value="gmail.com">gmail.com</option> 
						     <option value="hanmir.com">hanmir.com</option>
						     <option value="paran.com">paran.com</option>
						</select>
						ex) example@email.com
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><span style="color:red;"> * </span><label for="pollstart">??????</label></th>
	              <td>
	              	<input type="text" name="pollstart" id="pollstart" value="<%=util.getStr(dataMap.get("DATA04")) %>" style="width:30%;" maxlength="100" /> ~ <input type="text" name="pollend" id="pollend" value="<%=util.getStr(dataMap.get("DATA05")) %>" style="width:30%;" maxlength="100" />
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="contents">??????</label></th>
	              <td>

	              	<textarea name="content" id="contents" style="width:100%;height:350px;"><%=util.getStr(dataMap.get("CONTENT")) %></textarea>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><span style="color:red;"> * </span><label for="agenm">?????????</label></th>
	              <td>
	              	<select style="width:150px;margin-right:15px; padding:0px" name="agenm" id="agenm">
	              	<%if(util.getStr(dataMap.get("DATA06")) ==""){ %>
	              		<option value="" selected>????????????</option>
						 <%for(HashMap rs:dataList) { %> 
						     <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>"><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
						 <%} %>
					 <%} else{%>
					 	 <option value="" >????????????</option>
						<%for(HashMap rs:dataList) { 
						 	if(util.getStr(rs.get("ORG_GRP_NM")).equals(util.getStr(dataMap.get("DATA06")))){%> 
						     <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>" selected><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
						 <%  }else{%>
							 <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>" ><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
						<%	 }
						 }%>
					<%} %>	 
					</select>
	              </td>
	            </tr>
	            <tr>  
	              <th scope="row" class="tit"><span style="color:red;"> * </span><label for="answer">???????????????</label></th>
	              <td>
	              	<input type="text" name="answer" id="answer" value="<%=util.getStr(dataMap.get("DATA07")) %>" style="width:40%;" maxlength="100" />
	              </td>
	            </tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="row" class="tit">
						????????????
					</th>
				<td>
				<%
					if(fileList.size() > 0){
				%>
						<ul class="file" style="line-height: 22px;">
						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
								String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<li class="text">
								<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
										value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" /> &nbsp;
								<label for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
								
<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
								
							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" /> 
							<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div> 
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function addRowFile(fileGrpnm){
					            	//<![CDATA[
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";
				            		//]]>
			            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}
			
					            function delRowFile(fileGrpnm){
					            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }
			
								function fileSet(fileCnt){
									if($('#fileFlog_'+fileCnt).is(':checked')){
										$('#fileBox_'+fileCnt).show();
									}else{
										$('#fileBox_'+fileCnt).hide();
									}
								}
				            </script> 
				            
	            <% }else{ %>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" /> 
							<input type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div> 
						<script type="text/javascript">
							var arrfileCnt = new Array();
							arrfileCnt['<%=fileFullGrp%>'] = 2;
				            function addRowFile(fileGrpnm){
			            		var fileHtml = "<div>";
			            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
			            		fileHtml += "</div>";
		
		            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
		            			arrfileCnt[fileGrpnm]++;
			            	}
		
				            function delRowFile(fileGrpnm){
				            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
				            		return;
				            	}
				            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
				            	arrfileCnt[fileGrpnm]--;
				            }
			            </script> 
			      <% } %>
						  </td>
				</tr>
				<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('editProc')"/>
			<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var permEditor = $('#permEditor').val();
if(permEditor=="Y"){
   var oEditors = [];
	$(function(){
		// ?????? ?????? ??????
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "contents",
			sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,				// ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
				bUseVerticalResizer : true,		// ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
				bUseModeChanger : true,			// ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
				//aAdditionalFontList : aAdditionalFontSet,		// ?????? ?????? ??????
			}, //boolean
			fCreator : "createSEditor2"
		});
	});
}	
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fedit').submit();
	}

	
	
		
		function goSubmit(mode){
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
			var regUrl = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
			if($('#siteId').val() == ''){
				alert("???????????? ?????? ????????????");
				$('#siteId').focus();
				return false;
			}
			if($('#subject').val() == ''){
				alert("????????? ?????? ????????????");
				$('#subject').focus();
				return false;
			}
			if($('#pollurl').val() != ''){
				if(!regUrl.test($('#pollurl').val())){
					alert("URL??? ?????? ?????? ???????????????. ?????? ??????????????????");
					$('#pollurl').focus();
					return false;
				}
			}
			if($('#pollstart').val() == '' && $('#pollend').val() == ''){
				alert("????????? ?????? ????????????");
				$('#pollend').focus();
				$('#pollstart').focus();
				return false;
			}
			if($('#email01').val() != '' && $('#email02').val() != ''){
				if($("#selectEmail option:selected").val()== '1'){
					var email_check01 = $('#email01').val();
					var email_check02 = $('#email02').val();
					$('#email03').val(email_check02);
					$('#pollemail').val(email_check01 +"@"+email_check02);
				}else{//?????? ????????? ??????
					var email_check03 = $('#email02').val();
					var email_check = $('#email01').val()+"@"+ $('#email02').val();
					$('#email03').val(email_check03);
					$('#pollemail').val(email_check);
				}
				if(!regEmail.test($('#pollemail').val())){
					alert("???????????? ?????? ?????? ???????????????. ?????? ??????????????????")
					$("#pollemail").focus();
					return false;
				}
			}
			if($('#pollfax01').val() != '' && $('#pollfax02').val() != '' && $('#pollfax03').val() != ''){
				var pollfax_check = $('#pollfax01').val()+'-'+$('#pollfax02').val()+'-'+$('#pollfax03').val();
				$('#pollfax').val(pollfax_check);
				
				if(!regExp.test($('#pollfax').val())){
					alert("?????? ????????? ?????? ?????? ???????????????. ?????? ??????????????????");
					$('#pollfax01').focus();
					return false;
				}
			}
			if($('#agenm').val() == ''){
				alert("???????????? ?????? ????????????");
				$('#agenm').focus();
				return false;
			}
			if($('#answer').val() == ''){
				alert("?????????????????? ?????? ????????????");
				$('#answer').focus();
				return false;
			}
			if(permEditor=="Y"){
				oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			}
			$('#mode').val(mode);
			$('#fedit').submit();
		}
		
		
		/* ?????? */
		$(document).ready(function(){
		    $("#pollstart, #pollend").datepicker({
		        showMonthAfterYear : true,
		        showButtonPanel : true,
		        changeMonth : true,
		        changeYear : true,
		        nextText : '?????? ???',
		        prevText : '?????? ???',
		        currentText : '?????? ??????',
		        closeText : '??????',
		        dateFormat : "yy-mm-dd",
		        dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		        dayNamesMin : ['???','???','???','???','???','???','???'],
		        monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		        monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
		    });

		      // ?????? ????????? ?????? ?????? ?????? ????????? ?????? ??? ??????
		     $('#pollstart').datepicker("option", "maxDate", $("#pollend").val());
		     $('#pollstart').datepicker("option", "onClose", function ( selectedDate ) {
		     $("#pollend").datepicker("option", "minDate", selectedDate );
		     });

		    // ?????? ????????? ?????? ?????? ?????? ????????? ?????? ??? ??????
		     $('#pollend').datepicker("option", "minDate", $("#pollstart").val());
		     $('#pollend').datepicker("option", "onClose", function ( selectedDate ) {
		     $("#pollstart").datepicker("option", "maxDate", selectedDate );
		    });
		     //????????? 
		     $('#selectEmail').change(function(){
		  	   $("#selectEmail option:selected").each(function () {
		  	        if($(this).val()== '1'){ //??????????????? ??????
		  	             $("#email02").val('');                        //??? ?????????
		  	             $("#email02").attr("disabled",false); //?????????
		  	        }else{ //??????????????? ????????????
		  	             $("#email02").val($(this).val());      //????????? ??????
		  	             $("#email02").attr("disabled",true); //????????????
		  	        }
		  	   });
		  	});
		 });

</script>