<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
	<script type="text/javascript">
		$(function(){
			$('.top_menu_box ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_1').hide();
					$('.sub_menu_list_box_2').hide();
					$('.sub_menu_list_box_3').hide();
					$('.sub_menu_list_box_4').hide();
					$('.sub_menu_list_box_5').hide();
					$('.sub_menu_list_box_6').hide();
					$('.sub_menu_list_box_'+(index+1)).show();
					$('.top_menu_box ul li').attr('class','')
					$(this).attr('class','on');

				});
			});


			$('.sub_menu_list_box_1 ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_1 ul li').attr('class','');
					$(this).attr('class','on');
				});
			});
			$('.sub_menu_list_box_2 ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_2 ul li').attr('class','');
					$(this).attr('class','on');
				});
			});
			$('.sub_menu_list_box_3 ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_3 ul li').attr('class','');
					$(this).attr('class','on');
				});
			});
			$('.sub_menu_list_box_4 ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_4 ul li').attr('class','');
					$(this).attr('class','on');
				});
			});
			$('.sub_menu_list_box_5 ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_5 ul li').attr('class','');
					$(this).attr('class','on');
				});
			});
			$('.sub_menu_list_box_6 ul li').each(function(index){
				$(this).mouseover(function(){
					$('.sub_menu_list_box_6 ul li').attr('class','');
					$(this).attr('class','on');
				});
			});
			$('#family_site').change(function(){
				if($(this).val() != ''){
					window.open($(this).val(),'site');
				}
			});
		});
	</script>
	<div id="header">
		<div class="gnb_box">
			<div class="top_gnb">
				<a href="/" title="HOME"><img src="/imgs/comm/btn_gnb_home.png" /></a>
				<!--  <a href="/" title="ENGLISH"><img src="/imgs/comm/btn_gnb_eng.png" /></a> -->
				<a href="/p/sitemap.do" title="site"><img src="/imgs/comm/btn_gnb_site.png" /></a>
				<a href="/p/login.do" title="admin"><img src="/imgs/comm/btn_gnb_admin.png" /></a>
			</div>
		</div>
		<div class="menu_gnb_box">
			<div class="menu_gnb">
				<div class="top_logo"><a href="/"><img src="/imgs/comm/logo.png" alt="????????????"/></a></div>
				<div class="top_menu_box">
					<ul>
						<li><a href="/p/sub_01_01.do">??????????????????</a></li>
						<li><a href="/p/sub_02_01.do">????????????</a></li>
						<li><a href="/p/sub_03_01.do">????????????</a></li>
						<li><a href="/p/sub_04_01.do">????????????</a></li>
						<li><a href="/p/sub_05_01.do">PR Center</a></li>
						<li><a href="/p/sub_06_01.do">?????? Center</a></li>
					</ul>
				</div>
			</div>
			<div class="sub_gnb_menu_box">
				<div class="sub_gnb_menu">
					<div class="sub_menu_list_box_1">
						<ul>
							<li><a href="/p/sub_01_01.do" >?????????</a></li>
							<li><a href="/p/sub_01_02.do">????????????</a></li>
							<li><a href="/p/sub_01_03.do">????????????</a></li>
							<li><a href="/p/sub_01_04.do">?????????</a></li>
							<li><a href="/p/sub_01_05.do">????????????</a></li>
						</ul>
					</div>
					<div class="sub_menu_list_box_2">
						<ul>
							<li><a href="/p/sub_02_01.do">????????????</a></li>
							<li><a href="/p/sub_02_02.do">?????????</a></li>
						</ul>
					</div>
					<div class="sub_menu_list_box_3">
						<ul>
							<li><a href="/p/sub_03_01.do">????????????</a></li>

						</ul>
					</div>
					<div class="sub_menu_list_box_4">
						<ul>
							<li><a href="/p/sub_04_01.do">????????????</a></li>
							<li><a href="/p/sub_04_02.do">????????????</a></li>
						</ul>
					</div>
					<div class="sub_menu_list_box_5">
						<ul>
							<!-- <li><a href="/p/sub_05_01.do">????????????</a></li>  -->
							<li><a href="/p/sub_05_02.do">?????? ??? ??????</a></li>
						</ul>
					</div>
					<div class="sub_menu_list_box_6">
						<ul>
							<li><a href="/p/sub_06_01.do">????????????</a></li>
							<li><a href="/p/sub_06_02.do">Q&amp;A</a></li>
							<li><a href="/p/sub_06_04.do">????????????</a></li>
						</ul>
					</div>
				</div>

			</div>
		</div>

	</div>