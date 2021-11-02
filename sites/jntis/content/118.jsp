<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<%
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"));
	String m = util.getStr(request.getParameter("m"));
	
%>

<div class="skin_line" style="display:block;height:10px;"></div>
	<div class="tabBox_pub">
		<ul>
			<li <%=(mode.equals("a1") || mode.equals(""))?"class='on'":""%>><a href="/jntis/sub.do?m=<%=m%>&mode=a1">사업통계</a></li>
			<!--<li <%=mode.equals("a2")?"class='on'":""%>><a href="/jntis/sub.do?m=<%=m%>&mode=a2">성과통계</a></li>
            <li <%=mode.equals("a3")?"class='on'":""%>><a href="/jntis/sub.do?m=<%=m%>&mode=a3">기획과제통계</a></li>-->
		</ul>
	</div>

</div>
<div class="tbl_right">
	<p>[단위 : 백만원]</p>
</div>
<div class="scroll">
<jsp:include page="/web/jntisJnrdM2Data.do" flush="true">
	<jsp:param name="mode" value="<%=mode%>"/>
</jsp:include>
</div>





<script>
	/* $(".tabBox_pub ul li").on("click", function() {
		var $this = $(this);
    	var $tab_con = $(".tab_table");
    	
    	
    	
    	
		
		$(".tabBox_pub ul li").filter(".on").removeClass("on");

		$this.addClass("on");

    	$tab_con.removeClass("on");
    	$tab_con.eq(tab_idx).addClass("on");
    }); */
</script>