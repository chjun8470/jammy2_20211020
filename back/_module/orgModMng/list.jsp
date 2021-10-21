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
	border-bottom: 1px solid #cccccc;
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
	height: 60px;
	width: 100%;
	line-height: 30px;
	background-color: #e1e1e1;
	text-align: left;
	border-bottom: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
	cursor:pointer;
}

.centerMenuBox .menuList1 {
	line-height: 30px;
	height: 610px;
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
	cursor: pointer;
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
	width: 610px;
	height: 270px;
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

<script src="/js/cms/back/module_mng.js" type="text/javascript"></script>

<div id="authGrpPopBox" >

	<div style="height:720px; overflow-y:scroll;">
		<div style="text-align:center;font-size:15px;height:40px;line-height:40px;">모듈권한정의</div>


		<div style="line-height:30px;padding-left:5px;padding-right:5px;">
			<input type="hidden" id="grpTp" value="" />
			<input type="hidden" id="selGrnum" value="" />
			<input type="hidden" id="selGrsubnum" value="" />
			<input type="hidden" id="reqUserIdx" value="" />
			<table class="menu_view"  border="0" >
				<tr>
					<th colspan="2">권한대상</th>
				</tr>
				<tr>
					<th style="width:70px;">대상구분</th>
					<td>
					<div id="grpTp1" style="display:none;">개인</div>
					<div id="grpTp2" style="display:none;">그룹</div>
					</td>
				</tr>
				<tr>
					<th colspan="2">적용대상</th>
				</tr>
				<tr>
					<td colspan="2" >
						<span id="grpInfo1">
							이름 : <span id="grpInfo1_nm" ></span><br/>
							ID   : <span id="grpInfo1_id" ></span><br/>
							기관명 : <span id="grpInfo1_org" ></span><br/>
							부서명   : <span id="grpInfo1_dept" ></span><br/>
							직급 : <span id="grpInfo1_position" ></span><br/>
							전화   : <span id="grpInfo1_phone" ></span><br/>
							이메일   : <span id="grpInfo1_email" ></span>
						</span>
						<span id="grpInfo2" style="display:none;">
							기관 : <span id="grpInfo2_org" ></span><br/>
							권한그룹 : <span id="grpInfo2_auth" ></span>
						</span>
					</td>
				</tr>
				<tr>
					<th colspan="2" id="grpGoTr1" style="display:none;">권한이관</th>
				</tr>
				<tr>
					<td colspan="2" id="grpGoTr2" style="display:none;">
						<div id="grpGoSel" style="height:auto;" ></div>
					</td>
				</tr>
			</table>

			<table class="menu_view"  border="0" >
				<tr>
					<th colspan="2">모듈목록 및 권한</th>
				</tr>
				<tr>
					<td style="padding:5px;">


						<div id="moduleList" style="height:auto;" ></div>


					</td>

				</tr>

			</table>

			<div style="text-align:center;">
				<input type="button" value="저장" class="btn_b_01" onclick="subOrgAuthSave()"/>
				<input type="button" value="닫기" class="btn_b_01" onclick="subOrgAuthHide();"/>
				<input type="checkbox" id="sub_org_auth_check" onchange="subOrgAuthCheck();"/><label for="sub_org_auth_check" >전체 선택</label>
			</div>

		</div>
	</div>

</div>

	<div class="bbs-top">
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<!-- 검색창 -->
					<label for="searchType">기업/기관명 :</label>
					&nbsp;<input type="text" name="orgGrpNm" id="orgGrpNm" class="inp_text" value="" style="width:200px; height:24px;">
					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="orgAuthListShow()">
				</div>
				<!-- board-search e -->
			</div>
		</div>
	</div>

<div style="position:relative; width: 100%; margin-top:10px;vertical-align:top;" >

	<div id="authPopBox" >

		<div style="height:235px;padding-left:15px;padding-right:15px;">
			<div style="text-align:center;font-size:15px;">부서 추가/수정</div>
			<div style="line-height:30px;">
				<div>
					<!-- <span style="width:90px;" >기관명 :</span> <span id="orgAuthPopNm"></span> -->
					<input type="hidden" id="orgAuthPopCd" value="" />
					<input type="hidden" id="orgAuthPopSubCd" value="" />
					<input type="hidden" id="orgAddr1" value="" />
					<input type="hidden" id="orgAddr2" value="" />
					<input type="hidden" id="zip" value="" />

				</div>
				<!--
				<div>
					<span style="width:90px;">부서/센터 :</span> <input type="text" id="orgSubAuthPopNm" class="inp_text"  value="" />
				</div>
				<div>
					<span style="width:90px;">주소 :</span> <input type="text" id="zipCode" class="inp_text" style="width:10%;" value="" />&nbsp;&nbsp;<input type="text" id="addr1" class="inp_text" style="width:40%;" value="" /> <input type="button" value="찾아보기" id="btnAuthWirtePop" class="btn_b_01" onclick="orgPost()"/> <input type="button" value="기관주소 불러오기" id="btnAuthWirtePop" class="btn_b_01" onclick="loadOrgAddr()"/>
				</div>
				<div>
					<span style="width:90px;">상세주소 :</span> <input type="text" id="addr2" class="inp_text"  value="" />
				</div>
				<div>
					<span style="width:90px;">대표전화 :</span> <input type="text" id="orgPhone" class="inp_text"  value="" />
				</div>
				<div>
					<span style="width:90px;">FAX :</span> <input type="text" id="orgFax" class="inp_text"  value="" />
				</div>
				-->

				<table>
					<caption>
	       				부서/센터 추가
	          		</caption>
	          		<colgroup>
				        <col style="width:100px;" />
				        <col style="width:*" />
			        </colgroup>
			        <tbody>
			        	<tr>
			        		<th>기관명 :</th>
			        		<td>
			        			<span id="orgAuthPopNm"></span>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>부서/센터 :</th>
			        		<td>
			        			<input type="text" id="orgSubAuthPopNm" class="inp_text" style="width:59%;" value="" />
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>주소 :</th>
			        		<td>
			        			<input type="text" id="zipCode" class="inp_text" style="width:10%;" value="" />&nbsp;&nbsp;&nbsp;<input type="text" id="addr1" class="inp_text" style="width:45%;" value="" /> <input type="button" value="찾아보기" id="btnAuthWirtePop" class="btn_b_01" onclick="orgPost()"/> <input type="button" value="기관주소 불러오기" id="btnAuthWirtePop" class="btn_b_01" onclick="loadOrgAddr()"/>
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>상세주소 :</th>
			        		<td>
			        			<input type="text" id="addr2" class="inp_text" style="width:59%;" value="" />
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>대표전화 :</th>
			        		<td>
			        			<input type="text" id="orgPhone" class="inp_text" style="width:59%;" value="" />
			        		</td>
			        	</tr>
			        	<tr>
			        		<th>FAX :</th>
			        		<td>
			        			<input type="text" id="orgFax" class="inp_text" style="width:59%;" value="" />
			        		</td>
			        	</tr>
			        </tbody>
				</table>
			</div>
		</div>
		<div style="text-align:center;">
			<input type="button" value="저장" id="btnAuthWirtePop2" class="btn_b_01" onclick="subOrgWrite()"/>
			<input type="button" style="display:none;" value="수정" id="btnAuthEditPop" class="btn_b_01" onclick="subOrgEdit()"/>
			<input type="button" value="닫기" class="btn_b_01" onclick="subOrgHide();" />
		</div>
	</div>


	<div class="leftMenuBox"  >

		<div class="leftMenuTite">
			기업/기관 부서명
		</div>

		<div class="leftMenuList" id="orgAuthList" >

		</div>
	</div>




	<div style="position:relative;top:0px;display:inline-block;vertical-align:top;margin-left:10px;">

		<div class="centerMenuBox"  >

			<div class="menuTite">
				권한부여
			</div>

			<div class="selOrg">
				선택권한그룹:

			</div>

			<div class="selOrgList" onclick="subOrgAuthOrgShow('org');" onmouseover="$(this).css('background','#fdfba8');" onmouseout="$(this).css('background','#e1e1e1');">

				<div style="padding:0px 5px;position:relative;" >
					<span>기관 : </span>
					<span id="selOrgNm">기관이름</span>
					<input type="hidden" id="selOrgCd" value="" />
				</div>

				<div style="padding:0px 5px;position:relative;" >
					<input type="hidden" id="selOrgSubCd" value="" />
					<span >부서 : </span>
				 	<span id="selOrgSubNm">권한구분</span>
				 	<span style="position:absolute;right:5px;bottom:5px;">
				 	<!--160830수정 추후스크립트수정예정 <input type="button" value="삭제" class="btn_b_01" style="display:none;" id="inpSubOrgDel" onclick="subSubOrgDelete()" /> -->
				 	</span>
				</div>


			</div>

			<div class="menuList1" id="authUser">
				<div class="menuRows_1" style="text-align:center;height:609px;">
					기업/기관 부서명을 선택해주세요.
				</div>
			</div>
		</div>
	</div>

	<div style="position:relative;top:0px;display:inline-block;vertical-align:top;margin-left:20px;">
		<div class="centerMenuBox">


			<div class="menuTite">
				권한미부여
			</div>

			<div class="menuList2" id="noAuthUser">
				<div class="menuRows_1" style="text-align:center;height:699px;">
					기업/기관 부서명을 선택해주세요.
				</div>
			</div>
		</div>

	</div>


</div>

