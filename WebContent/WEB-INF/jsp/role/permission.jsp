<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
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
		<title>角色授权页面</title>
	    <style type="text/css">
	        #main{
	            width: 500px;
	        }
	        .demo{width:450px; margin:20px auto}
	        .select_side{float:left; width:200px}
	         select{width:200px; height:200px;border: 1px solid #404040;font-weight: bold}
	        .select_opt{float:left; width:40px; height:15%; padding-top: 80px;padding-left: 10px;}
	        .select_opt p{width:26px; height:26px; margin-top:6px; background:url(resource/admin/images/arr.gif) no-repeat; cursor:pointer; text-indent:-999em}
	        .select_opt p#toright{background-position:2px 0}
	        .select_opt p#toleft{background-position:2px -22px}
	        .sub_btn{clear:both; height:42px; line-height:42px; padding-top:10px; text-align:center}
	    </style>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
		<script type="text/javascript">
		$(function(){
		    var leftSel = $("#selectL");//ID
		    var rightSel = $("#selectR");
		    $("#toright").bind("click",function(){      
		        leftSel.find("option:selected").each(function(){
		            $(this).remove().appendTo(rightSel);
		        });
		    });
		    $("#toleft").bind("click",function(){       
		        rightSel.find("option:selected").each(function(){
		            $(this).remove().appendTo(leftSel);
		        });
		    });
		    leftSel.dblclick(function(){
		        $(this).find("option:selected").each(function(){
		            $(this).remove().appendTo(rightSel);
		        });
		    });
		    rightSel.dblclick(function(){
		        $(this).find("option:selected").each(function(){
		            $(this).remove().appendTo(leftSel);
		        });
		    });
		
		});
		</script>
		<script type="text/javascript">
		  function toSub(){
			  //重点步骤设置选中
			  $("#selectR option").prop("selected",true);
			  //提交表单
			  $("#roleForm").submit();
		  }
		
		</script>
</head>

<body>
    <div id="main">
      <h2 style="text-align: center;font-size: 17px;font-weight: bold;">
                   针对于[${role.role_name }]角色进行授权
      </h2>
      <form action="sys/role/permission" method="post" id="roleForm">
      <div class="demo">
         <div class="select_side">
         <p style="text-align: center;font-weight: bold;">未选择菜单</p>
         <select id="selectL"  multiple="multiple">
            <c:forEach items="${unSelectedMenuList }" var="left">
                <option value="${left.menu_id }">${left.menu_name }</option>
            </c:forEach>
         </select>
         </div>
         <div class="select_opt">
            <p id="toright" title="添加">&gt;</p>
            <p id="toleft" title="移除">&lt;</p>
         </div>
         <div class="select_side">
         <p style="text-align: center;font-weight: bold;">已选择菜单</p>
         <select id="selectR" name="menus" multiple="multiple">
            <c:forEach items="${selectedMenuList }" var="right">
                <option value="${right.menu_id }">${right.menu_name }</option>
            </c:forEach>
         </select>
         </div>
         <!-- 设置隐藏域 -->
         <input type="hidden" name="role_id" value="${role.role_id }">
         <input type="hidden" name="_method" value="put">
         <div class="sub_btn">
            <input type="button" class="btn" value="更新授权" onclick="toSub()"/>
            <input type="button" class="btn" value="关闭窗口" onclick="toClose()"/>
         </div>
      </div>
      </form>
    </div>


</body>
</html>