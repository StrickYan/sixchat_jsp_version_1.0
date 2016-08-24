<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>sixchat-注册</title>
		<link href="./css/login.css" rel="stylesheet" type="text/css" />
		<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	</head>
	<body>
		<%@include file="conn.jsp"%>
		<%
			request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String text_placeholder="新的账号";	
									
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");
		
			if(id!=null&&password!=null){		

				String sq4 = "SELECT uId FROM WUsers where uId=?";	
				PreparedStatement ps4=conn.prepareStatement(sq4);
				ps4.setString(1,id);
				ResultSet rs4 = ps4.executeQuery();				
				
				if(rs4.next()){
					text_placeholder="该账号已存在";
					ps4.close();
				}
				else{
					ps4.close();
					
					String sql = "INSERT INTO WUsers(uId,Password) VALUES(?,?)";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,id);
					ps.setString(2,password);
					//ps.setString(2,password(password));
					ps.executeUpdate();
					ps.close();
						
					String sq2="update WUsers set Password=password(password) where uId=?";
					PreparedStatement ps2=conn.prepareStatement(sq2);
					ps2.setString(1,id);
					ps2.executeUpdate();
					ps2.close();
				
					String sq3 = "INSERT INTO WFriends(uId,fId) VALUES(?,?)";      //注册时自动添加自己为好友
					PreparedStatement ps3 = conn.prepareStatement(sq3);
					ps3.setString(1,id);
					ps3.setString(2,id);
					ps3.executeUpdate();
					ps3.close();
			
					conn.close();
					response.sendRedirect("wwait.jsp");
				}
			}
		%>
		<div id="login">
			<span id="brand_name"><a href="http://sixchat.cn">SixChat</a></span>
			<img src="img/default/04.jpg" width="90" height="90" style="margin-bottom: 30px;margin-top:40px;">
			<br>
			<form name="registerForm" action="wregister.jsp" method="post" autocomplete="off">
				<input type="text" name="id" id="id"  class="input_box" placeholder="<%=text_placeholder%>" onkeydown=KeyDown() 
					maxlength="20" required>			
				<input name="password"  class="input_box" placeholder="设置密码" onkeydown=KeyDown() type="password" 
					maxlength="20" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')" required>			
				<input name="password2" class="input_box" placeholder="确认密码" onkeydown=KeyDown() type="password" 
					maxlength="20" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')" required>			
				<button id="submit_button" type="button" name="button" onclick="validate()">注 册</button>				
				<a id="link" href="wlogin.jsp">现在登录</a>
			</form>
		</div>
		<script>
        function validate(){
           if(registerForm.id.value==""){
                alert("请输入您的账号");
                document.registerForm.id.focus();//聚焦
                return;
           }
           else if(registerForm.password.value==""){
               alert("请输入您的密码");
               document.registerForm.password.focus();//聚焦
               return;
           }
		   else if(registerForm.password2.value==""){
               alert("请确认您的密码");
               document.registerForm.password2.focus();//聚焦
               return;
           }
		    else if(registerForm.password.value!=registerForm.password2.value){
               alert("您输入的密码不一致，请重新输入");
               document.registerForm.password2.focus();//聚焦
               return;
           }
		   registerForm.submit();
		}		
		</script>
	</body>
</html>