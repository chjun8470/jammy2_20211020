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
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	if("".equals(mode)) mode = "writePorc";
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String tab = util.getStr(paramMap.get("tab"));
	String auth_lv = util.getStr(paramMap.get("auth_lv"));
	String userId = util.getStr(paramMap.get("userId"));
	String siteId = util.getStr(paramMap.get("siteId"));

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>

	  <form name="fwrite" id="fwrite" action="./sub.do" method="post" enctype="multipart/form-data"  >
	  	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="m" value="<%=m%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
		<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="m" value="<%=m%>" />
		<input type="hidden" name="tab" id="tab" value="<%=tab%>" />
		<input type="hidden" name="auth_lv" id="auth_lv" value="<%=auth_lv%>" />
		<input type="hidden" name="userId" id="userId" value="<%=userId%>" />
		<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
		<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
		

		<div class="basic_writeWrap">
			<div class="redTxt" style="margin-bottom:10px">* ?????? ?????????????????????.</div>
			
	        <table class="skin_write" summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
	          <caption>
	          ????????????
	          </caption>
	          <colgroup>
	          <col style="width:20%;" />
      			<col style="width:80%;" />
	          </colgroup>
	          <tbody>
	            <tr>
	              <th scope="col"><font color="red"> * </font><label for="subject">??????</label></th>
	              <td class="r_line_none"><input type="text" name="subject" id="subject" class="b_txtbox2 box_size_480" value="<%=util.getStr(dataMap.get("SUBJECT")) %>" /></td>
	            </tr>
				<tr>
	              <th scope="col"><label for="pollurl">?????? ???????????? URL</label></th>
	              <td class="r_line_none">
	              	<input type="text" name="pollurl" id="pollurl" class="b_txtbox2 box_size_480" value="" /><br/>
	              	ex) http://naver.com
	              </td>
	            </tr>
	            <tr>
	              <th scope="col"><label for="pollfax01">?????????</label></th>
	              <td class="r_line_none p_top_btm_6">
	              	<input type="hidden" name="pollemail" id="pollemail" />
	              	<input type="hidden" name="email03" id="email03" />
	              	<input type="hidden" name="pollfax" id="pollfax" />
	              	FAX : <input type="text" name="pollfax01" id="pollfax01" class="b_txtbox2" style="width:7%;" maxlength="100" /> - <input type="text" name="pollfax02" id="pollfax02" class="b_txtbox2" style="width:7%;" maxlength="100" /> - <input type="text" name="pollfax03" id="pollfax03" class="b_txtbox2" style="width:7%;" maxlength="100" />
	              	ex) 061-460-5200
	              	<br/><br/>
	              	EMAIL : <input type="text" name="email01" id="email01" value="" class="b_txtbox2" style="width:15%;" maxlength="100" title="????????? ??????" /> @ <input type="text" name="email02" id="email02" class="b_txtbox2" style="width:20%;" />
	              		<select class="select_box" style="width:20%; height:31px" name="selectEmail" id="selectEmail">
						     <option value="1" selected="selected">????????????</option>
						     <option value="naver.com">naver.com</option>
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
	              <th scope="row" class="tit"><font color="red"> * </font><label for="pollstart">??????</label></th>
	              <td class="r_line_none">
	              	<input type="text" name="pollstart" id="pollstart" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA04")) %>" style="width:30%;" maxlength="100" /> ~ <input type="text" name="pollend" id="pollend" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA05")) %>" style="width:30%;" maxlength="100" />
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="contents">??????</label></th>
	              <td class="r_line_none p_top_btm_6">

	              	<textarea rows="5" cols="10" name="content" id="contents" class="b_txtbox4 box_size_cs box_size_cs_vr"></textarea>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><font color="red"> * </font><label for="agenm">?????????</label></th>
	              <td class="r_line_none">
	              	<select class="b_select2" name="agenm" id="agenm">
					     <option value="" selected="selected">????????????</option>
					 <%for(HashMap rs:dataList) { %>
					     <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>"><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
					 <%} %>
					</select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><font color="red"> * </font><label for="answer">???????????????</label></th>
	              <td class="r_line_none">
	              	<input type="text" name="answer" id="answer" class="b_txtbox2 box_size_480" value="<%=util.getStr(dataMap.get("DATA07")) %>" />
	              </td>
	            </tr>

			<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="row" class="tit">
						????????????
					</th>
					<td class="r_line_none p_top_btm_6">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" title="????????????" class="select00401"/>
	              		<button class="b_btn_00401"" type="button" onclick="addRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_plus.gif" alt="???????????? ?????? ??????" /></button>
						<button class="b_btn_00401"" type="button" onclick="delRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_del.gif" alt="???????????? ?????? ??????" /></button>
	              	</div>

	        <script type="text/javascript">
					var arrfileCnt = new Array();
					arrfileCnt['<%=fileFullGrp%>'] = 2;
		            function addRowFile(fileGrpnm){
		            	//<![CDATA[
	            		var fileHtml = "<div style='padding-bottom:10px;'>";
	            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
	            		fileHtml += "</div>";
	            		//]]>
            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
            			arrfileCnt[fileGrpnm]++;
	            	}

		            function delRowFile(fileGrpnm){
		            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 0){
		            		return;
		            	}
		            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
		            	arrfileCnt[fileGrpnm]--;
		            }
	        </script>
					</td>
				</tr>
			<%} %>
	          </tbody>
	        </table>

	        <!-- bo_btn  -->
	        <div class="b_btn_area">
				<button class="btn_lft2" onclick="pageListGo()">??????</button>
				<button class="btn_rgt" onclick="goSubmit('writeProc')">??????</button>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
var permEditor = $('#permEditor').val();

function htmlEditor(){
	if(permEditor=="Y"){
	   
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
}
$(document).ready(function() {
	var win_w = $(window).width();
	if(win_w >= 768){
		if(permEditor=="Y"){
			$('#contents').hide();
			htmlEditor();
		}
	}
	$(window).resize(function(){
		winResize();
	});
	winResize();
});


function winResize(){
	var win_w = $(window).width();
	
	if(win_w < 1198 && win_w >= 768){ //????????? 1198 , 768 ???????????? 100%
		
			if(permEditor=="Y"){
				if($('#contents').css("display")!='none'){
					htmlEditor();
					$('#contents').hide();
				}
				
			}
	}else if(win_w < 768){ //????????? 769 ???????????? 100%
		if(permEditor=="Y"){
			if($('#contents').css("display")=='none'){
				oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				$('.r_line_none iframe').remove();
				$('#contents').show();
			}
		}
		
	}else{ //???????????????
	}
	
}

	function pageListGo(){
		$('#mode').val('list');
		$('#fwrite').submit();
	}
	function goSubmit(mode){
		var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
		var regUrl = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
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
		$('#fwrite').submit();
	}
	$(document).ready(function(){

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
	});
</script>