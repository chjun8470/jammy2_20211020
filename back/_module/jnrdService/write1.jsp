<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    //String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
    %>

    
    <form name="fwrite" id="fwrite" action="/sys/sys_jnrd_info.do" method="post" enctype="multipart/form-data">
    
    	<input type="text" name="mode" value="writeProc">
    	<input type="text" name="xxxx" value="123123">
    	<input type="text" name="nowPage" value="1">
    	
    	<input type="submit" value="전송">
    
    </form>