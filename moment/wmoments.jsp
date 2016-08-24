<%@ page language="java" import="java.sql.*,java.lang.Object,java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<title>sixchat-从未如此接近</title>	
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<link href="./css/wtop.css" rel="stylesheet" type="text/css" />
	<link href="./css/moments.css" rel="stylesheet" type="text/css" />
	<link href="./css/wmyInfo.css" rel="stylesheet" type="text/css" />
	<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
	<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
	<script src="./js/formatImg.js"></script>
	</head>
	<body>
	<%@include file="conn.jsp"%>
	<% 	
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
			
		String sq3 = "SELECT uImageurl from WUsers where uId=?";			
		PreparedStatement ps3=conn.prepareStatement(sq3);
		ps3.setString(1,user);
		ResultSet rs3 = ps3.executeQuery();	
		while(rs3.next()){
			String personalUrl=rs3.getString("uImageurl");
			%>
	<div class="personal">
		<a href="wpersonal.jsp?username=<%=user%>">
			 <img src="<%out.print(personalUrl);%>" alt="image" width="100" height="100">
		</a>
	</div>
	<%	
		}
		ps3.close();
	%>

	<div id="divImage" style="display:none"></div>
	
	<div class="top">
		<div class="logo"> 
			<a href="http://119.29.24.253">
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

	<div class="sendTop">
		<span id="tell">something ?!,.</span>
		<form name="loginForm" action="wnewMoments.jsp" method="post" enctype="multipart/form-data" autocomplete="off">
			<div id="send_text">
				<textarea id="saytext" name="info" placeholder="这里输入内容..." maxlength="280"></textarea>
			</div>		
			<div id="permission">
				<span class="emotion">表情</span>
				<button type="button" title="@好友" onclick="showMention()">提醒</button>
				<button type="button" title="不给谁看" onclick="showBlock()">隐藏</button>
				<button type="button" title="插入图片" onclick="this.form.file.click()">图片</button>
			</div>		
			<input type="file" name="file" id="file"  class="ifile">
			<div id="upload_send">
				<button type="button" onclick="validate()">发 布</button>						
			</div>	
			<div class="mentionPeople" name="mentionPeople"	style="display:none;background-color:#ECF0F1;">
				<%
					String sq7 = "SELECT fId from WFriends where uId=?";			
					PreparedStatement ps7=conn.prepareStatement(sq7);
					ps7.setString(1,user);
					ResultSet rs7 = ps7.executeQuery();	
					while(rs7.next()){					
						String fId=rs7.getString("fId");
				%>
					<input name="mentions" type="checkbox" value="<%=fId%>"><%=fId%>
				<%
					}
					ps7.close();
				%>
			</div>	
			<div class="blockPeople" name="blockPeople" style="display:none;background-color:#BDC3C7;">
				<%
					String sq8 = "SELECT fId from WFriends where uId=?";			
					PreparedStatement ps8=conn.prepareStatement(sq8);
					ps8.setString(1,user);
					ResultSet rs8 = ps8.executeQuery();	
					while(rs8.next()){					
						String fId=rs8.getString("fId");
				%>
					<input name="blocks" type="checkbox" value="<%=fId%>"><%=fId%>
				<%
					}
					ps8.close();
				%>
			</div>
		</form>
	</div>
<!--  
	<div class="notice">
		<b><span>感受 阳光洒满肩上的夏天  »</span></b><br>
		<hr>
	</div>
-->
	<%
	int musicId=0;
	String sqlMusic="call music_of_today();";
	PreparedStatement psMusic=conn.prepareStatement(sqlMusic);		
	ResultSet rsMusic = psMusic.executeQuery();
	if(rsMusic.next()){
		String str=rsMusic.getString("musicId");
		musicId=Integer.parseInt(str);
	}
	psMusic.close();
	%>

	<div class="music">
	<iframe frameborder="no" border="0" paddingheight="0" marginwidth="0" marginheight="0" width=588 height=42 src="http://music.163.com/outchain/player?type=2&id=<%=musicId %>&auto=0&height=32"></iframe>
	</div>
	<% 
		request.setCharacterEncoding("UTF-8");		
	
		String page_str = request.getParameter("page");
		int page_num = 0;
		if(page_str!=null){
			page_num=Integer.parseInt(page_str);
		}
	
	
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间
		String Time = formatter.format(currentTime); //将日期时间格局化
		//String str_date2 = currentTime.toString(); //将Date型日期时间转换成字符串形式								
		//通过数据库选择只显示好友的朋友圈和有权限看到的朋友圈   类似朋友圈权限版本
		//String sq2="select uId,Info,Imageurl,Time,No from WMoments where state=1 and uId in (select fId from WFriends where uId=?) and No not in (select momentId from WBlock where blockedId=?) order by Time desc limit 0,100";
			
		//查看所有有权限看到的朋友圈 不局限是好友  类似微博权限版本
		String sq2="select uId,Info,Imageurl,Time,No from WMoments where state=1 and No not in (select momentId from WBlock where blockedId=?) order by Time desc limit ?,10";
			
		PreparedStatement ps2=conn.prepareStatement(sq2);
		ps2.setString(1,user);
		//ps2.setString(2,user);	//只显示好友的朋友圈和有权限看到的朋友圈 即朋友圈权限版本时启用本句
		
		ps2.setInt(2,page_num*10);
			
		ResultSet rs = ps2.executeQuery();
		int tmp=0;			//计算朋友圈条数的变量
		int tmp2=0;    //计算朋友圈的评论条数
		while(rs.next()){
			String id = rs.getString("uId");
			String info = rs.getString("Info");
			String imageurl = rs.getString("Imageurl");
			String time = rs.getString("Time");
			String str = rs.getString("No");
			int num=Integer.parseInt(str);
								
			/* replaceAll用到正则表达式将字符串中所有的“<”“>”替换成空字符*/
			//id=id.replaceAll("<|>","");
			//info=info.replaceAll("<|>","");								
								
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
	<div class="mainInfo">
		<table>
			<!-- 输出id行 -->
			<tr>
				<td rowspan="4" style="width:60px;">
					<div class="headImage">
						<a href="wmyPost.jsp?username=<%=id%>"> 
							<img src="<%out.print(touxiang);%>" alt="image" width="50" height="50" >
						</a>
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
						<img src="<%out.print(imageurl);%>" alt="image" onload="formatImg(this)" onclick="clickImg(this)">
						-->
						<a href="wfullImage.jsp?imageurl=<%out.print("momentsImages/"+url);%>"
							style="font-weight:bold;text-decoration : none;"> 
							<img src="<%out.print(imageurl);%>" alt="image" onload="formatImg(this)">
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
								out.println(month+"月"+day+"日"+" "+hour+":"+minute+" ");
								if(id.equals(user)){     //当前用户才拥有权限删除自己的朋友圈
							%>
									<!--添加删除功能-->
									<!--  
									<a href="wdelete.jsp?num=<%=num%>&url=wmoments.jsp?page=<%=page_num%>">Delete</a>
									-->
									<a class="delMoment" href='javascript:;' onclick="javascript:delMoment(<%=num%>);">Delete</a>
							<%
								}
							%>
						</div>

						<!-- 一级评论按钮 -->
						<div class="login-put">				
							<button type="button" name="button" class="sub_btn" onClick="javascript:show(<%=tmp%>);return false;">&#5867 &#5867</button>
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
			
					<!-- 显示所有点赞的用户 -->
					<div class="line4" name="line4" style="display:none">
						<div class="like_me" name="like_me">
							<img src="img/default/like_people.png">
							<%	
							//	朋友圈权限版本
							//	//String sq6 = "SELECT likeId FROM Wlike where momentId=? and state=1 order by No asc";	
							//	//只有互为好友时才能看到点赞
							//	String sq6 = "SELECT Wlike.likeId FROM Wlike,WFriends where Wlike.momentId=? and Wlike.state=1 and WFriends.uId=? and WFriends.fId=Wlike.likeId order by Wlike.No asc";	
							//	PreparedStatement ps6=conn.prepareStatement(sq6);
							//	//num=Integer.parseInt(num);
							//	ps6.setInt(1,num);
							//	ps6.setString(2,user);
							//	ResultSet rs6 = ps6.executeQuery();		
							//	while(rs6.next()){			
							//	                                     //若有赞则显示点赞行，无则隐藏
							//		String likeId = rs6.getString("Wlike.likeId");
							//		out.println(likeId+",");
							//	}
							//	ps6.close();
							//	
								
								//微博权限版本
								String sq6;
								if(id.equals(user)){	//浏览自己的帖子可以看到所有赞包括好友与非好友
									sq6 = "SELECT likeId FROM Wlike where momentId=? and state=1 order by No asc";
									PreparedStatement ps6=conn.prepareStatement(sq6);
									ps6.setInt(1,num);
									ResultSet rs6 = ps6.executeQuery();		
									while(rs6.next()){			
										%><script>document.getElementsByName("line4")[<%out.print(tmp);%>].style.display="block";</script>
										<% //若有赞则显示点赞行，无则隐藏
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
										%><script>document.getElementsByName("line4")[<%out.print(tmp);%>].style.display="block";</script>
										<% //若有赞则显示点赞行，无则隐藏
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
							
								PreparedStatement ps5=conn.prepareStatement(sq5);
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
										out.print("<span class='comment_user_id'>");
										out.print(replyId);
										out.print("</span>");																							
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
										out.print("：");
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
										<a href="deleteComment.jsp?num=<%=comment_no%>&url=wmoments.jsp?page=<%=page_num%>">Delete</a>
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
				tmp++;
			}			
			ps2.close();
			conn.close();
	%>
	<div id="page">
		<a href="wmoments.jsp?page=<%=page_num-1%>">上一页</a>
		<span>|</span>
		<a href="wmoments.jsp?page=<%=page_num+1%>">下一页</a>
	</div>
	<div id="footer">
		Copyright © 2015-2016 SIXCHAT 深圳两十两网络技术有限公司<br>
		—— 削笔工作室 Tel:18503056101 ——
	</div>
		<script src="./js/global.js"></script>	
		<!--  
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		-->
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="./js/check.js"></script>		 
		<script type="text/javascript" src="./js/jquery.qqFace.js"></script>
			
	</body>
</html>