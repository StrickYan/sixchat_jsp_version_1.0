<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
	<head>	
	<meta charset="utf-8">
	<title>个人资料</title>
	<link href="./css/wtop.css" rel="stylesheet" type="text/css" />
	<link href="./css/personal.css" rel="stylesheet" type="text/css" />
	<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	<head>
	<body>
		<%@include file="conn.jsp"%>
		<%
			request.setCharacterEncoding("UTF-8");
			String username=request.getParameter("username");
					
			String user=null;
			int temp=0;
			ArrayList usernames=(ArrayList)session.getAttribute("usernames");
			try{
				for(int i=0;i<usernames.size();i++){
					String usernamess=(String)usernames.get(i);
					user=usernamess;
				} 	 
			}catch(Exception e){
				response.sendRedirect("wlogin.jsp"); 				//检测到没有登录状态跳转回登录界面				
				return;
			}
			
			if("repeat".equals(username)){
				out.println("<script>alert('该用户名已存在，请重新输入');</script>");
				username=user;
			}
			
			if(username==null){
				username=user;
			}
			
			%>
			

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
		<%				
			String sq2 = "SELECT uImageurl,sex,region,whatsup FROM WUsers where uId=?";			
			PreparedStatement ps2=conn.prepareStatement(sq2);
			ps2.setString(1,username);
			ResultSet rs2 = ps2.executeQuery();
			String uImageurl=null;
			String sex=null;
			String region=null;
			String whatsup=null;	
			while(rs2.next()){
				uImageurl=rs2.getString("uImageurl");
				sex=rs2.getString("sex");
				region=rs2.getString("region");
				whatsup=rs2.getString("whatsup");			
				%>
				<div class="personalInfo">
					<div class="image">
						<img src="<%out.print(uImageurl);%>" width="200" height="200" >
					</div>
					<div class="info">
						昵称：<%=username%>
						<hr color="D0D0D0">
						性别：<%=sex%>
						<hr color="D0D0D0">
						地区：<%=region%>
						<hr color="D0D0D0">
						个性签名：<%=whatsup%>
					</div>
				</div>		
		<%
				
			}
			ps2.close();
			
			try{
				if(user.equals(username)){
		%>			
				<div class="login-put">
					<form method="post" enctype="multipart/form-data">    
						<button type="button" name="button"
								onClick="showUpdateInfo()"
								style="width: 440px;height:20px;box-shadow:none;border-radius:5px;">修改资料</button>					
					</form>
				</div>			
						
				<div class="updateinfo" style="display:none" id="updateinfo">
					<form action="wpersonal2.jsp" method="post" enctype="multipart/form-data"> 		
					上传新头像：<br>
						<button type="button" title="插入图片" style="width: 80px;height:20px; " onclick="this.form.myFile.click()">选择图片</button>
						<input type="file" name="myFile" style="opacity: 0;filter: alpha(opacity = 0);cursor: pointer;margin-left:-2000px;"><br><hr color="D0D0D0">
					昵称：<br>
						<input type="text" name="name" value="<%=user%>" style="width: 195px;"><hr color="D0D0D0">
					性别：<br>
						<input type="text" name="sex" value="<%=sex%>" style="width: 195px;"><hr color="D0D0D0">
					地区：<br>
						<input type="text" name="region" value="<%=region%>" style="width: 195px;"><hr color="D0D0D0">
					个性签名：<br>
						<input type="text" name="whatsup" value="<%=whatsup%>" style="width: 195px;"><hr color="D0D0D0">
						<button type="submit" style="width: 200px;height:20px;">上 传</button>
						<hr color="D0D0D0">
					</form>				
				</div>
		<%
			}	
		}catch(Exception e){
			response.sendRedirect("wlogin.jsp"); 
		}
		%>	
		<script src="./js/global.js"></script>
	</body>
</html>