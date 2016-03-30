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
		<title>欢迎登录后台管理系统</title>
		<!-- 使用动态包含 -->
		<jsp:include page="/resource/include.jsp"/>
        <script src="resource/admin/js/cloud.js" type="text/javascript"></script>
        <script type="text/javascript" src="resource/jquery.md5.js"></script>
		<script language="javascript">
			$(function() {
				$('.loginbox').css({
					'position' : 'absolute',
					'left' : ($(window).width() - 692) / 2
				});
				$(window).resize(function() {
					$('.loginbox').css({
						'position' : 'absolute',
						'left' : ($(window).width() - 692) / 2
					});
				})
		
			});
		</script>
		<script type="text/javascript">
		        function toSub(){
		            /*在JavaScript当中定义函数，两种:
		              1. function 方法名(){}  有名函数--定义式        先调用后声明
		              2. var 变量名=function(){} 匿名函数--变量式 先声明后调用
		            */
		            var account = document.getElementById("account").value;
		            var password = document.getElementById("password").value;
		           
		            
		            if(account.length==0||account.length>16){
		                alert("账号输入有误请重新核对！");
		                document.getElementById("account").focus();
		                return false;
		            }
		            
		            if(password.length==0){
		                alert("请输入密码信息！");
		                document.getElementById("password").focus();
		                return false;
		            }
		            var code = $.trim(document.getElementById("code").value);
		            
		            if(code.length==0){
		            	alert("请输入验证码！");
		                document.getElementById("code").focus();
		                return false;
		            }
		            
		            
		            //对密码进行重新赋值
		            $("#password").val($.md5(password));
		         
		            
		            return true;
		            
		        }
		        $(function(){
		        	document.getElementById("account").focus();
		        	$("img").click(function(){
		        		this.src="sys/code?"+(new Date()).getTime();//使用时间戳，欺骗浏览器，都是一个新的请求，注意有问号
		        	});
		        });
		       
		</script>

</head>

<body
	style="background-color: #1c77ac; background-image: url(resource/admin/images/light.png); background-repeat: no-repeat; background-position: center top; overflow: hidden;">

	<!-- 漂浮云效果 开始-->
	<div id="mainBody">
		<div id="cloud1" class="cloud"></div>
		<div id="cloud2" class="cloud"></div>
	</div>
	<!-- 漂浮云效果 结束-->

	<!-- 顶部导航 -->
	<div class="logintop">
		<span>欢迎登录后台管理界面平台</span>
		<ul>
			<li><a href="javascript:void(0)">帮助</a></li>
			<li><a href="javascript:void(0)">关于</a></li>
		</ul>
	</div>
	<!-- 顶部导航 -->
	<div class="loginbody">
		<span class="systemlogo"></span>
		<!-- 登录表单开始 -->
		<form action="sys/login" method="post" onsubmit="return toSub()">
		<div class="loginbox">
			<ul>
				<li><input name="account" id="account" type="text"
					class="loginuser" placeholder="请输入账号" value="${account }"/></li>
				<li><input name="password" id="password" type="text"
					class="loginpwd" placeholder="请输入密码" /></li>
				<li><input name="code" id="code" type="text" class="logincode"
					placeholder="请输入验证码" /> <img src="sys/code" alt="没有图片"
					title="看不清楚,点击一下"
					style="position: absolute; left: 490px; width: 135px; height: 45px;" />
				</li>
				<li><input type="submit" class="loginbtn" value="登录" /> 
					<label style="color: red;">
							<!-- 可以用于错误提示功能 --> 
					   ${message }
							<!--
	                        <input name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a href="#">忘记密码？</a>
	                        -->
					</label>
				</li>
			</ul>
		</div>
		</form>
		<!-- 登录表单结束 -->

	</div>

	<div class="loginbm">
		&reg;2015 <a href="http://www.cnblogs.com/pangxiansheng/">胖先生</a><sup>&copy;</sup>
		仅供学习交流，勿用于任何商业用途
	</div>


</body>

</html>
