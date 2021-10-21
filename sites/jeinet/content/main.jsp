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
	SiteInfoVO siteInfoVO = (SiteInfoVO) request.getAttribute("SITE_INFO");
	PopupManager pm = new PopupManager(request);

	// 팝업존 리스트
	List<PopupVO> popupzoneList = pm.getPopupList(siteInfoVO.getSiteId(), "POPUPZONE");
	List<PopupVO> mainvisualList = pm.getPopupList(siteInfoVO.getSiteId(), "MAIN_VISUAL");
%>
<c:set var="popupzoneList" value="<%=popupzoneList%>" />
<c:set var="mainvisualList" value="<%=mainvisualList%>" />
<!--MainCont01 S-->
<!--<div class="MainCont01">

	<div class="VisualWrap">
	
		<div class="VisualCont">
			<%if (mainvisualList.size() > 1) {%>
			<ul class="VisualBtn01">
			            <li class="PrevBtn"><a href="#"><img
			                                    src="/img/main/btn_prev.png" alt="이전으로" /></a></li>
			            <li class="NextBtn"><a href="#"><img
			                                    src="/img/main/btn_next.png" alt="다음으로" /></a></li>
			</ul>
			<%}%>
		<div class="VisualTxt">
			<div class="VTxt01"><img src="/img/main/txt_mainvisual0102.png" alt="지역 연구장비를 한곳에!" /></div>
			<div class="VTxt02"><img src="/img/main/txt_mainvisual0202.png" alt="연구장비정보망" /></div>
			<div class="VTxt03"><img src="/img/main/txt_mainvisual0302.png" alt="Jeonnam Science &amp; Technology Promotion Center" /></div>
		</div>
		<div class="QuickLink">
			<ul>
				<li class="QL01" onclick="location.href='/jeinet/sub.do?m=53';"><a href="#">장비예약신청</a></li>
				<li class="QL02" onclick="location.href='/jeinet/sub.do?m=31';"><a href="/jeinet/sub.do?m=31">장비멘토링</a></li>
				<li class="QL03" onclick="window.open('http://www.etube.re.kr');"><a href="http://www.etube.re.kr">산업기술개발 장비<br/>공동이용시스템</a></li>
				<li class="QL04" onclick="window.open('http://www.smtech.go.kr/front/main/main.do');"><a href="http://www.smtech.go.kr/front/main/main.do">연구장비공동활용<br />지원사업신청</a></li>
			</ul>
		</div>
		<div class="Srch">
	        <h4 class="TitSrch">
	        	<span class="ImgTitSrch"><img src="/img/main/srch_logo.png" alt="JEINET 전남연구장비정보망 로고" /></span>
	            <span class="TxtTitSrch">장비검색</span>
	        </h4>
	        <div class="SrchBox">
		        <form name="mainSearchForm" method="post" action="/jeinet/sub.do?m=53" >
		        	<input name="searchWord" title="장비검색" class="ESearch" type="text" />
		        	<input tabindex="0" class="EQbtn" id="gt-submit" type="submit" value="검색" style="cursor:pointer" />
		        </form>
	        </div>
		</div>
		<ul class="VisualImg">
			<%-- <c:forEach var="result" items="${mainvisualList}" varStatus="status">
				<li style="background:url('/<c:url value='${result.atchFileFullPath}'/>');"></li>
			</c:forEach> --%>
		</ul>
		<%if (mainvisualList.size() > 1) {%>
		<div class="VisualBtnWrap">
			<div class="VisualBtnBox">
	            <ul class="VisualBtn02">
	            	<%for (int i = 0; i < mainvisualList.size(); i++) {
					String classdot = "";
					if (i == 0)
						classdot = "class='on'";%>
					<li <%=classdot%>><a href="javascript:void();"><%=(i + 1)%></a></li>
					<%}%>
                    <li class="stop"><a href="#">정지</a></li>
                    <li class="play"><a href="#">시작</a></li>
	            </ul>
			</div>
		</div>
		<%}%>
		</div>
	
	</div>

</div>-->
<!--MainCont01 E-->


<div class="MainVisualWrap">
	<div class="MainVisual">
		<img src="/img/main/txt_visual.png"
			alt="지역 연구장비를 한 곳에! 전남연구장비정보망 Jeonnam research Equipment Information NETwork"
			class="txt_visual">
		<div class="VisualLink" id="jntisMainContentStart">
			<ul class="MVisualLinkList">
				<li class="MVisualLinkList01">
					<a href="/jeinet/sub.do?m=53" title="새창열기" target="_blank">
					<div class="h_icon"></div>
					<h3>장비예약신청</h3>
				</a>
				</li>
				<li class="MVisualLinkList02">
					<a href="https://www.zeus.go.kr/main" title="새창열기" target="_blank">
					<div class="h_icon02"></div>
					<h3>장비활용종합포털</h3>
				</a>
				</li>
				<li class="MVisualLinkList03">
					<a href="https://www.itube.or.kr/index.do" title="새창열기" target="_blank">
						<div class="h_icon03"></div>
						<h3>
							산업기술개발<br>장비공동이용시스템
						</h3>
					</a>
				</li>
				<li class="MVisualLinkList04">
					<a href="https://www.zeus.go.kr/resv/vou/search" title="새창열기" target="_blank">
						<div class="h_icon04"></div>
						<h3>
							연구장비공동활용<br>지원사업신청
						</h3>
					</a>
				</li>
			</ul>
			<div class="sch_02">
				<h2> 
					<img src="/img/jeinet/main/s_logo.png"> 장비검색
				</h2>
				<p>JEINET에서 보유한 장비를 검색합니다.</p>
				<div class="jeinet_sch">

					<form action="/jeinet/sub.do?m=53" method="post" name="searchWord">
						<input type="text" name="searchWord" class="sch_in">
						<input type="submit" class="sch_btn" value="검색">
					</form>
					<!--<input type="search" name="searchSelectText" class="sch_in">
					<input type="submit" class="sch_btn" value="검색">-->
				</div>
			</div>
		</div>
		<!--visuallink -->
	</div>
</div>

<div class="MainContBg">
	<div class="MainCont01">
		<ul class="Main01">
			<li class="info01">
				<h2>연구장비등록현황(전남)</h2>
				<p id="strDate">------------</p>
			</li>
			<li>
				<div class="titbox">
					<img src="/img/jeinet/main/c_icon01.png">
					<h4>등록기관수</h4>
				</div>
				<div class="status">
					<ul>
						<li>전체<span id="strEnterpriseCnt"></span></li>
						<li>전남<span id="strJEnterpriseCnt"></span></li>
					</ul>
				</div>
			</li>
			<li>
				<div class="titbox">
					<img src="/img/jeinet/main/c_icon02.png">
					<h4>등록장비수</h4>
				</div>
				<div class="status">
					<ul>
						<li>전체<span id="strEquCnt"></span></li>
						<li>전남<span id="strJEquCnt"></span></li>
					</ul>
				</div>
			</li>
			<li>
				<div class="titbox">
					<img src="/img/jeinet/main/c_icon03.png">
					<h4>장비구축비</h4>
				</div>
				<div class="status">
					<ul>
						<li>전체<span id="strEquPrcCnt"></span></li>
						<li>전남<span id="strJEquPrcCnt"></span></li>
					</ul>
				</div>
			</li>
			<li>
				<div class="titbox">
					<img src="/img/jeinet/main/c_icon04.png">
					<h4>
						공동활용<br>허용률
					</h4>
				</div>
				<div class="status">
					<ul>
						<li>전체<span id="strEquUseCntPer"></span></li>
						<li>전남<span id="strJEquUseCntPer"></span></li>
					</ul>
				</div>
			</li>
		</ul>
	</div>


	<div class="MainContWrap">
		<!--MainCont02 S-->
		<div class="Main02">
			<div class="BoardWrap01">
				<div class="board">
					<!-- 공지사항  -->
					<div class="article article_mn1">
						<h3 class="TitBoard TitBoard01">
							<a id="boardtab1" class="on" href="javascript:boardlatestShow(1)">공지사항</a>
							<span class="line"></span> <a class="more" href="/jntis/sub.do?m=98">MORE+</a>
						</h3>
						
						<div class="ConBoard" id="article_list01" style="display: block">
							<ul class="ListBoard" id="boardLatestNotice"></ul>
						</div>
					</div>
					<!-- 지원사업 -->
					<!-- <div class="article article_mn2">
								<h3 class="TitBoard TitBoard02">
											<a id="boardtab2" href="javascript:boardlatestShow(2)">지원사업</a>
								</h3>
								<div class="ConBoard" id="article_list02" style="display: none">
											<ul class="ListBoard" id="boardLatestProject">
					
											</ul>
											<a class="more" href="/jeinet/sub.do?m=82">더보기<span>+</span></a>
								</div>
					</div> -->
					<!-- 보도자료 -->
					<!-- <div class="article article_mn3">
								<h3 class="TitBoard TitBoard03">
											<a id="boardtab3" href="javascript:boardlatestShow(3)">보도자료</a>
								</h3>
								<div class="ConBoard" id="article_list03" style="display: none">
											<ul class="ListBoard" id="boardLatestNews">
					
											</ul>
											<a class="more" href="/jeinet/sub.do?m=83">더보기<span>+</span></a>
								</div>
					</div> -->
				</div>
			</div>
			<div class="Section0502">
				<div class="popupzone">
					<h3 class="Titpopupzone">
						<span class="FontWeightBold">POPUP</span>ZONE <span class="line"></span>
					</h3>
					<!--
					<ul class="PopupControl">
						<li><a class="BtnPrev" href="javascript:silderPrev();">이전으로</a></li>
						<li><a class="BtnNext" href="javascript:silderNext();">다음으로</a></li>
						<li><a class="BtnStop" href="javascript:silderStop();">정지</a></li>
						<li><a class="BtnPlay" href="javascript:silderPlay();">재생</a></li>
					</ul>
					-->
					<ul class="PopupList" id="PopupList">
						<c:forEach var="result" items="${popupzoneList}"
							varStatus="status">
							<li><a href="<c:out value='${result.linkUrl}'/>"
								<c:if test="${result.linkTarget == '_BLANK'}">target="_blank"</c:if>>
									<img title="<c:out value='${result.title}'/>"
									src="/<c:url value='${result.atchFileFullPath}'/>"
									alt="<c:out value='${result.content}'/>" />
							</a></li>
						</c:forEach>
					</ul>

				</div>
				<!--  popupzone E -->
			</div>
		</div>
		<!--MainCont02 E-->
		<!--MainCont03 S-->
		<div class="MainCont03Wrap">

			<div class="MainCont03">
				<div class="Cont03Box">
					<ul class="DepthTab">
						<li><a class="TitTab01 on" id="equTitTab01" href="javascript:equTabShow(1,2);">JEINET&ZEUS장비</a></li>
						<li><a class="TitTab02" id="equTitTab02" href="javascript:equTabShow(2,2);">PHOTO NEWS</a></li>
						<li class="bg_none"><a class="TitTab03" id="equTitTab03" href="javascript:equTabShow(3,2);">우수사례</a></li>
					</ul>
				</div>
				<!--전남연구장비정보망 장비S-->
				<div class="Cont03Box" id="equTab1" style="display: block">

					<div class="Cont03Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:equTabShow(1,2)">최신순</a></li>
							<li><a class="sort01" href="javascript:equTabShow(1,1)">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=53">더보기<span>+</span></a></li>
						</ul>
					</div>


					<ul class="ListImg" id="equList_1_1" style="display: none;">
						LOADING ...
					</ul>

					<ul class="ListImg" id="equList_1_2">
					LOADING ...
					</ul>


				</div>
				<!--전남연구장비정보망 장비E-->
				<!--photo news S-->
				<div class="Cont03Box" id="equTab2" style="display: none">
					<div class="Cont03Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:equTabShow(2,2)">최신순</a></li>
							<li><a class="sort01" href="javascript:equTabShow(2,1)">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=85">더보기<span>+</span></a></li>
						</ul>
					</div>
					<div style="position: relative;">

						<ul class="ListImg" id="equList_2_1" style="display: none;">

							LOADING ...
						</ul>

						<ul class="ListImg" id="equList_2_2">LOADING ...
						</ul>

					</div>
				</div>
				<!--photo news E-->
				<!--우수사례 S-->
				<div class="Cont03Box" id="equTab3" style="display: none">
					<div class="Cont03Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:equTabShow(3,2)">최신순</a></li>
							<li><a class="sort01" href="javascript:equTabShow(3,1)">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=64">더보기<span>+</span></a></li>
						</ul>
					</div>
					<div style="position: relative;">

						<ul class="ListImg" id="equList_3_1" style="display: none;">

							LOADING ...
						</ul>

						<ul class="ListImg" id="equList_3_2">LOADING ...
						</ul>

					</div>
				</div>
				<%--우수사례 E --%>
			</div>
		</div>
		<!--MainCont03 E-->

		<!--MainCont04 S-->
		<div class="MainCont04Wrap">
			<div class="MainCont04">

				<div class="Cont04Box">
					<ul class="DepthTab">
						<li onclick="dataTabShow(1,2) ;">
							<a id="dataTitTab01" class="dataTitTab01 on" href="javascript:dataTabShow(1,2);">장비브로슈어</a>
						</li>
						<li onclick="dataTabShow(2,2);"><a id="dataTitTab02"
							class="dataTitTab02" href="javascript:dataTabShow(2,2);">장비정보</a>
						</li>
						<!--<li  onclick="dataTabShow(4,2);" ><a id="dataTitTab04" class="dataTitTab04" href="javascript:dataTabShow(4,2);">발간물</a></li>
													<li  onclick="dataTabShow(3,2);" class="bg_none"><a id="dataTitTab03" class="dataTitTab03" href="javascript:dataTabShow(3,2);">기술자료</a></li>-->

					</ul>
				</div>


				<!--브로슈어S-->
				<div class="Cont04Box" id="dataTab1" style="display: block">
					<div class="Cont04Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:dataTabShow(1,2);">최신순</a></li>
							<li><a class="sort01" href="javascript:dataTabShow(1,1);">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=77">더보기<span>+</span></a></li>
						</ul>
					</div>
					<div style="position: relative;">
						<ul class="ListImg" id="dataList_1_1" style="display: none">LOADING
							...
						</ul>
						<ul class="ListImg" id="dataList_1_2">LOADING ...
						</ul>
					</div>
				</div>
				<!--브로슈어E-->
				<!--정책이슈S-->
				<div class="Cont04Box" id="dataTab2" style="display: none">
					<div class="Cont04Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:dataTabShow(2,2);">최신순</a></li>
							<li><a class="sort01" href="javascript:dataTabShow(2,1);">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=73">더보기<span>+</span></a></li>
						</ul>
					</div>
					<div style="position: relative;">
						<ul class="ListImg" style="display: none" id="dataList_2_1">LOADING
							...
						</ul>
						<ul class="ListImg" style="display: none" id="dataList_2_2">LOADING
							...
						</ul>
					</div>
				</div>
				<!--정책이슈E-->
				<!--통계자료S-->
				<div class="Cont04Box" id="dataTab3" style="display: none">
					<div class="Cont04Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:dataTabShow(3,2);">최신순</a></li>
							<li><a class="sort01" href="javascript:dataTabShow(3,1);">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=74">더보기<span>+</span></a></li>
						</ul>
					</div>

					<div style="position: relative;">
						<ul class="ListImg" style="display: none" id="dataList_3_1">LOADING
							...
						</ul>
						<ul class="ListImg" style="display: none" id="dataList_3_2">LOADING
							...
						</ul>
					</div>

				</div>
				<!--통계자료E-->
				<!--발간물 S-->
				<div class="Cont04Box" id="dataTab4" style="display: none">
					<div class="Cont04Sort">
						<ul class="sort">
							<li><a class="sort02" href="javascript:dataTabShow(4,2);">최신순</a></li>
							<li><a class="sort01" href="javascript:dataTabShow(4,1);">조회순</a></li>
							<li><a class="more" href="/jeinet/sub.do?m=75">더보기<span>+</span></a></li>
						</ul>
					</div>
					<div style="position: relative;">
						<ul class="ListImg" style="display: none" id="dataList_4_1">LOADING
							...
						</ul>
						<ul class="ListImg" style="display: none" id="dataList_4_2">LOADING
							...
						</ul>
					</div>
				</div>
				<!--발간물 E-->
			</div>
		</div>
		<!--MainCont04 E-->
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

			<ul id="bannerList" class="BannerList" jnsp_dir="+">
			</ul>

			<div class="JeonNam">
				<a href="http://www.jeonnam.go.kr/" target="_blank">
					<div class="JeonNamCi">
						<img src="/img/main/ci_jeonam.png" alt="생명의 땅 전남, 전라남도"
							title="전남도청 바로가기" class="JeonNamImg" />
					</div>
				</a>
			</div>
		</div>
	</div>

</div>
<!--Banner E-->