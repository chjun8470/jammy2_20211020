<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	ComUtil util = new ComUtil();
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String listMode = paramMap.get("listMode");
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchType = util.getStr(paramMap.get("searchType"));
	
%>
<div class="popup_style">
	<div class="title_bar" style="padding:10px;background-color:#B2BABB;">
		<h1 align="center">:: 기관 조회 ::</h1>
	</div>
	<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="banner_search">
				<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
				<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
				<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
				

	<div class="search_p" style="margin:10px;">
		<div class="search_box">
			<div class="search_row">
				<select id="searchType" name="searchType">
					<option value="ORG" <%if("ORG".equals(searchType)) {%>selected="selected"<%} %>>기관명</option>
				</select>
				<input type="text" id="searchWord" name="searchWord" value="<%=searchWord %>" class="inp_txt" />
			
				<input type="button" onclick="submitGo()" value="검색" class="btn_g_01" />
			</div>
		</div>
	</div>
	</form>
	<div class="contents_box">
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 3%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">기관명</th>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<!-- 전체 데이터 넘기는 부분 -->
				<script type="text/javascript">
				//<![CDATA[
						var rsObj<%=cont%> = new Object();
						<%Set key = rs.keySet();
						for (Iterator iterator = key.iterator(); iterator.hasNext();) {
							//전송된 key
							String keyName = (String) iterator.next();
							//해당 key의 value
				            String value = (String) rs.get(keyName);
						%>
						rsObj<%=cont%>['<%=keyName%>'] = '<%=value.replaceAll("'","")%>';
						<%}%>
				//]]>		
				</script>
				<!-- 전체 데이터 넘기는 부분 -->
				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
					<td class="name">
						<button class="btn_inp_w_01"  onclick="clickToBtn('<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=util.getStr(rs.get("ORG_GRP_NM"))%>')">선택</button>
					</td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<div>
				<%=util.getPaging(staticVO, nowPage) %>
		</div>
			<div>
				<div class="btn_box">
					<div class="btn_right_box">
						<input type="button" value="닫기" class="btn_b_01" onclick="pageClose()"/>
					</div>
				</div>
			</div>
	</div>
</div>
<!--팝업창 내용 적용시키는 부분 -->
<script type="text/javascript">
//<![CDATA[
	function clickToBtn(cd, nm){
		
		$(opener.document).find("#blngOrgGubun").val(nm);		
// 		$(opener.document).find("#deptNm").val(cd);
	    //부서명 호출
 			var org_grp_cd = cd;
	    
			
			
				var params = {
                        "org_grp_cd":org_grp_cd
                        };
                jQuery.post("/web/changeOrgUpdate.do",$.param(params),
                function(data) {
                	alert("data   " + data);
//                       viewOrgSubList(data);
                }); 
		
		window.close();
	}
	function pageClose(){
		window.close();
	}
	function submitGo(){
		searchForm.submit();
	}
//]]>	
</script>