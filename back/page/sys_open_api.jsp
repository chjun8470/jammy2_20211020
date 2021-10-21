<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@include file="/back/_temple/basic/t_top.jsp" %>
<%

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));

%>
<div class="content_center">

	
<style type="text/css">
<!--
p.hstyle0
	{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle0
	{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle0
	{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle1
	{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle1
	{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle1
	{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle2
	{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle2
	{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle2
	{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle3
	{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle3
	{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle3
	{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle4
	{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle4
	{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle4
	{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle5
	{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle5
	{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle5
	{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle6
	{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle6
	{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle6
	{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle7
	{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle7
	{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle7
	{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle8
	{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle8
	{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle8
	{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle9
	{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle9
	{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle9
	{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle10
	{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle10
	{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle10
	{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle11
	{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle11
	{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle11
	{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle12
	{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle12
	{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle12
	{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle13
	{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle13
	{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle13
	{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle14
	{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#2e74b5;}
li.hstyle14
	{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#2e74b5;}
div.hstyle14
	{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#2e74b5;}
p.hstyle15
	{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle15
	{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle15
	{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle16
	{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle16
	{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle16
	{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle17
	{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle17
	{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle17
	{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
p.hstyle18
	{style-name:"td"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:100%; font-size:11.0pt; font-family:맑은 고딕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
li.hstyle18
	{style-name:"td"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:100%; font-size:11.0pt; font-family:맑은 고딕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
div.hstyle18
	{style-name:"td"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:100%; font-size:11.0pt; font-family:맑은 고딕; letter-spacing:0; font-weight:"normal"; font-style:"normal"; color:#000000;}
-->
</style>


<p class=hstyle0><span style='font-size:14.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:160%'>1.설명</span></p>

<p class=hstyle0 style='text-align:left;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&nbsp;&nbsp;○ 전남연구장비정보망에 저장되어 있는 장비 데이터를 요청합니다</span><span style='font-family:"맑은 고딕"'>.</span></p>

<p class=hstyle0><span style='font-family:"맑은 고딕"'><br></span></p>

<p class=hstyle0><span style='font-size:14.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:160%'>2.사용법</span></p>

<p class=hstyle0 style='text-align:left;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&nbsp;&nbsp;○ </span><span style='font-family:"맑은 고딕"'>h</span><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>ttp://jeinet.jnsp.re.kr/jeinet/eqapijson.do</span></p>

<p class=hstyle0 style='text-align:left;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&nbsp;&nbsp;○ </span><a href="http://jeinet.jnsp.re.kr/jeinet/eqapijson.do?searchusescopecd=2&searchusescopemean=1" target="_self"><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>http://jeinet.jnsp.re.kr/jeinet/eqapijson.do?searchusescopecd=2&amp;searchusescopemean=1</span></a></p>

<p class=hstyle0 style='text-align:left;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&nbsp;&nbsp;○ http://jeinet.jnsp.re.kr/jeinet/eqapijson.do?firstrecord=0&amp;pagesize=10</span></p>

<p class=hstyle0><span style='font-size:13.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:160%'>&nbsp;</span></p>

<p class=hstyle0><span style='font-size:13.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:160%'>&nbsp;2-1.조건</span></p>

<p class=hstyle0>
<table border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<tr>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>&nbsp;</span></p>
	</td>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕";font-weight:"bold"'>name</span></p>
	</td>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕";font-weight:"bold"'>&nbsp;</span></p>
	</td>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕";font-weight:"bold"'>&nbsp;</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>searchusescopecd&nbsp;</span></p>
	</td>
	<td valign="middle" style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>활용범위</span></p>
	</td>
	<td valign="middle" style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>2:공동활용허용가능, 3:공동활용서비스가능</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>2</span></p>
	</td>
	<td valign="middle" style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>searchusescoperange</span></p>
	</td>
	<td valign="middle" style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>활용대상</span></p>
	</td>
	<td valign="middle" style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>1:기관내부활용, 2:기관외부활용</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>3</span></p>
	</td>
	<td valign="middle" style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>searchusescopemean</span></p>
	</td>
	<td valign="middle" style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>이용방법</span></p>
	</td>
	<td valign="middle" style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>1:대여, 2:의뢰, 3:직접, 4:모두</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>4</span></p>
	</td>
	<td valign="middle" style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>searchusetypecd</span></p>
	</td>
	<td valign="middle" style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비용도</span></p>
	</td>
	<td valign="middle" style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>1:시험용, 2:분석용, 3:교육용, 4:계측용, 5:생산용, 6:기타</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>firstrecord</span></p>
	</td>
	<td valign="middle" style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>시작할row</span></p>
	</td>
	<td valign="middle" style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>숫자(미설정시 전체값 표시)</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:30;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>6</span></p>
	</td>
	<td valign="middle" style='width:159;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>pagesize</span></p>
	</td>
	<td valign="middle" style='width:91;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>갯수</span></p>
	</td>
	<td valign="middle" style='width:366;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>숫자(미설정시 전체값 표시)</span></p>
	</td>
</tr>
</table>
<p class=hstyle0></p>

<p class=hstyle0><span style='font-family:"맑은 고딕"'><br></span></p>

<p class=hstyle0><span style='font-size:14.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:160%'>3.데이터예시</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>{&quot;data&quot;:[{&quot;rnd_biz&quot;:&quot;지역전략산업육성사업&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;location_dtl&quot;:&quot;고분자센터&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;user_idx&quot;:&quot;74&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;rnd_equ_idx&quot;:&quot;844&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;take_cd&quot;:&quot;1&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>“</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>.</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>.</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>중략</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>.</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>.</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>.</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;branch_nm&quot;:&quot;물리적측정장비 &gt; 힘/토크/압력/진공측정장비 &gt; 부하시험기&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;delete_yn&quot;:&quot;n&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;eng_key_word&quot;:&quot;test bench,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;idle_disuse_cd&quot;:&quot;03&quot;,</span></p>

<p class=hstyle0 style='margin-left:9.1pt;'><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;oper_email&quot;:&quot;</span><a href="mailto:sjlee4629@jntp.or.kr"><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>sjlee4629@jntp.or.kr</span></a><span style='font-size:11.0pt;font-family:"맑은 고딕";line-height:160%'>&quot;}}</span></p>

<p class=hstyle0><span style='font-size:14.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:160%'>4.데이터 항목</span></p>

<p class=hstyle0></p>
<table border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<tr>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕";font-weight:"bold"'>&nbsp;</span></p>
	</td>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕";font-weight:"bold"'>name</span></p>
	</td>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕";font-weight:"bold"'>length</span></p>
	</td>
	<td valign="middle" bgcolor="#d5c9a2"  style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕";font-weight:"bold"'>description</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_equ_idx</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>11</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비 아이디</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>2</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>시설장비 분류</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>3</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>fixed_aset_no</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>고정자산관리번호</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>4</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>kor_nm</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>한글 장비명 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>eng_nm</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>영문 장비명 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>6</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>manufacture_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>제작사 코드 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>7</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>manufacture_nm</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>제작사 명 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>8</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>model_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>모델명 코드 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>9</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>made_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>제작국가명 코드 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>10</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>model_nm</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>모델 명 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>11</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>취득 방법 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>12</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_prc</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>취득 금액/개발비/총구축비</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>13</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_sdt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>취득일/개발시작일</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>14</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_edt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>개발종료일</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>15</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>location</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>설치 장소 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>16</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>location_dtl</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>설치장소 상세정보</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>17</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>branch_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>연구시설장비 표준분류 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>18</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>branch_nm</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>연구시설장비 표준분류 명 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>19</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>regist_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비 구분 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>20</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_scope_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>활용 범위 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>21</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_scope_reason</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>200</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>단독활용사유</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>22</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_type_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비 용도 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>23</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_type_reason</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>200</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비용도사유</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>24</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>idle_disuse_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비 상태 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>25</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>setup_id</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>설치장소 id</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>26</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>st_stype</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>설치장소 층수 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>27</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>st_room</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>설치장소 호수 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>28</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_detail_feature</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>text</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비설명(기능)&nbsp;</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>29</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_detail_capability</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>text</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>구성 및 성능 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>30</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_detail_example</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>text</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>사용 예 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>31</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>import_cd</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>5대 중점투자분야 </span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>32</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>oper_tel</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>문의처&nbsp;</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>33</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>disuse_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>불용처분일자</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>34</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>disuse_type</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>불용처분 타입</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>35</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>disuse_verdict_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>불용판정일자</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>36</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>dev_open_yn</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>개발장비공개여부</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>37</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>dev_spec</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>개발장비 비중</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>38</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>disuse_organ</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>양여,대여기관</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>39</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_scope_range</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>활용대상</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>40</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_scope_mean</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>사용법</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>41</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>use_scope</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비단독활용사유</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>42</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>eqcp_id</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>주장비코드</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>43</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>eqcp_nm</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>주장비이름</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>44</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>fixed_aset_no_yn</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>고유자산관리번호 사용여부(n=사용)</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>45</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>kor_large_fac_yn</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>거대연구시설여부</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>46</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>land_area</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>땅면적</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>47</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>land_prc</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>토지비</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>48</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>land_reason</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>토지사유</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>49</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>build_area</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>건물면적</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>50</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>floor_up</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>건물지상층수</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>51</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>floor_down</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>건물지하층수</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>52</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>build_prc</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>건물비</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>53</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>build_reason</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>건물사유</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>54</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_little_take_prc</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>3천만원 미만연구장비비용</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:20;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>55</span></p>
	</td>
	<td valign="middle" style='width:189;height:20;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_facilities_take_prc</span></p>
	</td>
	<td valign="middle" style='width:68;height:20;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:20;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>특수설비비용</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>56</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_facilities_yn</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>특수설비여부</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>57</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_take_prc</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>연구장비비</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>58</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_prc_foreign</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>국산금액</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>59</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_prc_domestic</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>외산금액</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>60</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>user_idx</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>등록자idx</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>61</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_info</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>과제정보</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>62</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_yn</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>연구과제 여부</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>63</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>branch_cd1</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>표준분류체계 대분류</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>64</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>branch_cd2</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>표준분류체계 중분류</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>65</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>branch_cd3</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>표준분류체계 소분류</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>66</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_source</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>사업비 출처</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>67</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>take_source_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>사업비 출처 상세</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>68</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_st_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>과제수행기간</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>69</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_ed_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>과제수행기간</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>70</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_director</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>연구책임자</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>71</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_division</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>6t분류</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>72</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_biz</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>세부사업명</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>73</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_main_org</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>주관기관명</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>74</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_task</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>세부과제</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>75</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>rnd_commit</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>과제수행부청</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>76</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>kor_key_word</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>한글 검색키워드</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>77</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>eng_key_word</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>영문 검색키워드</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>78</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>oper_charger</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>문의담당자</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>79</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>oper_position</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>문의담당자 직위</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>80</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>oper_email</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>문의이메일</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>81</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>oper_fax</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>문의팩스</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>82</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>oper_etc</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>비고</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>83</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>ntis_equip_info</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>ntis등록번호</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>84</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equip_warranty</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>내구연한</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>85</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equ_user_idx</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>30</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비담당자</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>86</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>delete_yn</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>삭제여부</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>87</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>hits</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>10</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>조회수</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>88</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>equ_produce</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>255</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>장비제작사</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>89</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>reg_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>&nbsp;</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>등록일</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:21;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>90</span></p>
	</td>
	<td valign="middle" style='width:189;height:21;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>state</span></p>
	</td>
	<td valign="middle" style='width:68;height:21;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>5</span></p>
	</td>
	<td valign="middle" style='width:336;height:21;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕";letter-spacing:-5%'>상태(1승인요청2이용승인3승인거절4이용완료5승인취소)</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>91</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>reject</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>1000</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>반려사유</span></p>
	</td>
</tr>
<tr>
	<td valign="middle" style='width:38;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>92</span></p>
	</td>
	<td valign="middle" style='width:189;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>state_dt</span></p>
	</td>
	<td valign="middle" style='width:68;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0 style='text-align:center;'><span style='font-family:"맑은 고딕"'>&nbsp;</span></p>
	</td>
	<td valign="middle" style='width:336;height:17;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<p class=hstyle0><span style='font-family:"맑은 고딕"'>상태처리 변경일자</span></p>
	</td>
</tr>
</table>
</div>
<%@include file="/back/_temple/basic/t_footer.jsp" %>
