<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<title>查看大图</title>
		<link rel="icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="img/default/my.ico" type="image/x-icon" />
		<link rel="bookmark" href="img/default/my.ico" type="image/x-icon" />
		<script>
			function formatImg(imgObject){
           		if(imgObject.height > 864 || imgObject.width > 1366){
                	var hw = imgObject.height/imgObject.width;
                	var hh = imgObject.height/864;
                	var ww = imgObject.width/1366;
                	if (hh>ww) {
                    	imgObject.height = 864;
                    	imgObject.width = 864/hw;
                	} else {
                    	imgObject.height = 1366*hw;
                    	imgObject.width = 1366;
                	}
            	}     
            	//imgObject.height = 864;
            	//imgObject.width = 1366;
 			
            //	var img= document.getElementById('image');
			//	img.style.position="absolute";
			//	img.style.left="50%";
			//	img.style.top="50%";
			//	img.style.margin=imgObject.height/-2+" "+"0"+" "+"0"+" "+imgObject.width/-2;
        	}
		</script>
		<style>
			body {
				text-align:center;
				background:rgb(243,243,243);
			}	
			img {
				width:50%;
				cursor:pointer;
			}
		</style>
	</head>
	<body>
		<% 
		request.setCharacterEncoding("UTF-8");
		String imageurl=request.getParameter("imageurl");
		%>
		<div id="image">
		<img src="<%out.print(imageurl);%>" alt="image" onclick="history.back(1);">
		</div>
	</body>
</html>