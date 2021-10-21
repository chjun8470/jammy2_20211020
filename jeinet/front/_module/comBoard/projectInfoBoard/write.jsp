<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	ArrayList<HashMap<String, String>> supportTypeList = request.getAttribute("supportTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportTypeList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchReceipt = util.getStr(paramMap.get("searchReceipt"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분
	
	String supportType = "";
	if(siteId.equals("jeinet")){
		supportType = "03";
	}else if(siteId.equals("jipbank")){
		supportType = "04";
	}

	if("".equals(mode)) mode = "write";

%>
<form name="fwrite" id="fwrite" action="sub.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchReceipt" id="searchReceipt" value="<%=searchReceipt%>" />
	<%if(siteId.equals("jeinet")){	%>
			
	<input type="hidden" name="supportType" id="supportType" value="<%=supportType%>" />
			
	<%}else if(siteId.equals("jipbank")){	%>	
					
	<input type="hidden" name="supportType" id="supportType" value="<%=supportType%>" />
			
	<%}	%>

	<div class="basic_writeWrap">
		<div class="redTxt" style="margin-bottom:10px">* 필수 입력사항입니다.</div>
		<table class="skin_write">
			<caption>작성하기</caption>
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<tbody>
			<%
			if(siteId.equals("jntis")){
			 %>	
			
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 지원사업유형
					</th>
					<td class="r_line_none p_top_btm_6">
						<select name="supportType" id="supportType" class="b_select2" style="width: 31%;">
						<%for(HashMap rs:supportTypeList){%>
							<option value="<%=util.getStr(rs.get("CODE_CD")) %>"><%=util.getStr(rs.get("CODE_NM")) %></option>
						<%}%>
	              		</select>
					</td>
				</tr>
			<%}%>
			
			
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 사업명
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="subject" id="subject" value="" class="b_txtbox1" />
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 사업비
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="proExpense" id="proExpense" value="" class="b_txtbox1" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 접수기간
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="recStDt" id="recStDt" class="b_txtbox3" value="" style="width:13%;" /> ~
						<input type="text" name="recEdDt" id="recEdDt" class="b_txtbox3" value="" style="width:13%;" />
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 사업기간
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="proStDt" id="proStDt" class="b_txtbox3" value="" style="width:13%;" /> ~
						<input type="text" name="proEdDt" id="proEdDt" class="b_txtbox3" value="" style="width:13%;" />
					</td>
				</tr>
				<tr>
					<th class="col">
						 지원부처
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="supportPlace" id="supportPlace" value="" class="b_txtbox1" />
					</td>
				</tr>
				<tr>
					<th class="col"> 담당기관/부서</th>
					<td class="r_line_none p_top_btm_6">
						<span id="orgGroupTd">
							<input type="text" name="OwnOrgNm" id="OwnOrgNm" value="" class="b_txtbox1" style="padding-left:2px; font-size:12px" placeholder=" 기관검색버튼을 클릭해주세요."/>&nbsp;
							<input type="hidden" name="OwnOrg" id="OwnOrg" value=""/>
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="b_btn_01" onclick="popupWindow('registrationOrgList')" >
						</span>
						<span>
							<input type="text" name="OwnDeptNm" id="OwnDeptNm" value="" class="b_txtbox1" style="padding-left:2px; font-size:12px" placeholder=" 부서검색버튼을 클릭해주세요."/>&nbsp;
							<input type="button" name="blngOrgSubNm" value="부서검색" id="blngOrgSubNm" class="b_btn_02" onclick="popupWindow('registrationOrgSubList')" >
						</span>

					</td>
				</tr>				
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 사업담당자
					</th>
					<td class="r_line_none p_top_btm_6">
						<table>
						<tr><th>성       명</th><td><input type="text" name="proChargeNm" id="proChargeNm" value="" class="b_txtbox1" /></td></tr>
						<tr><th>직       위</th><td><input type="text" name="proChargePosition" id="proChargePosition" value="" class="b_txtbox1" /></td></tr>
						<tr><th>이  메  일</th><td><input type="text" name="proChargeEmail" id="proChargeEmail" value="" class="b_txtbox1" /></td></tr>
						<tr><th>전       화</th><td><input type="text" name="proChargeTel" id="proChargeTel" value="" class="b_txtbox1" /></td></tr>
						</table>						
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> 사업목적
					</th>
					<td class="r_line_none p_top_btm_6">
						<textarea name="proPurpose" id="proPurpose" class="b_txtbox1" style="height:90px; font-size:16px;"></textarea>
					</td>
				</tr>
				<tr>
					<th class="col">사업내용</th>
					<td class="r_line_none p_top_btm_6">
						<textarea name="content" id="contents" class="b_txtbox4" style="width:98%"></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th class="col">첨부파일</th>
					<td class="r_line_none p_top_btm_6">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div style="padding-bottom:5px;">
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" class="select00401" title="파일첨부" />
						</div>
	              	</div>

	              	<div style="display:inline-block;vertical-align:bottom;padding-bottom:5px;">
	              		<button class="addImageBtn b_btn_00401" type="button" onclick="addRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_plus.gif" alt="첨부파일 추가 버튼" /></button>
						<button class="delImageBtn b_btn_00401" type="button" onclick="delRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_del.gif" alt="첨부파일 삭제 버튼" /></button>
	              		<%-- <input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
						<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" /> --%>
	              	</div>
	              	<br/> * 300kb이상의 실사이미지만 등록이 가능합니다.
					<br/> * 가로형 이미지만 등록해주세요.

	        <script type="text/javascript">
					var arrfileCnt = new Array();
					arrfileCnt['<%=fileFullGrp%>'] = 2;
		            function addRowFile(fileGrpnm){
	            		var fileHtml = "<div style='padding-bottom:5px;'>";
	            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"' style='height:37px;' title='파일첨부' />";
	            		fileHtml += "</div>";

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
		<div class="b_btn_area" >
			<button type="button" class="btn_lft2" onclick="goSubmit('list')">목록</button>
			<button type="button" class="btn_rgt" onclick="goSubmit('writeProc')">작성</button>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){

		$("#recStDt, #recEdDt, #proStDt, #proEdDt").datepicker({
			showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',
			currentText : '오늘 날짜',
			closeText : '닫기',
			dateFormat : "yy-mm-dd",
			dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
			dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
		});

		// 시작일 값에 따른 종료일 선택 값 제한
	    $('#recStDt').datepicker("option", "maxDate", $("#recEdDt").val());
	    $('#recStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#recEdDt").datepicker( "option", "minDate", selectedDate );
	    });
		// 종료일 값에 따른 시작일 선택 값 제한
	    $('#recEdDt').datepicker("option", "minDate", $("#recStDt").val());
	    $('#recEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#recStDt").datepicker( "option", "maxDate", selectedDate );
		});

	 	// 시작일 값에 따른 종료일 선택 값 제한
	    $('#proStDt').datepicker("option", "maxDate", $("#proEdDt").val());
	    $('#proStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#proEdDt").datepicker( "option", "minDate", selectedDate );
	    });
	 	// 종료일 값에 따른 시작일 선택 값 제한
	    $('#proEdDt').datepicker("option", "minDate", $("#proStDt").val());
	    $('#proEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	    $("#proStDt").datepicker( "option", "maxDate", selectedDate );
		});

		//숫자만 입력
		$("#proExpense").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^0-9]/gi,''));
            }
        });
		$("#proChargeTel").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^0-9]/gi,''));
            }
        });
		
		//이름 입력
		$('#proChargeNm').change(function(){
				var value = $('#proChargeNm').val();
				var pattern = /^[가-힣]{2,5}$/;
				var match = pattern.exec(value);

				if(match == null || value.length < 2 || value.length > 5){
					alert("이름은 한글 2자이상 5자 이하로 입력해야 합니다.");
					$('#proChargeNm').val('').focus();
					return;
				}
		});
		
		//이메일 입력
		$('#proChargeEmail').change(function(){
			var value = $('#proChargeEmail').val();
			var pattern = /^[_0-9a-zA-Z-.]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)$/;
			var match = pattern.exec(value);

			if(match == null){
				alert("email 형식으로 입력해야 합니다.");
				$('#proChargeEmail').val('').focus();
				return;
			};
		 });

	});

	function goSubmit(mode){

		//작성 클릭시(mode = writeProc일때) 필수값 체크
		if(mode == 'writeProc'){
			if($('#subject').val() == ""){
				alert("사업명을 입력해주세요");
				return false;
			}
			if($('#proExpense').val() == ""){
				alert("사업비를 입력해주세요");
				return false;
			}
			if($('#recStDt').val() == "" || $('#recEdDt').val() == ""){
				alert("접수기간을 입력해주세요");
				return false;
			}
			if($('#proStDt').val() == "" || $('#proEdDt').val() == ""){
				alert("사업기간을 입력해주세요");
				return false;
			}
			
			if($('#proChargeNm').val() == ""){
				alert("사업담당자 성명을 입력해주세요");
				return false;
			}
			if($('#proPurpose').val() == ""){
				alert("사업목적를 입력해주세요");
				return false;
			}
		}



        if(mode=="writeProc" && permEditor=="Y"){
               oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

               if((oEditors[0].getIR()).length < 15){
            	  alert("사업내용을 다시 입력해주세요");
            	  return false;
               }
               //alert( oEditors[0].getIR() );
               //alert( document.getElementById("contents").value );
               //alert((oEditors[0].getIR()).length);
        }
        $('#mode').val(mode);
        $('#fwrite').submit();
     }

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
	
	/*---------기관검색 S----------*/
	//기관검색 팝업
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="";
		
		if(listMode == 'registrationOrgSubList'){
			popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('input[name=OwnOrg]').val();
		}else{
    		popUrl="/sys/popup/"+listMode+".do";
		}
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	//기관정보
	function orgInfo(orgGrpCd){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),

		function(data){
			orgGrpNm = data.dataMap.ORG_GRP_NM; //기관명
			//orgGrpCd = data.dataMap.ORG_GRP_CD; //기관코드
			$("#orgGroupNm").val(orgGrpNm);
			//$("#eventManageOrgCd").val(orgGrpCd);
			$("#orgGroupDeptNm").val("");
		});
	}
	/*---------기관검색 E----------*/

</script>