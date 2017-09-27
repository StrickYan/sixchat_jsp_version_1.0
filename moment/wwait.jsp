<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<style>
			body{
				background-color: #f2f2f5;
				font-family: montserrat, arial, verdana;
				color:gray;
			}
			h3,h4{
				text-align:center;			
			}
			h3 {
				margin-top:10%;
			}
			a {
				color:blue;
				text-decoration : none;
			}
		</style>
	</head>
	<body>
		<h3>注册成功，正在返回登录界面...</h3>
		<h4>如没有跳转,请点击<a href="wlogin.jsp">这里</a></h4>
		<%
			response.setHeader("refresh", "2;url=wlogin.jsp");
		%>
	</body>
</html>