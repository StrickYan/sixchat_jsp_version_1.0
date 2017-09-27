/**
 * 
 */
function trimLR(str) {	//去掉str左右两边空格
	var whitespace = ' \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000';
	for (var i = 0; i < str.length; i++) {
		if (whitespace.indexOf(str.charAt(i)) === -1) {
			str = str.substring(i);
			break;
		}
	}
	for (i = str.length - 1; i >= 0; i--) {
		if (whitespace.indexOf(str.charAt(i)) === -1) {
			str = str.substring(0, i + 1);
			break;
		}
	}
	return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}
function validate(){
    loginForm.info.value=trimLR(loginForm.info.value);   	
    if(loginForm.info.value==""&&loginForm.file.value==""){
      // alert("请输入内容");
       document.loginForm.info.focus();//聚焦
       return;
   }
   loginForm.submit();
}		
function clickImg(obj){
    var value = document.getElementById("divImage").style.display;
    if(value=="none"){
        document.getElementById("divImage").style.display="block";	
    }
    else{
        document.getElementById("divImage").style.display="none";					
    }
    var dv=document.getElementById("divImage");
    dv.innerHTML="<img src="+obj.src+" />";

} 	
function showMention(){
    var value = document.getElementsByName("mentionPeople")[0].style.display;
    if(value=="none"){
        document.getElementsByName("mentionPeople")[0].style.display="block";	
    }
    else
        document.getElementsByName("mentionPeople")[0].style.display="none";	
}  	

function showBlock(){
    var value = document.getElementsByName("blockPeople")[0].style.display;
    if(value=="none"){
        document.getElementsByName("blockPeople")[0].style.display="block";	
    }
    else
        document.getElementsByName("blockPeople")[0].style.display="none";	
}  
var xmlRequest = null;   
function initXMLRequest() {   
    if (window.ActiveXObject) {   
        xmlRequest = new ActiveXObject("Microsoft.XMLHTTP");   
    } else {   
        if (window.XMLHttpRequest) {   
            xmlRequest = new XMLHttpRequest();   
        }   
    }   
}
function sendHTTPRequest() {
    initXMLRequest();
    var url = "wsearchNews.jsp";	//调用的页面
    if (xmlRequest) {   
        xmlRequest.open("POST", url, true);
        xmlRequest.send(); 
        xmlRequest.onreadystatechange = isDataExists; 
        //使用方法回调，每30秒调用一次
        setTimeout("sendHTTPRequest()",30000);
    }   
}   
function isDataExists() {   
    if (xmlRequest.readyState == 4) {   
        if (xmlRequest.status == 200) {
            //alert("调用成功!");
            news.innerHTML=xmlRequest.responseText;
        }
    }
}
function show(tmp)//弹出一级评论框
{
    var value = document.getElementsByName("div1")[tmp].style.display;
    if(value=="none"){
        document.getElementsByName("div1")[tmp].style.display="block";	
        document.getElementsByName("text01")[tmp].focus();//聚焦
    }
    else
        document.getElementsByName("div1")[tmp].style.display="none";	

}   
function saveLike(obj,tmp){	//点赞响应函数
    var xmlHttp;
    var like_me=document.getElementsByName("like_me")[tmp];												
    if(window.ActiveXObject)
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");			
    else if(window.XMLHttpRequest)
        xmlHttp = new XMLHttpRequest();				
    url ="wlike.jsp?" + obj.name;		
    xmlHttp.open("POST",url,true);
    xmlHttp.onreadystatechange = function(){
        if(xmlHttp.readyState == 4 && xmlHttp.status == 200){	
        //document.getElementsByName(obj.name)[0].value="已赞";	//发送成功后改变valve值
        document.getElementsByName("line4")[tmp].style.display="block";		//发送成功后显示点赞行													
        like_me.innerHTML = xmlHttp.responseText;						
        }
    }						
    xmlHttp.send(null);					
}
function saveComment(obj,tmp){	//保存一级评论框内容
    var comment=document.getElementsByName("text01")[tmp].value;
    comment=trimLR(comment);   	
    if(comment==""){
      // alert("请输入内容");
       document.getElementsByName("text01")[tmp].focus();//聚焦
       return;
    }		
    var xmlHttp;
    var cment=document.getElementsByName("cment")[tmp];								
    if(window.ActiveXObject){
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
    }					
    url="waddComment.jsp?txt=" + comment + obj.name;									
    xmlHttp.open("POST",url,true);
    xmlHttp.onreadystatechange = function(){
        if(xmlHttp.readyState == 4 && xmlHttp.status == 200){	
            document.getElementsByName("text01")[tmp].value=""; //发送成功后清空文本框
            document.getElementsByName("div1")[tmp].style.display="none";	//发送成功后隐藏文本框							
            //cment.innerHTML = xmlHttp.responseText;

            var new_comment=document.createElement("span");
            new_comment.setAttribute("class", "one_comment");
            new_comment.innerHTML = xmlHttp.responseText;
            cment.parentNode.insertBefore(new_comment,cment);
        }
    }									
    xmlHttp.send(null);					
}								
function show2(obj,tmp2){	//弹出二级评论框
    var value = document.getElementsByName("div2")[tmp2].style.display;
    if(value=="none"){
        document.getElementsByName("div2")[tmp2].style.display="block";	
        document.getElementsByName("text02")[tmp2].focus();//聚焦
    }
    else
        document.getElementsByName("div2")[tmp2].style.display="none";	
}    
function saveComment2(obj,tmp,tmp2){				
    var comment=document.getElementsByName("text02")[tmp2].value;
    comment=trimLR(comment);   	
    if(comment==""){
      // alert("请输入内容");
       document.getElementsByName("text02")[tmp2].focus();//聚焦
       return;
    }			
    var xmlHttp;
    var cment=document.getElementsByName("cment")[tmp];	
    if(window.ActiveXObject){
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
    }		
    url="waddComment.jsp?txt=" + comment + obj.name;		
    xmlHttp.open("POST",url,true);
    xmlHttp.onreadystatechange = function(){
        if(xmlHttp.readyState == 4 && xmlHttp.status == 200){	
            document.getElementsByName("text02")[tmp2].value=""; //发送成功后清空文本框
            document.getElementsByName("div2")[tmp2].style.display="none";	//发送成功后隐藏文本框							
            //cment.innerHTML = xmlHttp.responseText;	

            var new_comment=document.createElement("span");
            new_comment.setAttribute("class", "one_comment");
            new_comment.innerHTML = xmlHttp.responseText;
            cment.parentNode.insertBefore(new_comment,cment);
        }
    }									
xmlHttp.send(null);					
}
function delMoment(num){
    var xmlHttp;						
    if(window.ActiveXObject){
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
    }		
    url="wdelete.jsp?num="+num;						
    xmlHttp.open("POST",url,true);								
    xmlHttp.send(null);					
}
function delComment(comment_no){
    var xmlHttp;						
    if(window.ActiveXObject){
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequest){
        xmlHttp = new XMLHttpRequest();
    }	
    url="deleteComment.jsp?num="+comment_no;							
    xmlHttp.open("POST",url,true);								
    xmlHttp.send(null);					
}
function addLoadEvent(func) {
      var oldonload = window.onload;
      if (typeof window.onload != 'function') {
          window.onload = func;
      } 
      else {
          window.onload = function() {
            oldonload();
            func();
          }
      }
}
addLoadEvent(sendHTTPRequest);
function showUpdateInfo(){
    var value = document.getElementById("updateinfo").style.display;
    if(value=="none"){
        document.getElementById("updateinfo").style.display="block";	
    }
    else
        document.getElementById("updateinfo").style.display="none";	
} 
