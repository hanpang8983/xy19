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
		<title>无标题文档</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
        <script type="text/javascript" src="resource/jquery.md5.js"></script>
	    <script type="text/javascript">
		   
	    
	        function toSub(){
		    	//获取新密码
	        	var old_password = $.trim($("#old_password").val());
	        	var password = $.trim($("#password").val());
	        	var new_password = $.trim($("#new_password").val());
	        	
	        	if(password.length==0){
	        		alert("请输入新密码");
	        		return false;
	        	}
	        	
	        	if(old_password==password){
	        		alert("新密码跟原密码一致，请重新输入!");
	        		return false;
	        	}
	        	
	        	if(new_password.length==0){
                    alert("请输入确认密码");
                    return false;
                }
	        	
	        	if(password!=new_password){
	        		alert("两次密码不一直，请重新输入!");
                    return false;
	        	}
	        	//加密密码
	        	$("#password").val($.md5(password));
	        	
	        	
	        	$("#userForm").submit();
	        	
	            
	        }
	        
	        //查询密码是否正确
	        function toSelectPWD(){
	        	var old_password = $.trim($("#old_password").val());
	        	if(old_password.length==0){
	        		return false;//没有任何反应
	        	}
	        	
	        	//使用Ajax进行查询操作
	        	$.post("sys/user/pwd",{old_password:$.md5(old_password)},function(data){
	        		if(data.flag=="success"){//密码正确
	        			//设置文本框为只读状态
	        			$("#old_password").prop("readonly",true);
	        		    //启动变更按钮
	        		    $(".btn_disable").prop("disabled",false);
	        		    $(".btn_disable").removeClass("btn_disable").addClass("btn");
	        		}else{//密码不正确
	        			alert(data.message);
	        		    return false;
	        		}
	        	});
	        }
	
	    </script>
	   
</head>

<body>


<div class="formbody">

    <div class="formtitle"><span>口令修改</span></div>
    <!-- 保存操作 -->
    <form action="sys/user/password" method="post" id="userForm">
    <ul class="forminfo">
        <li><label>原密码</label><input  id="old_password" type="password" class="dfinput" maxlength="10" placeholder="请输入原密码，长度不能超过10位"
                                        onchange="toSelectPWD()"/></li>
        <li><label>新密码</label><input name="password" id="password" type="password" class="dfinput" maxlength="10" placeholder="请输入新密码"/></li>
        <li><label>确认密码</label><input id="new_password" type="password" class="dfinput" maxlength="10" placeholder="再一次输入密码"/></li>
        <li>
            <label>&nbsp;</label>
            <!-- 这里我们练习一下disable的属性,默认情况下为不可用-->
            <input  type="button" class="btn_disable" value="变更口令" onclick="toSub();" disabled="disabled"/>
            <input  type="button" class="btn" value="关闭窗口" onclick="toClose();"/>
        </li>
    </ul>
     <!-- 隐藏域 -->
     <input type="hidden" name="_method" value="put">

    </form>


</div>


</body>

</html>
