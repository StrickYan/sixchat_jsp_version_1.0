<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<body>
	<%
		ArrayList usernames=(ArrayList)session.getAttribute("usernames");
		try{
			for(int i=0;i<usernames.size();i++){
				String username=(String)usernames.get(i);	
				List onlineUserList = (List) application.getAttribute("onlineUserList"); 
				onlineUserList.remove(username);	
			}				
		}catch(Exception e){} 	
		session.invalidate();//注销		
		//response.sendRedirect("wlogin.jsp");
		response.sendRedirect("http://119.29.24.253");
	%>
	</body>
</html>