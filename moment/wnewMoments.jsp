<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.jspsmart.upload.*" %> 
<%@ page import="javax.servlet.*" %>

<%@ page import="java.io.File"%>
<%@ page import="java.applet.Applet" %>
<%@ page import="java.awt.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="java.io.*,java.awt.Image,java.awt.image.*,com.sun.image.codec.jpeg.*, java.sql.*,com.jspsmart.upload.*,java.util.*"%>
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
		
		SmartUpload smart = new SmartUpload();
    	smart.initialize(pageContext);
		try{		
			String bigimageAddress=application.getRealPath("/");  //  
  			String smallimageAddress="momentsImages/";//原图保存的路径
 			String smallimageAddress1="thumbnail_momentsImages/";//压缩后小图片的保存的根目录的路径
    		smart.upload(); 	
 			
    		if (!smart.getFiles().getFile(0).isMissing()){//存在上传图片才执行
 			
  				//更改文件名，取得当前上传时间的毫秒数值
				Calendar calendar = Calendar.getInstance();
				String fileName = String.valueOf(calendar.getTimeInMillis());//设置新的文件名
				String random_letter=String.valueOf((char)(Math.random()*26 + 'a'));				
 				String ext = smart.getFiles().getFile(0).getFileExt();    //获取的上传文件的格式
 				fileName = fileName+random_letter+"."+ext;    //对上传的文件重新命名，若前后两文件重名则后者把前者覆盖
				// System.out.println(fileName);
 				smart.getFiles().getFile(0).saveAs(bigimageAddress+smallimageAddress+fileName);  //原图保存 
 				Imageurl ="thumbnail_momentsImages/"+fileName;				
 				String playerheadadr = bigimageAddress+smallimageAddress+fileName;   
    			String url=bigimageAddress+smallimageAddress1;
    			java.io.File file = new java.io.File(playerheadadr);
    			String newurladd = url+fileName;
    			Image src = javax.imageio.ImageIO.read(file);   
    			//  图片压缩
    			float tagsize=200;	//压缩后长或宽的分辨率为200
    			int old_w=src.getWidth(null);   //得到源图宽 
    			int old_h=src.getHeight(null);      
    			int new_w=0;   
   	 			int new_h=0;                        
    			//得到源图长  
    			int tempsize;
    			float tempdouble;     
     			if(old_w>old_h){    
       				tempdouble=old_w/tagsize;  
       			}else{    
          	 		tempdouble=old_h/tagsize;  
        		}       
   				new_w=Math.round(old_w/tempdouble);   
   				new_h=Math.round(old_h/tempdouble);//计算新图长宽 			  			  
   				Graphics2D g2D=null;
   				BufferedImage tag = new BufferedImage(new_w,new_h,BufferedImage.TYPE_4BYTE_ABGR_PRE); 
   				tag.getGraphics().drawImage(src,0,0,new_w,new_h,null);     //绘制缩小后的图   
   				ImageIO.write(tag, "png", new File(newurladd));    //压缩后保存新图
    		}
		}catch(SmartUploadException e){	
			e.printStackTrace();
		}  
		info=smart.getRequest().getParameter("info");
		String mentionPeople[]=smart.getRequest().getParameterValues("mentions");
		String blockPeople[]=smart.getRequest().getParameterValues("blocks");
		
		/*
		在Servlet中如果想要取得文本框提交的内容，不能使用request.getParameter()，
		因为这种提交方式是以二进制进提交的，所以使用以前的取值方法取到的都是null，
		这时候要使用 new SmartUpload.getRequest().getParameter("name");进行取值。
		*/		
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