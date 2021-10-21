<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "main";
	request.setCharacterEncoding("utf-8");
	String deth1 = "";
	String deth2 = "";

	ComUtil util = new ComUtil();
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	ArrayList<HashMap<String, String>> dataListWidget = request.getAttribute("dataListWidget") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataListWidget");
	ArrayList<HashMap<String, String>> dataListPopup = request.getAttribute("dataListPopup") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataListPopup");
%>
<%@include file="/front/_temple/main/t_top.jsp" %>
	<script type="text/javascript">
	//<![CDATA[

		$(document).ready(function(){

		});

		function setCookie( name, value, expirehours ) {
			var todayDate = new Date();
			todayDate.setHours( todayDate.getHours() + expirehours );
			document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			console.log(document.cookie)
		}

		function closeWin(flag, layer, id) {
			var idid = '#' + id;
		    if ( flag ) {
		        setCookie( idid, 'done' , 24 );
		    }
		    $(idid).get(0).style.visibility = 'hidden';
		}
		function closeWin2(id) {
			var idid = '#' + id;
			 $(idid).get(0).style.visibility = 'hidden';
		}

		function toTimeObject(time) { //parseTime(time)
			var year = time.substr(0,4);
			var month = time.substr(5,2) - 1; // 1월=0,12월=11
			var day = time.substr(8,2);
			var hour = time.substr(10,2);
			var min = time.substr(12,2);
			return new Date(year,month,day,hour,min);
		}

		function isFutureTime(time) {
			return (toTimeObject(time) > new Date());
		}

		function isPastTime(time) {
			return (toTimeObject(time) < new Date());
		}


		function getCookie(cname) {
		    var name = cname + "=";
		    //console.log(name);

		    //alert(document.cookie);
		    var ca = document.cookie.split(';');


		    for(var i=0; i<ca.length; i++) {
		        var c = ca[i];
		        while (c.charAt(0)==' ') c = c.substring(1);
		        console.log(c.indexOf(name));
		        if (c.indexOf(name) == 0) {
		            return c.substring(name.length, c.length);
		        }
		    }
		return "";
		}

		// 시작일시, 종료일시, 창이름, URL, 가로사이즈, 세로사이즈, x좌표, y좌표
		function openPopup(winName, stime, etime, wtarget, wurl, wsize, hsize, lpos, tpos){
			if(isPastTime(stime) && isFutureTime(etime)){
			var blnCookie = getCookie( winName );
			   //var obj = eval( "window." + winName );
			   //console.log(obj);
			   console.log(blnCookie);
			   if( !blnCookie ) {
				   //obj.style.display = "block";
				   window.open(wurl, wtarget, 'scrollbars=no, menubar=no, toolbar=no, location=no, status=no, width='+ wsize +', height='+hsize+',top='+tpos+',left='+lpos);
			   }
			}
		}
		<%for(HashMap rs:dataListPopup) {%>
			<%if(util.getStr(rs.get("HIDE_YN")).equals("N") && util.getStr(rs.get("POPUP_TYPE")).equals("window")&&util.getStr(rs.get("POPUP_URL")).equals("")){%>
				openPopup("popup_layer<%=util.getStr(rs.get("POPUP_IDX"))%>","<%=util.getStr(rs.get("ST_DT"))%><%=util.getStr(rs.get("ST_TIME"))%><%=util.getStr(rs.get("ST_MIN"))%>", "<%=util.getStr(rs.get("ED_DT"))%><%=util.getStr(rs.get("ED_TIME"))%><%=util.getStr(rs.get("ED_MIN"))%>", "popup_<%=util.getStr(rs.get("POPUP_IDX"))%>", "/sys/popupView.do?siteCode=<%=util.getStr(rs.get("SITE_CODE"))%>&popupIdx=<%=String.valueOf(rs.get("POPUP_IDX"))%>", "<%=util.getStr(rs.get("CSS_WIDTH"))%>", "<%=util.getStr(rs.get("CSS_HEIGHT")) %>", "<%=util.getStr(rs.get("CSS_LEFT"))%>", "<%=util.getStr(rs.get("CSS_TOP"))%>");
			<%} else { %>
				openPopup("popup_layer<%=util.getStr(rs.get("POPUP_IDX"))%>","<%=util.getStr(rs.get("ST_DT"))%><%=util.getStr(rs.get("ST_TIME"))%><%=util.getStr(rs.get("ST_MIN"))%>", "<%=util.getStr(rs.get("ED_DT"))%><%=util.getStr(rs.get("ED_TIME"))%><%=util.getStr(rs.get("ED_MIN"))%>", "popup_<%=util.getStr(rs.get("POPUP_IDX"))%>", "/sys/popupViewew.do", "<%=util.getStr(rs.get("CSS_WIDTH"))%>", "<%=util.getStr(rs.get("CSS_HEIGHT")) %>", "<%=util.getStr(rs.get("CSS_LEFT"))%>", "<%=util.getStr(rs.get("CSS_TOP"))%>");
			<%}%>
		<%} %>

		function fn_layer_popup(popupIdx){
				var layer = document.getElementById("popup_layer"+popupIdx);
				layer.style.visibility="hidden"; //반대는 hidden
			}
	//]]>	
	</script>
	<% Cookie[] cookies = request.getCookies();%>
	<%for(HashMap rs:dataListPopup) {%>
		<%if(util.getStr(rs.get("HIDE_YN")).equals("N") && util.getStr(rs.get("POPUP_TYPE")).equals("layer")){
			String Check = "none";
			if(request.getCookies() != null){
				for(Cookie cookie : cookies){
					if(cookie.getName().equals("popup_layer"+util.getStr(rs.get("POPUP_IDX"))))
					{
						Check = cookie.getValue();
					}
				}
			}
			if(!Check.equals("done")){
		%>
			<div id="popup_layer<%=util.getStr(rs.get("POPUP_IDX"))%>" class='layer_popup'
				style="position:absolute; border:double; top:<%=util.getStr(rs.get("CSS_TOP"))%>px; left:<%=util.getStr(rs.get("CSS_LEFT"))%>px; width:<%=util.getStr(rs.get("CSS_WIDTH"))%>px;
				height:<%=util.getStr(rs.get("CSS_HEIGHT"))%>px; z-index:1; visibility:visible; background-color:white;">
				<%if(util.getStr(rs.get("CONT_TYPE")).equals("html")){ %>
					<%=util.getStr(rs.get("HTML_CODING")) %>
				<%} else {%>
					<a href="<%=util.getStr(rs.get("LINK_URL")) %>"><img src="<%=util.getStr(rs.get("IMG_SRC"))%>" width="300" /></a>
				<%} %>
				<div class="btn_box">
					<div class="btn_left_box">
						<input type='checkbox' name='chkbox' value='divpop1' onclick='closeWin(true,"divpop1","popup_layer<%=util.getStr(rs.get("POPUP_IDX"))%>");'>오늘 하루 이 창을 열지 않음
					</div>
					<div class="btn_right_box">
						<span class="btn_b_01"><a href='#' onclick='closeWin2("popup_layer<%=util.getStr(rs.get("POPUP_IDX"))%>"); return false;'>닫기</a></span>
					</div>
				</div>
			</div>
		<%} %>
	<%}
	}%>

<div class="main_right_box">
	<div class="main_row_btn">
		<a href=""><img src="/imgs/main/btn_main_1.png" alt="" /></a>
		<a href=""><img src="/imgs/main/btn_main_2.png" alt="" /></a>
		<a href=""><img src="/imgs/main/btn_main_3.png" alt="" /></a>
	</div>
</div>
<div class="main_bottom_box">
	<div class="main_bottom_box_1">
		<a href=""><img src="/imgs/main/btn_main_4.png" alt=""/></a>
	</div>
	<div class="main_bottom_box_2">
		<a href=""><img src="/imgs/main/btn_main_5.png" alt=""/></a>
	</div>
	<div class="main_bottom_box_3">
		<a href=""><img src="/imgs/main/btn_main_6.png" alt=""/></a>
	</div>
	<div class="main_bottom_box_4">
		<a href=""><img src="/imgs/main/btn_main_7.png" alt=""/></a>
	</div>

	<div class="main_bottom_box_5">
		<div class="title_bar"><img src="/imgs/main/title_notice.png" alt="공지사항" />	</div>
		<div class="title_bar_more"><a href="/p/sub_06_01.do"><img src="/imgs/main/more.png" alt="MORE" /></a></div>
		<div class="notice_list">
			<ul>
			<%for(HashMap rs:dataListWidget) {%>
				<li>
					<a href="/p/sub_06_01.do?mode=view&amp;boardIdx=<%=util.getStr(rs.get("BOARD_IDX"))%>" title="공지사항이동">
					<%if(util.getStr(rs.get("SUBJECT")).length()>13) {%>
					<%=util.getStr(rs.get("SUBJECT")).substring(0, 12)+"..."%>
					<%} else {%>
					<%=util.getStr(rs.get("SUBJECT"))%>
					<%} %></a>
					<span class="notice_dt"><%=util.getStr(rs.get("REG_DT")).substring(0, 11)%></span>
				</li>
			<%} %>
			</ul>
		</div>
	</div>
</div>

<%@include file="/front/_temple/main/t_footer.jsp" %>