<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
	ArrayList<HashMap<String, String>> rndExcelDataList = request.getAttribute("rndExcelDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndExcelDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	
	
	String year = util.getStr(request.getParameter("year"));
	String area = util.getStr(request.getParameter("area"));
	String xmode = util.getStr(request.getParameter("xmode"));
	
	
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	
	ArrayList<HashMap<String, Object>> rndSumPriceList1 = request.getAttribute("rndSumPriceList1") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList1");
	
	ArrayList<HashMap<String, Object>> rndSumPriceList1_x1 = request.getAttribute("rndSumPriceList1_x1") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList1_x1");
	
	//ArrayList<HashMap<String, Object>> rndSumPriceList2 = request.getAttribute("rndSumPriceList2") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList2");
	//ArrayList<HashMap<String, Object>> rndSumPriceList3 = request.getAttribute("rndSumPriceList3") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList3");
	
	
	
	String category = "[";
	String data = "[";
	int k = 0;
	String eq = ",";
	
	
	
	data += "{";
	data += "name:'test',";
	data += "colorByPoint:true,";
	data += "data:[";
	
	String dataX = "";
	String dataY = "";
	
	for(HashMap rs:rndSumPriceList1) {
		if(k != 0){
			category += eq;
			data += eq;
			dataX += eq;
			dataY += eq;
		}
		
		data += "{";
		data += "name:'"+util.getStr(rs.get("TITLE"))+"',";
		data += "y:"+util.getStr(rs.get("TOTAL_PRICE"))+"";
		data += "}";
		
		dataX += util.getStr(rs.get("TOTAL_PRICE"));
		dataY += util.getStr(rs.get("CNT")).equals("")?0:util.getStr(rs.get("CNT"));
		
		category += " '"+util.getStr(rs.get("TITLE"))+"'";
		
		k++;
	}	
	category += "]";
	data += "]";
	data += "}]";
	
	pageContext.setAttribute("cxyearX", util.getStr(paramMap.get("year")));
	
%>



<div id="high_container">
	<div style="text-align:center; border:1px solid #ddd; color:#999; padding:50px; margin-bottom:50px;">일치하는 데이터가 없습니다.</div>
</div>

<jsp:useBean id="currTime" class="java.util.Date" />
<div class="con10">
<form method="post">
	<div class="sh_box">
        <ul>
            <li>
                <label>연도</label>
                
                <fmt:formatDate value="${currTime}" var="currTime" pattern="yyyy" />
       			<select name="year" id="year" class="select_box">
       				<option value="">:::선택:::</option>
       				<c:forEach var="i" begin="${currTime-4}" end="${currTime}">
          			<option value="${i}" <c:if test="${i eq cxyearX}">selected</c:if>>${i}</option>
          			</c:forEach>
       			</select>
                
                <%-- <select name="year" class="select_box">
                    <option value="">선택</option>
                    <option value="2021" <%if(year.equals("2021")) { %> selected="selected" <% } %>>2021</option>
                    <option value="2020" <%if(year.equals("2020")) { %> selected="selected" <% } %>>2020</option>
                    <option value="2019" <%if(year.equals("2019")) { %> selected="selected" <% } %>>2019</option>
                    <option value="2018" <%if(year.equals("2018")) { %> selected="selected" <% } %>>2018</option>
                </select> --%>
            </li>
            <li>
                <label>지역</label>
                <select name="area" id="area" class="select_box">
                	<option value="">전라남도</option>
        			<%
					for(HashMap rs:areaSigunguList) {
					%>
					<option value="<%=util.getStr(rs.get("CODE_NM"))%>" <%=(area.equals(util.getStr(rs.get("CODE_NM"))))?"selected":""%>><%=util.getStr(rs.get("CODE_NM"))%></option>
					<% } %>
        		</select>
                
            </li>
            <li>
                <label>선택</label>
                <select name="xmode" class="select_box">
                    <option value="" <%=(xmode.equals(""))?"selected":""%>>과학기술표준분류</option>
                    <option value="statis1" <%=(xmode.equals("statis1"))?"selected":""%>>중점과학기술분류</option>
                    <option value="statis2" <%=(xmode.equals("statis2"))?"selected":""%>>6T관련기술분류</option>
                </select>
                
            </li>
            <li><input type="submit" class="btn_bl" value="검색"></li>
        </ul>
    </div>
</form>
</div>


<br style="display:block; visibility:hidden; clear:both; content:'';" />

<div class="con10">
	<span style="float:right">(단위 : 백만원/과제수)</span>
	<div class="scroll">
		<table class="tbl_01">
        <colgroup>
		<thead>
			<tr>
			<%
			int x = 0;
			for(HashMap rs:rndSumPriceList1_x1){
				if(x==0) out.print("<th rowspan='2'>지역</th>");
			%>
				<th colspan="2"><%=rs.get("TITLE")%></th>
			<%
	        	x++;
			}//for end
	        %>
	        </tr>
	        <tr>
	        	<% for(HashMap rs:rndSumPriceList1_x1){ %>
	        	<th>사업비</th>
	        	<th>과제수</th>
	        	<% } %>
	        </tr>
	        
		</thead>
        <tbody>
            <tr>
            <%
            int xx = 0;
           
            	
			for(HashMap rs:rndSumPriceList1_x1){
				if(xx==0){
					if(util.getStr(paramMap.get("area")).equals(null) || util.getStr(paramMap.get("area")).equals("")){
						out.print("<td>전라남도</td>");
					}else{
						out.print("<td>"+util.getStr(paramMap.get("area"))+"</td>");
					}
				}
				//int totPrice = rs.get("TOTAL_PRICE")/100;
			%>
				<td><%=util.getComma(rs.get("TOTAL_PRICE"))%></td>
				<td><%=util.getComma(rs.get("CNT"))%></td>
			<%
	        	xx++;
			}//for end
            
	        %>
            </tr>
            <% 
            
            if(rndSumPriceList1_x1.size() > 0){
            if(util.getStr(paramMap.get("area")).equals(null) || util.getStr(paramMap.get("area")).equals("")){
            
            int io = 0;
			String price = "-";
			String num = "-";
            for(HashMap rs:areaSigunguList){ %>
            
        	<tr>
        		<td><%=util.getStr(rs.get("CODE_NM")) %></td>
        		<%
        		
        		int xo = 0;
        		for(HashMap rsd:rndSumPriceList1_x1){
        			
        			ArrayList<HashMap<String, Object>> setlist = request.getAttribute("set_"+xo+"_"+io) == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("set_"+xo+"_"+io);
        			if(setlist.size() > 0){
        				price = util.getInt(setlist.get(0).get("CNT")).equals(0)?"-":util.getComma(setlist.get(0).get("TOTAL_PRICE"));
        				num = util.getInt(setlist.get(0).get("CNT")).equals(0)?"-":util.getComma(setlist.get(0).get("CNT"));
        			}
        			
        		%>
        		<td><%=price%></td>
        		<td><%=num%></td>
        		<%
        			xo++;
        		}%>
        	</tr>
        	
        	<% io++; }
            }
            }else{
            %>
            <tr>
            	<td>데이터가 없습니다.</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    </div>
</div>

<div id="container"></div>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/highcharts-more.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script> 

<script>
Highcharts.setOptions({
	lang:{
		thousandsSep:','
	}
});

/* Highcharts.setOptions({
    colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
}); */
Highcharts.chart('high_container', {
    chart: {
        marginRight: 80
    },
    credits: {
        enabled: false
    },
    title: {
        text: '총 사업비/과제수'
    },
    xAxis: {
        categories: <%=category%>
    },
    yAxis: [{
    	min:0,
        title: {
            text: '단위:백만원'
        },
        tickInterval : 110
    }, {
        title: {
            text: '단위:갯수'            
        },
        opposite: true
    }],
    plotOptions: {
    	series: {
   	      borderWidth: 0,
   	      dataLabels: {
   	        enabled: true,
   	        format: '{point.y:,.0f} 백만원'
   	      }
   	    }
    },
    series: [{
        type: 'line',
        data: [<%=dataY%>],
        name: '과제수',
        yAxis: 1,
        color:'#7a6e96',
        tooltip:{
        	valueSuffix:' 개'
        },
        dataLabels:{
        	format:''
        },
        zIndex:2
    }, {
        type: 'column',
        data: [<%=dataX%>],
        name: '총사업비',
        tooltip:{
        	valueSuffix:' 백만원'
        },
        colorByPoint: true,
        zIndex:1
    }]
});





</script>