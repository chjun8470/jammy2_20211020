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
       
       HashMap<String, String> infoData = request.getAttribute("infoData") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("infoData");
       ArrayList<HashMap<String, String>> infoBusinessList = request.getAttribute("infoBusinessList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("infoBusinessList");
       
       ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	   ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	   
	   
       String mode = util.getStr(paramMap.get("mode"));
       String nowPage = util.getStr(paramMap.get("nowPage"));
       String userIdx = util.getStr(paramMap.get("userIdx"));
       if("".equals(mode)) mode = "write";

       String fileGrp = "jntisJnrd";
       String fileSubGrp = "";
       String fileFullGrp =fileGrp+fileSubGrp;

       int scCnt = 0;
       
       
%>

<style>
table.skin_basic_write td.padding_none{padding:0;}
#businesslist td p{padding:10px 0; border-top:1px solid #ddd;}
#businesslist td p:first-child{border-top:none;}

#businesslist td p span{display:inline-block; width:100px; text-align:center;}
</style>

<jsp:useBean id="currTime" class="java.util.Date" />



<div class="skin_bbs_write" style="margin-top: 30px">
	
	<!-- ???????????? S -->
	<h2 class="tit">????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>????????????</caption>
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
           			<%=util.getStr(infoData.get("CODE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(??????)??????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("TYPE_A"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????(???)???</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("CNAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(?????????)?????????</th>
           		<td>
           			<%=util.getStr(infoData.get("BNAME"))%>
           		</td>
           		<th scope="row" class="tit"> ??????(??????)???</th>
           		<td>
           			<%=util.getStr(infoData.get("B_ANAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ???????????????</th>
           		<td colspan="3">
           			?????? : <%=util.getStr(String.valueOf(infoData.get("S_DATE")))%>
           			?????? : <%=util.getStr(String.valueOf(infoData.get("E_DATE")))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.setFormatNum(String.valueOf(infoData.get("B_TPRICE")), "comma") %>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td>
           			<%=util.getStr(infoData.get("YEAR_TYPE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(??????)????????????</th>
           		<td colspan="3">
           		<%=util.getStr(infoData.get("B_CH"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(??????)????????????</th>
           		<td colspan="3">
           			?????? : <%=util.getStr(String.valueOf(infoData.get("B_SD")))%><br/>
           			?????? : <%=util.getStr(String.valueOf(infoData.get("B_ED")))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(??????)?????????</th>
           		<td colspan="3">
           		<% 
           		int fileCnt = 1;
           		for(HashMap rs:fileList){
           			String fileParamB = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
					+"&amp;fileId="+util.getStr(String.valueOf(rs.get("FILE_ID")))
					+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
           		%>
           			???????????? <%=fileCnt%> :
		           			<a href="/cmm/fms/ComFileDown.do<%=fileParamB%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)[????????????]</a>
           		<%
           			fileCnt++;
           		} 
           		%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- ???????????? E -->



	<!-- ????????????(??????)?????? S -->
	<div style="padding-top:15px"></div>
	<h2 class="tit">????????????(??????)??????</h2>
    <div class="zoom">
		
	</div>
	<div id="businesslist">
		
		<%
		for(HashMap rs:infoBusinessList){
		%>
	
  		<table class="skin_basic_write" id="businesslist_cont_<%=scCnt%>">
  			<caption>????????????(??????)??????</caption>
  			<colgroup>
            	<col style="width:15%" />
           	</colgroup>
			<tbody>
	            <tr >
	         		<th scope="row" class="tit"> ????????????</th>
	         		<td>
	         			<%=rs.get("BIS_YEAR")%>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">???????????? ????????????</th>
	         		<td>
	         			?????? : <%=String.valueOf(rs.get("BIS_SDATE"))%><br/>
	          			?????? : <%=String.valueOf(rs.get("BIS_EDATE"))%>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"> ????????????</th>
	         		<td>
	         			<%=rs.get("BIS_TYPE")%>
	         		</td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit"> ???????????? ?????????<br>(??????:100??????)</th>
	         		<td class="padding_none">
	         			<p><span>?????? : </span><%=util.setFormatNum(String.valueOf(rs.get("BIS_PRICE_1")), "comma") %></p>
	         			<p><span>????????? : </span><%=util.setFormatNum(String.valueOf(rs.get("BIS_PRICE_2")), "comma") %></p>
	         			<p><span>?????? : </span><%=util.setFormatNum(String.valueOf(rs.get("BIS_PRICE_3")), "comma") %></p>
	         			<p><span>?????? : </span><%=util.setFormatNum(String.valueOf(rs.get("BIS_PRICE_4")), "comma") %></p>
	         		</td>
	         	</tr>
	   		</tbody>
		</table>
		<%
		}
		%>
	</div>
	
	<h2 class="tit">??????(??????)??????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????????????????</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
        	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("AN_NAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("CN_NAME"))%>
           		</td>
           	</tr>
        </tbody>
    </table>
	
	
	<!-- ???????????? S -->
	<h2 class="tit">??????????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????????????????</caption>
        <colgroup>
              <col style="width:15%" />
              <col style="width:35%" />
              <col style="width:15%" />
              <col style="width:35%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("CEN_TYPE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("ORG_AGE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(??????)???</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DEP_NAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????(??????)?????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DEP_CODE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ???????????? ?????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("BUS_IMP_CODE"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ???????????????</th>
           		<td>
           			<%=util.getStr(infoData.get("DIRECTOR"))%>
           		</td>
           		<th scope="row" class="tit">??????????????? ??????</th>
           		<td>
           			<%=util.autoTel(infoData.get("DIR_TEL"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit">??????????????? ?????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_EMAIL"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
	<!-- ???????????? E -->
	
	
	<h2 class="tit">??????(??????)??????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????(??????)??????</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"> ????????????????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_TYPE1"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_TYPE2"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_TYPE3"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_TYPE4"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> 6T??????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_TYPE5"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("DIR_TYPE6"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	
   	
   	<h2 class="tit">????????? ????????????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>????????? ????????????</caption>
        <colgroup>
              <col style="width:15%" />
        </colgroup>
        <tbody>
           	<tr>
           		<th scope="row" class="tit"> ?????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("MAN_CNAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ?????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("MAN_PNAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("MAN_ANAME"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ??????</th>
           		<td colspan="3">
           			<%=util.getStr(infoData.get("MAN_SPOT"))%>
           		</td>
           	</tr>
           	<tr>
           		<th scope="row" class="tit"> ????????????</th>
           		<td colspan="3">
           			<%=util.autoTel(infoData.get("MAN_TEL"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>
   	
   	<h2 class="tit">??????</h2>
	<div class="zoom">
		
	</div>
	<table class="skin_basic_write" >
		<caption>??????</caption>
        <tbody>
           	<tr>
           		<td colspan="4">
           			<%=util.getStr(infoData.get("COMMENT"))%>
           		</td>
           	</tr>
    	</tbody>
   	</table>



    <!-- bo_btn  -->
    <div class="btn_right_box" style="text-align: right; width: 980px;">
           <input type="button" class="btn_inp_b_01" value="??????" data-idx="<%=util.getStr(paramMap.get("idx"))%>"/>
           <input type="button" class="btn_inp_w_01" value="??????"/>
    </div>
    <!--// bo_btn -->


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	
	
$(document).on("click",".btn_inp_b_01",function(){	
	
	var idx = $(this).data("idx");
	location.href="/sys/sys_jnrd_info.do?mode=modify&IDX="+idx;
	
	
});


$(document).on("click",".btn_inp_w_01",function(){	
	location.href="/sys/sys_jnrd_info.do";
});
	
	
	
	
//????????? ????????? ??????
	function userInfo(){
		$('#mode').val("write");
	    $('#fwrite').submit();
	}
//??????????????? ?????? S
	$("#photoCheck").click(function() {
		if($("#photoCheck").val() == null || $("#photoCheck").val() == "" ||$("#photoCheck").val() == "on" ||$("#photoCheck").val() == "Y"){
			$("#photoCheck").val("N");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDiv').hide();
		}else{
			$("#photoCheck").val("Y");
			$('#<%=fileFullGrp%>File1').val("");
			$('#fileDiv').show();
		}
	});
//??????????????? ?????? E
//????????????-???????????? Sss
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
//????????????-???????????? E
//????????????-???????????? S
	function majorDeth1(mode){
		var result = "";
		var mode = mode;
		if(mode == "exRealm"){
			var deth1 = $('select[name=exMajor]:last').val();
		}else if(mode == "pluralExRealm"){
			var deth1 = $('select[name=pluralExMajor]:last').val();
		}
		$.ajax({
	            type: "POST",
	            data : {
	           	 deth1 : deth1
	            },
	            url : '/sys/dethCheck.do',
	            dataType : 'json',
	            success : function(data){
	           	result += "<option value=''>???????????????.</option>";
	           	for(i=0; i<data.cnt; i++){
					result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
				}
	           	$('select[name='+mode+']:last').val("");
	           	$('select[name='+mode+']:last').append(result);
	            }
	   	});
	}
//????????????-???????????? E
//????????????-????????? ?????? S
	function goCheck(){
		var imgFormat = "\.(pdf|hwp|xml|xlsx|pptx)$";
        var fileCount = $("input[type=file]").length;
		
		
		if($("input[name='bname']").val() == ""){
			alert("?????????????????? ???????????????");
			$("input[name='bname']").focus();
			return false;
		}
		
		if($("input[name='baname']").val() == ""){
			alert("??????(??????)?????? ???????????????");
			$("input[name='baname']").focus();
			return false;
		}
		
		if($("input[name='sdate']").val() == ""){
			alert("??????????????? ???????????? ???????????????");
			$("input[name='sdate']").focus();
			return false;
		}
		
		if($("input[name='edate']").val() == ""){
			alert("??????????????? ???????????? ???????????????");
			$("input[name='edate']").focus();
			return false;
		}
		
		if($("input[name='btprice']").val() == ""){
			alert("??????????????? ???????????????");
			$("input[name='btprice']").focus();
			return false;
		}
		
		if(!$("input[name='bch1']").is(":checked") && !$("input[name='bch2']").is(":checked") && !$("input[name='bch3']").is(":checked") && !$("input[name='bch4']").is(":checked")){
			alert("??????(??????)??????????????? ???????????? ???????????????");
			$("input[name='bch1']").focus();
			return false;
		}
		
		if($("input[name='bsd']").val() == ""){
			alert("??????(??????)???????????? ???????????? ???????????????");
			$("input[name='bsd']").focus();
			return false;
		}
		
		if($("input[name='bed']").val() == ""){
			alert("??????(??????)???????????? ???????????? ???????????????");
			$("input[name='bed']").focus();
			return false;
		}
		
		if((new RegExp(imgFormat)).test($("#<%=fileFullGrp%>File1").val()) && $('#<%=fileFullGrp%>File1').val() != ""){

   		}else if($("#<%=fileFullGrp%>File1").val() == ""){
   			alert("????????? ???????????????.");
   			return false;
   		}else{
   			alert("?????? ????????? ???????????? ??? ????????????.");
   			return false;
   		}
		
		if($("#BIS_YEAR_0").val() == ""){
			alert("??????????????? ??????????????? ???????????????");
			$("#BIS_YEAR_0").focus();
			return false;
		}
		
		if($('select[name="bisyear"]:last').val() == ""){
	    	alert("??????????????? ??????????????? ?????? ?????????");
	    	$('select[name="bisyear"]:last').focus();
			return false;
	    }
		
		if($('input[name="bisprice_1"]:last').val() == ""){
	    	alert("????????? ?????? ?????????");
	    	$('input[name="bisprice_1"]:last').focus();
			return false;
	    }
	    if($('input[name="bisprice_2"]:last').val() == ""){
	    	alert("???????????? ?????? ?????????");
	    	$('input[name="bisprice_2"]:last').focus();
			return false;
	    }
	    if($('input[name="bisprice_3"]:last').val() == ""){
	    	alert("????????? ?????? ?????????");
	    	$('input[name="bisprice_3"]:last').focus();
			return false;
	    }
	    
	    /* ???????????? ????????? */
	    if($('input[name="anname"]').val() == ""){
	    	alert("?????????????????? ???????????????");
	    	$('input[name="anname"]').focus();
			return false;
	    }
	    
	    
	    /* ?????????????????? ????????? */
	    if($('select[name="centype"]').val() == ""){
	    	alert("??????????????? ???????????????");
	    	$('select[name="centype"]').focus();
			return false;
	    }
	    if($('input[name="orgage"]').val() == ""){
	    	alert("??????????????? ?????? ?????????");
	    	$('input[name="orgage"]').focus();
			return false;
	    }
	    if($('input[name="depname"]').val() == ""){
	    	alert("??????(??????)?????? ?????? ?????????");
	    	$('input[name="depname"]').focus();
			return false;
	    }
	    if($('select[name="depcode"]').val() == ""){
	    	alert("??????(??????)???????????? ???????????????");
	    	$('select[name="depcode"]').focus();
			return false;
	    }
	    if($('select[name="busimpcode"]').val() == ""){
	    	alert("???????????? ???????????? ???????????????");
	    	$('select[name="busimpcode"]').focus();
			return false;
	    }
	    if($('input[name="director"]').val() == ""){
	    	alert("?????????????????? ?????? ?????????");
	    	$('input[name="director"]').focus();
			return false;
	    }
	    
	    /* ?????????????????? ????????? */
	    if($('select[name="dirtype1"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype1"]').focus();
			return false;
	    }
	    if($('select[name="dirtype2"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype2"]').focus();
			return false;
	    }
	    if($('select[name="dirtype3"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype3"]').focus();
			return false;
	    }
	    if($('select[name="dirtype4"]').val() == ""){
	    	alert("??????????????????????????? ???????????????");
	    	$('select[name="dirtype4"]').focus();
			return false;
	    }
	    if($('select[name="dirtype5"]').val() == ""){
	    	alert("6T????????? ???????????????");
	    	$('select[name="dirtype5"]').focus();
			return false;
	    }
	    if($('select[name="dirtype6"]').val() == ""){
	    	alert("??????????????? ???????????????");
	    	$('select[name="dirtype6"]').focus();
			return false;
	    }
	    
	    /*????????? ???????????? ?????????*/
	    if($('input[name="mancname"]').val() == ""){
	    	alert("???????????? ???????????? ?????? ?????????");
	    	$('input[name="mancname"]').focus();
			return false;
	    }
	    if($('input[name="manpname"]').val() == ""){
	    	alert("???????????? ???????????? ?????? ?????????");
	    	$('input[name="manpname"]').focus();
			return false;
	    }
	    if($('input[name="mananame"]').val() == ""){
	    	alert("???????????? ??????????????? ?????? ?????????");
	    	$('input[name="mananame"]').focus();
			return false;
	    }
	    if($('input[name="manspot"]').val() == ""){
	    	alert("???????????? ????????? ????????? ?????? ?????????");
	    	$('input[name="manspot"]').focus();
			return false;
	    }
	    if($('input[name="mantel"]').val() == ""){
	    	alert("???????????? ??????????????? ?????? ?????????");
	    	$('input[name="mantel"]').focus();
			return false;
	    }
	    
		
		
		goSubmit('writeProc','10');
	}
	
	
	
	
	$(document).on("change","input[name='bisprice_3']:last",function(){
		var totP = parseInt($("input[name='bisprice_1']:last").val())+parseInt($("input[name='bisprice_2']:last").val())+parseInt($("input[name='bisprice_3']:last").val());
		$("input[name='bisprice_4']:last").val(totP);
	});
	
	
	
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
	$("#E_DATE,#B_SD,#B_ED,#BIS_SDATE_0,#BIS_EDATE_0").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	//nextText : '?????? ???',
       	//prevText : '?????? ???',

       	//closeText : '??????',
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	
        
		//yearRange: '1980:2020'
	});
	
	$("#S_DATE").datepicker({
       	showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            var xNum = "";
            //??????????????????
            $.ajax({
	            type: "POST",
	            data: {year:year},
	            url : '/sys/jntisJnrdAjax.do',
	            dataType : 'json',
	            success : function(data){	            	
	            	if(data.dataList != null){
	            		xNum = String(data.dataList.IDX).padStart(5,"0");
	            		$("#CODE").val("JNP-"+year+"-"+xNum);
	            	}else{
	            		$("#CODE").val("JNP-"+year+"-00001");
	            	}         		
	            }
   			});            
        }
	});
	
	
	
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

	
//??????datePicker E
//addRow Sss

	var date = new Date(); 
	var year = date.getFullYear();

	function addRow(mode){
   		if(mode=="business"){
   			var cnt = $('input[name=checkNum]:last').val();
   		    var ScCnt = parseInt(cnt)+1;//???::1 int????????? ??????
   		        		    
   		    if($('#BIS_YEAR_'+cnt).val() == ""){
   				alert("??????????????? ?????? ?????????");
   				$('#BIS_YEAR_'+cnt).focus();
   				return false;
   			}
   		    
   		    if($('input[name="bisprice_1"]:last').val() == ""){
   		    	alert("????????? ?????? ?????????");
   		    	$('input[name="bisprice_1"]:last').focus();
   				return false;
   		    }
   		    if($('input[name="bisprice_2"]:last').val() == ""){
   		    	alert("???????????? ?????? ?????????");
   		    	$('input[name="bisprice_2"]:last').focus();
   				return false;
   		    }
   		    if($('input[name="bisprice_3"]:last').val() == ""){
   		    	alert("????????? ?????? ?????????");
   		    	$('input[name="bisprice_3"]:last').focus();
   				return false;
   		    }
   		    
   		    var totalP = parseInt($('input[name="bisprice_1"]:last').val())+parseInt($('input[name="bisprice_2"]:last').val())+parseInt($('input[name="bisprice_3"]:last').val());
   		 	$('input[name="bisprice_4"]:last').val(totalP);
   		    
   		    
   			var row = "";
   			row += '<table class="skin_basic_write" id="businesslist_cont_'+ScCnt+'">';
   			row += '<input type="hidden" name="checkNum" value="'+ScCnt+'">';
     			row += '<caption>????????????</caption>';
     			row += '<colgroup>';
               row += '<col style="width:15%" />';
              	row += '</colgroup>';
   			row += '<tr>';
         	row += '<th scope="row" class="tit"> ????????????</th>';
         	row += '<td>';
         	row += '	<select name="bisyear" id="BIS_YEAR_'+ScCnt+'" class="select_box">';
         	row += '		<option value="">:::??????:::</option>'
         	for(var y=2018; y<=year; y++){
         		row += '<option>'+y+'</option>';
         	}
         	row += '	</select>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit">???????????? ????????????</th>';
         	row += '<td>';
         	row += '	?????? : <input type="text" name="bissdate" id="BIS_SDATE_'+ScCnt+'" class="inp_txt read_only" readonly vaule=""/>';
       		row += '	?????? : <input type="text" name="bisedate" id="BIS_EDATE_'+ScCnt+'" class="inp_txt read_only" readonly vaule=""/>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit"> ????????????</th>';
         	row += '<td>';
         	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="????????????" checked="checked"> ????????????</label>';
           	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="????????????"> ????????????</label>';
           	row += '	<label><input type="radio" name="bistype_'+ScCnt+'" value="??????"> ??????</label>';
         	row += '</td>';
         	row += '</tr>';
         	row += '<tr>';
         	row += '<th scope="row" class="tit"> ???????????? ?????????</th>';
         	row += '<td class="padding_none">';
         	row += '	<p><span>?????? : </span><input type="number" name="bisprice_1" class="inp_txt"> (??????:100??????)</p>';
         	row += '	<p><span>????????? : </span><input type="number" name="bisprice_2" class="inp_txt"> (??????:100??????)</p>';
         	row += '	<p><span>?????? : </span><input type="number" name="bisprice_3" class="inp_txt"> (??????:100??????)</p>';
         	row += '	<p><span>?????? : </span><input type="number" name="bisprice_4" class="inp_txt read_only" readonly> (??????:100??????)</p>';
         	row += '</td>';
         	row += '</tr>';
         	row += '</table>';
   		 	
   		    $("#businesslist").append(row);

    	}
    	//date
		setLicenseBtn(ScCnt, mode);
	}
//addRow E
//delRow S
	function delRow(mode){
   		if(mode=="business"){
   			if($('input[name=checkNum]').size() == 1){
   				alert("?????? ??? ??? ????????????.");
   				return false;
   			};
   			var delCnt = $('input[name=checkNum]').size() - 1;
   			var parenttr = $("#businesslist_cont_"+delCnt).remove();
   		}
   		//setLicenseBtn();
   	}
//delRow E

	
	
	$("#emailDomainChoise").change(function() {
		if(this.value==""){
			$("#mail2").css("background-color","");
			$("#mail2").removeAttr("readonly");
			$("#mail2").val("");
		}else{
			$("#mail2").val(this.value);
			$("#mail2").css("background-color", "#EEEEEE");
			$("#mail2").attr("readonly", true);
		}
	});
//addRow??? datePicker E


function setLicenseBtn(plusScCnt, mode){
   	/* DatePicker ?????? */
  		var date ="";
  		if(mode == "business"){
  			date = "#BIS_SDATE_"+plusScCnt+", #BIS_EDATE_"+plusScCnt;
  		}

	$(date).datepicker({
		showMonthAfterYear : true,
       	//showButtonPanel : true,
       	changeMonth : true,
       	changeYear : true,
       	//nextText : '?????? ???',
       	//prevText : '?????? ???',

       	//closeText : '??????',
       	dateFormat : "yy-mm-dd",
       	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
       	dayNamesMin : ['???','???','???','???','???','???','???'],
       	//monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???']
       	monthNamesShort : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
       	/*onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
        }*/
        
		//yearRange: '1980:2020'
	});
};


</script>