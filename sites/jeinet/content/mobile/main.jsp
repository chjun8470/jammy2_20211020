<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<div class="MainVisualWrap">
            <div class="MainVisual">
                <img src="/img/mobile/main/txt_visual.png"  alt="지역연구장비를 한 곳에! 전남연구장비정보망 Jeonnam risearch Equipment Information NETwork" class="txt_visual">
                <div class="VisualLink" id="jntisMainContentStart">
                    <ul class="MVisualLinkList">
                        <li class="MVisualLinkList01" onclick="window.open('http://jeinet.jnsp.re.kr/jeinet/main.do')">
                            <a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
                                <div class="h_icon"></div>
                                <h3>장비예약신청</h3>
                            </a>
                        </li>
                        <li class="MVisualLinkList02" onclick="window.open('http://jeinet.jnsp.re.kr/jeinet/main.do')">
                            <a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
                                <div class="h_icon02"></div>
                                <h3>장비검색</h3>
                            </a>
                        </li>
                        <li class="MVisualLinkList03" onclick="window.open('http://jrpm.jnsp.re.kr/')">
                            <a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
                                <div class="h_icon03"></div>
                                <h3>자료검색</h3>
                            </a>
                        </li>

                    </ul>
                    
                </div>
                <!--visuallink -->
            </div>
        </div>
        <!--MainVisualWrap e 2021.03.17-->
        <div class="MainContBg">
            <!--MainCont01 s-->
            <div class="MainCont01">
                <ul class="Main01">
                    <li class="info01">
                        <h2>연구장비등록현황(전남)<span id="strDate"></span></h2>
                        <!--<p>2021년 03월 16일 15시 기준</p>-->
                    </li>
                    <li>
                        <div class="status icon01">
                            <!--<img src="img/jeinet/main/c_icon01.png">-->
                            <h4>등록기관수</h4>
                            <h4><span id="strEnterpriseCnt"></span>개 (전남<e id="strJEnterpriseCnt"></e>개)</h4>
                        </div>
                    </li>
                    <li>
                        <div class="status icon02">
                            <!--<img src="img/jeinet/main/c_icon02.png">-->
                            <h4>등록장비수</h4>
                            <h4><span id="strEquCnt"></span>개 (전남<e id="strJEquCnt"></e>개)</h4>
                        </div>
                    </li>
                    <li>
                        <div class="status icon03">
                            <!--<img src="img/jeinet/main/c_icon03.png">-->
                            <h4>장비구축비</h4>
                            <h4><span id="strEquPrcCnt"></span>억원 (전남<e id="strJEquPrcCnt"></e>억원)</h4>
                        </div>
                    </li>
                    <li>
                        <div class="status icon04">
                            <!--<img src="img/jeinet/main/c_icon04.png">-->
                            <h4>공동활용 허용률</h4>
                            <h4><span id="strEquUseCntPer"></span>% (전남<e id="strJEquUseCntPer"></e>%)</h4>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="MainContWrap">
                <!--Main02 s-->
                <div class="Main02">
                    <div class="BoardWrap01">
                        <div class="board">
                            <!-- 공지사항  -->
                            <div class="article article_mn1">
                                <h3 class="TitBoard TitBoard01">
                                    <a id="boardtab1" class="on" href="javascript:boardlatestShow(1)"
                                    >공지사항</a>
                                    <a class="more" href="/jeinet/sub.do?m=34">MORE+</a>
                                </h3>
                                <div class="ConBoard" id="article_list01" style="display: block;">
                                    <ul class="ListBoard" id="boardLatestNotice">
                                        <li>
											<span class="subject">
												<a href="/jeinet/sub.do?m=34&amp;mode=view&amp;boardIdx=15954">
												2021년「국가연구시설장비 관리 및 윤리에 관한 교육」일정안내_NFEC
												</a>
											</span>
											<span class="date">2021-03-17</span>
										</li>
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="Section0502">
                        <div class="popupzone">

                            <h3 class="Titpopupzone">
                                POPUPZONE
                                <span class="line"></span>
                            </h3>
                            <div class="bx-wrapper" style="max-width: 335px;">
                                <div class="bx-viewport" style="width: 100%; overflow: hidden; position: relative; height: 252px;">
                                    <ul class="PopupList" id="PopupList" style="width: 515%; position: relative; transition-duration: 0s; transform: translate3d(-670px, 0px, 0px);">
                                        <li style="float: left; list-style: none; position: relative; width: 335px;" class="bx-clone">
											<a href="http://www.etube.re.kr" target="_blank">
												<img title="산업기술개발장비 공동이용 시스템에서 필요한 장비를 편리하게 이용하실 수 있습니다." src="/img/jeinet/main/popup01.jpg" alt="e-Tube 산업기술개발장비 공동이용 시스템에서 필요한 장비를 편리하게 이용하실 수 있습니다.">
											</a>
										</li>

                                        <li style="float: left; list-style: none; position: relative; width: 335px;">
                                            <a href="http://jeinet.jnsp.re.kr/jeinet/sub.do?listMode=imagelist&amp;m=53&amp;searchWord=%ED%95%9C%EA%B5%AD%EA%B1%B4%EC%84%A4%EA%B8%B0%EC%88%A0%EC%97%B0%EA%B5%AC%EC%9B%90">
											<img title="전남연구장비정보망에서 한국건설기술연구원 보유 고가 연구장비를 활용ㆍ지원합니다." src="/img/jeinet/main/popup01.jpg" alt="전남연구장비정보망(JEINET)에서 한국건설기술연구원(KICT) 보유 고가 연구장비를 활용.지원합니다.">
											</a>
                                        </li>

                                        <li style="float: left; list-style: none; position: relative; width: 335px;">
                                            <a href="https://www.zeus.go.kr" target="_blank" >
											<img title="ZEUS 장비활용서비스" src="img/jeinet/main/popup01.jpg" alt="장비활용종합포털, ZEUS 전국 장비보유기관들이 공동으로 참여하는 클라우드 기반의 지능형 장비예약시스템으로 장비 이용에 대한 중개 · 알선 및 다양하고 유용한 콘텐츠를 제공합니다.">
											</a>
                                        </li>

                                        <li style="float: left; list-style: none; position: relative; width: 335px;">
                                            <a href="http://www.etube.re.kr" target="_blank">
												<img title="산업기술개발장비 공동이용 시스템에서 필요한 장비를 편리하게 이용하실 수 있습니다." src="/img/jeinet/main/popup01.jpg"alt="e-Tube 산업기술개발장비 공동이용 시스템에서 필요한 장비를 편리하게 이용하실 수 있습니다.">
											</a>
                                        </li>

                                        <li style="float: left; list-style: none; position: relative; width: 335px;" class="bx-clone">
											<a href="http://jeinet.jnsp.re.kr/jeinet/sub.do?listMode=imagelist&amp;m=53&amp;searchWord=%ED%95%9C%EA%B5%AD%EA%B1%B4%EC%84%A4%EA%B8%B0%EC%88%A0%EC%97%B0%EA%B5%AC%EC%9B%90">
												<img title="전남연구장비정보망에서 한국건설기술연구원 보유 고가 연구장비를 활용ㆍ지원합니다." src="/img/jeinet/main/popup01.jpg" alt="전남연구장비정보망(JEINET)에서 한국건설기술연구원(KICT) 보유 고가 연구장비를 활용.지원합니다.">
											</a>
										</li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

            </div>


        </div>