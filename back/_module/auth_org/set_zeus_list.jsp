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

request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String display = "sub";
ComUtil util = new ComUtil();

String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");


StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
String mode = util.getStr(paramMap.get("mode"));
String nowPage = util.getIntStr(paramMap.get("nowPage"));


//out.println(staticVO);


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
		<h3 class="text-muted">국가연구시설장비  API LIST</h3>
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
				<th class="text-center">DETAIL</th>
			</tr>
		</thead>
		<tbody id="rslt-search">
		<%
		for(HashMap rs:dataList){
		%>
		<tr>
			<td><string><%=util.getStr(rs.get("korNm"))%></string><div style="color:#999;"><%=util.getStr(rs.get("engNm"))%></div></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>
			<%
			if(!util.getStr(rs.get("detailYn")).equals("Y")){
			%>
			<button type="button" class="setZeusInfo" data-idx="<%=util.getStr(String.valueOf(rs.get("equipId")))%>">서브등록</button>
			<%
			}else{
			%>
			<button type="button" disabled>등록완료</button>
			<%
			}
			%>
			</td>
		</tr>
		<%
		}
		%>
		</tbody>
	</table>
	
	</form>
	<%=util.getPaging(staticVO, nowPage) %>
	<hr>
	<div class="footer">
		
		
		
	</div>
</div>

<script>
$(".setZeusInfo").on("click",function(){
	var equipId = $(this).data("idx");
	var $this = $(this);
	util.equipReadData(equipId,$this);
});
</script>



