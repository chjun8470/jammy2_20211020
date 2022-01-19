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
	HashMap<String, String> userDataMap = request.getAttribute("userDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userDataMap");
	HashMap<String, String> resvDataMap = request.getAttribute("resvDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("resvDataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	
	String eduType = util.getStr(paramMap.get("type")).equals("jntis")?"":"_smbrnd";
	
%>
<style scoped>
#bgLayer {  
  position:fixed;  
  left:0;
  top:0;
  z-index:1001; 
  width:100%;
  height:100%;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
  filter: alpha(opacity=50);
  -khtml-opacity: 0.5;
  -moz-opacity: 0.5;
  opacity:0.5;
  background-color:#000;   
  display:none;
  
}

#rejectDiv{
 position:fixed;
  z-index:1002; 
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;   
  display:none;
  text-align: left;
}

</style>

<form id = "rejectForm" name = "rejectForm" method="post" action="/sub.do">
	<input type="hidden" name = "mode" id = "rejectMode" value="resvEdit"/>
	<input type="hidden" name = "eduResvId" id = "rejectEduResvId" value="<%=util.getStr(paramMap.get("eduResvId"))%>"/>
	<input type="hidden" name = "eduId" id = "rejectEduId" value="<%=util.getStr(paramMap.get("eduId"))%>"/>
	<input type="hidden" name = "resvState" id = "rejectResvState" value="30"/>
	<input type="hidden" name = "userIdx" id = "rejectUserIdx" value="<%=util.getStr(paramMap.get("userIdx"))%>"/>
	<input type="hidden" name = "rmCheck" id = "rmCheck" value="Y"/>
	<div id="bgLayer" onclick="rejectExit();"></div>
	<div id="rejectDiv"></div>
</form>

<form id = "fview" name = "fview" method="post" action="/sys/sys_rm<%=eduType%>_edu.do" enctype="multipart/form-data">
<div class="clear_wrap">
						<div class="left_box w75">
				<div class="box_in" style="width:80%">
					<p class="tr mb5"></p>
					<table id="step1" class="skin_basic_write">
						<caption>신청정보 상세정보표</caption>
						<colgroup>
				   			<col style="width:200px">
				   			<col style="width:800">
						</colgroup>
						<tbody>
						
						<tr>
							<th scope="col" class="top_sell bln">교육명</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_NM"))%>
							</td>
							<!-- 
							<th scope="col" class="top_sell bln">교육분류</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_CATE_NM"))%>
							</td>-->
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육과정</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(dataMap.get("EDU_CUR"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">교육신청상태</th>
							<td class="top_sell brn" colspan="3">
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("10")?"신청":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("20")?"승인":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("30")?"반려":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("40")?"신청취소":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("50")?"수료":"" %>
								<%=util.getStr(resvDataMap.get("RESV_STATE")).equals("60")?"미수료":"" %>
							</td>
						</tr>
						<tr id="rejectTr" <%=util.getStr(resvDataMap.get("RESV_STATE")).equals("30")?"":"style='display:none'" %>>
							<th scope="col" class="top_sell bln" >반려내용</th>
							<td class="top_sell brn" colspan="3">
							<pre><%=util.getStr(resvDataMap.get("RESV_REJECT"))%></pre>
							</td>
						</tr>
						
						<tr>
							<th scope="col" class="top_sell bln">접수기간</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>
							</td>
							<th scope="col" class="top_sell bln">교육기간</th>
							<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EDU_ST_DT"))%> ~ <%=util.getStr(dataMap.get("EDU_ED_DT"))%>
							</td>
						</tr>
						
						<tr>
							<th scope="col" class="top_sell bln">안내사항</th>
							<td class="top_sell brn">
								<pre><%=util.getStr(dataMap.get("EDU_TIME"))%></pre>
							</td>
							<th scope="col" class="top_sell bln">총교육시간</th>
							<td class="top_sell brn">
								<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>(시간)
							</td>
						</tr>
						
						<tr>
							<th scope="col" class="top_sell bln">신청자명</th>
							<td class="top_sell brn">
								<%=util.getIntStr(userDataMap.get("PSN_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">성별</th>
							<td class="top_sell brn">
								<%=util.getIntStr(userDataMap.get("GENDER_TYPE_CD"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">소속</th>
							<td class="top_sell brn">
								<%=util.getStr(userDataMap.get("ORG_GRP_NM"))%>
							</td>
							<th scope="col" class="top_sell bln">직위</th>
							<td class="top_sell brn">
								<%=util.getStr(userDataMap.get("POSITION_NM"))%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">신청자 휴대폰 번호</th>
							<td class="top_sell brn">
								<%=util.getStr(userDataMap.get("CP_NO"))%>
							</td>
							<th scope="col" class="top_sell bln">신청자 이메일</th>
							<td class="top_sell brn">
								<%=util.getStr(userDataMap.get("EMAIL"))%>
							</td>
						</tr>
						<%if(util.getStr(resvDataMap.get("RESV_STATE")).equals("50")){%>
						<tr>
							<th>수료증 직접등록</th>
							<td>
							
								<% if(util.getStr(String.valueOf(resvDataMap.get("RESV_CERTI_FILE"))).equals("")){%>
								<input type="file" name="resvCertiFile1"  id="resvCertiFile1"  title="파일첨부" />
								<input type="hidden" name="fileSn"  value="3" />
								<%}else{%>
								<ul class="file" style="line-height: 22px;">
									<li class="text">
										<input type="hidden" name="fileSn"  value="3" />
										<input type="checkbox" name="fileFlog" id="fileFlog_3"
												value="<%=util.getStr(String.valueOf(resvDataMap.get("RESV_CERTI_FILE")))%>" onclick="fileSet('3')" /> &nbsp;
										<label for="fileFlog_3">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
								
								<%=util.getStr(resvDataMap.get("RESV_CERTI_FILE_TITLE")) %>
								
									</li>
								</ul>
								<div id="fileBox_3" style="display:none">
									<input type="file" name="resvCertiFile1"  id="resvCertiFile1"  title="파일첨부"  />
								</div>
								<%}%>
								<input type="button" name="insertBtn" id="insertBtn" class="btn_inp_g_01" value="확인" onclick = "resvFileInsert()"/>
							
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			  </div>
			  <div class="btn_box" >
			  			<div class="btn_left_box" >
						<%if(util.getStr(resvDataMap.get("RESV_STATE")).equals("10")){%>
								<input type="button" onclick="actState('20')" value="승인" class="btn_inp_g_01"/>
								<input type="button" onclick="actState('30')" value="반려" class="btn_inp_g_01"/>
							<%}else if(util.getStr(resvDataMap.get("RESV_STATE")).equals("20")){%>
								<input type="button" onclick="actState('10')" value="신청" class="btn_inp_g_01"/>
								<input type="button" onclick="actState('50')" value="수료" class="btn_inp_g_01"/>
								<!-- <input type="button" onclick="actState('60')" value="미수료" class="btn_inp_g_01"/> -->
							<%}else if(util.getStr(resvDataMap.get("RESV_STATE")).equals("50")){%>
								<input type="button" onclick="actState('20')" value="승인" class="btn_inp_g_01"/>
								<input type="button" onclick="actState('60')" value="미수료" class="btn_inp_g_01"/>
							
							<%}else if(util.getStr(resvDataMap.get("RESV_STATE")).equals("60")){%>
								<input type="button" onclick="actState('20')" value="승인" class="btn_inp_g_01"/>
								<input type="button" onclick="actState('50')" value="수료" class="btn_inp_g_01"/>
							
							<%}else{%>
								<input type="button" onclick="actState('10')" value="신청" class="btn_inp_g_01"/>
								<%if(util.getStr(resvDataMap.get("RESV_STATE")).equals("30")){%>
									<input type="button" onclick="actState('20')" value="승인" class="btn_inp_g_01"/>
								<%}else{ %>
									<input type="button" onclick="actState('30')" value="반려" class="btn_inp_g_01"/>
								<%}%>
							<%} %>
						</div>
						<div class="btn_right_box">
							<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
						</div>
			 </div>
			</div>
</div>

	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "nowPage" name = "nowPage" value = "<%=util.getIntStr(paramMap.get("nowPage"))%>"/>
	<input type="hidden" name = "eduId" id = "eduId" value="<%=util.getStr(paramMap.get("eduId"))%>"/>
	<input type="hidden" name = "eduResvId" id = "eduResvId" value="<%=util.getStr(paramMap.get("eduResvId"))%>"/>
	<input type="hidden" name = "resvState" id = "resvState" value="<%=util.getStr(resvDataMap.get("RESV_STATE"))%>"/>
	<input type="hidden" name = "userIdx" id = "userIdx" value="<%=util.getStr(paramMap.get("userIdx"))%>"/>
	<input type="hidden" name = "rmCheck" id = "rmCheck2" value="Y"/>
	<input type="hidden" name = "eduType" id = "eduType" value="<%=util.getStr(paramMap.get("type"))%>"/>
	
</form>

<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('resvList');
		$('#fview').attr("action","/sys/sys_rm<%=eduType%>_edu.do");
		$('#fview').submit();
	}

	function resvFileInsert(){
		/*if(!$('#fileFlog_3').is(':checked')){
		if($("#resvCertiFile1").val()==""||$("#resvCertiFile1").val()==null){
			alert("파일을 등록해 주세요.");
			return false;	
		}
	}*/
		if($("#resvCertiFile1").val()!=""&&$("#resvCertiFile1").val()!=null){
		var filePattern = new Array("pdf");
			var fileName = $('#resvCertiFile1').val();
				if(fileName != "" || fileName != null){
				   fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(filePattern.indexOf(fileName)==-1){
						alert("첨부파일은 pdf 확장자 파일만 업로드가능합니다.");
						$('#resvCertiFile1').val("");
						return false;
					}
				}
		}
			$('#fview').attr('action','./jnspEduProc.do');
			$('#mode').val("resvEdit");
			$('#fview').submit();
		
	}
	
	function fileSet(fileCnt){
		if($('#fileFlog_'+fileCnt).is(':checked')){
			$('#fileBox_'+fileCnt).show();
		}else{
			$('#fileBox_'+fileCnt).hide();
		}
	}
	
	function actState(stateCd){
		if(stateCd=="30"){
			var divText="";
			divText="<textarea id=\"resvRejectRej\" name=\"resvReject\" cols=\"45\" rows=\"5\"></textarea>";
			divText="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + divText;
			divText="<div style='margin:20px'><h2>반려사유 입력</h2>" + divText;
			
			divText+="<div id='rejectExitButton' style='text-align:center'>"
				   + "<input type='button' onclick='rejectSubmit()' value='확인' class='btn_inp_b_01'/>"
				   + "<input type='button' onclick='rejectExit()' value='닫기' class='btn_inp_w_01'/></div>";
			divText+="</div>";
			$('#rejectDiv').html(divText);
			$("#rejectDiv").css("left",($(document).width()/2)-($("#reject").width()/2)+"px");
			$("#rejectDiv").css("top","200px");
			$('#rejectDiv,#bgLayer').show();
			
		}else{
			$('#resvState').val(stateCd);
			$('#fview').attr('action','./jnspEduProc.do');
			$('#mode').val("resvEdit");
			$('#fview').submit();
		}
	}
	
	function rejectExit(){
		$("#rejectDiv").html("");
		$("#bgLayer,#rejectDiv").hide();
	}
	function rejectSubmit(){
		$('#rejectForm').attr('action','./jnspEduProc.do');
		$('#rejectMode').val("resvEdit");
		$('#rejectResvState').val("30");
		$('#rejectForm').submit();
	}
</script>