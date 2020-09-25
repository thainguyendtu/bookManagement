<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Management</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<style>
	a {
		text-decoration: none;
	}
</style>
<body>
	<div align="center">
		<h2 style="text-transform: uppercase">${book.title}</h2>
		<h4>Author: ${book.author}</h4>
		<h4>Created at: ${book.createdAt}</h4>
		<h4>Updated at: ${book.updatedAt}</h4>
		<h4>Description: </h4>
		<p>${book.description}</p>
		<h4>Image:</h4>
		<img alt="${pageContext.request.contextPath}/${book.title}" src="/${book.image}"/>
		<br>
		<c:if test="${checkFavorite == true}">
			<div class="favorite">
				<a href="javascript:void(0)" id="addToFavoriteBooks" class="${book.id}">Add to My Book List</a>
				<span class="message" style="color: blue"></span>
			</div>
		</c:if>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function () {
		$("#addToFavoriteBooks").on('click', function () {
			var id = $(this).attr('class');

			$.ajax({
				url : "${pageContext.request.contextPath}/book/addToFavoriteBooks/" + id,
				type: 'GET',
				dataType: 'html',
				async: false,
				contentType :"application/json",
				success : function(data) {
					$(".favorite").empty();
					$(".favorite").append('<span class="message" style="color: blue">Add to Favorite Books Successed!</span>')
				},
				error: function(error) {
				    console.log(error)
				}
			});
		});
	});
</script>
</html>