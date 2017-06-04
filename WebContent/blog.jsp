<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Map<String, String> map = ContentStorage.instance.readAll();
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
</style>
</head>
<body>
	<h1
		style="margin: 0.0px 0.0px 16.1px 0.0px; line-height: 28.0px; font: 24.0px Times; color: #000000; -webkit-text-stroke: #000000">
		<span class="s1"><b>Liuxl's Blog</b></span>
	</h1>
	<p></p>
	<%
		for(Map.Entry<String, String> entry : map.entrySet()){
			String title = entry.getKey();
			String content = entry.getValue();
	%>
		<p><b><%=title %></b></p>
		<p><%=content %></p>
		<p></p>
	<%
		}
	%>
</body>
</html>