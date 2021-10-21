<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.site.service.*" %>
<%@ page import="egovframework.jammy2.board.service.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%
	SiteMenuVO siteMenuVO = (SiteMenuVO)request.getAttribute("SITE_MENU");
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	
	String boardUrl = (String)request.getAttribute("javax.servlet.forward.request_uri");
		
	String device = (String)request.getAttribute("DEVICE");
	String skinNm = ("MOBILE".equals(device)) ? boardVO.getMobileSkinNm() : boardVO.getSkinNm();

	ArrayList cssList = new ArrayList();
	cssList.add("/modules/board/skins/"+skinNm+"/style.css");
	cssList.add("/modules/board/css/"+boardVO.getBoardId()+".css");

	ArrayList jsList = new ArrayList();
	jsList.add("/modules/board/js/board.js");

	request.setAttribute("boardUrl", boardUrl);	
	request.setAttribute("cssList", cssList);
	request.setAttribute("jsList", jsList);
%>
<jsp:include page="/core/view/site.jsp" flush="false" />