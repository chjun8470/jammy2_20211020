<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> reservationDataList = request.getAttribute("reservationDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("reservationDataList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "registration";
	String fileImgGrp = "registartion_img";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String fileFullImgGrp = fileImgGrp+fileSubGrp;

	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));

	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");

	ArrayList<HashMap<String, String>> DataPatentList = request.getAttribute("dataPatentList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataPatentList");
	ArrayList<HashMap<String, String>> DataDesignList = request.getAttribute("dataDesignList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataDesignList");
	ArrayList<HashMap<String, String>> DataBrandList = request.getAttribute("dataBrandList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataBrandList");
	ArrayList<HashMap<String, String>> DataProgramList = request.getAttribute("dataProgramList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataProgramList");
	ArrayList<HashMap<String, String>> DataKnowHowList = request.getAttribute("dataKnowHowList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataKnowHowList");

	int scCnt = 0;
%>
<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
	<input type="hidden" 	name="m" 			id="m" 				value="57" />
	<input type="hidden" 	name="mode" 		id="mode" 			value="<%=mode%>" />
	<input type="hidden" 	name="nowPage" 		id="nowPage" 		value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" 	name="listMode" 	id="listMode" 		value="<%=listMode%>" />
	<input type="hidden" 	name="searchCd" 	id="searchCd" 		value="<%=util.getStr(paramMap.get("searchCd")) %>" />
	<input type="hidden" 	name="searchId" 	id="searchId" 		value="" />

<!--tabBox S-->
<div class="tabBox2">
	<ul>
		<li <%if(util.getStr(paramMap.get("searchCd")).equals("") || util.getStr(paramMap.get("searchCd")).equals("all")) { %> class="on" <% } %>><a href="#" onclick="orderTab('all')">전체</a></li>
		<li <%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %> class="on" <% } %>><a href="#" onclick="orderTab('1')">특허실용신안</a></li>
		<li <%if(util.getStr(paramMap.get("searchCd")).equals("2")) { %> class="on" <% } %>><a href="#" onclick="orderTab('2')">디자인</a></li>
		<li <%if(util.getStr(paramMap.get("searchCd")).equals("3")) { %> class="on" <% } %>><a href="#" onclick="orderTab('3')">상표</a></li>
		<li <%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %> class="on" <% } %>><a href="#" onclick="orderTab('4')">프로그램</a></li>
		<li <%if(util.getStr(paramMap.get("searchCd")).equals("5")) { %> class="on" <% } %>><a href="#" onclick="orderTab('5')">노하우</a></li>
	</ul>
</div>
<!--tabBox E-->

<!--Patent_search S-->
<div class="Patent_search">

<div class="p_srchBox">
<div class="p_kinds">기술별</div>

	<select class="p_select" name="reDeth1" id="reDeth1<%=scCnt %>" onchange="standardDeth1('reDeth2<%=scCnt %>')">
		<option value="">중분류</option>
			<%
			int num = 1;
			for(HashMap rs:standardList) {
			%>
		<option id="mCode<%=num%>" <%if(util.getStr(paramMap.get("reDeth1")).equals(util.getStr(rs.get("CODE")))) { %>selected <% } %>
		value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
		<% num++; } %>
	</select>

	<select class="p_select2" name="reDeth2" id="reDeth2<%=scCnt %>">
		<option value="">소분류</option>
	</select>

</div>


<div class="p_srchBox">
	<div class="p_kinds">기관별</div>

	<input id="ownOrgNmText" class="p_srch_txt2" name="ownOrgNmText" type="text" title="검색단어입력" value="<%=util.getStr(paramMap.get("ownOrgNmText"))%>" />

</div>


<div class="p_srchBox">
	<div class="p_kinds">유형별</div>

	<select class="p_select" name="searchSelect" id="searchSelect">
		<option value="">선택하세요</option>
		<option value="1" <%if(util.getStr(paramMap.get("searchSelect")).equals("1")) { %> selected <% } %>>명칭</option>
		<option value="2" <%if(util.getStr(paramMap.get("searchSelect")).equals("2")) { %> selected <% } %>>기술내용</option>
		<option value="3" <%if(util.getStr(paramMap.get("searchSelect")).equals("3")) { %> selected <% } %>>출원번호</option>
		<option value="4" <%if(util.getStr(paramMap.get("searchSelect")).equals("4")) { %> selected <% } %>>등록번호</option>
	</select>
	<input id="p_srch_txt" class="p_srch_txt" name="searchSelectText" type="text" title="검색단어입력" value="<%=util.getStr(paramMap.get("searchSelectText"))%>" />
</div>

<div class="p_srchBox">
	<div class="p_kinds">지역별</div>

	<select class="p_select" name="searchArea" id="searchArea">
		<option value="">선택하세요</option>
		<%
			int numArea = 1;
			for(HashMap rs:areaSigunguList) {
			%>
		<option id="sigunguCode<%=numArea%>" <%if(util.getStr(paramMap.get("searchArea")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
		value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
		<% numArea++; } %>
	</select>

	<div class="p_btnBox">
		<button class="p_btn_rgt" onclick="pageSearchGo()" style="cursor:pointer">검색</button>
	</div>
</div>

</div>
<!--Patent_search E-->

<%if(util.getStr(paramMap.get("searchCd")).equals("1") && util.getStr(paramMap.get("totalCountPatent")).equals("")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 실용특허실안 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>
<% } else if(util.getStr(paramMap.get("searchCd")).equals("1") && util.getStr(paramMap.get("totalCountPatent")).equals("0")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 실용특허실안 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>

<% } else if(util.getStr(paramMap.get("searchCd")).equals("2") && util.getStr(paramMap.get("totalCountDesign")).equals("")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 디자인 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>
<% } else if(util.getStr(paramMap.get("searchCd")).equals("2") && util.getStr(paramMap.get("totalCountDesign")).equals("0")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 디자인 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>

<% } else if(util.getStr(paramMap.get("searchCd")).equals("3") && util.getStr(paramMap.get("totalCountBrand")).equals("")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 상표 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>
<% } else if(util.getStr(paramMap.get("searchCd")).equals("3") && util.getStr(paramMap.get("totalCountBrand")).equals("0")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 상표 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>

<% } else if(util.getStr(paramMap.get("searchCd")).equals("4") && util.getStr(paramMap.get("totalCountProgram")).equals("")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 프로그램 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>
<% } else if(util.getStr(paramMap.get("searchCd")).equals("4") && util.getStr(paramMap.get("totalCountProgram")).equals("0")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 프로그램 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>

<% } else if(util.getStr(paramMap.get("searchCd")).equals("5") && util.getStr(paramMap.get("totalCountKnowHow")).equals("")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 노하우 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>
<% } else if(util.getStr(paramMap.get("searchCd")).equals("5") && util.getStr(paramMap.get("totalCountKnowHow")).equals("0")) { %>
<div class="txt_p_info"><img src="/img/board/result_none.png" alt="검색하신 노하우 내용의 데이터가 없습니다. 확인 후 다시 검색해 주세요." /></div>
<% } else { %>


<div class="list_top" style="margin-top:-20px; border-bottom:1px solid #e1e1e1; padding-bottom:10px; margin-bottom:20px">
	<div class="b_btn_listBox">
		<button type="button" class="b_btn_block" id="cont_block" onclick="pageListGo('moreImageList')" title="블럭형"><img src="/img/board/btn_block_ovr.png" style="cursor:pointer"/></button>
		<button type="button" class="b_btn_blog" id="cont_blog" onclick="pageListGo('moreBlogList')" title="블로그형"><img src="/img/board/btn_blog.png" style="cursor:pointer"/> </button>
	</div>
</div>



	<!--특허검색 결과 S-->
<!--Patent_listWrap S-->
<div class="Patent_listWrap">

	<!--PatentBox01 S-->
	<div class="PatentBox">
	<div class="tit_patent01">
	<%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %>[특허실용신안]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("2")) { %>[디자인]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("3")) { %>[상표]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>[프로그램]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("5")) { %>[노하우]<% } %>
	</div>
	<div class="patent_count">
	<%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %>
		<%if(util.getStr(paramMap.get("totalCountPatent")).equals("") || util.getStr(paramMap.get("totalCountPatent")).equals(null)) { %>
		&nbsp;&nbsp;&nbsp; <span class="Bold">검색결과과 없습니다.</span>
		<% } else { %>
	<span class="Bold"><%=util.getStr(paramMap.get("totalCountPatent"))%></span>건 검색
		<% } %>
	<% } %>

	<%if(util.getStr(paramMap.get("searchCd")).equals("2")) { %>
		<%if(util.getStr(paramMap.get("totalCountDesign")).equals("") || util.getStr(paramMap.get("totalCountDesign")).equals(null)) { %>
		&nbsp;&nbsp;&nbsp; <span class="Bold">검색결과과 없습니다.</span>
		<% } else { %>
	<span class="Bold"><%=util.getStr(paramMap.get("totalCountDesign"))%></span>건 검색
		<% } %>
	<% } %>

	<%if(util.getStr(paramMap.get("searchCd")).equals("3")) { %>
		<%if(util.getStr(paramMap.get("totalCountBrand")).equals("") || util.getStr(paramMap.get("totalCountBrand")).equals(null)) { %>
		&nbsp;&nbsp;&nbsp; <span class="Bold">검색결과과 없습니다.</span>
		<% } else { %>
	<span class="Bold"><%=util.getStr(paramMap.get("totalCountBrand"))%></span>건 검색
		<% } %>
	<% } %>

	<%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>
		<%if(util.getStr(paramMap.get("totalCountProgram")).equals("") || util.getStr(paramMap.get("totalCountProgram")).equals(null)) { %>
		&nbsp;&nbsp;&nbsp; <span class="Bold">검색결과과 없습니다.</span>
		<% } else { %>
	<span class="Bold"><%=util.getStr(paramMap.get("totalCountProgram"))%></span>건 검색
		<% } %>
	<% } %>

	<%if(util.getStr(paramMap.get("searchCd")).equals("5")) { %>
		<%if(util.getStr(paramMap.get("totalCountKnowHow")).equals("") || util.getStr(paramMap.get("totalCountKnowHow")).equals(null)) { %>
		&nbsp;&nbsp;&nbsp; <span class="Bold">검색결과과 없습니다.</span>
		<% } else { %>
	<span class="Bold"><%=util.getStr(paramMap.get("totalCountKnowHow"))%></span>건 검색
		<% } %>
	<% } %>

	</div>


	<ul class="patent_imglist">


		<!-- 특허실용신안 리스트 -->
		<%
		if(util.getStr(paramMap.get("searchCd")).equals("1")) {
			int cont1 = (util.getInt(paramMap.get("totalCountPatent")) - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num1 = 1;
					for(HashMap rs:DataPatentList) {
		%>
		<a href="#" onclick="pageViewGo('view','<%=util.getStr(rs.get("SEARCH_PATENT_IDX"))%>','1')">
		<li>

		<div class="shape">
			<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("10")) { %>
			<img alt="기계/소재" src="/img/board/shape11.gif" />
			<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("20")) { %>
			<img alt="전기/전자" src="/img/board/shape12.gif" />
			<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("30")) { %>
			<img alt="정보통신" src="/img/board/shape13.gif" />
			<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("40")) { %>
			<img alt="화학" src="/img/board/shape14.gif" />
			<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("50")) { %>
			<img alt="바이오/의료" src="/img/board/shape15.gif" />
			<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("60")) { %>
			<img alt="에너지/자원" src="/img/board/shape16.gif" />
			<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("70")) { %>
			<img alt="지식서비스" src="/img/board/shape17.gif" />
			<% } %>
		</div>
		<h3><span class="Bold">
		<% if(util.getStr(rs.get("INVENTION_KOR_NM")).length() > 7){ %>
			<%=util.getStr(rs.get("INVENTION_KOR_NM")).substring(0, 7)+"...."%>
			<% } else { %>
			<%=util.getStr(rs.get("INVENTION_KOR_NM"))%>
		<% } %>
		</span></h3>

			<div class="patent_info">
			<div class="patent_img"><img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+util.getStr(rs.get("IMG_TITLE")))%>" alt="대표이미지" /></div>
			</div>

		</li></a>
		<% if(num1%4 == 0) { %>
			<br />
		<% } num1++; cont1--; }  %>

		<%if(util.getStr(paramMap.get("totalCountPatent")).equals("") || util.getStr(paramMap.get("totalCountPatent")).equals(null)) { %>
		<% }  } %>
		<!-- 특허실용신안 리스트 끝 -->


		<!-- 디자인 리스트 -->
		<%
		if(util.getStr(paramMap.get("searchCd")).equals("2")) {
			int cont2 = (util.getInt(paramMap.get("totalCountDesign")) - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num2 = 1;
				for(HashMap rs:DataDesignList) {
		%>
		<a href="#" onclick="pageViewGo('view','<%=util.getStr(rs.get("SEARCH_DESIGN_IDX"))%>','2')">
		<li>
			<div class="shape">
				<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("10")) { %>
				<img alt="기계/소재" src="/img/board/shape11.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("20")) { %>
				<img alt="전기/전자" src="/img/board/shape12.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("30")) { %>
				<img alt="정보통신" src="/img/board/shape13.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("40")) { %>
				<img alt="화학" src="/img/board/shape14.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("50")) { %>
				<img alt="바이오/의료" src="/img/board/shape15.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("60")) { %>
				<img alt="에너지/자원" src="/img/board/shape16.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("70")) { %>
				<img alt="지식서비스" src="/img/board/shape17.gif" />
				<% } %>
			</div>
			<h3><span class="Bold">
			<% if(util.getStr(rs.get("USE_NM")).length() > 7){ %>
				<%=util.getStr(rs.get("USE_NM")).substring(0, 7)+"...."%>
				<% } else { %>
				<%=util.getStr(rs.get("USE_NM"))%>
			<% } %>
			</span></h3>

			<div class="patent_info">
			<div class="patent_img"><img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+util.getStr(rs.get("IMG_TITLE")))%>" alt="대표이미지" /></div>
			</div>
		</li></a>
			<% if(num2%4 == 0) { %>
			<br />
			<% } num2++; cont2--; } %>

		<%if(util.getStr(paramMap.get("totalCountDesign")).equals("") || util.getStr(paramMap.get("totalCountDesign")).equals(null)) { %>
		<% }  } %>
		<!-- 디자인 리스트 끝 -->



		<!-- 상표 리스트 -->
		<%
		if(util.getStr(paramMap.get("searchCd")).equals("3")) {
			int cont3 = (util.getInt(paramMap.get("totalCountBrand")) - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num3 = 1;
				for(HashMap rs:DataBrandList) {
		%>
		<a href="#" onclick="pageViewGo('view','<%=util.getStr(rs.get("SEARCH_BRAND_IDX"))%>','3')">
		<li>
			<div class="shape">
				<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("10")) { %>
				<img alt="기계/소재" src="/img/board/shape11.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("20")) { %>
				<img alt="전기/전자" src="/img/board/shape12.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("30")) { %>
				<img alt="정보통신" src="/img/board/shape13.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("40")) { %>
				<img alt="화학" src="/img/board/shape14.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("50")) { %>
				<img alt="바이오/의료" src="/img/board/shape15.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("60")) { %>
				<img alt="에너지/자원" src="/img/board/shape16.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("70")) { %>
				<img alt="지식서비스" src="/img/board/shape17.gif" />
				<% } %>
			</div>
			<h3><span class="Bold">
			<% if(util.getStr(rs.get("USE_NM")).length() > 7){ %>
				<%=util.getStr(rs.get("USE_NM")).substring(0, 7)+"...."%>
				<% } else { %>
				<%=util.getStr(rs.get("USE_NM"))%>
			<% } %>
			</span></h3>

			<div class="patent_info">
			<div class="patent_img"><img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+util.getStr(rs.get("IMG_TITLE")))%>" alt="대표이미지" /></div>
			</div>
		</li></a>
			<% if(num3%4 == 0) { %>
			<br />
			<% } num3++; cont3--; } %>

			<%if(util.getStr(paramMap.get("totalCountBrand")).equals("") || util.getStr(paramMap.get("totalCountBrand")).equals(null)) { %>
			<% } } %>
		<!-- 상표 리스트 끝-->



		<!-- 프로그램 리스트 -->
		<%
		if(util.getStr(paramMap.get("searchCd")).equals("4")) {
			int cont4 = (util.getInt(paramMap.get("totalCountProgram")) - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num4 = 1;
				for(HashMap rs:DataProgramList) {
		%>
		<a href="#" onclick="pageViewGo('view','<%=util.getStr(rs.get("SEARCH_PROGRAM_IDX"))%>','4')">
		<li>
			<div class="shape">
				<%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("10")) { %>
				<img alt="기계/소재" src="/img/board/shape11.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("20")) { %>
				<img alt="전기/전자" src="/img/board/shape12.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("30")) { %>
				<img alt="정보통신" src="/img/board/shape13.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("40")) { %>
				<img alt="화학" src="/img/board/shape14.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("50")) { %>
				<img alt="바이오/의료" src="/img/board/shape15.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("60")) { %>
				<img alt="에너지/자원" src="/img/board/shape16.gif" />
				<% } %> <%if(util.getStr(rs.get("TCHNLGY_M_CL")).equals("70")) { %>
				<img alt="지식서비스" src="/img/board/shape17.gif" />
				<% } %>
			</div>
			<h3><span class="Bold">
			<% if(util.getStr(rs.get("USE_NM")).length() > 7){ %>
				<%=util.getStr(rs.get("USE_NM")).substring(0, 7)+"...."%>
				<% } else { %>
				<%=util.getStr(rs.get("USE_NM"))%>
			<% } %>
			</span></h3>

			<div class="patent_info">
			<div class="patent_img"><img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+util.getStr(rs.get("IMG_TITLE")))%>" alt="대표이미지" /></div>
			</div>
		</li></a>
			<% if(num4%4 == 0) { %>
			<br />
			<% } num4++; cont4--; } %>

			<%if(util.getStr(paramMap.get("totalCountProgram")).equals("") || util.getStr(paramMap.get("totalCountProgram")).equals(null)) { %>
			<% } } %>
		<!-- 프로그램 리스트 끝-->



		<!-- 노하우 리스트 -->
		<%
		if(util.getStr(paramMap.get("searchCd")).equals("5")) {
			int cont5 = (util.getInt(paramMap.get("totalCountKnowHow")) - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num5 = 1;
				for(HashMap rs:DataKnowHowList) {
		%>
		<a href="#" onclick="pageViewGo('view','<%=util.getStr(rs.get("SEARCH_KNOWHOW_IDX"))%>','5')">
		<li>
			<div class="shape">
			<%if(util.getStr(rs.get("BEFORE_INFO")).equals("F")) { %>
			<img alt="유상이전" src="/img/board/shape23.gif" />
			<% } %> <%if(util.getStr(rs.get("BEFORE_INFO")).equals("D")) { %>
			<img alt="무상이전" src="/img/board/shape24.gif" />
			<% } %>

			</div>
			<h3><span class="Bold">
			<% if(util.getStr(rs.get("TCHNLGY_NM")).length() > 7){ %>
				<%=util.getStr(rs.get("TCHNLGY_NM")).substring(0, 7)+"...."%>
				<% } else { %>
				<%=util.getStr(rs.get("TCHNLGY_NM"))%>
			<% } %>
			</span></h3>

			<div class="patent_info">
			<div class="patent_img"><img src="<%=(util.getStr(rs.get("IMG_FILE_ID")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(rs.get("IMG_FILE_PATH"))+util.getStr(rs.get("IMG_TITLE")))%>" alt="대표이미지" /></div>
			</div>
		</li></a>
			<% if(num5%4 == 0) { %>
			<br />
			<% } num5++; cont5--; } %>

			<%if(util.getStr(paramMap.get("totalCountKnowHow")).equals("") || util.getStr(paramMap.get("totalCountKnowHow")).equals(null)) { %>
			<% } } %>
		<!-- 노하우 리스트 끝-->

	</ul>

	</div>
	<!--PatentBox01 E-->

</div>
<!--Patent_listWrap E-->

</form>

<!--특허검색 결과 E-->
<%=util.getPaging(staticVO, nowPage)%>
<% } %>



<script type="text/javascript">
//<![CDATA[
	$(".paging").children().click(function() {
		$("#mode").val("searchMore");
		$("#searchForm").submit();
	});

function pageSearchGo(){
	$('#mode').val('search');
	$('#nowPage').val('1');
	if($('#searchCd').val() == "all") {
		$('#mode').val('search');
	}else {
		$('#mode').val('searchMore');
	}
	$('#searchForm').submit();
}

function pageViewGo(mode,idx,searchCd){
	$('#mode').val('view');
	$('#searchId').val(idx);
	$('#searchCd').val(searchCd);
	$('#searchForm').submit();
}

function pageListGo(listMode){
	$('#mode').val('searchMore');
	$('#listMode').val(listMode);
	$('#searchForm').submit();
}

function orderTab(searchCd){
	if(searchCd == 'all'){
		$('#mode').val('search');
		$('#listMode').val("patentImageList");
	}
	else {
		$('#mode').val('searchMore');
		$('#listMode').val("moreImageList");
	}
	$('#nowPage').val('1');
	$('#searchCd').val(searchCd);
	$('#searchForm').submit();
}

<%if(!util.getStr(paramMap.get("reDeth1")).equals(null) && !util.getStr(paramMap.get("reDeth1")).equals("")) { %>
standardDeth1('reDeth2<%=scCnt %>');
<% } %>
function standardDeth1(mode){
	var result = "";
	var mode = mode;
	var name = mode.substr(0,2);
	var name2 = mode.substring(7,8);
	var tchnlgyS = "${paramMap.reDeth2}";
	$('#mCode').val($('#reDeth1'+name2).val());
	if(name == "re"){
		var deth3 = $('#reDeth1'+name2).val();
	}else if(name == "ev"){
		var deth3 = $('#evDeth1'+name2).val();
	}else if(name == "co"){
		var deth3 = $('#coDeth1'+name2).val();
	}
 	$.ajax({
         type: "POST",
         data : {
        	 deth3 : deth3
         },
         url : '/sys/dethCheck.do',
         dataType : 'json',
         success : function(data){
        	 $('#'+mode).html("");
        	result += "<option value=''>선택하세요.</option>";
        	for(i=0; i<data.cnt; i++){
        		if(tchnlgyS == data.dataList[i].CODE){
        			result += "<option value=\""+data.dataList[i].CODE+"\" id=deth"+i+" selected>"+data.dataList[i].NAME+"</option>";
        		} else {
					result += "<option value=\""+data.dataList[i].CODE+"\" id=deth"+i+">"+data.dataList[i].NAME+"</option>";
        		}
        	}
        	$('#'+mode).append(result);
         }
	});
}

//]]>
</script>