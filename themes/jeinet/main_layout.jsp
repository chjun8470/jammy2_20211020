<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/func.jsp"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pargma", "no-cache");
response.setHeader("Expires", "-1");

String jsDateStr = "";
info.elsys.jnsp.util.ComUtil jsComUtil = new info.elsys.jnsp.util.ComUtil();
jsDateStr = jsComUtil.getCDate("yyyyMMddhh");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>
<title>전남연구장비정보망</title>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<meta http-equiv="imagetoolbar" content="no"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="keywords" content="전남연구장비정보망,전남 연구장비,전남장비,연구장비,공동장비,공동활용장비,전남 연구장비 쉐어링"/>
	<meta name="description" content=""/>

<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="No-Cache" />



<link rel="shortcut icon" href="/img/common/ci_jeinet.ico" />

<!--[if lte IE 8]>
<link href="/css/cms/front/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css" />
<script src="/css/cms/front/respond.min.js" type="text/javascript"></script>
<![endif]-->

<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js'/>"></script>
<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/common.js'/>"></script>

<script type="text/javascript" src="/js/cms/front/func_web.js"></script>

<c:forEach var="js" items="${jsList}">
	<script type="text/javascript" src="<c:out value='${js}'/>"></script>
</c:forEach>


	<link href="/js/cms/front/bxslide/jquery.bxslider.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/cms/front/bxslide/jquery.bxslider.min.js"></script>

		
	<script type="text/javascript" src="/js/cms/front/main_banner.js?v=<%=jsDateStr%>"></script>
	
	<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/common.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/board.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/sub.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/main.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/media_960.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css" />


  <!-- End SlidesJS Required -->
  	<script type="text/javascript">
  	
  //<![CDATA[
	  	var popZone = "";
	  	$(function(){
	  		  popZone = $('#PopupList').bxSlider({
	    		  randomStart:true,
		  		  auto: true,
			  	  slideWidth: 335,
			  	  wrapperClass:'bx-wrapper',
			  	  controls:false
		  		});

	     });

	  	function silderPrev(){
	  		popZone.goToPrevSlide();
			return;
	  	}
		function silderNext(){
	  		popZone.goToNextSlide();
			return;
	  	}
		function silderStop(){
	  		popZone.stopAuto();
			return;
	  	}
		function silderPlay(){
	  		popZone.startAuto();
			return;
	  	}

		function getCookie(name){
            var nameOfCookie=name+'=';
            var x=0;
            while(x<=document.cookie.length){
                   var y=(x+nameOfCookie.length);
                         if(document.cookie.substring(x,y)==nameOfCookie){
                                if((endOfCookie=document.cookie.indexOf(';',y))==-1)
                                              endOfCookie=document.cookie.length;
                                              return unescape(document.cookie.substring(y,endOfCookie));
                                       }
                                x=document.cookie.indexOf('',x)+1;
                                if(x==0)
                         break;
                   }
            return;
	    }

			//배너 모음 S

			//Banner 타입 배너가 우에서 좌로 흐르는 타입
			//최초 모든 배너들이 잘 늘어서도록 처리해야 한다.
			
			
			
			jQuery(function() {

					var banners = jQuery(".BannerList");
					

					//배너 데이터 세팅
					var inhtml = "";
					for(var bl=0;bl<bannerList.length;bl++) {
						inhtml += "<li>";
						inhtml += "<a href=" + bannerList[bl]['BANNER_LINK'] + " target=\"_blank\" jnsp_isfocus=\"false\" style=\"left: 160px; top: 0px;\">";
						inhtml += "<img src=" + bannerList[bl]['FILE_PATH'] + bannerList[bl]['TITLE'] + " alt=" + bannerList[bl]['BANNER_NAME'] + " title=" + bannerList[bl]['BANNER_NAME'] + " 바로가기>";
						inhtml += "</a>";
						inhtml += "</li>";
					}
					$("#bannerList").append(inhtml);

					for(var bi=0;bi<banners.length;bi++) {

						jQuery(banners[bi]).attr("jnsp_dir", "+");

						var siblings = jQuery(banners[bi]).children();
						var x = 0;

						for(var i=0;i<siblings.length;i++) {
							jQuery(jQuery(siblings[i]).children()[0]).css("left", x);
							jQuery(jQuery(siblings[i]).children()[0]).css("top", 0);
							x += (parseInt(jQuery(jQuery(siblings[i]).children()[0]).css("width")) + 5);
							jQuery(jQuery(siblings[i]).children()[0]).attr("jnsp_isFocus", "false");
						}
					}
				}
			);



			//focus를 가지거나 마우스가 올라오면 멈춘다.
			jQuery(
				function() {
					jQuery(".BannerList li a").focus(
						function() {
							jQuery(this).attr("jnsp_isFocus", "true");
						}
					);
				}
			);

			jQuery(
				function() {
					jQuery(".BannerList li a").blur(
						function() {
							jQuery(this).attr("jnsp_isFocus", "false");
						}
					);
				}
			);

			jQuery(
				function() {
					jQuery(".BannerList li a").mouseover(
						function() {
							jQuery(this).attr("jnsp_isFocus", "true");
						}
					);
				}
			);

			jQuery(
				function() {
					jQuery(".BannerList li a").mouseout(
						function() {
							jQuery(this).attr("jnsp_isFocus", "false");
						}
					);
				}
			);



			//흐르게 한다.
			jQuery(
				function() {
					var banners = jQuery(".BannerList");
					if(banners.length > 0) {

						setInterval(
							function() {
								for(var bi=0;bi<banners.length;bi++) {
									var siblings = jQuery(banners[bi]).children();
									var isFocus = false;
									for(var i=0;i<siblings.length;i++) {
										if(jQuery(jQuery(siblings[i]).children()[0]).attr("jnsp_isFocus") == "true") {
											isFocus = true;
											break;
										}
									}
									if(!isFocus) {
										var prev = jQuery(banners[bi]).scrollLeft();
										if(jQuery(banners[bi]).attr("jnsp_dir") == "+") {
											jQuery(banners[bi]).scrollLeft(jQuery(banners[bi]).scrollLeft()+2);
										} else {
											jQuery(banners[bi]).scrollLeft(jQuery(banners[bi]).scrollLeft()-2);
										}
										if(prev == jQuery(banners[bi]).scrollLeft()) {
											if(jQuery(banners[bi]).attr("jnsp_dir") == "+") {
												jQuery(banners[bi]).attr("jnsp_dir", "-");
											} else {
												jQuery(banners[bi]).attr("jnsp_dir", "+");
											}
										}
									}
								}
							}
							,50
						);
					}
				}
			);

			



			jQuery(function() {

			     jQuery("#rolling_stop").click(
			         function() {
			             $(".BannerList li a").attr("jnsp_isFocus", "true");
			         }
			     )
			     jQuery("#rolling_right").click(
			         function() {
			             jQuery(".BannerList li a").attr("jnsp_isFocus", "false");
			             jQuery(".BannerList").attr("jnsp_dir", "-");

			         }
			     )
					jQuery("#rolling_play").click(
			         function() {
			             jQuery(".BannerList li a").attr("jnsp_isFocus", "false");
			             jQuery(".BannerList").attr("jnsp_dir", "-");

			         }
			     )
			     jQuery("#rolling_left").click(
			         function() {
			             jQuery(".BannerList li a").attr("jnsp_isFocus", "false");
			             jQuery(".BannerList").attr("jnsp_dir", "+");

			         }
			     )
			});





			function boardlatestShow(no) {

				$('#boardtab1').attr('class', "");
				$('#boardtab2').attr('class', "");
				$('#boardtab3').attr('class', "");
				$('#boardtab' + no).attr('class', "on");

				$('#article_list01').hide();
				$('#article_list02').hide();
				$('#article_list03').hide();
				$('#article_list0' + no).show();


			}

			function equTabShow(tab,no) {

				$('#equTitTab01').removeClass('on');
				$('#equTitTab02').removeClass('on');
				$('#equTitTab03').removeClass('on');
				$('#equTitTab0'+tab).addClass('on');

				$('#equTab1').hide();
				$('#equTab2').hide();
				$('#equTab3').hide();
				$('#equTab'+tab).show();

				$('#equList_1_1').hide();
				$('#equList_1_2').hide();
				$('#equList_2_1').hide();
				$('#equList_2_2').hide();
				$('#equList_3_1').hide();
				$('#equList_3_2').hide();

				$('#equList_'+tab+'_'+no).show();

			}



			function dataTabShow(tab,no) {

				$('#dataTitTab01').removeClass('on');
				$('#dataTitTab02').removeClass('on');
				$('#dataTitTab03').removeClass('on');
				$('#dataTitTab04').removeClass('on');
				$('#dataTitTab0'+tab).addClass('on');

				$('#dataTab1').hide();
				$('#dataTab2').hide();
				$('#dataTab3').hide();
				$('#dataTab4').hide();
				$('#dataTab'+tab).show();

				$('#dataList_1_1').hide();
				$('#dataList_1_2').hide();
				$('#dataList_2_1').hide();
				$('#dataList_2_2').hide();
				$('#dataList_3_1').hide();
				$('#dataList_3_2').hide();
				$('#dataList_4_1').hide();
				$('#dataList_4_2').hide();

				$('#dataList_'+tab+'_'+no).show();

			}


			$(function(){

				//Popup
				if(getCookie('popup20180206')!='done'){
				   // 팝업추가 180206
				 window.open('/popup/index_20180206.jsp','popup20180206','top=200,left=180,width=750,height=590,scrollbars=no');
				}
				/* if(getCookie('popup20170830')!='done'){
					window.open('/popup/index_20170830.jsp','','top=0,left=0,width=413,height=665,scrollbars=no');
				} */
				
				

				$('#strDate').text(strDate + " 기준");
				
				$('#strEnterpriseCnt').html(strEnterpriseCnt+"<e>기관</e>");
				$('#strJEnterpriseCnt').html(strJEnterpriseCnt+"<e>기관</e>");
				
				$('#strEquCnt').html(strEquCnt+"<e>점</e>");
				$('#strJEquCnt').html(strJEquCnt+"<e>점</e>");
				
				$('#strEquPrcCnt').html(strEquPrcCnt+"<e>억원</e>");
				$('#strJEquPrcCnt').html(strJEquPrcCnt+"<e>억원</e>");
				
				$('#strEquUseCntPer').html(strEquUseCntPer+"<e>%</e>");
				$('#strJEquUseCntPer').html(strJEquUseCntPer+"<e>%</e>");

				//공지사항
				var inhtml = "";
				for(var i = 0 ;i < boardLatestNotice.length;i++){
					var rs = boardLatestNotice[i];
					inhtml += '<li><span class="subject">';
					inhtml += '<a href="http://jntis.jnsp.re.kr/jntis/sub.do?m=98&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" target="_brank">';
					inhtml += rs['SUBJECT'] + '</a>';
					inhtml += '</span>';
					inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM'];
					inhtml += '</span></li>';
				}
				$('#boardLatestNotice').html(inhtml);

				//지원사업
				/*
				inhtml = "";
				for(var i = 0 ;i < boardLatestProject.length;i++){
					var rs = boardLatestProject[i];
					inhtml += '<li><span class="subject">';
					inhtml += '<a href="/jeinet/sub.do?m=82&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					inhtml += rs['SUBJECT'] + '</a>';
					inhtml += '</span>';
					inhtml += '<span class="date"><span class="company">'+rs['WRITER_NM']+'</span>'+rs['FRST_REGIST_PNTTM'];
					inhtml += '</span></li>';
				}
				$('#boardLatestProject').html(inhtml);


				//보도자료
				inhtml = "";
				for(var i = 0 ;i < boardLatestNews.length;i++){
					var rs = boardLatestNews[i];
					inhtml += '<li><span class="subject">';
					inhtml += '<a href="/jeinet/sub.do?m=83&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					inhtml += rs['SUBJECT'] + '</a>';
					inhtml += '</span>';
					inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span></li>';
				}
				$('#boardLatestNews').html(inhtml);
				*/
				
				
				
				//JEINET장비
				inhtml = "";
				for(var i = 0 ;i < boardListEqu.length;i++){
					if(i == 4) break;
					var rs = boardListEqu[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?mode=view&listMode=imagelist&m=53&rndEquIdx="+rs['RND_EQU_IDX'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					inhtml += '<span class="photo">';
					if(rs["TITLE"] != '' ){
						inhtml += '<img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["KOR_NM"]+'" />';
					}else{
						inhtml += '<img src="/img/main/no_image01.gif" alt="'+rs["KOR_NM"]+'" />';
					}
					inhtml += '</span>';
					inhtml += '<span class="TitPhoto">';
					inhtml += '<p class="agency">'+rs["OWN_ORG_NM"]+'</p>';
					inhtml += '<p class="subject">'+cutStr(rs["KOR_NM"],18)+'</p>';
					//OWN_ORG_SUB_NM
					inhtml += '</span>';
					inhtml += '</a>';
					inhtml += '</li>';

				}
				//boardListEqu
				$('#equList_1_1').html(inhtml);


				//장비 최신글순
				inhtml = "";
				for(var i = 0 ;i < boardListEquDate.length;i++){
					if(i == 4) break;
					var rs = boardListEquDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?mode=view&listMode=imagelist&m=53&rndEquIdx="+rs['RND_EQU_IDX'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					inhtml += '<span class="photo">';
					if(rs["TITLE"] != '' ){
						inhtml += '<img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["KOR_NM"]+'" />';
					}else{
						inhtml += '<img src="/img/main/no_image01.gif" alt="'+rs["KOR_NM"]+'" />';
					}
					inhtml += '</span>';
					inhtml += '<span class="TitPhoto">';
					inhtml += '<p class="agency">'+rs["OWN_ORG_NM"]+'</p>';
					inhtml += '<p class="subject">'+cutStr(rs["KOR_NM"],18)+'</p>';
					inhtml += '</span>';
					inhtml += '</a>';
					inhtml += '</li>';

				}


				//boardListEquDate
				$('#equList_1_2').html(inhtml);





				//포토뉴스
				inhtml = "";
				for(var i = 0 ;i < boardListPhoto.length;i++){
					if(i == 4) break;
					var rs = boardListPhoto[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=85&boardComIdx=00018&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],18)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}

				//boardListBro
				$('#equList_2_1').html(inhtml);


				inhtml = "";
				for(var i = 0 ;i < boardListPhotoDate.length;i++){
					if(i == 4) break;
					var rs = boardListPhotoDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=85&boardComIdx=00018&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],18)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}



				//boardListBroData
				$('#equList_2_2').html(inhtml);




				// 우수사례

				inhtml = "";
				for(var i = 0 ;i < boardListNumOne.length;i++){
					if(i == 4) break;
					var rs = boardListNumOneDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=64&boardComIdx=00018&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],18)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}

				$('#equList_3_1').html(inhtml);

				// 우수사례 recent
				inhtml = "";
				for(var i = 0 ;i < boardListNumOneDate.length;i++){
					if(i == 4) break;
					var rs = boardListNumOneDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=64&boardComIdx=00018&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],18)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}

				$('#equList_3_2').html(inhtml);









				// 브로슈어
				inhtml = "";
				for(var i = 0 ;i < boardListBro.length;i++){
					//console.log("i = "+i);
					if(i == 4) break;
					var rs = boardListBro[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=77&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}

					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],36)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_1_1').html(inhtml);


				inhtml = "";
				for(var i = 0 ;i < boardListBroDate.length;i++){
					if(i == 4) break;
					var rs = boardListBroDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=77&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],36)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_1_2').html(inhtml);
				
				
				
				//장비정보
				inhtml = "";
				for(var i = 0 ;i < boardListLaw.length;i++){
					//console.log("i = "+i);
					if(i == 4) break;
					var rs = boardListLaw[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=73&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}

					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],36)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_2_1').html(inhtml);


				inhtml = "";
				for(var i = 0 ;i < boardListLawDate.length;i++){
					if(i == 4) break;
					var rs = boardListLawDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=73&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],36)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_2_2').html(inhtml);
				
				

				/*
				// 정책이슈
				inhtml = "";
				for(var i = 0 ;i < boardListPolicy.length;i++){
					if(i == 5) break;
					var rs = boardListPolicyDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=54&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],36)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_2_1').html(inhtml);

				inhtml = "";
				for(var i = 0 ;i < boardListLawordDate.length;i++){
					if(i == 5) break;
					var rs = boardListLawordDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=54&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],36)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_2_2').html(inhtml);
				*/
				
				/*
				// 통계자료
				inhtml = "";
				for(var i = 0 ;i < boardListStats.length;i++){
					if(i == 5) break;
					var rs = boardListStats[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";

					var alink = "/jeinet/sub.do?m=74&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],8)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_3_1').html(inhtml);

				// 통계자료 최신순
				inhtml = "";
				for(var i = 0 ;i < boardListStatsDate.length;i++){
					if(i == 5) break;
					var rs = boardListStatsDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=74&boardComIdx=00012&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],8)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}
				$('#dataList_3_2').html(inhtml);
				*/

				/*
				// 기타발간물
				inhtml = "";
				for(var i = 0 ;i < boardListLaword.length;i++){
					if(i == 5) break;
					var rs = boardListLawordDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=75&boardComIdx=00020&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],8)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';

				}
				$('#dataList_4_1').html(inhtml);

				
				
				// 기타발간물 최신
				inhtml = "";
				for(var i = 0 ;i < boardListLawordDate.length;i++){
					if(i == 5) break;
					var rs = boardListLawordDate[i];
					var inclass = "";
					if(i == 4) inclass = " class='end' ";
					var alink = "/jeinet/sub.do?m=75&boardComIdx=00020&mode=view&&boardIdx="+rs['ARTICLE_ID'];
					inhtml += '<li '+inclass+'>';
					inhtml += '<a href="'+alink+'">';
					if(rs["TITLE"] != '' ){
						inhtml += '<div class="photo"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" /></div>';
					}else{
						inhtml += '<div class="photo"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" /></div>';
					}
					inhtml += '<div class="TitPhoto">';
					inhtml += '<p class="subject">'+cutStr(rs["SUBJECT"],8)+'</p>';

					inhtml += '</div>';
					inhtml += '</a>';
					inhtml += '</li>';
				}

				$('#dataList_4_2').html(inhtml);
				*/
			
				
			});

			function cutStr(str,no){
				if(str.length <= no){
					return str;
				}else{
					return str.substring(0,no)+"...";
				}
			}

			$(function (){
				$(window).resize(function(){
					resizeShow();
				});

				resizeShow();

			});


			function resizeShow(){

				var w_win = $(window).width();

					if(w_win <=  768 ){
						$('#dataList_1_1 li').eq(3).addClass('end');
						$('#dataList_1_1 li').eq(4).css('display','none');
						$('#dataList_1_2 li').eq(3).addClass('end');
						$('#dataList_1_2 li').eq(4).css('display','none');
						$('#dataList_2_1 li').eq(3).addClass('end');
						$('#dataList_2_1 li').eq(4).css('display','none');
						$('#dataList_2_2 li').eq(3).addClass('end');
						$('#dataList_2_2 li').eq(4).css('display','none');
						$('#dataList_3_1 li').eq(3).addClass('end');
						$('#dataList_3_1 li').eq(4).css('display','none');
						$('#dataList_3_2 li').eq(3).addClass('end');
						$('#dataList_3_2 li').eq(4).css('display','none');
						$('#dataList_4_1 li').eq(3).addClass('end');
						$('#dataList_4_1 li').eq(4).css('display','none');
						$('#dataList_4_2 li').eq(3).addClass('end');
						$('#dataList_4_2 li').eq(4).css('display','none');
					}else{
						$('#dataList_1_1 li').eq(3).removeClass('end');
						$('#dataList_1_1 li').eq(4).css('display','');
						$('#dataList_1_2 li').eq(3).removeClass('end');
						$('#dataList_1_2 li').eq(4).css('display','');
						$('#dataList_2_1 li').eq(3).removeClass('end');
						$('#dataList_2_1 li').eq(4).css('display','');
						$('#dataList_2_2 li').eq(3).removeClass('end');
						$('#dataList_2_2 li').eq(4).css('display','');
						$('#dataList_3_1 li').eq(3).removeClass('end');
						$('#dataList_3_1 li').eq(4).css('display','');
						$('#dataList_3_2 li').eq(3).removeClass('end');
						$('#dataList_3_2 li').eq(4).css('display','');
						$('#dataList_4_1 li').eq(3).removeClass('end');
						$('#dataList_4_1 li').eq(4).css('display','');
						$('#dataList_4_2 li').eq(3).removeClass('end');
						$('#dataList_4_2 li').eq(4).css('display','');
					}
			}
		//]]>
		</script>
</head>
<body>

<!--Wrap S-->
<div class="Wrap">

	<!--HeaderWrap S-->
	<div class="HeaderWrap">
		<%@include file="include/header.jsp"%>
	</div>

	<c:import url="${contentFile}" />

	<!--FooterWrap S-->
	<div class="FooterWrap">
		<%@include file="include/footer.jsp"%>
	</div>

</div>
<!--Wrap e-->
</body>
</html>
