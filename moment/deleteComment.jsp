<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
	<head>
		<meta charset="utf-8">
	</head>
	<body>		
		<%@include file="conn.jsp"%>
		<%
			request.setCharacterEncoding("UTF-8");	
			String str=request.getParameter("num");
			int num=Integer.parseInt(str);
			/*
			String url=request.getParameter("url"); 
			String username=request.getParameter("username");
			if(username!=null)
				username = URLEncoder.encode(username,"utf-8");		//解决response.sendRedirect()中文参数乱码
			*/
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");
			
			//通过修改数据库变量隐藏数据达到虚拟删除的效果		
			String sq1="update WComment set state=0 where No=?";
			PreparedStatement ps1=conn.prepareStatement(sq1);
			ps1.setInt(1,num);
			ps1.executeUpdate();
			ps1.close();
			conn.close();
			/*
			if (username!=null)
				response.sendRedirect(url+"&username="+username);
			else
				response.sendRedirect(url);
			*/
		%>
	</body>
</html>