<%@page import="pageofliuxl.ContentStorage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String content = request.getParameter("content");
	ContentStorage.instance.save("liuxl", content);
	System.out.print(content);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manage page</title>
</head>
<body>
	<textarea id="textArea"></textarea>
	<button class="button" id="submitButton" onclick="submitIntoDB()">submit</button>
	<script src="script/jquery.js"></script>
	<script src="script/manage.js"></script>
</body>
</html>