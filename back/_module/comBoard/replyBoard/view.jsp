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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

%>

	<form name="fview" id="fview" action="<%=myPage%>" method="post" >
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />


	<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">

			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="head_text" style="text-align: right; width: 950px;">
		<!-- 	<p  style="text-align: right;" > -->
			작성자 :  <%=util.getStr(dataMap.get("WRITER_ID")) %>
			 | 작성일 : <%=util.getCDate(dataMap.get("FRST_REGIST_PNTTM"))%>
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
			</div>
		</div>
		<div  style="clear:both;">
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
									<li class="text" >
										<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px;padding:10px"/>
		<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
									</li>
								<% fileCnt++; }%>
								</ul>
							<%} %>

		</div>
		<div class="btn_box">
			<%if(util.loginCheck()){ %>
				<div class="btn_left_box">
					<% HashMap<String, String> aticleDataMap = request.getAttribute("aticleDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("aticleDataMap"); %>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
				<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")  && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
				<input type="button" class="btn_inp_b_01" value="삭제" onclick="goSubmit('del')"/>
			<%} %>
				</div>
			<%} %>
				<div class="btn_right_box">
			<%if(util.getStr(boardMap.get("PERM_REPLY")).equals("Y")){ %>
					<input type="button" class="btn_inp_b_01" value="답변" onclick="goSubmit('reWrite')"/>
			<% }%>
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