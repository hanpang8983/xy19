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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%-- 
		参考文章:http://www.cnblogs.com/muqianying/archive/2012/03/16/2400280.html
		--%>
		
		<title>导航页面</title>
		<!-- 动态包含引入静态文件 -->
		<jsp:include page="/resource/include.jsp"/>
		
		<script type="text/javascript">
		$(function(){   
		    //导航切换
		    $(".menuson li").click(function(){
		        $(".menuson li.active").removeClass("active")
		        $(this).addClass("active");
		    });
		    
		    $('.title').click(function(){
		        var $ul = $(this).next('ul');
		        $('dd').find('ul').slideUp();
		        if($ul.is(':visible')){
		            $(this).next('ul').slideUp();
		        }else{
		            $(this).next('ul').slideDown();
		        }
		    });
		})  
		</script>
		<script type="text/javascript">
        function toJump(obj,url,open_type,target){
            switch(open_type){
                case "1":
                    obj.target=target;
                    obj.href=url;
                    
                    break;
                case "2":
                    window.open(url,""+(new Date()).getTime(),"height=200,width=300");
                    
                    break;
                case "3":
                    url = "http://"+url;
                    
                    obj.target="_blank";
                    obj.href=url;
                    break;
            }   
            
            
        }
        </script>


</head>

<body style="background:#f0f9fd;">
    <div class="lefttop"><span></span>HP权限管理</div>
    
    <dl class="leftmenu">
     <c:forEach items="${leftParentMenuList }" var="parent">   
    <dd>
	    <div class="title">
	    <span><img src="resource/admin/images/leftico01.png" /></span>${parent.menu_name }
	    </div>
        <ul class="menuson">
        <c:forEach items="${leftMenuList }" var="menu">
            <c:if test="${menu.parent_id==parent.menu_id }">
                <li><cite></cite><a href="javascript:void(0)"
                    onclick="toJump(this,'${menu.url}','${menu.open_type }','${menu.target}')">${menu.menu_name }</a><i></i></li>
            </c:if>
        </c:forEach>
        </ul>    
    </dd>
    </c:forEach>
        
    <!--  
    <dd>
    <div class="title">
    <span><img src="resource/admin/images/leftico02.png" /></span>其他设置
    </div>
    <ul class="menuson">
        <li><cite></cite><a href="#">编辑内容</a><i></i></li>
        <li><cite></cite><a href="#">发布信息</a><i></i></li>
        <li><cite></cite><a href="#">档案列表显示</a><i></i></li>
        </ul>     
    </dd> 
    
    
    <dd><div class="title"><span><img src="resource/admin/images/leftico03.png" /></span>编辑器</div>
    <ul class="menuson">
        <li><cite></cite><a href="#">自定义</a><i></i></li>
        <li><cite></cite><a href="#">常用资料</a><i></i></li>
        <li><cite></cite><a href="#">信息列表</a><i></i></li>
        <li><cite></cite><a href="#">其他</a><i></i></li>
    </ul>    
    </dd>  
    
    
    <dd><div class="title"><span><img src="resource/admin/images/leftico04.png" /></span>日期管理</div>
    <ul class="menuson">
        <li><cite></cite><a href="#">自定义</a><i></i></li>
        <li><cite></cite><a href="#">常用资料</a><i></i></li>
        <li><cite></cite><a href="#">信息列表</a><i></i></li>
        <li><cite></cite><a href="#">其他</a><i></i></li>
    </ul>
    
    </dd>

        <dd>
            <div class="title">
                <span><img src="resource/admin/images/leftico02.png" /></span>系统管理
            </div>
            <ul class="menuson">
                <li><cite></cite><a href="#">系统用户管理</a><i></i></li>
                <li><cite></cite><a href="shxt/role_list.html" target="rightFrame">角色管理</a><i></i></li>
                <li><cite></cite><a href="#">菜单信息管理</a><i></i></li>
            </ul>
        </dd>


        <dd><div class="title"><span><img src="resource/admin/images/leftico03.png" /></span>kindEditor的使用</div>
            <ul class="menuson">
                <li><cite></cite><a href="kindeditor/default.html"  target="rightFrame">默认模版事件</a><i></i></li>
                <li><cite></cite><a href="kindeditor/字数统计示例.html" target="rightFrame">字数统计示例</a><i></i></li>
            </ul>
        </dd>


        <dd><div class="title"><span><img src="resource/admin/images/leftico04.png" /></span>表单管理</div>
            <ul class="menuson">
                <li><cite></cite><a href="form.html" target="rightFrame">表单</a><i></i></li>
                <li><cite></cite><a href="user_form.html"  target="rightFrame">用户表单</a><i></i></li>
            </ul>

        </dd>
        -->
    </dl>
    
</body>
</html>