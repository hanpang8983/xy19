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
		<title>头部页面</title>
        <!-- 动态包含引入静态文件 -->
        <jsp:include page="/resource/include.jsp"/>
		<script type="text/javascript">
		$(function(){   
		    //顶部导航切换
		    $(".nav li a").click(function(){
		        $(".nav li a.selected").removeClass("selected")
		        $(this).addClass("selected");
		    })  
		})  
		</script>
		<script type="text/javascript">
		function toLoginOut(){
		    if(window.confirm("您确定要退出该系统吗")){
		        window.top.location.href="sys/loginOut";
		    }
		}
		//修改密码口令
		function toUpdatePWD(){
            var d = top.dialog({
                width:700,
                height:300,
                url:'sys/user/password',//可以是一个访问路径Action|Servlet等或者jsp页面资源
                onclose: function () {
                if (this.returnValue=="success") {
                    alert("下次登录使用新密码!");
                    return false;
                    //window.location.href=window.location.href;
                }

            }
            });
            d.showModal();
        }
		
		</script>


</head>

<body style="background:url(resource/admin/images/topbg.gif) repeat-x;">

    <div class="topleft">
    <a href="sys/frameset/right" target="right"><img src="resource/admin/images/logo.png" title="系统首页" /></a>
    </div>
    <!--    
    <ul class="nav">
    <li><a href="default.html" target="rightFrame" class="selected"><img src="resource/admin/images/icon01.png" title="工作台" /><h2>工作台</h2></a></li>
    <li><a href="imgtable.html" target="rightFrame"><img src="resource/admin/images/icon02.png" title="模型管理" /><h2>模型管理</h2></a></li>
    <li><a href="imglist.html"  target="rightFrame"><img src="resource/admin/images/icon03.png" title="模块设计" /><h2>模块设计</h2></a></li>
    <li><a href="tools.html"  target="rightFrame"><img src="resource/admin/images/icon04.png" title="常用工具" /><h2>常用工具</h2></a></li>
    <li><a href="computer.html" target="rightFrame"><img src="resource/admin/images/icon05.png" title="文件管理" /><h2>文件管理</h2></a></li>
    <li><a href="tab.html"  target="rightFrame"><img src="resource/admin/images/icon06.png" title="系统设置" /><h2>系统设置</h2></a></li>
    </ul>
     -->         
    <div class="topright">    
    <ul>
    <li><span><img src="resource/admin/images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
    <li><a href="javascript:void(0)" onclick="toUpdatePWD()">变更口令</a></li>
    <li><a href="javascript:void(0)" onclick="toLoginOut()">安全退出</a></li>
    </ul>
     
    <div class="user">
    <span>${session_user.user_name }</span>
    <i>消息</i>
    <b>5</b>
    </div>    
    
    </div>

</body>
</html>