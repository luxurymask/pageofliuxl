<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	JSONArray jsonArray = ContentStorage.instance.readAll();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Style-Type" content="text/css">
<link rel="Shortcut Icon" href="logo.png" />
<title>liuxl's blog</title>
<meta name="Generator" content="Cocoa HTML Writer">
<meta name="CocoaVersion" content="1504.82">
<style type="text/css">
p.p2 {
	margin: 0.0px 0.0px 12.0px 0.0px;
	line-height: 14.0px;
	font: 12.0px Times;
	color: #000000;
	-webkit-text-stroke: #000000
}

p.p4 {
	margin: 0.0px 0.0px 12.0px 0.0px;
	line-height: 14.0px;
	font: 12.0px Times;
	color: #000000;
	-webkit-text-stroke: #000000;
	min-height: 14.0px
}

span.s1 {
	font-kerning: none
}

span.s2 {
	font: 12.0px 'Songti SC';
	font-kerning: none
}

#main_avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
}
</style>
</head>
<body>
	<p><div align="center"><img id="main_avatar" alt="liuxl" src="http://localhost:8080/pageofliuxl/imgs/avatar.jpg"></div></p>
	<div align="center"><h1
		style="margin: 0.0px 0.0px 16.1px 0.0px; line-height: 28.0px; font: 24.0px Times; color: #000000; -webkit-text-stroke: #000000">
		<span id="main_title"><b>Liuxl's Blog</b></span>
	</h1></div>
	<p></p>
	<%
		for(int i = 0;i < jsonArray.length();i++){
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			String id = jsonObject.getString("id");
			String title = jsonObject.getString("title");
			String content = jsonObject.getString("content");
			String time = jsonObject.getString("time");
	%>
		<p><b class="article_title"><%=title %></b></p>
		<p><b><%=id %></b> | <b><%=time %></b></p>
		<p><%=content %></p>
		<p></p>
		<p>-------------------------------------------------------------------------------------</p>
		<p></p>
	<%
		}
	%>
</body>
</html>