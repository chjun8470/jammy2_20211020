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
	String avg = util.getStr(paramMap.get("avg"));
	

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
			
			
				<input type="submit" style="float:left;" name="avg" id="agency" value="?????????" />
				<input type="submit" style="float:left;" name="avg" id="area" value="?????????" />
				<button name="aireport" id="aireport" style="float:right;" onclick="window.open(location.href='/AIViewer55/temp/eqst.jsp?test=2')" value="Ai????????? ??????" >????????? ??????</button>
			
		</form>
		</div>

		<div id="report_chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div><br/>

				<br/><div class="search_row">
					[?????? <span><%=staticVO.getTotalCount() %></spRNrran>???, <span><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				</div>




		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
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
					<th scope="col">?????? ???</th>
					<th scope="col">??? ???</th>


				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dayListTable) {%>
				<tr>
					<td><%=util.getStr(rs.get("AXIS"))%></td>
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
            text: '???????????? ?????? ??????'
        },
        xAxis: {
            categories: [
						<%
							int countno = 0;
							for(HashMap rs:dayList) {
						%>
                         '<%=util.getStr(rs.get("AXIS"))%>'
		                        <%if(dayList.size()!=countno+1){%>
										<%=","%>
								<%}
							countno++;
							}
						%> 
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
            name: '?????????',
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
            type: 'pie',
            name: '?????????',
            data: [
                   <% 
                   		int i = 1;
                   		for(HashMap rs:dayList) {
                   			out.println("{name : '"+util.getStr(rs.get("AXIS"))+"',");
        	            	out.println("y: "+util.getStr(rs.get("CNT"))+",");
        	       %>     	
                color: Highcharts.getOptions().colors[<%=i-1%>] // Jane's color
                   <%	
		                   if(dayList.size() == i){
		                      	out.println("}],");
		                      }else{
		
		                    	  out.println("},");
		                      	i++;
		                      }
                   		}
                   %>
            
            center: [50, 30],
            size: 100,
            showInLegend: false,
            dataLabels: {
                enabled: false
            }
        }]
    });
});


</script>