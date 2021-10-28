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
		<img src="/img/jntis/main/txt_visual.png" alt="세상을 바꾸는 과학기술 전남과학기술정보시스템 Jeonnam Science &amp; Technology Information system" class="txt_visual" id="jntisMainContentStart" tabindex="0"/>
		<div class="VisualLink" >
			<ul class="MVisualLinkList">
				<li class="MVisualLinkList01">
                    <a href="/jntis/sub.do?m=118" title="새창열기" target="_blank">
                        <h3>전남R&D통계정보</h3>
                        <div class="h_icon"></div>
                        <div class="btn_go02"><p class="sound_only">바로가기</p></div>
                    </a>
                </li>
                <li class="MVisualLinkList02">
                    <a href="http://rnd.jnsp.re.kr/" title="새창열기" target="_blank">
                        <h3>전남R&D성과관리시스템</h3>
                        <div class="h_icon02"></div>
                        <div class="btn_go02"><p class="sound_only">바로가기</p></div>
                    </a>
                </li>
			<!--<li class="MVisualLinkList01" onclick="window.open('http://jeinet.jnsp.re.kr/jeinet/main.do')">
					<h3>전남연구장비정보망</h3>
					<p class="MVLTxt">
						지역연구장비를 한곳에!<br /> 장비 상담에서 활용지원까지!
					</p>
					<a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
						<img src="/img/jntis/main/btn_go02.png" alt="전남연구장비정보망 홈페이지 바로가기" />
					</a>
				</li>


				<li class="MVisualLinkList02" onclick="window.open('http://jipbank.jnsp.re.kr/jipbank/main.do')">
			    	<h3>전남지식재산정보은행</h3>
			    		<p class="MVLTxt">
			            	성공적 지식재산활용 지원!<br />
			                지식재산 창출에서 이전·사업화까지
			            </p>
			    		<a href="http://jipbank.jnsp.re.kr/jipbank/main.do" title="새창열기" target="_blank">
			    			<img src="/img/jntis/main/btn_go02.png" alt="전남지식재산정보은행 홈페이지 바로가기" />
			    		</a>
				</li> -->


				<%
					if (mobile1 || mobile2) {
				%>
				
				<li class="MVisualLinkList03">
                    <a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
                        <h3>전남연구장비정보망</h3>
                        <div class="h_icon03"></div>
                        <div class="btn_go02"><p class="sound_only">바로가기</p></div>
                    </a>
                </li>
                <li class="MVisualLinkList04">
                    <a href="http://smbrnd.jnsp.re.kr/smbrnd/main.do" title="새창열기" target="_blank">
                        <h3>전남중소기업 <br/> R&D통합지원플랫폼</h3>
                        <div class="h_icon04"></div>
                        <div class="btn_go02"><p class="sound_only">바로가기</p></div>
                    </a>
                </li>
				<!--<li class="MVisualLinkList03">
					<h3>전남R&D과제관리시스템</h3>
					<p class="MVLTxt">
						과제 관리를 쉽게!<br />한눈에 확인하는 과제관리
					</p>
					<p class="MVLTxt">PC버전에서만 사용가능합니다</p>
				</li>


				<li class="MVisualLinkList04">
					<h3>전남R&D성과관리시스템</h3>
					<p class="MVLTxt">
						성과관리를한번에!<br /> 성과관리 및 분석 제공.
					</p>
					<p class="MVLTxt">PC버전에서만 사용가능합니다</p>
				</li>-->

				<%
					} else {
				%>
				<li class="MVisualLinkList03">
                    <a href="http://jeinet.jnsp.re.kr/jeinet/main.do" title="새창열기" target="_blank">
                        <h3>전남연구장비정보망</h3>
                        <div class="h_icon03"></div>
                        <div class="btn_go02"><p class="sound_only">바로가기</p></div>
                    </a>
                </li>
                <li class="MVisualLinkList04">
                    <a href="http://smbrnd.jnsp.re.kr/smbrnd/main.do" title="새창열기" target="_blank">
                        <h3>전남중소기업<br/>R&D통합지원플랫폼</h3>
                        <div class="h_icon04"></div>
                        <div class="btn_go02"><p class="sound_only">바로가기</p></div>
                    </a>
                </li>

				<!--<li class="MVisualLinkList03" onclick="window.open('http://jrpm.jnsp.re.kr/')">
					<h3>전남R&D과제관리시스템</h3>
					<p class="MVLTxt">
						과제 관리를 쉽게!<br />한눈에 확인하는 과제관리
					</p>
					<a href="http://jrpm.jnsp.re.kr/" title="새창열기" target="_blank">
						<img src="/img/jntis/main/btn_go02.png" alt="전남R&D과제관리시스템 홈페이지 바로가기" />
					</a>
				</li>
				<li class="MVisualLinkList04" onclick="window.open('http://rnd.jnsp.re.kr/')">
					<h3>전남R&D성과관리시스템</h3>
					<p class="MVLTxt">
						성과관리를한번에!<br /> 성과관리 및 분석 제공.
					</p>
					<a href="http://rnd.jnsp.re.kr/" title="새창열기" target="_blank">
						<img src="/img/jntis/main/btn_go02.png" alt="전남R&D성과관리시스템 홈페이지 바로가기" />
					</a>
				</li>-->
				<%
					}
				%>



				<!--<li class="MVisualLinkList05">
			    	<h3>전남조선산업정보망</h3>
			    		<p class="MVLTxt">
			            	전남지역 조선·해양산업의<br />
			    			통합정보제공
			            </p>
			            <a href="http://www.jnship.kr" title="새창열기" target="_blank"><img src="/img/jntis/main/btn_go02.png" alt="전남조선산업정보망 홈페이지 바로가기" /></a>
			    </li>-->



			</ul>
		</div>
		<!--visuallink -->
	</div>
</div>
<!--MainVisualWrap e-->
<div class="MainContBg">
	<!-- 21.05. 07 MainCont01 start-->
	<div class="MainCont01">
        <div class="width1200">
            <div class="MCSection01">
                <ul>
                    <li class="enroll02">
                        <input onclick="popupWindow('orgResvPop','2','width=800, height=1200');" type="button" title="새창열기" alt="기관등록 바로가기" value="기관등록"/>
                    </li>
                </ul>
            </div>

            <!-- 160616 최은성 팀장님 추가 -->
            <script type="text/javascript">
                //<![CDATA[     
                function popupWindow(listMode, userTP) {
                    var settings = 'toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=500,width=1304,left=0,top=0';

                    var popUrl = "/web/popup/" + listMode + ".do?orgType=" + userTP;
                    //var popOption="width=850, height=650, resizable=no, scrollbars=yes, status=no;";
                    var popOption = "width=800, height=1200, resizable=no, scrollbars=yes, status=no;";
                    window.open(popUrl, "orgResv", popOption);

                } //]]>

            </script>
            <!-- 160616 최은성 팀장님 추가 -->

            <div class="MCSection02">
                <h3>기관 등록현황(전남)</h3>
                <ul>
                    <li><span class="title">대학</span>
                        <p class="num"><span id="avg_1_2">0</span><span id="avg_1_2_2"> (0)</span>개 대학</p>
                    </li>
                    <li><span class="title">연구기관</span>
                        <p class="num"><span id="avg_1_3">0</span><span id="avg_1_3_2"> (0)</span>개 기관</p>
                    </li>
                    <li><span class="title">지원기관</span>
                        <p class="num"><span id="avg_1_4">0</span><span id="avg_1_4_2"> (0)</span>개 기관</p>
                    </li>
                    <li><span class="title">기업</span>
                        <p class="num"><span id='avg_1_1'>0</span><span id='avg_1_1_2'> (0)</span>개 기업</p>
                    </li>
                </ul>
                <!-- <a class="more" href="/jntis/sub.do?m=26"><img src="/img/jntis/main/btn_more0101.gif" alt="더보기+" /></a> -->
            </div>
            <div class="MCSection03">
                <h3>연구장비 등록현황(전남)</h3>
                <ul>
                    <li><span class="title">등록기관</span>
                        <p class="num"><span id="avg_2_1">41</span><span id="avg_2_1_2">(40)</span>개 기관</p>
                    </li>
                    <li><span class="title">등록장비수</span>
                        <p class="num"><span id="avg_2_2">2,840</span><span id="avg_2_2_2">(2,591)</span>점</p>
                    </li>
                    <li><span class="title">장비구축비</span>
                        <p class="num"><span id='avg_2_3'>0</span><span id='avg_2_3_2'>(0)</span>억원</p>
                    </li>
                    <li><span class="title">공동활용허용률</span>
                        <p class="num"><span id="avg_2_4">77</span>%</p>
                    </li>
                </ul>
                <!-- <a class="more" href="/jeinet/sub.do?m=86"><img src="/img/jntis/main/btn_more0102.gif" alt="더보기+" /></a> -->
            </div>
            <div class="MCSection04">
                <h3>지식재산 등록현황(전남)</h3>
                <ul>
                    <li><span class="title">등록기관</span>
                        <p class="num"><span id="avg_3_1">-</span><span id="avg_3_1_2">(40)</span>개</p>
                    </li>
                    <li><span class="title">등록기술</span>
                        <p class="num"><span id="avg_3_2">2,840</span><span id="avg_3_2_2">(2,591)</span>건</p>
                    </li>
                    <!--<li><span class="title">이전현황</span>
                        <p class="num"><span id='avg_3_3'>-</span><span id='avg_3_3_2'>(-)</span>건</p>
                    </li>
                    <li><span class="title">기술료현황</span>
                        <p class="num"><span id="avg_3_4">-</span>억원</p>
                    </li>-->
                </ul>
                <!-- <a class="more" href="/jeinet/sub.do?m=86"><img src="/img/jntis/main/btn_more0102.gif" alt="더보기+" /></a> -->
            </div>
        </div>
    </div>
	<!-- 21.05. 07 MainCont01 end-->
	<div class="MainContWrap">

		<div class="MCSsch">
			<div class="sch01">
				<ul>
					<li>
						<button class="sch_btn00 on" alt="특허·실용신안 검색 바로가기" title="새창열림" onclick="window.open('http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=1&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=')">
							<span class="ff_tit">특허·실용신안 검색</span><br>
							<span class="tit_00">PATENT</span>
						</button>
					</li>
					<li>
						<button class="sch_btn00" alt="특허·실용신안 검색 바로가기" title="새창열림" onclick="window.open('http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=searchMore&nowPage=1&listMode=moreBlogList&searchCd=4&searchId=&reDeth1=&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=')">
							<span class="ff_tit">프로그램 검색</span><br>
							<span class="tit_00">PROGRAM</span>
						</button>
					</li>
					<!--<li>
						<button class="sch_btn00">
							<h3>노하우 검색</h3>
							<h1>JIPBANK</h1>
						</button>
					</li>-->
					<li>
					
					<form action="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&listMode=patentBlogList&searchCd=all&searchSelect=" method="post" name="searchBox" target="_blank">
						<input type="text" name="searchSelectText" placeholder="명칭,기술내용,출원번호,등록번호 검색" class="PPJsch" title="명칭,기술내용,출원번호,등록번호 검색창"/>
						<input type="submit" class="bluebtn" value="" alt="검색" title="새창열림"/>
					</form>
					</li>
				</ul>
			</div>
			<div class="sch02">
				<h2>기술분류별</h2>
				<p id="strTchnlgyTotalCnt">[총 4,872건]</p>
				<ul>
					<li>
						<a class="tech on" alt="기계/소재 바로가기" title="새창열림" target="_blank" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=10&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon01.png" alt=""/><br>
							<span>기계/소재</span>
						</a>
						<p id="strMchnCnt">238건</p>
					</li>
					<li>
						<a class="tech" alt="전기/전자 바로가기" title="새창열림" target="_blank" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=10&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon02.png" alt=""/><br>
							<span>전기/전자</span>
						</a>
						<p id="strElctyCnt">119건</p>
					</li>
					<li>
						<a class="tech" alt="정보통신 바로가기" title="새창열림" target="_blank" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=30&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon03.png" alt=""/><br>
							<span>정보통신</span>
						</a>
						<p id="strIrmcCnt">100건</p>
					</li>
					<li>
						<a class="tech" alt="화학 바로가기" title="새창열림" target="_blank" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=40&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon04.png" alt=""/><br>
							<span>화학</span>
						</a>
						<p id="strChmstryCnt">18건</p>
					</li>
					<li>
						<a class="tech" alt="바이오/의료 바로가기" title="새창열림" target="_blank" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=50&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon05.png" alt=""/><br>
							<span>바이오/의료</span>
						</a>
						<p id="strBioCnt">744건</p>
					</li>
					<li>
						<a class="tech" title="새창열림" alt="에너지/자원 바로가기"
						href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=60&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon06.png" alt=""/><br>
							<span>에너지/자원</span>
						</a>
						<p id="strEnergyCnt">58건</p>
					</li>
					<li>
						<a class="tech" alt="기타 바로가기" title="새창열림" target="_blank" href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=57&mode=search&nowPage=1&listMode=patentBlogList&searchCd=all&searchId=&reDeth1=80&reDeth2=&ownOrgNmText=&searchSelect=&searchSelectText=">
							<img src="/img/jntis/main/icon08.png" alt=""/><br>
							<span>기타</span>
						</a>
						<p id="strNowhowCnt">3,595건</p>
					</li>
				</ul>
			</div>
		</div>

		<div class="MainCont02">
			<div class="left">
				<!--<div class="BoardWrap01">
					<div class="board01">
						<h2>통합게시판 <a class="more" href="http://jntis.jnsp.re.kr/jntis/sub.do?m=99">+</a></h2>
						<div class="article article_mn1">
							<!--<h3 class="TitBoard TitBoard01" onclick="boardlatestShow(1);return false;">
								<a id="boardtab1" class="on" href="#">통합</a>
							</h3>
							<div class="ConBoard" id="article_list01">
								<ul class="ListBoard" id="boardLatestNotice">
									<li></li>
								</ul>
								<!-- <a class="more" href="#">더보기 <span>+</span></a>
							</div>
						</div>
	
						<!-- <div class="article article_mn2">
							<h3 class="TitBoard TitBoard02"
								onclick="boardlatestShow(2);return false;">
								<a id="boardtab2" href="#">JNTIS</a>
							</h3>
							<div class="ConBoard" id="article_list02" style="display: none">
								<ul class="ListBoard" id="boardLatestJntis">
									<li></li>
								</ul>
								<a class="more" href="http://jntis.jnsp.re.kr/jntis/sub.do?m=98">더보기<span>+</span></a>
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
				</div>-->
				<!-- div class="BoardWrap02">
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
								<a class="more" href="/jntis/sub.do?m=29">더보기<span>+</span></a>
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
								<a class="more" href="/jntis/sub.do?m=28">더보기<span>+</span></a>
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
				</div-->
				<div class="BoardWrap03">
					<div class="board03">
						<h2>통합게시판</h2>
						<div class="article article_mn1">
							<h3 class="TitBoard TitBoard01"
								onclick="edulatestShow(1);return false;">
								<a id="edutab1" class="on" href="#">통합</a>
							</h3>
							<div class="ConBoard" id="edu_list01">
								<ul class="ListBoard" id="boardLatestEventEdu">
									<li></li>
								</ul>
                                <!--<a class="more" href="/jntis/sub.do?m=32" title="통합 더보기">+</a>-->
							</div>
						</div>
						<div class="article article_mn2">
							<h3 class="TitBoard TitBoard02"
								onclick="edulatestShow(2);return false;">
								<a id="edutab2" href="#">공지사항</a>
							</h3>
							<div class="ConBoard" id="edu_list02" style="display: none;">
								<ul class="ListBoard" id="boardLatestJntis">
									<li></li>
								</ul>
								<a class="more" href="/jntis/sub.do?m=98" title="공지사항 더보기"><span class="sound_only">공지사항 더보기</span>+</a>
							</div>
						</div>
						<div class="article article_mn3">
							<h3 class="TitBoard TitBoard03"
								onclick="edulatestShow(3);return false;">
								<a id="edutab3" href="#">행사정보</a>
							</h3>
							<div class="ConBoard" id="edu_list03" style="display: none;">
								<ul class="ListBoard" id="boardLatestEvent">
									<li></li>
								</ul>
								<a class="more" href="/jntis/sub.do?m=32" title="행사정보 더보기"><span class="sound_only">행사정보 더보기</span>+</a>
							</div>
						</div>
						<div class="article article_mn4">
							<h3 class="TitBoard TitBoard04"
								onclick="edulatestShow(4);return false;">
								<a id="edutab4" href="#">교육정보</a>
							</h3>
							<div class="ConBoard" id="edu_list04" style="display: none;">
								<ul class="ListBoard" id="boardLatestEdu">
									<li></li>
								</ul>
								<a class="more" href="/jntis/sub.do?m=34" title="교육정보 더보기"><span class="sound_only">교육정보 더보기</span>+</a>
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
										<a href="#">타이틀을 입력합니다.</a>
									</span>
									<span class="date">2016-05-16</span>
							 	</li>
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
										<a href="#">타이틀을 입력합니다.</a>
									</span>
									<span class="date">2016-05-16</span>
								</li>
								<li>
									<span class="subject">
										<img src="/img/jntis/main/icon_jeinet.png" alt="연구장비정보망 게시판아이콘" />
										<a href="#">타이틀을 입력합니다.</a>
									</span>
								 	<span class="date">2016-05-16</span>
								</li>
							</ul>
							<a class="more02 more03" href="/jntis/sub.do?m=93">더보기<span>+</span></a>
						</div>
					
					</div>
				</div-->

			</div>
			<div class="right">
				<script type="text/javascript">

					$(function() {
						var tabMenu = $(".Bheader");

						//컨텐츠 내용을 숨겨주세요!
						tabMenu.find("ul > li > .busi_info").hide();
						tabMenu.find("li.active > .busi_info").show();

						//두번째 버튼 클릭 --> 모든 active 삭제 --> 내가 클릭한 버튼 active 추가
						function tabList(e){
						e.preventDefault(); //#의 기능을 차단
						var target = $(this);
						target.next().show().parent("li").addClass("active").siblings("li").removeClass("active").find(".busi_info").hide();    
						//버튼을 클릭하면 ~ div를 보여주고
						//부모의 li 태그에 클래스를 추가하고
						//형제의 li 태그에 클래스를 제거하고
						//제거한 자식의 div 태그를 숨겨줌
						}

						tabMenu.find("ul > li > .tab_btn").click(tabList).focus(tabList);

					    /*$(".hd_tab li").on("click", function() {
							var $this = $(this);
					    	var tab_idx = $this.index();
					    	var $tab_con = $(".tab_content");
							
							$(".hd_tab li").filter(".on").removeClass("on");
	
							$this.addClass("on");
	
					    	$tab_con.removeClass("on");
					    	$tab_con.eq(tab_idx).addClass("on");
					    });*/




						$(".MCSsch .sch_btn00").on("click", function() {
							var $this = $(this);
					    	var tab_idx = $this.index();
							
							$(".MCSsch .sch_btn00").filter(".on").removeClass("on");
							$this.addClass("on");
	
					    });

						$(".MCSsch .tech").on("click", function() {
							var $this = $(this);
					    	var tab_idx = $this.index();
							
							$(".MCSsch .tech").filter(".on").removeClass("on");
							$this.addClass("on");
	
					    });
	
	
					});

				</script>
				<div class="busi_latest">
                    <div class="Bheader">
                        <ul class="hd_tab">
                            <li class="active">
								<a href="#" class="tab_btn">지역사업</a>
								<div class="busi_info">
									 <ul id="boardLatestProject2">
										 
									 </ul>
								 </div>
							</li>
                            <li>
								<a href="#" class="tab_btn">정부사업</a>
								<div class="busi_info">
									 <ul id="boardLatestProject1">
										 
									 </ul>
								 </div>
							</li>
                            <li>
								<a href="#" class="tab_btn">통합</a>
								<div class="busi_info">
									 <ul id="boardLatestProject">
										 
									 </ul>
								 </div>
							</li>
                        </ul>
                    </div>
                </div>
            </div>
		</div>
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
	<div class="MainCont04">
		<h2 class="tit_MC04">PHOTO NEWS<a class="more" href="/jntis/sub.do?m=94" title="포토뉴스 더보기"><span class="sound_only">포토뉴스 더보기</span>+</a></h2>
		<ul id="boardListPhoto">
			<li></li>
		</ul>
	</div>
	<!--MainCont04 e-->

	<!--MainCont05 s-->
	<div class="MainCont05">
        <div class="Section0501">
            <h2 class="tit_MC05">R&amp;D 관련정보</h2>
            <ul>
                <li class="MC050101">
                    <p class="Tit0501">국가과학기술정보시스템</p>
                    <p class="Txt0501">Government R&amp;D Projects</p>
                    <a href="https://www.ntis.go.kr/ThMain.do" target="_blank" title="국가과학기술정보시스템 홈페이지 새창열기">
                        <img src="/img/jntis/main/btn_go01.png" alt="국가과학기술정보시스템 바로가기" class="go"/>
                    </a>
                </li>
                <li class="MC050102">
                    <p class="Tit0501">사이언스 ON</p>
                    <p class="Txt0502">Sience ON</p>
                    <a href="https://scienceon.kisti.re.kr/main/mainForm.do" target="_blank" title="사이언스 온 새창열기">
                        <img src="/img/jntis/main/btn_go01.png" alt="사이언스 온 바로가기" class="go"/>
                    </a>
                </li>
                <li class="MC050103">
                    <p class="Tit0501">기업마당</p>
                    <p class="Txt0501">Company yard</p>
                    <a href="http://www.bizinfo.go.kr/cmm/main/introPage.do" title="기업마당 새창열기" target="_blank">
                        <img src="/img/jntis/main/btn_go01.png" alt="기업마당 바로가기" class="go"/>
                    </a>
                </li>
                <li class="MC050104">
                    <p class="Tit0501 MAB10" style="line-height: 25px">중소기업 기술개발사업<br/>종합관리시스템</p>
                    <a href="http://www.smtech.go.kr" target="_blank" title="중소기업 기술개발사업 종합관리시스템 새창열기">
                        <img src="/img/jntis/main/btn_go01.png" alt="중소기업 기술개발사업 종합관리시스템 바로가기" class="go"/>
                    </a>
                </li>
            </ul>
        </div>

		<div class="Section0502">
			<h2 class="tit_MC0502">POPUP ZONE</h2>
			<!--<ul class="PopupControl">
				<li><a class="BtnPrev" href="javascript:silderPrev();">이전으로</a></li>
				<li><a class="BtnNext" href="javascript:silderNext();">다음으로</a></li>
				<li><a class="BtnStop" href="javascript:silderStop();">정지</a></li>
				<li><a class="BtnPlay" href="javascript:silderPlay();">재생</a></li>
			</ul>-->
			<ul class="PopupList02" id="PopupList02">

				<c:forEach var="result" items="${popupzoneList}" varStatus="status">
					<li style="padding: 1px;">
						<a href="<c:out value='${result.linkUrl}'/>" <c:if test="${result.linkTarget == '_BLANK'}">target="_blank"</c:if> title="<c:out value='${result.title}'/>">
							<img src="/<c:url value='${result.atchFileFullPath}'/>" alt="<c:out value='${result.content}'/>" />
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

			<ul id="bannerList" class="BannerList">
			</ul>

			<div class="JeonNam">
				<div class="JeonNamCi">
					<a href="http://www.jeonnam.go.kr/" target="_blank">
						<img src="/img/main/ci_jeonam.png" alt="생명의 땅 전남, 전라남도" title="전남도청 바로가기" class="JeonNamImg" />
					</a>
				</div>
			</div>
		</div>
	</div>
	<!--Banner E-->

</div>
