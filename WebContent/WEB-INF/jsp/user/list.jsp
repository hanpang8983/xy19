<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<title>角色管理</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
	    <script language="javascript">
	        $(function () {
	            //导航切换
	            $(".imglist li").click(function () {
	                $(".imglist li.selected").removeClass("selected")
	                $(this).addClass("selected");
	            })
	        })
	    </script>

    <!-- 关于功能测试代码 -->
    <script type="text/javascript">
        function toAddUser(){
            var d = top.dialog({
                width:500,
                height:450,
                url:'sys/user/add',//可以是一个访问路径Action|Servlet等或者jsp页面资源
                onclose: function () {
	                if (this.returnValue=="success") {
	                    window.location.href=window.location.href;
	                }
                }
            });
            d.showModal();
        }
        
        function toUpdateUser(user_id){
            var d = top.dialog({
                width:500,
                height:450,
                url:'sys/user/update/'+user_id,//使用路径传递简单数据
                onclose: function () {
                    if (this.returnValue=="success") {
                        window.location.href=window.location.href;
                    }
                }
            });
            d.showModal();
        }


        //变更状态方法
        function toChangeStatus(user_id,status){
            
            //判断用户的ID,如果为负数那么久不能进行该操作
            if(user_id<0){
            	alert("该用户无法进行该操作，已经被锁定的账号信息!");
            	return false;
            }
            
            var title = "";
            if(status==1){
                status=2;
                title="<strong style='color:red;font-size:17px;'>禁用</strong>";
            }else{
                status=1;
                title="<strong style='color:green;font-size:17px;'>启用</strong>";
            }
        	
        	
            var d = dialog({
            	title: '友情提示',
                content: '您确定要'+title+'操作吗?',
                okValue: '狠心一下',
                ok: function () {
                	$.post("sys/user/status",{_method:"put",user_id:user_id,status:status},function(data){
                        if(data.flag=="success"){
                            window.location.href= window.location.href;
                        }
                    })
                },
                cancelValue: '放弃了!',
                cancel: function () {}
            });
            d.show();
        }
        
        function toChangeRole(user_id){
        	var d = top.dialog({
                width:500,
                height:200,
                url:'sys/user/role?user_id='+user_id,//好久没有使用问好传递数据了，练习使用一下,等号后面不要写空格哟
                onclose: function () {
                    if (this.returnValue=="success") {
                        window.location.href=window.location.href;
                    }
                }
            });
            d.showModal();
        }
        
        function toDetail(user_id){
        	var d = top.dialog({
                width:500,
                height:450,
                url:'sys/user/detail/'+user_id,//好久没有使用问好传递数据了，练习使用一下,等号后面不要写空格哟
                onclose: function () {
                    if (this.returnValue=="success") {
                        window.location.href=window.location.href;
                    }
                }
            });
            d.showModal();
        }



    </script>

</head>


<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li>系统用户管理</li>
    </ul>
</div>

<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li class="click" onclick="toAddUser()"><span><img src="resource/admin/images/t01.png"/></span>新建用户</li>
        </ul>
    </div>


    <ul class="imglist">
        <c:forEach items="${userList }" var="user">
            <li >
	            <span>
	               <!-- 设置默认图片 -->
	               <img src="upload/user/${user.user_image }"
	               alt="${user.user_name }"
	               title="${user.user_name }"
	               onerror="this.src='upload/user/default.jpg'"
	               style="width: 168px;height: 126px;"
	               />
	            </span>
	            <h2>
	               ${user.user_name }&nbsp;|&nbsp;
	               <c:out value="${user.role.role_name }" escapeXml="false">
	                   <font style="color: red;font-weight: bold;">无角色</font>
	               </c:out>
	            </h2>
	            <p>
	               <a href="javascript:void(0)" onclick="toUpdateUser('${user.user_id}')">维护</a>&nbsp;&nbsp;&nbsp;&nbsp;
	               <c:if test="${user.status==1 }" var="flag">
	                   <a href="javascript:void(0)" onclick="toChangeStatus('${user.user_id}','${user.status }')" style="font-weight: bold;color: green;">已启用</a>
	               </c:if>
	                <c:if test="${!flag }">
                       <a href="javascript:void(0)" onclick="toChangeStatus('${user.user_id}','${user.status }')" style="font-weight:bold;color: red;">已禁用</a>
                   </c:if>
	            </p>
	            <p>
	               <a href="javascript:void(0)" onclick="toChangeRole('${user.user_id}')">角色</a>&nbsp;&nbsp;&nbsp;&nbsp;
	               <a href="javascript:void(0)" onclick="toDetail('${user.user_id}')">详细</a></p>
	        </li>
        </c:forEach>
        

       

    </ul>


</div>


</body>

</html>