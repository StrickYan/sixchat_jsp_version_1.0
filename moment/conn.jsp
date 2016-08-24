<%@ page language="java" import="java.sql.*" pageEncoding="utf-8" %>
<% 
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","username","password");
%>