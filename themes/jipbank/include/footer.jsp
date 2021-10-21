<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div class="FooterBox">

<div class="f_menu">
<ul>
<li class="first"><a href="/jipbank/sub.do?m=87"><span class="Blue">개인정보처리방침</span></a></li>
<li><a href="/jipbank/sub.do?m=86">이메일무단수집거부</a></li>
<li><a href="/jipbank/sub.do?m=88">저작권정책</a></li>
<li><a href="/jipbank/sub.do?m=84">찾아오시는길</a></li>
<li><a href="/jipbank/sub.do?m=89">홈페이지의견접수</a></li>
<li><a href="http://jeinet.jnsp.re.kr/file/06.JIPBANKManual(user) - ver 0.3.pdf" target="_blank">매뉴얼 다운로드</a></li>
<li class="end"><a href="javascript:snsFaceBook()"><img src="/img/common/icon_sns01.png" alt="페이스북 바로가기"/></a></li>
</ul>
</div>
<div class="f_qr">
<img src="/img/jipbank/common/f_qr.jpg" alt="QR코드" />
</div>
<div class="f_site">
<ul>
<li>

<select class="select_site" id="siteNO1" title="유관기관 site">
<option value="#" selected="selected">유관기관 site</option>
<option value="http://www.koreasp.or.kr/index.php">지방과학연구단지협의회</option>
<option value="http://www.cbkipa.net/home/main2.do">충북과학연구단지</option>
</select>
<p class="btn_area"><input onclick="siteGo1()" type="image" src="/img/common/btn_move.gif" alt="이동" class="btn_area" /></p>

</li>
<li>

<select class="select_site" id="siteNO2" title="Family site">
<option value="" selected="selected">Family site</option>
<option value="http://jntp.or.kr/home/menu/69.do">정책기획단</option>
<option value="http://jntp.or.kr/home/menu/70.do">기업지원단</option>
<option value="http://jntp.or.kr/home/menu/71.do">신소재기술산업화지원센터</option>
<option value="http://jntp.or.kr/home/menu/72.do">세라믹산업종합지원센터</option>
<option value="http://jntp.or.kr/home/menu/67.do">고분자 융·복합소재센터</option>
<option value="http://jntp.or.kr/home/menu/73.do">레이저시스템산업지원센터</option>
</select>
<p class="btn_area"><input onclick="siteGo2()" type="image" src="/img/common/btn_move.gif" alt="이동" class="btn_area" /></p>

</li>
</ul>
</div>



<div class="f_info">
<div class="f_info1">전남테크노파크 전라남도 순천시 해룡면 을촌산단 4로 13</div>
<div class="f_info2">
<div class="f_tel">TEL : 061-460-5200</div>
<div class="f_fax">FAX : 061-464-0110</div>
</div>
<div class="f_info3">COPYRIGHT ⒞JEONNAM SCIENCE & TECHNOLOGY PROMOTION CENTER. ALL RIGHT RESERVED.</div>
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
	/* window.open('http://www.facebook.com/sharer.php?u=http://jipbank.jnsp.re.kr/jipbank/main.do&t=전남연구장비정보망'); */
	window.open('https://www.facebook.com/jntis.jnsp.re.kr/','facebook');
}
//]]>
</script>