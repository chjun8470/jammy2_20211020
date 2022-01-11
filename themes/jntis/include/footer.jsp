<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<div class="FooterBox">

<div class="hide">전남테크노파크, 전남과학기술진흥센터 로고</div>

<div class="f_menu">
<ul>
<li class="first"><a href="/jntis/sub.do?m=104"><span class="Blue">개인정보처리방침</span></a></li>
<li><a href="/jntis/sub.do?m=103">이메일무단수집거부</a></li>
<li><a href="/jntis/sub.do?m=105">저작권정책</a></li>
<li><a href="/jntis/sub.do?m=101">찾아오시는길</a></li>
<li><a href="/jntis/sub.do?m=106">홈페이지의견접수</a></li>
<li><a href="http://jeinet.jnsp.re.kr/file/02.JNTISManual(user) - ver 0.3.pdf" target="_blank" title="새창열기">매뉴얼 다운로드</a></li>
<li class="end"><a href="javascript:snsFaceBook()"><img src="/img/common/icon_sns01.png" title="새창열기" alt="페이스북 바로가기"/></a></li>
</ul>
</div>

<<<<<<< HEAD
<div class="waMark">
<<<<<<< HEAD
<input type="image" class="" src="/img/jntis/common/mark.png" style="float:right;margin:10px 0 0 10px" alt="웹 접근성 인증마크"
=======
<!--<div class="waMark">
<input type="image" class="" src="/img/jntis/main/img_web_accessibility.png" style="width:104px;height:73px;float:right;margin:10px 0 0 10px" alt="웹 접근성 인증마크"
>>>>>>> parent of d943127 (211215 1001)
=======
<input type="image" class="" src="/img/jntis/main/img_web_accessibility.png" style="width:104px;height:73px;float:right;margin:10px 0 0 10px" alt="웹 접근성 인증마크"
>>>>>>> parent of 4424c78 (220111 147)
onclick="location.href='http://wa.or.kr/waMark/status_new.asp?op=1&wd=%EC%A0%84%EB%82%A8%EA%B3%BC%ED%95%99%EA%B8%B0%EC%88%A0%EC%A0%95%EB%B3%B4%EC%8B%9C%EC%8A%A4%ED%85%9C&x=0&y=0'"/>
</div>-->


<div class="f_qr">
<img src="/img/jntis/common/f_qr.jpg" alt="전남과학기술정보시스템 QR코드" />
</div>

<div class="f_site">
<ul>
<li>
<select name="siteNO1" class="select_site" id="siteNO1" title="유관기관 사이트 바로가기 선택">
<option value="" selected="selected">유관기관 사이트</option>
<option value="http://www.koreasp.or.kr/index.php">지방과학연구단지협의회</option>
<option value="http://www.cbkipa.net/home/main2.do">충북과학연구단지</option>
</select>
<p class="btn_area"><input onclick="siteGo1()" type="image" src="/img/common/btn_move.gif" title="새창열기" alt="이동" class="btn_area" /></p>

</li>
<li>
<select name="siteNO2" class="select_site" id="siteNO2" title="패밀리 사이트 바로가기 선택">
<option value="" selected="selected">패밀리 사이트</option>
<option value="http://jntp.or.kr/home/menu/69.do">정책기획단</option>
<option value="http://jntp.or.kr/home/menu/70.do">기업지원단</option>
<option value="http://jntp.or.kr/home/menu/71.do">신소재기술산업화지원센터</option>
<option value="http://jntp.or.kr/home/menu/72.do">세라믹산업종합지원센터</option>
<option value="http://jntp.or.kr/home/menu/67.do">고분자 융·복합소재센터</option>
<option value="http://jntp.or.kr/home/menu/73.do">레이저시스템산업지원센터</option>
</select>
<p class="btn_area"><input onclick="siteGo2()" type="image" src="/img/common/btn_move.gif" title="새창열기" alt="이동" class="btn_area" /></p>
</li>
</ul>
</div>

<div class="f_info">
<div class="f_info1">전라남도 순천시 해룡면 율촌산단 4로 13 전남테크노파크 (58034)</div>
<div class="f_info2">
<div class="f_tel">TEL : 061-729-2974</div>
<div class="f_fax">FAX : 061-729-2588</div>
</div>
<div class="f_info3">COPYRIGHT ⒞JEONNAM SCIENCE &amp; TECHNOLOGY PROMOTION CENTER. ALL RIGHT RESERVED.</div>
</div>

</div>

<script type="text/javascript">
//<![CDATA[
function siteGo1(){
	if($('#siteNO1').val() != ''){
		window.open($('#siteNO1').val());
	}
}
function siteGo2(){
	if($('#siteNO2').val() != ''){
		window.open($('#siteNO2').val());
	}
}
function snsFaceBook(){
	/* window.open('http://www.facebook.com/sharer.php?u=http://jntis.jnsp.re.kr/jntis/main.do&t=전남연구장비정보망'); */
	window.open('https://www.facebook.com/jntis.jnsp.re.kr/','facebook');
}
//]]>
</script>