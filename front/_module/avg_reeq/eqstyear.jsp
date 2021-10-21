<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	ArrayList<HashMap<String, String>> ghouseDataList = request.getAttribute("ghouseDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("ghouseDataList");
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dayList = request.getAttribute("dayList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dayList");
	ArrayList<HashMap<String, String>> dayListTable = request.getAttribute("dayListTable") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dayListTable");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String equipmentDateStart = paramMap.get("equipmentDateStart");
	String equipmentDateEnd = paramMap.get("equipmentDateEnd");
	String selectValue = paramMap.get("select");
	String chart = util.getStr(paramMap.get("chart"));
	
	//loginVO.getAuthLv()
%>
<%!
	public String Checked(String radioCheck, String selectValue){
		String check="";
		if(radioCheck.equals(selectValue))check="checked";
		return check;
	}
%>


<div class="skin_list">

	<div class="skin_bbs_list">
		<div class="bbs-top">
		<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />
			<input type="hidden" name="selectValue" id="selectValue" value="<%=selectValue%>" />
			<input type="hidden" name="list" id="list" value="day" />
			<div class="search_box">
				<div class="board-search">
				<label for="keyword" class="hide">키워드</label>
					<input type="submit" name="chart" id="column" value = "column" title="막대그래프 보기" />
					<input type="submit" name="chart" id="polygonal" value = "polygonal" title="선그래프 보기" />
					<input type="submit" name="chart" id="pie" value = "pie" title="원그래프 보기" />
				
					<input type="radio" name ="select" id ="year" value = "년간"  <%=Checked("년간", selectValue) %>/>
						<label for="year"> 년간 </label>&nbsp;
					<input type="radio" name ="select"  id ="month"  value = "월간"<%=Checked("월간",selectValue) %>/>
						<label for="month"> 월간 </label>&nbsp;
					<input type="radio" name ="select"  id ="day"  value = "일간"<%=Checked("일간", selectValue) %> />
						<label for="day"> 일간 </label>&nbsp;
					<input type="text" class="board-input" id="datepicker1" name ="equipmentDateStart"  size ="13" value="<%=equipmentDateStart %>"  title="검색 일자 시작"  /><b> ~ </b><input type="text" class="board-input" id="datepicker2" name ="equipmentDateEnd" size ="13" value="<%=equipmentDateEnd %>"  title="검색 일자 종료"  />
					<input type="image" name="imageField" id="imageField" src="/imgs/board/btn_search.gif" alt="검색" class="vmiddle">
				</div>
			</div>
		</form>
		</div>

		<div id="report_chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div><br/>

				<br/><div class="search_row">
					[전체 <span><%=staticVO.getTotalCount() %></span>건, <span><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<span class="bbs_btn">
					<input type="button" class="btn_list"  value="엑셀저장"  onclick="excelDown();" />
				</span>
				</div>




		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 15%;" />
				<col style="width: 14%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 14%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col"><%=selectValue %></th>
					<th scope="col">장비 명</th>
					<th scope="col">건 수</th>


				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dayListTable) {%>
				<tr>
					<td><%=util.getStr(rs.get("DAY"))%></td>
					<td><%=util.getStr(rs.get("KOR_NM"))%></td>
					<td><%=util.getStr(rs.get("CNT"))%></td>
				</tr>
			<%
				}
			%>

			</tbody>
		</table>


	</div>

</div>

<%=util.getPaging(staticVO, nowPage) %>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function pageWriteGo(mode){
		$('#mode').val(write);
		$('#searchForm').submit();
	}
	/* 엑셀 다운 */
	function excelDown(){
        $('#searchForm').attr('action','/sys/avg_eq_cnstc_excel.do');
        $('#searchForm').attr('target','_blank');
        $('#searchForm').submit();
        $('#searchForm').attr('action','./<%=myPage %>');
        $('#searchForm').attr('target','');
     }
	/* 달력 */
	$(document).ready(function(){
	    $("#datepicker1, #datepicker2").datepicker({
	        showMonthAfterYear : true,
	        showButtonPanel : true,
	        changeMonth : true,
	        changeYear : true,
	        nextText : '다음 달',
	        prevText : '이전 달',
	        currentText : '오늘 날짜',
	        closeText : '닫기',
	        dateFormat : "yy-mm-dd",
	        dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
	        dayNamesMin : ['월','화','수','목','금','토','일'],
	        monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	    });

	      // 작업 시작일 값에 따른 작업 종료일 선택 값 제한
	     $('#datepicker1').datepicker("option", "maxDate", $("#datepicker2").val());
	     $('#datepicker1').datepicker("option", "onClose", function ( selectedDate ) {
	     $("#datepicker2").datepicker("option", "minDate", selectedDate );
	     });

	    // 작업 종료일 값에 따른 작업 시작일 선택 값 제한
	     $('#datepicker2').datepicker("option", "minDate", $("#datepicker1").val());
	     $('#datepicker2').datepicker("option", "onClose", function ( selectedDate ) {
	     $("#datepicker1").datepicker("option", "maxDate", selectedDate );
	    });
	});



	/* 그래프  */
$(function () {
    $('#report_chart').highcharts({
        chart: {
        	<%if(chart.equals("polygonal")){%>
        		type: ''
        	<%}else if(util.getStr(paramMap.get("chart")).equals("pie")){%>
	        	type: '<%=util.getStr(paramMap.get("chart"))%>',
	        	options3d: {
	                enabled: true,
	                alpha: 45
	            }
	        	
        	<%}else{%>
        	
        		
        		type: '<%=util.getStr(paramMap.get("chart"))%>',
        		options3d: {
	                enabled: true,
	                beta: 5,
	                alpha: 10
	            }
        	<%}%>
        }, 
        title: {
            text: ''
        },
        subtitle: {
            text: ' '
        },
        xAxis: {
            categories: [
				<%
				int countno = 0;
				String text = "";

				for(HashMap rs:dayList) {

				text += ""+util.getStr(rs.get("DAY"))+"";
				if(dayList.size()!=countno+1){
					text +=",";
				}
				countno++;
				}

						/*
				for(int day=1;day<=31;day++){
					text += "'"+day+"'";
					if(day!=31){text += ",";}
				}
				*/
				out.println(text);
				%>
            ],
            title: {
                text: '일별 (일)',
            x: 450
            },
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        plotOptions: {
            pie: {
            	allowPointSelect: true,
            	innerSize: 100,
                depth: 45
            },
            column: {
                
                depth: 80
            }
        },
        tooltip: {
        	headerFormat: '<span style="font-size:10px">{point.key}일</span><br/><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}:</td>' +
                '<td style="padding:0"><b>{point.y:.0f}건</b></td></tr>',
            footerFormat: '</table>',
            shared: false,
            useHTML: false
        },

        series: [{
        	name: '건 수',
        	data:[
			<% 
			countno = 0;
			for(HashMap rs:dayList) {
			%>
			{name: '<%=util.getStr(rs.get("KOR_NM"))%>',
				y:<%=util.getStr(rs.get("CNT"))%>
			<%
				if(dayList.size()!=countno+1){%>
					<%="},"%>
				<%}
				countno++;
			
			}
			%>
        	}]
         }]
         });
     });
	//]]>
</script>