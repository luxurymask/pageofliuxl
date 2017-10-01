<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="pageofliuxl.MessageStorage"%>
<%@page import="pageofliuxl.PVCounter"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String title = "";
	String content = "";
	String time = "";
	String ip = "";
	if (id != null && !id.equals("")) {
		JSONObject jsonObject = MessageStorage.instance.read(id);
		ip = jsonObject.getString("ip");
		title = jsonObject.getString("title");
		content = jsonObject.getString("content");
		time = jsonObject.getString("time");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div><b><%= title%></b></div>
		<p></p>
		<div><b><%= ip%></b> | <b><%= time%></b></div>
		<p></p>
		<div><%= content%></div>
	</div>
</body>
</html>