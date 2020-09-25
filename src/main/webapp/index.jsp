<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Management</title>
</head>
<body>
<div align="center">
	<h2>WELCOME TO BOOK MANAGEMENT</h2>
	<c:url var="login" value="showLogin"></c:url>
	
	<a href="<c:out value="${login}"/>">Go to Login page</a>
</div>
</body>
</html>