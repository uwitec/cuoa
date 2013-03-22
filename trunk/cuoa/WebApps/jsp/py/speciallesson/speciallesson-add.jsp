<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
    <script type="text/javascript">
         function f_submit(){
        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	$.getJSON(contextPath + "/py-speciallesson/speciallesson!add.action", param,function(json){
					if(json.success){
						alert(json.message,"success");
					  	home_fresh();
					  	closeWindow();
					}else{
						alert(json.message,"error");
					}
				});
			} 
          }
    </script>
</head>

<body>
 <form class="l-form validate">
<div class="l-group l-group-hasicon">
	<img src="<%=contextPath%>/ligerui/ligerUI/skins/icons/communication.gif">
	<span>新增特殊课次</span>
</div>
    <div class="content">
    	<!-- 载入班级基本信息联动 -->
		<ul id="basicLinkage">
		</ul>
		<!-- 载入班级上课地点联动信息 -->
		<ul id="locationLinkage">
		</ul>
    	<ul>
    		<li>
    			<label>名称：</label>
    			<input type="text"  name="testingType.name" id="name" class="required input-text" />
    		</li>
    	</ul>
    </div>
    </form>
</body>
</html>