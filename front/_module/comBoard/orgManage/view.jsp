<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String orgGrpCd = util.getStr(paramMap.get("orgGrpCd"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String beforeBoardComIdx = util.getStr(paramMap.get("beforeBoardComIdx"));
	String afterBoardComIdx = util.getStr(paramMap.get("afterBoardComIdx"));
	//String siteId = util.getStr(paramMap.get("siteId")); //사이트구분(필요없음)
	String orgSearchWord = util.getStr(paramMap.get("orgSearchWord"));
	orgSearchWord = request.getParameter("orgSearchWord") == null ? "" : (String)request.getParameter("orgSearchWord");
	String searchWord = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat datef = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	if((util.getBbsAuth(loginVO,boardMap,"READ")).equals(false)){
%>
		<script type="text/javascript" >
		//<![CDATA[
			alert("권한이 부족합니다.");
			history.back(-1); //이전화면으로
		//]]>	
		</script>
<%
		return;
	}
%>

<form name="fview" id="fview" action="sub.do" method="post" >
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>" />
	<input type="hidden" name="noticeCheck" id="noticeCheck" value="<%=util.getStr(dataMap.get("NOTICE_AT"))%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="<%=beforeBoardComIdx%>" />
	<input type="hidden" name="afterBoardComIdx" id="afterBoardComIdx" value="<%=afterBoardComIdx%>" />
	<input type="hidden" name="m"  value="<%=m%>" />
	<input type="hidden" name="cmtIdx" id="cmtIdx" />
	<%-- <input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" /> --%>
	<input type="hidden" name="orgSearchWord" id="orgSearchWord" value="<%=orgSearchWord%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<div class="basic_viewWrap">

		<table class="skin_view">
		    <colgroup>
		      <col style="width:15%;" />
		      <col style="width:45%;" />
		      <col style="width:15%;" />
		      <col style="width:25%;" />
		    </colgroup>

			<tbody>
			  <tr>
			    <th scope="col">기관명</th>
			    <td>
			    	<%=util.getStr(dataMap.get("BOARD_ID"))%>
			    </td>
			    <th scope="col">부서명</th>
			    <td class="r_line_none">
			    	<%=util.getStr(dataMap.get("DATA02"))%>
			    </td>
			  </tr>
			  <tr>
			    <th scope="col">이름</th>
			    <td>
			    	<%=util.getStr(dataMap.get("DATA05"))%>
			    </td>
			    <th scope="col">직위</th>
			    <td class="r_line_none">
			    	<%=util.getStr(dataMap.get("DATA04"))%>
			    </td>
			  </tr>
			  <tr>
			    <th scope="col">전화번호</th>
			    <td>
			    	<%=util.getStr(dataMap.get("DATA08"))%>-<%=util.getStr(dataMap.get("DATA09"))%>-<%=util.getStr(dataMap.get("DATA10"))%>
			    </td>
			    <th scope="col">이메일</th>
			    <td class="r_line_none">
			    		<%=util.getStr(dataMap.get("DATA14"))%>@<%=util.getStr(dataMap.get("DATA15"))%>
			    </td>
			  </tr>
			  <tr>
			    <th scope="col" rowspan="2">업무내용</th>
			    <td class="r_line_none" colspan="3">
			    	<%=util.getStr(dataMap.get("TEXT1"))%>
			    </td>
			  </tr>


			</tbody>
		</table>


	<!--basic_listWrap E-->
		<div class="b_btn_area">

			<!-- class="btn_lft2"  -->
				<a href="./sub.do?m=<%=m%>&amp;mode=list&amp;listMode=list&amp;orgSearchWord=<%=orgSearchWord%>&amp;searchWord=<%=searchWord%>&amp;orgGrpCd=<%=util.getStr(dataMap.get("DATA01"))%>"><input type="button" class="btn_rgt" value="이전으로"/></a>
		</div>
		<!--b_btn_area E-->

		</div>
</form>




<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode){

		//삭제버튼 클릭할때 실행
		if(mode == 'del'){

			if (confirm("정말 삭제하시겠습니까??") == true){ //확인
				$('#mode').val(mode);
				$('#fview').submit();
			}else{ //취소
			    return;
			}

		}

		$('#mode').val(mode);
		$('#fview').submit();
	}

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
			alert("등록 권한이 부족합니다.");
			return false;
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
		$('.P_contBox2 td.jip_info2').css("height","auto");
		$('.skin_view').css("width","100%");
		$('.b_btn_area').css("width","100%");

		//$('.view_cont img').css("width","100%");
		//$('.view_cont img').css("height","");
		$('.__se_tbl_ext').css("width","100%");
		$('.__se_tbl_ext').removeAttr("width");
		$('.__se_tbl_ext tr td').css("width","200px");
		$('.__se_tbl_ext tr td').removeAttr("width");
		$('.__se_tbl_ext col').css("width","");
		$('.__se_tbl_ext').find('col:eq(0)').css("width","10%");
		$('.__se_tbl_ext').find('col:eq(1)').css("width","auto");
		$('.__se_tbl_ext col').removeAttr("width");
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



			$('.b_btn_area .btn_rgt2').css("width","90px");
			$('.b_btn_area .btn_rgt').css("width","90px");
			$('.b_btn_area .btn_lft2').css("width","90px");
			$('.b_btn_area .btn_rgt2').css("height","34px");
			$('.b_btn_area .btn_rgt').css("height","34px");
			$('.b_btn_area .btn_lft2').css("height","34px");
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$('.b_btn_area .b_txtbox4').css("width","100%");
			$('#inpCmt').css("width","50px");
			$('#inpCmt').css("height","30px");
			$('.b_btn_area').css("height","100px");

			$('.b_btn_area .btn_rgt2').css("width","60px");
			$('.b_btn_area .btn_rgt').css("width","60px");
			$('.b_btn_area .btn_lft2').css("width","60px");
			$('.b_btn_area .btn_rgt2').css("height","28px");
			$('.b_btn_area .btn_rgt').css("height","28px");
			$('.b_btn_area .btn_lft2').css("height","28px");

		}else{ //기본사이즈
			$('.b_btn_area .b_txtbox4').css("width","88%");
			$('#inpCmt').css("margin-top","");


		}

	}
//]]>	
</script>