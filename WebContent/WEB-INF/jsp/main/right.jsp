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
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<%-- 
		参考文章:http://www.cnblogs.com/muqianying/archive/2012/03/16/2400280.html
		--%>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<title>主页面</title>
		<link href="resource/admin/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="resource/admin/js/jquery.js"></script>
		<script type="text/javascript">
		$(function(){
			toShowDate();
			
		});
		
		function toShowDate(){
			var date = new Date();
			//获取当前的小时
			var hours = date.getHours();
			var str = "";
			if(hours<6){
				str = "凌晨好";
			}
			else if(hours<9){
				str = "早上好";
			}
			else if(hours<12){
                str = "上午好";
            }
			else if(hours<14){
                str = "中午好";
            }
			else if(hours<17){
                str = "下午好";
            }
			else if(hours<19){
                str = "傍晚好";
            }
			else if(hours<22){
                str = "晚上好";
            }else{
            	str = "深夜好";
            }
			$("#title").html(str);
		}
		</script>

</head>


<body>

    <div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li>首页</li>
    </ul>
    </div>
    
    <div class="mainindex">
    
    
    <div class="welinfo">
    <span><img src="resource/admin/images/sun.png" alt="天气" /></span>
    <b><span id="title"></span>${sessionScope.session_user.account }，欢迎使用权限管理系统</b>(hanpang8983@foxmail.com)
    <a href="#">帐号设置</a>
    </div>
    
    <div class="welinfo">
    <span><img src="resource/admin/images/time.png" alt="时间" /></span>
    <i>您上次登录的时间：2013-10-09 15:22</i> （不是您登录的？<a href="#">请点这里</a>）
    </div>
    
    <div class="xline"></div>
    
    <ul class="iconlist">
    
    <li><img src="resource/admin/images/ico01.png" /><p><a href="#">管理设置</a></p></li>
    <li><img src="resource/admin/images/ico02.png" /><p><a href="#">发布文章</a></p></li>
    <li><img src="resource/admin/images/ico03.png" /><p><a href="#">数据统计</a></p></li>
    <li><img src="resource/admin/images/ico04.png" /><p><a href="#">文件上传</a></p></li>
    <li><img src="resource/admin/images/ico05.png" /><p><a href="#">目录管理</a></p></li>
    <li><img src="resource/admin/images/ico06.png" /><p><a href="#">查询</a></p></li> 
            
    </ul>
    
    <div class="ibox"><a class="ibtn"><img src="resource/admin/images/iadd.png" />添加新的快捷功能</a></div>
    
    <div class="xline"></div>
    <div class="box"></div>
    
    <div class="welinfo">
    <span><img src="resource/admin/images/dp.png" alt="提醒" /></span>
    <b>Uimaker信息管理系统使用指南</b>
    </div>
    
    <ul class="infolist">
    <li><span>您可以快速进行文章发布管理操作</span><a class="ibtn">发布或管理文章</a></li>
    <li><span>您可以快速发布产品</span><a class="ibtn">发布或管理产品</a></li>
    <li><span>您可以进行密码修改、账户设置等操作</span><a class="ibtn">账户管理</a></li>
    </ul>
    
    <div class="xline"></div>
    
    <div class="uimakerinfo"><b>查看Uimaker网站使用指南，您可以了解到多种风格的B/S后台管理界面,软件界面设计，图标设计，手机界面等相关信息</b>(<a href="http://www.uimaker.com" target="_blank">www.uimaker.com</a>)</div>
    
    <ul class="umlist">
    <li><a href="#">如何发布文章</a></li>
    <li><a href="#">如何访问网站</a></li>
    <li><a href="#">如何管理广告</a></li>
    <li><a href="#">后台用户设置(权限)</a></li>
    <li><a href="#">系统设置</a></li>
    </ul>
    
    
    </div>
    
    

</body>

</html>