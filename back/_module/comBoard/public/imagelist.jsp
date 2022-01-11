<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> publicTypeList = request.getAttribute("publicTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("publicTypeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	/* 대표이미지 출력때문에 필요 imagelist, bloglist에서 필요 */
	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String ArrayCheck = util.getStr(paramMap.get("ArrayCheck")); // 게시판분류 체크값 담아두는곳
	if("".equals(listMode)) mode = "list";
%>

<div class="skin_list">
	<div>
		<form action="?<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="ArrayCheck" id="ArrayCheck" value="<%=ArrayCheck%>" />


			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search" style="line-height:27px;">
					<div style="position:relative;">
					<span style="float:left; padding:0px 0px;">게시판 분류 :</span>
					<%
						int cnt = 1;
						for(HashMap rs:publicTypeList) {

							String ckChecked = "NO";

							if(util.getStr(paramMap.get("ArrayCheck")) != null){
								String[] arrChk = util.getStr(paramMap.get("ArrayCheck")).split(",");

								for(int i =0;  i < arrChk.length ; i++){
									if(util.getStr(rs.get("CODE_CD")).equals(arrChk[i])){
										//System.out.println(arrChk[i]);
										ckChecked = "YES";
									}
								}

							}else{

								if(request.getParameterValues("searchPublicType[]") != null){
									String[] ckTp = request.getParameterValues("searchPublicType[]");

									for(int i =0;  i < ckTp.length ; i++){
										if(util.getStr(rs.get("CODE_CD")).equals(ckTp[i])){
											ckChecked = "YES";
										}
									}
								}
							}
					%>
					<span style="float:left; padding:0px 5px;"><input type="checkbox" name="searchPublicType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>>
						  <label for="sstp<%=cnt%>"><%=util.getStr(rs.get("CODE_NM"))%></label>
					</span>
					<%
						cnt++;
						}
					%>
					</div>
					<div style="position:relative;clear:both;">
						<label  for="searchState">접수상태 :</label>
						<select class="select" name="searchState" id="searchState" style="height: 24px;">
							<option value="">전체</option>
							<option value="10" <%if("10".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인요청</option>
							<option value="20" <%if("20".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인</option>
							<option value="30" <%if("30".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인거절</option>
						</select><br>

						<!-- 검색종류선택 -->
						<label  for="searchType" >검색구분 :</label>
						<select name="searchType" id="searchType" class="select" style="height: 24px;">
							<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
							<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
							<option value="GROUP" <%if("GROUP".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>발행기관</option>
						</select>

						<!-- 키워드 -->
						<input type="text" class="inp_txt" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:74%;" />

						<!-- 검색버튼 -->
						<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list','imagelist')" style="float:right"/>
					</div>
				</div>
				<!-- board-search e -->
			</div>
			</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]

				<!--리스트 버튼-->
				<input type="button" class="btn_inp_w_01" value="리스트" style="float:right;" onclick="goSubmit('list', 'list')"/>

				<%--
				<div class="btn_right_box">
					<input type="button" class="btn_inp_w_01" value="최신순" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"/>
					<input type="button" class="btn_inp_w_01" value="인기순" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"/>
					<input type="button" class="btn_inp_w_01" value="다운로드순" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"/>
					<input type="button" class="btn_inp_w_01" value="리스트" onclick="goSubmit('list', 'list', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="이미지리스트" onclick="goSubmit('list','imagelist', '<%=sortMode%>')"/>
					<input type="button" class="btn_inp_w_01" value="블로그리스트" onclick="goSubmit('list','bloglist', '<%=sortMode%>')"/>
				</div>
				--%>
			</div>

		</form>
		<!-- searchForm e -->

		<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

			if(dataList.size() == 0){
		%>
			<table  class="skin_basic_list">
				<tr>
					<th>번호</th>
					<th>사이트</th>
					<th>게시판분류</th>
					<th>제목</th>
					<th>발행기관</th>
					<th>발행일</th>
					<th>회수</th>
					<th>상태</th>
				</tr>
				<tr><td colspan='8'>데이터가 존재하지 않습니다</td></tr>
			</table>
		<%
			}
			int num = 1;
				for(HashMap rs:dataList) {
					int fileCnt = 1;
					for(HashMap filers:fileList) {
						if(rs.get("DATA_IDX").equals(filers.get("DATA_IDX")))
						{
							String fileParam = "?dataGrp="+util.getStr(filers.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(filers.get("FILE_ID"))
												+"&amp;boardIdx="+util.getStr(filers.get("DATA_IDX"));
		%>

			<div class="subject" style="float:left; top:30px;">
				<div class="tool" style="width:230px;height:400px;margin-left:10px;">
					<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
					<%if("".equals(util.getStr(rs.get("FILE_ID")))){%>
						<img src="/img/main/no_image02.gif" class="imgList" alt="no_image" width="200" height="300" />
					<%}else{%>
						<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="imgList" alt="사진" width="200" height="300" />
					<%}%>
					</a>
					<br/><br/>
					<span class="tit_publist" style="font-weight: bold;">
					<%if(util.getStr(rs.get("SUBJECT")).length()>13){%>
						<%=util.getStr(rs.get("SUBJECT")).substring(0,13)+"···"%>
					<%}else{%>
						<%=util.getStr(rs.get("SUBJECT"))%>
					<%}%>
					</span><br/>
					<span class="tooltip_info" >
						발행기관(출처) :
						<%if(util.getStr(rs.get("DATA04")).length()>10){%>
							<%=util.getStr(rs.get("DATA04")).substring(0,10)+"···"%>
						<%}else{%>
							<%=util.getStr(rs.get("DATA04"))%>
						<%}%><br />
						발행일 :<%=util.getStr(rs.get("DATA05"))%><br />
						분류 :<% if("POLICY".equals(util.getStr(rs.get("DATA03")))) { %> 정책이슈
						<% } else if("LAWORD".equals(util.getStr(rs.get("DATA03")))) { %> 관련법령
						<% } else if("STATS".equals(util.getStr(rs.get("DATA03")))) { %> 통계자료
						<% } else if("TECHNOLOGY".equals(util.getStr(rs.get("DATA03")))) { %> 기술자료
						<% } else if("MENUAL".equals(util.getStr(rs.get("DATA03")))) { %> 연구장비 메뉴얼
						<% } else if("BROCHURE".equals(util.getStr(rs.get("DATA03")))) { %> 연구장비 브로슈어
						<% } else if("SCIENCE".equals(util.getStr(rs.get("DATA03")))) { %> 과학기술정보
						<% } else if("INDUSTRIAL".equals(util.getStr(rs.get("DATA03")))) { %> 산업기술자료
						<% } else if("EXCELLENCE".equals(util.getStr(rs.get("DATA03")))) { %> 우수기술
						<% } else if("KICT".equals(util.getStr(rs.get("DATA03")))) { %> KICT우수기술
						<% } else { %> 발간물   <% } %><br />
						조회수: <%=util.getInt(rs.get("HITS"))%>
					</span>
				</div>

			</div>

			<%if(num%4 == 0) {%>
			<%}%>

		<%
					num++;
					cont--;
					}
				}//fileList
			}//dataList
		%>




		<%-- <div class="pub_list" id="cont_block">
			<ul class="pub_list_block">
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					int num = 1;
							for(HashMap rs:dataList) {
								int fileCnt = 1;
								for(HashMap filers:fileList) {
									if(rs.get("DATA_IDX").equals(filers.get("DATA_IDX")))
									{

									String fileParam = "?dataGrp="+util.getStr(filers.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(filers.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(filers.get("DATA_IDX"));


				%>
				<li class="tooltip" style="position:relative;">
				<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
				<p class="img_publist"><img id="<%=num %>" src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" width="199" height="281" /></p>
				<p class="tit_publist"><%=util.getStr(rs.get("SUBJECT"))%></p></a>
				<p class="down_publist"><a href="/cmm/fms/ComFileDown.do<%=fileParam%>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image22','','/img/board/btn_down1_ovr.gif',1)"><img src="/img/board/btn_down1.gif" alt="다운로드" width="213" height="50" id="Image22" /></a></p>

				<div id="tooltip<%=num %>" style="position:absolute; bottom:50px; right:1px; display:none;width:213px;height:350px;background-color:gray;margin-left:10px;opacity:0.6;color:white;text-align:center;">
                	<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')">
                	<div style="width:212px; height:350px;">
                    <br /><br />상세보기<br /><br />
                   	발행기관(출처) :<%=util.getStr(rs.get("DATA04"))%><br />
					발행 :<%=util.getStr(rs.get("DATA05"))%><br />
					<%if("POLICY".equals(util.getStr(rs.get("DATA03")))) {%>
					분류 : 정책이슈<br />
					<% }else if("LAWORD".equals(util.getStr(rs.get("DATA03")))) { %>
					분류 : 관련법령<br />
					<% }else if("STATS".equals(util.getStr(rs.get("DATA03")))) { %>
					분류: 통계자료<br />
					<% }else { %>
					분류: 기타발간물<br />
					<% } %>
					조회수: <%=util.getInt(rs.get("HITS"))%>
                    </div>
                    </a>
                </div>
				</li>



					<% if(num%4 == 0) { %>
					<br />
				<% } num++; cont--; } } }%>
			</ul>
		</div> --%>

		<div class="btn_box" style="clear:both;">
			&nbsp;
			<% if(util.loginCheck()) { %>
			<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="등록" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,listMode,sortMode,boardIdx){

		/*for(var i=1; i<$('input[name="searchPublicType[]"]').length; i++){
			if($('input:checkbox[id="sstp'+i+'"]').is(":checked")==true){
				alert($('input:checkbox[id="sstp'+i+'"]').val());
			}
		}*/

		var ArrayCheck = new Array();	//Array선언
		var CheckArr = document.getElementsByName("searchPublicType[]");	//체크박스의 이름을 가져온다.

		for(var i=0; i<CheckArr.length; i++){
			if(CheckArr[i].checked) {
				//alert(CheckArr[i].value);
				ArrayCheck.push(CheckArr[i].value);
			}
		}
		//alert(ArrayCheck);
		$("#ArrayCheck").val(ArrayCheck);

		$('#boardIdx').val(boardIdx);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

</script>