<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	String m = util.getStr(request.getQueryString());

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));

	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String resActionUrl = "/jeinet/sub.do?m=53";
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<!--MPCont s-->
<div class="MPCont">

	<div class="MPTit MPTit02">장바구니</div>

	<form id = "searchForm" name = "searchForm" method="post" action="./myfav.do" class="boardSearch">
		<input type="hidden" name = "nowPage" 			id = "nowPage" />
		<input type="hidden" name = "mode" 				id = "mode" />
		<input type="hidden" name = "listMode" 			id = "listMode" 		value="<%=listMode%>" />
		<input type="hidden" name = "sortMode" 			id = "sortMode" 		value="<%=sortMode%>" />
		<input type="hidden" name = "rndEquIdx" 		id = "rndEquIdx" 		value="" />
		<input type="hidden" name = "equGoodsFavIdx" 	id = "equGoodsFavIdx" 	value="" />
		<input type="hidden" name = "reUrl" 			id = "reUrl" 			value="myfav.do" />

<!--list_top S-->
<div class="list_top02 MAT0">

	<div class="board_count">전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건</div>

	<div class="b_srchBox02">

			<select name="searchUseScopeCd" id="searchUseScopeCd" class="b_select02">
				<option value="">활용범위</option>
				<option value="1" <%if(util.getStr(paramMap.get("searchUseScopeCd")).equals("1")) { %> selected="selected" <% } %>>단독활용가능</option>
				<option value="2" <%if(util.getStr(paramMap.get("searchUseScopeCd")).equals("2")) { %> selected="selected" <% } %>>공동활용허용가능</option>
				<option value="3" <%if(util.getStr(paramMap.get("searchUseScopeCd")).equals("3")) { %> selected="selected" <% } %>>공동활용서비스가능</option>
			</select>

			<select name="searchUseScopeRange" id="searchUseScopeRange" class="b_select02">
				<option value="">활용대상</option>
				<option value="기관내부활용" <%if(util.getStr(paramMap.get("searchUseScopeRange")).equals("기관내부활용")) { %> selected="selected" <% } %>>기관내부활용</option>
				<option value="기관외부활용" <%if(util.getStr(paramMap.get("searchUseScopeRange")).equals("기관외부활용")) { %> selected="selected" <% } %>>기관외부활용</option>
			</select>

			<select name="searchUseScopeMean" id="searchUseScopeMean" class="b_select02 mar0">
				<option value="">이용방법</option>
				<option value="직접" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("직접")) { %> selected="selected" <% } %>>직접사용</option>
				<option value="의뢰" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("의뢰")) { %> selected="selected" <% } %>>시험의뢰</option>
				<option value="대여" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("대여")) { %> selected="selected" <% } %>>대여</option>
				<option value="모두" <%if(util.getStr(paramMap.get("searchUseScopeMean")).equals("모두")) { %> selected="selected" <% } %>>모두가능</option>
			</select>

			<div class="b_srch02">
				<!-- 키워드 -->
				<input type="text" name="searchWord" id="searchWord" class="b_srch_txt02" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
				<!-- 검색버튼 -->
				<input type="image" class="b_go_btn02" src="/img/board/btn_ico_srch.png" onclick="pageSearchGo()" />
			</div>

	</div>

</div>

<!--list_top E-->

	<div class="checkBoxArea MAT20">
		<input type="checkbox" id="checkAll"/><label for="checkAll">전체선택</label>
	</div>

	<div class="pub_list MAT20" id="cont_block">

		<ul>
			<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
							for(HashMap rs:dataList) {

								int fileCnt = 1;

									/* String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileIdx="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX")); */
			%>
			<li>
				<div class="checkBoxArea MAT20">
					<input type="checkbox" id="checkContetns<%=cont %>" name="checkContents" value="<%=util.getStr(rs.get("RND_EQU_IDX"))%>"/><label for="checkContetns<%=cont %>">선택</label>
				</div>

				<p class="img_publist_blog MAT10" >

					<a href="#" onclick="pageViewGo('view','<%=listMode %>','<%=util.getStr(rs.get("RND_EQU_IDX"))%>')">

					<%if(util.getStr(rs.get("TITLE")).equals("") || util.getStr(rs.get("TITLE")).equals(null)) { %>

						<img src = "/img/board/img_sample5.jpg" width="200" height="200" /></a>
					 <% } else { %>
						<img src="<%=util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("TITLE"))%>" width="199" height="199" /></a>
					 <%  } %>
				</p>
				<div class="explanation02">


					<div class="pubBox01 MAT20">

						<div class="tit_publist_blog01">
							<%=util.getStr(rs.get("KOR_NM"))%>
						</div>

						<div class="star_publist_blog01">
							<%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("1.0")) { %> <img src="/img/board/star1.png" alt="1점" /> 1점 <% } %>
							<%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("2.0")) { %> <img src="/img/board/star2.png" alt="2점" /> 2점 <% } %>
							<%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("3.0")) { %> <img src="/img/board/star3.png" alt="3점" /> 3점 <% } %>
							<%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("4.0")) { %> <img src="/img/board/star4.png" alt="4점" /> 4점 <% } %>
							<%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("5.0")) { %> <img src="/img/board/star5.png" alt="5점" /> 5점 <% } %>
							<%if(util.getStr(rs.get("EQU_SATISFACTION")).equals("")) { %> <img src="/img/board/star5.png" alt="5점" /> 5점 <% } %>
						</div>

					</div>




					<div class="txt_publist_blog01 MAT10">
						<dl>
							<dt>제조사</dt>
							<dd><%=util.getStr(rs.get("MANUFACTURE_NM"))%></dd>

							<dt class="MAT10">활용대상</dt>
							<dd class="MAT10"><%if(util.getStr(rs.get("USE_SCOPE_RANGE")).equals("") || util.getStr(rs.get("USE_SCOPE_RANGE")).equals(null)) { %>
							정보없음
							<% } else { %>
								<%=util.getStr(rs.get("USE_SCOPE_RANGE"))%>
							<% } %>
							</dd>
						</dl>
					</div>


					<div class="txt_publist_blog02 MAT10">

						<% if(util.getStr(rs.get("EQUIP_DETAIL_EXAMPLE")).length() > 95) { %>
						<%=util.getStr(rs.get("EQUIP_DETAIL_EXAMPLE")).substring(0, 93)+"..."%></p>
						<% } else { %>
						<%=util.getStr(rs.get("EQUIP_DETAIL_EXAMPLE"))%></p>
						<% } %>

					</div>


					<div class="MPBtnWrap MAT20">
						<button id="favDelBtn" class="btn_inp_w_01" name="favDelBtn" onclick="favDeleteGo('<%=rs.get("EQU_GOODS_FAV_IDX")%>')">삭제</button>
					</div>
				</div>
			</li>
			<% cont--; } %>
		</ul>
	</div>

	</div>
	</form>
	<!--  </form> -->

			<div class="MPBtnWrap cntr MAT20">
				<input type="button" id="applyFav" name="applyFav" class="btn_inp_b_01" value="예약신청" onclick="goApplyFav()" style="cursor: pointer"/>
			</div>

	<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
//<![CDATA[
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(mode,listMode,idx){
		try	{
			window.opener.location.href = "/jeinet/sub.do?m=53&mode=view&rndEquIdx="+idx;
		}catch(e){
			//$('#mode').val('view');
			//$('#rndEquIdx').val(idx);
			//$('#searchForm').attr('_blank');
			//$('#searchForm').submit();
			window.open("/jeinet/sub.do?m=53&mode=view&rndEquIdx="+idx,'');
		}


	}
	function favDeleteGo(favIdx){
		$('#mode').val('del');
		$('#equGoodsFavIdx').val(favIdx);
		document.searchForm.action = "?<%=m%>";
		$('#searchForm').submit();
	}
	function listPageSubmit(mode,listMode,sortMode){
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

	// 체크박스 선택 값 신청
	function goApplyFav(){

	if($("input:checkbox[name=checkContents]").is(":checked") == false) {
		alert("장비를 선택해 주세요");
	}

		$("input[name=checkContents]:checked").each(function(){

			$("#mode").val("applyFavForm");
			$('#searchForm').submit();

		});
	}

	// 체크박스 전체선택,해제
	$(document).ready(function(){
		$("#checkAll").click(function(){
			var chk = $(this).is(":checked");
			if(chk){ $(".checkBoxArea input").prop("checked", true);
			}else{
				$(".checkBoxArea input").prop("checked", false);
			}
		});
	});
//]]>
</script>

