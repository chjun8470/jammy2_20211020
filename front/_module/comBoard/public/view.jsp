<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(paramMap.get("m"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode")); //정렬(최신순, 인기순, 다운로드순)
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분

	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat datef = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

%>

<form name="fview" id="fview" action="sub.do" method="post" >
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>&amp;boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="cmtIdx" id="cmtIdx" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<!--b_ContBox S-->
	<div class="b_ContBox">


	<div class="PubCont">
	<%
		if(dataMap.size() > 0){
			String fileParam = "?dataGrp="+util.getStr(dataMap.get("DATA_GRP"))
							+"&amp;fileId="+util.getIntStr(dataMap.get("FILE_ID"))
							+"&amp;boardIdx="+util.getStr(dataMap.get("DATA_IDX"));
	%>
		<p class="TitPubView"><%=util.getStr(dataMap.get("SUBJECT")) %></p>

		<div class="PubimgBox" style="margin-top:30px;">
			<iframe src = "/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" title="PDF 자료" width="100%" height="562px" scrolling="yes" ></iframe>
			<object data="/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" type="application/pdf" width="100%" height="562px" style="display:none;">
				<embed src="/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" type="application/pdf" />
			</object>
			<div class="pdfMent" >
				<h3><b>태블릿/모바일</b> 모드에서는 <b>PDF다운로드</b> 후 확인가능합니다.</h3>
			</div>
		</div>

		<p class="TxtPubView2">
			발행기관(출처) : <%=util.getStr(String.valueOf(dataMap.get("DATA04")))%>
			&nbsp;/&nbsp;발행 : <%=util.getStr(String.valueOf(dataMap.get("DATA05")))%><br/>
			<%if("SCIENCE".equals(util.getStr(dataMap.get("DATA03")))) {%>
			분류 : 과학기술동향
			<% }else if("LAWORD".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류 : 관련법령
			<% }else if("TECHNOLOGY".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 기술자료
			<% }else if("ETC".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 발간물
			<% }else if("INDUSTRIAL".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 산업기술자료
			<% }else if("MENUAL".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 연구장비메뉴얼
			<% }else if("BROCHURE".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 연구장비브로슈어
			<% }else if("POLICY".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 정책이슈
			<% }else { %>
			분류: 통계자료
			<% } %>
			&nbsp;/&nbsp;조회 : <%=util.getIntStr(dataMap.get("HITS"))%>
		</p>

		<p class="down_publist">
			<a href="/cmm/fms/ComFileDown.do<%=fileParam.replace("boardIdx=", "dataIdx=") %>" title="첨부파일 다운로드" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','/img/board/btn_down3_ovr.gif',1)"><img src="/img/board/btn_down3.gif" alt="2" width="213" height="50" id="Image4" /></a>
		</p>
	</div>
 
	<div class="basic_pubviewWrap2">
		<h4 class="title003">주요정보</h4>
		<div class="pubview_text">
			<%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%>
		</div>
		<%--
			<h4 class="title003">목차</h4>
			<div class="pubview_text">
				<%=util.getStr(dataMap.get("DATA02"))%>
			</div>
		--%>
	</div>
	<div class="update" style="float:right;">
		[최종수정일:
		<%if(util.getStr(dataMap.get("LAST_UPDT_PNTTM_DT")).equals("")){%>
			<%=util.getStr(dataMap.get("FRST_REGIST_PNTTM_DT"))%>
		<%}else{%>
			<%=util.getStr(dataMap.get("LAST_UPDT_PNTTM_DT"))%>
		<%}%>
		]
	</div>
	<br/>
	<% } %>

</div>
<!--b_ContBox E-->

		<!-- 댓글리스트-->
		<input type="hidden" id="editComment" name="editComment" /><!--수정시 필요 -->
		<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { //댓글여부%>
		<%
			if(cmtMap.size() > 0) {
				int no = 0;
				for(HashMap rs:cmtMap) {
		%>
		<table class="P_contBox2" summary="보기 게시판으로 의견남기기, 답글남기기로 구성되어 있습니다.">
			<caption>의견남기기 답글남기기로 구성된 표입니다.</caption>
			<colgroup>
				<col style="width:65%;" />
				<col style="width:35%;" />
			</colgroup>

			<tbody>
				<tr>
					<td class="jip_info2 r_line_none" colspan="2">
					<div class="ideaBox" style="width: 100%;">
						<ul class="idea_list" style="display:">
							<li>
								<div class="idea_name"><%=util.getStr(rs.get("REG_USER_NM")) %></div>
								<div class="idea_date"><%=datef.format(rs.get("REG_DT")) %></div>

								<div class="idea_txt" id="commentDiv<%=no%>">
									<span id="comment<%=no%>"><%=util.getStr(rs.get("CMT_CONTENT")).replaceAll("\n", "<br/>") %></span>
									<textarea title="의견 내용 입력창" id="commentUdtInput<%=no%>" name="commentUdtInput" style=" display:none" class="input_idea"><%=util.getStr(rs.get("CMT_CONTENT")) %></textarea>
									&nbsp;
									<div class="edt_btn_box" style="float: right;">
										<%-- <%if(util.loginCheck() && util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %> --%>
										<%if(util.loginCheck() && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
											( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
											loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
											<a id="udtTag<%=no%>" onclick="editCmt('<%=no%>')" style="cursor:pointer; display:">수정</a>
											<a id="saveTag<%=no%>" href="#" style="display:none" onclick="editCmtProc('<%=util.getStr(rs.get("CMT_IDX")) %>',<%=no%>)" >저장</a>
											<a id="cancleTag<%=no%>" style="cursor:pointer; display:none" onclick="cancleEdit('<%=no%>')" >취소</a>
										<%} %>

										<%-- <%
										  int cmtDelLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_DEL")));
										  if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtDelLv){ //댓글삭제권한
										%> --%>
										<%
											int cmtDelLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_DEL")));
											if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtDelLv && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
											( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
											loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ 
										%>
											<a id="delTag<%=no%>" href="#" style="cursor:pointer; display:" onclick="delCmt('<%=util.getStr(rs.get("CMT_IDX")) %>')" >삭제</a>
										<%} %>
									</div>
								</div>
							</li>
						</ul>

					</div>
					</td>
				</tr>
			</tbody>
		</table>
		<%
					no++;
				}
			}
		%>
		<%}%>

		<div class="b_btn_area">
			<!-- 댓글등록 -->
			<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { //댓글여부 %>
			<div class="comment_box_btn">
				<textarea title="의견 내용 입력창" rows="5" cols="10" name="comment" class="b_txtbox4" style='width:85%;min-height:20px; height:78px;'></textarea>
				<%
					int cmtWriteLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_WRITE")));
					if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtWriteLv){ //댓글등록권한
				%>
				<button type="button" id="inpCmt" class="btn_rgt btn_style_1 btn_rgt_new_cnci" style="float:right;width:80px;height:80px">등록</button>
				<%	} else { %>
				<button type="button" id="inpCmtNot" class="btn_rgt btn_rgt_new_cnci" style="float:right;width:80px;height:80px">등록</button>
				<%	} %>
			</div>
			<% } %>

			<div class="dn_button_cs_box">
			<!--160821 front write,edit 삭제-->
			<%--
			<%if(util.loginCheck()){ %>
				<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")) {%>
					<button type="button" class="btn_rgt color_box_1" onclick="goSubmit('edit')">수정</button>
				<% } if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")) {%>
					<button type="button" class="btn_rgt color_box_1" onclick="goSubmit('del')">삭제</button>
				<% } %>
			<%} %>
			--%>
			<button type="button" class="btn_lft2" onclick="goSubmit('list', '<%=listMode%>', '<%=sortMode%>')">목록</button>
			</div>

		</div>
		<!--b_btn_area E-->

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

	/* function more_view(data, btn){
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
	} */

	function editCmt(no) {
		$("#comment"+no).hide();
		$("#udtTag"+no).hide();
		$("#delTag"+no).hide();
		$("#saveTag"+no).show();
		$("#cancleTag"+no).show();
		$("#commentUdtInput"+no).show()
	}

	function editCmtProc(idx, no) {
		$("#mode").val("editcmt");
		$("#cmtIdx").val(idx);
		$("#editComment").val($("#commentUdtInput"+no).val());
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

	function cancleEdit(no) {
		$("#saveTag"+no).hide();
		$("#cancleTag"+no).hide();
		$("#commentUdtInput"+no).hide()
		$("#udtTag"+no).show();
		$("#delTag"+no).show();
		$("#comment"+no).show();
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
		$("#inpCmtNot").click(function() {
			if(<%=util.loginCheck()%> == true){
				alert("등록 권한이 부족합니다.");
				return false;
			}else{
				alert("로그인해주세요.");
				return false;
			}

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
			//$('.tabBox_pub ul li').css("width","22%");
			$('.b_btn_area .b_txtbox4').css("width","644px");
			$('#inpCmt').css("width","80px");
			$('#inpCmt').css("height","80px");
			$('.b_btn_area').css("height","31px");
			$('#inpCmt').css("margin-top","");
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$('.b_btn_area .b_txtbox4').css("width","63%");
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