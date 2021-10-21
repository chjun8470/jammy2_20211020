<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchReceipt = util.getStr(paramMap.get("searchReceipt"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(boardMap.get("SITE_ID")); //사이트구분
	String cash = util.getIntStr(dataMap.get("DATA02"));

	if((util.getBbsAuth(loginVO,boardMap,"READ")).equals(false)){
%>
		<script type="text/javascript" >
			alert("권한이 부족합니다.");
			history.back(-1); //이전화면으로
		</script>
<%
		return;
	}
%>
<div class="projectlnfoBoard_view">

<form name="fview" id="fview" action="sub.do" method="post" >
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchReceipt" id="searchReceipt" value="<%=searchReceipt%>" />
	
	<div class="basic_viewWrap">

		<table class="skin_view" summary="지역 사업정보 조회 테이블로 지원사업유형, 사업비, 접수상태, 접수기간, 사업기간, 담당기관/부서, 지원부처, 사업담당자(성명, 직위, 전화, 이메일), 사업목적, 사업내용, 첨부파일로 구성되어 있습니다.">
        <caption>지역 사업정보 조회</caption>
			<!-- colgroup s -->
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col" colspan="2">
						<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
					</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<tr>
					<th scope="col"> 지원사업유형</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("CODE_NM")) %></td>
				</tr>
				<tr>
					<th scope="col"> 사업비</th>
					<td class="r_line_none">
						
						<%=util.setFormatNum(cash,"comma")%> 원
					</td>
				</tr>
				<tr>
					<th scope="col"> 접수상태</th>
					<td class="r_line_none">
						<% if("접수중".equals(util.getStr(dataMap.get("RECEIPT_NM")))){ %>
						<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("접수전".equals(util.getStr(dataMap.get("RECEIPT_NM")))){ %>
						<img alt="접수전" src="/img/back/comm/edu_state_img_02.png" />
						<% }else{ %>
						<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
						<% }%>
					</td>
				</tr>
				<tr>
					<th scope="col"> 접수기간</th>
					<td class="r_line_none">
						<%=util.getStr(dataMap.get("DATA03")) %>&nbsp;~&nbsp;<%=util.getStr(dataMap.get("DATA04")) %>
					</td>
				</tr>
				<tr>
					<th scope="col"> 사업기간</th>
					<td class="r_line_none">
						<%=util.getStr(dataMap.get("DATA05")) %>&nbsp;~&nbsp;<%=util.getStr(dataMap.get("DATA06")) %>
					</td>
				</tr>
				<tr>
					<th scope="col"> 담당기관/부서</th>
					<td class="r_line_none">
						<%=util.getStr(dataMap.get("DATA07")) %>
					 	<%if(!util.getStr(dataMap.get("DATA08")).equals("")){%>
					 	/ <%=util.getStr(dataMap.get("DATA08")) %></td>
					 	<%}%>
				</tr>
				<tr>
					<th scope="col"> 지원부처</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("DATA09")) %></td>
				</tr>
				<tr>
					<th scope="col"> 사업담당자</th>
					<td class="r_line_none">
						<dl><dt style="float:left;width: 80px;font-weight: bold;" >성  명</dt><dd> <%=util.getStr(dataMap.get("DATA10"),"-") %></dd></dt></dl>
						<dl><dt style="float:left;width: 80px;font-weight: bold;" >직  위</dt><dd> <%=util.getStr(dataMap.get("DATA11"),"-") %></dd></dt></dl>
						<dl><dt style="float:left;width: 80px;font-weight: bold;" >전  화</dt><dd> <%=util.getStr(dataMap.get("DATA12"),"-") %></dd></dt></dl>
						<dl><dt style="float:left;width: 80px;font-weight: bold;" >이메일</dt><dd> <%=util.getStr(dataMap.get("DATA13"),"-") %></dd></dt></dl>
					</td>
					
				</tr>
				<tr>
					<th scope="col"> 사업목적</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("DATA14")) %></td>
				</tr>
				<tr>
					<th scope="col"> 사업내용</th>
					<td class="r_line_none">
						<div class="img_box" style="width:98%; height:98%;"><%=dataMap.get("CONTENT").trim().replaceAll("<br>", "<br/>").replaceAll("<br style='font: 14px/21px \"Malgun Gothic\", gulim, dotum, sans-serif; text-align: left; color: rgb(0, 0, 0); text-transform: none; text-indent: 0px; letter-spacing: -1px; word-spacing: 0px; white-space: normal; box-sizing: border-box; widows: 1; font-size-adjust: none; font-stretch: normal; -webkit-text-stroke-width: 0px;'>","<br/>")%></div>

						<!-- 파일첨부 이미지일 경우 화면에 출력  -->
						<!-- <%
							int imgCnt = 1;
							for(HashMap rs:fileList){
								String ext = util.getStr(rs.get("FILE_CAT")).toLowerCase();
									if("jpeg".equals(ext) || "jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
						%>
									<div>
										&#60; File_Image <%=imgCnt%> &#62;<br/>
										<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" alt="지역 사업정보 이미지파일" style="max-width:500px; vertical-align:middle "/>
									</div>
						<%
									imgCnt++;
									}
							}
						%> -->
					</td>
				</tr>
				<tr>
				  	<th scope="col">첨부파일</th>
				  	<td class="r_line_none">
					  	<%
							if(fileList.size() > 0){
							for(HashMap rs:fileList){
							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<span style="border-width: 1px;">
							<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드">
								<img src="/img/board/ico_file.png" alt="첨부파일 아이콘" style="padding-bottom: 5px;"/>&nbsp;<%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
							</a>
							</span>
							<br />

						<% } }%>
				    </td>
				</tr>
			</tbody>
		</table>

		<br/>

		<!-- 댓글 -->
		<div class="skin_basic_write">
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx" />
			<table class="new_text_box" style="">
				<colgroup>
					<col width="10%" />
					<col width="40%" />
					<col width="20%" />
					<col width="15%" />
				</colgroup>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" name="cmt<%=no %>">
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td style="text-align: center;"><%=util.getStr(rs.get("REG_DT")) %></td>
						<%-- <%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %> --%>
						
						<td class="style_new_1 AlignCenter">
						<%if(util.loginCheck() && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
							( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
							loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
							<span onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">수정</span>
						<%}%>
						<%
									int cmtDelLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_DEL")));
									if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtDelLv && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
									( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
									loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
							<span onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %> style="margin-left:5px;")">삭제</span>
						<%}%>
						</td>
						<%-- <% } %> --%>
					</tr>
				<%
					no++;
					}
				%>
			</table>
            <%} %>
            	
	        	<%if(util.loginCheck() && util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
		            	<textarea title="의견 내용 입력창" rows="5" name="comment" class="b_txtbox4 b_txtbox5_new" style=""></textarea>
		                <button type="button" id="inpCmt" class="btn_rgt2 btn_style_2 color_box_btn_2" style="float:right;width:80px;height:80px">등록</button>
	        	<% } %>
				<div class="b_btn_area">
				<%-- <%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")){ %> --%>
				<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
					( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(dataMap.get("ORG_GRP_CD"))) )||
					loginVO.getUserId().equals(dataMap.get("WRITER_ID"))   ) ){ %>
					<input type="button" class="btn_rgt color_box_btn_1" value="수정" onclick="goSubmit('edit')"/>
				<%}%>
				<%-- <%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")){ %> --%>
				<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
					( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(dataMap.get("ORG_GRP_CD"))) )||
					loginVO.getUserId().equals(dataMap.get("WRITER_ID"))   ) ){ %>
					<input type="button" class="btn_rgt color_box_btn_1" value="삭제" onclick="goSubmit('del')"/>
				<%} %>
					<input type="button" class="btn_lft2" value="목록" onclick="goSubmit('list')"/>
				</div>	
			</div>
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
	};

	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='2'><textarea name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='2' style='padding-left:30px;'><button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='editCmtProc("+idx+")'>수정</button>"
		tag += "<button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>취소</button></td>";
		tag += "</tr>";
		$("#cmt"+no).after(tag);
	};

	function editCmtProc(idx) {
		$("#mode").val("editcmt");
		$("#cmtIdx").val(idx);
		var formData = $("#fview").serialize();
		$.ajax({
			url:"/sys/comBoard.do",
			data:formData,
			type:"POST",
			success:function() {
				alert("댓글이 수정되었습니다.");
				window.location.reload();
			}
		});
	};

	function cancleEdit(no, idx) {
		$("#editcmt"+no).remove();
		$("#cmtIdx").val("");
		$("#cmt"+no).show();
	};

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
					alert("댓글이 삭제되었습니다.");
					window.location.reload();
				}
			});
		}
	};

	$(document).ready(function() {

		$("#inpCmt").click(function() {
			$("#mode").val("comment");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("댓글이 등록되었습니다.");
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
		
	};
//]]>	
</script>
</div>