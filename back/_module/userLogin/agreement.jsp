<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <style>
    	#content{
    		padding:50px;
    		width:800px;
    	}
    	#allAgree{
			float:right;
			height:50px;
    	}
    	
    	.agreementBox{
    		width:100%;
    		height:200px;
    		border:1px #000000 solid;
    		padding : 10px
    	}
    	
    	.header{
    		width:100%;
    	}
    	
    	.body{
    		width:100%;
    		
    	}
   		
    
    </style>
    
    
    <div id ="content" >
    	<form name="agreeForm" id="agreeForm" action="/sys/login.do" method="post" >
    	<input type="hidden" name="mode" id="mode"/>
	    <div id="allAgree">
	    	<input type="button" value="전체동의" onclick="allAgree();"/>
	    </div>
		<div id="agreement">
			<div class="agreementBox">
				<div class="header">
					이용약관
				</div>
				<div class="body">
					<textarea rows="7" style="width:100%;" readonly="readonly">약관</textarea>	
				</div>
				<div style="float:right">
					<label>
						<input type="checkbox" value="Y" name="termsAgree" id = "termsAgree"/>
						상기 약관에 동의합니다.(필수)
					</label>
				</div>
			</div>
			<div class="agreementBox">
				<div class="header">개인정보의 보유기간 및 이용기간</div>
				<div class="body">
					<textarea rows="7" style="width:100%;" readonly="readonly">약관</textarea>	
				</div>
				<div style="float:right">
					<label>
						<input type="checkbox" value="Y" name="possProdAgrrYn" id = "possProdAgrrYn"/>
						상기 개인정보의 보유기간 및 이용기간에 동의합니다.(필수)
					</label>
				</div>
			</div>
			<div class="agreementBox">
				<div class="header">개인정보 수집 동의 안내</div>
				<div class="body">
					<textarea rows="7" style="width:100%;" readonly="readonly">약관</textarea>	
				</div>
				<div style="float:right">
					<label>
						<input type="checkbox" value="Y" name="requiredClagYn" id = "requiredClagYn"/>
						상기 필수항목 수집에 동의합니다.(필수)
					</label>
				</div>
			</div>
			<div class="agreementBox">
				<div class="body">
					<textarea rows="7" style="width:100%;" readonly="readonly">약관</textarea>	
				</div>
				<div style="float:right">
					<label>
						<input type="checkbox" value="Y" name="psnInfoAgreeYn" id = "psnInfoAgreeYn"/>
						상기 선택항목 수집에 동의합니다.(선택)
					</label>
				</div>
			</div>
			<div class="agreementBox">
				<div class="header">
					개인정보 활용 동의 안내
				</div>
				<div class="body">
					<textarea rows="7" style="width:100%;" readonly="readonly">약관</textarea>	
				</div>
				<div style="float:right">
					<label>
						<input type="checkbox" value="Y" name="choiceClagYn" id = "choiceClagYn"/>
						상기 개인정보 활용에 동의합니다.(선택)
					</label>
				</div>
			</div>
		</div>
		<div class="btn_right_box">
			<input class="btn_inp_b_01" type="button" value="이전" onclick="window.location.href='/sys/login.do'"/>
			<input class="btn_inp_b_01" type="button" value="다음" onclick="agreeCheck();"/>
		</div>
		</form>
	</div>
	
	<script type="text/javascript">
	function allAgree(){ 
            $('input[type="checkbox"]').prop('checked', true);
	}
	
	function agreeCheck(){
		if(!$("#termsAgree").is(":checked")){
			alert("이용약관의 동의가 필요합니다.");
			$("#termsAgree").focus();
			return false;
		}
		if(!$("#possProdAgrrYn").is(":checked")){
			alert("개인정보의 보유기간 및 이용시간의 동의가 필요합니다.");
			return false;
		}
		if(!$("#requiredClagYn").is(":checked")){
			alert("개인정보 수집 동의 안내가 필요합니다.");
			return false;
		}
		$("#mode").val("step2");
		$("#agreeForm").submit();
		
	}
	</script>