<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<body>
		<%@include file="conn.jsp"%>
		<%	
			String user=null;
			ArrayList usernames=(ArrayList)session.getAttribute("usernames");
			try{
				for(int i=0;i<usernames.size();i++){
					String username=(String)usernames.get(i);
					user=username;
				} 	 
			}catch(Exception e){
				response.sendRedirect("wlogin.jsp");    //检测到没有登录状态跳转回登录界面				
			}
			
			request.setCharacterEncoding("UTF-8");
			String momentId=request.getParameter("num");
			String likeId=request.getParameter("likeId");
			String likedId=request.getParameter("likedId");
			
		//	momentId = java.net.URLDecoder.decode(momentId,"UTF-8");
		//	likeId = java.net.URLDecoder.decode(likeId,"UTF-8");			
		//	likedId = java.net.URLDecoder.decode(likedId,"UTF-8");
			
			//out.println(momentId+" "+likeId);
			int num=Integer.parseInt(momentId);
			
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");
			
			String sq1 = "SELECT state,No FROM Wlike where momentId=? and likeId=?";	
			PreparedStatement ps1=conn.prepareStatement(sq1);
			ps1.setString(1,momentId);
			ps1.setString(2,likeId);
			ResultSet rs1 = ps1.executeQuery();
			if(!rs1.next()){
				String sq2 = "INSERT INTO Wlike(momentId,likeId,likedId) VALUES(?,?,?)";
				PreparedStatement ps2 = conn.prepareStatement(sq2);				
				ps2.setInt(1,num);
				ps2.setString(2,likeId);	
				ps2.setString(3,likedId);				
				ps2.executeUpdate();			
				ps2.close();
				//out.println(likeId);															
			}
			else{
				String stateTemp = rs1.getString("state");
				String NoTemp = rs1.getString("No");
				int state=Integer.parseInt(stateTemp);
				int No=Integer.parseInt(NoTemp);
				if(state==1){
					String sq3="update Wlike set state=0 where No=?";
					PreparedStatement ps3=conn.prepareStatement(sq3);
					ps3.setInt(1,No);
					ps3.executeUpdate();
					ps3.close();				
				}
				else{
					String sq4="update Wlike set state=1 where No=?";
					PreparedStatement ps4=conn.prepareStatement(sq4);
					ps4.setInt(1,No);
					ps4.executeUpdate();
					ps4.close();
					//out.println(likeId);												
				}
			}
			%>
			<img src="img/default/like_people.png" width="15" height="15">
			<%
			/*朋友圈权限版本*/
			/*
			//String sq5 = "SELECT likeId FROM Wlike where momentId=? and state=1 order by No asc";	
			String sq5 = "SELECT Wlike.likeId FROM Wlike,WFriends where Wlike.momentId=? and Wlike.state=1 and WFriends.uId=? and WFriends.fId=Wlike.likeId order by Wlike.No asc";	
			PreparedStatement ps5=conn.prepareStatement(sq5);
			ps5.setInt(1,num);
			ps5.setString(2,user);
			ResultSet rs5 = ps5.executeQuery();								   
			while(rs5.next()){			
				String likeIds = rs5.getString("likeId");
				out.println(likeIds+",");
			}
			ps5.close();	
			*/
			
			//微博权限版本
			String sq6;
			if(likedId.equals(user)){	//浏览自己的帖子可以看到所有赞包括好友与非好友
				sq6 = "SELECT likeId FROM Wlike where momentId=? and state=1 order by No asc";
				PreparedStatement ps6=conn.prepareStatement(sq6);
				ps6.setInt(1,num);
				ResultSet rs6 = ps6.executeQuery();		
				while(rs6.next()){			
					String likeIds = rs6.getString("Wlike.likeId");
					//out.println(likeIds+",");
					%>
					<c:out value="<%=likeIds+','%>"></c:out>
					<%
				}
				ps6.close();
			}
			else{		//浏览他人的帖子时只能看到互为好友的赞
				sq6 = "SELECT Wlike.likeId FROM Wlike,WFriends where Wlike.momentId=? and Wlike.state=1 and WFriends.uId=? and WFriends.fId=Wlike.likeId order by Wlike.No asc";	
				PreparedStatement ps6=conn.prepareStatement(sq6);
				ps6.setInt(1,num);
				ps6.setString(2,user);
				ResultSet rs6 = ps6.executeQuery();		
				while(rs6.next()){			
					String likeIds = rs6.getString("Wlike.likeId");
					//out.println(likeIds+",");
					%>
					<c:out value="<%=likeIds+','%>"></c:out>
					<%
				}
				ps6.close();
			}		
			
			
			ps1.close();	
			conn.close();			
		%>
	</body>
</html>