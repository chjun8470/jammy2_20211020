<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<%@ page import="java.util.*"%>
<%@ page import="egovframework.jammy2.site.service.*"%>
<%@ page import="egovframework.jammy2.popup.service.PopupManager"%>
<%@ page import="egovframework.jammy2.popup.service.PopupVO"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%
	ComUtil util = new ComUtil();
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
	PopupManager pm = new PopupManager(request);

	// 팝업존 리스트
	List<PopupVO> popupzoneList = pm.getPopupList(siteInfoVO.getSiteId(), "POPUPZONE");

	List<PopupVO> mainvisualList = pm.getPopupList(siteInfoVO.getSiteId(), "MAIN_VISUAL");


%>


<c:set var="popupzoneList" value="<%=popupzoneList%>" />
<c:set var="mainvisualList" value="<%=mainvisualList%>" />



<!--MainVIsualWrap S-->
<div class="MainVIsualWrap">

<p style="text-indent:-9999px; width:200px; float:left">Jeonnam Intellectual Property BANK</p>

<!--MainVisualBox S-->
<div class="MainVisualBox">

<div class="VisualTxtBox">
<div class="VTxt01"><img src="/img/jipbank/main3/VTxt01.png" alt="지식재산 창출에서 이전·기술사업화까지" /></div>
<div class="VTxt02"><img src="/img/jipbank/main3/VTxt02.png" alt="지식재산정보은행이 지원합니다" /></div>
<div class="VTxt03"><img src="/img/jipbank/main3/VTxt03.png" alt="Jeonnam Intellectual Property Bank" /></div>

<div class="VisualSrchBox">
<form action="/jipbank/sub.do?m=57&listMode=patentBlogList&searchCd=all&searchSelect=" method="post" name="searchBox">
<input type="text" class="SrchForm" name="searchSelectText"/><button class="Btn_VSrch" style="cursor:pointer;" onclick="sybmit()">검색</button>
<form>
</div>

</div>

<!--QuickLink S-->
<div class="QuickLink">

<!--QuickBox S-->
<ul class="QuickBox">
<li><a href="/jipbank/sub.do?m=26"><img src="/img/jipbank/main3/btn_Quick01.png" alt="지식재산등록기관" /></a></li>
<li><a href="/jipbank/sub.do?m=82"><img src="/img/jipbank/main3/btn_Quick02.png" alt="지식재산통계" /></a></li>
<li><a href="http://www.kipris.or.kr/khome/main.jsp" target="_blank"><img src="/img/jipbank/main3/btn_Quick03.png" alt="키프리스 검색" /></a></li>

<li><a href="/jipbank/sub.do?m=76"><img src="/img/jipbank/main3/btn_Quick04.png" alt="성과확산" /></a></li>
<li><a href="/jipbank/sub.do?m=43"><img src="/img/jipbank/main3/btn_Quick05.png" alt="전문가정보" /></a></li>
<li><a href="/jipbank/sub.do?m=58"><img src="/img/jipbank/main3/btn_Quick06.png" alt="정책이슈" /></a></li>

<li><a href="/jipbank/sub.do?m=71"><img src="/img/jipbank/main3/btn_Quick07.png" alt="커뮤니티" /></a></li>
<li><a href="/jipbank/sub.do?m=64"><img src="/img/jipbank/main3/btn_Quick08.png" alt="기술이전상담" /></a></li>
<li><a href="/jipbank/sub.do?m=67"><img src="/img/jipbank/main3/btn_Quick09.png" alt="창업상담" /></a></li>
</ul>
<!--QuickBox E-->

<!--StatusBox S-->
<div class="StatusBox">

<div class="StatusTit"><img src="/img/jipbank/main3/tit_status.png" alt="등록기술" /></div>
<div class="StatusTotal">총 <span id="strTchnlgyTotalCnt"></span>건</div>

<div class="CategoryBox">

<dl class="Category01">
<dt>기계/소재</dt> <dd id="strMchnCnt">0</dd>
<dt>정보통신</dt> <dd id="strIrmcCnt">0</dd>
<dt>바이오/의료</dt> <dd id="strBioCnt">0</dd>
<dt>지식서비스</dt> <dd id="strKnwldgCnt">0</dd>
</dl>

<dl class="Category02">
<dt>전기/전자</dt> <dd id="strElctyCnt">0</dd>
<dt>화학</dt> <dd id="strChmstryCnt">0</dd>
<dt>에너지/지원</dt> <dd id="strEnergyCnt">0</dd>
<dt>미분류</dt> <dd id="strNowhowCnt">0</dd>
</dl>

</div>

</div>
<!--StatusBox E-->

</div>
<!--QuickLink E-->

</div>
<!--MainVisualBox E-->

</div>
<!--MainVIsualWrap E-->



<!--MainTabWrap S-->
<div class="MainTabWrap">

<div class="TabMenuWrap">
<ul>
<li class="tab01"><a href="javascript:SearchShow(1)" id="SearchTab01" class="on">이전기술검색</a></li>
<li class="tab02"><a href="javascript:SearchShow(2)" id="SearchTab02">기술분류별</a></li>
<!-- <li class="tab03"><a href="javascript:SearchShow(3)" id="SearchTab03" >연구기관별</a></li> -->
<li class="tab04"><a href="javascript:SearchShow(4)" id="SearchTab04" >지역별</a></li>
</ul>
</div>

<!--TabBtnWrap S-->
<div class="TabBtnWrap">

<!--TabList01 S-->
<div id="TabList01" >
<div class="TabBox01">
<ul>
<li class="side"><div class="TabTit01">Technology</div>
                 <div class="TabTit02"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">기술 검색</a></div>
</li>
<div class="TabBox01_gap"><img src="/img/jipbank/main3/gap_MainTab1.gif"/></div>
<li><div class="TabTit01">Patent</div>
    <div class="TabTit03"><a href="/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=1&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">특허·실용신안 검색</a></div>
</li>
<div class="TabBox01_gap"><img src="/img/jipbank/main3/gap_MainTab1.gif"/></div>
<li><div class="TabTit01">Design</div>
    <div class="TabTit02"><a href="/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=2&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">디자인 검색</a></div>
</li>
<div class="TabBox01_gap"><img src="/img/jipbank/main3/gap_MainTab1.gif"/></div>
<li><div class="TabTit01">Brand</div>
    <div class="TabTit02"><a href="/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=3&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">상표 검색</a></div>
</li>
<div class="TabBox01_gap"><img src="/img/jipbank/main3/gap_MainTab1.gif"/></div>
<li><div class="TabTit01">Program</div>
    <div class="TabTit02"><a href="/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=4&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">프로그램 검색</a></div>
</li>
<div class="TabBox01_gap"><img src="/img/jipbank/main3/gap_MainTab1.gif"/></div>
<li class="side"><div class="TabTit01">JIPBANK</div>
                 <div class="TabTit02"><a href="/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=5&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">미분류 검색</a></div>
</li>
</ul>
</div>
</div>
<!--TabList01 E-->



<!--TabList02 S-->
<div id="TabList02" style="display:none">
<div class="TabBox02">
<ul>
<li class="side"><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=10&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon1.png" /></a></div>
                 <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=10&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">기계/소재</a></div></li>

<div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=20&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon2.png" /></a></div>
    <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=20&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">전기/전자</a></div></li>

<div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=30&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon3.png" /></a></div>
    <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=30&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">정보통신</a></div></li>

    <div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=40&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon4.png" /></a></div>
    <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=40&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">화학</a></div></li>

    <div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=50&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon5.png" /></a></div>
    <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=50&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">바이오/의료</a></div></li>

    <div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=60&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon6.png" /></a></div>
    <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=60&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">에너지/자원</a></div></li>

    <div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=70&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon7.png" /></a></div>
    <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=70&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">지식서비스</a></div></li>

    <div class="TabBox02_gap"><img src="/img/jipbank/main3/gap_MainTab2.gif"/></div>

<li class="side"><div class="Tab02_icon"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=80&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText="><img src="/img/jipbank/main3/MainTab2_icon8.png" /></a></div>
                 <div class="Tab02Tit"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=80&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">미분류</a></div></li>

</ul>
</div>
</div>
<!--TabList02 E-->




<!--TabList03 S-->
<div id="TabList03" style="display:none">
<div class="TabBox03">
<ul>
<!-- <button class="btn_arw"><img src="/img/jipbank/main3/MainTab3_arw1.png" alt="이전으로 가기"/></button> -->

<li>
<div class="img_map"><img src="/img/jipbank/main3/MainTab3_map1.png" alt="순천 지도 이미지"/></div>
<div class="agency01"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=전남테크노파크&searchSelect=&searchSelectText=&searchArea=">전남테크노파크</a></div>
<!-- <div class="agency02"><a href="#">전남과학기술진흥센터</a></div>
<div class="agency03"><a href="#">녹색에너지연구원</a></div>
<div class="agency04"><a href="#">전남테크노파크</a></div> -->
</li>

<div class="TabBox03_gap"><img src="/img/jipbank/main3/gap_MainTab3.gif"/></div>

<li class="center">
<div class="img_map"><img src="/img/jipbank/main3/MainTab3_map2.png" alt="목포 지도 이미지"/></div>
<div class="agency01"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=녹색에너지연구원&searchSelect=&searchSelectText=&searchArea=">녹색에너지연구원</a></div>
<!-- <div class="agency02"><a href="#">전남테크노파크</a></div>
<div class="agency03"><a href="#">전남과학기술진흥센터</a></div>
<div class="agency04"><a href="#">녹색에너지연구원</a></div> -->
</li>

<div class="TabBox03_gap"><img src="/img/jipbank/main3/gap_MainTab3.gif"/></div>

<li>
<div class="img_map"><img src="/img/jipbank/main3/MainTab3_map3.png" alt="영암 지도 이미지"/></div>
<div class="agency01"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=전남과학기술진흥센터&searchSelect=&searchSelectText=&searchArea=">전남과학기술진흥센터</a></div>
<!-- <div class="agency02"><a href="#">전남테크노파크</a></div>
<div class="agency03"><a href="#">녹색에너지연구원</a></div>
<div class="agency04"><a href="#">전남과학기술진흥센터</a></div> -->
</li>

<!-- <button class="btn_arw btn_arw2"><img src="/img/jipbank/main3/MainTab3_arw2.png" alt="다음으로 가기"/></button> -->
</ul>
</div>
</div>
<!--TabList03 E-->



<!--TabList04 S-->
<div id="TabList04" style="display:none">
<div class="TabBox04">
<ul>
<li class="first"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=8">목포시</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=13">여수시</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=11">순천시</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=6">나주시</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=4">광양시</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=7">담양군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=3">곡성군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=5">구례군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=2">고흥군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=10">보성군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=22">화순군</a></li>
<li class="first"><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=18">장흥군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=1">강진군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=21">해남군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=15">영암군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=9">무안군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=20">함평군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=14">영광군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=17">장성군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=16">완도군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=19">진도군</a></li>
<li><a href="/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=&searchArea=12">신안군</a></li>
</ul>
</div>
</div>
<!--TabList04 E-->

</div>
<!--TabBtnWrap E-->

</div>
<!--MainTabWrap E-->



<!--ContBox01 S-->
<div class="ContBox01">

<!--NoticeWrap S-->
<div class="NoticeWrap">
	<ul class="NoticeMenuBox">
		<li class="on" id="boardtab1"><a href="javascript:boardlatestShow(1,2)" >공지사항</a></li>
		<div class="Notice_gap"><img src="/img/jipbank/main3/gap_notice.gif"/></div>
		<li id="boardtab2"><a href="javascript:boardlatestShow(2,1)" >지원사업</a></li>
		<div id="viewMore1" class="btn_more"><a href="/jipbank/sub.do?m=71"><img src="/img/jipbank/main3/btn_more.png" alt="공지사항 더보기 버튼"/></a></div>
		<div id="viewMore2" class="btn_more" style="display:none;"><a href="/jipbank/sub.do?m=72"><img src="/img/jipbank/main3/btn_more.png" alt="지원사업 더보기 버튼"/></a></div>
	</ul>


<!--List01 S-->
<div id="List01">



	<!--NoticeListBox S-->
	<div class="NoticeListBox" id="article_list01">

		<ul class="ListBox01" id="boardLatestNotice">
		</ul>
		<ul class="ListBox02" id="boardLatestNoticeSite">
		</ul>
		<ul class="ListBox03" id="boardLatestNoticeData">
		</ul>

	</div>
	<!--NoticeListBox E-->

</div>
<!--List01 E-->


<!--List02 S-->
<div id="List02" style="display:none">

	<!--NoticeListBox S-->
	<div class="NoticeListBox" id="article_list02">

		<ul class="ListBox01" id="boardLatestProject">
		</ul>

		<ul class="ListBox02" id="boardLatestProjectSite">
		</ul>

		<ul class="ListBox03" id="boardLatestProjectData">
		</ul>

	</div>
	<!--NoticeListBox E-->

</div>
<!--List02 E-->


</div>
<!--NoticeWrap E-->


<!--popupzone S-->
<div class="popupzone">
<h3 class="Titpopupzone"><span class="FontWeightBold">POPUP</span>ZONE</h3>
<ul class="PopupControl">
<li><a class="BtnPrev" href="javascript:silderPrev();">이전으로</a></li>
<li><a class="BtnNext" href="javascript:silderNext();">다음으로</a></li>
<li><a class="BtnStop" href="javascript:silderStop();">정지</a></li>
<li><a class="BtnPlay" href="javascript:silderPlay();">재생</a></li>
</ul>

<ul class="PopupList" id="PopupList">
<li><a href="#"><img title="정부3.02" src="/img/jipbank/main3/img_sample_popup.gif" alt="정부3.0" /></a></li>
</ul>
</div>
<!--popupzone E-->

</div>
<!--ContBox01 E-->


<!--ContBox02 S-->
<div class="ContBox02">

<!--ImgListWrap01 S-->
<div class="ImgListWrap01">


<!--ImgList01 S-->
<div id="ImgList01">
	<ul class="ImgListMenuBox">
				<!-- <li class="tab01 on" id="jipTab01"><a href="javascript:equTabShow(1,1)">포토뉴스</a></li>
				<div class="ImgList_gap"><img src="/img/jipbank/main3/gap_imglist.gif"/></div> -->
                <li class="tab03 on" id="jipTab03"><a href="javascript:equTabShow(3,1)">우수사례</a></li>
                <div class="ImgList_gap"><img src="/img/jipbank/main3/gap_imglist.gif"/></div>
			    <li class="tab02" id="jipTab02" style=" width: 120px;"><a href="javascript:equTabShow(2,1)">기술사업화제품</a></li>



			<ul class="ListSortBox"  style="margin-left: 680px;" >
				<li class="lookup"><a href="javascript:equTabShow(9,1)">조회순</a></li>
					<div class="ImgList_gap"><img src="/img/jipbank/main3/gap_imglist.gif"/></div>
				<li class="newest"><a href="javascript:equTabShow(9,2)">최신순</a></li>
			</ul>

		<div id="more3" class="btn_more"><a href="/jipbank/sub.do?m=76"><img src="/img/jipbank/main3/btn_more2.png" alt="우수사례 더보기 버튼"/></a></div>
		<div id="more2" class="btn_more" style="display:none;"><a href="/jipbank/sub.do?m=77"><img src="/img/jipbank/main3/btn_more2.png" alt="제품홍보 더보기 버튼"/></a></div>


	</ul>
<!--ImgListBox S-->
<!-- 포토 뉴스 조회순 -->
<!-- <ul class="ImgListBox" id="photoList_1_1">
</ul>
포토뉴스 최신순
<ul class="ImgListBox" id="photoList_1_2" style="display:none;">
</ul> -->
<!--ImgListBox E-->


<!--ImgListBox S-->
<!-- 우수사례조회순 -->
<ul class="ImgListBox" id="photoList_3_1" >
</ul>
<!-- 우수사례최신순 -->
<ul class="ImgListBox" id="photoList_3_2" style="display:none;">
</ul>
<!--ImgListBox E-->

<!-- 기술 사업화 제품 조회순 -->
<ul class="ImgListBox" id="photoList_2_1" style="display:none;">
</ul>
<!-- 기술 사업화 제품 최신순 -->
<ul class="ImgListBox" id="photoList_2_2" style="display:none;">
</ul>
<!--ImgListBox E-->


</div>
<!--ImgList01 E-->




</div>
<!--ImgListWrap01 E-->




<!--ImgListWrap02 S-->
<div class="ImgListWrap02">

<ul class="ImgListMenuBox02">
<li class="title"><a href="javascript:dataTabShow(1,1)">PUBLICATION</a></li>

<ul class="ListSortBox">
<li class="lookup"><a href="javascript:dataTabShow(1,1)">조회순</a></li>
<div class="ImgList_gap"><img src="/img/jipbank/main3/gap_imglist.gif"/></div>
<li class="newest"><a href="javascript:dataTabShow(1,2)">최신순</a></li>
</ul>

<div class="btn_more"><a href="/jipbank/sub.do?m=58"><img src="/img/jipbank/main3/btn_more2.png" alt="더보기"/></a></div>

</ul>

<!--ImgListBox S-->
<ul class="ImgListBox02" id="publicList_1_1">
</ul>
<ul class="ImgListBox02" id="publicList_1_2" style="display:none;">
</ul>
<!--ImgListBox E-->

</div>
<!--ImgListWrap02 E-->

</div>
<!--ContBox02 E-->




<!--Banner S-->
<div class="BannerWrap">

            <div class="Banner" style="position: relative;">

                        <h3 class="TitBanner">배너모음</h3>
                        <ul class="BannerControl">
                                    <li><a class="BtnPrev" id="rolling_left"
                                                href="javascript:void();">이전으로</a></li>
                                    <li><a class="BtnNext" id="rolling_right"
                                                href="javascript:void();">다음으로</a></li>
                                    <li><a class="BtnStop" id="rolling_stop"
                                                href="javascript:void();">정지</a></li>
                                    <li><a class="BtnPlay" id="rolling_play"
                                                href="javascript:void();">재생</a></li>
                        </ul>

                        <ul class="BannerList" jnsp_dir="+">
                        <li><a href="http://jntp.or.kr"><img src="/img/main/banner01.gif" alt="전남테크노파크" title="전남테크노파크 바로가기" /></a></li>
                        <li><a href="http://www.jnsp.re.kr"><img src="/img/main/banner02.gif" alt="전남과학기술진흥센터" title="전남과학기술진흥센터 바로가기" /></a></li>
                        <li><a href="https://ccei.creativekorea.or.kr"><img src="/img/main/banner03.gif" alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
                        <li><a href="http://gei.re.kr"><img src="/img/main/banner04.gif" alt="녹색에너지연구원" title="녹색에너지연구원 바로가기" /></a></li>
                        <li><a href="http://www.motie.go.kr/"><img src="/img/main/banner05.gif" alt="산업통상자원부" title="산업통상자원부 바로가기" /></a></li>
                        <li><a href="http://www.keit.re.kr/"><img src="/img/main/banner06.gif" alt="한국산업기술평가관리원" title="한국산업기술평가관리원 바로가기" /></a></li>
                        <li><a href="https://www.kiat.or.kr/"><img src="/img/main/banner07.gif" alt="한국산업기술진흥원" title="한국산업기술진흥원 바로가기" /></a></li>
                        </ul>

                        <div class="JeonNam">
                                    <a href="http://www.jeonnam.go.kr/" target="_blank">
                                    <div class="JeonNamCi">
                                    <img  src="/img/main/ci_jeonam.png" alt="생명의 땅 전남, 전라남도" title="전남도청 바로가기"  class="JeonNamImg"/>
                                    </div>
                                    </a>
                        </div>
            </div>
</div>
<!--Banner E-->