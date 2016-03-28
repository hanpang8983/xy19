<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//项目的发布路径，例如:  /rabc
	String path = request.getContextPath();
	/*
	全路径，形式如下: http://127.0.0.1:8001/rbac/
	request.getScheme()      ——> http 获取协议
	request.getServerName()  --> 127.0.0.1 获取服务名
	request.getServerPort()  --> 8001 获取端口号
	path                     --> /rbac 获取访问的路径 路
	*/
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
        <%-- 
		  参考文章:http://www.cnblogs.com/muqianying/archive/2012/03/16/2400280.html
		--%>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<title>信息管理系统界面</title>
		<!-- 动态包含引入静态文件 -->
		
		<style type="text/css">
		* {
			padding: 0;
			margin: 0;
		}
		
		html, body {
			height: 100%;
			border: none 0;
		}
		</style>
		<!-- 动态包含引入静态文件 -->
		<jsp:include page="/resource/include.jsp"/>
		

</head>
<body>

	<!-- 使用iframe加载右侧内容 -->
	<iframe src="sys/frameset/index" id="myIframe" scrolling="no" frameborder="0"></iframe>
	<script type="text/javascript">
		window.dialog = dialog;
	</script>

	<!-- iframe自适应高度，Iframe显示不完整 -->
</body>
</html>
<script type="text/javascript">
	$(function() {
		$("#myIframe").width($(window).width());
		$("#myIframe").height($(window).height());

		//给window绑定重置事件
		$(window).resize(function() {
			$("#myIframe").width($(window).width());
			$("#myIframe").height($(window).height());

		});
	});
</script>