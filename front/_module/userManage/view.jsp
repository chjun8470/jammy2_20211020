<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="org.springframework.web.util.CookieGenerator"%><%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.util.Calendar" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	String deth1 = "6";
	String deth2 = "3";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> commentList = request.getAttribute("commentList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("commentList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	String manageIdx = util.getStr(paramMap.get("manageIdx"));

%>
<form name="fview" id="fview" action="<%=myPage%>" method="post" >

	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="manageIdx" id="manageIdx"  value="<%=manageIdx%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="reg_id" id="reg_id" value="<%=util.getStr(dataMap.get("REG_ID"))%>" />
		<input type="hidden" name="reg_id" id="reg_id" value="<%=loginVO.getId() %>" />
		<input type="hidden" name="commentIdx" id="commentIdx"  />
		<input type="hidden" name="cName" id="cName"value="<%=loginVO.getName()%>"   />

	<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">
			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="head_text">
			글쓴이 :  <%=util.getStr(dataMap.get("REG_ID")) %>
			 | <%=String.valueOf(dataMap.get("REG_DT")).split(" ")[0] %>
			</div>
		</div>

		<div style="text-align: left; widht: 100%;" class="bbs_cont">
			<div class="style-init" style="word-break:break-all;">
			<%for(HashMap rs:fileList){
				String ext = util.getStr(rs.get("FILE_EXT")).toLowerCase();
						if("jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
							%>
								<img src="<%=(util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("FILE_NM"))) %>" class="img-view" style="max-width:700px;"/>
							<%
						}
				}%>
				<pre><%=util.getStr(dataMap.get("CONTENTS")).replaceAll("\n","<br/>") %></pre>
			</div>
		</div>
		<div class="bbs_head">
			<div class="head_text">
				상태 :
				<%
					String state = util.getStr(dataMap.get("STATE"));
					if("01".equals(state))out.println("접수중");
					else if("02".equals(state))out.println("승인");
					else if("03".equals(state))out.println("반려");
					else if("04".equals(state))out.println("보류");
				%>
			</div>
			<br/>
			<div class="bbs_cont"  id = "cmt_div" <%if(util.getStr(dataMap.get("COMMENT")).equals("")){ %><%="style=display:none" %><%} %> >
					이유 :<pre><%=util.getStr(dataMap.get("COMMENT")) %></pre>
			</div>
		</div>
		<div  style="clear:both;">
			<ul class="bbs_file">
				<%for(HashMap rs:fileList){ %>
					<%String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;dataSubGrp="+util.getStr(rs.get("DATA_SUB_GRP"))
												+"&amp;fileIdx="+util.getStr(rs.get("FILE_IDX"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));%>
					<li ><a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드"><%=util.getStr(rs.get("FILE_ORGN_NM")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte) </a></li>
				<%}%>
			</ul>

		</div>
		<div class="bbs_head" >
				<div class="head_text" align="left">
					 <%=util.getStr(loginVO.getName()) %>&nbsp;
					| &nbsp;<%=util.getStr(loginVO.getId()) %>
				</div>
	        	<textarea id="cText"  name="cText" style="width:80%" rows="4"></textarea>
				<button class="btn_b_01" style="vertical-align: top;max-height:67px; height:67px; min-width:67px;" onclick = "commentWriteGo()">댓글 </button>
		</div>
		<%
			for(HashMap rs:commentList){
				String commentIdx = util.getStr(rs.get("COMMENT_IDX"));
			%>
			<div style="text-align: left; widht: 100%;" class="bbs_cont">
				<div id="btn_div<%=commentIdx%>" class="head_text">
					<%=util.getStr(rs.get("NAME")) %>&nbsp;
					 |&nbsp; <%=util.getStr(rs.get("REG_ID")) %>&nbsp;
						|&nbsp;<button type = "button" class="btn_inp_w_01" style="font-size: 8px;height: 20px;min-width: 35px;line-height: 11px;"  onclick = "commentEdit(<%=commentIdx%>) "> 수정 </button>&nbsp;
						|&nbsp;<button class="btn_inp_w_01" style="font-size: 8px;height: 20px;min-width: 35px;line-height: 11px;" onclick = "commentDelGo(<%=commentIdx %>)"> 삭제 </button>&nbsp;
				</div>

				<div id = "cmt_div<%=commentIdx %>" name = "cmt_div" style="display:none">
					<div id="btn_div<%=commentIdx%>" name ="btn_div"  class="head_text">
					<%=util.getStr(rs.get("NAME")) %>&nbsp;
					|&nbsp;<%=util.getStr(rs.get("REG_ID")) %>
					</div>
					<textarea id="comment<%=commentIdx %>" name ="comment" style="width:80%" rows="4"><%=util.getStr(rs.get("CONTENT")).replaceAll("\n","<br/>") %></textarea>
					<button class="btn_b_01" style="vertical-align: top; min-width:67px;max-height:67px; height:67px;" onclick = "commentEditGo(<%=commentIdx%>) "> 수정 </button>&nbsp;
				</div>
				<div id ="comment_div<%=commentIdx %>" name ="comment_div" class="style-init"   style="word-break:break-all;">
					<pre><%=util.getStr(rs.get("CONTENT")).replaceAll("\n","<br/>") %></pre>
				</div>
			</div>
		<% }%>
		<div class="btn_box">
			<%if(util.loginCheck()){ %>
				<div class="btn_left_box">
					<span>
						<a href="#" onclick="pageEditGo()"><img src="/imgs/board/btn_modify.gif" alt="수정"  /></a>
					</span>
					<span>
						<a href="#" onclick="pageDelGo()"><img src="/imgs/board/btn_del.gif" alt="삭제" /></a>
					</span>
				</div>
			<%} %>
				<div class="btn_right_box">
					<a href="./<%=myPage %>" onclick="pageListGo()"><img src="/imgs/board/btn_list.gif" alt="목록" /></a>
				</div>
		</div>
	</div>
</form>
<script type="text/javascript">
//<![CDATA[
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageDelGo(){
		$('#mode').val('del');
		$('#fview').submit();
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
	function commentWriteGo(){
		if($('#cName').val() == ''){
			alert("이름을 입력 해주세요");
			return false;
		}
		if($('#cText').val() == ''){
			alert("내용을 입력 해주세요");
			return false;
		}
		$('#mode').val('commentWrite');
		$('#fview').submit();
	}
	function viewInput(){
		if($("#state option:selected").val()=="01"){
			$('#cmt_div').css("display","none");
		}else if($("#state option:selected").val()=="02"){
			$('#cmt_div').css("display","none");
		}else{
			$('#cmt_div').show();
		}
	}
	function commentEdit(no){
		if($('#cmt_div'+no).css('display') == 'none')
		{
				$('div[name=cmt_div]').hide(); $('#cmt_div'+no).show();
				$('div[name=comment_div]').show(); $('#comment_div'+no).hide();
				$('div[name=btn_div]').show(); $('#btn_div'+no).hide();
		}
		else
		{
			$('div[name=cmt_div]').hide();
		}
	}
	function commentEditGo(val){
		if($('#comment'+val).val() == ''){
			alert("내용을 입력 해주세요");
			return false;
		}
		$('#cText').val($('#comment'+val).val());
		$('#mode').val('commentEdit');
		$('#commentIdx').val(val);
		$('#fview').submit();
	}

	function commentDelGo(val){
		if( confirm(" 정말로 삭제하시겠습니까?" ) ){
			$('#mode').val('commentDel');
			$('#commentIdx').val(val);
			$('#fview').submit();
		};
	};
//]]>	
</script>