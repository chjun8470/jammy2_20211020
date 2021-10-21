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

  
   	String xNum = util.getStr(paramMap.get("xnum"));
	String year = util.getStr(paramMap.get("year"));
	String mIDX = util.getStr(paramMap.get("midx"));
	
	String fileGrp = "JnrdResult";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
     	
       
%>

<div id="result_content<%=year%>" class="result_content">
		<form method="post" name="resultForm_<%=year%>" id="resultForm_<%=year%>" action="<%=myPage%>">
		<input type="hidden" name="mode" value="writeProc">
		<input type="hidden" name="midx" value="<%=mIDX%>">
		
		<table class="skin_basic_write" >
			<caption>성과등록</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 성과발생연도</th>
		          		<td colspan="3">
		          			<!-- select name="npyear" id="npyear1" class="select_box" style="min-width:150px;">
		          				<option value="">::년도선택::</option>
		          			</select-->
		          			<input type="text" name="reyear" id="reyear" value="<%=year %>" class="inp_txt read_only" readonly />
		          			<label><input type="checkbox" name="reset" id="reset" value="1"/> 미등록</label>
		          		</td>
		          	</tr>		          	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - 사업화성과</h3>
		<div class="zoom_x"></div>
		<table class="skin_basic_write" >
			<caption>사업화성과</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 사업화구분</th>
		          		<td colspan="3">
		          			<label><input type="radio" name="retype" value="고용" checked="checked"> 고용</label>
		           			<label><input type="radio" name="retype" value="매출"> 매출</label>
		           			<label><input type="radio" name="retype" value="고용/매출"> 고용/매출</label>
		          		</td>
		          	</tr>
		          	<tr class="gg">
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 고용</th>
		          		<td colspan="3">
		          			<input type="text" name="reperson" id="reperson" value="" class="inp_txt" />(명)
		          		</td>
		          	</tr>
		          	<tr class="mm" style="display:none;">
		          		<th scope="row" class="tit"><span style="color:red;" >*</span> 매출</th>
		          		<td colspan="3">
		          			<input type="text" name="reprice" id="reprice" value="" class="inp_txt" disabled />(단위:백만원)
		          		</td>
		          	</tr>		          	
		   	</tbody>
		</table>
		
		<h3 class="tit"> - 기타성과</h3>
		<div class="zoom_x"></div>
		<table class="skin_basic_write" >
			<caption>기타성과</caption>
		       <colgroup>
		             <col style="width:20%" />
		             <col style="width:30%" />
		             <col style="width:20%" />
		             <col style="width:30%" />
		       </colgroup>
		       <tbody>
		          	<tr>
		          		<td colspan="4">
		          			<textarea name="recomment" class="inp_txt" rows="3" style="min-width:80%"></textarea>
		          		</td>
		          	</tr>          	
		   	</tbody>
		</table>
		
		
		<h3 class="tit"> - <%=year%>년 논문성과</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('info',<%=year%>);" />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('info',<%=year%>);" />
		</div>
		
		<div id="resultInfo_t1_<%=year%>">
			<div class="hideBox_n">+ 버튼을 누르고 성과를 등록하세요</div>		
		</div>
		
		<h3 class="tit"> - <%=year%>년 지적재산성과</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('se',<%=year%>)" />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('se',<%=year%>)" />
		</div>
		
		<div id="resultInfo_t2_<%=year%>">
			<div class="hideBox_n">+ 버튼을 누르고 성과를 등록하세요</div>
		</div>
		
		<h3 class="tit"> - <%=year%>년 기술이전성과</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('tech',<%=year%>)" />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('tech',<%=year%>)" />
		</div>
		
		<div id="resultInfo_t3_<%=year%>">
			<div class="hideBox_n">+ 버튼을 누르고 성과를 등록하세요</div>
		</div>
		
		<h3 class="tit"> - <%=year%>년 연구시설장비구축성과</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('bus',<%=year%>)" />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('bus',<%=year%>)" />
		</div>
		
		<div id="resultInfo_t4_<%=year%>">
			<div class="hideBox_n">+ 버튼을 누르고 성과를 등록하세요</div>
		</div>
		
		<h3 class="tit"> - <%=year%>년 신품종개발성과</h3>
		<div class="zoom_x">
			<input type="button" name="addbtn" value="+" class="btn_add" onclick="addResultRow('pps',<%=year%>)" />
			<input type="button" name="delbtn" value="-" class="btn_del" onclick="delResultRow('pps',<%=year%>)" />
		</div>
		
		<div id="resultInfo_t5_<%=year%>">
			<div class="hideBox_n">+ 버튼을 누르고 성과를 등록하세요</div>
		</div>
		
		<input type="button" class="submitBtn" value="성과업로드" />
		
		</form>
		
		
	</div>
	
	
	
	