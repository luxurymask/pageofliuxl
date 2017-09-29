<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	JSONArray jsonArray = ContentStorage.instance.readAll();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<button class="button" id="newBlogButton" onclick="window.location.href='manage.jsp';">new blog</button>
	<%
		for(int i = 0;i < jsonArray.length();i++){
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			String id = jsonObject.getString("id");
			String title = jsonObject.getString("title");
			String content = jsonObject.getString("content");
			String time = jsonObject.getString("time");
	%>
		<p><a href="manage.jsp?id=<%= id%>"><b class="article_title"><%=title %></b> | <b><%=time %></b></a></p>
		<p></p>
	<%
		}
	%>
</body>
</html>