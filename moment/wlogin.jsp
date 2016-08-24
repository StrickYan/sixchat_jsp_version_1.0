<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*,java.net.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>sixchat-登录</title>
		<link href="./css/login.css" rel="stylesheet" type="text/css" />
		<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	</head>
	<body>
		<%@include file="conn.jsp"%>
		<%	
			ArrayList usname=(ArrayList)session.getAttribute("usernames");  //检测用户登录状态，若登录跳转首页界面
			if(usname!=null){
				response.sendRedirect("wmoments.jsp");
				return;
			}			
			request.setCharacterEncoding("UTF-8");
			String Id=null;
			String temp_Id=null;	//存放cookie获取的Id
			String Password=null;		
			String text_placeholder="Name";	
			String pw_placeholder="Password";			
			String head_image="img/default/04.jpg";
				
			Cookie cookies[] = request.getCookies();        //获取cookie
			if(cookies != null) { 
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("id"))
					//Id = cookies[i].getValue();
					temp_Id = URLDecoder.decode(cookies[i].getValue(),"UTF-8");    //中文转码
				}
			 }		 
			Id = request.getParameter("id");
			if(Id==null){
				Id=temp_Id;
			}
			Password = request.getParameter("password");		
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");							
			if(Id!=null&&Password!=null){						
				Cookie c = new Cookie("id", URLEncoder.encode(Id,"UTF-8")); //输入为中文时需要编码
				c.setMaxAge(60*60*24);       // Cookie 的有效期为 一天 秒
				//c.setMaxAge(60); 
				response.addCookie(c);						
				String sq2 = "SELECT uId,Password FROM WUsers where uId=?";	
				PreparedStatement ps2=conn.prepareStatement(sq2);
				ps2.setString(1,Id);
				ResultSet rs = ps2.executeQuery();
				
				if(!rs.next()){
					Id=null;
					text_placeholder="该用户不存在";
					ps2.close();
				}
				else{
				    ps2.close();					
					String sq3 = "SELECT uId FROM WUsers where uId=? and Password=password(?)";	
					PreparedStatement ps3=conn.prepareStatement(sq3);
					ps3.setString(1,Id);
					ps3.setString(2,Password);
					ResultSet rs3 = ps3.executeQuery();			
					//if(password.equals(password(Password))){不能这样比较，password()函数要放在数据库语言里才有定义
					if(rs3.next()){
						String username = rs3.getString("uId");
						ArrayList usernames=new ArrayList();
						usernames.add(username);
						session.setAttribute("usernames",usernames);	
						ps3.close();							
						response.sendRedirect("wmoments.jsp");
						return;
					}
					else{
						pw_placeholder="密码错误";
						ps3.close();
					}
				}
			}					
			if(Id!=null){
				String sq4 = "SELECT uImageurl FROM WUsers where uId=?";	
				PreparedStatement ps4=conn.prepareStatement(sq4);
				ps4.setString(1,Id);
				ResultSet rs4 = ps4.executeQuery();	
				if(rs4.next()){
					head_image=rs4.getString("uImageurl");
					ps4.close();
				}
			}		
			conn.close();
		%>				
		<div id="login">
			<span id="brand_name"><a href="http://sixchat.cn">SixChat</a></span>
			<img src="<%=head_image %>" width="90" height="90" style="margin-bottom: 30px;margin-top:40px;">
			<br>
			<form name="loginForm" action="wlogin.jsp" method="post" autocomplete="off">
				<input type="text" name="id" id="id"  class="input_box" placeholder="<%=text_placeholder%>" onkeypress="EnterPress(event)" onkeydown="EnterPress()" 
				value="<% if(Id != null) out.println(Id); %>" maxlength="20" required>			
				<input name="password" id="password" class="input_box" placeholder="<%=pw_placeholder%>" onkeypress="EnterPress(event)" onkeydown="EnterPress()" type="password" 
				maxlength="20" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')" required>			
				<button id="submit_button" type="button" name=button onclick="validate()">
					log In
				</button>			
				<a id="link" href="wregister.jsp">Register Account</a>
			</form>
		</div>
		<script type="text/javascript">
        function validate(){
           if(loginForm.id.value==""){
                //alert("请输入您的账号");
                document.loginForm.id.focus();//聚焦
                return;
           }
           else if(loginForm.password.value==""){
               //alert("请输入您的密码");
               document.loginForm.password.focus();//聚焦
               return;
           }
		   loginForm.submit();
		}		
		function EnterPress(e){ //传入 event   
		    var e = e || window.event;   
		    if(e.keyCode == 13){   
		    document.getElementById("submit_button").click();   
		    }   
		    return false;
		}  
		</script>
	</body>	
</html>
