$(function(){

    // 绑定删除朋友圈事件
    $(".mainInfo").delegate(".delMoment", "click", function(){
        $(this).parents('div').slideUp('slow', function() {
            //$(this).remove();
        });
    });
    
    // 绑定删除评论事件
    $(".comment").delegate(".delComment", "click", function(){
        $(this).parents('span').slideUp('slow', function() {
            //$(this).remove();
        });
    });
    
    /*
    // 绑定删除评论事件
    $(".cment").delegate(".delCment", "click", function(){
        $(this).parents('span').slideUp('slow', function() {
            //$(this).remove();
        });
    });
    */
	
	$('.emotion').qqFace({
		id : 'facebox', //表情视图区域的ID
		assign:'saytext', //插入表情的内容区域
		path:'face/'	//表情存放的路径
	});
	
	$(".info").each(function(){
		var str = $(this).text();
		$(this).html(replace_em(str));
	});
	
	$(".comment_text").each(function(){
		var str = $(this).text();
		$(this).html(replace_em(str));
	});
})

function replace_em(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br />');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img src="face/$1.gif" border="0" />');
	
	//文本中url替换成可点击的链接 target='_blank'指明打开新窗口
	var regexp = /((http|ftp|https|file):[^'"\s]+)/ig;
	str = str.replace(regexp,"<a target='_blank' href='$1'>$1</a>");
	
	return str;
}
