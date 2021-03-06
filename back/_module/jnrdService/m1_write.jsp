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
	
	<p style="color:red;"><span style="color:red;" >*</span>) ?????? ?????????????????????.</p>

	<!-- ???????????? S -->
	<h2 class="tit">??????(??????) ????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????(??????) ????????????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit">??????(??????)????????????</th>
           		<td colspan="3">
           			<input type="text" name="mcode" id="MCODE" value="JNR-" class="inp_txt read_only" readonly style="width:300px;">
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> R&D?????? ??????</th>
           		<td colspan="3">
           			<label><input type="radio" name="mtype" value="??????R&D" checked="checked"> ?????? R&D</label>
           			<label><input type="radio" name="mtype" value="?????????R&D"> ?????????R&D</label>
           			<label><input type="radio" name="mtype" value="??????R&D"> ??????R&D</label>
           			<label><input type="radio" name="mtype" value="?????????R&D"> ?????????R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="btype" value="????????????" checked="checked"> ????????????</label>
           			<label><input type="radio" name="btype" value="????????????"> ????????????</label>
           			<label><input type="radio" name="btype" value="????????????"> ????????????</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>
           		<td colspan="3">
           			<label><input type="radio" name="ctype" value="??????R&D" checked="checked"> ??????R&D</label>
           			<label><input type="radio" name="ctype" value="??????R&D"> ??????R&D</label>
           			<label><input type="radio" name="ctype" value="?????????R&D"> ?????????R&D</label>
           			<label><input type="radio" name="ctype" value="?????????R&D"> ?????????R&D</label>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(???)???</th>
           		<td colspan="3">
           			<select name="mname" class="select_box">
           				<option value="">:::??????:::</option>
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
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ??????(?????????)?????????</th>
           		<td colspan="3">
           			<input type="text" name="mbname" id="MBNAME" class="inp_txt" vaule="" size="50"/>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>
           		<td colspan="3">
           			<input type="text" name="hname" id="HNAME" class="inp_txt" vaule="" size="50"/>
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- ???????????? E -->



	<!-- ???????????? -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????????</h2>
    <div class="zoom">
		
	</div>
	<div id="businesslist">
  		<table class="skin_basic_write">
  			<caption>????????????</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
	         		<td>
	         			<input type="text" name="msdate" id="MSDATE" class="inp_txt read_only" readonly vaule=""/>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>
	         		<td>
	         			<input type="text" name="medate" id="MEDATE" class="inp_txt read_only" readonly vaule=""/>
	         			<label><input type="checkbox" name="ming" id="MING" value="1"/>????????????</label>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">????????????(??????)</th>
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
           <input type="button" class="btn_inp_b_01" value="????????????" onclick="goCheck()"/>
           <input type="button" class="btn_inp_w_01" value="??????" />
    </div>
    <!--// bo_btn -->
</form>


<div style="padding-top:15px"></div>




<div id="ncontentBox">
	
	<h2 class="tit">?????????????????????</h2>
	<div class="zoom"></div>
	
	<div class="hideBox">
		??????????????? ?????? ???????????????
	</div>
		
</div>
<div style="padding-top:15px"></div>


<div id="resultBox">
	
	<h2 class="tit">????????????</h2>
	<div class="zoom"></div>
	
	<div class="hideBox">
		??????????????? ?????? ???????????????
	</div>
	
		
</div>








<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	$(document).on("click",".btn_inp_w_01",function(){	
		location.href="/sys/sys_jnrd_m1.do";
	});

	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^???-???]/;
	var characPattern = /[^a-zA-Z0-9^???-???]/;
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
            		
            		alert("??????????????? ?????????????????????.\n??????????????? ????????? ?????????.");
            		var midx = data.paramMap.midx;
            		
            		for(var y=sDateYear; y<=eDateYear; y++){
            			
            			var htmlSet1 = "";
            			var htmlSet2 = "";
            			
            			htmlSet1 += '<div class="htmlSet" id="htmlCont_'+y+'">';
            			htmlSet1 += '<input type="hidden" name="midx" value="'+midx+'">'
	            		htmlSet1 += '?????????????????? : <strong>'+y+'</strong>??? <span class="bdText"></span>';
	            		htmlSet1 += '<span class="htmlBtn add addPriceSet" data-year="'+y+'" data-midx="'+midx+'">????????????</span>';
	            		//htmlSet1 += '<span class="htmlBtn nps addNpSet cRed" data-year="'+y+'" data-midx="'+midx+'">???????????????</span>';
	            		htmlSet1 += '</div>';
	            		
	            		htmlSet2 += '<div class="htmlResultSet" id="htmlResultCont_'+y+'">';
            			htmlSet2 += '<input type="hidden" name="midx" value="'+midx+'">'
	            		htmlSet2 += '?????????????????? : <strong>'+y+'</strong>??? <span class="bdText"></span>';
	            		htmlSet2 += '<span class="htmlBtn addx addResultSet" data-year="'+y+'" data-midx="'+midx+'">????????????</span>';
	            		//htmlSet2 += '<span class="htmlBtn npsx addResultNpSet cRed" data-year="'+y+'" data-midx="'+midx+'">???????????????</span>';
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


//????????????-????????? ?????? S
	function goCheck(){
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
        var fileCount = $("input[type=file]").length;
		
        if($("select[name='mname']").val() == ""){
        	alert('????????????(???)?????? ???????????????');
        	$("select[name='mname']").focus();
        	return false;
        }
        
        if($("input[name='mbname']").val() == ""){
        	alert('??????(?????????)???????????? ???????????????');
        	$("input[name='mbname']").focus();
        	return false;
        }
        
        if($("input[name='hname']").val() == ""){
        	alert('???????????? ???????????????');
        	$("input[name='hname']").focus();
        	return false;
        }
        
        if($("#MSDATE").val() == ""){
        	alert('?????????????????? ???????????????');
        	$("#MSDATE").focus();
        	return false;
        }
        
        if($("#MEDATE").val() == "" && !$("#MING").is(":checked")){
        	alert('?????????????????? ???????????????');
        	$("#MEDATE").focus();
        	return false;
        }
        
        
		
	    
		goSubmit('writeProc','10');
	}
	
	
	
	
	
//????????????-????????? ?????? E
//????????? S
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=620, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
//????????? E
//??????datePicker S
	$("#MEDATE").datepicker({
       	showMonthAfterYear : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
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
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            var xNum = "";
            
            sDateYear = parseInt(year);
            
            //??????????????????
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
			alert("????????????????????? ?????? ???????????????");
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
			
			/* ???????????? ????????? */
			$(this).parents("div.ncontent").find("input").not(this).prop("disabled",false);
			$(this).parents("div.ncontent").find("option").attr("disabled",false);
			$(this).parents("div.ncontent").find("textarea").attr("disabled",false);
			
			if($(this).parents("div.ncontent").find("input[name='nptype2']:checked").val() == "?????????"){
				
				$(this).parents("div.ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",true);
			}
			
			
			
			
		}
	});
	
	
	$(document).on("click","#reset",function(){
		if($(this).is(":checked") && $(this).parents("div.result_content").find("#reyear").val() == ""){
			alert("????????????????????? ?????? ???????????????");
			//$(this).parents("div.result_content").find("#reyear").focus();
			$(this).prop("checked",false);
			
		}else if($(this).is(":checked") && $(this).parents("div.result_content").find("#reyear").val() != ""){
			
			$(this).parents("div.result_content").find("input").not(this).prop("disabled",true);
			$(this).parents("div.result_content").find("option").attr("disabled",true);
			$(this).parents("div.result_content").find("textarea").attr("disabled",true);
			$(this).parents("div.result_content").find(".hideBox_n").text("???????????????????????? ????????? ????????? ??? ????????????.");
			$(this).parents("div.result_content").find(".submitBtn").prop("disabled",false);
			$(this).parents("div.result_content").find("input[name='midx']").prop("disabled",false);
			$(this).parents("div.result_content").find("input[name='reyear']").prop("disabled",false);
			
		}else{
			
			/* ???????????? ????????? */
			$(this).parents("div.result_content").find("input").not(this).prop("disabled",false);
			$(this).parents("div.result_content").find("option").attr("disabled",false);
			$(this).parents("div.result_content").find("textarea").attr("disabled",false);
			$(this).parents("div.result_content").find(".hideBox_n").text("+ ????????? ????????? ????????? ???????????????");
			//$(this).parents("div.result_content").find(":button").removeClass("cGreay");
		}
	});
	
	
	$("input[name='medate']").on("change",function(){
		if($("input[name='msdate']").val() == ""){
			alert("???????????? ???????????? ???????????????");
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
		$("#monthTit").html(monthTot+"??????");
	});
	
	$("input[name='ming']").on("click",function(){
		if($(this).is(":checked")){
			eDateYear = parseInt(toDateYear);
			$("input[name='medate']").val("");
			$("input[name='medate']").attr("disabled",true);
			$("input[name='mMonth']").val(0);
			$("#monthTit").html("????????????");
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
            url : "/sys/sysJnrd_ncontentAjax.do", // ?????????
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
			alert("????????????????????? ????????? ??? ????????????.");
			$("#MSDATE").focus();
			return false;
		}
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrd_ncontentAjax.do", // ?????????
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
			alert("????????????????????? ????????? ??? ????????????.");
			$("#MSDATE").focus();
			return false;
		}
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrd_resultWriteAjax.do", // ?????????
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
	
	//???????????????
	$(document).on("click",".addNpSet",function(){
		
		var year = $(this).data("year");
		var midx = $(this).data("midx");
		var $this = $(this);
		
		$.ajax({
			cache : false,
			url : "/sys/sysJnrdNpSetAjax.do", // ?????????
			type : 'POST',
			data : {year:year,midx:midx},
			dataType : 'JSON',
			success : function(data) {
				
				if(data.state == "OK"){
				
					$this.parents(".htmlSet").find(".htmlBtn").addClass("cGreay");
					$this.parents(".htmlSet").find(".htmlBtn").removeClass("addPriceSet");
					$this.parents(".htmlSet").find(".htmlBtn").removeClass("addNpSet");
					$this.text("?????????????????????");
					$this.parents(".htmlSet").find(".bdText").text("???????????? ????????? ?????????");
					$this.removeClass("cGreay");
					$this.addClass("ageNpset cBlue");
					
				
				}else{
					alert("????????? ?????????????????????. ??????????????? ???????????????");
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
				$this.text("???????????????");
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
			
		if(formData.get("reperson") == "" && (formData.get("retype") == "??????" || formData.get("retype") == "??????/??????" )){
			alert("??????????????? ???????????????");
			$(this).parents(".result_content").find("#reperson").focus();
			return false;
		}
		if(formData.get("reprice") == "" && (formData.get("retype") == "??????" || formData.get("retype") == "??????/??????" )){
			alert("????????? ???????????????");
			$(this).parents(".result_content").find("#reprice").focus();
			return false;
		}
		
		if(formData.has("chk_info")){
			
			if($(this).parents(".result_content").find("input[name='re1name']:last").val() == ""){
				alert("??????????????? ???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1name']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1aname']:last").val() == ""){
				alert("??????????????? ??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1aname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='re1date']:last").val() == ""){
				alert("??????????????? ???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='re1date']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_se")){
			
			if($(this).parents(".result_content").find("select[name='setype']:last").val() == ""){
				alert("??????/??????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='setype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='senumber']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='senumber']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='sedate']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sedate']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sename']:last").val() == ""){
				alert("????????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sename']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='sesetdate']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='sesetdate']:last").focus();
				return false;
			}
		}
		
		
		if(formData.has("chk_tech")){
			
			if($(this).parents(".result_content").find("select[name='tetype']:last").val() == ""){
				alert("????????????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='tetype']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='teprice']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='teprice']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='te_nprice']:last").val() == ""){
				alert("?????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='te_nprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tenname']:last").val() == ""){
				alert("????????????(??????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='tenname']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='tegname']:last").val() == ""){
				alert("????????????(??????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='tegname']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_bus")){
			
			if($(this).parents(".result_content").find("input[name='busname']:last").val() == ""){
				alert("???????????????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busstatus']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busstatus']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='busprice']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busprice']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='busnum']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='busnum']:last").focus();
				return false;
			}
		}
		
		if(formData.has("chk_pps")){
			
			if($(this).parents(".result_content").find("input[name='ppsname']:last").val() == ""){
				alert("??????????????? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("input[name='ppsxname']:last").val() == ""){
				alert("???????????? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsxname']:last").focus();
				return false;
			}
			
			if($(this).parents(".result_content").find("select[name='ppstype']:last").val() == ""){
				alert("??????/??????????????? ???????????????");
				$(this).parents(".result_content").find("select[name='ppstype']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsnum']:last").val() == ""){
				alert("????????????(????????????)??? ???????????????");
				$(this).parents(".result_content").find("input[name='ppsnum']:last").focus();
				return false;
			}
			if($(this).parents(".result_content").find("input[name='ppsdate']:last").val() == ""){
				alert("?????????(?????????)??? ???????????????");
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
            		
            		alert('????????????!!');
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
			
			if($(this).parents(".ncontent").find("input[name='nptype2']:checked").val() != "?????????"){
		
				if($(this).parents(".ncontent").find("#nptotprice").val() == ""){
					alert("???????????? ??????");
					$(this).parents(".ncontent").find("#nptotprice").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice1").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice1").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice2").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice2").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice3").val() == ""){
					alert("????????? ??????");
					$(this).parents(".ncontent").find("#npprice3").focus();
					return false;
				}
				if($(this).parents(".ncontent").find("#npprice4").val() == ""){
					alert("?????? ??????");
					$(this).parents(".ncontent").find("#npprice4").focus();
					return false;
				}
				
			}
			
			
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File1").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File1").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File2").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File2").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		}
			
			<%-- if((new RegExp(imgFormat)).test($(this).parents(".ncontent").find("#<%=fileFullGrp%>File3").val()) && $(this).parents(".ncontent").find('#<%=fileFullGrp%>File1').val() != ""){
	
	   		}else if($(this).parents(".ncontent").find("#<%=fileFullGrp%>File3").val() == ""){
	   			alert("????????? ???????????????.");
	   			return false;
	   		}else{
	   			alert("?????? ????????? ???????????? ??? ????????????.");
	   			return false;
	   		} --%>
			
			if($(this).parents(".ncontent").find("#npotext1").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext1").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext2").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext2").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext3").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext3").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext4").val() == ""){
				alert("???????????? ??????");
				$(this).parents(".ncontent").find("#npotext4").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext5").val() == ""){
				alert("????????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext5").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext6").val() == ""){
				alert("????????????(??????) ??????");
				$(this).parents(".ncontent").find("#npotext6").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext7").val() == ""){
				alert("?????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext7").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext8").val() == ""){
				alert("????????????????????? ??????");
				$(this).parents(".ncontent").find("#npotext8").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext9").val() == ""){
				alert("??????????????? ???????????? ??????");
				$(this).parents(".ncontent").find("#npotext9").focus();
				return false;
			}
			if($(this).parents(".ncontent").find("#npotext10").val() == ""){
				alert("??????????????? ??????");
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
            		
            		alert('????????????!!');
            		$this.removeClass("addPriceInfo");
            		$this.addClass("addPriceInfo_off");
            		$this.text("????????????");
            		$(".addPriceInfo_off").attr("data-midx",midx);
            		
            	}
                
            }, // success
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
		
		
		
		
	});
	
	
	
	
	
	
	
	
	
	// ?????????????????????????????????ddd
	function addResultRow(mode,year){ //????????????
		
		if(mode == "info"){
			
			var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t1_"+year).find('input[name=re1name]:last').val() == ""){
					alert("???????????? ???????????????");
					$("#resultInfo_t1_"+year).find('input[name=re1name]:last').focus();
					return false;
				}
				if($("#resultInfo_t1_"+year).find('input[name="re1aname"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t1_"+year).find('input[name="re1aname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t1_"+year).find('input[name="re1date"]:last').val() == ""){
					alert("???????????? ???????????????");
					$("#resultInfo_t1_"+year).find('input[name="re1date"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '	  	<tr>';
			htmlCont += '      		<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
			htmlCont += '      		<td colspan="3">';
			htmlCont += '      			<input type="hidden" name="chk_info" value="'+ScCnt+'">';
			htmlCont += '          		<label><input type="radio" name="re1type_'+ScCnt+'" value="SCI(E)??????" checked="checked"> SCI(E)??????</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="???SCI(E)??????"> ???SCI(E)??????</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '           	<label><input type="radio" name="re1type_'+ScCnt+'" value="??????"> ??????</label>';
			htmlCont += '          	</td>';
			htmlCont += '       </tr>';
			htmlCont += '       <tr>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
			htmlCont += '       	<td>';
			htmlCont += '       		<input type="text" name="re1name" id="re1name_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
			htmlCont += '       	<td>';
			htmlCont += '       		<input type="text" name="re1aname" id="re1aname_'+year+'_'+ScCnt+'" value="" class="inp_txt" />';
			htmlCont += '       	</td>';
			htmlCont += '       </tr>';
			htmlCont += '       <tr>';
			htmlCont += '       	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
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
		       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		       	dayNamesMin : ['???','???','???','???','???','???','???'],
		       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
		
		}else if(mode == "se"){ //??????????????????
			
			var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t2_"+year).find('select[name=setype]:last').val() == ""){
					alert("??????/??????????????? ???????????????");
					$("#resultInfo_t2_"+year).find('select[name=setype]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="senumber"]:last').val() == ""){
					alert("????????????(????????????)??? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="senumber"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sedate"]:last').val() == ""){
					alert("?????????(?????????)??? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="sedate"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sename"]:last').val() == ""){
					alert("????????????????????? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="sename"]:last').focus();
					return false;
				}
				if($("#resultInfo_t2_"+year).find('input[name="sesetdate"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t2_"+year).find('input[name="sesetdate"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_se" value="'+ScCnt+'">';
	      	htmlCont += '		<select class="select_box" name="setype">';
	      	htmlCont += '			<option value="">::??????::</option>';
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
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="senumber" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sedate" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="sename" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
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
		       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		       	dayNamesMin : ['???','???','???','???','???','???','???'],
		       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
			
		}else if(mode == "tech"){ //??????????????????
			
			var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t3_"+year).find('select[name=tetype]:last').val() == ""){
					alert("????????????????????? ???????????????");
					$("#resultInfo_t3_"+year).find('select[name=tetype]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="teprice"]:last').val() == ""){
					alert("???????????? ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="teprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="te_nprice"]:last').val() == ""){
					alert("?????????????????? ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="te_nprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="tenname"]:last').val() == ""){
					alert("????????????(??????) ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="tenname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t3_"+year).find('input[name="tegname"]:last').val() == ""){
					alert("????????????(??????) ???????????????");
					$("#resultInfo_t3_"+year).find('input[name="tegname"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_tech" value="'+ScCnt+'">';
	      	htmlCont += '		<select class="select_box" name="tetype">';
	      	htmlCont += '			<option value="">::??????::</option>';
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
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<label><input type="radio" name="tetype1_'+ScCnt+'" value="??????/??????" checked="checked"> ??????/??????</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="tetype1_'+ScCnt+'" value="????????????"> ????????????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <label><input type="radio" name="tetype2_'+ScCnt+'" value="???????????????" checked="checked"> ???????????????</label>';
			htmlCont += '       <label><input type="radio" name="tetype2_'+ScCnt+'" value="???????????????"> ???????????????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="teprice" value=""/>(??????:?????????)';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="te_nprice" value="" onkeyup="commaCheck(this)"/>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="tenname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(??????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="tegname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
			htmlCont += '   </tbody>';
			htmlCont += '</table>';
			
			$("#resultInfo_t3_"+year).find(".hideBox_n").hide();
			$("#resultInfo_t3_"+year).append(htmlCont);
			
		}else if(mode == "bus"){ //??????????????????????????????
			
			var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t4_"+year).find('input[name=busname]:last').val() == ""){
					alert("???????????????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name=busname]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busstatus"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name="busstatus"]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busprice"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name="busprice"]:last').focus();
					return false;
				}
				if($("#resultInfo_t4_"+year).find('input[name="busnum"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t4_"+year).find('input[name="busnum"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '	<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_bus" value="'+ScCnt+'">';
	      	htmlCont += '      	<label><input type="radio" name="bustype1_'+ScCnt+'" value="?????????" checked="checked"> ?????????</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="????????????"> ????????????</label>';
			htmlCont += '       <label><input type="radio" name="bustype1_'+ScCnt+'" value="??????"> ??????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <input type="text" class="inp_txt" name="busname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busstatus" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busprice" value="" />(??????:?????????)';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="busnum" value="" />(1???/EA)';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(??????)</th>';
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
			var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
			
			if(cnt > 0){
				
				if($("#resultInfo_t5_"+year).find('input[name=ppsname]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name=ppsname]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsxname"]:last').val() == ""){
					alert("??????????????? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name="ppsxname"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('select[name="ppstype"]:last').val() == ""){
					alert("??????/????????? ???????????????");
					$("#resultInfo_t5_"+year).find('select[name="ppstype"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsnum"]:last').val() == ""){
					alert("????????????(????????????)??? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name="ppsnum"]:last').focus();
					return false;
				}
				if($("#resultInfo_t5_"+year).find('input[name="ppsdate"]:last').val() == ""){
					alert("?????????(?????????)??? ???????????????");
					$("#resultInfo_t5_"+year).find('input[name="ppsdate"]:last').focus();
					return false;
				}
			
			}
			
			var htmlCont = "";
			htmlCont += '<table class="skin_basic_write info'+ScCnt+'" >';
			htmlCont += '	<caption>??????????????????????????????</caption>';
			htmlCont += '       <colgroup>';
			htmlCont += '	       <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '          <col style="width:20%" />';
			htmlCont += '          <col style="width:30%" />';
			htmlCont += '       </colgroup>';
			htmlCont += '   <tbody>';
			htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ???????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '      	<input type="hidden" name="chk_pps" value="'+ScCnt+'">';
	      	htmlCont += '      	<label><input type="radio" name="ppstype1_'+ScCnt+'" value="???????????????(??????)??????" checked="checked">???????????????(??????)??????</label>';
			htmlCont += '       <label><input type="radio" name="ppstype1_'+ScCnt+'" value="???????????????(??????)??????">???????????????(??????)??????</label>';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;">*</span> ????????????</th>';
	      	htmlCont += '	<td colspan="3">';
	      	htmlCont += '       <input type="text" class="inp_txt" name="ppsname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '</tr>';
	      	htmlCont += '<tr>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsxname" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ??????/????????????</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<select class="select_box" name="ppstype">';
	      	htmlCont += '			<option value="">::??????::</option>';
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
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ????????????(????????????)</th>';
	      	htmlCont += '	<td>';
	      	htmlCont += '		<input type="text" class="inp_txt" name="ppsnum" value="" />';
	      	htmlCont += '	</td>';
	      	htmlCont += '	<th scope="row" class="tit"><span style="color:red;" >*</span> ?????????(?????????)</th>';
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
		       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		       	dayNamesMin : ['???','???','???','???','???','???','???'],
		       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		       	onClose: function(dateText, inst) {
		                        
		        }
			});
			
			
		}
		
	}
	
	$(document).on("click","input[name^='tetype2_']",function(){
		var code = $(this).val();
		if(code == "???????????????"){
			$(this).parents(".skin_basic_write").find("input[name='teprice']").val("");
		}else{
			$(this).parents(".skin_basic_write").find("input[name='teprice']").val("????????????3%");
		}
	});
	
	
	
	
	
	
	
	function delResultRow(mode,year){
		
		if(mode == "info"){
			
			var cnt = $("#resultInfo_t1_"+year).find('input[name=chk_info]').size();
			var delCnt = cnt-1;
			
			if(delCnt == 0){
				$("#resultInfo_t1_"+year).html('<div class="hideBox_n">+????????? ????????? ??????????????? ???????????????</div>');
			}
			$("#resultInfo_t1_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "se"){
			
			var cnt = $("#resultInfo_t2_"+year).find('input[name=chk_se]').size();
			var delCnt = cnt-1;
			
			if(delCnt == 0){
				$("#resultInfo_t2_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t2_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "tech"){
			//ddddddddddddd
			var cnt = $("#resultInfo_t3_"+year).find('input[name=chk_tech]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t3_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t3_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "bus"){
			
			var cnt = $("#resultInfo_t4_"+year).find('input[name=chk_bus]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t4_"+year).html('<div class="hideBox_n">+????????? ????????? ????????????????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t4_"+year).find(".info"+cnt).remove();
			
		}else if(mode == "pps"){
			
			var cnt = $("#resultInfo_t5_"+year).find('input[name=chk_pps]').size();
			var delCnt = cnt-1;
			if(delCnt == 0){
				$("#resultInfo_t5_"+year).html('<div class="hideBox_n">+????????? ????????? ???????????????????????? ???????????????</div>');
			}
			$("#resultInfo_t5_"+year).find(".info"+cnt).remove();
			
		}
	}
	
	//dddddddddd
	$(document).on("change","input[name='retype']",function(){
		
		if($(this).val() == "??????"){
			$(this).parents(".result_content").find(".mm").hide();
			$(this).parents(".result_content").find(".gg").show();
			$(this).parents(".result_content").find("#reprice").prop("disabled",true);
			$(this).parents(".result_content").find("#reperson").prop("disabled",false);
		}else if($(this).val() == "??????"){
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
		if($(this).val() == "?????????"){
			$(this).parents(".ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",true);
		}else{
			$(this).parents(".ncontent").find("#nptotprice,#npprice1,#npprice2,#npprice3,#npprice4,#npprice5").prop("disabled",false);
		}
	});
	
	
	


</script>