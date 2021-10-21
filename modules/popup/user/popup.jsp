<%@ page language="java" contentType="javascript" %>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.popup.service.PopupManager" %>
<%@ page import="egovframework.jammy2.popup.service.PopupVO" %>

<%	
	PopupManager pm = new PopupManager(request);

	String siteId = (String)request.getAttribute("siteId");
	List<PopupVO> popupList = pm.getPopupList(siteId, "WINDOW");
%>

<% 
if (popupList != null && popupList.size() > 0) 
{
	PopupVO vo = new PopupVO();
	for (int i = 0; i < popupList.size(); i++)
	{
		vo = (PopupVO)popupList.get(i);		
%>
if (getCookie("popview").indexOf("['<%=siteId%>_<%=vo.getPopupId()%>']") == -1) {
	window.open("/<%=siteId%>/popup/detail.do?popupId=<%=vo.getPopupId()%>", "<%=vo.getPopupId()%>", "left=<%=vo.getPopupLeft()%>, top=<%=vo.getPopupTop()%>, width=<%=vo.getPopupWidth()%>, height=<%=vo.getPopupHeight()+30%>, scrollbars=<%=vo.getScrollAt()%>");
}
<%
	}
}
%>