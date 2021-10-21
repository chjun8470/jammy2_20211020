<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>


<div class="nav_box">
	<div class="localbar">

    	<div class="nav_title">

    		<p class="title_name"><%=util.getStr(nowMenu.get("PMS_MENU_NAME")) %></p>

	    </div>

		<ul>
			<li>HOME</li>
 			<li>&gt;</li>

 			<%


			for(int m1no = 0; menuArr1.size() > m1no; m1no++){

				HashMap leftMenuMap1 = (HashMap)menuArr1.get(m1no);
				ArrayList leftMenuArr2 = (ArrayList)leftMenuMap1.get("data");

				if(util.getStr(nowMenu.get("SET_DETH1")).equals(util.getStr(leftMenuMap1.get("setDeth1")))){
				%>
				 <li><%=util.getStr(leftMenuMap1.get("name"))%></li>
           		 <li>&gt;</li>
				<%
				}
				for(int m2no = 0; leftMenuArr2.size() > m2no; m2no++){
					HashMap leftMenuMap2 = (HashMap)leftMenuArr2.get(m2no);
					if(util.getStr(nowMenu.get("SET_DETH1")).equals(util.getStr(leftMenuMap1.get("setDeth1"))) && util.getStr(nowMenu.get("SET_DETH2")).equals(util.getStr(leftMenuMap2.get("setDeth2")))){
					%>
					<li><a href="<%=util.getStr(leftMenuMap2.get("url"))%>" ><%=util.getStr(leftMenuMap2.get("name"))%></a></li>
					<%}
				}

			}

%>
		</ul>
     </div>
</div>