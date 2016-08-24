/**
 * 
 */
			function changeMusic(){
				var myDate = new Date();
 	  			// 随机换背景音乐
 				flag = myDate.getSeconds();        //获取当前秒数(0-59)
 				flag = flag%11;
  				var music= document.getElementById('music');
				music.setAttribute("src","music/"+flag+".mp3");
			}
			addLoadEvent(changeMusic);