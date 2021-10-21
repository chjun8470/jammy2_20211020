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
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	HashMap<String, String> e1t1tuu1 = request.getAttribute("e1t1tuu1") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tuu1");
	HashMap<String, String> e1t1tuu2 = request.getAttribute("e1t1tuu2") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tuu2");
	HashMap<String, String> e1t1tuu3 = request.getAttribute("e1t1tuu3") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tuu3");

	HashMap<String, String> e1t2tuu1 = request.getAttribute("e1t2tuu1") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tuu1");
	HashMap<String, String> e1t2tuu2 = request.getAttribute("e1t2tuu2") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tuu2");
	HashMap<String, String> e1t2tuu3 = request.getAttribute("e1t2tuu3") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tuu3");

	HashMap<String, String> e2t1tuu1 = request.getAttribute("e2t1tuu1") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tuu1");
	HashMap<String, String> e2t1tuu2 = request.getAttribute("e2t1tuu2") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tuu2");
	HashMap<String, String> e2t1tuu3 = request.getAttribute("e2t1tuu3") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tuu3");

	HashMap<String, String> e2t2tuu1 = request.getAttribute("e2t2tuu1") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tuu1");
	HashMap<String, String> e2t2tuu2 = request.getAttribute("e2t2tuu2") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tuu2");
	HashMap<String, String> e2t2tuu3 = request.getAttribute("e2t2tuu3") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tuu3");

	HashMap<String, String> e1t1tiu01 = request.getAttribute("e1t1tiu01") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tiu01");
	HashMap<String, String> e1t1tiu02 = request.getAttribute("e1t1tiu02") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tiu02");
	HashMap<String, String> e1t1tiu03 = request.getAttribute("e1t1tiu03") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tiu03");
	HashMap<String, String> e1t1tiu04 = request.getAttribute("e1t1tiu04") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t1tiu04");

	HashMap<String, String> e1t2tiu01 = request.getAttribute("e1t2tiu01") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tiu01");
	HashMap<String, String> e1t2tiu02 = request.getAttribute("e1t2tiu02") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tiu02");
	HashMap<String, String> e1t2tiu03 = request.getAttribute("e1t2tiu03") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tiu03");
	HashMap<String, String> e1t2tiu04 = request.getAttribute("e1t2tiu04") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e1t2tiu04");

	HashMap<String, String> e2t1tiu01 = request.getAttribute("e2t1tiu01") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tiu01");
	HashMap<String, String> e2t1tiu02 = request.getAttribute("e2t1tiu02") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tiu02");
	HashMap<String, String> e2t1tiu03 = request.getAttribute("e2t1tiu03") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tiu03");
	HashMap<String, String> e2t1tiu04 = request.getAttribute("e2t1tiu04") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t1tiu04");

	HashMap<String, String> e2t2tiu01 = request.getAttribute("e2t2tiu01") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tiu01");
	HashMap<String, String> e2t2tiu02 = request.getAttribute("e2t2tiu02") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tiu02");
	HashMap<String, String> e2t2tiu03 = request.getAttribute("e2t2tiu03") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tiu03");
	HashMap<String, String> e2t2tiu04 = request.getAttribute("e2t2tiu04") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("e2t2tiu04");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>

<style type="text/css">
	table td p {cursor: pointer;}
</style>
<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_equ_status.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "equCd" id = "equCd" />
			<input type="hidden" name = "takeCd" id = "takeCd" />
			<input type="hidden" name = "scope" id = "scope" />
			<input type="hidden" name = "disUse" id = "disUse" />
			<!-- bbs-top e -->
</form>
	<div>
		<!-- skin_basic_list s -->
					<span><b style="color:red">* 해당 장비수를 클릭하시면 상세보기 페이지로 이동합니다.</b></span>
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">

			</colgroup>

			<thead>
				<tr>
					<th scope="col" rowspan="5" colspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">구분</th>
					<th scope="col" colspan="3" style = "border-right: solid 1px #e0e0e0;">활용범위</th>
					<th scope="col" colspan="4" style = "border-right: solid 1px #e0e0e0; background-color: #B2EBF4;">장비상태</th>
					<th scope="col" rowspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">전체</th>
				</tr>
				<tr>
					<th scope="col">단독<br>활용</th>
					<th scope="col">공동<br>활용<br>허용</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">공동<br>활용<br>서비스</th>
					<th scope="col" style = "background-color: #B2EBF4;">활용</th>
					<th scope="col" style = "background-color: #B2EBF4;">저활용</th>
					<th scope="col" style = "background-color: #B2EBF4;">유휴</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0; background-color: #B2EBF4;">불용<br>(처분)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="col" rowspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">구매<br/>(구축비)</th>
					<!-- <td scope="col"></td> -->
					<td scope="col">
						<p class="scope111"><%=util.getStr(String.valueOf(e1t1tuu1.get("CNT"))) %></p>
						<p class="scope111">(<%=util.getNumKorUnit(String.valueOf(e1t1tuu1.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="scope112"><%=util.getStr(String.valueOf(e1t1tuu2.get("CNT"))) %></p>
						<p class="scope112">(<%=util.getNumKorUnit(String.valueOf(e1t1tuu2.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="scope113"><%=util.getStr(String.valueOf(e1t1tuu3.get("CNT"))) %></p>
						<p class="scope113">(<%=util.getNumKorUnit(String.valueOf(e1t1tuu3.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse111"><%=util.getStr(String.valueOf(e1t1tiu01.get("CNT"))) %></p>
						<p class="disUse111">(<%=util.getNumKorUnit(String.valueOf(e1t1tiu01.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse112"><%=util.getStr(String.valueOf(e1t1tiu02.get("CNT"))) %></p>
						<p class="disUse112">(<%=util.getNumKorUnit(String.valueOf(e1t1tiu02.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse113"><%=util.getStr(String.valueOf(e1t1tiu03.get("CNT"))) %></p>
						<p class="disUse113">(<%=util.getNumKorUnit(String.valueOf(e1t1tiu03.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="disUse114"><%=util.getStr(String.valueOf(e1t1tiu04.get("CNT"))) %></p>
						<p class="disUse114">(<%=util.getNumKorUnit(String.valueOf(e1t1tiu04.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="sum11"><%=util.getInt(String.valueOf(e1t1tuu1.get("CNT")))+util.getInt(String.valueOf(e1t1tuu2.get("CNT")))+util.getInt(String.valueOf(e1t1tuu3.get("CNT")))/* +util.getInt(String.valueOf(e1t1tiu01.get("CNT")))+util.getInt(String.valueOf(e1t1tiu02.get("CNT")))+util.getInt(String.valueOf(e1t1tiu03.get("CNT")))+util.getInt(String.valueOf(e1t1tiu04.get("CNT"))) */ %></p>
						<p class="sum11">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t1tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t1tuu3.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
				</tr>
				<tr>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">개발<br/>(구축비)</th>
					<!-- <td scope="col"></td> -->
					<td scope="col">
						<p class="scope121"><%=util.getStr(String.valueOf(e1t2tuu1.get("CNT"))) %></p>
						<p class="scope121">(<%=util.getNumKorUnit(String.valueOf(e1t2tuu1.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="scope122"><%=util.getStr(String.valueOf(e1t2tuu2.get("CNT"))) %></p>
						<p class="scope122">(<%=util.getNumKorUnit(String.valueOf(e1t2tuu2.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="scope123"><%=util.getStr(String.valueOf(e1t2tuu3.get("CNT"))) %></p>
						<p class="scope123">(<%=util.getNumKorUnit(String.valueOf(e1t2tuu3.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse121"><%=util.getStr(String.valueOf(e1t2tiu01.get("CNT"))) %></p>
						<p class="disUse121">(<%=util.getNumKorUnit(String.valueOf(e1t2tiu01.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse122"><%=util.getStr(String.valueOf(e1t2tiu02.get("CNT"))) %></p>
						<p class="disUse122">(<%=util.getNumKorUnit(String.valueOf(e1t2tiu02.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse123"><%=util.getStr(String.valueOf(e1t2tiu03.get("CNT"))) %></p>
						<p class="disUse123">(<%=util.getNumKorUnit(String.valueOf(e1t2tiu03.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="disUse124"><%=util.getStr(String.valueOf(e1t2tiu04.get("CNT"))) %></p>
						<p class="disUse124">(<%=util.getNumKorUnit(String.valueOf(e1t2tiu04.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="sum12"><%=util.getInt(String.valueOf(e1t2tuu1.get("CNT")))+util.getInt(String.valueOf(e1t2tuu2.get("CNT")))+util.getInt(String.valueOf(e1t2tuu3.get("CNT")))/* +util.getInt(String.valueOf(e1t2tiu01.get("CNT")))+util.getInt(String.valueOf(e1t2tiu02.get("CNT")))+util.getInt(String.valueOf(e1t2tiu03.get("CNT")))+util.getInt(String.valueOf(e1t2tiu04.get("CNT"))) */ %></p>
						<p class="sum12">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t2tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu3.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
				</tr>
				<tr>
					<th scope="col" rowspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">시설</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">일반<br/>(구축비)</th>
					<td scope="col">
						<p class="scope211"><%=util.getStr(String.valueOf(e2t1tuu1.get("CNT"))) %></p>
						<p class="scope211">(<%=util.getNumKorUnit(String.valueOf(e2t1tuu1.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="scope212"><%=util.getStr(String.valueOf(e2t1tuu2.get("CNT"))) %></p>
						<p class="scope212">(<%=util.getNumKorUnit(String.valueOf(e2t1tuu2.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="scope213"><%=util.getStr(String.valueOf(e2t1tuu3.get("CNT"))) %></p>
						<p class="scope213">(<%=util.getNumKorUnit(String.valueOf(e2t1tuu3.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse211"><%=util.getStr(String.valueOf(e2t1tiu01.get("CNT"))) %></p>
						<p class="disUse211">(<%=util.getNumKorUnit(String.valueOf(e2t1tiu01.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse212"><%=util.getStr(String.valueOf(e2t1tiu02.get("CNT"))) %></p>
						<p class="disUse212">(<%=util.getNumKorUnit(String.valueOf(e2t1tiu02.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse213"><%=util.getStr(String.valueOf(e2t1tiu03.get("CNT"))) %></p>
						<p class="disUse213">(<%=util.getNumKorUnit(String.valueOf(e2t1tiu03.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="disUse214"><%=util.getStr(String.valueOf(e2t1tiu04.get("CNT"))) %></p>
						<p class="disUse214">(<%=util.getNumKorUnit(String.valueOf(e2t1tiu04.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="sum21"><%=util.getInt(String.valueOf(e2t1tuu1.get("CNT")))+util.getInt(String.valueOf(e2t1tuu2.get("CNT")))+util.getInt(String.valueOf(e2t1tuu3.get("CNT")))/* +util.getInt(String.valueOf(e2t1tiu01.get("CNT")))+util.getInt(String.valueOf(e2t1tiu02.get("CNT")))+util.getInt(String.valueOf(e2t1tiu03.get("CNT")))+util.getInt(String.valueOf(e2t1tiu04.get("CNT")))  */%></p>
						<p class="sum21">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e2t1tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu3.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
				</tr>
				<tr>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">대형<br/>(구축비)</th>
					<!-- <td scope="col"></td> -->
					<td scope="col">
						<p class="scope221"><%=util.getStr(String.valueOf(e2t2tuu1.get("CNT"))) %></p>
						<p class="scope221">(<%=util.getNumKorUnit(String.valueOf(e2t2tuu1.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="scope222"><%=util.getStr(String.valueOf(e2t2tuu2.get("CNT"))) %></p>
						<p class="scope222">(<%=util.getNumKorUnit(String.valueOf(e2t2tuu2.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="scope223"><%=util.getStr(String.valueOf(e2t2tuu3.get("CNT"))) %></p>
						<p class="scope223">(<%=util.getNumKorUnit(String.valueOf(e2t2tuu3.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse221"><%=util.getStr(String.valueOf(e2t2tiu01.get("CNT"))) %></p>
						<p class="disUse221">(<%=util.getNumKorUnit(String.valueOf(e2t2tiu01.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse222"><%=util.getStr(String.valueOf(e2t2tiu02.get("CNT"))) %></p>
						<p class="disUse222">(<%=util.getNumKorUnit(String.valueOf(e2t2tiu02.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col">
						<p class="disUse223"><%=util.getStr(String.valueOf(e2t2tiu03.get("CNT"))) %></p>
						<p class="disUse223">(<%=util.getNumKorUnit(String.valueOf(e2t2tiu03.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="disUse224"><%=util.getStr(String.valueOf(e2t2tiu04.get("CNT"))) %></p>
						<p class="disUse224">(<%=util.getNumKorUnit(String.valueOf(e2t2tiu04.get("TAKE_PRC"))) %>원)</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="sum22"><%=util.getInt(String.valueOf(e2t2tuu1.get("CNT")))+util.getInt(String.valueOf(e2t2tuu2.get("CNT")))+util.getInt(String.valueOf(e2t2tuu3.get("CNT")))/* +util.getInt(String.valueOf(e2t2tiu01.get("CNT")))+util.getInt(String.valueOf(e2t2tiu02.get("CNT")))+util.getInt(String.valueOf(e2t2tiu03.get("CNT")))+util.getInt(String.valueOf(e2t2tiu04.get("CNT"))) */ %></p>
						<p class="sum22">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e2t2tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu3.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
				</tr>
				<tr>
					<th scope="col" colspan="2"  style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">합계<br/>(구축비)</th>
					<td scope="col">
						<p class="scope1"><%=util.getInt(String.valueOf(e1t1tuu1.get("CNT")))
						+util.getInt(String.valueOf(e1t2tuu1.get("CNT")))
						+util.getInt(String.valueOf(e2t1tuu1.get("CNT")))
						+util.getInt(String.valueOf(e2t2tuu1.get("CNT")))
						%></p>
						<p class="scope1">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu1.get("TAKE_PRC"))))
							%>원)
						</p>

					</td>
					<td scope="col">
						<p class="scope2"><%=util.getInt(String.valueOf(e1t1tuu2.get("CNT")))
						+util.getInt(String.valueOf(e1t2tuu2.get("CNT")))
						+util.getInt(String.valueOf(e2t1tuu2.get("CNT")))
						+util.getInt(String.valueOf(e2t2tuu2.get("CNT")))
						%></p>
						<p class="scope2">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu2.get("TAKE_PRC")))
								+Double.parseDouble(String.valueOf(e2t1tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu2.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="scope3"><%=util.getInt(String.valueOf(e1t1tuu3.get("CNT")))
						+util.getInt(String.valueOf(e1t2tuu3.get("CNT")))
						+util.getInt(String.valueOf(e2t1tuu3.get("CNT")))
						+util.getInt(String.valueOf(e2t2tuu3.get("CNT")))
						%></p>
						<p class="scope3">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tuu3.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu3.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu3.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu3.get("TAKE_PRC"))))
								%>원)
						</p>
					</td>
					<td scope="col">
						<p class="disUse1"><%=util.getInt(String.valueOf(e1t1tiu01.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu01.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu01.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu01.get("CNT")))
						%></p>
						<p class="disUse1">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tiu01.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tiu01.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tiu01.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tiu01.get("TAKE_PRC"))))
								%>원)
						</p>
					</td>
					<td scope="col">
						<p class="disUse2"><%=util.getInt(String.valueOf(e1t1tiu02.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu02.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu02.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu02.get("CNT")))
						%></p>
						<p class="disUse2">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tiu02.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tiu02.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tiu02.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tiu02.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
					<td scope="col">
						<p class="disUse3"><%=util.getInt(String.valueOf(e1t1tiu03.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu03.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu03.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu03.get("CNT")))
						%></p>
						<p class="disUse3">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tiu03.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tiu03.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tiu03.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tiu03.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="disUse4"><%=util.getInt(String.valueOf(e1t1tiu04.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu04.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu04.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu04.get("CNT")))
						%></p>
						<p class="disUse4">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tiu04.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tiu04.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tiu04.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tiu04.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;">
						<p class="all">
						<%=
						 util.getInt(String.valueOf(e1t1tuu1.get("CNT")))
						+util.getInt(String.valueOf(e1t2tuu1.get("CNT")))
						+util.getInt(String.valueOf(e2t1tuu1.get("CNT")))
						+util.getInt(String.valueOf(e2t2tuu1.get("CNT")))

						+util.getInt(String.valueOf(e1t1tuu2.get("CNT")))
						+util.getInt(String.valueOf(e1t2tuu2.get("CNT")))
						+util.getInt(String.valueOf(e2t1tuu2.get("CNT")))
						+util.getInt(String.valueOf(e2t2tuu2.get("CNT")))

						+util.getInt(String.valueOf(e1t1tuu3.get("CNT")))
						+util.getInt(String.valueOf(e1t2tuu3.get("CNT")))
						+util.getInt(String.valueOf(e2t1tuu3.get("CNT")))
						+util.getInt(String.valueOf(e2t2tuu3.get("CNT")))
						/*
						+util.getInt(String.valueOf(e1t1tiu01.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu01.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu01.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu01.get("CNT")))

						+util.getInt(String.valueOf(e1t1tiu02.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu02.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu02.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu02.get("CNT")))

						+util.getInt(String.valueOf(e1t1tiu03.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu03.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu03.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu03.get("CNT")))

						+util.getInt(String.valueOf(e1t1tiu04.get("CNT")))
						+util.getInt(String.valueOf(e1t2tiu04.get("CNT")))
						+util.getInt(String.valueOf(e2t1tiu04.get("CNT")))
						+util.getInt(String.valueOf(e2t2tiu04.get("CNT")))
						*/
						%></p>
						<p class="all">
							(<%=util.getNumKorUnit(
								Double.parseDouble(String.valueOf(e1t1tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu1.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu1.get("TAKE_PRC")))

								+ Double.parseDouble(String.valueOf(e1t1tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu2.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu2.get("TAKE_PRC")))

								+ Double.parseDouble(String.valueOf(e1t1tuu3.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e1t2tuu3.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t1tuu3.get("TAKE_PRC")))
								+ Double.parseDouble(String.valueOf(e2t2tuu3.get("TAKE_PRC"))))
							%>원)
						</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<script type="text/javascript">
	$(".scope111").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("1");
		$("#disUse").val("");
	});
	$(".scope112").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("2");
		$("#disUse").val("");
	});
	$(".scope113").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("3");
		$("#disUse").val("");
	});

	$(".scope121").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("1");
		$("#disUse").val("");
	});
	$(".scope122").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("2");
		$("#disUse").val("");
	});
	$(".scope123").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("3");
		$("#disUse").val("");
	});

	$(".scope1").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("1");
		$("#disUse").val("");
	});
	$(".scope2").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("2");
		$("#disUse").val("");
	});
	$(".scope3").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("3");
		$("#disUse").val("");
	});


	$(".scope211").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("1");
		$("#disUse").val("");
	});
	$(".scope212").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("2");
		$("#disUse").val("");
	});
	$(".scope213").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("3");
		$("#disUse").val("");
	});

	$(".scope221").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("1");
		$("#disUse").val("");
	});
	$(".scope222").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("2");
		$("#disUse").val("");
	});
	$(".scope223").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("3");
		$("#disUse").val("");
	});

	$(".disUse111").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("01");
	});
	$(".disUse112").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("02");
	});
	$(".disUse113").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("03");
	});
	$(".disUse114").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("04");
	});

	$(".disUse121").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("01");
	});
	$(".disUse122").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("02");
	});
	$(".disUse123").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("03");
	});
	$(".disUse124").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("04");
	});

	$(".disUse211").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("01");
	});
	$(".disUse212").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("02");
	});
	$(".disUse213").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("03");
	});
	$(".disUse214").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("04");
	});

	$(".disUse221").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("01");
	});
	$(".disUse222").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("02");
	});
	$(".disUse223").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("03");
	});
	$(".disUse224").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("04");
	});

	$(".disUse1").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("");
		$("#disUse").val("01");
	});
	$(".disUse2").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("");
		$("#disUse").val("02");
	});
	$(".disUse3").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("");
		$("#disUse").val("03");
	});
	$(".disUse4").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("");
		$("#disUse").val("04");
	});

	$(".sum11").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("");
	});
	$(".sum12").click(function() {
		$("#equCd").val("1");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("");
	});
	$(".sum21").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("1");
		$("#scope").val("");
		$("#disUse").val("");
	});
	$(".sum22").click(function() {
		$("#equCd").val("2");
		$("#takeCd").val("2");
		$("#scope").val("");
		$("#disUse").val("");
	});

	$(".all").click(function() {
		$("#equCd").val("");
		$("#takeCd").val("");
		$("#scope").val("");
		$("#disUse").val("");
	});


    $("td p").click(function() {
    	$("#mode").val("list");
    	$("#searchForm").submit();
    });

</script>


<!--// bo_btn -->
