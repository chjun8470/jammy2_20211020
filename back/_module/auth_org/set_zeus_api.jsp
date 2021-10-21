<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%> 
<%


request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");

String display = "sub";
ComUtil util = new ComUtil();

HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

String zeuskey = util.getStr(paramMap.get("zeuskey"));

%>


	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" rel="stylesheet"/>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet"/>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
	<script src="http://malsup.github.io/jquery.form.js" type="text/javascript" type="text/javascript"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.min.js" type="text/javascript"></script>
	
	<script src="/js/zeus/moment.js" type="text/javascript"></script>
	<script src="/js/zeus/api.js" type="text/javascript"></script>
	<script src="/js/zeus/nfecutil.js" type="text/javascript"></script>
	

<style>

	p { margin:0; }
	body { font-size:12px; }
	#wrap #container #left_snb .left_main_menu { height:auto; }
	#wrap #container #left_snb .left_main_menu._on { height:auto; }
	#wrap #container #left_snb .left_main_menu._ckon { height:auto; }
	ul { margin-bottom:0; }
	#wrap #container #left_snb li { font-size:12px; }
	#main_footer { margin-top:100px }

</style>

<div class="container">
	
	<div class="header page-header">
		<h3 class="text-muted">국가연구시설장비  API SAMPLE</h3>
	</div>
	
	
	
	<form method="post" name="zeusform" id="zeusform">
	<input type="hidden" name="mode" value="writeProc">
	<table class="table table-hover" style="font-size: 13px;">
		<colgroup>
			<col />
			<col width="150"/>
			<col width="100"/>
			<col width="150"/>
			<col width="150"/>
			<col width="80"/>
			<col width="80"/>
			<col width="100"/>
			<col width="80"/>
			<col width="50"/> 
		</colgroup>
		<thead>		
			<tr>
				<th class="text-center">장비명</th>
				<th class="text-center">기관명</th>
				<th class="text-center">고정자산관리번호</th>
				<th class="text-center">장비등록번호</th>
				<th class="text-center">활용범위</th>
				<th class="text-center">장비상태</th>
				<th class="text-center">등록자</th>
				<th class="text-center">등록일</th>
				<th class="text-center">장비상태</th>
				<th class="text-center">API</th>
			</tr>
		</thead>
		<tbody id="rslt-search"></tbody>
	</table>
	<input type="button" id="submitBtn" value="등록">
	</form>
	<div class="row">
		<div id="rstl-navi"class="col-md-5 col-md-offset-4"></div>
	</div>
	<hr>
	<div class="footer">
		
		
		
	</div>
</div>

<script type="text/javascript">
	
	var param = {};
	param['pageSize'] = 100;
	param['page'] = 1;
	util.equipSearch(param);

	
	
	$(document).on("click","#submitBtn",function (){
		
		var f = $("#zeusform")[0];
		var formData = new FormData(f);
		
		$.ajax({
            cache : false,
            url : "/sys/zeus.do",
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
		
	});

	<%-- var key = "<%=zeuskey%>";
	var prefixUrl = 'http://api.zeus.go.kr/api/eq/equips/'+key+'?pageSize=100';
	var html = "";
	$.ajax({
		url: prefixUrl, 
		data:{}, 
		dataType:"JSON"}).done(function(data) {
		
		console.log(data.pageList);
		$.each(data.pageList, function(i,v){
			
			//console.log(v.branchNm);
			html += '<tr>';
			html += '<td><a href="api-read.html?equipId='+v.equipId+'&key="><strong>'+v.korNm+'</strong></a><div style="color:#999;">'+v.engNm+'</div></td>'; //장비명
			html += '<td class="text-center">'+v.organNm+'</td>'; //기관명
			html += '<td class="text-center">'+v.fixedAsetNo+'</td>'; //고정자산관리번호
			html += '<td class="text-center">'+v.equipNo+'</td>'; //장비등록번호
			html += '<td class="text-center">'+v.useScopeNm+'</td>'; //활용범위
			html += '<td class="text-center">'+v.idleDisuseNm+'</td>'; //장비상태
			html += '<td class="text-center">'+v.registId+'</td>'; //등록자
			html += '<td class="text-center">'+v.registDt+'</td>'; //등록일
			html += '<td class="text-center">'+v.statusNm+'</td>'; //장비상태
			html += '<td class="text-center">'+v.apiYn+'</td>'; //API
			html += '</tr>';
			
			
		});
		
		
		$('#rstl-navi').html(renderNavi(util.equipSearch, data, params).removeClass('btn-group-xs col-sm-offset-3 col-sm-8').addClass('btn-group-sm'));
		
		
		//console.log(html);
		$('#rslt-search').append(html);
		
		
	}); --%>
</script>

