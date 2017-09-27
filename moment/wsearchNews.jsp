<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
	<body>
	<%@include file="conn.jsp"%>
	<%
		String user=null;
		int temp=0;
		ArrayList usernames=(ArrayList)session.getAttribute("usernames");
			try{
				for(int i=0;i<usernames.size();i++){
					String username=(String)usernames.get(i);
					user=username;
					
					String sq3 = "SELECT uId FROM WaddFriend where state=1 and addId=?";	
					PreparedStatement ps3=conn.prepareStatement(sq3);
					ps3.setString(1,username);
					ResultSet rs3 = ps3.executeQuery();
					while(rs3.next()){
						temp++;
					}
					ps3.close();
				
					String sq7 = "SELECT news FROM WComment where state=1 and news=1 and ((replyId !=? and replyId=replyedId and momentId in(select No from WMoments where uId=?)) or (replyedId=? and replyId<>replyedId))";									
			//		String sq7 = "SELECT news FROM WComment where news=1 and replyedId=? and replyId<>replyedId";	
					PreparedStatement ps7=conn.prepareStatement(sq7);
					ps7.setString(1,username);
					ps7.setString(2,username);
					ps7.setString(3,username);
					ResultSet rs7 = ps7.executeQuery();
					while(rs7.next()){
						temp++;
					}
					ps7.close();
					
					String sq1 = "SELECT news FROM Wlike where news=1 and state=1 and likedId=? and likeId<>likedId";	
					PreparedStatement ps1=conn.prepareStatement(sq1);
					ps1.setString(1,username);
					ResultSet rs1 = ps1.executeQuery();
					while(rs1.next()){
						temp++;
					}
					ps1.close();
						
					String sq2 = "SELECT news FROM WMentions where news=1 and mentionedId=?";	
					PreparedStatement ps2=conn.prepareStatement(sq2);
					ps2.setString(1,username);
					ResultSet rs2 = ps2.executeQuery();
					while(rs2.next()){
						temp++;
					}
					ps2.close();
					
				} 	 
			}catch(Exception e){
				response.sendRedirect("wlogin.jsp");    //检测到没有登录状态跳转回登录界面
				
			}
		%>
		<a href="wnewFriend1.jsp">
		<%
		if(temp!=0){
			out.println("+"+temp);
		}

		else
			out.println("信息");
		%>
		</a>		
	</body>
</html>