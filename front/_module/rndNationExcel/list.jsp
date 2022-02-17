<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%

	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> rndNationExcelDataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	
	ArrayList<HashMap<String, Object>> scibMap = request.getAttribute("scibMap") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("scibMap");
	
	
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	int rndYear = Integer.parseInt(sf.format(nowTime));
	
%>

<div class="skin_list">
	
	
	<form id = "searchForm" name = "searchForm" method="post" action="?m=20" onsubmit="return searchFormCheck(this)">
		<input type="hidden" name = "nowPage" id = "nowPage" />
		<input type="hidden" name = "mode" id = "mode" />
		<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
			<div class="basic_grid">
				<div class="search_box" style="padding:10px">
					
					<p>설립일 : <input type="text" name="buildDate" id="buildDate" readonly value="" /></p>
					<p>매출액 : <input type="text" name="searchPrice" id="searchPrice" value="" />(단위:백만원)</p>
					<p>
						주력사업분류
						<select name="scib" id="scib">
							<option value="">과학기술표준분류(대)</option>
							<%
							for(HashMap co:scibMap){
								
								out.print("<option value='"+util.getStr(co.get("CODE_CD"))+"'>"+util.getStr(co.get("CODE_NM"))+"</option>");
							}
							%>
						</select>
						<select name="scim" id="scim">
							<option value="">과학기술표준분류(중)</option>
						</select>
					</p>
					<p>
						보유현황
						연구개발협력체 <input type="checkbox" >대학 <input type="checkbox" >연구기관 <input type="checkbox" >기업
						수요처 구매약속 <input type="checkbox" >구매동의서 <input type="checkbox" >구매계약서</br>
						기업인증 <input type="checkbox" >연구소 <input type="checkbox" >전담부서 <input type="checkbox" >벤처 <input type="checkbox" >이노비즈
						투자기업투자약속<input type="checkbox" >투자동의서
					</p>	
					
					<div class="board-search">
						
						
						
						<select name="searchYear" id="searchYear" class="select">
							<option value="">::년도선택::</option>
							<%
								String selected = ""; 
								for(int i=rndYear; i>1950; i--){
									selected = util.getInt(paramMap.get("searchYear")).equals(i)?"selected":"";
									out.println("<option value='"+i+"' "+selected+">"+i+"년</option>");
								}
							%>
						</select>					
					
						<select name="searchType" id="searchType" class="select">
							<option value="EX_1" <%if(util.getStr(paramMap.get("searchType")).equals("EX_1")) { %> selected="selected" <% } %> >부처명</option>
							<option value="EX_3" <%if(util.getStr(paramMap.get("searchType")).equals("EX_3")) { %> selected="selected" <% } %>>사업명</option>
							<option value="EX_4" <%if(util.getStr(paramMap.get("searchType")).equals("EX_4")) { %> selected="selected" <% } %>>내역사업명</option>
						</select>
						<!-- 키워드 -->
						<label for="keyword" class="hide">키워드</label>
						<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
						<!-- 검색버튼 -->
						
						<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" style="float: right;" />
					</div>
					<!-- board-search -->
				 </div>
			</div>
		<!-- bbs-top e -->
	</form>
	
	<div class="total" style="margin-top: 10px;">
		[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
	</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 35%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">부처</th>
					<th scope="col">내역사업명</th>
					<th scope="col">접수시작일</th>
					<th scope="col">접수마감일</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			
			for(HashMap rs:rndNationExcelDataList) {%>
				<tr onclick="location.href='?mode=view&IDX=<%=util.getStr(rs.get("IDX"))%>'">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("EX_1"))%></td>
					<td class="b_notice line_new_reg ico_box_cs"><%=util.getStr(rs.get("EX_4"))%></td>
					<td><%=util.getStr(rs.get("EX_6"))%></td>
					<td><%=util.getStr(rs.get("EX_7"))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#moduleInfoIdx').val(idx);
		$('#searchForm').submit();
	}
	
	
	function searchFormCheck(f){
		
		if($("#scib").val() != "" && $("#scim").val() == ""){
			alert("과학기술표준분류(중)을 선택해주세요");
			$("#scim").focus();
			return false;
		}
		
	}
	
	
	
	$("select[name='scib']").on("change",function(){
		var codeX = $(this).val();
		var codeNext = 2;
		var mode = "scib";
		var idx = $("select[name='scib']").index(this);
		
		if(codeX != ""){
			$.post("/sys/expertManage.do",{codeX:codeX, codeNext:codeNext, mode:mode},function(data){
				if(data.state == "OK"){
					var html = "";
					
					$("select[name='scim']").eq(idx).find("option").remove().end().append("<option value=''>과학기술표준분류(중)</option>");
					
					
					$.each(data.dataList,function(idx,obj){
						html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
					});
					$("select[name='scim']").eq(idx).append(html);
				}
			},"JSON");
		}else{
			$("select[name='scim']").eq(idx).find("option").remove().end().append("<option value=''>과학기술표준분류(중)</option>");			
		}
	});
	
	
	$("#buildDate").datepicker({
		
		showMonthAfterYear : true,
	   	showButtonPanel : true,
	   	changeMonth : true,
	   	changeYear : true,
	   	nextText : '다음 달',
	   	prevText : '이전 달',

	   	closeText : '닫기',
	   	dateFormat : "yy-mm-dd",
	   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	   	dayNamesMin : ['월','화','수','목','금','토','일'],
	   	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	   	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
	   	onClose: function(dateText, inst) {
	        //var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	        //var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	        //$(this).datepicker('setDate', new Date(year, month, 1));
	    }
	   	/* showButtonPanel:true,
		yearRange: '1980:2020' */
	});

	
</script>

