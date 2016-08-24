<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<body>
		<%@include file="conn.jsp"%>
		<%
			request.setCharacterEncoding("UTF-8");
			String comment=request.getParameter("txt");
			String momentId=request.getParameter("num");
			String replyId=request.getParameter("replyId");			
			String replyedId=request.getParameter("replyedId");			
						
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date currentTime = new java.util.Date();//得到当前系统时间
			String Time = formatter.format(currentTime); //将日期时间格局化
			//String str_date2 = currentTime.toString(); //将Date型日期时间转换成字符串形式
	
			String sql = "INSERT INTO WComment(momentId,comment,replyId,replyedId,time) VALUES(?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);				
			ps.setString(1,momentId);
			ps.setString(2,comment);
			ps.setString(3,replyId);	
			ps.setString(4,replyedId);
			ps.setString(5,Time);			
			ps.executeUpdate();			
			ps.close();
					
			/*分离时间的年，月，日，小时，分，秒等单独的信息*/		
			String hour=Time.substring(11,13);
			String minute=Time.substring(14,16);

		//	comment=comment.replaceAll("<|>","");		
			
			int comment_no=0;
			String sq2="select No from WComment where momentId=? and state=1 and comment=? order by time desc";
			PreparedStatement ps2=conn.prepareStatement(sq2);
			ps2.setString(1,momentId);
			ps2.setString(2,comment);															
			ResultSet rs2 = ps2.executeQuery();							
			if(rs2.next()){								
				String str_no = rs2.getString("No");
				comment_no=Integer.parseInt(str_no);
			}
					
			String sq9;
			String head_url=null;
			sq9 = "select uImageurl from WUsers where uId=?";			
			PreparedStatement ps9=conn.prepareStatement(sq9);
			ps9.setString(1,replyId);
			ResultSet rs9 = ps9.executeQuery();	
			if(rs9.next()){
				head_url=rs9.getString("uImageurl");		
			}							
			ps9.close();	
			out.print("<span class='comment_head_img'><a href=wmyPost.jsp?username="+replyId+"><img src="+head_url+"></a></span>");	
			
			if(replyedId.equals(replyId)){
				out.print("<span class='comment_user_id'>");
				out.print(replyId);
				out.print("</span>");							
				out.print("：");
		%>			
				<c:out value="<%=comment%>"></c:out>	
		<%				
				out.print("<br>");
				out.print("<span class='comment_time'>"+hour+":"+minute+"</span>");
			}			
			else{
				out.print("<span class='comment_user_id'>");
				out.print(replyId);
				out.print("</span>");
				out.print(" @ ");
				out.print("<span class='comment_user_id'>");
				out.print(replyedId);
				out.print("</span>");	
				out.print("：");					
		%>			
				<c:out value="<%=comment%>"></c:out>		
		<%				
				out.print("<br>");
				out.print("<span class='comment_time'>"+hour+":"+minute+"</span>");
			}
			conn.close();
		%>
		<a class="delComment" href='javascript:;' onclick="javascript:delComment(<%=comment_no%>);">Delete</a>
	</body>
</html>