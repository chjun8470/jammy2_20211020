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
	String avgnm = util.getStr(paramMap.get("avgnm"));

	
%>
<%!
	public String Checked(String radioCheck, String selectValue){
		String check="";
		if(radioCheck.equals(selectValue))check="checked";
		return check;
	}
%>
<div class="tabBox">
	<ul>
		<li class="<%if(avg.equals("?????????")){ %>on<%}%>" onclick="goSubmit('?????????')"><a href="javascript:void(0);">?????????</a></li>
		<li class="<%if(avg.equals("?????????")){ %>on<%}%>" onclick="goSubmit('?????????')"><a href="javascript:void(0);">?????????</a></li>
		<li class="<%if(avg.equals("?????????")){ %>on<%}%>" onclick="goSubmit('?????????')"><a href="javascript:void(0);">?????????</a></li>
	</ul>
</div>
<div class="list_top010">

		<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<!-- <input type="hidden" name="tab" id="tab"  value="build" /> -->
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="avg" id="avg" value="<%=avg%>" />
		</form>
</div>
	<div id="report_chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div><br/>

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
				<%if(avg.equals("?????????")){%>
					<th scope="col" class="r_line_none2" id="datanma"></th>
					<!-- <th scope="col" class="number" id ="datacnta"></th>
					<th scope="col" class="number" id ="datacntc"></th> -->
					<th scope="col" class="r_line_none file" id ="datacntb"></th>
				<%} else if(avg.equals("?????????")){%>
					<th scope="col" class="r_line_none2" id="datanma"></th>
					<!-- <th scope="col" class="number" id ="datacnta"></th>
					<th scope="col" class="number" id ="datacntb"></th> 
					<th scope="col" class="number" id ="datacntc"></th>-->
					<th scope="col" class="r_line_none file" id ="datacntd"></th>
				<%}else if(avg.equals("?????????")){%>
					<th scope="col" class="r_line_none2" id="datanma"></th>
					<th scope="col" class="r_line_none file" id ="datacnta"></th>
				<%} %>

				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dayListTable) {%>
				<tr>
				<%if(avg.equals("?????????")){%>
					<td class="r_line_none2"><%=util.getStr(rs.get("AREA"))%></td>
					<%-- <td class="number"><%=util.getComma(rs.get("CNT"))%></td>
					<td class="r_line_none2"><%=util.getStr(rs.get("EQUIP"))%></td> --%>
					<td class="r_line_none file"><%=util.getComma(rs.get("CNT"))%></td>
				<%}else if(avg.equals("?????????")){%>
					<td class="r_line_none2"><%=util.getStr(rs.get("AREA"))%></td>
					<%-- <td class="number"><%=util.getComma(rs.get("ORG_CNT"))%></td>
					<td class="number"><%=util.getComma(rs.get("CNT"))%></td>
					<td class="number"><%=util.getComma(rs.get("EQUIP"))%></td> --%>
					<td class="r_line_none file"><%=util.getComma(rs.get("CNT"))%></td>
				<%}else if(avg.equals("?????????")){%>
					<td class="r_line_none2"><%=util.getStr(rs.get("DA"))%></td>
					<td class="r_line_none file"><%=util.getComma(rs.get("CNT"))%></td>
				<%} %>
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
$( document ).ready(function() {
	<%if(avg.equals("?????????")){%>
		$("#datanma").html("?????????");
 		/* $("#datacnta").html("?????????");
 		$("#datacntc").html("???????????????"); */
 		$("#datacntb").html("???????????? ??????");
 	<%} else if(avg.equals("?????????")){%>
 		$("#datanma").html("?????????");
		/* $("#datacnta").html("?????????");
		$("#datacntb").html("?????????");
		$("#datacntc").html("???????????????"); */
		$("#datacntd").html("?????????");
 	<%} else if(avg.equals("?????????")){%>
 		$("#datanma").html("??????");
 		$("#datacnta").html("?????????");
 	<%} %>
});
function searchGo(){
	$('#searchForm').submit();
}
function goSubmit(avg){
	$('#avg').val(avg);
	$('#searchForm').submit();
}


	/* ?????????  */
$(function () {
    $('#report_chart').highcharts({
        title: {
            text: '???????????? ????????????'
        },
        credits:{ enabled:false },
        xAxis: {
            categories: [
						<%
							int countno = 0;
							String cateStr = "";
							for(HashMap rs:dayList) {
								cateStr +="'";
								if(avg.equals("?????????")){
									cateStr += util.getStr(rs.get("DA"));
								}else{
									cateStr += util.getStr(rs.get("AREA"));	
								}
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
            		'?????????',
        	data: [

					<%
					countno = 0;
					for(HashMap rs:dayList) {
					%>
						<%="".equals(util.getStr(rs.get("CNT"))) ? "0": util.getStr(rs.get("CNT"))%>
				<%	
					if(dayList.size() != countno+1){%>
						<%=","%>
					<%}
						countno++;
					}
					
					%>
                  ]
        }<%-- , {
            type: 'pie',
            name: '?????????',
            data:
                   <%
                   		int i = 1;
        			out.print("[");
                   		for(HashMap rs:dayList) {
                   			if(avg.equals("?????????")){
                   				out.print("{name : '"+util.getStr(rs.get("DA"))+"',");
                   				out.print("y: ");
                   				out.print("".equals(util.getStr(rs.get("CNT"))  ) ? "0": util.getStr(rs.get("CNT")) );
                   				out.print(",");
                   			}else{
                   				out.print("{name : '"+util.getStr(rs.get("AREA"))+"',");
                   				out.print("y: ");
                   				out.print("".equals(util.getStr(rs.get("CNT"))  ) ? "0": util.getStr(rs.get("CNT")) );
                   				out.print(",");
                   			}
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
        } --%>]
    });
});
</script>
