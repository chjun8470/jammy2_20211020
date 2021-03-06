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

<style>
.tbtn1{padding:7px 9px; background:#ddd; border-radius: 5px;}
.tbtn2{padding:7px 9px; background:#56b55d; border-radius: 5px; color:#fff;}
</style>



<div class="skin_list">
	
	
	<form id = "searchForm" name = "searchForm" method="post" action="?m=20" onsubmit="return searchFormCheck(this)">
		<input type="hidden" name = "nowPage" id = "nowPage" />
		<input type="hidden" name = "mode" id = "mode" />
		<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
			<div class="search_00">
				<div class="search_box02">
					<ul>
						<li>
							<h3 class="list_tit">????????? : </h3>
							<div class="list">
								<input type="text" name="buildDate" id="buildDate" value="<%=(util.getStr(paramMap.get("buildDate")).equals(""))?"":util.getStr(paramMap.get("buildDate")) %>" class="b_srch_txt inputbox" />
							</div>
						</li>
						<li>
							<h3 class="list_tit">????????? : </h3>
							<div class="list">
								<input type="text" name="searchPrice" id="searchPrice" value="<%=(util.getStr(paramMap.get("searchPrice")).equals(""))?"":util.getStr(paramMap.get("searchPrice")) %>" class="b_srch_txt inputbox" />(??????:?????????)
							</div>
						</li>
						<li>
							<h3 class="list_tit">??????????????????</h3>
							<div class="list">
								<select name="scib" id="scib" class="select_box">
									<option value="">????????????????????????(???)</option>
									<%
									for(HashMap co:scibMap){
										String selected = (util.getStr(paramMap.get("scib")).equals(co.get("CODE_CD")))?"selected":"";
										out.print("<option value='"+util.getStr(co.get("CODE_CD"))+"' "+selected+">"+util.getStr(co.get("CODE_NM"))+"</option>");
									}
									%>
								</select>
								<select name="scim" id="scim" class="select_box">
									<option value="">????????????????????????(???)</option>
								</select>
							</div>
						</li>
						<li>
							<h3 class="list_tit">????????????????????? ????????????</h3>
							<div class="list">
								<ul class="checkbox">
									<li><label for="ex22_1"><input name="ex22_1" value="??????" id="ex22_1" type="checkbox" <%=(util.getStr(paramMap.get("ex22_1")).equals("??????"))?"checked":"" %>>??????</label></li>
									<li><label for="ex22_2"><input name="ex22_2" value="????????????" id="ex22_2" type="checkbox" <%=(util.getStr(paramMap.get("ex22_2")).equals("????????????"))?"checked":"" %> >????????????</label></li>
									<li><label for="ex22_3"><input name="ex22_3" value="??????" id="ex22_3" type="checkbox" <%=(util.getStr(paramMap.get("ex22_3")).equals("??????"))?"checked":"" %> >??????</label></li>
								</ul>
							</div>
						</li>
						<li>
							<h3 class="list_tit">????????? ????????????</h3>
							<div class="list">
								<ul class="checkbox">
									<li><label for="ex20_1"><input name="ex20_1" value="???????????????" id="ex20_1" type="checkbox" <%=(util.getStr(paramMap.get("ex20_1")).equals("???????????????"))?"checked":"" %> >???????????????</label> </li>
									<li><label for="ex20_2"><input name="ex20_2" value="???????????????" id="ex20_2" type="checkbox" <%=(util.getStr(paramMap.get("ex20_2")).equals("???????????????"))?"checked":"" %> >???????????????</label></li>
								</ul>
							</div>
						</li>
						<li>
							<h3 class="list_tit">????????????</h3>
							<div class="list">
								<ul class="checkbox">
									<li><label for="ex23_1"><input name="ex23_1" value="?????????" id="ex23_1" type="checkbox" <%=(util.getStr(paramMap.get("ex23_1")).equals("?????????"))?"checked":"" %> >?????????</label></li>
									<li><label for="ex23_2"><input name="ex23_2" value="????????????" id="ex23_2" type="checkbox" <%=(util.getStr(paramMap.get("ex23_2")).equals("????????????"))?"checked":"" %> >????????????</label></li>
									<li><label for="ex23_3"><input name="ex23_3" value="??????" id="ex23_3" type="checkbox" <%=(util.getStr(paramMap.get("ex23_3")).equals("??????"))?"checked":"" %> >??????</label></li>
									<li><label for="ex23_4"><input name="ex23_4" value="????????????" id="ex23_4" type="checkbox" <%=(util.getStr(paramMap.get("ex23_4")).equals("????????????"))?"checked":"" %> >????????????</label></li>
								</ul>
							</div>
						</li>
						<li>
							<h3 class="list_tit">????????????????????????</h3>
							<div class="list">
								<ul class="checkbox">
									<li><label for="ex21_1"><input name="ex21_1" value="???????????????" id="ex21_1" type="checkbox" <%=(util.getStr(paramMap.get("ex21_1")).equals("???????????????"))?"checked":"" %> >???????????????</label></li>
								</ul>
							</div>
						</li>
						<li>
							<h3 class="list_tit">??????</h3>
							<div class="list">
								<div class="board-search">
									<ul class="li_sch">
										<li>
											<select name="searchYear" id="searchYear" class="select_box">
												<option value="">::????????????::</option>
												<%
													String selected = ""; 
													for(int i=rndYear; i>1950; i--){
														selected = util.getInt(paramMap.get("searchYear")).equals(i)?"selected":"";
														out.println("<option value='"+i+"' "+selected+">"+i+"???</option>");
													}
												%>
											</select>	
										</li>
										<li>
											<select name="searchType" id="searchType" class="select_box">
												<option value="A.EX_1" <%if(util.getStr(paramMap.get("searchType")).equals("A.EX_1")) { %> selected="selected" <% } %> >?????????</option>
												<option value="A.EX_3" <%if(util.getStr(paramMap.get("searchType")).equals("A.EX_3")) { %> selected="selected" <% } %>>?????????</option>
												<option value="A.EX_4" <%if(util.getStr(paramMap.get("searchType")).equals("A.EX_4")) { %> selected="selected" <% } %>>???????????????</option>
											</select>
										</li>
										<li>
											<!-- ????????? -->
											<label for="keyword" class="hide">?????????</label>
											<input type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord")) %>" class="b_srch_txt inputbox" />
											<!-- ???????????? -->
										</li>										
										<li><input type="button" class="btn_bl" value="??????" onclick="pageSearchGo()" style="float: right;" /></li>
									</ul>
								</div>
							</div>
						</li>
					</ul>
					
					
					<!-- board-search -->
				 </div>
			</div>
		<!-- bbs-top e -->
	</form>
	
	<div class="total" style="margin-top: 10px;">
		[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
	</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 15%;" />
				<col style="width: 25%;" />
				<col />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			if(rndNationExcelDataList.size() > 0){
			for(HashMap rs:rndNationExcelDataList) {%>
				<tr onclick="location.href='sub.do?m=<%=paramMap.get("m")%>&mode=view&IDX=<%=util.getStr(rs.get("IDX"))%>'">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("EX_1"))%></td>
					<td class="b_notice line_new_reg ico_box_cs"><%=util.getStr(rs.get("EX_3"))%></td>
					<td class="b_notice line_new_reg ico_box_cs"><%=util.getStr(rs.get("EX_4"))%></td>
					<td><%=util.getStr(rs.get("EX_7"))%></td>
					<td><span class="<%=util.getStr(rs.get("STATUS")).equals("2")?"tbtn1":"tbtn2"%>"><%=util.getStr(rs.get("STATUS")).equals("2")?"?????????":"???????????????"%></span></td>
				</tr>
			<%
			cont--;
			}
			}else{//endif%>
				<tr><td colspan="6">??????????????? ?????? ????????? ????????????.</td></tr>
			<%
			}
			%>
			</tbody>
		</table>
	<% if(rndNationExcelDataList.size() > 0){ %>	
	<%=util.getPaging(staticVO, nowPage) %>
	<% } %>
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
			alert("????????????????????????(???)??? ??????????????????");
			$("#scim").focus();
			return false;
		}
		
	}
	
	var scCode1 = "<%=util.getStr(paramMap.get("scib"))%>";
	var scCode2 = "<%=util.getStr(paramMap.get("scim"))%>";
	
	if(scCode1 != ""){
		var codeX = scCode1;
		var codeNext = 2;
		var mode = "scib";
		
		$.ajax({
			url : "/sys/expertManage.do",
			async : false,
			type : "POST",
			data : {codeX:codeX, codeNext:codeNext, mode:mode},
			dataType : "JSON",
			success : function(data){
				if(data.state == "OK"){
					var html = "";
					$.each(data.dataList,function(idx,obj){
						var selectx = (obj.CODE_CD == scCode2)?"selected":""; 
						html += "<option value='"+obj.CODE_CD+"' "+selectx+">"+obj.CODE_NM+"</option>";
					});
					$("#scim").append(html);
				}
			}
		});			
		
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
					
					$("select[name='scim']").eq(idx).find("option").remove().end().append("<option value=''>????????????????????????(???)</option>");
					
					
					$.each(data.dataList,function(idx,obj){
						html += "<option value='"+obj.CODE_CD+"'>"+obj.CODE_NM+"</option>";
					});
					$("select[name='scim']").eq(idx).append(html);
				}
			},"JSON");
		}else{
			$("select[name='scim']").eq(idx).find("option").remove().end().append("<option value=''>????????????????????????(???)</option>");			
		}
	});
	
	
	$("#buildDate").datepicker({
		
		showMonthAfterYear : true,
	   	showButtonPanel : true,
	   	changeMonth : true,
	   	changeYear : true,
	   	nextText : '?????? ???',
	   	prevText : '?????? ???',
	   	minDate: '-100y',
	   	yearRange: "1955:<%=rndYear%>",
	   	closeText : '??????',
	   	dateFormat : "yy-mm-dd",
	   	dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
	   	dayNamesMin : ['???','???','???','???','???','???','???'],
	   	monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
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

