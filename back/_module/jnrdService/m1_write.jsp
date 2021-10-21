<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
   
   

	ArrayList<HashMap<String, String>> supportList = request.getAttribute("supportList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportList");
	ArrayList<HashMap<String, String>> applicationList = request.getAttribute("applicationList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("applicationList");
	ArrayList<HashMap<String, String>> technologyList = request.getAttribute("technologyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("technologyList");
	
	
/*
ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
ArrayList<HashMap<String, String>> rndStageList = request.getAttribute("rndStageList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
ArrayList<HashMap<String, String>> rndPurposeList = request.getAttribute("rndPurposeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndPurposeList");
ArrayList<HashMap<String, String>> scienceBList = request.getAttribute("scienceBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndStageList");
ArrayList<HashMap<String, String>> emphasisBList = request.getAttribute("emphasisBList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("emphasisBList");
ArrayList<HashMap<String, String>> rndTbList = request.getAttribute("rndTbList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndTbList");
ArrayList<HashMap<String, String>> IndustryList = request.getAttribute("IndustryList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("IndustryList");
ArrayList<HashMap<String, String>> blueList = request.getAttribute("blueList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("blueList");
ArrayList<HashMap<String, String>> agencyList = request.getAttribute("agencyList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyList");
*/

   String mode = util.getStr(paramMap.get("mode"));
   String nowPage = util.getStr(paramMap.get("nowPage"));
   String userIdx = util.getStr(paramMap.get("userIdx"));
   if("".equals(mode)) mode = "write";

   String fileGrp = "Jnrdm1";
   String fileSubGrp = "";
   String fileFullGrp =fileGrp+fileSubGrp;

   int scCnt = 0;
       
       
%>

<style>
table.skin_basic_write td.padding_none{padding:0;}
#businesslist td p{padding:10px 0; border-top:1px solid #ddd;}
#businesslist td p:first-child{border-top:none;}

#businesslist td p span{display:inline-block; width:100px; text-align:center;}

.htmlSet{clear:both; font-size:14px; border:1px solid #ddd; margin-bottom:15px; padding:30px 20px; text-align:left;}
.htmlBtn{float:right; padding:5px 10px; margin-left:5px; background:#333; color:#f8f8f8; cursor:pointer; vertical-align:middle;}
.cRed{background:#fd4343;}
.cGreen{background:#3fc127;}
.cGreay{background:#b9b9b9 !important; cursor:unset;}
.cBlue{background:#2d93fd;}
.hideBox{clear:both; border:1px solid #ddd; color:#999; font-size:14px; margin-bottom:15px; padding:30px 20px; text-align:center;}
.hideBox_n{clear:both; border:1px solid #ddd; background:#f8f8f8; color:#999; font-size:14px; margin-bottom:15px; padding:15px 0; text-align:center;}
.bdText{color:#ff0000; margin-left:30px;}

.htmlResultSet{clear:both; font-size:14px; border:1px solid #ddd; margin-bottom:15px; padding:30px 20px; text-align:left;}

.result_content{border-bottom:1px dashed #ddd; padding-bottom:20px; margin-bottom:30px;}
.submitBtn{margin:50px auto 30px; border:1px solid #ddd; background:#498944; color:#fff; padding:10px 30px; display:block; font-size:14px;}
.addPriceInfo{margin:50px auto 30px; border:1px solid #ddd; background:#498944; color:#fff; padding:10px 30px; display:block; width:100px; text-align:center; font-size:14px; float:unset;}
.addPriceInfo_off{margin:50px auto 30px; border:1px solid #ddd; background:#f7f7f7; color:#999; padding:10px 30px; display:block; width:100px; text-align:center; font-size:14px; float:unset;}
</style>

<jsp:useBean id="currTime" class="java.util.Date" />


<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="/sys/<%=myPage%>" />
	<input type="hidden" name="proState" id="proState" value="" />
	<div class="skin_bbs_write" style="margin-top: 30px">
	
	<p style="color:red;"><span style="color:red;" >*</span>) 필수 입력사항입니다.</p>

	<!-- 기본정보 S -->
	<h2 class="tit">사업(과제) 기본정보</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>사업(과제) 기본정보</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit">사업(과제)관리번호</th>
           		<td colspan="3">
           			<input type="text" name="mcode" id="MCODE" value="JNR-" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> R&D재원 구분</th>
           		<td colspan="3">
           			<label><input type="radio" name="mtype" value="국비R&D" checked="checked"> 국비 R&D</label>
           			<label><input type="radio" name="mtype" value="국가비R&D"> 국가비R&D</label>
           			<label><input type="radio" name="mtype" value="도비R&D"> 도비R&D</label>
           			<label><input type="radio" name="mtype" value="도비비R&D"> 도비비R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업성격</th>
           		<td colspan="3">
           			<label><input type="radio" name="btype" value="국비사업" checked="checked"> 국비사업</label>
           			<label><input type="radio" name="btype" value="매칭사업"> 매칭사업</label>
           			<label><input type="radio" name="btype" value="자체사업"> 자체사업</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 관리사업구분</th>
           		<td colspan="3">
           			<label><input type="radio" name="ctype" value="중점R&D" checked="checked"> 중점R&D</label>
           			<label><input type="radio" name="ctype" value="관리R&D"> 관리R&D</label>
           			<label><input type="radio" name="ctype" value="중점비R&D"> 중점비R&D</label>
           			<label><input type="radio" name="ctype" value="관리비R&D"> 관리비R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 지원부처(청)명</th>
           		<td colspan="3">
           			<select name="mname" class="select_box">
           				<option value="">:::선택:::</option>
           				<%
							for(HashMap sup:supportList){
						%>
						<option value="<%=util.getStr(sup.get("CODE_NM"))%>"><%=util.getStr(sup.get("CODE_NM"))%></option>
						<% 
						}
						%>
           			</select>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 부처(전남도)사업명</th>
           		<td colspan="3">
           			<input type="text" name="mbname" id="MBNAME" class="inp_txt" vaule="" size="50"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> 과제명</th>
           		<td colspan="3">
           			<input type="text" name="hname" id="HNAME" class="inp_txt" vaule="" size="50"/>
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- 기본정보 E -->



	<!-- 연구기간 -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">연구기간</h2>
    <div class="zoom">
		
	</div>
	<div id="businesslist">
  		<table class="skin_basic_write">
  			<caption>연구기간</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> 시작연월일</th>
	         		<td>
	         			<input type="text" name="msdate" id="MSDATE" class="inp_txt read_only" readonly vaule=""/>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> 종료연월일</th>
	         		<td>
	         			<input type="text" name="medate" id="MEDATE" class="inp_txt read_only" readonly vaule=""/>
	         			<label><input type="checkbox" name="ming" id="MING" value="1"/>연차계속</label>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">연구기간(개월)</th>
	         		<td>
	         			<input type="hidden" name="mMonth" value="" />
	         			<span id="monthTit"></span>
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
	
	</div>
    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="신청하기" onclick="goCheck()"/>
           <input type="button" class="btn_inp_w_01" value="목록" />
    </div>
    <!--// bo_btn -->
</form>


<div style="padding-top:15px"></div>




<div id="ncontentBox">
	
	<h2 class="tit">대상연도예산액</h2>
	<div class="zoom"></div>
	
	<div class="hideBox">
		기본정보를 먼저 등록하세요
	</div>
		
</div>
<div style="padding-top:15px"></div>


<div id="resultBox">
	
	<h2 class="tit">성과등록</h2>
	<div class="zoom"></div>
	
	<div class="hideBox">
		기본정보를 먼저 등록하세요
	</div>
	
		
</div>








<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	$(document).on("click",".btn_inp_w_01",function(){	
		location.href="/sys/sys_jnrd_m1.do";
	});

	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^가-힣]/;
	var characPattern = /[^a-zA-Z0-9^가-힣]/;
	var engPattern  = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var datePattern = /^[0-9]{4}-[0-9]{2}/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
	var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	var sDateYear = 0;
	var eDateYear = 0;
	var yearOption = "";
	
	
	
	
	var submitChk = false;

	function goSubmit(mode,proState){
		$('#proState').val(proState);
		$('#mode').val(mode);
		
		var formData = new FormData($("#fwrite")[0]);
		
		if(submitChk){
			return false;
		}else{
			submitChk = true;
		}
			
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdM1_formAjax.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	if(data.status == "OK"){
            		
            		alert("기본정보가 저장되었습니다.\n추가정보가 활성화 됩니다.");
            		var midx = data.paramMap.midx;
            		
            		for(var y=sDateYear; y<=eDateYear; y++){
            			
            			var htmlSet1 = "";
            			var htmlSet2 = "";
            			
            			htmlSet1 += '<div class="htmlSet" id="htmlCont_'+y+'">';
            			htmlSet1 += '<input type="hidden" name="midx" value="'+midx+'">'
	            		htmlSet1 += '조사대상년도 : <strong>'+y+'</strong>년 <span class="bdText"></span>';
	            		htmlSet1 += '<span class="htmlBtn add addPriceSet" data-year="'+y+'" data-midx="'+midx+'">작성하기</span>';
	            		//htmlSet1 += '<span class="htmlBtn nps addNpSet cRed" data-year="'+y+'" data-midx="'+midx+'">비대상적용</span>';
	            		htmlSet1 += '</div>';
	            		
	            		htmlSet2 += '<div class="htmlResultSet" id="htmlResultCont_'+y+'">';
            			htmlSet2 += '<input type="hidden" name="midx" value="'+midx+'">'
	            		htmlSet2 += '성과발생년도 : <strong>'+y+'</strong>년 <span class="bdText"></span>';
	            		htmlSet2 += '<span class="htmlBtn addx addResultSet" data-year="'+y+'" data-midx="'+midx+'">성과등록</span>';
	            		//htmlSet2 += '<span class="htmlBtn npsx addResultNpSet cRed" data-year="'+y+'" data-midx="'+midx+'">성과미등록</span>';
	            		htmlSet2 += '</div>';
	            		
	            		$("#ncontentBox").append(htmlSet1);
	            		$("#resultBox").append(htmlSet2);
            		}
            		
            		
            		$("#ncontentBox").show();
        			$(".hideBox").hide();
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
    }
	
	
	function areaClick(mode,no){
		if(no =="2"){
			$("#"+mode+"1").val("");
			$("#"+mode+"1").attr("name","0");
			$("#"+mode+"2").attr("name",mode);
			$("#"+mode+"1").hide();
			$("#"+mode+"2").show();
		}else{
			$("#"+mode+"2").val("");
			$("#"+mode+"2").attr("name","0");
			$("#"+mode+"1").attr("name",mode);
			$("#"+mode+"2").hide();
			$("#"+mode+"1").show();
		}
	}


//신청하기-데이터 체크 S
	function goCheck(){
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
        var fileCount = $("input[type=file]").length;
		
        if($("select[name='mname']").val() == ""){
        	alert('지원부처(청)명을 입력하세요');
        	$("select[name='mname']").focus();
        	return false;
        }
        
        if($("input[name='mbname']").val() == ""){
        	alert('부처(전남도)사업명을 입력하세요');
        	$("input[name='mbname']").focus();
        	return false;
        }
        
        if($("input[name='hname']").val() == ""){
        	alert('과제명을 입력하세요');
        	$("input[name='hname']").focus();
        	return false;
        }
        
        if($("#MSDATE").val() == ""){
        	alert('연구시작일을 작성하세요');
        	$("#MSDATE").focus();
        	return false;
        }
        
        if($("#MEDATE").val() == "" && !$("#MING").is(":checked")){
        	alert('연구종료일을 작성하세요');
        	$("#MEDATE").focus();
        	return false;
        }
        
        
		
	    
		goSubmit('writeProc','10');
	}
	
	
	
	
	
//신청하기-데이터 체트 E
//팝업창 S
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=620, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
//팝업창 E
//기본datePicker S
	$("#MEDATE").datepicker({
       	showMonthAfterYear : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['일','월','화','수','목','금','토'],
       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	onClose: function(dateText, inst) {
       		var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
       		eDateYear = parseInt(year);
       		
       		console.log(sDateYear+"------"+eDateYear);
       	}
	});
	
	$("#MSDATE").datepicker({
       	showMonthAfterYear : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
       	dayNamesMin : ['일','월','화','수','목','금','토'],
       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            var xNum = "";
            
            sDateYear = parseInt(year);
            
            //코드번호생성
            $.ajax({
	            type: "POST",
	            data: {year:year},
	            url : '/sys/jntisJnrdM1Ajax.do',
	            dataType : 'json',
	            success : function(data){	            	
	            	if(data.dataList != null){
	            		xNum = String(data.dataList.IDX).padStart(5,"0");
	            		$("#MCODE").val("JNR-"+year+"-"+xNum);
	            	}else{
	            		$("#MCODE").val("JNR-"+year+"-00001");
	            	}           		
	            }
   			});            
        }
	});
	
	var toDate = new Date();
	var toDateYear = toDate.getFullYear();
	
	
	$(document).on("click","#npset1",function(){
		if($(this).is(":checked") && $(this).parents("div.ncontent").find("#npyear1").val() == ""){
			alert("조사대상연도를 먼저 선택하세요");
			$(this).parents("div.ncontent").find("#npyear1").focus();
			$(this).prop("checked",false);
			
		}else if($(this).is(":checked") && $(this).parents("div.ncontent").find("#npyear1").val() != ""){
			
			$(this).parents("div.ncontent").find("input").not(this).prop("disabled",true);
			$(this).parents("div.ncontent").find("option").attr("disabled",true);
			$(this).parents("div.ncontent").find("textarea").attr("disabled",true);
			$(this).parents("div.ncontent").find("input[name='midx']").prop("disabled",false);
			$(this).parents("div.ncontent").find("input[name='npyear']").prop("disabled",false);
			
			$(this).parents("div.ncontent").find("input[name='fileSn'],input[name='fileFlog']").prop("disabled",false);
			
			//$(this).prop("disabled",false);
			
		}else{
			
			/* 하위메뉴 비활성 */
			$(this).parents("div.ncontent").find("input").not(this).prop("disabled",false);
			$(this).parents("div.ncontent").find("option").attr("disabled",false);
			$(this).parents("div.ncontent").find("textarea").attr("disabled",false);
			
			if($(this).parents("div.ncontent").find("input[name='nptype2']:checked").val() == "미확정"){
				
				$(this).parents("div.ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",true);
			}
			
			
			
			
		}
	});
	
	
	$(document).on("click","#reset",function(){
		if($(this).is(":checked") && $(this).parents("div.result_content").find("#reyear").val() == ""){
			alert("조사대상연도를 먼저 선택하세요");
			//$(this).parents("div.result_content").find("#reyear").focus();
			$(this).prop("checked",false);
			
		}else if($(this).is(":checked") && $(this).parents("div.result_content").find("#reyear").val() != ""){
			
			$(this).parents("div.result_content").find("input").not(this).prop("disabled",true);
			$(this).parents("div.result_content").find("option").attr("disabled",true);
			$(this).parents("div.result_content").find("textarea").attr("disabled",true);
			$(this).parents("div.result_content").find(".hideBox_n").text("미등록상태에서는 성과를 등록할 수 없습니다.");
			$(this).parents("div.result_content").find(".submitBtn").prop("disabled",false);
			$(this).parents("div.result_content").find("input[name='midx']").prop("disabled",false);
			$(this).parents("div.result_content").find("input[name='reyear']").prop("disabled",false);
			
		}else{
			
			/* 하위메뉴 비활성 */
			$(this).parents("div.result_content").find("input").not(this).prop("disabled",false);
			$(this).parents("div.result_content").find("option").attr("disabled",false);
			$(this).parents("div.result_content").find("textarea").attr("disabled",false);
			$(this).parents("div.result_content").find(".hideBox_n").text("+ 버튼을 누르고 성과를 등록하세요");
			//$(this).parents("div.result_content").find(":button").removeClass("cGreay");
		}
	});
	
	
	$("input[name='medate']").on("change",function(){
		if($("input[name='msdate']").val() == ""){
			alert("연구기간 시작일을 선택하세요");
			$("input[name='msdate']").focus();
			$("input[name='medate']").val("");
			return false;
		}
		var sdate = $("input[name='msdate']").val().split("-");
		var sy = new Date(sdate[0],sdate[1],sdate[2]);
		var ey = new Date($(this).val());
		var dif = ey - sy;
		var cDay = 86400*1000;
		var cMonth = cDay*30;
		var monthTot = parseInt((dif/cMonth)+1);
		
		$("input[name='mMonth']").val(monthTot);
		$("#monthTit").html(monthTot+"개월");
	});
	
	$("input[name='ming']").on("click",function(){
		if($(this).is(":checked")){
			eDateYear = parseInt(toDateYear);
			$("input[name='medate']").val("");
			$("input[name='medate']").attr("disabled",true);
			$("input[name='mMonth']").val(0);
			$("#monthTit").html("연차계속");
		}else{
			eDateYear = "";
			$("input[name='medate']").attr("disabled",false);
			$("#monthTit").html("");
		}		
	});
	
	/*
	var ncontentNum = 1;
	
	function addRow(mode){
		
		$.ajax({
            cache : false,
            url : "/sys/sysJnrd_ncontentAjax.do", // 요기에
            type : 'POST', 
            data : {num:ncontentNum},
            dataType : 'HTML',
            success : function(data) {
            	
            	$("#ncontentBox").append(data);
            	
            	for(var y=sDateYear; y<=eDateYear; y++){
        			yearOption += "<option>"+y+"</option>";
        		}
            	$("#ncontent"+ncontentNum).find("#npyear"+ncontentNum).append(yearOption);
            	ncontentNum ++;
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
	}*/
	
	$(document).on("click",".addPriceSet",function(){
		
		if(year == ""){
			alert("조사대상년도는 공백일 수 없습니다.");
			$("#MSDATE").focus();
			return false;
		}
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrd_ncontentAjax.do", // 요기에
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'HTML',
			success : function(data) {
				$("#htmlCont_"+year).after(data);
				$this.parents(".htmlSet").find(".htmlBtn").addClass("cGreay");
				$this.removeClass("addPriceSet");
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	$(document).on("click",".addResultSet",function(){
		
		if(year == ""){
			alert("성과발생년도는 공백일 수 없습니다.");
			$("#MSDATE").focus();
			return false;
		}
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrd_resultWriteAjax.do", // 요기에
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'HTML',
			success : function(data) {
				$("#htmlResultCont_"+year).after(data);
				$this.parents(".htmlResultSet").find(".htmlBtn").addClass("cGreay");
				$this.removeClass("addResultSet");
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	//비대상적용
	$(document).on("click",".addNpSet",function(){
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrdNpSetAjax.do", // 요기에
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'JSON',
			success : function(data) {
				
				if(data.state == "OK"){
				
					$this.parents(".htmlSet").find(".htmlBtn").addClass("cGreay");
					$this.parents(".htmlSet").find(".htmlBtn").removeClass("addPriceSet");
					$this.parents(".htmlSet").find(".htmlBtn").removeClass("addNpSet");
					$this.text("비대상적용해제");
					$this.parents(".htmlSet").find(".bdText").text("해당년도 비대상 적용중");
					$this.removeClass("cGreay");
					$this.addClass("ageNpset cBlue");
					
				
				}else{
					alert("적용에 실패하셨습니다. 관리자에게 문의하세요");
				}
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	$(document).on("click",".ageNpset",function(){
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrdNpSetDelAjax.do",
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'HTML',
			success : function(data) {
				
				$this.parents(".htmlSet").find(".add").addClass("addPriceSet");
				$this.parents(".htmlSet").find(".htmlBtn").removeClass("cGreay cBlue");
				$this.text("비대상적용");
				$this.parents(".htmlSet").find(".bdText").text("");
				$this.removeClass("ageNpset");
				$this.addClass("ageNpset");
				
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		
	});
	
	
	function delRow(mode){
		
		$(".ncontent:last").remove();
		ncontentNum --;
	}
	
	
	
	function fillZero(width, str){
		var xcode = "";
		if(str.length >= width){
			xcode = str;
		}else{
			var mm = "";
			for(var i=0; i<(width-str.length+1); i++){
				mm += "0";
			}
			xcode = mm+str;
		}
	    return xcode;
	}
	
	
	$(document).on("change","#npprice1,#npprice2,#npprice3,#npprice4",function(){
		
		var np1 = $(this).parents(".ncontent").find("#npprice1").val();
		var np2 = $(this).parents(".ncontent").find("#npprice2").val();
		var np3 = $(this).parents(".ncontent").find("#npprice3").val();
		var np4 = $(this).parents(".ncontent").find("#npprice4").val();
		
		var npp1 = (np1 == "")?0:np1;
		var npp2 = (np2 == "")?0:np2;
		var npp3 = (np3 == "")?0:np3;
		var npp4 = (np4 == "")?0:np4;
		
		var totP = parseInt(npp1)+parseInt(npp2)+parseInt(npp3)+parseInt(npp4);
		$(this).parents(".ncontent").find("#npprice5").val(totP);
		
	});
	
	
	$(document).on("change","input[name='busprice'],input[name='busnum']",function(){
		
		var np1 = $(this).parents(".skin_basic_write").find("input[name='busprice']").val();
		var np2 = $(this).parents(".skin_basic_write").find("input[name='busnum']").val();
		
		var npp1 = (np1 == "")?0:np1;
		var npp2 = (np2 == "")?0:np2;
		
		var totP = parseInt(npp1)*parseInt(npp2);
		$(this).parents(".skin_basic_write").find("input[name='bustotprice']").val(totP);
		$(this).parents(".skin_basic_write").find(".bustotprice").text(totP);
		
	});
	
	
	
	$(document).on("click",".submitBtn",function (){
		var f = $(this).parents(".result_content").find("form")[0];
		var formData = new FormData(f);
		var $this = $(this);
			
		if(formData.get("reperson") == "" && (formData.get("retype") == "고용" || formData.get("retype") == "고용/매출" )){
			alert("고용인원을 입력하세요");
			$(this).parents(".result_content").find("#reperson").focus();
			return false;
		}
		if(formData.get("reprice") == "" && (formData.get("retype") == "매출" || formData.get("retype") == "고용/매출" )){
			alert("매출을 입력하세요");
			$(this).parents(".result_content").find("#reprice").focus();
			return false;
		}
		
		if(formData.has("chk_info")){
			
			if($(this).parents(".result_content").find("input[name='re1name']:last").val() == ""){
				alert("논문성과의 논문명을 입력하세요");
				$(this).parents(".result_content").find("input[name='re1name']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1aname']:last").val() == ""){
				alert("논문성과의 등재지명을 입력하세요");
				$(this).parents(".result_content").find("input[name='re1aname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1date']:last").val() == ""){
				alert("논문성과의 등재일을 입력하세요");
				$(this).parents(".result_content").find("input[name='re1date']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_se")){
			
			if($(this).parents(".result_content").find("select[name='setype']:last").val() == ""){
				alert("출원/등록구분을 입력하세요");
				$(this).parents(".result_content").find("select[name='setype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='senumber']:last").val() == ""){
				alert("출원번호를 입력하세요");
				$(this).parents(".result_content").find("input[name='senumber']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='sedate']:last").val() == ""){
				alert("출원일을 입력하세요");
				$(this).parents(".result_content").find("input[name='sedate']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sename']:last").val() == ""){
				alert("지적재산권명을 입력하세요");
				$(this).parents(".result_content").find("input[name='sename']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sesetdate']:last").val() == ""){
				alert("등록기간을 입력하세요");
				$(this).parents(".result_content").find("input[name='sesetdate']:last").focus();
				return false;
			}
		}
		
		
		if(formData.has("chk_tech")){
			
			if($(this).parents(".result_content").find("select[name='tetype']:last").val() == ""){
				alert("기술이전구분을 입력하세요");
				$(this).parents(".result_content").find("select[name='tetype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='teprice']:last").val() == ""){
				alert("기술료를 입력하세요");
				$(this).parents(".result_content").find("input[name='teprice']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='te_nprice']:last").val() == ""){
				alert("이전기술료을 입력하세요");
				$(this).parents(".result_content").find("input[name='te_nprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tenname']:last").val() == ""){
				alert("양도기관(기업)을 입력하세요");
				$(this).parents(".result_content").find("input[name='tenname']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tegname']:last").val() == ""){
				alert("양수기관(기업)을 입력하세요");
				$(this).parents(".result_content").find("input[name='tegname']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_bus")){
			
			if($(this).parents(".result_content").find("input[name='busname']:last").val() == ""){
				alert("연구시설장비명을 입력하세요");
				$(this).parents(".result_content").find("input[name='busname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busstatus']:last").val() == ""){
				alert("주요사양을 입력하세요");
				$(this).parents(".result_content").find("input[name='busstatus']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busprice']:last").val() == ""){
				alert("구축단가를 입력하세요");
				$(this).parents(".result_content").find("input[name='busprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='busnum']:last").val() == ""){
				alert("구축수량을 입력하세요");
				$(this).parents(".result_content").find("input[name='busnum']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_pps")){
			
			if($(this).parents(".result_content").find("input[name='ppsname']:last").val() == ""){
				alert("품종명칭을 입력하세요");
				$(this).parents(".result_content").find("input[name='ppsname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='ppsxname']:last").val() == ""){
				alert("작물명칭 입력하세요");
				$(this).parents(".result_content").find("input[name='ppsxname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("select[name='ppstype']:last").val() == ""){
				alert("출원/등록구분을 입력하세요");
				$(this).parents(".result_content").find("select[name='ppstype']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsnum']:last").val() == ""){
				alert("출원번호(등록번호)을 입력하세요");
				$(this).parents(".result_content").find("input[name='ppsnum']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsdate']:last").val() == ""){
				alert("출원일(등록일)을 입력하세요");
				$(this).parents(".result_content").find("input[name='ppsdate']:last").focus();
				return false;
			}
		}		
		
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdResultFormWriteProc.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	
            	var midx = data.paramMap.mridx;
            	
            	if(data.status == "OK" && midx > 0){
            		
            		alert('저장완료!!');
            		$this.prop("disabled",true);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		return false;
	});
	
	
	
	$(document).on("click",".addPriceInfo",function(){
		var year = $(this).data("year");
		var formData = new FormData($("#ncontForm_"+year)[0]);
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
		var $this = $(this);
		
		if($(this).parents(".ncontent").find("input[name='npset']").is(":checked")){
			
			
			
			
		}else{
			
			if($(this).parents(".ncontent").find("input[name='nptype2']:checked").val() != "미확정"){
		
				if($(this).parents(".ncontent").find("#nptotprice").val() == ""){
					alert("총연구비 작성");
					$(this).parents(".ncontent").find("#nptotprice").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice1").val() == ""){
					alert("국비 작성");
					$(this).parents(".ncontent").find("#npprice1").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice2").val() == ""){
					alert("도비 작성");
					$(this).parents(".ncontent").find("#npprice2").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice3").val() == ""){
					alert("시군비 작성");
					$(this).parents(".ncontent").find("#npprice3").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice4").val() == ""){
					alert("기타 작성");
					$(this).parents(".ncontent").find("#npprice4").focus();
					return false;
				}
				
			}
			
			
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File1").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File1").val() == ""){
	   			alert("파일을 첨부하세요.");
	   			return false;
	   		}else{
	   			alert("문서 파일만 첨부하실 수 있습니다.");
	   			return false;
	   		}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File2").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File2").val() == ""){
	   			alert("파일을 첨부하세요.");
	   			return false;
	   		}else{
	   			alert("문서 파일만 첨부하실 수 있습니다.");
	   			return false;
	   		}
			
			<%-- if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File3").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File3").val() == ""){
	   			alert("파일을 첨부하세요.");
	   			return false;
	   		}else{
	   			alert("문서 파일만 첨부하실 수 있습니다.");
	   			return false;
	   		} --%>
			
			if($(this).parents(".ncontent").find("#npotext1").val() == ""){
				alert("전문기관 작성");
				$(this).parents(".ncontent").find("#npotext1").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext2").val() == ""){
				alert("관리기관 작성");
				$(this).parents(".ncontent").find("#npotext2").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext3").val() == ""){
				alert("기관유형 작성");
				$(this).parents(".ncontent").find("#npotext3").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext4").val() == ""){
				alert("주관기관 작성");
				$(this).parents(".ncontent").find("#npotext4").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext5").val() == ""){
				alert("주관기관소재지 작성");
				$(this).parents(".ncontent").find("#npotext5").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext6").val() == ""){
				alert("소속부서(학과) 작성");
				$(this).parents(".ncontent").find("#npotext6").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext7").val() == ""){
				alert("연구책임자명 작성");
				$(this).parents(".ncontent").find("#npotext7").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext8").val() == ""){
				alert("연구책임자직위 작성");
				$(this).parents(".ncontent").find("#npotext8").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext9").val() == ""){
				alert("연구책임자 최정학위 작성");
				$(this).parents(".ncontent").find("#npotext9").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext10").val() == ""){
				alert("사업시행지 작성");
				$(this).parents(".ncontent").find("#npotext10").focus();
				return false;
			}
			
		}	
			
		$.ajax({
            cache : false,
            url : "/sys/sysJnrdM1PriceInfoWriteProc.do",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData,
            dataType : 'JSON',
            success : function(data) {
            	
            	var midx = data.paramMap.midx;
            	
            	if(data.status == "OK" && midx > 0){
            		
            		alert('저장완료!!');
            		$this.removeClass("addPriceInfo");
            		$this.addClass("addPriceInfo_off");
            		$this.text("등록완료");
            		$(".addPriceInfo_off").attr("data-midx",midx);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		
	});
	
	
	
	
	
	
	
	
	
	// ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇddd
	function addResultRow(mode,year){ //논문성과
		
		if(mode == "info"){
			
			var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
			var ScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
			
			if(cnt > 0){
				
				if($("#resultInfo_t1_"+year).find('input[name=re1name]:last').val() == ""){
					alert("논문명를 작성하세요");
					$("#resultInfo_t1_"+year).find('input[name=re1name]:last').focus();
					return false;
				}
				if($("#resultInfo_t1_"+year).find('input[name="re1aname"]:last').val() == ""){
					alert("등재지명를 작성하세요");
					$("#resultInfo_t1_"+year).find('input[name="re1aname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t1_"+year).find('input[name="re1date"]:last').val() == ""){
					alert("등재일을 작성하세요");
					$("#resultInfo_t1_"+year).find('input[name="re1date"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>논문성과</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '	  	<tr>';
			htmlCont += '      		<th scope="row" class="tit"><span style="color:red;" >*</span> 논문구분</th>';
			htmlCont += '      		<td colspan="3">';
			htmlCont += '      			<input type="hidden" name="chk_info" value="'+ScCnt+'">';
			htmlCont += '          		<label><input type="radio" name="re1type_'+ScCnt+'" value="SCI(E)등재" checked="checked"> SCI(E)등재</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="비SCI(E)등재"> 비SCI(E)등재</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="학술대회"> 학술대회</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="기타"> 기타</label>';
			htmlCont += '          	</td>';
			htmlCont += '       </tr>';
			htmlCont += '       <tr>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> 논문명</th>';
			htmlCont += '       	<td>';
			htmlCont += '       		<input type="text" name="re1name" id="re1name_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> 등재지명</th>';
			htmlCont += '       	<td>';
			htmlCont += '       		<input type="text" name="re1aname" id="re1aname_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       </tr>';
			htmlCont += '       <tr>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> 등재일</th>';
			htmlCont += '       	<td colspan="3">';
			htmlCont += '       		<input type="text" name="re1date" id="re1date_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       </tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t1_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t1_"+year).append(htmlCont);
			
			$("input[name='re1date']").datepicker({
		       	showMonthAfterYear : true,
		       	changeMonth : true,
		       	changeYear : true,
		       	dateFormat : "yy-mm-dd",
		       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		       	dayNamesMin : ['일','월','화','수','목','금','토'],
		       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
		
		}else if(mode == "se"){ //지적재산성과
			
			var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
			var ScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
			
			if(cnt > 0){
				
				if($("#resultInfo_t2_"+year).find('select[name=setype]:last').val() == ""){
					alert("출원/등록구분를 선택하세요");
					$("#resultInfo_t2_"+year).find('select[name=setype]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="senumber"]:last').val() == ""){
					alert("출원번호(등록번호)를 작성하세요");
					$("#resultInfo_t2_"+year).find('input[name="senumber"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sedate"]:last').val() == ""){
					alert("출원일(등록일)을 작성하세요");
					$("#resultInfo_t2_"+year).find('input[name="sedate"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sename"]:last').val() == ""){
					alert("지적재산권명을 작성하세요");
					$("#resultInfo_t2_"+year).find('input[name="sename"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sesetdate"]:last').val() == ""){
					alert("등록기간을 작성하세요");
					$("#resultInfo_t2_"+year).find('input[name="sesetdate"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>지적재산성과</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 출원/등록구분</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_se" value="'+ScCnt+'">';
	      	htmlCont += '		<select class="select_box" name="setype">';
	      	htmlCont += '			<option value="">::선택::</option>';
	      	<%
			for(HashMap rs:applicationList){
			%>
			htmlCont += '			<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>';
			<% 
			}
			%>
	      	
	      	htmlCont += '		</select>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 출원번호(등록번호)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="senumber" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 출원일(등록일)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sedate" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 지적재산권명</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sename" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 등록기관</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sesetdate" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t2_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t2_"+year).append(htmlCont);
			
			$("input[name='sedate']").datepicker({
		       	showMonthAfterYear : true,
		       	changeMonth : true,
		       	changeYear : true,
		       	dateFormat : "yy-mm-dd",
		       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		       	dayNamesMin : ['일','월','화','수','목','금','토'],
		       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
			
		}else if(mode == "tech"){ //기술이전성과
			
			var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
			var ScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
			
			if(cnt > 0){
				
				if($("#resultInfo_t3_"+year).find('select[name=tetype]:last').val() == ""){
					alert("기술이전구분를 선택하세요");
					$("#resultInfo_t3_"+year).find('select[name=tetype]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="teprice"]:last').val() == ""){
					alert("기술료를 작성하세요");
					$("#resultInfo_t3_"+year).find('input[name="teprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="te_nprice"]:last').val() == ""){
					alert("이전기술명을 작성하세요");
					$("#resultInfo_t3_"+year).find('input[name="te_nprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="tenname"]:last').val() == ""){
					alert("양도기관(기업) 작성하세요");
					$("#resultInfo_t3_"+year).find('input[name="tenname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="tegname"]:last').val() == ""){
					alert("양수기관(기업) 작성하세요");
					$("#resultInfo_t3_"+year).find('input[name="tegname"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>기술이전성과</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 기술이전구분</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_tech" value="'+ScCnt+'">';
	      	htmlCont += '		<select class="select_box" name="tetype">';
	      	htmlCont += '			<option value="">::선택::</option>';
	      	<%
			for(HashMap rs:technologyList){
			%>
			htmlCont += '			<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>';
			<% 
			}
			%>
	      	
	      	htmlCont += '		</select>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 이전유형</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<label><input type="radio" name="tetype1_'+ScCnt+'" value="양도/양수" checked="checked"> 양도/양수</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="전용실시"> 전용실시</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="통상실시"> 통상실시</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="기술지도"> 기술지도</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 기술이전료구분</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <label><input type="radio" name="tetype2_'+ScCnt+'" value="정액기술료" checked="checked"> 정액기술료</label>';
			htmlCont += '       <label><input type="radio" name="tetype2_'+ScCnt+'" value="경상기술료"> 경상기술료</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 기술료</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="teprice" value=""/>(단위:백만원)';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 이전기술료</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="te_nprice" value="" onkeyup="commaCheck(this)"/>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 양도기관(기업)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="tenname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 양수기관(기업)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="tegname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t3_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t3_"+year).append(htmlCont);
			
		}else if(mode == "bus"){ //연구시설장비구축성과
			
			var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
			var ScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
			
			if(cnt > 0){
				
				if($("#resultInfo_t4_"+year).find('input[name=busname]:last').val() == ""){
					alert("연구시설장비명을 입력하세요");
					$("#resultInfo_t4_"+year).find('input[name=busname]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busstatus"]:last').val() == ""){
					alert("주요사양을 입력하세요");
					$("#resultInfo_t4_"+year).find('input[name="busstatus"]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busprice"]:last').val() == ""){
					alert("구축단가를 입력하세요");
					$("#resultInfo_t4_"+year).find('input[name="busprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busnum"]:last').val() == ""){
					alert("구축수량을 입력하세요");
					$("#resultInfo_t4_"+year).find('input[name="busnum"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>연구시설장비구축성과</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '	<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 구분</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_bus" value="'+ScCnt+'">';
	      	htmlCont += '      	<label><input type="radio" name="bustype1_'+ScCnt+'" value="건축물" checked="checked"> 건축물</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="연구시설"> 연구시설</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="연구장비"> 연구장비</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="기타"> 기타</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 연구시설장비명</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <input type="text" class="inp_txt" name="busname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 주요사양</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busstatus" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 구축단가</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busprice" value="" />(단위:백만원)';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 구축수량</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busnum" value="" />(1식/EA)';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 구축비(합계)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="hidden" class="inp_txt" name="bustotprice" value="" />';
	      	htmlCont += '		<span class="bustotprice"></span>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t4_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t4_"+year).append(htmlCont);
			
		}else if(mode == "pps"){
			
			
			var cnt = $("#resultInfo_t5_"+year).find('input[name=chk_pps]').size();
			var ScCnt = parseInt(cnt)+1;//값::1 int형으로 변환
			
			if(cnt > 0){
				
				if($("#resultInfo_t5_"+year).find('input[name=ppsname]:last').val() == ""){
					alert("품종명칭을 입력하세요");
					$("#resultInfo_t5_"+year).find('input[name=ppsname]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsxname"]:last').val() == ""){
					alert("작물명칭을 입력하세요");
					$("#resultInfo_t5_"+year).find('input[name="ppsxname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('select[name="ppstype"]:last').val() == ""){
					alert("출원/등록를 선택하세요");
					$("#resultInfo_t5_"+year).find('select[name="ppstype"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsnum"]:last').val() == ""){
					alert("출원번호(등록번호)를 입력하세요");
					$("#resultInfo_t5_"+year).find('input[name="ppsnum"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsdate"]:last').val() == ""){
					alert("출원일(등록일)를 입력하세요");
					$("#resultInfo_t5_"+year).find('input[name="ppsdate"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>연구시설장비구축성과</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 신품종구분</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_pps" value="'+ScCnt+'">';
	      	htmlCont += '      	<label><input type="radio" name="ppstype1_'+ScCnt+'" value="신품종성과(정보)등록" checked="checked">신품종성과(정보)등록</label>';
			htmlCont += '       <label><input type="radio" name="ppstype1_'+ScCnt+'" value="신품종종자(실물)기탁">신품종종자(실물)기탁</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;">*</span> 품종명칭</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <input type="text" class="inp_txt" name="ppsname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 작물명칭</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsxname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 출원/등록구분</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<select class="select_box" name="ppstype">';
	      	htmlCont += '			<option value="">::선택::</option>';
	      	<%
			for(HashMap rs:applicationList){
			%>
			htmlCont += '			<option value="<%=util.getStr(rs.get("CODE_NM"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>';
			<% 
			}
			%>
	      	
	      	htmlCont += '		</select>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 출원번호(등록번호)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsnum" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> 출원일(등록일)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsdate" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t5_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t5_"+year).append(htmlCont);
			
			$("input[name='ppsdate']").datepicker({
		       	showMonthAfterYear : true,
		       	changeMonth : true,
		       	changeYear : true,
		       	dateFormat : "yy-mm-dd",
		       	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		       	dayNamesMin : ['일','월','화','수','목','금','토'],
		       	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
			
		}
		
	}
	
	$(document).on("click","input[name^='tetype2_']",function(){
		var code = $(this).val();
		if(code == "정액기술료"){
			$(this).parents(".skin_basic_write").find("input[name='teprice']").val("");
		}else{
			$(this).parents(".skin_basic_write").find("input[name='teprice']").val("매출액의3%");
		}
	});
	
	
	
	
	
	
	
	function delResultRow(mode,year){
		
		if(mode == "info"){
			
			var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
			var delCnt = cnt-1;
			
			if(delCnt == 0){
				$("#resultInfo_t1_"+year).html('<div class="hideBox_n">+버튼을 누르고 논문성과를 등록하세요</div>');
			}
			$("#resultInfo_t1_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "se"){
			
			var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
			var delCnt = cnt-1;
			
			if(delCnt == 0){
				$("#resultInfo_t2_"+year).html('<div class="hideBox_n">+버튼을 누르고 지적재산성과를 등록하세요</div>');
			}
			$("#resultInfo_t2_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "tech"){
			//ddddddddddddd
			var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t3_"+year).html('<div class="hideBox_n">+버튼을 누르고 기술이전성과를 등록하세요</div>');
			}
			$("#resultInfo_t3_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "bus"){
			
			var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t4_"+year).html('<div class="hideBox_n">+버튼을 누르고 연구시설장비구축성과를 등록하세요</div>');
			}
			$("#resultInfo_t4_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "pps"){
			
			var cnt = $("#resultInfo_t5_"+year).find('input[name=chk_pps]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t5_"+year).html('<div class="hideBox_n">+버튼을 누르고 신품종개발성과를 등록하세요</div>');
			}
			$("#resultInfo_t5_"+year).find(".info"+cnt).remove();
			
		}
	}
	
	//dddddddddd
	$(document).on("change","input[name='retype']",function(){
		
		if($(this).val() == "고용"){
			$(this).parents(".result_content").find(".mm").hide();
			$(this).parents(".result_content").find(".gg").show();
			$(this).parents(".result_content").find("#reprice").prop("disabled",true);
			$(this).parents(".result_content").find("#reperson").prop("disabled",false);
		}else if($(this).val() == "매출"){
			$(this).parents(".result_content").find(".mm").show();
			$(this).parents(".result_content").find(".gg").hide();
			$(this).parents(".result_content").find("#reprice").prop("disabled",false);
			$(this).parents(".result_content").find("#reperson").prop("disabled",true);
		}else{
			$(this).parents(".result_content").find(".mm").show();
			$(this).parents(".result_content").find(".gg").show();
			$(this).parents(".result_content").find("#reprice").prop("disabled",false);
			$(this).parents(".result_content").find("#reperson").prop("disabled",false);
		}
	});
	
	
	$(document).on("click","input[name='nptype2']",function(){
		if($(this).val() == "미확정"){
			$(this).parents(".ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",true);
		}else{
			$(this).parents(".ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",false);
		}
	});
	
	
	


</script>