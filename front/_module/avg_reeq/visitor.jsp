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
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String avg = util.getStr(paramMap.get("avg"));
	String DateStart = paramMap.get("DateStart");
	String DateEnd = paramMap.get("DateEnd");
	String tab = paramMap.get("tab");
	String siteId = paramMap.get("siteId");
%>
<%!
	public String Checked(String radioCheck, String selectValue){
		String check="";
		if(radioCheck.equals(selectValue)){
			check +=" checked";
			check +="='checked'";
		}
		return check;
	}
%>
<%if(siteId.equals("jeinet")){ %>
<div class="tabBox">
	<ul>
		<li class="<%if(tab.equals("접속수")){ %>on<%}%>" onclick="tabSubmit('접속수')"><a href="javascript:void(0);">JEINET접속자</a></li>
		<li class="<%if(tab.equals("예약수")){ %>on<%}%>" onclick="tabSubmit('예약수')"><a href="javascript:void(0);">JEINET예약</a></li>
	</ul>
</div>
<%} %>
<div class="list_top012">
	
		<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="tab" id="tab"  value="<%=tab%>" />
			
			
			
			
			<div class="b_srchBox012">
			
			
			    <div class="b_chck012">
				<input type="radio" name ="avg" id ="year" value = "년별"  <%=Checked("년별", avg) %>/>
				<label for="year"> 년간 </label>
				<input type="radio" name ="avg"  id ="month"  value = "월별"<%=Checked("월별",avg) %>/>
				<label for="month"> 월간 </label>
				<input type="radio" name ="avg"  id ="day"  value = "일별"<%=Checked("일별", avg) %> />
				<label for="day"> 일간 </label>
				</div>
				
				
				<div class="b_srch012">
				<input type="text" class="b_srch_txt012" id="datepicker1" title="검색 시작 일자"  name ="DateStart" value="<%=DateStart %>" />
				<div class="b_between">~</div>
				<input type="text" class="b_srch_txt012" id="datepicker2" title="검색 종료 일자"  name ="DateEnd" value="<%=DateEnd %>" />
				<input type="image" class="b_go_btn012" alt="검색" src="../img/board/btn_ico_srch.png" onclick="goSubmit()" />
				</div>
				
			</div>	
				
			
			

		</form>
		
</div>
		
	<div id="report_chart"></div>
	
		<div class="board_count">
			[전체 <span class="blue1"><%=staticVO.getTotalCount() %></span>건, <span class="blue1"><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		</div>
		
		<!-- skin_basic_list s -->
		<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
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
					<th  scope="col"><%=avg%></th>
					<th scope="col" class="number line_cnci_lft">
						<%if(tab.equals("접속수")){
		            		out.print("접속수");
		            	}else{
		            		out.print("예약수");
		            	}
		            	%>
					</th>


				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dayListTable) {%>
				<tr>
					<td class="number "><%=util.getStr(rs.get("AXIS"))%></td>
					<td class="number line_cnci_lft"><%=util.getComma(rs.get("CNT"))%></td>
				</tr>
			<%
				}
			%>

			</tbody>
		</table>
<%=util.getPaging(staticVO, nowPage) %>
	


<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
function goSubmit(){
	$('#searchForm').submit();
}
function tabSubmit(tab){
	$('#tab').val(tab);
	$('#searchForm').submit();
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
        title: {
            text:
            	<%if(tab.equals("접속수")){
            		out.print("'접속자통계'");
            	}else{
            		out.print("'예약자 통계'");
            	}
            	%>
        },
        credits:{ enabled:false },
        xAxis: {
            categories: [
						<%
							int countno = 0;
							String cateStr = "";
							for(HashMap rs:dayList) {
								cateStr +="'";
								cateStr += util.getStr(rs.get("AXIS"));
								cateStr +="'";
								if(dayList.size()!=countno+1){
									cateStr += ",";
								}
								countno++;
							}
						%>
						<%=cateStr%>
                        ]
        },
        yAxis: {
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        labels: {
            items: [{
                html: '',
                style: {
                    left: '25px',
                    top: '18px',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                }
            }]
        },
        series: [{
            type: 'column',
            colorByPoint: true,
            name:
            	<%if(tab.equals("접속수")){
            		out.print("'접속수',");
            	}else{
            		out.print("'예약수',");
            	}
            	%>
            data: [

					<%
					countno = 0;
					for(HashMap rs:dayList) {
					%>
					<%=util.getStr(rs.get("CNT"))%>
					<%
						if(dayList.size()!=countno+1){%>
							<%=","%>
						<%}
						countno++;

					}
					%>
                  ]
        }, {
            type: 'spline',
            name:
            	<%if(tab.equals("접속수")){
            		out.print("'접속수',");
            	}else{
            		out.print("'예약수',");
            	}
            	%>
            data:
                   <%
                   		int i = 1;
        			out.print("[");
                   		for(HashMap rs:dayList) {
                   			out.print("{name : '"+util.getStr(rs.get("AXIS"))+"',");
        	            	out.print("y: "+util.getStr(rs.get("CNT"))+",");
        	       %>
                color: Highcharts.getOptions().colors[<%=i-1%>] // Jane's color
                   <%

		                   if(dayList.size() == i){
		                      	out.println("}");
		                      }else{

		                    	  out.println("},");
		                      	i++;
		                      }
                   		}
                   %>
            ],
            center: [50, -25],
            size: 90,
            showInLegend: false,
            dataLabels: {
                enabled: false
            }
        }]
    });
});
	//]]>
</script>
