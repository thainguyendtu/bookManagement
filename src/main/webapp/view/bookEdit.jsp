<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Management</title>
</head>
<body>
	<div align="center">
		<h2>UPDATE FOR: <span style="text-transform: uppercase">${book.title}</span></h2>
		<form:form action="${pageContext.request.contextPath}/book/edit/${book.id}" method="POST" modelAttribute="book">
			<table>
			<tr>
				<td>
					<form:label path="title">Title:</form:label>
				</td>
				<td>
					<form:input path="title" name="title" id="title"/>
				</td>
			</tr>
			<tr>
				<td>
					<form:label path="author">Author:</form:label>
				</td>
				<td>
					<form:input path="author" name="author" id="author"/>
				</td>
			</tr>
			<tr>
				<td>
					<form:label path="description">Description:</form:label>
				</td>
				<td>
					<form:textarea path="description" name="description" id="description"/>
				</td>
			</tr>
			<tr>
				<td>
					<form:label path="createdAt">Created at:</form:label>
				</td>
				<td>
					<input type="date" name="createdAt" id="createdAt" value="${book.createdAt}"/>
				</td>
			</tr>
			<tr>
				<td>
					<form:label path="image">Old image:</form:label>
				</td>
				<td>
					<img src="/${book.image}" alt="${book.title}"/>
				</td>
			</tr>
			<tr>
				<td>
					<form:label path="image">New image:</form:label>
				</td>
				<td>
					<input type="file"/>
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td>
					<form:button name="login" id="login">Login</form:button>
				</td>
			</tr>
		</table>
		</form:form>
	</div>
</body>
</html>