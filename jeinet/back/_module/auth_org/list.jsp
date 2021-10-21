<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");

	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));

	String nowPage = util.getStr(paramMap.get("nowPage"));

%>

<style type="text/css">

.leftMenuBox {
	position: relative;
	top: 0px;
	width: 300px;
	display: inline-block;
	vertical-align: top;
}

.leftMenuBox .leftMenuTite {
	height: 30px;
	line-height: 30px;
	background-color: #f3f3f3;
	text-align: center;
	border: 1px solid #cccccc;
}

.leftMenuBox .leftMenuList {
	line-height: 30px;
	height: 700px;
	overflow-y:scroll;
	width: 298px;
	border-right: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
}

.leftMenuBox .leftMenuList .menuRows {
	cursor: pointer;
}

.leftMenuBox .leftMenuList .menuRows .menuRows_1 {
	border-bottom: 1px solid #cccccc;
	cursor: pointer;
	padding: 0px 5px;
}

.leftMenuBox .leftMenuList .menuRows .menuRows_2 {
	cursor: pointer;
	padding: 0px 5px;
	background-color: #f9f9f9;
}

.centerMenuBox {
	position: relative;
	top: 0px;
	width: 300px;
	display: inline-block;
	vertical-align: top;
}



.centerMenuBox .menuTite {
	height: 30px;
	width: 100%;
	line-height: 30px;
	background-color: #f3f3f3;
	text-align: center;
	border: 1px solid #cccccc;
}


.centerMenuBox .selOrg {
	height: 30px;
	width: 100%;
	line-height: 30px;
	background-color: #fddc86;
	text-align: center;
	border-bottom: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}


.centerMenuBox .selOrgList {
	height: 30px;
	width: 100%;
	line-height: 30px;
	background-color: #e1e1e1;
	text-align: left;
	border-bottom: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;

}

.centerMenuBox .menuList1 {
	line-height: 30px;
	height: 700px;
	overflow-y:scroll;
	width: 300px;
	border-right: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
}

.centerMenuBox .menuList2 {
	line-height: 30px;
	height: 700px;
	overflow-y:scroll;
	width: 300px;
	border-right: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
}


.centerMenuBox .menuList1 .menuRows_1  , .centerMenuBox .menuList2 .menuRows_1{
	border-bottom: 1px solid #cccccc;
	padding: 0px 25px 0px 5px;
}



.menu_view {
	width: 100%;
	height: 100%;
	line-height: 30px;
	border-collapse: collapse;
	border: 1px solid #cccccc;
}

.menu_view th {
	border: 1px solid #cccccc;
	border-collapse: collapse;
	background-color: #f3f3f3;
}

.menu_view td {
	border: 1px solid #cccccc;
	border-collapse: collapse;
	padding: 0px 5px;
}

.tabbox {
	position: relative;
	border-bottom: 1px solid #cccccc;
	margin-top: 10px;
	padding-left: 20px;
}

.tabbox .tabBtn {
	position: relative;
	display: inline-block;
	height: 30px;
	line-height: 30px;
	width: 100px;
	background-color: #d0d0d0;
	color: #ffffff;
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	text-align: center;
	margin-right: 10px;
	top: 1px;
	cursor: pointer;
}

.tabbox .tabBtn_on {
	position: relative;
	display: inline-block;
	height: 30px;
	line-height: 30px;
	width: 100px;
	color: #fffff;
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	border-bottom: 1px solid #ffffff;
	text-align: center;
	margin-right: 10px;
	background-color: #ffffff;
	top: 1px;
	color: #fffff;
	cursor: pointer;
}

#authPopBox {
	display:none;
	z-index: 9;
	border: 3px solid #60bbff;
	position: absolute;
	top: 500px;
	left: 0px;
	width: 294px;
	height: 130px;
	background: #ffffff;
}

#authGrpPopBox{
	display:none;
	z-index: 10;
	border: 3px solid #60bbff;
	position: absolute;
	top: 186px;
	left: 20px;
	width: 300px;
	height: 730px;
	background: #ffffff;
}

</style>

<script src="/js/cms/back/auth_module.js" type="text/javascript"></script>

<div class="bbs-top">
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					기관명 : <input type="text" name="orgGrpNm" id="orgGrpNm" class="board-input" value="">
					<input type="button" class="btn_inp_g_01" value="검색" onclick="orgAuthListShow()">
				</div>
				<!-- board-search e -->
			</div>
		</div>
	</div>

<div style="position:relative; width: 100%; margin-top:10px;vertical-align:top;" >

	<div class="leftMenuBox"  >

		<div class="leftMenuTite">
			기관
		</div>

		<div class="leftMenuList" id="orgAuthList" >

		</div>
	</div>




	<div style="position:relative;top:0px;display:inline-block;vertical-align:top;margin-left:10px;">

		<div class="centerMenuBox"  >

			<div class="menuTite">
				권한적용모듈
			</div>

			<div style="line-height:30px;" class="selOrgList">
				<div>
					&nbsp;&nbsp;&nbsp;<span style="width:90px;" >기관명 :</span> <span id="orgAuthPopNm"></span>
				</div>
			</div>

			<div class="menuList1" id="authModule">
				<div class="menuRows_1" style="text-align:center;height:669px;">
					권한적용모듈을 선택해주세요.
				</div>
			</div>
		</div>
	</div>

	<div style="position:relative;top:0px;display:inline-block;vertical-align:top;margin-left:20px;">
		<div class="centerMenuBox">


			<div class="menuTite">
				전체 모듈
			</div>

			<div class="menuList2" id="allModule">
				<div class="menuRows_1" style="text-align:center;height:699px;">
					전체 모듈을 선택해주세요.
				</div>
			</div>
		</div>

	</div>


</div>

