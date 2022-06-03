<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<!-- USO DI DIRETTIVA include -->
<!-- ESEMPIO DI Inclusione di file che sono nella stessa cartella relativi alla JSP page-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home Page</title>
</head>
<body>
     
    <%@include file="header.html" %>
     
    <hr/>
    <h2>This is main content</h2>
    <hr/>
     
    <%@include file="footer.html" %>
     
</body>
</html>