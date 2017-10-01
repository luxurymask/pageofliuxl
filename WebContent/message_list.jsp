<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="pageofliuxl.MessageStorage"%>
<%@page import="pageofliuxl.PVCounter"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	JSONArray jsonArray = MessageStorage.instance.readAll();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<p></p>
		<%
			long visitTimestamp = System.currentTimeMillis();
		%>
		<%
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				String id = jsonObject.getString("id");
				String ip = jsonObject.getString("ip");
				String title = jsonObject.getString("title");
				String time = jsonObject.getString("time");
		%>
		<div align="left">
			<p>
				<a href="message.jsp?id=<%= id%>"><b class="article_title"><%=title%></b> | <b><%=ip%></b> | <b><%=time%></b></a>
			</p>
		</div>
		<%
			}
		%>
	</div>
</body>
</html>