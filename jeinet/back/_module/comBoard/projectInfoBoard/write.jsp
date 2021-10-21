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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

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
	
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	if("".equals(mode)) mode = "write";

%>
<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchReceipt" id="searchReceipt" value="<%=searchReceipt%>" />


	<div class="skin_bbs_write" style="margin-top: 30px; width: 1000px;">
		<font color="red">* 필수 입력사항입니다.</font>
		<table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
			<caption>작성하기</caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="supportType"> 지원사업유형</label>
					</th>
					<td>
						<select name="supportType" id="supportType" style="width:30%;">
						<%for(HashMap rs:supportTypeList){%>
							<option value="<%=util.getStr(rs.get("CODE_CD")) %>"><%=util.getStr(rs.get("CODE_NM")) %></option>
						<%}%>
	              		</select>
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="subject"> 사업명</label>
					</th>
					<td>
						<input type="text" name="subject" id="subject" value="" style="width: 95%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proExpense"> 사업비</label>
					</th>
					<td>
						<input type="text" name="proExpense" id="proExpense" value="" style="width: 95%;" maxlength="10" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="recDt"> 접수기간</label>
					</th>
					<td>
						<input type="text" name="recStDt" id="recStDt" value="" /> ~
						<input type="text" name="recEdDt" id="recEdDt" value="" />
					</td>
				</tr>
				
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proDt"> 사업기간</label>
					</th>
					<td>
						<input type="text" name="proStDt" id="proStDt" value="" /> ~
						<input type="text" name="proEdDt" id="proEdDt" value="" />
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
							<input type="text" name="OwnOrgNm" id="OwnOrgNm" value="" class="b_txtbox1" style="width:30%;" placeholder=" 기관검색버튼을 클릭해주세요."/>&nbsp;
							<input type="hidden" name="OwnOrg" id="OwnOrg" value=""/>
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="b_btn_01" onclick="popupWindow('registrationOrgList')" >
						</span>
						<span>
							<input type="text" name="OwnDeptNm" id="OwnDeptNm" value="" class="b_txtbox1" style="width:30%;" placeholder=" 부서검색버튼을 클릭해주세요."/>&nbsp;
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
						<tr><th>전       화</th><td><input type="text" name="proChargeTel" id="proChargeTel" value="" class="b_txtbox1" maxlength="11"/></td></tr>
						</table>						
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proPurpose"> 사업목적</label>
					</th>
					<td>
						<textarea rows="5" cols="111" name="proPurpose" id="proPurpose"></textarea>
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="contents"> 사업내용</label>
					</th>
					<td class="con-txt">
						<textarea name="content" id="contents" style="width: 100%; height: 350px;"></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th class="tit">
						<label for="extfile"> 첨부파일</label>
					</th>
					<td>
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
						</div>
	              	</div>

	              	<div style="display:inline-block;vertical-align:bottom;">
	              		<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
						<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
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
					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="작성" onclick="goSubmit('writeProc')"/>
			<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
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
			if($('#content').val() == ""){
				alert("사업내용을 입력해주세요");
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

	var permEditor = $('#permEditor').val();
	if(permEditor=="Y"){
	    var oEditors = [];
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
				},  //boolean
				fCreator : "createSEditor2"
			});
		});
	}
	
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

</script>