<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
	<body>
		<%@include file="conn.jsp"%>
		<%
		request.setCharacterEncoding("utf-8");
		String num=request.getParameter("num");
		String no=request.getParameter("No");
		String fname=request.getParameter("name");
		//Class.forName("com.mysql.jdbc.Driver");
		//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");					
		
		ArrayList usernames=(ArrayList)session.getAttribute("usernames");
		try{
			for(int i=0;i<usernames.size();i++){
				String username=(String)usernames.get(i);
				
				if(num!=null){
					int num1=Integer.parseInt(num);
					int no1=Integer.parseInt(no);
					
					if(num1==0){
									
						String sq2="update WaddFriend set state=0 where No=?";
						PreparedStatement ps2=conn.prepareStatement(sq2);
						ps2.setInt(1,no1);
						ps2.executeUpdate();
						ps2.close();
											
						String sq4 = "INSERT INTO WFriends(uId,fId) VALUES(?,?)";
						PreparedStatement ps = conn.prepareStatement(sq4);
						ps.setString(1,username);
						ps.setString(2,fname);
						ps.executeUpdate();
						ps.close();
						
						String sq5 = "INSERT INTO WFriends(uId,fId) VALUES(?,?)";
						PreparedStatement ps5 = conn.prepareStatement(sq5);
						ps5.setString(1,fname);
						ps5.setString(2,username);
						ps5.executeUpdate();
						ps5.close();
						
					}
					else if(num1==2){						
						String sq3="update WaddFriend set state=2 where No=?";
						PreparedStatement ps3=conn.prepareStatement(sq3);
						ps3.setInt(1,no1);
						ps3.executeUpdate();
						ps3.close();
					}
				}
			}				
		}catch(Exception e){
			response.sendRedirect("wlogin.jsp");    
		}
		conn.close();
		response.sendRedirect("wnewFriend1.jsp"); 
		%>
	</body>
</html>