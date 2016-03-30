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
		<title>无标题文档</title>
        <!-- 使用动态包含 -->
        <jsp:include page="/resource/include.jsp"/>
        <!-- 引入Ajax上传操作 -->
        <script type="text/javascript" src="resource/jquery.ajaxfileupload.js"></script>
        <!-- 引入MyDate97插件 -->
        <script type="text/javascript" src="resource/admin/My97DatePicker/WdatePicker.js"></script>
	    <script type="text/javascript">
		    $(function(){
		    	//初始化日期
		    	$("#create_date").val(DateUtil.dateToStr("yyyy-MM-dd",new Date()));
		    })
	    
	        function toSub(){
		    	var user_name = $.trim($("#user_name").val());
		    	var account = $.trim($("#account").val());
		    	var tel = $.trim($("#tel").val());
		    	
		    	if(user_name.length==0){
		    		alert("请输入你的姓名，快点!");
		    		$("#user_name").focus();
		    		return false;
		    	}
		    	
		    	if(account.length==0){
                    alert("请输入账号，必须要有啊!");
                    $("#account").focus();
                    return false;
                }
		    	
		    	if(tel.length==0){
                    alert("对电话我们只是输入就行，不验证!");
                    $("#tel").focus();
                    return false;
                }
		    	
		    	$.post("sys/user/account",{account:account},function(data){
		    		if(data.flag=="success"){
		    			$("#userForm").submit();
		    			return false;
		    		}else{
		    			alert(data.message);
		    			return false;
		    		}
		    	});
		    	
	            
	        }
	
	    </script>
	    <script type="text/javascript">
        $(function(){
             $('#image').ajaxfileupload({
                 'action': 'sys/user/upload',//上传路径
                 'valid_extensions' : ['gif','png','jpg','jpeg','bmp'],//允许上传的格式
                 'onComplete': function(data) {
                	
                    $("#user_image").val(data.newName);
                    //移除属性
                    $("#image").removeAttr("name");
                  }
             });
        });
        </script>
</head>

<body>


<div class="formbody">

    <div class="formtitle"><span>系统用户基本信息</span></div>
    <!-- 保存操作 -->
    <form action="sys/user/add" method="post" id="userForm">
    <ul class="forminfo">
        <li><label>姓名</label><input name="user_name" id="user_name" type="text" class="dfinput" maxlength="10" placeholder="请输入用户姓名，不能超过10个字符"/></li>
        <li><label>账号</label><input name="account" id="account" type="text" class="dfinput" maxlength="10" placeholder="账号信息，不能超过10个字符"/></li>
        <li><label>密码</label><input type="text" class="dfinput" value="初始化密码:123456" readonly="readonly"/>
                                <input type="hidden" name="password" value="e10adc3949ba59abbe56e057f20f883e">
        </li>
        <li><label>电话</label><input name="tel" id="tel" type="text" class="dfinput" maxlength="11" placeholder="请输入有效的手机号码"/></li>
        <li><label>性别</label>
            <cite>
                <input name="sex" type="radio" value="男" checked="checked"/>男士&nbsp;&nbsp;&nbsp;&nbsp;
                <input name="sex" type="radio" value="女"/>女士
            </cite>
        </li>
        <li>
            <label>头像</label>
            <input name="image" id="image" type="file" class="dfinput" /><i>AJAX上传</i>
        </li>
        <li>
            <label>创建日期</label>
            <!-- 练习使用MyDate97插件 -->
            <input id="create_date" name="create_date" class="Wdate" type="text" onclick="WdatePicker({minDate:'%y-%M-%d'})"/>
        </li>
       
        <li>
            <label>&nbsp;</label>
            <input  type="button" class="btn" value="新增用户" onclick="toSub();"/>
            <input  type="button" class="btn" value="关闭窗口" onclick="toClose();"/>
        </li>
    </ul>
    <input type="hidden" id="user_image" name="user_image">
    </form>


</div>


</body>

</html>
