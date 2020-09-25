<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Management</title>
</head>
<body>
	<div align="center">
		<h2 style="text-transform: uppercase">${book.title}</h2>
		<h4>Author: ${book.author}</h4>
		<h4>Created at: ${book.createdAt}</h4>
		<h4>Updated at: ${book.updatedAt}</h4>
		<h4>Description: </h4>
		<p>${book.description}</p>
		<h4>Image:</h4>
		<img alt="${book.title}" src="/${book.image}"/>
	</div>
</body>
</html>