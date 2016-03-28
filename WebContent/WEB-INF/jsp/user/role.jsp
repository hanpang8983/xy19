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
		<title>用户管理之修改角色</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
	    <script type="text/javascript">
	    
	        function toSub(){
		    	var fk_role_id = $("#fk_role_id").val();
		    	if(fk_role_id.length==0){
		    		alert("请选择要更改的角色");
		    		return false;
		    	}
		    	
    			$("#userForm").submit();
    			return false;
	            
	        }
	
	    </script>
	   
</head>

<body>


<div class="formbody">

    <div class="formtitle"><span>给【${user.user_name }】变更角色</span></div>
    <!-- 更新操作，使用标签的形式,我忘记了
   
     -->
    <form:form action="sys/user/role" method="put" id="userForm" commandName="user">
    <ul class="forminfo">
        <li>
            <label>角色</label>
            <form:select path="fk_role_id" cssClass="select_show">
                <!-- 判断情况 -->
                <c:if test="${empty user.fk_role_id }">
                <form:option value="">请选择角色</form:option>
                </c:if>
            
                <form:options items="${roleList }" itemValue="role_id" itemLabel="role_name"/>
            </form:select>
        </li>
        <li>
            <label>&nbsp;</label>
            <input  type="button" class="btn" value="更新用户" onclick="toSub();"/>
            <input  type="button" class="btn" value="关闭窗口" onclick="toClose();"/>
        </li>
    </ul>
    <!-- 隐藏域 -->
    <form:hidden path="user_id"/>
   
    </form:form>


</div>


</body>

</html>
