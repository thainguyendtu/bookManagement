<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Management</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<style>
	table {
		width: 80%;
	}
	
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px;
	}
	
	.number {
		width: 5%;
	}
	
	.titleLabel, .author, .createdAt, .updatedAt, .image {
		width: 10%;
	}
	
	.action {
		width: 15%;
	}
	
	a {
		text-decoration: none;
	}
	
	a:pointer {
		text-decoration: none;
	}
	
	.disabled {
		color: red;
	}
</style>
<body>
	<div align="center">
		<h2>My Book List</h2>
		<c:choose>
			<c:when test="${not empty userInfo}">
				<a href="${pageContext.request.contextPath}/logout">Log Out</a>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath}/showLogin">Log In</a>
			</c:otherwise>
		</c:choose>
		<br>
		<div class="message" style="text-align: center">
		<br>
		</div>
		<label>Title</label>: <input type="text" id="title"/>&nbsp;
		<label>Author</label>: <input type="text" id="author"/>&nbsp;<button id="search">Search</button><br><br>
		<table>
			<thead>
				<tr>
					<th class="number">No.</th>
					<th class="titleLabel">Title <a href="javascript:void(0)" id="titleAsc">/\</a> </th>
					<th class="author">Author <a href="javascript:void(0)" id="authorAsc">/\</a></th>
					<th class="description">Description</th>
					<th class="createdAt">Created at <a href="javascript:void(0)" id="createdAtAsc">/\</a></th>
					<th class="updatedAt">Updated at <a href="javascript:void(0)" id="updatedAtAsc">/\</a></th>
					<th class="image">Image</th>
					<c:if test="${not empty userInfo}">
						<th class="action">Action</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${bookList}" varStatus="loop" >
					<tr class="row" ${(loop.index + 1) % 2 == 0 ? '' : 'style="background: #E3E3ED"'}>
						<td style="text-align: center">${loop.index + 1}</td>
						<td class="title"><a href="${pageContext.request.contextPath}/book/detail/${book.id}">${book.title}</a></td>
						<td>${book.author}</td>
						<td>${book.description}</td>
						<td style="text-align: center">${book.createdAt}</td>
						<td style="text-align: center">${book.updatedAt}</td>
						<td><img src="${pageContext.request.contextPath}/${book.image}" alt="${book.title}" width="70px" height="70px"/></td>
						<c:if test="${not empty userInfo}">
							<td>
								<a href="javascript:void(0)" class="${book.enabled == true ? 'enabled' : 'disabled'}" id="${book.id}">
									<c:choose>
										<c:when test="${book.enabled == true}">Enabled</c:when>
										<c:otherwise>Disabled</c:otherwise>
									</c:choose>
								</a>&nbsp;
								<a href="${pageContext.request.contextPath}/book/showEdit/${book.id}">Edit</a>&nbsp;
								<a href="javascript:void(0)" class="remove" id="${book.id}">Remove</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$(".remove").on('click', function() {
			var name = $(this).closest("tr").find(".title").find("a").text();
			var check = confirm('Are you sure to remove "' + name + '" from favorite book?');
			if (check == true) {
				removeBook(this);
			}
		});
		
		$(".enabled, .disabled").on('click', function() {
			setStatus(this);
		});
		
		$("#titleAsc, #titleDesc").on('click', function() {
			if($(this).text() == '/\\') {
				$(this).attr('id','titleDesc');
				$(this).text('\\/');
				arrangeBook('title', true);
			} else {
				$(this).attr('id','titleAsc');
				$(this).text('/\\');
				arrangeBook('title', false);
			}
		});
		
		$("#authorAsc, #authorDesc").on('click', function() {
			if($(this).text() == '/\\') {
				$(this).attr('id','authorDesc');
				$(this).text('\\/');
				arrangeBook('author', true);
			} else {
				$(this).attr('id','authorAsc');
				$(this).text('/\\');
				arrangeBook('author', false);
			}
		});
		
		$("#createdAtAsc, #createdAtDesc").on('click', function() {
			if($(this).text() == '/\\') {
				$(this).attr('id','createdAtDesc');
				$(this).text('\\/');
				arrangeBook('created_at', true);
			} else {
				$(this).attr('id','createdAtAsc');
				$(this).text('/\\');
				arrangeBook('created_at', false);
			}
		});
		
		$("#updatedAtAsc, #updatedAtDesc").on('click', function() {
			if($(this).text() == '/\\') {
				$(this).attr('id','updatedAtDesc');
				$(this).text('\\/');
				arrangeBook('updated_at', true);
			} else {
				$(this).attr('id','updatedAtAsc');
				$(this).text('/\\');
				arrangeBook('updated_at', false);
			}
		});
		
		$("#search").on('click', function() {
			searchBook();
		});
	
	});
	
	function removeBook(obj) {
		var id = $(obj).attr("id");
		var name = $(obj).closest("tr").find(".name").find("a").text();

		$.ajax({
			url : "${pageContext.request.contextPath}/book/deleteFromFavoriteBooks/" + id,
			type: 'GET',
			dataType: 'html',
			contentType :"application/json",
			success : function(data) {
				var response = JSON.parse(data);
				
				$("tbody").empty();
				for (var i = 0; i < response.length; i++) {
					$("tbody").append('<tr ' + (i % 2 == 0 ? 'style="background: #E3E3ED"' : '') + '>'
							+ '<td style="text-align: center">' + (i + 1) + '</td>'
							+ '<td class="title"><a href="${pageContext.request.contextPath}/book/detail/' + response[i].id + '">' + response[i].title + '</a></td>'
							+ '<td>' + response[i].author + '</td>'
							+ '<td>' + response[i].description + '</td>'
							+ '<td style="text-align: center">' + response[i].createdAt + '</td>'
							+ '<td style="text-align: center">' + response[i].updatedAt + '</td>'
							+ '<td><img src="${pageContext.request.contextPath}/' + response[i].image + '" alt="' + response[i].title + '" width="70px" height="70px"/></td>'
							+ '<c:if test="${not empty userInfo}">'
							+ '	<td>'
							+ '		<a href="javascript:void(0)" class="' + (response[i].enabled == true ? 'enabled' : 'disabled') + '" id="' + response[i].id + '">'
							+ (response[i].enabled == true ? 'Enabled' : 'Disabled')
							+ '</a>&nbsp;'
							+ '		<a href="${pageContext.request.contextPath}/book/showEdit/' + response[i].id + '">Edit</a>&nbsp;'
							+ '		<a href="javascript:void(0)" class="remove" id="' + response[i].id + '">Remove</a>'
							+ '	</td>'
							+ '</c:if>'
							+ '</tr>');
				}
				
				$(".enabled, .disabled").on('click', function() {
					setStatus(this);
				});
				
				$(".message").append("<span style='color: blue'>Remove <b>" + name + "</b> successed!</span>");
				setTimeout(function(){
					$(".message").empty();
				}, 5000);
			},
			error: function(error) {
			    console.log(error)
			}
		});
	}
	
	function searchBook() {
		var title = $("#title").val();
		var author = $("#author").val();
		
		var searchDTO = {
				"title": title,
				"author": author
			};

		$.ajax({
			url : "${pageContext.request.contextPath}/book/search",
			type: 'POST',
			data: JSON.stringify(searchDTO),
			dataType: 'json',
			contentType :"application/json; charset=UTF-8",
			success : function(data) {
				var response = JSON.parse(data);
				
				$("tbody").empty();
				for (var i = 0; i < response.length; i++) {
					$("tbody").append('<tr ' + (i % 2 == 0 ? 'style="background: #E3E3ED"' : '') + '>'
							+ '<td style="text-align: center">' + (i + 1) + '</td>'
							+ '<td class="title"><a href="${pageContext.request.contextPath}/book/detail/' + response[i].id + '">' + response[i].title + '</a></td>'
							+ '<td>' + response[i].author + '</td>'
							+ '<td>' + response[i].description + '</td>'
							+ '<td style="text-align: center">' + response[i].createdAt + '</td>'
							+ '<td style="text-align: center">' + response[i].updatedAt + '</td>'
							+ '<td><img src="${pageContext.request.contextPath}/' + response[i].image + '" alt="' + response[i].title + '" width="70px" height="70px"/></td>'
							+ '<c:if test="${not empty userInfo}">'
							+ '	<td>'
							+ '		<a href="javascript:void(0)" class="' + (response[i].enabled == true ? 'enabled' : 'disabled') + '" id="' + response[i].id + '">'
							+ (response[i].enabled == true ? 'Enabled' : 'Disabled')
							+ '</a>&nbsp;'
							+ '		<a href="${pageContext.request.contextPath}/book/showEdit/' + response[i].id + '">Edit</a>&nbsp;'
							+ '		<a href="javascript:void(0)" class="remove" id="' + response[i].id + '">Remove</a>'
							+ '	</td>'
							+ '</c:if>'
							+ '</tr>');
				}
				
				$(".remove").on('click', function() {
					var name = $(this).closest("tr").find(".title").find("a").text();
					var check = confirm('Are you sure to remove "' + name + '" from favorite books?');
					if (check == true) {
						deleteBook(this);
					}
				});
				
				$(".enabled, .disabled").on('click', function() {
					setStatus(this);
				});
				
			},
			error: function(error) {
			    console.log(error)
			}
		});
	}
	
	function setStatus(obj) {
		var id = $(obj).attr("id");

		$.ajax({
			url : "${pageContext.request.contextPath}/book/setStatus/" + id,
			type: 'GET',
			dataType: 'html',
			async: false,
			contentType :"application/json",
			success : function(data) {
				if ($(obj).attr('class') == 'enabled') {
					$(obj).text('Disabled');
					$(obj).attr('class','disabled');
				} else {
					$(obj).text('Enabled');
					$(obj).attr('class','enabled');
				}
			},
			error: function(error) {
			    console.log(error)
			}
		});
	}
	
	function arrangeBook(field, asc) {
		$.ajax({
			url : "${pageContext.request.contextPath}/book/arrangeFavoriteBook/" + field + "/" + asc + "",
			type: 'GET',
			dataType: 'html',
			async: false,
			contentType :"application/json; charser=UTF-8",
			success : function(data) {
				var response = JSON.parse(data);
				
				$("tbody").empty();
				for (var i = 0; i < response.length; i++) {
					$("tbody").append('<tr ' + (i % 2 == 0 ? 'style="background: #E3E3ED"' : '') + '>'
							+ '<td style="text-align: center">' + (i + 1) + '</td>'
							+ '<td class="title"><a href="${pageContext.request.contextPath}/book/detail/' + response[i].id + '">' + response[i].title + '</a></td>'
							+ '<td>' + response[i].author + '</td>'
							+ '<td>' + response[i].description + '</td>'
							+ '<td style="text-align: center">' + response[i].createdAt + '</td>'
							+ '<td style="text-align: center">' + response[i].updatedAt + '</td>'
							+ '<td><img src="${pageContext.request.contextPath}/' + response[i].image + '" alt="' + response[i].title + '" width="70px" height="70px"/></td>'
							+ '<c:if test="${not empty userInfo}">'
							+ '	<td>'
							+ '		<a href="javascript:void(0)" class="' + (response[i].enabled == true ? 'enabled' : 'disabled') + '" id="' + response[i].id + '">'
							+ (response[i].enabled == true ? 'Enabled' : 'Disabled')
							+ '</a>&nbsp;'
							+ '		<a href="${pageContext.request.contextPath}/book/showEdit/' + response[i].id + '">Edit</a>&nbsp;'
							+ '		<a href="javascript:void(0)" class="remove" id="' + response[i].id + '">Remove</a>'
							+ '	</td>'
							+ '</c:if>'
							+ '</tr>');
				}
				
				$(".remove").on('click', function() {
					var name = $(this).closest("tr").find(".title").find("a").text();
					var check = confirm('Are you sure to remove "' + name + '"?');
					if (check == true) {
						deleteBook(this);
					}
				});
				
				$(".enabled, .disabled").on('click', function() {
					setStatus(this);
				});
			},
			error: function(error) {
			    console.log(error)
			}
		});
	}
	
</script>
</html>