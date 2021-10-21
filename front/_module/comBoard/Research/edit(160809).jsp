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
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String tab = util.getStr(paramMap.get("tab"));
	String auth_lv = util.getStr(paramMap.get("auth_lv"));
	String sttus = util.getStr(dataMap.get("DATA15"));
	String userId = util.getStr(paramMap.get("userId"));
	String siteId = util.getStr(paramMap.get("siteId"));

	if("".equals(mode)) mode = "edit";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>
<form name="fedit" id="fedit" action="?<%=m%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="tab" id="tab" value="<%=tab%>" />
	<input type="hidden" name="sttus" id="sttus" value="<%=sttus%>" />
	<input type="hidden" name="auth_lv" id="auth_lv" value="<%=auth_lv%>" />
	<input type="hidden" name="userId" id="userId" value="<%=userId%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	
		<div class="basic_writeWrap">
			<font color="red">* 필수 입력사항입니다.</font>
			<br/>
			<br/>
	        <table class="skin_write" >
	          <caption>
	          작성하기
	          </caption>
	          <colgroup>
	          <col style="width:15%;" />
      			<col style="width:75%;" />
	          </colgroup>
	          <tbody>
	            <tr>
	              <th scope="col"><font color="red"> * </font><label for="subject">제목</label></th>
	              <td class="r_line_none p_top_btm_6"><input type="text" name="subject" id="subject" class="b_txtbox2" value="<%=util.getStr(dataMap.get("SUBJECT")) %>" /></td>
	            </tr>
				<tr>
	              <th scope="col"><label for="pollurl">구글 설문조사 URL</label></th>
	              <td class="r_line_none p_top_btm_6">
	              	<input type="text" name="pollurl" id="pollurl" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA01")) %>" /><br/>
	              	ex) http://naver.com
	              </td>
	            </tr>
	            <tr>
	              <th scope="col"><label for="pollfax01">회신처</label></th>
	              <td class="r_line_none p_top_btm_6">
	              	<input type="hidden" name="pollemail" id="pollemail"/>
	              	<input type="hidden" name="email03" id="email03"/>
	              	<input type="hidden" name="pollfax" id="pollfax" />
	              	FAX :
	              		<input type="text" name="pollfax01" id="pollfax01" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA10")) %>" style="width:7%;" maxlength="100" /> - <input type="text" name="pollfax02" id="pollfax02" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA11")) %>" style="width:7%;" maxlength="100" /> - <input type="text" name="pollfax03" id="pollfax03" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA12")) %>" style="width:7%;" maxlength="100" />
	              		ex) 061-460-5200
	              	<br/><br/>
	              	EMAIL :
	              		<input type="text" name="email01" id="email01" value="<%=util.getStr(dataMap.get("DATA08")) %>" class="b_txtbox2" style="width:15%;" maxlength="100" title="이메일 입력" /> @ <input type="text" name="email02" id="email02" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA09")) %>" style="width:20%;" />
						<select class="select_box" style="width:20%; height:35px" name="selectEmail" id="selectEmail">
						     <option value="1" selected="selected">직접입력</option>
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
	              <th scope="row" class="tit"><font color="red"> * </font><label for="pollstart">기간</label></th>
	              <td class="r_line_none p_top_btm_6">
	              	<input type="text" name="pollstart" id="pollstart" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA04")) %>" style="width:30%;" maxlength="100" /> ~ <input type="text" name="pollend" id="pollend" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA05")) %>" style="width:30%;" maxlength="100" />
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="contents">내용</label></th>
	              <td class="r_line_none p_top_btm_6">

	              	<textarea rows="5" cols="10" name="content" id="contents" class="b_txtbox4" ><%=util.getStr(dataMap.get("CONTENT")) %></textarea>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><font color="red"> * </font><label for="agenm">기관명</label></th>
	              <td class="r_line_none p_top_btm_6">
	              	<select style="width:20%"  class="b_select2" name="agenm" id="agenm">
					<%if(util.getStr(dataMap.get("DATA06")) ==""){ %>
	              		<option value="" selected>선택목록</option>
						 <%for(HashMap rs:dataList) { %>
						     <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>"><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
						 <%} %>
					 <%} else{%>
					 	 <option value="" >선택목록</option>
						<%for(HashMap rs:dataList) {
						 	if(util.getStr(rs.get("ORG_GRP_NM")).equals(util.getStr(dataMap.get("DATA06")))){%>
						     <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>" selected="selected"><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
						 <%  }else{%>
							 <option value="<%=util.getStr(rs.get("ORG_GRP_NM")) %>" ><%=util.getStr(rs.get("ORG_GRP_NM")) %></option>
						<%	 }
						 }%>
					<%} %>
					</select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><font color="red"> * </font><label for="answer">응답대상자</label></th>
	              <td class="r_line_none p_top_btm_6">
	              	<input type="text" name="answer" id="answer" class="b_txtbox2" value="<%=util.getStr(dataMap.get("DATA07")) %>" />
	              </td>
	            </tr>

	             <%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="row" class="tit">
						첨부파일
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
								<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
								
									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								
							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" style="height:37px;" />
							<button class="b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_plus.gif" alt="첨부파일 추가 버튼" /></button>
							<button class="b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_del.gif" alt="첨부파일 삭제 버튼" /></button>
						</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function addRowFile(fileGrpnm){
					            	//<![CDATA[
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
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
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="파일첨부" style="height:37px;" />
								<button class="b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_plus.gif" alt="첨부파일 추가 버튼" /></button>
								<button class="b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_del.gif" alt="첨부파일 삭제 버튼" /></button>
							</div>
						</div>
						<script type="text/javascript">
							var arrfileCnt = new Array();
							arrfileCnt['<%=fileFullGrp%>'] = 2;
				            function addRowFile(fileGrpnm){
			            		var fileHtml = "<div>";
			            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
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
	        <div class="b_btn_area">
				<button class="btn_lft2" onclick="goSubmit('view')">취소</button>
				<button class="btn_rgt" onclick="goSubmit('editProc')">수정</button>
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
			// 추가 글꼴 목록
			//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "contents",
				sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
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
	
	if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
		
			if(permEditor=="Y"){
				if($('#contents').css("display")!='none'){
					htmlEditor();
					$('#contents').hide();
				}
				
			}
	}else if(win_w < 768){ //모바일 769 이하일때 100%
		if(permEditor=="Y"){
			if($('#contents').css("display")=='none'){
				oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				$('.r_line_none iframe').remove();
				$('#contents').show();
			}
		}
		
	}else{ //기본사이즈
	}
	
}

	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fedit').submit();
	}

	function goSubmit(mode){
		var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
		var regUrl = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
		if($('#subject').val() == ''){
			alert("제목을 입력 해주세요");
			$('#subject').focus();
			return false;
		}
		if($('#pollurl').val() != ''){
			if(!regUrl.test($('#pollurl').val())){
				alert("URL를 잘못 입력 하셨습니다. 다시 입력해주세요");
				$('#pollurl').focus();
				return false;
			}
		}
		if($('#pollstart').val() == '' && $('#pollend').val() == ''){
			alert("기간을 입력 해주세요");
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
			}else{//선택 입력일 경우
				var email_check03 = $('#email02').val();
				var email_check = $('#email01').val()+"@"+ $('#email02').val();
				$('#email03').val(email_check03);
				$('#pollemail').val(email_check);
			}
			if(!regEmail.test($('#pollemail').val())){
				alert("이메일을 잘못 입력 하셨습니다. 다시 입력해주세요")
				$("#pollemail").focus();
				return false;
			}
		}
		if($('#pollfax01').val() != '' && $('#pollfax02').val() != '' && $('#pollfax03').val() != ''){
			var pollfax_check = $('#pollfax01').val()+'-'+$('#pollfax02').val()+'-'+$('#pollfax03').val();
			$('#pollfax').val(pollfax_check);

			if(!regExp.test($('#pollfax').val())){
				alert("팩스 번호를 잘못 입력 하셨습니다. 다시 입력해주세요");
				$('#pollfax01').focus();
				return false;
			}
		}
		if($('#agenm').val() == ''){
			alert("기관명을 입력 해주세요");
			$('#agenm').focus();
			return false;
		}
		if($('#answer').val() == ''){
			alert("응답대상자를 입력 해주세요");
			$('#answer').focus();
			return false;
		}
		if(permEditor=="Y"){
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		$('#mode').val(mode);
		$('#fedit').submit();
	}


		/* 달력 */
		$(document).ready(function(){
		    $("#pollstart, #pollend").datepicker({
		        showMonthAfterYear : true,
		        showButtonPanel : true,
		        changeMonth : true,
		        changeYear : true,
		        nextText : '다음 달',
		        prevText : '이전 달',
		        currentText : '오늘 날짜',
		        closeText : '닫기',
		        dateFormat : "yy-mm-dd",
		        dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		        dayNamesMin : ['월','화','수','목','금','토','일'],
		        monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
		    });

		      // 작업 시작일 값에 따른 작업 종료일 선택 값 제한
		     $('#pollstart').datepicker("option", "maxDate", $("#pollend").val());
		     $('#pollstart').datepicker("option", "onClose", function ( selectedDate ) {
		     $("#pollend").datepicker("option", "minDate", selectedDate );
		     });

		    // 작업 종료일 값에 따른 작업 시작일 선택 값 제한
		     $('#pollend').datepicker("option", "minDate", $("#pollstart").val());
		     $('#pollend').datepicker("option", "onClose", function ( selectedDate ) {
		     $("#pollstart").datepicker("option", "maxDate", selectedDate );
		    });
		     //이메일
		     $('#selectEmail').change(function(){
		  	   $("#selectEmail option:selected").each(function () {
		  	        if($(this).val()== '1'){ //직접입력일 경우
		  	             $("#email02").val('');                        //값 초기화
		  	             $("#email02").attr("disabled",false); //활성화
		  	        }else{ //직접입력이 아닐경우
		  	             $("#email02").val($(this).val());      //선택값 입력
		  	             $("#email02").attr("disabled",true); //비활성화
		  	        }
		  	   });
		  	});
		 });

</script>