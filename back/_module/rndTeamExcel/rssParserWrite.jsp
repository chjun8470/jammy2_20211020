<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form name="searchForm" method="get" action="/sys/rssParser.do">   
<input type="text" id="searchDate" name="dt" value="">
<input type="submit" value="등록">
</form>



<script>

$("#searchDate").datepicker({
	
	showMonthAfterYear : true,
   	showButtonPanel : true,
   	changeMonth : true,
   	changeYear : true,
   	nextText : '다음 달',
   	prevText : '이전 달',
   	minDate: '-100y',
   	closeText : '닫기',
   	dateFormat : "yymmdd",
   	dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
   	dayNamesMin : ['월','화','수','목','금','토','일'],
   	monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
   	monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
   	onClose: function(dateText, inst) {
        //var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        //var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        //$(this).datepicker('setDate', new Date(year, month, 1));
    }
   	/* showButtonPanel:true,
	yearRange: '1980:2020' */
});

</script>