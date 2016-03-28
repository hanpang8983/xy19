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
		<title>菜单信息管理</title>
		<!-- 使用动态包含数据 -->
		<jsp:include page="/resource/include.jsp"/>
		<script type="text/javascript">
		/*
		  
		*/
    	function toAddParentMenu(){
    		  var addDialog = top.dialog({
                id: 'menu_parent_add_dialog',
                //title: '菜单添加操作',
                url: 'sys/menu/parent/add',
                //quickClose: true,
                width:500,
                height:200,
                onclose: function () {
                    if (this.returnValue=="success") {
                       //window.location.reload();
                       window.location.href=window.location.href;
                    }
                 
                }
            });
    		  
    		addDialog.show();
            return false;
    	}
		
    	/**
         *对父节点进行变更
         */
         function toChildUpdate(parent_id){
             var dialog = top.dialog({
                 id: 'menu_child_update_dialog',
                 //title: '菜单添加操作',
                 url: 'sys/menu/parent/update/'+parent_id,//路径传递数据
                 //quickClose: true,
                 width:500,
                 height:350,
                 onclose: function () {
                     if (this.returnValue=="success") {
                         //window.location.href=window.location.href;
                         toShowChild(parent_id);
                         //刷新左侧导航部分
                         window.parent.frames["leftFrame"].location.reload();
                     }
                    
                 }
             });
               
             dialog.showModal();
             return false;
         }
    	
    	function toAddChildMenu(){
            var addDialog = top.dialog({
              id: 'menu_child_add_dialog',
              //title: '菜单添加操作',
              url: 'sys/menu/child/add',
              //quickClose: true,
              width:500,
              height:350,
              onclose: function () {
                  /* if (this.returnValue) {
                      $('#value').html(this.returnValue);
                  }
                  console.log('onclose'); */
              }
          });
            
          addDialog.showModal();
          return false;
      }
    	
    	//查看子节点
    	function toShowChild(parent_id){
    		$.get("sys/menu/child/list",{parent_id:parent_id},function(data){
    			if(data!=null&&data.length>0){
    				$("#child_div").css("display","block");//显示div
    				$("#child_tbody").empty();//清空
    				var arr = ["站内打开","弹出窗口","外域访问"];//打开方式
    				var tr="";
    				for (var i = 0; i < data.length; i++) {
						tr +="<tr>";
						tr += "<td>"+(i+1)+"</td><td><img src='resource/admin/images/f03.png' />"+data[i].menu_name+"</td><td>"+data[i].url+"</td><td>"+arr[data[i].open_type-1]+"</td><td><a href='javascript:void(0)' class='tablelink' onclick=\"toChildUpdate('"+data[i].menu_id+"','"+data[i].parent_id+"')\">更新</a>&nbsp;|&nbsp;<a href='javascript:void(0)' class='tablelink' onclick=\"toChildDelete(this,'"+data[i].menu_id+"')\">删除</a></td>";
						tr +="</tr>";
					}
    				$("#child_tbody").append(tr);//追加
    			}else{//没有数据的处理
    				alert("抱歉该节点下没有子节点数据!");
    				$("#child_tbody").empty();
    				$("#child_div").css("display","none");
    			}
    		});
    		
    	}
    	/**
    	*对子节点进行变更
    	*/
    	function toChildUpdate(child_id,parent_id){
    		var dialog = top.dialog({
                id: 'menu_child_update_dialog',
                //title: '菜单添加操作',
                url: 'sys/menu/child/update/'+child_id,//路径传递数据
                //quickClose: true,
                width:500,
                height:350,
                onclose: function () {
                    if (this.returnValue=="success") {
                        //window.location.href=window.location.href;
                        toShowChild(parent_id);
                        //刷新左侧导航部分
                        window.parent.frames["leftFrame"].location.reload();
                    }
                   
                }
            });
              
    		dialog.showModal();
            return false;
    	}
    	
    	function toChildDelete(obj,menu_id){
    		var d = dialog({
                title: '有请提示',
                content: '您确定要删除该子节点吗?',
                okValue: '确定',
                ok: function () {
                    this.title('提交中…');
                    $.post("sys/menu/child/delete",{_method:"delete",menu_id:menu_id},function(data){
                        if(data.flag=="success"){
                            $(obj).parent().parent().fadeOut("slow",function(){
                                $(this).remove();
                            });
                            return false;
                        }else{
                            alert(data.message);
                            return false;
                        }
                    });
                },
                cancelValue: '取消',
                cancel: function () {}
            });
            d.show();
    		
    		
    	}
    	
    	function toParentDelete(obj,menu_id){
    		var d = dialog({
    		    title: '有请提示',
    		    content: '您确定要删除该子节点吗?',
    		    okValue: '确定',
    		    ok: function () {
    		        this.title('提交中…');
    		        $.post("sys/menu/parent/delete",
    	                    {_method:"delete",menu_id:menu_id},
    	            function(data){
    	                if(data.flag=="success"){
    	                    $(obj).parent().parent().fadeOut("slow",function(){
    	                        $(this).remove();
    	                    });
    	                    return false;
    	                    
    	                    
    	                }else{
    	                    alert(data.message);
    	                    return false;
    	                }
    	            });
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
	        <li>权限菜单管理</li>
	    </ul>
    </div>
    <div class="tools">

        <ul class="toolbar">
            <li class="click" onclick="toAddParentMenu()"><span><img src="resource/admin/images/t01.png"/></span>创建父节点</li>
            <li class="click" onclick="toAddChildMenu()"><span><img src="resource/admin/images/t01.png"/></span>新增子节点</li>
        </ul>
    </div>
    
    <div>
        <div style="float: left;width: 40%">
             <table class="filetable" >
		        <thead>
		            <tr>
		            <th width="10%">序号</th>
		            <th width="40%">父节点名称</th>
		            <th>具体操作</th>
		            </tr>       
		        </thead>
		        
		        <tbody>
                <c:forEach items="${parentMenuList }" var="parent" varStatus="vs">
                     <tr>
                         <td>${vs.count }</td>
                         <td><img src="resource/admin/images/f01.png" />${parent.menu_name }</td>
                         <td>
                            <a href="javascript:void(0)" class="tablelink" onclick="toParentUpdate('${parent.menu_id}')">编辑</a>&nbsp;|&nbsp;
                            <a href="javascript:void(0)" class="tablelink" onclick="toShowChild('${parent.menu_id}')">查看子节点</a>&nbsp;|&nbsp;
                            <a href="javascript:void(0)" class="tablelink" onclick="toParentDelete(this,'${parent.menu_id}')">删除</a>&nbsp;
                         </td>
                     </tr>
                 </c:forEach>
		        </tbody>
		    </table>
        </div>
        <div id="child_div" style="float: left;padding-left: 40px;width: 50%;display: none;">
             <table class="filetable" >
                <thead>
                    <tr>
                    <th width="10%">序号</th>
                    <th width="25%">子节点名称</th>
                    <th width="25%">访问路径</th>
                    <th width="15%">访问类型</th>
                    <th>具体操作</th>
                    </tr>       
                </thead>
                
                <tbody id="child_tbody">
                </tbody>
            </table>
        </div>
    </div>

</body>

</html>
	
	
		
	</body>
</html>