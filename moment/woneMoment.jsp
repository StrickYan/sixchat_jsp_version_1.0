<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>	
	<meta charset="utf-8">
	<title>个人</title>	
	<link href="./css/wtop.css" rel="stylesheet" type="text/css" />
	<link href="./css/wmyInfo.css" rel="stylesheet" type="text/css" />
	<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	<script src="./js/formatImg.js"></script>
	</head>
	<body>
		<%@include file="conn.jsp"%>
		<%
			request.setCharacterEncoding("UTF-8");
			String momentId=request.getParameter("momentId");
			//out.println(momentId);
			int number=Integer.parseInt(momentId);		
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
					
			//查看所有有权限看到的朋友圈 不局限是好友  类似微博权限版本
			String sq2="select uId,Info,Imageurl,Time,No from WMoments where state=1 and No not in (select momentId from WBlock where blockedId=?) and No=?";
	
		//	//通过数据库选择只显示好友的朋友圈
		//	String sq2 = "SELECT WMoments.uId,WMoments.Info,WMoments.Imageurl,WMoments.Time,WMoments.No FROM WMoments,WFriends where WMoments.state=1 and WFriends.fId=WMoments.uId and WFriends.uId=? and WMoments.No=?";			
		
			PreparedStatement ps2=conn.prepareStatement(sq2);
			ps2.setString(1,user);
			ps2.setInt(2,number);
			ResultSet rs = ps2.executeQuery();
			int tmp=0;
			int tmp2=0;    //计算朋友圈的评论条数
			while(rs.next()){
		//		String id = rs.getString("WMoments.uId");
		//		String info = rs.getString("WMoments.Info");
		//		String imageurl = rs.getString("WMoments.Imageurl");
		//		String time = rs.getString("WMoments.Time");
		//		String str = rs.getString("WMoments.No");
								
				String id = rs.getString("uId");
				String info = rs.getString("Info");
				String imageurl = rs.getString("Imageurl");
				String time = rs.getString("Time");
				String str = rs.getString("No");			
				int num=Integer.parseInt(str);						
				/* replaceAll用到正则表达式将字符串中所有的“<”“>”替换成空字符*/
		//		id=id.replaceAll("<|>","");
		//		info=info.replaceAll("<|>","");
								
				/*分离时间的年，月，日，小时，分，秒等单独的信息*/
				String date=time;
				//out.println(date+"<br>");
				String year=date.substring(0,4);//取第0+1位至第4位
				String month=date.substring(5,7);//取第5+1位至第7位
				String day=date.substring(8,10);//取第8+1位至第10位
				//out.println("year="+year+",month="+month+",day="+day)
				String hour=date.substring(11,13);
				String minute=date.substring(14,16);
				String second=date.substring(17,19);			
				String sq4 = "SELECT uImageurl from WUsers where uId=?";			
				PreparedStatement ps4=conn.prepareStatement(sq4);
				ps4.setString(1,id);
				ResultSet rs4 = ps4.executeQuery();	
				while(rs4.next()){
					String touxiang = rs4.getString("uImageurl");
					%>																		
					<div class="mainInfo" style="margin-top:100px;">					
					<table >	
					<!-- 输出id行 -->
					<tr>		
						<td rowspan="4" width="60">
							<div class="headImage" >
								<img src="<%out.print(touxiang);%>" width="50" height="50" >
							</div>
						</td>
						<td class="id_name">	
							<b><c:out value="<%=id%>"></c:out></b>							
						</td>
					</tr>					
					<!-- 输出info行 -->
					<tr>
						<td>
						<div class="info"><c:out value="<%=info%>"></c:out></div>																																	
						</td>
					</tr>					
					<!-- 输出图片行 -->	
					<tr>
						<td>
						<%
							if(imageurl!=null){
								String url=imageurl.split("\\/")[1];//取原图片名
						%>
								<div class="image">
									<!--  
									<img src="<%out.print(imageurl);%>" onload="formatImg(this)" onclick="clickImg(this)">
									-->								
									<a href="wfullImage.jsp?imageurl=<%out.print("momentsImages/"+url);%>" style="font-weight:bold;text-decoration : none;">
										<img src="<%out.print(imageurl);%>" onload="formatImg(this)" ">
									</a>									
								</div>	
						<%
							}
						%>								
						</td>
					</tr>	
					<!-- 输出时间行 -->
					<tr>
						<td>				
						<div class="line3">
						<div class="time">
						<%
							//out.println(time +"<BR>"+"<hr>");
							out.println(month+"月"+day+"日"+" "+hour+":"+minute+" ");
						%>		
						<%
							if(id.equals(user)){     //当前用户才拥有权限删除自己的朋友圈
						%>
						<!--添加删除功能-->
						<!--  
						<a href="wdelete.jsp?num=<%=num%>&url=wmoments.jsp">Delete</a>
						-->
						<a class="delMoment" href='javascript:;' onclick="javascript:delMoment(<%=num%>);">Delete</a>
						<%
						}
						%>
						</div>					
						<div id="divImage" style="display:none"></div>																											
						<!-- 一级评论按钮 -->
						<div class="login-put">				
							<button type="button" name="button" onClick="javascript:show(<%=tmp%>);return false;">&#5867 &#5867</button>
						</div>	
						<!-- 点赞按钮 -->
						<div class="like">
							<button type="button" 
									name="num=<%=num%>&likeId=<%=user%>&likedId=<%=id%>"
									onclick="saveLike(this,<%=tmp%>)">like</button>
						</div>		
					</div>		
					<!-- 一级评论框 -->
					<div class="div1" name="div1" style="display:none">
						<form name="form_comment_1" method="post" action="" autocomplete="off">
							<input type="text" class="text01" name="text01" placeholder="这里输入评论" maxlength="140" required/>
							<span class="button01"> 
								<button type="button" 
									name="&num=<%=num%>&replyId=<%=user%>&replyedId=<%=user%>"
									onclick="javascript:saveComment(this,<%=tmp%>);">发 送</button>
							</span>
						</form>
					</div>
						<div class="line4" name="line4" style="display:none">				
							<div class="like_me" name="like_me">
								<img src="img/default/like_people.png">
							<%
					//			String sq6 = "SELECT likeId FROM Wlike where momentId=? and state=1 order by No asc";	
					//			PreparedStatement ps6=conn.prepareStatement(sq6);
								//num=Integer.parseInt(num);
					//			ps6.setInt(1,num);
					//			ResultSet rs6 = ps6.executeQuery();								   
					//			while(rs6.next()){			
					//								 //若有赞则显示点赞行，无则隐藏
					//				String likeId = rs6.getString("likeId");
					//				out.println(likeId+",");
					//			}
					//			ps6.close();
																											
								//微博权限版本
								String sq6;
								if(id.equals(user)){	//浏览自己的帖子可以看到所有赞包括好友与非好友
									sq6 = "SELECT likeId FROM Wlike where momentId=? and state=1 order by No asc";
									PreparedStatement ps6=conn.prepareStatement(sq6);
									ps6.setInt(1,num);
									ResultSet rs6 = ps6.executeQuery();		
									while(rs6.next()){			
										%><script>document.getElementsByName("line4")[<%out.print(tmp);%>].style.display="block";</script><% //若有赞则显示点赞行，无则隐藏
										String likeId = rs6.getString("Wlike.likeId");
										//out.println(likeId+",");
										%>
										<c:out value="<%=likeId+','%>"></c:out>
										<%
									}
									ps6.close();
								}
								else{		//浏览他人的帖子时只能看到互为好友的赞
									sq6 = "SELECT Wlike.likeId FROM Wlike,WFriends where Wlike.momentId=? and Wlike.state=1 and WFriends.uId=? and WFriends.fId=Wlike.likeId order by Wlike.No asc";	
									PreparedStatement ps6=conn.prepareStatement(sq6);
									ps6.setInt(1,num);
									ps6.setString(2,user);
									ResultSet rs6 = ps6.executeQuery();		
									while(rs6.next()){			
										%><script>document.getElementsByName("line4")[<%out.print(tmp);%>].style.display="block";</script><% //若有赞则显示点赞行，无则隐藏
										String likeId = rs6.getString("Wlike.likeId");
										//out.println(likeId+",");
										%>
										<c:out value="<%=likeId+','%>"></c:out>
										<%
									}
									ps6.close();
								}																											
							%>																			
							</div>
						</div>															
						<div class="comment">
							<%						
								String sq5;
								if(id.equals(user)){	//浏览自己的帖子可以看到所有评论包括好友与非好友
									sq5 = "SELECT No,comment,replyId,replyedId,time FROM WComment where momentId=? and state=1 order by time asc";	
								}
								else{	//浏览他人的帖子时只能看到互为好友的评论或者 自己与该用户的对话
									sq5="select No,replyId,replyedId,comment,time from WComment where momentId=? and state=1 and ( (replyId in (select fId from WFriends where uId=?) and replyedId in (select fId from WFriends where uId=?)) or (replyId in (?,?) and replyedId in (?,?)) ) order by time asc";
								}						
							//	String sq5 = "SELECT comment,replyId,replyedId,time FROM WComment where momentId=? order by time asc";	
								PreparedStatement ps5=conn.prepareStatement(sq5);
								//num=Integer.parseInt(num);
								ps5.setInt(1,num);							
								if(!id.equals(user)){
									ps5.setString(2,user);
									ps5.setString(3,user);
									
									ps5.setString(4,user);
									ps5.setString(5,id);
									ps5.setString(6,id);
									ps5.setString(7,user);
									
								}							
								ResultSet rs5 = ps5.executeQuery();
								 
								while(rs5.next()){
									String str_no = rs5.getString("No");
									int comment_no=Integer.parseInt(str_no);
									String comment = rs5.getString("comment");
									String replyId = rs5.getString("replyId");
									String replyedId = rs5.getString("replyedId");
									String timeTemp = rs5.getString("time");
									/*分离时间的小时，分等单独的信息*/		
									String hourTemp=timeTemp.substring(11,13);
									String minuteTemp=timeTemp.substring(14,16);
									
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
									
									out.print("<span class='one_comment'><span class='comment_head_img'><a href=wmyPost.jsp?username="+replyId+"><img src="+head_url+"></a></span>");
									if(replyedId.equals(replyId)){
										//out.println(replyId+"："+comment+"<br>");
										//out.println(hourTemp+":"+minuteTemp);
										out.print("<span class='comment_user_id'>");
										out.print(replyId);
										out.print("</span>");				
									//	out.print("："+comment);									
										out.print("：");      //用<c:out>标签可以防止html标签攻击
									%>
										<span class="comment_text"><c:out value="<%=comment%>"></c:out></span>
									<%										
										out.print("<br>");
										out.print("<span class='comment_time'>"+hourTemp+":"+minuteTemp+"</span>");
									}
									else{
										//out.println(replyId+" @ "+replyedId+"："+comment+"<br>");
										//out.println(hourTemp+":"+minuteTemp);
										out.print("<span class='comment_user_id'>");
										out.print(replyId);
										out.print("</span>");
										out.print(" @ ");
										out.print("<span class='comment_user_id'>");
										out.print(replyedId);
										out.print("</span>");
									//	out.print("："+comment);
										
										out.print("：");      //用<c:out>标签可以防止html标签攻击
									%>
										<span class="comment_text"><c:out value="<%=comment%>"></c:out></span>
									<%										
										out.print("<br>");
										out.print("<span class='comment_time'>"+hourTemp+":"+minuteTemp+"</span>");
									}								
									%>							
									<!-- 二级评论按钮 -->
									<div class="login-put2">
										<input type="image" 
											name="button" src="img/default/feed_comment.png"
											onClick="javascript:show2(this,<%=tmp2%>);return false;">
									</div>							
									<% 
									if(replyId.equals(user)){     //当前用户才拥有权限删除自己的评论
									%>
										<!--  
										<a href="deleteComment.jsp?num=<%=comment_no%>&url=<%="woneMoment.jsp?"%>momentId=<%=number%>">Delete</a>
										-->
										<a class="delComment" href='javascript:;' onclick="javascript:delComment(<%=comment_no%>);">Delete</a>
									<% 
									}
									%>								
									<br>																							
									<!-- 二级评论框 -->																						
									<div class="div2" name="div2" style="display:none">													
										<form name="form_comment_2" method="post" action="" autocomplete="off">	
											<input type="text" class="text02" name="text02" placeholder="回复..." maxlength="140">
											<span class="button01">				
												<button type="button" 
														name="&num=<%=num%>&replyId=<%=user%>&replyedId=<%=replyId%>"
														onclick="javascript:saveComment2(this,<%=tmp%>,<%=tmp2%>);">发 送</button>
											</span>						
										</form> 
									</div>																								
							<%
									out.print("</span>");
									tmp2++;
								}
								ps5.close();							 
							%>
							<div class="cment" name="cment"></div>	
						</div>					
											
					</td>
				</tr>			
			</table>
		</div>		
		<%	
				}	
				ps4.close();				
			}			
			ps2.close();
			conn.close();
								
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
		<script src="./js/global.js"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="./js/check.js"></script>		 
		<script type="text/javascript" src="./js/jquery.qqFace.js"></script>
	</body>
</html>