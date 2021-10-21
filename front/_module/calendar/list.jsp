<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>

<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://www.google.com/jsapi"></script>
<script src="http://ajax.googleapis.com/ajax/libs/webfont/1.0.29/webfont.js" type="text/javascript"></script>
<div class="subcontBox">
			&nbsp;
			<div class="contentBox">
			<!-- start -->

	<script type="text/javascript">
	//<![CDATA[
		function fn_add(year,month){
		   var frm = document.fn_form;
		   if(year == ''){
			   year=document.getElementById('StYear').value;
		   }
		   frm.ParamYear.value=year;
		   frm.ParamMonth.value=month;
		   frm.target="_self";
		   frm.action="/p/sub_06_04.do";
		   frm.submit();
		}
	//]]>
	</script>

<%!
	static boolean isNull(String str){
		if(str !=null && str.length()>0){
			return false;
		} else {
			return true;
		}
	}
%>

<%


	String StYear = request.getParameter("ParamYear");
	String StMonth = request.getParameter("ParamMonth");

	Calendar now = Calendar.getInstance();

	if(!isNull(StYear)&&!isNull(StMonth)){
		int IntYear =Integer.parseInt(StYear);
		int IntMonth =Integer.parseInt(StMonth);
		now.set(IntYear, IntMonth, 0);
	} else {
		StYear =Integer.toString(now.get(Calendar.YEAR));
		StMonth =Integer.toString(now.get(Calendar.MONTH)+1);
		now = Calendar.getInstance();
	}

		int NowYear = now.get(Calendar.YEAR);
		int NowMonth = now.get(Calendar.MONTH)+1;
		int ParamYear = 0;
		int ParamMonth = 0;
	if(!isNull(StYear)&&!isNull(StMonth)){
		ParamYear = Integer.parseInt(StYear);
		ParamMonth = Integer.parseInt(StMonth);
	} else {
		ParamYear = NowYear;
		ParamMonth = NowMonth;
	}

	now.set(NowYear, NowMonth-1, 1);    //출력할 년도, 월로 설정
	NowYear = now.get(Calendar.YEAR);    //변화된 년, 월
	NowMonth = now.get(Calendar.MONTH)+ 1;
	String ToStYear = Integer.toString(NowYear);

	if(ToStYear.length()<1){
		ToStYear = "0"+ToStYear;
	}
	String ToStMonth = Integer.toString(NowMonth);
	if(ToStMonth.length()<=1){
		ToStMonth = "0"+ToStMonth;
	}
	String date = ToStYear +"-"+ToStMonth;
	String fc = "";

	int start = now.getActualMaximum(Calendar.DATE);
	int end = now.getActualMaximum(Calendar.DAY_OF_MONTH);    //해당월의 마지막 날짜

	int week = now.get(Calendar.DAY_OF_WEEK);    //1~7(일~토)

	//시작 , 끝 날짜 임의 세팅

%>
		<form name="fn_form" method="post" action="/p/sub_06_04.do">
			<input type="hidden" name="ParamYear" value="<%=ParamYear%>"/>
			<input type="hidden" name="ParamMonth" value="<%=ParamMonth%>"/>
			<%-- <div class="cal-search">
				<label for="searchType" class="hide">검색종류선택</label>
				<!-- searchCnd s -->
				<select name="searchType" id="searchType" class="select" style="height: 24px">
					<option value="TITLE" <%if("TITLE".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>제목</option>
				</select>

				<label for="keyword" class="hide">키워드</label>
				<input type="text" name="searchWord" id="searchWord" class="inp_text"  value="<%=util.getStr(paramMap.get("searchWord"))%>" />

				<input type="submit" class="btn_inp_g_01" value="검색"/>
			</div> --%>
				<table>
					<tr >
						<td width="270px">&nbsp;</td>
						<td>
							<%if(ParamMonth <= 1){%>
							<img src="../imgs/back/comm/pre.png" alt="이전" style="width:25px;" title="이전" onclick="javascript:fn_add(<%=ParamYear-1 %>,12)"/>
							<%} else {%>
								<img src="../imgs/back/comm/pre.png" alt="이전" style="width:25px;" title="이전" onclick="javascript:fn_add(<%=ParamYear%>,<%=ParamMonth-1 %>)" />
							<%} %>
						</td>
						<td width="5px">&nbsp;</td>

						<td width= "110px" style="vertical-align:middle; no-repeat left 0px; font-size:11px; font-weight:bold;padding-bottom:3px" align="center">
							<select name="StYear" id="StYear" style="width:55px;border:1px solid #c9c9c9; color:#444;background:#ffffff;" title="년">
								<%for(int i = NowYear-4; i<NowYear+5; i++) { %>
									<%if(ParamYear==i) {%>
										<option value="<%=i %>" selected="selected"><%=i %></option>
									<%}else { %>
										<option value="<%=i%>" > <%=i %></option>
									<%} %>
								<%} %>
							</select>
						&nbsp;
						<select name="StMonth" id="StMonth" style="width:43px;border:1px solid #c9c9c9; color:#444;background:#ffffff;" title="월" onchange="fn_add('',this.value);">
							<%for(int i = 1; i<13; i++) { %>
								 <%if(ParamMonth==i) {%>
								 <option value="<%=i %>" selected="selected"><%=i %></option>
								 <%}else{ %>
								 <option value="<%=i%>" ><%=i %></option>
								 <%} %>
							<%} %>
						</select>
							</td>

						<td width="5px">&nbsp;</td>

						<td width= "10px" align="center">
					<%if(ParamMonth >= 12){ %>
							<img src="../imgs/back/comm/next.png" alt="다음" style="width:25px;" title="다음" onclick="javascript:fn_add(<%=ParamYear+1 %>,1)"/>
					<%} else { if(ParamMonth==0) ParamMonth = ParamMonth+1;%>
							<img src="../imgs/back/comm/next.png" alt="다음" style="width:25px;" title="다음" onclick="javascript:fn_add(<%=ParamYear%>,<%=ParamMonth+1 %>)" />
					<%} %>
						</td>
					</tr>
				</table>
			</form>

	<table border="1" style="width:100%;border:1px #dddddd solid; margin-top:20px;">
		<tr height="30">
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="red">일</font></td>
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="#666">월</font></td>
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="#666">화</font></td>
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="#666">수</font></td>
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="#666">목</font></td>
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="#666">금</font></td>
			<td width="13%" bgcolor="#f9f9f9" align="right" style="font-weight:bold;" bordercolor="#e4e5e7"><font color="blue">토</font></td>
		</tr>
	<tr height='100' >
<%
		int newLine=0;
		for(int i=1; i<week; i++) {
			 %>
			<td bgcolor='#ffffff' bordercolor="#e4e5e7">&nbsp;</td>
			<%
			newLine++;
			}

		for(int i=1; i<=end; i++) 	{
			int z =0;

			String number = Integer.toString(i);
			if (newLine == 0 ){fc = "red";}
			else if (newLine == 6 ){fc = "blue";}//토요일
			else {fc="#000000";}				//일요일
			%>
			<td bordercolor="#e4e5e7"  valign="top">
			<table style="width:100%;, height:100%;" >
				<tr>
					<td align="right" style="padding-left:0.36em; padding-top:0.36em;font-weight:bold; " bordercolor="#e4e5e7" bgcolor="f9fcf7" >
						<%if(!fc.equals("red")&&!fc.equals("blue")){ %>
							<font color="<%=fc%>"><%=i%></font>
							<%}
						else{%>
							<font color="<%=fc%>"><%=i%></font>
							<%} %>
					</td>
				</tr>
				<tr>
					<td align="left" height="80" bordercolor="#e4e5e7"  valign="top">

			<%
				for(HashMap rs:dataList) {
					String date1 = util.getStr(rs.get("ST_DT"));
					String date2 = util.getStr(rs.get("ED_DT"));

					date1 = date1.replaceAll("-","");
					date2 = date2.replaceAll("-","");

					String a = Integer.toString(i);

					if(StMonth.length()<2){
						StMonth = "0"+StMonth;
					}
					if(a.length()<2){
						a = "0"+a;
					}

					String checkDate = StYear+""+StMonth+""+a;

					if(Integer.parseInt(date1)<=Integer.parseInt(checkDate) && Integer.parseInt(date2)>=Integer.parseInt(checkDate)){%>
						<a href="./<%=myPage%>?mode=view&amp;calIdx=<%=util.getStr(rs.get("CAL_IDX"))%>" >
							<%if(util.getStr(rs.get("TITLE")).length()>5) {%>
							<%=util.getStr(rs.get("TITLE")).substring(0, 5)+"..."%><br />
							<%} else {%>
							<%=util.getStr(rs.get("TITLE"))%><br />
							<%} %>
						</a>
					<%
					}
				}
					%>
					</td>
				</tr>
			</table>
			</td>
			<%
			newLine++;
				if(newLine == 7 && i != end) {%>
					</tr>
					<tr height='100'>
					<%newLine = 0;
				}
		}
		while(newLine>0 && newLine<7) {%>
			<td bgcolor='ffffff' bordercolor="#e4e5e7">&nbsp;</td>
			<% newLine++; }%>
			</tr>
		</table>
				<!-- end -->
			</div>
			</div>
    <!--subcontBox e-->
</body>
</html>