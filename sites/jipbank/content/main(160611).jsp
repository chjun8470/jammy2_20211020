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
<link href="/css/cms/front/jipbank/main_ces.css" media="all" rel="stylesheet" type="text/css" />



<c:set var="popupzoneList" value="<%=popupzoneList%>" />
<c:set var="mainvisualList" value="<%=mainvisualList%>" />
<!--MainCont01 S-->
<div class="MainCont01">
	<div class="VisualWrap">
		<div class="VisualCont">

		<div style="background: url('/img/jipbank/main2/main_visual.png') no-repeat top; margin: 0px auto; height: 497px;">
			<div style="width:1200px;margin: 0px auto; position:relative;">

				<div class="QuickLink">
					<div class="topblock"><a href="/jipbank/sub.do?m=26"><img src="/img/jipbank/main2/btn_qk_1.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=82"><img src="/img/jipbank/main2/btn_qk_2.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=57"><img src="/img/jipbank/main2/btn_qk_3.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=76"><img src="/img/jipbank/main2/btn_qk_4.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=43"><img src="/img/jipbank/main2/btn_qk_5.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=62"><img src="/img/jipbank/main2/btn_qk_6.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=74"><img src="/img/jipbank/main2/btn_qk_7.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=63"><img src="/img/jipbank/main2/btn_qk_8.png" /></a></div>
					<div class="topblock"><a href="/jipbank/sub.do?m=66"><img src="/img/jipbank/main2/btn_qk_9.png" /></a></div>

					<div style="position:absolute;border-bottom:1px solid #8096a0;height:1px;width:280px;top:290px;left:40px;">&nbsp;</div>

					<div class="jipbankInfo"><img src="/img/jipbank/main2/jipbank_info.png" /></div>
				</div>
			</div>

		</div>



	</div>

</div>
<!--MainCont01 E-->
<div style="height: 129px;width:100%;margin: 0px auto;">
	<div style="background: url('/img/jipbank/main2/menu_tab.png') no-repeat top; margin: 0px auto; height: 129px;position:relative;margin-top:-50px;">

	</div>
</div>

<div style="background: url('/img/jipbank/main2/main_conts.png') no-repeat top; margin: 0px auto; height: 1079px;">

</div>




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
			<li><a href="#"><img src="/img/main/banner01.gif"
					alt="산업통상자원부" title="산업통상자원부 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner02.gif"
					alt="한국산업기술평가관리원" title="한국산업기술평가관리원 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner03.gif" alt="KIAT"
					title="KIAT 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
			<li><a href="#"><img src="/img/main/banner04.gif"
					alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
		</ul>

		<div class="JeonNam" style="float: right;">
			<a href="http://www.jeonnam.go.kr/" target="_blank"><img
				src="/img/main/ci_jeonam.png" alt="생명의 땅 전남, 전라남도" title="전남도청 바로가기" /></a>
		</div>
	</div>
</div>
<!--Banner E-->
