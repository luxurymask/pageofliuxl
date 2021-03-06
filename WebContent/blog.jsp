<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="pageofliuxl.MessageStorage"%>
<%@page import="pageofliuxl.PVCounter"%>
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

#main_bio {
	
}

#main_avatar {
	width: 100px;
	height: 100px;
	border-radius: 50%;
}
</style>
</head>
<body>
	<%
		String clientIP = request.getRemoteAddr();
		long timestamp = System.currentTimeMillis();
		String pageURL = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()
				+ request.getServletPath();
		PVCounter.instance.setPV(clientIP, pageURL, timestamp);
	%>
	<p>
	<div align="center">
		<img id="main_avatar" alt="liuxl"
			src="imgs/avatar.jpg">
	</div>
	</p>
	<div align="center">
		<h1
			style="margin: 0.0px 0.0px 16.1px 0.0px; line-height: 28.0px; font: 24.0px Times; color: #000000; -webkit-text-stroke: #000000">
			<span id="main_title"><b>Liuxl's Blog</b></span>
			<p></p>
			<span id="main_bio">他们没有砍过一棵正在生长的树, 孩子们也没有摘过一朵正在盛开的花。</span>
		</h1>
	</div>
	<div align="center">
		<p></p>
		<%
			long visitTimestamp = System.currentTimeMillis();
		%>
		<%
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				String id = jsonObject.getString("id");
				String title = jsonObject.getString("title");
				String content = jsonObject.getString("content");
				String time = jsonObject.getString("time");
		%>
		<div align="left">
			<p>
				<b class="article_title"><%=title%></b>
			</p>
			<p>
				<b><%=id%></b> | <b><%=time%></b>
			</p>
			<p><%=content%></p>
			<p></p>
			<p>-------------------------------------------------------------------------------------</p>
			<p></p>
		</div>
		<%
			}
		%>
	</div>
	<div>
		<input id="messageTitle" type= "text" style="width:30%; height:30px;"></input>
		<button class="button" id="messageButton" onclick="leaveMessage()" style="height:30px;">leave a message</button>
		<p></p>
		<textarea id="messageContent" style="width:70%; height:100px; resize:none;"></textarea>
	</div>
	<script src="script/jquery.js"></script>
	<script src="script/blog.js"></script>
</body>
</html>
<%
	String flag = request.getParameter("flag");
	if (flag != null && flag.equals("true")) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		MessageStorage.instance.save(clientIP, title, content, false);
	}
%>