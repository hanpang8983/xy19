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
		<title>胖先生:83604162</title>
		<!-- 使用动态包含数据 -->
        <jsp:include page="/resource/include.jsp"/>
		<script type="text/javascript">
    	function toSub(){
    		var menu_name = $.trim($("#menu_name").val());
    		if(menu_name.length==0){
    			alert("菜单名都没有，你想什么?");
    			return false;
    		}
    		//验证根节点的名称是否重复
    		$.post("sys/menu/-1/name",{menu_name:menu_name},function(data){
    			if(data.flag=="success"){
    				$("#menuForm").submit();
    				return false;
    			}else{
    				alert(data.message);
    				return false;
    			}
    		});
    	}
    	</script>
	</head>
	<body>
	   <div class="formbody">
		    <div class="formtitle"><span>创建父节点基本信息</span></div>
		    <form action="sys/menu/add" method="post" id="menuForm">
		    <ul class="forminfo">
			    <li>
			    <label>父节点名称</label>
			    <input name="menu_name" id="menu_name" type="text"  maxlength="10" class="dfinput" placeholder="请输入父节点名称，最大长度为10"/></li>
			    <li>
			         <label>&nbsp;</label>
			         <input type="button" class="btn" value="创建节点" onclick="toSub()"/>
			         <input type="button" class="btn" value="关闭窗口" onclick="toClose()"/>
			    </li>
	        </ul>
            </form>
    
        </div>
		
	</body>
</html>