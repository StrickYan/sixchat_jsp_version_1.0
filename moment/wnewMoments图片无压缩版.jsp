<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.jspsmart.upload.*" %> 
<%@ page import="javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<body>
		<%@include file="conn.jsp"%>
		<%
		request.setCharacterEncoding("UTF-8");
		String info=null;
		String Imageurl=null;
		String user=null;
		int momentId=0;
		//String mentionPeople[]=null;
		ArrayList usernames=(ArrayList)session.getAttribute("usernames");
		try{
			for(int i=0;i<usernames.size();i++){
				String usernamess=(String)usernames.get(i);
				user=usernamess;
			} 	 
		}catch(Exception e){
			response.sendRedirect("wlogin.jsp");    //检测到没有登录状态跳转回登录界面				
			return;
		}
		
		//Class.forName("com.mysql.jdbc.Driver");
		//Connection conn = DriverManager.getConnection("jdbc:mysql://119.29.24.253:3306/S2013150028?useUnicode=true&characterEncoding=utf-8","S2013150028","657136");
		

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
			smartFile.saveAs("/momentsImages/"+smartFile.getFileName(),smartUpload.SAVE_VIRTUAL);//保存文件		
			Imageurl ="momentsImages/"+smartFile.getFileName();		
			
		}catch(SmartUploadException e){	
			e.printStackTrace();
		}
		
		/*
		在Servlet中如果想要取得文本框提交的内容，不能使用request.getParameter()，
		因为这种提交方式是以二进制进提交的，所以使用以前的取值方法取到的都是null，
		这时候要使用 new SmartUpload.getRequest().getParameter("name");进行取值。
		*/
		info=smartUpload.getRequest().getParameter("info");
		//info=new String(info.trim().getBytes("ISO-8859-1"),"UTF-8");
		String mentionPeople[]=smartUpload.getRequest().getParameterValues("mentions");
		String blockPeople[]=smartUpload.getRequest().getParameterValues("blocks");
		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间
		String Time = formatter.format(currentTime); //将日期时间格局化
		//String str_date2 = currentTime.toString(); //将Date型日期时间转换成字符串形式
		
		String sql = "INSERT INTO WMoments(uId,Info,Time,Imageurl) VALUES(?,?,?,?)";
		PreparedStatement ps = conn.prepareStatement(sql);				
		ps.setString(1,user);
		ps.setString(2,info);
		ps.setString(3,Time);	
		ps.setString(4,Imageurl);			
		ps.executeUpdate();			
		ps.close();
		
		try{
			if(mentionPeople.length!=0){
				String sq3 = "SELECT No from WMoments where uId=? and Time=?";			
				PreparedStatement ps3=conn.prepareStatement(sq3);
				ps3.setString(1,user);
				ps3.setString(2,Time);
				ResultSet rs3 = ps3.executeQuery();	
				while(rs3.next()){	
					momentId=rs3.getInt("No");
				}
				ps3.close();
			
				for(int i=0;i<mentionPeople.length;i++){
					String sq2 = "INSERT INTO WMentions(mentionId,mentionedId,momentId) VALUES(?,?,?)";
					PreparedStatement ps2 = conn.prepareStatement(sq2);				
					ps2.setString(1,user);
					ps2.setString(2,mentionPeople[i]);
					ps2.setInt(3,momentId);			
					ps2.executeUpdate();			
					ps2.close();
				}
			}		
		}catch(Exception e){
			//response.sendRedirect("wmoments.jsp");
			//return;
		}	
		
		
		
		try{
			if(blockPeople.length!=0){
				String sq4 = "SELECT No from WMoments where uId=? and Time=?";			
				PreparedStatement ps4=conn.prepareStatement(sq4);
				ps4.setString(1,user);
				ps4.setString(2,Time);
				ResultSet rs4 = ps4.executeQuery();	
				while(rs4.next()){	
					momentId=rs4.getInt("No");
				}
				ps4.close();
			
				for(int i=0;i<blockPeople.length;i++){
					String sq5 = "INSERT INTO WBlock(blockedId,momentId) VALUES(?,?)";
					PreparedStatement ps5 = conn.prepareStatement(sq5);									
					ps5.setString(1,blockPeople[i]);
					ps5.setInt(2,momentId);			
					ps5.executeUpdate();			
					ps5.close();
				}
			}		
		}catch(Exception e){
			//response.sendRedirect("wmoments.jsp");
			//return;
		}			
		response.sendRedirect("wmoments.jsp");				
		%>
	</body>
</html>