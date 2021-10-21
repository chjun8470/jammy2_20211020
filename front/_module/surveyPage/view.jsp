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
	HashMap<String, String> surveyDataMap = request.getAttribute("surveyDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("surveyDataMap");
	ArrayList<HashMap<String,String>> questionIdxList = request.getAttribute("questionIdxList") == null ? new ArrayList<HashMap<String,String>>(): (ArrayList<HashMap<String,String>>) request.getAttribute("questionIdxList");
	HashMap<String,ArrayList<HashMap<String,String>>> questionDataMap = request.getAttribute("questionDataMap") == null ? new HashMap<String,ArrayList<HashMap<String,String>>>(): (HashMap<String,ArrayList<HashMap<String,String>>>)request.getAttribute("questionDataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String surveyIdx = util.getStr(paramMap.get("surveyIdx"));

	String reg_id = loginVO.getId();
	System.out.println("reg_id : " + reg_id);

	String reg_ip = request.getRemoteAddr();
	System.out.println("reg_ip : " + reg_ip);

	System.out.println("View : "+myPage);

%>
<form name="fview" id="fview" action="./<%=myPage%>" method="post" >

  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
  	<input type="hidden" name="allData" id="allData"  value="" />
  	<input type="hidden" name="surveyIdx" id="surveyIdx"  value="<%=surveyIdx%>" />
  	<input type="hidden" name="myPage" id="myPage"  value="<%=myPage%>" />
  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=util.getStr(paramMap.get("searchType")) %>" />
	<input type="hidden" name="searchValue" id="searchValue" value="<%=util.getStr(paramMap.get("searchValue")) %>" />
	<input type="hidden" name="reg_id" id="reg_id" value="<%=reg_id%>" />
	<input type="hidden" name="reg_ip" id="reg_ip" value="<%=reg_ip%>" />

	<div class="skin_bbs_veiw" style="margin-top:30px; width:700px;">
		<table class="skin_basic_list">
			<tr>
				<th style="text-indent:10px; text-align:left;">
					<label for="subject">설문 제목</label>
				</th>
			</tr>
			<tr>
				<td style="text-indent:10px; text-align:left;">
					<%=util.getStr(surveyDataMap.get("SUBJECT")) %>
				</td>
			</tr>
			<tr>
				<th style="text-indent:10px; text-align:left;">
					<label for="contents">설문 내용</label>
				</th>
			</tr>
			<tr>
				<td style="text-indent:10px; text-align:left;">
					<%=util.getStr(surveyDataMap.get("CONTENTS")).replaceAll("\n","<br/>") %>
				</td>
			</tr>
		</table>

			<%
				int questionCnt = 0;
				for(HashMap idxList : questionIdxList){
					ArrayList<HashMap<String,String>> qusetionList = questionDataMap.get(util.getIntStr(idxList.get("QUESTION_IDX")));
					int question_item_cnt = 0;
					for(HashMap question: qusetionList){
						if("question_subject".equals(question.get("TABLECODE"))){
			%>
					<table class="skin_basic_list" >
						<tr>
							<th colspan=2 style="text-indent:10px; text-align:left;"><%=++questionCnt%>번 <%=question.get("TABLETITLE") %></th>
						</tr>
						<tr>
							<td colspan=2 style="text-indent:10px; text-align:left;" ><%=question.get("SUBJECT") %></td>
						</tr>
			<%
						}else if("question_content".equals(question.get("TABLECODE"))){
			%>
							<tr>
								<th colspan=2 style="text-indent:10px; text-align:left;"><%=questionCnt%>번 <%=question.get("TABLETITLE") %></th>
							</tr>
							<tr>
								<td colspan=2  style="text-indent:10px; text-align:left;"><%=question.get("SUBJECT") %></td>
							</tr>
							<tr>
								<th class="question_item" style="text-indent:10px; text-align:left;"><%=questionCnt%>번 문항</th>
								<th>선택</th>
							</tr>
			<%
						}else if("question_item".equals(question.get("TABLECODE"))){
			%>
							<tr>
								<td style="text-indent:10px; text-align:left;"><%=question.get("SUBJECT") %></td>
								<td style="width:100px"><input type="radio" name="question_item_<%=questionCnt %>" id="question_item_<%=questionCnt %>" value="<%=++question_item_cnt %>" /></td>
							</tr>
			<%
						}
					}
			%>
					</table>
			<%
				}
			%>
	</div>
	<div class="btn_box" style=" width:700px;">
		&nbsp;
		<div class="btn_right_box">
			<input type="button" id="send_answer_btn" name="send_answer_btn" class="send_answer_btn btn_inp_b_01" value="등록" />
			<span class="btn_w_01">
				<a href="./<%=myPage %>" onclick="pageListGo()">목록</a>
			</span>
		</div>
	</div>
	&nbsp;
</form>

<script type="text/javascript">
//<![CDATA[
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}

	$(document).ready(function(){
		$(this).on('click', '.send_answer_btn', function(){
			var ckdata = "";
			var ckcnt = 0;
			var question_item_no = $('.question_item').length;
			console.log(question_item_no);
			$('input:radio').each(function(){
				var radio_name = $(this).attr("name");
				if($(this).is(':checked')){
					var dot = ',';
					if(ckcnt == 0){
						dot = '';
					}
					ckdata += dot + $(this).val();
					ckcnt++;
				}
			});
			for(var i = 0; i < question_item_no; i++){
				if(!$('[name="question_item_' + (i+1) + '"]').is(':checked')){
					alert((i+1) +  "번째 질문에 대한 문항이 선택 되지 않았습니다.");
					$(this).focus();
					return;
				}
			}
			console.log(ckdata);
			if(ckdata != ''){
				if(confirm('설문을 완료하시겠습니까?')){
					$('#mode').val('sendAnswer');
					$('#allData').val(ckdata);
					$('#fview').submit();
				}
			}
		})
	})
//]]>
</script>
