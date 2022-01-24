<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.MenuVO"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<%
	request.setCharacterEncoding("UTF-8");

	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
	LoginVO loginVO = util.getLoginInfo(request); //세션정보 가져오기

	String menuPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> nowMenu = request.getAttribute("nowMenu") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("nowMenu");
	
	ArrayList<HashMap<String, String>> dataMenuList = request.getAttribute("dataMenuList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMenuList");
	
	//해당 사용자 기관 관리자 정보 출력용 맵
	HashMap<String,String> orgInfoMap = request.getAttribute("orgInfoMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("orgInfoMap");
	
	String tmenu = util.getStr(nowMenu.get("PMS_TMENU")).equals("") ? util.getStr(paramMap.get("tmenu")) : util.getStr(nowMenu.get("PMS_TMENU"));
	if("".equals(tmenu)){tmenu = "2";}

	ArrayList menuArr1 = new ArrayList(); //메뉴_Arr
	ArrayList menuArr2 = new ArrayList(); //메뉴Sub_Arr

	HashMap menuMap1 = new HashMap(); //메뉴_Map
	HashMap menuMap2 = new HashMap(); //메뉴Sub_Map

	ArrayList menuTitleArr = new ArrayList(); //메뉴타이틀_Arr
	HashMap menuTitleMap = new HashMap(); //메뉴타이틀_Map

	String parentTitle = "";



	for(int i=0; i<dataMenuList.size(); i++){

		HashMap  menuRs = dataMenuList.get(i);

		if(!util.getStr(menuRs.get("PMS_TMENU")).equals(tmenu) || menuRs.get("DETH").equals("1")){
			continue;
		}

		menuMap1 = new HashMap();
		menuArr2 = new ArrayList();

		menuMap1.put("tmenu", util.getStr(menuRs.get("PMS_TMENU")));
		menuMap1.put("idx", util.getStr(menuRs.get("PMS_MENU_IDX")));
		menuMap1.put("parentIdx", util.getStr(menuRs.get("PARENT_PMS_MENU_IDX")));
		menuMap1.put("deth", util.getStr(menuRs.get("DETH")));
		menuMap1.put("setDeth1", util.getStr(menuRs.get("SET_DETH1")));
		menuMap1.put("setDeth2", util.getStr(menuRs.get("SET_DETH2")));
		menuMap1.put("name", util.getStr(menuRs.get("PMS_MENU_NAME")));
		menuMap1.put("type", util.getStr(menuRs.get("PMS_MENU_TYPE")));
		menuMap1.put("url", util.getStr(menuRs.get("PMS_MENU_URL")));
		menuMap1.put("auth", util.getStr(menuRs.get("PMS_MENU_AUTH")));
		menuMap1.put("iconNo", util.getStr(menuRs.get("ICON_NO")));
		menuMap1.put("use", util.getStr(menuRs.get("USEY")));

		for(int j=0; j<dataMenuList.size(); j++){

			HashMap  menuSubRs = dataMenuList.get(j);
			if(menuSubRs.get("DETH").equals("0") || !util.getStr(menuSubRs.get("PMS_TMENU")).equals(tmenu)){
				continue;
			}

			if(menuSubRs.get("SET_DETH1").equals(menuRs.get("SET_DETH1")) && menuSubRs.get("DETH").equals("1") ){
				menuMap2 = new HashMap();
				menuMap2.put("tmenu", util.getStr(menuSubRs.get("PMS_TMENU")));
				menuMap2.put("idx", util.getStr(menuSubRs.get("PMS_MENU_IDX")));
				menuMap2.put("parentIdx", util.getStr(menuSubRs.get("PARENT_PMS_MENU_IDX")));
				menuMap2.put("deth", util.getStr(menuSubRs.get("DETH")));
				menuMap2.put("setDeth1", util.getStr(menuSubRs.get("SET_DETH1")));
				menuMap2.put("setDeth2", util.getStr(menuSubRs.get("SET_DETH2")));
				menuMap2.put("name", util.getStr(menuSubRs.get("PMS_MENU_NAME")));
				menuMap2.put("type", util.getStr(menuSubRs.get("PMS_MENU_TYPE")));
				menuMap2.put("url", util.getStr(menuSubRs.get("PMS_MENU_URL")));
				menuMap2.put("auth", util.getStr(menuSubRs.get("PMS_MENU_AUTH")));
				menuMap2.put("iconNo", util.getStr(menuSubRs.get("ICON_NO")));
				menuMap2.put("use", util.getStr(menuSubRs.get("USEY")));

				menuArr2.add(menuMap2);
			}
		}

		menuMap1.put("data",menuArr2);
		menuArr1.add(menuMap1);

		if(menuRs.get("SET_DETH1").equals(nowMenu.get("SET_DETH1")) && menuRs.get("DETH").equals("0")){
			parentTitle = util.getStr(menuRs.get("PMS_MENU_NAME"));
		}

	}

%>

<%@include file="/back/_item/basic/i_header.jsp" %>

<div id="wrap">

	<div id="header">dddddddddd
		<%@include file="/back/_item/basic/i_top.jsp" %>
	</div>
	<div id="container">

		<%@include file="/back/_item/basic/i_left.jsp" %>

		<div class="contents">
			<%@include file="/back/_item/basic/i_localbar.jsp" %>
			<div class="contents_box">
