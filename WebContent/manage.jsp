<%@page import="pageofliuxl.ContentStorage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manage page</title>
</head>
<body>
	<input id="titleInput"></input>
	<textarea id="contentTextArea" class="ckeditor"></textarea>
	<script type="text/JavaScript">CKEDITOR.replace('contentTextArea');</script>
	<button class="button" id="submitButton" onclick="submitIntoDB()">submit</button>
	<script type="text/JavaScript" src="ckeditor/ckeditor.js"></script>
	<script src="script/jquery.js"></script>
	<script src="script/manage.js"></script>
</body>
</html>

<%
	String flag = request.getParameter("flag");
	if(flag != null && flag.equals("true")){
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		ContentStorage.instance.save(title, content);
	}
%>