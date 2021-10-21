<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" session="false" %>
<%@page import="egovframework.com.cmm.util.EgovSessionCookieUtil"  %>
<%@page import="java.util.*"  %>
<%

EgovSessionCookieUtil cookie = new EgovSessionCookieUtil();

cookie.setCookie(response, "aaa", "bbbbb");

out.print(cookie.getCookie(request, "aaa"));

%>