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
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId"));
	LoginVO loginVO = util.getLoginInfo(request);
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	SimpleDateFormat date_format = new SimpleDateFormat("YYYY-mm-dd");

%>
<form name="fview" id="fview" action="sub.do" method="post" >
		<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>&amp;boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
		<input type="hidden" name="m" value="<%=m%>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
		<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

<!--b_ContBox S-->
<div class="b_ContBox">


	<div class="PubCont">
	<%
		if(dataMap.size() > 0){
			String fileParam = "?dataGrp="+util.getStr(dataMap.get("DATA_GRP"))
					+"&amp;fileId="+util.getIntStr(dataMap.get("FILE_ID"))
					+"&amp;dataIdx="+util.getStr(dataMap.get("DATA_IDX"));

	%>
		<p class="TitPubView"><%=util.getStr(dataMap.get("SUBJECT")) %></p>
		<div class="PubimgBox" style="margin-top:30px;"><iframe src = "/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" width="100%" height="562px" scrolling="yes" ></iframe></div>
			<p class="TxtPubView2">
			발행기관(출처) : <%=util.getStr(String.valueOf(dataMap.get("DATA04")))%>
			/  발행일 : <%=util.getStr(String.valueOf(dataMap.get("DATA05")))%>
			<br/>
			<%if("POLICY".equals(util.getStr(dataMap.get("DATA03")))) {%>
			분류 : 정책이슈
			<% }else if("LAWORD".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류 : 관련법령
			<% }else if("STATS".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 통계자료
			<% }else { %>
			분류: 기타발간물
			<% } %>
			/  조회 : <%=util.getIntStr(dataMap.get("HITS"))%></p>
			<p class="down_publist">
			<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/btn_down3.gif" alt="2" width="213" height="50" id="Image4" /></a>
			<!--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','/img/board/btn_down3_ovr.gif',1)"><img src="/img/board/btn_down3.gif" alt="2" width="213" height="50" id="Image4" /></a>-->
			</p>
		</div>

<!--basic_listWrap S-->
		<div class="basic_pubviewWrap2">
		<div class="h4_tit">주요정보</div>
		<div class="pubview_text">
			<%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%>
		</div>
		<%-- <div class="h4_tit">목차</div>
		<div class="pubview_text">
			<%=util.getStr(dataMap.get("DATA02"))%>
		</div> --%>
		</div>
	<div class="update" style="float:right;">
		[최종수정일: <%=util.getStr(String.valueOf(dataMap.get("LAST_UPDT_PNTTM")))%>]
	<% } %>
	</div>
<!--basic_listWrap E-->
	</div>
<!--b_ContBox E-->

<!--b_btn_area E--><!--Contents E--><!--ContWrap E--><!--SubBox E--><!--SubWrap E-->

		<div>
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx">
			<table style="width:100%;">
				<colgroup>
					<col width="15%" />
					<col width="60%" />
					<col width="15%" />
					<col width="10%" />
				</colgroup>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" name="cmt<%=no %>">
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td style="text-align: center;"><%=util.getStr(String.valueOf(rs.get("REG_DT"))) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
							<a href="#" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">수정</a>
							<a href="#" style="margin-left:5px;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">삭제</a>
						</td>
						<% } %>
					</tr>
				<%
					no++;
					} %>
			</table>
			<%} %>
		</div>
		<div class="b_btn_area">
		<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>

				<textarea rows="5" cols="20" name="comment" class="b_txtbox4" style="width:88%;min-height:20px; height:78px;"></textarea>
				<button type="button" id="inpCmt" class="btn_rgt2" style="float:right;width:80px;height:80px">등록</button>
		<% } %>
			<%if(util.loginCheck()){ %>
				<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")) {%>
					<button type="button" class="btn_rgt" onclick="goSubmit('edit')">수정</button>
				<% } if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")) {%>
					<button type="button" class="btn_rgt" onclick="goSubmit('del')">삭제</button>
			<% } } %>
					<button type="button" class="btn_lft2" onclick="goSubmit('list', '<%=listMode%>', '<%=sortMode%>')">목록</button>
		</div>
</form>

<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode, listMode, sortMode){
		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		if(mode=="list"){
			$('#boardIdx').val('');
		}

		$('#fview').submit();
	}

	function more_view(data, btn){
		var content_data = data;
		var btn = btn;
		console.info(data);
		console.info(btn);
		$('#'+content_data).css("display", "block");
		$('#'+btn).css("display", "block");


	}
	function more_close(data, btn){
		alert(data);
		alert(btn);
	}

	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='2'><textarea name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='2' style='padding-left:30px;'><button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='editCmtProc("+idx+")'>수정</button>"
		tag += "<button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>취소</button></td>";
		tag += "</tr>";
		$("#cmt"+no).after(tag);
	}

	function editCmtProc(idx) {
		$("#mode").val("editcmt");
		$("#cmtIdx").val(idx);
		var formData = $("#fview").serialize();
		$.ajax({
			url:"/sys/comBoard.do",
			data:formData,
			type:"POST",
			success:function() {
				alert("수정되었습니다");
				window.location.reload();
			}
		});
	}

	function cancleEdit(no, idx) {
		$("#editcmt"+no).remove();
		$("#cmtIdx").val("");
		$("#cmt"+no).show();
	}

	function delCmt(cmt) {
		if(confirm("댓글을 삭제하시겠습니까?")) {
			$("#cmtIdx").val(cmt);
			$("#mode").val("delComment");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("삭제되었습니다");
					window.location.reload();
				}
			});
		}
	}

	$(document).ready(function() {
		$("#inpCmt").click(function() {
			$("#mode").val("comment");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("등록되었습니다");
					window.location.reload();
				}
			});
		});
	});


	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});

	function winResize(){
		var win_w = $(window).width();
		$('.b_btn_area .btn_lft2').css("margin-top","10px");
		$('.b_btn_area .btn_rgt2').css("margin-top","10px");
		$('.b_btn_area .btn_rgt').css("margin-top","10px");
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
//			$('.tabBox_pub ul li').css("width","22%");
			$('.b_btn_area .b_txtbox4').css("width","85%");
			$('#inpCmt').css("width","80px");
			$('#inpCmt').css("height","80px");
			$('.b_btn_area').css("height","31px");
			$('#inpCmt').css("margin-top","");
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$('.b_btn_area .b_txtbox4').css("width","100%");
			$('#inpCmt').css("width","50px");
			$('#inpCmt').css("height","30px");
			$('.b_btn_area').css("height","100px");

		}else{ //기본사이즈
			$('.b_btn_area .b_txtbox4').css("width","88%");
			$('#inpCmt').css("margin-top","");
		}

	}
//]]>
</script>
<!--
<script type="text/javascript">
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
-->