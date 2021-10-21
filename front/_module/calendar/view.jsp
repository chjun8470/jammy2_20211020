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
	String calIdx = util.getStr(paramMap.get("calIdx"));

%>
  <form name="fview" id="fview" action="<%=myPage%>" method="post" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="calIdx" id="calIdx"  value="<%=calIdx%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=util.getStr(paramMap.get("searchType")) %>" />
		<input type="hidden" name="searchWold" id="searchWold" value="<%=util.getStr(paramMap.get("searchWold")) %>" />

<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">

			<h3 class="title"><%=util.getStr(dataMap.get("TITLE"))  %> 세부 정보</h3>

		</div>

		<table class="skin_basic_list" summary="세부적인 사이트코드 내용을 표시합니다.">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 5%;" />
			</colgroup>
			<!-- colgroup e -->

				<tr>
					<th scope="col" ><label for="calIdx">순서</label></th>
					<td scope="col" colspan=3><%=calIdx%></td>
				</tr>

				<tr>
					<th scope="col"><label for="title">제목</label></th>
					<td scope="col" colspan=3><%=util.getStr(dataMap.get("TITLE"))%></td>
				</tr>

				<tr>
					<th scope="col"><label for="htmlText">내용</label></th>
					<td scope="col" colspan=3><%=util.getStr(dataMap.get("HTML_TEXT"))%></td>
				</tr>

				<tr>
					<th scope="col"><label for="popupDate">기간</label></th>
					<td scope="col" colspan=3><%=util.getStr(dataMap.get("ST_DT"))%> <%=util.getStr(dataMap.get("ST_TIME"))%>:<%=util.getStr(dataMap.get("ST_MIN"))%> ~ <%=util.getStr(dataMap.get("ED_DT"))%> <%=util.getStr(dataMap.get("ED_TIME"))%>:<%=util.getStr(dataMap.get("ED_MIN"))%></td>
				</tr>

				<tr>
					<th scope="row"><label for="reg_dt">등록 일자</label><br /></th>
					<td><%=String.valueOf(dataMap.get("REG_DT")).split(" ")[0]%></td>
					<th scope="row"><label for="up_dt">수정 일자</label><br /></th>
					<td><%=String.valueOf(dataMap.get("REG_DT")).split(" ")[0]%></td>
				</tr>
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
		</table>

		<div class="btn_box">
			<div class="btn_right_box">
				<span class="btn_b_01"><a href="./<%=myPage %>" onclick="pageListGo()">목록</a></span>
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
/* 	function pageDelGo(){
		$('#mode').val('del');
		$('#fview').submit();
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	} */
//]]>	
</script>