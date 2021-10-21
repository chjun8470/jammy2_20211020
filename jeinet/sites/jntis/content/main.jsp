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

    	String userAgent = request.getHeader("user-agent");
    	boolean mobile1 = userAgent.matches(".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson).*");
    	boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");

%>
<c:set var="popupzoneList" value="<%=popupzoneList%>" />
<c:set var="mainvisualList" value="<%=mainvisualList%>" />


<div class="MainVisualWrap">
<div class="MainVisual">
<img src="/img/jntis/main/txt_visual.png" alt="세상을 바꾸는 과학기술 전남과학기술정보시스템 Jeonnam Science & Technology Information system" />
<div class="VisualLink">
<ul class="MVisualLinkList">
<li class="MVisualLinkList01" onclick="window.open('http://jeinet.jnsp.re.kr/jeinet/main.do')">
<p class="MVLTit">전남연구장비정보망</p>
<p class="MVLTxt">지역연구장비를 한곳에!<br />
장비 상담에서 활용지원까지!</p>
<a href="http://jeinet.jnsp.re.kr/jeinet/main.do" target="_blank"><img src="/img/jntis/main/btn_go02.png" alt="바로가기" title="전남연구장비정보망 홈페이지 바로가기" /></a></li>
<li class="MVisualLinkList02" onclick="window.open('http://jipbank.jnsp.re.kr/jipbank/main.do')">
<p class="MVLTit">전남지식재산정보은행</p>
<p class="MVLTxt">성공적 지식재산활용 지원!<br />지식재산 창출에서 이전·사업화까지</p>
<a href="http://jipbank.jnsp.re.kr/jipbank/main.do" target="_blank"><img src="/img/jntis/main/btn_go02.png" alt="바로가기" title="전남지식재산정보은행 홈페이지 바로가기" /></a></li>
<% if(mobile1 || mobile2) { %>
<li class="MVisualLinkList03">
<p class="MVLTit">전남R&D과제관리시스템</p>
<p class="MVLTxt">과제 관리를 쉽게!<br />한눈에 확인하는 과제관리</p>
<p class="MVLTxt">PC버전에서만 사용가능합니다</p></li>
<li class="MVisualLinkList04">
<p class="MVLTit">전남R&D성과관리시스템</p>
<p class="MVLTxt">성과관리를한번에!<br />
성과관리 및 분석 제공.</p>
<p class="MVLTxt">PC버전에서만 사용가능합니다</p></li>
<% } else {

 %>
<li class="MVisualLinkList03" onclick="window.open('http://jrpm.jnsp.re.kr/')" >
<p class="MVLTit">전남R&D과제관리시스템</p>
<p class="MVLTxt">과제 관리를 쉽게!<br />한눈에 확인하는 과제관리</p>
<a href="http://jrpm.jnsp.re.kr/" target="_blank"><img src="/img/jntis/main/btn_go02.png" alt="바로가기" title="전남과제관리시스템 홈페이지 바로가기" /></a></li>
<li class="MVisualLinkList04" onclick="window.open('http://rnd.jnsp.re.kr/')" >
<p class="MVLTit">전남R&D성과관리시스템</p>
<p class="MVLTxt">성과관리를한번에!<br />
성과관리 및 분석 제공.</p>
<a href="http://rnd.jnsp.re.kr/" target="_blank"><img src="/img/jntis/main/btn_go02.png" alt="바로가기" title="전남성과관리시스템 홈페이지 바로가기" /></a></li>
<% } %>
</ul>
</div>
<!--visuallink -->
</div>
</div>
<!--MainVisualWrap e-->
<div class="MainContBg">
<div class="MainContWrap">
<!--MainCont01 s-->
<div class="MainCont01">
<div class="MCSection01">
<ul>
<!--
<li class="enroll01" onclick="location.href='/jntis/sub.do?m=26';">기업등록 바로가기</li>
<li class="enroll02" onclick="location.href='/jntis/sub.do?m=26';">기관등록 바로가기</li>
-->
<li class="enroll01" onclick="popupWindow('orgResvPop','1');">기업등록 바로가기</li>
<li class="enroll02" onclick="popupWindow('orgResvPop','2');">기관등록 바로가기</li>
</ul>
</div>

<!-- 160616 최은성 팀장님 추가 -->
<script>
function popupWindow(listMode,userTP){
       var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

       var popUrl="/web/popup/"+listMode+".do?orgType="+userTP;
       var popOption="width=850, height=650, resizable=no, scrollbars=yes, status=no;";
       window.open(popUrl,"orgResv",popOption);

}
</script>
<!-- 160616 최은성 팀장님 추가 -->

<div class="MCSection02">
<h3>기업/기관 등록현황(전남)</h3>
<ul>
<li><em class="title">기업수</em><p class="num" ><span id='avg_1_1'>0</span><span id='avg_1_1_2'>(0)</span>개 기업</p></li>
<li><em class="title">대학</em><p class="num"><span id='avg_1_2'>0</span><span id='avg_1_2_2'>(0)</span>개 대학</p></li>
<li><em class="title">연구기관</em><p class="num"><span id='avg_1_3'>0</span><span id='avg_1_3_2'>(0)</span>개 기관</p></li>
<li><em class="title">지원기관</em><p class="num"><span id='avg_1_4'>0</span><span id='avg_1_4_2'>(0)</span>개 기관</p></li>
</ul>
<!-- <a class="more" href="/jntis/sub.do?m=26"><img src="/img/jntis/main/btn_more0101.gif" alt="더보기+" /></a> -->
</div>
<div class="MCSection03">
<h3>연구장비 등록현황(전남)</h3>
<ul>
<li><em class="title">등록기관</em><p class="num"><span id='avg_2_1'>0</span><span id='avg_2_1_2'>(0)</span>개 기관</p></li>
<li><em class="title">등록장비수</em><p class="num"><span id='avg_2_2'>0</span><span id='avg_2_2_2'>(0)</span>점</p></li>
<li><em class="title">취득금액</em><p class="num"><span id='avg_2_3'>0</span><span id='avg_2_3_2'>(0)</span>억원</p></li>
<li><em class="title">공동활용허용률</em><p class="num"><span id='avg_2_4'>0</span>%</p></li>
</ul>
<!-- <a class="more" href="/jeinet/sub.do?m=86"><img src="/img/jntis/main/btn_more0102.gif" alt="더보기+" /></a> -->
</div>
<div class="MCSection04">
<h3>지식재산 등록현황(전남)</h3>
<ul>
<li><em class="title">등록기관</em><p class="num"><span id='avg_3_1'>0</span><span id='avg_3_1_2'>(0)</span>개 기관</p></li>
<li><em class="title">특허/실용신안</em><p class="num"><span id='avg_3_2'>0</span><span id='avg_3_2_2'>(0)</span>건</p></li>
<li><em class="title">디자인/상표</em><p class="num"><span id='avg_3_3'>0</span><span id='avg_3_3_2'>(0)</span>건</p></li>
<li><em class="title">프로그램/노하우</em><p class="num"><span id='avg_3_4'>0</span><span id='avg_3_4_2'>(0)</span>건</p></li>
</ul>
<!-- <a class="more" href="/jipbank/sub.do?m=82"><img src="/img/jntis/main/btn_more0103.gif" alt="더보기+" /></a> -->
</div>
<div class="MCSection05">
<h3>전문가 등록현황(전남)</h3>
<ul>
<li><em class="title">대학·연구기관</em><p class="num"><span id='avg_4_1'>0</span><span id='avg_4_1_2'>(0)</span>개 기관</p></li>
<li><em class="title">민간·기업</em><p class="num"><span id='avg_4_2'>0</span><span id='avg_4_2_2'>(0)</span>개 기업</p></li>
<li><em class="title">등록전문가</em><p class="num"><span id='avg_4_3'>0</span><!-- <span id='avg_4_3_3'>(0)</span> -->명</p></li>
<li><em class="title">기관담당자</em><p class="num"><span id='avg_4_4'>0</span><!-- <span id='avg_4_4_4'>(0)</span> -->명</p></li>
</ul>
<!-- <a class="more" href="#"><img src="/img/jntis/main/btn_more0104.gif" alt="더보기+" /></a> -->
</div><!--MCSention01"-->
</div>
<!--MainCont01 e-->

<!--MainCont02 s-->
<div class="MainCont02">
<div class="BoardWrap01">
<div class="board01">
       <h2>통합게시판</h2>
       <div class="article article_mn1">
              <h3 class="TitBoard TitBoard01" onclick="boardlatestShow(1)"><a id="boardtab1"  class="on" href="javascript:void()">통합</a></h3>
              <div class="ConBoard" id="article_list01" >
                     <ul class="ListBoard" id="boardLatestNotice">



                     </ul>
                     <a class="more" href="http://jntis.jnsp.re.kr/jntis/sub.do?m=99">더보기<span>+</span></a>
                     <!-- <a class="more" href="#">더보기 <span>+</span></a> -->
              </div>
       </div>

       <div class="article article_mn2">
       <h3 class="TitBoard TitBoard02"  onclick="boardlatestShow(2)"><a  id="boardtab2" href="javascript:void()">JNTIS</a></h3>
              <div class="ConBoard" id="article_list02" style="display:none" >
                     <ul class="ListBoard" id="boardLatestJntis">

                     </ul>
                     <a class="more" href="http://jntis.jnsp.re.kr/jntis/sub.do?m=98">더보기<span>+</span></a>
              </div>
       </div>
       <div class="article article_mn3">
       <h3 class="TitBoard TitBoard03" onclick="boardlatestShow(3)"><a id="boardtab3"  href="javascript:void()">JEINET</a></h3>
              <div class="ConBoard" id="article_list03" style="display:none" >
                     <ul class="ListBoard" id="boardLatestJeinet">

                     </ul>
                     <a class="more" href="http://jeinet.jnsp.re.kr/jeinet/sub.do?m=34">더보기<span>+</span></a>
              </div>
       </div>
       <div class="article article_mn4">
       <h3 class="TitBoard TitBoard04" onclick="boardlatestShow(4)"><a id="boardtab4"  href="javascript:void()">JPBANK</a></h3>
              <div class="ConBoard" id="article_list04"  style="display:none">
                     <ul class="ListBoard" id="boardLatestJipBank">

                     </ul>
                     <a class="more" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=71">더보기<span>+</span></a>
              </div>
       </div>
</div></div>
<div class="BoardWrap02">
<div class="board02">
       <h2>사업안내</h2>
       <div class="article article_mn1">
       <h3 class="TitBoard TitBoard01" onclick="bizlatestShow(1)"><a id="biztab1" class="on" href="javascript:void()">통합</a></h3>
              <div class="ConBoard" id="biz_list01" >
                     <ul class="ListBoard02" id="boardLatestProject">

                     </ul>
                     <!-- <a class="more" href="#">더보기<span>+</span></a> -->
              </div>
       </div>
       <div class="article article_mn2">
       <h3 class="TitBoard TitBoard02" onclick="bizlatestShow(2)"><a id="biztab2" href="javascript:void()">정부사업</a></h3>
              <div class="ConBoard" id="biz_list02" style="display:none" >
                     <ul class="ListBoard" id="boardLatestProject1">

                     </ul>
                     <a class="more" href="/jntis/sub.do?m=28">더보기<span>+</span></a>
              </div>
       </div>
       <div class="article article_mn3">
       <h3 class="TitBoard TitBoard03" onclick="bizlatestShow(3)"><a id="biztab3" href="javascript:void()">지역사업</a></h3>
              <div class="ConBoard" id="biz_list03" style="display:none" >
                     <ul class="ListBoard" id="boardLatestProject2">

                     </ul>
                     <a class="more" href="/jntis/sub.do?m=29">더보기<span>+</span></a>
              </div>
       </div>

</div>
</div>
<div class="BoardWrap03">
<div class="board03">
              <h2>행사교육정보</h2>
       <div class="article article_mn1">
       <h3 class="TitBoard TitBoard01"  onclick="edulatestShow(1)"><a  id="edutab1" class="on"  href="javascript:void()">통합</a></h3>
              <div class="ConBoard" id="edu_list01"  >
                     <ul class="ListBoard" id="boardLatestEventEdu">

                     </ul>
              </div>
       </div>
       <div class="article article_mn2">
       <h3 class="TitBoard TitBoard02"  onclick="edulatestShow(2)"><a  id="edutab2" href="javascript:void()">행사정보</a></h3>
              <div class="ConBoard" id="edu_list02" style="display:none;" >
                     <ul class="ListBoard" id="boardLatestEvent">

                     </ul>
                     <a class="more" href="http://jntis.jnsp.re.kr/jntis/sub.do?m=32">더보기<span>+</span></a>
              </div>
       </div>
       <div class="article article_mn3">
       <h3 class="TitBoard TitBoard03"  onclick="edulatestShow(3)"><a  id="edutab3" href="javascript:void()">교육정보</a></h3>
              <div class="ConBoard" id="edu_list03"  style="display:none;" >
                     <ul class="ListBoard" id="boardLatestEdu">

                     </ul>
                     <a class="more" href="/jntis/sub.do?m=34" >더보기<span>+</span></a>
              </div>
       </div>

</div>
</div>
<div class="BoardWrap04">
<div class="board04">
       <h2>보도자료</h2>
       <div class="ConBoard">
                     <ul class="ListBoard04" id="boardLatestNews">


            <li>
                     <span class="subject">
            <img src="/img/jntis/main/icon_jipbank.png" alt="지식재산 게시판아이콘" />
            <a href="#">타이틀을 입력합니다.</a></span>
                     <span class="date">2016-05-16</span>
                     </li>
                     <li>
                     <span class="subject">
            <img src="/img/jntis/main/icon_jeinet.png" alt="연구장비정보망 게시판아이콘" />
            <a href="#">타이틀을 입력합니다.</a></span>
                     <span class="date">2016-05-16</span>
                     </li>
            <li>
                     <span class="subject">
            <img src="/img/jntis/main/icon_jipbank.png" alt="지식재산 게시판아이콘" />
            <a href="#">타이틀을 입력합니다.</a></span>
                     <span class="date">2016-05-16</span>
                     </li>
                     <li>
                     <span class="subject">
            <img src="/img/jntis/main/icon_jeinet.png" alt="연구장비정보망 게시판아이콘" />
            <a href="#">타이틀을 입력합니다.</a></span>
                     <span class="date">2016-05-16</span>
                     </li>
            <li>
                     <span class="subject">
            <img src="/img/jntis/main/icon_jeinet.png" alt="연구장비정보망 게시판아이콘" />
            <a href="#">타이틀을 입력합니다.</a></span>
                     <span class="date">2016-05-16</span>
                     </li>


                     </ul>
                     <a class="more" href="/jntis/sub.do?m=93">더보기 <span>+</span></a>
       </div>

</div>
</div>
</div>
</div>
<!--MainCont02 e-->
<!--MainCont03 s-->
<div class="MainCont03">
<ul>
<li class="QuickLink01" onclick='location.href="/jntis/sub.do?m=37"'><a href="/jntis/sub.do?m=37">과학기술정보</a></li>
<li class="QuickLink02" onclick='location.href="/jntis/sub.do?m=115"'><a href="/jntis/sub.do?m=115">기업정보</a></li>
<li class="QuickLink03" onclick='location.href="/jntis/sub.do?m=116"'><a href="/jntis/sub.do?m=116">기업연구소정보</a></li>
<li class="QuickLink04" onclick='location.href="/jntis/sub.do?m=84"'><a href="/jntis/sub.do?m=84">전문가정보</a></li>
<li class="QuickLink05" onclick='location.href="/jntis/sub.do?m=85"'><a href="/jntis/sub.do?m=85">일자리정보</a></li>
<li class="QuickLink06" onclick='location.href="/jntis/sub.do?m=88"'><a href="/jntis/sub.do?m=88">투자유치정보</a></li>
<li class="QuickLink07" onclick='location.href="/jntis/sub.do?m=90"'><a href="/jntis/sub.do?m=90">수요조사</a></li>
<li class="QuickLink08" onclick='location.href="/jntis/sub.do?m=92"'><a href="/jntis/sub.do?m=92">만족도조사</a></li>
</ul>
</div>
<!--MainCont03 e-->

<!--MainCont04 s-->
<div class="MainCont04" >
<h2 class="tit_MC04">PHOTO NEWS</h2>
<ul id="boardListPhoto">

</ul>
<a class="more" href="/jntis/sub.do?m=94">더보기 <span>+</span></a>
</div>
<!--MainCont04 e-->

<!--MainCont05 s-->
<div class="MainCont05">
<div class="Section0501">
<h2 class="tit_MC05">R&amp;D 관련정보</h2>
<ul>
<li class="MC050101">
<p class="Tit0501">국가R&amp;D사업</p>
<p class="Txt0501">Government R&amp;D Projects</p>
<a href="/jntis/sub.do?m=28"><img src="/img/jntis/main/btn_go.gif" alt="바로가기" title="국가R&D 홈페이지 바로가기" /></a>
</li>
<li class="MC050102">
<p class="Tit0501">R&amp;D 관심기업 정보</p>
<p class="Txt0502">R&amp;D business information of interest</p>
<a href="/jntis/sub.do?m=56"><img src="/img/jntis/main/btn_go.gif" alt="바로가기" title="R&D 관심기업 정보 바로가기" /></a>
</li>
<li class="MC050103">
<p class="Tit0501">주요서비스</p>
<p class="Txt0501">Key service</p>
<a href="/jntis/sub.do?m=112"><img src="/img/jntis/main/btn_go.gif" alt="바로가기" title="주요서비스 바로가기" /></a>
</li>
<!-- <li class="MC050104">
<p class="Tit0501">기술사업화 제품홍보</p>
<p class="Txt0502">Promoting a product commerciallzation</p>
<a href="/jntis/sub.do?m=109"><img src="/img/jntis/main/btn_go.gif" alt="바로가기" title="기술사업화 제품홍보 바로가기" /></a>
</li> --></ul>
</div>

<div class="Section0502">
<h2 class="tit_MC0502">POPUP ZONE</h2>
<ul class="PopupControl">
                           <li><a class="BtnPrev" href="javascript:silderPrev();">이전으로</a></li>
                           <li><a class="BtnNext" href="javascript:silderNext();">다음으로</a></li>
                           <li><a class="BtnStop" href="javascript:silderStop();">정지</a></li>
                           <li><a class="BtnPlay" href="javascript:silderPlay();">재생</a></li>
                     </ul>
                     <ul class="PopupList02" id="PopupList02">

                         <c:forEach var="result" items="${popupzoneList}" varStatus="status">
                        <li>
                            <a href="<c:out value='${result.linkUrl}'/>" <c:if test="${result.linkTarget == '_BLANK'}">target="_blank"</c:if> >
                                  <img title="<c:out value='${result.title}'/>" src="/<c:url value='${result.atchFileFullPath}'/>" alt="<c:out value='${result.content}'/>" />
                            </a>
                        </li>
                  </c:forEach>
                     </ul>
</div>
</div>
<!--MainCont05 e-->

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

</div>
<!--MainContWRap e-->
</div>