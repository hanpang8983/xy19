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
		<title>用户管理之详细页面</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
        <!-- 引入Ajax上传操作 -->
        <script type="text/javascript" src="resource/jquery.ajaxfileupload.js"></script>
        <!-- 引入MyDate97插件 -->
        <script type="text/javascript" src="resource/admin/My97DatePicker/WdatePicker.js"></script>
</head>

<body>


<div class="formbody">

    <div class="formtitle"><span>系统用户基本信息</span></div>
    <!-- 更新操作，使用标签的形式,我忘记了 -->
    <ul class="forminfo">
        <li>
            <label>姓名</label>
            <input type="text" value="${user.user_name }" class="dfinput">
        </li>
        <!-- 账号不允许修改，设置为只读状态 -->
        <li>
            <label>账号</label>
            <input type="text" value="${user.account }" class="dfinput">
        </li>
        <li>
            <label>电话</label>
            <input type="text" value="${user.tel }" class="dfinput">
        </li>
        <li><label>性别</label>
            <input type="text" value="${user.sex}" class="dfinput">
        </li>
        
        <li>
            <label>创建日期</label>
            <!-- 关于日期的显示，我们需要使用fmt标签哟 -->
            <input class="dfinput"  value='<fmt:formatDate value="${user.create_date }" pattern="yyyy-MM-dd"/>'/>
            
        </li>
        <li>
            <label>头像</label>
            <img alt="暂无头像" src="upload/user/${user.user_image }" style="width: 50px;height: 50px;">
        </li>
       
        <li>
            <label>&nbsp;</label>
       
            <input  type="button" class="btn" value="关闭窗口" onclick="toClose();"/>
        </li>
    </ul>
    


</div>


</body>

</html>
