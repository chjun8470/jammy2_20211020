<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> replyMap = request.getAttribute("replyMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("replyMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String replyIdx = util.getStr(paramMap.get("replyIdx"));
%>
<form name="fview" id="fview" action="<%=myPage%>" method="post" >
	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx"  value="<%=boardComIdx%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" /> 
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx %>" />
	<input type="hidden" name="replyIdx" id="replyIdx" value="<%=replyIdx %>" />

	<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">

			<h3 class="title"><%=util.getStr(replyMap.get("SUBJECT")) %></h3>
			<div class="head_text">
			글쓴이 :  <%=util.getStr(replyMap.get("WRITER_ID")) %>
			 | <%=util.getStr(replyMap.get("FRST_REGIST_PNTTM")) %>
			 | 조회 : <%=util.getIntStr(replyMap.get("HITS")) %>
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

				<pre><%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%></pre>
				<pre>=========================================================================</pre>
				<pre><%=replyMap.get("CONTENT")%></pre>
			</div>
		</div>
		<div  style="clear:both;">
			<ul class="bbs_file">
				<%for(HashMap rs:fileList){ %>
					<%String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;dataSubGrp="+util.getStr(rs.get("DATA_SUB_GRP"))
												+"&amp;fileIdx="+util.getStr(rs.get("FILE_IDX"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));%>
					<li ><a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.getStr(rs.get("FILE_ORGN_NM")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte) </a></li>
				<%}%>
			</ul>

		</div>
		<div class="btn_box">
				<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('reEdit')"/>
					<input type="button" class="btn_inp_b_01" value="삭제" onclick="goSubmit('del')"/>
					<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
				</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fview').submit();
	}
</script>