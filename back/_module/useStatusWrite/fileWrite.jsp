<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = util.getStr(paramMap.get("fileGrp"));
	String fileSubGrp = util.getStr(paramMap.get("fileSubGrp"));
	String fileExt = util.getStr(paramMap.get("fileExt"));
	String fileExt2 = util.getStr(paramMap.get("fileExt2"));
	int fileCnt = util.getInt(paramMap.get("fileCnt"));
	int fileSize = util.getInt(paramMap.get("fileSize"));

	String fileFullGrp = fileGrp + fileSubGrp;

	int fileListSize = util.getInt(fileList.size());
	if(fileListSize == 0){
		fileListSize = 1;
	} else {
		fileListSize = 2;
	}
%>
<%
if(fileList.size() > 0){
%>
<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
<%
	int fileOrgCnt = 1;
	for(HashMap rs:fileList){
		String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
							+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
							+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
%>
	<li class="text">
		<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileFullGrp%>_<%=fileOrgCnt%>" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileFullGrp%>','<%=fileOrgCnt%>')" />&nbsp;
		<label for="fileFlog_<%=fileFullGrp%>_<%=fileOrgCnt%>">파일삭제</label>&nbsp;&nbsp;
		<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
		<div id="fileBox_<%=fileFullGrp%>_<%=fileOrgCnt%>" style="display:none">
			<input type="file" name="<%=fileFullGrp%>_File<%=fileOrgCnt%>" id="<%=fileFullGrp%>_File<%=fileOrgCnt%>" title="파일첨부" onchange="getFileExtCkCheck('<%=fileFullGrp%>_File<%=fileOrgCnt%>','<%=fileExt2%>',<%=fileSize%>)" />
		</div>
	</li>
<% fileOrgCnt++; }%>
</ul>
<%if(fileCnt>1){ %>
<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
<%} else { %>
<div style="display: none;" id="<%=fileFullGrp%>fileGrpBox">
<%} %>
	<div>
		<input type="file" name="<%=fileFullGrp%>_File<%=fileCnt%>" id="<%=fileFullGrp%>_File<%=fileCnt%>" title="파일첨부" onchange="getFileExtCkCheck('<%=fileFullGrp%>_File<%=fileCnt%>',''<%=fileExt2%>',<%=fileSize%>)" />
	</div>
</div>
<%if(fileCnt>1){ %>
<div style="display: inline-block; vertical-align: bottom;">
	<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>', '<%=fileCnt%>', '<%=fileExt%>', '<%=fileExt2%>', '<%=fileSize%>');" />
	<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
</div>
<%} %>
<% } else { %>
	<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
		<div>
			<input type="file" name="<%=fileFullGrp%>_File1" id="<%=fileFullGrp%>_File1" title="파일첨부"  onchange="getFileExtCkCheck('<%=fileFullGrp%>_File1','<%=fileExt%>', '<%=fileExt2%>',<%=fileSize%>)" />
		</div>
	</div>
	<%if(fileCnt>1){%>
	<div style="display: inline-block; vertical-align: bottom;">
		<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>', '<%=fileCnt%>', '<%=fileExt%>', '<%=fileExt2%>', '<%=fileSize%>');" />
		<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
	</div>
	<%}%>
<% } %>
<script type="text/javascript">
arrfileCnt['<%=fileFullGrp%>'] = <%=fileListSize+1%>;
</script>