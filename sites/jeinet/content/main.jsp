<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
<!--MainCont01 S-->
<div class="MainCont01">
            <div class="VisualWrap">
                        <div class="VisualCont">
                                    <%
                                                if(mainvisualList.size() > 1 ){
                                    %>
                                    <ul class="VisualBtn01">
                                                <li class="PrevBtn"><a href="#"><img
                                                                        src="/img/main/btn_prev.png" alt="이전으로" /></a></li>
                                                <li class="NextBtn"><a href="#"><img
                                                                        src="/img/main/btn_next.png" alt="다음으로" /></a></li>
                                    </ul>
                                    <%
                                                }
                                    %>
                                    <p class="VisualTxt">
                                                <span class="VTxt01"><img
                                                            src="/img/main/txt_mainvisual01.png" alt="지역 연구장비를 한곳에!" /></span> <span
                                                            class="VTxt02"><img src="/img/main/txt_mainvisual02.png"
                                                            alt="연구장비정보망" /></span> <span class="VTxt03"><img
                                                            src="/img/main/txt_mainvisual03.png"
                                                            alt="Jeonnam Science &amp; Technology Promotion Center" /></span>
                                    </p>
                                    <div class="QuickLink">
                                    <ul>
                                   		<li class="QL01" onclick="location.href='/jeinet/sub.do?m=53';"><a href="#">장비예약신청</a></li>
                                   		<li class="QL02" onclick="location.href='/jeinet/sub.do?m=31';"><a href="/jeinet/sub.do?m=31">장비멘토링.</a></li>
                                        
                                        
                                   		<li class="QL03" onclick="window.open('http://www.etube.re.kr');"><a href="http://www.etube.re.kr">산업기술개발 장비<br/>공동이용시스템</a></li>
                                        
                                        
                                  		<li class="QL04" onclick="window.open('http://www.smtech.go.kr/front/main/main.do');"><a href="http://www.smtech.go.kr/front/main/main.do">연구장비공동활용<br />지원사업신청</a></li>					
                                    </ul>
                                    </div>


                                    <div class="Srch">
                                                <h4 class="TitSrch">
                                                            <span class="ImgTitSrch">
                                                                        <img src="/img/main/srch_logo.png" alt="JEINET 전남연구장비정보망 로고" />
                                                            </span>
                                                            <span class="TxtTitSrch">장비검색</span>
                                                </h4>

                                                <div class="SrchBox">
                                                <form name="mainSearchForm" method="post" action="/jeinet/sub.do?m=53" >
                                                            <input name="searchWord" title="장비검색" class="ESearch"
                                                                        type="text" /> <input tabindex="0" class="EQbtn" id="gt-submit"
                                                                        type="submit" value="검색" style="cursor:pointer" />
                                                </form>
                                                </div>

                                    </div>
                                    <ul class="VisualImg">
                                                <c:forEach var="result" items="${mainvisualList}" varStatus="status">
                                                            <li
                                                                        style="background:url('/<c:url value='${result.atchFileFullPath}'/>');"></li>
                                                </c:forEach>
                                    </ul>

                                    <%
                                                if(mainvisualList.size() > 1 ){
                                    %>
                                    <div class="VisualBtnWrap">
                                                <div class="VisualBtnBox">
                                                            <ul class="VisualBtn02">
                                                                        <%
                                                                                    for(int i = 0;i < mainvisualList.size();i++){
                                                                                                                                    String classdot = "";
                                                                                                                                    if(i == 0) classdot = "class='on'";
                                                                        %>
                                                                        <li <%=classdot%>><a href="javascript:void();"><%=(i+1)%></a></li>
                                                                        <%
                                                                                    }
                                                                        %>
                                                                        <li class="stop"><a href="#">정지</a></li>
                                                                        <li class="play"><a href="#">시작</a></li>
                                                            </ul>
                                                </div>
                                    </div>
                                    <%
                                                }
                                    %>
                        </div>

            </div>

</div>
<!--MainCont01 E-->




<!--MainCont02 S-->
<div class="MainCont02Wrap">
            <div class="MainCont02">
                        <div class="MainCont0201">

                                    <div class="status">
                                                <div class="tit_status">
                                                            <span class="date" id="strDate"></span>
                                                            <p><span class="FontWeightNormal">연구장비등록 </span>현황</p>
                                                </div>
                                                <ul class="StatusList">
                                                            <li class="SL01"><em>등록 기관수</em>
                                                            <p><span id="strEnterpriseCnt"></span><span class="unit">개 기관</span>     </p></li>
                                                            <li class="SL02" ><em>장비수</em>
                                                            <p><span id="strEquCnt"></span><span class="unit">점</span></p></li>
                                                            <li class="SL03"><em>취득금액</em>
                                                            <p><span id="strEquPrcCnt"></span><span class="unit">억원</span></p></li>
                                                            <li class="SL04"><em>공동활용허용률</em>
                                                            <p><span id="strEquUseCntPer"></span><span class="unit">%</span></p></li>
                                                </ul>
                                                <div class="BoardWrap">
                                                            <div class="board">
                                                            			<!-- 공지사항  -->
                                                                        <div class="article article_mn1">
                                                                                    <h3 class="TitBoard TitBoard01">
                                                                                                <a id="boardtab1" class="on"
                                                                                                            href="javascript:boardlatestShow(1)">공지사항</a>
                                                                                    </h3>

                                                                                    <div class="ConBoard" id="article_list01" style="display: block">
                                                                                                <ul class="ListBoard" id="boardLatestNotice">

                                                                                                </ul>
                                                                                                <a class="more" href="/jeinet/sub.do?m=34">더보기<span>+</span></a>
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
                                    </div>
                        </div>





                        <div class="popupzone">

                                    <h3 class="Titpopupzone">
                                                <span class="FontWeightBold">POPUP</span>ZONE
                                    </h3>
                                    <ul class="PopupControl">
                                                <li><a class="BtnPrev" href="javascript:silderPrev();">이전으로</a></li>
                                                <li><a class="BtnNext" href="javascript:silderNext();">다음으로</a></li>
                                                <li><a class="BtnStop" href="javascript:silderStop();">정지</a></li>
                                                <li><a class="BtnPlay" href="javascript:silderPlay();">재생</a></li>
                                    </ul>
                                    <ul class="PopupList" id="PopupList">
                                                <c:forEach var="result" items="${popupzoneList}" varStatus="status">
                                                            <li><a href="<c:out value='${result.linkUrl}'/>"
                                                                        <c:if test="${result.linkTarget == '_BLANK'}">target="_blank"</c:if>><img
                                                                                    title="<c:out value='${result.title}'/>"
                                                                                    src="/<c:url value='${result.atchFileFullPath}'/>"
                                                                                    alt="<c:out value='${result.content}'/>" /></a></li>
                                                </c:forEach>
                                    </ul>

                        </div>
                        <!--  popupzone E -->

            </div>
            <!--MainCont02 E-->
</div>
<!--MainCont02wrap E-->

<!--MainCont03 S-->

<div class="MainCont03Wrap">
            <div class="MainCont03">
                        <div class="Cont03Box">
                                    <ul class="DepthTab">

                                                <li><a class="TitTab01 on" id="equTitTab01" href="javascript:equTabShow(1,2);"><span class="hidden">JEINET</span>장비</a></li>
                                                <li><a class="TitTab02" id="equTitTab02" href="javascript:equTabShow(2,2);">PHOTO NEWS</a></li>
                                                <li><a class="TitTab03" id="equTitTab03" href="javascript:equTabShow(3,2);">우수사례</a></li>
                                    </ul>
                        </div>
                        <!--전남연구장비정보망 장비S-->
                        <div class="Cont03Box" id="equTab1" style="display:block">

                                    <div class="Cont03Sort">
                                                <ul class="sort">
													<li><a class="sort02" href="javascript:equTabShow(1,2)">최신순</a></li>
                                                    <li><a class="sort01" href="javascript:equTabShow(1,1)">조회순</a></li>
                                                </ul>

                                                <ul class="Cont03Control" style="padding-top:8px;">
                                                            <a class="more" href="/jeinet/sub.do?m=53">더보기<span>+</span></a>
                                                </ul>
                                    </div>

                                    <ul class="ListImg" id="equList_1_1" style="display:none;">
                                                LOADING ...
                                    </ul>

                                    <ul class="ListImg" id="equList_1_2" >
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
                                                </ul>
                                                <ul class="Cont03Control" style="padding-top:8px;">
                                                            <a class="more" href="/jeinet/sub.do?m=85">더보기<span>+</span></a>
                                                </ul>
                                    </div>
                                    <div style="position: relative;" >

                                                <ul class="ListImg" id="equList_2_1" style="display: none;">

												LOADING ...
                                                </ul>

                                                <ul class="ListImg" id="equList_2_2">
                                                LOADING ...
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
                                                </ul>
                                                <ul class="Cont03Control" style="padding-top:8px;">
                                                            <a class="more" href="/jeinet/sub.do?m=64">더보기<span>+</span></a>
                                                </ul>
                                    </div>
                                    <div style="position: relative;" >

                                                <ul class="ListImg" id="equList_3_1" style="display: none;">

												LOADING ...
                                                </ul>

                                                <ul class="ListImg" id="equList_3_2">
                                                LOADING ...
                                                </ul>

                                    </div>
                        </div>
                        <!--우수사례 E-->
            </div>
</div>
<!--MainCont03 E-->





<!--MainCont04 S-->
<div class="MainCont04Wrap">
            <div class="MainCont04">

                        <div class="Cont04Box">
                                    <ul class="DepthTab">
                                                <li  onclick="dataTabShow(1,2) ;"><a id="dataTitTab01" class="dataTitTab01 on" href="javascript:dataTabShow(1,2);">브로슈어</a></li>
                                                <li  onclick="dataTabShow(2,2);" ><a id="dataTitTab02" class="dataTitTab02" href="javascript:dataTabShow(2,2);">정책이슈</a></li>
                                                <li  onclick="dataTabShow(3,2);" ><a id="dataTitTab03" class="dataTitTab03" href="javascript:dataTabShow(3,2);">통계자료</a></li>
                                                <li  onclick="dataTabShow(4,2);" ><a id="dataTitTab04" class="dataTitTab04" href="javascript:dataTabShow(4,2);">발간물</a></li>
                                    </ul>
                        </div>


                        <!--브로슈어S-->
                        <div class="Cont04Box" id="dataTab1" style="display: block">
                                    <div class="Cont04Sort">
                                                <ul class="sort">
													<li><a class="sort02" href="javascript:dataTabShow(1,2);">최신순</a></li>
													<li><a class="sort01" href="javascript:dataTabShow(1,1);">조회순</a></li>
                                                </ul>
                                                <ul class="Cont04Control">
                                                   <a class="more" href="/jeinet/sub.do?m=77">더보기<span>+</span></a>
                                                </ul>
                                    </div>
                                    <div style="position: relative;">
                                                <ul class="ListImg" id="dataList_1_1" style="display: none" >LOADING ...</ul>
                                                <ul class="ListImg" id="dataList_1_2">LOADING ...</ul>
                                    </div>
                        </div>
                        <!--브로슈어E-->
                        <!--정책이슈S-->
                        <div class="Cont04Box" id="dataTab2" style="display: none">
                                    <div class="Cont04Sort">
                                                <ul class="sort">
													<li><a class="sort02" href="javascript:dataTabShow(2,2);">최신순</a></li>
                                                    <li><a class="sort01" href="javascript:dataTabShow(2,1);">조회순</a></li>
                                                </ul>
                                                <ul class="Cont04Control" style="padding-top:8px;">
                                                            <a class="more" href="/jeinet/sub.do?m=54">더보기<span>+</span></a>

                                                </ul>
                                    </div>
                                    <div style="position: relative;">
                                                <ul class="ListImg" style="display: none" id="dataList_2_1">LOADING ...</ul>
                                                <ul class="ListImg" style="display: none" id="dataList_2_2">LOADING ...</ul>
                                    </div>
                        </div>
                        <!--정책이슈E-->
                        <!--통계자료S-->
                        <div class="Cont04Box" id="dataTab3" style="display: none">
                                    <div class="Cont04Sort">
                                                <ul class="sort">
													<li><a class="sort02" href="javascript:dataTabShow(3,2);">최신순</a></li>
												    <li><a class="sort01" href="javascript:dataTabShow(3,1);">조회순</a></li>
                                                </ul>
                                                <ul class="Cont04Control" style="padding-top:5px;">
                                                   <a class="more" href="/jeinet/sub.do?m=74">더보기<span>+</span></a>
                                                </ul>
                                    </div>

                                    <div style="position: relative;">
                                                <ul class="ListImg" style="display: none" id="dataList_3_1">LOADING ...</ul>
                                                <ul class="ListImg" style="display: none" id="dataList_3_2">LOADING ...</ul>
                                    </div>

                        </div>
                        <!--통계자료E-->
                        <!--발간물 S-->
                        <div class="Cont04Box" id="dataTab4" style="display: none">
                                    <div class="Cont04Sort">
                                                <ul class="sort">
                                                   <li><a class="sort02" href="javascript:dataTabShow(4,2);">최신순</a></li>
												   <li><a class="sort01" href="javascript:dataTabShow(4,1);">조회순</a></li>
                                                </ul>
                                                <ul class="Cont04Control" style="padding-top:5px;">
                                                            <a class="more" href="/jeinet/sub.do?m=75">더보기<span>+</span></a>
                                                </ul>
                                    </div>
                                    <div style="position: relative;">
                                                <ul class="ListImg" style="display: none" id="dataList_4_1">LOADING ...</ul>
                                                <ul class="ListImg" style="display: none" id="dataList_4_2">LOADING ...</ul>
                                    </div>
                        </div>
                        <!--발간물 E-->
            </div>
</div>
<!--MainCont04 E-->


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

                        
                        <li><a href="http://www.jnsp.re.kr"><img src="/img/main/banner02.gif" alt="전남과학기술진흥센터" title="전남과학기술진흥센터 바로가기" /></a></li>
                        <li><a href="https://ccei.creativekorea.or.kr"><img src="/img/main/banner03.gif" alt="전남창조경제혁신센터" title="전남창조경제혁신센터 바로가기" /></a></li>
                        <li><a href="http://www.motie.go.kr/"><img src="/img/main/banner05.gif" alt="산업통상자원부" title="산업통상자원부 바로가기" /></a></li>
                        <li><a href="http://www.keit.re.kr/"><img src="/img/main/banner06.gif" alt="한국산업기술평가관리원" title="한국산업기술평가관리원 바로가기" /></a></li>
                        <li><a href="https://www.kiat.or.kr/"><img src="/img/main/banner07.gif" alt="한국산업기술진흥원" title="한국산업기술진흥원 바로가기" /></a></li>
                        
                        <li><a href="http://www.etube.re.kr/main/mainIndex.do" target="_blank"><img src="/img/main/banner00.gif" alt="e-Tube" title="e-Tube 바로가기" /></a></li>
                        <li><a href="http://www.dsu.ac.kr" target="_blank"><img src="/img/main/banner08.gif" alt="동신대학교" title="동신대학교 바로가기" /></a></li>
                        <li><a href="http://www.mokpo.ac.kr" target="_blank"><img src="/img/main/banner09.gif" alt="국립목포대학교" title="국립목포대학교 바로가기" /></a></li>
                        <li><a href="http://www.mmu.ac.kr" target="_blank"><img src="/img/main/banner10.gif" alt="목포해양대학교" title="목포해양대학교 바로가기" /></a></li>
                        <li><a href="http://www.sehan.ac.kr" target="_blank"><img src="/img/main/banner11.gif" alt="세한대학교" title="세한대학교 바로가기" /></a></li>
                        <li><a href="http://www.scnu.ac.kr" target="_blank"><img src="/img/main/banner12.gif" alt="국립순천대학교" title="국립순천대학교 바로가기" /></a></li>
                        <li><a href="http://www.jnu.ac.kr" target="_blank"><img src="/img/main/banner13.gif" alt="전남대학교(여수캠퍼스)" title="전남대학교(여수캠퍼스) 바로가기" /></a></li>
                        <li><a href="http://www.cdu.ac.kr" target="_blank"><img src="/img/main/banner14.gif" alt="초당대학교" title="초당대학교 바로가기" /></a></li>
                        <li><a href="http://www.scjc.ac.kr" target="_blank"><img src="/img/main/banner15.gif" alt="청암대학교" title="청암대학교 바로가기" /></a></li>
                        <li><a href="http://www.cntu.ac.kr" target="_blank"><img src="/img/main/banner16.gif" alt="전남과학대학교" title="전남과학대학교 바로가기" /></a></li>
                        <li><a href="http://www.kopo.ac.kr/mokpo" target="_blank"><img src="/img/main/banner17.gif" alt="한국폴리텍V대학 목포캠퍼스" title="한국폴리텍V대학 목포캠퍼스 바로가기" /></a></li>
                        <li><a href="http://www.jares.go.kr" target="_blank"><img src="/img/main/banner18.gif" alt="전라남도 농업기술원" title="전라남도 농업기술원 바로가기" /></a></li>
                        <li><a href="http://www.jihe.go.kr" target="_blank"><img src="/img/main/banner19.gif" alt="전남보건환경연구원" title="전남보건환경연구원 바로가기" /></a></li>
                        <li><a href="http://www.jnforest.jeonnam.go.kr" target="_blank"><img src="/img/main/banner20.gif" alt="전남산림자원연구소" title="전남산림자원연구소 바로가기" /></a></li>
                        <li><a href="http://www.ofsi.jeonnam.go.kr" target="_blank"><img src="/img/main/banner21.gif" alt="전남해양수산과학원" title="전남해양수산과학원 바로가기" /></a></li>
                        <li><a href="http://gei.re.kr"><img src="/img/main/banner04.gif" alt="녹색에너지연구원" title="녹색에너지연구원 바로가기" /></a></li>
                        <li><a href="http://www.jcia.or.kr" target="_blank"><img src="/img/main/banner23.gif" alt="전남정보문화산업진흥원" title="전남정보문화산업진흥원 바로가기" /></a></li>
                        <li><a href="http://www.jbf.kr" target="_blank"><img src="/img/main/banner24.gif" alt="전남생물산업진흥원" title="전남생물산업진흥원 바로가기" /></a></li>
                        <li><a href="http://jntp.or.kr"><img src="/img/main/banner01.gif" alt="전남테크노파크" title="전남테크노파크 바로가기" /></a></li>
                        <li><a href="http://www.jeipi.or.kr" target="_blank"><img src="/img/main/banner26.gif" alt="전라남도환경산업진흥원" title="전라남도환경산업진흥원 바로가기" /></a></li>
                        <li><a href="http://www.katech.re.kr" target="_blank"><img src="/img/main/banner27.gif" alt="자동차부품연구원" title="자동차부품연구원 바로가기" /></a></li>
                        <li><a href="http://www.rims.re.kr" target="_blank"><img src="/img/main/banner28.gif" alt="중소조선연구원(서남권본부)" title="중소조선연구원(서남권본부) 바로가기" /></a></li>
                        <li><a href="http://2mfood.kr" target="_blank"><img src="/img/main/banner29.gif" alt="목포수산식품지원센터" title="목포수산식품지원센터 바로가기" /></a></li>
                        <li><a href="http://www.jmi.re.kr" target="_blank"><img src="/img/main/banner30.gif" alt="장흥군버섯산업연구원" title="장흥군버섯산업연구원 바로가기" /></a></li>
                        <li><a href="http://www.ysagr.yeosu.go.kr" target="_blank"><img src="/img/main/banner31.gif" alt="여수시 농업기술센터" title="여수시 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.naju.go.kr/atec" target="_blank"><img src="/img/main/banner32.gif" alt="나주시 농업기술센터" title="나주시 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.gwangyang.go.kr/jares/index.gwangyang" target="_blank"><img src="/img/main/banner33.gif" alt="광양시 농업기술센터" title="광양시 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.atc.damyang.go.kr" target="_blank"><img src="/img/main/banner34.gif" alt="담양군 농업기술센터" title="담양군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.gokseong.go.kr/fmtech" target="_blank"><img src="/img/main/banner35.gif" alt="곡성군 농업기술센터" title="곡성군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.gurye.go.kr/farmtech" target="_blank"><img src="/img/main/banner36.gif" alt="구례군 농업기술센터" title="구례군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.atec.boseong.go.kr" target="_blank"><img src="/img/main/banner37.gif" alt="보성군 농업기술센터" title="보성군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.nong.yeongam.go.kr" target="_blank"><img src="/img/main/banner38.gif" alt="영암군 농업기술센터" title="영암군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.hampyeong.go.kr/center/main/main.php" target="_blank"><img src="/img/main/banner39.gif" alt="함평군 농업기술센터" title="함평군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.yeonggwang.go.kr/main/?site=agro" target="_blank"><img src="/img/main/banner40.gif" alt="영광군 농업기술센터" title="영광군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.agro.jangseong.go.kr" target="_blank"><img src="/img/main/banner41.gif" alt="장성군 농업기술센터" title="장성군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.wando.go.kr/ares" target="_blank"><img src="/img/main/banner42.gif" alt="완도군 농업기술센터" title="완도군 농업기술센터 바로가기" /></a></li>
                        <li><a href="http://www.kict.re.kr" target="_blank"><img src="/img/main/banner43.gif" alt="한국건설기술연구원" title="한국건설기술연구원 바로가기" /></a></li>
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