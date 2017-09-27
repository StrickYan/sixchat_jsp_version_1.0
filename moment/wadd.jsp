<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>添加好友</title>
   		<meta charset="utf-8">
		<link href="./css/wtop.css" rel="stylesheet" type="text/css" />
		<link href="./css/personal.css" rel="stylesheet" type="text/css" />	
		<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	</head>	
	<body>
		<%@include file="conn.jsp"%>
		<%		
			request.setCharacterEncoding("utf-8");
			String str=request.getParameter("sousuo");
			String str1=request.getParameter("str");			
			String user=null;
			int temp=0;
			ArrayList usernames=(ArrayList)session.getAttribute("usernames");
			try{
				for(int i=0;i<usernames.size();i++){
					String username=(String)usernames.get(i);
					user=username;
				} 	 
			}catch(Exception e){
				response.sendRedirect("wlogin.jsp");    //检测到没有登录状态跳转回登录界面
				
			}			
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");						
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
			String sq5 = "SELECT uImageurl,sex,region,whatsup FROM WUsers where uId=?";			
			PreparedStatement ps5=conn.prepareStatement(sq5);
			ps5.setString(1,str);
			ResultSet rs5 = ps5.executeQuery();
			String uImageurl=null;
			String sex=null;
			String region=null;
			String whatsup=null;	
			if(rs5.next()){
				uImageurl=rs5.getString("uImageurl");
				sex=rs5.getString("sex");
				region=rs5.getString("region");
				whatsup=rs5.getString("whatsup");			
				%>
				<div class="personalInfo">
					<div class="image">
						<a href="wmyPost.jsp?username=<%=str%>">
							<img src="<%out.print(uImageurl);%>" width="200" height="200" >
						</a>
					</div>
					<div class="info">
						昵称：<%=str%>
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
			else{		
			%>
				<div class="personalInfo">
					<div class="image">
						<img src="img/default/morentouxiang.png" width="200" height="200" >
					</div>
					<div class="info">
						昵称：我是谁
						<hr color="D0D0D0">
						性别：你猜
						<hr color="D0D0D0">
						地区：你猜
						<hr color="D0D0D0">
						个性签名：你再猜
					</div>
				</div>		
		<%						
			}
			ps5.close();	
		%>		
		<div class="result">
		<%						
			if(str!=null){			
				String sq1 = "SELECT uId FROM WUsers where uId=?";	
				PreparedStatement ps1=conn.prepareStatement(sq1);
				ps1.setString(1,str);
				ResultSet rs1 = ps1.executeQuery();						
				if(!rs1.next()){
					out.println("该账号不存在，请重新输入"+"<br>");
				%>
					或者 <a href="wregister.jsp">现在注册</a>
				<%
				}
				else{
					out.println("用户："+str);				
					/*查询数据库若已提交过申请好友请求则返回提醒已提交过*/						
					String sq4="select uId from WFriends where uId=? and fId=?";
					PreparedStatement ps4=conn.prepareStatement(sq4);
					ps4.setString(1,user);
					ps4.setString(2,str);
					ResultSet rs4 = ps4.executeQuery();
					if(rs4.next()){
						out.println("和你已经是好友");
					}
					else{
						String sq3 = "SELECT uId FROM WaddFriend where uId=? and addId=? and state=1";	
						PreparedStatement ps3=conn.prepareStatement(sq3);
						ps3.setString(1,user);
						ps3.setString(2,str);
						ResultSet rs3 = ps3.executeQuery();							
						if(rs3.next()){
							out.println("已添加，等待通过");
						}
						else{
							
							%>
							<a href="wadd.jsp?str=<%=str%>">添加</a><br>
							<%
						}
						ps3.close();
					}
					ps4.close();		
				}
				ps1.close();
			}
			if(str1!=null){					
				//str1=new String(str1.getBytes("iso8859-1"),"utf-8");//字符流转码 原因未知			
				String sq4 = "SELECT uId FROM WaddFriend where uId=? and addId=? and state=1";	//事先检测数据库若已有添加好友请求则不再进行插入数据库操作防止重复添加
				PreparedStatement ps4=conn.prepareStatement(sq4);
				ps4.setString(1,user);
				ps4.setString(2,str1);
				ResultSet rs4 = ps4.executeQuery();
				if(rs4.next()){
					ps4.close();
					response.sendRedirect("wmoments.jsp");
				}
				else{			
					//str1=new String(str.getBytes("iso8859-1"),"utf-8");//字符流转码 原因未知
					String sq2 = "INSERT INTO WaddFriend(uId,addId) VALUES(?,?)";
					PreparedStatement ps = conn.prepareStatement(sq2);
					ps.setString(1,user);
					ps.setString(2,str1);
					ps.executeUpdate();
					ps.close();				
					out.println(str1+" "+"已添加，等待通过");
				}						
			}		
		%>
		</div>		
		<script src="./js/global.js"></script>
	</body>
</html>