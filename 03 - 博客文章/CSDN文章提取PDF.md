---

---
--- 

> 本文摘自CSDN文章“# 【新】CSDN文章一键打印、输出PDF（自动阅读全文、全清爽模式）”，原文作者JavonPeng，原文链接[https://blog.csdn.net/p1279030826/article/details/106602341]
# F12打开开发人员工具，在控制台输入以下内容：

```js
(function(){
	'use strict';
	var articleBox = $("div.article_content");
	articleBox.removeAttr("style");
	$(".hide-preCode-bt").parents(".author-pjw").show();
	$(".hide-preCode-bt").parents("pre").removeClass("set-code-hide");
	$(".hide-preCode-bt").parents(".hide-preCode-box").hide().remove();
	$("#btn-readmore").parent().remove();
	$("#side").remove();
	$(".csdn-side-toolbar, .template-box, .blog-footer-bottom, .left-toolbox, .toolbar-inside").remove();
	$(".comment-box, .recommend-box, .more-toolbox, .article-info-box, .column-group-item").remove();
	$("aside, .tool-box, .recommend-nps-box, .skill-tree-box").remove();
	$("main").css('display','content'); 
	$("main").css('float','left'); 
	$("#mainBox").width("100%");		
	document.getElementsByTagName('body')[0].style.zoom=0.8;
	window.print();
})();
```

会自动启动PDF打印机，设置相关参数然后保存即可。