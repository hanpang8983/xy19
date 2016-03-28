<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    		var parent_id =$("#parent_id").val();
    		
    		var menu_name = $.trim($("#menu_name").val());
    		if(menu_name.length==0){
    			alert("菜单名都没有，你想什么?");
    			return false;
    		}
    		
    		var url = $.trim($("#url").val());
            if(url.length==0){
                alert("没有访问路径吗?");
                return false;
            }
            
            var open_type =$("#open_type").val();
            if(open_type.length==0){
                alert("请选择访问类型?");
                return false;
            }
            
            //分情况处理
            //第一种情况:你修改了父节点
            var old_parent_id = $("#old_parent_id").val();
            if(old_parent_id!=parent_id){
            	//修改父节点
            	var ajax_url="sys/menu/"+parent_id+"/name";
                $.post(ajax_url,{menu_name:menu_name},function(data){
                    if(data.flag=="success"){
                        $("#menuForm").submit();
                        return false;
                    }else{
                        alert("该节点下已经存在该名称，不能进行调整");
                        return false;
                    }
                });
            }else{
            	//第二种情况，判断的名称是否修改
            	var old_menu_name = $("#old_menu_name").val();
            	if(old_menu_name!=menu_name){
            		//没有修改父节点，但是我修改菜单名称
            		var ajax_url="sys/menu/"+parent_id+"/name";
            		$.post(ajax_url,{menu_name:menu_name},function(data){
                        if(data.flag=="success"){
                            $("#menuForm").submit();
                            return false;
                        }else{
                            alert(data.message);
                            $("#menu_name").val(old_menu_name);
                            return false;
                        }
                    }); 
            		
            	}else{
            		//没有修改父节点，也没有修改名称
            		$("#menuForm").submit();
                    return false;
            	}
            }
    		
       
    	}
    	</script>
    	
	</head>
	<body>
	    <div class="formbody">
           <div class="formtitle"><span>新增子节点基本信息</span></div>
           <form:form action="sys/menu/update" method="put" id="menuForm" commandName="child_menu">
           <ul class="forminfo">
               <li>
                   <label>父节点列表:</label>
                   <form:select path="parent_id" cssClass="select_show">
                       <form:options items="${parentMenuList }" itemLabel="menu_name" itemValue="menu_id"/> 
                   </form:select>
               </li>
               <li>
                    <label>节点名称:</label>
                    <form:input path="menu_name" cssClass="dfinput" maxlength="10" placeholder="请输入子节点名称，最大长度为10"/>
               </li>
                <li>
                    <label>访问路径:</label>
                    <form:input path="url" cssClass="dfinput" maxlength="60" placeholder="请输入访问地址"/>
               </li>
               <li>
                    <label>访问类型:</label>
                     <form:select path="open_type" cssClass="select_show">
				          <form:option value="1">站内打开</form:option>
				          <form:option value="2">弹出打开</form:option>
				          <form:option value="3">外域访问</form:option>
			         </form:select>
               </li>
               
               <li>     
                    <label>&nbsp;</label>
                    <input type="button" class="btn" value="变更节点" onclick="toSub()"/>
                    <input type="button" class="btn" value="关闭窗口" onclick="toClose()"/>
               </li>
           </ul>
             <!-- 隐藏域 -->
	         <form:hidden path="menu_id"/>
	         <!-- 使用普通的HTML表单 -->
	         <input type="hidden" id="old_menu_name" value="${child_menu.menu_name }">
	         <input type="hidden" id="old_parent_id" value="${child_menu.parent_id }">
           </form:form>
       </div>
	
	
	
		
		
	</body>
</html>