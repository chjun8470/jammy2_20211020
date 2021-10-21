<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@include file="/back/_temple/basic/t_top.jsp" %>

   <div class="content_center">
		<div class="btn_right_box">
			<input type="button" class="btn_inp_w_01" style="float: right;" value="인쇄" onclick="print()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="PDF저장" onclick="pdf()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="EXCEL저장" onclick="excel()"/>
			<input type="button" class="btn_inp_w_01" style="float: right;" value="한글저장" onclick="hwp()"/>
		</div>
	   <div>
	      <iframe src="/AIViewer55/temp/expert.jsp?reportParams=showMenuBar:false" id="expert" name="expert" width="100%" height="100%" style="border:0px;" onload="autoReportResize('expert')"></iframe>
	   </div>   
   </div>
<script type="text/javascript">
//페이지 움직이기
function parentTest(value){
  	  $( 'html, body' ).animate( { scrollTop : value+200 } );
  	}
//파일 다운로드 스크립트
var print = function() {
	index = eqst.PDFPrint();
}
var pdf = function() {
	index = eqst.PDFConvert();
}
var excel = function() {
	index = eqst.ExcelConvert();
}
var hwp = function() {
	index = eqst.hwpConvert();
}	

</script>
<%@include file="/back/_temple/basic/t_footer.jsp" %>