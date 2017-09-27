<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
	<body>	
		<%@include file="conn.jsp"%>	
		<%
			String str=request.getParameter("num");
			int num=Integer.parseInt(str);
			//String url=request.getParameter("url"); 
			
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");
			
			//通过修改数据库变量隐藏数据达到虚拟删除的效果		
			String sq1="update WMoments set state=0 where No=?";
			PreparedStatement ps1=conn.prepareStatement(sq1);
			ps1.setInt(1,num);
			ps1.executeUpdate();
			ps1.close();
			
			String sq2="update WComment set state=0 where momentId=?";
			PreparedStatement ps2=conn.prepareStatement(sq2);
			ps2.setInt(1,num);
			ps2.executeUpdate();
			ps2.close();
			
			String sq3="update Wlike set state=0 where momentId=?";
			PreparedStatement ps3=conn.prepareStatement(sq3);
			ps3.setInt(1,num);
			ps3.executeUpdate();
			ps3.close();

			conn.close();
			//response.sendRedirect(url);  //在首页删除时跳转回首页,其他页面跳回其他页面
		%>
	</body>
</html>