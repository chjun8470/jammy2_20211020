<%@ page contentType="text/csv" %>

<%
    response.setCharacterEncoding("EUC-KR"); // set to client(windows) native charset.
    response.setHeader("Content-Disposition", "attachment; filename=aireport.csv");

    request.setCharacterEncoding("UTF-8");
    out.print(request.getParameter("data"));
    out.close();
%>
