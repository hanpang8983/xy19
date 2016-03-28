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
		<title>用户管理</title>
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


        //变更状态方法
        function toChangeStatus(){
            var d = dialog({
                title: '提示',
                content: '按钮回调函数返回 false 则不许关闭',
                okValue: '确定',
                ok: function () {
                    this.title('提交中…');
                    return false;
                },
                cancelValue: '取消',
                cancel: function () {}
            });
            d.show();
        }



    </script>
    <script type="text/javascript">
        function toPage(type){
            var pageNow = document.getElementById("pageNow").value;
            var totalPages = document.getElementById("totalPages").value;
            switch(type){
                case "1":
                case "5":
                    document.getElementById("pageNow").value =1;
                    break;
                case "2":
                    if(parseInt(pageNow)<=1){
                        alert("没有上一页");
                        return false;
                    }
                    document.getElementById("pageNow").value = parseInt(pageNow)-1;
                    break;
                case "3":
                    if(parseInt(pageNow)>=parseInt(totalPages)){
                        alert("别点了，没有了");
                        return false;
                    }
                    document.getElementById("pageNow").value = parseInt(pageNow)+1;
                    break;
                case "4":
                    document.getElementById("pageNow").value =totalPages;
                    break;
                
            }
            document.getElementById("searchForm").submit();
            
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
    <!-- 设置隐藏表单 -->
    <form action="sys/user/find" method="post" id="searchForm">
        <input type="hidden" name="pageNow" id="pageNow" value="${pager.pageNow }">
        <input type="hidden"  id="totalPages" value="${pager.totalPages }">
          
    </form>

    <ul class="imglist">
        <c:forEach items="${pager.datas }" var="user">
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
	                   <font color="red">暂无</font>
	               </c:out>
	            </h2>
	            <p>
	               <a href="#">维护</a>&nbsp;&nbsp;&nbsp;&nbsp;
	               <a href="javascript:void(0)" onclick="toChangeStatus()">状态</a>
	            </p>
	            <p>
	               <a href="#">角色</a>&nbsp;&nbsp;&nbsp;&nbsp;
	               <a href="#">详细</a></p>
	        </li>
        </c:forEach>
    </ul>
    <div class="pagin">
        <div class="message">共<i class="blue">${pager.totalCount }</i>条记录，当前显示第&nbsp;<i class="blue">${pager.pageNow }&nbsp;/&nbsp;${pager.totalPages }</i>页</div>
        <ul class="paginList">
        <li class="paginItem"><a href="javascript:void(0)" onclick="toPage('1')">首页</a></li>
        <li class="paginItem"><a href="javascript:void(0)" onclick="toPage('2')">上一页</a></li>
        <li class="paginItem"><a href="javascript:void(0)" onclick="toPage('3')">下一页</a></li>
        <li class="paginItem"><a href="javascript:void(0)" onclick="toPage('4')">尾页</a></li>
        </ul>
    </div>
    


</div>


</body>

</html>