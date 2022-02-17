<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>


<%
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
	
	
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"));
	String year = util.getStr(request.getParameter("year"));
	String area = util.getStr(request.getParameter("area"));
	
	
	
	String m = 	"20";
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");//추가적으로 파라미터 를 추가해준다
	
	
	

%>


<jsp:include page="/web/smbRndNationExcel.do" flush="true">
	<jsp:param name="mode" value="<%=mode%>"/>
	<jsp:param name="m" value="<%=m%>"/>
	<jsp:param name="nowPage" value="<%=nowPage%>"/>
</jsp:include>



