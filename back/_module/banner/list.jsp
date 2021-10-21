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
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	
	//첨부파일용
	String fileGrp = "banner";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	
	

	if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) < 99){
%>
	<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	</script>
<%
		return;
	}
%>

<div class="skin_list">
	<div>
		 <form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />

			<div class="bbs-top">
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<!-- 검색종류선택 -->
							<select name="searchType" id="searchType" class="select" style="height: 29px">
								<option value="ALL">전체</option>
								<option value="BANNER_IDX" <%if("BANNER_IDX".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>배너ID</option>
								<option value="BANNER_NAME" <%if("BANNER_NAME".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>배너명</option>
								<option value="BANNER_LINK" <%if("BANNER_LINK".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>배너 링크</option>
							</select>
							<!-- 키워드 -->
							<input class="board-input" type="text" title="검색단어입력" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:300px; height:25px" />
		
							<!-- 검색버튼 -->
							<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('')" style="float:right"/>
						</div>
						<!-- board-search e -->
					</div>
				</div>
			</div>
			<!-- bbs-top e -->
<!-- 			등록창 -->
			<div class="bbs-top" style="margin-top: 10px;">
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<label for="bannerName">배너명 :</label>
							<input id="bannerName" name="bannerName" class="board-input" style="height:25px">
							<label for="bannerLink">배너링크 :</label>
							<input id="bannerLink" name="bannerLink" class="board-input" style="height:25px;width: 200px;">
							<label for="searchType3">배너이미지 :</label>
							<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
                                  <div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	                                  <div >
	                                  	<input type="file" name="<%=fileFullGrp%>File"  id="<%=fileFullGrp%>File"  title="파일첨부" accept="image/*" />
	                                  </div>
	                           	  </div>
							</div>
							<label for="orderNo">배너순서 :</label>
							<input id="orderNo" name="orderNo" class="board-input" maxlength="11" onkeyup="onlyNumber($(this))" onkeydown="onlyNumber($(this))" style="width:75px; height:25px">
							<!-- 등록버튼 -->
							<input type="button" class="btn_inp_b_01" value="등록" onclick="writeProc()" style="float:right"/>
						</div>
						<!-- board-search e -->
					</div>
				</div>
			</div>

			<div class="total" style="float:left; text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>

		</form>
		<!-- searchForm e -->


		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 20%;" />
				<col style="width: 25%;" />
				<col style="width: 30%;" />
				<col style="width: 10%;" />
				<col style="width: 5%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">배너ID</th>
					<th scope="col">배너명</th>
					<th scope="col">배너 링크</th>
					<th scope="col">배너 이미지</th>
					<th scope="col">배너 순서</th>
					<th scope="col">수정</th>
				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
				int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
				for(HashMap rs:dataList) {
			%>
				<tr>
<!-- 				번호 -->
					<td>
						<%=cont%>
					</td>
<!-- 					배너ID -->
					<td>
						<%=util.getStr(rs.get("BANNER_IDX"))%>
					</td>
<!-- 					배너명 -->
					<td>
						<div name="view<%=util.getStr(rs.get("BANNER_IDX"))%>">
							<%if(util.getStr(rs.get("BANNER_NAME")).length()>20){%><%=util.getStr(rs.get("BANNER_NAME")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("BANNER_NAME"))%><%}%>
						</div>
						<div name="edit<%=util.getStr(rs.get("BANNER_IDX"))%>" class="hide">
							<input type="text" id="bannerName<%=util.getStr(rs.get("BANNER_IDX"))%>" name="bannerName<%=util.getStr(rs.get("BANNER_IDX"))%>" value="<%=util.getStr(rs.get("BANNER_NAME"))%>" style="height:25px;" />
						</div>
					</td>
<!-- 					배너링크 -->
					<td>
						<div name="view<%=util.getStr(rs.get("BANNER_IDX"))%>">
							<%if(util.getStr(rs.get("BANNER_LINK")).length()>100){%><%=util.getStr(rs.get("BANNER_LINK")).substring(0, 100)+" · · · "%><%}else{%><%=util.getStr(rs.get("BANNER_LINK"))%><%}%>
						</div>
						<div name="edit<%=util.getStr(rs.get("BANNER_IDX"))%>" class="hide">
							<input type="text" id="bannerLink<%=util.getStr(rs.get("BANNER_IDX"))%>" name="bannerLink<%=util.getStr(rs.get("BANNER_IDX"))%>" value="<%=util.getStr(rs.get("BANNER_LINK"))%>" style="height:25px;width: 200px;" />
						</div>
					</td>
<!-- 					배너이미지 -->
					<td>
						<form action="./<%=myPage %>" name="editForm<%=util.getStr(rs.get("BANNER_IDX"))%>" id="editForm<%=util.getStr(rs.get("BANNER_IDX"))%>" method="post">
							<input type="hidden" name="mode" id="editMode<%=util.getStr(rs.get("BANNER_IDX"))%>"  value="<%=mode%>" />
							<input type="hidden" id="editBannerName<%=util.getStr(rs.get("BANNER_IDX"))%>" name="bannerName">
							<input type="hidden" id="editBannerLink<%=util.getStr(rs.get("BANNER_IDX"))%>" name="bannerLink">
							<input type="hidden" id="editOrderNo<%=util.getStr(rs.get("BANNER_IDX"))%>" name="orderNo">
							<input type="hidden" id="dataIdx<%=util.getStr(rs.get("BANNER_IDX"))%>" name="dataIdx" value="<%=util.getStr(rs.get("BANNER_IDX"))%>" />
							<div name="view<%=util.getStr(rs.get("BANNER_IDX"))%>">
							
							<!-- 파일첨부 이미지일 경우 화면에 출력  -->
						<%
							String ext = util.getStr(rs.get("FILE_CAT")).toLowerCase();
		
							if("jpeg".equals(ext) || "jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
								
						%>
							<div>
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:123px; max-height: 27px; vertical-align:middle "/>
							</div>
						<%
							}
						%>
							</div>
							<div name="edit<%=util.getStr(rs.get("BANNER_IDX"))%>" class="hide">
						<ul>
					<%
						if(!util.getStr(rs.get("FILE_ID")).equals("")){
							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
					%>
							<li class="text">
								<input type="hidden" id="fileDel<%=util.getStr(rs.get("BANNER_IDX"))%>" name="fileDel" value="" />
								<input type="hidden" id="fileId<%=util.getStr(rs.get("BANNER_IDX"))%>" name="fileId" value="<%=util.getStr(rs.get("FILE_ID"))%>" />
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
								<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
	
							</li>
						</ul>
						
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox"<%=util.getStr(rs.get("BANNER_IDX"))%>>
							<div>
								<input type="file" name="<%=fileFullGrp%>File<%=util.getStr(rs.get("BANNER_IDX"))%>"  id="<%=fileFullGrp%>File<%=util.getStr(rs.get("BANNER_IDX"))%>"  title="파일첨부" accept="image/*" />
								<br/> * 123px * 27px 사이즈의 이미지만 등록해주세요.
							</div>
						</div>
		            <% 
			            }else{
					%>
							<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox<%=util.getStr(rs.get("BANNER_IDX"))%>">
								<div>
									<input type="file" name="<%=fileFullGrp%><%=util.getStr(rs.get("BANNER_IDX"))%>" id="<%=fileFullGrp%><%=util.getStr(rs.get("BANNER_IDX"))%>" title="파일첨부" />
								</div>
							</div>
				      <% } %>
							</div>
						</form>
					      </td>
<!-- 					배너순서 -->
					<td>
						<div name="view<%=util.getStr(rs.get("BANNER_IDX"))%>">
							<%=util.getStr(rs.get("ORDER_NO"))%>
						</div>
						<div name="edit<%=util.getStr(rs.get("BANNER_IDX"))%>" class="hide">
							<input type="text" id="orderNo<%=util.getStr(rs.get("BANNER_IDX"))%>" name="orderNo<%=util.getStr(rs.get("BANNER_IDX"))%>" value="<%=util.getStr(rs.get("ORDER_NO"))%>" style="width:75px; height:25px" />
						</div>
					</td>
<!-- 					수정 -->
					<td>
						<div name="view<%=util.getStr(rs.get("BANNER_IDX"))%>">
							<input type="button" value="수정" class="btn_inp_b_01" onclick="editMode($(this), <%=util.getStr(rs.get("BANNER_IDX"))%>)">
						</div>
						<div name="edit<%=util.getStr(rs.get("BANNER_IDX"))%>" class="hide">
							<input type="button" value="삭제" class="btn_inp_b_01" onclick="delProc($(this), <%=util.getStr(rs.get("BANNER_IDX"))%>)">
							<input type="button" value="수정" class="btn_inp_b_01" onclick="edit($(this), <%=util.getStr(rs.get("BANNER_IDX"))%>)" style="margin-top: 10px;">
							<input type="button" value="취소" class="btn_inp_w_01" onclick="editExit($(this), <%=util.getStr(rs.get("BANNER_IDX"))%>)" style="margin-top: 10px;">
						</div>
					</td>
				</tr>
			<%
				cont--;
				}
			%>
			</tbody>
		</table>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
	//검색
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	
	//수정모드
	function editMode(param, id)
	{
		console.log(param);
		console.log(id);
		$("div[name='edit" + id + "']").each(function(){
			
			$(this).removeClass('hide');
		});
		
		$("div[name='view" + id + "']").each(function(){
			
			$(this).addClass('hide');
		});
	}
	
	
	//수정
	function edit(param, id)
	{
			//유효성 체크
			if($("#bannerName"+id).val() == "")
			{
				alert("배너명을 입력하세요.");
				return false;
			}
			else if($("#bannerLink"+id).val() == "")
			{
				alert("배너링크를 입력하세요.");
				return false;
			}
			else if($("#orderNo"+id).val() == "")
			{
				alert("배너순서를 입력하세요.");
				return false;
			}
			
		if(confirm("수정 하시겠습니까?"))
		{
			//DATA SET
			$("#editMode"+id).val("editProc");
			$("#editBannerName"+id).val($("#bannerName"+id).val());
			$("#editBannerLink"+id).val($("#bannerLink"+id).val());
			$("#editOrderNo"+id).val($("#orderNo"+id).val());
			
			//업로드 파일 있는지 확인
			if($("#bannerFile"+id).val() != "")
			{
				//삭제 방지용
				$("#fileDel"+id).val("Y");
			}
			
			var editData = new FormData($("#editForm"+id)[0]);
			$.ajax({
				url:"/sys/sys_banner_manage.do",
				data:editData,
				type:"POST",
				processData : false,
	            contentType : false,
				success:function(data){
					alert(data.msg);
					window.location.reload();
				}
			});
		}
	}
	
	//수정 취소
	function editExit(param, id)
	{
		$("div[name='view" + id + "']").each(function(){
			
			$(this).removeClass('hide');
		});
		$("div[name='edit" + id + "']").each(function(){
			
			$(this).addClass('hide');
		});
	}
	
	//등록
	function writeProc()
	{
		//유효성 체크
		if($("#bannerName").val() == "")
		{
			alert("배너명을 입력하세요.");
			return false;
		}
		else if($("#bannerLink").val() == "")
		{
			alert("배너링크를 입력하세요.");
			return false;
		}
		else if($("#bannerFile").val() == "")
		{
			alert("배너이미지를 추가하세요.");
			return false;
		}
		else if($("#orderNo").val() == "")
		{
			alert("배너순서를 입력하세요.");
			return false;
		}
		
		if(confirm("등록 하시겠습니까?"))
		{
			//DATA SET
			$("#mode").val("writeProc");
			var formData = new FormData($("#searchForm")[0]);
			$.ajax({
				url:"/sys/sys_banner_manage.do",
				data:formData,
				type:"POST",
				processData : false,
	            contentType : false,
				success:function(data){
					alert(data.msg);
					window.location.reload();
				}
			});
		}
	}
	
	
	
	//삭제
	function delProc(param, id)
	{
		if(confirm("삭제 하시겠습니까?"))
		{
			//DATA SET
			$("#editMode"+id).val("del");
			var editData = new FormData($("#editForm"+id)[0]);
			$.ajax({
				url:"/sys/sys_banner_manage.do",
				data:editData,
				type:"POST",
				processData : false,
	            contentType : false,
				success:function(data){
					alert(data.msg);
					window.location.reload();
				}
			});
		}
	}
	
	//숫자만 입력
	function onlyNumber(param){
		param.val(param.val().replace(/[^0-9]/gi,""));
	}
	
	
</script>

