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
        function toAddRole(){
        	var d = top.dialog({
                width:700,
                height:550,
                //title: '欢迎',
                url:'sys/role/add',//可以是一个访问路径Action|Servlet等或者jsp页面资源
                onclose: function () {
                if (this.returnValue=="success") {
                   window.location.href=window.location.href;
                }

            }
            });
            d.showModal();
        }
        
        //更新角色信息
        function toUpdate(role_id){
        	 //测试artDialog是否成功
            //成功需要注意jquery的版本必须是1.7+以上
            var d = top.dialog({
                width:700,
                height:550,
                //title: '欢迎',
                url:'sys/role/update/'+role_id,//可以是一个访问路径Action|Servlet等或者jsp页面资源
                onclose: function () {
                if (this.returnValue=="success") {
                   window.location.href=window.location.href;
                }

            }
            });
            d.showModal();
        }


        //变更状态方法
        function toChangeStatus(role_id,role_status){
        	var title = "";
        	if(role_status==1){
        		role_status=2;
        		title="<strong style='color:red;font-size:17px;'>禁用</strong>";
        	}else{
        		role_status=1;
                title="<strong style='color:green;font-size:17px;'>可用</strong>";
        	}
        
        	var d = dialog({
        	    title: '友情提示',
        	    content: '您确定要'+title+'操作吗?',
        	    okValue: '确定',
        	    ok: function () {
        	       $.post("sys/role/status",{_method:"put",role_id:role_id,role_status:role_status},function(data){
        	    	   if(data.flag=="success"){
        	    		   window.location.href= window.location.href;
        	    	   }
        	       })
        	    },
        	    cancelValue: '取消',
        	    cancel: function () {}
        	});
        	d.show();
        }

        
        
        
        /**
        * 角色的授权操作
        */
        function toPermission(role_id){
            //测试artDialog是否成功
            //成功需要注意jquery的版本必须是1.7+以上
            var d = top.dialog({
                width:500,
                height:350,
                //title: '欢迎',
                url:'sys/role/permission/'+role_id,//可以是一个访问路径Action|Servlet等或者jsp页面资源
                onclose: function () {
                if (this.returnValue=="success") {
                   //判断是否为更新当前角色
                   var session_role_id = $("#session_role_id").val();
                   if(session_role_id==role_id){
                	   window.parent.frames["leftFrame"].location.reload();
                   }
                }

            }
            });
            d.showModal();
        }
        
        
        function toDelete(role_id){
        	var d = dialog({
                title: '友情提示',
                content: '<b style="font-size:20px;color:red;">您真的确定要执行该注销操作吗?</b>',
                okValue: '确定',
                ok: function () {
                   $.post("sys/role/delete",{_method:"delete",role_id:role_id},function(data){
                       if(data.flag=="success"){
                           window.location.href= window.location.href;
                       }
                   })
                },
                cancelValue: '取消',
                cancel: function () {}
            });
            d.show();
        }


    </script>

</head>


<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li>角色管理</li>
    </ul>
</div>

<div class="rightinfo">

    <div class="tools">
        <ul class="toolbar">
            <li class="click" onclick="toAddRole()"><span><img src="resource/admin/images/t01.png"/></span>新建角色</li>
        </ul>

    </div>


    <ul class="imglist">
        <c:forEach items="${roleList }" var="role">
        <li>
            <span><img src="upload/role/${role.role_photo }" style="width: 168px;height: 126px;"
            onerror="this.src='upload/role/default.png'"
            /></span>

            <h2>${role.role_name }</h2>

            <p><a href="javascript:void(0)" onclick="toUpdate('${role.role_id}')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <c:if test="${role.role_status==1 }" var="flag">
                    <a href="javascript:void(0)" onclick="toChangeStatus('${role.role_id}',${role.role_status })" style="color: red;">禁用</a>
                </c:if>
                <c:if test="${!flag }">
                    <a href="javascript:void(0)" onclick="toChangeStatus('${role.role_id}',${role.role_status })" style="color: green;">启用</a>
                </c:if>
            </p>

            <p><a href="javascript:void(0)" onclick="toDelete('${role.role_id}')">注销</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="toPermission('${role.role_id}')">授权</a></p>
        </li>
        </c:forEach>

    </ul>


</div>
<!-- 设置隐藏 -->
<input type="hidden" id="session_role_id" value="${sessionScope.session_user.fk_role_id }">

</body>

</html>