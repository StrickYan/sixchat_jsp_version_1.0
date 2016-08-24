<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>	
	<meta charset="utf-8">
	<title>动态</title>
	<link href="./css/wtop.css" rel="stylesheet" type="text/css" />
	<link href="./css/news.css" rel="stylesheet" type="text/css" />
	<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	<style>
		.comment_text img{
			margin-left:2px;
			width:18px;
			height:18px;
			vertical-align:text-bottom;
		}
	</style>
	</head>
	<body>	
	<div class="showNews">
		<%@include file="conn.jsp"%>
		<%
		//Class.forName("com.mysql.jdbc.Driver");
		//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");			
		String user=null;
		int temp=0;
		ArrayList usernames=(ArrayList)session.getAttribute("usernames");
		try{
			for(int i=0;i<usernames.size();i++){
				String username=(String)usernames.get(i);
				user=username;

				//String sq6 = "SELECT mentionId,momentId FROM WMentions where news=1 and mentionedId=? and mentionId<>mentionedId order by No desc";	
				String sq6 = "SELECT mentionId,momentId FROM WMentions where  mentionedId=? and mentionId<>mentionedId order by No desc limit 0,5";	  //把动态都读出来，无论已读是否
				PreparedStatement ps6=conn.prepareStatement(sq6);
				ps6.setString(1,username);
				ResultSet rs6 = ps6.executeQuery();
				while(rs6.next()){
					%>
					<div class="mention">
					<%
					String mentionId = rs6.getString("mentionId");
					String momentId = rs6.getString("momentId");
					out.println("<span class='name'>"+mentionId+"</span>"+" "+"提到了你"+" ");
					%>
					<a href="woneMoment.jsp?momentId=<%=momentId%>">查看</a><br>
					</div>
					<%
				}
				ps6.close();
				
				%><br><%
				
				//String sq2 = "SELECT likeId,momentId FROM Wlike where news=1 and likedId=? and likeId<>likedId order by No desc";	
				String sq2 = "SELECT likeId,momentId FROM Wlike where state=1 and likedId=? and likeId<>likedId order by No desc limit 0,10";
				PreparedStatement ps2=conn.prepareStatement(sq2);
				ps2.setString(1,username);
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){
					%>
					<div class="like">
					<%
					String momentId = rs2.getString("momentId");
					String likeId = rs2.getString("likeId");
					out.println("<span class='name'>"+likeId+"</span>"+" "+"赞了你"+" ");
					%>
					<a href="woneMoment.jsp?momentId=<%=momentId%>">查看</a><br>
					</div>
					<%
				}
				ps2.close();
				%><br><%
								
				//String sq3 = "SELECT replyId,momentId,comment FROM WComment where replyedId=? and replyId<>replyedId order by No desc limit 0,20";
				String sq3 = "SELECT replyId,momentId,comment FROM WComment where state=1 and ((replyId<>? and replyId=replyedId and momentId in(select No from WMoments where uId=?)) or (replyedId=? and replyId<>replyedId)) order by No desc limit 0,20";
				PreparedStatement ps3=conn.prepareStatement(sq3);
				ps3.setString(1,username);
				ps3.setString(2,username);
				ps3.setString(3,username);
				ResultSet rs3 = ps3.executeQuery();
				while(rs3.next()){
					%>
					<div class="comment">
					<%
					String momentId = rs3.getString("momentId");
					String replyId = rs3.getString("replyId");
					String comment = rs3.getString("comment");
					//out.println("<span class='name'>"+replyId+"</span>"+" "+"回复了你"+"："+comment);
					out.print("<span class='name'>"+replyId+"</span>"+" "+"回复了你"+"：");
					%>
					<span class="comment_text"><c:out value="<%=comment%>"></c:out></span>
					<a href="woneMoment.jsp?momentId=<%=momentId%>">查看</a><br>
					</div>
					<%
				}
				ps3.close();
				%><br><%

				String sq7="update WMentions set news=0 where mentionedId=?";
				PreparedStatement ps7=conn.prepareStatement(sq7);
				ps7.setString(1,username);
				ps7.executeUpdate();
				ps7.close();
				
				String sq4="update Wlike set news=0 where likedId=?";
				PreparedStatement ps4=conn.prepareStatement(sq4);
				ps4.setString(1,username);
				ps4.executeUpdate();
				ps4.close();
				
				String sq5="update WComment set news=0 where news=1 and state=1 and ((replyId<>? and momentId in(select No from WMoments where uId=?)) or (replyedId=? and replyId<>replyedId))";
				PreparedStatement ps5=conn.prepareStatement(sq5);
				ps5.setString(1,username);
				ps5.setString(2,username);
				ps5.setString(3,username);
				ps5.executeUpdate();
				ps5.close();
	

				
				String sq1 = "SELECT uId,state,No FROM WaddFriend where addId=? order by No desc limit 0,20";	
				PreparedStatement ps1=conn.prepareStatement(sq1);
				ps1.setString(1,username);
				ResultSet rs = ps1.executeQuery();
				
				while(rs.next()){
					%>
					<div class="newFriends">
					<%				
					String uId=rs.getString("uId");
					String state=rs.getString("state");
					int state1=Integer.parseInt(state);
					String No=rs.getString("No");
					out.println("<span class='name'>"+uId+"</span>");
					if(state1==1){
	%>
					<a href="wnewFriend2.jsp?num=0&No=<%=No%>&name=<%=uId%>">接受</a>
					<a href="wnewFriend2.jsp?num=2&No=<%=No%>">拒绝</a><br>
	<%
					}
					else{
						if(state1==0){
							%>
							已接受<br>
							<%
						}
						else if(state1==2){
							%>
							已拒绝<br>
							<%
						}
					}
					%>
					</div>
					<%
				}
				ps1.close();
																							
			}				
		}catch(Exception e){
			response.sendRedirect("wlogin.jsp");    
		}
		conn.close();		
		%>
	</div>
	
	<div class="top">
		<div class="logo"> 
			<a href="http://sixchat.cn">
				<img src="img/default/my.ico" width="30" height="30">
			</a>
		</div> 
		<div class="search">
			<form name="searchForm" action="wadd.jsp" method="post">
				<input type="text" autocomplete="off" name="sousuo" class="sousuo"
					value="  添加新的好友"
					onfocus='if(this.value=="  添加新的好友"){this.value="";};'
					onblur='if(this.value==""){this.value="  添加新的好友";};'>
				<button type="submit">搜 索</button>
			</form>
		</div>
		<div class="main">
			<a href="wmoments.jsp">	
				<!-- <img src="upload/main.png"style="height:33px;" > -->
				首页		
			</a>	
		</div>
		<div class="mypost">
			<a href="wmyPost.jsp"> 
				<!--  <img src="upload/mypost.png" style="height:30px;"> -->
				<%	
					out.println(user);
				%>
			</a> 
			<a href="wlogout.jsp" >注销</a>
		</div>		
		<div class="news" id="news">
			<a href="wnewFriend1.jsp">信息</a>
			<%
			if(temp!=0){
			%>
			<a href="wnewFriend1.jsp" style="color:red;">
			<%
				out.println("+"+temp);
			%>
			</a>
		<%
			}	
		%>
		</div>	
	</div>
		<script src="./js/global.js"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="./js/check.js"></script>		 
		<script type="text/javascript" src="./js/jquery.qqFace.js"></script>
	</body>
</html>