<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/func.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>
<title>전남과학기술정보시스템</title>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta http-equiv="imagetoolbar" content="no"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="keywords" content=""/>
	<meta name="description" content=""/>

<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/smbrnd/common.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/smbrnd/main.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/smbrnd/sub.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/smbrnd/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/smbrnd/media_480.css" media="all" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="/img/common/ci_jntis.ico" />

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
	<script type="text/javascript" src="/js/slick.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/js/slick.css"/>
	
	<link href="/js/cms/front/bxslide/jquery.bxslider.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/cms/front/bxslide/jquery.bxslider.js"></script>
    <script type="text/javascript" src="/js/cms/front/main_smbrnd_banner.js?v=${jsVersion}"></script>
    <script type="text/javascript" src="/js/cms/front/bxslide/js_allim3.js"></script> 

  <!-- End SlidesJS Required -->
  	<script type="text/javascript">
  //<![CDATA[

	  	var popZone = "";
	  	$(document).ready(function(){
	  			popZone = $('#PopupList02').bxSlider({
					randomStart:false,
					auto: true,
					slideWidth: 456,
					wrapperClass:'bx-wrapper',
					controls:false
		  		});
			//bxslider 탭키 접근 20180827 시작
			$('#PopupList02 li:first-child a').on('keyup', function(e){
				if(e.which == 9 && !e.shiftKey ){//탭키
					console.log("tabChange");
					popZone.reloadSlider({
						auto: false,
						infiniteLoop : false,
						autoHover : false,
						slideWidth: 456,
						wrapperClass:'bx-wrapper',
						controls:false
					});
					setTimeout(function(){$('#PopupList02 > li:first-child > a').focus();}, 200);
				}
			});
			$('#PopupList02 > li > a').on('focusin', function(){
				console.log('foucsin');
				var idx = $(this).parent().index();
				var banText = $(this).find('img').attr('alt');
				$(this).parent('li').removeClass('active');
				$(this).parent('li').addClass('active');
			});
			//bxslider 탭키 접근 20180827 종료

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

		function silderMove(idx){
	  		popZone.goToSlide(idx);
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
						inhtml += "<a href=" + bannerList[bl]['BANNER_LINK'] + " target=\"_blank\" jnsp_isfocus=\"false\" style=\"left: 160px; top: 0px;\"  title='" + bannerList[bl]['BANNER_NAME'] + " 바로가기(새창열림)'>";
						inhtml += "<img src='" + bannerList[bl]['FILE_PATH'] + bannerList[bl]['TITLE'] + "' alt='" + bannerList[bl]['BANNER_NAME'] + "'>";
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
			// 2016.09.20 박재경 배너 슬라이딩 스위치
			var isBannerSliding = false;

			jQuery(
				function() {
					var banners = jQuery(".BannerList");
					if(banners.length > 0) {
						isBannerSliding = true;

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
									if(!isFocus && isBannerSliding) {
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
			         	isBannerSliding = false;
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
			         	isBannerSliding = true;
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
				$('#boardtab4').attr('class', "");
				$('#boardtab' + no).attr('class', "on");

				$('#article_list01').hide();
				$('#article_list02').hide();
				$('#article_list03').hide();
				$('#article_list04').hide();
				$('#article_list0' + no).show();


			}

			function edulatestShow(no) {
				$('#edutab1').attr('class', "");
				$('#edutab2').attr('class', "");
				$('#edutab3').attr('class', "");
				$('#edutab' + no).attr('class', "on");

				$('#edu_list01').hide();
				$('#edu_list02').hide();
				$('#edu_list03').hide();
				$('#edu_list0' + no).show();


			}


			function bizlatestShow(no) {

				$('#biztab1').attr('class', "");
				$('#biztab2').attr('class', "");
				$('#biztab3').attr('class', "");
				$('#biztab' + no).attr('class', "on");

				$('#biz_list01').hide();
				$('#biz_list02').hide();
				$('#biz_list03').hide();

				$('#biz_list0' + no).show();


			}

			function equTabShow(tab,no) {

				$('#equTitTab01').removeClass('on');
				$('#equTitTab02').removeClass('on');
				$('#equTitTab0'+tab).addClass('on');

				$('#equTab1').hide();
				$('#equTab2').hide();
				$('#equTab'+tab).show();

				$('#equList_1_1').hide();
				$('#equList_1_2').hide();
				$('#equList_2_1').hide();
				$('#equList_2_2').hide();

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
				
				
				$("#strDate").text(strDate);
				$('#mainCount1').text(procnt3);
				$('#mainCount2').text(procn4);
				
				
				
				
				//기업수
				//$('#avg_1_1').text(orgcnt1);
				//대학
				//$('#avg_1_2').text(agencycnt1);
				//연구기관
				//$('#avg_1_3').text(agencycnt2);
				//지원기관
				//$('#avg_1_4').text(agencycnt3);

				//전남기업수
				//$('#avg_1_1_2').text("("+jorgcnt1+")");
				//전남대학
				//$('#avg_1_2_2').text("("+jagencycnt1+")");
				//전남연구기관
				//$('#avg_1_3_2').text("("+jagencycnt2+")");
				//전남지원기관
				//$('#avg_1_4_2').text("("+jagencycnt3+")");


				//등록기관수
				//$('#avg_2_1').text(strEnterpriseCnt);
				//장비수
				//$('#avg_2_2').text(strEquCnt);
				//취득금액
				//$('#avg_2_3').text(strEquPrcCnt);
				//공동활용허용율
				//$('#avg_2_4').text(strEquUseCntPer);

				//등록기관수
				//$('#avg_2_1_2').text("("+strJEnterpriseCnt+")");
				//데이터 나오게 임의로 바꿈
				/* //장비수
				$('#avg_2_2_2').text("("+strJEquCnt+")");
				//취득금액
				$('#avg_2_3_2').text("("+strJEquPrcCnt+")"); */
				//장비수
				//$('#avg_2_2_2').text("("+strJEquCnt+")");
				//취득금액
				//$('#avg_2_3_2').text("("+strJEquPrcCnt+")");


				//등록 기관수
				//$('#avg_3_1').text(jipcnt1);
				//특허
				//$('#avg_3_2').text(jipcnt2);
				//디자인상표
				//$('#avg_3_3').text(jipcnt3);
				//노하우
				//$('#avg_3_4').text(jipcnt4);

				//전남등록 기관수
				//$('#avg_3_1_2').text("("+jipcnt1+")");
				//전남특허
				//$('#avg_3_2_2').text("("+jjipcnt2+")");
				//전남디자인상표
				//$('#avg_3_3_2').text("("+jjipcnt3+")");
				//전남노하우
				//$('#avg_3_4_2').text("("+jjipcnt4+")");


				//대학·연구기관
				//$('#avg_4_1').text(procnt1);
				//민간·기업
				//$('#avg_4_2').text(procnt2);
				//등록전문가
				//$('#avg_4_3').text(procnt3);
				//기관 담당자
				//$('#avg_4_4').text(procnt4);

				//전남대학·연구기관
				//$('#avg_4_1_2').text("("+Jprocnt1+")");
				//전남민간·기업
				//$('#avg_4_2_2').text("("+Jprocnt2+")");
				//등록전문가
				//$('#avg_4_4_3').text("("+procnt3+")");
				//전남기관 담당자
				//$('#avg_4_4_4').text("("+procnt4+")");


				//통합게시판


                var inhtml = "";
                for(var i = 0 ;i < boardLatestNotice.length;i++){
                      var rs = boardLatestNotice[i];
                      inhtml += '<li><span class="subject">';
					 if(rs['SITE_ID'] == 'jipbank'){
	                      inhtml += '<img src="/img/jntis/main/icon_jipbank.png" alt="지식"/>&nbsp;';
	                      inhtml += '<a href="/jipbank/sub.do?m=71&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  } else if(rs['SITE_ID'] == 'jeinet'){
	                      inhtml += '<img src="/img/jntis/main/icon_jeinet.png" alt="장비"/>&nbsp;';
	                      inhtml += '<a href="/jeinet/sub.do?m=34&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  } else if(rs['SITE_ID'] == 'jntis'){
	                      inhtml += '<img src="/img/jntis/main/icon_jntis.png"  alt="과학"/>&nbsp;';
	                      inhtml += '<a href="http://jntis.jnsp.re.kr/jntis/sub.do?m=98&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" target="_blank">';
					  }
                      inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }

                $('#boardLatestNotice').html(inhtml);

				//과학기술

                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestJntis.length;i++){
                      var rs = boardLatestJntis[i];
                      inhtml += '<li><span class="subject">';
					 inhtml += '<a href="/jntis/sub.do?m=98&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }


                $('#boardLatestJntis').html(inhtml); */

				//연구장비

                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestJeinet.length;i++){
                      var rs = boardLatestJeinet[i];
                      inhtml += '<li><span class="subject">';
					 inhtml += '<a href="http://jeinet.jnsp.re.kr/jeinet/sub.do?m=34&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }


                $('#boardLatestJeinet').html(inhtml); */


                //지식재산
               /*  var inhtml = "";
                for(var i = 0 ;i < boardLatestJipBank.length;i++){
                      var rs = boardLatestJipBank[i];
                      inhtml += '<li><span class="subject">';
					 inhtml += '<a href="http://jipbank.jnsp.re.kr/jipbank/sub.do?m=71&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }


                $('#boardLatestJipBank').html(inhtml); */

				 //행사교육정보

                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestEventEdu.length;i++){
                      var rs = boardLatestEventEdu[i];
	                      inhtml += '<li><span class="subject">';
                      if(rs['TB_NM'] == "2"){
	                      inhtml += '<img src="/img/jntis/main/icon_event.png" alt="행사"/>&nbsp;';
						  inhtml += '<a href="/jntis/sub.do?m=32&mode=view&eventIdx=' + rs['IDX'] + '" >';
						  inhtml += rs['NM'] + '</a></span>';
	                      inhtml += '<span class="date">'+rs['REG_DT']+'</span>';
                      }else{
                    	  inhtml += '<img src="/img/jntis/main/icon_edu.png" alt="교육"/>&nbsp;';
						  inhtml += '<a href="/jntis/sub.do?m=34&mode=view&eduId=' + rs['IDX'] + '" >';
						  inhtml += rs['NM'] + '</a></span>';
						  inhtml += '<span class="date">'+rs['REG_DT']+'</span>';
                      }

	                      inhtml += '</li>';
                }

                $('#boardLatestEventEdu').html(inhtml); */

                //교육자료
                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestEdu.length;i++){
                      var rs = boardLatestEdu[i];
                      inhtml += '<li><span class="subject">';
					  inhtml += '<a href="/jntis/sub.do?m=34&mode=view&eduId=' + rs['EDU_ID'] + '" >';
					  inhtml += rs['EDU_NM'] + '</a></span>';
					  inhtml += '<span class="date">'+rs['REG_DATE']+'</span>';
					  // 2017.07.19 lgy
					  if(rs['EDU_STATE'] != "") inhtml += '<span class="date">['+rs['EDU_STATE'].replace('10','접수중').replace('20','교육중').replace('30','마감')+']&nbsp;&nbsp;</span>';
					  inhtml += '<span class="date">['+rs['EDU_STATE'].replace('10','접수중').replace('20','교육중').replace('30','마감')+']&nbsp;&nbsp;</span>';
                      inhtml += '</li>';
                }

                $('#boardLatestEdu').html(inhtml); */

                //행사정보

               /*  var inhtml = "";
                for(var i = 0 ;i < boardLatestEvent.length;i++){
                      var rs = boardLatestEvent[i];
                      inhtml += '<li><span class="subject">';
					  inhtml += '<a href="/jntis/sub.do?m=32&mode=view&eventIdx=' + rs['EVENT_IDX'] + '" >';
					  inhtml += rs['EVENT_NM'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['REG_DT']+'</span>';
                      inhtml += '</li>';
                }

                $('#boardLatestEvent').html(inhtml); */

                //보도자료
                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestNews.length;i++){
                      var rs = boardLatestNews[i];
                      inhtml += '<li><span class="subject">';
					  inhtml += '<a href="/jntis/sub.do?m=93&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }

                $('#boardLatestNews').html(inhtml); */



                //통합
                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestProject.length;i++){
                      var rs = boardLatestProject[i];
                      inhtml += '<li><span class="subject">';
             		 if(rs['GB'] == '1'){
	                      inhtml += '<img src="/img/jntis/main/icon_area.png" alt="지역사업"/>&nbsp;';
	                      inhtml += '<a href="/jntis/sub.do?m=29&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  } else if(rs['GB'] == '2'){
	                      inhtml += '<img src="/img/jntis/main/icon_gover.png" alt="정부사업"/>&nbsp;';
	                      inhtml += '<a href="/jntis/sub.do?m=28&mode=view&uid=' + rs['ARTICLE_ID'] + '" >';
					   }

					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }
                $('#boardLatestProject').html(inhtml); */



                //국가
                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestProject1.length;i++){
                      var rs = boardLatestProject1[i];
                      inhtml += '<li><span class="subject">';
					  inhtml += '<a href="/jntis/sub.do?m=28&mode=view&uid=' + rs['UID'] + '" >';
					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['D_REGIS']+'</span>';
                      inhtml += '</li>';
                }

                $('#boardLatestProject1').html(inhtml); */
                //지역사업
                /* var inhtml = "";
                for(var i = 0 ;i < boardLatestProject2.length;i++){
                      var rs = boardLatestProject2[i];
                      inhtml += '<li><span class="subject">';
					  inhtml += '<a href="/jntis/sub.do?m=29&mode=view&boardIdx=' + rs['ARTICLE_ID'] + '" >';
					  inhtml += rs['SUBJECT'] + '</a></span>';
                      inhtml += '<span class="date">'+rs['FRST_REGIST_PNTTM']+'</span>';
                      inhtml += '</li>';
                }

                $('#boardLatestProject2').html(inhtml); */



                //포토뉴스
                /* inhtml = "";
                for(var i = 0 ;i < boardListPhoto.length;i++){
                      if(i == 5) break;
                      var rs = boardListPhoto[i];


                      var inclass = "";
                      if(i == 0) inclass = " class='first' ";
                      var alink = "/jntis/sub.do?m=94&boardComIdx=00054&mode=view&&boardIdx="+rs['ARTICLE_ID'];
                      inhtml += '<li '+inclass+'>';
                      if(rs["TITLE"] != '' ){
                            inhtml += '<p class="Pic"><img src="'+rs["FILE_PATH"]+rs["TITLE"]+'" alt="" width="217" height="157" /></p>';
                      }else{
                            inhtml += '<p class="Pic"><img src="/img/main/no_image01.gif" alt="" width="217" height="157" /></p>';
                      }
                      inhtml += '<em class="TitlePic">';
                      inhtml += '<a href="'+alink+'" title="' + rs["SUBJECT"] + '">';
                      inhtml += cutStr(rs["SUBJECT"],8);
                      inhtml += '</a>';
                      inhtml += '</em>';
                      inhtml += '</li>';

                }

                //포토뉴스
                $('#boardListPhoto').html(inhtml); */

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

					resizeShow()

				});

			resizeShow()
			});
			function resizeShow(){
				var w_win = $(window).width();

				if(w_win <=  768 ){
					$('#boardListPhoto li').eq(3).addClass('end');
					$('#boardListPhoto li').eq(4).css('display','none');

				}else{
					$('#boardListPhoto li').eq(3).removeClass('end');
					$('#boardListPhoto li').eq(4).css('display','');
				}
			}

			$( document ).ready(function() {
				$(".board01 > div > h3 > a").each(function(idx) {
					$(this).focus(function(){
						boardlatestShow(idx+1);
					});
				});

				$(".board02 > div > h3 > a").each(function(idx) {
					$(this).focus(function(){
						bizlatestShow(idx+1);
					});
				});

				$(".board03 > div > h3 > a").each(function(idx) {
					$(this).focus(function(){
						edulatestShow(idx+1);
					});
				});
			});
			//]]>
		</script>
</head>
<body>

<!--Wrap S-->
<div class="Wrap">
	<ul id="go_main">
			<li><a href="#jntisMainContentStart" >본문 바로 가기</a></li>
			<li><a href="javascript:void(0);" onclick='javascript:document.getElementById("top_menu_id_2").focus();return false;'>주메뉴 바로가기</a></li>
	</ul>
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
