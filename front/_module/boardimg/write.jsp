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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "write";
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
%>
		<script type="text/javascript">
		//<![CDATA[

			function submitGo(){
				if($('#subject').val() == ''){
					alert("제목을 입력 해주세요");
					return false;
				}

				if($('#contents').val() == ""){
					alert("내용을 입력 해주세요");
					return false;
				}

				return true;
			}
		//]]>	
		</script>


	  <form name="fwrite" id="fwrite" action="/m/boardProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="boardIdx" id="boardIdx"  value="<%=boardIdx%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=util.getStr(paramMap.get("searchType")) %>" />
		<input type="hidden" name="searchWold" id="searchWold" value="<%=util.getStr(paramMap.get("searchWold")) %>" />

		<div class="skin_bbs_write" style="margin-top:30px">



			<font color="red">* 필수 입력사항입니다.</font>
	        <table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
	          <caption>
	          작성하기
	          </caption>
	          <colgroup>
	          <col width="140px" />
	          <col width="*" />
	          </colgroup>
	          <tbody>
	            <tr>
	              <th scope="row" class="tit"><label for="subject">제목</label></th>
	              <td>
	              <input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT")) %>" style="width:100%;" maxlength="100" /></td>
	            </tr>

	            <tr>
	              <th scope="row" class="tit"><label for="contents">내용</label></th>
	              <td class="con-txt"><textarea name="contents" id="contents" style="width:100%;height:350px;"><%=util.getStr(dataMap.get("CONTENTS")) %></textarea></td>
	            </tr>

	            <tr>
	              <th scope="row" class="tit"><label for="extfile">첨부파일</label></th>
	              <td>

	              <%if(fileList.size() > 0){%>
            	  <ul class="file">
					<% for(HashMap rs:fileList){ %>
						<%String fileParam = "?dataType="+util.getStr(rs.get("DATA_TYPE"))+"&amp;fileIdx="+util.getStr(rs.get("FILE_IDX"))+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));%>
                  		<li class="text">
                  			<input type="checkbox" name="fileFlog" id="fileFlog_<%=util.getStr(rs.get("FILE_SN"))%>" value="Y" onclick="if($(this).is(':checked')){$('#fileBox_<%=util.getStr(rs.get("FILE_SN"))%>').show();}else{$('#fileBox_<%=util.getStr(rs.get("FILE_SN"))%>').hide()}" />
                  			&nbsp;<label for="fileFlog_<%=util.getStr(rs.get("FILE_SN"))%>">파일삭제</label>&nbsp;&nbsp;
                  			 <%=util.deStr(rs.get("FILE_ORGN_NM")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
                  			 <div style="padding-top:10px;display:none;" id="fileBox_<%=util.getStr(rs.get("FILE_SN"))%>">
                  			 	<input type="file" name="extfile"  id="extfile"  title="파일첨부" />
                  			 	<input type="hidden" name="fileSn"  value="<%=util.getStr(rs.get("FILE_SN"))%>" />
                  			 </div>
                  		</li>
					<% } %>
  					</ul>
              		<% }else{ %>

              	<input type="file" name="extfile"  id="extfile"  title="파일첨부" />
              	<input type="hidden" name="fileFlog"  value="N"  />
              <%} %>

	              	</td>
	            </tr>
	          </tbody>
	        </table>

	        <!-- bo_btn  -->
	        <div class="bo_btn_box textC">

	        	<input type="submit" value="작성완료" id="btn_submit"  class="btn_submit" />

	        	<span class="btn_02"><a href="./<%=myPage%>">취소</a></span>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>

