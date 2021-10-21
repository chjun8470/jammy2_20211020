<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(request.getQueryString());
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId"));

%>
<div class="list_top">
	<form action="?<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" /> <!-- input hidden 모두 제거하고 프로세스에서 처리 -->
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId %>"/>

			<div class="board_count">
				[전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
			</div>

		<div class="publist_top_wrap">

			<div class="b_srchBox">
				<select name="searchType" id="searchType" class="b_select">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
						<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
				</select>
				<div class="b_srch">
					<input id="srch_txt" class="b_srch_txt" name="searchKrwd" type="text" title="검색단어입력" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" alt="바로가기" value="검색" onclick="goSubmit('list')" />
				</div>
			</div>

				<div class="list_sort">
				<% if("new_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
					<button class="sort01_over" id="pcont_block01_over" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"><img src="/img/board/btn_order_new_ovr.gif" alt="최신순" /></button>
					<button class="sort02" id="pcont_block02" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"><img src="/img/board/btn_order_popularity.gif" alt="인기순" ></button>
					<button class="sort03" id="pcont_block03" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"><img src="/img/board/btn_order_down.gif" alt="다운로드순" ></button>
				<% } else if("popular_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
					<button class="sort01" id="pcont_block01" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"><img src="/img/board/btn_order_new.gif" alt="최신순" /></button>
					<button class="sort02_over" id="pcont_block02_over" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"><img src="/img/board/btn_order_popularity_ovr.gif" alt="인기순" /></button>
					<button class="sort03" id="pcont_block03" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"><img src="/img/board/btn_order_down.gif" alt="다운로드순" ></button>
				<% } else { %>
					<button class="sort01" id="pcont_block01" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"><img src="/img/board/btn_order_new.gif" alt="최신순" /></button>
					<button class="sort02" id="pcont_block02" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"><img src="/img/board/btn_order_popularity.gif" alt="인기순" ></button>
					<button class="sort03_over" id="pcont_block03_over" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"><img src="/img/board/btn_order_down_ovr.gif" alt="다운로드순" /></button>
				<% } %>
				</div>

			<div class="b_srchBox_gap"><img src="/img/board/srch_box_gap.gif" /></div>

			<div class="b_btn_listBox">
				<button type="button" class="b_btn_block" id="cont_block" onclick="goSubmit('list','imagelist','<%=sortMode%>')" title="블럭형"><img src="/img/board/btn_block.png" ></button>
				<button type="button" class="b_btn_blog" id="cont_blog" onclick="goSubmit('list','bloglist','<%=sortMode%>')" title="블로그형"><img src="/img/board/btn_blog_ovr.png" /> </button>
			</div>
		</div>
	</form>
</div>


		<!-- skin_basic_list s -->
		<div class="pub_list" id="cont_block">
			<ul class="pub_list_blog">
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					int num = 1;
							for(HashMap rs:dataList) {
								for(HashMap filers:fileList) {
									if(rs.get("DATA_IDX").equals(filers.get("DATA_IDX")))
									{

										String fileParam = "?dataGrp="+util.getStr(filers.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(filers.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(filers.get("DATA_IDX"));
				%>
			<li>
				<p class="img_publist_blog"><a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><img id="<%=num %>" src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" width="199" height="281" /></a></p>
				<div class="explanation">
					<p class="tit_publist_blog01"><a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><%=util.getStr(rs.get("SUBJECT"))%></a></p>
					<p class="txt_publist_blog01"><a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">발행기관(출처) : <%=util.getStr(rs.get("DATA04"))%> /
					<p class="txt_publist_blog01"><a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">발행일 : <%=util.getStr(rs.get("DATA05"))%> /
					<%if("POLICY".equals(util.getStr(rs.get("DATA03")))) {%>
					분류 : 정책이슈
					<% }else if("LAWORD".equals(util.getStr(rs.get("DATA03")))) { %>
					분류 : 관련법령
					<% }else if("STATS".equals(util.getStr(rs.get("DATA03")))) { %>
					분류: 통계자료
					<% }else { %>
					분류: 기타발간물
					<% } %>
					/ 조회 : <%=util.getInt(rs.get("HITS"))%></a></p>
					<p class="txt_publist_blog02" style="overflow: hidden;""><a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><%=util.getStr(String.valueOf(rs.get("CONTENT")).replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""))%></a></p>

					<p class="down_publist"><a href="/cmm/fms/ComFileDown.do<%=fileParam%>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image15','','/img/board/btn_down2_ovr.gif',1)"><img src="/img/board/btn_down2.gif" alt="1" width="158" height="37" id="Image15" /></a></p>
				</div>
			</li>

					<% if(num%4 == 0) { %>
					<br/>
				<% } num++; cont--; } } }%>
			</ul>

		<div class="b_btn_area">
		<% if(util.loginCheck()) { %>
		<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
			<button class="btn_rgt" onclick="goSubmit('write')">등록</button>
		<% } } %>
		</div>
	</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,listMode,sortMode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}


</script>
<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
</script>