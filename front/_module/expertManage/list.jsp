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

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, Object>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("dataList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));

	String fileGrp = "expertManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	int authLv = 0;
	int writeAuth = util.getInt(loginVO.getAuthLv());
	if(loginVO.getAuthLv() != null) {
		authLv = Integer.parseInt(loginVO.getAuthLv());
	}
%>

<div class="list_top">
	<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="userIdx" id="userIdx" value="" />

		<div class="board_count">
			[전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
			<%-- [전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page] --%>
		</div>
		<div class="b_srchBox srch_box" style="width:390px;">
        
           <select name="searchType" id="searchType" class="b_select" title="검색조건 선택">
				<option value="ORG" <%if("ORG".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>기관명</option>
				<option value="DEPT" <%if("DEPT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>부서명</option>
				<option value="NAME" <%if("NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>이름</option>
				<option value="POSITION" <%if("POSITION".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>직위</option>
			</select>

			<div class="b_srch wrt_box">
                <label class="hide" for="searchWord">검색어를 입력하세요</label>
				<input class="b_srch_txt" name="searchWord" id="searchWord" type="text" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" alt="검색" onclick="goSubmit('list')" />
			</div>

			

		</div>
	</form>
</div>

<!-- skin_basic_list s -->
<div class="pub_list03 size_style_1" id="cont_block">
	<ul class="pub_list03_blog cs_style_h size_cs_1">
	<%
		int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
		int num = 1;
		if(dataList.size()>0){
			for(HashMap rs:dataList) {

				String fileParam = "/img/main/no_image01.gif";
				String fileAlt = "";
				if(!util.getStr(rs.get("FILE_ID")).equals("") && !util.getStr(rs.get("FILE_ID")).equals(null)){
					fileParam = "/file/"+fileGrp+"/"+rs.get("TITLE");
					fileAlt = util.getStr(rs.get("PSN_NM"))+" 사진";
				}
		%>
		<li>
			<p class="img_publist03_blog img_size_cs1">
				<img src = "<%=fileParam%>" style=" width: 150px; height: 180px;" alt="<%=fileAlt%>" />
			</p>
			<div class="explanation MAT15 style_csbox1 height_cs_style">
				<table class=" table_box_style_1 skin_list img_size_960" summary="전문가 정보표입니다. 전문가 성명,직위,기관명,부서명,전공분야,관심분야,전문분야,주요경력, 경력 정보 등을 표기하고있습니다." >
					<caption>전문가 정보 테이블</caption>
					<colgroup>
						<col style="width: 50%;" />
						<col style="width: 50%;" />
					</colgroup>
					<thead>
						<tr>
						<th colspan="2">
							<p class="tit_publist03_blog01 cs_style">
								<%=util.getStr(rs.get("PSN_NM"))%>
							</p>
						</th>
					</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2" class="cs_td_style_1 box_style_1td AlignLeft">
								직위 : <%=util.getStr(rs.get("POSITION_NM"))%> &nbsp;/&nbsp;&nbsp;
								기관명 : <%=util.getStr(rs.get("ORG_GRP_NM"))%> &nbsp;/&nbsp;&nbsp;
								부서명 : <%=util.getStr(rs.get("DEPT_NM"))%>
							</td>
						</tr>
						<tr>
							<th class="cs_td_style_1 AlignLeft img_size1"><img alt="" src="/img/board/ico_h.png" /> 전공분야</th>
							<th class="cs_td_style_1 AlignLeft"><img alt="" src="/img/board/ico_h.png" /> 관심분야</th>
						</tr>
						<tr>
							<td class="cs_td_style_1 ValignTop AlignLeft">
								- 주전공 :
								<%if(util.getStr(rs.get("EX_MAJOR_NAME")).equals("")){ %>
									정보없음
								<%}else{%>
									<%=util.getStr(rs.get("EX_MAJOR_NAME"))%><br/>
								<%}%>
								- 복수전공 :
								<%if(util.getStr(rs.get("EX_MAJOR_PLURAL_NAME")).equals("")){ %>
									정보없음
								<%}else{%>
									 <%=util.getStr(rs.get("EX_MAJOR_PLURAL_NAME"))%>
								<%}%>
							</td>
							<td class="cs_td_style_1 ValignTop AlignLeft">
								<%=util.getStr(rs.get("PRO_USER_INTEREST_WORLD"))%>
							</td>
						</tr>
						<tr>
							<th class="cs_td_style_1 AlignLeft"><img alt="" src="/img/board/ico_h.png" /> 전문분야</th>
							<th class="cs_td_style_1 AlignLeft"><img alt="" src="/img/board/ico_h.png" /> 주요경력</th>
						</tr>
						<tr>
							<td class="cs_td_style_1 ValignTop AlignLeft">
								<%if(util.getStr(rs.get("PRO_JNTIS_PLANNING")).equals("Y")){%>정책기획,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JNTIS_RND")).equals("Y")){%>연구개발,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JNTIS_COMPANY")).equals("Y")){%>기업지원,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JEINET")).equals("Y")){%>연구장비,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JIPBANK")).equals("Y")){%>지식재산,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JNTIS_EDUCATION")).equals("Y")){%>인력양성,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JNTIS_CONSULTING")).equals("Y")){%>컨설팅,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JNTIS_MARKETING")).equals("Y")){%>마케팅,&nbsp;&nbsp;<%}%>
								<%if(util.getStr(rs.get("PRO_JNTIS_ETC")).equals("Y")){%>기타<%}%>
							</td>
							<td class="cs_td_style_1 ValignTop AlignLeft">
								<%
									ArrayList<HashMap<String, String>> dataList2 = request.getAttribute("dataList"+util.getStr(rs.get("USER_IDX"))) == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList"+util.getStr(rs.get("USER_IDX")));

									if(dataList2.size()>0){
										for(HashMap cr:dataList2) {
								%>
											<%=util.getStr(cr.get("CR_START"))%> - <%=util.getStr(cr.get("CR_FINISH"))%>&nbsp;&nbsp;
											<%=util.getStr(cr.get("CR_NM"))%>&nbsp;근무 <br/>
								<%
										}
									}else{
								%>
									정보없음
								<%}%>
							</td>

						</tr>
					</tbody>
				</table>

			</div>
		</li>

	<%		cont--;
			}
		}else{
	%>
		<li style="text-align: center;">데이터가 없습니다.</li>
	<%}%>
	</ul>

	<div class="b_btn_area">
		<% if(util.loginCheck() && authLv >= writeAuth) { %>
			<button class="btn_rgt" onclick="goSubmit('write')">등록</button>
		<% } else { %>
			<button class="btn_rgt" onclick="goLogin()">등록</button>
		<% } %>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,userIdx){
		$('#userIdx').val(userIdx);
		$('#mode').val(mode);
		if(mode == "view"){
			$('#searchForm').attr('method','get');
		}
		$('#searchForm').submit();
	}
	function goLogin() {
		alert("로그인이 필요합니다.");
		javascript:ssoPopupShow('login');
	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});
//]]>
</script>