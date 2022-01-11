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
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO;"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
    String siteId = siteInfoVO.getSiteId();

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
	String listMode = util.getStr(paramMap.get("listMode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
<<<<<<< HEAD
	
	
=======
>>>>>>> 4424c7885b5c7f1cf0e25c6d2dc73af3c1fdf129

%>

<form name="fview" id="fview" action="sub.do" method="post" >
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&amp;mode=list&amp;boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="m"  value="<%=m%>" />
   <input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
   	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="basic_viewWrap">

		<table class="skin_view" summary="이미지게시판 상세보기 테이블로 제목, 등록자, 등록일, 첨부파일, 조회로 구성되어 있습니다.">
          <caption>이미지게시판 상세보기</caption>
		    <colgroup>
		      <col style="width:15%;" />
		      <col style="width:45%;" />
		      <col style="width:15%;" />
		      <col style="width:25%;" />
		    </colgroup>

			<thead>
			  <tr>
			    <th scope="col">제목</th>
			    <td class="r_line_none" colspan="3">
			    	<%=util.getStr(dataMap.get("SUBJECT"))%>
			    </td>
			  </tr>
			</thead>
			<tbody>
			  <tr>
			    <th scope="col">등록자</th>
			    <td><%=util.getStr(dataMap.get("WRITER_NM"))%>(<%=util.getStr(dataMap.get("WRITER_ID"))%>)</td>
				<th scope="col" class="lft_line">등록일</th>
			    <td class="r_line_none"><%=util.getStr(dataMap.get("FRST_REGIST_PNTTM"))%></td>
			  </tr>
			  <tr>
			  	<th scope="col">첨부파일</th>
			  	<td>
				  	<%
				  		int fileCnt = 1;
						if(fileList.size() > 0){
							for(HashMap rs:fileList){
								if( fileCnt != 1 ){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
								%>
									<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드">
										<img src="/img/board/ico_file.png" alt="첨부파일 아이콘" />&nbsp;<%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
									</a><br />
								<% 
								}
								fileCnt++;
							} 
						}
						%>
			    </td>
			    <th scope="col" class="lft_line">조회</th>
			    <td class="r_line_none"><%=util.getIntStr(dataMap.get("HITS"))%></td>
			  </tr>
			  <tr>
			    <td class="r_line_none view_cont" colspan="4" style="word-break:break-all; overflow:hidden;">
			    	<div style="padding: 10px;"><%=dataMap.get("CONTENT").trim().replaceAll("<br>", "<br/>")%></div>


					<!-- 파일첨부 이미지일 경우 화면에 출력  -->
					<%
						int imgCnt = 1;
						for(HashMap rs:fileList){
									String ext = util.getStr(rs.get("FILE_CAT")).toLowerCase();
									if("jpeg".equals(ext) || "jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){

										if( imgCnt != 1 ){
							%>
									<div>
										<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:1000px; vertical-align:middle" alt="" />
									</div>
							<%
									}
										imgCnt++;
								}
						}
					%>
			    </td>
			  </tr>
			</tbody>
		</table>
<%
if( util.getStr(boardMap.get("PERM_CMT")).equals("Y")){ %>
		<!--댓글 S-->
		<div>
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx" />
			<table class="skin_basic_write" style="width:100%;">
				<colgroup>
				    <col style="width:15%;" />
					<col style="width:50%;" />
					<col style="width:15%;" />
					<col style="width:20%;" />
			    </colgroup>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" name="cmt<%=no %>">
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td><%=util.getStr(rs.get("REG_DT")) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
						<%if(util.loginCheck() && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
							( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
							loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
							<input type="button" value="수정" style="width:30%; height:30px; margin-left:10px;" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')" >
						<%}%>
						<%
						int cmtDelLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_DEL")));
						if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtDelLv && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
						( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
						loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
							<input type="button" value="삭제" style="width:30%; height:30px; margin-left:10px;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">
						<%}%>
						</td>
						<%}%>
					</tr>
				<%
					no++;
					} %>
			</table>
			<%} %>
		</div>

		<div class="b_btn_area" style="height: 250px;">
		<%if(util.loginCheck()) { %>
			<textarea title="의견 내용 입력창"  rows="5" cols="10" name="comment" class="b_txtbox4 new_boxwrt" ></textarea>
			<button type="button" id="inpCmt" class="btn_rgt box_style_1 del_margin_new" style="float:right;">등록</button>
		<% } %>
<% }%>

		<!--b_btn_area S-->
			<div class="b_btn_area">
			<%-- <%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")){ %> --%>
				<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
					( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(dataMap.get("ORG_GRP_CD"))) )||
					loginVO.getUserId().equals(dataMap.get("WRITER_ID"))   ) ){ %>
					<input type="button" class="btn_rgt color_box_btn_1 del_margin_new_lft" value="수정" onclick="goSubmit('edit')"/>
			<%}%>
			<%-- <%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")){ %> --%>
				<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
					( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(dataMap.get("ORG_GRP_CD"))) )||
					loginVO.getUserId().equals(dataMap.get("WRITER_ID"))   ) ){ %>
					<input type="button" class="btn_rgt color_box_btn_1 del_margin_new_lft" value="삭제" onclick="goSubmit('del')"/>
			<%} %>
				<input type="button" class="btn_lft2 del_margin_new" value="목록" onclick="goSubmit('list')"/>
			</div>
		</div>
		<!--b_btn_area E-->

	</div>
	<!--basic_listWrap E-->

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

	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='3'><textarea title='의견 내용 입력창' rows='5' cols='10' name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='1' style='padding-left:30px;'><button type='button' style='width:42%; height:50px; margin-left:10px;' onclick='editCmtProc("+idx+")'>수정</button>"
		tag += "<button type='button' style='width:42%; height:40px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>취소</button></td>";
		tag += "</tr>";
		$("#cmt"+no).after(tag);
	}

	function editCmtProc(idx) {
		$("#mode").val("editcmt");
		$("#cmtIdx").val(idx);
		var formData = $("#fview").serialize();
		$.ajax({
			url:"sub.do",
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
				url:"sub.do",
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
				url:"sub.do", 
				/* url:"/sys/comBoard.do", */
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
		if(win_w < 1198 && win_w > 768){ //테블릿 1198 , 768 이하일때 100%
//			$('.tabBox_pub ul li').css("width","22%");
			$('.b_btn_area .b_txtbox4').css("width","85%");
			$('#inpCmt').css("width","80px");
			$('#inpCmt').css("height","80px");
			$('.b_btn_area').css("height","31px");
			$('#inpCmt').css("margin-top","");
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$('.b_btn_area .b_txtbox4').css("width","97%");
			$('#inpCmt').css("width","50px");
			$('#inpCmt').css("height","30px");
			$('.b_btn_area').css("height","100px");

		}else{ //기본사이즈
			//$('.b_btn_area .b_txtbox4').css("width","85%");//
			$('#inpCmt').css("margin-top","");


		}

	}
//]]>
</script>