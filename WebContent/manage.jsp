<%@page import="pageofliuxl.ContentStorage"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manage page</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String title = "";
		String content = "";
		if (id != null && !id.equals("")) {
			JSONObject jsonObject = ContentStorage.instance.read(id);
			title = jsonObject.getString("title");
			content = jsonObject.getString("content");
		}
		
	%>
	<input id="titleInput" type= "text" value="<%= title%>"></input>
	<textarea id="contentTextArea" class="ckeditor"><%=content%></textarea>
	<script type="text/JavaScript">
		CKEDITOR.replace('contentTextArea');
	</script>
	<button class="button" id="submitButton" onclick="submitIntoDB()">submit</button>
	<script type="text/JavaScript" src="ckeditor/ckeditor.js"></script>
	<script src="script/jquery.js"></script>
	<script src="script/manage.js"></script>
</body>
</html>
<%
	String flag = request.getParameter("flag");
	if (flag != null && flag.equals("true")) {
		title = request.getParameter("title");
		content = request.getParameter("content");
		if (id == null) {
			ContentStorage.instance.save(title, content);
		} else {
			ContentStorage.instance.save(id, title, content);
		}
	}
%>