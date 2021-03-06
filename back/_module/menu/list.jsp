<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%

	//String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataMenuList = request.getAttribute("dataMenuList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMenuList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);


%>
<style type="text/css">
	.leftMenuBox{
		position:relative;top:0px;width:200px;display:inline-block;vertical-align:top;

	}
	.leftMenuBox .leftMenuTite{
		height:30px;line-height:30px;background-color:#f3f3f3;text-align:center;
		border:1px solid #cccccc;
	}

	.leftMenuBox .leftMenuList{
		line-height:30px;
		height:100%;
		width:198px;
		border-right:1px solid #cccccc;
		border-left:1px solid #cccccc;
	}

	.leftMenuBox .leftMenuList .menuRows{
		border-bottom:1px solid #cccccc;
		cursor:pointer;
		padding:0px 5px;
	}


	.title_box{
		border-bottom:1px solid #cccccc;
		height:30px;
		line-height:30px;
	}

	.rightMenuTite{
		height:30px;line-height:30px;background-color:#f3f3f3;text-align:center;
		width:500px;
		border:1px solid #cccccc;
	}

	.menu_view{
		width:100%;
		height:100%;
		line-height:30px;
		border-collapse: collapse;
	}
	.menu_view th{
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		border-bottom:1px solid #cccccc;
		border-collapse: collapse;
		background-color:#f3f3f3;
	}

	.menu_view td{
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		border-bottom:1px solid #cccccc;
		border-collapse: collapse;
		padding:0px 5px;
	}

	.tabbox{
		position:relative;
		border-bottom:1px solid #cccccc;
		margin-top:10px;
		padding-left:20px;
	}
	.tabbox .tabBtn {
		position:relative;
		display:inline-block;
		height:30px;
		line-height:30px;
		width:100px;
		background-color:#d0d0d0;
		color:#ffffff;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		text-align:center;
		margin-right:10px;
		top:1px;
		cursor:pointer;
	}

	.tabbox .tabBtn_on{
		position:relative;
		display:inline-block;
		height:30px;
		line-height:30px;
		width:100px;
		color:#fffff;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		border-bottom:1px solid #ffffff;
		text-align:center;
		margin-right:10px;
		background-color:#ffffff;
		top:1px;
		color:#fffff;
		cursor:pointer;
	}

</style>

<script type="text/javascript">

	$(function(){
		$('.menuRows').mouseover(function(){
			$('.menuRows').css('background-color','#fffff');
			$(this).css('background-color','#80c5fd');
		});
		$('.menuRows').mouseout(function(){
			$('.menuRows').css('background-color','#fffff');
		});
	});

	function menuShow(menuIdx){

		if(menuIdx == ''){
			alert("?????? ????????? ?????????????????????.");
			return;
		}

		var params = {
        				"menuIdx":menuIdx,
                        "mode":"view"
				};

		jQuery.post("/sys/menuProc.do",$.param(params),
		function(data) {

			var succCode="";
			for (var i in data) {
				succCode = data.succCode;
           	}
			if(succCode=="OK"){
				$('#pms_menu_name').val(data.menuData.PMS_MENU_NAME);
				$('#order_no').val(data.menuData.ORDER_NO);
				$('#pms_menu_type').val(data.menuData.PMS_MENU_TYPE);
				$('#pms_menu_url').val(data.menuData.PMS_MENU_URL);
				$('#pms_menu_auth').val(data.menuData.PMS_MENU_AUTH);
				$('#parent_pms_menu_idx').val(data.menuData.PARENT_PMS_MENU_IDX);
				$('#pms_menu_idx').val(data.menuData.PMS_MENU_IDX);
				$('#deth').val(data.menuData.DETH);
				$('#set_deth1').val(data.menuData.SET_DETH1);
				$('#set_deth2').val(data.menuData.SET_DETH2);
				$('#icon_no').val(data.menuData.ICON_NO);
				$('#menuInstBtn').hide();
				$('#menuUptBtn').show();
				data = null;
			}else if(succCode == "MISS"){
				alert('????????? ????????????.');
				return;
			}else{
				alert('????????? ???????????????.');
				return;
			}
		});
	}


	function menuEdit(){

		var pms_menu_name = $('#pms_menu_name').val();
		var order_no = $('#order_no').val();
		var pms_tmenu = $('#pms_tmenu').val();
		var deth = $('#deth').val();
		var pms_menu_type = $('#pms_menu_type').val();
		var pms_menu_url = $('#pms_menu_url').val();
		var pms_menu_auth = $('#pms_menu_auth').val();
		var parent_pms_menu_idx = $('#parent_pms_menu_idx').val();
		var pms_menu_idx = $('#pms_menu_idx').val();
		var set_deth1 = $('#set_deth1').val();
		var set_deth2 = $('#set_deth2').val();
		var icon_no = $('#icon_no').val();

		if(pms_menu_name == ""){return alert("????????? ???????????????");}
		if(pms_menu_type == ""){return alert("??????????????? ???????????????");}
		if(pms_menu_url == ""){return alert("????????? ???????????????");}
		if(pms_menu_auth == ""){return alert("????????? ???????????????");}
		if(parent_pms_menu_idx == ""){return alert("???????????? ???????????????");}

		var params = {
        				"pmsMenuName":pms_menu_name ,
        				"orderNo":order_no,
        				"pmsTmenu":pms_tmenu,
        				"deth":deth,
        				"pmsMenuUrl":pms_menu_url,
        				"pmsMenuType":pms_menu_type,
        				"pmsMenuAuth":pms_menu_auth,
        				"parentPmsMenuIdx":parent_pms_menu_idx,
        				"pmsMenuIdx":pms_menu_idx,
        				"setDeth1":set_deth1,
        				"setDeth2":set_deth2,
        				"iconNo":icon_no,
                        "mode":"edit"
				};

		jQuery.post("/sys/menuProc.do",$.param(params),
		function(data) {

			var succCode="";
			for (var i in data) {
				succCode = data.succCode;
           	}
			if(succCode=="OK"){
				alert("?????????????????????.");
				window.replace();
			}else if(succCode == "MISS"){
				alert('????????? ????????????.');
				return;
			}else{
				alert('????????? ???????????????.');
				return;
			}
		});
	}


	function writeGo(){

		var pms_menu_name = $('#pms_menu_name').val();
		var order_no = $('#order_no').val();
		var pms_tmenu = $('#pms_tmenu').val();
		var deth = $('#deth').val();
		var pms_menu_type = $('#pms_menu_type').val();
		var pms_menu_url = $('#pms_menu_url').val();
		var pms_menu_auth = $('#pms_menu_auth').val();
		var parent_pms_menu_idx = $('#parent_pms_menu_idx').val();
		var pms_menu_idx = $('#pms_menu_idx').val();
		var set_deth1 = $('#set_deth1').val();
		var set_deth2 = $('#set_deth2').val();
		var icon_no = $('#icon_no').val();

		if(pms_menu_name == ""){return alert("????????? ???????????????");}
		if(pms_menu_type == ""){return alert("??????????????? ???????????????");}
		if(pms_menu_url == ""){return alert("????????? ???????????????");}
		if(pms_menu_auth == ""){return alert("????????? ???????????????");}
		if(parent_pms_menu_idx == ""){return alert("???????????? ???????????????");}


		var params = {
        				"pmsMenuName":pms_menu_name ,
        				"orderNo":order_no,
        				"pmsTmenu":pms_tmenu,
        				"deth":deth,
        				"pmsMenuUrl":pms_menu_url,
        				"pmsMenuType":pms_menu_type,
        				"pmsMenuAuth":pms_menu_auth,
        				"parentPmsMenuIdx":parent_pms_menu_idx,
        				"pmsMenuIdx":pms_menu_idx,
        				"setDeth1":set_deth1,
        				"setDeth2":set_deth2,
        				"iconNo":icon_no,
                        "mode":"write"
				};

		jQuery.post("/sys/menuProc.do",$.param(params),
		function(data) {

			var succCode="";
			for (var i in data) {
				succCode = data.succCode;
           	}
			if(succCode=="OK"){
				alert("?????????????????????.");
				window.replace();
			}else if(succCode == "MISS"){
				alert('????????? ????????????.');
				return;
			}else{
				alert('????????? ???????????????.');
				return;
			}
		});
	}

	function tabGoLink(no){
		location.href = "/sys/sys_menu.do?tmenu=1&subtmenu="+no;
	}
</script>



<div class="title_box">
	??? ?????? ??????
</div>

<div class="tabbox">
	<div class="tabBtn<%if(!"2".equals(util.getStr(paramMap.get("subtmenu")))){out.print("_on");} %>" onclick="tabGoLink(1)" >?????? PMS</div>
	<div class="tabBtn<%if("2".equals(util.getStr(paramMap.get("subtmenu")))){out.print("_on");} %>" onclick="tabGoLink(2)" >?????? PMS</div>
</div>

<div style="position:relative; width: 100%; margin-top:10px;vertical-align:top;" >
	<div class="leftMenuBox"  >

		<div class="leftMenuTite">
			????????????
		</div>
		<div style="width:219px;">
		<div class="leftMenuList">
			<%
				int i=0;
				for(HashMap rs:dataMenuList) {
					i++;
			%>
			<div class="menuRows" onclick="menuShow('<%=util.getStr(rs.get("PMS_MENU_IDX"))%>')">
				<%
					if("1".equals(util.getStr(rs.get("DETH")))){
						out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
					}
				%>
				<%=util.getStr(rs.get("ORDER_NO"))%>. <%=util.getStr(rs.get("PMS_MENU_NAME"))%>
			</div>
			<%
				}
			%>
		</div>
		</div>
	</div>

	<div style="position:relative;top:0px;display:inline-block;vertical-align:top;">


		<div class="rightMenuTite">
			????????????
		</div>

		<div >


			<table class="menu_view"  border="0" >
				<tr>
					<th>??????</th>
					<td>
						<%
							String subtmenu = "1";
							if("2".equals(util.getStr(paramMap.get("subtmenu")))){
								out.print("?????? PMS");
								subtmenu = "2";
							} else{
								out.print("?????? PMS");
								subtmenu = "1";
							}%>
							<input type="hidden" value="<%=subtmenu%>" name="pms_tmenu" id="pms_tmenu" />
							<input type="hidden" value="<%=subtmenu%>" name="pms_menu_idx" id="pms_menu_idx" />
					</td>
				</tr>
				<tr>
					<th><label for="pms_menu_name">??????</label></th>
					<td>
						<input id="pms_menu_name" name="pms_menu_name" value="" class="inp_text" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th><label for="pms_menu_type">????????????</label></th>
					<td>
						<select id="pms_menu_type" name="pms_menu_type" class="inp_text" style="width:100px;">
							<option value="leaf">????????????</option>
							<option value="link">??????</option>
							<option value="open">??????</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><label for="pms_menu_url">??????</label></th>
					<td>
						<input id="pms_menu_url" name="pms_menu_url" value="" class="inp_text" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th><label for="pms_menu_auth">??????</label></th>
					<td>
						<input id="pms_menu_auth" name="pms_menu_auth" value="" class="inp_text" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th><label for="parent_pms_menu_idx">??????IDX</label></th>
					<td>
						<input id="parent_pms_menu_idx" name="parent_pms_menu_idx" value="" class="inp_text" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<th><label for="order_no">??????</label></th>
					<td>
						<input id="order_no" name="order_no" value="" class="inp_text" style="width:200px;"/>

					</td>
				</tr>
				<tr>
					<th><label for="deth">??????</label></th>
					<td>
						<select id="deth" name="deth" class="inp_text" style="width:100px;">
							<option value="0">??????</option>
							<option value="1">??????</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><label for="icon_no">?????????</label></th>
					<td>
						<select id="icon_no" name="icon_no" class="inp_text" style="width:100px;">
							<option value="1">??????</option>
							<option value="2">??????</option>
							<option value="3">??????</option>
							<option value="4">??????</option>
							<option value="5">??????</option>
							<option value="6">?????????</option>
							<option value="7">????????????</option>
							<option value="8">????????????</option>
							<option value="9">????????????</option>
							<option value="10">??????</option>
							<option value="11">??????</option>
							<option value="12">?????????</option>
							<option value="13">??????</option>

						</select>
					</td>
				</tr>
				<tr>
					<th><label for="deth">??????NO.1</label></th>
					<td>
						<input id="set_deth1" name="set_deth1" value="" class="inp_text" style="width:200px;"/>
					</td>
				</tr>

				<tr>
					<th><label for="deth">??????NO.2</label></th>
					<td>
						<input id="set_deth2" name="set_deth2" value="" class="inp_text" style="width:200px;"/>
					</td>
				</tr>


			</table>
			<div style="text-align:center;height:40px;line-height:40px;">
				<input class="btn_b_01" type="button" style="min-width:100px;width:100px;" id="menuInstBtn" value="??????" onclick="writeGo()"/>
				<input class="btn_b_01" type="button" style="min-width:100px;width:100px;display:none;" id="menuUptBtn"  value="??????" onclick="menuEdit()"/>
			</div>

		</div>
	</div>

</div>


