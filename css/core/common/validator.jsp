<%@ page language="java" contentType="javascript" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
document.write('<script type="text/javascript" src="<c:url value='/core/js/jquery-validation/jquery.validate.js'/>"></script>');
document.write('<script type="text/javascript" src="<c:url value='/core/js/jquery-validation/jquery-validate.bootstrap-tooltip.js'/>"></script>');
document.write('<script type="text/javascript" src="<c:url value='/core/js/jquery-validation/localization/messages_${lang}.min.js'/>"></script>');    