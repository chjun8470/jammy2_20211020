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
       StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
       ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
       LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

       String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String boardIdx = util.getStr(paramMap.get("boardIdx"));
       if("".equals(mode)) mode = "write";
   	String searchType = util.getStr(paramMap.get("searchType"));
   	String searchWord = util.getStr(paramMap.get("searchWord"));
   	
       String fileGrp = "board";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

%>
<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
       <input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
       <input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
       <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
       <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
       <input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
       <input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
       <input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
       <input type="hidden" name="num1" id="userIdx" value="<%=util.getStr(loginVO.getUserIdx())%>" />
       <input type="hidden" name="subject" id="subject" value="???????????????" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	   <div class="skin_bbs_write" style="margin-top: 30px">
	   		<font color="red">* ?????? ?????????????????????.</font>
	   		<table class="skin_basic_write" summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
	   			<caption>???????????????</caption>
                     <colgroup>
                           <col width="140px" />
                           <col width="*" />
                     </colgroup>
                     <tbody>
                     	   <tr>
                           		<th scope="row" class="tit" colspan="2">
                           			<label for="userInfo">????????????</label>
                           		</th>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="name">??????</label>
                           		</th>
                           		<td>
                           			<input type="text" name="data01" id="name" value="<%=util.getStr(loginVO.getPsnNm())%>" style="width:100%; border:0;" maxlength="100" readOnly >
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="birthday">????????????</label>
                           		</th>
                           		<td>
                           			<%if(util.getStr(loginVO.getBirthDate()).equals("")||util.getStr(loginVO.getBirthDate()).equals(null)){%>
                           				<input type="text" name="data02" id="birthday" style="width:100%;" maxlength="100">
                           			<%}else{ %>
                           				<input type="text" name="data02" id="birthday" value="<%=util.getStr(loginVO.getBirthDate())%>" style="width:100%; border:0;" maxlength="100" readOnly >
                           			<%} %>
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="nationality">??????</label>
                           		</th>
                           		<td>
                           			<%if(util.getStr(loginVO.getFrgnYn()).equals("N")){%>
                           				<input type="text" name="data03" id="nationality" value="????????????" style="width:100%; border:0;" maxlength="100" readOnly >
                           			<%}else{%>
                           				<input type="text" name="data03" id="nationality" style="width:100%;" maxlength="100">
                           			<%}%>
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="homePage">????????????</label>
                           		</th>
                           		<td>
                           			<input type="text" name="data04" id="homePage" style="width:100%;" maxlength="100">
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="affiliation">??????</label>
                           		</th>
                           		<td>
                           				<input type="text" name="data05" id="affiliation" style="width:100%;" maxlength="100">
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="major">??????</label>
                           		</th>
                           		<td>
                           				<input type="text" name="data06" id="major" style="width:100%;" maxlength="100">
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="position">??????</label>
                           		</th>
                           		<td>
                           				<input type="text" name="data07" id="position" style="width:100%;" maxlength="100">
                           		</td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit">
                           			<label for="position_field">????????????</label>
                           		</th>
                           		<td>
                           				<input type="text" name="data08" id="position_field" style="width:100%;" maxlength="100">
                           		</td>
                           	</tr>

                           	<tr>
                           		<th scope="row" class="tit" colspan="2">
                           			<label for="academic_career">??????</label>
                           		</th>
                           	</tr>
                           	<tr>
                           		<td class="con-txt" colspan="2">
                                         <textarea name="text1" id="academic_career" style="width: 100%; height: 200px;"></textarea>
                                  </td>
                           	</tr>
                           	<tr>
                           		<th scope="row" class="tit" colspan="2">
                           			<label for="career">??????</label>
                           		</th>
                           	</tr>
                           	<tr>
                           		<td class="con-txt" colspan="2">
                                         <textarea name="text2" id="career" style="width: 100%; height: 200px;"></textarea>
                                  </td>
                           	</tr>
                     </tbody>
	   		</table>
	   </div>
              <!-- bo_btn  -->
              <div class="btn_right_box" style="text-align: right; width: 980px;">
                     <input type="button" class="btn_inp_b_01" value="????????????" onclick="goCheck('<%=util.getStr(loginVO.getProState())%>')"/>
                     <input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
              </div>
              <!--// bo_btn -->
       </div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
		function goCheck(proYn){
		    if(proYn == "" || proYn == null ||proYn == "N"){
		    	goSubmit("writeProc");
		    }else if(proYn == "R"){
		    	alert("????????????????????????.");
		    }else if(proYn == "Y"){
		    	alert("????????? ?????? ????????????.");
		    }else{
		    	alert("?????????");
		    }
		}
       function goSubmit(mode){
              if(mode=="writeProc" && permEditor=="Y"){
                     oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
              }
              $('#mode').val(mode);
              $('#fwrite').submit();
       }

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
                                  bUseToolbar : true,                      // ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
                                  bUseVerticalResizer : true,       // ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
                                  bUseModeChanger : true,                  // ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
                                  //aAdditionalFontList : aAdditionalFontSet,              // ?????? ?????? ??????
                           }, //boolean
                           fCreator : "createSEditor2"
                     });
              });
       }

</script>