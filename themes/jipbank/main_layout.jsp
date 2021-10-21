<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/func.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>
<title>전남지식재산정보은행</title>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="imagetoolbar" content="no" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="keywords" content="" />
       <meta name="description" content="" />


<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/board.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/board_3.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/common.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/main_jipbank.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/media_480.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/jipbank/cont.css" media="all" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="/img/common/ci_jipbank.ico">


<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js'/>"></script>
<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/common.js'/>"></script>

<script type="text/javascript" src="/js/cms/front/func_web.js"></script>

      <%-- <link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/bootstrap.min.css'/>" media="screen">
      <link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/font-awesome.min.css'/>" />
      <link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/main.css'/>" />
      <c:forEach var="css" items="${cssList}">
      <link rel="stylesheet" type="text/css" href="<c:out value='${css}'/>">
      </c:forEach> --%>
      <!--[if lt IE 9]>
      <script src="<c:out value='${LAYOUT_PATH}/js/html5shiv.js'/>"></script>
      <script src="<c:out value='${LAYOUT_PATH}/js/respond.min.js'/>"></script>
      <![endif]-->
      <script type="text/javascript" src="/js/cms/front/func_web.js"></script>

<c:forEach var="js" items="${jsList}">
      <script type="text/javascript" src="<c:out value='${js}'/>"></script>
</c:forEach>

      <link href="/js/cms/front/bxslide/jquery.bxslider.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/cms/front/bxslide/jquery.bxslider.min.js"></script>
<!-- <link href="/css/cms/front/jipbank/main_ces.css" media="all" rel="stylesheet" type="text/css" /> -->

<script type="text/javascript" src="/js/cms/front/main_jipbank_banner.js"></script>
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




				function SearchShow(no) {

                    $('#SearchTab01').attr('class', "");
                    $('#SearchTab02').attr('class', "");
                    $('#SearchTab03').attr('class', "");
                    $('#SearchTab04').attr('class', "");
                    $('#SearchTab0' + no).attr('class', "on");

                    $('#TabList01').hide();
	                $('#TabList02').hide();
	                $('#TabList03').hide();
	                $('#TabList04').hide();
                    $('#TabList0' + no).show();


                  }

                  function boardlatestShow(no, off) {

                        $('#boardtab1').attr('class', "");
                        $('#boardtab2').attr('class', "");
                        $('#boardtab' + no).attr('class', "on");
                        $('#viewMore' + no).show();
                        $('#viewMore' + off).hide();
                        $('#List01').hide();
                        $('#List02').hide();
                        $('#List0' + no).show();


                  }




				  var tabval = 2;
                  function equTabShow(tab,no) {
               	  		if(tab == 9) {
               	  			tab = tabval;
               	  		}else{
               	  			tabval = tab;
               	  		}

                        $('#jipTab01').removeClass('on');
                        $('#jipTab02').removeClass('on');
                        $('#jipTab03').removeClass('on');
                        $('#jipTab0'+tab).addClass('on');


                        $('#photoList_1_1').hide();
                        $('#photoList_1_2').hide();
                        $('#photoList_2_1').hide();
                        $('#photoList_2_2').hide();
                        $('#photoList_3_1').hide();
                        $('#photoList_3_2').hide();

						$('#photoList_'+tab+'_'+no).show();

						if((tab == '3' || tab=='2') && no == '1'){
							//$('#more3').hide();
							$('#more2').hide();

							$('#more'+tab).show();
						}



                  }



                  function dataTabShow(tab,no) {

                        $('#dataTitTab0'+tab).addClass('on');

                        $('#publicList_1_1').hide();
                        $('#publicList_1_2').hide();

                        $('#publicList_'+tab+'_'+no).show();

                  }

                  $(function(){

						if(getCookie('popup20161107')!='done'){
							//(11/11)새창팝업 삭제요청하여서 주석처리함
							//window.open('/popup/index_20161108.jsp','','top=0,left=0,width=413,height=630,scrollbars=no');
						}

                        $('#strTchnlgyTotalCnt').text(strTchnlgyTotalCnt);
                        $('#strMchnCnt').text(strMchnCnt);
                        $('#strIrmcCnt').text(strIrmcCnt);
                        $('#strBioCnt').text(strBioCnt);
                        $('#strKnwldgCnt').text(strKnwldgCnt);
                        $('#strElctyCnt').text(strElctyCnt);
                        $('#strChmstryCnt').text(strChmstryCnt);
                        $('#strEnergyCnt').text(strEnergyCnt);
                        $('#strNowhowCnt').text(strNowhowCnt);

                        // 링크 변동 필요

                        //공지사항
                        var inhtml = "";
                        for(var i = 0 ;i < boardLatestNotice.length;i++){
                              var rs = boardLatestNotice[i];
                              inhtml += '<li>';
                              inhtml += '<a href="/jipbank/sub.do?m=71&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
                              inhtml += rs['SUBJECT'] + '</a>';
                              inhtml += '</li>';
                        }
                        $('#boardLatestNotice').html(inhtml);

                        //공지사항 날짜
                        var inhtml = "";
                        for(var i = 0 ;i < boardLatestNotice.length;i++){
                              var rs = boardLatestNotice[i];
                              inhtml += '<li>';
                              inhtml += rs['FRST_REGIST_PNTTM'];
                              inhtml += '</li>';
                        }
                        $('#boardLatestNoticeData').html(inhtml);
                      //공지사항 사이트
                        var inhtml = "";
                        for(var i = 0 ;i < boardLatestNotice.length;i++){
                              var rs = boardLatestNotice[i];
                              inhtml += '<li>';
                              inhtml += rs['SITE_NM'];
                              inhtml += '</li>';
                        }
                        $('#boardLatestNoticeSite').html(inhtml);
						/*
                        //지원사업
                        var inhtml = "";
                        for(var i = 0 ;i < boardLatestProject.length;i++){
                              var rs = boardLatestProject[i];
                              inhtml += '<li>';
                              inhtml += '<a href="/jipbank/sub.do?m=72&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
                              inhtml += rs['SUBJECT']  + '</a>';
//                              inhtml += rs['FRST_REGIST_PNTTM'];
                              inhtml += '</li>';
                        }
                        $('#boardLatestProject').html(inhtml);

                        //지원사업 날짜
                        var inhtml = "";
                        for(var i = 0 ;i < boardLatestProject.length;i++){
                              var rs = boardLatestProject[i];
                              inhtml += '<li>';
                              inhtml += rs['FRST_REGIST_PNTTM'];
                              inhtml += '</li>';
                        }
                        $('#boardLatestProjectData').html(inhtml);
                      //지원사업 사이트
                        var inhtml = "";
                        for(var i = 0 ;i < boardLatestProject.length;i++){
                              var rs = boardLatestProject[i];
                              inhtml += '<li>';
                              inhtml += rs['SITE_NM'];
                              inhtml += '</li>';
                        }
                        $('#boardLatestProjectSite').html(inhtml);
						*/
                        //포토뉴스
                        inhtml = "";
                        for(var i = 0 ;i < boardListPhoto1.length;i++){
                              if(i == 5) break;
                              var rs = boardListPhoto1[i];
                              var inclass = "";
                              if(i == 4) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=77&boardComIdx=00038&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }else{
                                    inhtml += '<p class="pic"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],8);
                              //inhtml += rs["WRITER_NM"];
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }

                        //boardListBro
                        $('#photoList_1_1').html(inhtml);


                        inhtml = "";
                        for(var i = 0 ;i < boardListPhotoDate1.length;i++){
                              if(i == 5) break;
                              var rs = boardListPhotoDate1[i];
                              var inclass = "";
                              if(i == 4) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=77&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],8);
                              inhtml += rs["WRITER_NM"];
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }
                        //boardListBroData
                        $('#photoList_1_2').html(inhtml);

                        //제품홍보
                        inhtml = "";
                        for(var i = 0 ;i < boardListPhoto2.length;i++){
                              if(i == 5) break;
                              var rs = boardListPhoto2[i];
                              var inclass = "";
                              if(i == 4) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=77&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],10);
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }

                        //boardListBro
                        $('#photoList_2_1').html(inhtml);


                        inhtml = "";
                        for(var i = 0 ;i < boardListPhotoDate2.length;i++){
                              if(i == 5) break;
                              var rs = boardListPhotoDate2[i];
                              var inclass = "";
                              if(i == 4) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=77&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += /* '<p class="subject">'+ */cutStr(rs["SUBJECT"],10)/* +'</p>' */;
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }
                        //boardListBroData
                        $('#photoList_2_2').html(inhtml);
						/*
                        //우수사례
                        inhtml = "";
                        for(var i = 0 ;i < boardListPhoto3.length;i++){
                              if(i == 5) break;
                              var rs = boardListPhoto3[i];
                              var inclass = "";
                              if(i == 4) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=76&boardComIdx=00038&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],10);
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }

                        //boardListBro
                        $('#photoList_3_1').html(inhtml);

                        inhtml = "";
                        for(var i = 0 ;i < boardListPhotoDate3.length;i++){
                              if(i == 5) break;
                              var rs = boardListPhotoDate3[i];
                              var inclass = "";
                              if(i == 4) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=76&boardComIdx=00038&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image01.gif" alt="'+rs["SUBJECT"]+'" width="217" height="157" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],8);
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }
                        //boardListBroData
                        $('#photoList_3_2').html(inhtml);
						*/
						
                        //PUBLICATION
                        inhtml = "";
                        for(var i = 0 ;i < boardListPublic.length;i++){
                              if(i == 6) break;
                              var rs = boardListPublic[i];
                              var inclass = "";
                              if(i == 5) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=58&boardComIdx=00028&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="281" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" width="217" height="281" /></p>';
                              }

                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],10);
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }
                        $('#publicList_1_1').html(inhtml);

                        inhtml = "";
                        for(var i = 0 ;i < boardListPublicDate.length;i++){
                              if(i == 6) break;
                              var rs = boardListPublicDate[i];
                              var inclass = "";
                              if(i == 5) inclass = " class='end' ";
                              var alink = "/jipbank/sub.do?m=58&boardComIdx=00028&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                              inhtml += '<li '+inclass+'>';
                              if(rs["TITLE"] != '' ){
                                    inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="'+rs["SUBJECT"]+'" width="217" height="281" /></p>';
                              }else{
                                    inhtml += '<p class="Pic"><img src="/img/main/no_image02.gif" alt="'+rs["SUBJECT"]+'" width="217" height="281" /></p>';
                              }
                              inhtml += '<em class="TitlePic">';
                              inhtml += '<a href="'+alink+'">';
                              inhtml += cutStr(rs["SUBJECT"],10)
                              inhtml += '</a>';
                              inhtml += '</em>';
                              inhtml += '</li>';
                        }
                        $('#publicList_1_2').html(inhtml);

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
		/*				$('#photoList_3_1 li').eq(3).addClass('end');
						$('#photoList_3_1 li').eq(4).css('display','none');
						$('#photoList_3_2 li').eq(3).addClass('end');
						$('#photoList_3_2 li').eq(4).css('display','none');

						$('#photoList_2_1 li').eq(3).addClass('end');
						$('#photoList_2_1 li').eq(4).css('display','none');
						$('#photoList_2_2 li').eq(3).addClass('end');
						$('#photoList_2_2 li').eq(4).css('display','none');
*/
						$('#publicList_1_1 li').eq(4).addClass('end');
						$('#publicList_1_1 li').eq(5).css('display','none');
						$('#publicList_1_2 li').eq(4).addClass('end');
						$('#publicList_1_2 li').eq(5).css('display','none');
					}else{
	/*					$('#photoList_3_1 li').eq(3).removeClass('end');
						$('#photoList_3_1 li').eq(4).css('display','');
						$('#photoList_3_2 li').eq(3).removeClass('end');
						$('#photoList_3_2 li').eq(4).css('display','');
						$('#photoList_2_1 li').eq(3).removeClass('end');
						$('#photoList_2_1 li').eq(4).css('display','');
						$('#photoList_2_2 li').eq(3).removeClass('end');
						$('#photoList_2_2 li').eq(4).css('display','');
*/
						$('#publicList_1_1 li').eq(4).removeClass('end');
						$('#publicList_1_1 li').eq(5).css('display','');
						$('#publicList_1_2 li').eq(4).removeClass('end');
						$('#publicList_1_2 li').eq(5).css('display','');

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