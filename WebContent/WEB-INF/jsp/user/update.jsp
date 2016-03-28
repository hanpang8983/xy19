<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
		<title>用户管理之更新页面</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
        <!-- 引入Ajax上传操作 -->
        <script type="text/javascript" src="resource/jquery.ajaxfileupload.js"></script>
        <!-- 引入MyDate97插件 -->
        <script type="text/javascript" src="resource/admin/My97DatePicker/WdatePicker.js"></script>
	    <script type="text/javascript">
	    
	        function toSub(){
		    	var user_name = $.trim($("#user_name").val());
		    	
		    	var tel = $.trim($("#tel").val());
		    	
		    	if(user_name.length==0){
		    		alert("请输入你的姓名，快点!");
		    		$("#user_name").focus();
		    		return false;
		    	}
		    	
		    	if(tel.length==0){
                    alert("对电话我们只是输入就行，不验证!");
                    $("#tel").focus();
                    return false;
                }
		    	
		    	//直接提交表单即可，因为不修改账号
    			$("#userForm").submit();
    			return false;
	            
	        }
	
	    </script>
	    <script type="text/javascript">
        $(function(){
             $('#image').ajaxfileupload({
                 'action': 'sys/user/upload',//上传路径
                 'valid_extensions' : ['gif','png','jpg','jpeg','bmp'],//允许上传的格式
                 'onComplete': function(data) {
                	
                    $("#user_image").val(data.newName);
                    //移除属性
                    $("#image").removeAttr("name");
                  }
             });
        });
        </script>
</head>

<body>


<div class="formbody">

    <div class="formtitle"><span>系统用户基本信息&nbsp;|&nbsp;编辑</span></div>
    <!-- 更新操作，使用标签的形式,我忘记了 -->
    <form:form action="sys/user/update" method="put" id="userForm" commandName="user">
    <ul class="forminfo">
        <li>
            <label>姓名</label>
            <form:input path="user_name" cssClass="dfinput" maxlength="10" placeholder="请输入用户姓名，不能超过10个字符"/>
        </li>
        <!-- 账号不允许修改，设置为只读状态 -->
        <li>
            <label>账号</label>
            <form:input path="account" cssClass="dfinput" readonly="true" cssStyle="background: #ccc;" />
        </li>
        <li>
            <label>电话</label>
            <form:input path="tel" cssClass="dfinput" maxlength="11" placeholder="请输入有效的手机号码"/>
        </li>
        <li><label>性别</label>
            <cite>
                <form:radiobutton path="sex" value="男" />男生
                &nbsp;&nbsp;&nbsp;&nbsp;
                <form:radiobutton path="sex" value="女" />女生
            </cite>
        </li>
        <li>
            <label>头像</label>
            <!-- 发现没有文件域的标签，使用html的原生的 -->
            <input name="image" id="image" type="file" class="dfinput" />
        </li>
        <li>
            <label>创建日期</label>
            <!-- 关于日期的显示，我们需要使用fmt标签哟 -->
            <input id="create_date" name="create_date" class="Wdate" type="text" 
            onclick="WdatePicker({minDate:'%y-%M-%d'})"
            value='<fmt:formatDate value="${user.create_date }" pattern="yyyy-MM-dd"/>'
            />
            
        </li>
       
        <li>
            <label>&nbsp;</label>
            <input  type="button" class="btn" value="更新用户" onclick="toSub();"/>
            <input  type="button" class="btn" value="关闭窗口" onclick="toClose();"/>
        </li>
    </ul>
    <!-- 隐藏域 -->
    <form:hidden path="user_image"/>
    <form:hidden path="user_id"/>
   
    </form:form>


</div>


</body>

</html>
