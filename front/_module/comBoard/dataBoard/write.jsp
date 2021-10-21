<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
        String display = "sub";
        request.setCharacterEncoding("utf-8");
        ComUtil util = new ComUtil();

        HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
        HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
        HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

        StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
        LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
        ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

        String siteId = util.getStr(paramMap.get("siteId"));
        String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
        String mode = util.getStr(paramMap.get("mode"));
        String m = util.getStr(paramMap.get("m"));
        String nowPage = util.getIntStr(paramMap.get("nowPage"));
        String boardIdx = util.getStr(paramMap.get("boardIdx"));
		String searchType = util.getStr(paramMap.get("searchType"));
   		String searchWord = util.getStr(paramMap.get("searchWord"));
   		String searchDataType = util.getStr(paramMap.get("searchDataType"));

        if("".equals(mode)) mode = "write";

        String fileGrp = "board";
        String fileSubGrp = "";
        String fileFullGrp =fileGrp+fileSubGrp;
%>

<form name="fwrite" id="fwrite" action="sub.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
    <input type="hidden" name="siteId" id="siteId" value="<%=siteId %>" />
    <input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
    <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
    <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
    <input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchDataType" id="searchDataType" value="<%=searchDataType%>" />

    <div class="basic_writeWrap004">
    	<div class="redTxt" style="margin-bottom:10px"> * 필수 입력사항입니다.</div>
        <table class="skin_write004">
        	<caption>작성하기</caption>
            <colgroup>
				<col style="width: 15%;" />
				<col style="width: 85%;" />
			</colgroup>
            <thead>
            	<!--공지글-->
                <%--
	                <%if(util.getStr(boardMap.get("BOARD_ID")).equals("00053") || util.getStr(boardMap.get("BOARD_ID")).equals("00032") || util.getStr(boardMap.get("BOARD_ID")).equals("00005") || util.getStr(boardMap.get("BOARD_ID")).equals("00001")){ %>
		            <tr>
						<th scope="row" class="tit">
			               	<span style="color:red; font-size:11pt;">*</span><label for="noticeAt"> 공지글여부</label>
			            </th>
						<td>
			               	사용 <input type="checkbox" name="noticeAt" id="noticeAt" value="Y" onclick="check_only(this)"/>
			               	미사용 <input type="checkbox" name="noticeAt" id="noticeAt_N" value="N" checked="checked" onclick="check_only(this)"/>
			            </td>
		            </tr>
		            <%}%>
	            --%>
	            <tr>
	            	<th scope="col"><span style="color:red; font-size:11pt;">*</span> 자료구분</th>
			    	<td class="r_line_none">
						<select name="dataType" id="dataType" class="select_box2">
							<option value="교육">교육자료</option>
							<option value="행사">행사자료</option>
						</select>
					</td>
	            </tr>
                <tr>
			    	<th scope="col"><span style="color:red; font-size:11pt;">*</span> 제목</th>
			    	<td class="r_line_none">
			    		<input type="text" name="subject" id="subject" value="" class="input_txt00401" maxlength="100" />
                        <!-- <div class="checkBox00401">
                        <input type="checkbox" name="secretAt" id="secretAt" value="Y" />&nbsp;비밀글
                        </div> -->
                    </td>
                </tr>
			</thead>
			<tbody>
                <tr>
			    	<th scope="col">내용</th>
			    	<td class="r_line_none">
			    		<textarea name="content" id="contents" style="width:100%; height:350px; font-size:10pt;"></textarea>
			    	</td>
			  	</tr>

                <!-- 파일첨부 -->
			  	<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
			  	<tr>
                	<th scope="row">자료첨부</th>
                    <td class="r_line_none">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" class="select00401" title="파일첨부"/>
						<button class="b_btn_00401" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
						<button class="b_btn_00401" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>
	              		<!--<br/> * 300kb이상의 이미지만 등록이 가능합니다.-->
	              		<!--<br/> * 첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.-->
	              	</div>

	        		<script type="text/javascript">
	        		//<![CDATA[
						var arrfileCnt = new Array();
						arrfileCnt['<%=fileFullGrp%>'] = 2;
			            function addRowFile(fileGrpnm){
		            		var fileHtml = "<div>";
		            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부'  style='height:26px;'/>";
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
			        //]]>    
	        		</script>
					</td>
				</tr>
				<% } %>
              </tbody>
		</table>

	</div>
	<!--basic_listWrap E-->


	<!--b_btn_area S-->
	<div class="b_btn_area">
		<button class="btn_lft2 color_box_btn_1" onclick="goSubmit('list')">취소</button>
		<button class="btn_rgt" onclick="goSubmit('writeProc')">작성</button>
	</div>
	<!--b_btn_area E-->


</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//<![CDATA[
       function goSubmit(mode){

    	   if(mode=="writeProc"){

	   			if($('#subject').val() == ""){
	     				alert("제목을 입력해주세요");
	     				return false;
	   			}

	   			if (confirm("저장하시겠습니까??") == true){ //확인

	   				if(permEditor=="Y"){
	   					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	   				}

	   			}else{ //취소
	   			    return;
	   			}
	   		}

    	    if(mode == "list"){
           		$('#fwrite').attr("action", "sub.do");
            }

            $('#mode').val(mode);
            $('#fwrite').submit();
       }

       var permEditor = $('#permEditor').val();
       if(permEditor=="Y"){
           var oEditors = [];
              $(function(){
                     //추가 글꼴 목록
                     //var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
                     nhn.husky.EZCreator.createInIFrame({
                           oAppRef: oEditors,
                           elPlaceHolder: "contents",
                           sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
                           htParams : {
                                  bUseToolbar : true,                      // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                                  bUseVerticalResizer : true,       // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                                  bUseModeChanger : true,                  // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                                  //aAdditionalFontList : aAdditionalFontSet,              // 추가 글꼴 목록
                           }, //boolean
                           fCreator : "createSEditor2"
                     });
              });
       }

       /*
       //공지글
       function check_only(chk){
           var obj = document.getElementsByName("noticeAt");
           for(var i=0; i<obj.length; i++){
               if(obj[i] != chk){
                   obj[i].checked = false;
               }
           }
       }
       */

       $(document).ready(function() {
     		var win_w = $(window).width();
     		if(win_w >= 768){
     			if(permEditor == "Y"){
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

     				if(permEditor == "Y"){
     					if($('#contents').css("display")!='none'){
     						htmlEditor();
     						$('#contents').hide();
     					}

     				}
     		}else if(win_w < 768){ //모바일 769 이하일때 100%
     			if(permEditor == "Y"){
     				if($('#contents').css("display")=='none'){
     					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
     					$('.r_line_none iframe').remove();
     					$('#contents').show();
     				}
     			}

     		}else{ //기본사이즈
     		}

     	}
//]]>     	
</script>