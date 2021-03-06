<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
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
		<title>角色更新页面</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
        <script type="text/javascript" src="resource/jquery.ajaxfileupload.js"></script>
        <script type="text/javascript">
        $(function(){
        	 $('#photo').ajaxfileupload({
                 'action': 'sys/role/upload',//上传路径
                 'valid_extensions' : ['gif','png','jpg','jpeg','bmp'],//允许上传的格式
                 'onComplete': function(data) {
                    $("#role_photo").val(data.newName);
                    //改变图片
                    $("img").attr("src","upload/role/"+data.newName);
                    //移除属性
                    $("#photo").removeAttr("name");
                   
                  }
             });
        });
        
        //角色更新操作
        function toSub(){
        	var role_name = $.trim($("#role_name").val());
        	var role_desc = $.trim($("#role_desc").val());
        	if(role_name.length==0){
        		alert("请输入角色信息");
        		$("#role_name").focus();
        		return false;
        	}
        	//第一种情况
        	var old_role_name =$("#old_role_name").val();
        	if(old_role_name==role_name){//没有改名字，那么久直接提交
        		
        		$("#roleForm").submit();
        		return false;
        	}else{
        		$.post("sys/role/name",{role_name:role_name},function(data){
        			
        			if(data.flag=="success"){
        				$("#roleForm").submit();
                        return false;
        			}else{
        				$("#role_name").val(old_role_name);
        				alert(data.message);
                        return false;
        			}
        		})
        	}
        	
        }
        
        </script>
    </head>

<body>

	<div class="formbody">
	    <div class="formtitle">
	       <span>角色更新信息</span>
	    </div>
	    <form:form action="sys/role/update" method="put" id="roleForm" commandName="role">
	    <ul class="forminfo">
	        <li>
	            <label>角色名称</label>
	            <form:input path="role_name" cssClass="dfinput" maxlength="10"/><i>角色名称不能重复</i>
	        </li>
	        <li>
	            <label>选择图片</label>
	            <input id="photo" name="photo" type="file" class="dfinput"/>
	        </li>
	        <li>
	            <label>&nbsp;</label>
	            <img alt="暂无数据" title="${role.role_name }" 
	            src="upload/role/${role.role_photo }" 
	            style="width: 168px;height: 126px;">
	        </li>
	        <li>
	            <label>职能描述</label>
	            <form:textarea path="role_desc" cssClass="textinput" placeholder="请输入角色描述" />
	        </li>
	        <li><label>&nbsp;</label>
	            <input type="button" class="btn" value="更新角色" onclick="toSub()"/>
	            <input type="button" class="btn" value="关闭窗口" onclick="toClose()"/>
	        </li>
	    </ul>
	    <!-- 隐藏域 -->
	    <form:hidden path="role_id"/>
	    <form:hidden path="role_photo"/>
	    <input type="hidden" id="old_role_name" value="${role.role_name }">
	    </form:form>
	
	
	</div>


</body>

</html>
