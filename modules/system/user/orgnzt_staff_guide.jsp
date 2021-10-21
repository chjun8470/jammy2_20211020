<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.site.service.SiteManager" %>
<%@ page import="egovframework.jammy2.system.orgnzt.service.*" %>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
SiteManager siteManager = new SiteManager(request);

String rootOrgnztId = "ORGNZT_0000000000002";
String searchOrgnztId = EgovStringUtil.nullConvert(request.getParameter("orgnztId"));
if ("".equals(searchOrgnztId)) {
	searchOrgnztId = "ORGNZT_0000000000003";
}

List<OrgnztVO> orgnztList = (List)siteManager.getOrgnztList(rootOrgnztId);
OrgnztVO orgnztVO = (OrgnztVO)siteManager.getOrgnztInfo(searchOrgnztId);

List<OrgnztStaffVO> orgnztStaffList = (List)siteManager.getOrgnztStaffListByOrgnzt(orgnztVO.getOrgnztId(), orgnztVO.getLft(), orgnztVO.getRgt());
LinkedHashMap<String, ArrayList> orgnztStaffListTree = new LinkedHashMap<String, ArrayList>();
if (orgnztStaffList != null && orgnztStaffList.size() > 0) {
	for (int i = 0; i < orgnztStaffList.size(); i++) {
		OrgnztStaffVO tmpVO = (OrgnztStaffVO)orgnztStaffList.get(i);
		ArrayList<OrgnztStaffVO> ar = null;
		if (!orgnztStaffListTree.containsKey(tmpVO.getOrgnztNm())) {
			ar = new ArrayList<OrgnztStaffVO>();			
		} else {
			ar = orgnztStaffListTree.get(tmpVO.getOrgnztNm());
		}
		ar.add(tmpVO);		
		orgnztStaffListTree.put(tmpVO.getOrgnztNm(), ar);
	}
}

request.setAttribute("searchOrgnztId", searchOrgnztId);
request.setAttribute("orgnztList", orgnztList);
request.setAttribute("orgnztVO", orgnztVO);
request.setAttribute("orgnztStaffListTree", orgnztStaffListTree);
%>

<div class="tab-type1">
	<ul class="nav nav-pills">
	<c:forEach var="result" items="${orgnztList}" varStatus="status">
		<c:if test="${result.level == orgnztVO.level}">
		<li<c:if test="${searchOrgnztId == result.orgnztId}"> class="active"</c:if>><span><a href="?orgnztId=<c:out value='${result.orgnztId}'/>"><c:out value="${result.orgnztNm}"/></a></span></li>
		</c:if>
	</c:forEach>
	</ul>
</div>

<h4><c:out value="${orgnztVO.orgnztNm}"/></h4>

<div class="orgnzt-staff">
<c:forEach var="result" items="${orgnztStaffListTree}" varStatus="status">	
	<h5 class="orgnzt_nm">${result.key}</h5>
	<div class="staff-item">
		<ul>
		<c:forEach var="staff" items="${result.value}">
			<li>				
				<div class="clearfix">
					<div class="col-sm-6 item-left">
						<div class="photo">
							<img src="<c:url value='/${staff.photoFileNm}'/>" width="60" alt="" />
						</div>
						<dl>
							<dt>성명/직위</dt>
							<dd>
								<c:out value="${staff.name}"/>
								<c:if test="${not empty staff.rank}"> / <c:out value="${staff.rank}"/></c:if>
							</dd>
							<dt>E-mail</dt>
							<dd><c:out value="${staff.email}"/></dd>
							<dt>Tel</dt>
							<dd><c:out value="${staff.telNo}"/></dd>
						</dl>
					</div>
					<div class="col-sm-6 item-right">
						<c:out value="${jmy:nl2br(staff.asgnedArea)}" escapeXml="false" />
					</div>
				</div>
			</li>
		</c:forEach>
		</ul>
	</div>
</c:forEach>
</div>