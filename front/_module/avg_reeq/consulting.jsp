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
<div class="list_top" style="margin-bottom:15px; margin-top:70px;">
	<div class="board_count">
		
		<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<div class="b_btn_sortlistBox" style="float:right;width: 473px;">
				<input type="radio" name ="avg" id ="year" value = "??????"  <%=Checked("??????", avg) %>/>
				<label for="year"> ?????? </label>&nbsp;
				<input type="radio" name ="avg"  id ="month"  value = "??????"<%=Checked("??????",avg) %>/>
				<label for="month"> ?????? </label>&nbsp;
				<input type="radio" name ="avg"  id ="day"  value = "??????"<%=Checked("??????", avg) %> />
				<label for="day"> ?????? </label>&nbsp;
				<input type="text" class="b_txtbox2" id="datepicker1" name ="DateStart" style="width:20%;" size ="13" value="<%=DateStart %>"  title="?????? ?????? ??????" /><b> ~ </b><input type="text" class="b_txtbox2" id="datepicker2" name ="DateEnd" style="width:20%;" size ="13" value="<%=DateEnd %>"  title="?????? ?????? ??????"  />
				<input type="image" class="b_go_btn" alt="??????" src="../img/board/btn_ico_srch.png" onclick="goSubmit()" />	 
			</div>
			
		</form>
	<div id="report_chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div><br/>
	<br/>
		<div class="board_count">
			[?????? <span class="blue1"><%=staticVO.getTotalCount() %></span>???, <span class="blue1"><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		</div>
		<br/>
		<br/>
		<!-- skin_basic_list s -->
		<table class="skin_list" summary="????????? ????????? ???????????? ????????????..">
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
					<th scope="col"><%=avg%></th>
					<th scope="col" class="number">
							?????? ???
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
					<td class="number"><%=util.getStr(rs.get("DAY"))%></td>
					<td class="number"><%=util.getComma(rs.get("CNT"))%></td>
				</tr>
			<%
				}
			%>

			</tbody>
		</table>
<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

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
/* ?????? */
$(document).ready(function(){
    $("#datepicker1, #datepicker2").datepicker({
        showMonthAfterYear : true,
        showButtonPanel : true,
        changeMonth : true,
        changeYear : true,
        nextText : '?????? ???',
        prevText : '?????? ???',
        currentText : '?????? ??????',
        closeText : '??????',
        dateFormat : "yy-mm-dd",
        dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
        dayNamesMin : ['???','???','???','???','???','???','???'],
        monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
        monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
    });

      // ?????? ????????? ?????? ?????? ?????? ????????? ?????? ??? ??????
     $('#datepicker1').datepicker("option", "maxDate", $("#datepicker2").val());
     $('#datepicker1').datepicker("option", "onClose", function ( selectedDate ) {
     $("#datepicker2").datepicker("option", "minDate", selectedDate );
     });

    // ?????? ????????? ?????? ?????? ?????? ????????? ?????? ??? ??????
     $('#datepicker2').datepicker("option", "minDate", $("#datepicker1").val());
     $('#datepicker2').datepicker("option", "onClose", function ( selectedDate ) {
     $("#datepicker1").datepicker("option", "maxDate", selectedDate );
    });
});

	/* ?????????  */
$(function () {
    $('#report_chart').highcharts({
        title: {
            text: '?????? ??????'
            	
        },
        credits:{ enabled:false },
        xAxis: {
            categories: [
						<%
							int countno = 0;
							String cateStr = "";
							for(HashMap rs:dayList) {
								cateStr +="'";
								cateStr += util.getStr(rs.get("DAY"));
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
            name:'?????? ???',
            	
    
            	
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
            name:'?????? ???',
            	
            	
            	
            	
            data: 
                   <% 
                   		int i = 1;
        			out.print("[");
                   		for(HashMap rs:dayList) {
                   			out.print("{name : '"+util.getStr(rs.get("DAY"))+"',");
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
