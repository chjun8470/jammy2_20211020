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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

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
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

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


<form name="fview" id="fview" action="<%=myPage%>" method="post">
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="noticeCheck" id="noticeCheck" value="<%=util.getStr(dataMap.get("NOTICE_AT"))%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="skin_bbs_veiw" style="margin-top:30px; width:1000px;">

		<div class="bbs_head" style="width:1000px;">
			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="head_text" style="text-align: right; width: 980px;">
				<span> 작성자 : <%=util.getStr(dataMap.get("WRITER_ID")) %></span>	&#124;
			 	<span> 작성일 : <%=util.getStr(dataMap.get("FRST_REGIST_PNTTM"))%></span>
			</div>
		</div>

		<div class="bbs_cont" style="text-align: left; padding: 5px; width: 990px;">

			<div class="style-init" style="word-break:break-all; overflow:hidden;">
				<%=dataMap.get("CONTENT").trim().replaceAll("<br>", "<br/>")%>


			<!-- 파일첨부 이미지일 경우 화면에 출력  -->
			<%
				int imgCnt = 1;
				for(HashMap rs:fileList){
						String ext = util.getStr(rs.get("FILE_CAT")).toLowerCase();
	
						if("jpeg".equals(ext) || "jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){

							if( imgCnt != 1 ){
						%>
								<div>
									<%-- &#60; File_Image <%=imgCnt%> &#62;<br/> --%>
									<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:500px; vertical-align:middle "/>
								</div>
						<%			
							}
							imgCnt++;
	
						}
					}
			%>
			</div>

		</div>

		<!-- 첨부파일 -->
		<div style="clear:both;">
			<%if(fileList.size() > 0){%>

				<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
					<%
						int fileCnt = 1;
						for(HashMap rs:fileList){
							if( fileCnt != 1 ){
							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<li class="text"> 첨부파일 <%=fileCnt%> :
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
	                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
	                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
	                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
	         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
	                        </li>
						<% 
							}
							fileCnt++; 
						}
					%>
				</ul>
			<%} %>
		</div>
		<div class="btn_box" style="text-align: right;">
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")){ %>
				<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")){ %>
				<input type="button" class="btn_inp_b_01" value="삭제" onclick="goSubmit('del')"/>
			<%} %>
				<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
		</div>

	</div>
</form>

<script type="text/javascript">
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
</script>