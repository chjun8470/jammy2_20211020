<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



	<script type="text/javascript">
	//<![CDATA[
	// 타이틀 변경
	document.title = '약관 및 동의서 - 회원가입 - 전남과학기술정보시스템';
	
	function allAgree(){
            $('input[type="checkbox"]').prop('checked', true);
	}

	function agreeCheck(mode){

		$("#mode").val(mode);

	}
	function agreeSubmitCheck(){
		
		if(!$("#agree1").is(":checked")){
			alert("이용약관의 동의가 필요합니다.");
			$("#agree1").focus();
			return false;
		}
		if(!$("#agree2").is(":checked")){
			alert("개인정보의 보유기간 및 이용시간의 동의가 필요합니다.");
			$("#agree2").focus();
			return false;
		}
		return true;
	}

	$(document).ready(function(){
		window.resizeTo("836", "800");
		$('input[name="grobalTp"]').change(function(){

			    if($(this).val()=='1'){
			    	$('#btnBox1').show();
			    	$('#btnBox2').hide();
			    }else{
			    	$('#btnBox2').show();
			    	$('#btnBox1').hide();
			    }

		});
	});
	//]]>
	</script>


	<form name="agreeForm" id="agreeForm" action="/sso/join.do" method="post" onsubmit="return agreeSubmitCheck();" >

    		<input type="hidden" name="mode" id="mode" value="" />

			<div class="join_order"><img src="/img/login/img_join_order1.png" alt="STEP1 약관 및 동의서(현재단계), STEP2 정보입력, STEP3 가입완료" /></div>


			<!--agreeBox1 S-->
			<div class="agreeBox1">
				<h4 class="tit_agree">약관 및 동의서</h4>

				<div class="check_agree"><input type="checkbox" id="agreeInfo" name="agreeInfo" style="width:17px; height:17px;" onclick="allAgree();"/><label for="agreeInfo">전체동의</label></div>

				<div class="agreement">

					<div class="Box1">
						<h5 class="tit_agree2">개인정보의 보유기간 및 이용기간</h5>
						<div class="check_agree2"><input type="checkbox" id="agree1" name="agree1" value="Y" style="width:14px; height:14px;" /><label for="agree1">위 약관에 동의합니다.</label></div>
					</div>
					<textarea class="info_agree" title="회원가입을 위한 개인정보의 보유기간 및 이용기간 동의서">- 서비스 이용을 위해 개인정보의 보유기간 및 이용기간 안내를 끝까지 읽어보시고 동의여부를 선택하시기 바랍니다.
이용자 개인정보는 원칙적으로 개인정보의 처리목적이 달성되면 지체없이 파기하며, 홈페이지회원 등의 홍보 및 대국민서비스 목적의 외부고객 명부는 특별한 경우를 제외하고는 2년을 주기로 정보주체의 재동의 절차를 거쳐 동의한 경우에만 계속적으로 보유할 수 있습니다.</textarea>
				</div>

				<div class="agreement">
					<div class="Box1">
						<h5 class="tit_agree2">개인정보 수집 동의 안내</h5>
						<div class="check_agree2"><input type="checkbox" id="agree2" name="agree2" value="Y" style="width:14px; height:14px;" /><label for="agree2">위 약관에 동의합니다.</label></div>
					</div>
					<textarea class="info_agree" title="회원가입을 위한 개인정보 수집 동의 안내 동의서">- 안내를 끝까지 읽어보시고 동의여부를 선택하시기 바랍니다.
전남테크노파크는 서비스를 위해 회원가입시 아래 정보를 필수항목으로 수집합니다.

- 필수항목 : 이름, 성별, 생년월일, 외국인여부, 사용자ID, 비밀번호, 이메일, 소속기관, 거주지 구분(국내,국외), 우편번호, 주소, 전화번호, 직업, 사용자유형, 생년월일

※ 이메일, 주소, 전화번호는 알리미서비스, 이벤트, 상품 및 안내문 발송, 문의사항 응대를 위해 수집하는 정보이며 소속기관, 직업유형, 사용자유형은 사용자별 서비스 권한을 구분하기 위한 필수정보입니다.

개인정보 활용 동의 안내
- 서비스 이용을 위해 개인정보 공동활용 및 정보공개 동의를 끝까지 읽어보시고 동의여부를 선택하시기 바랍니다.
전남과학기술정보시스템에서 귀하의 정보를 활용하고자 합니다.

전남테크노파크  전남과학기술정보시스템에서는 각 부처와 연계하여 전남연구장비 및 지식재산 인력정보를 데이터베이스화하는 작업을 추진하고 있습니다.


◊ 귀하의 정보는 아래와 같이 수집됩니다.

1. 귀하께서 이미 전남R&amp;D과제에 참여하셨다면, 귀하가 참여한 전남R&amp;D과제의 신청 절차를 통하여 이미 귀하의 정보가 해당 과제와 관련된 연구관리전문기관에 보관되어 있습니다. 이 중 데이터 공동활용 및 정보공개에 동의하신 연구참여자에 한하여 전남테크노파크에서는 연구관리전문기관의 협조를 얻어 귀하의 소중한 정보를 요청하고 전달받게 됩니다

2. 귀하께서 앞으로 전남R&amp;D과제에 참여하실 예정이시라면, 귀하가 참여할 전남R&amp;D과제의 신청 절차에 귀하의 정보가 입력됩니다. 이 중 데이터 공동활용 및 정보공개에 동의하신 연구참여자에 한하여 귀하의 정보가 입력된 이후에 전남테크노파크에서는 연구관리전문기관의 협조를 얻어 귀하의 소중한 정보를 요청하고 전달받게 됩니다.

◊ 귀하께서 동의하신 전남R&amp;D인력정보서비스에 수록된 정보는 '개인정보처리방침'에 따라 엄격히 보호되고 전남테크노파크 사업목적 이외의 용도로는 일체 사용되지 않음을 알려드립니다.

◊ 전남R&amp;D참여인력DB, 평가위원DB는 아래와 같이 개인정보 항목을 처리하고 있습니다.


1. 개인정보 파일명 : 전남R&amp;D참여인력DB, 평가위원 DB
- 개인정보 항목
·필수항목 : 기본정보(한글성명, 국적, 생년월일, 성별, 이메일, 과학기술표준분류별전문분야), 소속기관사항(국내외구분, 기관명, 직위, 우편번호, 지번부소, 도로명주소, 전화, 재직여부)
·선택항목 : 기본정보(영문성명, 한문성명, 휴대폰, 홈페이지, 대표전문기관별전문분야), 소속기관사항(학과/부서, 팩스, 전임최초임용일), 학력, 경력, 소속학협회, 논문, 과제수행실적, 저역서실적, 훈포장사항, 지식재산권, 주요업적, 자격, 사진
·자동생성항목 : 접속 IP 정보, 쿠키, 서비스 이용 기록, 접속 로그
- 수집방법 : 홈페이지, 대표전문기관 연계
- 보유근거 : 국가연구개발사업의 관리 등에 관한 규정 제25조, 정보주체의 동의
- 보유기간 : 준영구

2. 개인정보 파일명 : 과학기술인 등록번호 DB
- 개인정보 항목
·필수항목 : 기본정보(한글성명, 휴대폰, 이메일), 소속기관사항(기관/개인구분, 국내외구분, 우편번호, 직장전화번호)
·선택항목 : 기본정보(영문성명, 한문성명), 소속기관사항(소속기관명, 부서명, 직위, 지번주소, 도로명주소)
·자동생성항목 : 접속 IP 정보, 쿠키, 서비스 이용 기록, 접속 로그
- 수집방법 : 홈페이지, 대표전문기관 연계
- 보유근거 : 국가연구개발사업의 관리 등에 관한 규정 제25조, 정보주체의 동의
- 보유기간 : 준영구

※ 개인정보 활용에 동의하지 않으시는 경우 연구자 상세검색 조회 시 일부 항목이 조회되지 않을 수 있습니다. </textarea>
				</div>

			</div>
			<!--agreeBox1 E-->





			<!--agreeBox2 S-->
			<div class="agreeBox2">

				<h4 class="tit_agree2">가입회원 종류</h4>

				<!--memberKindWrap S-->
				<div class="memberKindWrap">

					<div class="memberKind">
<<<<<<< HEAD
						<div class="check_choice"><input type="radio" value="2" checked="checked" name="userTp" id="userTp2" style="width:16px; height:16px;" /><label for="userTp2">기업회원</label></div>
						<div class="check_choice2"><input type="radio" value="3"  name="userTp" id="userTp3" style="width:16px; height:16px;" /><label for="userTp3">기관회원</label></div>
						<div class="check_choice4"><input type="radio" value="4"  name="userTp" id="userTp4" style="width:16px; height:16px;" /><label for="userTp4">전문가회원</label></div>
						<div class="check_choice3"><input type="radio" value="1" name="userTp" id="userTp1" style="width:16px; height:16px;" /><label for="userTp1">개인회원</label></div>
=======
						<div class="check_choice"><input type="radio" value="1" checked="checked" name="userTp" id="userTp1" style="width:16px; height:16px;" /><label for="userTp1">개인회원</label></div>
						<div class="check_choice2"><input type="radio" value="2" name="userTp" id="userTp2" style="width:16px; height:16px;" /><label for="userTp2">기업회원</label></div>
						<div class="check_choice3"><input type="radio" value="3"  name="userTp" id="userTp3" style="width:16px; height:16px;" /><label for="userTp3">기관회원</label></div>
>>>>>>> 4424c7885b5c7f1cf0e25c6d2dc73af3c1fdf129
					</div>

					<div class="memberCountry">
						<div class="check_choice4"><input type="radio" value="1" checked="checked" name="grobalTp" id="grobalTp1" style="width:14px; height:14px;" /><label for="grobalTp1">국내인</label></div>
						<div class="check_choice5"><input type="radio" value="2" name="grobalTp" id="grobalTp2"  style="width:14px; height:14px;" /><label for="grobalTp2">외국인</label></div>
						<div class="reference">※ 개인회원은 전남과학기술정보시스템의 일부 서비스를 제공 받으실 수 없습니다.</div>
					</div>

				</div>
				<!--memberKindWrap E-->

			</div>
			<!--agreeBox2 E-->


<!--btnBox1 S-->

			<!--btnBox1 S-->
			<div class="btnBox1" id="btnBox1">
				<button class="btn_g-pin" onclick="agreeCheck('GPIN');" >G-PIN 인증</button>
				<button class="btn_phone" onclick="agreeCheck('MOBILE');" >휴대폰 인증</button>
			</div>
			<!--btnBox1 E-->


		<!--btnBox1 S-->
			<div class="btnBox1" id="btnBox2" style="display:none">
				<button class="btn_g-pin" onclick="agreeCheck('FOREIGN');" >외국인가입</button>
			</div>
			<!--btnBox1 E-->

	</form>
