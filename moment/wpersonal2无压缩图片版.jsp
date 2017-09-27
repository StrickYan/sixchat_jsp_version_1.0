<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.jspsmart.upload.*" %> 
<%@ page import="javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<body>
		<%@include file="conn.jsp"%>
		<%
		request.setCharacterEncoding("UTF-8");
		String name=null;
		String sex=null;
		String region=null;			
		String whatsup=null;	
	
		String user=null;
		ArrayList usernames=(ArrayList)session.getAttribute("usernames");
		try{
			for(int i=0;i<usernames.size();i++){
				String usernamess=(String)usernames.get(i);
				user=usernamess;
			} 	 
		}catch(Exception e){
			response.sendRedirect("wlogin.jsp");    //检测到没有登录状态跳转回登录界面				
		}
		
		//Class.forName("com.mysql.jdbc.Driver");
		//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");
		
		String sq2 = "SELECT uImageurl FROM WUsers where uId=?";			
		PreparedStatement ps2=conn.prepareStatement(sq2);
		ps2.setString(1,user);
		ResultSet rs2 = ps2.executeQuery();
		String uImageurl=null;
		String urlTemp=null;
		while(rs2.next()){
			urlTemp=rs2.getString("uImageurl");
		}
		ps2.close();

		SmartUpload smartUpload=new SmartUpload();
		//初始化
		ServletConfig config1 = this.getServletConfig();
		smartUpload.initialize(config1,request,response);
		try{
			//上传文件
			smartUpload.upload();
			//得到上传的文件
			File smartFile=smartUpload.getFiles().getFile(0);
			//保存文件
			//double temp=Math.random();
			smartFile.saveAs("/upload/"+smartFile.getFileName(),smartUpload.SAVE_VIRTUAL);//保存文件		
			uImageurl ="upload/"+smartFile.getFileName();		
		}catch(SmartUploadException e){	
			e.printStackTrace();
		}
		if(uImageurl==null){
			uImageurl=urlTemp;
		}
				
		/*
		在Servlet中如果想要取得文本框提交的内容，不能使用request.getParameter()，
		因为这种提交方式是以二进制进提交的，所以使用以前的取值方法取到的都是null，
		这时候要使用 new SmartUpload.getRequest().getParameter("name");进行取值。
		*/
		name=smartUpload.getRequest().getParameter("name");
		sex=smartUpload.getRequest().getParameter("sex");
		region=smartUpload.getRequest().getParameter("region");
		whatsup=smartUpload.getRequest().getParameter("whatsup");

		//String msg="Upload Success!";
		//String msg=uImageurl;
		//request.setAttribute("msg", msg);
		//RequestDispatcher rd= request.getRequestDispatcher("/Weixin/wpersonal.jsp");
		//rd.forward(request, response);
		
		try{
			String sq1="update WUsers set uImageurl=?,sex=?,region=?,whatsup=?,uId=? where uId=?";
			PreparedStatement ps1=conn.prepareStatement(sq1);
			ps1.setString(1,uImageurl);
			ps1.setString(2,sex);
			ps1.setString(3,region);
			ps1.setString(4,whatsup);
			ps1.setString(5,name);
			ps1.setString(6,user);
			ps1.executeUpdate();
			ps1.close();		
		}catch(Exception e){
			response.sendRedirect("wpersonal.jsp?username=repeat");
			return;
		}

		
		String sq3="update WComment set replyId=? where replyId=?";
		PreparedStatement ps3=conn.prepareStatement(sq3);
		ps3.setString(1,name);
		ps3.setString(2,user);
		ps3.executeUpdate();
		ps3.close();
		
		String sq4="update WComment set replyedId=? where replyedId=?";
		PreparedStatement ps4=conn.prepareStatement(sq4);
		ps4.setString(1,name);
		ps4.setString(2,user);
		ps4.executeUpdate();
		ps4.close();
		
		String sq5="update WaddFriend set uId=? where uId=?";
		PreparedStatement ps5=conn.prepareStatement(sq5);
		ps5.setString(1,name);
		ps5.setString(2,user);
		ps5.executeUpdate();
		ps5.close();
		
		String sq6="update WaddFriend set addId=? where addId=?";
		PreparedStatement ps6=conn.prepareStatement(sq6);
		ps6.setString(1,name);
		ps6.setString(2,user);
		ps6.executeUpdate();
		ps6.close();
		
		String sq7="update WBlock set blockedId=? where blockedId=?";
		PreparedStatement ps7=conn.prepareStatement(sq7);
		ps7.setString(1,name);
		ps7.setString(2,user);
		ps7.executeUpdate();
		ps7.close();
		
		String sq8="update WFriends set uId=? where uId=?";
		PreparedStatement ps8=conn.prepareStatement(sq8);
		ps8.setString(1,name);
		ps8.setString(2,user);
		ps8.executeUpdate();
		ps8.close();
		
		String sq9="update WFriends set fId=? where fId=?";
		PreparedStatement ps9=conn.prepareStatement(sq9);
		ps9.setString(1,name);
		ps9.setString(2,user);
		ps9.executeUpdate();
		ps9.close();
		
		String sq10="update Wlike set likeId=? where likeId=?";
		PreparedStatement ps10=conn.prepareStatement(sq10);
		ps10.setString(1,name);
		ps10.setString(2,user);
		ps10.executeUpdate();
		ps10.close();
		
		String sq11="update Wlike set likedId=? where likedId=?";
		PreparedStatement ps11=conn.prepareStatement(sq11);
		ps11.setString(1,name);
		ps11.setString(2,user);
		ps11.executeUpdate();
		ps11.close();
		
		String sq12="update WMentions set mentionId=? where mentionId=?";
		PreparedStatement ps12=conn.prepareStatement(sq12);
		ps12.setString(1,name);
		ps12.setString(2,user);
		ps12.executeUpdate();
		ps12.close();
		
		String sq13="update WMentions set mentionedId=? where mentionedId=?";
		PreparedStatement ps13=conn.prepareStatement(sq13);
		ps13.setString(1,name);
		ps13.setString(2,user);
		ps13.executeUpdate();
		ps13.close();
		
		String sq14="update WMoments set uId=? where uId=?";
		PreparedStatement ps14=conn.prepareStatement(sq14);
		ps14.setString(1,name);
		ps14.setString(2,user);
		ps14.executeUpdate();
		ps14.close();
				
		try{
			for(int i=0;i<usernames.size();i++){
				String username=(String)usernames.get(i);	
				List onlineUserList = (List) application.getAttribute("onlineUserList"); 
				onlineUserList.remove(username);	
			}				
		}catch(Exception e){} 	
		session.removeAttribute("usernames");
		ArrayList new_username=new ArrayList();
		new_username.add(name);
		session.setAttribute("usernames",new_username);	
		
		response.sendRedirect("wpersonal.jsp");
		
		%>
	</body>
</html>