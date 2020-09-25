<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div align="center">
	<h2>LOGIN</h2>
	<c:if test="${param['errorIncorrect']}"><span style="font-style: italic; color: red">Incorrect Username or Password!</span></c:if>
	<c:if test="${param['errorEmpty']}"><span style="font-style: italic; color: red">Please fill full information!</span></c:if>
	<label id="errorEmpty" style="font-style: italic; color: red"></label>
	<form:form action="login" method="POST" modelAttribute="userLogin">
		<table>
			<tr>
				<td>
					<form:label path="email">Email</form:label>
				</td>
				<td>
					<form:input path="email" name="email" id="email"/>
				</td>
			</tr>
			<tr>
				<td>
					<form:label path="password">Password</form:label>
				</td>
				<td>
					<form:input path="password" name="password" id="password"/>
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
	<br/>
	<c:url var="getAllBooks" value="book/getAllBooks"></c:url>
	<a href="<c:out value="${getAllBooks}"/>">Login as Guest</a>
</div>
</body>
<script type="text/javascript">
// 	$(document).ready(function() {
// 		$("#login").on('click', function () {
// 			var email = $("#email").val();
// 			var password = $("#password").val();
			
// 			if (email == null || email == '' || password == null || password == '') {
// 				$("#errorEmpty").empty();
// 				$("#errorEmpty").append('Vui lòng điền đầy đủ Email và Password');
// 			} else {
// 				$.ajax({
// 					  type: "POST",
// 					  url: '${contextPath}/login',
// 					  data: {
// 						  email: email,
// 						  password: password
// 					  },
// 					  dataType: 'html',
// 					  success: function() {
// 						console.log('success');
// 						}
// 					});
// 			}
// 		});
// 	});
</script>
</html>