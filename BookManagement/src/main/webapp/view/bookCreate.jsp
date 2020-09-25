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
		<h2>ADD NEW BOOK</h2>
		<form:form action="${pageContext.request.contextPath}/book/add" method="POST" modelAttribute="book">
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
					<form:button name="add" id="add">Add</form:button>
				</td>
			</tr>
		</table>
		</form:form>
	</div>
</body>
</html>