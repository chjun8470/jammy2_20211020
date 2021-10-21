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
	SiteInfoVO siteInfoVO = (SiteInfoVO) request.getAttribute("SITE_INFO");
	PopupManager pm = new PopupManager(request);
	
	// 팝업존 리스트
	List<PopupVO> popupzoneList = pm.getPopupList(siteInfoVO.getSiteId(), "POPUPZONE");
	
	List<PopupVO> mainvisualList = pm.getPopupList(siteInfoVO.getSiteId(), "MAIN_VISUAL");
	
	String userAgent = request.getHeader("user-agent");
	boolean mobile1 = userAgent.matches(
			".*(iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson).*");
	boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
%>
<c:set var="popupzoneList" value="<%=popupzoneList%>" />
<c:set var="mainvisualList" value="<%=mainvisualList%>" />

<div class="MainVisualWrap">
	<div class="MainVisual">
		<img src="/img/smbrnd/main/txt_visual.png" alt="세상을 바꾸는 과학기술 전남과학기술정보시스템 Jeonnam Science &amp; Technology Information system" style="user-select: auto;" class="txt_visual"/>
		<div class="VisualLink" id="jntisMainContentStart">
			<ul class="MVisualLinkList">
				
				<li class="MVisualLinkList01">
					<a href="http://jntis.jnsp.re.kr/jntis/main.do" title="새창열기" target="_blank">
						<h3>전남과학기술정보시스템</h3>
						<!--<p class="MVLTxt">
							지역연구장비를 한곳에!<br /> 장비 상담에서 활용지원까지!
						</p> -->
						<img src="/img/smbrnd/main/h_icon.png" class="h_icon" alt="전남과학기술정보시스템 로고"/>
						<img src="/img/smbrnd/main/btn_go02.png" alt="전남과학기술정보시스템 홈페이지 바로가기" />
					</a>
				</li>


				<li class="MVisualLinkList02">
					<a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
						<h3>전남연구장비정보망</h3>
							<!--<p class="MVLTxt">
								성공적 지식재산활용 지원!<br />
								지식재산 창출에서 이전·사업화까지
							</p>-->
						<img src="/img/smbrnd/main/h_icon02.png" class="h_icon" alt="전남연구장비정보망 로고"/>
						<img src="/img/smbrnd/main/btn_go02.png" alt="전남연구장비정보망 홈페이지 바로가기" />
					</a>
				</li>



				<%
					if (mobile1 || mobile2) {
				%>
				<li class="MVisualLinkList03">
					<a href="http://rnd.jnsp.re.kr/" title="새창열기" target="_blank">
						<h3>전남R&D성과관리시스템</h3>
							<!--<p class="MVLTxt">
								성공적 지식재산활용 지원!<br />
								지식재산 창출에서 이전·사업화까지
							</p>-->
						<img src="/img/smbrnd/main/h_icon03.png" class="h_icon m_icon" alt="전남R&D성과관리시스템 로고"/>
						<img src="/img/smbrnd/main/btn_go02.png" alt="전남R&D성과관리시스템 홈페이지 바로가기" />
					</a>
				</li>

				<li class="MVisualLinkList04">
					<a href="/smbrnd/sub.do?m=10" title="바로가기">
						<h3>전남 중소기업 통계정보</h3>
							<!--<p class="MVLTxt">
								성공적 지식재산활용 지원!<br />
								지식재산 창출에서 이전·사업화까지
							</p>-->
						<img src="/img/smbrnd/main/h_icon04.png" class="h_icon m_icon" alt="전남 중소기업 통계정보 로고"/>
						<img src="/img/smbrnd/main/btn_go02.png" alt="전남 중소기업 통계정보 홈페이지 바로가기" />
					</a>
				</li>

				<%
					} else {
				%>


				<li class="MVisualLinkList03">
					<a href="http://rnd.jnsp.re.kr/ " title="새창열기" target="_blank">
						<h3>전남R&D성과관리시스템</h3>
							<!--<p class="MVLTxt">
								성공적 지식재산활용 지원!<br />
								지식재산 창출에서 이전·사업화까지
							</p>-->
						<img src="/img/smbrnd/main/h_icon03.png" class="h_icon m_icon" alt="전남R&D성과관리시스템 로고"/>
						<img src="/img/smbrnd/main/btn_go02.png" alt="전남R&D성과관리시스템 홈페이지 바로가기" />
					</a>
				</li>

				<li class="MVisualLinkList04">
					<a href="http://smbrnd.jnsp.re.kr/smbrnd/sub.do?m=10" title="바로가기">
						<h3>전남 중소기업 통계정보</h3>
							<!--<p class="MVLTxt">
								성공적 지식재산활용 지원!<br />
								지식재산 창출에서 이전·사업화까지
							</p>-->
						<img src="/img/smbrnd/main/h_icon04.png" class="h_icon m_icon" alt="전남 중소기업 통계정보 로고"/>
						<img src="/img/smbrnd/main/btn_go02.png" alt="전남 중소기업 통계정보 홈페이지 바로가기" />
					</a>
				</li>
				<%
					}
				%>



				<!--<li class="MVisualLinkList05">
			    	<h3>전남조선산업정보망</h3>
			    		<p class="MVLTxt">
			            	전남지역 조선·해양산업의<br />
			    			통합정보제공
			            </p>
			            <a href="http://www.jnship.kr" title="새창열기" target="_blank"><img src="/img/smbrnd/main/btn_go02.png" alt="전남조선산업정보망 홈페이지 바로가기" /></a>
			    </li>-->



			</ul>
		</div>
		<!--visuallink -->
	</div>
	<div id="banner_slide">
        <div class="banner01"></div>
        <div class="banner02"></div>
    </div>

    <script type="text/javascript">
        $(function(){
            $('#banner_slide').slick({
                dots: false,
                arrows:false,
                autoplay:true,
                infinite: true,
                speed: 500,
                fade: true,
                pauseOnHover: false,
                cssEase: 'linear'
            });
        });
    </script>
</div>
<!--MainVisualWrap e-->
<div class="MainContBg">
	<div class="MainContWrap">
		<!--MainCont01 s-->
		<div class="MainCont01">
			<!--2021.03.17 sy-->
			
			<ul class="Main01">
                 <li class="info01">
					<h2>전문가 등록현황</h2>
                    <p><span id="strDate">2021년 03월 16일 15시</span> 기준</p>
                 </li>
                 <li>
                    <img src="/img/smbrnd/main/c_icon01.png" alt="등록 전문가 수 아이콘 이미지"/>
                    <h4>등록 전문가 수</h4>
                    <h2><span id="mainCount1">232</span><span>명</span></h2>
                 </li>
                 <li>
                    <img src="/img/smbrnd/main/c_icon02.png" alt="협력기관 수 아이콘 이미지"/>
                    <h4>협력기관 수</h4>
                    <h2><span id="mainCount2">232</span><span>개</span></h2>
                 </li>
                 <li class="btn_b">
                     <a href="/smbrnd/sub.do?m=9" alt="전문가검색 바로가기">
						<h4>전문가검색</h4>
						<h1>SEARCH</h1>
                     </a>
                 </li>
                 <li class="btn_g">
                     <a href="/smbrnd/sub.do?m=13" alt="전문가등록 바로가기">
                        <h4>전문가등록</h4>
                        <h1>EXPERT</h1>
                     </a>
                 </li>
            </ul>
            

			<!--21.03.17 v주석-->

			<!--<div class="MCSection01">
				<ul>
					
					<li class="enroll01" onclick="location.href='/smbrnd/sub.do?m=26';">기업등록 바로가기</li>
					<li class="enroll02" onclick="location.href='/smbrnd/sub.do?m=26';">기관등록 바로가기</li>
					
					<!-- <li class="enroll01"><input onclick="popupWindow('orgResvPop','1');" type="image" src="/img/smbrnd/main/btn_main01.png" title="새창열기" alt="기업등록 바로가기" /></li>
					<li class="enroll02"><input
						onclick="popupWindow('orgResvPop','2');" type="image"
						src="/img/smbrnd/main/btn_main02.png" title="새창열기" alt="기관등록 바로가기" /></li>
				</ul>
			</div> -->

			<!-- 160616 최은성 팀장님 추가 -->
			<script type="text/javascript">
				//<![CDATA[
				function popupWindow(listMode, userTP) {
					var settings = 'toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
					var popUrl = "/web/popup/" + listMode + ".do?orgType="
							+ userTP;
					//var popOption="width=850, height=650, resizable=no, scrollbars=yes, status=no;";
					var popOption = "width=817, height=700, resizable=no, scrollbars=yes, status=no;";
					window.open(popUrl, "orgResv", popOption);
				}
				//]]>
			</script>
			<!-- 160616 최은성 팀장님 추가 -->

			<!--<div class="MCSection02">
				<h3>기관 등록현황(전남)</h3>
				<ul>
					
					<li><em class="title">대학</em>
						<p class="num">
							<span id='avg_1_2'>0</span><span id='avg_1_2_2'>(0)</span>개 대학
						</p></li>
					<li><em class="title">연구기관</em>
						<p class="num">
							<span id='avg_1_3'>0</span><span id='avg_1_3_2'>(0)</span>개 기관
						</p></li>
					<li>
						<em class="title">지원기관 <span id='avg_1_4'>0</span>개</em>
						<p class="num">
							전남 <span id='avg_1_4_2'>(0)</span>
						</p>
					</li>
					<li>
						<em class="title">기업 <span id='avg_1_1'>0</span>개</em>
						<p class="num" >
							전남 <span id='avg_1_1_2'>(0)</span>
						</p>
					</li>
				</ul>
				<a class="more" href="/smbrnd/sub.do?m=26"><img src="/img/smbrnd/main/btn_more0101.gif" alt="더보기+" /></a>
			</div>-->
			<!--<div class="MCSection03">
				<h3>연구장비 등록현황(전남)</h3>
				<ul>
					<li><em class="title">등록기관</em>
						<p class="num">
							<span id='avg_2_1'>0</span><span id='avg_2_1_2'>(0)</span>개 기관
						</p></li>
					<li><em class="title">등록장비수</em>
						<p class="num">
							<span id='avg_2_2'>0</span><span id='avg_2_2_2'>(0)</span>점
						</p></li>
					<li><em class="title">장비구축비</em><p class="num"><span id='avg_2_3'>0</span><span id='avg_2_3_2'>(0)</span>억원</p></li>
					<li><em class="title">공동활용허용률</em>
						<p class="num">
							<span id='avg_2_4'>0</span>%
						</p></li>
				</ul>
				<a class="more" href="/jeinet/sub.do?m=86"><img src="/img/smbrnd/main/btn_more0102.gif" alt="더보기+" /></a>
			</div>
			
			<!-- <div class="MCSection04">
				<h3>지식재산 등록현황(전남)</h3>
				<ul>
				<li><em class="title">등록기관</em><p class="num"><span id='avg_3_1'>0</span><span id='avg_3_1_2'>(0)</span>개 기관</p></li>
				<li><em class="title">특허/실용신안</em><p class="num"><span id='avg_3_2'>0</span><span id='avg_3_2_2'>(0)</span>건</p></li>
				<li><em class="title">디자인/상표</em><p class="num"><span id='avg_3_3'>0</span><span id='avg_3_3_2'>(0)</span>건</p></li>
				<li><em class="title">프로그램/노하우</em><p class="num"><span id='avg_3_4'>0</span><span id='avg_3_4_2'>(0)</span>건</p></li>
				</ul>
				<a class="more" href="/jipbank/sub.do?m=82"><img src="/img/smbrnd/main/btn_more0103.gif" alt="더보기+" /></a>
			</div>-->
			
			<!-- 
			<div class="MCSection05">
				<h3>전문가 등록현황(전남)</h3>
				<ul>
				<li><em class="title">대학·연구기관</em><p class="num"><span id='avg_4_1'>0</span><span id='avg_4_1_2'>(0)</span>개 기관</p></li>
				<li><em class="title">민간·기업</em><p class="num"><span id='avg_4_2'>0</span><span id='avg_4_2_2'>(0)</span>개 기업</p></li>
				<li><em class="title">등록전문가</em><p class="num"><span id='avg_4_3'>0</span><span id='avg_4_3_3'>(0)</span>명</p></li>
				<li><em class="title">기관담당자</em><p class="num"><span id='avg_4_4'>0</span><span id='avg_4_4_4'>(0)</span>명</p></li>
				</ul>
				<a class="more" href="#"><img src="/img/smbrnd/main/btn_more0104.gif" alt="더보기+" /></a>
			</div>
			-->
			<!--MCSention01"-->
		</div>
		<!--MainCont01 e-->

		<!--Main02 s-->
                <div class="Main02">

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
								<li style="padding: 1px;"><a
									href="<c:out value='${result.linkUrl}'/>"
									<c:if test="${result.linkTarget == '_BLANK'}">target="_blank"</c:if>
									title="<c:out value='${result.title}'/>">
									<img src="/<c:url value='${result.atchFileFullPath}'/>" alt="<c:out value='${result.content}'/>" />
								</a></li>
							</c:forEach>
						</ul>
                    </div>


                    <div class="BoardWrap01">
                        <div class="board01">
                            <h2>공지사항</h2>
                            <div class="ConBoard">
                                <ul class="ListBoard01" id="boardLatestNotice">
                                    
                                    
                                    
                                    
                                </ul>
                                <a class="more more03" href="http://jntis.jnsp.re.kr/jntis/sub.do?m=98" title="공지사항 더보기" target="_blank">MORE<span>+</span></a>
                            </div>

                        </div>
                    </div>
                </div>
		<!--Main02 end-->

		<!--Main03 s-->
                <div class="Main03"> 
                    <div class="Section0501">
                        <h2 class="tit_MC05">R&amp;D 관련정보</h2>
                        <ul>
                            <li class="MC050103">
                                <img src="/img/smbrnd/main/icon_rnd01.png" class="iconrnd" alt="기업마당 사이트로고"/>
                                <div class="txt0317">
                                    <p class="Tit0501">기업마당</p>
                                    <p class="Txt0501">Company yard</p>
                                    <a href="http://www.bizinfo.go.kr/cmm/main/introPage.do" title="기업마당 바로가기" target="_blank">
                                        <img src="/img/smbrnd/main/btn_go01.png" alt="기업마당"/>
                                    </a>
                                </div>
                            </li>
                            <li class="MC050104">
                                <img src="/img/smbrnd/main/icon_rnd02.png" class="iconrnd" alt="중소기업기술개발사업 종합관리시스템 사이트로고"/>
                                <div class="txt0317">
                                    <p class="Tit0501 MAB10" style="line-height: 25px; user-select: auto;">중소기업기술개발사업<br/>종합관리시스템</p>
                                    <a href="http://www.smtech.go.kr" target="_blank" title="중소기업 기술개발사업 종합관리시스템 바로가기">
                                        <img src="/img/smbrnd/main/btn_go01.png" alt="중소기업 기술개발사업 종합관리시스템"/>
                                    </a>
                                </div>
                            </li>
                            <li class="MC050101">
                                <img src="/img/smbrnd/main/icon_rnd03.png" class="iconrnd" alt="기업공감원스톱서비스 사이트로고"/>
                                <div class="txt0317">
                                    <p class="Tit0501">기업공감원스톱서비스</p>
                                    <!--<p class="Txt0501">Government R&amp;D Projects</p>-->
                                    <a href="https://www.ntis.go.kr/ThMain.do" target="_blank" title="기업공감원스톱서비스 홈페이지 바로가기">
                                        <img src="/img/smbrnd/main/btn_go01.png" alt="기업공감원스톱서비스"/>
                                    </a>
                                </div>
                            </li>
                            <li class="MC050102">
                                <img src="/img/smbrnd/main/icon_rnd04.png" class="iconrnd" alt="중소기업 기술로드맵 사이트로고"/>
                                <div class="txt0317">
                                    <p class="Tit0501">중소기업<br/>기술로드맵</p>
                                    <!--<p class="Txt0502">SME R &amp; D Rapid Support Messenger</p>-->
                                    <a href="http://www.ndsl.kr" target="_blank" title="중소기업기술로드맵 바로가기">
                                        <img src="/img/smbrnd/main/btn_go01.png" alt="중소기업기술로드맵 메신저"/>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
         <!--Main03 e-->

		<!--MainCont02 s-->
		<!--<div class="MainCont02">
			<div class="BoardWrap01">
				<div class="board01">
					<h2>통합게시판</h2>
					<div class="article article_mn1">
						<h3 class="TitBoard TitBoard01"
							onclick="boardlatestShow(1);return false;">
							<a id="boardtab1" class="on" href="#">통합</a>
						</h3>
						<div class="ConBoard" id="article_list01">
							<ul class="ListBoard" id="boardLatestNotice">
								<li></li>
							</ul>
							<a class="more" href="/smbrnd/sub.do?m=99">더보기<span>+</span></a>
							<!-- <a class="more" href="#">더보기 <span>+</span></a>
						</div>
					</div>
					<div class="article article_mn2">
						<h3 class="TitBoard TitBoard02"
							onclick="boardlatestShow(2);return false;">
							<a id="boardtab2" href="#">JNTIS</a>
						</h3>
						<div class="ConBoard" id="article_list02" style="display: none">
							<ul class="ListBoard" id="boardLatestJntis">
								<li></li>
							</ul>
							<a class="more" href="/smbrnd/sub.do?m=98">더보기<span>+</span></a>
						</div>
					</div>
					<div class="article article_mn3">
						<h3 class="TitBoard TitBoard03"
							onclick="boardlatestShow(3);return false;">
							<a id="boardtab3" href="#">JEINET</a>
						</h3>
						<div class="ConBoard" id="article_list03" style="display: none">
							<ul class="ListBoard" id="boardLatestJeinet">
								<li></li>
							</ul>
							<a class="more"
								href="http://jeinet.jnsp.re.kr/jeinet/sub.do?m=34">더보기<span>+</span></a>
						</div>
					</div>
					<div class="article article_mn4">
						<h3 class="TitBoard TitBoard04"
							onclick="boardlatestShow(4);return false;">
							<a id="boardtab4" href="#">JIPBANK</a>
						</h3>
						<div class="ConBoard" id="article_list04" style="display: none">
							<ul class="ListBoard" id="boardLatestJipBank">
								<li></li>
							</ul>
							<a class="more"
								href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=71">더보기<span>+</span></a>
						</div>
					</div>
				</div>
			</div>
			<div class="BoardWrap02">
				<div class="board02">
					<h2>사업안내</h2>
					<div class="article article_mn3">
						<h3 class="TitBoard TitBoard03"
							onclick="bizlatestShow(1);return false;">
							<a id="biztab1" class="on" href="#">지역사업</a>
						</h3>
						<div class="ConBoard" id="biz_list01">
							<ul class="ListBoard" id="boardLatestProject2">
								<li></li>
							</ul>
							<a class="more" href="/smbrnd/sub.do?m=29">더보기<span>+</span></a>
						</div>
					</div>
					<div class="article article_mn2">
						<h3 class="TitBoard TitBoard02"
							onclick="bizlatestShow(2);return false;">
							<a id="biztab2" href="#">정부사업</a>
						</h3>
						<div class="ConBoard" id="biz_list02" style="display: none">
							<ul class="ListBoard" id="boardLatestProject1">
								<li></li>
							</ul>
							<a class="more" href="/smbrnd/sub.do?m=28">더보기<span>+</span></a>
						</div>
					</div>
					<div class="article article_mn1">
						<h3 class="TitBoard TitBoard01"
							onclick="bizlatestShow(3);return false;">
							<a id="biztab3" href="#">통합</a>
						</h3>
						<div class="ConBoard" id="biz_list03" style="display: none">
							<ul class="ListBoard02" id="boardLatestProject">
								<li></li>
							</ul>
							<a class="more" href="#">더보기<span>+</span></a>
						</div>
					</div>
				</div>
			</div>
			<div class="BoardWrap03">
				<div class="board03">
					<h2>행사교육정보</h2>
					<div class="article article_mn1">
						<h3 class="TitBoard TitBoard01"
							onclick="edulatestShow(1);return false;">
							<a id="edutab1" class="on" href="#">통합</a>
						</h3>
						<div class="ConBoard" id="edu_list01">
							<ul class="ListBoard" id="boardLatestEventEdu">
								<li></li>
							</ul>
							<a class="more02"
								href="/jntis/sub.do?m=32">더보기<span>+</span></a>
						</div>
					</div>
					<div class="article article_mn2">
						<h3 class="TitBoard TitBoard02"
							onclick="edulatestShow(2);return false;">
							<a id="edutab2" href="#">행사정보</a>
						</h3>
						<div class="ConBoard" id="edu_list02" style="display: none;">
							<ul class="ListBoard" id="boardLatestEvent">
								<li></li>
							</ul>
							<a class="more02"
								href="http://jntis.jnsp.re.kr/jntis/sub.do?m=32">더보기<span>+</span></a>
						</div>
					</div>
					<div class="article article_mn3">
						<h3 class="TitBoard TitBoard03"
							onclick="edulatestShow(3);return false;">
							<a id="edutab3" href="#">교육정보</a>
						</h3>
						<div class="ConBoard" id="edu_list03" style="display: none;">
							<ul class="ListBoard" id="boardLatestEdu">
								<li></li>
							</ul>
							<a class="more02" href="/jntis/sub.do?m=34">더보기<span>+</span></a>
						</div>
					</div>
				</div>
			</div>
			<!-- div class="BoardWrap04">
				<div class="board04">
					<h2>보도자료</h2>
					<div class="ConBoard">
						<ul class="ListBoard04" id="boardLatestNews">
							<li>
								<span class="subject">
									<img src="/img/jntis/main/icon_jipbank.png" alt="지식재산 게시판아이콘" />
									<a href="#">타이틀을 입력합니다.</a>
								</span>
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
									 <a class="more02 more03" href="/jntis/sub.do?m=93">더보기<span>+</span></a>
					   </div>
				
				</div>
			</div
		</div>-->
	</div>



	<!--MainCont02 e-->
	<!--MainCont03 s-->
	<!-- <div class="MainCont03">
		<ul>
		<li class="QuickLink01" onclick='location.href="/jntis/sub.do?m=37"'><a href="#" title="과학기술정보">과학기술정보</a></li>
		<li class="QuickLink02" onclick='location.href="/jntis/sub.do?m=115"'><a href="#" title="기업정보">기업정보</a></li>
		<li class="QuickLink03" onclick='window.open("https://www.rnd.or.kr/infoservice/infoservice2_view.jsp?s_a_sido_code=13","_blank")'><a href="#" title="기업연구소정보">기업연구소정보</a></li>
		<li class="QuickLink04" onclick='location.href="/jntis/sub.do?m=84"'><a href="#" title="전문가정보">전문가정보</a></li>
		<li class="QuickLink05" onclick='location.href="/jntis/sub.do?m=81"'><a href="#" title="일자리정보">일자리정보</a></li>
		<li class="QuickLink06" onclick='location.href="/jntis/sub.do?m=56"'><a href="#" title="R&D관심기업정보">R&D관심기업정보</a></li>
		<li class="QuickLink07" onclick='location.href="/jntis/sub.do?m=90"'><a href="#" title="수요조사">수요조사</a></li>
		<li class="QuickLink08" onclick='location.href="/jntis/sub.do?m=90"'><a href="#" title="만족도조사">만족도조사</a></li>
		</ul>
	</div> -->
	<!--MainCont03 e-->

	<!--MainCont04 s-->
	<!--<div class="MainCont04">
		<h2 class="tit_MC04">PHOTO NEWS</h2>
		<ul id="boardListPhoto">
			<li></li>
		</ul>
		<a class="more" href="/jntis/sub.do?m=94">포토뉴스 더보기<span>+</span></a>
	</div>-->
	<!--MainCont04 e-->

	<!--MainCont05 s-->
	<!--<div class="MainCont05">
		<div class="Section0501">
			<h2 class="tit_MC05">R&D 관련정보</h2>
			<ul>
				<li class="MC050101">
					<p class="Tit0501">국가과학기술정보시스템</p>
					<p class="Txt0501">Government R&D Projects</p> <a
					href="https://www.ntis.go.kr/ThMain.do" target="_blank"
					title="국가과학기술정보시스템 홈페이지 바로가기"><img
						src="/img/jntis/main/btn_go.gif" alt="국가과학기술정보시스템" /></a>
				</li>
				<li class="MC050102">
					<p class="Tit0501">국가과학기술정보센터</p>
					<p class="Txt0502">SME R & D Rapid Support Messenger</p> <a
					href="http://www.ndsl.kr" target="_blank" title="국가과학기술정보센터 바로가기"><img
						src="/img/jntis/main/btn_go.gif" alt="국가과학기술정보센터 메신저" /></a>
				</li>
				<li class="MC050103">
					<p class="Tit0501">기업마당</p>
					<p class="Txt0501">Company yard</p> <a
					href="http://www.bizinfo.go.kr/cmm/main/introPage.do"
					title="기업마당 바로가기" target="_blank"><img
						src="/img/jntis/main/btn_go.gif" alt="기업마당" /></a>
				</li>
				<li class="MC050104">
					<p class="Tit0501 MAB10" style="line-height: 25px">
						중소기업 기술개발사업<br />종합관리시스템
					</p> <a href="http://www.smtech.go.kr" target="_blank"
					title="중소기업 기술개발사업 종합관리시스템 바로가기" target="_blank"><img
						src="/img/jntis/main/btn_go.gif" alt="중소기업 기술개발사업 종합관리시스템" /></a>
				</li>
			</ul>
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
					<li style="padding: 1px;"><a
						href="<c:out value='${result.linkUrl}'/>"
						<c:if test="${result.linkTarget == '_BLANK'}">target="_blank"</c:if>
						title="<c:out value='${result.title}'/>"> <img
							src="/<c:url value='${result.atchFileFullPath}'/>"
							alt="<c:out value='${result.content}'/>" />
					</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>-->
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
			<ul id="bannerList" class="BannerList">
			</ul>

			<div class="JeonNam">
				<div class="JeonNamCi">
					<a href="http://www.jeonnam.go.kr/" target="_blank"> <img
						src="/img/main/ci_jeonam.png" alt="생명의 땅 전남, 전라남도"
						title="전남도청 바로가기" class="JeonNamImg" />
					</a>
				</div>
			</div>
		</div>
	</div>
	<!--Banner E-->

</div>
<!--MainContWRap e-->
