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
		request.setCharacterEncoding("utf-8");
	ComUtil util=new ComUtil();

	HashMap<String, Object> paramMap=request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");

	String m=util.getStr(paramMap.get("m"));
	String mode=util.getStr(paramMap.get("mode"));
%>


<!--특허검색 결과 S-->
<!--Patent_srchWrap S-->
<div class="Patent_srchWrap">

<div class="tit_p_srch"><img src="/img/board/tit_srch.png" alt="지식재산 검색" /></div>
	<form action="sub.do?m=57" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" 	name="mode" 			id="mode" 			value="<%=mode%>" />
		<input type="hidden" 	name="searchCd" 		id="searchCd" 		value="all" />
		<input type="hidden" 	name="searchCdText" 	id="searchCdText" 	value="전체" />

		<!--Patent_search S-->
		<div class="Patent_search">

			<div class="p_srchBox">
				<div class="nctg" data-mode="press" >
					<a href="#" class="btn_nctg" onclick="sele(); return false;" id="sele">전체</a>
					<ul class="cpress_lst" id="seleMenu" style="display:none">
						<li class="on"><a href="#ctAll" onclick="return false;">전체</a></li>
						<li><a href="#ct1" onclick="return false;">특허실용신안</a></li>
						<li><a href="#ct2" onclick="return false;">디자인</a></li>
						<li><a href="#ct3" onclick="return false;">상표</a></li>
						<li><a href="#ct4" onclick="return false;">프로그램</a></li>
						<li><a href="#ct5" onclick="return false;">노하우</a></li>
					</ul>
				</div>

				<div class="p_srch">
					<input id="searchWord" class="p_srch_txt" name="searchWord" type="text" title="검색단어입력" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
					<input type="image" src="/img/board/btn_ico_srch2.png" class="p_go_btn" alt="바로가기" onclick="pageSearchGo()" />
				</div>
			</div>

		</div>
		<!--Patent_search E-->

	</form>

<div class="txt_p_info"><img src="/img/board/img_srch_info.png" alt="지식재산 정보은행의 통합검색 서비스입니다. 원하시는 지식재산의 이름을 입력하여 주십시오." /></div>

</div>
<!--Patent_srchWrap E-->
<!--특허검색 결과 E-->








<%--
	<!--list_top S-->
	<div class="list_top">

		<form action="?<%=m%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="m" id="m" value="57" />

		<div class="publist_top_wrap">

		<div class="b_srchBox">
			<select name="searchCd" id="searchCd" class="b_select" style="height: 24px;width:15%;">
				<option value="all" <%if(util.getStr(paramMap.get("searchCd")).equals("all")) { %> selected="selected" <% } %>>전체</option>
				<option value="1" <%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %> selected="selected" <% } %>>특허실용신안</option>
				<option value="2" <%if(util.getStr(paramMap.get("searchCd")).equals("2")) { %> selected="selected" <% } %>>디자인</option>
				<option value="3" <%if(util.getStr(paramMap.get("searchCd")).equals("3")) { %> selected="selected" <% } %>>상표</option>
				<option value="4" <%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %> selected="selected" <% } %>>프로그램</option>
				<option value="5" <%if(util.getStr(paramMap.get("searchCd")).equals("5")) { %> selected="selected" <% } %>>노하우</option>
			</select>
			<div class="b_srch">
				<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord")) %>" style="width:75%;" />
				<!-- 검색버튼 -->
				<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" alt="바로가기" value="검색" onclick="pageSearchGo()" />
			</div>
		</div>

	</div>
	</form>
</div> --%>

<script type="text/javascript">
//<![CDATA[
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

function sele(){
	$('.cpress_lst').show();
}

$(document).ready(function() {
	$("#seleMenu li a").click(function(){
		$("#sele").text($(this).text());
		$("#seleMenu li").removeClass();
		$(this).parent().addClass("on");
		$('.cpress_lst').hide();

		if($(this).parent().text()=="전체"){
			$('#searchCd').val('all');
			$('#searchCdText').val('전체');

		}if($(this).parent().text()=="특허실용신안"){
			$('#searchCd').val('1');
			$('#searchCdText').val('특허실용신안');

		}if($(this).parent().text()=="디자인"){
			$('#searchCd').val('2');
			$('#searchCdText').val('디자인');

		}if($(this).parent().text()=="상표"){
			$('#searchCd').val('3');
			$('#searchCdText').val('상표');

		}if($(this).parent().text()=="프로그램"){
			$('#searchCd').val('4');
			$('#searchCdText').val('프로그램');

		}if($(this).parent().text()=="노하우"){
			$('#searchCd').val('5');
			$('#searchCdText').val('노하우');
		}

	})
});
//]]>

</script>